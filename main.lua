math.randomseed(os.time())

local Vector = Vector or require "lib/vector"
local Actor = Actor or require "src/actor"
local Background = Background or require "src/background"
local Bubble = Bubble or require "src/bubble"
local Compass = Compass or require "src/compass"
local Hud = Hud or require "src/hud"
local Menu = Menu or require "src/menu"

actorList = {}

function love.load()
  local background = Background()
  table.insert(actorList, background)
  local c = Compass()
  table.insert(actorList, c)
  local b = Bubble()
  table.insert(actorList, b)
  local h = Hud()
  table.insert(actorList, h)
  local m = Menu()
  table.insert(actorList, m)
end

function love.update(dt)
  for _, v in ipairs(actorList) do
    v:update(dt)
  end
end

function love.draw()
  for _, v in ipairs(actorList) do
    if v:is(Menu) then
      if v.startGame == false then
        v:draw()
      elseif v.startGame == true then
        for kk, vv in ipairs(actorList) do
            vv:draw()
          end
        end
      end
    end
  end

function love.keypressed(key)
  for _, v in ipairs(actorList) do
    if v:is(Menu) then
      v:keyPressed(key)
    end
  end
end
