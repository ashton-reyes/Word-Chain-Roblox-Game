-- Services
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Developer Products
local hintProductId = 3524532544
local skipProductId = 3524532694

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

storeButton.MouseButton1Click:Connect(function()
	storeFrame.Visible = not storeFrame.Visible
end)

