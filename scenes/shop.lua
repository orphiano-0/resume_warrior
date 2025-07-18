local shop = {}
local gameState
local gear = require("classes.gear")

local function ensureGameState()
    if not gameState then
        local ok, gs = pcall(require, "gameState")
        if ok then
            gameState = gs
        else
            print("❌ Failed to require gameState in shop.lua:", gs)
        end
    end
end

shop.items = {
    gear.create("Coffee Mug"),
    gear.create("Briefcase"),
    gear.create("Ergonomic Chair")
}

function shop:load()
    print("🧠 Loading shop scene")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.titleImage = love.graphics.newImage("assets/images/background/pantry.png")
    self.selected = 1
end

function shop:draw()
    ensureGameState()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())
    love.graphics.setFont(self.font)

    local function drawPixelatedBox(text, y)
        local padding = 10
        local boxWidth = self.font:getWidth(text) + padding * 2
        local boxHeight = self.font:getHeight() + padding
        local x = (w - boxWidth) / 2
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", x, y - padding / 2, boxWidth, boxHeight, 4, 4)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(text, 0, y, w, "center")
    end

    local shopText = "Coffee Shop - Beans: " .. (gameState.playerData and gameState.playerData.currency or 0)
    drawPixelatedBox(shopText, 50)

    for i, item in ipairs(self.items) do
        local prefix = (i == self.selected) and "> " or "  "
        local text = prefix .. item.name .. " (" .. item.cost .. " Beans): " .. item:getDescription()
        drawPixelatedBox(text, 100 + i * 30)
    end

    drawPixelatedBox("Use ↑/↓ to select, [Enter] to buy, [Escape] to return to map", h - 50)
end

function shop:keypressed(key)
    ensureGameState()

    if key == "up" then
        self.selected = (self.selected - 2) % #self.items + 1
    elseif key == "down" then
        self.selected = self.selected % #self.items + 1
    elseif key == "return" then
        local player = gameState.playerData
        if not player then
            print("❌ Error: No player data in shop")
            return
        end

        ---@type table|nil
        local item = self.items[self.selected]
        if not item then
            print("❌ Error: No item selected")
            return
        end

        if player.currency >= item.cost then
            player.currency = player.currency - item.cost
            player.gear = player.gear or {}
            table.insert(player.gear, item)

            -- Check if applyEffect exists and is callable
            if item.applyEffect then
                item:applyEffect(player)
            end

            print("🧠 Bought " .. item.name .. " for " .. item.cost .. " Beans")
            gameState:switch("map")
        else
            print("❌ Not enough Beans to buy " .. item.name)
        end
    elseif key == "escape" then
        print("🧠 Shop: Returning to map")
        gameState:switch("map")
    end
end

return shop
