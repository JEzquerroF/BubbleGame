local Actor = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local Hud = Hud or require "src/hud"
local Bubble = Actor:extend()

local bubbleList = { "src/textures/bubble1.png", "src/textures/bubble2.png",
  "src/textures/bubble3.png", "src/textures/bubble4.png", "src/textures/bubble5.png" }

function Bubble:new()
  self.state = "idle"
  self.color = math.random(1,5)
  self.enganchado = 1
  self.id = 3
  self.padres = {}
  self.hijo = {}
  self.madre = nil
  self.voyaEliminarme = false
  Bubble.super.new(self, bubbleList[self.color], 448, 535, 900)
end

function Bubble:update(dt)
  local eliminar = {}
  if self.state == "moving" then
    Bubble.super.update(self, dt)
    for j, i in pairs(actorList) do
      if i:is(Bubble) and i.state == "sticked" and i ~= self then
        if i:dist(self) < 34 then
          self.state = "sticked"
          if i.color == self.color then
            self.enganchado = i.enganchado + 1
            i.enganchado = self.enganchado
            self.padres = i.padres
            table.insert(self.padres, i.id)
          end
          self.madre = i.id
          table.insert(i.hijo, self.id)
        end
      end
    end
  end


  -----------------ENGANCHARSE----------------------
  if self.enganchado > 2 then
    for j, i in pairs(self.padres) do
      for k, v in pairs(actorList) do
        if v.id == i then
          v.voyaEliminarme = true
          table.insert(eliminar, v.id)
        end
      end
    end
    table.insert(eliminar, self.id)
    self.voyaEliminarme = true

    -----------------ACIERTOS----------------------
    for k, v in pairs(actorList) do
      if v:is(Hud) then
        v.aciertos = v.aciertos + 1
      end
    end

    ----------ELIMINAR BURBUJA---------------------
    for j, i in pairs(eliminar) do
      for k, v in pairs(actorList) do
        if v.id == i then
          table.remove(actorList, k)
          --print("Burbuja ID", v.id, "ha sido eliminda")
          --print("Burbuja ID", v.id, "estado para eliminar", v.voyaEliminarme)
        end
      end
    end

    ---------------INDICAMOS CAMBIO DE ESTADO FALL---------------
    for k, v in pairs(actorList) do
      for j, i in pairs(eliminar) do
        if v.madre == i then
          for m, n in pairs(v.hijo) do
            if n == v.id and v.voyaEliminarme == false then
              v.state = "fall"
            end
          end
          --print("Burbuja ID", v.id, "cambiada a estado 'fall'")
          --print("Burbuja ID", v.id, "estado para eliminar", v.voyaEliminarme)
          v.state = "fall"
        end
      end
    end
  end
  --------------BURBUJA FALL----------
  if self.state == "fall" and self.voyaEliminarme == false then
    Bubble.super.update(self, dt)
    for k, v in pairs(actorList) do
      if v:is(Bubble) then
        if self.id == v.madre then
          v.state = "fall"
        end
      end
    end
    self.forward.x = 0
    self.forward.y = 1
    self.speed = 800
  end

  ------------------------REBOTES--------------------------
  local minX = 280
  local maxX = 600

  if self.position.x < minX then
    self.position.x = minX
    self.forward.x = math.abs(self.forward.x)
  elseif self.position.x > maxX then
    self.position.x = maxX
    self.forward.x = -math.abs(self.forward.x)
  end

  if self.position.y < 90 then
    self.state = "sticked"
    if self.position.y < 88 or self.position.y > 70 then
      self.position.y = 73
    end
  elseif self.position.y > 700 then
    for k, v in pairs(actorList) do
      if v.id == self.id then
        table.remove(actorList, k)
      end
    end
  end
end

function Bubble:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local rr = self.rot
  love.graphics.draw(self.image, xx, yy, rr, 1, 1, ox, oy)
end

return Bubble
