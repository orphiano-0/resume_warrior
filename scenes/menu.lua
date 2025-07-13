local menu = {}
local gameState -- Declare but don't assign at the top

function menu:load()
    print("🧠 Loading menu scene")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
end

function menu:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Welcome to the Game!\nPress [Enter] to create your resume", 0, h / 2 - 20, w, "center")
end

function menu:keypressed(key)
    if key == "return" then
        print("🧠 Menu: Switching to resume")
        if not gameState then gameState = require("gameState") end -- Lazy require
        gameState:switch("resume")
    end
end

return menu
