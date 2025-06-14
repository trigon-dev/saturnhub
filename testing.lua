-- Hard‑coded supported games list
local supportedGames = {
    [3823781113] = {
        Name      = "Saber Simulator",
        ScriptURL = "https://rawscripts.net/raw/Saber-Simulator-REVAMP-Op-Gui-41756"
    },
    [126884695634066] = {
        Name      = "Grow a Garden",
        ScriptURL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"
    }
}

-- Roblox services
local TeleportService = game:GetService("TeleportService")
local Players         = game:GetService("Players")
local HttpService     = game:GetService("HttpService")

-- Server utilities
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

-- Universal fallback tab UI
local function runUniversalFallback(Window, Luna)
    Luna:Notification({
        Title       = "Unsupported Game",
        Icon        = "notifications_active",
        ImageSource = "Material",
        Content     = "Only the Universal tab is available."
    })

    local UniversalTab = Window:CreateTab({
        Name        = "Universal",
        Icon        = "view_in_ar",
        ImageSource = "Material",
        ShowTitle   = true
    })

    UniversalTab:CreateSection("Admin")
    UniversalTab:CreateButton({ Name = "Infinite Yield", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end })
    UniversalTab:CreateButton({ Name = "Nameless Admin", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
    end })
    UniversalTab:CreateButton({ Name = "AK Admin", Callback = function()
        loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
    end })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("FE")
    UniversalTab:CreateButton({ Name = "Stalkie", Callback = function()
        repeat task.wait() until Players.LocalPlayer
        loadstring(game:HttpGet("https://raw.githubusercontent.com/0riginalWarrior/Stalkie/refs/heads/main/roblox.lua"))()
    end })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("Script Hubs")
    UniversalTab:CreateButton({ Name = "Speed Hub X", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end })
    UniversalTab:CreateButton({ Name = "Forge Hub", Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
    end })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("Server Utilities")
    UniversalTab:CreateButton({ Name = "Rejoin",      Callback = rejoin      })
    UniversalTab:CreateButton({ Name = "Serverhop",    Callback = serverhop    })
    UniversalTab:CreateButton({ Name = "Small Server", Callback = smallServer })
end

-- Detect and run game‑specific script (and create its tab)
local function runDetectedGame(Window, Luna)
    local gameId   = game.PlaceId
    local gameData = supportedGames[gameId]

    if gameData then
        Luna:Notification({
            Title       = "Game Detected",
            Icon        = "notifications_active",
            ImageSource = "Material",
            Content     = "Detected supported game: " .. gameData.Name
        })

        local GamesTab = Window:CreateTab({
            Name        = "Games",
            Icon        = "view_in_ar",
            ImageSource = "Material",
            ShowTitle   = true
        })

        GamesTab:CreateButton({
            Name     = gameData.Name,
            Callback = function()
                loadstring(game:HttpGet(gameData.ScriptURL))()
            end
        })
    else
        runUniversalFallback(Window, Luna)
    end
end

-- Load Luna UI
local Luna = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua",
    true
))()

local Window = Luna:CreateWindow({
    Name            = "Saturn Hub",
    Subtitle        = "BETA",
    LogoID          = "86704560187347",
    LoadingEnabled  = true,
    LoadingTitle    = "Saturn Hub",
    LoadingSubtitle = "by coolio",

    ConfigSettings = {
        RootFolder   = nil,
        ConfigFolder = "saturnhub"
    },

    KeySystem = false
})

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite     = "TyevewM7Jc",
    Icon               = 1
})

-- Auto‑detect on load
task.defer(function()
    runDetectedGame(Window, Luna)
end)
