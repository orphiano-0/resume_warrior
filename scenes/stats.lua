local stats = {}
local gameState


function stats:load()
    if not gameState then
        local ok, gs = pcall(require, "gameState")
        if ok then
            gameState = gs
        else
            print("❌ Failed to load gameState in stats.lua")
        end
    end
    self.font = love.graphics.newFont("assets/fonts/pixel.ttf", 12)
    self.bg = love.graphics.newImage("assets/images/background/bright_background.png")
end

function stats:draw()
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.draw(self.bg, 0, 0, 0, w / self.bg:getWidth(), h / self.bg:getHeight())
    love.graphics.setFont(self.font)

    local y = 30
    local sectionSpacing = 15
    local boxWidth = 360
    local boxX = (w - boxWidth) / 2
    local padding = 12
    local lineHeight = 18

    --- Draw a styled box with title and content
    local function drawBox(title, contentLines, boxColor)
        local boxHeight = (#contentLines + 1) * lineHeight + padding * 2
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", boxX, y, boxWidth, boxHeight, 10, 10)

        love.graphics.setColor(unpack(boxColor or { 1, 1, 1 }))
        love.graphics.printf(title, boxX, y + 8, boxWidth, "center")

        love.graphics.setColor(1, 1, 1)
        for i, line in ipairs(contentLines) do
            love.graphics.print(line, boxX + padding, y + padding + (i * lineHeight))
        end

        y = y + boxHeight + sectionSpacing
    end

    local p = gameState.player or {}

    drawBox("📊 PLAYER STATS", {
        "Name: " .. (p.name or "N/A"),
        "Career: " .. (p.career or "N/A"),
        "Level: " .. (p.level or 1),
        "XP: " .. (p.xp or 0) .. "/" .. (p.xpToNext or 0),
        "HP: " .. (p.hp or 0) .. "/" .. (p.maxHp or 0),
        "Currency: $" .. (p.currency or 0),
        "Experience: " .. ((p.stats and p.stats.experience) or 0),
        "Intelligence: " .. ((p.stats and p.stats.intelligence) or 0),
        "Charisma: " .. ((p.stats and p.stats.charisma) or 0)
    }, { 1, 0.85, 0.3 }) -- yellow

    local gearContent = {}
    for slot, item in pairs(p.gear or {}) do
        table.insert(gearContent, slot .. ": " .. item.name)
    end
    drawBox("🛡️ EQUIPPED GEAR", #gearContent > 0 and gearContent or { "None" }, { 0.3, 0.7, 1 }) -- blue

    local skillContent = {}
    for _, skill in ipairs(p.skills or {}) do
        table.insert(skillContent, "- " .. skill.name)
    end
    drawBox("🔥 SKILLS", #skillContent > 0 and skillContent or { "None" }, { 1, 0.4, 0.4 }) -- red

    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, h - 30, w, 30)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Press [Backspace] to return", 0, h - 25, w, "center")
end

function stats:keypressed(key)
    if key == "backspace" then
        print("↩️ Returning to map")
        gameState:switch("map")
    end
end

return stats
