-- Services
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

-- Titles


Players.PlayerAdded:Connect(function(player)
	local function applyTitle(character)
		local head = character:WaitForChild("Head")

		local titles = ServerStorage:FindFirstChild("Titles")
		local owner = titles:FindFirstChild("Owner")
		
--		print(titles)
--		print(owner)
		if owner then
			local clonedTitle = owner:Clone()
			clonedTitle.Parent = head
		end

	end

	if player.Character then
		applyTitle(player.Character)
	end

	player.CharacterAdded:Connect(applyTitle)
end)