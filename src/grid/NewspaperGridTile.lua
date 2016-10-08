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
  local x, y = self.grid.x + (self.col - 1)*self.width, self.grid.y + (self.row - 1)*self.height
  love.graphics.rectangle("line", x, y, self.width, self.height)
end

return NewspaperGridTile
