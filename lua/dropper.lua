local dropper = {}

function dropper:new(x, y)
	local newObj = {
		dropper = true,
		x = x,
		y = y,
	}

	setmetatable(newObj, { __index = self })

	return newObj
end

return dropper
