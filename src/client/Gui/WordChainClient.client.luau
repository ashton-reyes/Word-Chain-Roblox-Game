--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StartGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

--Folders
local remotesFolder = ReplicatedStorage.Remotes
local modulesFolder = ReplicatedStorage.Modules
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")
local promptWallsFolder = workspace:WaitForChild("PromptWalls")
local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")

--Modules/Remotes/Bindables
local easyLists = require(modulesFolder.EasyLists)
local startedLevel = remotesFolder:WaitForChild("StartedLevel")
local finishedLevel = remotesFolder:WaitForChild("FinishedLevel")
local updateWordsGui = remotesFolder:WaitForChild("UpdateWordsGui")
local resetWordWalls = bindablesFolder:WaitForChild("ResetWordWalls")
local resetStageWalls = bindablesFolder:WaitForChild("ResetStageWalls")
local hintActivated = bindablesFolder:WaitForChild("HintActivated")
local hintFinished = bindablesFolder:WaitForChild("HintFinished")
local updateWordWalls = bindablesFolder:WaitForChild("UpdateWordWalls")

--Player Gui
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local wordsGui = PlayerGui:WaitForChild("WordsGui")
local wordsLabel = wordsGui:WaitForChild("WordsLabel")
local mainGui = PlayerGui:WaitForChild("MainGui")
local frame = mainGui:WaitForChild("Frame")
local hintButton = frame:WaitForChild("HintButton")


local stageNum = player:WaitForChild("StageNum")
local stageName = player:WaitForChild("StageName")
local hintIndex = player:WaitForChild("HintIndex")

--Parts
local startWall = promptWallsFolder:WaitForChild("StartWall")
local startPrompt = startWall:WaitForChild("ProximityPrompt")

--Sounds
local finishedLevelSound = soundEffectsFolder:WaitForChild("FinishedLevel")
local correctAnswerSound = soundEffectsFolder:WaitForChild("CorrectAnswer")
local teleportSound = soundEffectsFolder:WaitForChild("Teleport")

--Functions
local function updateGui()
	local words = easyLists[stageName.Value]
	wordsLabel.Text = stageName.Value.."\n"
	for _, key in ipairs(words.Order) do
		wordsLabel.Text ..= words[key] .. "\n"
	end
end

--Connect Functions
startedLevel.OnClientEvent:Connect(function(player)
	updateGui()
	teleportSound:Play()
	stageNum.Value = 1
	startPrompt.Enabled = false
	wordsLabel.Visible = true
end)

finishedLevel.OnClientEvent:Connect(function(player)
	finishedLevelSound:Play()
	resetWordWalls:Fire()
	resetStageWalls:Fire()
	stageNum.Value = 0
	wordsLabel.Visible = false
	startPrompt.Enabled = true
end)

updateWordsGui.OnClientEvent:Connect(function(guess)
	correctAnswerSound:Play()
	local words = easyLists[stageName.Value]
	for _, key in ipairs(words.Order) do
		if string.lower(key) == guess then
			words[key] = key
		end
	end
	updateGui()
end)

hintActivated.Event:Connect(function()
	local words = easyLists[stageName.Value]
	local finished = false
	for i, key in ipairs(words.Order) do
		if i == stageNum.Value then
			words[key] = string.sub(key, 1, hintIndex.Value)
			local index = #key - hintIndex.Value
			if index == 0 then
				finished = true
			end
			for i = 1, index do
				words[key] = words[key].." _"
			end
		end
	end
	hintIndex.Value += 1
	updateGui()
	updateWordWalls:Fire()
	if finished then
		correctAnswerSound:Play()
		hintFinished:Fire()
		hintButton.Interactable = false
	end
end)

stageNum.Changed:Connect(function()
	hintIndex.Value = 2
end)