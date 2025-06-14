-- CONFIGURE THESE URLS
local pastebinKeyURL = "https://pastebin.com/raw/nANC0S82"
local pastebinGamesURL = "https://pastebin.com/raw/7P7BEmKP"

-- Fetch the key from Pastebin
local function fetchKey()
    local success, response = pcall(function()
        return game:HttpGet(pastebinKeyURL)
    end)
    if success and response and response ~= "" then
        return response
    else
        return nil
    end
end

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
    print("Unsupported game detected. Loading Universal tab...")

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
        print("Detected supported game:", gameData.Name)
        if type(gameData.ScriptURL) == "string" then
            loadstring(game:HttpGet(gameData.ScriptURL))()
        end
    else
        warn("Unsupported game.")
        runUniversalFallback(Window)
    end
end

-- Load Luna UI
local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/main/source.lua", true))()

local dynamicKey = fetchKey() or "default-key"
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

    KeySystem = true,
    KeySettings = {
        Title = "Saturn Hub",
        Subtitle = "Key System",
        Note = "Auto-detected key",
        SaveInRoot = false,
        SaveKey = true,
        Key = {dynamicKey},
        SecondAction = {
            Enabled = false,
            Type = "Link",
            Parameter = ""
        }
    }
})

-- Create a basic Home tab for UI completeness
Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite = "TyevewM7Jc",
    Icon = 1,
})

-- Create a Games tab (optional, you can add more)
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
