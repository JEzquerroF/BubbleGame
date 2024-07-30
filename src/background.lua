local Actor = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local MenuFondo = Actor:extend()

function MenuFondo:new()
  MenuFondo.super.new(self, "src/textures/background.png", 0, 0, 0)
end

function MenuFondo:update(dt)
end

function MenuFondo:draw()
  love.graphics.draw(self.image, 0, -10, 0, 1, 1.02)
end

return MenuFondo
