local uiRenderer = {}

function uiRenderer.drawHealthBar(x, y, width, height, current, max, color)
    local ratio = math.max(tonumber(current) or 0, 0) / (tonumber(max) or 1)
    ratio = math.min(ratio, 1)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", x, y, width, height)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, width * ratio, height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, width, height)
end

return uiRenderer
