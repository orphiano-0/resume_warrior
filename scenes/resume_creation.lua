local resume = {}

local Player = require("classes.player")

function resume:load()
    self.player = Player:new()
    self.selected = 1
    self.statsOrder = { "intelligence", "communication", "experience", "stress" }
    self.careerPaths = { "Tech Bro", "Marketing Diva", "Freelance Wizard" }
    self.selectedCareer = 1
end

function resume:update(dt) end

function resume:draw()
    love.graphics.printf("📄 Resume Builder", 0, 40, love.graphics.getWidth(), "center")

    love.graphics.printf("Total Points Remaining: " .. self.player.totalPoints, 0, 100, love.graphics.getWidth(),
        "center")

    -- Draw stat options
    for i, stat in ipairs(self.statsOrder) do
        local y = 150 + i * 30
        local arrow = (i == self.selected) and "➤ " or "   "
        love.graphics.printf(
            arrow .. stat:sub(1, 1):upper() .. stat:sub(2) .. ": " .. self.player.stats[stat],
            0, y, love.graphics.getWidth(), "center"
        )
    end

    -- Career choice
    love.graphics.printf("Career Path: [" .. self.careerPaths[self.selectedCareer] .. "]", 0, 320,
        love.graphics.getWidth(), "center")

    love.graphics.printf("↑/↓: Navigate   ←/→: Adjust Stat   [Tab]: Change Career   [Enter]: Confirm", 0, 400,
        love.graphics.getWidth(), "center")
end

function resume:keypressed(key)
    if key == "up" then
        self.selected = self.selected - 1
        if self.selected < 1 then self.selected = #self.statsOrder end
    elseif key == "down" then
        self.selected = self.selected + 1
        if self.selected > #self.statsOrder then self.selected = 1 end
    elseif key == "right" then
        local stat = self.statsOrder[self.selected]
        if self.player.totalPoints > 0 then
            self.player.stats[stat] = self.player.stats[stat] + 1
            self.player.totalPoints = self.player.totalPoints - 1
        end
    elseif key == "left" then
        local stat = self.statsOrder[self.selected]
        if self.player.stats[stat] > 0 then
            self.player.stats[stat] = self.player.stats[stat] - 1
            self.player.totalPoints = self.player.totalPoints + 1
        end
    elseif key == "tab" then
        self.selectedCareer = self.selectedCareer + 1
        if self.selectedCareer > #self.careerPaths then self.selectedCareer = 1 end
    elseif key == "return" then
        self.player.career = self.careerPaths[self.selectedCareer]
        print("Resume Complete!")
        print("Stats:", self.player.stats.intelligence, self.player.stats.communication,
            self.player.stats.experience, self.player.stats.stress)
        print("Career:", self.player.career)
        if self.onComplete then
            self.onComplete(self.player)
        end
    end
end

return resume
