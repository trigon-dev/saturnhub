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
    UniversalTab:CreateButton({
        Name     = "Infinite Yield",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
    UniversalTab:CreateButton({
        Name     = "Nameless Admin",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
        end
    })
    UniversalTab:CreateButton({
        Name     = "AK Admin",
        Callback = function()
            loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
        end
    })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("FE")
    UniversalTab:CreateButton({
        Name     = "Stalkie",
        Callback = function()
            repeat task.wait() until game.Players.LocalPlayer
            loadstring(game:HttpGet("https://raw.githubusercontent.com/0riginalWarrior/Stalkie/refs/heads/main/roblox.lua"))()
        end
    })

    UniversalTab:CreateDivider()
    UniversalTab:CreateSection("Script Hubs")
    UniversalTab:CreateButton({
        Name     = "Speed Hub X",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        end
    })
    UniversalTab:CreateButton({
        Name     = "Forge Hub",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
        end
    })
end

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
    ConfigSettings  = {
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

task.defer(function()
    runDetectedGame(Window, Luna)
end)
