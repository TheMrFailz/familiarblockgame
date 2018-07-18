AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

local Length = 4
local Width = 2
local Height = 1
local MaxHealth = 650
local Constraintable = true
ENT.OurHealth = MaxHealth

function ENT:Initialize()
    
    
	self:SetModel( "models/hunter/blocks/cube2x2x025.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    
    
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
    
    --self:EmitSound("weapon_effects/rocket_fire.wav")
end

 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    
end


function ENT:PhysicsCollide( touchdata, toucherobj )
    
    
    
end

function ENT:OnTakeDamage(dmg)
    if(self.Entity.OurHealth < (MaxHealth * 0.5)) then
        Constraintable = false
        
        if(self.Entity:GetPhysicsObject():IsMoveable() == false) then
            self.Entity:GetPhysicsObject():EnableMotion(true)
        end
    end
    
    if(self.Entity.OurHealth < (MaxHealth * 0.20)) then
        constraint.RemoveAll(self.Entity)
    end
    
    self.Entity:TakePhysicsDamage(dmg)
    if(self.Entity.OurHealth <= 0) then return end
    
    self.Entity.OurHealth = self.Entity.OurHealth - dmg:GetDamage()
    if(self.Entity.OurHealth <= 0) then
        self.Entity:Remove()
        
    end
end