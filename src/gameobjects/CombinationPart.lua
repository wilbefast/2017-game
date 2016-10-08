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
    financial = { image = Resources.triangle},
    world = { image = Resources.square},
    state = { image = Resources.circle},
    sexual = { image = Resources.trapeze},
    null = {}
  },
  directions = {
    N = { offset = { x = 0, y = -1 }, rotation = 0 },
    E = { offset = { x = 1, y = 0 }, rotation = math.pi / 2},
    S = { offset = { x = 0, y = 1 }, rotation = math.pi },
    W = { offset = { x = -1, y = 0 }, rotation = math.pi * 3 / 2 }
  },
  init = function(self, dir, x, y, combinationType, convex)
    GameObject.init(self, x, y)

    combinationType = combinationType or self.types[useful.randIn({
      "financial",
      "world",
      "state",
      "sexual",
      "null"
    })]
    if convex == nil then
      convex = math.random() > 0.5 and true or false
    end

    self.pivot = { x = 0.5, y = 0.5 }
    self.wiggle = { x = 0, y = 0 }
    self.size = PuzzlePiece.cellSize
    self.convex = convex

    local d = self.directions[dir]
    self.offset, self.rotation = d.offset, d.rotation


    self:setType(combinationType)
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
  if combinationType.image then
    self.scale = {
      x = self.size / combinationType.image:getWidth() / 2,
      y = self.size / combinationType.image:getHeight() / 2
    }
  else
    self.scale = {
      x = 0,
      y = 0
    }
  end
end

function CombinationPart:draw()
  local image =  self.combinationType.image
  if image then
    if self.convex then
      love.graphics.setColor(255,255,255)
    else
      love.graphics.setColor(100,100,100)
    end
    love.graphics.draw(image,
      self.x + PuzzlePiece.cellSize*0.5,
      self.y + PuzzlePiece.cellSize*0.5,
      self.rotation, self.scale.x,
      self.scale.y,
      image:getWidth() / 2,
      image:getHeight() / 2)
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
