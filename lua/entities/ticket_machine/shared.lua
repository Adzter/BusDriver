ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Ticket Machine"
ENT.Author= "Adzter"
ENT.Contact= "http://steamcommunity.com/id/imadzter"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false

ticketConfig = {}

-- You should only really edit the values below
-- here unless you know what you're doing

ticketConfig.job = TEAM_BUS
ticketConfig.price = 150
ticketConfig.paycheck = "You received a ticket sale of: " -- note the price is automatically added on the end
ticketConfig.currency = "$"	-- currency shown in the above message
ticketConfig.success = "All day ticket purchased"
ticketConfig.already = "You already own a ticket"
ticketConfig.cannotAfford = "You cannot afford a ticket"
ticketConfig.noTicket = "You do not own a ticket"