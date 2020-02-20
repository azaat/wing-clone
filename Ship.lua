Ship = Class{}
TURN_ANGLE = 0.005

function Ship:init(world, x, y, dim)
    self.world = world
    self.x = x
    self.y = y
    self.dim = dim

    self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
    self.shape = love.physics.newPolygonShape( - self.dim,
        self.dim * 2, 
        self.dim, 
        self.dim * 2, 
        0, 
        - self.dim * 2)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
end

function Ship:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon('fill', self.body:getWorldPoints(
        self.shape:getPoints()))
end