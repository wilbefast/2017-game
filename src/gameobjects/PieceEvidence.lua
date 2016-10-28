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

local PieceEvidence = Class({
  type = GameObject.newType("PieceEvidence"),
  partColour = {
    r = 246,
    g = 206,
    b = 43,
  },
  maxCredibility = 3,
  init = function(self, tile, args)
    local args = args or PieceEvidence.pick()
    args.image = Resources.pieceEvidence
    PuzzlePiece.init(self, tile, args)

    self.credibility = 0
  end
})
PieceEvidence:include(PuzzlePiece)

--[[------------------------------------------------------------
Events
--]]--

function PieceEvidence:applyEffect()
  PuzzlePiece.applyEffect(self)
  ingame:spawnEvidencePieceFromEvidence(self)
end

function PieceEvidence:onSuccessfulDrop(targetTile)
  if targetTile.grid.isSociety then
    ingame:tick()

    local probAdversary = 1 - self.credibility/self.maxCredibility
    probAdversary = 0.9*probAdversary*probAdversary

    local probAlly = self.credibility/self.maxCredibility
    probAlly = 0.9*probAlly*probAlly

    local probNothing = 1 - probAdversary - probAlly

    log:write("Random draw must be above", probAdversary, "for ally or", probAdversary + probAlly, "for nothing")
    local draw = math.random()
    log:write("Random draw was", draw)

    if draw <= probAdversary then
      -- attack on our evidence
      ingame:spawnAdversaryPieceFromEvidence(self, targetTile)
    elseif draw <= probAdversary + probAlly then
      -- defense of our evidence
      ingame:spawnAllyPieceFromEvidence(self, targetTile)
    else
      -- nothing
    end
  end
end

function PieceEvidence:attackFromSystem(position)
  local probAdversary = 1 - self.credibility/self.maxCredibility
  probAdversary = 0.9*probAdversary*probAdversary

  local probAlly = self.credibility/self.maxCredibility
  probAlly = 0.9*probAlly*probAlly

  local probNothing = 1 - probAdversary - probAlly

  log:write("Random draw must be above", probAdversary, "for ally or", probAdversary + probAlly, "for nothing")
  local draw = math.random()
  log:write("Random draw was", draw)

  if draw <= probAdversary then
    -- attack on our evidence
    ingame:spawnAdversaryPieceFromEvidence(self, position)
  elseif draw <= probAdversary + probAlly then
    -- defense of our evidence
    ingame:spawnAllyPieceFromEvidence(self, position)
  else
    -- nothing
  end
end

function PieceEvidence:onFailedDrop(targetTile)
end

--[[------------------------------------------------------------
Query
--]]--

function PieceEvidence:canBeMovedToTile(tile)
  if not PuzzlePiece.canBeMovedToTile(self, tile) then
    return false
  end
  if tile.grid.isSociety then
    return (self:isAttack(tile, "PieceCandidate", "PieceSecretService", "PieceAdversary"))
  else
    return true
  end
end

--[[------------------------------------------------------------
Generation
--]]--

function PieceEvidence.pick()
  return useful.randIn(PuzzlePiece.databaseByType.PieceEvidence)
end


--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function PieceEvidence:draw()
  PuzzlePiece.draw(self)
  if DEBUG then
    useful.bindBlack()
    love.graphics.print("CRED = " .. tostring(self.credibility), self.x + 8, self.y + 80)
    useful.bindWhite()
  end
end

function PieceEvidence:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceEvidence
