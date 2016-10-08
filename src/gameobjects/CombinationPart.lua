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
  init = function(self, x, y, combinationType, convex, offset, cellSize, color)
    GameObject.init(self, x, y)
    self.pivot = { x = 0.5, y = 0.5 }
    self.size = 32
    self.convex = convex
    self.combinationType = combinationType
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
  if self.convex then
    love.graphics.setColor(255,255,255)
  else
    love.graphics.setColor(0,0,0)
  end
  local x = self.x + self.size * self.pivot.x
  local y = self.y + self.size * self.pivot.y
  if self.combinationType == 0 then
    local top = y + self.size
    if self.convex then
      top = y - self.size
    end
    love.graphics.polygon("fill", x - self.size, y, x + self.size, y, x, top)
  -- elseif self.combinationType == 1
  else
    love.graphics.rectangle("fill", x - self.size, y, self.size * 2, self.size)
  end
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
  return combinationPart.combinationType == self.combinationType and combinationPart.convex ~= self.convex
end

function CombinationPart:shouldRepulse(combinationPart)
  return combinationPart.convex and self.convex
end

--[[------------------------------------------------------------
Export
--]]--

return CombinationPart
