include( "shared.lua" )
include( "robloxhud.lua")
include( "robloxchat.lua")
--include( "camerastuff.lua")
include( "buildmode.lua")
include( "lavakillfield.lua")


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

local messageOverlay = {}
messageOverlay.text = ""
messageOverlay.time = 0

function enableMoveControls()
enableMouseControls()

end

usermessage.Hook("openBuildControls", enableBuildControls)
 
net.Receive("client_ScreenMessage", function()
    local ply = net.ReadEntity()
    local message = net.ReadString()
    
    messageOverlay.text = message
    messageOverlay.target = ply
    messageOverlay.time = CurTime() + 5
end)

function magicDupeMachine(dupeTable_c, fileName)
    
    
    -- Make ourselves a new file name to work with given the filename they want to write to.
    local newFileName = "fbg_" .. fileName .. ".txt"
    
    -- Write this to a new file in the /data/ directory!
    file.Write(newFileName, dupeTable_c)
    if file.Exists(newFileName, "DATA") != true then
        
        print("OOF! Somethings wrong! Saved file not found!")
    else 
        print("DING! File done saving.")
        print("File contents:")
        print(file.Read(newFileName, "DATA"))
    end
end

net.Receive("client_SaveWorld", function()
    local ply = net.ReadEntity()
    local message = net.ReadString()
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

local ScrollDist = 30
local CamPos -- This is for keeping track of where the thirdperson cam is.
local moveClickDelay = 0
local Distance2Move = 0
local walktimeGlobal = 0
--local hasChanged = false
--local isMoving = false

--==============================================================
--[[ This controls the dank thirdperson cam. ]]

local thirdpersonCamera_Allowed = true
local mousePanel2 = vgui.Create("DFrame")
mousePanel2:SetSize(ScrW(), ScrH())
mousePanel2:SetPos(0,0)
mousePanel2:SetAlpha(0)
mousePanel2:SetWorldClicker(true)
mousePanel2:ShowCloseButton(true)
mousePanel2:SetCursor("blank")
mousePanel2:SetKeyboardInputEnabled( true )
--mousePanel2:SetDraggable(true)



function mousePanel2:OnMouseWheeled(delta)
    if delta == 1 then
        ScrollDist = ScrollDist - 10
    elseif delta == -1 then
        ScrollDist = ScrollDist + 10
        
    end
end

--[[ This is how we do click to move. It's mega jank.]]
function click2move()
    
    if (ScrollDist > 5 && input.IsMouseDown(MOUSE_MIDDLE) == true) && moveClickDelay < CurTime() then
        
        
        local x, y = gui.MousePos()
        
        local tr = util.QuickTrace( CamPos, gui.ScreenToVector( gui.MousePos() ) * 100000, LocalPlayer() )
        
        
        local ShootyShootPos = LocalPlayer():GetShootPos()
        
        local Dist = LocalPlayer():GetPos():Distance(tr.HitPos)
        
        if Dist <= 1000 then
            LocalPlayer():SetEyeAngles((tr.HitPos - ShootyShootPos):Angle())
            
            local walktime = Dist / 210
            walktimeGlobal = CurTime() + walktime
            LocalPlayer():ConCommand("+forward")
            
            
            timer.Simple(walktime, function()
                
                if walktimeGlobal < CurTime() then
                    LocalPlayer():ConCommand("-forward")
                end
            end)
            
            
            
        end
        moveClickDelay = CurTime() + 0.5
    end

    
end

hook.Add( "Think", "Click2Move", click2move )


--[[ Just a heads up this is basically gonna be a clone of the context menu meme

]]
--vgui.Register( "CoolmousePanel2", mousePanel2, "EditablePanel")
function mousePanel2:Init()
    -- I guess we setup our panel here? Really hacky shit imo.

    self:SetSize(ScrW(), ScrH())
    --self:Center()
    self:SetWorldClicker(false)
    self:SetCursor("blank")
    
end

function mousePanel2:Open()
    if (self:IsVisible()) then return end
    
    CloseDermaMenus()
    
    mousePanel2:SetAlpha(0)

    --self:MakePopup()
    gui.EnableScreenClicker(true)
    self:SetVisible(true)
    self:SetKeyboardInputEnabled( false )
    self:SetMouseInputEnabled( true )
    RestoreCursorPosition()
    
    
    
end

function mousePanel2:Close( bSkipAnim )

    gui.EnableScreenClicker(false)
	RememberCursorPosition()
	
    --self:MakePopup(false)
	self:SetKeyboardInputEnabled( false )
	self:SetMouseInputEnabled( false )
    self:KillFocus()
	self:SetAlpha( 255 )
	self:SetVisible( false )
	--self:RestoreControlPanel()
    CloseDermaMenus()
    
end

function enableMouseControls(ply)
    mousePanel2:Open()




end

function disableMouseControls(ply)
    mousePanel2:Close()




end


local toggle = false
local clicktoggle = false
function pivotView()

    if CLIENT then
        
        
        if input.IsMouseDown(MOUSE_MIDDLE) == true then
            if clicktoggle == true then
                local posx, posy = mousePanel2:CursorPos()
                local aimpos = LocalPlayer():GetAimVector()
                --print(aimpos)
                clicktoggle = false
            end
        else
            if clicktoggle == false then
                
                clicktoggle = true
            end
        end
        
        if input.IsMouseDown(MOUSE_RIGHT) == true then
            if toggle == true then
            disableMouseControls()
            toggle = false
            end
        else
            --
            if toggle == false then
                enableMouseControls()
                toggle = true
            end
        end
    end
    
    if LocalPlayer():Team() == 2 then
        disableMouseControls(LocalPlayer())
    end
    
end
hook.Add("Think", "pivotView", pivotView)

 
--[[
if thirdpersonCamera_Allowed == true then
    enableMouseControls()
    print("Thirdperson enabled")
else
    disableMouseControls()
end 
]]

usermessage.Hook("openMoveControls", enableMouseControls)

--==============================================================
-- CUSTOM THIRDPERSON CAM TEST


local function MyCalcView( ply, pos, angles, fov )
    if ScrollDist < 5 then
        ScrollDist = 5
        disableMouseControls(ply)
    end
    if ScrollDist > 275 then ScrollDist = 275 end
    
    if ScrollDist != 5 and LocalPlayer():Team() != 2 then
    
	local view = {}
   
	view.origin = pos + Vector(0,0,(ScrollDist))-( angles:Forward()*((ScrollDist * 4)) )
    local ViewPos = pos + Vector(0,0,(ScrollDist))-( angles:Forward()*((ScrollDist * 4)) )
    local ViewAng = (((ply:GetPos() + Vector(0,0,70)) - ViewPos)):GetNormalized():Angle()
    
    CamPos = ViewPos
    
	view.angles = ViewAng
	view.fov = fov
	view.drawviewer = true
    return view
    else
        local view = {}
        view.origin = pos
        view.angles = ViewAng
        view.fov = fov
        view.drawviewer = false
        return view
    end 
	
end

hook.Add( "CalcView", "MyCalcView", MyCalcView )