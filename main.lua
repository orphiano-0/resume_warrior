local gameState = require("gameState")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    defaultFont = love.graphics.newFont(14)
    love.graphics.setFont(defaultFont)
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
