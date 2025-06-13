local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()

local Window = Luna:CreateWindow({
	Name = "Saturn Hub",
	Subtitle = nil,
	LogoID = "86704560187347",
	LoadingEnabled = true,
	LoadingTitle = "Saturn Loader",
	LoadingSubtitle = "by coolio",

	ConfigSettings = {
		RootFolder = nil,
		ConfigFolder = "SaturnHub"
	},

	KeySystem = false,
	KeySettings = {
		Title = "Saturn Hub",
		Subtitle = "Key System",
		Note = "",
		SaveInRoot = false,
		SaveKey = true,
		Key = {"Example Key"},
		SecondAction = {
			Enabled = true,
			Type = "Link",
			Parameter = ""
	}
})
