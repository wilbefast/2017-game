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

local Pouf = Class({
  type = GameObject.newType("Pouf"),
  layer = 100,
  init = function(self)
    GameObject.init(self, 0, 0)

    self.particles = love.graphics.newParticleSystem(Resources.poof, 1000)
    self.particles:setParticleLifetime(0.5, 1.5)
    self.particles:setEmissionRate(0)
    local range = 100
    self.particles:setLinearAcceleration(-range, -range, range, range)
    self.particles:setColors( 255, 255, 255, 255, 255, 255, 255, 0 )
    -- self.particles:setSpeed(0.5, 5)
    self.particles:setSpin(0.5, 5)
    self.particles:setSizeVariation(1)
    self.particles:setSizes(0.75, 1, 0)
    self.particles:setAreaSpread("uniform", PuzzlePiece.cellSize / 2, PuzzlePiece.cellSize / 2)
    -- self.particles:setEmitterLifetime(1)
  end
})
Pouf:include(GameObject)

--[[------------------------------------------------------------
Events
--]]--

function Pouf:emit(tile)
  self.particles:setPosition(tile.x + PuzzlePiece.cellSize / 2, tile.y + PuzzlePiece.cellSize / 2)
  self.particles:emit(10)
end

--[[------------------------------------------------------------
Game loop
--]]--

function Pouf:draw()
  love.graphics.draw(self.particles)
end

function Pouf:update(dt)
  self.particles:update(dt)
end

--[[------------------------------------------------------------
Export
--]]--

return Pouf
