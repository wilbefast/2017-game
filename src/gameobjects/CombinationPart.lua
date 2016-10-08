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

local CombinationPart = Class({
  type = GameObject.newType("CombinationPart"),
  layer = 1,
  init = function(self, x, y, type, convex, offset, cellSize)
    GameObject.init(self, x, y)
    self.pivot = { x = 0.5, y = 0.5 }
    self.size = 32
    self.convex = convex
    self.type = type
    self.offset = offset
    self.cellSize = cellSize
    self.wiggle = { x = 0, y = 0 }
  end
})
CombinationPart:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function CombinationPart:onPurge()
end

function CombinationPart:draw()
  -- if self.convex then
    -- background color
  --   love.graphics.setColor(91, 132, 192)
  -- else
    love.graphics.setColor(0,255,0)
  -- end
  local style = ""
  if self.convex then
    style = "fill"
  else
    style = "line"
  end
  love.graphics.rectangle(style, self.x, self.y, self.size, self.size)
  love.graphics.setColor(255,255,255)
end

function CombinationPart:update(dt)
end

function CombinationPart:follow(x, y)
  self.x = x - self.pivot.x * self.size + self.offset.x * self.cellSize / 2 * (1 + self.wiggle.x)
  self.y = y - self.pivot.y * self.size + self.offset.y * self.cellSize / 2 * (1 + self.wiggle.y)
end

function CombinationPart:doTheWiggle(x, y)
  self.wiggle.x = x
  self.wiggle.y = y
end

function CombinationPart:checkMatching(combinationPart)
  return combinationPart.type == self.type and combinationPart.convex ~= self.convex
end

function CombinationPart:shouldRepulse(combinationPart)
  return combinationPart.convex and self.convex
end

--[[------------------------------------------------------------
Export
--]]--

return CombinationPart
