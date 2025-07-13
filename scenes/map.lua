local map = {}
local gameState

function map:load(stage)
    self.stage = stage or 1
    print("🧠 Map loaded, current stage:", self.stage)
    self.bg = love.graphics.newImage("assets/images/background/bright_background.png")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.selection = 1
end

function map:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.draw(self.bg, 0, 0, 0, w / self.bg:getWidth(), h / self.bg:getHeight())
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Stage " .. self.stage, 0, 50, w, "center")

    local options = { "Go to Battle", "Visit Coffee Shop" }
    for i, option in ipairs(options) do
        local prefix = (i == self.selection) and "> " or "  "
        love.graphics.printf(prefix .. option, 0, 100 + i * 30, w, "center")
    end

    love.graphics.printf("Use ↑/↓ to choose, [Enter] to select", 0, h - 50, w, "center")
end

function map:keypressed(key)
    if not gameState then
        local ok, gs = pcall(require, "gameState")
        if ok then
            gameState = gs
        else
            print("❌ Failed to require gameState:", gs)
            return
        end
    end

    if key == "up" then
        self.selection = (self.selection - 2) % 2 + 1
    elseif key == "down" then
        self.selection = self.selection % 2 + 1
    elseif key == "return" then
        if self.selection == 1 then
            local enemyList
            if self.stage == 1 then
                enemyList = { "internSwarm", "hrKaren" }
            elseif self.stage == 2 then
                enemyList = { "micromanageDragon" }
            elseif self.stage == 3 then
                enemyList = { "deadlineDemon" }
            elseif self.stage == 4 then
                enemyList = { "overtimeOgre" }
            elseif self.stage == 5 then
                enemyList = { "selfdoubtSpecter" }
            elseif self.stage == 6 then
                enemyList = { "gaslightGhoul" }
            elseif self.stage == 7 then
                enemyList = { "hrReaper" }
            elseif self.stage == 8 then
                enemyList = { "ceoOfDoom" }
            elseif self.stage == 9 then
                enemyList = { "ceoOfChaos" }
            else
                enemyList = { "internSwarm" }
            end

            print("🧠 Starting battle for stage", self.stage, "with enemies:", table.concat(enemyList, ", "))
            gameState.currentStage = self.stage + 1
            gameState:switch("battle", enemyList)
        elseif self.selection == 2 then
            print("🧠 Going to shop from map")
            gameState:switch("shop")
        end
    end
end

return map
