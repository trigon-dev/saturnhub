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

	KeySystem = true,
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

local Tab = Window:CreateTab({
	Name = "Tab Example",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true
})

Tab:CreateSection("Section Example")

Section:Set("New Section Name")
Section:Destroy()

Tab:CreateDivider()

Luna:Destroy()

Luna:Notification({ 
	Title = "Saturn Hub Executed",
	Icon = "notifications_active",
	ImageSource = "Material",
	Content = "test"
})

Luna:LoadAutoloadConfig()
