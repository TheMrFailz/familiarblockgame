AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
ENT.BouncesTillDeath = 4
ENT.Bounces = 0
local Color2
function ENT:Initialize()
 
	self:SetModel( "models/hunter/misc/sphere025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    
 
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    Color2 = self:GetColor()
end



function ENT:PhysicsCollide( touchdata, toucherobj )

    
    
    if touchdata.HitEntity != nil then
        
        if touchdata.HitEntity:GetClass() != "fbg_spawnpoint_dest" then
        touchdata.HitEntity:SetColor(Color(math.random(50,255), math.random(50,255), math.random(50,255), 255))
        end
    if touchdata.HitEntity:IsPlayer() then
        local damageInfo = DamageInfo()
            damageInfo:SetDamage(25)
            
            damageInfo:SetDamageType(DMG_GENERIC)
            touchdata.HitEntity:TakeDamageInfo(damageInfo)
        
    end
    
    end
    
    self:Remove()
    --
end

