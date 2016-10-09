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
GAMEOVER GAMESTATE
--]]------------------------------------------------------------

local state = GameState.new()

local endings = {
  win = {
    background = Resources.gameover.win
  },
  killed = {
    background = Resources.gameover.killed
  },
  extremist = {
    background = Resources.gameover.extremist
  },
  standard = {
    background = Resources.gameover.standard
  },
}

--[[------------------------------------------------------------
GameState navigation
--]]--

function state:init()
end

function state:enter()

  if ingame:countPiecesOfType("PieceNewspaper") <= 0 then
    self.ending = endings.kill
  elseif ingame:countPiecesOfType("PieceCandidate") <= 0 then
    self.ending = endings.win
  elseif ingame:countPiecesOfType("PieceCandidate") >= 4
  or ingame:isPieceOfTypeSuchThat("PieceCandidate", function(p) return p.name == "Reac" or p.name == "Socialo" end) then
    self.ending = endings.standard
  else
    self.ending = endings.extremist
  end
end

function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--


function state:keypressed(key, uni)
  GameState.switch(title)
end

function state:mousepressed()
  GameState.switch(title)
end

function state:update(dt)
end

function state:draw()
  love.graphics.draw(self.ending.background)
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
