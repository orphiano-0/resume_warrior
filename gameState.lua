local gameState = {}

local menu = require("scenes.menu")
local shopScene = require("scenes.shop")
local resumeCreation = require("scenes.resume_creation")
local mapScene = require("scenes.map")

local current = "title"
local saveFileName = "savegame.lua"

local states = {
    title = nil, -- Will be loaded dynamically
    menu = menu,
    resume = resumeCreation,
    map = mapScene,
    battle = nil,
    shop = shopScene
}

-- 🔧 Table serialization helper
function table.serialize(tbl)
    local function serialize(o)
        if type(o) == "number" then
            return tostring(o)
        elseif type(o) == "string" then
            return string.format("%q", o)
        elseif type(o) == "boolean" then
            return tostring(o)
        elseif type(o) == "table" then
            local s = "{"
            for k, v in pairs(o) do
                s = s .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
            end
            return s .. "}"
        else
            return "\"[unserializable datatype:" .. type(o) .. "]\""
        end
    end
    return serialize(tbl)
end

function gameState:save()
    local data = {
        currentStage = self.currentStage,
        playerData = self.playerData
    }
    local serialized = "return " .. table.serialize(data)
    local success, message = love.filesystem.write(saveFileName, serialized)
    if success then
        print("💾 Game saved successfully.")
    else
        print("❌ Failed to save game:", message)
    end
end

function gameState:loadSave()
    if love.filesystem.getInfo(saveFileName) then
        local chunk = love.filesystem.load(saveFileName)
        local data = chunk()
        self.currentStage = data.currentStage or 1
        self.playerData = data.playerData or nil
        print("✅ Save file loaded.")
    else
        print("ℹ️ No save file found. Starting new game.")
        self.currentStage = 1
        self.playerData = nil
    end
end

function gameState:newGame()
    self.currentStage = 1
    self.playerData = nil
    love.filesystem.remove(saveFileName)
    print("🆕 New game started.")
end

function gameState:load(...)
    self:loadSave()

    print("🧠 gameState:load, currentStage:", self.currentStage, "scene:", current)

    -- Dynamically load title scene to avoid circular dependency
    if not states.title then
        print("🧠 Loading title scene")
        local success, titleScene = pcall(require, "scenes.title")
        if success and type(titleScene) == "table" then
            states.title = titleScene
        else
            print("❌ Error: Failed to load title scene or title scene is not a table:", titleScene)
            states.title = {
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
        local success, titleScene = pcall(require, "scenes.title")
        if success and type(titleScene) == "table" then
            states.title = titleScene
        else
            print("❌ Error: Failed to load title scene or title scene is not a table:", titleScene)
            return
        end
    end

    if newState == "battle" and not states.battle then
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
    if key == "f5" then self:save() end
    if key == "f6" then self:loadSave() end
    if key == "f7" then self:newGame() end

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
