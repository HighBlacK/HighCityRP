function GetVehHealthPercent()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehiclehealth = GetEntityHealth(vehicle) - 100
	local maxhealth = GetEntityMaxHealth(vehicle) - 100
	local procentage = (vehiclehealth / maxhealth) * 100
	return procentage
end

function GetEngineHealthPercent()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehiclehealth = GetVehicleEngineHealth(vehicle) - 100
	local maxhealth = 1000.0 - 100
	local procentage = (vehiclehealth / maxhealth) * 100
	return procentage
end


function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end



Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsUsing(ped)
		local damage = GetEngineHealthPercent(vehicle)
		if IsPedInAnyVehicle(ped, false) then
			SetPlayerVehicleDamageModifier(PlayerId(), 100) -- Seems to not work at the moment --
			if damage < 85 then
				SetVehicleUndriveable(vehicle, true)
				ShowNotification("Le moteur du véhicule est ~r~trop endommagé.")
				--ShowNotification("~r~Le véhicule est trop endommagé.")
			else
			    SetVehicleUndriveable(vehicle, false)
			end
		end
	end
end)


Citizen.CreateThread(function()

	while true do

		Citizen.Wait(0)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			playerCar = GetVehiclePedIsIn(playerPed, false)
			if playerCar and GetPedInVehicleSeat(playerCar, -1) == playerPed then
				Citizen.Wait(200)
		
				if GetVehicleEngineHealth(playerCar) < 950 then --max 1000 min 0
				   SetVehicleUndriveable(playerCar, 1)
				   ShowNotification("Le moteur du véhicule est ~r~trop endommagé.")
				end
			end
		end

	end
end)
