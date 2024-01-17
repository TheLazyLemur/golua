local tiny = require("tiny")
local rl = require("wrapper")

local wrappingSystem = tiny.processingSystem()
wrappingSystem.filter = tiny.requireAll("x", "y", "movespeed")

function wrappingSystem:process(e, _)
	e.x = e.x % rl.getScreenWidth()
	e.y = e.y % rl.getScreenHeight()
end

return wrappingSystem
