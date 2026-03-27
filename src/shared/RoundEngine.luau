

local RoundEngine = {}
RoundEngine.__index = RoundEngine

-- creating the constructor
function RoundEngine.new()
    local self = setmetatable({}, RoundEngine)
    self.state = "Waiting"
    self.playerCount = 0
    self.players = {}
    self._listeners = {}
    return self
end

-- the getState() method
function RoundEngine:getState()
    return self.state
end

-- the addPlayer() method
function RoundEngine:addPlayer(player)
    self.players[player] = true
    self.playerCount += 1
end

-- the removePlayer() method
function RoundEngine:removePlayer(player)
    if self.players[player] == nil then
        return
    end

    self.players[player] = nil
    self.playerCount -= 1
end

-- the hasPlayer() method
function RoundEngine:hasPlayer(player)
    return self.players[player] == true
end

-- the getPlayerCount() method
function RoundEngine:getPlayerCount()
    return self.playerCount
end

-- the on(event, callback) method
function RoundEngine:on(event, callback)
    if self._listeners[event] == nil then
        self._listeners[event] = {}
    end
    
    table.insert(self._listeners[event], callback)
end

-- the emit(event) method
function RoundEngine:emit(event)
    if self._listeners[event] == nil then return end
    for _, callback in ipairs(self._listeners[event]) do
        task.spawn(callback)
    end
end

-- the start() method
function RoundEngine:start()
    if self.playerCount < 2 then
        warn("Not enough players to start")
        return
    end

    self.state = "InProgress"
    self:emit("roundStarted")
end

-- the endRound() method
function RoundEngine:endRound()
    self.state = "Ended"
    self:emit("roundEnded")
end

-- the reset() method
function RoundEngine:reset()
    self.players = {}
    self.playerCount = 0
    self.state = "Waiting"
    self:emit("roundReset")
end

return RoundEngine