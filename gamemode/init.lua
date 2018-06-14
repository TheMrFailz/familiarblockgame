AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "roblox_guy.lua" )
include( "shared.lua" )
include( "roblox_guy.lua")
 
function GM:PlayerDeathSound()
    return true
end

function GM:PlayerDeath( ply, wep, attacker )
    
    ply:EmitSound("player/custom/oof.wav", 100, 100, 1)
    --print(ply:GetPos())
   

end

concommand.Add("join_buildmode", function( ply, cmd, args)
    ply:SetTeam(2)
    ply:SetModel("models/dav0r/camera.mdl")
    print("Entered build mode...")
    ply:Kill()
    end)
    
concommand.Add("join_playmode", function( ply, cmd, args)
    ply:SetTeam(1)
    ply:UnSpectate()
    ply:SetModel("models/player/failzstuff/roblox_guy/roblox_guy.mdl")
    print("Entered play mode...")
    ply:Kill()
    end)
    
    
function GM:PlayerInitialSpawn(ply)
    ply:ConCommand("join_playmode")
    

end
    
function GM:PlayerSpawn(ply)
    ply:SetupHands()

    if ply:Team() == 1 then
        print("Play mode player spawned!")
        
        
    end
    
    if ply:Team() == 2 then
        print("Build mode player spawned!")
        ply:Spectate( OBS_MODE_ROAMING )
        ply:Give("fbg_blockgun")
        
    end
    

end

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function brickposgenerator( pos)
    local maporigin = Vector(0,0,0)
    local outpos = Vector(0,0,0)
    local studsize = 11
    
    if(math.Round(pos.z) == 16)then
        pos.z = 20
    end
    
    local x = math.Round(pos.x/studsize)*studsize
    local y = math.Round(pos.y/studsize)*studsize
    local z = math.Round(pos.z/studsize)*studsize
    --local z = pos.z + 5.5
    outpos = Vector(x,y,z)

    return outpos
end

function brickgenerator( Length, Width, Height )
    local Model = ""
    
    local Le = ""
    local Wi = ""
    local He = ""
    
    if( (Length / 4)%1 != 0 ) then
        if( ((Length / 4)) < 1) && ((Length / 4) != 0.5) then
            Le = "0" .. tostring((Length / 4)*100)
        elseif( ((Length / 4) == 0.5)) then
            
            Le = "0" .. tostring((Length / 4)*10)
        else
            Le = tostring((Length / 4)*100)
        end
    else
        Le = tostring(Length / 4)
    end
    
    if( (Width / 4)%1 != 0 ) then
        if( ((Width / 4)) < 1) && ((Width / 4) != 0.5) then
            Wi = "0" .. tostring((Width / 4)*100)
        elseif( ((Width / 4) == 0.5)) then
            
            Wi = "0" .. tostring((Width / 4)*10)
        else
            Wi = tostring((Width / 4)*100)
        end
    else
        Wi = tostring(Width / 4)
    end
    
    if( (Height / 4)%1 != 0 ) then
        if( ((Height / 4)) < 1) && ((Height / 4) != 0.5) then
            He = "0" .. tostring((Height / 4)*100)
        elseif( ((Height / 4) == 0.5)) then
            
            He = "0" .. tostring((Height / 4)*10)
        else
            He = tostring((Height / 4)*100)
        end
    else
        He = tostring(Height / 4)
    end
    
	Model = ( "models/hunter/blocks/cube" .. Wi .. "x" .. Le .. "x" .. He .. ".mdl" )

    return Model

end

function blockinit(ply, lookpos)
    --print("Success!")
    local newprop = ents.Create("roblox_brick_base")
    if (!IsValid( newprop )) then return end
    
    newprop:SetModel(brickgenerator(1,1,1))
    newprop:SetPos(brickposgenerator(lookpos))
    newprop:Spawn()
    
    local phys = newprop:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
    newprop:GetPhysicsObject():EnableMotion(false)
    --newprop:SetOwner(ply)
    

end

function blockcolor(ply, lookent, Color)
    if (!lookent:IsValid()) then return end
    --if (lookent:GetOwner() == ply) then 
        lookent:SetColor(Color)
        print("Made color")
        print(Color)
        
    --end
    

end

function blockdelete(ply, lookent)
    if (!lookent:IsValid()) then return end
    --if (lookent:GetOwner() == ply) then 
        lookent:Remove()
        
    --end
    
end

