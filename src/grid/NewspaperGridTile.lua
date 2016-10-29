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

local NewspaperGridTile = Class({
  init = function(self, col, row, width, height, grid)
    self.col = col
    self.row = row
    self.width = width
    self.height = height
    self.grid = grid
  end
})

function NewspaperGridTile:draw()
  if self.hovered then
    love.graphics.setLineWidth(4)
    local x, y = self.grid.x + (self.col - 1)*self.width, self.grid.y + (self.row - 1)*self.height
    love.graphics.rectangle("line", x, y, self.width, self.height)
    love.graphics.setLineWidth(1)
  end
  if DEBUG then
    if self.piece then
      local x, y = self.grid.x + (self.col - 1)*self.width, self.grid.y + (self.row - 1)*self.height
      love.graphics.rectangle("fill", x, y, self.width, self.height)
    end
  end
end

function NewspaperGridTile:update(dt)
  -- clean
  if self.piece and (self.piece.purge or not self.piece.tile) then
    self.piece.purge = true
    self.piece = nil
  end
end

return NewspaperGridTile
