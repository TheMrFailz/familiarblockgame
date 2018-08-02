 
include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
function ENT:Draw()
    self.BaseClass.Draw(self)  -- We want to override rendering, so don't call baseclass.
   
    self:SetMaterial("models/props_c17/metalladder001")
    
    
    
    self:SetColor(Color(150,153,137,255))
    self:DrawModel()       -- Draw the model.
 
    --AddWorldTip( self:EntIndex(), "BATHTUB TIME!", 0.5, self:GetPos(), self  ) -- Add an example tip.
end