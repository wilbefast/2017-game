--[[
(C) Copyright 2016 William Dyce

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
INGAME GAMESTATE
--]]------------------------------------------------------------

local state = GameState.new()

--[[------------------------------------------------------------
GameState navigation
--]]--

function state:init()
end

function state:enter()
	--self.newspaperGrid = CollisionGrid()
	PuzzlePiece(200, 300)
	PuzzlePiece(700, 140)
	PuzzlePiece(133, 100)
end

function state:leave()
	GameObject.purgeAll()
	self.newspaperGrid = nil
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:mousepressed()
  shake = shake + 20
end


function state:keypressed(key, uni)
  if key == "escape" then
    shake = shake + 2
		GameState.switch(title)
  end
end

function state:update(dt)
  -- update logic
  GameObject.updateAll(dt)
end

function state:draw()
	-- draw logic
	GameObject.drawAll()

  -- left and right parts
  love.graphics.rectangle("line", 16, 16, WORLD_W*0.5 - 32, WORLD_H - 32)
  love.graphics.rectangle("line", WORLD_W*0.5 + 16, 16, WORLD_W*0.5 - 32, WORLD_H - 32)
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
