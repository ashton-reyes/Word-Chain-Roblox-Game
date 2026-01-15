--[[
    Word Chain Main GUI Client
    - Updates on-screen word list and handles hint / level start / finish logic
    - Plays sounds and coordinates with word walls and stage walls via bindables
]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local CollectionService = game:GetService("CollectionService")

-- Folders
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")
local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")

-- Modules / remotes / bindables
local stageTypes = require(modulesFolder:WaitForChild("StageTypes"))

local startedLevel = remotesFolder:WaitForChild("StartedLevel")
local updateWordsGui = remotesFolder:WaitForChild("UpdateWordsGui")
local finishedLevel = remotesFolder:WaitForChild("FinishedLevel")

local resetWordWalls = bindablesFolder:WaitForChild("ResetWordWalls")
local resetStageWalls = bindablesFolder:WaitForChild("ResetStageWalls")
local hintActivated = bindablesFolder:WaitForChild("HintActivated")
local hintFinished = bindablesFolder:WaitForChild("HintFinished")
local updateWordWalls = bindablesFolder:WaitForChild("UpdateWordWalls")

-- Stage type lookup (e.g., 1 = "EasyLists", 2 = "MediumLists", etc.)
local types = stageTypes.Stages

-- Player GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local wordsGui = playerGui:WaitForChild("WordsGui")
local wordsLabel = wordsGui:WaitForChild("WordsLabel")
local mainGui = playerGui:WaitForChild("MainGui")
local frame = mainGui:WaitForChild("Frame")
local hintButton = frame:WaitForChild("HintButton")

-- Player state values
local stageType = player:WaitForChild("StageType")
local stageNum = player:WaitForChild("StageNum")
local hintIndex = player:WaitForChild("HintIndex")

-- Start walls and prompts
local startWalls = CollectionService:GetTagged("StartWalls")
local startPrompts = {}
for _, wall in ipairs(startWalls) do
	table.insert(startPrompts, wall:WaitForChild("ProximityPrompt"))
end

-- Track future StartWalls as they get tagged
CollectionService:GetInstanceAddedSignal("StartWalls"):Connect(function(newWall)
	table.insert(startWalls, newWall)
	table.insert(startPrompts, newWall:WaitForChild("ProximityPrompt"))
end)

-- Sounds
local finishedLevelSound = soundEffectsFolder:WaitForChild("FinishedLevel")
local correctAnswerSound = soundEffectsFolder:WaitForChild("CorrectAnswer")
local teleportSound = soundEffectsFolder:WaitForChild("Teleport")

-- Updates the WordsGui TextLabel with the current list and clues
local function updateGui()
	local currentStageType = player:WaitForChild("StageType")
	local typeName = types[currentStageType.Value]

	local listModule = require(modulesFolder[typeName])
	local startWord = player:WaitForChild(typeName)
	local words = listModule[startWord.Value]

	wordsLabel.Text = startWord.Value .. "\n"
	for _, key in ipairs(words.Order) do
		wordsLabel.Text ..= words[key] .. "\n"
	end
end

-- When a level starts, update GUI, play sound, and disable start prompts
startedLevel.OnClientEvent:Connect(function()
	updateGui()
	teleportSound:Play()
	stageNum.Value = 1
	wordsLabel.Visible = true

	for _, prompt in ipairs(startPrompts) do
		prompt.Enabled = false
	end
end)

-- When a level finishes, reset walls and re-enable prompts
finishedLevel.OnClientInvoke = function()
	finishedLevelSound:Play()
	resetWordWalls:Fire()
	resetStageWalls:Fire()
	stageNum.Value = 0
	wordsLabel.Visible = false

	for _, prompt in ipairs(startPrompts) do
		prompt.Enabled = true
	end

	return true
end

-- When a correct answer is submitted, reveal that word in the list and update walls
updateWordsGui.OnClientEvent:Connect(function(guess)
	correctAnswerSound:Play()

	local currentStageType = player:WaitForChild("StageType")
	local typeName = types[currentStageType.Value]
	local listModule = require(modulesFolder[typeName])
	local startWord = player:WaitForChild(typeName)
	local words = listModule[startWord.Value]

	for _, key in ipairs(words.Order) do
		if string.lower(key) == guess then
			-- Replace clue with the actual word
			words[key] = key
		end
	end

	updateGui()
	updateWordWalls:Fire()
end)

-- Hint button: progressively reveals more letters for the current word
hintActivated.Event:Connect(function()
	local currentStageType = player:WaitForChild("StageType")
	local typeName = types[currentStageType.Value]
	local listModule = require(modulesFolder[typeName])
	local startWord = player:WaitForChild(typeName)
	local words = listModule[startWord.Value]

	local finished = false

	for i, key in ipairs(words.Order) do
		if i == stageNum.Value then
			-- Reveal first hintIndex letters, then fill remaining with underscores
			words[key] = string.sub(key, 1, hintIndex.Value)
			local remaining = #key - hintIndex.Value

			if remaining == 0 then
				finished = true
			end

			for _ = 1, remaining do
				words[key] = words[key] .. " _"
			end
		end
	end

	hintIndex.Value += 1
	updateGui()
	updateWordWalls:Fire() -- WordWallsClient

	if finished then
		correctAnswerSound:Play()
		hintFinished:Fire()
		hintButton.Interactable = false
	end
end)

-- Reset hint index whenever the stage changes
stageNum.Changed:Connect(function()
	hintIndex.Value = 2
end)
