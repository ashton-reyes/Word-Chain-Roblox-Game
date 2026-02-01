-- Services
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

-- Developer Products
local hintProductId = 3524532544
local skipProductId = 3524532694

-- Folders
local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")

-- SFX
local click1 = soundEffectsFolder:WaitForChild("Click1")

-- LocalPlayer
local player = Players.LocalPlayer

-- Player stats
local sfx = player:WaitForChild("SFX")
local hintCount = player:WaitForChild("HintCount")
local skipCount = player:WaitForChild("SkipCount")

-- Player gui
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")
local storeFrame = mainGui:WaitForChild("StoreFrame")
local storeButton = mainGui:WaitForChild("StoreButton")
local xButton = storeFrame:WaitForChild("XButton")

local originalSize = storeFrame.Size
storeButton.MouseButton1Click:Connect(function()
	storeFrame.Size = UDim2.new(0, 0, 0 ,0)
	storeFrame.Visible = not storeFrame.Visible
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = originalSize
	}
	local tween = TweenService:Create(storeFrame, tweenInfo, propertyTable)
	tween:Play()
	if sfx.Value then
		click1:Play()
	end
end)

xButton.MouseButton1Click:Connect(function()
	storeFrame.Visible = not storeFrame.Visible
	if sfx.Value then
		click1:Play()
	end
end)

