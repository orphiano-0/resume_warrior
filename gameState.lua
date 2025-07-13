local gameState = {}

local menu = require("scenes.menu")
local resumeCreation = require("scenes.resume_creation")
local mapScene = require("scenes.map")

local current = "menu"
local states = {
    menu = menu,
    resume = resumeCreation,
    map = mapScene,
    battle = nil
}

function gameState:load(...)
    if not self.currentStage then
        self.currentStage = 1
    end
    print("🧠 gameState:load, currentStage:", self.currentStage, "scene:", current)
    if not states.battle then
        states.battle = require("scenes.battle")
    end
    if current == "map" then
        states[current]:load(self.currentStage)
    else
        states[current]:load(...)
    end

    if current == "resume" then
        states["resume"].onComplete = function(playerData)
            self.playerData = playerData
            self:switch("map")
        end
    end
end

function gameState:switch(newState, ...)
    if states[newState] or newState == "battle" then
        if newState == "battle" and not states.battle then
            states.battle = require("scenes.battle")
        end
        current = newState
        if newState == "map" then
            states[current]:load(self.currentStage)
        else
            states[current]:load(...)
        end

        if newState == "resume" then
            states["resume"].onComplete = function(playerData)
                self.playerData = playerData
                self:switch("map")
            end
        end
        print("🧠 gameState:switch to", newState, "currentStage:", self.currentStage)
    else
        print("❌ Error: Attempted to switch to invalid state:", newState)
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

return gameState
