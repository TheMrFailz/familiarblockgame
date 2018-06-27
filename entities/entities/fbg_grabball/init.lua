AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/maxofs2d/hover_classic.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	--self:SetSolid( SOLID_NONE )         -- Toolbox
    
 
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    
end

function ENT:PhysicsCollide( touchdata, toucherobj )
    
    
    
end

