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

local Tooltip = Class({
  type = GameObject.newType("Tooltip"),
  layer = 3,
  init = function(self)
    GameObject.init(self, 0, 0)
    self.image = nil
    self.shouldAppear = false
    self.apparition = 0
    self.apparitionDelay = 1
    self.disappeared = true
    self.apparitionDirection = -1
  end
})
Tooltip:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function Tooltip:show(x, y, image)
  self.image = image
  self.shouldAppear = true
  if x + self.image:getWidth() > WORLD_W then
    self.x = x - PuzzlePiece.cellSize - self.image:getWidth()
  else
    self.x = x
  end
  if y + self.image:getHeight() > WORLD_H then
    self.y = y - PuzzlePiece.cellSize - self.image:getHeight()
  else
    self.y = y
  end
  self.y = useful.clamp(self.y, 0, WORLD_H - self.image:getHeight())
end

function Tooltip:hide()
  self.shouldAppear = false
end

function Tooltip:draw()
  if self.image then
    love.graphics.setColor(255, 255, 255, self.apparition * 255)
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setColor(255, 255, 255, 255)
  end
end

function Tooltip:update(dt)
  if self.shouldAppear then
    self.apparition = useful.clamp(self.apparition + dt / self.apparitionDelay, 0, 1)
  else
    self.apparition = useful.clamp(self.apparition - dt / self.apparitionDelay, 0, 1)
  end
  self.disappeared = self.apparition == 0
end

--[[------------------------------------------------------------
Export
--]]--

return Tooltip
