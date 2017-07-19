function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent("repair:repairkit")
AddEventHandler("repair:repairkit", function()
    local pos = GetEntityCoords( GetPlayerPed(-1), 1 )
    local car = GetClosestVehicle( pos.x, pos.y, pos.z, 3.000, 0, 70)
	
	if DoesEntityExist(car) then
	   PlayScenario("world_human_vehicle_mechanic")
	   Wait(200)
	   TriggerEvent('InteractSound_CL:PlayOnOne', 'repair', 1.0)
	   Wait(10000)
	   TriggerEvent('InteractSound_CL:PlayOnOne', 'repair', 1.0)
	   Wait(10000)
	   SetVehicleFixed(car)
	   --SetVehicleEngineHealth(car, 1000.0)
       --SetVehicleBodyHealth( car, 800.0)
       SetVehicleEngineOn( car, true, false, true)
       DrawNotif("Le véhicule est ~g~réparé")
    else
	    DrawNotif("~r~Aucun véhicule à proximité")
        TriggerEvent("player:receiveItem", 53, 1)
    end
end)

function PlayScenario(param1)
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(GetPlayerPed(-1), param1, 0, 1)
		Citizen.Wait(20000)
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end)
end
