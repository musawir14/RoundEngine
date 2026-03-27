# RoundEngine

A reusable, open-source Luau library for Roblox that handles round-based game logic — so you don't have to rewrite it for every game.

---

## Why

Almost every Roblox game has rounds. Battle royales, obby races, hide and seek — they all need the same boilerplate: wait for players, count down, track who's in, end when time runs out, reset, repeat.

RoundEngine handles all of that in one place. Drop it into any project, configure it, and focus on your actual game logic.

---

## Installation

**Requires [Rojo](https://rojo.space) 7.x**

1. Clone this repo into your project:
   ```bash
   git clone https://github.com/musawir14/RoundEngine.git
   ```

2. Copy `src/shared/RoundEngine.luau` into your project's `ReplicatedStorage`.

3. Require it from any server script:
   ```lua
   local RoundEngine = require(game.ReplicatedStorage.RoundEngine)
   ```

---

## Quick Start

```lua
local RoundEngine = require(game.ReplicatedStorage.RoundEngine)

-- Create a round
local round = RoundEngine.new()

-- Listen to events
round:on("roundStarted", function()
    print("Round started with " .. round:getPlayerCount() .. " players!")
end)

round:on("roundEnded", function()
    print("Round over!")
    task.delay(3, function()
        round:reset()
    end)
end)

-- Connect Roblox player events
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    round:addPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    round:removePlayer(player)
end)

-- Start manually when ready
round:start()
```

---

## API Reference

### Constructor

| Method | Description |
|---|---|
| `RoundEngine.new()` | Creates and returns a new RoundEngine instance |

### Player Management

| Method | Returns | Description |
|---|---|---|
| `round:addPlayer(player)` | — | Adds a player to the round |
| `round:removePlayer(player)` | — | Removes a player from the round |
| `round:hasPlayer(player)` | `boolean` | Returns true if the player is in the round |
| `round:getPlayerCount()` | `number` | Returns the current number of players |

### Round Lifecycle

| Method | Description |
|---|---|
| `round:start()` | Starts the round. Warns if fewer than 2 players |
| `round:endRound()` | Ends the round and emits `roundEnded` |
| `round:reset()` | Clears all players and returns to Waiting state |

### State

| Method | Returns | Description |
|---|---|---|
| `round:getState()` | `string` | Returns current state: `"Waiting"`, `"InProgress"`, or `"Ended"` |

### Events

| Method | Description |
|---|---|
| `round:on(event, callback)` | Registers a listener for a named event |
| `round:emit(event)` | Fires all listeners for a named event |

### Event Names

| Event | Fired when |
|---|---|
| `"roundStarted"` | `start()` is called successfully |
| `"roundEnded"` | `endRound()` is called |
| `"roundReset"` | `reset()` is called |

---

## License

MIT
