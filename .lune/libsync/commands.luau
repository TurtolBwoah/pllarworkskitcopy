local richterm = require("@vendor/richterm")

export type command = {
	command: string,
	colour: richterm.Formatter,
	args: { string },
}

return {
	{
		command = "rojo",
		colour = richterm.red,
		args = {
			"sourcemap",
			"default.project.json",
			"--output",
			"sourcemap.json",
			"--watch",
		},
	},

	{
		command = "blink",
		colour = richterm.yellow,
		args = { "ext/network/core.blink", "--watch" },
	},

	{
		command = "darklua",
		colour = richterm.magenta,
		args = { "process", "src", "out", "--watch" },
	},

	{
		command = "rojo",
		colour = richterm.red,
		args = { "serve", "game.project.json" },
	},
} :: { command }
