local skills = require("classes.skills")
local enemies = {
    ["internSwarm"] = {
        name = "Intern Swarm",
        hp = 15,
        maxHp = 15,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Coffee Sabotage"] }
    },
    ["hrKaren"] = {
        name = "Karen of HR",
        hp = 25,
        maxHp = 25,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Burnout"], skills.enemySkills["Team Reorg"] }
    },
    ["micromanageDragon"] = {
        name = "Micromanage Dragon",
        hp = 40,
        maxHp = 40,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Corporate Rant"], skills.enemySkills["Emergency Meeting"] }
    },
    ["deadlineDemon"] = {
        name = "Deadline Demon",
        hp = 50,
        maxHp = 50,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Overtime"], skills.enemySkills["Team Reorg"] }
    },
    ["overtimeOgre"] = {
        name = "Overtime Ogre",
        hp = 60,
        maxHp = 60,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Overtime"], skills.enemySkills["Corporate Rant"] }
    },
    ["selfdoubtSpecter"] = {
        name = "Self-Doubt Specter",
        hp = 70,
        maxHp = 70,
        skills = { skills.enemySkills["Coffee Sabotage"], skills.enemySkills["Burnout"], skills.enemySkills["Emergency Meeting"] }
    },
    ["gaslightGhoul"] = {
        name = "Gaslight Ghoul",
        hp = 80,
        maxHp = 80,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Coffee Sabotage"], skills.enemySkills["Team Reorg"] }
    },
    ["hrReaper"] = {
        name = "HR Reaper",
        hp = 90,
        maxHp = 90,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Burnout"], skills.enemySkills["Corporate Rant"] }
    },
    ["ceoOfDoom"] = {
        name = "CEO of Doom",
        hp = 100,
        maxHp = 100,
        skills = { skills.enemySkills["Paperwork Pile"], skills.enemySkills["Team Reorg"], skills.enemySkills["Emergency Meeting"] }
    },
    ["ceoOfChaos"] = {
        name = "CEO of Chaos",
        hp = 100,
        maxHp = 100,
        skills = { skills.enemySkills["Micromanage"], skills.enemySkills["Corporate Rant"], skills.enemySkills["Overtime"] }
    }
}

return enemies
