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

local Timeline = Class({
  type = GameObject.newType("Timeline"),
  layer = 0,
  init = function(self)
    GameObject.init(self, 0, 0)

    self.roundTotal = 100
    self.currentRound = 0

    self.roundCandidate = 0
    self.roundStepCandidate = 15
    self.candidateTiles = {
      ingame.societyGrid:gridToTile(2, 2),
      ingame.societyGrid:gridToTile(8, 2),
      ingame.societyGrid:gridToTile(5, 3),
      ingame.societyGrid:gridToTile(3, 4),
      ingame.societyGrid:gridToTile(7, 4)
    }
    self.currentCandidate = 0
    local database = require("assets/twerk/pieces")
    self.candidateList = {
      database.Reac,
      database.Socialo,
      database.Gaucho,
      database.Centre,
      database.Ailleur
    }
    useful.shuffle(self.candidateList)

    -- normalized position
    self.ratioCurrentRound = 0
    self.ratioCurrentTarget = 0

    -- image
    self.timelineCursor = Resources.timelineCursor

    -- layout
    self.margin = 8
    self.height = 32
    self.cursorWidth = 16
    self.cursorHeight = 16
    self.timelineLeft = 716
    self.timelineRight = 1860
    self.timelineWidth = self.timelineRight - self.timelineLeft
    self.timelineTop = WORLD_H - 155
    self.timelineBottom = self.timelineTop + self.timelineCursor:getHeight()

    -- animation
    self.animStart = -1000
    self.animDelay = 1
    self.animScale = 0.5

    -- sorry
    self.actionStart = -1000
    self.actionDelay = 0.5
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
  if self.actionStart + self.actionDelay < love.timer.getTime() then
    local pieceType = piece:typename()
    if pieceType == "PieceEvidence" or pieceType == "PieceJournalist" or pieceType == "PieceSource" then
      self.currentRound = self.currentRound + 1

      if self.currentRound > self.roundTotal then
        GameState.switch(gameover)
      else
        self.ratioCurrentTarget = self.currentRound / self.roundTotal
        self.animStart = love.timer.getTime()
        self.actionStart = love.timer.getTime()
      end

      self.roundCandidate = self.roundCandidate + 1
      if self.roundCandidate >= self.roundStepCandidate then
        self.roundCandidate = 0

        local emptyTiles = {}
        for key, tile in ipairs(self.candidateTiles) do
          if not tile.piece then
            table.insert(emptyTiles, tile)
          end
        end
        ingame:trySpawn(PieceCandidate, emptyTiles, 1)
      end
    end
  end
end

function Timeline:draw()
  -- current cursor
  local currentX = self.timelineLeft + self.timelineWidth*self.ratioCurrentRound
  local scale = 1 + self.animScale * math.sin(math.pi * useful.clamp((love.timer.getTime() - self.animStart) / self.animDelay, 0, 1))
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(
    self.timelineCursor,
    currentX - self.timelineCursor:getWidth() * scale / 2,
    self.timelineBottom - scale * self.timelineCursor:getHeight(),
    0,
    scale)
end

function Timeline:update(dt)
  self.ratioCurrentRound = useful.lerp(self.ratioCurrentRound, self.ratioCurrentTarget, 0.5)
end

--[[------------------------------------------------------------
Export
--]]--

return Timeline
