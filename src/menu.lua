local Actor = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local Bubble = Bubble or require "src/bubble"
local Menu = Actor:extend()

function Menu:new()
    self.startGame = false
    self.menuSelectedOption = 1
    self.backgroundMenu = love.graphics.newImage("src/textures/backgroundMenu.png")
    self.title = love.graphics.newImage("src/textures/title.png")
    self.selected = love.graphics.newImage("src/textures/selected.png")
    self.selectedGuy = love.graphics.newImage("src/textures/selected_guy.png")
    self.music = love.audio.newSource("src/music/bobble_music.mp3", "stream")
end

function Menu:update(dt)
    --Musica de fondo
    love.audio.setVolume(0.02)
    self.music:setLooping(true)
    love.audio.play(self.music)

    if self.startGame == false then
        function love.keypressed(key)
            if key == "up" then
                self.menuSelectedOption = self.menuSelectedOption - 1
                if self.menuSelectedOption < 1 then
                    self.menuSelectedOption = 2
                end
            elseif key == "down" then
                self.menuSelectedOption = self.menuSelectedOption + 1
                if self.menuSelectedOption > 2 then
                    self.menuSelectedOption = 1
                end
            elseif key == "return" then
                if self.menuSelectedOption == 1 then
                    self.startGame = true
                elseif self.menuSelectedOption == 2 then
                    --Salir del juego
                    love.event.quit()
                end
            elseif key == "escape" then
                self.startGame = false
            end
        end
    end
end

function Menu:draw()
    if self.startGame == false then
        love.graphics.draw(self.backgroundMenu)
        love.graphics.draw(self.title, 310, 100, 0, 1.5, 1.5)

        --Texto informativo
        SetFont("BubbleBobble", 15)
        love.graphics.print("Press ENTER to confirm your option!\nOr press", 600, 100, 0.3)
        SetFont("CascadiaCode", 15)
        love.graphics.print("↑↓ ", 650, 135, 0.3)
        SetFont("BubbleBobble", 15)
        love.graphics.print("to change it.", 670, 140, 0.3)

        SetFont("BubbleBobble", 25)

        --Dibuja las opciones del menu y te marca en cual estás
        local options = { "New game", "Exit" }
        for i, option in ipairs(options) do
            if i == self.menuSelectedOption and self.startGame == false then
                love.graphics.draw(self.selected, 360, 320 + i * 50, 0, 1, 1.3)
                love.graphics.draw(self.selectedGuy, 340, 326 + i * 50)
            end
            love.graphics.print(option, 380, 320 + i * 50)
        end
    end
end

--Funcion para cambiar la fuente y su tamaño
function SetFont(name, size)
    love.graphics.setFont(love.graphics.newFont("src/fonts/" .. name .. ".ttf", size))
end

return Menu
