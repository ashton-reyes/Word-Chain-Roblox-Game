--[[
    Wall Prompts Handler
    - Handles entering and exiting word-chain stages
    - Teleports players and updates StageType (indicates what word-chain they are playing)
    - Updates player level stat
]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

-- Folders
local stagesFolder = workspace:WaitForChild("Stages")
local easyStage = stagesFolder:WaitForChild("EasyStage")
local promptWallsFolder = easyStage:WaitForChild("PromptWalls")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")

-- Remotes / modules
local startedLevel = remotesFolder:WaitForChild("StartedLevel")
local finishedLevel = remotesFolder:WaitForChild("FinishedLevel") 
local stageTypes = require(modulesFolder:WaitForChild("StageTypes"))

-- Cache stage type metadata
local types = stageTypes.Stages

-- Parts / tagged collections
local startWalls = CollectionService:GetTagged("StartWalls")
local endWalls = CollectionService:GetTagged("EndWalls")

-- Connect prompts on all start walls
for _, wall in ipairs(startWalls) do
	local prompt = wall:WaitForChild("ProximityPrompt")

	prompt.Triggered:Connect(function(player)
		local character = player.Character
		if not character then
			return
		end

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end

		-- Set current stage type on the player
		local stageType = player:WaitForChild("StageType")
		stageType.Value = wall.StageType.Value

		-- Teleport player just in front of the wall, in facing direction
		local targetPos = wall.Position + -wall.CFrame.LookVector * 10
		hrp.Position = targetPos

		-- Notify client that the level started (WordChainClient)
		startedLevel:FireClient(player)
	end)
end


-- Connect prompts on all end walls
for _, wall in ipairs(endWalls) do
	local prompt = wall:WaitForChild("ProximityPrompt")

	prompt.Triggered:Connect(function(player)
		local character = player.Character
		if not character then
			return
		end

		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then
			return
		end

		-- Resolve stage type and current word list
		local stageType = player:WaitForChild("StageType")
		local typeName = types[stageType.Value]
		local startWord = player:WaitForChild(typeName)

		local listModule = require(modulesFolder[typeName])
		local words = listModule.ListNames

		-- Advance to the next word in the list
		for i, word in ipairs(words) do
			if word == startWord.Value then
				startWord.Value = words[i + 1]
				break
			end
		end

		-- Increment level based on stage difficulty
		local leaderstats = player:WaitForChild("leaderstats")
		local level = leaderstats:WaitForChild("Level")
		level.Value += stageType.Value -- Consider making this a constant / config

		-- Waits for client to finish whatever happens when the game is finished (WordChainClient)
		local result = finishedLevel:InvokeClient(player)
		stageType.Value = 0

		-- Send player back to spawn
		hrp.Position = workspace.SpawnLocation.Position + Vector3.new(0, 5, 0)
	end)
end
