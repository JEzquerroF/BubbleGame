local Actor = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local Bubble = Bubble or require "src/bubble"
local Menu = Menu or require "src/menu"
local Compass = Actor:extend()

function Compass:new()
  Compass.super.new(self, "src/textures/compass.png", 448, 535, 0)
  self.compass2 = love.graphics.newImage("src/textures/compass2.png")
  self.tiempoActual = 0 or self.tiempoActual
  self.forward = Vector.new(0, -1)
  self.recargando = false
  self.contador = 3
end

function Compass:update(dt)
  for i, j in pairs(actorList) do
    if j:is(Menu) then
      if j.startGame == true then
        -- Movement
        if love.keyboard.isDown("a") and self.rot > -1.1 then
          self.forward:rotate(-math.pi * dt)
          self.rot = self.rot - math.pi * dt
        end

        if love.keyboard.isDown("d") and self.rot < 1.1 then
          self.forward:rotate(math.pi * dt)
          self.rot = self.rot + math.pi * dt
        end

        --Launching
        if love.keyboard.isDown("space") then
          for j, b in ipairs(actorList) do
            if b:is(Bubble) and b.state == "idle" then
              self.recargando = true
              b.forward = Vector.new(self.forward.x, self.forward.y)
              b.state = "moving"
            end
          end
        end

        --ReLoad
        if self.recargando == true then
          self.tiempoActual = self.tiempoActual + dt
          if self.tiempoActual >= 0.5 then
            b = Bubble()
            table.insert(actorList, b)
            self.contador = self.contador + 1
            b.id = self.contador
            --print("Numero de ID: ".. b.id)
            self.tiempoActual = 0
            self.recargando = false
          end
        end
      end
    end
  end
end

function Compass:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local rr = self.rot
  love.graphics.draw(self.compass2, 395, 515, 0, 1.1, 1.1)
  love.graphics.draw(self.image, xx, yy, rr, 1, 1, ox, oy)
end

return Compass
