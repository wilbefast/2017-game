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
  init = function(self, x, y, cellCount, cellSize, gridWidth, gridHeight)
    GameObject.init(self, x, y)
    self.t = math.random()

    self.pivot = { x = 0.5, y = 0.5 }
    self.size = { x = cellSize, y = cellSize }

    self.cellSize = cellSize
    self.gridCellCount = cellCount
    self.gridWidth = gridWidth
    self.gridHeight = gridHeight
    self.gridMargin = 16

    -- gridIndex
    self.gridIndex = { x = 0, y = 0 }

    -- wiggle animation
    self.wiggleStartedAt = love.timer.getTime()
    self.wiggleDelay = 0.3
    self.wiggleScale = 0.2
    self.wiggleCount = 3
    self.wiggle = { x = 0, y = 0 }

    -- snap animation
    self.snapStartedAt = love.timer.getTime()
    self.snapDelay = 0.2
    self.snapPosition = { x = 0, y = 0 }

    -- combination parts
    self.combinationPartList = {}
    self:generateCombination()

    self.color = { r = math.ceil(math.random() * 255), g = math.ceil(math.random() * 255), b = math.ceil(math.random() * 255) }
  end
})
PuzzlePiece:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function PuzzlePiece:onPurge()
end

function PuzzlePiece:generateCombination()
  -- css style (top, right, bottom, left)
  for i = 0, 3 do
    self.combinationPartList[i] = CombinationPart(i, self.x, self.y, math.floor(math.random() * 4), math.random() > 0.5, self.cellSize)
  end
end

function PuzzlePiece:drawPiece()

  -- snap feedback
  love.graphics.setColor(255,0,0, 100)
  love.graphics.rectangle("fill", self.snapPosition.x - self.cellSize, self.snapPosition.y - self.cellSize, self.cellSize, self.cellSize)

  -- draw dat piece
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.x - self.pivot.x * self.size.x, self.y - self.pivot.y * self.size.y, self.size.x, self.size.y)
  love.graphics.setColor(255,255,255)

  -- test
  love.graphics.print(self.gridIndex.x .. ', ' .. self.gridIndex.y, self.x - self.pivot.x * self.size.x, self.y - self.pivot.y * self.size.y)
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
  local snapRatio = 1 - useful.clamp((love.timer.getTime() - self.snapStartedAt) / self.snapDelay, 0, 1)
  self.snapPosition.x = (math.ceil((self.x - self.gridMargin) / self.gridWidth * self.gridCellCount) / self.gridCellCount) * self.gridWidth + self.gridMargin
  self.snapPosition.y = (math.ceil((self.y - self.gridMargin) / self.gridHeight * self.gridCellCount) / self.gridCellCount) * self.gridHeight + self.gridMargin
  self.x = useful.lerp(self.x, self.snapPosition.x - self.pivot.x * self.cellSize, 0.5 * snapRatio)
  self.y = useful.lerp(self.y, self.snapPosition.y - self.pivot.y * self.cellSize, 0.5 * snapRatio)

  -- grid index
  self.gridIndex.x = math.ceil((self.snapPosition.x - self.gridMargin) / self.gridWidth * self.gridCellCount)
  self.gridIndex.y = math.ceil((self.snapPosition.y - self.gridMargin) / self.gridHeight * self.gridCellCount)

  self:followCombinationParts()
end

function PuzzlePiece:drag(x, y)
  self.x = useful.lerp(self.x, x, 0.5)
  self.y = useful.lerp(self.y, y, 0.5)

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
  local partA, partB
  if self.gridIndex.x == puzzlePiece.gridIndex.x then
    if self.gridIndex.y < puzzlePiece.gridIndex.y then
      -- check bottom
      partA = self:getBottom()
      partB = puzzlePiece:getTop()
    else
      -- check top
      partA = self:getTop()
      partB = puzzlePiece:getBottom()
    end
  elseif self.gridIndex.y == puzzlePiece.gridIndex.y then
    if self.gridIndex.x < puzzlePiece.gridIndex.x then
      -- check left
      partA = self:getRight()
      partB = puzzlePiece:getLeft()
    else
      -- check right
      partA = self:getLeft()
      partB = puzzlePiece:getRight()
    end
  end

  return partA:checkMatching(partB), partA:shouldRepulse(partB)
end

--[[------------------------------------------------------------
Export
--]]--

return PuzzlePiece
