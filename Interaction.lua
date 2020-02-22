Interaction = Class{}

--PHYSICAL PARAMETERS
RAY_LENGTH = 300
FORCE = 6
ADD_FORCE = 3

function Interaction:init(world, map, ship)
    self.world = world
    self.map = map
    self.ship = ship
    self.point1 = {} 
    self.point2 = {}
end

function Interaction:update()
    local angle = self.ship.body:getAngle()
    
    if love.keyboard.isDown('left') then
        self.ship.body:setAngle(angle - TURN_ANGLE)
        angle = angle - TURN_ANGLE
    elseif love.keyboard.isDown('right') then
        self.ship.body:setAngle(angle + TURN_ANGLE)
        angle = angle + TURN_ANGLE
    end

    --Applying reactive force to the Player
    local xn, yn, fraction = self:cast(angle)
    self.ship.body:applyForce(FORCE * math.sin(angle),
        - FORCE * math.cos(angle))
    if xn then
        self.ship.body:applyForce(ADD_FORCE * math.sin(angle) / fraction,
            - ADD_FORCE * math.cos(angle) / fraction)
    end

end

function Interaction:cast(angle)
    self.point1.x, self.point1.y = self.ship.body:getWorldCenter()
    self.point2.x = self.point1.x - RAY_LENGTH * math.sin(angle)
    self.point2.y = self.point1.y + RAY_LENGTH * math.cos(angle)

    local minX, minY, minFrac
    for i = 1, self.map.shape:getChildCount() do
        local xn, yn, fraction = self.map.fixture:rayCast(self.point1.x, self.point1.y,
            self.point2.x, self.point2.y, 1, i)
        if xn then
            if (not minFrac) or (minFrac > fraction) then
                minFrac = fraction
                minX = xn
                minY = yn
            end
        end
    end

    return minX, minY, minFrac
end

function Interaction:render()
    self.map:render()
    self.ship:render()

    --Ray rendering
    local angle = self.ship.body:getAngle()
    local xn, yn, fraction = self:cast(angle)
    if xn then
        local r1HitX = self.point1.x + (self.point2.x - self.point1.x) * fraction
        local r1HitY = self.point1.y + (self.point2.y - self.point1.y) * fraction
        
        love.graphics.setColor(0, 0, 0.5)
        love.graphics.line(self.point1.x, self.point1.y, r1HitX, r1HitY)
    end
end