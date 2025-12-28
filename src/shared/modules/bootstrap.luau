--!optimize 2
--!native

local framework = require("@pkg/framework")

return function(singletons: { framework.singleton })
	framework.run({
		singletons = singletons,
		lifecycles = { "init", "start", "stop" },
	})
end
