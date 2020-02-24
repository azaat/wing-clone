Interaction = Class{}

--Physical parameters
RAY_LENGTH = 300
FORCE = 88
ADD_FORCE = 44

function Interaction:init(world, map, ship, width, height)
    self.world = world
    self.map = map
    self.ship = ship

    self.width = width
    self.height = height

    self.point1 = {} 
    self.point2 = {}
end

function Interaction:update(dt)
    local angle = self.ship.body:getAngle()
 
    if love.keyboard.isDown('left') then
        self.ship.body:setAngle(angle - TURN_ANGLE * dt)
        angle = angle - TURN_ANGLE
    elseif love.keyboard.isDown('right') then
        self.ship.body:setAngle(angle + TURN_ANGLE * dt)
        angle = angle + TURN_ANGLE
    end  
    
    --Mobile controls
    local touches = love.touch.getTouches()
 
    for i, id in ipairs(touches) do
        local tx, ty = love.touch.getPosition(id)

        if tx < self.width / 2 then
            self.ship.body:setAngle(angle - TURN_ANGLE * dt)
            angle = angle - TURN_ANGLE
        else
            self.ship.body:setAngle(angle + TURN_ANGLE * dt)
            angle = angle + TURN_ANGLE
        end
    end

    --Applying reactive force to the ship
    local xn, yn, fraction = self:cast(angle)
    self.ship.body:applyForce(FORCE * math.sin(angle),
        - FORCE * math.cos(angle))
    if xn then
        self.ship.body:applyForce(dt * ADD_FORCE * math.sin(angle) / fraction,
            - dt * ADD_FORCE * math.cos(angle) / fraction)
    end

end

--Casting a ray from the ship to the walls
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