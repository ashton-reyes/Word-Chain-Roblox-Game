--Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

--LocalPlayer
local player = Players.LocalPlayer
local stageNum = player:WaitForChild("StageNum")

--Folders
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")

--Bindables
local hintActivated = bindablesFolder:WaitForChild("HintActivated")

--Gui
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")
local frame = mainGui:WaitForChild("Frame")

--Buttons
local hintButton = frame:WaitForChild("HintButton")
local skipWordButton = frame:WaitForChild("SkipWordButton")

hintButton.MouseButton1Click:Connect(function()
	hintActivated:Fire()
end)

local originalSizeHB = hintButton.Size
local orginalSizeSWB = skipWordButton.Size

hintButton.MouseEnter:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = UDim2.new(originalSizeHB.X.Scale + 0.08, 0, originalSizeHB.Y.Scale + 0.1, 0)
	}
	local tween = TweenService:Create(hintButton, tweenInfo, propertyTable)
	tween:Play()
end)

hintButton.MouseLeave:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = originalSizeHB
	}
	local tween = TweenService:Create(hintButton, tweenInfo, propertyTable)
	tween:Play()
end)

skipWordButton.MouseEnter:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = UDim2.new(orginalSizeSWB.X.Scale + 0.08, 0, orginalSizeSWB.Y.Scale + 0.1, 0)
	}
	local tween = TweenService:Create(skipWordButton, tweenInfo, propertyTable)
	tween:Play()
end)

skipWordButton.MouseLeave:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = orginalSizeSWB
	}
	local tween = TweenService:Create(skipWordButton, tweenInfo, propertyTable)
	tween:Play()
end)

stageNum.Changed:Connect(function()
	if stageNum.Value == 0 then
		hintButton.Interactable = false
	else
		hintButton.Interactable = true
	end
end)
