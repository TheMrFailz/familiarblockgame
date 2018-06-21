


surface.CreateFont( "ConvictSansChat", {
	font = "Comic Sans MS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 24,
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

local chatH = 200
local chatW = 400

chatBoxThing = {}


function QuickMenuButtons()
    --[[ Because I dont want to try and remake this in the hud file. ]]
    local client = LocalPlayer()
    local buttonFrame = vgui.Create("DFrame")
    buttonFrame:SetPos(0,0)
    buttonFrame:SetSize(650, 30)
    buttonFrame:SetDraggable(false)
    buttonFrame:ShowCloseButton(true)
    buttonFrame:SetTitle("")
    buttonFrame.Paint = function( self, w, h )
        
    end
    
    local buttonButton1 = vgui.Create( "DButton", buttonFrame ) 
    buttonButton1:SetText( "" )					
    buttonButton1:SetPos( 370, 0 )					
    buttonButton1:SetSize( 120, 30 )					
    buttonButton1.DoClick = function()				
        gui.OpenURL( "https://i.imgur.com/Xs4x8Bl.png" )			
    end
    buttonButton1.Paint = function(self, w, h)
        --draw.RoundedBox( 0, 0, 0, w, h, Color(255, 0, 0,200) )
    end
    
    

end

function ChatBoxSetup()
    local client = LocalPlayer()
    --GAMEMODE:CloseDermaMenus()
    chatBoxThing.dFrame = vgui.Create("DFrame")
    chatBoxThing.dTextEntry = vgui.Create("DTextEntry", chatBoxThing.dFrame)
    chatBoxThing.dRichText = vgui.Create("RichText", chatBoxThing.dFrame) 
    
    chatBoxThing.dTextEntry:SetFont("ConvictSansChat")
    chatBoxThing.dRichText:SetFontInternal("ConvictSansChat")
    
    chatBoxThing.dFrame:SetPos(20, 50)
    chatBoxThing.dFrame:SetSize(chatW,chatH)
    chatBoxThing.dFrame:SetDraggable(true)
    chatBoxThing.dFrame:ShowCloseButton(false)
    chatBoxThing.dFrame:SetTitle("")
    chatBoxThing.dFrame.Paint = function( self, w, h )
        
    end
    --chatBoxThing.dFrame:MakePopup()
    
    chatBoxThing.dRichText:SetPos(5, 10)
    chatBoxThing.dRichText:SetSize(chatW - 10, chatH - 10)

    chatBoxThing.dRichText:AppendText("Welcome to Familiar Block Game\n")
    function chatBoxThing.dRichText:PerformLayout()
        self:SetFontInternal("ConvictSansChat")
        self:SetFGColor( Color(255,255,255))
    end
    
    
    chatBoxThing.dTextEntry:SetPos(5,175)
    chatBoxThing.dTextEntry:SetSize(chatW - 10,20)
    chatBoxThing.dTextEntry:SetCursor("beam")
    chatBoxThing.dTextEntry.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color(214, 209, 209,50) )
        draw.SimpleText("> " .. self:GetValue(), "ConvictSans", 0, -5, Color(255,255,255,255), 0,0)
    end
    
    --chatBoxThing.dTextEntry:SetText("")
    
end

hook.Add("Initialize", "RobloxChatBox2", function()
    
    ChatBoxSetup()
    --QuickMenuButtons()
end)
    




concommand.Add("reload_chat", function( ply, cmd, args)
    --QuickMenuButtons()
    ChatBoxSetup()
end)


hook.Add( "OnPlayerChat", "myChat", function( player, strText, bTeamOnly, bPlayerIsDead ) 
	--local col = GAMEMODE:GetTeamColor( player ) -- Get the player's team color
    --chatBoxThing.dRichText:InsertColorChange(col)
    local col = team.GetColor(ply:Team())
    local r, g, b, a = col.r, col.g, col.b, col.a
    chatBoxThing.dRichText:InsertColorChange(r,g,b,a)
    chatBoxThing.dRichText:AppendText(player:GetName())
    chatBoxThing.dRichText:InsertColorChange(255,255,255,255)
    chatBoxThing.dRichText:AppendText(": " .. strText .. "\n")
    
    
end )

hook.Add( "ChatTextChanged", "myChat_Update", function( text )
	chatBoxThing.dTextEntry:SetText( text )
end)

--[[ hook.Remove("PlayerBindPress", "fbg_bindhack")
hook.Add("PlayerBindPress")

]]

hook.Add("StartChat", "WowThisIsFuckinDumb", function( team )

    return true end
)
