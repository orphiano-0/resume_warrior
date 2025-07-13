local skills = require("classes.skills")
local enemies = require("classes.enemies")
local gameState = require("gameState")
local battle = {}

local attackSound = love.audio.newSource("assets/sounds/attack.mp3", "static")
local healSound = love.audio.newSource("assets/sounds/heal.mp3", "static")

function battle:load(enemyQueue)
    print("🧠 Loading battle with enemyQueue:", table.concat(enemyQueue or {}, ", "), "Stage:",
        gameState.currentStage or "unknown")
    self.enemyQueue = type(enemyQueue) == "table" and enemyQueue or { enemyQueue }
    self.currentEnemyIndex = 1
    self.battleOver = false
    self.victoryAcknowledged = false
    self.postBattleTimer = 0
    self.stageCleared = false

    self.bg = love.graphics.newImage("assets/images/background/bright_background.png")
    self.playerImage = love.graphics.newImage("assets/images/characters/player_1.png")
    self.pixelFont = love.graphics.newFont("assets/fonts/pixel.ttf", 12)

    local defaultPlayer = {
        name = "You",
        hp = 40,
        maxHp = 40,
        level = 1,
        xp = 0,
        xpToNext = 3,
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

    self.player = gameState.playerData or {}
    for k, v in pairs(defaultPlayer) do
        if self.player[k] == nil then
            self.player[k] = v
        end
    end

    self.player.statusEffects = self.player.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }

    if self.player.stats then
        local stats = self.player.stats
        self.player.hp = self.player.hp or (stats.experience * 5 + stats.intelligence * 2 + 20)
        self.player.maxHp = self.player.maxHp or self.player.hp
        self.player.name = self.player.career or self.player.name or "You"
        if not self.player.skills or #self.player.skills == 0 then
            local career = self.player.career or "Tech Bro"
            if career == "Tech Bro" then
                self.player.skills = {
                    skills.playerSkills["Excel Slam"],
                    skills.playerSkills["Buzzword Barrage"],
                    skills.playerSkills["Coffee Break"]
                }
            elseif career == "Marketing Diva" then
                self.player.skills = {
                    skills.playerSkills["Buzzword Barrage"],
                    skills.playerSkills["LinkedIn Flex"],
                    skills.playerSkills["Coffee Break"]
                }
            elseif career == "Freelance Wizard" then
                self.player.skills = {
                    skills.playerSkills["Excel Slam"],
                    skills.playerSkills["Coffee Break"],
                    skills.playerSkills["LinkedIn Flex"]
                }
            end
        end
    end

    self.player.hp = tonumber(self.player.hp) or 40
    self.player.maxHp = tonumber(self.player.maxHp) or 40
    self.player.level = tonumber(self.player.level) or 1
    self.player.xp = tonumber(self.player.xp) or 0
    self.player.xpToNext = tonumber(self.player.xpToNext) or 3
    self.player.selectedSkill = tonumber(self.player.selectedSkill) or 1

    self.floatingText = {}
    self:loadEnemy()
end

function battle:loadEnemy()
    local name = self.enemyQueue[self.currentEnemyIndex]
    print("🧠 Loading enemy:", name, "Index:", self.currentEnemyIndex, "Stage:", gameState.currentStage or "unknown")

    self.enemy = enemies[name]
    if not self.enemy then
        print("❌ Error: Enemy not found for key: " .. tostring(name))
        self.enemy = {
            name = "Unknown Enemy",
            hp = 20,
            maxHp = 20,
            skills = { skills.playerSkills["Excel Slam"] } -- Fallback skill
        }
    else
        self.enemy = {
            name = self.enemy.name,
            hp = self.enemy.maxHp,
            maxHp = self.enemy.maxHp,
            skills = self.enemy.skills
        }
    end

    -- Validate skills
    if not self.enemy.skills or #self.enemy.skills == 0 then
        print("⚠️ Warning: Enemy " .. tostring(name) .. " has no valid skills, assigning fallback")
        self.enemy.skills = { skills.playerSkills["Excel Slam"] }
    end

    self.enemy.hp = tonumber(self.enemy.hp) or self.enemy.maxHp or 20
    self.enemy.maxHp = tonumber(self.enemy.maxHp) or 20
    self.enemyName = tostring(name)

    local imagePath = "assets/images/characters/" .. string.lower(tostring(name)) .. ".png"
    if love.filesystem.getInfo(imagePath) then
        self.enemyImage = love.graphics.newImage(imagePath)
    else
        print("⚠️ Warning: Enemy image not found at path:", imagePath)
        self.enemyImage = love.graphics.newImage("assets/images/characters/default_enemy.png")
    end

    self.turn = "player"
    self.message = "Battle started against " .. (self.enemy.name or "Unknown Enemy") .. "!"
    print("🧠 Enemy HP:", self.enemy.hp, "Max HP:", self.enemy.maxHp)
end

function battle:update(dt)
    for i = #self.floatingText, 1, -1 do
        local t = self.floatingText[i]
        t.y = t.y - dt * 30
        t.timer = t.timer - dt
        if t.timer <= 0 then table.remove(self.floatingText, i) end
    end

    if self.battleOver and self.postBattleTimer > 0 then
        self.postBattleTimer = self.postBattleTimer - dt
    end
end

function battle:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    if self.postBattleTimer > 0 then
        love.graphics.setColor(1, 1, 1, math.max(0, self.postBattleTimer / 2))
    end
    love.graphics.draw(self.bg, 0, 0, 0, w / self.bg:getWidth(), h / self.bg:getHeight())
    love.graphics.setFont(self.pixelFont)

    local scale = 0.5
    local playerX, playerY = 60, h - self.playerImage:getHeight() * scale - 40
    local enemyX, enemyY = w - self.enemyImage:getWidth() * scale - 100, 60
    love.graphics.draw(self.playerImage, playerX, playerY, 0, scale, scale)
    love.graphics.draw(self.enemyImage, enemyX, enemyY, 0, scale, scale)

    self:drawHealthBar(playerX, playerY - 16, self.playerImage:getWidth() * scale, 10, self.player.hp, self.player.maxHp,
        { 0, 0.8, 0.2 })
    self:drawHealthBar(enemyX, enemyY - 16, self.enemyImage:getWidth() * scale, 10, self.enemy.hp, self.enemy.maxHp,
        { 0.8, 0.1, 0.1 })

    local dialogX, dialogY, dialogW = 15, 15, w / 2 - 30
    local _, wrappedText = love.graphics.getFont():getWrap(self.message, dialogW - 20)
    local dialogH = 50 + #wrappedText * love.graphics.getFont():getHeight()
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", dialogX, dialogY, dialogW, dialogH)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", dialogX, dialogY, dialogW, dialogH)
    love.graphics.printf("Battle: " .. (self.enemy.name or "Unknown Enemy"), dialogX + 10, dialogY + 10, dialogW - 20,
        "left")
    love.graphics.printf(self.message, dialogX + 10, dialogY + 30, dialogW - 20, "left")

    local statsY = dialogY + dialogH + 10
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", dialogX, statsY, dialogW, 60)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", dialogX, statsY, dialogW, 60)
    love.graphics.printf("Player: " .. self.player.name .. " (Lvl " .. self.player.level .. ")", dialogX + 10,
        statsY + 10, dialogW - 20, "left")
    love.graphics.printf(
        "HP: " ..
        self.player.hp .. "/" .. self.player.maxHp .. "   XP: " .. self.player.xp .. "/" .. self.player.xpToNext,
        dialogX + 10, statsY + 30, dialogW - 20, "left")

    if not self.battleOver and self.turn == "player" then
        local skillX = w / 2 + 50
        local skillY = h - 200
        local skillW = w / 2 - 70
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle("fill", skillX - 10, skillY, skillW, #self.player.skills * 25 + 60)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", skillX - 10, skillY, skillW, #self.player.skills * 25 + 60)
        love.graphics.printf("↑/↓ to select, [Enter] to use", skillX, skillY + 10, skillW - 20, "left")

        for i, skill in ipairs(self.player.skills) do
            local y = skillY + 30 + i * 25
            local selected = (i == self.player.selectedSkill)
            love.graphics.setColor(selected and { 0.4, 0.8, 1 } or { 1, 1, 1 })
            love.graphics.printf((selected and "➤ " or "") .. skill.name, skillX + 20, y, skillW - 40, "left")
            if skill.cooldown and skill.currentCooldown and skill.currentCooldown > 0 then
                local r = 10
                local percent = skill.currentCooldown / skill.cooldown
                love.graphics.setColor(1, 0.2, 0.2, 0.6)
                love.graphics.arc("fill", skillX + 5, y + 10, r, -math.pi / 2, -math.pi / 2 + 2 * math.pi * percent)
            end
        end
    elseif self.battleOver then
        love.graphics.setColor(1, 1, 1)
        local text = self.stageCleared and "Stage cleared! Press [Enter] to return to map" or
            "Press [Enter] to face the next enemy"
        love.graphics.printf(text, w / 2, h - 50, w / 2 - 40, "center")
    end

    for _, t in ipairs(self.floatingText) do
        love.graphics.setColor(1, 0.2, 0.2)
        love.graphics.print(t.text, t.x, t.y)
    end
    love.graphics.setColor(1, 1, 1)
end

function battle:keypressed(key)
    if self.battleOver then
        if key == "return" and self.victoryAcknowledged then
            if self.stageCleared then
                print("🧠 Stage cleared, returning to map")
                gameState:switch("map")
            elseif self.currentEnemyIndex < #self.enemyQueue then
                print("🧠 Loading next enemy in queue:", self.enemyQueue[self.currentEnemyIndex + 1])
                self.currentEnemyIndex = self.currentEnemyIndex + 1
                self.battleOver = false
                self.victoryAcknowledged = false
                self:loadEnemy()
            else
                print("🧠 All enemies in stage defeated, setting stageCleared")
                self.stageCleared = true
                self.postBattleTimer = 2
            end
        elseif key == "return" then
            self.victoryAcknowledged = true
        end
        return
    end

    if self.turn == "player" then
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
            local damage = math.max(hpBefore - self.enemy.hp, 0)
            self.message = "You " .. result

            if damage > 0 then
                attackSound:play()
                table.insert(self.floatingText,
                    { text = "-" .. damage, x = love.graphics.getWidth() - 140, y = 80, timer = 1.2 })
            elseif skill.type == "heal" then
                healSound:play()
            end

            if skill.cooldown then skill.currentCooldown = skill.cooldown end
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
    self.player.statusEffects = self.player.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }
    local status = self.player.statusEffects
    if status.burnout > 0 then
        status.burnout = status.burnout - 1
        self.message = "You're burned out and skip your turn!"
        self.turn = "enemy"
        self:enemyTurn()
        return true
    end
    if status.overworked > 0 then
        status.overworked = status.overworked - 1
        self.player.hp = self.player.hp - 2
        self.message = "You're overworked! -2 HP!"
    end
    if status.selfdoubt > 0 then
        status.selfdoubt = status.selfdoubt - 1
        self.player.hp = self.player.hp - 2
        self.message = "Self-doubt hurts! -2 HP!"
        self.turn = "enemy"
        self:enemyTurn()
        return true
    end
    return false
end

function battle:enemyTurn()
    if not self.enemy.skills or #self.enemy.skills == 0 then
        print("❌ Error: No valid skills for enemy " .. (self.enemy.name or "Unknown Enemy"))
        self.message = (self.enemy.name or "Unknown Enemy") .. " does nothing!"
        self.turn = "player"
        return
    end

    local skill = self.enemy.skills[math.random(#self.enemy.skills)]
    if not skill then
        print("❌ Error: Selected nil skill for enemy " .. (self.enemy.name or "Unknown Enemy"))
        self.message = (self.enemy.name or "Unknown Enemy") .. " does nothing!"
        self.turn = "player"
        return
    end

    local hpBefore = self.player.hp
    local result = skill.action(self.enemy, self.player)
    local damage = math.max(hpBefore - self.player.hp, 0)

    self.message = (self.enemy.name or "Unknown Enemy") .. " " .. result

    if damage > 0 then
        attackSound:play()
        table.insert(self.floatingText,
            { text = "-" .. damage, x = 80, y = love.graphics.getHeight() - 160, timer = 1.2 })
    end

    if self.player.hp <= 0 then
        self.message = "You were defeated by " .. (self.enemy.name or "Unknown Enemy") .. "!"
        self.battleOver = true
        return
    end

    self:updateCooldowns()
    self:updateBuffs()
    self.turn = "player"
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

function battle:drawHealthBar(x, y, width, height, current, max, color)
    current = tonumber(current) or 0
    max = tonumber(max) or 1
    local ratio = math.max(current / max, 0)
    if ratio > 1 then ratio = 1 end
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, width * ratio, height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, width, height)
end

function battle:winBattle()
    self.enemy.hp = 0
    self.message = "You defeated " .. (self.enemy.name or "Unknown Enemy") .. "! +5 XP"
    self.player.xp = self.player.xp + 5
    self.battleOver = true
    self.victoryAcknowledged = false

    if self.player.xp >= self.player.xpToNext then
        self.player.level = self.player.level + 1
        self.player.xp = self.player.xp - self.player.xpToNext
        self.player.xpToNext = self.player.xpToNext + 5
        self.player.maxHp = self.player.maxHp + 5
        self.player.hp = self.player.maxHp
        self.message = self.message .. "\nLevel up! Now level " .. self.player.level
        local newSkill = self:unlockSkillsByLevel(self.player.level)
        if newSkill then
            self.message = self.message .. "\nUnlocked: " .. newSkill
        end
    end

    self.player.statusEffects = self.player.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }
    gameState.playerData = self.player

    if self.currentEnemyIndex < #self.enemyQueue then
        self.message = self.message .. "\nGet ready for the next enemy!"
    else
        self.message = self.message .. "\nStage cleared!"
    end
end

function battle:unlockSkillsByLevel(level)
    local s = require("classes.skills")
    local ps = s.playerSkills
    local owned = {}
    for _, skill in ipairs(self.player.skills) do owned[skill.name] = true end

    local function addSkill(name)
        if not owned[name] then
            local skill = ps[name]
            if skill then
                table.insert(self.player.skills, skill)
                return name
            end
        end
    end

    if level == 2 then
        return addSkill("PowerPoint Punch")
    elseif level == 3 then
        return addSkill("All-Nighter")
    elseif level == 4 then
        return addSkill("Mindfulness")
    elseif level == 5 then
        for i, s in ipairs(self.player.skills) do
            if s.name == "Buzzword Barrage" then
                local upgraded = ps["Buzzword Barrage+"]
                if upgraded then
                    self.player.skills[i] = upgraded
                    return "Buzzword Barrage+"
                end
            end
        end
    elseif level == 6 then
        return addSkill("Executive Focus")
    elseif level == 7 then
        return addSkill("Corporate Clutch")
    end
end

return battle
