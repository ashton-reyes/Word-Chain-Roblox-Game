-- Services
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

-- Folders
local backgroundMusicFolder = SoundService:WaitForChild("BackgroundMusic")

-- Songs (array of Sound objects)
local songs = backgroundMusicFolder:GetChildren()

-- Gui
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local mainGui = PlayerGui:WaitForChild("MainGui")

-- Other
local muteButton = mainGui:WaitForChild("MuteButton")
local muted = muteButton:WaitForChild("Muted")

local currentSong
local playedSongs = {}
local endedConnection -- to disconnect when switching songs

local function playSong()
	-- stop old song and disconnect its Ended handler
	if currentSong then
		currentSong:Stop()
		if endedConnection then
			endedConnection:Disconnect()
			endedConnection = nil
		end
	end

	-- if no songs left, refill from playedSongs
	if #songs == 0 then
		for i, song in ipairs(playedSongs) do
			songs[i] = song
		end
		table.clear(playedSongs) -- or: playedSongs = {}
	end

	-- still nothing? then just return
	if #songs == 0 then
		return
	end

	-- pick first song in list
	currentSong = songs[1]
	currentSong.Volume = muted.Value and 0 or 0.1
	currentSong:Play()

	-- when it ends, move it to playedSongs and play the next one
	endedConnection = currentSong.Ended:Connect(function()
		table.insert(playedSongs, currentSong)
		table.remove(songs, 1)
		playSong()
	end)
end

playSong()

muteButton.MouseButton1Click:Connect(function()
	muted.Value = not muted.Value

	if muted.Value then
		muteButton.Image = "rbxassetid://12339193508"
		if currentSong then
			currentSong.Volume = 0
		end
	else
		muteButton.Image = "rbxassetid://8625422354"
		if currentSong then
			currentSong.Volume = 0.1
		end
	end
end)
