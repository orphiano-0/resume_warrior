local skills = require("classes.skills")

local playerManager = {}

function playerManager.getDefaultPlayer()
    return {
        name = "You",
        hp = 50,
        maxHp = 50,
        level = 1,
        xp = 0,
        xpToNext = 3,
        selectedSkill = 1,
        buffs = { damageBoost = 0, turnsRemaining = 0 },
        statusEffects = { burnout = 0, overworked = 0, selfdoubt = 0 },
        skills = {
            skills.playerSkills["Excel Slam"],
            skills.playerSkills["Buzzword Barrage"],
            skills.playerSkills["Coffee Break"],
            skills.playerSkills["LinkedIn Flex"]
        }
    }
end

function playerManager.setCareerSkills(player)
    local pSkills = skills.playerSkills
    if player.career == "Tech Bro" then
        player.skills = { pSkills["Excel Slam"], pSkills["Buzzword Barrage"], pSkills["Coffee Break"] }
    elseif player.career == "Marketing Diva" then
        player.skills = { pSkills["Buzzword Barrage"], pSkills["LinkedIn Flex"], pSkills["Coffee Break"] }
    elseif player.career == "Freelance Wizard" then
        player.skills = { pSkills["Excel Slam"], pSkills["Coffee Break"], pSkills["LinkedIn Flex"] }
    end
end

return playerManager
