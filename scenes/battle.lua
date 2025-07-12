local skills = require("classes.skills")
local enemies = require("classes.enemies")
local battle = {}

function battle:load(enemyName)
    enemyName = enemyName or "ceoOfChaos"
    self.enemy = enemies[enemyName]

    -- Load Images
    self.playerImage = love.graphics.newImage("assets/images/characters/player_1.png")
    self.enemyImage = love.graphics.newImage("assets/images/characters/" .. string.lower(enemyName) .. ".png")

    self.imageScale = 0.5 -- consistent scale for both images

    -- Player Setup
    self.player = {
        name = "You",
        hp = 40,
        maxHp = 40,
        level = 3,
        xp = 0,
        xpToNext = 10,
        selectedSkill = 1,
        buffs = { damageBoost = 0, turnsRemaining = 0 },
        statusEffects = { burnout = 0, overworked = 0, selfdoubt = 0 },
        skills = {
            skills.playerSkills["Excel Slam"],
            skills.playerSkills["Buzzword Barrage"],
            skills.playerSkills["Coffee Break"],
            skills.playerSkills["LinkedIn Flex"]
        }
    }

    self.turn = "player"
    self.battleOver = false
    self.message = "Battle started against " .. self.enemy.name .. "!"
end

function battle:update(dt) end

function battle:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local scale = self.imageScale

    -- Draw Characters
    love.graphics.setColor(1, 1, 1)
    local pw, ph = self.playerImage:getWidth(), self.playerImage:getHeight()
    local ew, eh = self.enemyImage:getWidth(), self.enemyImage:getHeight()

    local playerX = 60
    local playerY = h - ph * scale - 40
    local enemyX = w - ew * scale - 60
    local enemyY = 60

    love.graphics.draw(self.playerImage, playerX, playerY, 0, scale, scale)
    love.graphics.draw(self.enemyImage, enemyX, enemyY, 0, scale, scale)

    -- UI Labels
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.printf("⚔️ Battle: " .. self.enemy.name, 0, 20, w, "center")

    -- Player Info
    love.graphics.setFont(love.graphics.newFont(14))
    love.graphics.printf("👨‍💼 " .. self.player.name .. " (Lvl " .. self.player.level .. ")", 20, 60, w, "left")
    self:drawHealthBar(20, 80, 200, 20, self.player.hp, self.player.maxHp, { 0, 0.8, 0.2 })
    love.graphics.printf("HP: " .. self.player.hp .. " / " .. self.player.maxHp, 230, 80, w, "left")
    love.graphics.printf("🧠 XP: " .. self.player.xp .. " / " .. self.player.xpToNext, 20, 110, w, "left")

    -- Status Effects
    local status = ""
    for k, v in pairs(self.player.statusEffects) do
        if v > 0 then
            local emoji = k == "burnout" and "🔥" or k == "overworked" and "😩" or k == "selfdoubt" and "💭" or "❓"
            status = status .. emoji .. " " .. k .. " (" .. v .. ")  "
        end
    end
    if status ~= "" then
        love.graphics.setColor(1, 0.6, 0.2)
        love.graphics.printf(status, 20, 135, w, "left")
    end

    -- Enemy Info
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("👥 Enemy: " .. self.enemy.name, 20, 170, w, "left")
    self:drawHealthBar(20, 190, 200, 20, self.enemy.hp, self.enemy.maxHp, { 0.8, 0.1, 0.1 })
    love.graphics.printf("HP: " .. self.enemy.hp .. " / " .. self.enemy.maxHp, 230, 190, w, "left")

    -- Message Box
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", 20, 230, w - 40, 60)
    love.graphics.printf(self.message, 30, 240, w - 60, "left")

    -- Skill Menu
    if not self.battleOver and self.turn == "player" then
        love.graphics.setFont(love.graphics.newFont(16))
        love.graphics.printf("↑/↓ to select skill, [Enter] to use", 0, 310, w, "center")
        for i, skill in ipairs(self.player.skills) do
            local y = 340 + i * 30
            local selected = (i == self.player.selectedSkill)
            local cdText = skill.currentCooldown > 0 and (" (CD: " .. skill.currentCooldown .. ")") or ""
            local text = (selected and "➤ " or "    ") .. skill.name .. cdText
            love.graphics.setColor(selected and { 0.2, 0.6, 1 } or { 1, 1, 1 })
            love.graphics.printf(text, 0, y, w, "center")
        end
    elseif self.battleOver then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("🎉 Press [Enter] to return to map", 0, 480, w, "center")
    end

    love.graphics.setColor(1, 1, 1) -- Reset color
end

function battle:keypressed(key)
    if self.battleOver and key == "return" then
        local gameState = require("gameState")
        gameState:switch("map")
        return
    end

    if self.turn == "player" and not self.battleOver then
        if key == "up" then
            self.player.selectedSkill = (self.player.selectedSkill - 2) % #self.player.skills + 1
        elseif key == "down" then
            self.player.selectedSkill = self.player.selectedSkill % #self.player.skills + 1
        elseif key == "return" then
            if self:checkPlayerStatusEffects() then return end

            local skill = self.player.skills[self.player.selectedSkill]
            if skill.currentCooldown > 0 then
                self.message = skill.name .. " is on cooldown!"
                return
            end

            self.message = "You " .. skill.action(self.player, self.enemy)
            if skill.cooldown then
                skill.currentCooldown = skill.cooldown
            end

            if self.enemy.hp <= 0 then
                self:winBattle()
            else
                self.turn = "enemy"
                self:enemyTurn()
            end
        end
    end
end

function battle:checkPlayerStatusEffects()
    if self.player.statusEffects.burnout > 0 then
        self.message = "You're burned out and skip your turn!"
        self.player.statusEffects.burnout = self.player.statusEffects.burnout - 1
        self.turn = "enemy"
        self:enemyTurn()
        return true
    end

    if self.player.statusEffects.overworked > 0 then
        self.player.hp = self.player.hp - 2
        self.message = "You're overworked! -2 HP!"
        self.player.statusEffects.overworked = self.player.statusEffects.overworked - 1
    end

    if self.player.statusEffects.selfdoubt > 0 then
        self.player.hp = self.player.hp - 2
        self.message = "You've been doubting yourself! -2 HP!"
        self.player.statusEffects.selfdoubt = self.player.statusEffects.selfdoubt - 1
        self.turn = "enemy"
        self:enemyTurn()
        return true
    end

    return false
end

function battle:enemyTurn()
    local skill = self.enemy.skills[math.random(#self.enemy.skills)]
    self.message = self.enemy.name .. " " .. skill.action(self.enemy, self.player)

    if self.player.hp <= 0 then
        self.player.hp = 0
        self.message = "You were defeated by " .. self.enemy.name .. "!"
        self.battleOver = true
        return
    end

    self:updateCooldowns()
    self:updateBuffs()
    self.turn = "player"
end

function battle:drawHealthBar(x, y, width, height, current, max, color)
    local ratio = math.max(current / max, 0)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, width * ratio, height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, width, height)
end

function battle:updateCooldowns()
    for _, skill in ipairs(self.player.skills) do
        if skill.currentCooldown and skill.currentCooldown > 0 then
            skill.currentCooldown = skill.currentCooldown - 1
        end
    end
end

function battle:updateBuffs()
    if self.player.buffs.turnsRemaining > 0 then
        self.player.buffs.turnsRemaining = self.player.buffs.turnsRemaining - 1
        if self.player.buffs.turnsRemaining == 0 then
            self.player.buffs.damageBoost = 0
        end
    end
end

function battle:winBattle()
    self.enemy.hp = 0
    self.message = "You defeated " .. self.enemy.name .. "! +5 XP"
    self.player.xp = self.player.xp + 5
    self.battleOver = true

    if self.player.xp >= self.player.xpToNext then
        self.player.level = self.player.level + 1
        self.player.xp = self.player.xp - self.player.xpToNext
        self.player.xpToNext = self.player.xpToNext + 5
        self.player.maxHp = self.player.maxHp + 5
        self.player.hp = self.player.maxHp
        self.message = self.message .. "\n🎉 Level up! Now level " .. self.player.level
    end
end

return battle
