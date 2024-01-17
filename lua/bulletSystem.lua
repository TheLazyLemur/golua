local rl = require("wrapper")
local tiny = require("tiny")
local Bullet = require("bullet")

local bulletSystem = tiny.processingSystem()
bulletSystem.filter = tiny.requireAll("bullet")

function bulletSystem:preProcess(_)
	if not self.hasStarted then
		self.world:AddEventListener("gun_fired", function(x, y, height)
			local ent = Bullet:new(x, y + (height / 2) - 2.5 - 5)
			self.world.addEntity(self.world, ent)
		end)
		self.hasStarted = true
	end
end

function bulletSystem:process(e, dt)
	e.x = e.x + 700 * dt
	if e.x > rl.getScreenWidth() then
		self.world.removeEntity(self.world, e)
	end
end

return bulletSystem
