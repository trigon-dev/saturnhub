--===== CONFIGURATION =====--
local VersionURL = "https://raw.githubusercontent.com/trigon-dev/saturnhub/refs/heads/main/version.txt"
local HubURL     = "https://raw.githubusercontent.com/trigon-dev/saturnhub/refs/heads/main/main.lua"

-- fetch your current version from GitHub
local function fetchLocalVersion()
    local ok, res = pcall(function()
        return game:HttpGet(VersionURL, true)
    end)
    if ok and type(res) == "string" then
        return res:match("%S+")
    else
        return "0.0.0"  -- fallback if fetch fails
    end
end

local CurrentVersion = fetchLocalVersion()

--===== SERVICES =====--
local TeleportService = game:GetService("TeleportService")
local Players         = game:GetService("Players")
local HttpService     = game:GetService("HttpService")
local StarterGui      = game:GetService("StarterGui")

--===== GAME/SCRIPT DATA =====--
local supportedGames = {
    {
        ID = 3823781113,
        Name = "Saber Simulator",
        Scripts = {
            { Name = "Revamp OP Gui", URL = "https://rawscripts.net/raw/Saber-Simulator-REVAMP-Op-Gui-41756" },
            { Name = "NS Hub",        URL = "https://rawscripts.net/raw/Saber-Simulator-SUMMER-SUMMER-EVENT-AUTO-FARM-AUTO-BUY-AUTO-BOSS-41970" }
        }
    },
    {
        ID = 126884695634066,
        Name = "Grow a Garden",
        Scripts = {
            { Name = "Speed Hub X", URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" }
        }
    },
    {
        ID = 13127800756,
        Name = "Arm Wrestle Simulator",
        Scripts = {
            { Name = "NDS Hub", URL = "https://api.luarmor.net/files/v3/loaders/49f02b0d8c1f60207c84ae76e12abc1e.lua" }
        }
    },
    {
        ID = 3623096087,
        Name = "Muscle Legends",
        Scripts = {
            { Name = "Speed Hub X",   URL = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" },
            { Name = "Enchanted Hub", URL = "https://raw.githubusercontent.com/iblameaabis/Enchanted/refs/heads/main/Enchanted%20Hub%20On%20Top" }
        }
    },
    {
        ID = 6403373529,
        Name = "Slap Battles",
        Scripts = {
            { Name = "Forge Hub", URL = "https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua" }
        }
    },
    {
        ID = 2753915549,
        Name = "Blox Fruits",
        Scripts = {
            { Name = "Redz Hub", URL = "https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau" }
        }
    },
    {
        ID = 10449761463,
        Name = "The Strongest Battlegrounds",
        Scripts = {
            { Name = "Kukuri Client", URL = "https://raw.githubusercontent.com/Mikasuru/Arc/refs/heads/main/Arc.lua" }
        }
    }
}

--===== UTILITY FUNCTIONS =====--
local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title    = title,
        Text     = text,
        Duration = duration or 5
    })
end

local function promptReload(title, text)
    StarterGui:SetCore("SendNotification", {
        Title    = title,
        Text     = text,
        Duration = 10,
        Button1  = "Reload",
        Button2  = "Later",
        Callback = function()
            Luna:Destroy()
            loadstring(game:HttpGet(HubURL, true))()
        end
    })
end

local function rejoin()
    TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
end

local function serverhop()
    local currentJobId = game.JobId
    while true do
        local ok, result = pcall(function()
            local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100")
                :format(game.PlaceId)
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        if ok and result and type(result.data) == "table" then
            for _, srv in ipairs(result.data) do
                if srv.playing < srv.maxPlayers and srv.id ~= currentJobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, Players.LocalPlayer)
                    return
                end
            end
        end
        task.wait(1)
    end
end

local function smallServer()
    local ok, result = pcall(function()
        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100")
            :format(game.PlaceId)
        return HttpService:JSONDecode(game:HttpGet(url)).data
    end)
    if ok and type(result) == "table" and #result > 0 then
        table.sort(result, function(a, b) return a.playing < b.playing end)
        TeleportService:TeleportToPlaceInstance(game.PlaceId, result[1].id, Players.LocalPlayer)
    end
end

--===== VERSION CHECKER =====--
local function checkForUpdates()
    local ok, res = pcall(function()
        return game:HttpGet(VersionURL, true)
    end)
    if ok and type(res) == "string" then
        local latest = res:match("%S+")
        if latest and latest ~= CurrentVersion then
            return true, latest
        end
    end
    return false, nil
end

--===== LOAD LUNA UI =======
local Luna = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua",
    true
))()

--===== CREATE MAIN WINDOW =======
local Window = Luna:CreateWindow({
    Name            = "Saturn Hub",
    Subtitle        = "v" .. CurrentVersion,
    LogoID          = "7251671408",
    LoadingEnabled  = true,
    LoadingTitle    = "Saturn Hub",
    LoadingSubtitle = "by coolio",
    KeySystem       = false
})

Window:CreateHomeTab({
    SupportedExecutors = {},
    DiscordInvite     = "TyevewM7Jc",
    Icon              = 1
})

--===== INITIAL UPDATE CHECK (deferred) =======
task.defer(function()
    local available, latest = checkForUpdates()
    if available then
        promptReload(
            "Saturn Hub",
            "Update available! v" .. latest .. " (you have v" .. CurrentVersion .. ")"
        )
    end
end)

--===== BUILD TABS =======
local function runDetectedGame()
    local currentGame
    for _, g in ipairs(supportedGames) do
        if g.ID == game.PlaceId then
            currentGame = g
            break
        end
    end

    if not currentGame then
        local ut = Window:CreateTab({
            Name        = "Universal",
            Icon        = "view_in_ar",
            ImageSource = "Material",
            ShowTitle   = true
        })

        ut:CreateSection("Admin")
        ut:CreateButton({ Name = "Infinite Yield", Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))()
        end })
        ut:CreateButton({ Name = "Nameless Admin", Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua", true))()
        end })
        ut:CreateButton({ Name = "AK Admin", Callback = function()
            loadstring(game:HttpGet("https://angelical.me/ak.lua", true))()
        end })

        ut:CreateDivider()
        ut:CreateSection("FE")
        ut:CreateButton({ Name = "Stalkie", Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/0riginalWarrior/Stalkie/refs/heads/main/roblox.lua", true))()
        end })

        ut:CreateDivider()
        ut:CreateSection("Script Hubs")
        ut:CreateButton({ Name = "Speed Hub X", Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        end })
        ut:CreateButton({ Name = "Forge Hub", Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua", true))()
        end })

        ut:CreateDivider()
        ut:CreateSection("Utilities")
        ut:CreateButton({ Name = "Rejoin",       Callback = rejoin })
        ut:CreateButton({ Name = "Serverhop",    Callback = serverhop })
        ut:CreateButton({ Name = "Small Server", Callback = smallServer })

        ut:CreateDivider()
        ut:CreateButton({
            Name = "Check for Updates",
            Callback = function()
                local available, latest = checkForUpdates()
                if available then
                    promptReload(
                        "Saturn Hub",
                        "Update available! v" .. latest .. " (you have v" .. CurrentVersion .. ")"
                    )
                else
                    notify("Saturn Hub", "You’re up to date (v" .. CurrentVersion .. ")", 5)
                end
            end
        })

        return
    end

    local tab = Window:CreateTab({
        Name        = "Scripts",
        Icon        = "view_in_ar",
        ImageSource = "Material",
        ShowTitle   = true
    })

    tab:CreateSection(currentGame.Name)
    for _, info in ipairs(currentGame.Scripts) do
        tab:CreateButton({
            Name     = info.Name,
            Callback = function()
                local okFetch, res = pcall(function()
                    return game:HttpGet(info.URL, true)
                end)
                if not (okFetch and type(res) == "string") then
                    notify("Saturn Hub", "Failed to load " .. info.Name, 4)
                    return
                end
                local okLoad, fnOrErr = pcall(loadstring, res)
                if not (okLoad and type(fnOrErr) == "function") then
                    notify("Saturn Hub", "Compile error in " .. info.Name, 4)
                    return
                end
                local okRun, runErr = pcall(fnOrErr)
                if not okRun then
                    notify("Saturn Hub", "Runtime error in " .. info.Name, 4)
                end
            end
        })
    end

    tab:CreateDivider()
    tab:CreateSection("Utilities")
    tab:CreateButton({ Name = "Rejoin",       Callback = rejoin })
    tab:CreateButton({ Name = "Serverhop",    Callback = serverhop })
    tab:CreateButton({ Name = "Small Server", Callback = smallServer })

    tab:CreateDivider()
    tab:CreateButton({
        Name = "Check for Updates",
        Callback = function()
            local available, latest = checkForUpdates()
            if available then
                promptReload(
                    "Saturn Hub",
                    "Update available! v" .. latest .. " (you have v" .. CurrentVersion .. ")"
                )
            else
                notify("Saturn Hub", "You’re up to date (v" .. CurrentVersion .. ")", 5)
            end
        end
    })
end

task.defer(runDetectedGame)
