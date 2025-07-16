local gameState = require("gameState")

local function safeLoad(loaderFunc, path, description)
    local ok, result = pcall(loaderFunc, path)
    if ok then
        print("✅ Loaded " .. description .. ": " .. path)
        return result
    else
        print("❌ Failed to load " .. description .. ": " .. tostring(result))
        return nil
    end
end

function love.load()
    print("🧠 Game started, logging to console.log")
    love.window.setTitle("Resume Warrior: Career Mode")

    local icon = safeLoad(love.image.newImageData, "assets/images/logo/logo.png", "window icon")
    if icon then love.window.setIcon(icon) end

    local font = safeLoad(function(p) return love.graphics.newFont(p, 12) end, "assets/fonts/pixel.ttf", "font")
    if font then love.graphics.setFont(font) end

    -- Load and play background music
    local bgMusic = safeLoad(function(p) return love.audio.newSource(p, "stream") end, "assets/sounds/theme_song.mp3",
        "background music")
    if bgMusic then
        bgMusic:setLooping(true)
        bgMusic:setVolume(0.5)
        bgMusic:play()
        print("🎵 Background music started")
    end

    gameState:load()
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()
end

function love.keypressed(key)
    gameState:keypressed(key)
end

function love.mousepressed(x, y, button)
    gameState:mousepressed(x, y, button)
end
