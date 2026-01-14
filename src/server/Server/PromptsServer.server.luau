--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

--Folders
local stagesFolder = workspace:WaitForChild("Stages")
local easyStage = stagesFolder:WaitForChild("EasyStage")
local promptWallsFolder = easyStage:WaitForChild("PromptWalls")
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
local startWalls = CollectionService:GetTagged("StartWalls")
local endWalls = CollectionService:GetTagged("EndWalls")


local startPrompts = {}
local endPrompts = {}

for i, wall in ipairs(startWalls) do
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
		
		local stageType = player:WaitForChild("StageType")
		stageType.Value = wall.StageType.Value
		local targetPos = wall.Position + -wall.CFrame.LookVector * 10
		hrp.Position = targetPos
		startedLevel:FireClient(player) --WordChainClient
	end)
end

for i, wall in ipairs(endWalls) do
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
		
		
		local leaderstats = player:WaitForChild("leaderstats")
		local level = leaderstats:WaitForChild("Level")
		level.Value += 1

		stageType.Value = 0
		finishedLevel:FireClient(player) --WordChainClient
		hrp.Position = workspace.SpawnLocation.Position + Vector3.new(0, 5, 0)
	end)
end

