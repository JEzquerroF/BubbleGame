local Actor  = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local Hud = Actor:extend()

function Hud:new(aciertos)
    self.aciertos = aciertos or 0
    self.font = love.graphics.newFont("src/fonts/BubbleBobble.ttf", 25)
end

function Hud:update(dt)
end

function Hud:draw()
    --Combo Count
    love.graphics.setFont(self.font)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 300, 7, 200, 40)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Combo Count: " .. self.aciertos, 305, 17)
    --Controls
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",690,130,140,40)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("A-D to Aim", 699,135)

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",690,170,161,40)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Space to Shoot", 698,175)

  
end

return Hud
