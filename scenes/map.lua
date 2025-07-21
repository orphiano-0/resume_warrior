local map = {}
local gameState

function map:load(stage)
    self.stage = stage or 1
    print("🧠 Map loaded, current stage:", self.stage)
    self.bg = love.graphics.newImage("assets/images/background/bright_background.png")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.selection = 1

    -- Moved here so it can be accessed in both draw() and keypressed()
    self.options = { "Office Battle", "Coffee Pantry", "View Stats" }
end

function map:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.draw(self.bg, 0, 0, 0, w / self.bg:getWidth(), h / self.bg:getHeight())
    love.graphics.setFont(self.font)

    local function drawPixelatedBox(text, y)
        local padding = 10
        local boxWidth = self.font:getWidth(text) + padding * 2
        local boxHeight = self.font:getHeight() + padding
        local x = (w - boxWidth) / 2
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", x, y - padding / 2, boxWidth, boxHeight, 4, 4)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(text, 0, y, w, "center")
    end

    drawPixelatedBox("Stage " .. self.stage, 50)

    for i, option in ipairs(self.options) do
        local prefix = (i == self.selection) and "> " or "  "
        drawPixelatedBox(prefix .. option, 100 + i * 30)
    end

    drawPixelatedBox("Use ↑/↓ to choose, [Enter] to select", h - 50)
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

    local optionCount = #self.options

    if key == "up" then
        self.selection = (self.selection - 2 + optionCount) % optionCount + 1
    elseif key == "down" then
        self.selection = self.selection % optionCount + 1
    elseif key == "return" then
        if self.selection == 1 then
            local enemyList = ({
                [1] = { "internSwarm", "toxicTeammate" },
                [2] = { "printerPoltergeist", "toxicTeammate" },
                [3] = { "slackerZombie", "coffeeGremlin" },
                [4] = { "micromanageDragon", "meetingMummy" },
                [5] = { "meetingMummy", "deadlineDemon" },
                [6] = { "itGremlin", "budgetBanshee" },
                [7] = { "policyPhantom", "overtimeOgre" },
                [8] = { "calendarWitch", "overtimeOgre" },
                [9] = { "gaslightGhoul", "policyPhantom" },
                [10] = { "burnoutBot", "coffeeGremlin", "micromanageDragon" },
                [11] = { "middleManagerMinotaur", "slackerZombie", "slackerZombie", "slackerZombie" },
                [12] = { "hrReaper", "toxicTeammate", "budgetBanshee", "budgetBanshee", "calendarWitch" },
                [13] = { "feedbackFiend", "meetingMummy", "coffeeGremlin" },
                [14] = { "meetingMummy", "toxicTeammate", "hrReaper", "middleManagerMinotaur", "ceoOfDoom" }
            })[self.stage] or { "ceoOfDoom" }

            print("🧠 Starting battle for stage", self.stage, "with enemies:", table.concat(enemyList, ", "))
            gameState.currentStage = self.stage + 1
            gameState:switch("battle", enemyList)
        elseif self.selection == 2 then
            print("🧠 Going to shop from map")
            gameState:switch("shop")
        elseif self.selection == 3 then
            print("📊 Viewing player stats")
            gameState:switch("stats")
        end
    end
end

return map
