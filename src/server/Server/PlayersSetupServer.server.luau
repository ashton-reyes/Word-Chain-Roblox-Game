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

-- Modules
local easyLists = require(modulesFolder:WaitForChild("EasyLists"))

-- LocalPlayer (only valid in a LocalScript; unused here but kept for reference)
local player = Players.LocalPlayer

-- Set up stats and values when a player joins
Players.PlayerAdded:Connect(function(player)
	-- Leaderstats folder (for Roblox leaderboard UI)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	-- Player level shown on the leaderboard
	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Value = 0
	level.Parent = leaderstats

	-- Tracks which stage number the player is on (per difficulty)
	local stageNum = Instance.new("IntValue")
	stageNum.Name = "StageNum"
	stageNum.Value = 0
	stageNum.Parent = player

	-- Current list selections for each difficulty
	local easyListsValue = Instance.new("StringValue")
	easyListsValue.Name = "EasyLists"
	easyListsValue.Value = "Beach"
	easyListsValue.Parent = player

	local mediumListsValue = Instance.new("StringValue")
	mediumListsValue.Name = "MediumLists"
	mediumListsValue.Value = "Market"
	mediumListsValue.Parent = player

	local hardListsValue = Instance.new("StringValue")
	hardListsValue.Name = "HardLists"
	hardListsValue.Value = "Laboratory"
	hardListsValue.Parent = player

	-- Index used for hints inside the current list (e.g., which hint to show next)
	local hintIndex = Instance.new("IntValue")
	hintIndex.Name = "HintIndex"
	hintIndex.Value = 2
	hintIndex.Parent = player

	-- Stores all lists the player has fully completed
	local finishedList = Instance.new("Folder")
	finishedList.Name = "FinishedLists"
	finishedList.Parent = player

    --[[
        StageType encoding:
        0 = No Stage
        1 = Easy
        2 = Medium
        3 = Hard
        4 = Other
        Used by other scripts to know which word-chain the player is currently in.
    ]]
	local stageType = Instance.new("IntValue")
	stageType.Name = "StageType"
	stageType.Value = 0
	stageType.Parent = player

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
