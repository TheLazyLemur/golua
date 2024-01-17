local rl = require("wrapper")

local bullet = {}

function bullet:new(x, y)
	local newObj = {
		x = x,
		y = y,
		width = 5,
		height = 5,
		bullet = true,
	}

	setmetatable(newObj, { __index = self })

	return newObj
end

function bullet:draw()
	rl.drawRec(self.x, self.y, 5, 5)
end

return bullet
