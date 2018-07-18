DeriveGamemode( "sandbox" )

GM.Name = "Familiar Block Game"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"
GM.TeamBased = false

function GM:Initialize()
    
end

team.SetUp(1, "Playmode", Color(255,0,0,255), true)
team.SetUp(2, "Buildmode", Color(100,100,100,255), true)
team.SetUp(3, "Oofers", Color(0, 165, 255, 255), true)
team.SetUp(4, "Bloxxers", Color(255, 136, 0, 255), true)

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