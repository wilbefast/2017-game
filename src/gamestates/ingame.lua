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
	self.gridCellCount = 8
	self.gridWidth = (WORLD_W*0.5 - 32)
	self.gridCellSize = self.gridWidth / self.gridCellCount
	self.gridHeight = self.gridCellCount * self.gridCellSize--WORLD_H - 16
	PuzzlePiece(200, 300, self.gridCellCount, self.gridCellSize, self.gridWidth, self.gridHeight)
	PuzzlePiece(700, 140, self.gridCellCount, self.gridCellSize, self.gridWidth, self.gridHeight)
	PuzzlePiece(133, 100, self.gridCellCount, self.gridCellSize, self.gridWidth, self.gridHeight)
end

function state:leave()
	GameObject.purgeAll()
	self.newspaperGrid = nil
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:mousepressed(x, y, button)
	--mapToTypeWithinRadius
  --shake = shake + 20
	self.puzzlePieceDragged = GameObject.getNearestOfType("PuzzlePiece", x, y)
	self.puzzlePieceDragged.wiggleStartedAt = love.timer.getTime()
end

function state:mousereleased(x, y, button)
	if self.puzzlePieceDragged then
		self.puzzlePieceDragged.snapStartedAt = love.timer.getTime()
		self.puzzlePieceDragged.wiggleStartedAt = love.timer.getTime()
	  self.puzzlePieceDragged = nil
	end
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

 	-- drag
 	if self.puzzlePieceDragged then
  	self.puzzlePieceDragged:drag(scaling.scaleMouse())
  end
end

function state:draw()
	-- draw logic
	GameObject.drawAll()

  -- left and right parts
  love.graphics.rectangle("line", 16, 16, WORLD_W*0.5 - 32, WORLD_H - 32)
  love.graphics.rectangle("line", WORLD_W*0.5 + 16, 16, WORLD_W*0.5 - 32, WORLD_H - 32)

  -- fake grid
  for x = 0, 8 do
		love.graphics.line(16 + x * self.gridCellSize, 16, 16 + x * self.gridCellSize, WORLD_H - 16)
  	for y = 0, 8 do
  		love.graphics.line(16, 16 + y * self.gridCellSize, WORLD_W*0.5 - 16, 16 + y * self.gridCellSize)
  	end
  end
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
