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


local PieceSource = Class({
  type = GameObject.newType("PieceSource"),
  init = function(self, tile, args)
    PuzzlePiece.init(self, tile, args or PieceSource.pick())

    -- piece image
    self.image = Resources.pieceSource
    self.imageScale = PuzzlePiece.cellSize / self.image:getWidth()
  end
})
PieceSource:include(PuzzlePiece)

--[[------------------------------------------------------------
Generation
--]]--

function PieceSource.pick()
  -- prepare the weights of each part type
  local partWeights = {}
  for name, type in pairs(CombinationPart.types) do
    -- TODO
    -- ideally check that the part is also not already filled
    partWeights[name] = type.count.Enemy.concave + type.count.Candidate.concave
  end

  -- prepare the spawn pool
  local sourceTemplates = PuzzlePiece.databaseByType.PieceSource
  local drawPool = {}
  for _, template in ipairs(sourceTemplates) do
    local weight = 0
    local connectionCount = 0
    for dir, connection in pairs(template.connections) do
      weight = weight + partWeights[connection.type]
      connectionCount = connectionCount + 1
    end
    weight = 4*weight/connectionCount/connectionCount/connectionCount
    -- TODO unique draws
    for i = 1, math.ceil(weight) do
      table.insert(drawPool, template)
    end
  end

  -- shuffle and draw
  useful.shuffle(drawPool)
  return drawPool[1]
end

--[[------------------------------------------------------------
Game loop
--]]--

function PieceSource:draw()
  PuzzlePiece.draw(self)
end

function PieceSource:update(dt)
  PuzzlePiece.update(self, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return PieceSource
