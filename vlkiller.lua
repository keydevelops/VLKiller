local OLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local players = game:GetService("Players")
local localHrp = players.LocalPlayer.Character.HumanoidRootPart
local playerName = nil
local playerNames = {}
local playerDropdown
local teleportBack = false
local tpWaitTime = 10
local originalCFrame = localHrp.CFrame

local Window = OLib:MakeWindow({Name = "Vampire Life killer", HidePremium = false, IntroText = "VL Killer", SaveConfig = false, ConfigFolder = "VLKiller"})

local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local STab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local function updatePlayerNames()
    playerNames = {}
    for _, player in pairs(players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    if playerDropdown then
        playerDropdown:Refresh(playerNames, true)
    end
end


playerDropdown = Tab:AddDropdown({
    Name = "Players",
    Default = "Select player",
    Options = playerNames,
    Callback = function(PlayerUsername)
        playerName = PlayerUsername
    end
})

STab:AddToggle({
    Name = "Teleport back",
    Default = true,
    Callback = function(Value)
        teleportBack = Value
        if teleportBack then
            OLib:MakeNotification({
                Name = "Teleport back",
                Content = "Enabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            OLib:MakeNotification({
                Name = "Teleport back",
                Content = "Disabled",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end    
})

STab:AddSlider({
	Name = "TP wait time",
	Min = 0,
	Max = 20,
	Default = 10,
	Color = Color3.fromRGB(255,127,80),
	Increment = 1,
	ValueName = "Secs.",
	Callback = function(Value)
		tpWaitTime = Value
	end    
})

updatePlayerNames()

Tab:AddButton({
    Name = "Pain Infliction",
    Callback = function(Value)
        if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
            for i = 1, 20 do
                local ohString1 = "Start"
                local ohInstance2 = workspace.CharacterModels:FindFirstChild(playerName)
                if ohInstance2 then
                    workspace.CharacterModels[players.LocalPlayer.Name]["Pain Infliction"].ClickEvent:FireServer(ohString1, ohInstance2)
                end
            end
            if teleportBack then
                wait(tpWaitTime)
                localHrp.CFrame = originalCFrame
            end
        else
            OLib:MakeNotification({
                Name = "Invalid player!",
                Content = "Please, select a valid player!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

Tab:AddButton({
    Name = "Rip Heart",
    Callback = function(Value)
        if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
            if teleportBack then
                originalCFrame = localHrp.CFrame
            end
            for i = 1, 1 do
                local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                if ohInstance1 then
                    workspace.CharacterModels[players.LocalPlayer.Name]["Rip Heart"].RemoteEvent:FireServer(ohInstance1)
                end
            end
            if teleportBack then
                wait(tpWaitTime)
                localHrp.CFrame = originalCFrame
            end
        else
            OLib:MakeNotification({
                Name = "Invalid player!",
                Content = "Please, select a valid player!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

Tab:AddButton({
    Name = "Decapitate",
    Callback = function(Value)
        if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
            if teleportBack then
                originalCFrame = localHrp.CFrame
            end
            for i = 1, 1 do
                local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                if ohInstance1 then
                    workspace.CharacterModels[players.LocalPlayer.Name]["Decapitate"].RemoteEvent:FireServer(ohInstance1)
                end
            end
            if teleportBack then
                wait(tpWaitTime)
                localHrp.CFrame = originalCFrame
            end
        else
            OLib:MakeNotification({
                Name = "Invalid player!",
                Content = "Please, select a valid player!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

Tab:AddButton({
    Name = "Snap neck",
    Callback = function(Value)
        if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
            if teleportBack then
                originalCFrame = localHrp.CFrame
            end
            for i = 1, 1 do
                local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                if ohInstance1 then
                    workspace.CharacterModels[players.LocalPlayer.Name]["Snap Neck"].RemoteEvent:FireServer(ohInstance1)
                end
            end
            if teleportBack then
                wait(tpWaitTime)
                localHrp.CFrame = originalCFrame
            end
        else
            OLib:MakeNotification({
                Name = "Invalid player!",
                Content = "Please, select a valid player!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})


Tab:AddButton({
    Name = "Decapitate all",
    Callback = function(Value)
        local myUsername = players.LocalPlayer.Name

        if teleportBack then
            originalCFrame = localHrp.CFrame
        end

        for _, player in pairs(players:GetPlayers()) do
            if player.Name ~= myUsername and player.Name ~= "Wolfdmitrich" then
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels[player.Name]

                    workspace.CharacterModels[myUsername]["Decapitate"].RemoteEvent:FireServer(ohInstance1)
                end
                print("Killed " .. player.Name)
            end
        end
        if teleportBack then
            wait(tpWaitTime)
            localHrp.CFrame = originalCFrame
        end
    end
})

Tab:AddButton({
    Name = "Snap neck all",
    Callback = function(Value)
        local myUsername = players.LocalPlayer.Name

        if teleportBack then
            originalCFrame = localHrp.CFrame
        end

        for _, player in pairs(players:GetPlayers()) do
            if player.Name ~= myUsername and player.Name ~= "Wolfdmitrich" then
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels[player.Name]

                    workspace.CharacterModels[myUsername]["Snap Neck"].RemoteEvent:FireServer(ohInstance1)
                end
                print("Killed " .. player.Name)
            end
        end
        if teleportBack then
            wait(tpWaitTime)
            localHrp.CFrame = originalCFrame
        end
    end
})

OLib:Init()

players.PlayerAdded:Connect(function(player)
    updatePlayerNames()
end)

players.PlayerRemoving:Connect(function(player)
    updatePlayerNames()
end)
