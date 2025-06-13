local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Saturn Hub",
	Subtitle = nil,
	LogoID = "86704560187347",
	LoadingEnabled = true,
	LoadingTitle = "Saturn Hub is loading",
	LoadingSubtitle = "by coolio",

	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "SaturnHub"
	},
	
	KeySystem = true,
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
			Parameter = "https://discord.com/invite/TyevewM7Jc"
		}
	}
})

local Tab = Window:CreateTab({
	Name = "Home",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
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

Luna:LoadAutoloadConfig()
