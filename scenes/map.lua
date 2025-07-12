local map = {}

function map:load()
    self.options = {
        { label = "📊 Battle: Office Intern Swarm", type = "battle" },
        { label = "🍕 Event: Awkward Team Lunch", type = "event" },
        { label = "🛍️ Shop: LinkedIn Perks", type = "shop" }
    }
    self.selected = 1
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

    love.graphics.printf("↑/↓ to navigate, Enter to select", 0, 300, love.graphics.getWidth(), "center")
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
        print("Selected:", choice.type, "-", choice.label)
        -- Placeholder: you could do gameState:switch("battle") or similar
        if choice.type == "battle" then
            local gameState = require("gameState")
            gameState:switch("battle")
        end
    end
end

return map
