-- Service
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")


-- Folders
local titlesFolder = ServerStorage:WaitForChild("PlayerTitles")

-- Titles
local titles = titlesFolder:GetChildren()

Players.PlayerAdded:Connect(function(player)
    local level = player:WaitForChild("leaderstats"):WaitForChild("Level")
    
end)