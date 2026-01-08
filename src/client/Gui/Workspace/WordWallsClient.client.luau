--Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Folders
local wordWallsFolder = workspace.WordWalls
local modulesFolder = ReplicatedStorage.Modules
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local promptWallsFolder = workspace:WaitForChild("PromptWalls")

--LocalPlayer
local player = Players.LocalPlayer

--Modules/Remotes/Bindables
local easyLists = require(modulesFolder.EasyLists)
local answeredCorrectly = remotesFolder:WaitForChild("AnsweredCorrectly")
local resetWordWalls = bindablesFolder:WaitForChild("ResetWordWalls")

--StageName
local stageName = player:WaitForChild("StageName")

--Table
local words = easyLists[stageName.Value]


--Walls
local wall1 = wordWallsFolder:WaitForChild("Wall1")
local wall2 = wordWallsFolder:WaitForChild("Wall2")
local wall3 = wordWallsFolder:WaitForChild("Wall3")
local startWall = promptWallsFolder:WaitForChild("StartWall")
local startWallLabel = startWall:WaitForChild("SurfaceGui"):WaitForChild("TextLabel")

local walls = {wall1, wall2, wall3}
local wallLabels = {}

for i = 1, #walls do
	local wallGui = walls[i]:WaitForChild("SurfaceGui")
	local wallLabel = wallGui:WaitForChild("TextLabel")
	
	wallLabels[i] = wallLabel
end

startWallLabel.Text = stageName.Value.."\n"
for i, key in ipairs(words.Order) do
	startWallLabel.Text = startWallLabel.Text..words[key].."\n"
	wallLabels[i].Text = words[key]
	local answer = walls[i]:WaitForChild("Answer")
	answer.Value = string.lower(key)
end
startWallLabel.Text = startWallLabel.Text:gsub("\n$", "")


answeredCorrectly.OnClientEvent:Connect(function(guess)
	for i = 1, #walls do
		local answer = walls[i].Answer
		if answer.Value == string.lower(guess) then
			walls[i].CanCollide = false
			walls[i].Transparency = 0.5
		end
	end
end)


resetWordWalls.Event:Connect(function()
	for i = 1, #walls do
		walls[i].CanCollide = true
		walls[i].Transparency = 0
	end
end)