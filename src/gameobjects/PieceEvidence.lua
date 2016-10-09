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
  init = function(self, tile, args)
    PuzzlePiece.init(self, tile, args or PieceEvidence.pick())

    -- piece image
    self.image = Resources.pieceEvidence
    self.imageScale = PuzzlePiece.cellSize / self.image:getWidth()
  end
})
PieceEvidence:include(PuzzlePiece)

--[[------------------------------------------------------------
Events
--]]--

function PieceSource:applyEffect()
  PuzzlePiece.applyEffect(self)
  ingame:spawnEvidencePieceFromSource(self)
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
end

function PieceEvidence:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceEvidence
