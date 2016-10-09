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
  layer = 0,
  init = function(self)
    GameObject.init(self, 0, 0)

    self.roundTotal = 100
    self.roundStep = 5
    self.currentRound = 0

    -- normalized position
    self.ratioCurrentRound = 0

    -- image
    self.image = Resources.timeline
    self.image:setWrap("repeat")

    -- layout
    self.margin = 8
    self.height = 32
    self.cursorWidth = 16
    self.cursorHeight = 16
    self.timelineLeft = 712
    self.timelineRight = 1860
    self.timelineWidth = self.timelineRight - self.timelineLeft
    self.timelineTop = WORLD_H - 100
    self.timelineBottom = self.timelineTop + self.image:getHeight()

    -- tmp
    self.background = love.graphics.newQuad(0, 0, self.timelineWidth, self.height, self.image:getWidth(), self.image:getHeight())
  end
})
Timeline:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

--[[------------------------------------------------------------
Game loop
--]]--

function Timeline:combinationHasBeenMade(piece)
  log:write(piece:typename())
  local pieceType = piece:typename()
  if pieceType == "PieceEvidence" or pieceType == "PieceJournalist" or pieceType == "PieceSource" then
    self.currentRound = self.currentRound + 1
    self.ratioCurrentRound = self.currentRound / self.roundTotal
  end
end

function Timeline:draw()

  -- bar
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.image, self.background, self.timelineLeft, self.timelineTop)

  -- current cursor
  love.graphics.setColor(255, 0, 0)
  love.graphics.setLineWidth(2)
  local currentX = self.timelineLeft + self.timelineWidth*self.ratioCurrentRound
  love.graphics.polygon("fill", currentX - self.cursorWidth, self.timelineTop - self.cursorHeight, currentX, self.timelineTop, currentX + self.cursorWidth, self.timelineTop - self.cursorHeight)
  love.graphics.line(currentX, self.timelineBottom, currentX, self.timelineTop)

  love.graphics.setColor(255, 255, 255)
end

function Timeline:update(dt)
end

--[[------------------------------------------------------------
Export
--]]--

return Timeline
