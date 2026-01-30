local main = workspace:WaitForChild("Main")
local stages = main:WaitForChild("Stages")
local tutorialStage = stages:WaitForChild("TutorialStage")
local bennys = tutorialStage:WaitForChild("Benny")


local benny1 = bennys:WaitForChild("Benny1")
local proximityPrompt1 = benny1:WaitForChild("ProximityPrompt")
local head1 = benny1:WaitForChild("Head")
local billboardGui1 = head1:WaitForChild("BillboardGui")
local textLabel1 = billboardGui1:WaitForChild("TextLabel")

proximityPrompt1.TriggerEnded:Connect(function()
	textLabel1.Text = "Type \"Butter\""
end)

local benny2 = bennys:WaitForChild("Benny2")
local proximityPrompt2 = benny2:WaitForChild("ProximityPrompt")
local head2 = benny2:WaitForChild("Head")
local billboardGui2 = head2:WaitForChild("BillboardGui")
local textLabel2 = billboardGui2:WaitForChild("TextLabel")

proximityPrompt2.TriggerEnded:Connect(function()
	textLabel2.Text = "Type \"Fly\""
end)