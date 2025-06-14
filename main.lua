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
        gamesTab:CreateButton({
            Name = "Run Script",
            Callback = function()
                local s = gameData.Scripts[1]
                if s and s.URL ~= "" then
                    loadstring(game:HttpGet(s.URL, true))()
                else
                    warn("No script URL found.")
                end
            end
        })
    else
        runUniversalFallback()
    end
end

task.defer(runDetectedGame)
