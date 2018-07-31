 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
local spawnPointMat = Material( "bricks/spawnpoint.png" )
local spawnPointSize = 96
function ENT:Draw()
    self.BaseClass.Draw(self) 
    
    local stretchtext = Material("models/bricktextures/stud_white.vtf", "noclamp")
    local stretchtext2 = stretchtext:GetName()
    
    self:SetMaterial(stretchtext2)
    
    self:DrawModel()
 
    cam.Start3D2D(self:GetPos() + Vector(0,0,6), self:GetAngles(), 1)
        surface.SetDrawColor(255,255,255,255)
        surface.SetMaterial(spawnPointMat)
        surface.DrawTexturedRect(-48,-48,spawnPointSize,spawnPointSize)
        
    
    cam.End3D2D()
    
end

