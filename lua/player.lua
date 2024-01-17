local rl = require("wrapper")

local player = {}

function player:new(x, y, width, height)
	local newObj = {
		x = x,
		y = y,
		width = width,
		height = height,
		movespeed = 300,
		player = true,
		fireCoolDownTime = 0,
	}

	setmetatable(newObj, { __index = self })

	return newObj
end

function player:draw()
	rl.drawRec(self.x, self.y, self.width, self.height)
end

return player
