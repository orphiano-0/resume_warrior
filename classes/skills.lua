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
            user.hp = math.min(user.hp + 5, user.maxHp)
            return "initiates a Stock Buyback and heals " .. healed .. " HP!"
        end
    }
}

-- Damage calculator (used for buffs)
function skills.calculateDamage(user, base)
    return base + (user.buffs and user.buffs.damageBoost or 0)
end

return skills
