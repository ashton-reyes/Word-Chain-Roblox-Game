--Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local CollectionService = game:GetService("CollectionService")

--Folders
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

--Modules/Remotes/Bindables
local easyLists = require(modulesFolder.EasyLists)
local answeredCorrectly = remotesFolder:WaitForChild("AnsweredCorrectly")
local updateWordsGui = remotesFolder:WaitForChild("UpdateWordsGui")

--Audio
local correctAnswer = SoundService:WaitForChild("CorrectAnswer")

--Tagged WordWall
local wordWalls = CollectionService:GetTagged("WordWalls")

Players.PlayerAdded:Connect(function(player)
	
	player.Chatted:Connect(function(message)
		local stageName = player:FindFirstChild("StageName")
		local words = easyLists[stageName.Value]
		local guess = string.lower(message)
		for key, word in pairs(words) do
			if string.lower(key) == guess then
				correctAnswer:Play()
				answeredCorrectly:FireClient(player, guess)
				updateWordsGui:FireClient(player, guess)
			end
		end
	end)
end)