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
	-- setup grid sizes and spacing between them
	local spacing = 155
	local newspapergrid_tiles_across = 3
	local society_tiles_across = 6
	local grid_tiles_down = 5
	local total_tiles_across = newspapergrid_tiles_across + society_tiles_across
	local tile_size = 155 --(WORLD_W - 3*spacing) / total_tiles_across
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

	-- set up the wiggle
	PuzzlePiece.cellSize = tile_size

	-- puzzle pieces
	--PuzzlePiece(200, 300)
	-- PuzzlePiece(700, 140)
	-- PuzzlePiece(133, 100)

	self.grabbedPiece = nil
	self.hoveredTile = nil

	-- test newspaper
	PieceNewspaper(self.societyGrid:gridToTile(2,2))
end

function state:leave()
	GameObject.purgeAll()
	self.newspaperGrid = nil
	self.societyGrid = nil
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:mousepressed(x, y, button)
	if DEBUG and self.hoveredTile then
		PuzzlePiece(self.hoveredTile)
		return
	end

  -- drag puzzle piece
	if self.grabbedPiece then
		return
	end
	if not self.hoveredTile then
		return
	end
	local piece = self.hoveredTile.piece
	if not piece then
		return
	end
	piece:grab(piece)
	self.grabbedPiece = piece
end

function state:mousereleased(x, y, button)
	if self.grabbedPiece then
		self.grabbedPiece:drop(self.hoveredTile) -- self.hoveredTile can be nil
		self.grabbedPiece = nil
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

	-- hover tiles
	if self.hoveredTile then
		self.hoveredTile.hovered = false
		self.hoveredTile = nil
	end
	local newHoveredTile = self.newspaperGrid:pixelToTile(mx, my) or self.societyGrid:pixelToTile(mx, my)
	if newHoveredTile then
 		self.hoveredTile = newHoveredTile
		newHoveredTile.hovered = true
	end

 	-- drag
 	if self.grabbedPiece then
  	self.grabbedPiece:drag(mx, my)
  end
end

function state:draw()
	love.graphics.draw(Resources.ingame)

	-- newspaper grid
	love.graphics.setColor(255, 255, 0)
		self.newspaperGrid:draw()
	useful.bindWhite()

	-- society grid
	love.graphics.setColor(0, 255, 0)
		self.societyGrid:draw()
	useful.bindWhite()

	-- draw logic
	GameObject.drawAll()
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
