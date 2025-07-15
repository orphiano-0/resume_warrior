local gameState = require("gameState")

function love.load()
    print("🧠 Game started, logging to console.log")

    love.window.setTitle("Resume Warrior: Career Mode")

    local icon = love.image.newImageData("assets/images/logo/logo.png")
    love.window.setIcon(icon)

    love.graphics.setFont(love.graphics.newFont("assets/fonts/pixel.ttf", 12))

    gameState:load()
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()
end

function love.keypressed(key)
    gameState:keypressed(key)
end

function love.mousepressed(x, y, button)
    gameState:mousepressed(x, y, button)
end
