 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
local spawnPointMat = Material( "bricks/spawnpoint.png" )
local spawnPointSize = 96
function ENT:Draw()
    self.BaseClass.Draw(self)  -- We want to override rendering, so don't call baseclass.
                                  -- Use this when you need to add to the rendering.
    --self:DrawEntityOutline( 1.0 ) -- Draw an outline of 1 world unit.
    
    
    local stretchtext = Material("models/bricktextures/stud_white.vtf", "noclamp")
    local stretchtext2 = stretchtext:GetName()
    
    self:SetMaterial(stretchtext2)
    
    
    --self:SetColor(Color(255,255,255,255))
    self:DrawModel()       -- Draw the model.
 
    --AddWorldTip( self:EntIndex(), "BATHTUB TIME!", 0.5, self:GetPos(), self  ) -- Add an example tip.
    
    cam.Start3D2D(self:GetPos() + Vector(0,0,6), self:GetAngles(), 1)
        surface.SetDrawColor(255,255,255,255)
        surface.SetMaterial(spawnPointMat)
        surface.DrawTexturedRect(-48,-48,spawnPointSize,spawnPointSize)
        
    
    cam.End3D2D()
    
end

