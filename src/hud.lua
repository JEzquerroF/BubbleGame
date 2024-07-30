local Actor  = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local Hud    = Actor:extend()

function Hud:new(aciertos)
    self.aciertos = aciertos or 0
    self.font = love.graphics.newFont("src/fonts/BubbleBobble.ttf", 25)
end

function Hud:update(dt)
end

function Hud:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 290, 7, 319, 40)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Numero de Aciertos: " .. self.aciertos, 300, 17)
end

return Hud
