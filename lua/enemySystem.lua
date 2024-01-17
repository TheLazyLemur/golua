local rl = require("wrapper")
local tiny = require("tiny")

local enemySystem = tiny.processingSystem()
enemySystem.filter = tiny.requireAll("enemy")

function enemySystem:process(e, dt)
	e.x = e.x - 200 * dt
end

return enemySystem
