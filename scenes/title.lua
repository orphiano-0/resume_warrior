local title = {}
local gameState = require("gameState")

function title:load()
    print("🧠 Loading title scene")
    self.titleImage = love.graphics.newImage("assets/images/background/welcome.png")
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
end

function title:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.titleImage, 0, 0, 0, w / self.titleImage:getWidth(), h / self.titleImage:getHeight())
    love.graphics.setFont(self.font)
    love.graphics.printf("Press [Enter] to start", 0, h - 50, w, "center")
end

function title:keypressed(key)
    if key == "return" then
        print("🧠 Title: Switching to menu")
        gameState:switch("menu")
    end
end

return title
