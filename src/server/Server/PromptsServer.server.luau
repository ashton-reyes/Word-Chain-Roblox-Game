--[[
    Wall Prompts Handler
    - Handles entering and exiting word-chain stages
    - Teleports players and updates StageType (indicates what word-chain they are playing)
    - Updates player level stat
]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local DataStoreService = game:GetService("DataStoreService")

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
local skipActivated = remotesFolder:WaitForChild("SkipActivated")

-- Cache stage type metadata
local types = stageTypes.Stages

-- Parts / tagged collections
local startWalls = CollectionService:GetTagged("StartWalls")
local endWalls = CollectionService:GetTagged("EndWalls")

-- CONSTANTS
local EASY_LIST_INCREMENT = 1
local MEDIUM_LIST_INCREMENT = 2
local HARD_LIST_INCREMENT = 3

-- DSS
local PlayerLevel = DataStoreService:GetDataStore("PlayerLevel")
local PlayerEasyLists = DataStoreService:GetDataStore("PlayerEasyLists")
local PlayerMediumLists = DataStoreService:GetDataStore("PlayerMediumLists")
local PlayerHardLists = DataStoreService:GetDataStore("PlayerHardLists")

-- Cache
local easyListsCache = {}

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


local function finishedStage(player)
	local character = player.Character
	if not character then
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	local playerLists = {}
	table.insert(playerLists, player:WaitForChild("EasyLists"))
	table.insert(playerLists, player:WaitForChild("MediumLists"))
	table.insert(playerLists, player:WaitForChild("HardLists"))

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
			if stageType.Value == 1 then -- in easy stage
				local success, newEasyLists = pcall(function()
					PlayerEasyLists:SetAsync(player.UserId, startWord.Value)
				end)
			elseif stageType.Value == 2 then -- in medium stge
				local success, newMediumLists = pcall(function()
					PlayerMediumLists:SetAsync(player.UserId, startWord.Value)
				end)
			elseif stageType.Value == 3 then -- in hard stage
				local success, newHardLists = pcall(function()
					PlayerHardLists:SetAsync(player.UserId, startWord.Value)
				end)
			end
			break
		end
	end

	-- Increment level based on stage difficulty
	local leaderstats = player:WaitForChild("leaderstats")
	local level = leaderstats:WaitForChild("Level")
	level.Value += stageType.Value -- Consider making this a constant / config
	local success, updatedLevel = pcall(function()
		return PlayerLevel:IncrementAsync(player.UserId, stageType.Value)
	end)

	-- Waits for client to finish whatever happens when the game is finished (WordChainClient)
	local result = finishedLevel:InvokeClient(player)
	stageType.Value = 0

	-- Send player back to spawn
	hrp.Position = workspace.SpawnLocation.Position + Vector3.new(0, 5, 0)
end


skipActivated.OnServerEvent:Connect(function(player)
	finishedStage(player)
end)


-- Connect prompts on all end walls
for _, wall in ipairs(endWalls) do
	local prompt = wall:WaitForChild("ProximityPrompt")

	prompt.Triggered:Connect(function(player)
		finishedStage(player)
	end)
end
