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
  init = function(self, tile, args)
    local args = args or PieceEvidence.pick()
    args.image = Resources.pieceEvidence
    PuzzlePiece.init(self, tile, args)

    self.credibility = 1
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

--[[------------------------------------------------------------
Query
--]]--

function PieceEvidence:canBeMovedToTile(tile)
  if not PuzzlePiece.canBeMovedToTile(self, tile) then
    return false
  end
  if tile.grid.isSociety then
    return self:isAttack(tile, "PieceCandidate")
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
