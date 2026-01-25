--[[
    Check Chat Handler
    - Listens to player chat messages as guesses for word-chain stages
    - Checks guesses against the current list and notifies the client on success
]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

-- Modules / remotes
local stageTypes = require(modulesFolder:WaitForChild("StageTypes"))
local answeredCorrectly = remotesFolder:WaitForChild("AnsweredCorrectly")
local updateWordsGui = remotesFolder:WaitForChild("UpdateWordsGui")

-- Cache stage type names by index (e.g., 1 = "Easy", 2 = "Medium", etc.)
local types = stageTypes.Stages

-- Connect per-player chat listeners
Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		local stageType = player:FindFirstChild("StageType")

		-- Only allow guesses while the player is in a stage (StageType > 0)
		if stageType and stageType.Value > 0 then
			-- Resolve which list module and key to use based on current StageType
			local typeName = types[stageType.Value]
			local listModule = require(modulesFolder:WaitForChild(typeName))

			-- Current active list name stored on the player (e.g., "Beach")
			local currentListName = player:WaitForChild(typeName).Value

			-- words is a dictionary: [answerWord] = clue/definition/whatever
			local words = listModule[currentListName]

			-- Normalize player guess to lowercase for case-insensitive matching
			local guess = string.lower(message)

			-- Compare the guess against all valid keys in the current list
			for key, _ in pairs(words) do
				if string.lower(key) == guess then
					-- Notify the client that the guess was correct (WordWallsClient)
					answeredCorrectly:FireClient(player, guess)

					-- Update the word GUI (e.g., show guessed word / progress) (WordChainClient)
					updateWordsGui:FireClient(player, guess)
					break
				end
			end
		end
	end)
end)
