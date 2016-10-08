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
  init = function(self, index, x, y, combinationType, convex, cellSize, color)
    GameObject.init(self, x, y)
    self.index = index
    self.pivot = { x = 0.5, y = 0.5 }
    self.size = cellSize
    self.convex = convex

    self.combinationType = combinationType
    if combinationType == 0 then
      self.image = Resources.triangle
    elseif combinationType == 1 then
      self.image = Resources.square
    elseif combinationType == 2 then
      self.image = Resources.circle
    elseif combinationType == 3 then
      self.image = Resources.trapeze
    end

    if index == 0 then
      self.offset = { x = 0, y = -1 }
      self.rotation = 0
    elseif index == 1 then
      self.offset = { x = 1, y = 0 }
      self.rotation = math.pi / 2
    elseif index == 2 then
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

function CombinationPart:drawPart()
  if self.convex then
    love.graphics.setColor(255,255,255)
  else
    love.graphics.setColor(100,100,100)
  end
  -- if self.convex then
  --   love.graphics.setBlendMode("alpha")
  -- else
  --   love.graphics.setBlendMode("subtract")
  -- end
  -- local x = self.x + self.size * self.pivot.x
  -- local y = self.y + self.size * self.pivot.y
  -- if self.combinationType == 0 then
  --   local top = y + self.size
  --   if self.convex then
  --     top = y - self.size
  --   end
    -- love.graphics.setColor(255,255,255)
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale.x, self.scale.y, self.size / 2, self.size / 2)
    -- love.graphics.polygon("fill", x - self.size / 2, y, x + self.size / 2, y, x, top)
  -- elseif self.combinationType == 1 then
  --   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
  -- elseif self.combinationType == 2 then
  --   love.graphics.circle("fill", x, y, self.size / 2)
  -- else
  --   love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
  -- end
  love.graphics.setColor(255,255,255)
  love.graphics.setBlendMode("alpha")
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
