--Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Folders
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")

--Modules
local easyLists = require(modulesFolder.EasyLists)

--DSS
local PlayerStageName = DataStoreService:GetDataStore("PlayerStageName")

Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstat"
	
	local stageNum = Instance.new("IntValue", player)
	stageNum.Name = "StageNum"
	stageNum.Value = 0
	
	
	
	
	
	local stageName = Instance.new("StringValue", player)
	stageName.Name = "StageName"
	stageName.Value = "Beach"

	local success, storedStageName = pcall(function()
		return PlayerStageName:GetAsync(player.UserId)
	end)

	if success and storedStageName ~= nil then
		stageName.Value = storedStageName
	else
		stageName.Value = "Beach"
		pcall(function()
			PlayerStageName:SetAsync(player.UserId, "Beach")
		end)
	end
	
end)