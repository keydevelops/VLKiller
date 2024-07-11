-- VL Killer by wolfdmitrich and privatekey
local AOLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()

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
local whitelisted = {"Wolfdmitrich", "VadimYtube20", "semik2022", "ADSker_man222"}
local AuthKey = "VLK_F4B119EA514FF95678EF9D69F883D"
local AuthkeyInput = nil
local localPlayerName = players.LocalPlayer.Name

function invisible(value)
    if value == "on" then
        for i = 1, 100 do
            local ohBoolean1 = false
            workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
            wait(0.01)
        end
    elseif value == "off" then
        for i = 1, 100 do
            local ohBoolean1 = true
            workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
            wait(0.01)
        end
    end
end

function init_auth()
    local AuthWindow =
        AOLib:MakeWindow(
        {
            Name = "VLK Auth System",
            HidePremium = false,
            IntroText = "VLK Auth",
            SaveConfig = true,
            ConfigFolder = "VLKAuth"
        }
    )
    local AuthTab =
        AuthWindow:MakeTab(
        {
            Name = "Auth",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
        }
    )

    AuthTab:AddTextbox(
        {
            Name = "Enter auth key",
            Default = "",
            TextDisappear = false,
            Callback = function(Value)
                AuthkeyInput = Value
                if AuthkeyInput ~= nil and AuthkeyInput == AuthKey then
                    AOLib:Destroy()
                    init_vlk()
                else
                    AOLib:MakeNotification(
                        {
                            Name = "Key System",
                            Content = "Key is invalid.",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )
end

function init_vlk()
    local OLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
    local Window =
        OLib:MakeWindow(
        {
            Name = "Vampire Life Killer",
            HidePremium = false,
            IntroText = "VLKiller",
            SaveConfig = true,
            ConfigFolder = "VLKiller"
        }
    )

    local Tab =
        Window:MakeTab(
        {
            Name = "Main",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
        }
    )

    local TTab =
        Window:MakeTab(
        {
            Name = "Tools",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
        }
    )

    local STab =
        Window:MakeTab(
        {
            Name = "Settings",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
        }
    )

    local function updatePlayerNames()
        playerNames = {}
        for _, player in pairs(players:GetPlayers()) do
            table.insert(playerNames, player.Name)
        end
        if playerDropdown then
            playerDropdown:Refresh(playerNames, true)
        end
    end

    playerDropdown =
        Tab:AddDropdown(
        {
            Name = "Players",
            Default = "Select player",
            Options = playerNames,
            Callback = function(PlayerUsername)
                playerName = PlayerUsername
            end
        }
    )

    local inputPlayerName
    Tab:AddTextbox(
        {
            Name = "Player Name",
            Default = "",
            TextDisappear = false,
            Callback = function(Value)
                inputPlayerName = Value
                for _, player in pairs(players:GetPlayers()) do
                    if string.find(string.lower(player.Name), string.lower(inputPlayerName)) then
                        playerName = player.Name
                        OLib:MakeNotification(
                            {
                                Name = "Player Found",
                                Content = "Player " .. playerName .. " selected.",
                                Image = "rbxassetid://4483345998",
                                Time = 5
                            }
                        )
                        break
                    end
                end
            end
        }
    )

    STab:AddToggle(
        {
            Name = "Teleport back",
            Default = false,
            Callback = function(Value)
                teleportBack = Value
                if teleportBack then
                    OLib:MakeNotification(
                        {
                            Name = "Teleport back",
                            Content = "Enabled",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                else
                    OLib:MakeNotification(
                        {
                            Name = "Teleport back",
                            Content = "Disabled",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddLabel("Vampire")

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

                        workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                    end
                )

                tool.Parent = game.Players.LocalPlayer.Backpack

                local tool = Instance.new("Tool")
                tool.Name = "Bat off"
                tool.RequiresHandle = false

                tool.Activated:Connect(
                    function()
                        local ohBoolean1 = false

                        workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                    end
                )

                tool.Parent = game.Players.LocalPlayer.Backpack
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Bat Tool (2nd version)",
            Callback = function()
                local tool = Instance.new("Tool")
                tool.Name = "Bat"
                tool.RequiresHandle = false

                -- Когда инструмент экипирован
                tool.Equipped:Connect(
                    function()
                        local ohBoolean1 = true
                        workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                    end
                )

                -- Когда инструмент убран
                tool.Unequipped:Connect(
                    function()
                        local ohBoolean1 = false
                        workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                    end
                )

                tool.Parent = game.Players.LocalPlayer.Backpack
            end
        }
    )

    Tab:AddLabel("Если ты будешь использавать Invisible Off")
    Tab:AddLabel("То, после нажми B английскую")

    Tab:AddButton(
        {
            Name = "Invisible On",
            Callback = function()
                invisible("on")
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Invisible Off",
            Callback = function()
                invisible("off")
            end
        }
    )

    STab:AddToggle(
        {
            Name = "Whitelist",
            Default = true,
            Callback = function(Value)
                if Value then
                    whitelisted = {"Wolfdmitrich", "VadimYtube20", "semik2022", "ADSker_man222"}
                    OLib:MakeNotification(
                        {
                            Name = "Whitelist",
                            Content = "On",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                else
                    whitelisted = {}
                    AOLib:MakeNotification(
                        {
                            Name = "Whitelist",
                            Content = "Off",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )
    STab:AddToggle(
        {
            Name = "Auto dodge",
            Default = false,
            Callback = function(Value)
                autoDodge = Value
                if autoDodge then
                    OLib:MakeNotification(
                        {
                            Name = "Auto Dodge",
                            Content = "Enabled",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                    autododge()
                else
                    OLib:MakeNotification(
                        {
                            Name = "Auto Dodge",
                            Content = "Disabled",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    function autododge()
        while autoDodge do
            game:GetService("Players").LocalPlayer.Backpack.Fists.Dodge.RemoteEvent:FireServer()
            wait(dodgeSleep / 1000)
        end
    end

    STab:AddSlider(
        {
            Name = "TP wait time",
            Min = 0,
            Max = 20,
            Default = 10,
            Color = Color3.fromRGB(255, 127, 80),
            Increment = 1,
            ValueName = "Secs.",
            Callback = function(Value)
                tpWaitTime = Value
            end
        }
    )

    STab:AddSlider(
        {
            Name = "Auto dodge sleep time",
            Min = 5,
            Max = 40,
            Default = 10,
            Color = Color3.fromRGB(255, 127, 80),
            Increment = 1,
            ValueName = "ms",
            Callback = function(Value)
                dodgeSleep = Value
            end
        }
    )
    updatePlayerNames()

    Tab:AddButton(
        {
            Name = "Rip Heart",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Rip Heart"].RemoteEvent:FireServer(
                                ohInstance1
                            )
                        end
                    end
                    if teleportBack then
                        wait(tpWaitTime)
                        localHrp.CFrame = originalCFrame
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Compulsion",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Compulsion"].RemoteEvent:FireServer(
                                ohInstance1
                            )
                        end
                    end
                    if teleportBack then
                        wait(tpWaitTime)
                        localHrp.CFrame = originalCFrame
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Bite",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Bite"].RemoteEvent:FireServer(
                                ohInstance1,
                                true
                            )
                        end
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "UnBite",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Bite"].RemoteEvent:FireServer(
                                ohInstance1,
                                false
                            )
                        end
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Feed Blood",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Feed Blood"].RemoteEvent:FireServer(
                                ohInstance1
                            )
                        end
                    end
                    if teleportBack then
                        wait(tpWaitTime)
                        localHrp.CFrame = originalCFrame
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Decapitate",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Decapitate"].RemoteEvent:FireServer(
                                ohInstance1
                            )
                        end
                    end
                    if teleportBack then
                        wait(tpWaitTime)
                        localHrp.CFrame = originalCFrame
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Snap neck",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                        if ohInstance1 then
                            workspace.CharacterModels[players.LocalPlayer.Name]["Snap Neck"].RemoteEvent:FireServer(
                                ohInstance1
                            )
                        end
                    end
                    if teleportBack then
                        wait(tpWaitTime)
                        localHrp.CFrame = originalCFrame
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )
    Tab:AddButton(
        {
            Name = "Carry",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohBoolean1 = true
                        local ohInstance2 = workspace.CharacterModels[playerName]

                        workspace.CharacterModels[localPlayerName].Carry.RemoteEvent:FireServer(ohBoolean1, ohInstance2)
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )
    Tab:AddButton(
        {
            Name = "UnCarry",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end
                    for i = 1, 1 do
                        local ohBoolean1 = false
                        local ohInstance2 = workspace.CharacterModels[playerName]

                        workspace.CharacterModels[localPlayerName].Carry.RemoteEvent:FireServer(ohBoolean1, ohInstance2)
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Out of Map",
            Callback = function()
                if playerName and playerName ~= "Select player" and playerName ~= players.LocalPlayer.Name then
                    if teleportBack then
                        originalCFrame = localHrp.CFrame
                    end

                    for i = 1, 1 do
                        print(playerName)
                        local players = game:GetService("Players")
                        local localPlayer = players.LocalPlayer

                        local position = nil

                        local character = localPlayer.Character
                        if character and character:FindFirstChild("HumanoidRootPart") then
                            position = character.HumanoidRootPart.Position
                            print("Current Position: ", position)
                        else
                            warn("HumanoidRootPart not found!")
                        end

                        local ohBoolean1 = true
                        workspace.CharacterModels[localPlayerName]["Bat Transform"].RemoteEvent:FireServer(ohBoolean1)
                        wait(0.5)
                        local ohBoolean1 = true
                        local ohInstance2 = workspace.CharacterModels[playerName]

                        workspace.CharacterModels[localPlayerName].Carry.RemoteEvent:FireServer(ohBoolean1, ohInstance2)

                        local players = game:GetService("Players")
                        local localPlayer = players.LocalPlayer
                        local targetPosition = Vector3.new(-350, 724, -1464) -- Укажите здесь нужные координаты

                        local function teleportTo(position)
                            local character = localPlayer.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                character.HumanoidRootPart.CFrame = CFrame.new(position)
                            else
                                warn("HumanoidRootPart not found!")
                            end
                        end

                        teleportTo(targetPosition)

                        wait(45)

                        local ohBoolean1 = false
                        local ohInstance2 = workspace.CharacterModels[playerName]

                        workspace.CharacterModels[localPlayerName].Carry.RemoteEvent:FireServer(ohBoolean1, ohInstance2)

                        teleportTo(position)
                    end
                else
                    OLib:MakeNotification(
                        {
                            Name = "Invalid player!",
                            Content = "Please, select a valid player!",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        }
                    )
                end
            end
        }
    )

    Tab:AddDropdown(
        {
            Name = "Kill All Player in Team",
            Default = "1",
            Options = {"Vampire", "Witch", "Werewolf", "Hybrid", "Human"},
            Callback = function(Value)
                local players = game:GetService("Players")
                local localPlayer = players.LocalPlayer

                -- Функция для убийства игрока
                local function killPlayer(playerName)
                    local ohInstance1 = workspace.CharacterModels:FindFirstChild(playerName)
                    if ohInstance1 then
                        workspace.CharacterModels[localPlayer.Name]["Decapitate"].RemoteEvent:FireServer(ohInstance1)
                    else
                        warn("Player " .. playerName .. " not found in CharacterModels")
                    end
                end

                -- Функция для убийства всех игроков из группы, кроме localPlayer и тех, кто в whitelisted
                local function killAllPlayersInTeamExceptLocalPlayerAndWhitelisted()
                    for _, player in pairs(players:GetPlayers()) do
                        if
                            player.Team and player.Team.Name == Value and player ~= localPlayer and
                                not table.find(whitelisted, player.Name)
                         then
                            killPlayer(player.Name)
                        end
                    end
                end

                -- Запуск функции для убийства всех игроков из группы, кроме localPlayer и whitelisted
                killAllPlayersInTeamExceptLocalPlayerAndWhitelisted()
                wait(4.5)
                killAllPlayersInTeamExceptLocalPlayerAndWhitelisted()
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Decapitate All",
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
        }
    )

    Tab:AddButton(
        {
            Name = "Rip Heart All",
            Callback = function()
                local myUsername = players.LocalPlayer.Name

                if teleportBack then
                    originalCFrame = localHrp.CFrame
                end

                for _, player in pairs(players:GetPlayers()) do
                    if player.Name ~= myUsername and not table.find(whitelisted, player.Name) then
                        for i = 1, 1 do
                            local ohInstance1 = workspace.CharacterModels[player.Name]
                            workspace.CharacterModels[myUsername]["Rip Heart"].RemoteEvent:FireServer(ohInstance1)
                        end
                        print("Killed " .. player.Name)
                    end
                end
                if teleportBack then
                    wait(tpWaitTime)
                    localHrp.CFrame = originalCFrame
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Feed Blood All",
            Callback = function()
                local myUsername = players.LocalPlayer.Name

                if teleportBack then
                    originalCFrame = localHrp.CFrame
                end

                for _, player in pairs(players:GetPlayers()) do
                    if player.Name ~= myUsername and not table.find(whitelisted, player.Name) then
                        for i = 1, 1 do
                            local ohInstance1 = workspace.CharacterModels[player.Name]
                            workspace.CharacterModels[myUsername]["Feed Blood"].RemoteEvent:FireServer(ohInstance1)
                        end
                        print("Killed " .. player.Name)
                    end
                end
                if teleportBack then
                    wait(tpWaitTime)
                    localHrp.CFrame = originalCFrame
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Snap Neck All",
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
        }
    )
    Tab:AddButton(
        {
            Name = "Compulsion All",
            Callback = function()
                local myUsername = players.LocalPlayer.Name

                if teleportBack then
                    originalCFrame = localHrp.CFrame
                end

                for _, player in pairs(players:GetPlayers()) do
                    if player.Name ~= myUsername and not table.find(whitelisted, player.Name) then
                        for i = 1, 1 do
                            local ohInstance1 = workspace.CharacterModels[player.Name]
                            workspace.CharacterModels[myUsername]["Compulsion"].RemoteEvent:FireServer(ohInstance1)
                        end
                        print("Killed " .. player.Name)
                    end
                end
                if teleportBack then
                    wait(tpWaitTime)
                    localHrp.CFrame = originalCFrame
                end
            end
        }
    )

    Tab:AddLabel("Server crashers")

    Tab:AddButton(
        {
            Name = "Crash server",
            Callback = function()
                local players = game:GetService("Players")
                local myUsername = players.LocalPlayer.Name

                OLib:MakeNotification(
                    {
                        Name = "Server crasher",
                        Content = "Trying to crash server...\nMethod: Players",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    }
                )

                local running = true
                while running do
                    for _, player in pairs(players:GetPlayers()) do
                        if player.Name ~= myUsername and not table.find(whitelisted, player.Name) then
                            pcall(
                                function()
                                    for i = 1, 50 do
                                        local ohInstance1 = workspace.CharacterModels[player.Name]
                                        workspace.CharacterModels[myUsername]["Snap Neck"].RemoteEvent:FireServer(
                                            ohInstance1
                                        )
                                        print("Killed " .. player.Name)
                                    end
                                end
                            )
                        end
                    end
                    wait(0.1) -- To avoid infinite loop freeze
                end
            end
        }
    )

    Tab:AddButton(
        {
            Name = "Crash server through villagers",
            Callback = function()
                local players = game:GetService("Players")
                local myUsername = players.LocalPlayer.Name

                OLib:MakeNotification(
                    {
                        Name = "Server crasher",
                        Content = "Trying to crash server...\nMethod: Villagers",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    }
                )

                local running = true
                while running do
                    pcall(
                        function()
                            for i = 1, 50 do
                                local ohInstance1 = workspace.CharacterModels.Villager
                                workspace.CharacterModels[myUsername]["Snap Neck"].RemoteEvent:FireServer(ohInstance1)
                                print("Killed Villager")
                            end
                        end
                    )
                    wait(0.1) -- To avoid infinite loop freeze
                end
            end
        }
    )

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

    players.PlayerAdded:Connect(
        function(player)
            updatePlayerNames()
        end
    )

    players.PlayerRemoving:Connect(
        function(player)
            updatePlayerNames()
        end
    )
end

if table.find(whitelisted, players.LocalPlayer.Name) then
    init_vlk()
else
    init_auth()
end
