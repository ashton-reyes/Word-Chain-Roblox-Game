--[[
    Stage Walls Handler (Client)
    - Tracks when the local player touches stage walls and increments StageNum
    - Resets wall touch state when requested via a bindable event
]]

-- Services
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

-- Bindables
local resetStageWalls = bindablesFolder:WaitForChild("ResetStageWalls")

-- Local player reference (only valid in a LocalScript)
local player = Players.LocalPlayer

-- Ensure the game is fully loaded before wiring connections
if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- Sets up touch handling for a single stage wall
local function setupWall(stageWall)
	local touched = stageWall:WaitForChild("Touched")

	stageWall.Touched:Connect(function(otherPart)
		local character = player.Character
		if not character then
			return
		end

		-- Only count if the local player's character touched and wall wasn't already counted
		if otherPart:IsDescendantOf(character) and not touched.Value then
			touched.Value = true

			-- Increment the player's current stage number
			local stageNum = player:WaitForChild("StageNum")
			stageNum.Value += 1
		end
	end)
end

-- Set up touch logic for existing tagged walls
for _, wall in ipairs(CollectionService:GetTagged("StageWalls")) do
	setupWall(wall)
end

-- Reset all stage walls' touched state when signaled
resetStageWalls.Event:Connect(function()
	for _, wall in ipairs(CollectionService:GetTagged("StageWalls")) do
		local touched = wall:WaitForChild("Touched")
		touched.Value = false
	end
end)

-- Automatically set up touch logic for walls tagged in the future
CollectionService:GetInstanceAddedSignal("StageWalls"):Connect(setupWall)
