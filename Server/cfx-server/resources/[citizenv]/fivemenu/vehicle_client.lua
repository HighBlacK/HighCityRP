RegisterNetEvent("vehmenu:vehOG")
AddEventHandler("vehmenu:vehOG", function()
    VMenu.ResetMenu(25, "","default")
	VMenu.AddNum10(25, "Definir limite","speed", 30, 130, "Choisir la vitesse maximale")
	VMenu.AddFunc(25, "Limiter la vitesse", "vehmenu:setspeed", {getOpt("speed")}, "Appliquer la limite de vitesse")
end)

RegisterNetEvent("vehmenu:setspeed")
AddEventHandler("vehmenu:setspeed", function(speed)
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
	local speedlimit = speed
    SetEntityMaxSpeed(vehicle, speedlimit)
end)