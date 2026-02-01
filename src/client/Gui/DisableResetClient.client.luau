local StarterGui = game:GetService("StarterGui")
local success
repeat
	success = pcall(function()
		StarterGui:SetCore("ResetButtonCallback", false)
	end)
	task.wait(0.1)
until success