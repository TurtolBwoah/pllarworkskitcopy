local process = require("@lune/process")
local task = require("@lune/task")

return function(command: string, args: { string }, options: process.ExecOptions)
	local can_continue = false

	local process_success: boolean?
	local process_result: process.ExecResult?

	task.spawn(function()
		local thread = coroutine.create(function()
			return process.exec(command, args, options)
		end)

		local success: boolean, result: process.ExecResult = coroutine.resume(thread)

		can_continue = true

		process_success = success
		process_result = result
	end)

	repeat
		task.wait()
	until can_continue

	return {
		success = process_success,
		result = process_result,
	}
end
