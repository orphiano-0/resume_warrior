local skills = require("classes.skills")
local enemies = require("classes.enemies")
local battle = {}

local attackSound = love.audio.newSource("assets/sounds/attack.mp3", "static")
local healSound = love.audio.newSource("assets/sounds/heal.mp3", "static")

function battle:load(enemyName)
    enemyName = enemyName or "ceoOfChaos"
    self.enemy = enemies[enemyName]
    self.enemyName = enemyName

    -- Background & Images
    self.bg = love.graphics.newImage("assets/images/background/background.jpg")
    self.playerImage = love.graphics.newImage("assets/images/characters/player_1.png")
    self.enemyImage = love.graphics.newImage("assets/images/characters/" .. string.lower(enemyName) .. ".png")

    -- Optional pixel font
    self.pixelFont = love.graphics.newFont("assets/fonts/pixel.ttf", 12)

    -- Player setup
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
    self.floatingText = {}
end

function battle:update(dt)
    for i = #self.floatingText, 1, -1 do
        local text = self.floatingText[i]
        text.y = text.y - dt * 30
        text.timer = text.timer - dt
        if text.timer <= 0 then
            table.remove(self.floatingText, i)
        end
    end
end

function battle:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()

    -- Draw background
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.bg, 0, 0, 0, w / self.bg:getWidth(), h / self.bg:getHeight())

    -- Use pixel font
    love.graphics.setFont(self.pixelFont or love.graphics.newFont(12))

    -- Draw characters
    local scale = 0.5
    local playerX, playerY = 60, h - self.playerImage:getHeight() * scale - 40
    local enemyX, enemyY = w - self.enemyImage:getWidth() * scale - 100, 60

    love.graphics.draw(self.playerImage, playerX, playerY, 0, scale, scale)
    love.graphics.draw(self.enemyImage, enemyX, enemyY, 0, scale, scale)

    -- HP Bars
    self:drawHealthBar(playerX, playerY - 16, self.playerImage:getWidth() * scale, 10, self.player.hp, self.player.maxHp,
        { 0, 0.8, 0.2 })
    self:drawHealthBar(enemyX, enemyY - 16, self.enemyImage:getWidth() * scale, 10, self.enemy.hp, self.enemy.maxHp,
        { 0.8, 0.1, 0.1 })

    -- === Battle Message Dialog Box ===
    local dialogX, dialogY, dialogW = 15, 15, w / 2 - 30
    local font = love.graphics.getFont()
    local _, wrappedText = font:getWrap(self.message, dialogW - 20)
    local lineHeight = font:getHeight()
    local messageHeight = #wrappedText * lineHeight
    local dialogH = 50 + messageHeight

    -- Container
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", dialogX, dialogY, dialogW, dialogH)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", dialogX, dialogY, dialogW, dialogH)

    -- Text inside dialog
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Battle: " .. self.enemy.name, dialogX + 10, dialogY + 10, dialogW - 20, "left")
    love.graphics.printf(self.message, dialogX + 10, dialogY + 30, dialogW - 20, "left")

    -- === Player Stats Box ===
    local statsX, statsY, statsW, statsH = 15, dialogY + dialogH + 10, dialogW, 60
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", statsX, statsY, statsW, statsH)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", statsX, statsY, statsW, statsH)

    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Player: " .. self.player.name .. " (Lvl " .. self.player.level .. ")", statsX + 10, statsY + 10,
        statsW - 20, "left")
    love.graphics.printf(
    "HP: " .. self.player.hp .. "/" .. self.player.maxHp .. "   XP: " .. self.player.xp .. "/" .. self.player.xpToNext,
        statsX + 10, statsY + 30, statsW - 20, "left")

    -- === Skill Menu ===
    if not self.battleOver and self.turn == "player" then
        local skillX = w / 2 + 50
        local skillY = h - 200
        local skillW = w / 2 - 70
        local skillH = #self.player.skills * 25 + 60

        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", skillX - 10, skillY, skillW, skillH)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", skillX - 10, skillY, skillW, skillH)

        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("↑/↓ to select, [Enter] to use", skillX, skillY + 10, skillW - 20, "left")

        for i, skill in ipairs(self.player.skills) do
            local y = skillY + 30 + i * 25
            local selected = (i == self.player.selectedSkill)

            love.graphics.setColor(selected and { 0.4, 0.8, 1 } or { 1, 1, 1 })
            love.graphics.printf((selected and "➤ " or "") .. skill.name, skillX + 20, y, skillW - 40, "left")

            -- Cooldown Arc
            if skill.cooldown and skill.currentCooldown and skill.currentCooldown > 0 then
                local r = 10
                local percent = skill.currentCooldown / skill.cooldown
                love.graphics.setColor(1, 0.2, 0.2, 0.6)
                love.graphics.arc("fill", skillX + 5, y + 10, r, -math.pi / 2, -math.pi / 2 + 2 * math.pi * percent)
            end
        end
    elseif self.battleOver then
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("Press [Enter] to return to map", w / 2, h - 50, w / 2 - 40, "center")
    end

    -- Floating Damage Text
    for _, t in ipairs(self.floatingText) do
        love.graphics.setColor(1, 0.2, 0.2)
        love.graphics.print(t.text, t.x, t.y)
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
            if skill.currentCooldown and skill.currentCooldown > 0 then
                self.message = skill.name .. " is on cooldown!"
                return
            end

            local hpBefore = self.enemy.hp
            local result = skill.action(self.player, self.enemy)
            local damageDealt = math.max(hpBefore - self.enemy.hp, 0)

            self.message = "You " .. result

            if damageDealt > 0 then
                attackSound:play()
                table.insert(self.floatingText, {
                    text = "-" .. damageDealt,
                    x = love.graphics.getWidth() - 140,
                    y = 80,
                    timer = 1.2
                })
            elseif skill.type == "heal" then
                healSound:play()
            end

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
        self.message = "Self-doubt hurts! -2 HP!"
        self.player.statusEffects.selfdoubt = self.player.statusEffects.selfdoubt - 1
        self.turn = "enemy"
        self:enemyTurn()
        return true
    end

    return false
end

function battle:enemyTurn()
    local skill = self.enemy.skills[math.random(#self.enemy.skills)]
    local hpBefore = self.player.hp
    local result = skill.action(self.enemy, self.player)
    local damageDealt = math.max(hpBefore - self.player.hp, 0)

    self.message = self.enemy.name .. " " .. result

    if damageDealt > 0 then
        attackSound:play()
        table.insert(self.floatingText, {
            text = "-" .. damageDealt,
            x = 80,
            y = love.graphics.getHeight() - 160,
            timer = 1.2
        })
    end

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
        self.message = self.message .. "\nLevel up! Now level " .. self.player.level
    end
end

return battle
