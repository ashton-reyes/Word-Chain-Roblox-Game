--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Folders
local promptWallsFolder = workspace.PromptWalls
local remotesFolder = ReplicatedStorage.Remotes
local modulesFolder = ReplicatedStorage:WaitForChild("Modules")

--Modules/Remotes/Bindables
local startedLevel = remotesFolder:WaitForChild("StartedLevel")
local finishedLevel = remotesFolder:WaitForChild("FinishedLevel")
local easyLists = require(modulesFolder:WaitForChild("EasyLists"))
local stageTypes = require(modulesFolder:WaitForChild("StageTypes"))
local types = stageTypes.Stages


--Parts
local startWall = promptWallsFolder:WaitForChild("StartWall")
local endWall = promptWallsFolder:WaitForChild("EndWall")

--Gui
local startPrompt = startWall:WaitForChild("ProximityPrompt")
local endPrompt = endWall:WaitForChild("ProximityPrompt")


startPrompt.Triggered:Connect(function(player)
	local character = player.Character
	if not character then 
		return 
	end 
	
	local stageType = player:WaitForChild("StageType")
	stageType.Value = startWall.StageType.Value
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then 
		return 
	end

	startedLevel:FireClient(player)
	rootPart.Position = Vector3.new(1.801, 4.02, -41.453)
end)

endPrompt.Triggered:Connect(function(player)
	local character = player.Character

	if not character then
		return 
	end

	local stageType = player:WaitForChild("StageType")
	local stageName = player:WaitForChild("StageName")
	
	local typeName = types[stageType.Value]
	
	
	local list = require(modulesFolder[typeName])
	local words = list.ListNames
	for i, word in pairs(words) do
		if word == stageName.Value then
			stageName.Value = words[i+1]
			break
		end
	end
	

	stageType.Value = 0
	
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then
		return 
	end
	
	finishedLevel:FireClient(player)
	rootPart.Position = workspace.SpawnLocation.Position + Vector3.new(0, 5, 0)
end)






