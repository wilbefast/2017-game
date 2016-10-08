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
  init = function(self, tile, args)
    PuzzlePiece.init(self, tile, args and args)
  end
})
PieceAdversary:include(PuzzlePiece)

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
