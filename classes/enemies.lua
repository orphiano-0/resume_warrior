local skills = require("classes.skills")
local enemies = {
    ["internSwarm"] = {
        name = "Intern Swarm",
        hp = 15,
        maxHp = 15,
        skills = { skills.enemySkills["Paperwork Pile"] }
    },
    ["hrKaren"] = {
        name = "Karen of HR",
        hp = 25,
        maxHp = 25,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Burnout"] }
    },
    ["micromanageDragon"] = {
        name = "Micromanage Dragon",
        hp = 40,
        maxHp = 40,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Overtime"] }
    },
    ["deadlineDemon"] = {
        name = "Deadline Demon",
        hp = 50,
        maxHp = 50,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Burnout"] }
    },
    ["overtimeOgre"] = {
        name = "Overtime Ogre",
        hp = 60,
        maxHp = 60,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Overtime"] }
    },
    ["selfdoubtSpecter"] = {
        name = "Self-Doubt Specter",
        hp = 70,
        maxHp = 70,
        skills = { skills.enemySkills["Burnout"], skills.enemySkills["Overtime"] }
    },
    ["gaslightGhoul"] = {
        name = "Gaslight Ghoul",
        hp = 80,
        maxHp = 80,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Burnout"] }
    },
    ["hrReaper"] = {
        name = "HR Reaper",
        hp = 90,
        maxHp = 90,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Overtime"] }
    },
    ["ceoOfDoom"] = {
        name = "CEO of Doom",
        hp = 100,
        maxHp = 100,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Burnout"], skills.enemySkills["Overtime"] }
    },
    ["ceoOfChaos"] = {
        name = "CEO of Chaos",
        hp = 100,
        maxHp = 100,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Burnout"], skills.enemySkills["Overtime"] }
    }
}

return enemies
