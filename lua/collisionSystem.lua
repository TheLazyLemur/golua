local tiny = require("tiny")
local dropper = require("dropper")

local collisionSystem = tiny.processingSystem()
collisionSystem.filter = tiny.requireAny("bullet", "enemy", "player")

local function checkCollision(rect1, rect2)
	return rect1.x < rect2.x + rect2.width
	    and rect1.x + rect1.width > rect2.x
	    and rect1.y < rect2.y + rect2.height
	    and rect1.y + rect1.height > rect2.y
end

function collisionSystem:process(e, dt)
	if e.player or e.bullet then
		for _, other in ipairs(collisionSystem.entities) do
			if other.enemy then
				local rect1 = { x = e.x, y = e.y, width = e.width, height = e.height }
				local rect2 = { x = other.x, y = other.y, width = other.width, height = other.height }

				if checkCollision(rect1, rect2) then
					collisionSystem.world.removeEntity(collisionSystem.world, e)
					collisionSystem.world.removeEntity(collisionSystem.world, other)

					collisionSystem.world.addEntity(collisionSystem.world,
						dropper:new(other.x, other.y))

					if e.bullet and other.enemy then
						self.world.Dispatch(self.world, "enemy_killed")
					end

					break
				end
			end
		end
	end
end

return collisionSystem
