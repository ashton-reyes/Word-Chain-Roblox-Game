local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")
local click1 = soundEffectsFolder:WaitForChild("Click1")


local LocalPlayer = Players.LocalPlayer
local stageType = LocalPlayer:WaitForChild("StageType")
local sfx = LocalPlayer:WaitForChild("SFX")

local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")
local hidePlayersButton = mainGui:WaitForChild("HidePlayersButton")

local Hidden = false
local OriginalTransparency = {}  -- [part] = number
local inTutorial = false

local function hideAllPlayers()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local char = player.Character
			if char then
				for _, child in ipairs(char:GetDescendants()) do
					if child:IsA("BasePart") or child:IsA("Decal") then
						-- save once
						if OriginalTransparency[child] == nil then
							OriginalTransparency[child] = child.Transparency
						end
						child.Transparency = 1
					end
				end
			end
		end
	end
end

local function showAllPlayers()
	for part, original in pairs(OriginalTransparency) do
		if part and part.Parent then
			part.Transparency = original
		end
	end
	table.clear(OriginalTransparency)
end


local orignalSize = hidePlayersButton.Size
hidePlayersButton.MouseEnter:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = UDim2.new(orignalSize.X.Scale + 0.01, 0, orignalSize.Y.Scale + 0.01, 0),
	}
	local tween = TweenService:Create(hidePlayersButton, tweenInfo, propertyTable)
	tween:Play()
end)

hidePlayersButton.MouseLeave:Connect(function()
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = orignalSize,
	}
	local tween = TweenService:Create(hidePlayersButton, tweenInfo, propertyTable)
	tween:Play()
end)


hidePlayersButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click1:Play()
	end
	
	if Hidden then
		showAllPlayers()
		Hidden = false
		hidePlayersButton.Text = "Hide Players"
	else
		hideAllPlayers()
		Hidden = true
		hidePlayersButton.Text = "Show Players"
	end
end)

stageType.Changed:Connect(function()
	if stageType.Value == 4 then
		inTutorial = true
		hideAllPlayers()
		Hidden = true
	else
		if inTutorial then
			showAllPlayers()
			Hidden = false
			inTutorial = false
		end
	end
end)
