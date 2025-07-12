local skills = require("classes.skills")

local enemies = {}

enemies.internSwarm = {
    name = "Intern Swarm",
    hp = 15,
    maxHp = 15,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Office Gossip"],
        skills.enemySkills["Late Report"]
    }
}

enemies.hrKaren = {
    name = "Karen of HR",
    hp = 25,
    maxHp = 25,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Office Gossip"],
    }
}

enemies.micromanageDragon = {
    name = "Micromanage Dragon 🐉",
    hp = 40,
    maxHp = 40,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Late Report"],
        skills.enemySkills["Office Gossip"],
        skills.enemySkills["Stock Buyback"],
    }
}

enemies.ceoOfChaos = {
    name = "CEO of Chaos",
    hp = 60,
    maxHp = 60,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Late Report"],
        skills.enemySkills["Office Gossip"],
        skills.enemySkills["Gaslighting"],
        skills.enemySkills["Stock Buyback"],
    }
}

return enemies
