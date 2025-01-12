local Maze = require("src.maze")
local Player = require("src.player")

local maze
local player

function love.load()
    maze = Maze.new(50, 60, 55) -- Create a maze with rows, columns, and cell size
    player = Player.new(2, 2, 30) -- Initialize the player at position (2, 2)
end

function love.update(dt)
    -- Pass `dt` to the player's update function
    player:update(maze, dt)
end

function love.draw()
    maze:draw()
    player:draw(maze)
end

function love.keypressed(key)
    player:keypressed(key, maze)
end

