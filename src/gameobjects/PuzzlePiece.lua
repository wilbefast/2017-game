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
  init = function(self, x, y, cellCount, cellSize, gridWidth, gridHeight)
    GameObject.init(self, x, y)
    self.t = math.random()

    self.radius = cellSize
    self.gridCellCount = cellCount
    self.gridWidth = gridWidth
    self.gridHeight = gridHeight
    self.gridMargin = 16

    -- wiggle animation
    self.wiggleStartedAt = -1000
    self.wiggleDelay = 0.3
    self.wiggleScale = 0.2
    self.wiggleCount = 3

    -- snap animation
    self.snapStartedAt = -1000
    self.snapDelay = 0.2
  end
})
PuzzlePiece:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function PuzzlePiece:onPurge()
end

function PuzzlePiece:draw()

  -- wiggle animation
  local wiggleRatio = 1 - useful.clamp((love.timer.getTime() - self.wiggleStartedAt) / self.wiggleDelay, 0, 1)
  local t = self.t * self.wiggleCount * math.pi * 2
  local sx = self.radius * (1 + self.wiggleScale * math.cos(t) * wiggleRatio)
  local sy = self.radius * (1 + self.wiggleScale * math.cos(t + math.pi) * wiggleRatio)

  -- draw dat piece
  love.graphics.rectangle("line", self.x - 0.5 * sx, self.y - 0.5 * sy, sx, sy)
end

function PuzzlePiece:update(dt)
  self.t = self.t + dt
  if self.t > 1 then
    self.t = self.t - 1
  end

  -- snap animation
  local snapRatio = 1 - useful.clamp((love.timer.getTime() - self.snapStartedAt) / self.snapDelay, 0, 1)
  local x = (math.ceil((self.x - self.gridMargin) / self.gridWidth * self.gridCellCount) / self.gridCellCount) * self.gridWidth + self.gridMargin
  local y = (math.ceil((self.y - self.gridMargin) / self.gridHeight * self.gridCellCount) / self.gridCellCount) * self.gridHeight + self.gridMargin
  self.x = useful.lerp(self.x, x - 0.5 * self.radius, 0.5 * snapRatio)
  self.y = useful.lerp(self.y, y - 0.5 * self.radius, 0.5 * snapRatio)
end

function PuzzlePiece:drag(x, y)
  self.x = useful.lerp(self.x, x, 0.5)
  self.y = useful.lerp(self.y, y, 0.5)
end

--[[------------------------------------------------------------
Export
--]]--

return PuzzlePiece
