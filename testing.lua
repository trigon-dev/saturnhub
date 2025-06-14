-- CONFIGURE THESE URLS
local pastebinGamesURL = "https://pastebin.com/raw/YOUR_GAMES_PASTE_ID"

-- Fetch supported games list from Pastebin
local function fetchSupportedGames()
    local success, response = pcall(function()
        return game:HttpGet(pastebinGamesURL)
    end)
    if success then
        local successDecode, result = pcall(function()
            return loadstring("return " .. response)()
        end)
        if successDecode and type(result) == "table" then
            return result
        end
    end
    return {}
end

-- Universal fallback tab UI
local function runUniversalFallback(Window)
    Window:Notify({
        Title = "Unsupported Game",
        Description = "Loading Universal fallback tab.",
        Duration = 5
    })

    local UniversalTab = Window:CreateTab({
        Name = "Universal",
        Icon = "view_in_ar",
        ImageSource = "Material",
        ShowTitle = true
    })

    UniversalTab:CreateSection("Admin")

    UniversalTab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })

    UniversalTab:CreateButton({
        Name = "Nameless Admin",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
        end
    })

    UniversalTab:CreateButton({
        Name = "AK Admin",
        Callback = function()
            loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
        end
    })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("FE")

    UniversalTab:CreateButton({
        Name = "Stalkie",
        Callback = function()
            repeat task.wait() until game.Players.LocalPlayer
            loadstring(game:HttpGet("https://raw.githubusercontent.com/0riginalWarrior/Stalkie/refs/heads/main/roblox.lua"))()
        end
    })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("Script Hubs")

    UniversalTab:CreateButton({
        Name = "Speed Hub X",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        end
    })

    UniversalTab:CreateButton({
        Name = "Forge Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
        end
    })
end

-- Detect and run game-specific script
local function runDetectedGame(Window, supportedGames)
    local gameId = game.PlaceId
    local gameData = supportedGames[gameId]
    if gameData then
        Window:Notify({
            Title = "Game Detected",
            Description = "Detected supported game: " .. gameData.Name,
            Duration = 5
        })
        if type(gameData.ScriptURL) == "string" then
            loadstring(game:HttpGet(gameData.ScriptURL))()
        end
    else
        runUniversalFallback(Window)
    end
end

-- Load Luna UI
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua", true))()

local supportedGames = fetchSupportedGames()

local Window = Luna:CreateWindow({
    Name = "Saturn Hub",
    Subtitle = "BETA",
    LogoID = "86704560187347",
    LoadingEnabled = true,
    LoadingTitle = "Saturn Hub",
    LoadingSubtitle = "by coolio",

    ConfigSettings = {
        RootFolder = nil,
        ConfigFolder = "saturnhub"
    },

    KeySystem = false -- disabled
})

-- Create a basic Home tab for UI completeness
Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "TyevewM7Jc",
    Icon = 1,
})

-- Create a Games tab (optional)
Window:CreateTab({
    Name = "Games",
    Icon = "view_in_ar",
    ImageSource = "Material",
    ShowTitle = true
})

-- Automatically detect game and run script or fallback UI
task.defer(function()
    runDetectedGame(Window, supportedGames)
end)
