--[[
(C) Copyright 2014 William Dyce

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

local PuzzlePiece = Class({
  type = GameObject.newType("PuzzlePiece"),
  layer = 0,
  snapDelay = 0.2,
  init = function(self, tile)
    GameObject.init(self, tile.x, tile.y)

    self.t = math.random()
    self.tile = tile
    tile.piece = self

    self.size = { x = self.cellSize, y = self.cellSize }

    -- wiggle animation
    self.wiggleStartedAt = love.timer.getTime()
    self.wiggleDelay = 0.3
    self.wiggleScale = 0.2
    self.wiggleCount = 3
    self.wiggle = { x = 0, y = 0 }

    -- snap animation
    self.snapStartedAt = love.timer.getTime()

    -- combination parts
    self.combinationPartList = {}
    self:generateCombination()

    self.color = {
      r = math.ceil(math.random() * 255),
      g = math.ceil(math.random() * 255),
      b = math.ceil(math.random() * 255)
    }
  end
})
PuzzlePiece:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

function PuzzlePiece:grab()
  self.wiggleStartedAt = love.timer.getTime()
  self.previousTile = self.tile
  self.tile.piece = nil
  self.tile = nil
end


function PuzzlePiece:drop(tile)
  if not tile or tile.piece then
    -- this tile already has a piece in it - revert back to previous tile!
    tile = self.previousTile
  end

  self.snapStartedAt = love.timer.getTime()
  self.wiggleStartedAt = love.timer.getTime()

  self.tile = tile
  self.previousTile = nil
  tile.piece = self

  local x, y = tile.x, tile.y
  babysitter.activeWaitThen(1, function(t)
    if not self.tile then
      return true -- interrupt
    end
    self.x = useful.lerp(self.x, x, t)
    self.y = useful.lerp(self.y, y, t)
  end)
end

function PuzzlePiece:onPurge()
end

function PuzzlePiece:generateCombination()
  -- css style (top, right, bottom, left)
  for i = 0, 3 do
    self.combinationPartList[i] = CombinationPart(i, self.x, self.y, math.floor(math.random() * 4), math.random() > 0.5, self.cellSize)
  end
end

--[[------------------------------------------------------------
Game loop
--]]--

function PuzzlePiece:draw()

  -- snap feedback
  -- if self.tile then
  --   love.graphics.setColor(255,0,0, 100)
  --   love.graphics.rectangle("fill", self.snapPosition.x - self.cellSize, self.snapPosition.y - self.cellSize, self.cellSize, self.cellSize)
  -- end

  -- draw the piece
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.x, self.y, self.size.x, self.size.y)
  love.graphics.setColor(255,255,255)

  -- show grid coordinates
  if self.tile then
    local c, r = self.tile.col, self.tile.row
    love.graphics.setFont(fontMedium)
    love.graphics.print(c .. ', ' .. r, self.x + self.size.x*0.35, self.y + self.size.y*0.35)
  end
end

function PuzzlePiece:followCombinationParts()
  -- combination parts
  for i = 0, #self.combinationPartList do
    self.combinationPartList[i]:follow(self.x, self.y)-- - self.pivot.x * self.size.x, self.y - self.pivot.y * self.size.y)
    self.combinationPartList[i]:doTheWiggle(self.wiggle.x, self.wiggle.y)
  end
end

function PuzzlePiece:update(dt)
  -- timing
  self.t = self.t + dt
  if self.t > 1 then
    self.t = self.t - 1
  end

  -- wiggle animation
  local wiggleRatio = 1 - useful.clamp((love.timer.getTime() - self.wiggleStartedAt) / self.wiggleDelay, 0, 1)
  local t = self.t * self.wiggleCount * math.pi * 2
  self.wiggle.x = self.wiggleScale * math.cos(t) * wiggleRatio
  self.wiggle.y = self.wiggleScale * math.cos(t + math.pi) * wiggleRatio
  self.size.x = self.cellSize * (1 + self.wiggle.x)
  self.size.y = self.cellSize * (1 + self.wiggle.y)

  -- snap animation
  if self.tile then
    local snapRatio = 1 - useful.clamp((love.timer.getTime() - self.snapStartedAt) / self.snapDelay, 0, 1)
    self.x = useful.lerp(self.x, self.tile.x, 0.5 * snapRatio)
    self.y = useful.lerp(self.y, self.tile.y, 0.5 * snapRatio)
  end

  self:followCombinationParts()
end

function PuzzlePiece:drag(x, y)
  self.x = useful.lerp(self.x, x - self.cellSize*0.5, 0.5)
  self.y = useful.lerp(self.y, y - self.cellSize*0.5, 0.5)

  self:followCombinationParts()
end

function PuzzlePiece:getTop()
  return self.combinationPartList[0]
end

function PuzzlePiece:getRight()
  return self.combinationPartList[1]
end

function PuzzlePiece:getBottom()
  return self.combinationPartList[2]
end

function PuzzlePiece:getLeft()
  return self.combinationPartList[3]
end

function PuzzlePiece:checkMatching(puzzlePiece)
  return false
  -- local partA, partB
  -- if self.gridIndex.x == puzzlePiece.gridIndex.x then
  --   if self.gridIndex.y < puzzlePiece.gridIndex.y then
  --     -- check bottom
  --     partA = self:getBottom()
  --     partB = puzzlePiece:getTop()
  --   else
  --     -- check top
  --     partA = self:getTop()
  --     partB = puzzlePiece:getBottom()
  --   end
  -- elseif self.gridIndex.y == puzzlePiece.gridIndex.y then
  --   if self.gridIndex.x < puzzlePiece.gridIndex.x then
  --     -- check left
  --     partA = self:getRight()
  --     partB = puzzlePiece:getLeft()
  --   else
  --     -- check right
  --     partA = self:getLeft()
  --     partB = puzzlePiece:getRight()
  --   end
  -- end
  --
  -- return partA:checkMatching(partB), partA:shouldRepulse(partB)
end

--[[------------------------------------------------------------
Export
--]]--

return PuzzlePiece
