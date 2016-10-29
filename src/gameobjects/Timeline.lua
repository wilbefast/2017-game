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
Initialisation
--]]--

local Timeline = Class({
  type = GameObject.newType("Timeline"),
  layer = 0,
  init = function(self)
    GameObject.init(self, 0, 0)

    self.roundTotal = 100
    self.currentRound = 0

    self.roundCandidate = 0
    self.roundEvent = 0
    self.roundStepCandidate = 15
    self.roundStepEvent = 10
    self.candidateTiles = {
      ingame.societyGrid:gridToTile(2, 2),
      ingame.societyGrid:gridToTile(8, 2),
      ingame.societyGrid:gridToTile(5, 3),
      ingame.societyGrid:gridToTile(3, 4),
      ingame.societyGrid:gridToTile(7, 4)
    }
    self.currentCandidate = 0
    local database = require("assets/twerk/pieces")
    self.candidateList = {
      database.Reac,
      database.Socialo,
      database.Gaucho,
      database.Centre,
      database.Ailleur
    }
    useful.shuffle(self.candidateList)

    -- normalized position
    self.ratioCurrentRound = 0
    self.ratioCurrentTarget = 0

    -- image
    self.timelineCursor = Resources.timelineCursor

    -- layout
    self.margin = 8
    self.height = 32
    self.cursorWidth = 16
    self.cursorHeight = 16
    self.timelineLeft = 716
    self.timelineRight = 1860
    self.timelineWidth = self.timelineRight - self.timelineLeft
    self.timelineTop = WORLD_H - 190
    self.timelineBottom = self.timelineTop + self.timelineCursor:getHeight()

    -- animation
    self.animStart = -1000
    self.animDelay = 1
    self.animScale = 0.5

    -- sorry
    self.actionStart = -1000
    self.actionDelay = 0.5
  end
})
Timeline:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--
function Timeline:spawnNewEvent()
  local randomNumber = math.random()
  local emptyTiles = {}
  local candidateOccupiedTiles = {}
  local newspaperOccupiedTiles = {}
  ingame.societyGrid:map(function(tile) if not tile.piece  then table.insert(emptyTiles, tile) end end)
  ingame.societyGrid:map(function(tile) if tile.piece and tile.piece:isType("PieceCandidate") then table.insert(candidateOccupiedTiles, tile) end end)
	ingame.societyGrid:map(function(tile) if tile.piece and tile.piece:isType("PieceNewspaper") then table.insert(newspaperOccupiedTiles, tile) end end)
  useful.shuffle(candidateOccupiedTiles)

    if randomNumber < 0.33 then
      -- set empty tiles for allies
      if candidateOccupiedTiles[1] then
        ingame:spawnAllyPieceFromCandidate(candidateOccupiedTiles[1].piece,candidateOccupiedTiles[1])
      end
      --ingame:trySpawn(PieceAlly,emptyTiles,1)
    elseif randomNumber < 0.66 then
      -- set empty tiles for attack on newspaper
      if candidateOccupiedTiles[1] then
        ingame:spawnEventPieceFromCandidate(candidateOccupiedTiles[1].piece,candidateOccupiedTiles[1])
      end
      --ingame:trySpawn(PieceEvent,emptyTiles,1)
    else
      log:write("\t\t newspaper tile: ", newspaperOccupiedTiles[0], " or ", newspaperOccupiedTiles[1])
      if newspaperOccupiedTiles[1] then
        ingame:spawnEventPieceFromNewspaper(newspaperOccupiedTiles[1].piece,newspaperOccupiedTiles[1])
        newspaperOccupiedTiles[1].piece:checkForDeaths()
      end
      -- set empty tile for protection of opponents == tile for allies too
    end
  end

function Timeline:spawnNextCandidate()
  local emptyTiles = {}
  for key, tile in ipairs(self.candidateTiles) do
    if not tile.piece then
      table.insert(emptyTiles, tile)
    end
  end
  ingame:trySpawn(PieceCandidate, emptyTiles, 1)
end

function Timeline:tick()
  if self.actionStart + self.actionDelay < love.timer.getTime() then
    self.currentRound = self.currentRound + 1

    if self.currentRound > self.roundTotal then
      GameState.switch(gameover)
    else
      self.ratioCurrentTarget = self.currentRound / self.roundTotal
      self.animStart = love.timer.getTime()
      self.actionStart = love.timer.getTime()
    end

    self.roundCandidate = self.roundCandidate + 1
    if self.roundCandidate >= self.roundStepCandidate then
      self.roundCandidate = 0
      self:spawnNextCandidate()
    end

    -- generate events
    self.roundEvent = self.roundEvent + 1
    if self.roundEvent >= self.roundStepEvent then
      self.roundEvent = 0
      self:spawnNewEvent()
    end

    local destroyablePieces = {}
  --  local destroyablePiecesCount = ingame:countPiecesOfType("PieceAlly", ingame.societyGrid) + ingame:countPiecesOfType("PieceEvent", ingame.societyGrid)

    --if (destroyablePiecesCount > 0) then
      -- not working
      ingame.societyGrid:map(function(tile) if  tile.piece then table.insert(destroyablePieces, tile) end end)
      for p, tile in pairs(destroyablePieces) do
        if tile.piece:isType("PieceAlly") or tile.piece:isType("PieceEvent") then
          tile.piece:updateLifetime()
          if not tile.piece:isAnyPartAttacking() then
            tile.piece.purge = true
          end
        elseif tile.piece:isType("PieceEvidence") then
          tile.piece:attackFromSystem(tile)
          if not tile.piece:isAnyPartAttacking() then
            tile.piece.purge = true
          end
        elseif tile.piece:isType("PieceAdversary") then
          if not tile.piece:isAnyPartAttacking() then
            tile.piece.purge = true
          end
        end
      end
      end
  --  end

    --ingame.societyGrid:map(function(tile) if tile.piece then tile.piece:checkForDeaths() end end)


  end


function Timeline:combinationHasBeenMade(piece)
  local pieceType = piece:typename()
  if pieceType == "PieceEvidence" or pieceType == "PieceJournalist" or pieceType == "PieceSource" then
    self:tick()
  end
end

--[[------------------------------------------------------------
Game loop
--]]--

function Timeline:draw()
  -- current cursor
  local currentX = self.timelineLeft + self.timelineWidth*self.ratioCurrentRound
  local scale = 1 + self.animScale * math.sin(math.pi * useful.clamp((love.timer.getTime() - self.animStart) / self.animDelay, 0, 1))
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(
    self.timelineCursor,
    currentX - self.timelineCursor:getWidth() * scale / 2,
    self.timelineBottom - scale * self.timelineCursor:getHeight(),
    0,
    scale)
end

function Timeline:update(dt)
  self.ratioCurrentRound = useful.lerp(self.ratioCurrentRound, self.ratioCurrentTarget, 0.5)
end

--[[------------------------------------------------------------
Export
--]]--

return Timeline
