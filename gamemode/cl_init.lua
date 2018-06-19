include( "shared.lua" )
include( "robloxhud.lua")
include( "camerastuff.lua")

hook.Add('OnContextMenuOpen', 'NoContext4u', function()return false end)

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



