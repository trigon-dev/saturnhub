local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local hiddenfling = false
local connections = {}

local function getRoot(character)
	return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
end

local function enableWalkfling()
	if hiddenfling then return end
	hiddenfling = true

	connections["fling"] = RunService.Heartbeat:Connect(function()
		if not hiddenfling then return end

		local player = Players.LocalPlayer
		local character = player and player.Character
		local hrp = character and getRoot(character)

		if hrp then
			local originalVelocity = hrp.Velocity
			hrp.Velocity = originalVelocity * 10000 + Vector3.new(0, 10000, 0)

			RunService.RenderStepped:Wait()
			if hrp then
				hrp.Velocity = originalVelocity
			end

			RunService.Stepped:Wait()
			if hrp then
				hrp.Velocity = originalVelocity + Vector3.new(0, 0.1, 0)
			end
		end
	end)
end

local function disableWalkfling()
	if not hiddenfling then return end
	hiddenfling = false

	for _, conn in pairs(connections) do
		if conn then conn:Disconnect() end
	end
	table.clear(connections)
end

local function onCharacterAdded(character)
	disableWalkfling()
	enableWalkfling()
end

local player = Players.LocalPlayer

if player.Character then
	onCharacterAdded(player.Character)
end

player.CharacterAdded:Connect(onCharacterAdded)
