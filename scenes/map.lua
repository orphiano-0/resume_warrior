local map = {}

function map:load()
    self.selected = 1
    self.stage = 1 -- Current stage
    self.stages = {
        [1] = { "internSwarm" },
        [2] = { "micromanageDragon" },
        [3] = { "deadlineDemon" },
        [4] = { "overtimeOgre" },
        [5] = { "selfdoubtSpecter" },
        [6] = { "gaslightGhoul" },
        [7] = { "hrReaper" },
        [8] = { "ceoOfDoom" }
    }

    self.options = {
        { label = "📊 Start Next Career Challenge", type = "battle" },
        { label = "🍕 Event: Awkward Team Lunch", type = "event" },
        { label = "🛍️ Shop: LinkedIn Perks", type = "shop" }
    }
end

function map:update(dt) end

function map:draw()
    love.graphics.printf("🏢 Career Map", 0, 40, love.graphics.getWidth(), "center")
    love.graphics.printf("Choose your next move!", 0, 80, love.graphics.getWidth(), "center")

    for i, option in ipairs(self.options) do
        local y = 120 + i * 30
        local prefix = (i == self.selected) and "➤ " or "   "
        love.graphics.printf(prefix .. option.label, 0, y, love.graphics.getWidth(), "center")
    end

    if not self.stages[self.stage] then
        love.graphics.printf("🎉 You've completed all career battles! Press [Enter] to restart.", 0, 280,
            love.graphics.getWidth(), "center")
    end

    love.graphics.printf("↑/↓ to navigate, Enter to select", 0, 320, love.graphics.getWidth(), "center")
end

function map:keypressed(key)
    if key == "up" then
        self.selected = self.selected - 1
        if self.selected < 1 then self.selected = #self.options end
    elseif key == "down" then
        self.selected = self.selected + 1
        if self.selected > #self.options then self.selected = 1 end
    elseif key == "return" then
        local choice = self.options[self.selected]
        local gameState = require("gameState")
        local battle = require("scenes.battle")

        if choice.type == "battle" then
            -- Check if there are stages left to play
            if self.stages[self.stage] then
                local enemyList = self.stages[self.stage]
                local enemyKey = enemyList[1]
                if enemyKey then
                    gameState:switch("battle", enemyKey)
                    print("Loading enemy key:", enemyKey)
                    self.stage = self.stage + 1
                else
                    print("❌ Error: No enemy key defined for stage:", self.stage)
                end
            else
                -- All stages completed; restart game
                print("🎉 All stages completed! Restarting game.")
                self.stage = 1 -- Reset to first stage
                self:load()    -- Reload map state
            end
        elseif choice.type == "event" then
            print("📅 Event feature coming soon.")
        elseif choice.type == "shop" then
            print("🛍️ Shop feature coming soon.")
        end
    end
end

return map
