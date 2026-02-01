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
local SoundService = game:GetService("SoundService")
local MarketplaceService = game:GetService("MarketplaceService")

-- Developer Product
local hintProductId = 3524532544
local skipProductId = 3524532694

-- Local player
local player = Players.LocalPlayer
local sfx = player:WaitForChild("SFX")
local stageNum = player:WaitForChild("StageNum")
local stageType = player:WaitForChild("StageType")
local hintCount = player:WaitForChild("HintCount")
local skipCount = player:WaitForChild("SkipCount")

-- Folders
local bindablesFolder = ReplicatedStorage:WaitForChild("Bindables")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")
local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")

-- Bindables / remotes
local hintActivated = bindablesFolder:WaitForChild("HintActivated")
local skipActivated = remotesFolder:WaitForChild("SkipActivated")

-- TODO: maybe a new click sfx
-- SFX 
local click1 = soundEffectsFolder:WaitForChild("Click1")


-- GUI references
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")
local frame = mainGui:WaitForChild("Frame")

-- Buttons
local hintButton = frame:WaitForChild("HintButton")
local skipWordButton = frame:WaitForChild("SkipWordButton")
local exitButton = mainGui:WaitForChild("ExitButton")

-- Labels
local hintCountLabel = hintButton:WaitForChild("HintCount")
local skipCountLabel = skipWordButton:WaitForChild("SkipCount")

-- Words Gui
local wordsGui = playerGui:WaitForChild("WordsGui")
local wordsLabel = wordsGui:WaitForChild("WordsLabel")


local function promptHintProductPurchase()
	local success, errorMessage = pcall(function()
		MarketplaceService:PromptProductPurchase(player, hintProductId)
	end)
	if success then
		hintCount.Value += 1
	else
		error(errorMessage)
	end
end

local function promptSkipProductPurchase()
	local success, errorMessage = pcall(function()
		MarketplaceService:PromptProductPurchase(player, skipProductId)
	end)
end


-- Fire hint event when the hint button is clicked
hintButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click1:Play()
	end
	if hintCount.Value > 0 then
		hintActivated:Fire() -- WordChainClient
		hintCount.Value -= 1
	else
		promptHintProductPurchase()
	end
	
end)

-- FIre skip event when skip button is clicked
skipWordButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click1:Play()
	end
	if skipCount.Value > 0 then
		skipActivated:FireServer() -- PromptsServer
		skipCount.Value -= 1
		skipWordButton.Interactable = false
	else
		promptSkipProductPurchase()
	end
	
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
	exitButton.Visible = true
	if stageNum.Value == 0 then
		hintButton.Interactable = false
		skipWordButton.Interactable = false
		exitButton.Visible = false
	elseif stageType.Value == 4 then
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

exitButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click1:Play()
	end
	
	local character = player.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChild("Humanoid")
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not hrp then
		return
	end

	hrp.CFrame = CFrame.new(workspace.SpawnLocation.Position + Vector3.new(0, 5, 0))
	stageNum.Value = 0
	exitButton.Visible = false
	wordsLabel.Visible = false
end)