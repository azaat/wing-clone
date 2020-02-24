Ship = Class{}

--Physical parameters
TURN_ANGLE = 6
LINEAR_DAMPING = 3
ANGULAR_DAMPING = 30
SHIP_REST = 1.1

function Ship:init(world, x, y, dim)
    self.world = world
    self.x = x
    self.y = y
    self.dim = dim

    self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
    self.body:setLinearDamping(LINEAR_DAMPING)
    self.body:setAngularDamping(ANGULAR_DAMPING)

    --Triangular shape of the ship
    self.shape = love.physics.newPolygonShape( - self.dim, self.dim, 
        0, self.dim * 3,
        self.dim, self.dim, 
        0, - self.dim * 2)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)

    self.fixture:setRestitution(SHIP_REST)
end

function Ship:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon('fill', self.body:getWorldPoints(
        self.shape:getPoints()))
end