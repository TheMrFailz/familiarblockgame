AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

local Length = 4
local Width = 2
local Height = 1
local MaxHealth = 300

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
    
end

