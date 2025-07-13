local map = {}
local gameState

function map:load(stage)
    self.stage = stage or 1
    print("🧠 Map loaded, current stage:", self.stage)
    self.bg = love.graphics.newImage("assets/images/background/bright_background.png")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
end

function map:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.draw(self.bg, 0, 0, 0, w / self.bg:getWidth(), h / self.bg:getHeight())
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Stage " .. self.stage, 0, 50, w, "center")
    love.graphics.printf("Press [Enter] to Start Next Career Challenge", 0, h - 50, w, "center")
end

function map:keypressed(key)
    if key == "return" then
        -- Lazy require with error handling
        if not gameState then
            local ok, gs = pcall(require, "gameState")
            if ok then
                gameState = gs
            else
                print("❌ Failed to require gameState:", gs)
                return
            end
        end

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
    end
end

return map
