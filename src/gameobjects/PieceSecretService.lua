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

local PieceSecretService = Class({
  type = GameObject.newType("PieceSecretService"),
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
PieceSecretService:include(PuzzlePiece)

function PieceSecretService.pick()
  return useful.randIn(PuzzlePiece.databaseByType.PieceSecretService)
end

--[[------------------------------------------------------------
Query
--]]--

function PieceSecretService:shouldDie()
  if PuzzlePiece.shouldDie(self) then
    return true
  end
  -- also die if not attacking
  --return not self:isAnyPartAttacking()
end

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function PieceSecretService:draw()
  PuzzlePiece.draw(self)
end

function PieceSecretService:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceSecretService
