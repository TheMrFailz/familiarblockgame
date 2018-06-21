include( "shared.lua" )
include( "robloxhud.lua")
include( "robloxchat.lua")
include( "camerastuff.lua")

hook.Add('OnContextMenuOpen', 'NoContext4u', function()return false end)
local hide = {
	["CHudWeaponSelection"] = true
    --["CHudChatC"] = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

end )




local ZoomLevel = 20

function ClientZoom()


end

--hook.Add('OnContextMenuOpen', 'NoContext4u', function()return false end)

local function messageOv(ply, message)
    
    local greybox = draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color(214, 209, 209,150))
    local text = draw.Text({
        text = message,
        font = "ConvictSans",
        pos = { ScrW() / 2, ScrH() / 2 },
        color = NormalColor
    })
    
    

end

net.Receive("client_ScreenMessage", function()
    local ply = net.ReadEntity()
    local message = net.ReadString()
    --local delay = net.ReadInt()
    messageOv(ply, message)
    --print("Hello!")
end)



