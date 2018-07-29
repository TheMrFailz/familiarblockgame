AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

local Length = 4
local Width = 1
local Height = 1
local MaxHealth = 500
local Constraintable = true
ENT.OurHealth = MaxHealth

function Connector() end
 
function ENT:Initialize()
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
    
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    phys:Sleep()
    
    --self:EmitSound("weapon_effects/rocket_fire.wav")
end

function Connector(self)
    if (Constraintable == true) then
        print("Checking for neighbors")
        local constrainttrace = util.QuickTrace(self:GetPos(), self:LocalToWorld(Vector(0,0,100)), self)
        print(constrainttrace.Entity)
        if(constrainttrace.Entity:IsValid()) then
            constraint.Weld(self.Entity, constrainttrace.Entity, 0, 0, 0, true, false)
            print("WE FOUND SOMETHING!")
        end
    end
end
 

function ENT:OnTakeDamage(dmg)
    if(self.Entity.OurHealth < (MaxHealth * 0.6)) then
        Constraintable = false
        if(self.Entity:GetPhysicsObject():IsMoveable() == false) then
            self.Entity:GetPhysicsObject():EnableMotion(true)
        end
    end
    
    if(self.Entity.OurHealth < (MaxHealth * 0.40)) then
        constraint.RemoveAll(self.Entity)
        
    end
    if(self.Entity.OurHealth < (MaxHealth * 0.20)) then
        constraint.RemoveAll(self.Entity)
        self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        
    end
    
    self.Entity:TakePhysicsDamage(dmg)
    if(self.Entity.OurHealth <= 0) then return end
    
    self.Entity.OurHealth = self.Entity.OurHealth - dmg:GetDamage()
    if(self.Entity.OurHealth <= 0) then
        self.Entity:Remove()
        
    end
end

