--[[
(C) Copyright 2016 William Dyce, Leon Denise, Maxence Voleau

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
    financial = { name = "financial", image = Resources.combinations.financial },
    world = { name = "world", image = Resources.combinations.world },
    state = { name = "state", image = Resources.combinations.state },
    sexual = { name = "sexual", image = Resources.combinations.sexual },
    null = { name = "null" }
  },
  directions = {
    N = { name = "N", offset = { x = 0, y = -1 }, rotation = 0 },
    E = { name = "E", offset = { x = 1, y = 0 }, rotation = math.pi / 2},
    S = { name = "S", offset = { x = 0, y = 1 }, rotation = math.pi },
    W = { name = "W", offset = { x = -1, y = 0 }, rotation = math.pi * 3 / 2 }
  },
  init = function(self, args)

    -- unpack arguments
    local dir =  args.direction
    local x = args.piece.x
    local y = args.piece.y
    local combinationType = args.type
    local convex = args.convex

    -- super
    GameObject.init(self, x, y)

    -- save link to the holder
    self.piece = args.piece

    -- type of part
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

    -- convex or concave?
    if convex == nil then
      convex = math.random() > 0.5 and true or false
    end
    self.convex = convex
    self.concave = not convex
    self.layer = self.convex and 2 or 1
    self.name = (self.convex and " convex " or " concave ") .. combinationType.name

    -- save it all
    self.pivot = { x = 0.5, y = 0.5 }
    self.wiggle = { x = 0, y = 0 }
    self.wiggleDirection = 1
    self.size = PuzzlePiece.cellSize
    self.piece = args.piece

    -- set direction
    local d = self.directions[dir]
    self.offset, self.rotation = d.offset, d.rotation
    self.rotationTarget = self.rotation
    self:setDirection(dir)

    -- set connection type
    self:setType(combinationType)

    -- increment counters
    local t = args.piece.team
    local c = self.convex and "convex" or "concave"
    self.combinationType.count[t][c] = self.combinationType.count[t][c] + 1
    if self.piece:isType("PieceCandidate") then
      self.combinationType.count.Candidate[c] = self.combinationType.count.Candidate[c] + 1
    end
    --log:write("there are", self.combinationType.count[t][c], c, "parts of type", self.combinationType.name, "of team", t)

    -- colour
    self.colour = self.piece.partColour
  end
})
CombinationPart:include(GameObject)

for name, template in pairs(CombinationPart.types) do
  template.count = {
    Player = {
      convex = 0,
      concave = 0
    },
    Enemy = {
      convex = 0,
      concave = 0
    },
    Neutral = {
      convex = 0,
      concave = 0
    },
    Candidate = {
      convex = 0,
      concave = 0
    }
  }
end

--[[------------------------------------------------------------
Events
--]]--

function CombinationPart:onPurge()
  if not self.piece then
    return
  end
  -- decrement counters
  local t = self.piece.team
  local c = self.convex and "convex" or "concave"
  self.combinationType.count[t][c] = self.combinationType.count[t][c] - 1
  if self.piece:isType("PieceCandidate") then
    self.combinationType.count.Candidate[c] = self.combinationType.count.Candidate[c] - 1
  end
  -- unlink
  self.piece = nil
end

function CombinationPart:setType(combinationType)
  self.combinationType = combinationType
  if combinationType.image then
    self.image = combinationType.image[self.convex and "OUT" or "IN"]
    if self.image then
      self.scale = {
        x = PuzzlePiece.cellSize / self.image:getWidth(),
        y = PuzzlePiece.cellSize / self.image:getHeight()
      }
    else
      self.scale = { x = 0, y = 0 }
    end
  end
end

function CombinationPart:resetLayer()
  self.layer = self.convex and 2 or 1
end

--[[------------------------------------------------------------
Game loop
--]]--

function CombinationPart:erase_concave()
  if self.concave then
    love.graphics.draw(
      self.image,
      PuzzlePiece.cellSize*0.5,
      PuzzlePiece.cellSize*0.5,
      self.rotation,
      self.scale.x,
      self.scale.y,
      self.image:getWidth() / 2,
      self.image:getHeight())
  end
end

function CombinationPart:draw_from_piece()
  if self.image and self.convex then
    love.graphics.setColor(self.colour.r, self.colour.g, self.colour.b)
    love.graphics.draw(
      self.image,
      self.x + PuzzlePiece.cellSize*0.5,
      self.y + PuzzlePiece.cellSize*0.5,
      self.rotation,
      self.scale.x * (1 + self.wiggle.x),
      self.scale.y * (1 + self.wiggle.y),
      self.image:getWidth() / 2,
      self.image:getHeight())
    useful.bindWhite()
  end
end

function CombinationPart:update(dt)
  self.rotation = useful.lerp(self.rotation, self.rotationTarget, 0.5)
end

--[[------------------------------------------------------------
Modify
--]]--

function CombinationPart:setDirection(dir)
  local d = self.directions[dir]
  self.offset, self.rotation = d.offset, d.rotation
  self.rotationTarget = self.rotation
  if d.name == "W" or d.name == "E" then
    self.wiggleDirection = -1
  else
    self.wiggleDirection = 1
  end
  self.dir = dir
end

function CombinationPart:follow(x, y)
  self.x = x--+ self.size * self.offset.x * (1 + self.wiggle.x) * self.pivot.x
  self.y = y--+ self.size * self.offset.y * (1 + self.wiggle.y) * self.pivot.y
end

function CombinationPart:doTheWiggle(x, y)
  if self.wiggleDirection > 0 then
    self.wiggle.x = x
    self.wiggle.y = y
  else
    self.wiggle.x = y
    self.wiggle.y = x
  end
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

function CombinationPart:isAttack()
  if not self.convex then
    log:write("\t\tNot attack because not convex")
    return false
  end
  local affectedTile = self.piece.tile[self.dir]
  if not affectedTile then
    log:write("\t\tNot attack because no tile in direction", self.dir)
    return false
  end
  local affectedPiece = affectedTile.piece
  if not affectedPiece then
    log:write("\t\tNot attack because nobody is in", affectedTile.col, affectedTile.row)
    for i, v in pairs(affectedTile) do
      log:write("\t\t\t", i, v)
    end
    return false
  end
  local oppositeDir = PuzzlePiece.oppositeDirections[self.dir]
  local affectedPart = affectedPiece.combinationParts[oppositeDir]
  if not affectedPart then
    log:write("\t\tNot attack because no", oppositeDir,"facing part is in", affectedTile.col, affectedTile.row)
    return false
  end
  if not self:checkMatching(affectedPart) then
    log:write("\t\tNot attack because parts do not match")
    return false
  end
  return true
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
