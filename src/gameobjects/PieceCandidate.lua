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
  partColour = {
    r = 255,
    g = 100,
    b = 90,
  },
  init = function(self, tile, args)
    local args = args or PieceCandidate.pick()
    args.image = Resources.pieceCandidate
    PuzzlePiece.init(self, tile, args)

    -- tooltip
    if args and args.tooltip and Resources[args.tooltip .. "_f"] then
      self.imageTooltip = Resources[args.tooltip .. (math.random() > 0.5 and "_f" or "_h")]
    elseif self.tooltipName and Resources[self.tooltipName .. "_f"] then
      self.imageTooltip = Resources[self.tooltipName .. (math.random() > 0.5 and "_f" or "_h")]
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

function PieceCandidate.pick()
  if #ingame.timeline.candidateList > 0 then
    local picked = ingame.timeline.candidateList[1]
    table.remove(ingame.timeline.candidateList, 1)
    return picked
  else
    return {}
  end
end

--[[------------------------------------------------------------
Export
--]]--

return PieceCandidate
