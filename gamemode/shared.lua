DeriveGamemode( "sandbox" )

GM.Name = "Familiar Block Game"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
    team.SetUp(1, "Playmode", Color(255,0,0), true)
	team.SetUp(2, "Buildmode", Color(100,100,100), true)
end

hook.Add("PlayerButtonDown", "ButtonyThings", function(ply, button)
    if SERVER then
    local weaponsTable = ply:GetWeapons()
    local numOfWeps = table.Count(weaponsTable)
    
    
    if ((button - 1) >= 0 ) && ((button - 1) <= 9) then
        if button - 2 < table.Count(weaponsTable) then
            ply:SelectWeapon(weaponsTable[button - 1]:GetClass())
        end
    end
    
    end
end)


function brickMatrixGenerator(entity, length, width, height)
    if CLIENT then 
    local blockScale = Vector(length, width, height)
    local blockMatrix = Matrix()
    
    blockMatrix:Scale(blockScale)
    --print("nice")
    entity:EnableMatrix("RenderMultiply", blockMatrix)
    end
    
    
end