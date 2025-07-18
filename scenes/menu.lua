local menu = {}
local gameState
local lovefs = love.filesystem

function menu:load()
    print("🧠 Loading menu scene")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.titleImage = love.graphics.newImage("assets/images/background/lobby.png")

    -- Options: label, tag, and disabled flag
    self.options = {
        { label = "Start",    tag = "resume_creation", disabled = false },
        { label = "Continue", tag = "resume",          disabled = not lovefs.getInfo("save.dat") },
        { label = "Quit",     tag = "quit",            disabled = false }
    }

    self.selected = 1
    self:skipDisabled(1) -- Make sure the initial selected is not disabled
end

function menu:skipDisabled(direction)
    local total = #self.options
    for _ = 1, total do
        if not self.options[self.selected].disabled then return end
        self.selected = self.selected + direction
        if self.selected < 1 then self.selected = total end
        if self.selected > total then self.selected = 1 end
    end
end

function menu:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setFont(self.font)
    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())

    -- Title
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.rectangle("fill", 0, h / 4 - 30, w, 60)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Welcome to the Game!", 0, h / 4 - 10, w, "center")

    -- Menu Options
    for i, option in ipairs(self.options) do
        local y = h / 2 + (i - 1) * 30
        if option.disabled then
            love.graphics.setColor(0.5, 0.5, 0.5) -- Gray out
        elseif i == self.selected then
            love.graphics.setColor(1, 1, 0)       -- Highlight
        else
            love.graphics.setColor(1, 1, 1)
        end

        local prefix = (i == self.selected and not option.disabled) and "> " or "  "
        love.graphics.printf(prefix .. option.label, 0, y, w, "center")
    end
end

function menu:keypressed(key)
    if key == "up" then
        repeat
            self.selected = self.selected - 1
            if self.selected < 1 then self.selected = #self.options end
        until not self.options[self.selected].disabled
    elseif key == "down" then
        repeat
            self.selected = self.selected + 1
            if self.selected > #self.options then self.selected = 1 end
        until not self.options[self.selected].disabled
    elseif key == "return" then
        local selectedOption = self.options[self.selected]
        if selectedOption.disabled then return end

        if not gameState then gameState = require("gameState") end

        if selectedOption.tag == "resume_creation" then
            print("🎯 Starting new resume creation")
            gameState:switch("resume")
        elseif selectedOption.tag == "resume" then
            print("🔄 Continuing previous stage")
            gameState:switch("resume")
        elseif selectedOption.tag == "quit" then
            print("👋 Quitting game")
            love.event.quit()
        end
    end
end

return menu
