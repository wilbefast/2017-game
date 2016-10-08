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
    financial = { image = Resources.combinations.financial },
    world = { image = Resources.combinations.world },
    state = { image = Resources.combinations.state },
    sexual = { image = Resources.combinations.sexual },
    null = {}
  },
  directions = {
    N = { name = "N", offset = { x = 0, y = -1 }, rotation = 0 },
    E = { name = "E", offset = { x = 1, y = 0 }, rotation = math.pi / 2},
    S = { name = "S", offset = { x = 0, y = 1 }, rotation = math.pi },
    W = { name = "W", offset = { x = -1, y = 0 }, rotation = math.pi * 3 / 2 }
  },
  init = function(self, args)

    local dir =  args.direction
    local x = args.piece.x
    local y = args.piece.y
    local combinationType = args.type
    local convex = args.convex

    GameObject.init(self, x, y)

    if not combinationType then
      combinationType = useful.randIn({
        "financial",
        "world",
        "state",
        "sexual",
        "null"
      })
    end
    if type(combinationType) == "string" then
      combinationType = self.types[combinationType]
    end
    if convex == nil then
      convex = math.random() > 0.5 and true or false
    end

    self.pivot = { x = 0.5, y = 0.5 }
    self.wiggle = { x = 0, y = 0 }
    self.wiggleDirection = 1
    self.size = PuzzlePiece.cellSize
    self.convex = convex

    local d = self.directions[dir]
    self.offset, self.rotation = d.offset, d.rotation
    self.rotationTarget = self.rotation
    if d.name == "W" or d.name == "E" then
      self.wiggleDirection = -1
    else
      -- self.wiggleDirection = -1
    end

    self:setType(combinationType)
  end
})
CombinationPart:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

function CombinationPart:onPurge()
end

function CombinationPart:setType(combinationType)
  self.combinationType = combinationType
  if combinationType.image then
    self.image = combinationType.image[self.convex and "OUT" or "IN"]
    if self.image then
      self.scale = {
        x = self.size / self.image:getWidth(),
        y = self.size / self.image:getHeight()
      }
    else
      self.scale = { x = 0, y = 0 }
    end
  end
end

--[[------------------------------------------------------------
Game loop
--]]--

function CombinationPart:draw()
  if self.image then
    love.graphics.draw(
      self.image,
      self.x + PuzzlePiece.cellSize*0.5,
      self.y + PuzzlePiece.cellSize*0.5,
      self.rotation,
      self.scale.x * (1 + self.wiggleDirection * self.wiggle.x),
      self.scale.y * (1 + self.wiggleDirection * self.wiggle.y),
      PuzzlePiece.cellSize / 2,
      self.image:getHeight())
  end
end

function CombinationPart:update(dt)
  self.rotation = useful.lerp(self.rotation, self.rotationTarget, 0.5)
end

--[[------------------------------------------------------------
Modify
--]]--

function CombinationPart:follow(x, y)
  self.x = x--+ self.size * self.offset.x * (1 + self.wiggle.x) * self.pivot.x
  self.y = y--+ self.size * self.offset.y * (1 + self.wiggle.y) * self.pivot.y
end

function CombinationPart:doTheWiggle(x, y)
  self.wiggle.x = x
  self.wiggle.y = y
end

function CombinationPart:rotate(direction)
  local radian = 0

  if direction > 0 then
    radian = math.pi/2
  elseif direction < 0 then
    radian = -math.pi/2
  end

  self.rotationTarget = self.rotationTarget + radian

end

--[[------------------------------------------------------------
Query
--]]--

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
