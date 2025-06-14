local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local screenGui
local textBox
local updateConnection

local function createGui(rootPart)
    if screenGui then
        screenGui:Destroy()
        screenGui = nil
    end
    if updateConnection then
        updateConnection:Disconnect()
        updateConnection = nil
    end

    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(0, 300, 0, 50)
    shadow.Position = UDim2.new(0, 12, 0, 12)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.6
    shadow.BorderSizePixel = 0
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 10)
    shadowCorner.Parent = shadow
    shadow.Parent = screenGui

    textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 300, 0, 50)
    textBox.Position = UDim2.new(0, 10, 0, 10)
    textBox.ClearTextOnFocus = false
    textBox.TextEditable = true
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    textBox.BackgroundTransparency = 0
    textBox.BorderSizePixel = 1
    textBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
    textBox.Text = ""

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = textBox

    textBox.Parent = screenGui

    updateConnection = RunService.RenderStepped:Connect(function()
        if not textBox:IsFocused() then
            local pos = rootPart.Position
            textBox.Text = string.format("%.9f, %.9f, %.9f", pos.X, pos.Y, pos.Z)
        end
    end)
end

local function onCharacterAdded(character)
    local rootPart = character:WaitForChild("HumanoidRootPart")
    createGui(rootPart)
end

if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)
