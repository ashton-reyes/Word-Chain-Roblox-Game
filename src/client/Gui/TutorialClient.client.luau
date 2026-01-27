-- Services
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Folders
local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")
local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

-- Remotes
local startTutorial = remotesFolder:WaitForChild("StartTutorial")

-- SFX
local click1 = soundEffectsFolder:WaitForChild("Click1")
local click2 = soundEffectsFolder:WaitForChild("Click2")

-- LocalPlayer
local player = Players.LocalPlayer
local sfx = player:WaitForChild("SFX")
local playerGui = player:WaitForChild("PlayerGui")

-- Screen Guis
local mainGui = playerGui:WaitForChild("MainGui")
local tutorialGui = playerGui:WaitForChild("TutorialGui")

-- Instances
local tutorialButton = mainGui:WaitForChild("TutorialButton")
local tutorialFrame = tutorialGui:WaitForChild("TutorialFrame")
local nextButton = tutorialFrame:WaitForChild("NextButton")
local xButton = tutorialFrame:WaitForChild("XButton")
local page = tutorialFrame:WaitForChild("Page")
local pageOne = tutorialFrame:WaitForChild("PageOne")
local pageTwo = tutorialFrame:WaitForChild("PageTwo")

startTutorial.OnClientEvent:Connect(function()
	if page.Value == 3 then
		page.Value = 1
	end
end)

local originalSize = tutorialFrame.Size
page.Changed:Connect(function()
	if page.Value == 0 or page.Value == 3 then
		tutorialFrame.Visible = false
	else
		if page.Value == 1 then
			tutorialFrame.Size = UDim2.new(0, 0, 0, 0)
			tutorialFrame.Visible = true
			local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			local propertyTable = {
				Size = originalSize
			}
			local tween = TweenService:Create(tutorialFrame, tweenInfo, propertyTable)
			tween:Play()
			pageOne.Visible = true
			pageTwo.Visible = false
		elseif page.Value == 2 then
			tutorialFrame.Visible = true
			pageOne.Visible = false
			pageTwo.Visible = true
		else 
			tutorialFrame.Visible = false
			pageOne.Visible = false
			pageTwo.Visible = false
		end
	end
end)

tutorialButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click1:Play()
	end
	
	if tutorialFrame.Visible then
		page.Value = 0
	else
		page.Value = 1
	end
end)

nextButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click2:Play()
	end
	
	page.Value += 1
	
end)

xButton.MouseButton1Click:Connect(function()
	if sfx.Value then
		click1:Play()
	end
	
	page.Value = 3
end)