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
  types = {
    { name = "Triangle", id = 1, image = Resources.triangle},
    { name = "Square", id = 2, image = Resources.square},
    { name = "Circle", id = 3, image = Resources.circle},
    { name = "Trapeze", id = 4, image = Resources.trapeze}
  },
  init = function(self, index, x, y, combinationType, convex, color)
    GameObject.init(self, x, y)
    self.index = index
    self.pivot = { x = 0.5, y = 0.5 }
    self.wiggle = { x = 0, y = 0 }
    self.size = PuzzlePiece.cellSize
    self.convex = convex

    self:setType(combinationType)
    self.scale = { x = self.size / self.image:getWidth() / 2, y = self.size / self.image:getHeight() / 2 }

    -- css style (top, right, bottom, left)
    if index == 1 then
      self.offset = { x = 0, y = -1 }
      self.rotation = 0
    elseif index == 2 then
      self.offset = { x = 1, y = 0 }
      self.rotation = math.pi / 2
    elseif index == 3 then
      self.rotation = math.pi
      self.offset = { x = 0, y = 1 }
    else
      self.offset = { x = -1, y = 0 }
      self.rotation = math.pi * 3 / 2
    end
  end
})
CombinationPart:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function CombinationPart:onPurge()
end

function CombinationPart:setType(combinationTypeIndex)
  if combinationTypeIndex > #self.types then
    log:write("Invalid combination type index", combinationTypeIndex, "defaulting to 1!")
    combinationTypeIndex = 1
  end
  self.combinationType = combinationTypeIndex
  self.image = self.types[combinationTypeIndex].image
  self.scale = { x = self.size / self.image:getWidth() / 2, y = self.size / self.image:getHeight() / 2 }
end

function CombinationPart:draw()
  if self.combinationType ~= 5 then
    if self.convex then
      love.graphics.setColor(255,255,255)
    else
      love.graphics.setColor(100,100,100)
    end
    love.graphics.draw(self.image, self.x + PuzzlePiece.cellSize*0.5, self.y + PuzzlePiece.cellSize*0.5, self.rotation, self.scale.x, self.scale.y, self.image:getWidth() / 2, self.image:getHeight() / 2)
    love.graphics.setColor(255,255,255)
  end
end

function CombinationPart:update(dt)
end

function CombinationPart:follow(x, y)
  self.x = x + self.size * self.offset.x * (1 + self.wiggle.x) * self.pivot.x
  self.y = y + self.size * self.offset.y * (1 + self.wiggle.y) * self.pivot.y
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
