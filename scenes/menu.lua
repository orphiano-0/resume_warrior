local menu = {}

local gameState -- to be set later

function menu:load()
    gameState = require("gameState")
end

function menu:draw()
    love.graphics.printf("📄 Resume Warrior: Career Mode", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Press [Enter] to Build Your Resume", 0, 200, love.graphics.getWidth(), "center")
end

function menu:keypressed(key)
    if key == "return" then
        gameState:switch("resume")
    end
end

return menu
