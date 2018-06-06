AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:PlayerDeathSound()
    return true
end

function GM:PlayerDeath( ply, wep, attacker )
    
    ply:EmitSound("player/custom/oof.wav", 100, 100, 1)
    print(ply:GetPos())
   

end

