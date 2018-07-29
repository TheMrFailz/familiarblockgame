AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

local Length = 4
local Width = 1
local Height = 1
local MaxHealth = 300
local Constraintable = true
ENT.OurHealth = MaxHealth

function ENT:Initialize()
    
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    self:SetModel("models/hunter/blocks/cube8x8x025.mdl")
    
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
    self:SetRenderMode( RENDERMODE_TRANSALPHA )
    self:SetColor(Color(255,255,0,10))
    self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    --self:EmitSound("weapon_effects/rocket_fire.wav")
    phys:Sleep()
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

function ENT:Think()
return true
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

function ENT:Touch( toucher )
    if toucher:IsValid() then
        --print("Oolala")
        if toucher:IsPlayer() then
            toucher:Kill()
        end
        
    end


end

function ENT:OnTakeDamage(dmg)
--[[
    Leftover code from the original brick. We don't want kill bricks to break so we don't do anything here.
    
    if(self.Entity.OurHealth < (MaxHealth * 0.9)) then
        Constraintable = false
        if(self.Entity:GetPhysicsObject():IsMoveable() == false) then
            self.Entity:GetPhysicsObject():EnableMotion(true)
        end
    end
    
    if(self.Entity.OurHealth < (MaxHealth * 0.50)) then
        constraint.RemoveAll(self.Entity)
    end
    
    
    self.Entity:TakePhysicsDamage(dmg)
    if(self.Entity.OurHealth <= 0) then return end
    
    self.Entity.OurHealth = self.Entity.OurHealth - dmg:GetDamage()
    if(self.Entity.OurHealth <= 0) then
        self.Entity:Remove()
        
    end]]
end

