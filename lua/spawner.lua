local rl = require("wrapper")

local spawner = {}

function spawner:new()
	local newObj = {
		spawner = true,
		spawnTime = 0,
	}

	setmetatable(newObj, { __index = self })

	return newObj
end

return spawner
