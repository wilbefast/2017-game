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
    PuzzlePiece.init(self, tile, args and args)
  end
})
PieceSource:include(PuzzlePiece)

--[[------------------------------------------------------------
Generation
--]]--

function PieceSource.pick(numberToPick)
  numberToPick = numberToPick or 1

  -- prepare the weights of each part type
  local partWeights = {}
  for name, type in pairs(CombinationPart.types) do
    partWeights[name] = type.count.Enemy.concave
  end

  -- prepare the spawn pool
  local sourceTemplates = PuzzlePiece.databaseByType[PieceSource]
  local drawPool = {}
  for _, template in ipairs(sourceTemplates) do
    for i = 1, weight do
      table.insert(drawPool, template)
    end
  end

  useful.shuffle(drawPool)
  if numberToPick <= 1 then
    return drawPool[1]
  end

  -- chaque pièce a un poid relatif à ses connexions:
  -- un type de connexion gagne 1 de poid par connexion concave sur les pièces du camp système placé sur le plateau de jeu
  -- Un point supplémentaire est accordé pour les connexions non occupées des candidats
  -- Le poid des pièces à 2 connexions est ensuite divisé par 4
  -- weight = (Sum(SimilarConnectivityOfSystemPiece) + Sum(EmptySimilarConnectivityOfCandidatePiece)) / PieceDivider
  -- on fait ensuite un tirage aléatoire pondéré sans remise : si deux sources doivent apparaître, elles ne peuvent pas être identiques.


end

--[[------------------------------------------------------------
Events
--]]--

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
