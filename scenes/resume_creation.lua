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
    self.titleImage = love.graphics.newImage("assets/images/background/lobby.png")
end

function resume:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setFont(self.font)
    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())

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

    drawPixelatedBox("Create Your Resume", 50)
    drawPixelatedBox("Career: " .. self.career, 100)
    drawPixelatedBox("Points remaining: " .. self.points, 130)

    for i, stat in ipairs(self.statsList) do
        local value = self.stats[stat]
        local prefix = (i == self.selected) and "> " or "  "
        local text = prefix .. stat .. ": " .. value
        drawPixelatedBox(text, 160 + i * 25)
    end

    drawPixelatedBox("Use ↑/↓ to select, ←/→ to adjust stats, [Enter] to confirm", h - 50)
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
        print("🧠 Resume: Creating player with career", self.career)
        local gameState = require("gameState")
        local playerData = player.create(self.career, self.stats)
        gameState.player = playerData
        gameState:switch("map") -- move to map after creation
    end
end

function resume:mousepressed(x, y, button)
    local w = love.graphics.getWidth()
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
