local rl = require("wrapper")

local pickup = {}

function pickup:new(x, y, width, height)
	local newObj = {
		pickup = true,
		x = x,
		y = y,
		width = width,
		height = height,
	}

	setmetatable(newObj, { __index = self })

	return newObj
end

function pickup:draw()
	rl.drawRec(self.x, self.y, self.width, self.height)
	if DEBUG then
		rl.drawLine(self.x, self.y, self.x, rl.getScreenHeight())
	end
end

return pickup
