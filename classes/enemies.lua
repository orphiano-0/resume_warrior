local skills = require("classes.skills")

local enemies = {}

-- === Extra/Optional Enemies ===
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
        skills.enemySkills["Office Gossip"]
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
        skills.enemySkills["Stock Buyback"]
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
        skills.enemySkills["Stock Buyback"]
    }
}

-- === Story Progression Enemies ===
enemies.micromanageDragon = {
    name = "Micromanage Dragon",
    hp = 35,
    maxHp = 35,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Late Report"]
    }
}

enemies.deadlineDemon = {
    name = "Deadline Demon",
    hp = 40,
    maxHp = 40,
    skills = {
        skills.enemySkills["Office Gossip"],
        skills.enemySkills["Late Report"],
        skills.enemySkills["Paper Cut"]
    }
}

enemies.overtimeOgre = {
    name = "Overtime Ogre",
    hp = 50,
    maxHp = 50,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Office Gossip"],
        skills.enemySkills["Burnout"]
    }
}

enemies.selfdoubtSpecter = {
    name = "Self-Doubt Specter",
    hp = 55,
    maxHp = 55,
    skills = {
        skills.enemySkills["Self Doubt"],
        skills.enemySkills["Office Gossip"],
        skills.enemySkills["Late Report"]
    }
}

enemies.gaslightGhoul = {
    name = "Gaslight Ghoul",
    hp = 60,
    maxHp = 60,
    skills = {
        skills.enemySkills["Gaslighting"],
        skills.enemySkills["Stock Buyback"],
        skills.enemySkills["Burnout"]
    }
}

enemies.hrReaper = {
    name = "HR Reaper",
    hp = 70,
    maxHp = 70,
    skills = {
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Self Doubt"],
        skills.enemySkills["Overtime"],
        skills.enemySkills["Late Report"]
    }
}

enemies.ceoOfDoom = {
    name = "CEO of Doom",
    hp = 90,
    maxHp = 90,
    skills = {
        skills.enemySkills["Gaslighting"],
        skills.enemySkills["Paper Cut"],
        skills.enemySkills["Late Report"],
        skills.enemySkills["Burnout"],
        skills.enemySkills["Stock Buyback"]
    }
}

return enemies
