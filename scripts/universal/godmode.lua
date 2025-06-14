local function enableGodMode()
    local character = game.Players.LocalPlayer.Character
    if not character then return end

    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
            part.Anchored = false
            part:SetAttribute("OriginalTransparency", part.Transparency)
            part.Transparency = 0.5
        end
    end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Name = "1"
        humanoid.Health = humanoid.MaxHealth
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoid.PlatformStand = false
    end

    character:FindFirstChild("HumanoidRootPart").Anchored = false
end
