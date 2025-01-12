local Player = {}
Player.__index = Player

function Player.new(startX, startY, size)
    local self = setmetatable({}, Player)
    self.x = startX
    self.y = startY
    self.size = size
    self.speed = 100 -- Movement speed in units per second
    self.targetX = startX -- Destination column
    self.targetY = startY -- Destination row
    return self
end

function Player:update(maze, dt)
    -- Smooth movement towards the target position
    local cellSize = maze.cellSize
    local targetPixelX = (self.targetX - 1) * cellSize + cellSize / 2
    local targetPixelY = (self.targetY - 1) * cellSize + cellSize / 2

    local currentPixelX = self.x * cellSize + cellSize / 2
    local currentPixelY = self.y * cellSize + cellSize / 2

    -- Calculate direction and move
    if currentPixelX ~= targetPixelX then
        local direction = (targetPixelX > currentPixelX) and 1 or -1
        self.x = self.x + direction * self.speed * dt / cellSize
        if math.abs(currentPixelX - targetPixelX) < self.speed * dt then
            self.x = self.targetX - 1 -- Snap to the target
        end
    end

    if currentPixelY ~= targetPixelY then
        local direction = (targetPixelY > currentPixelY) and 1 or -1
        self.y = self.y + direction * self.speed * dt / cellSize
        if math.abs(currentPixelY - targetPixelY) < self.speed * dt then
            self.y = self.targetY - 1 -- Snap to the target
        end
    end
end

function Player:keypressed(key, maze)
    if( key == "w" or key =="up") and maze:isWalkable(self.targetY - 1, self.targetX) then
        self.targetY = self.targetY - 1
    elseif (key == "s" or key == "down") and maze:isWalkable(self.targetY + 1, self.targetX) then
        self.targetY = self.targetY + 1
    elseif (key == "a" or key == "left") and maze:isWalkable(self.targetY, self.targetX - 1) then
        self.targetX = self.targetX - 1
    elseif (key == "d" or key == "right") and maze:isWalkable(self.targetY, self.targetX + 1) then
        self.targetX = self.targetX + 1
    end
end

function Player:draw(maze)
    love.graphics.setColor(1, 0, 0) -- Player color
    local cellSize = maze.cellSize
    love.graphics.rectangle("fill",
        self.x * cellSize + (cellSize - self.size) / 2,
        self.y * cellSize + (cellSize - self.size) / 2,
        self.size,
        self.size
    )
end

return Player

