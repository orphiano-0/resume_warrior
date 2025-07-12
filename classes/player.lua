local Player = {}

function Player:new()
    local obj = {
        name = "Unnamed",
        stats = {
            intelligence = 0,
            communication = 0,
            experience = 0,
            stress = 0
        },
        totalPoints = 10,
        career = "Undecided"

    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return Player
