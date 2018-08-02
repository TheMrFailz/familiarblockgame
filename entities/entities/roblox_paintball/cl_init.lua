 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]

ENT.randomColor_r = 0
ENT.randomColor_g = 0
ENT.randomColor_b = 0

function ENT:Initialize()
    self.Entity.randomColor_r = math.random(50,255)
    self.Entity.randomColor_g = math.random(50,255)
    self.Entity.randomColor_b = math.random(50,255)
end

function ENT:Draw()
    self.BaseClass.Draw(self)  -- We want to override rendering, so don't call baseclass.
   
    self:SetMaterial("models/debug/debugwhite")
    
    
    
    self:SetColor(Color(self.Entity.randomColor_r,self.Entity.randomColor_b,self.Entity.randomColor_g,255))
    self:DrawModel()       -- Draw the model.
 
    --AddWorldTip( self:EntIndex(), "BATHTUB TIME!", 0.5, self:GetPos(), self  ) -- Add an example tip.
end