local Maze = {}
Maze.__index = Maze

function Maze.new(rows, cols, cellSize)
    local self = setmetatable({}, Maze)
    self.rows = rows
    self.cols = cols
    self.cellSize = cellSize

    -- Define a simple static maze (1 = wall, 0 = path)
    self.grid = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1},
        {1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1},
        {1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1},
        {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1},
        {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1},
        {1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
    }

    return self
end

function Maze:draw()
    for row = 1, self.rows do
        for col = 1, self.cols do
            -- Ensure grid values exist before accessing them
            local cell = self.grid[row] and self.grid[row][col]
            if cell == 1 then
                love.graphics.setColor(0.3, 0.3, 0.3) -- Wall color
            elseif cell == 0 then
                love.graphics.setColor(1, 1, 1) -- Path color
            else
                love.graphics.setColor(0, 0, 0) -- Fallback (error cell)
            end

            love.graphics.rectangle(
                "fill",
                (col - 1) * self.cellSize,
                (row - 1) * self.cellSize,
                self.cellSize,
                self.cellSize
            )
        end
    end
end

function Maze:isWalkable(row, col)
    -- Check bounds and return walkability
    return self.grid[row] and self.grid[row][col] == 0
end

return Maze

