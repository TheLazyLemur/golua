local rl = require("wrapper")

local enemy = {}

function enemy:new(x, y, width, height)
	local newObj = {
		x = x,
		y = y,
		width = width,
		height = height,
		enemy = true,
	}

	setmetatable(newObj, { __index = self })

	return newObj
end

function enemy:draw()
	rl.drawRec(self.x, self.y, self.width, self.height)
end

return enemy
