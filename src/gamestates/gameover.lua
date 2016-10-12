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
    background = Resources.gameover.win,
    name = "win",
    jingle = "combo"
  },
  killed = {
    background = Resources.gameover.killed,
    name = "killed",
    jingle = "combo"
  },
  extremist = {
    background = Resources.gameover.extremist,
    name = "extremist",
    jingle = "combo"
  },
  standard = {
    background = Resources.gameover.standard,
    name = "standard",
    jingle = "combo"
  },
}

--[[------------------------------------------------------------
GameState navigation
--]]--

function state:init()
end

function state:enter()
  audio:play_sound(self.ending.jingle)
end

function state:leave()
end

--[[------------------------------------------------------------
Modification
--]]--

function state:setEnding(endingName)
  if self.ending then
    log:write("An ending has already been selected")
    return
  end
  self.ending = endings[endingName]
  if not self.ending then
    log:write("Invalid ending", endingName)
  else
    log:write("Ending is", self.ending.name)
  end
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:mousepressed()
  audio:play_sound("combo", 0.1)
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
