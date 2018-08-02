AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
ENT.BouncesTillDeath = 4
ENT.Bounces = 0
 
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
    
end



function ENT:PhysicsCollide( touchdata, toucherobj )
    
    if toucherobj.HitEntity != nil then
    if toucherobj.HitEntity:IsPlayer() then
        local damageInfo = DamageInfo()
            damageInfo:SetDamage(10)
            
            damageInfo:SetDamageType(DMG_GENERIC)
            toucherobj.HitEntity:TakeDamageInfo(damageInfo)
        self:Remove()
    end
    end
    
    self.Entity.Bounces = self.Entity.Bounces + 1
    if self.Entity.Bounces >= self.Entity.BouncesTillDeath then
        self:Remove()
    end
    local physobj = self:GetPhysicsObject()
    local LastSpeed = math.max( touchdata.OurOldVelocity:Length(), touchdata.Speed )
	local NewVelocity = physobj:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )

	local TargetVelocity = NewVelocity * LastSpeed * 1.2

	physobj:SetVelocity( TargetVelocity )

    
    --self:EmitSound("weapon_effects/rubberband2.wav")
    
    
end

