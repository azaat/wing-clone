Class = require 'class'
Camera = require 'camera'
require 'Map'
require 'Ship'
require 'Interaction'

WIDTH = 1000
HEIGHT = 720

function love.load()
    love.window.setMode(WIDTH, HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

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
    camera.scale = 1.5
    map = Map(world, level1, 5)
    ship = Ship(world, WIDTH / 2, HEIGHT / 2, 5)
    interaction = Interaction(world, map, ship)
end

function love.update(dt)
    world:update(dt)
    interaction:update()

    camera:update(dt)
    camera:follow(ship.body:getWorldCenter())
end

function love.draw()
    camera:attach()
    interaction:render()
    camera:detach()
    camera:draw()
end