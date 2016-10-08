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

local Tooltip = Class({
  type = GameObject.newType("Tooltip"),
  layer = 3,
  init = function(self)
    GameObject.init(self)
    self.image = nil
    self.shouldAppear = false
    self.apparition = 0
    self.apparitionDelay = 0
  end
})
Tooltip:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function Tooltip:show(image)
  self.image = image
  self.shouldAppear = true
end

function Tooltip:hide()
  self.shouldAppear = false
end

function Tooltip:draw()
    -- love.graphics.draw(self.image, self.x + PuzzlePiece.cellSize*0.5, self.y + PuzzlePiece.cellSize*0.5, self.rotation, self.scale.x, self.scale.y, self.image:getWidth() / 2, self.image:getHeight() / 2)
end

function Tooltip:update(dt)
  self.apparition = useful.clamp(self.apparition + dt / self.apparitionDelay, 0, 1)
end

--[[------------------------------------------------------------
Export
--]]--

return Tooltip
