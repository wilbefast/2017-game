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

local PieceCandidate = Class({
  type = GameObject.newType("PieceCandidate"),
  init = function(self, tile, args)
    PuzzlePiece.init(self, tile, args and args)

    -- piece image
    self.image = Resources.pieceCandidate
    self.imageScale = PuzzlePiece.cellSize / self.image:getWidth()

    -- tooltip
    if args.tooltip and Resources[args.tooltip .. "_f"] then
      self.imageTooltip = Resources[args.tooltip .. (math.random() > 0.5 and "_f" or "_h")]
    end
  end
})
PieceCandidate:include(PuzzlePiece)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function PieceCandidate:draw()
  PuzzlePiece.draw(self)
end

function PieceCandidate:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceCandidate
