local rl = require("wrapper")
local tiny = require("tiny")

local playerSystem = tiny.processingSystem()
playerSystem.filter = tiny.requireAll("x", "y", "movespeed")

function playerSystem:process(e, dt)
	if not self.hasStarted then
		self.hasStarted = true
	end

	if rl.getKeyDown(rl.KeyW) then
		e.y = e.y - e.movespeed * dt
	end

	if rl.getKeyDown(rl.KeyS) then
		e.y = e.y + e.movespeed * dt
	end

	if rl.getKeyDown(rl.KeyA) then
		e.x = e.x - e.movespeed * dt
	end

	if rl.getKeyDown(rl.KeyD) then
		e.x = e.x + e.movespeed * dt
	end

	e.fireCoolDownTime = e.fireCoolDownTime - dt
	if rl.getKeyDown(rl.KeySpace) and e.fireCoolDownTime <= 0 then
		e.fireCoolDownTime = 0.1
		self.world:Dispatch("gun_fired", e.x, e.y, e.height)
	end
end

return playerSystem
