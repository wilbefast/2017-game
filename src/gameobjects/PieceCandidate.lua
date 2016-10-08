--[[
(C) Copyright 2016 William Dyce

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

local PieceNewspaper = Class({
  type = GameObject.newType("PieceCandidate"),
  layer = 0,
  snapDelay = 0.2,
  init = function(self, tile)
    PuzzlePiece.init(self, tile)

    -- css style (top, right, bottom, left)
    self.combinationParts.N:setType(1)
    self.combinationParts.E:setType(5)
    self.combinationParts.S:setType(2)
    self.combinationParts.W:setType(5)

    self.combinationParts.N.convex = false
    self.combinationParts.E.convex = false
  end
})
PieceNewspaper:include(PuzzlePiece)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function PieceNewspaper:draw()
  PuzzlePiece.draw(self)
end

function PieceNewspaper:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceNewspaper
