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
INGAME GAMESTATE
--]]------------------------------------------------------------

local state = GameState.new()

--[[------------------------------------------------------------
GameState navigation
--]]--

function state:init()
end

function state:enter()
	GameObject.purgeAll()
	self.newspaperGrid = nil
	self.societyGrid = nil

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

	-- specific gui
	self.tooltip = Tooltip()
	self.timeline = Timeline()
	self.pouf = Pouf()

	-- ensure that there are 3 source puzzle pieces
	self:spawnSourcePieces()

end

function state:leave()
	GameObject.purgeAll()
end

--[[------------------------------------------------------------
Query
--]]--

function state:countPiecesOfType(type, grid)
	if grid then
		return grid:count(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type)
		end)
	else
		return self.newspaperGrid:count(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type)
		end) + self.societyGrid:count(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type)
		end)
	end
end

function state:countPiecesOfTypeSuchThat(type, suchThat, grid)
	if grid then
		return grid:count(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type) and suchThat(t.piece)
		end)
	else
		return self.newspaperGrid:count(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type) and suchThat(t.piece)
		end) + self.societyGrid:count(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type) and suchThat(t.piece)
		end)
	end
end

function state:isPieceOfTypeSuchThat(type, suchThat, grid)
	if grid then
		return grid:any(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type) and suchThat(t.piece)
		end)
	else
		return self.newspaperGrid:any(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type) and suchThat(t.piece)
		end) or self.societyGrid:any(function(t)
			return t.piece and not t.piece.purge and t.piece:isType(type) and suchThat(t.piece)
		end)
	end
end



--[[------------------------------------------------------------
Game logic
--]]--

function state:trySpawn(class, candidateTiles, numberToSpawn)
	if #candidateTiles <= 0 then
		return
	end
	useful.shuffle(candidateTiles)
	local numberToSpawn = numberToSpawn or 1
	local spawnedPieces = 0
	local i = 1
	log:write("Spawning", GameObject.typename(class))
	while spawnedPieces < numberToSpawn and i <= #candidateTiles do
		if false then
		else
			local tile = candidateTiles[i]
			-- TODO - check whether a spawn is actually possible on this tile
			local piece = class(tile)
			log:write("\tspawning piece", piece.name, "at", tile.col, tile.row)
			spawnedPieces = spawnedPieces + 1

			self.pouf:emit(tile)
		end
		i = i + 1
	end
	if spawnedPieces < numberToSpawn then
		log:write("Only able to spawn", spawnedPieces, "of", numberToSpawn, "into a set of", #candidateTiles, "tiles")
	end
end

function state:spawnSourcePieces()

	local emptyTiles = {}
	self.newspaperGrid:map(function(tile) if not tile.piece then table.insert(emptyTiles, tile) end end)
	if #emptyTiles <= 3  then
		-- there must be no more than 12 pieces in the newspaper section (=> 3 spaces)
		return
	end
	local sourcePieces = self:countPiecesOfType("PieceSource", self.newspaperGrid)
	local sourcesToSpawn = math.max(0, math.min(#emptyTiles - 3, 3 - sourcePieces))
	if sourcesToSpawn <= 0 then
		return
	end
	self:trySpawn(PieceSource, emptyTiles, sourcesToSpawn)
end

function state:spawnEvidencePieceFromSource(source)
	local emptyTiles = {}
	self.newspaperGrid:map(function(tile) if not tile.piece then table.insert(emptyTiles, tile) end end)
	if #emptyTiles <= 3  then
		-- there must be no more than 12 pieces in the newspaper section (=> 3 spaces)
		log:write("Not enough room to spawn evidence, there are only", #emptyTiles, "free tiles")
		return
	end
	self:trySpawn(PieceEvidence, emptyTiles)
end

function state:spawnEvidencePieceFromEvidence(source)
	local emptyTiles = {}
	self.newspaperGrid:map(function(tile) if not tile.piece then table.insert(emptyTiles, tile) end end)
	if #emptyTiles <= 3  then
		-- there must be no more than 12 pieces in the newspaper section (=> 3 spaces)
		log:write("Not enough room to spawn evidence, there are only", #emptyTiles, "free tiles")
		return
	end
	self:trySpawn(PieceEvidence, emptyTiles)
end

--[[------------------------------------------------------------
Events
--]]--

function state:combinationHasBeenMade(piece)
	self.timeline:combinationHasBeenMade(piece)

	-- win if there are no candidates
	if self:countPiecesOfType("PieceCandidate") <= 0 then
		GameState.switch(gameover)
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
		if self.hoveredTile and not self.grabbedPiece:isType("PieceEvidence") and self.hoveredTile.grid == self.societyGrid then
			self.grabbedPiece:drop(self.grabbedPiece.previousTile)
		else
			self.grabbedPiece:drop(self.hoveredTile) -- self.hoveredTile can be nil
		end
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
	end
	local newHoveredTile = self.newspaperGrid:pixelToTile(mx, my) or self.societyGrid:pixelToTile(mx, my)
	if newHoveredTile then
 		self.hoveredTile = newHoveredTile
		newHoveredTile.hovered = true
	end

	-- tooltip
	if self.hoveredTile then
		local hoveredPiece = self.hoveredTile.piece
		if hoveredPiece then
			if hoveredPiece.imageTooltip then
				if self.tooltip.disappeared then
					if self.tooltip.hovered then
						if self.tooltip:hoverDelayComplete() then
							self.tooltip:show(
								hoveredPiece.x + PuzzlePiece.cellSize,
								hoveredPiece.y + PuzzlePiece.cellSize,
								hoveredPiece.imageTooltip)
						end
					else
						self.tooltip:hover()
					end
				elseif self.tooltip.image ~= hoveredPiece.imageTooltip then
					self.tooltip:hide()
				end
			else
				self.tooltip:hide()
			end
		else
			self.tooltip:hide()
		end
	else
		self.tooltip:hide()
	end

 	-- drag
 	if self.grabbedPiece then
		self.grabbedPiece:drag(mx, my)
		if not self.grabbedPiece:isType("PieceEvidence") then
			if mx > self.newspaperLimit + PuzzlePiece.cellSize then
				self.grabbedPiece.x = math.min(self.grabbedPiece.x, self.newspaperLimit - PuzzlePiece.cellSize)
				self.grabbedPiece:followCombinationParts()
				self.grabbedPiece:drop(self.grabbedPiece.previousTile) -- self.hoveredTile can be nil
				self.grabbedPiece = nil
			else
				local stretchRatio = 0
				local stretchRatio = state.smoothstep(
					self.newspaperLimit - PuzzlePiece.cellSize/2,
					self.newspaperLimit + PuzzlePiece.cellSize,
					mx)
				self.grabbedPiece.x = math.min(self.grabbedPiece.x, self.newspaperLimit - PuzzlePiece.cellSize + PuzzlePiece.cellSize * stretchRatio / 4)
				self.grabbedPiece:setStretch(stretchRatio)
			end
		end
  else
		-- spawn source tiles
		self:spawnSourcePieces()
	end
end

function state:draw()
	love.graphics.draw(Resources.ingame)

	if self.grabbedPiece then
		-- newspaper grid
		love.graphics.setColor(255, 255, 0)
			self.newspaperGrid:draw()
		useful.bindWhite()

		-- society grid
		if self.grabbedPiece:isType("PieceEvidence") then
			love.graphics.setColor(0, 255, 0)
				self.societyGrid:draw()
			useful.bindWhite()
		end
	end

	-- draw logic
	GameObject.drawAll()
end

-- https://www.khronos.org/opengles/sdk/docs/man31/html/smoothstep.xhtml
function state.smoothstep (edge0, edge1, x)
  local t = useful.clamp((x - edge0) / (edge1 - edge0), 0, 1)
  return t * t * (3 - 2 * t)
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state
