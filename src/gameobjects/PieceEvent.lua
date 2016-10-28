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

local PieceEvent = Class({
  type = GameObject.newType("PieceEvent"),
  partColour = {
    r = 0,
    g = 171,
    b = 157,
  },
  init = function(self, tile, args)
    local args = args or PieceEvent.pick()
    args.image = Resources.pieceEnemy
    PuzzlePiece.init(self, tile, args)
    if not self:rotateTillAttacking() then
      self.purge = true
    end
  end
})
PieceEvent:include(PuzzlePiece)

--[[------------------------------------------------------------
Game loop
--]]--

function PieceEvent.pick()
  return useful.randIn(PuzzlePiece.databaseByType.PieceEvent)
end


function PieceEvent:draw()
  PuzzlePiece.draw(self)
end

  function PieceEvent:shouldDie()
  if self.lifetime <= 0 then
    return true
  end
end

function PieceEvent:updateLifetime()
  self.lifetime= self.lifetime - 1
  log:write("\t lifetime decreased:", self.lifetime)
  if (self:shouldDie()) then
    self.purge = true
    self = nil
  end
end

function PieceEvent:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceEvent
