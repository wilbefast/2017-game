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
  init = function(self, x, y, type, offset, cellSize)
    GameObject.init(self, x, y)
    self.pivot = { x = 0.5, y = 0.5 }
    self.size = 32
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
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
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

--[[------------------------------------------------------------
Export
--]]--

return CombinationPart
