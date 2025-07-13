local Player = {}

function Player.create(career, stats)
    local obj = {
        name = "Unnamed",
        stats = stats or {
            intelligence = 0,
            communication = 0,
            experience = 0,
            stress = 0
        },
        totalPoints = 10,
        career = career or "Undecided"
    }
    setmetatable(obj, Player)
    Player.__index = Player
    return obj
end

return Player
