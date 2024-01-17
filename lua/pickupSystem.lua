local tiny = require("tiny")

local pickupSystem = tiny.processingSystem()
pickupSystem.filter = tiny.requireAny("pickup", "player")

local function checkCollision(rect1, rect2)
	return rect1.x < rect2.x + rect2.width
	    and rect1.x + rect1.width > rect2.x
	    and rect1.y < rect2.y + rect2.height
	    and rect1.y + rect1.height > rect2.y
end

function pickupSystem:process(e, dt)
	if e.pickup then
		e.y = e.y + 100 * dt
	end

	if e.player then
		for _, other in ipairs(pickupSystem.entities) do
			if other.pickup then
				local rect1 = { x = e.x, y = e.y, width = e.width, height = e.height }
				local rect2 = { x = other.x, y = other.y, width = other.width, height = other.height }

				if checkCollision(rect1, rect2) == true then
					self.world:Dispatch("pickup")
					self.world:removeEntity(other)
				end
			end
		end
	end
end

return pickupSystem
