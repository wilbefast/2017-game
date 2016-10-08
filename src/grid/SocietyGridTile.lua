local SocietyGridTile = Class({
  init = function(self, col, row, width, height, grid)
    self.col = col
    self.row = row
    self.width = width
    self.height = height
    self.grid = grid
  end
})

function SocietyGridTile:draw()
  if self.hovered then
    love.graphics.setLineWidth(4)
  end
  local x, y = self.grid.x + (self.col - 1)*self.width, self.grid.y + (self.row - 1)*self.height
  love.graphics.rectangle("line", x, y, self.width, self.height)
  love.graphics.setLineWidth(1)
end

return SocietyGridTile