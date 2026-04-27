-- Constants
local HINT_INTERVAL = 15 -- Prone to adjustment
local SKIP_INTERVAL = 60 -- Prone to adjustment



-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

-- Remotes
local increaseServerHint = remotesFolder:WaitForChild("IncreaseServerHint")
local increaseServerSkip = remotesFolder:WaitForChild("IncreaseServerSkip")


-- Local Player
local player = Players.LocalPlayer
local hints = player:WaitForChild("HintCount")
local skips = player:WaitForChild("SkipCount")
local stageNum = player:WaitForChild("StageNum")


-- Gui references
local playerGui = player:WaitForChild("PlayerGui")
local distributionGui = playerGui:WaitForChild("DistributionGui")
local hintTimeLabel = distributionGui:WaitForChild("HintTimeLabel")
local skipTimeLabel = distributionGui:WaitForChild("SkipTimeLabel")

task.spawn(function()
	local hintTime = HINT_INTERVAL
	local skipTime = SKIP_INTERVAL
	hintTimeLabel.Text = "Next: "..hintTime
	skipTimeLabel.Text = "Next: "..skipTime
	while true do
		if stageNum.Value > 0 then
			hintTime -= 1
			skipTime -= 1
			hintTimeLabel.Text = "Next: "..hintTime
			skipTimeLabel.Text = "Next: "..skipTime

			if hintTime == 0 then
				hints.Value += 1
				increaseServerHint:FireServer()
				hintTime = "Next: "..HINT_INTERVAL
			end

			if skipTime == 0 then
				skips.Value += 1
				increaseServerSkip:FireServer()
				skipTime = "Next: "..SKIP_INTERVAL
			end
		end

		
		task.wait(1)
	end
end)



