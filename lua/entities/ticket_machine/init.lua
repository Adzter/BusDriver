AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
--Initialise an empty table to hold the ticket holders
--Note that it's global incase there's multiple ticket machines 
hasTicket = {} 

function ENT:Initialize()
 
	self:SetModel( "models/props/cs_assault/ticketmachine.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	-- disable the movement of the entity
	self:SetMoveType( MOVETYPE_NONE )
	
	self:SetUseType( SIMPLE_USE )
	
end
 
function ENT:Use( activator, caller )
	-- Check if the player already has a ticket
	if table.HasValue( hasTicket, activator ) then 
		DarkRP.notify( activator, 1, 10, ticketConfig.already )
		return
	end
	
	--Check if the player can afford a ticket
	if not activator:canAfford( ticketConfig.price ) then
		DarkRP.notify( activator, 1, 10, ticketConfig.cannotAfford )
		return
	end
	
	-- Add the player into the table
	table.insert( hasTicket, activator )
	-- Take the money from the player
	activator:addMoney ( -ticketConfig.price )
	-- Let them know that their purchase was sucessful
	DarkRP.notify( activator, 0, 10, ticketConfig.success )
	
	-- If there's currently a bus driver on then give them the profit
	-- and if there's more than one, split the profits, first check
	-- if there's actually a bus driver though
	
	if #team.GetPlayers( ticketConfig.job ) > 0 then
		local paycheck = math.floor( ticketConfig.price / #team.GetPlayers( ticketConfig.job ))
		-- The paycheck per person is the price of the ticket divided by the players
		-- rounded down to prevent any rounding up exploits
		
		for k,v in pairs( team.GetPlayers( ticketConfig.job ) ) do
			v:addMoney ( paycheck )
			DarkRP.notify( v, 0, 10, ticketConfig.paycheck .. ticketConfig.currency .. paycheck )
		end
	end
end
 
hook.Add( "PlayerDisconnected", "ticketMachineDisconnect", function( ply )
	-- When the player disconnects, check to see if they have a ticket, if they do
	-- then remove them from the table, we don't want the table getting huge and slow
	if table.HasValue( hasTicket, ply ) then
		table.RemoveByValue( hasTicket, ply )
	end
end)

-- Whenever a player tries to enter a vehicle, check to see if it's one
-- of the seats of the bus, if it is then check to see if they've got a
-- ticket, return false if they don't have one.
local cooldown = CurTime()
function checkTicket( ply, ent )
	if ent:GetClass() == "prop_vehicle_prisoner_pod" and ent:GetMaterial() == "models/sligwolf/unique_props/nodraw" then
	    if CurTime() > cooldown then
			if table.HasValue( hasTicket, ply ) then
				return true
			else
				cooldown = CurTime() + 1
				DarkRP.notify( ply, 1, 10, ticketConfig.noTicket )
				return false
			end
		else
			return false
		end
	end
end
hook.Add( "PlayerUse", "checkTicket", checkTicket )

function ENT:Think()
end

