include('shared.lua')

surface.CreateFont( "ticketMachine", {
	font = "Arial", 
	size = 16, 
	weight = 700, 
	blursize = 0, 
	scanlines = 0, 
	antialias = false, 
} )

function ENT:Draw()
    -- self.BaseClass.Draw(self) -- Overrides Draw
    self:DrawModel() -- Draws Model Client Side
	
	cam.Start3D2D( self:LocalToWorld(Vector( 15.5, 0, 22 )), self:GetAngles() + Angle( 0, 90, 90 ), 0.5 )
		draw.RoundedBox( 0, -38, 4, 80, 20, Color( 0, 0, 0, 255) )
		draw.DrawText("Bus Tickets", "ticketMachine", 0, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
		
		draw.RoundedBox( 0, -38, -143, 80, 20, Color( 0, 0, 0, 255) )
		draw.DrawText("$150 All Day", "ticketMachine", 0, -142, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end