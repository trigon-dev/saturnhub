local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local function createGui()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "CoordsDisplay"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(0, 300, 0, 40)
	textBox.Position = UDim2.new(0.5, -150, 0.85, -20)
	textBox.AnchorPoint = Vector2.new(0.5, 0.5)
	textBox.Text = ""
	textBox.TextScaled = true
	textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
	textBox.ClearTextOnFocus = false
	textBox.TextEditable = false
	textBox.Font = Enum.Font.SourceSans
	textBox.Parent = screenGui

	local copyButton = Instance.new("TextButton")
	copyButton.Size = UDim2.new(0, 200, 0, 40)
	copyButton.Position = UDim2.new(0.5, -100, 0.9, 0)
	copyButton.AnchorPoint = Vector2.new(0.5, 0)
	copyButton.Text = "Copy to Clipboard"
	copyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	copyButton.TextColor3 = Color3.new(1, 1, 1)
	copyButton.TextScaled = true
	copyButton.Parent = screenGui

	copyButton.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(textBox.Text)
			copyButton.Text = "Copied!"
		else
			copyButton.Text = "Copied (manual)"
		end
		wait(1.5)
		copyButton.Text = "Copy to Clipboard"
	end)

	return textBox
end

local coordBox = createGui()

local function highlightSpawn(spawn)
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Adornee = spawn
	selectionBox.Color3 = Color3.new(1, 1, 1)
	selectionBox.LineThickness = 0.05
	selectionBox.SurfaceTransparency = 1
	selectionBox.Parent = spawn
end

local function setupClickableSpawn(spawn)
	highlightSpawn(spawn)

	local clickDetector = Instance.new("ClickDetector")
	clickDetector.MaxActivationDistance = 20
	clickDetector.Parent = spawn

	clickDetector.MouseClick:Connect(function()
		local pos = spawn.Position
		local coordText = string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z)
		coordBox.Text = coordText
		print("Copied: " .. coordText)
	end)
end

for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("SpawnLocation") then
		setupClickableSpawn(obj)
	end
end

workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("SpawnLocation") then
		setupClickableSpawn(obj)
	end
end)
