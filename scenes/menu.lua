local menu = {}
local gameState

function menu:load()
    print("🧠 Loading menu scene")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.titleImage = love.graphics.newImage("assets/images/background/lobby.png")
end

function menu:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setFont(self.font)
    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())

    local welcome = "Welcome to the Game!\n\nPress [Enter] to create your resume"
    local lines = 3
    local padding = 10
    local textW = self.font:getWidth("Press [Enter] to create your resume")
    local boxW = textW + padding * 2
    local boxH = self.font:getHeight() * lines + padding * 2
    local x = (w - boxW) / 2
    local y = h / 2 - boxH / 2

    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", x, y, boxW, boxH, 4, 4)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(welcome, 0, y + padding, w, "center")
end

function menu:keypressed(key)
    if key == "return" then
        print("🧠 Menu: Switching to resume")
        if not gameState then gameState = require("gameState") end
        gameState:switch("resume")
    end
end

return menu
