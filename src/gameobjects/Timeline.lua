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

local Timeline = Class({
  type = GameObject.newType("Timeline"),
  layer = 3,
  init = function(self)
    GameObject.init(self, 0, 0)

    self.ratioCurrentCursor = 0

    self.roundCount = 100
    self.roundStep = 5
    self.step = self.roundCount / self.roundStep

    self.margin = 8
    self.height = 32
    self.cursorWidth = 16
    self.cursorHeight = 16
  end
})
Timeline:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function Timeline:draw()

  local barBottom = WORLD_H - self.margin
  local barTop = barBottom - self.height

  -- bar
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle("fill", self.margin, barBottom - self.height / 2, WORLD_W - self.margin * 2, self.height / 2)

  -- lines
  -- for x = 0, self.step do
  --   love.graphics.line(self.margin + x * self.step * self.roundStep, barBottom, self.margin + x * self.step * self.roundStep, barTop)
  -- end

  -- current cursor
  local currentX = (WORLD_W - self.margin * 2) * self.ratioCurrentCursor
  love.graphics.setColor(255, 0, 0)
  love.graphics.polygon("fill", currentX - self.cursorWidth, barTop - self.cursorHeight, currentX, barTop, currentX + self.cursorWidth, barTop - self.cursorHeight)
  love.graphics.setLineWidth(2)
  love.graphics.line(currentX, barBottom, currentX, barTop - self.cursorHeight)

  love.graphics.setColor(255, 255, 255)
end

function Timeline:update(dt)
  self.ratioCurrentCursor = useful.round((math.sin(love.timer.getTime() * 0.2) * 0.5 + 0.5) * self.roundCount) / self.roundCount
end

--[[------------------------------------------------------------
Export
--]]--

return Timeline
