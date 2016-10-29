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

local PieceAdversary = Class({
  type = GameObject.newType("PieceAdversary"),
  partColour = {
    r = 218,
    g = 0,
    b = 35,
  },
  init = function(self, tile, args)
    local args = args or PieceAdversary.pick()
    args.image = Resources.pieceEnemy
    PuzzlePiece.init(self, tile, args)
    if not self:rotateTillAttacking() then
      self.purge = true
    end
  end
})
PieceAdversary:include(PuzzlePiece)

function PieceAdversary.pick()
  return useful.randIn(PuzzlePiece.databaseByType.PieceAdversary)
end

--[[------------------------------------------------------------
Query
--]]--

function PieceAdversary:shouldDie()
  if PuzzlePiece.shouldDie(self) then
    return true
  end
  -- also die if not attacking
  return not self:isAnyPartAttacking()
end

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function PieceAdversary:draw()
  PuzzlePiece.draw(self)
end

function PieceAdversary:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceAdversary
