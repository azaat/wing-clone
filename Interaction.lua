Interaction = Class{}
RAY_LENGTH = 300

function Interaction:init(world, map, ship)
    self.world = world
    self.map = map
    self.ship = ship

    self.point1 = {} 
    self.point2 = {}
end

function Interaction:update()
    angle = self.ship.body:getAngle()
    if love.keyboard.isDown('left') then
        self.ship.body:setAngle(angle - TURN_ANGLE)
    elseif love.keyboard.isDown('right') then
        self.ship.body:setAngle(angle + TURN_ANGLE)
    end

    xn, yn, fraction = self:cast()
end

function Interaction:cast()
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

    xn, yn, fraction = self:cast()
    love.graphics.setColor(0, 255, 0)
    love.graphics.line(self.point1.x, self.point1.y,
    self.point2.x, self.point2.y)

    if xn then
        local r1HitX = self.point1.x + (self.point2.x - self.point1.x) * fraction
        local r1HitY = self.point1.y + (self.point2.y - self.point1.y) * fraction
        love.graphics.setColor(255, 0, 0)
        love.graphics.line(self.point1.x, self.point1.y, r1HitX, r1HitY)
    end
end