--[[
(C) Copyright 2014 William Dyce

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

local PuzzlePiece = Class({
  type = GameObject.newType("PuzzlePiece"),
  init = function(self, x, y)
    GameObject.init(self, x, y)
    self.radius = 32
    self.t = math.random()
  end
})
PuzzlePiece:include(GameObject)

--[[------------------------------------------------------------
Game loop
--]]--

function PuzzlePiece:onPurge()
end

function PuzzlePiece:draw()
  if DEBUG then
    local s = 128*(1 + 0.2*math.cos(self.t*math.pi*2))
    love.graphics.rectangle("line", self.x - 0.5*s, self.y - 0.5*s, s, s)
  end
end

function PuzzlePiece:update(dt)
  self.t = self.t + dt
  if self.t > 1 then
    self.t = self.t - 1
  end
end

--[[------------------------------------------------------------
Export
--]]--

return PuzzlePiece
