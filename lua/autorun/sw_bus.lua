AddCSLuaFile("autorun/sw_bus.lua")

local Category = "SligWolf's Vehicle's"

local V = { 	
				Name = "Bus", 
				Class = "prop_vehicle_jeep_old",
				Category = "SligWolf's Vehicle's",
			    busfrontlights = {
					Light1 = { Pos = Vector(-37,-120,35), Ang = Angle(20,90,0) } , 
					Light2 = { Pos = Vector(37,-120,35), Ang = Angle(20,90,0) } 
				},
				busbacklights = {
					Light3 = { Pos = Vector(-45,183,46), Ang = Angle(-90,0,0) } , 
					Light4 = { Pos = Vector(45,183,46), Ang = Angle(90,0,0) } 
				},
				BusDoors  = { 
					busdoors1 = { Pos = Vector(0,0,0), Ang = Angle(0,0,0) }
				},
				Author = "SligWolf",
				Information = "Bus made by SligWolf",
				Model = "models/sligwolf/bus/bus.mdl",
				
				SW_PassengersBusNew  = { passenger1 = { Pos = Vector(34,-46,35), Ang = Angle(0,0,0) },
								passenger2 = { Pos = Vector(34,92,35), Ang = Angle(0,0,0) },
								passenger3 = { Pos = Vector(-34,95,35), Ang = Angle(0,180,0) },
								passenger4 = { Pos = Vector(34,166,35), Ang = Angle(0,0,0) },
								passenger5 = { Pos = Vector(0,166,35), Ang = Angle(0,0,0) },
								passenger6 = { Pos = Vector(-34,-44,35), Ang = Angle(0,180,0) },
								passenger7 = { Pos = Vector(-34,166,35), Ang = Angle(0,0,0) }	},
				SeatType = "jeep_seat",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/sligwolf/sw_bus.txt"
							}
			}

list.Set( "Vehicles", "sw_bus", V )

local function SpawnBus(player, vehicle)

local localpos = vehicle:GetPos() 
local localang = vehicle:GetAngles()

if vehicle.VehicleTable then
	if vehicle.VehicleTable.SW_PassengersBusNew then
	vehicle.VehicleTable.SWBusLastHonkHorn = 0		
	vehicle.VehicleTable.SWBusDoorOpenClose = 0
		for swttpabusn,swttpbbusn in pairs(vehicle.VehicleTable.SW_PassengersBusNew) do
			local SeatPosTPBus = localpos + ( localang:Forward() * swttpbbusn.Pos.x) + ( localang:Right() * swttpbbusn.Pos.y) + ( localang:Up() * swttpbbusn.Pos.z)
			local SeatTPBus = ents.Create( "prop_vehicle_prisoner_pod" )
			SeatTPBus:SetModel( "models/nova/jeep_seat.mdl" )
			SeatTPBus:SetKeyValue( "vehiclescript" , "scripts/vehicles/prisoner_pod.txt" )
			SeatTPBus:SetAngles( localang + swttpbbusn.Ang )
			SeatTPBus:SetPos( SeatPosTPBus )
			SeatTPBus:SetMaterial("models/sligwolf/unique_props/nodraw")
				SeatTPBus:DrawShadow( false )
				SeatTPBus:Spawn()
				SeatTPBus:Activate()
			vehicle:DeleteOnRemove( SeatTPBus )
			SeatTPBus:SetParent(vehicle)
			SeatTPBus:SetCollisionGroup(20)
			end
		end
	end
	
if vehicle.VehicleTable then
	if vehicle.VehicleTable.busfrontlights then
		vehicle.busfrontlights = {}
		local Flights = vehicle.VehicleTable.busfrontlights
		local angles = vehicle:GetAngles()
		for sligwolfbusa,sligwolfbusb in pairs(Flights) do
		local pos = vehicle:GetPos() + ( angles:Forward() * sligwolfbusb.Pos.x ) + ( angles:Right() * sligwolfbusb.Pos.y ) + ( angles:Up() * sligwolfbusb.Pos.z )
			vehicle.busfrontlights[sligwolfbusa] = ents.Create( "gmod_lamp" )
					
			vehicle.busfrontlights[sligwolfbusa]:SetColor( Color( 255, 255, 255, 255 ) )
			vehicle.busfrontlights[sligwolfbusa]:SetFlashlightTexture( "effects/flashlight001" )
			vehicle.busfrontlights[sligwolfbusa]:SetLightFOV( 90 )
			vehicle.busfrontlights[sligwolfbusa]:SetDistance( 1024 )
			vehicle.busfrontlights[sligwolfbusa]:SetBrightness( 1 )
			vehicle.busfrontlights[sligwolfbusa]:SetToggle( 1 )
			vehicle.busfrontlights[sligwolfbusa]:UpdateLight()

			vehicle.busfrontlights[sligwolfbusa].NumDown = numpad.OnDown( player, "", "LampToggle", vehicle.busfrontlights[sligwolfbusa], 1 )
			vehicle.busfrontlights[sligwolfbusa].NumUp = numpad.OnUp( player, "", "LampToggle", vehicle.busfrontlights[sligwolfbusa], 0 )
					
			vehicle.busfrontlights[sligwolfbusa]:SetModel( "models/sligwolf/unique_props/placeholder001.mdl" )
			vehicle.busfrontlights[sligwolfbusa]:SetPos(pos)
			vehicle.busfrontlights[sligwolfbusa]:SetAngles( angles + sligwolfbusb.Ang )
			vehicle.busfrontlights[sligwolfbusa]:SetParent(vehicle)
			vehicle.busfrontlights[sligwolfbusa]:Spawn()
			vehicle.busfrontlights[sligwolfbusa]:DeleteOnRemove( vehicle )
		end
	end
	
	if vehicle.VehicleTable.busbacklights then
		vehicle.busbacklights = {}
		local Blights = vehicle.VehicleTable.busbacklights
		local angles = vehicle:GetAngles()
		for sligwolfbusc,sligwolfbusd in pairs(Blights) do
		local pos = vehicle:GetPos() + ( angles:Forward() * sligwolfbusd.Pos.x ) + ( angles:Right() * sligwolfbusd.Pos.y ) + ( angles:Up() * sligwolfbusd.Pos.z )
			vehicle.busbacklights[sligwolfbusc] = ents.Create( "gmod_light" )
			
			vehicle.busbacklights[sligwolfbusc]:SetMaterial("models/sligwolf/unique_props/nodraw")	
			
			vehicle.busbacklights[sligwolfbusc]:SetColor( Color( 255, 0, 0, 255 ) )
			vehicle.busbacklights[sligwolfbusc]:SetBrightness( 1 )
			vehicle.busbacklights[sligwolfbusc]:SetLightSize( 1 )
			vehicle.busbacklights[sligwolfbusc]:SetToggle( 1 )
			vehicle.busbacklights[sligwolfbusc].NumDown = numpad.OnDown( player, "", "LightToggle", vehicle.busbacklights[sligwolfbusc], 1 )
			vehicle.busbacklights[sligwolfbusc].NumUp = numpad.OnUp( player, "", "LightToggle", vehicle.busbacklights[sligwolfbusc], 0 )
			
			vehicle.busbacklights[sligwolfbusc]:SetPos(pos)
			vehicle.busbacklights[sligwolfbusc]:SetAngles( angles + sligwolfbusd.Ang )
			vehicle.busbacklights[sligwolfbusc]:SetParent(vehicle)
			vehicle.busbacklights[sligwolfbusc]:Spawn()
			vehicle.busbacklights[sligwolfbusc]:DeleteOnRemove( vehicle )
		
		end
	end
end

if vehicle.VehicleTable then
	if vehicle.VehicleTable.BusDoors then	
			
	vehicle.BusDoors = {}
	local swbusdoor = vehicle.VehicleTable.BusDoors
	local BusDoorsAngles = vehicle:GetAngles()
	for swbusdoorsA,swbusdoorsB in pairs(swbusdoor) do
	local BusDoorsPos = vehicle:GetPos() + ( BusDoorsAngles:Forward() * swbusdoorsB.Pos.x ) + ( BusDoorsAngles:Right() * swbusdoorsB.Pos.y ) + ( BusDoorsAngles:Up() * swbusdoorsB.Pos.z )
		vehicle.BusDoors[swbusdoorsA] = ents.Create( "prop_physics" )
		vehicle.BusDoors[swbusdoorsA]:SetModel( "models/sligwolf/bus/bus_doors.mdl" )
		vehicle.BusDoors[swbusdoorsA]:SetPos( BusDoorsPos )
		vehicle.BusDoors[swbusdoorsA]:SetAngles( BusDoorsAngles + swbusdoorsB.Ang )
		vehicle.BusDoors[swbusdoorsA]:DrawShadow( false )
		vehicle.BusDoors[swbusdoorsA]:Spawn()
		vehicle.BusDoors[swbusdoorsA]:SetSolid(6)
		vehicle.BusDoors[swbusdoorsA]:SetParent(vehicle)
		vehicle:DeleteOnRemove( vehicle.BusDoors[swbusdoorsA] )
	end
	end
end

end

if SERVER then

local function BusLight( player,key )
    if ( not player ) or ( not IsValid( player ) ) then return end
    local vehicle = player:GetVehicle()
    if not IsValid( vehicle ) then return end
    if not ( vehicle.VehicleTable && vehicle.VehicleTable.busfrontlights  && vehicle.VehicleTable.busbacklights && vehicle.VehicleTable.BusDoors) then return end
	if not ( vehicle.busfrontlights && vehicle.busbacklights && vehicle.BusDoors) then return end
		for sligwolfbusa,sligwolfbusb in pairs(vehicle.busfrontlights) do
			local LastHorn = vehicle.VehicleTable.SWBusLastHonkHorn
			if (LastHorn + 1.5) <= CurTime() then
				vehicle.VehicleTable.SWBusLastHonkHorn = CurTime()
				if ( player:KeyPressed( IN_ATTACK ) ) && player:InVehicle() then
				vehicle:EmitSound("vehicles/sligwolf/bus/bus_horn.wav", 100, 100)  
				end
			end
		end
		for sligwolfbusa,sligwolfbusb in pairs(vehicle.busfrontlights) do
			if ( player:KeyPressed( IN_WALK ) ) && player:InVehicle() then
			sligwolfbusb:Toggle()
			vehicle:EmitSound("items/flashlight1.wav", 100, 100)  
			end
		end
		for sligwolfbusc,sligwolfbusd in pairs(vehicle.busbacklights) do
			if ( player:KeyPressed( IN_WALK ) ) && player:InVehicle() then
			sligwolfbusd:Toggle() 
			end
		end	
		for swbusdoorsA,swbusdoorsB in pairs(vehicle.BusDoors) do
		if vehicle.VehicleTable.SWBusDoorOpenClose == 0 then
			for _, CloseDoor in pairs(ents.FindByModel("models/sligwolf/bus/bus_doors.mdl")) do
				if vehicle:GetPos():Distance( CloseDoor:GetPos() ) <= 5 then
					if ( player:KeyPressed( IN_RELOAD ) ) && player:InVehicle() then
						local sequence = CloseDoor:LookupSequence("close")
						CloseDoor:ResetSequence(sequence)
						CloseDoor:SetSolid(0)
						vehicle:EmitSound("vehicles/sligwolf/bus/bus_door.wav", 100, 100)
						timer.Simple(0.25,function() 
							if ( !vehicle:IsValid()) then return end
								for swbusdoorsA,swbusdoorsB in pairs(vehicle.BusDoors) do
									vehicle.VehicleTable.SWBusDoorOpenClose = 1
								end
							end)
					end
				end
			end
		end
			
			for _, OpenDoor in pairs(ents.FindByModel("models/sligwolf/bus/bus_doors.mdl")) do
			if vehicle.VehicleTable.SWBusDoorOpenClose == 1 then
				if vehicle:GetPos():Distance( OpenDoor:GetPos() ) <= 5 then
					if ( player:KeyPressed( IN_RELOAD ) ) && player:InVehicle() then
						local sequence = OpenDoor:LookupSequence("open")
						OpenDoor:ResetSequence(sequence)
						OpenDoor:SetSolid(6)
						vehicle:EmitSound("vehicles/sligwolf/bus/bus_door.wav", 100, 100)
						timer.Simple(0.25,function() 
							if ( !vehicle:IsValid()) then return end
								for swbusdoorsA,swbusdoorsB in pairs(vehicle.BusDoors) do
									vehicle.VehicleTable.SWBusDoorOpenClose = 0
								end
							end)
						local mins = vehicle:LocalToWorld( vehicle:OBBMins() + Vector( 80, 80, 80 ) )
						local maxs = vehicle:LocalToWorld( vehicle:OBBMaxs() - Vector( 80, 80, 80 ) )
						for k,v in pairs( ents.FindInBox( mins, maxs ) ) do
							if v:IsPlayer() and not table.HasValue( hasTicket, v ) and not table.HasValue( ticketConfig.excludedJobs, team.GetName(v:Team()) ) then
								v:wanted( v, "Evading bus fares" )
							end
						end
					end
				end
			end
			end
		end
end
hook.Add( "KeyPress", "BusLight", BusLight )
end

hook.Add( "PlayerSpawnedVehicle", "SpawnBus", SpawnBus )