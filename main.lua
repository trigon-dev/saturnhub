local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Saturn Hub",
	Subtitle = nil,
	LogoID = "rbxassetid://109296600971739",
	LoadingEnabled = true,
	LoadingTitle = "Saturn Hub",
	LoadingSubtitle = "by coolio",

	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "saturnhub"
	},
	
	KeySystem = false,
	KeySettings = {
		Title = "Saturn Hub",
		Subtitle = "Key System",
		Note = "Join the Discord server to get the key.",
		SaveInRoot = false,
		SaveKey = true, 
		Key = {"release"},
		SecondAction = {
			Enabled = false,
			Type = "Link",
			Parameter = "https://discord.gg/TyevewM7Jc"
		}
	}
})

Window:CreateHomeTab({
	SupportedExecutors = {},
	DiscordInvite = "TyevewM7Jc",
	Icon = 1,
})

local Tab = Window:CreateTab({
	Name = "Games",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

local Tab = Window:CreateTab({
	Name = "Univeral",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Tab:CreateSection("Admin")

local Button = Tab:CreateButton({
	Name = "Infinite Yield",
	Description = nil,
    	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    	end
})

local Button = Tab:CreateButton({
	Name = "Nameless Admin",
	Description = nil,
    	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
    	end
})


local Button = Tab:CreateButton({
	Name = "AK Admin",
	Description = nil,
    	Callback = function()
        loadstring(game:HttpGet("https://angelical.me/ak.lua"))()
    	end
})

Tab:CreateDivider()

Tab:CreateSection("FE")

--[[

local Button = Tab:CreateButton({
	Name = "",
	Description = nil,
    	Callback = function()
        
    	end
})

]]

Tab:CreateDivider()

Tab:CreateSection("Script Hubs")

local Button = Tab:CreateButton({
	Name = "Speed Hub X",
	Description = nil,
    	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    	end
})

local Button = Tab:CreateButton({
	Name = "Forge Hub",
	Description = nil,
    	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua"))()
    	end
})

local Tab = Window:CreateTab({
	Name = "Info",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

local Label = Tab:CreateLabel({
	Text = "Version: 1.0.1",
	Style = 2
})

local Label = Tab:CreateLabel({
	Text = "Updated: 6/13/2025",
	Style = 2
})

local Tab = Window:CreateTab({
	Name = "Configs",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Configs:BuildConfigSection()

local Tab = Window:CreateTab({
	Name = "Settings",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Settings:BuildThemeSection()

Luna:LoadAutoloadConfig()
