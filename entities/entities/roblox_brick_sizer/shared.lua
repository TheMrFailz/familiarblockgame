ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Brick"

ENT.Author			= "nil"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

if CLIENT then
    ENT.Category        = "Roblox Ents"
end

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "Direction" )

end