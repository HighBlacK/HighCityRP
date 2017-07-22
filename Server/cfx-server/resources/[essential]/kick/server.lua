RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	DropPlayer(source, "Vous avez été AFK pendant trop longtemps.")
end)

pingLimit = 400

RegisterServerEvent("checkMyPingBro")
AddEventHandler("checkMyPingBro", function()
	ping = GetPlayerPing(source)
	if ping >= pingLimit then
		DropPlayer(source, "Votre ping est trop haut (Limite: " .. pingLimit .. " Votre Ping: " .. ping .. ")")
	end
end)