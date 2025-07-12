local gameState = {}

local menu = require("scenes.menu")
local resumeCreation = require("scenes.resume_creation")
local mapScene = require("scenes.map")
local battleScene = require("scenes.battle")

local current = "menu"
local states = {
    menu = menu,
    resume = resumeCreation,
    map = mapScene,
    battle = battleScene
}

function gameState:load(...)
    states[current]:load(...)

    if current == "resume" then
        states["resume"].onComplete = function(playerData)
            self.playerData = playerData
            self:switch("map")
        end
    end
end

function gameState:update(dt)
    if states[current].update then
        states[current]:update(dt)
    end
end

function gameState:draw()
    if states[current].draw then
        states[current]:draw()
    end
end

function gameState:keypressed(key)
    if states[current].keypressed then
        states[current]:keypressed(key)
    end
end

function gameState:mousepressed(x, y, button)
    if states[current].mousepressed then
        states[current]:mousepressed(x, y, button)
    end
end

-- ✅ Allows passing enemy keys or any custom arguments
function gameState:switch(newState, ...)
    if states[newState] then
        current = newState
        states[current]:load(...)

        if newState == "resume" then
            states["resume"].onComplete = function(playerData)
                self.playerData = playerData
                self:switch("map")
            end
        end
    end
end

return gameState
