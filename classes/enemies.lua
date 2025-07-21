local skills = require("classes.skills")

local enemies = {
    -- 🟢 Tier 1 – Minor Nuisances (50–80 HP)
    ["internSwarm"] = {
        name = "Intern Swarm",
        hp = 50,
        maxHp = 50,
        skills = {
            skills.enemySkills["Paperwork Pile"],
            skills.enemySkills["Office Gossip"]
        }
    },
    ["coffeeGremlin"] = {
        name = "Coffee Gremlin",
        hp = 55,
        maxHp = 55,
        skills = {
            skills.enemySkills["Coffee Sabotage"],
            skills.enemySkills["Paperwork Pile"]
        }
    },
    ["printerPoltergeist"] = {
        name = "Printer Poltergeist",
        hp = 60,
        maxHp = 60,
        skills = {
            skills.enemySkills["IT Delay"],
            skills.enemySkills["Paperwork Pile"]
        }
    },
    ["toxicTeammate"] = {
        name = "Toxic Teammate",
        hp = 70,
        maxHp = 70,
        skills = {
            skills.enemySkills["Burnout"],
            skills.enemySkills["Toxic Feedback"],
            skills.enemySkills["Office Gossip"]
        }
    },

    -- 🟡 Tier 2 – Office Trolls (85–140 HP)
    ["slackerZombie"] = {
        name = "Slacker Zombie",
        hp = 85,
        maxHp = 85,
        skills = {
            skills.enemySkills["Passive Aggression"],
            skills.enemySkills["Office Gossip"]
        }
    },
    ["micromanageDragon"] = {
        name = "Micromanage Dragon",
        hp = 90,
        maxHp = 90,
        skills = {
            skills.enemySkills["Micromanage"],
            skills.enemySkills["Corporate Rant"],
            skills.enemySkills["Red Tape Wrap"]
        }
    },
    ["meetingMummy"] = {
        name = "Meeting Mummy",
        hp = 95,
        maxHp = 95,
        skills = {
            skills.enemySkills["Emergency Meeting"],
            skills.enemySkills["Meeting Spiral"],
            skills.enemySkills["IT Delay"]
        }
    },
    ["deadlineDemon"] = {
        name = "Deadline Demon",
        hp = 100,
        maxHp = 100,
        skills = {
            skills.enemySkills["Overtime"],
            skills.enemySkills["Deadline Panic"],
            skills.enemySkills["Burnout"]
        }
    },
    ["itGremlin"] = {
        name = "IT Gremlin",
        hp = 105,
        maxHp = 105,
        skills = {
            skills.enemySkills["IT Delay"],
            skills.enemySkills["Coffee Sabotage"]
        }
    },
    ["budgetBanshee"] = {
        name = "Budget Banshee",
        hp = 115,
        maxHp = 115,
        skills = {
            skills.enemySkills["Team Reorg"],
            skills.enemySkills["Corporate Rant"],
            skills.enemySkills["Budget Cut"]
        }
    },
    ["policyPhantom"] = {
        name = "Policy Phantom",
        hp = 125,
        maxHp = 125,
        skills = {
            skills.enemySkills["Paperwork Pile"],
            skills.enemySkills["Burnout"],
            skills.enemySkills["Red Tape Wrap"]
        }
    },
    ["overtimeOgre"] = {
        name = "Overtime Ogre",
        hp = 140,
        maxHp = 140,
        skills = {
            skills.enemySkills["Micromanage"],
            skills.enemySkills["Overtime"],
            skills.enemySkills["Meeting Spiral"]
        }
    },

    -- 🟠 Tier 3 – Mid-Level Menaces (155–220 HP)
    ["calendarWitch"] = {
        name = "Calendar Witch",
        hp = 155,
        maxHp = 155,
        skills = {
            skills.enemySkills["Emergency Meeting"],
            skills.enemySkills["Meeting Spiral"],
            skills.enemySkills["Metrics Mayhem"]
        }
    },
    ["gaslightGhoul"] = {
        name = "Gaslight Ghoul",
        hp = 170,
        maxHp = 170,
        skills = {
            skills.enemySkills["Coffee Sabotage"],
            skills.enemySkills["Toxic Feedback"],
            skills.enemySkills["Team Reorg"]
        }
    },
    ["burnoutBot"] = {
        name = "Burnout Bot",
        hp = 185,
        maxHp = 185,
        skills = {
            skills.enemySkills["Burnout"],
            skills.enemySkills["Overtime"],
            skills.enemySkills["Deadline Panic"]
        }
    },
    ["middleManagerMinotaur"] = {
        name = "Middle Manager Minotaur",
        hp = 200,
        maxHp = 200,
        skills = {
            skills.enemySkills["Micromanage"],
            skills.enemySkills["Team Reorg"],
            skills.enemySkills["Reorg Confusion"]
        }
    },

    -- 🔴 Tier 4 – Final Bosses (230–300 HP)
    ["hrReaper"] = {
        name = "HR Reaper",
        hp = 230,
        maxHp = 230,
        skills = {
            skills.enemySkills["Corporate Rant"],
            skills.enemySkills["Micromanage"],
            skills.enemySkills["Reorg Confusion"]
        }
    },
    ["feedbackFiend"] = {
        name = "Feedback Fiend",
        hp = 260,
        maxHp = 260,
        skills = {
            skills.enemySkills["Corporate Rant"],
            skills.enemySkills["Toxic Feedback"],
            skills.enemySkills["Deadline Panic"]
        }
    },
    ["ceoOfDoom"] = {
        name = "CEO of Doom",
        hp = 400,
        maxHp = 400,
        skills = {
            skills.enemySkills["Emergency Meeting"],
            skills.enemySkills["Team Reorg"],
            skills.enemySkills["Metrics Mayhem"],
            skills.enemySkills["Coffee Sabotage"],
            skills.enemySkills["Toxic Feedback"],
            skills.enemySkills["Deadline Panic"]
        }
    }
}

return enemies
