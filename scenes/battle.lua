local skills = require("classes.skills")
local enemies = require("classes.enemies")
local battle = {}

function battle:load()
    -- Choose enemy
    self.enemy = enemies.internSwarm -- Swap this to hrKaren or micromanageDragon as needed

    -- Player setup
    self.player = {
        name = "You",
        hp = 20,
        maxHp = 20,
        level = 1,
        xp = 0,
        xpToNext = 10,
        selectedSkill = 1,
        buffs = { damageBoost = 0, turnsRemaining = 0 },
        statusEffects = { burnout = 0, overworked = 0, },
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
    love.graphics.printf("⚔️ Battle: " .. self.enemy.name, 0, 30, love.graphics.getWidth(), "center")

    love.graphics.printf("👨‍💼 HP: " .. self.player.hp .. "/" .. self.player.maxHp, 20, 80, love.graphics.getWidth(),
        "left")
    love.graphics.printf("🧠 XP: " .. self.player.xp .. "/" .. self.player.xpToNext .. " | Level " .. self.player.level,
        20, 110, love.graphics.getWidth(), "left")

    love.graphics.printf("👥 Enemy HP: " .. self.enemy.hp .. "/" .. self.enemy.maxHp, 20, 140, love.graphics.getWidth(),
        "left")
    love.graphics.printf(self.message, 0, 180, love.graphics.getWidth(), "center")

    if not self.battleOver and self.turn == "player" then
        love.graphics.printf("↑/↓ to select, [Enter] to use skill", 0, 220, love.graphics.getWidth(), "center")
        for i, skill in ipairs(self.player.skills) do
            local y = 260 + i * 30
            local selected = (i == self.player.selectedSkill) and "➤ " or "   "
            local cd = (skill.currentCooldown and skill.currentCooldown > 0) and
                (" (CD: " .. skill.currentCooldown .. ")") or ""
            love.graphics.printf(selected .. skill.name .. cd, 0, y, love.graphics.getWidth(), "center")
        end
    elseif self.battleOver then
        love.graphics.printf("Press [Enter] to return to map", 0, 260, love.graphics.getWidth(), "center")
    end
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
            self.player.selectedSkill = (self.player.selectedSkill) % #self.player.skills + 1
        elseif key == "return" then
            -- Check burnout
            if self.player.statusEffects.burnout > 0 then
                self.message = "You're burned out and skip your turn!"
                self.player.statusEffects.burnout = self.player.statusEffects.burnout - 1
                self.turn = "enemy"
                self:enemyTurn()
                return
            end

            -- Overworked penalty
            if self.player.statusEffects.overworked > 0 then
                self.player.hp = self.player.hp - 2
                self.message = "You're overworked! -2 HP!"
                self.player.statusEffects.overworked = self.player.statusEffects.overworked - 1
            end

            local skill = self.player.skills[self.player.selectedSkill]
            if skill.currentCooldown > 0 then
                self.message = skill.name .. " is on cooldown!"
                return
            end

            local result = skill.action(self.player, self.enemy)
            self.message = "You " .. result

            if skill.cooldown then skill.currentCooldown = skill.cooldown end

            if self.enemy.hp <= 0 then
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
            else
                self.turn = "enemy"
                self:enemyTurn()
            end
        end
    end
end

function battle:enemyTurn()
    local skill = self.enemy.skills[math.random(#self.enemy.skills)]
    local result = skill.action(self.enemy, self.player)
    self.message = self.enemy.name .. " " .. result

    if self.player.hp <= 0 then
        self.player.hp = 0
        self.message = "You were defeated by " .. self.enemy.name .. "!"
        self.battleOver = true
        return
    end

    -- Cooldowns
    for _, skill in ipairs(self.player.skills) do
        if skill.currentCooldown and skill.currentCooldown > 0 then
            skill.currentCooldown = skill.currentCooldown - 1
        end
    end

    -- Buff duration
    if self.player.buffs.turnsRemaining > 0 then
        self.player.buffs.turnsRemaining = self.player.buffs.turnsRemaining - 1
        if self.player.buffs.turnsRemaining == 0 then
            self.player.buffs.damageBoost = 0
        end
    end

    self.turn = "player"
end

return battle
