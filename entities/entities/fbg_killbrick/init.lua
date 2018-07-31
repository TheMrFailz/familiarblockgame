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
    phys:SetMass(1)
    --self:SetRenderMode( RENDERMODE_TRANSALPHA )
    self:SetColor(Color(255,255,0,10))
    --self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
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
        --print(toucher)
        if toucher:IsPlayer() then
            toucher:Kill()
        end
        
    end


end

function ENT:OnTakeDamage(dmg)

end

