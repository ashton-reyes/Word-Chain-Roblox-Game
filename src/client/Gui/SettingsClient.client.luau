
-- Services
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- Folders
local backgroundMusicFolder = SoundService:WaitForChild("BackgroundMusic")
local soundEffectsFolder = SoundService:WaitForChild("SoundEffects")

-- Songs (array of Sound objects)
local songs = backgroundMusicFolder:GetChildren()
local click1 = soundEffectsFolder:WaitForChild("Click1")
local click2 = soundEffectsFolder:WaitForChild("Click2")

-- Local Player
local player = Players.LocalPlayer
local sfx = player:WaitForChild("SFX")
local PlayerGui = player:WaitForChild("PlayerGui")
local mainGui = PlayerGui:WaitForChild("MainGui")
local settingsButton = mainGui:WaitForChild("SettingsButton")
local settingsFrame = mainGui:WaitForChild("SettingsFrame")
local xButton = settingsFrame:WaitForChild("XButton")

local buttonsFrame = settingsFrame:WaitForChild("Buttons")
local musicButton = buttonsFrame:WaitForChild("MusicButton")
local sfxButton = buttonsFrame:WaitForChild("SFXButton")
local dayButton = buttonsFrame:WaitForChild("DayButton")

local buttons = {}
table.insert(buttons, musicButton)
table.insert(buttons, sfxButton)
table.insert(buttons, dayButton)

-- Variables
local musicOn = musicButton:WaitForChild("On")
local sfxOn = sfxButton:WaitForChild("On")
local dayOn = dayButton:WaitForChild("On")

local originialSize = settingsFrame.Size
settingsButton.MouseButton1Click:Connect(function()
	settingsFrame.Size = UDim2.new(0, 0, 0 ,0)
	settingsFrame.Visible = not settingsFrame.Visible
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local propertyTable = {
		Size = originialSize
	}
	local tween = TweenService:Create(settingsFrame, tweenInfo, propertyTable)
	tween:Play()
	if sfx.Value then
		click1:Play()
	end
end)

xButton.MouseButton1Click:Connect(function()
	settingsFrame.Visible = not settingsFrame.Visible
	if sfx.Value then
		click1:Play()
	end
end)

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
	currentSong.Volume = not musicOn.Value and 0 or 0.1
	currentSong:Play()
	--	print("Now Playing: " .. currentSong.Name)

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
musicButton.MouseButton1Click:Connect(function()
	musicOn.Value = not musicOn.Value
	if sfx.Value then
		click2:Play()
	end

	if not musicOn.Value then
		musicButton.BackgroundColor3 = Color3.fromRGB(255, 0 ,0)
		musicButton.Text = "OFF"
		if currentSong then
			currentSong.Volume = 0
		end
	else
		musicButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		musicButton.Text = "ON"
		if currentSong then
			currentSong.Volume = 0.1
		end
	end
end)

sfxButton.MouseButton1Click:Connect(function()
	sfxOn.Value = not sfxOn.Value
	if not sfx.Value then
		click2:Play()
	end
	if not sfxOn.Value then
		sfxButton.BackgroundColor3 = Color3.fromRGB(255, 0 ,0)
		sfxButton.Text = "OFF"
		sfx.Value = false
	else
		sfxButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		sfxButton.Text = "ON"
		sfx.Value = true
	end
end)

-- TODO: It seems like everything in influenced by light so when its night, everything isn't as visible
dayButton.MouseButton1Click:Connect(function()
	dayOn.Value = not dayOn.Value
	if sfx.Value then
		click2:Play()
	end
	if not dayOn.Value then
		dayButton.BackgroundColor3 = Color3.fromRGB(255, 0 ,0)
		dayButton.Text = "OFF"
		Lighting.TimeOfDay = "21:00:00"
	else
		dayButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		dayButton.Text = "ON"
		Lighting.TimeOfDay = "14:30:00"
	end
end)