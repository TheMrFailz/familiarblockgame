AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')


ENT.Rotating = false
local Anga = 0
local quickDisable = false
ENT.TimeLeft = 0

function ENT:Initialize()
    self:SetModel("models/extras/info_speech.mdl")
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
 
function ENT:Use()
    if self.Entity.Rotating == false then 
        self.Entity.Rotating = true
        if quickDisable == false then
            self.Entity.TimeLeft = CurTime() + 35
            self.Entity:EmitSound("misc/failz_dev_commentary/node_5.wav")
            
            
        end
        quickDisable = true
    else
        
    end


end

function ENT:Think()
    if self.Entity.Rotating == true then
        Anga = Anga + 3
        self.Entity:SetAngles(Angle(0, Anga, 0))
    end
    
    if self.Entity.TimeLeft < CurTime() && quickDisable == true then
        self.Entity.TimeLeft = 0
        quickDisable = false
        self.Entity.Rotating = false
    end
    
end