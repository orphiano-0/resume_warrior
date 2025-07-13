local shop = {}
local gameState

-- ✅ Define this function early
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
    {
        name = "Coffee Mug",
        cost = 10,
        effect = { maxHp = 5 },
        description = "Increases max HP by 5"
    },
    {
        name = "Briefcase",
        cost = 15,
        effect = { damageBoost = 1 },
        description = "Increases damage by 1"
    },
    {
        name = "Ergonomic Chair",
        cost = 20,
        effect = { hpRegen = 2 },
        description = "Regenerates 2 HP per turn"
    }
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
    love.graphics.printf("Coffee Shop - Beans: " .. (gameState.playerData and gameState.playerData.currency or 0), 0, 50,
        w, "center")
    for i, item in ipairs(self.items) do
        local prefix = (i == self.selected) and "> " or "  "
        love.graphics.printf(prefix .. item.name .. " (" .. item.cost .. " Beans): " .. item.description, 0, 100 + i * 20,
            w, "center")
    end
    love.graphics.printf("Use ↑/↓ to select, [Enter] to buy, [Escape] to return to map", 0, h - 50, w, "center")
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
        local item = self.items[self.selected]
        if player.currency >= item.cost then
            player.currency = player.currency - item.cost
            player.gear = player.gear or {}
            table.insert(player.gear, item)
            print("🧠 Bought", item.name, "for", item.cost, "Beans")
            gameState:switch("map")
        else
            print("❌ Not enough Beans to buy", item.name)
        end
    elseif key == "escape" then
        print("🧠 Shop: Returning to map")
        gameState:switch("map")
    end
end

return shop
