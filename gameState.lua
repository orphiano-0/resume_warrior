local gameState = {}

local menu = require("scenes.menu")
local shopScene = require("scenes.shop")
local resumeCreation = require("scenes.resume_creation")
local mapScene = require("scenes.map")

local current = "title"
local states = {
    title = nil, -- Will be loaded dynamically
    menu = menu,
    resume = resumeCreation,
    map = mapScene,
    battle = nil,
    shop = shopScene
}

function gameState:load(...)
    if not self.currentStage then
        self.currentStage = 1
    end
    print("🧠 gameState:load, currentStage:", self.currentStage, "scene:", current)

    -- Dynamically load title scene to avoid circular dependency
    if not states.title then
        print("🧠 Loading title scene")
        local success, titleScene = pcall(require, "scenes.title")
        if success and type(titleScene) == "table" then
            states.title = titleScene
        else
            print("❌ Error: Failed to load title scene or title scene is not a table:", titleScene)
            states.title = { -- Fallback empty scene
                load = function() end,
                draw = function()
                    love.graphics.printf("Error: Title scene failed to load", 0, 100, love.graphics.getWidth(), "center")
                end,
                keypressed = function(key)
                    if key == "return" then
                        gameState:switch("menu")
                    end
                end
            }
        end
    end

    if not states.battle then
        print("🧠 Loading battle scene")
        local success, battleScene = pcall(require, "scenes.battle")
        if success and type(battleScene) == "table" then
            states.battle = battleScene
        else
            print("❌ Error: Failed to load battle scene or battle scene is not a table:", battleScene)
        end
    end

    if type(states[current]) ~= "table" then
        print("❌ Error: states[" .. current .. "] is not a table:", type(states[current]))
        return
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
    print("🧠 gameState:switch, newState:", newState, "currentStage:", self.currentStage)
    if newState == "title" and not states.title then
        print("🧠 Loading title scene in switch")
        local success, titleScene = pcall(require, "scenes.title")
        if success and type(titleScene) == "table" then
            states.title = titleScene
        else
            print("❌ Error: Failed to load title scene or title scene is not a table:", titleScene)
            return
        end
    end

    if newState == "battle" and not states.battle then
        print("🧠 Loading battle scene in switch")
        local success, battleScene = pcall(require, "scenes.battle")
        if success and type(battleScene) == "table" then
            states.battle = battleScene
        else
            print("❌ Error: Failed to load battle scene or battle scene is not a table:", battleScene)
            return
        end
    end

    if type(states[newState]) ~= "table" then
        print("❌ Error: states[" .. newState .. "] is not a table:", type(states[newState]))
        return
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
    print("🧠 Switched to", newState, "currentStage:", self.currentStage)
end

function gameState:update(dt)
    if type(states[current]) == "table" and states[current].update then
        states[current]:update(dt)
    end
end

function gameState:draw()
    if type(states[current]) == "table" and states[current].draw then
        states[current]:draw()
    end
end

function gameState:keypressed(key)
    if type(states[current]) == "table" and states[current].keypressed then
        states[current]:keypressed(key)
    end
end

function gameState:mousepressed(x, y, button)
    if type(states[current]) == "table" and states[current].mousepressed then
        states[current]:mousepressed(x, y, button)
    end
end

return gameState
