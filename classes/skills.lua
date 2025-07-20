local skills = {}

skills.playerSkills = {
    ["Excel Slam"] = {
        name = "Excel Slam",
        type = "attack",
        action = function(attacker, target)
            local baseDamage = math.random(4, 6)
            local damage = baseDamage + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "slammed with Excel for " .. damage .. " damage!"
        end
    },
    ["Buzzword Barrage"] = {
        name = "Buzzword Barrage",
        type = "attack",
        action = function(attacker, target)
            local baseDamage = math.random(3, 7)
            local damage = baseDamage + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "unleashed buzzwords for " .. damage .. " damage!"
        end
    },
    ["Coffee Break"] = {
        name = "Coffee Break",
        type = "heal",
        cooldown = 1,
        action = function(attacker, target)
            local heal = math.random(4, 7)
            attacker.hp = math.min(attacker.hp + heal, attacker.maxHp)
            return "took a coffee break, healed " .. heal .. " HP!"
        end
    },
    ["LinkedIn Flex"] = {
        name = "LinkedIn Flex",
        type = "buff",
        cooldown = 3,
        action = function(attacker, target)
            attacker.buffs = attacker.buffs or { damageBoost = 0, turnsRemaining = 0 }
            attacker.buffs.damageBoost = attacker.buffs.damageBoost + 2
            attacker.buffs.turnsRemaining = 3
            return "flexed on LinkedIn, boosting damage by 2 for 3 turns!"
        end
    },
    ["PowerPoint Punch"] = {
        name = "PowerPoint Punch",
        type = "attack",
        action = function(attacker, target)
            local baseDamage = math.random(5, 8)
            local damage = baseDamage + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "punched with PowerPoint for " .. damage .. " damage!"
        end
    },
    ["All-Nighter"] = {
        name = "All-Nighter",
        type = "heal",
        cooldown = 3,
        action = function(attacker, target)
            target.hp = math.min(target.hp + 10, target.maxHp)
            target.statusEffects = target.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }
            target.statusEffects.overworked = 4
            return "pulled an All-Nighter, healed 10 HP but got overworked!"
        end
    },
    ["Mindfulness"] = {
        name = "Mindfulness",
        type = "heal",
        cooldown = 3,
        action = function(attacker, target)
            target.hp = math.min(target.hp + 10, target.maxHp)
            target.statusEffects = { burnout = 0, overworked = 0, selfdoubt = 0 }
            return "practiced mindfulness, healed 10 HP and cleared status effects!"
        end
    },
    ["Buzzword Barrage+"] = {
        name = "Buzzword Barrage+",
        type = "attack",
        action = function(attacker, target)
            local baseDamage = math.random(6, 10)
            local damage = baseDamage + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "unleashed enhanced buzzwords for " .. damage .. " damage!"
        end
    },
    ["Executive Focus"] = {
        name = "Executive Focus",
        type = "buff",
        cooldown = 4,
        action = function(attacker, target)
            attacker.buffs = attacker.buffs or { damageBoost = 0, turnsRemaining = 0 }
            attacker.buffs.damageBoost = attacker.buffs.damageBoost + 3
            attacker.buffs.turnsRemaining = 4
            return "focused like an executive, boosting damage by 3 for 4 turns!"
        end
    },
    ["Corporate Clutch"] = {
        name = "Corporate Clutch",
        type = "heal",
        cooldown = 4,
        action = function(attacker, target)
            target.hp = math.min(target.hp + 15, target.maxHp)
            return "clutched it corporately, healed 15 HP!"
        end
    },
    ["Team Huddle"] = {
        name = "Team Huddle",
        type = "buff",
        cooldown = 4,
        action = function(attacker, target)
            attacker.statusEffects = { burnout = 0, overworked = 0, selfdoubt = 0 }
            return "called a team huddle, cleared all status effects!"
        end
    }
}

skills.enemySkills = {
    ["Paperwork Pile"] = {
        name = "Paperwork Pile",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(2, 5) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "threw a pile of paperwork for " .. damage .. " damage!"
        end
    },
    ["Micromanage"] = {
        name = "Micromanage",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(3, 6) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "micromanaged for " .. damage .. " damage!"
        end
    },
    ["Burnout"] = {
        name = "Burnout",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.burnout = 1
            return "inflicted burnout, preventing attacks for 2 turns!"
        end
    },
    ["Overtime"] = {
        name = "Overtime",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.overworked = 3
            return "demanded overtime, causing overwork for 3 turns!"
        end
    },
    ["Coffee Sabotage"] = {
        name = "Coffee Sabotage",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.selfdoubt = 3
            return "sabotaged your coffee, causing self-doubt for 3 turns!"
        end
    },
    ["Team Reorg"] = {
        name = "Team Reorg",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(3, 6) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.burnout = 1
            return "reorganized the team, dealing " .. damage .. " damage and inflicting burnout!"
        end
    },
    ["Corporate Rant"] = {
        name = "Corporate Rant",
        type = "buff",
        cooldown = 3,
        action = function(attacker, target)
            attacker.buffs = attacker.buffs or { damageBoost = 0, turnsRemaining = 0 }
            attacker.buffs.damageBoost = attacker.buffs.damageBoost + 2
            attacker.buffs.turnsRemaining = 3
            return "ranted corporately, boosting damage by 2 for 3 turns!"
        end
    },
    ["Emergency Meeting"] = {
        name = "Emergency Meeting",
        type = "heal",
        cooldown = 3,
        action = function(attacker, target)
            local heal = math.random(3, 6)
            attacker.hp = math.min(attacker.hp + heal, attacker.maxHp)
            return "called an emergency meeting, healed " .. heal .. " HP!"
        end
    },
    ["Passive Aggression"] = {
        name = "Passive Aggression",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.selfdoubt = 2
            return "used passive aggression, planting self-doubt for 2 turns!"
        end
    },
    ["Red Tape Wrap"] = {
        name = "Red Tape Wrap",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(4, 6) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "wrapped you in red tape for " .. damage .. " damage!"
        end
    },
    ["IT Delay"] = {
        name = "IT Delay",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.overworked = 2
            return "triggered IT delays, causing overwork for 2 turns!"
        end
    },
    ["Metrics Mayhem"] = {
        name = "Metrics Mayhem",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(4, 7) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "unleashed metric chaos for " .. damage .. " damage!"
        end
    },
    ["Budget Cut"] = {
        name = "Budget Cut",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(3, 5) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.burnout = 1
            return "sliced the budget, dealing " .. damage .. " damage and causing burnout!"
        end
    },
    ["Toxic Feedback"] = {
        name = "Toxic Feedback",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.selfdoubt = 3
            return "gave toxic feedback, inflicting self-doubt for 3 turns!"
        end
    },
    ["Meeting Spiral"] = {
        name = "Meeting Spiral",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(3, 6) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.overworked = 2
            return "dragged you into a meeting spiral for " .. damage .. " damage and overwork!"
        end
    },
    ["Reorg Confusion"] = {
        name = "Reorg Confusion",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.selfdoubt = 2
            target.statusEffects.overworked = 1
            return "caused reorganization confusion, applying multiple status effects!"
        end
    },
    ["Office Gossip"] = {
        name = "Office Gossip",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(3, 6) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            return "spread office gossip for " .. damage .. " emotional damage!"
        end
    },
    ["Deadline Panic"] = {
        name = "Deadline Panic",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(6, 9) + (attacker.buffs and attacker.buffs.damageBoost or 0)
            target.hp = target.hp - damage
            target.statusEffects = target.statusEffects or {}
            target.statusEffects.burnout = 1
            return "triggered deadline panic! " .. damage .. " damage and burnout for 1 turn!"
        end
    }
}

return skills
