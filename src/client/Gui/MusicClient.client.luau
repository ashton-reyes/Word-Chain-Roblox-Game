--[[
    Background Music Handler (Client)
    - Cycles through background music tracks without repeats until all are played
    - Handles muting/unmuting via a GUI button
]]

-- Services
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

-- Folders
local backgroundMusicFolder = SoundService:WaitForChild("BackgroundMusic")

-- Songs (array of Sound objects)
local songs = backgroundMusicFolder:GetChildren()

-- GUI
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainGui")

-- Mute button and state
local muteButton = mainGui:WaitForChild("MuteButton")
local muted = muteButton:WaitForChild("Muted")

-- Playback state
local currentSong
local playedSongs = {}
local endedConnection -- connection to current song's Ended event

-- Plays the next song, cycling when the list is exhausted
local function playSong()
	-- Stop old song and disconnect its Ended handler
	if currentSong then
		currentSong:Stop()
		if endedConnection then
			endedConnection:Disconnect()
			endedConnection = nil
		end
	end

	-- If no songs left, refill from playedSongs
	if #songs == 0 then
		for i, song in ipairs(playedSongs) do
			songs[i] = song
		end
		table.clear(playedSongs) -- reuse the same table
	end

	-- Still nothing? Then just return (no tracks in folder)
	if #songs == 0 then
		return
	end

	-- Pick first song in list
	currentSong = songs[1]
	currentSong.Volume = muted.Value and 0 or 0.1
	currentSong:Play()
	print("Now Playing: " .. currentSong.Name)

	-- When it ends, move it to playedSongs and play the next one
	endedConnection = currentSong.Ended:Connect(function()
		table.insert(playedSongs, currentSong)
		table.remove(songs, 1)
		playSong()
	end)
end

-- Start initial playback
playSong()

-- Toggle mute state and update button icon + volume
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
