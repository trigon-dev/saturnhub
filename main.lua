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
	
	KeySystem = true,
	KeySettings = {
		Title = "Saturn Hub",
		Subtitle = "Key System",
		Note = "Join the Discord server in order to get the key.",
		SaveInRoot = false,
		SaveKey = true, 
		Key = {"88355ec02b04aaf581f0b74cc"},
		SecondAction = {
			Enabled = true,
			Type = "Link",
			Parameter = "https://discord.com/invite/TyevewM7Jc"
		}
	}
})
