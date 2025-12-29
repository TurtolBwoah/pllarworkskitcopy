--!optimize 2
--!native

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local framework = require("@pkg/framework")

return function(singletons: { framework.singleton })
	local config = framework.run({
		singletons = singletons,
		lifecycles = { "init", "start", "stop" },
	})

	if RunService:IsServer() then
		game:BindToClose(function()
			framework.stop(config)
		end)
	else
		local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
		local character = player.Character or player.CharacterAdded:Wait()

		local humanoid = character:WaitForChild("Humanoid")
		local connection: RBXScriptConnection?

		connection = humanoid.Died:Connect(function()
			framework.stop(config)

			if connection and typeof(connection) == "RBXScriptConnection" then
				connection:Disconnect()
				connection = nil
			end
		end)
	end
end
