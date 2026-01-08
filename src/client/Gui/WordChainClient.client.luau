--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StartGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")

--Folders
local remotesFolder = ReplicatedStorage.Remotes
local modulesFolder = ReplicatedStorage.Modules
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

--Modules/Remotes/Bindables
local easyLists = require(modulesFolder.EasyLists)
local startedLevel = remotesFolder:WaitForChild("StartedLevel")
local finishedLevel = remotesFolder:WaitForChild("FinishedLevel")
local updateWordsGui = remotesFolder:WaitForChild("UpdateWordsGui")
local resetWordWalls = bindablesFolder:WaitForChild("ResetWordWalls")
local resetStageWalls = bindablesFolder:WaitForChild("ResetStageWalls")

--Player Gui
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local wordsGui = PlayerGui:WaitForChild("WordsGui")
local wordsLabel = wordsGui:WaitForChild("WordsLabel") 
local stageNum = player:WaitForChild("StageNum")
local stageName = player:WaitForChild("StageName")

--Sounds
local finishedLevelSound = SoundService:WaitForChild("FinishedLevel")

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
	wordsLabel.Visible = true
	stageNum.Value = 0
end)

finishedLevel.OnClientEvent:Connect(function(player)
	finishedLevelSound:Play()
	wordsLabel.Visible = false
	stageNum.Value = 0
	resetWordWalls:Fire()
	resetStageWalls:Fire()
end)

updateWordsGui.OnClientEvent:Connect(function(guess)
	local words = easyLists[stageName.Value]
	for _, key in ipairs(words.Order) do
		if string.lower(key) == guess then
			words[key] = key
		end
	end
	updateGui()
end)