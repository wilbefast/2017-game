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

	local spacing = 16

	local newspapergrid_tiles_across = 3
	local society_tiles_across = 6

	local grid_tiles_down = 5

	local total_tiles_across = newspapergrid_tiles_across + society_tiles_across
	local tile_size = (WORLD_W - 3*spacing) / total_tiles_across

	local newspapergrid_width = newspapergrid_tiles_across * tile_size
	local societygrid_width = society_tiles_across * tile_size

	-- newspaper grid
	self.newspaperGrid = CollisionGrid(
		NewspaperGridTile, tile_size, tile_size,
		newspapergrid_tiles_across, grid_tiles_down, spacing, spacing)

	-- society grid
	self.societyGrid = CollisionGrid(
		NewspaperGridTile, tile_size, tile_size,
		society_tiles_across, grid_tiles_down, newspapergrid_width + 2*spacing, spacing)

	--self.newspaperGrid = CollisionGrid()
	self.gridCellCount = 8
	self.gridWidth = (WORLD_W*0.5 - 32)
	self.gridCellSize = self.gridWidth / self.gridCellCount
	self.gridHeight = self.gridCellCount * self.gridCellSize--WORLD_H - 16
	PuzzlePiece(200, 300, self.gridCellCount, self.gridCellSize, self.gridWidth, self.gridHeight)
	PuzzlePiece(700, 140, self.gridCellCount, self.gridCellSize, self.gridWidth, self.gridHeight)
	PuzzlePiece(133, 100, self.gridCellCount, self.gridCellSize, self.gridWidth, self.gridHeight)

	self.lastPosition = { x = 0, y = 0 }
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

  -- drag puzzle piece
	self.puzzlePieceDragged = GameObject.getNearestOfType("PuzzlePiece", x, y)
  local distance = Vector.dist(x, y, self.puzzlePieceDragged.x, self.puzzlePieceDragged.y)
	if distance < self.gridCellSize then
		self.puzzlePieceDragged.wiggleStartedAt = love.timer.getTime()
		self.lastPosition.x = self.puzzlePieceDragged.x
		self.lastPosition.y = self.puzzlePieceDragged.y
	else
		self.puzzlePieceDragged = nil
	end
end

function state:mousereleased(x, y, button)

	-- check for combination
	-- GameObject.mapToType("PuzzlePiece", function(piece)
	log:write("woop")
	if self.puzzlePieceDragged then
		local piece = self.puzzlePieceDragged
		GameObject.mapToType("PuzzlePiece", function(other)
			if piece ~= other then
				local distance = Vector.dist(piece.gridIndex.x, piece.gridIndex.y, other.gridIndex.x, other.gridIndex.y)

				if distance == 0 then
					self:bringBackPiece(piece, self.lastPosition.x, self.lastPosition.y)

				elseif distance <= 1 then
					local match, repulse = piece:checkMatching(other)
					if match then
						log:write("YEAH!!!")

					elseif repulse then
						self:bringBackPiece(piece, self.lastPosition.x, self.lastPosition.y)
					end
				end
			end
		end)
	end
	-- end)

	-- drop puzzle piece
	if self.puzzlePieceDragged then
		self.puzzlePieceDragged.snapStartedAt = love.timer.getTime()
		self.puzzlePieceDragged.wiggleStartedAt = love.timer.getTime()
	  self.puzzlePieceDragged = nil
	end
end

function state:bringBackPiece(piece, x, y)
	babysitter.activeWaitThen(1, function(t)
		piece.x = useful.lerp(piece.x, x, t)
		piece.y = useful.lerp(piece.y, y, t)
		piece:followCombinationParts()
	end)
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


  -- left and right parts
  --love.graphics.rectangle("line", 16, 16, self.newspaperGridWidth, WORLD_H - 32)
  --love.graphics.rectangle("line", WORLD_W*0.5 + 16, 16, self.societyGridWidth, WORLD_H - 32)

  -- fake grid
  for x = 0, 8 do
		love.graphics.line(16 + x * self.gridCellSize, 16, 16 + x * self.gridCellSize, WORLD_H - 16)
  	for y = 0, 8 do
  		love.graphics.line(16, 16 + y * self.gridCellSize, WORLD_W*0.5 - 16, 16 + y * self.gridCellSize)
  	end
  end

	love.graphics.setColor(255, 255, 0)
		self.newspaperGrid:draw()
	useful.bindWhite()

	love.graphics.setColor(0, 255, 0)
		self.societyGrid:draw()
	useful.bindWhite()

	-- draw logic
	GameObject.drawAll()
end

function state:drawPieces()
	GameObject.mapToType("PuzzlePiece", function(piece) piece:drawPiece() end)
	GameObject.mapToType("CombinationPart", function(part) part:drawPart() end)
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
