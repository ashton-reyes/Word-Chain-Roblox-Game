--Services
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Folders
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

--Bindables
local resetStageWalls = bindablesFolder:WaitForChild("ResetStageWalls")


local player = Players.LocalPlayer

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local function setupWall(stageWall)
	local touched = stageWall:WaitForChild("Touched")

	stageWall.Touched:Connect(function(otherPart)
		local character = player.Character
		if not character then return end

		if otherPart:IsDescendantOf(character) and not touched.Value then
			touched.Value = true
			local stageNum = player:WaitForChild("StageNum")
			stageNum.Value += 1
		end
	end)
end

-- existing tagged walls
for _, wall in ipairs(CollectionService:GetTagged("StageWalls")) do
	setupWall(wall)
end

resetStageWalls.Event:Connect(function()
	for _, wall in ipairs(CollectionService:GetTagged("StageWalls")) do
		local touched = wall:WaitForChild("Touched")
		touched.Value = false
	end
end)


-- walls tagged later
CollectionService:GetInstanceAddedSignal("StageWalls"):Connect(setupWall)

