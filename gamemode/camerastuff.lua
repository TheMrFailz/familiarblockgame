-- nanynay



--==============================================================
--[[ This controls the dank thirdperson cam. ]]

local thirdpersonCamera_Allowed = true
local mousePanel2 = vgui.Create("DFrame")
mousePanel2:SetSize(ScrW(), ScrH())
mousePanel2:SetPos(0,0)
mousePanel2:SetAlpha(0)
mousePanel2:SetWorldClicker(true)
mousePanel2:ShowCloseButton(true)
mousePanel2:SetDraggable(true)


--[[ Just a heads up this is basically gonna be a clone of the context menu meme

]]
--vgui.Register( "CoolmousePanel2", mousePanel2, "EditablePanel")
function mousePanel2:Init()
    -- I guess we setup our panel here? Really hacky shit imo.
    
    self:SetSize(ScrW(), ScrH())
    --self:Center()
    self:SetWorldClicker(false)
    
    
end

function mousePanel2:Open()
    if (self:IsVisible()) then return end
    
    CloseDermaMenus()
    
    mousePanel2:SetAlpha(0)
    
    self:MakePopup()
    self:SetVisible(true)
    self:SetKeyboardInputEnabled( false )
    self:SetMouseInputEnabled( true )
    
    RestoreCursorPosition()
    
    
    
end

function mousePanel2:Close( bSkipAnim )


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
        
        if input.IsMouseDown(MOUSE_LEFT) == true then
            if clicktoggle == true then
                local posx, posy = mousePanel2:CursorPos()
                local aimpos = LocalPlayer():GetAimVector()
                print(aimpos)
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
end
hook.Add("Think", "pivotView", pivotView)

 

if thirdpersonCamera_Allowed == true then
    enableMouseControls()
    print("Thirdperson enabled")
else
    disableMouseControls()
end 


usermessage.Hook("openMoveControls", enableMouseControls)
