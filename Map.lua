Map = Class{}

function Map:init(world, points, width)
    self.world = world
    self.points = points
    self.width = width

    self.body = love.physics.newBody(self.world, 0, 0)
    self.shape = love.physics.newChainShape(false, points)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)

end

function Map:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.points)
end