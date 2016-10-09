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

return NewspaperGridTile
