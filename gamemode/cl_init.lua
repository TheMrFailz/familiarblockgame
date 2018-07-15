include( "shared.lua" )
include( "robloxhud.lua")
include( "robloxchat.lua")
include( "camerastuff.lua")
include( "buildmode.lua")



hook.Add('OnContextMenuOpen', 'NoContext4u', function()return false end)
local hide = {
	["CHudWeaponSelection"] = true
    --["CHudChatC"] = true
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

end )

surface.CreateFont( "ConvictSansOverlay", {
	font = "Comic Sans MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 32,
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


local ZoomLevel = 20

function ClientZoom()


end

--hook.Add('OnContextMenuOpen', 'NoContext4u', function()return false end)

local messageOverlay = {}
messageOverlay.text = ""
messageOverlay.time = 0

usermessage.Hook("openBuildControls", enableBuildControls)


net.Receive("client_ScreenMessage", function()
    local ply = net.ReadEntity()
    local message = net.ReadString()
    --local delay = net.ReadInt()
    
    messageOverlay.text = message
    messageOverlay.target = ply
    messageOverlay.time = CurTime() + 5
    --messageOv(ply, message, CurTime() + 3)
    --print("Hello!")
end)

function magicDupeMachine(dupeTable, fileName)
    
    -- Convert the table to a string (decompressed), Compress it...
    local dupeTable_d = util.TableToJSON(dupeTable, false)
    local dupeTable_c = util.Compress(dupeTable_d)
    
    -- Make ourselves a new file name to work with given the filename they want to write to.
    local newFileName = "fbg_" .. fileName .. ".txt"
    
    -- Write this to a new file in the /data/ directory!
    file.Write(newFileName, dupeTable_c)
    print("DING! File done saving.")

end

net.Receive("client_SaveWorld", function()
    local ply = net.ReadEntity()
    local message = net.ReadTable()
    local fileName = net.ReadString()
    if LocalPlayer() == ply then
        magicDupeMachine(message, fileName)
    end
end)
 

function messageOv(ply, message)
    
    
    
    local greybox = draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color(214, 209, 209,150))
    local offset = string.len(message) * 5
    
    local text = draw.Text({
        text = message,
        font = "ConvictSansOverlay",
        pos = { (ScrW() / 2) - offset, (ScrH() / 2) - 20 },
        color = NormalColor
    })
    
    
    
end

function messageOvControl()
    
    if (messageOverlay.text != "") && (messageOverlay.time > CurTime()) then 
        messageOv(messageOverlay.target, messageOverlay.text)
    
    
    end

end

hook.Add("HUDPaint", "RobloxOverlay", messageOvControl)


