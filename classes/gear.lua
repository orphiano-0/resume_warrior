local gear = {}
gear.methods = {} -- 👈 holds methods for all gear items

local gearData = {
    ["Coffee Mug"] = {
        cost = 10,
        effect = { maxHp = 5 },
        description = "Increases max HP by 5",
        category = "Healing"
    },
    ["Briefcase"] = {
        cost = 15,
        effect = { damageBoost = 1 },
        description = "Increases damage by 1",
        category = "Power-Up"
    },
    ["Ergonomic Chair"] = {
        cost = 20,
        effect = { hpRegen = 2 },
        description = "Regenerates 2 HP per turn",
        category = "Status Effect"
    },
    ["Energy Bar"] = {
        cost = 8,
        effect = { heal = 10 },
        description = "Restores 10 HP instantly",
        category = "Healing"
    },
    ["Motivational Poster"] = {
        cost = 25,
        effect = { damageBoost = 2 },
        description = "Boosts damage by 2 for a few turns",
        category = "Power-Up"
    },
    ["Standing Desk"] = {
        cost = 30,
        effect = { hpRegen = 3, maxHp = 3 },
        description = "Boosts HP Regen and Max HP",
        category = "Status Effect"
    }
}

function gear.create(name)
    local data = gearData[name]
    if not data then
        print("❌ Error: Gear not found: " .. tostring(name))
        return nil
    end
    local g = {
        name = name,
        cost = data.cost,
        effect = data.effect,
        description = data.description,
        category = data.category
    }
    setmetatable(g, { __index = gear.methods }) -- ✅ fixed circular reference
    print("🧠 Created gear: " .. name)
    return g
end

-- Move methods here
function gear.methods:applyEffect(player)
    if not player then
        print("❌ Error: No player provided to apply gear effect: " .. self.name)
        return
    end
    if self.effect.maxHp then
        player.maxHp = player.maxHp + self.effect.maxHp
        player.hp = math.min(player.hp, player.maxHp)
        print("🧠 Applied gear effect: Max HP +" .. self.effect.maxHp)
    end
    if self.effect.damageBoost then
        player.buffs = player.buffs or { damageBoost = 0, turnsRemaining = 0 }
        player.buffs.damageBoost = player.buffs.damageBoost + self.effect.damageBoost
        print("🧠 Applied gear effect: Damage Boost +" .. self.effect.damageBoost)
    end
    if self.effect.hpRegen then
        print("🧠 Registered HP Regen +" .. self.effect.hpRegen .. " per turn")
    end
    if self.effect.heal then
        player.hp = math.min(player.maxHp, player.hp + self.effect.heal)
        print("🧠 Healed +" .. self.effect.heal .. " HP")
    end
end

function gear.methods:getDescription()
    return self.description
end

function gear.exists(name)
    return gearData[name] ~= nil
end

return gear
