local tiny = require("tiny")
local rl = require("wrapper")

local SpawnerSystem = require("spawnerSystem")
local EnemySystem = require("enemySystem")
local PlayerSystem = require("playerSystem")
local WrappingSystem = require("wrappingSystem")
local BulletSystem = require("bulletSystem")
local CollisionSystem = require("collisionSystem")
local DropperSystem = require("dropperSystem")
local PickupSystem = require("pickupSystem")

local Player = require("player")
local Spawner = require("spawner")

local World = tiny.world()

DEBUG = true

function World:draw()
	for _, e in ipairs(self.entities) do
		if type(e["draw"]) == "function" then
			e:draw()
		end
	end
end

World.eventDispatcher = {}

function World:AddEventListener(eventName, listener)
	if not self.eventDispatcher[eventName] then
		self.eventDispatcher[eventName] = {}
	end
	table.insert(self.eventDispatcher[eventName], listener)
end

function World:Dispatch(eventName, ...)
	local listeners = self.eventDispatcher[eventName]
	if listeners then
		for _, listener in ipairs(listeners) do
			listener(...)
		end
	end
end

local run = true
local systems = {
	SpawnerSystem,
	EnemySystem,
	PlayerSystem,
	WrappingSystem,
	BulletSystem,
	CollisionSystem,
	DropperSystem,
	PickupSystem,
}

for _, system in ipairs(systems) do
	World:addSystem(system)
end

local score = 0

World.AddEventListener(World, "enemy_killed", function()
	score = score + 1
end)

World.AddEventListener(World, "pickup", function()
	score = score + 1
end)

World.addEntity(World, Player:new(100, 100, 50, 50))
World.addEntity(World, Spawner:new())

tiny.refresh(World)

rl.setTargetFPS(60)
rl.initWindow()

while not rl.windowShouldClose() and run do
	World:update(rl.getFrameTime())

	rl.beginDrawing()
	rl.clearBackground(0, 0, 0, 255)

	World:draw()

	if DEBUG then
		rl.drawFPS(10, 10)
	end

	rl.drawText("Score: " .. score, 20, 20, 20)

	rl.endDrawing()
end

rl.closeWindow()
