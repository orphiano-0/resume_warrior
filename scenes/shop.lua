local shop = {}
local gameState
local gear = require("classes.gear")

local showPopup = false
local popupMessage = ""
local popupTimer = 0
local popupDuration = 2 -- seconds

local purchaseSound
local errorSound

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

function shop:load()
    print("🧠 Loading shop scene")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.titleImage = love.graphics.newImage("assets/images/background/pantry.png")
    self.selected = 1

    -- 🔊 Load sound effects
    purchaseSound = love.audio.newSource("assets/sounds/purchase.mp3", "static")
    errorSound = love.audio.newSource("assets/sounds/death.mp3", "static")

    self.items = {
        gear.create("Coffee Mug"),
        gear.create("Briefcase"),
        gear.create("Ergonomic Chair"),
        gear.create("Energy Bar"),
        gear.create("Motivational Poster"),
        gear.create("Standing Desk")
    }

    self.categorizedItems = {}
    for _, item in ipairs(self.items) do
        local category = item.category or "Misc"
        self.categorizedItems[category] = self.categorizedItems[category] or {}
        table.insert(self.categorizedItems[category], item)
    end
end

function shop:update(dt)
    if showPopup then
        popupTimer = popupTimer - dt
        if popupTimer <= 0 then
            showPopup = false
        end
    end
end

function shop:draw()
    ensureGameState()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    local padding = 10

    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())
    love.graphics.setFont(self.font)

    self.itemIndexMap = {}
    local y = 40
    local centerX = w / 2

    local title = "☕ Coffee Shop - Beans: " .. (gameState.playerData and gameState.playerData.currency or 0)
    self:drawBox(title, centerX, y, { 0.2, 0.2, 0.2, 0.8 }, { 1, 1, 1 })
    y = y + 60

    local index = 1
    for category, items in pairs(self.categorizedItems) do
        self:drawBox("📦 " .. category, centerX, y, { 0.15, 0.15, 0.15, 0.8 }, { 1, 0.8, 0.2 })
        y = y + 40

        for _, item in ipairs(items) do
            local isSelected = (index == self.selected)
            local prefix = isSelected and "▶ " or "   "
            local itemText = prefix .. item.name .. " (" .. item.cost .. " Beans)"
            local descText = "   - " .. item:getDescription()

            if isSelected then
                self:drawBox(itemText, centerX, y, { 0.1, 0.3, 0.1, 0.9 }, { 1, 1, 1 })
                y = y + 25
                self:drawBox(descText, centerX, y, { 0.05, 0.05, 0.05, 0.6 }, { 0.9, 0.9, 0.9 })
                y = y + 40
            else
                self:drawBox(itemText, centerX, y, { 0, 0, 0, 0.6 }, { 0.8, 0.8, 0.8 })
                y = y + 40
            end

            self.itemIndexMap[index] = item
            index = index + 1
        end
    end

    self:drawBox("↑/↓ to select, [Enter] to buy, [Esc] to return", centerX, h - 40, { 0, 0, 0, 0.7 }, { 1, 1, 1 })

    -- 🔔 Draw top-right popup
    if showPopup then
        local msg = popupMessage
        local boxW = self.font:getWidth(msg) + 30
        local boxH = self.font:getHeight() + 14
        local x = w - boxW - 20
        local y = 20

        love.graphics.setColor(0, 0, 0, 0.85)
        love.graphics.rectangle("fill", x, y, boxW, boxH, 6, 6)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(msg, x + 10, y + 7, boxW - 20, "left")
    end
end

function shop:drawBox(text, x, y, bgColor, textColor)
    local paddingX, paddingY = 10, 6
    local width = self.font:getWidth(text) + paddingX * 2
    local height = self.font:getHeight() + paddingY * 2
    local boxX = x - width / 2
    love.graphics.setColor(bgColor)
    love.graphics.rectangle("fill", boxX, y, width, height, 4, 4)
    love.graphics.setColor(textColor)
    love.graphics.printf(text, boxX, y + paddingY, width, "center")
end

function shop:keypressed(key)
    ensureGameState()
    local maxItems = #self.itemIndexMap or 0

    if key == "up" then
        self.selected = (self.selected - 2) % maxItems + 1
    elseif key == "down" then
        self.selected = self.selected % maxItems + 1
    elseif key == "return" then
        local player = gameState.playerData
        local item = self.itemIndexMap[self.selected]

        if not player or not item then
            popupMessage = "❌ Error: No player or item"
            showPopup = true
            popupTimer = popupDuration
            love.audio.play(errorSound)
            return
        end

        if player.currency >= item.cost then
            player.currency = player.currency - item.cost
            player.gear = player.gear or {}
            table.insert(player.gear, item)

            if item.applyEffect then
                item:applyEffect(player)
            end

            popupMessage = "✅ " .. item.name .. " purchased!"
            love.audio.play(purchaseSound)
        else
            popupMessage = "❌ Not enough Beans!"
            love.audio.play(errorSound)
        end

        showPopup = true
        popupTimer = popupDuration
    elseif key == "escape" then
        print("🧠 Shop: Returning to map")
        gameState:switch("map")
    end
end

return shop
