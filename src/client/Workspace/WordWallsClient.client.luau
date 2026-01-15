if not game:IsLoaded() then
	game.Loaded:Wait()
end

--[[
    Word Wall GUI / State Handler (Client)
    - Populates StartWalls and WordWalls with the correct text for the current list
    - Updates walls when the player progresses or answers correctly
    - Controls collision/visibility for word walls based on stage state
]]

-- Services
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Local player
local player = Players.LocalPlayer
local stageNum = player:WaitForChild("StageNum")

-- Folders
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

-- Modules / remote events / bindables
local stageTypes = require(modulesFolder:WaitForChild("StageTypes"))
local types = stageTypes.Stages

local easyLists = require(modulesFolder:WaitForChild("EasyLists"))
local mediumLists = require(modulesFolder:WaitForChild("MediumLists"))
local hardLists = require(modulesFolder:WaitForChild("HardLists"))

local answeredCorrectly = remotesFolder:WaitForChild("AnsweredCorrectly")
local resetWordWalls = bindablesFolder:WaitForChild("ResetWordWalls")
local hintFinished = bindablesFolder:WaitForChild("HintFinished")
local updateWordWalls = bindablesFolder:WaitForChild("UpdateWordWalls")

-- Tagged walls
local wordWalls = CollectionService:GetTagged("WordWalls")
local startWalls = CollectionService:GetTagged("StartWalls")

-- Update the StartWall text for a specific wall
local function updateStartWall(wall)
	local typeName = types[wall:WaitForChild("StageType").Value]
	local startWord = player:WaitForChild(typeName)

	local listModule = require(modulesFolder[typeName])
	local words = listModule[startWord.Value]

	local gui = wall:WaitForChild("SurfaceGui")
	local label = gui:WaitForChild("TextLabel")

	-- First line is the starting word
	label.Text = startWord.Value .. "\n"

	-- Then append all clues/definitions in the configured order
	for _, key in ipairs(words.Order) do
		label.Text = label.Text .. words[key] .. "\n"
	end

	-- Remove trailing newline
	label.Text = label.Text:gsub("\n$", "")
end

-- Update a single WordWall based on its Type and Order
local function updateWordWall(wall)
	local order = wall:WaitForChild("Order")
	local typeValue = wall:WaitForChild("Type")
	local gui = wall:WaitForChild("SurfaceGui")
	local label = gui:WaitForChild("TextLabel")

	-- Type 1 = Easy
	if typeValue.Value == 1 then
		local startWord = player:WaitForChild("EasyLists")
		local words = easyLists[startWord.Value]
		local values = {}
		local keys = {}

		for i, key in ipairs(words.Order) do
			values[i] = words[key]
			keys[i] = key
		end

		if order.Value == 1 then
			label.Text = startWord.Value .. "\n" .. values[1]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[1])
		elseif order.Value == 2 then
			label.Text = values[1] .. "\n" .. values[2]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[2])
		elseif order.Value == 3 then
			label.Text = values[2] .. "\n" .. values[3]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[3])
		end

		-- Type 2 = Medium
	elseif typeValue.Value == 2 then
		local startWord = player:WaitForChild("MediumLists")
		local words = mediumLists[startWord.Value]
		local values = {}
		local keys = {}

		for i, key in ipairs(words.Order) do
			values[i] = words[key]
			keys[i] = key
		end

		if order.Value == 1 then
			label.Text = startWord.Value .. "\n" .. values[1]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[1])
		elseif order.Value == 2 then
			label.Text = values[1] .. "\n" .. values[2]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[2])
		elseif order.Value == 3 then
			label.Text = values[2] .. "\n" .. values[3]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[3])
		elseif order.Value == 4 then
			label.Text = values[3] .. "\n" .. values[4]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[4])
		end

		-- Type 3 = Hard
	elseif typeValue.Value == 3 then
		local startWord = player:WaitForChild("HardLists")
		local words = hardLists[startWord.Value]
		local values = {}
		local keys = {}

		for i, key in ipairs(words.Order) do
			values[i] = words[key]
			keys[i] = key
		end

		if order.Value == 1 then
			label.Text = startWord.Value .. "\n" .. values[1]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[1])
		elseif order.Value == 2 then
			label.Text = values[1] .. "\n" .. values[2]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[2])
		elseif order.Value == 3 then
			label.Text = values[2] .. "\n" .. values[3]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[3])
		elseif order.Value == 4 then
			label.Text = values[3] .. "\n" .. values[4]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[4])
		elseif order.Value == 5 then
			label.Text = values[4] .. "\n" .. values[5]
			local answer = wall:WaitForChild("Answer")
			answer.Value = string.lower(keys[5])
		end
	else
		error("Unknown Type Found")
	end
end

-- Initial population for existing StartWalls
for _, wall in ipairs(startWalls) do
	updateStartWall(wall)
end

-- Initial population for existing WordWalls
for _, wall in ipairs(wordWalls) do
	updateWordWall(wall)
end

-- Handle any StartWalls that get tagged later
CollectionService:GetInstanceAddedSignal("StartWalls"):Connect(function(newWall)
	table.insert(startWalls, newWall)
	updateStartWall(newWall)
end)

-- Handle any WordWalls that get tagged later
CollectionService:GetInstanceAddedSignal("WordWalls"):Connect(function(newWall)
	table.insert(wordWalls, newWall)
	updateWordWall(newWall)
end)

-- Batch update function for the current StageType
local function updateCurrentStageType()
	local stageType = player:WaitForChild("StageType")

	for _, wall in ipairs(wordWalls) do
		if wall:WaitForChild("Type").Value == stageType.Value then
			updateWordWall(wall)
		end
	end

	for _, wall in ipairs(startWalls) do
		if wall:WaitForChild("StageType").Value == stageType.Value then
			updateStartWall(wall)
		end
	end
end

-- When StageNum changes, refresh relevant walls
stageNum.Changed:Connect(function()
	updateCurrentStageType()
end)

-- External signal to force a word wall refresh
updateWordWalls.Event:Connect(function()
	updateCurrentStageType()
end)

-- When a word is answered correctly, unlock matching walls and refresh
answeredCorrectly.OnClientEvent:Connect(function(guess)
	for _, wall in ipairs(wordWalls) do
		local answer = wall:WaitForChild("Answer")
		if answer.Value == string.lower(guess) then
			wall.CanCollide = false
			wall.Transparency = 0.5
		end
	end

	updateCurrentStageType()
end)

-- Might need to turn this into a RemoteFunction (comment from original)
resetWordWalls.Event:Connect(function()
	local stageType = player:WaitForChild("StageType")
	for _, wall in ipairs(wordWalls) do
		local typeValue = wall:WaitForChild("Type")
		local currentStageType = player:WaitForChild("StageType")

		if typeValue.Value == currentStageType.Value then
			wall.CanCollide = true
			wall.Transparency = 0
		end
	end
end)

-- When hint sequence finishes, pre‑unlock the current wall for this stage/step
hintFinished.Event:Connect(function()
	for _, wall in ipairs(wordWalls) do
		local typeValue = wall:WaitForChild("Type")
		local order = wall:WaitForChild("Order")
		local currentStageType = player:WaitForChild("StageType")
		local currentStageNum = player:WaitForChild("StageNum")

		if typeValue.Value == currentStageType.Value and order.Value == currentStageNum.Value then
			wall.CanCollide = false
			wall.Transparency = 0.5
		end
	end
end)
