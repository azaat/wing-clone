Class = require 'class'
Camera = require 'camera'
push = require 'push'
require 'Map'
require 'Ship'
require 'Interaction'

local WIDTH = 1080
local HEIGHT = 720
local windowWidth, windowHeight = love.graphics.getDimensions()

function love.load()
    push:setupScreen(
        WIDTH, 
        HEIGHT, 
        windowWidth,
        windowHeight,
        {
        fullscreen = false,
        resizable = true
        }
    )

    world = love.physics.newWorld(0, 0, true)

    level1 = {
        546, 362,
        583, 488,
        500, 500,
        500, 700,
        583, 688,
        646, 662,
        683, 637,
        743, 575,
        800, 400,
        500, 100,
        225, 280,
        224, 517
    }

    camera = Camera(WIDTH / 2, HEIGHT / 2, WIDTH, HEIGHT)
    camera.scale = 2
    map = Map(world, level1, 5)
    ship = Ship(world, WIDTH / 2, HEIGHT / 2, 5)
    interaction = Interaction(world, map, ship, WIDTH, HEIGHT)
end

function love.update(dt)
    world:update(dt)
    interaction:update(dt)

    camera:update(dt)
    camera:follow(ship.body:getWorldCenter())
end

function love.draw()
    push:start()

    camera:attach()
    interaction:render()
    camera:detach()
    camera:draw()

    push:finish()
end