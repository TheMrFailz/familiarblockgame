AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/hunter/blocks/cube025x1x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    
 
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
    self:EmitSound("weapon_effects/rocket_fire.wav")
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    
end


local function SelfExplode(self) 
    
    local explosion = ents.Create( "env_explosion" )
    explosion:SetPos(self:GetPos())
    explosion:SetOwner(self)
    explosion:SetKeyValue("spawnflags", 64)
    explosion:Spawn()
    explosion:SetKeyValue("iMagnitude", "100")
    explosion:Fire( "Explode", 0, 0)
    
    explosion:EmitSound("weapon_effects/rocket_explode.wav", 400, 100)
    

end 

function ENT:PhysicsCollide( touchdata, toucherobj )
    timer.Simple(0, function()
    SelfExplode(self)
    self:Remove()
    end)
end

