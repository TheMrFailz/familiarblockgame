local buildPanel = vgui.Create("DFrame")
buildPanel:SetSize(ScrW(), ScrH())
buildPanel:SetPos(0,0)
buildPanel:SetAlpha(0)
buildPanel:SetWorldClicker(true)
buildPanel:ShowCloseButton(false)
buildPanel:SetDraggable(false)


--[[ Just a heads up this is basically gonna be a clone of the context menu meme

]]
--vgui.Register( "CoolBuildPanel", buildPanel, "EditablePanel")
function buildPanel:Init()
    -- I guess we setup our panel here? Really hacky shit imo.
    
    self:SetSize(ScrW(), ScrH())
    --self:Center()
    self:SetWorldClicker(true)
    
    
end

function buildPanel:Open()
    if (self:IsVisible()) then return end
    
    CloseDermaMenus()
    
    buildPanel:SetAlpha(0)
    
    self:MakePopup()
    self:SetVisible(true)
    self:SetKeyboardInputEnabled( false )
    self:SetMouseInputEnabled( true )
    
    RestoreCursorPosition()
    
    
    
end

function buildPanel:Close( bSkipAnim )


	RememberCursorPosition()

	CloseDermaMenus()

	self:SetKeyboardInputEnabled( false )
	self:SetMouseInputEnabled( false )

	self:SetAlpha( 255 )
	self:SetVisible( false )
	--self:RestoreControlPanel()

end

function enableBuildControls(ply)
    buildPanel:Open()




end

function disableBuildControls(ply)
    buildPanel:Close()




end

function disableScreenMouse(ply, key)
    if CLIENT then
        if ply:Team() == 2 then
        if key == 4 then
            disableBuildControls()
        end
        end
    end
end

hook.Add("KeyPress", "disableScreenMouse", disableScreenMouse)


function enableScreenMouse(ply, key)
    --print(key)
    if CLIENT then
        if ply:Team() == 2 then
        if key == 262144 then
            enableBuildControls()
            --print("yep")
        end
        end
    end
end

hook.Add("KeyPress", "enableScreenMouse", enableScreenMouse)


