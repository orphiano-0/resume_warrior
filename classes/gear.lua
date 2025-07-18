local gear = {}

local gearData = {
    ["Coffee Mug"] = {
        cost = 10,
        effect = { maxHp = 5 },
        description = "Increases max HP by 5"
    },
    ["Briefcase"] = {
        cost = 15,
        effect = { damageBoost = 1 },
        description = "Increases damage by 1"
    },
    ["Ergonomic Chair"] = {
        cost = 20,
        effect = { hpRegen = 2 },
        description = "Regenerates 2 HP per turn"
    }
}

function gear.create(name)
    local data = gearData[name]
    if not data then
        print("❌ Error: Gear not found: " .. tostring(name))
        return nil
    end
    local gear = {
        name = name,
        cost = data.cost,
        effect = data.effect,
        description = data.description
    }
    setmetatable(gear, { __index = gear })
    print("🧠 Created gear: " .. name)
    return gear
end

function gear:applyEffect(player)
    if not player then
        print("❌ Error: No player provided to apply gear effect: " .. self.name)
        return
    end
    if self.effect.maxHp then
        player.maxHp = player.maxHp + self.effect.maxHp
        player.hp = math.min(player.hp, player.maxHp)
        print("🧠 Applied gear effect: " .. self.name .. ", max HP +" .. self.effect.maxHp)
    end
    if self.effect.damageBoost then
        player.buffs = player.buffs or { damageBoost = 0, turnsRemaining = 0 }
        player.buffs.damageBoost = player.buffs.damageBoost + self.effect.damageBoost
        print("🧠 Applied gear effect: " .. self.name .. ", damage boost +" .. self.effect.damageBoost)
    end
    if self.effect.hpRegen then
        print("🧠 Registered gear effect: " .. self.name .. ", HP regen +" .. self.effect.hpRegen .. " per turn")
    end
end

function gear:getDescription()
    return self.description
end

function gear.exists(name)
    return gearData[name] ~= nil
end

return gear
