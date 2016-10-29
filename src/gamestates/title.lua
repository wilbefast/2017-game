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
TITLE GAMESTATE
--]]------------------------------------------------------------

local state = GameState.new()

--[[------------------------------------------------------------
GameState navigation
--]]--

function state:init()
end

function state:enter()
end

function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--


function state:keypressed(key, uni)
  if key == "escape" then
    audio:play_sound("back", 0.1)
    love.event.push("quit")
  end
end

function state:mousepressed()
  audio:play_sound("confirm", 0.05)
  GameState.switch(intro)
end

function state:update(dt)
end

function state:draw()
  -- background
  love.graphics.draw(Resources.title, 0, 0)
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
