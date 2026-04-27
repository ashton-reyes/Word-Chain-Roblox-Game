-- Services
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

-- Remotes
local decreaseServerHint = remotesFolder:WaitForChild("DecreaseServerHint")
local decreaseServerSkip = remotesFolder:WaitForChild("DecreaseServerSkip")

-- Constants
local AUTOSAVE_INTERVAL = 30

-- DSS
local PlayerLevel = DataStoreService:GetDataStore("PlayerLevel")

local PlayerHints = DataStoreService:GetDataStore("PlayerHints")
local PlayerSkips = DataStoreService:GetDataStore("PlayerSkips")

local PlayerEasyLists = DataStoreService:GetDataStore("PlayerEasyLists")
local PlayerMediumLists = DataStoreService:GetDataStore("PlayerMediumLists")
local PlayerHardLists = DataStoreService:GetDataStore("PlayerHardLists")


-- Functions

local function saveHints(userId, value)

	local success, err = pcall(function()
		PlayerHints:SetAsync(userId, value)
	end)

	if not success then
		warn("[SAVE ERROR] Could not save hint count for", userId, ":", err)
	end
end

local function saveSkips(userId, value)
	local success, err = pcall(function()
		PlayerSkips:SetAsync(userId, value)
	end)
	
	if not success then
		warn("[SAVE ERROR] Could not save skip count for", userId, ":", err)
	end
end

local function saveEasyLists(userId, value)
	local success, err = pcall(function()
		PlayerEasyLists:SetAsync(userId, value)
	end)
	
	if not success then
		warn("[SAVE ERROR] Could not save EasyLists for", userId, ":", err)
	end
end

local function saveMediumLists(userId, value)
	local success, err = pcall(function()
		PlayerMediumLists:SetAsync(userId, value)
	end)

	if not success then
		warn("[SAVE ERROR] Could not save MediumLists for", userId, ":", err)
	end
end

local function saveHardLists(userId, value)
	local success, err = pcall(function()
		PlayerHardLists:SetAsync(userId, value)
	end)

	if not success then
		warn("[SAVE ERROR] Could not save HardLists for", userId, ":", err)
	end
end

local function savePlayer(player)
	local userId = player.UserId
	local hints = player:FindFirstChild("HintCount")
	local skips = player:FindFirstChild("SkipCount")
	local leaderstats = player:FindFirstChild("leaderstats")

	if hints then
		saveHints(userId, hints.Value)
	end
	
	if skips then
		saveSkips(userId, skips.Value)
	end
end

-- Remote Event Connections
decreaseServerHint.OnServerEvent:Connect(function(player)
	local hints = player:FindFirstChild("HintCount")
	hints.Value -= 1
end)

decreaseServerSkip.OnServerEvent:Connect(function(player)
	local skips = player:FindFirstChild("SkipCount")
	skips.Value -= 1
end)

-- Event Connections
Players.PlayerRemoving:Connect(savePlayer)

game:BindToClose(function()
	task.wait(2)
end)


task.spawn(function()
	while true do
		task.wait(AUTOSAVE_INTERVAL)

		for i, player in ipairs(Players:GetPlayers()) do
			local leaderstats = player:WaitForChild("leaderstats")
			local level = leaderstats:WaitForChild("Level")
			local playTime = leaderstats:WaitForChild("PlayTime")
				
			local easyLists = player:WaitForChild("EasyLists")
			local mediumLists = player:WaitForChild("MediumLists")
			local hardLists = player:WaitForChild("HardLists")

		end
	end
end)


