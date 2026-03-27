local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local RoundEngine = require(ReplicatedStorage.Shared.RoundEngine)

local round = RoundEngine.new()

Players.PlayerAdded:Connect(function(player)
    round:addPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    round:removePlayer(player)
end)

round:on("roundStarted", function()
    print("Round has started! Players: " .. round:getPlayerCount())
end)

round:on("roundEnded", function()
    print("Round has ended!")
end)

round:on("roundReset", function()
    print("Round has been reset")
end)

print("GameManager Initialized!")
