AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "roblox_guy.lua" )
AddCSLuaFile( "robloxhud.lua")
AddCSLuaFile( "robloxchat.lua")
AddCSLuaFile( "buildmode.lua")
AddCSLuaFile( "camerastuff.lua")
include( "shared.lua" )
include( "roblox_guy.lua")
include( "gamescript.lua")
include( "textureincludes.lua")


--[[F A M I L I A R B L O C K G A M E
        A H I D E O K O J I M A
          P R O D U C T I O N

    TL:DR: it's a roblox clone.
    As far as I know all assets used
    are freeware / royalty free.
    Additionally, no code from Roblox
    was used in the production of this
    gamemode.
    
    Produced originally by TheMrFailz
    for the 2018 Summer gamemode competition.
    ]]

isAllowed_Build = true

util.AddNetworkString( "client_ScreenMessage" )
util.AddNetworkString( "client_SaveWorld" )
util.AddNetworkString( "dupeTransfer" )


function messageOverlay(ply, message)
    if IsValid(ply) then
        net.Start("client_ScreenMessage")
        net.WriteEntity(ply)
        net.WriteString(message)
        --net.WriteInt(delay)
        net.Send(ply)
        --print("run2")
    end

end
concommand.Add("screenything", function( ply, cmd, args, argStr)
    messageOverlay(ply, argStr)
    print(argStr)
end)


 
function GM:PlayerDeathSound()
    return true
end

function GM:PlayerDeath( ply, wep, attacker )
    
    ply:EmitSound("player/custom/oof.wav", 100, 100, 1)
    --print(ply:GetPos())
   

end

concommand.Add("join_buildmode", function( ply, cmd, args)
    if isAllowed_Build == true then
        ply:SetTeam(2)
        ply:SetModel("models/dav0r/camera.mdl")
        print("Entered build mode...")
        ply:Kill()
    else
        print("Error! Build mode disabled!")
        print("Change 'isAllowed_Build' to true in init.lua!")
    
    end
    end)
    
concommand.Add("join_playmode", function( ply, cmd, args)
    ply:SetTeam(1)
    ply:UnSpectate()
    ply:SetModel("models/player/failzstuff/roblox_guy/roblox_guy.mdl")
    --print("Entered play mode...")
    ply:Kill()
    end)
    
    
function GM:PlayerInitialSpawn(ply)
    ply:ConCommand("join_playmode")
    ply:ConCommand("dsp_off 1")

end
    
function GM:PlayerSpawn(ply)
    ply:SetupHands()

    if ply:Team() == 1 then
        print("Play mode player spawned!")
        --ply:ConCommand("join_playmode")
        
    end
    
    if ply:Team() == 2 then
        print("Build mode player spawned!")
        ply:Spectate( OBS_MODE_ROAMING )
        
        ply:Give("fbg_blockgun")
        ply:Give("fbg_colorgun")
        ply:Give("fbg_movegun")
        ply:Give("fbg_resizegun")
        ply:Give("fbg_copygun")
        
        umsg.Start("openBuildControls", ply)
        umsg.End() 
        
    end
    

end




function GM:PlayerButtonDown(ply, button)
    -- THIS IS TO FIX THE DUMB SPECTATOR NO SWEPS MEME
    if (button >= 2) && (button <= 10) then
        if ply:Team() == 2 then
            local weaponsTable = ply:GetWeapons()
            ply:UnSpectate()
            ply:SelectWeapon(weaponsTable[button - 1]:GetClass())
            --print(weaponsTable[button - 1]:GetClass())
            ply:Spectate( OBS_MODE_ROAMING )
        end
        
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

function rightAngleFind(ang)
    print("Input ang: ")
    print(ang)
    --ang = ang + 180
    
    if ang <= 45 && ang >= -45 then
        finalAngle = 0
    elseif ang > 45 && ang <= 135 then
        finalAngle = 90
    elseif ang < -45 && ang >= -135 then
        finalAngle = -90
    elseif ang > 135 && ang <= 180 then
        finalAngle = 180
    elseif ang < -135 && ang >= -180 then
        finalAngle = 180
    end
    
    return finalAngle
end

-- BRICK RELATED CODE BEGINS HERE

function brickposgenerator( pos)
    --[[ This function can (and should) be used to:
        Produce a grid location given a nearby
        vector world position.
        
    ]]


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
    --[[ This function can (and should) be used to:
        Produce a model name relative to the PHX
        model pack that roughly matches the brick
        specifications provided.
        
    ]]
    
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

function brickMatrixGenerator(entity, length, width, height)
    local blockS
    
    
    
end

function blockinit(ply, lookpos)
    --[[ This function can (and should) be used to:
        Create a new brick entity at a location.
        
    ]]
    
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
    --[[ This function can (and should) be used to:
        Change a particular brick's color.
        
    ]]
    
    
    if (!lookent:IsValid()) then return end
    lookent:SetColor(Color)
    --print("Made color")
    --print(Color)


end

function blockdelete(ply, lookent)
    --[[ This function can (and should) be used to:
        Delete a particular brick.
        
    ]]
    
    if (!lookent:IsValid()) then return end
    lookent:Remove()

end

function blockresize(lookent, length, width, height)
    --[[ This function can (and should) be used to:
        Resize a specific brick given new needed
        length/width/height specifications.
        
    ]]
    local originalPos = lookent:GetModelBounds(mins)
    local newPos = Vector(0,0,0)
    local newModel = brickgenerator(length, width, height)
    
    --print(newModel)
    if util.IsValidModel(newModel) == true then
    
        lookent:SetModel(newModel)
        
        lookent:Activate()
        lookent:PhysicsInit(SOLID_VPHYSICS)
        local phys = lookent:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableMotion(false)
        end
        
        newPos = lookent:LocalToWorld(originalPos)
        --lookent:SetPos(newPos)
    end
end

function blockscroll(ent, dir, side)
    if dir == "forward" then
        if scrolldir == 1 then
            ent:SetPos(ent:LocalToWorld(Vector(30,0,0)))
        elseif scrolldir == 2 then
            ent:SetPos(ent:LocalToWorld(Vector(30,0,0)))
        elseif scrolldir == 3 then
            ent:SetPos(ent:LocalToWorld(Vector(30,0,0)))
        end
    end
    if dir == "backward" then
        if scrolldir == 1 then
            ent:SetPos(ent:LocalToWorld(Vector(-30,0,0)))
        elseif scrolldir == 2 then
            ent:SetPos(ent:LocalToWorld(Vector(0,-30,0)))
        elseif scrolldir == 3 then
            ent:SetPos(ent:LocalToWorld(Vector(0,0,-30)))
        end
    end

end

function modeltoints(modelname, desireddimension)
    --local modelName = string.StripExtension(string.Replace(modelname, "models/hunter/blocks/cube", ""))
    local splodetable
    
    if !istable(modelname) && string.find(modelname, "models/hunter/blocks/cube")  != nil then
        local modelName = string.StripExtension(string.Replace(modelname, "models/hunter/blocks/cube", ""))
        splodetable = string.Explode("x", modelName, false)
        
    else
        splodetable = string.Explode("x", modelname[1], false)
    end
    
    
    --PrintTable(splodetable)
    local x, y, z
    
    x = tonumber(splodetable[1])
    y = tonumber(splodetable[2])
    z = tonumber(splodetable[3])
    
    
    
    if desireddimension == 1 then
        
        return x
    elseif desireddimension == 2 then
        
        return y
    elseif desireddimension == 3 then
        
        return z
        
    end
    
    --local brickheight = tonumber(string.StripExtension(splodetable[3]))
    
    
    
end

function brickgroundheight(ent)
    local dist = 0
    --local splodetable = string.Explode("x", ent:GetModel(), false)
    --local brickheight = tonumber(string.StripExtension(splodetable[3]))
    
    
    local brickheight = modeltoints(ent:GetModel(), 3)
    
    if brickheight == 25 then
        dist = 0
    elseif brickheight == 5 then
        dist = 1 * 6
    elseif brickheight == 75 then
        dist = 2 * 6
    else
    
        dist = (brickheight * 17)
    
    end
    --print("dist = " .. dist)
    --modeltoints(ent:GetModel(), 1)
    
    return dist
end


function brickcopy(ent, newpos, ang)
    local newModel = ent:GetModel()
    local newColor = ent:GetColor()
    local newAdjustedPos = brickposgenerator(newpos) + Vector(0,0,brickgroundheight(ent))
    
    local newProp = ents.Create("roblox_brick_base")
    if (!IsValid( newProp )) then return end
    
    newProp:SetModel(newModel)
    
    newHeight = ent:GetPos() + Vector(0,0,25)
    
    newProp:SetPos(newAdjustedPos)
    newProp:SetAngles(Angle(Vector(0,ang,0)))
    newProp:Spawn()
    newProp:SetColor(newColor)
    
    local phys = newProp:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    
    newProp:GetPhysicsObject():EnableMotion(false)


end

function resizelookat(ply, size)
    if IsValid(ply) then
    
    print(size)
    
    local lookedTable = ply:GetEyeTrace()
    local brickToSize = lookedTable.Entity
    local x = modeltoints(size, 1)
    local y = modeltoints(size, 2)
    local z = modeltoints(size, 3)
    
    blockresize(brickToSize, x, y, z)
    print("DONE!")

    end
end

concommand.Add("fbg_brickresize", function(ply, cmd, args)
    resizelookat(ply, args)
    end)

-- TURN BACK WHILE YOU STILL CAN. WORLD SAVING CODE BEGINS HERE AND SWEET JESUS IT IS TERRIFYING!

local bigtable = {} 

duplicator.Allow("roblox_brick_*")

function worldSaverThing(ply, worldTable, fileName)
    if IsValid(ply) then
        net.Start("client_SaveWorld")
        net.WriteEntity(ply)
        net.WriteTable(worldTable)
        net.WriteString(fileName)
        net.Send(ply)
        
    end

end


--[[ Map Saving Code.
     UPDATE 15/7/2018 (EURODATE):
    Re-wrote the world saving/loading code. TL:DR I originally loaded it from the client for some retarded reason.
    
    INFORMATION:
    This code is used to save your current world that you've made into a text file that can be loaded later.
    IT IS NOT MEANT TO BE USED IN MULTIPLAYER AT ALL. FAILURE TO DO SO WILL CAUSE HEADACHES AND ERRORS!
    
    Feed the command a filename (without folders or extensions). Will be saved to /data/ as fbg_(name).txt.
    MUST BE TRANSFERRED LATER MANUALLY TO THE SERVER'S familiarblockgame/content/data/mapdata/ folder.


]]

concommand.Add("fbg_worldsave", function(ply, cmd, args)
    bigtable = {}
    local worldObjTable = ents.FindByClass("roblox_brick_*")
    local worldObjDat = {}
    
    
    bigtable = duplicator.CopyEnts(worldObjTable)
    worldSaverThing(ply, bigtable, args[1]) -- DONT RUN THIS IN MP YOUR GONNA BREAK SOME SHIT.
    
    end)

--[[ Map loading code.
    UPDATE 15/7/2018 (EURODATE):
    Re-wrote the world saving/loading code. TL:DR I originally loaded it from the client for some retarded reason.
    
    INFORMATION:
    So this set of code basically reads the specified world data out of a text file in familiarblockgame/content/data/.
    I would have stored the files under content but I don't think the gamemode appreciates trying to load
    custom folders there.
    
    To call this just run fbg_worldload(player,file) where ply is a random player and file is
    the filename without the extension or folder bit.
    
    You may have noticed that there's a ply thing: I can't really get rid of that as it's
    required for duplicator.paste's dumbass function. Sorry! Provided you aren't
    doing any game-side ownership stuff though you should be ok to grab a random player.
    
    ]]


function fbg_worldload(ply, fileName)
    
    -- worldLoadThing(ply, file[1])
    
    -- Assemble the file location.
    local fileNameThing = "fbg_" .. fileName .. ".txt"
    print(fileNameThing)
    if file.Exists(fileNameThing, "DATA") != true then
        print("No file found!")
        return
    end
    
    -- Open and read the compressed string.
    local mapData_c = file.Read(fileNameThing)
    
    -- Decompress the string.
    local mapData_d = util.Decompress(mapData_c)
    
    -- Convert to a table.
    local mapData_d = util.JSONToTable(mapData_d)
    
    -- Setup our angles and position. In this case we're just doing the defaults WHICH YOU SHOULD PROBABLY KEEP.
    duplicator.SetLocalPos(Vector(0,0,0))
    duplicator.SetLocalAng(Angle(0,0,0))
    
    
    -- Begin pasting the map. REQUIRES A PLAYER OF SOME SORT.
    duplicator.Paste( ply, mapData_d.Entities, mapData_d.Constraints)
    
    print("DING! Paste is done.")
end

-- NOTE TO SELF: REMOVE THIS COMMAND LATER.
concommand.Add("fbg_worldload", function(ply, cmd, args)
    fbg_worldload(ply, args[1])
    end)

