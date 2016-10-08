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
  self.combinationPartList[0] = CombinationPart(self.x, self.y, 0, false, { x = 0, y = -1 }, self.cellSize)
  self.combinationPartList[1] = CombinationPart(self.x, self.y, 0, true, { x = 1, y = 0 }, self.cellSize)
  self.combinationPartList[2] = CombinationPart(self.x, self.y, 0, true, { x = 0, y = 1 }, self.cellSize)
  self.combinationPartList[3] = CombinationPart(self.x, self.y, 0, true, { x = -1, y = 0 }, self.cellSize)
end

function PuzzlePiece:draw()

  -- wiggle animation
  local wiggleRatio = 1 - useful.clamp((love.timer.getTime() - self.wiggleStartedAt) / self.wiggleDelay, 0, 1)
  local t = self.t * self.wiggleCount * math.pi * 2
  self.wiggle.x = self.wiggleScale * math.cos(t) * wiggleRatio
  self.wiggle.y = self.wiggleScale * math.cos(t + math.pi) * wiggleRatio
  local sx = self.cellSize * (1 + self.wiggle.x)
  local sy = self.cellSize * (1 + self.wiggle.y)

  -- snap animation
  local snapRatio = 1 - useful.clamp((love.timer.getTime() - self.snapStartedAt) / self.snapDelay, 0, 1)
  local x = (math.ceil((self.x - self.gridMargin) / self.gridWidth * self.gridCellCount) / self.gridCellCount) * self.gridWidth + self.gridMargin
  local y = (math.ceil((self.y - self.gridMargin) / self.gridHeight * self.gridCellCount) / self.gridCellCount) * self.gridHeight + self.gridMargin
  self.x = useful.lerp(self.x, x - self.pivot.x * self.cellSize, 0.5 * snapRatio)
  self.y = useful.lerp(self.y, y - self.pivot.y * self.cellSize, 0.5 * snapRatio)

  -- snap feedback
  love.graphics.setColor(255,0,0, 100)
  love.graphics.rectangle("fill", x - self.cellSize, y - self.cellSize, self.cellSize, self.cellSize)

  -- grid index
  self.gridIndex.x = math.ceil((x - self.gridMargin) / self.gridWidth * self.gridCellCount)
  self.gridIndex.y = math.ceil((y - self.gridMargin) / self.gridHeight * self.gridCellCount)

  -- draw dat piece
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.x - self.pivot.x * sx, self.y - self.pivot.y * sy, sx, sy)
  love.graphics.setColor(255,255,255)

  -- test
  love.graphics.print(self.gridIndex.x .. ', ' .. self.gridIndex.y, self.x - self.pivot.x * sx, self.y - self.pivot.y * sy)

  -- combination parts
  for i = 0, #self.combinationPartList do
    self.combinationPartList[i]:follow(self.x, self.y)
    self.combinationPartList[i]:doTheWiggle(self.wiggle.x, self.wiggle.y)
  end
end

function PuzzlePiece:update(dt)

  -- timing
  self.t = self.t + dt
  if self.t > 1 then
    self.t = self.t - 1
  end
end

function PuzzlePiece:drag(x, y)
  self.x = useful.lerp(self.x, x, 0.5)
  self.y = useful.lerp(self.y, y, 0.5)
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
