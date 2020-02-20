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


--[[
   Ray1 = {
 point1 = {},
 point2 = {},
}
Ray1.point1.x, Ray1.point1.y = objects.bod.body:getWorldCenter()
angle = objects.bod.body:getAngle()
Ray1.point2.x = Ray1.point1.x - 100 * math.sin(angle)
Ray1.point2.y = Ray1.point1.y + 100 * math.cos(angle)
Ray1.scale = 1 

Ray1.point1.x, Ray1.point1.y = objects.bod.body:getWorldCenter()
Ray1.point2.x = Ray1.point1.x - 100 * math.sin(angle)
Ray1.point2.y = Ray1.point1.y + 100 * math.cos(angle)
objects.bod.body:applyForce(1.5 * math.sin(angle),  - 1.5 * math.cos(angle))
 
-- applying reactive force
local r1nx, r1ny, r1f = objects.ground.fixture:rayCast(Ray1.point1.x, Ray1.point1.y, Ray1.point2.x, Ray1.point2.y, Ray1.scale)
if r1f then
 objects.bod.body:applyForce(1 * math.sin(angle) / r1f,  - 1 * math.cos(angle) / r1f)
end



local r1nx, r1ny, r1f = objects.ground.fixture:rayCast(Ray1.point1.x, Ray1.point1.y, Ray1.point2.x, Ray1.point2.y, Ray1.scale)
 
if r1nx then
 -- Calculating the world position where the ray hit.
 local r1HitX = Ray1.point1.x + (Ray1.point2.x - Ray1.point1.x) * r1f
 local r1HitY = Ray1.point1.y + (Ray1.point2.y - Ray1.point1.y) * r1f
 
 -- Drawing the ray from the starting point to the position on the shape.
 love.graphics.setColor(255, 0, 0)
 love.graphics.line(Ray1.point1.x, Ray1.point1.y, r1HitX, r1HitY)
 
 -- We also get the surface normal of the edge the ray hit. Here drawn in green
 love.graphics.setColor(0, 255, 0)
 love.graphics.line(r1HitX, r1HitY, r1HitX + r1nx * 25, r1HitY + r1ny * 25)
end
]]