function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

Citizen.CreateThread(function() 
    while true do              
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            local lock = GetVehicleDoorLockStatus(veh)

            if lock == 7 then
                SetVehicleDoorsLocked(veh, 2)
            end
                 
            local pedd = GetPedInVehicleSeat(veh, -1)

            if pedd then                   
                SetPedCanBeDraggedOut(pedd, false)
            end             
        end   
        Citizen.Wait(0)	    							
    end
end)

RegisterNetEvent("lockpick:uselockpick")
AddEventHandler("lockpick:uselockpick", function()
    local pos = GetEntityCoords(GetPlayerPed(-1), 1)
    local randomalarm = math.random(0, 100)
    local vehicle = GetClosestVehicle( pos.x, pos.y, pos.z, 3.000, 0, 70)
	local lockstatus = GetVehicleDoorLockStatus(vehicle)
	
	if DoesEntityExist(vehicle) then
	    if lockstatus => 2 then
	        if randomalarm =< 50 then
			    Citizen.CreateThread(function()
	    		    TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)		
	    	        TriggerEvent('InteractSound_CL:PlayOnOne', 'lockpick', 1.0)
	                Citizen.Wait(30000)
	                TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
		    		SetVehicleDoorsLocked(vehicle, 1)
		    		DrawNotif("Le véhicule est dévérouillé")
				end)
	    	else
			    Citizen.CreateThread(function()
			        TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_player", 8.0, 0.0, -1, 1, 0, 0, 0, 0)		
			        SetVehicleAlarm(vehicle, true)
    	    	    StartVehicleAlarm(vehicle)
    		        DrawNotif("~r~Attention, la police à été prévenue")
		    	    TriggerEvent('InteractSound_CL:PlayOnOne', 'lockpick', 1.0)
	                Citizen.Wait(30000)
	                TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 1.0)
		    		SetVehicleDoorsLocked(vehicle, 1)
			    	SetVehicleAlarm(vehicle, false)
			    	DrawNotif("Le véhicule est dévérouillé")
				end)
            end				
    	else
            DrawNotif("~r~Le véhicule est déja déverrouillé")
			TriggerEvent("player:receiveItem", 88, 1)
     	end
	else
	    DrawNotif("~r~Aucun véhicle à proximité")
		TriggerEvent("player:receiveItem", 88, 1)
    end
end)