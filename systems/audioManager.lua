local audioManager = {}

audioManager.sounds = {
    attack = love.audio.newSource("assets/sounds/attack.mp3", "static"),
    heal = love.audio.newSource("assets/sounds/heal.mp3", "static")
}

function audioManager.play(soundKey)
    local sound = audioManager.sounds[soundKey]
    if sound then sound:play() end
end

return audioManager
