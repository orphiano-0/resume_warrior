local skills = {}

skills.playerSkills = {
    ["Excel Slam"] = {
        name = "Excel Slam",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(4, 6)
            target.hp = target.hp - damage
            return "slammed with Excel for " .. damage .. " damage!"
        end
    },
    ["Buzzword Barrage"] = {
        name = "Buzzword Barrage",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(3, 7)
            target.hp = target.hp - damage
            return "unleashed buzzwords for " .. damage .. " damage!"
        end
    },
    ["Coffee Break"] = {
        name = "Coffee Break",
        type = "heal",
        cooldown = 2,
        action = function(attacker, target)
            local heal = math.random(5, 10)
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
            return "flexed on LinkedIn, boosting damage!"
        end
    },
    ["PowerPoint Punch"] = {
        name = "PowerPoint Punch",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(5, 8)
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
            target.statusEffects = target.statusEffects or
            { burnout = 0, overworked = 0, selfdoubt = 0 }                                                -- Ensure statusEffects exists
            target.statusEffects.overworked = 3
            return "pulled an All-Nighter, healed 10 HP but got overworked!"
        end
    },
    ["Mindfulness"] = {
        name = "Mindfulness",
        type = "heal",
        cooldown = 4,
        action = function(attacker, target)
            target.hp = math.min(target.hp + 15, target.maxHp)
            target.statusEffects = target.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }
            target.statusEffects.burnout = 0
            target.statusEffects.overworked = 0
            target.statusEffects.selfdoubt = 0
            return "practiced mindfulness, healed 15 HP and cleared status effects!"
        end
    },
    ["Buzzword Barrage+"] = {
        name = "Buzzword Barrage+",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(5, 9)
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
            return "focused like an executive, greatly boosting damage!"
        end
    },
    ["Corporate Clutch"] = {
        name = "Corporate Clutch",
        type = "heal",
        cooldown = 5,
        action = function(attacker, target)
            target.hp = math.min(target.hp + 20, target.maxHp)
            return "clutched it corporately, healed 20 HP!"
        end
    }
}

skills.enemySkills = {
    ["Paperwork Pile"] = {
        name = "Paperwork Pile",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(2, 5)
            target.hp = target.hp - damage
            return "threw a pile of paperwork for " .. damage .. " damage!"
        end
    },
    ["Micromanage"] = {
        name = "Micromanage",
        type = "attack",
        action = function(attacker, target)
            local damage = math.random(4, 7)
            target.hp = target.hp - damage
            return "micromanaged for " .. damage .. " damage!"
        end
    },
    ["Burnout"] = {
        name = "Burnout",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }
            target.statusEffects.burnout = 2
            return "inflicted burnout!"
        end
    },
    ["Overtime"] = {
        name = "Overtime",
        type = "status",
        action = function(attacker, target)
            target.statusEffects = target.statusEffects or { burnout = 0, overworked = 0, selfdoubt = 0 }
            target.statusEffects.overworked = 3
            return "demanded overtime, causing overwork!"
        end
    }
}

return skills
