--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--Folders
local promptWallsFolder = workspace.PromptWalls
local remotesFolder = ReplicatedStorage.Remotes

--Remotes
local startedLevel = remotesFolder:WaitForChild("StartedLevel")
local finishedLevel = remotesFolder:WaitForChild("FinishedLevel")

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

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then 
		return 
	end

	startedLevel:FireClient(player)
	rootPart.Position += Vector3.new(0, 0, -20)
end)

endPrompt.Triggered:Connect(function(player)
	local character = player.Character
	if not character then
		return 
	end
	
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then
		return 
	end
	
	finishedLevel:FireClient(player)
	rootPart.Position = workspace.SpawnLocation.Position + Vector3.new(0, 5, 0)
end)


