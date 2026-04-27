-- Service
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")

-- DSS
local PlayerTitles = DataStoreService:GetDataStore("PlayerTitles")


-- Folders
local titlesFolder = ServerStorage:WaitForChild("PlayerTitles")

-- Titles
local titles = titlesFolder:GetChildren()

Players.PlayerAdded:Connect(function(player)
    local level = player:WaitForChild("leaderstats"):WaitForChild("Level")


    local customTitle = Instance.new("BoolValue", player)
    customTitle.Name = "CustomTitle"
    local success, storedTitle = pcall(function()  
        return PlayerTitles:GetAsync(player.UserId)
    end)
    if success and storedTitle ~= nil then
        customTitle.Value = storedTitle
    else
        PlayerTitles:SetAsync(player.UserId, false)
        customTitle.Value = false
    end

end)