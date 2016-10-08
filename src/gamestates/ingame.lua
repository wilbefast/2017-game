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
	local spacing = 153
	local spacingSocietyGrid = 177
	local newspapergrid_tiles_across = 3
	local society_tiles_across = 9
	local grid_tiles_down = 5
	local total_tiles_across = newspapergrid_tiles_across + society_tiles_across
	local tile_size = 128--(WORLD_W - 3*spacing) / total_tiles_across
	local newspapergrid_width = newspapergrid_tiles_across * tile_size
	local societygrid_width = society_tiles_across * tile_size
	local grid_height = grid_tiles_down*tile_size
	local offset_y = (WORLD_H - grid_height)*0.5

	self.newspaperLimit = 650

	-- newspaper grid
	self.newspaperGrid = CollisionGrid(
		NewspaperGridTile, tile_size, tile_size,
		newspapergrid_tiles_across, grid_tiles_down, spacing, offset_y)

	-- society grid
	self.societyGrid = CollisionGrid(
		NewspaperGridTile, tile_size, tile_size,
		society_tiles_across, grid_tiles_down, newspapergrid_width + spacing + spacingSocietyGrid, offset_y)

	-- set up the wiggle
	PuzzlePiece.cellSize = tile_size

	-- initialise state
	self.grabbedPiece = nil
	self.hoveredTile = nil

	-- spawn all the starting pieces
	local spawn = require("assets/twerk/spawn")
	for i, args in ipairs(spawn) do
		local i = 1
		while i <= math.min(args.count, #args.possiblePositions) do
			local position = useful.randIn(args.possiblePositions)
			local grid = self[args.grid]
			if not grid then
				log:write("Invalid grid name", args.grid)
				grid = self.societyGrid
			end
			local tile = grid:gridToTile(position.col, position.row)
			if not tile.piece then
				local name = useful.randIn(args.name)
				local template = PuzzlePiece.database[name]
				local pieceType = _G[template.pieceType]
				if pieceType then
					pieceType(tile, template)
				else
					log:write("Invalid piece type", template.pieceType)
				end
				i = i + 1
			end
		end
	end

	-- ensure that there are 3 source puzzle pieces
	self:spawnSourcePieces()

	-- tooltip
	self.tooltip = Tooltip()

	-- timeline
	self.timeline = Timeline()
end

function state:leave()
	GameObject.purgeAll()
	self.newspaperGrid = nil
	self.societyGrid = nil
end

--[[------------------------------------------------------------
Game logic
--]]--

function state:spawnSourcePieces()

	local emptyTiles = {}
	self.newspaperGrid:map(function(tile) if not tile.piece then table.insert(emptyTiles, tile) end end)
	local sourcesToSpawn = math.max(0, math.min(#emptyTiles, 3 - GameObject.countOfType("PieceSource")))
	if sourcesToSpawn <= 0 then
		return
	end

	useful.shuffle(emptyTiles)
	for i = 1, sourcesToSpawn do
		PieceSource(emptyTiles[i])
	end
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:mousepressed(x, y, button)

	-- add puzzle piece
	-- if self.hoveredTile and button > 1 then
	-- 	PuzzlePiece(self.hoveredTile)
	-- 	return
	-- end

	if self.grabbedPiece then
		return
	end
	if not self.hoveredTile then
		return
	end
	local piece = self.hoveredTile.piece
	if not piece or self.hoveredTile.grid == self.societyGrid then
		return
	end

  -- drag puzzle piece
  if button == 1 then
		piece:grab(piece)
		self.grabbedPiece = piece
	-- rotate puzzle piece
	elseif button == 2 then
		piece:rotate(1)
	end
end

function state:mousereleased(x, y, button)
	if button == 1 and self.grabbedPiece then
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

--[[------------------------------------------------------------
Game loop
--]]--

function state:update(dt)
  -- update logic
  GameObject.updateAll(dt)

	-- hover tiles
	if self.hoveredTile then
		self.hoveredTile.hovered = false
		self.hoveredTile = nil
	else
		if self.tooltip.image then
			self.tooltip:hide()
		end
	end
	local newHoveredTile = self.newspaperGrid:pixelToTile(mx, my) or self.societyGrid:pixelToTile(mx, my)
	if newHoveredTile then
 		self.hoveredTile = newHoveredTile
		newHoveredTile.hovered = true

		local hoveredPiece = self.hoveredTile.piece
		if hoveredPiece then
			if hoveredPiece.imageTooltip then
				if self.tooltip.disappeared then
					self.tooltip:show(
						hoveredPiece.x + PuzzlePiece.cellSize,
						hoveredPiece.y + PuzzlePiece.cellSize,
						hoveredPiece.imageTooltip)
				end
			else
				self.tooltip:hide()
			end
		else
			self.tooltip:hide()
		end
	end

 	-- drag
 	if self.grabbedPiece then
		self.grabbedPiece:drag(mx, my)
		if not self.grabbedPiece:isType("Evidence") and mx > self.newspaperLimit then
			self.grabbedPiece:drop(self.grabbedPiece.previousTile) -- self.hoveredTile can be nil
			self.grabbedPiece = nil
		end
  end

	-- spawn source tiles
	self:spawnSourcePieces()
end

function state:draw()
	love.graphics.draw(Resources.ingame)

	if self.grabbedPiece then
		-- newspaper grid
		love.graphics.setColor(255, 255, 0)
			self.newspaperGrid:draw()
		useful.bindWhite()

		-- society grid
		love.graphics.setColor(0, 255, 0)
			self.societyGrid:draw()
		useful.bindWhite()
	end

	-- draw logic
	GameObject.drawAll()
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
