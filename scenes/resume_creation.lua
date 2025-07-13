local resume = {}
local player = require("classes.player")

function resume:load()
    print("🧠 Loading resume creation scene")
    self.career = "Tech Bro"
    self.stats = { experience = 5, intelligence = 5, charisma = 5 }
    self.points = 15
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.selected = 1
    self.careers = { "Tech Bro", "Marketing Diva", "Freelance Wizard" }
    self.statsList = { "experience", "intelligence", "charisma" }
end

function resume:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Create Your Resume", 0, 50, w, "center")
    love.graphics.printf("Career: " .. self.career, 0, 100, w, "center")
    love.graphics.printf("Points remaining: " .. self.points, 0, 150, w, "center")
    for i, stat in ipairs(self.statsList) do
        local value = self.stats[stat]
        local prefix = (i == self.selected) and "> " or "  "
        love.graphics.printf(prefix .. stat .. ": " .. value, 0, 150 + i * 20, w, "center")
    end
    love.graphics.printf("Use ↑/↓ to select, ←/→ to adjust stats, [Enter] to confirm", 0, h - 50, w, "center")
end

function resume:keypressed(key)
    if key == "up" then
        self.selected = (self.selected - 2) % #self.statsList + 1
    elseif key == "down" then
        self.selected = self.selected % #self.statsList + 1
    elseif key == "left" then
        local stat = self.statsList[self.selected]
        if self.stats[stat] > 1 then
            self.stats[stat] = self.stats[stat] - 1
            self.points = self.points + 1
        end
    elseif key == "right" then
        local stat = self.statsList[self.selected]
        if self.points > 0 then
            self.stats[stat] = self.stats[stat] + 1
            self.points = self.points - 1
        end
    elseif key == "return" and self.points == 0 then
        print("🧠 Resume: Creating player with career", self.career, "stats", self.stats.experience,
            self.stats.intelligence, self.stats.charisma)
        local playerData = player.create(self.career, self.stats)
        if self.onComplete then
            self.onComplete(playerData)
        end
    end
end

function resume:mousepressed(x, y, button)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    if y > 100 and y < 130 then
        for i, career in ipairs(self.careers) do
            local width = self.font:getWidth(career)
            local startX = (w - width) / 2
            if x >= startX and x <= startX + width then
                self.career = career
                break
            end
        end
    end
end

return resume
