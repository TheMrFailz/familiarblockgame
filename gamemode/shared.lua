DeriveGamemode( "sandbox" )

GM.Name = "Familiar Block Game"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
    team.SetUp(1, "Playmode", Color(0,0,255), true)
	team.SetUp(2, "Buildmode", Color(0,0,255), true)
end