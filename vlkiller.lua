local AOLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local players = game:GetService("Players")
local localHrp = players.LocalPlayer.Character.HumanoidRootPart
local playerName = nil
local playerNames = {}
local playerDropdown
local teleportBack = false
local autoDodge = false
local dodgeSleep = 25
local tpWaitTime = 10
local originalCFrame = localHrp.CFrame
local whitelisted = {"Wolfdmitrich", "VadimYtube20"}
local AuthKey = "VLK_F4B119EA514FF95678EF9D69F883D"
local AuthkeyInput = nil

function init_auth()
    local AuthWindow = AOLib:MakeWindow({Name = "VLK Auth System", HidePremium = false, IntroText = "VLK Auth", SaveConfig = true, ConfigFolder = "VLAuth"})
    local AuthTab = AuthWindow:MakeTab({
        Name = "Auth",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    AuthTab:AddTextbox({
        Name = "Enter auth key",
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            AuthkeyInput = Value
            if AuthkeyInput ~= nil and AuthkeyInput == AuthKey then
                AOLib:Destroy()
                init_vlk()
            else
                AOLib:MakeNotification({
                    Name = "Key System",
                    Content = "Key is invalid.",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end
    })
end

function init_vlk()
    local OLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OLib:MakeWindow({Name = "Vampire Life killer", HidePremium = false, IntroText = "VL Killer", SaveConfig = true, ConfigFolder = "VLKiller"})

    local Tab = Window:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    local TTab = Window:MakeTab({
        Name = "Tools",
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

    local inputPlayerName
    Tab:AddTextbox({
        Name = "Player Name",
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            inputPlayerName = Value
            for _, player in pairs(players:GetPlayers()) do
                if string.find(string.lower(player.Name), string.lower(inputPlayerName)) then
                    playerName = player.Name
                    OLib:MakeNotification({
                        Name = "Player Found",
                        Content = "Player " .. playerName .. " selected.",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                    break
                end
            end
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
    
    Tab:AddButton(
    {
        Name = "Bat Tool",
        Callback = function()
            local tool = Instance.new("Tool")
            tool.Name = "Bat On"
            tool.RequiresHandle = false

            tool.Activated:Connect(
                function()
                    local ohBoolean1 = true

                    workspace.CharacterModels.Wolfdmitrich["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                end
            )

            tool.Parent = game.Players.LocalPlayer.Backpack

            local tool = Instance.new("Tool")
            tool.Name = "Bat off"
            tool.RequiresHandle = false

            tool.Activated:Connect(
                function()
                    local ohBoolean1 = false

                    workspace.CharacterModels.Wolfdmitrich["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                end
            )

            tool.Parent = game.Players.LocalPlayer.Backpack
        end
    }
)

    Tab:AddButton(
        {
            Name = "Bat Tool",
            Callback = function()
                local tool = Instance.new("Tool")
                tool.Name = "Bat"
                tool.RequiresHandle = false

                -- Когда инструмент экипирован
                tool.Equipped:Connect(
                    function()
                        local ohBoolean1 = true
                        workspace.CharacterModels.Wolfdmitrich["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                    end
                )

                -- Когда инструмент убран
                tool.Unequipped:Connect(
                    function()
                        local ohBoolean1 = false
                        workspace.CharacterModels.Wolfdmitrich["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                    end
                )

                tool.Parent = game.Players.LocalPlayer.Backpack
            end
        }
    )

    STab:AddToggle({
        Name = "Auto dodge",
        Default = false,
        Callback = function(Value)
            autoDodge = Value
            if autoDodge then
                OLib:MakeNotification({
                    Name = "Auto Dodge",
                    Content = "Enabled",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
                autododge()
            else
                OLib:MakeNotification({
                    Name = "Auto Dodge",
                    Content = "Disabled",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
        end    
    })

    function autododge()
        while autoDodge do
            game:GetService("Players").LocalPlayer.Backpack.Fists.Dodge.RemoteEvent:FireServer()
            wait(dodgeSleep / 1000)
        end
    end

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

    STab:AddSlider({
        Name = "Auto dodge sleep time",
        Min = 5,
        Max = 40,
        Default = 10,
        Color = Color3.fromRGB(255,127,80),
        Increment = 1,
        ValueName = "ms",
        Callback = function(Value)
            dodgeSleep = Value
        end    
    })

    updatePlayerNames()

    Tab:AddButton({
        Name = "Pain Infliction",
        Callback = function()
            if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                if teleportBack then
                    originalCFrame = localHrp.CFrame
                end
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                    if ohInstance1 then
                        workspace.CharacterModels[players.LocalPlayer.Name]["Pain Infliction"].ClickEvent:FireServer(ohInstance1)
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
        Callback = function()
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
        Name = "Compulsion",
        Callback = function()
            if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                if teleportBack then
                    originalCFrame = localHrp.CFrame
                end
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                    if ohInstance1 then
                        workspace.CharacterModels[players.LocalPlayer.Name]["Compulsion"].RemoteEvent:FireServer(ohInstance1)
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
        Name = "Bite",
        Callback = function()
            if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                    if ohInstance1 then
                        workspace.CharacterModels[players.LocalPlayer.Name]["Bite"].RemoteEvent:FireServer(ohInstance1, true)
                    end
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
        Name = "UnBite",
        Callback = function()
            if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                    if ohInstance1 then
                        workspace.CharacterModels[players.LocalPlayer.Name]["Bite"].RemoteEvent:FireServer(ohInstance1, false)
                    end
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
        Name = "Feed Blood",
        Callback = function()
            if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                if teleportBack then
                    originalCFrame = localHrp.CFrame
                end
                for i = 1, 1 do
                    local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                    if ohInstance1 then
                        workspace.CharacterModels[players.LocalPlayer.Name]["Feed Blood"].RemoteEvent:FireServer(ohInstance1)
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
        Callback = function()
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
        Callback = function()
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
        Callback = function()
            local myUsername = players.LocalPlayer.Name

            if teleportBack then
                originalCFrame = localHrp.CFrame
            end

            for _, player in pairs(players:GetPlayers()) do
                if player.Name ~= myUsername and not table.find(whitelisted, player.Name) then
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
        Callback = function()
            local myUsername = players.LocalPlayer.Name

            if teleportBack then
                originalCFrame = localHrp.CFrame
            end

            for _, player in pairs(players:GetPlayers()) do
                if player.Name ~= myUsername and not table.find(whitelisted, player.Name) then
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
    TTab:AddButton(
        {
            Name = "Reset",
            Callback = function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Infinity Yield",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            end
        }
    )

    TTab:AddDropdown(
        {
            Name = "Eternal Forcefield",
            Default = "1",
            Options = {"On", "Off"},
            Callback = function(Value)
                if Value == "On" then
                    plr = game.Players.LocalPlayer
                    mouse = plr:GetMouse()
                    mouse.KeyDown:connect(
                        function(key)
                            if key == " " then
                                game.Players.LocalPlayer.Character.Humanoid:ChangeState(3)
                            end
                        end
                    )
                    plr = game.Players.LocalPlayer
                    mouse = plr:GetMouse()
                    mouse.KeyUp:connect(
                        function(key)
                            if key == " " then
                                jumping = false
                            end
                        end
                    )

                    FF = true

                    while wait() do
                        if FF then
                            game.Players.LocalPlayer.Character.Humanoid.Name = 1
                            local l = game.Players.LocalPlayer.Character["1"]:Clone()
                            l.Parent = game.Players.LocalPlayer.Character
                            l.Name = "Humanoid"
                            wait()
                            game.Players.LocalPlayer.Character["1"]:Destroy()
                            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
                            game.Players.LocalPlayer.Character.Animate.Disabled = true
                            wait()
                            game.Players.LocalPlayer.Character.Animate.Disabled = false
                            game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
                            wait(4.85)
                            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                            pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            wait(.4)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
                            workspace.CurrentCamera.CameraType = Enum.CameraType.Track
                        end
                    end
                end
                if Value == "Off" then
                    FF = false
                    wait()
                    xos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    wait(4.85)
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Track
                    wait(.4)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = xos
                end
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Remove Gameplay Paused",
            Callback = function()
                while true do
                    wait()
                    game.Players.LocalPlayer.GameplayPaused = false
                end
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Anti slow",
            Callback = function()
                repeat
                    wait()
                    local Player = game.Players.LocalPlayer
                    local Character = Player.Character or Player.CharacterAdded:Wait()

                    local initialSpeed = 16
                    local currentSpeed = Character.Humanoid.WalkSpeed

                    if currentSpeed >= 0 and currentSpeed <= 10 then
                        Character.Humanoid.WalkSpeed = initialSpeed
                    else
                        Character.Humanoid.WalkSpeed = currentSpeed
                    end
                until game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Anti inventory lock",
            Callback = function()
                while true do
                    task.wait()
                    local StarterGui = game:GetService("StarterGui")
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

                    local sgui = game:GetService("StarterGui")
                    sgui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
                end
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Anti jump block",
            Callback = function()
                while true do
                    wait()
                    local Player = game.Players.LocalPlayer
                    local Character = Player.Character or Player.CharacterAdded:Wait()
                    Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                    Character.Humanoid.UseJumpPower = true

                    local initialJump = 50
                    local currentJump = Character.Humanoid.JumpPower

                    if currentJump >= 0 and currentJump <= 10 then
                        Character.Humanoid.JumpPower = initialJump
                    else
                        Character.Humanoid.JumpPower = currentJump
                    end
                end
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Anti reclining",
            Callback = function()
                local plr = game.Players.LocalPlayer
                local char = plr.Character
                for _, child in pairs(char:GetChildren()) do
                    if child:IsA("BasePart") then
                        child.Massless = false
                        child.CustomPhysicalProperties = PhysicalProperties.new(math.huge, math.huge, math.huge)
                    end
                end
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Fix Camera",
            Callback = function()
                speaker = game.Players.LocalPlayer
                workspace.CurrentCamera:remove()
                task.wait()
                repeat
                    wait()
                until speaker.Character ~= nil
                workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA("Humanoid")
                workspace.CurrentCamera.CameraType = "Custom"
                speaker.CameraMinZoomDistance = 0.5
                speaker.CameraMaxZoomDistance = 400
                speaker.CameraMode = "Classic"
                speaker.Character.Head.Anchored = false
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Auto Defrost",
            Callback = function()
                while true do
                    wait()
                    Humanoid = game.Players.LocalPlayer.Character.Humanoid
                    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
                        task.spawn(
                            function()
                                for i, x in next, v.Character:GetDescendants() do
                                    if x.Name ~= floatName and x:IsA("BasePart") and x.Anchored then
                                        x.Anchored = false
                                        Humanoid.AutoRotate = true
                                    end
                                end
                            end
                        )
                    end
                end
            end
        }
    )

    TTab:AddButton(
        {
            Name = "Fulbright",
            Callback = function()
                pcall(
                    function()
                        local lighting = game:GetService("Lighting")
                        lighting.Ambient = Color3.fromRGB(255, 255, 255)
                        lighting.Brightness = 1
                        lighting.FogEnd = 1e10
                        for i, v in pairs(lighting:GetDescendants()) do
                            if
                                v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or
                                    v:IsA("SunRaysEffect")
                            then
                                v.Enabled = false
                            end
                        end
                        lighting.Changed:Connect(
                            function()
                                lighting.Ambient = Color3.fromRGB(255, 255, 255)
                                lighting.Brightness = 1
                                lighting.FogEnd = 1e10
                            end
                        )
                        spawn(
                            function()
                                local character = game:GetService("Players").LocalPlayer.Character
                                while wait() do
                                    repeat
                                        wait()
                                    until character ~= nil
                                    if not character.HumanoidRootPart:FindFirstChildWhichIsA("PointLight") then
                                        local headlight = Instance.new("PointLight", character.HumanoidRootPart)
                                        headlight.Brightness = 1
                                        headlight.Range = 60
                                    end
                                end
                            end
                        )
                    end
                )
            end
        }
    )

    OLib:Init()

    players.PlayerAdded:Connect(function(player)
        updatePlayerNames()
    end)

    players.PlayerRemoving:Connect(function(player)
        updatePlayerNames()
    end)
end


if table.find(whitelisted, players.LocalPlayer.Name) then
    init_vlk()
else
    init_auth()
end
