local supportedGames = {
    [3823781113] = {
        Name    = "Saber Simulator",
        Scripts = {
            { Name = "1",      URL = "https://rawscripts.net/raw/Saber-Simulator-REVAMP-Op-Gui-41756" },
            { Name = "2",      URL = "" },
            { Name = "3",      URL = "" },
            { Name = "4",      URL = "" },
            { Name = "5",      URL = "" },
        }
    },
    [126884695634066] = {
        Name    = "Grow a Garden",
        Scripts = {
            { Name = "1",      URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" },
            { Name = "2",      URL = "" },
            { Name = "3",      URL = "" },
            { Name = "4",      URL = "" },
            { Name = "5",      URL = "" },
        }
    }
}

local TeleportService = game:GetService("TeleportService")
local Players         = game:GetService("Players")
local HttpService     = game:GetService("HttpService")

local function rejoin()
    TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
end

local function serverhop()
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
    local success, data = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url)).data
    end)
    if success and data then
        for _, s in ipairs(data) do
            if s.playing < s.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, Players.LocalPlayer)
                return
            end
        end
    end
end

local function smallServer()
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
    local success, data = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url)).data
    end)
    if success and data and #data > 0 then
        table.sort(data, function(a,b) return a.playing < b.playing end)
        TeleportService:TeleportToPlaceInstance(game.PlaceId, data[1].id, Players.LocalPlayer)
    end
end

local Luna = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua",
    true
))()

local Window = Luna:CreateWindow({
    Name            = "Saturn Hub",
    Subtitle        = "v1.0",
    LogoID          = "7251671408",
    LoadingEnabled  = true,
    LoadingTitle    = "Saturn Hub",
    LoadingSubtitle = "by coolio",
    ConfigSettings  = {
        RootFolder   = nil,
        ConfigFolder = "saturnhub"
    },
    KeySystem = false
})

Window:LoadConfig()
Window:OnClose(function()
    Window:SaveConfig()
end)

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite     = "TyevewM7Jc",
    Icon               = 1
})

local function addAdvancedControls(tab)
    tab:CreateSection("Advanced Controls")
    tab:CreateToggle({
        Name    = "Enable God Mode",
        Default = false,
        Callback = function(state)
            print("God Mode is now", state)
        end
    })
    tab:CreateSlider({
        Name      = "Walk Speed",
        Min       = 16,
        Max       = 100,
        Default   = 16,
        Precision = 1,
        Callback  = function(value)
            if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end
    })
    tab:CreateTextbox({
        Name                       = "Custom Message",
        Placeholder                = "Type here…",
        Default                    = "",
        RemoveTextAfterFocusLost   = false,
        Callback                   = function(text)
            print("Textbox input:", text)
        end
    })
    tab:CreateDropdown({
        Name    = "Choose Team",
        Options = {"Red", "Blue", "Green"},
        Default = "Red",
        Callback = function(choice)
            print("Team selected:", choice)
        end
    })
    tab:CreateKeybind({
        Name     = "Toggle UI",
        Default  = Enum.KeyCode.RightControl,
        Mode     = "Toggle",
        Callback = function()
            Window:Toggle()
        end
    })
    tab:CreateColorPicker({
        Name    = "UI Accent Color",
        Default = Color3.fromRGB(255,255,255),
        Callback = function(color)
            Window:SetAccentColor(color)
        end
    })
end

local function runUniversalFallback()
    local universalTab = Window:CreateTab({
        Name        = "Universal",
        Icon        = "view_in_ar",
        ImageSource = "Material",
        ShowTitle   = true
    })
    universalTab:CreateSection("Admin")
    universalTab:CreateButton({ Name = "Infinite Yield", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end })
    universalTab:CreateButton({ Name = "Nameless Admin", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
    end })
    universalTab:CreateButton({ Name = "AK Admin", Callback = function()
        loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
    end })
    universalTab:CreateDivider()
    universalTab:CreateSection("FE")
    universalTab:CreateButton({ Name = "Stalkie", Callback = function()
        repeat task.wait() until Players.LocalPlayer
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0riginalWarrior/Stalkie/refs/heads/main/roblox.lua"))()
    end })
    universalTab:CreateDivider()
    universalTab:CreateSection("Script Hubs")
    universalTab:CreateButton({ Name = "Speed Hub X", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end })
    universalTab:CreateButton({ Name = "Forge Hub", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
    end })
    universalTab:CreateDivider()
    universalTab:CreateSection("Server Utilities")
    universalTab:CreateButton({ Name = "Rejoin",      Callback = rejoin      })
    universalTab:CreateButton({ Name = "Serverhop",    Callback = serverhop    })
    universalTab:CreateButton({ Name = "Small Server", Callback = smallServer })
    addAdvancedControls(universalTab)
end

local function runDetectedGame()
    local gameId   = game.PlaceId
    local gameData = supportedGames[gameId]
    if gameData then
        local gamesTab = Window:CreateTab({
            Name        = "Games",
            Icon        = "view_in_ar",
            ImageSource = "Material",
            ShowTitle   = true
        })
        gamesTab:CreateSection("Scripts")
        local scriptNames = {}
        for _, s in ipairs(gameData.Scripts) do
            table.insert(scriptNames, s.Name)
        end
        local selected = scriptNames[1]
        gamesTab:CreateDropdown({
            Name    = "Choose Script",
            Options = scriptNames,
            Default = selected,
            Callback = function(choice)
                selected = choice
            end
        })
        gamesTab:CreateButton({
            Name = "Run Script",
            Callback = function()
                for _, s in ipairs(gameData.Scripts) do
                    if s.Name == selected then
                        loadstring(game:HttpGet(s.URL, true))()
                        return
                    end
                end
                warn("No matching script URL found for “" .. selected .. "”")
            end
        })
        addAdvancedControls(gamesTab)
    else
        runUniversalFallback()
    end
end

task.defer(runDetectedGame)
