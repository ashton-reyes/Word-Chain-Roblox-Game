--[[
    Hint / Skip Button UI Handler (Client)
    - Fires a hint event when the player clicks the hint button
    - Tweens hint/skip buttons on hover
    - Disables the hint button when the player is not in a stage
]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Local player
local player = Players.LocalPlayer
local stageNum = player:WaitForChild("StageNum")
local stageType = player:WaitForChild("StageType")
local hintCount = player:WaitForChild("HintCount")
local skipCount = player:WaitForChild("SkipCount")

-- Folders
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

-- Bindables / remotes
local hintActivated = bindablesFolder:WaitForChild("HintActivated")
local skipActivated = remotesFolder:WaitForChild("SkipActivated")


-- GUI references
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")
local frame = mainGui:WaitForChild("Frame")

-- Buttons
local hintButton = frame:WaitForChild("HintButton")
local skipWordButton = frame:WaitForChild("SkipWordButton")

-- Labels
local hintCountLabel = hintButton:WaitForChild("HintCount")
local skipCountLabel = skipWordButton:WaitForChild("SkipCount")

-- Fire hint event when the hint button is clicked
-- TODO check if their hintcount > 0 and decrement by 1
hintButton.MouseButton1Click:Connect(function()
	hintActivated:Fire() -- WordChainClient
end)

-- TODO check if their skipcount > 0 and decrement by 1
skipWordButton.MouseButton1Click:Connect(function()
	skipActivated:FireServer()
end)

-- Cache original sizes for hover tweens
local originalSizeHB = hintButton.Size
local originalSizeSWB = skipWordButton.Size  

-- Hint button hover enlarge
hintButton.MouseEnter:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = UDim2.new(originalSizeHB.X.Scale + 0.08, 0, originalSizeHB.Y.Scale + 0.1, 0),
	}
	local tween = TweenService:Create(hintButton, tweenInfo, propertyTable)
	tween:Play()
end)

-- Hint button hover reset
hintButton.MouseLeave:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = originalSizeHB,
	}
	local tween = TweenService:Create(hintButton, tweenInfo, propertyTable)
	tween:Play()
end)

-- Skip button hover enlarge
skipWordButton.MouseEnter:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = UDim2.new(originalSizeSWB.X.Scale + 0.08, 0, originalSizeSWB.Y.Scale + 0.1, 0),
	}
	local tween = TweenService:Create(skipWordButton, tweenInfo, propertyTable)
	tween:Play()
end)

-- Skip button hover reset
skipWordButton.MouseLeave:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = originalSizeSWB,
	}
	local tween = TweenService:Create(skipWordButton, tweenInfo, propertyTable)
	tween:Play()
end)

-- Enable/disable hint button based on whether the player is in a stage
stageNum.Changed:Connect(function()
	if stageNum.Value == 0 then
		hintButton.Interactable = false
		skipWordButton.Interactable = false
	elseif stageType.Value == 1 and stageNum.Value == 4 then
		hintButton.Interactable = false
		skipWordButton.Interactable = false
	elseif stageType.Value == 2 and stageNum.Value == 5 then
		hintButton.Interactable = false
		skipWordButton.Interactable = false
	elseif stageType.Value == 3 and stageNum.Value == 6 then 
		hintButton.Interactable = false
		skipWordButton.Interactable = false
	else
		hintButton.Interactable = true
		skipWordButton.Interactable = true
	end
end)

hintCountLabel.Text = hintCount.Value
skipCountLabel.Text = skipCount.Value

hintCount.Changed:Connect(function()
	hintCountLabel.Text = hintCount.Value
end)

skipCount.Changed:Connect(function()
	skipCountLabel.Text = skipCount.Value
end)

