-- This is where you should be doing your ~custom~ sub gamemode meme.
-- Consider include'ing sub-files if you want to do multiple sub gamemodes and you want to pick between them.

local roundTime = -1
local roundLength = 180

function GM:Initialize()
    print("35 seconds until we start doing some round memes.")
    
    local quickPlayerList = player.GetHumans()
    for i = 1, player.GetCount() do
        messageOverlay(quickPlayerList[i], "Beginning round in 35 seconds...")
    end
    
    --rountTime = curTime() + 60
    timer.Simple( 35, function()
        roundStart()
    
    end)


end

local teamWeps = {
    "rblx_rocketlauncher"

}

local function teamWeaponGiver(ply)
    
        if ply:Team() == 3 or ply:Team() == 4 then
            for y = 1, table.Count(teamWeps) do
                ply:Give(teamWeps[y])
            end
        end
    



end
hook.Add("PlayerSpawn", "teamWeaponGiverHook", teamWeaponGiver)



function checkSpawns(quitBool)
    if quitBool == true then return end
    local oofTeam = spawnListAssembler(Color(0, 165, 255, 255))
    local bloxxTeam = spawnListAssembler(Color(255, 136, 0, 255))
    local gameover = false
    
    if table.Count(oofTeam) == 0 then
        local quickPlayerList = player.GetHumans()
        for i = 1, player.GetCount() do
            messageOverlay(quickPlayerList[i], "Game over! The Bloxxers win!")
        end
        gameover = true
        timer.Simple(7, function()
            roundEnd()
        end)
    end
    if table.Count(bloxxTeam) == 0 then
        local quickPlayerList = player.GetHumans()
        for i = 1, player.GetCount() do
            messageOverlay(quickPlayerList[i], "Game over! The Oofers win!")
        end
        gameover = true
        timer.Simple(7, function()
            roundEnd()
        end)
    end
    
    timer.Simple(5, function()
    
        checkSpawns(gameover)
    end)
end

function roundStart()

    local quickPlayerList = player.GetHumans()
    
    if table.Count(quickPlayerList) > 0 then
        fbg_worldload(quickPlayerList[1], "battletowerz_final_TEST")
    else
        print("Not enough players to start the round! Trying again in 15 seconds.")
        timer.Simple(15, function()
            roundStart()
        end)
        return
    end
    
    local teamPicker = 3
    for i = 1, player.GetCount() do
        quickPlayerList[i]:SetTeam(teamPicker)
        messageOverlay(quickPlayerList[i], "Round start! Destroy the enemy spawns!")
        timer.Simple(7, function()
            messageOverlay(quickPlayerList[i], "!This is a demo gamemode, so it's gonna be shit!")
        end)
        teamPicker = teamPicker + 1
        if teamPicker > 4 then teamPicker = 3 end
    end
    
    checkSpawns(false)
    
end 
-- NOTE TO SELF REMOVE THIS
concommand.Add("fbg_forceStart", function(ply, cmd, args)
    roundStart()
end)


function roundEnd()
    local quickPlayerList = player.GetHumans()
    for i = 1, player.GetCount() do
        messageOverlay(quickPlayerList[i], "Restarting (regenerating world...)")
    end
    timer.Simple(7, function()
       roundStart()
    end)
    
end