local dialogueBox = {}

-- Dialogue lines by skill name (shared by all enemies)
dialogueBox.enemyDialogue = {
    ["Paperwork Pile"] = {
        "A tidal wave of forms crashes toward you!",
        "Loose sheets scatter everywhere as they attack!"
    },
    ["Micromanage"] = {
        "They micromanage every breath you take!",
        "You feel suffocated by the constant nitpicking!"
    },
    ["Burnout"] = {
        "They drop work on you at 5:01 PM sharp!",
        "You're drowning in mental exhaustion!"
    },
    ["Overtime"] = {
        "No weekends for you! It's overtime again!",
        "You’re roped into another late-night grind!"
    },
    ["Coffee Sabotage"] = {
        "They tamper with your caffeine source!",
        "That wasn't your usual brew… was it?"
    },
    ["Team Reorg"] = {
        "You’re reassigned mid-project without notice!",
        "Another reorg? You lose your momentum!"
    },
    ["Corporate Rant"] = {
        "They rant about KPIs and quarterly synergy!",
        "An exhausting speech saps your focus!"
    },
    ["Emergency Meeting"] = {
        "An emergency meeting heals their resolve!",
        "They regroup with their team mid-battle!"
    }
}

dialogueBox.playerDialogue = {
    ["Excel Slam"] = {
        "You swing your spreadsheet like a sword!",
        "Rows and columns fly into your enemy's face!"
    },
    ["Buzzword Barrage"] = {
        "You unleash a flurry of meaningless jargon!",
        "\"Synergy! Pivot! Paradigm!\""
    },
    ["Coffee Break"] = {
        "You sip some sweet caffeine. Ahh!",
        "You feel your spirit perk up after a break!"
    },
    ["LinkedIn Flex"] = {
        "You flex your endorsements and online presence!",
        "You flash your latest connections with flair!"
    }
}

return dialogueBox
