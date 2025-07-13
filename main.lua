local gameState = require("gameState")

-- Redirect print to a file
local originalPrint = print
function print(...)
    local file = io.open("console.log", "a") -- Append mode
    if file then
        local args = { ... }
        for i, v in ipairs(args) do
            args[i] = tostring(v)
        end
        file:write(table.concat(args, "\t") .. "\n")
        file:close()
    end
    originalPrint(...) -- Still print to terminal if available
end

function love.load()
    print("🧠 Game started, logging to console.log")
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
