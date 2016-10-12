--[[
(C) Copyright 2016 William Dyce, Leon Denise, Maxence Voleau

All rights reserved. This program and the accompanying materials
are made available under the terms of the GNU Lesser General Public License
(LGPL) version 2.1 which accompanies this distribution, and is available at
http://www.gnu.org/licenses/lgpl-2.1.html

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.
--]]

--[[------------------------------------------------------------
GLOBAL VARIABLES
--]]------------------------------------------------------------

TITLE = "2017-game"
WORLD_W, WORLD_H = 1920, 1080
shake = 0
DEBUG = false
WORLD_OX, WORLD_OY = WORLD_W/2, WORLD_H
mx, my = WORLD_OX, WORLD_OY

--[[------------------------------------------------------------
LOCAL VARIABLES
--]]------------------------------------------------------------

local WORLD_CANVAS = nil
local CAPTURE_SCREENSHOT = false

--[[------------------------------------------------------------
LOVE CALLBACKS
--]]------------------------------------------------------------

function love.load(arg)

  -- "Unrequited" library
  Class = require("unrequited/Class")
  Vector = require("unrequited/Vector")
  GameState = require("unrequited/GameState")
  GameObject = require("unrequited/GameObject")
  CollisionGrid = require("unrequited/CollisionGrid")
  babysitter = require("unrequited/babysitter")
  useful = require("unrequited/useful")
  audio = require("unrequited/audio")
  log = require("unrequited/log")
  log:setLength(21)

  -- game-specific code
  Resources = require("Resources")
  scaling = require("scaling")
  ingame = require("gamestates/ingame")
  title = require("gamestates/title")
  intro = require("gamestates/intro")
  tuto = require("gamestates/tuto")
  gameover = require("gamestates/gameover")
  PuzzlePiece = require("gameobjects/PuzzlePiece")
  CombinationPart = require("gameobjects/CombinationPart")
  PieceNewspaper = require("gameobjects/PieceNewspaper")
  PieceCandidate = require("gameobjects/PieceCandidate")
  PieceSource = require("gameobjects/PieceSource")
  PieceEvidence = require("gameobjects/PieceEvidence")
  PieceAdversary = require("gameobjects/PieceAdversary")
  PieceAlly = require("gameobjects/PieceAlly")
  PieceJournalist = require("gameobjects/PieceJournalist")
  NewspaperGridTile = require("grid/NewspaperGridTile")
  Tooltip = require("gameobjects/Tooltip")
  Timeline = require("gameobjects/Timeline")
  Pouf = require("gameobjects/Pouf")

  -- startup logs
  log.print = true
  log:write("Starting '" .. TITLE .. "'")

  -- set scaling based on resolution
  scaling.reset()

  -- set interpolation
  love.graphics.setDefaultFilter("linear", "linear")
  love.graphics.setLineStyle("smooth")

  -- set z-order
  GameObject.view_oblique = 1

  -- resources
  -- ... fonts
  fontSmall = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 18)
  fontMedium = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 32)
  fontLarge = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 64)
  love.graphics.setFont(fontMedium)
  -- ... png

  -- initialise random
  math.randomseed(os.time())

  -- no mouse
  --love.mouse.setVisible(false)

  -- save directory
  love.filesystem.setIdentity(TITLE)

  -- window title
  love.window.setTitle(TITLE)

  -- canvases
  WORLD_CANVAS = love.graphics.newCanvas(WORLD_W, WORLD_H)

  -- clear colour
  love.graphics.setBackgroundColor(0, 0, 0)

  -- line width
  love.graphics.setLineWidth(3)

  -- music
  audio:load_music("marseillaise")
  audio:play_music("marseillaise")

  -- sound
  -- load_sound takes a filename, a volume (between 0 and 1) and a max number of simultaneous instances.
  audio:load_sound("combo", 0.4, 10)
  -- load_sounds takes a base filename, a number of variants, a volume and max a number of instances.
  audio:load_sounds("lick", 3, 1, 4)
  -- play_sound can be used to play either: it takes a name and a pitch randomisation (between 0 and 1)

  -- initial gamestate
  GameState.switch(title)
end

function love.focus(f)
  GameState.focus(f)
end

function love.quit()
  GameState.quit()
end

function love.keypressed(key, uni)
  GameState.keypressed(key, uni)
  if key == "d" then
    DEBUG = not DEBUG
  elseif key == "x" then
    CAPTURE_SCREENSHOT = not CAPTURE_SCREENSHOT
  else
    --babysitter.activeWaitThen(10, function(t) log:write(t*t) end, function() log:write("DONE") end)
  end
end

function love.keyreleased(key, uni)
  GameState.keyreleased(key, uni)
end

function love.mousepressed(x, y, button)
  mx, my = scaling.scaleMouse()
  GameState.mousepressed(mx, my, button)
end

function love.mousereleased(mx, my, button)
  mx, my = scaling.scaleMouse()
  GameState.mousereleased(mx, my, button)
end

function love.update(dt)
  GameState.update(dt)

  shake = shake*math.pow(0.9, 100*dt)
  if shake < 0 then
    shake = 0
  end

  mx, my = scaling.scaleMouse()
  mx, my = useful.clamp(mx, 1, WORLD_W - 1), useful.clamp(my, 1, WORLD_H - 6*math.sqrt(math.abs(mx - WORLD_OX)))

  babysitter.update(dt)
end

function love.draw()
  useful.pushCanvas(WORLD_CANVAS)
    -- clear
    love.graphics.setColor(91, 132, 192)
    love.graphics.rectangle("fill", 0, 0, WORLD_W, WORLD_H)
    useful.bindWhite()

    -- draw any other state specific stuff
    GameState.draw()
  useful.popCanvas()

  love.graphics.push()
    -- scaling
    love.graphics.scale(WINDOW_SCALE, WINDOW_SCALE)
    -- playable area is the centre sub-rect of the screen
    -- love.graphics.translate(
    --   (WINDOW_W - VIEW_W)*0.5/WINDOW_SCALE + useful.signedRand(shake),
    --   (WINDOW_H - VIEW_H)*0.5/WINDOW_SCALE + useful.signedRand(shake))
    -- draw the canvas
    love.graphics.draw(WORLD_CANVAS, 0, 0)
  love.graphics.pop() -- pop offset

  -- capture GIF footage
  if CAPTURE_SCREENSHOT then
    useful.recordGIF()
  end

  -- draw logs
  if DEBUG then
    log:draw(16, 48)
  end
end
