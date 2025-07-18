local skills = require("classes.skills")
local Player = {}

function Player.create(career, stats)
    local obj = {
        name = career or "Unnamed",
        career = career or "Undecided",
        stats = stats or {
            intelligence = 0,
            communication = 0,
            experience = 0,
            stress = 0
        },
        totalPoints = 10,
        hp = stats and (stats.experience * 5 + stats.intelligence * 2 + 20) or 40,
        maxHp = stats and (stats.experience * 5 + stats.intelligence * 2 + 20) or 40,
        level = 1,
        xp = 0,
        xpToNext = 3,
        currency = 100, -- Starting currency
        gear = {},      -- Store Gear instances
        selectedSkill = 1,
        buffs = { damageBoost = 0, turnsRemaining = 0 },
        statusEffects = { burnout = 0, overworked = 0, selfdoubt = 0 },
        skills = {}
    }
    if career == "Tech Bro" then
        obj.skills = {
            skills.playerSkills["Excel Slam"],
            skills.playerSkills["Buzzword Barrage"],
            skills.playerSkills["Coffee Break"]
        }
    elseif career == "Marketing Diva" then
        obj.skills = {
            skills.playerSkills["Buzzword Barrage"],
            skills.playerSkills["LinkedIn Flex"],
            skills.playerSkills["Coffee Break"]
        }
    elseif career == "Freelance Wizard" then
        obj.skills = {
            skills.playerSkills["Excel Slam"],
            skills.playerSkills["Coffee Break"],
            skills.playerSkills["LinkedIn Flex"]
        }
    end
    print("🧠 Player created: career =", career, "hp =", obj.hp, "currency =", obj.currency)
    setmetatable(obj, { __index = Player })
    return obj
end

return Player
