--[[
    Player Setup / Leaderstats Handler
    - Creates leaderstats and gameplay values for each player
    - Tracks level, current stage number, list selections, and difficulty state
]]

-- Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")

-- LocalPlayer (only valid in a LocalScript; unused here but kept for reference)
local player = Players.LocalPlayer

-- DSS
local PlayerLevel = DataStoreService:GetDataStore("PlayerLevel")
local PlayerEasyLists = DataStoreService:GetDataStore("PlayerEasyLists")
local PlayerMediumLists = DataStoreService:GetDataStore("PlayerMediumLists")
local PlayerHardLists = DataStoreService:GetDataStore("PlayerHardLists")


local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = humanoid.WalkSpeed * 2 -- default is 16, so this becomes 32
end

-- Set up stats and values when a player joins
Players.PlayerAdded:Connect(function(player)
	
	player.CharacterAdded:Connect(setupCharacter)
	
	if player.Character then
		setupCharacter(player.Character)
	end
	-- Leaderstats folder (for Roblox leaderboard UI)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	-- TODO: PlayTime stat
	local playTime = Instance.new("IntValue", leaderstats)
	playTime.Name = "PlayTime"
	playTime.Value = 0
	
	local hintCount = Instance.new("IntValue", player)
	hintCount.Name = "HintCount"
	hintCount.Value = 0
	
	local sfx = Instance.new("BoolValue", player)
	sfx.Name = "SFX"
	sfx.Value = true

	-- Player level shown on the leaderboard
	local level = Instance.new("IntValue", leaderstats)
	level.Name = "Level"
	local success, currentLevel = pcall(function()
		return PlayerLevel:GetAsync(player.UserId)
	end)
	if success and currentLevel ~= nil then
		level.Value = currentLevel
	else
		level.Value = 0
		pcall(function()
			PlayerLevel:SetAsync(player.UserId, 0)
		end)
	end

	-- Current list selections for each difficulty
	
	
	
	local easyListsValue = Instance.new("StringValue", player)
	easyListsValue.Name = "EasyLists"
	easyListsValue.Value = "Peanut"

	local mediumListsValue = Instance.new("StringValue", player)
	mediumListsValue.Name = "MediumLists"
	mediumListsValue.Value = "Sun"

	local hardListsValue = Instance.new("StringValue", player)
	hardListsValue.Name = "HardLists"
	hardListsValue.Value = "Fire"


	

	local easyListsValue = Instance.new("StringValue",player)
	easyListsValue.Name = "EasyLists"
	local success, currentEasyLists = pcall(function()
		return PlayerEasyLists:GetAsync(player.UserId)
	end)
	if success and currentEasyLists ~= nil then
		easyListsValue.Value = currentEasyLists
	else
		easyListsValue.Value = "Peanut"
		pcall(function()
			PlayerEasyLists:SetAsync(player.UserId, "Peanut")
		end)
	end
	--[[
	
	local mediumListsValue = Instance.new("StringValue", player)
	mediumListsValue.Name = "MediumLists"
	local success, currentMediumLists = pcall(function()
		return PlayerMediumLists:GetAsync(player.UserId)
	end)
	if success and currentMediumLists ~= nil then
		mediumListsValue.Value = currentMediumLists
	else
		mediumListsValue.Value = "Market"
		pcall(function()
			PlayerMediumLists:SetAsync(player.UserId, "Market")
		end)
	end
	

	local hardListsValue = Instance.new("StringValue", player)
	hardListsValue.Name = "HardLists"
	local success, currentHardLists = pcall(function()
		return PlayerHardLists:GetAsync(player.UserId)
	end)
	if success and currentHardLists ~= nil then
		hardListsValue.Value = currentHardLists
	else
		hardListsValue.Value = "Laboratory"
		pcall(function()
			PlayerHardLists:SetAsync(player.UserId, "Laboratory")
		end)
	end
	]]
	--[[
	
	PlayerEasyLists:RemoveAsync(player.UserId)
	PlayerMediumLists:RemoveAsync(player.UserId)
	PlayerHardLists:RemoveAsync(player.UserId)
	PlayerEasyLists:SetAsync(player.UserId, "Peanut")
	PlayerMediumLists:SetAsync(player.UserId, "Market")
	PlayerHardLists:SetAsync(player.UserId, "Laboratory")=
	]]
	local success, currentEasyLists = pcall(function()
		return PlayerEasyLists:GetAsync(player.UserId)
	end)
	if success then
		print(currentEasyLists)
	end
	
	local success, currentMediumLists = pcall(function()
		return PlayerMediumLists:GetAsync(player.UserId)
	end)
	if success then
		print(currentMediumLists)
	end
	
	local success, currentHardLists = pcall(function()
		return PlayerHardLists:GetAsync(player.UserId)
	end)
	if success then
		print(currentHardLists)
	end
	
	
	-- Tracks which stage number the player is on (per difficulty)
	local stageNum = Instance.new("IntValue", player)
	stageNum.Name = "StageNum"
	stageNum.Value = 0

	-- Index used for hints inside the current list (e.g., which hint to show next)
	local hintIndex = Instance.new("IntValue", player)
	hintIndex.Name = "HintIndex"
	hintIndex.Value = 2

	-- Stores all lists the player has fully completed
	local finishedList = Instance.new("Folder", player)
	finishedList.Name = "FinishedLists"

    --[[
        StageType encoding:
        0 = No Stage
        1 = Easy
        2 = Medium
        3 = Hard
        4 = Other
        Used by other scripts to know which word-chain the player is currently in.
    ]]
	local stageType = Instance.new("IntValue", player)
	stageType.Name = "StageType"
	stageType.Value = 0

    --[[
        Example DataStore integration for saving/loading a stage name.
        Disabled for now; re-enable once DataStore logic is needed.

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
    ]]
end)
