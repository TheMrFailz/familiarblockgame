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
    
    local weaponsTable = ply:GetWeapons()
    local numOfWeps = table.Count(weaponsTable)
    
    
    if ((button - 1) >= 0 ) && ((button - 1) <= 9) then
        ply:SelectWeapon(weaponsTable[button - 1]:GetClass())
        
    end
    

end)

