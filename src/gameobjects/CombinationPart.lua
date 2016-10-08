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
  init = function(self, index, x, y, combinationType, convex, color)
    GameObject.init(self, x, y)
    self.index = index
    self.pivot = { x = 0.5, y = 0.5 }
    self.size = PuzzlePiece.cellSize
    self.convex = convex

    self:setType(combinationType)

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
    self.wiggle = { x = 0, y = 0 }

    self.scale = { x = self.size / self.image:getWidth() / 2, y = self.size / self.image:getHeight() / 2 }
  end
})
CombinationPart:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function CombinationPart:onPurge()
end

function CombinationPart:setType(combinationType)
  self.combinationType = combinationType
  if combinationType == 1 then
    self.image = Resources.triangle
  elseif combinationType == 2 then
    self.image = Resources.square
  elseif combinationType == 3 then
    self.image = Resources.circle
  elseif combinationType == 4 then
    self.image = Resources.trapeze
  end
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
