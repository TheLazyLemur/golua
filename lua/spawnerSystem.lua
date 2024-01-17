local tiny = require("tiny")
local rl = require("wrapper")
local Enemy = require("enemy")

local spawnSystem = tiny.processingSystem()
spawnSystem.filter = tiny.requireAll("spawner")
spawnSystem.runTime = 0

function spawnSystem:process(e, dt)
	e.spawnTime = e.spawnTime - dt
	self.runTime = self.runTime + dt

	if e.spawnTime <= 0 then
		spawnSystem.world.addEntity(
			spawnSystem.world,
			Enemy:new(rl.getScreenWidth() + 200, rl.getRandomValue(0, rl.getScreenHeight()), 50, 30)
		)

		if self.runTime > 10 then
			e.spawnTime = 0.25
		else
			if self.runTime < 2 then
				e.spawnTime = 1
			end

			if self.runTime > 2 then
				e.spawnTime = 0.5
			end
		end
	end
end

return spawnSystem
