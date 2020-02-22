Ship = Class{}

--PHYSICAL PARAMETERS
TURN_ANGLE = 0.005
LINEAR_DAMPING = 0.5
ANGULAR_DAMPING = 5
SHIP_REST = 0.5

function Ship:init(world, x, y, dim)
    self.world = world
    self.x = x
    self.y = y
    self.dim = dim

    self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
    self.body:setLinearDamping(LINEAR_DAMPING)
    self.body:setAngularDamping(ANGULAR_DAMPING)

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