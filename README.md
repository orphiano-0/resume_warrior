# Resume Warrior: Career Mode - Project Documentation

## 🧭 Game Overview
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
  ui.lua                     -- Shared buttons, health bars, etc.
assets/
  fonts/, images/, sounds/   -- Art & audio assets
```

---

## 🧾 Storyboard

### 🎬 1. Title Screen
- **Options**: New Game, Continue, Exit
- **Background**: Office cubicle with motivational posters like “Push Pixels, Not Paperwork.”

### 🧍 2. Resume Creation (Character Creation)
- Build your resume by assigning points to:
  | Section | In-Game Stat |
  |---------|--------------|
  | Education Level | 💡 Intelligence |
  | Communication Style | 💬 Communication |
  | Work Experience | 💼 Experience |
  | Stress Handling | 🧘 Stress Tolerance |
- Choose a **Career Path** (e.g., Tech Bro, Marketing Diva, Freelance Wizard) for a unique starting skill and passive.

### 🗺️ 3. Career Map (Progression)
- Series of nodes (battle, event, shop).
- Choose paths (Slay the Spire-style).
- Goal: Reach the top floor of the building (C-Suite).

### ⚔️ 4. Battle System (Core Loop)
- **Turn-Based Combat**:
  - Choose from: Resume Skills (Attacks), Items (e.g., Coffee, Office Gossip), Defend, Special Move (once per fight).
- **Combat UI**:
  - Witty combat messages (e.g., “You launched Buzzword Barrage — synergy overload!”).
  - Animated status effects (e.g., “Overworked”, “Burnout”).

### 💬 5. Events (Random Encounters)
- Examples:
  - **Office Party**: Tap-to-dance mini-game.
  - **Team Building Exercise**: Choose dialog.
  - **Passive-Aggressive Email**: Affects stats.

### 🛍️ 6. LinkedIn Shop (Power-Ups)
- Spend **Exposure Points** to buy:
  - Gear (e.g., “Coffee-Stained Tie” = +5 charm).
  - Skills (e.g., “Presentation Slam”).
  - Buffs (e.g., “Overtime Bonus”).

### 🧟‍♂️ 7. Boss Fights
- Each boss has phases and taunts:
  - **Karen of HR**: Forces you to apologize mid-turn.
  - **PowerPoint Golem**: Slides stun you.
  - **CEO of Chaos**: Uses gaslighting, NDA magic, and stock buyback moves.

### 🎉 8. Ending (Based on Performance)
- **Dream Job Secured**: Defeat all bosses.
- **Back to Freelancing**: Lose or fail KPIs.
- **You Are Now the CEO**: Secret ending via "hostile takeover" negotiation.

---

## 🗂️ Project Development Phases

### ✅ Phase 1: Core Foundation
- **Tasks**:
  - `main.lua` setup: Implement `love.load`, `love.update`, `love.draw`.
  - Game state system: Switch between scenes (menu, resume_creation, map, battle, etc.).
  - Asset loader: Preload fonts, images, sounds.
  - Basic UI system: Create reusable buttons, textboxes.
- **Status**: ✅ Complete

### ✅ Phase 2: Resume Creation System
- **Tasks**:
  - Resume screen UI: Stat names, point allocation interface.
  - Point logic: Allow adding/removing with limits (e.g., 10 total points).
  - Career path selection: Grant passive skill (e.g., “Tech Bro” starts with “Debug Bash”).
  - Save resume data: Store stats in Player object for battle use.
- **Status**: 🔄 In Progress

### ✅ Phase 3: Career Map Navigation
- **Tasks**:
  - Node system: Each node = battle, event, or shop.
  - Pathing: Choose next step (Slay the Spire-style branches).
  - Event triggers: Clicking a node triggers event or battle.
  - Floor progression: Progress toward bosses every X nodes.
- **Status**: ⏳ To Do

### ✅ Phase 4: Battle System (Turn-Based Combat)
- **Tasks**:
  - Turn system: Player and enemy alternate turns.
  - UI: Buttons for attack, defend, items, special move.
  - Skills logic: Damage calculation, buffs, debuffs.
  - Status effects: Burnout, Overworked, Coffee Buff, etc.
  - Victory/defeat state: Rewards, loss screen, stress penalty.
- **Status**: ⏳ To Do

### ✅ Phase 5: Enemies and Bosses
- **Tasks**:
  - Basic enemies: Intern Swarm, Karen of HR, PowerPoint Golem.
  - Boss logic: Special phases, custom dialogue, unique abilities.
  - Enemy animations: Optional shaking, blinking, “rage” mode.
  - Enemy flavor text: “Karen uses an HR Violation Slam!” etc.
- **Status**: ⏳ To Do

### ✅ Phase 6: Events & Shops
- **Tasks**:
  - Random event engine: Office drama, job interview mini-events, team-building.
  - Event choices: Dialogue or stat-based outcomes (e.g., pass a Communication check).
  - LinkedIn Shop: Spend “Exposure Points” for items, gear, skills.
  - Gear system: Equip buffs, passive bonuses, silly equipment like “Coffee Mug of Power”.
- **Status**: ⏳ To Do

### ✅ Phase 7: UX Polish & Humor
- **Tasks**:
  - Dialogue system: Witty messages and responses.
  - Animations: UI tweening, sprite bobbing, screen shake.
  - Sound effects: Keyboard clacks, paper rustling, HR alarm buzzers.
  - Cutscenes: Intro and ending scenes with flair.
  - Secret endings: "You became CEO", "Got laid off but became an influencer", etc.
- **Status**: ⏳ To Do

### ✅ Phase 8: Export, QA & Polish
- **Tasks**:
  - Save/load: Optional, for longer sessions.
  - Error handling: Prevent crashes or broken states.
  - Testing: Bugfixes and stat balancing.
  - Export: Build for Windows/macOS/Linux.
  - Optional: Web build using Love.js for browser play.
- **Status**: ⏳ To Do

---

## 📊 Progress Tracking
| Phase | Status |
|-------|--------|
| Phase 1: Core Structure | ✅ Complete |
| Phase 2: Resume System | 🔄 In Progress |
| Phase 3: Map Navigation | ⏳ To Do |
| Phase 4: Battle System | ⏳ To Do |
| Phase 5: Enemies & Bosses | ⏳ To Do |
| Phase 6: Events & Shop | ⏳ To Do |
| Phase 7: Humor & UX Polish | ⏳ To Do |
| Phase 8: QA & Release | ⏳ To Do |