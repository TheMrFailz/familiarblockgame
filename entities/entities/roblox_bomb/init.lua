AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

ENT.exloding3 = 0
ENT.stage = 0

local function SelfExplode(self) 
    
    local explosion = ents.Create( "env_explosion" )
    explosion:SetPos(self:GetPos())
    explosion:SetOwner(self)
    explosion:SetKeyValue("spawnflags", 64)
    explosion:Spawn()
    explosion:SetKeyValue("iMagnitude", "300")
    explosion:Fire( "Explode", 0, 0)
    
    explosion:EmitSound("weapon_effects/bomb_explode.wav", 400, 100)
    self:Remove()

end 


function ENT:Think()
    
    if self.Entity.exploding3 != nil then
    if self.Entity.exploding3 <= CurTime() then
        self.Entity:EmitSound("weapon_effects/switch_tick.wav")
        self.Entity.stage = self.Entity.stage + 1
        self.Entity.exploding3 = CurTime() + (2 - (0.3 * self.Entity.stage))
        
    end
    else
        self.Entity.exploding3 = CurTime() + 2
    end
    
    if self.Entity.exploding3 < CurTime() - 3 then
        SelfExplode(self)
    end
    
end
 
function ENT:Initialize()
    self.Entity.exploding3 = CurTime() + 2
	self:SetModel( "models/roblox_weapons/bomb/weapon_rblx_bomb.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    
 
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
    --tickTock(5, self.Entity)
    
    --self:EmitSound("weapon_effects/rocket_fire.wav")
end
 
function ENT:Use( activator, caller )
    return
end





function ENT:PhysicsCollide( touchdata, toucherobj )
    
end

