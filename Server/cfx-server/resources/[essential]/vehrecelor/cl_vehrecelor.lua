RegisterNetEvent('garages:SelVehicle')

local vehrecelor = {-467.938, -1676.24, 19.0532}

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DisplayHelp(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

Citizen.CreateThread(function()
	local loc = vehrecelor
	pos = vehrecelor
	 local blip = AddBlipForCoord(-467.938, -1676.24, 19.0532)
	 SetBlipSprite(blip,207)
	 SetBlipColour(blip, 2)
	 BeginTextCommandSetBlipName("STRING")
	 AddTextComponentString("Receleur")
	 EndTextCommandSetBlipName(blip)
	 SetBlipAsShortRange(blip,true)
	 SetBlipAsMissionCreatorBlip(blip,true)
	checkgarage = 0
	while true do
		Wait(0)
		DrawMarker(1,vehrecelor[1],vehrecelor[2],vehrecelor[3],0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(vehrecelor[1],vehrecelor[2],vehrecelor[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour ~r~vendre le véhicule volé à 50% du prix d\'achat", false)
			if IsControlJustPressed(1, 86) then
				local caissei = GetClosestVehicle(vehrecelor[1],vehrecelor[2],vehrecelor[3], 3.000, 0, 70)
				SetEntityAsMissionEntity(caissei, true, true)
				local platecaissei = GetVehicleNumberPlateText(caissei)
				if DoesEntityExist(caissei) then
				else
					drawNotification("Aucun véhicule présent")
				end
			end
		end
	end
end)

AddEventHandler('garages:SelVehicle', function(vehicle, plate)
    local car = GetHashKey(vehicle)
    local plate = plate
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        local caissei = GetClosestVehicle(vehrecelor[1],vehrecelor[2],vehrecelor[3], 3.000, 0, 70)
        SetEntityAsMissionEntity(caissei, true, true)
        local platecaissei = GetVehicleNumberPlateText(caissei)
        if DoesEntityExist(caissei) then
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(caissei))
            TriggerServerEvent('garages:SelVeh', platecaissei, vehicle)
            end
        else
            drawNotification("~r~Aucun véhicule présent")
        end
    end)
end)
