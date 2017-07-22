local money = 0
local carJob = false

function LocalPed()
	return GetPlayerPed(-1)
end

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function deleteCar(car)
  SetEntityAsMissionEntity(car, true, true)
  Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( car ))
  Citizen.InvokeNative( 0xB736A491E64A32CF, Citizen.PointerValueIntInitialized( car ))
  Citizen.InvokeNative( 0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized( car ))
end

local ShowMsgtime = { msg = "", time = 0 }
local myjob = 0

RegisterNetEvent("farm:getJobs")
AddEventHandler("farm:getJobs", function(job)
  myjob = job
end)

local plate = ""

RegisterNetEvent("org:f_plate")
AddEventHandler('org:f_plate', function(plaque)
  plate = plaque
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxt(ShowMsgtime.msg, 1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)
 
Citizen.CreateThread(function()
    while true do
	    Citizen.Wait(1)
        DrawMarker(1,2236.92,5164.83,57.735,0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 255, 0, 200, 0, 0, 0, 0)
	    if GetDistanceBetweenCoords(2236.92,5164.83,58.735,GetEntityCoords(LocalPed())) < 3 then
		    if IsInVehicle() == false then
                ShowInfo('Appuyer sur ~INPUT_CONTEXT~ pour sortir votre ~b~véhicule de travail',0)
     		    if IsControlJustPressed(1,38) then
				    local carblock = GetClosestVehicle(2230.29, 5177.94, 60.0048, 3.000, 0, 70)
		            if not DoesEntityExist(carblock) then
		                TriggerServerEvent("poleemploi:getjobs")
                        Wait(100)
                        if myjob == 14 then
                            local car = 2132890591
	    	                RequestModel(car)
                            while not HasModelLoaded(car) do
                            Wait(1)
                            end
             		        TriggerEvent("vmenu:JobOutfit", 19, 109)
                            vehicle = CreateVehicle(car, 2230.29, 5177.94, 60.0048, 0.0, true, false)
                            SetVehicleOnGroundProperly(vehicle)
        			        TriggerServerEvent("farm:plate")
         			        Wait(100)
             			    SetVehicleNumberPlateText(vehicle, plate)
    	        		    Wait(100)
             		        SetVehicleHasBeenOwnedByPlayer(vehicle,true)
                            SetVehRadioStation(vehicle, "OFF")
                            SetVehicleColours(vehicle, 53, 53)
                            SetVehicleLivery(vehicle, 4)
                            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                            SetVehicleEngineOn(vehicle, true, false, false)
                            SetEntityAsMissionEntity(vehicle, true, true)
                            Wait(100)
                            Citizen.Wait(1)
		    	            AfficherBlip()
	                    else
                            DrawNotif('~r~Vous devez être fermier')
		                end		
                    else
                        DrawNotif('~r~La zone est encombrée')
                    end
		        end
            else
	            if GetDistanceBetweenCoords(2236.92,5164.83,58.735,GetEntityCoords(LocalPed())) < 1 then
                    ShowInfo('Appuyer sur ~INPUT_CONTEXT~ pour rentrer votre ~b~véhicule de travail',0)
        		    if IsControlJustPressed(1,38) then
	    			    local ped = GetPlayerPed(-1)
    				    local jobveh = GetVehiclePedIsUsing(ped)
    		            if DoesEntityExist(jobveh) then
                            deleteCar(jobveh)
                            DrawNotif('Le véhicule est ~g~rentré')						
	                    end
					end	
                end
		    end
        end			
    end
end)