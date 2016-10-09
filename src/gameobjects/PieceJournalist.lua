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

local PieceJournalist = Class({
  type = GameObject.newType("PieceJournalist"),
  partColour = {
    r = 47,
    g = 25,
    b = 100,
  },
  init = function(self, tile, args)
    PuzzlePiece.init(self, tile, args and args)

    -- piece image
    self.image = Resources.pieceJournalist
    self.imageScale = PuzzlePiece.cellSize / self.image:getWidth()
  end
})
PieceJournalist:include(PuzzlePiece)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function PieceJournalist:draw()
  PuzzlePiece.draw(self)
end

function PieceJournalist:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceJournalist
