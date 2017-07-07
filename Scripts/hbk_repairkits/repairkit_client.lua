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
	   PlayScenario("world_human_vehicle_mechanic")                       ------REPAIR ANIMATION---ANIMATION DE REPARATION
	   TriggerEvent('InteractSound_CL:PlayOnOne', 'repair', 1.0)          ------IF YOU HAVE THE INTERACT SOUND SCRIPT-------SI VOUS AVEZ LE SCRIPT INTERACT SOUND
	   Wait(20000)                                                        ------TO SET HOW MANY TIME BEFORE THE VEHICLE IS FIXED----POUR DEFINIR COMBIEN DE TEMPS AVANT QUE LE VEHICULE SOIT REPARE
	   --SetVehicleFixed(car)                                             ------IF YOU WANT TO FIX EVERYTHING----SI VOUS VOULEZ TOUT REPARER (PAS CONSEILLE SI VOUS AVEZ UN JOB DE DEPANEUR SUR VOTRE SERVEUR)
	   --SetVehicleEngineHealth(car, 1000.0)                              ------IF YOU JUST WANT TO REPAIR THE ENGINE-----SI VOUS VOULEZ JUSTE REPARER LE MOTEUR          
       --SetVehicleBodyHealth( car, 1000.0)                               ------IF YOU JUST WANT TO REPAIR THE BODY------SI VOUS VOULEZ JUSTE REPARER LA CAROSSERIE
       SetVehicleEngineOn( car, true, false, true)
       DrawNotif("Le véhicule est ~g~réparé")                             ------THE VEHICLE IS FIXED TEXT
    else
	    DrawNotif("~r~Aucun véhicule à proximité")                        ------NO VEHICLE AT PROXIMITY TEXT
        TriggerEvent("player:receiveItem", REPAIRKIT ITEM ID, 1)          ------REPLACE "REPAIR KIT ITEM ID" BY YOUR REPAIR KIT ITEM ID ON YOUR DATABASE----REMPLACER LE REPAIRKIT ITEM ID PAR L'ID QUE VOUS AVEZ CHOISIS DANS VOTRE BASE DE DONNEE
    end
end)

function PlayScenario(param1) 
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(GetPlayerPed(-1), param1, 0, 1)
		Citizen.Wait(20000)                                               ------TO SET THE TIME OF THE ANNIMATION, I RECOMMAND TO SET THE SAME TIME AS THE PREVIOUS ONE----POUR DEFINIR LA DUREE DE L'ANNIMATION, JE RECOMMANDE DE DEFINIR LE MËME TEMPS QUE POUR LA PRECEDENTE
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end)
end