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

local database = require("assets/twerk/pieces")
local databaseByType = {}
for name, pieceTemplate in pairs(database) do
  local t = pieceTemplate.pieceType
  if not databaseByType[t] then
    databaseByType[t] = {}
  end
  table.insert(databaseByType[t], pieceTemplate)
end

local PuzzlePiece = Class({
  type = GameObject.newType("PuzzlePiece"),
  layer = 0,
  snapDelay = 0.2,
  database = database,
  databaseByType = databaseByType,

  directions = { "N", "E", "S", "W" },
  oppositeDirections = { N = "S", E = "W", S = "N", W = "E" },
  clockwiseDirections = { N = "E", E = "S", S = "W", W = "N" },
  counterClockwiseDirections = { N = "W", E = "N", S = "E", W = "S" },

  init = function(self, tile, args)
    GameObject.init(self, tile.x, tile.y)

    self.t = math.random()

    -- attach to tile
    self.tile = tile
    tile.piece = self

    -- set size
    self.size = { x = PuzzlePiece.cellSize, y = PuzzlePiece.cellSize }
    self.rotation = 0
    self.rotationTarget = 0

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

    -- set team
    self.team = args and args.team or "Neutral"

    -- set name
    self.name = args and args.name or "???"

    -- initialise connections
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
      if not args.connections then
        log:write("Missing 'connections' in template, randomising parts")
        _randomiseCombinationParts()
      else
        for dir, connection in pairs(args.connections) do
          local part = CombinationPart({
            direction = dir,
            piece = self,
            type = connection.type,
            convex = connection.convex
          })
          self.combinationParts[dir] = part
        end
      end

      -- tooltip
      if args.tooltip and Resources[args.tooltip] then
        self.imageTooltip = Resources[args.tooltip]
      end
    else
      _randomiseCombinationParts()
    end

    -- store connection count
    self.partCount = 0
    for dir, part in pairs(self.combinationParts) do
      if not part.isNull then
        self.partCount = self.partCount + 1
      end
    end

    -- colour
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

function PuzzlePiece:rotateDirection(map)
  local newCombinationParts = {}
  for direction, part in pairs(self.combinationParts) do
    local newDirection = map[direction]
    newCombinationParts[newDirection] = part
  end
  self.combinationParts = newCombinationParts
  self:checkForDeaths()
end

function PuzzlePiece:rotateClockwise()
  self:rotateDirection(self.clockwiseDirections)
end

function PuzzlePiece:rotateCounterClockwise()
  self:rotateDirection(self.counterClockwiseDirections)
end

function PuzzlePiece:grab()
  self.grabbed = true
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
  self.grabbed = false
  self.layer = nil
  for dir, part in pairs(self.combinationParts) do
    part:resetLayer()
  end

  if not tile or tile.piece or not self:canBeMovedToTile(tile) then
    -- this tile already has a piece in it, or the piece would not fit here - revert back to previous tile!
    tile = self.previousTile
  end

  -- update position
  self.tile = tile
  self.previousTile = nil
  tile.piece = self

  -- the piece or other pieces may be destroyed
  self:checkForDeaths()

  -- wiggle into position
  self.snapStartedAt = love.timer.getTime()
  self.wiggleStartedAt = love.timer.getTime()
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
  ingame.pouf:emit(self.tile)
  self.tile.piece = nil
  for direction, part in pairs(self.combinationParts) do
    part.purge = true
  end
end

function PuzzlePiece:applyEffect()
  ingame:combinationHasBeenMade(self)
end

--[[------------------------------------------------------------
Game loop
--]]--

function PuzzlePiece:draw()

  -- draw the piece
  if self.image then
    love.graphics.draw(
      self.image,
      self.x + PuzzlePiece.cellSize / 2,
      self.y + PuzzlePiece.cellSize / 2,
      self.rotation,
      self.imageScale * (1 + self.wiggle.x),
      self.imageScale * (1 + self.wiggle.y),
      PuzzlePiece.cellSize / 2,
      PuzzlePiece.cellSize / 2)
  else
    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.rectangle("fill", self.x - PuzzlePiece.cellSize * self.wiggle.x / 2, self.y - PuzzlePiece.cellSize * self.wiggle.y / 2, self.size.x, self.size.y)
    love.graphics.setColor(255,255,255)
  end

  -- debug stuff
  if DEBUG then
    love.graphics.setFont(fontMedium)
    useful.bindBlack()

    -- print the name
    love.graphics.print(self.name, self.x + self.size.x*0.35, self.y + self.size.y*0.3)
    love.graphics.print(self:typename(), self.x + self.size.x*0.35, self.y + self.size.y*0.5)

    -- show grid coordinates
    if self.tile then
      local c, r = self.tile.col, self.tile.row
      love.graphics.print(c .. ', ' .. r, self.x + self.size.x*0.35, self.y + self.size.y*0.1)
    end

    useful.bindWhite()
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

  -- rotation animation
  self.rotation = useful.lerp(self.rotation, self.rotationTarget, 0.5)

  -- drag combination parts behind us
  self:followCombinationParts()

  -- for great justice!
  if (self.tile and self.tile.piece ~= self) or (not self.tile and not self.grabbed) then
    self.purge = true
  end
end

function PuzzlePiece:drag(x, y)
  self.x = useful.lerp(self.x, x - PuzzlePiece.cellSize*0.5, 0.5)
  self.y = useful.lerp(self.y, y - PuzzlePiece.cellSize*0.5, 0.5)

  -- drag combination parts behind us
  self:followCombinationParts()
end

function PuzzlePiece:rotate(direction)
  local radian = 0

  if direction > 0 then
    radian = math.pi/2
    self:rotateClockwise()
  elseif direction < 0 then
    radian = -math.pi/2
    self:rotateCounterClockwise()
  end

  self.rotationTarget = self.rotationTarget + radian
  for dir, part in pairs(self.combinationParts) do
    part:rotate(direction)
  end

  self.wiggleStartedAt = love.timer.getTime()
end

function PuzzlePiece:setStretch(ratio)
  if math.abs(self.rotation) < 0.01 or math.abs(self.rotation - math.pi) < 0.01 then
    self.wiggle.x = -ratio * 0.5
  else
    self.wiggle.y = -ratio * 0.5
  end
  self:followCombinationParts()
end

function PuzzlePiece:canBeMovedToTile(newTile)
  if not newTile then
    return false
  end
  local permissive = false--newTile.grid == ingame.newspaperGrid
  if permissive then
    return true
  end
  local shouldTakeRound = 0
  for _, dir in ipairs(self.directions) do
    local part = self.combinationParts[dir]
    local otherTile = newTile[dir]
    if otherTile and otherTile.piece then
      local otherPart = otherTile.piece.combinationParts[self.oppositeDirections[dir]]
      if part and otherPart and not part:checkMatching(otherPart) then
        return false
      elseif part and not otherPart then
        return false
      elseif otherPart and not part then
        return false
      end
      if part and otherPart then
        shouldTakeRound = shouldTakeRound + (part:checkMatching(otherPart) and 1 or 0)
      end
    end
  end
  return true
end

--[[------------------------------------------------------------
Query
--]]--

function PuzzlePiece:checkForDeaths()
  self.tile.grid:map(function(t)
    if t.piece and t.piece:shouldDie() then
      t.piece.purge = true
      t.piece:applyEffect()
    end
  end)
  if self.purge then
    return
  end
end

function PuzzlePiece:shouldDie()
  local allEntriesFilled = true
  local anyEntries = false
  for dir, part in pairs(self.combinationParts) do
    if not part.convex then
      anyEntries = true
      local otherTile = self.tile[dir]
      if otherTile and otherTile.piece then
        local otherPart = otherTile.piece.combinationParts[self.oppositeDirections[dir]]
        if not otherPart or not part:checkMatching(otherPart) then
          allEntriesFilled = false
        end
      else
        allEntriesFilled = false
      end
    end
  end
  return anyEntries and allEntriesFilled
end

--[[------------------------------------------------------------
Export
--]]--

return PuzzlePiece
