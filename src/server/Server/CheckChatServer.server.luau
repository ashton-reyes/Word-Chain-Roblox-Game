--Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

--Folders
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

--Modules/Remotes/Bindables
local easyLists = require(modulesFolder.EasyLists)
local stageTypes = require(modulesFolder:WaitForChild("StageTypes"))
local answeredCorrectly = remotesFolder:WaitForChild("AnsweredCorrectly")
local updateWordsGui = remotesFolder:WaitForChild("UpdateWordsGui")

local types = stageTypes.Stages

--Tagged WordWall
local wordWalls = CollectionService:GetTagged("WordWalls")

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		local stageType = player:FindFirstChild("StageType")
		local stageName = player:FindFirstChild("StageName")
		
		--Checks to see if the player is in the stage so you can't guess outside of it
		if stageType and stageType.Value > 0 then
			local typeName = types[stageType.Value]
			local list = require(modulesFolder[typeName])
			local words = list[stageName.Value]
			local guess = string.lower(message)
			
			for key, word in pairs(words) do
				if string.lower(key) == guess then
					answeredCorrectly:FireClient(player, guess)
					updateWordsGui:FireClient(player,guess)
				end
			end
		end
	end)
end)