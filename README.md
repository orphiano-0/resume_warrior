# 💾 Resume Warrior: Career Mode – Project Documentation

## 🗭 Game Overview

**Title**: Resume Warrior: Career Mode
**Genre**: Witty Turn-Based Roguelike RPG
**Engine**: Love2D (Lua)
**Goal**: Climb the corporate ladder by battling absurd workplace enemies using skills from your resume. Build your character through “job experience,” collect “gear,” and defeat the CEO of Chaos to land your dream job.

---

## 🎮 Game Loop Flow

1. **Start Screen**
2. **Resume Creation** (Character Creation)
3. **Career Map** (Linear/Branching Path)

   - Battle (Turn-Based)
   - Event (Random: Party, Office Drama, etc.)
   - Shop (LinkedIn Perks Store)

4. **Boss Fights** (Karen of HR → PowerPoint Golem → CEO of Chaos)
5. **End Game** (Offer Letter or Corporate Exile)

---

## 🗂️ File Structure (Recommended Lua Modules)

```
main.lua                     -- Entry point
gameState.lua                -- Manages game state (menu, battle, map, etc.)
scenes/
  menu.lua                   -- Start / Resume / Quit
  resume_creation.lua        -- Character stat allocation
  battle.lua                 -- Turn-based battle logic
  map.lua                    -- Career progression
  ending.lua                 -- Victory / Defeat
classes/
  player.lua                 -- Player class (stats, skills, inventory)
  enemy.lua                  -- Enemy class (AI, attacks)
  skill.lua                  -- Skill definitions
  gear.lua                   -- Equipment handling
  dialoguebox.lua            -- Witty combat texts
assets/
  fonts/, images/, sounds/   -- Art & audio assets
```

---

## 📟 Storyboard

### 🎮 1. Title Screen

- **Options**: New Game, Continue, Exit
- **Background**: Office cubicle with motivational posters like “Push Pixels, Not Paperwork.”

---

### 🧐 2. Resume Creation (Character Creation)

Assign points to build your professional persona:

| Resume Section      | In-Game Stat        |
| ------------------- | ------------------- |
| Education Level     | 💡 Intelligence     |
| Communication Style | 💬 Communication    |
| Work Experience     | 💼 Experience       |
| Stress Handling     | 🧘 Stress Tolerance |

- Choose a **Career Path** (Tech Bro, Marketing Diva, Freelance Wizard) for a unique starting skill and passive bonus.

---

### 🗺️ 3. Career Map (Progression)

- Slay-the-Spire-style node system:
  **Battle → Event → Shop**
- Ascend the corporate tower floor by floor.

---

### ⚔️ 4. Battle System (Core Loop)

- **Turn-Based Combat**:

  - Resume Skills (attacks, buffs, heals)
  - Items (e.g., Coffee, Gossip)
  - Special Move (once per battle)

- **UI Elements**:

  - Witty status messages
  - Animated effects (Burnout, Self-Doubt, Overworked)

---

### 💬 5. Random Events

- **Office Party**: Dance mini-game
- **Passive-Aggressive Email**: Changes stats
- **Team Building**: Dialogue choice that influences future combat

---

### 🛙️ 6. LinkedIn Shop

Spend **Exposure Points** on:

#### Gear:

- _Coffee Mug_: +5 Max HP
- _Briefcase_: +1 Damage
- _Ergonomic Chair_: +2 HP/turn regen
- _Energy Bar_: +10 HP
- _Motivational Poster_: +2 Damage for limited turns
- _Standing Desk_: +3 HP Regen, +3 Max HP

#### Skills:

- _Excel Slam_, _LinkedIn Flex_, _Team Huddle_, etc.

---

### 💀 7. Enemy Tiers

#### 🟢 Tier 1: Minor Nuisances (50–80 HP)

- Intern Swarm
- Coffee Gremlin
- Printer Poltergeist
- Toxic Teammate

#### 🟡 Tier 2: Office Trolls (85–140 HP)

- Slacker Zombie
- Micromanage Dragon
- Meeting Mummy
- Deadline Demon
- IT Gremlin
- Budget Banshee
- Policy Phantom
- Overtime Ogre

#### 🟠 Tier 3: Mid-Level Menaces (155–220 HP)

- Calendar Witch
- Gaslight Ghoul
- Burnout Bot
- Middle Manager Minotaur

#### 🔴 Tier 4: Final Bosses (230–400 HP)

- HR Reaper
- Feedback Fiend
- CEO of Doom

---

### 💼 8. Skills

#### 🧠 Player Skills

- **Excel Slam**, **Buzzword Barrage**, **Coffee Break**, **LinkedIn Flex**
- **PowerPoint Punch**, **All-Nighter**, **Mindfulness**
- **Buzzword Barrage+**, **Executive Focus**, **Corporate Clutch**, **Team Huddle**

#### 🔫 Enemy Skills

- **Paperwork Pile**, **Micromanage**, **Burnout**, **Overtime**, **Coffee Sabotage**
- **Team Reorg**, **Corporate Rant**, **Emergency Meeting**, **Red Tape Wrap**
- **IT Delay**, **Metrics Mayhem**, **Budget Cut**, **Toxic Feedback**
- **Passive Aggression**, **Meeting Spiral**, **Reorg Confusion**, **Office Gossip**
- **Deadline Panic**

---

### 🎉 9. Endings

| Outcome                | Condition                          |
| ---------------------- | ---------------------------------- |
| 💼 Dream Job Secured   | Beat all bosses                    |
| 📟 Back to Freelancing | Fail KPIs / lose final battle      |
| 🏢 You Are Now the CEO | Secret ending via hostile takeover |
