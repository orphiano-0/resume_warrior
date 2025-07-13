local menu = {}
local gameState -- Declare but don't assign at the top

function menu:load()
    print("🧠 Loading menu scene")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.titleImage = love.graphics.newImage("assets/images/background/lobby.png")
end

function menu:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setFont(self.font)
    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())
    love.graphics.printf("Welcome to the Game!\n\nPress [Enter] to create your resume", 0, h / 2 - 20, w, "center")
end

function menu:keypressed(key)
    if key == "return" then
        print("🧠 Menu: Switching to resume")
        if not gameState then gameState = require("gameState") end -- Lazy require
        gameState:switch("resume")
    end
end

return menu
