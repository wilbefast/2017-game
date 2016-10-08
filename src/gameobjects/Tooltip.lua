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

function Tooltip:show(x, y, image)
  self.image = image
  self.shouldAppear = true
  if x < WORLD_W / 2 then
    self.x = WORLD_W * 3 / 4 - self.image:getWidth()
  else
    self.x = WORLD_W * 1 / 4 - self.image:getWidth()
  end
  if y < WORLD_H / 2 then
    self.y = WORLD_H
  else
    self.y = - self.image:getHeight()
  end
end

function Tooltip:hide()
  self.shouldAppear = false
end

function Tooltip:draw()
  if self.image then
    love.graphics.draw(self.image, self.x, self.y + self.apparition * self.image:getHeight())
  end
end

function Tooltip:update(dt)
  self.apparition = useful.clamp(self.apparition + dt / self.apparitionDelay, 0, 1)
end

--[[------------------------------------------------------------
Export
--]]--

return Tooltip
