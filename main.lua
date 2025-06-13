local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Saturn Hub",
	Subtitle = nil,
	LogoID = "86704560187347",
	LoadingEnabled = true,
	LoadingTitle = "Saturn Hub Loader",
	LoadingSubtitle = "by coolio",

	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "SaturnHub"
	},
	
	KeySystem = false,
	KeySettings = {
		Title = "Saturn Hub",
		Subtitle = "Key System",
		Note = "Join the Discord server in order to get the key.",
		SaveInRoot = false,
		SaveKey = false, 
		Key = {""},
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

local Tab = Window:CreateTab({
	Name = "Info",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Luna:LoadAutoloadConfig()
