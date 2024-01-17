local rl = require("wrapper")
local pickup = require("pickup")

local tiny = require("tiny")

local dropperSystem = tiny.processingSystem()
dropperSystem.filter = tiny.requireAll("dropper")

function dropperSystem:process(e, dt)
	if rl.getRandomValue(0, 100) >= 75 then
		dropperSystem.world.addEntity(dropperSystem.world, pickup:new(e.x, e.y, 10, 10))
		dropperSystem.world.removeEntity(dropperSystem.world, e)
	else
		dropperSystem.world.removeEntity(dropperSystem.world, e)
	end
end

return dropperSystem
