Class = require 'class'

require 'Map'
require 'Ship'
require 'Interaction'

WIDTH = 1280
HEIGHT = 720

function love.load()
    love.window.setMode(WIDTH, HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    world = love.physics.newWorld(0, 0, true)

    level1 = {
        100, 100,
        200, 150,
        300, 400,
        500, 450,
        550, 600,
        300,  800
    }

    map = Map(world, level1, 5)
    ship = Ship(world, WIDTH / 2, HEIGHT / 2, 5)
    interaction = Interaction(world, map, ship)
end

function love.update(dt)
    world:update(dt)
    interaction:update()
end

function love.draw()
    interaction:render()
end