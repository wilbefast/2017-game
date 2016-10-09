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

local PieceAlly = Class({
  type = GameObject.newType("PieceAlly"),
  partColour = {
    r = 0,
    g = 171,
    b = 157,
  },
  init = function(self, tile, args)
    local args = args or PieceAlly.pick()
    args.image = Resources.pieceAlly
    PuzzlePiece.init(self, tile, args)

  end
})
PieceAlly:include(PuzzlePiece)

--[[------------------------------------------------------------
Game loop
--]]--

function PieceAlly.pick()
  return useful.randIn(PuzzlePiece.databaseByType.PieceAlly)
end


function PieceAlly:draw()
  PuzzlePiece.draw(self)
end

function PieceAlly:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceAlly
