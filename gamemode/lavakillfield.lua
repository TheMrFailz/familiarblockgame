local spawnPointMat = Material( "bricks/fbg_lava" )
local spawnPointSize = 10000
function lavaDraw()
    
 
    cam.Start3D2D(Vector(4100,4100,96), Angle(0,0,0), 1)
        surface.SetDrawColor(0,0,255,255)
        surface.SetMaterial(spawnPointMat)
        surface.DrawTexturedRect(0,0,spawnPointSize,spawnPointSize)
        
    
    cam.End3D2D()
    
end

hook.Add("PostDrawOpaqueRenderables", "CoolLavaThing", lavaDraw())