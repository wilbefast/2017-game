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
  layer = 0,
  snapDelay = 0.2,
  database = require("assets/twerk/pieces"),

  directions = { "N", "E", "S", "W" },
  oppositeDirections = { N = "S", E = "W", S = "N", W = "E" },

  init = function(self, tile, args)
    GameObject.init(self, tile.x, tile.y)

    self.t = math.random()
    self.tile = tile
    tile.piece = self

    self.size = { x = PuzzlePiece.cellSize, y = PuzzlePiece.cellSize }

    -- wiggle animation
    self.wiggleStartedAt = love.timer.getTime()
    self.wiggleDelay = 0.3
    self.wiggleScale = 0.2
    self.wiggleCount = 3
    self.wiggle = { x = 0, y = 0 }

    -- snap animation
    self.snapStartedAt = love.timer.getTime()

    -- combination parts
    self.combinationParts = {}

    local _randomiseCombinationParts = function()
      for i, dir in ipairs(self.directions) do
        local part = CombinationPart({
          direction = dir,
          piece = self
        })
        self.combinationParts[dir] = part
      end
    end

    if args then
      if not args.name then
        log:write("Missing name argument, randomising parts")
        _randomiseCombinationParts()
      else
        local name = useful.randIn(args.name)
        local template = self.database[name]
        if not template then
          log:write("Piece not found in database", name)
        else
          log:write("Spawning piece", template.name)
          self.name = template.name
          for dir, args in pairs(template.connections) do
            local part = CombinationPart({
              direction = dir,
              piece = self,
              type = args.type,
              convex = args.convex
            })
            self.combinationParts[dir] = part
          end
        end
      end
    else
      _randomiseCombinationParts()
    end

    self.color = {
      r = math.ceil(math.random() * 255),
      g = math.ceil(math.random() * 255),
      b = math.ceil(math.random() * 255)
    }
  end
})
PuzzlePiece:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

function PuzzlePiece:grab()
  self.wiggleStartedAt = love.timer.getTime()
  self.previousTile = self.tile
  self.tile.piece = nil
  self.tile = nil

  self.layer = 100
  for dir, part in pairs(self.combinationParts) do
    part.layer = 101
  end
end


function PuzzlePiece:drop(tile)
  self.layer = nil
  for dir, part in pairs(self.combinationParts) do
    part.layer = nil
  end

  if not tile or tile.piece or not self:canBeMovedToTile(tile) then
    -- this tile already has a piece in it, or the piece would not fit here - revert back to previous tile!
    tile = self.previousTile
  end

  self.snapStartedAt = love.timer.getTime()
  self.wiggleStartedAt = love.timer.getTime()

  self.tile = tile
  self.previousTile = nil
  tile.piece = self

  local x, y = tile.x, tile.y
  babysitter.activeWaitThen(1, function(t)
    if not self.tile then
      return true -- interrupt
    end
    self.x = useful.lerp(self.x, x, t)
    self.y = useful.lerp(self.y, y, t)
  end)
end

function PuzzlePiece:onPurge()
end

--[[------------------------------------------------------------
Game loop
--]]--

function PuzzlePiece:draw()

  -- draw the piece
  love.graphics.setColor(self.color.r, self.color.g, self.color.b)
  love.graphics.rectangle("fill", self.x - PuzzlePiece.cellSize * self.wiggle.x / 2, self.y - PuzzlePiece.cellSize * self.wiggle.y / 2, self.size.x, self.size.y)
  love.graphics.setColor(255,255,255)

  -- show grid coordinates
  if self.tile then
    local c, r = self.tile.col, self.tile.row
    love.graphics.setFont(fontMedium)
    love.graphics.print(c .. ', ' .. r, self.x + self.size.x*0.35, self.y + self.size.y*0.35)
  end
end

function PuzzlePiece:followCombinationParts()
  -- combination parts
  for dir, part in pairs(self.combinationParts) do
    part:follow(self.x, self.y)
    part:doTheWiggle(self.wiggle.x, self.wiggle.y)
  end
end

function PuzzlePiece:update(dt)
  -- timing
  self.t = self.t + dt
  if self.t > 1 then
    self.t = self.t - 1
  end

  -- wiggle animation
  local wiggleRatio = 1 - useful.clamp((love.timer.getTime() - self.wiggleStartedAt) / self.wiggleDelay, 0, 1)
  local t = self.t * self.wiggleCount * math.pi * 2
  self.wiggle.x = self.wiggleScale * math.cos(t) * wiggleRatio
  self.wiggle.y = self.wiggleScale * math.cos(t + math.pi) * wiggleRatio
  self.size.x = PuzzlePiece.cellSize * (1 + self.wiggle.x)
  self.size.y = PuzzlePiece.cellSize * (1 + self.wiggle.y)

  -- snap animation
  if self.tile then
    local snapRatio = 1 - useful.clamp((love.timer.getTime() - self.snapStartedAt) / self.snapDelay, 0, 1)
    self.x = useful.lerp(self.x, self.tile.x, 0.5 * snapRatio)
    self.y = useful.lerp(self.y, self.tile.y, 0.5 * snapRatio)
  end

  self:followCombinationParts()
end

function PuzzlePiece:drag(x, y)
  self.x = useful.lerp(self.x, x - PuzzlePiece.cellSize*0.5, 0.5)
  self.y = useful.lerp(self.y, y - PuzzlePiece.cellSize*0.5, 0.5)

  self:followCombinationParts()
end

function PuzzlePiece:canBeMovedToTile(newTile)
  if not newTile then
    return false
  end
  for dir, part in pairs(self.combinationParts) do
    if part then
      local otherTile = newTile[dir]
      if otherTile and otherTile.piece then
        local otherPart = otherTile.piece.combinationParts[self.oppositeDirections[dir]]
        if otherPart then
          return part:checkMatching(otherPart)
        end
      end
    end
  end
  return true
end

--[[------------------------------------------------------------
Export
--]]--

return PuzzlePiece
