surface.CreateFont( "ConvictSans", {
	font = "Comic Sans MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 28,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

function WeaponSelect()
    if LocalPlayer():Alive() == true then
    local weaponsTable = LocalPlayer():GetWeapons()
    local numOfWeps = table.Count(weaponsTable)
    -- 125 w x 125 h
    draw.RoundedBox(0, 0, ScrH() - 125, 125 * numOfWeps, ScrH(), Color(214, 209, 209,150)) -- draw wide ass weapon select box
    
    local numSizeW = 35
    local numSizeH = 35
    
    
    
    for i = 0, numOfWeps - 1 do
        surface.SetDrawColor(255,255,255,255) -- Cleanup so our shit doesn't end up green.
        if weaponsTable[i+1] == nil then break end
        local wepClass = weaponsTable[i+1]:GetClass() 
        --print('materials/entities/' .. wepClass .. '.png')
        local wepPos = table.KeyFromValue(weaponsTable, LocalPlayer():GetActiveWeapon()) - 1 -- Find out where in the table your current weapon is so we can highlight it
        
        surface.SetMaterial(Material('materials/entities/' .. wepClass .. '.png'))
        surface.DrawTexturedRect(i*125, ScrH() - 125, 125, 125) -- Draw that cool weapon icon
        
        draw.RoundedBox(0, i * 125, ScrH() - numSizeH, numSizeW, numSizeH, Color(214, 209, 209,200)) -- draw little boxes for the numbers
        draw.Text({
            text = i + 1, -- Weapon number
            font = "ConvictSans",
            pos = { (i * 125) + 12, ScrH() - 31 },
            color = Color(255,255,255,255)
        })
        
        --print("I is " .. i .. " and wepPos is " .. wepPos)
        if i == wepPos then
            draw.OutlinedBox(i * 125, ScrH() - 125, 125, 125, 3, Color(75, 196, 66, 255)) -- If our current draw cycle for this happens
            -- to be on the selected weapon, draw a cool green box outline.
            
        end
        
    end

    end
end

function RScoreBoard()
    local playerTable = player.GetAll()
    
    draw.RoundedBox(0, ScrW() - 255, 10, 245, 50 + (table.Count(playerTable) * 17), Color(214, 209, 209,150))
    draw.Text({
        text = "Player List",
        font = "ConvictSans",
        pos = { ScrW() - 255, 10 },
        color = Color(255,255,255,200)
    })
    
    for i = 1, table.Count(playerTable) do
        local col = team.GetColor(playerTable[i]:Team())
        local r, g, b, a = col.r, col.g, col.b, col.a
        draw.Text({
            text = playerTable[i]:Nick(),
            font = "ConvictSans",
            pos = { ScrW() - 255, 15 + (i * 17) },
            color = Color(r,g,b,200)
        })
    
    
    end
    
    
    
end

hook.Add("HUDPaint", "RobloxWeaponSelect", WeaponSelect)
hook.Add("HUDPaint", "RobloxScoreBoard", RScoreBoard)





--function PlayerList

function HUD()
    local client = LocalPlayer()
    --client:SetWorldClicker( true )
    if !client:Alive() then
        return
    end
    
    local NormalColor = Color(0,0,0,200)
    local DisabledColor = Color(100,100,100,200)
    
    draw.RoundedBox(0, 0, 0, 650, 30, Color(214, 209, 209,150)) -- Draw that grey menu bar on the top let
    --/**
    -- WORDS
    draw.Text({
        text = "Fullscreen",
        font = "ConvictSans",
        pos = { 250, 0 },
        color = DisabledColor
    })
    
    draw.Text({
        text = "Tools",
        font = "ConvictSans",
        pos = { 10, 0 },
        color = DisabledColor
    })
    
    draw.Text({
        text = "Insert",
        font = "ConvictSans",
        pos = { 120, 0 },
        color = DisabledColor
    })
    
    draw.Text({
        text = "Help...",
        font = "ConvictSans",
        pos = { 400, 0 },
        color = NormalColor
    })
    
    draw.Text({
        text = "Exit",
        font = "ConvictSans",
        pos = { 530, 0 },
        color = NormalColor
    })
    --*/
    
    -- Health bar thing
    draw.Text({
        text = "Health",
        font = "ConvictSans",
        pos = { ScrW() - 100, ScrH() / 2 },
        color = Color(0,29,255,255)
    })
    
    local health = client:Health() * 1.25
    
    draw.RoundedBox(0, ScrW() - 75, (ScrH() / 2) - 125, 10, 125, Color(255, 27, 0, 255))
    draw.RoundedBox(0, ScrW() - 75, (ScrH() / 2) - health + 0, 10, health + 1, Color(129, 174, 41, 255))


end
hook.Add("HUDPaint", "Robloxhud", HUD)

function Hidehud(ply)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
        if ply == v then
            return false
        end
        
    end



end
hook.Add("HUDShouldDraw","HideDefaultHud", Hidehud)