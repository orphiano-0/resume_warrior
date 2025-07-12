local skills = {}

-- Player Skills
skills.playerSkills = {
    ["Excel Slam"] = {
        name = "Excel Slam",
        type = "attack",
        power = 6,
        cooldown = 4,
        currentCooldown = 0,
        action = function(user, target)
            local dmg = skills.calculateDamage(user, 6)
            target.hp = target.hp - dmg
            return "used Excel Slam for " .. dmg .. " damage!"
        end
    },
    ["Buzzword Barrage"] = {
        name = "Buzzword Barrage",
        type = "multi",
        power = 3,
        hits = 2,
        cooldown = 1,
        currentCooldown = 0,
        action = function(user, target)
            local total = skills.calculateDamage(user, 3) * 2
            target.hp = target.hp - total
            return "used Buzzword Barrage! 2 hits for " .. total .. " damage!"
        end
    },
    ["Coffee Break"] = {
        name = "Coffee Break",
        type = "heal",
        amount = 5,
        cooldown = 2,
        currentCooldown = 0,
        action = function(user)
            user.hp = math.min(user.hp + 5, user.maxHp)
            return "healed 5 HP with Coffee Break!"
        end
    },
    ["LinkedIn Flex"] = {
        name = "LinkedIn Flex",
        type = "buff",
        amount = 2,
        duration = 2,
        cooldown = 2,
        currentCooldown = 0,
        action = function(user)
            user.buffs.damageBoost = 2
            user.buffs.turnsRemaining = 2
            return "used LinkedIn Flex! +2 damage for 2 turns!"
        end
    },
    ["PowerPoint Punch"] = {
        name = "PowerPoint Punch",
        type = "attack",
        power = 8,
        cooldown = 3,
        currentCooldown = 0,
        action = function(user, target)
            local dmg = skills.calculateDamage(user, 8)
            target.hp = target.hp - dmg
            return "used PowerPoint Punch for " .. dmg .. " damage!"
        end
    },
    ["All-Nighter"] = {
        name = "All-Nighter",
        type = "status",
        effect = "burnout",
        cooldown = 3,
        currentCooldown = 0,
        action = function(user, target)
            target.statusEffects.burnout = 1
            target.hp = target.hp - 2
            return "pulled an All-Nighter! Target is burned out and takes 2 damage!"
        end
    },
    ["Mindfulness"] = {
        name = "Mindfulness",
        type = "heal",
        amount = 10,
        cooldown = 3,
        currentCooldown = 0,
        action = function(user)
            user.hp = math.min(user.hp + 10, user.maxHp)
            return "practiced Mindfulness and healed 10 HP!"
        end
    },
    ["Buzzword Barrage+"] = {
        name = "Buzzword Barrage+",
        type = "multi",
        power = 4,
        hits = 3,
        cooldown = 2,
        currentCooldown = 0,
        action = function(user, target)
            local total = skills.calculateDamage(user, 4) * 3
            target.hp = target.hp - total
            return "unleashed Buzzword Barrage+! 3 hits for " .. total .. " damage!"
        end
    },
    ["Executive Focus"] = {
        name = "Executive Focus",
        type = "buff",
        duration = 3,
        cooldown = 4,
        currentCooldown = 0,
        action = function(user)
            user.buffs.damageBoost = 1
            user.buffs.turnsRemaining = 3
            user.statusEffects.overworked = 0
            return "entered Executive Focus! +1 damage and cured overwork!"
        end
    },
    ["Corporate Clutch"] = {
        name = "Corporate Clutch",
        type = "ultimate",
        cooldown = 5,
        currentCooldown = 0,
        action = function(user, target)
            local effects = {
                function()
                    local dmg = skills.calculateDamage(user, 10)
                    target.hp = target.hp - dmg
                    return "landed a surprise deal for " .. dmg .. " damage!"
                end,
                function()
                    local healed = math.min(user.maxHp - user.hp, 8)
                    user.hp = user.hp + healed
                    return "closed a company wellness week! Healed " .. healed .. " HP!"
                end,
                function()
                    user.buffs.damageBoost = 3
                    user.buffs.turnsRemaining = 2
                    return "presented at TEDx! +3 damage boost!"
                end
            }
            local chosen = effects[math.random(#effects)]
            return "used Corporate Clutch: " .. chosen()
        end
    }
}

-- Enemy Skills
skills.enemySkills = {
    ["Paper Cut"] = {
        name = "Paper Cut",
        type = "attack",
        damage = 3,
        action = function(user, target)
            target.hp = target.hp - 3
            return "uses Paper Cut for 3 damage!"
        end
    },
    ["Office Gossip"] = {
        name = "Office Gossip",
        type = "status",
        effect = "burnout",
        duration = 1,
        action = function(user, target)
            target.statusEffects.burnout = 1
            return "spreads Office Gossip! You're burned out!"
        end
    },
    ["Late Report"] = {
        name = "Late Report",
        type = "status",
        effect = "overworked",
        duration = 2,
        action = function(user, target)
            target.statusEffects.overworked = 2
            return "slams you with a Late Report! You're overworked!"
        end
    },
    ["Gaslighting"] = {
        name = "Gaslighting",
        type = "status",
        effect = "selfdoubt",
        damage = 3,
        duration = 2,
        action = function(user, target)
            target.statusEffects.selfdoubt = 2
            return "blames you for being ineffective! You're being gaslighted!"
        end
    },
    ["Stock Buyback"] = {
        name = "Stock Buyback",
        type = "heal",
        amount = 5,
        action = function(user)
            local healed = math.min(user.maxHp - user.hp, 5)
            user.hp = user.hp + healed
            return "initiates a Stock Buyback and heals " .. healed .. " HP!"
        end
    }
}

-- Damage calculator (used for buffs)
function skills.calculateDamage(user, base)
    return base + (user.buffs and user.buffs.damageBoost or 0)
end

return skills
