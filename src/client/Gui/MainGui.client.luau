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

-- Folders
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

-- Bindables
local hintActivated = bindablesFolder:WaitForChild("HintActivated")

-- GUI references
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")
local frame = mainGui:WaitForChild("Frame")

-- Buttons
local hintButton = frame:WaitForChild("HintButton")
local skipWordButton = frame:WaitForChild("SkipWordButton")

-- Fire hint event when the hint button is clicked
hintButton.MouseButton1Click:Connect(function()
	hintActivated:Fire() -- WordChainClient
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
	else
		hintButton.Interactable = true
	end
end)
