--[[Register]]--

RegisterNetEvent("ply_autoecole:GetLicences")
--RegisterNetEvent("ply_autoecole:StartPermisTrue")
RegisterNetEvent("ply_autoecole:StartPermisVoitureTrue")
RegisterNetEvent("ply_autoecole:StartPermisMotoTrue")
RegisterNetEvent("ply_autoecole:StartPermisVeloTrue")
RegisterNetEvent("ply_autoecole:StartPermisPoidslourdTrue")
RegisterNetEvent("ply_autoecole:StartPermisHeliTrue")
RegisterNetEvent("ply_autoecole:StartPermisBoatTrue")
RegisterNetEvent("ply_autoecole:StartPermisFalse")




--[[Local/Global]]--

permis = {}
local autoecole_location = {-1193.31, -1492.55, 3.279}
local epreuve = false
local ventenamefr = "~r~Auto/Moto Ecole"
local ventenameen = "Auto/Moto Drive test"
local ArgentJoueur = 0


--[[Functions]]--


function configLang(lang)
	local lang = lang
	if lang == "FR" then
		lang_string = {
			menu1 = "Auto/Moto Ecole",
			menu2 = "Fermer",
			menu3 = "Appuyer sur ~g~E~s~ pour ouvrir le menu",
			menu4 = "Ce permis est déjà obtenu",
			menu5 = "La zone est encombrée",
			menu6 = "Début de l'épreuve, rendez-vous à destination",
			menu7 = "Appuyer sur ~g~E~s~ pour terminer l'épreuve",
			menu8 = "Epreuve raté, le véhicule est trop endommagé",
			menu9 = "Epreuve réussie",
			menu10 = "Ce n'est pas le bon vehicule"
	}

	elseif lang == "EN" then
		lang_string = {
			menu1 = "Auto/Moto Drive test",
			menu2 = "Close",
			menu3 = "~g~E~s~ to open menu",
			menu4 = "This license is already obtained",
			menu5 = "The area is crowded",
			menu6 = "Start of the test, go to destination",
			menu7 = "E to complete the test",
			menu8 = "Test failed, the vehicle is too damaged",
			menu9 = "Test successful",
			menu10 = "This is not the right vehicle"
	}
	end
end

function MenuAutoecole()
    ped = GetPlayerPed(-1);
    MenuTitle = lang_string.menu1
	CloseMenu()
    for ind, value in pairs(permis) do
		Menu.addButton(tostring(value.name), "SetPermis", value.id)
    end
    Menu.addButton(lang_string.menu2,"CloseMenu",nil) 
end

function SetPermis(permis_id)
	local permis_id = permis_id
	TriggerServerEvent('ply_autoecole:CheckForPermis', permis_id)	
	CloseMenu()
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true
    TriggerServerEvent("ply_autoecole:GetLicences")
end

function LocalPed()
	return GetPlayerPed(-1)
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

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

function GetVehHealthPercent(vehicle)
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehiclehealth = GetEntityHealth(vehicle) - 100
	local maxhealth = GetEntityMaxHealth(vehicle) - 100
	local procentage = (vehiclehealth / maxhealth) * 100
	return procentage
end

function DisplayHelp(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

--[[Citizen]]--

Citizen.CreateThread(function()
	local pos = autoecole_location
	local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
	SetBlipSprite(blip,198)
	SetBlipColour(blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(ventenamefr)
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
	while true do
		Wait(0)
		--DrawMarker(1,autoecole_location[1],autoecole_location[2],autoecole_location[3],0,0,0,0,0,0,4.001,4.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(autoecole_location[1],autoecole_location[2],autoecole_location[3],GetEntityCoords(LocalPed())) < 5 and IsPedInAnyVehicle(LocalPed(), true) == false then
			--drawTxt(lang_string.menu3,0,1,0.5,0.8,0.6,255,255,255,255)		
			if IsControlJustPressed(1, 86) then
				--MenuAutoecole()
				--Menu.hidden = not Menu.hidden
			end
			--Menu.renderGUI()
		end
	end
end)



--[[Events]]--
ArgentJoueur = 0

RegisterNetEvent("ply_autoecole:f_getCash")
AddEventHandler("ply_autoecole:f_getCash", function(argent)
  ArgentJoueur = argent
end)

AddEventHandler("playerSpawned", function()
    local lang = "FR"
    configLang(lang)
    TriggerServerEvent("ply_autoecole:GetLicences")
end)

AddEventHandler("ply_autoecole:GetLicences", function(thepermis)
    permis = {}
    permis = thepermis
end)

AddEventHandler("ply_autoecole:StartPermisFalse", function()
	drawNotification("Ce permis est déjà obtenu")
end)

AddEventHandler("ply_autoecole:StartPermisVoitureTrue", function()
	local permis_id = 1
	--local permis_name = name
	local permis_vehicle = 0xF8DE29A8  ---344943009
	local permis_end_x = 141.180
	local permis_end_y = 6634.790
	local permis_end_z = 31.636
	local permis_plate ="AUTOTEST"
	local permisv = true
	
	Citizen.CreateThread(function()
	 	Citizen.Wait(0)
 		local pos = autoecole_location
 		local caisseo = GetClosestVehicle(autoecole_location[1], autoecole_location[2], autoecole_location[3], 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("~r~La zone est encombrée")		
		else
		    RequestModel(permis_vehicle)
		    while not HasModelLoaded(permis_vehicle) do
		    Citizen.Wait(0)
			drawTxt("Chargement...",1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
		    end
		    veh = CreateVehicle(permis_vehicle, autoecole_location[1], autoecole_location[2], autoecole_location[3], 215.0, true, false)
		    SetVehicleNumberPlateText(veh, permis_plate)
		    SetVehicleOnGroundProperly(veh)
		    SetVehicleHasBeenOwnedByPlayer(veh,true)
		    local id = NetworkGetNetworkIdFromEntity(veh)
		    SetNetworkIdCanMigrate(id, true)
		    SetVehicleColours(veh, primarycolor, secondarycolor)
		    SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
		    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		    SetEntityInvincible(veh, false)
		    drawNotification("Début de l'épreuve, rendez-vous à destination en respectant le code de la route")		   
		end		
	end)

	local epreuve = true

	blipermis = AddBlipForCoord(permis_end_x,permis_end_y,permis_end_z)
	Citizen.CreateThread(function()		
		Wait(0)
        SetBlipSprite(blipermis, 1)
        SetBlipColour(blipermis, 2)
        SetBlipAsMissionCreatorBlip(blipermis,true)
        SetBlipRoute(blipermis, true)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if GetDistanceBetweenCoords(permis_end_x,permis_end_y,permis_end_z,GetEntityCoords(LocalPed())) < 3 and epreuve then
				DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour terminer l'épreuve", false)
				--drawTxt("Appuyer sur ~g~E~s~ pour terminer l'épreuve",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					local ped = GetPlayerPed(-1)
					local vehicle = GetVehiclePedIsUsing(ped)
					SetEntityAsMissionEntity(vehicle, true, true)
					local vehplate = GetVehicleNumberPlateText(vehicle)					
					if vehplate == permis_plate then
						local vehiclehealth = GetEntityHealth(vehicle) - 100
						local maxhealth = GetEntityMaxHealth(vehicle) - 100
						local damage = (vehiclehealth / maxhealth) * 100
						if damage <= 95 then							
							drawNotification("~r~Epreuve ratée, le véhicule est trop endommagé")							
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						else							
							drawNotification("~g~Epreuve réussie")
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							TriggerServerEvent("ply_autoecole:Userlicencev", permisv)
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						end
					else
						drawNotification("~r~Ce n'est pas le bon vehicule")
					end
				end
			end
		end
	end)
end)

AddEventHandler("ply_autoecole:StartPermisMotoTrue", function()
	local permis_id = 2
	--local permis_name = name
	local permis_vehicle = 1672195559
	local permis_end_x = 646.875
	local permis_end_y = 584.900
	local permis_end_z = 128.911
	local permis_plate ="AUTOTEST"
	local permism = true
	local epreuve = false
	
	Citizen.CreateThread(function()
	 	Citizen.Wait(0)
 		local pos = autoecole_location
 		local caisseo = GetClosestVehicle(autoecole_location[1], autoecole_location[2], autoecole_location[3], 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("~r~La zone est encombrée")		
		else
		    TriggerServerEvent("ply_autoecole:getCash_s")
            Wait(200)
			if ArgentJoueur >= 5000 then
	    	    RequestModel(permis_vehicle)
		        while not HasModelLoaded(permis_vehicle) do
	    	    Citizen.Wait(0)
	    		drawTxt("Chargement...",1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
		        end
	    	    veh = CreateVehicle(permis_vehicle, autoecole_location[1], autoecole_location[2], autoecole_location[3], 215.0, true, false)
	    	    SetVehicleNumberPlateText(veh, permis_plate)
	    	    SetVehicleOnGroundProperly(veh)
	    	    SetVehicleHasBeenOwnedByPlayer(veh,true)
	    	    local id = NetworkGetNetworkIdFromEntity(veh)
	    	    SetNetworkIdCanMigrate(id, true)
	    	    SetVehicleColours(veh, primarycolor, secondarycolor)
	    	    SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
	    	    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
	    	    SetEntityInvincible(veh, false)
	    	    drawNotification("Début de l'épreuve, rendez-vous à destination en respectant le code de la route")		
                TriggerServerEvent("ply_autoecole:moneyupdate", -5000)
				blipermis = AddBlipForCoord(permis_end_x,permis_end_y,permis_end_z)
	            Citizen.CreateThread(function()		
	         	    Wait(0)
                    SetBlipSprite(blipermis, 1)
                    SetBlipColour(blipermis, 2)
                    SetBlipAsMissionCreatorBlip(blipermis,true)
                    SetBlipRoute(blipermis, true)
	            end)
				epreuve = true
			else
			    drawNotification("~r~Vous n'avez pas assez d'argent")
				epreuve = false
            end				
		end		
	end)

	
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if GetDistanceBetweenCoords(permis_end_x,permis_end_y,permis_end_z,GetEntityCoords(LocalPed())) < 3 and epreuve then
				DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour terminer l'épreuve", false)
				--drawTxt("Appuyer sur ~g~E~s~ pour terminer l'épreuve",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					local ped = GetPlayerPed(-1)
					local vehicle = GetVehiclePedIsUsing(ped)
					SetEntityAsMissionEntity(vehicle, true, true)
					local vehplate = GetVehicleNumberPlateText(vehicle)					
					if vehplate == permis_plate then
						local vehiclehealth = GetEntityHealth(vehicle) - 100
						local maxhealth = GetEntityMaxHealth(vehicle) - 100
						local damage = (vehiclehealth / maxhealth) * 100
						if damage <= 95 then							
							drawNotification("~r~Epreuve ratée, le véhicule est trop endommagé")							
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						else							
							drawNotification("~g~Epreuve réussie, ~n~~w~L'Etat vous rembouse la moitiée de la somme engagée")
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							TriggerServerEvent("ply_autoecole:Userlicencem", permism)
							TriggerServerEvent("ply_autoecole:moneyupdate", 2500)	
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						end
					else
						drawNotification("~r~Ce n'est pas le bon vehicule")
					end
				end
			end
		end
	end)
end)

AddEventHandler("ply_autoecole:StartPermisVeloTrue", function()
	local permis_id = 3
	--local permis_name = name
	local permis_vehicle = -836512833
	local permis_end_x = -2316.720
	local permis_end_y = 428.935
	local permis_end_z = 174.467
	local permis_plate ="AUTOTEST"
	local permisvel = true
	
	Citizen.CreateThread(function()
	 	Citizen.Wait(0)
 		local pos = autoecole_location
 		local caisseo = GetClosestVehicle(autoecole_location[1], autoecole_location[2], autoecole_location[3], 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("~r~La zone est encombrée")		
		else
		    RequestModel(permis_vehicle)
		    while not HasModelLoaded(permis_vehicle) do
		    Citizen.Wait(0)
			drawTxt("Chargement...",1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
		    end
		    veh = CreateVehicle(permis_vehicle, autoecole_location[1], autoecole_location[2], autoecole_location[3], 215.0, true, false)
		    SetVehicleNumberPlateText(veh, permis_plate)
		    SetVehicleOnGroundProperly(veh)
		    SetVehicleHasBeenOwnedByPlayer(veh,true)
		    local id = NetworkGetNetworkIdFromEntity(veh)
		    SetNetworkIdCanMigrate(id, true)
		    SetVehicleColours(veh, primarycolor, secondarycolor)
		    SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
		    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		    SetEntityInvincible(veh, false)
		    drawNotification("Début de l'épreuve, rendez-vous à destination en respectant le code de la route")		   
		end		
	end)

	local epreuve = true

	blipermis = AddBlipForCoord(permis_end_x,permis_end_y,permis_end_z)
	Citizen.CreateThread(function()		
		Wait(0)
        SetBlipSprite(blipermis, 1)
        SetBlipColour(blipermis, 2)
        SetBlipAsMissionCreatorBlip(blipermis,true)
        SetBlipRoute(blipermis, true)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if GetDistanceBetweenCoords(permis_end_x,permis_end_y,permis_end_z,GetEntityCoords(LocalPed())) < 3 and epreuve then
				DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour terminer l'épreuve", false)
				--drawTxt("Appuyer sur ~g~E~s~ pour terminer l'épreuve",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					local ped = GetPlayerPed(-1)
					local vehicle = GetVehiclePedIsUsing(ped)
					SetEntityAsMissionEntity(vehicle, true, true)
					local vehplate = GetVehicleNumberPlateText(vehicle)					
					if vehplate == permis_plate then
						local vehiclehealth = GetEntityHealth(vehicle) - 100
						local maxhealth = GetEntityMaxHealth(vehicle) - 100
						local damage = (vehiclehealth / maxhealth) * 100
						if damage <= 95 then							
							drawNotification("~r~Epreuve ratée, le véhicule est trop endommagé")							
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						else							
							drawNotification("~g~Epreuve réussie")
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							TriggerServerEvent("ply_autoecole:Userlicencevel", permisvel)
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						end
					else
						drawNotification("~r~Ce n'est pas le bon vehicule")
					end
				end
			end
		end
	end)
end)

AddEventHandler("ply_autoecole:StartPermisPoidslourdTrue", function()
	local permis_id = 4
	--local permis_name = name
	local permis_vehicle = 2112052861
	local permis_end_x = 1268.240
	local permis_end_y = -3186.820
	local permis_end_z = 5.903
	local permis_plate ="AUTOTEST"
	local permisc = true
	local epreuve = false
	
	Citizen.CreateThread(function()
	 	Citizen.Wait(0)
 		local pos = autoecole_location
 		local caisseo = GetClosestVehicle(autoecole_location[1], autoecole_location[2], autoecole_location[3], 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("~r~La zone est encombrée")		
		else
		    TriggerServerEvent("ply_autoecole:getCash_s")
            Wait(200)
			if ArgentJoueur >= 10000 then
		        RequestModel(permis_vehicle)
    		    while not HasModelLoaded(permis_vehicle) do
    		    Citizen.Wait(0)
    			drawTxt("Chargement...",1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
    		    end
    		    veh = CreateVehicle(permis_vehicle, autoecole_location[1], autoecole_location[2], autoecole_location[3], 215.0, true, false)
    		    SetVehicleNumberPlateText(veh, permis_plate)
    		    SetVehicleOnGroundProperly(veh)
    		    SetVehicleHasBeenOwnedByPlayer(veh,true)
    		    local id = NetworkGetNetworkIdFromEntity(veh)
    		    SetNetworkIdCanMigrate(id, true)
    		    SetVehicleColours(veh, primarycolor, secondarycolor)
    		    SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
    		    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
    		    SetEntityInvincible(veh, false)
    		    drawNotification("Début de l'épreuve, rendez-vous à destination en respectant le code de la route")		
                TriggerServerEvent("ply_autoecole:moneyupdate", -10000)	
    	        blipermis = AddBlipForCoord(permis_end_x,permis_end_y,permis_end_z)
    	        Citizen.CreateThread(function()		
    		        Wait(0)
                    SetBlipSprite(blipermis, 1)
                    SetBlipColour(blipermis, 2)
                    SetBlipAsMissionCreatorBlip(blipermis,true)
                    SetBlipRoute(blipermis, true)
	            end)
				epreuve = true
			else
			    drawNotification("~r~Vous n'avez pas assez d'argent")
				epreuve = false
            end						
		end		
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if GetDistanceBetweenCoords(permis_end_x,permis_end_y,permis_end_z,GetEntityCoords(LocalPed())) < 3 and epreuve then
				DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour terminer l'épreuve", false)
				--drawTxt("Appuyer sur ~g~E~s~ pour terminer l'épreuve",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					local ped = GetPlayerPed(-1)
					local vehicle = GetVehiclePedIsUsing(ped)
					SetEntityAsMissionEntity(vehicle, true, true)
					local vehplate = GetVehicleNumberPlateText(vehicle)					
					if vehplate == permis_plate then
						local vehiclehealth = GetEntityHealth(vehicle) - 100
						local maxhealth = GetEntityMaxHealth(vehicle) - 100
						local damage = (vehiclehealth / maxhealth) * 100
						if damage <= 95 then							
							drawNotification("~r~Epreuve ratée, le véhicule est trop endommagé")							
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						else							
							drawNotification("~g~Epreuve réussie, ~n~~w~L'Etat vous rembouse la moitiée de la somme engagée")
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							TriggerServerEvent("ply_autoecole:Userlicencec", permisc)
							TriggerServerEvent("ply_autoecole:moneyupdate", 5000)
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						end
					else
						drawNotification("~r~Ce n'est pas le bon vehicule")
					end
				end
			end
		end
	end)
end)

AddEventHandler("ply_autoecole:StartPermisHeliTrue", function()
	local permis_id = 5
	--local permis_name = name
	local permis_vehicle = -1660661558
	local permis_end_x = 1770.72
	local permis_end_y = 3239.85
	local permis_end_z = 42.1344
	local permis_plate ="AUTOTEST"
	local permish = true
	local epreuve = false
	
	Citizen.CreateThread(function()
	 	Citizen.Wait(0)
 		local pos = autoecole_location
 		local caisseo = GetClosestVehicle(-725.271, -1444.27, 5.00052, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("~r~La zone est encombrée")		
		else
		    TriggerServerEvent("ply_autoecole:getCash_s")
            Wait(200)
			if ArgentJoueur >= 50000 then
			    RequestModel(permis_vehicle)
			    while not HasModelLoaded(permis_vehicle) do
			    Citizen.Wait(0)
				drawTxt("Chargement...",1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
			    end
			    veh = CreateVehicle(permis_vehicle, -725.271, -1444.27, 5.00052, 215.0, true, false)
			    SetVehicleNumberPlateText(veh, permis_plate)
			    SetVehicleOnGroundProperly(veh)
			    SetVehicleHasBeenOwnedByPlayer(veh,true)
			    local id = NetworkGetNetworkIdFromEntity(veh)
			    SetNetworkIdCanMigrate(id, true)
			    SetVehicleColours(veh, primarycolor, secondarycolor)
			    SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
			    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
			    SetEntityInvincible(veh, false)
			    drawNotification("Début de l'épreuve, rendez-vous à destination")
				TriggerServerEvent("ply_autoecole:moneyupdate", -50000)
	            blipermis = AddBlipForCoord(permis_end_x,permis_end_y,permis_end_z)
	            Citizen.CreateThread(function()		
            		Wait(0)
                    SetBlipSprite(blipermis, 1)
                    SetBlipColour(blipermis, 2)
                    SetBlipAsMissionCreatorBlip(blipermis,true)
                    SetBlipRoute(blipermis, true)
	            end)
				epreuve = true
			else
			    drawNotification("~r~Vous n'avez pas assez d'argent")
				epreuve = false
            end	
		end		
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if GetDistanceBetweenCoords(permis_end_x,permis_end_y,permis_end_z,GetEntityCoords(LocalPed())) < 3 and epreuve then
				DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour terminer l'épreuve", false)
				--drawTxt("Appuyer sur ~g~E~s~ pour terminer l'épreuve",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					local ped = GetPlayerPed(-1)
					local vehicle = GetVehiclePedIsUsing(ped)
					SetEntityAsMissionEntity(vehicle, true, true)
					local vehplate = GetVehicleNumberPlateText(vehicle)					
					if vehplate == permis_plate then
						local vehiclehealth = GetEntityHealth(vehicle) - 100
						local maxhealth = GetEntityMaxHealth(vehicle) - 100
						local damage = (vehiclehealth / maxhealth) * 100
						if damage <= 95 then							
							drawNotification("~r~Epreuve ratée, le véhicule est trop endommagé")							
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						else							
							drawNotification("~g~Epreuve réussie, ~n~~w~L'Etat vous rembouse la moitiée de la somme engagée")
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							TriggerServerEvent("ply_autoecole:Userlicenceh", permish)
							TriggerServerEvent("ply_autoecole:moneyupdate", 25000)
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						end
					else
						drawNotification("~r~Ce n'est pas le bon vehicule")
					end
				end
			end
		end
	end)
end)

AddEventHandler("ply_autoecole:StartPermisBoatTrue", function()
	local permis_id = 6
	--local permis_name = name
	local permis_vehicle = 861409633
	local permis_end_x = -3425.93
	local permis_end_y = 947.454
	local permis_end_z = -0.167121
	local permis_plate ="AUTOTEST"
	local permisb = true
	local epreuve = false
	
	Citizen.CreateThread(function()
	 	Citizen.Wait(0)
 		local pos = autoecole_location
 		local caisseo = GetClosestVehicle(-936.327, -1466.56, -0.472946, 3.000, 0, 70)
		if DoesEntityExist(caisseo) then
			drawNotification("~r~La zone est encombrée")		
		else
		    TriggerServerEvent("ply_autoecole:getCash_s")
            Wait(200)
			if ArgentJoueur >= 50000 then
			    RequestModel(permis_vehicle)
			    while not HasModelLoaded(permis_vehicle) do
			    Citizen.Wait(0)
				drawTxt("Chargement...",1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
			    end
			    veh = CreateVehicle(permis_vehicle, -936.327, -1466.56, -0.472946, 215.0, true, false)
			    SetVehicleNumberPlateText(veh, permis_plate)
			    SetVehicleOnGroundProperly(veh)
			    SetVehicleHasBeenOwnedByPlayer(veh,true)
			    local id = NetworkGetNetworkIdFromEntity(veh)
			    SetNetworkIdCanMigrate(id, true)
			    SetVehicleColours(veh, primarycolor, secondarycolor)
			    SetVehicleExtraColours(veh, pearlescentcolor, wheelcolor)
			    TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
			    SetEntityInvincible(veh, false)
			    drawNotification("Début de l'épreuve, rendez-vous à destination")
				TriggerServerEvent("ply_autoecole:moneyupdate", -50000)
	            blipermis = AddBlipForCoord(permis_end_x,permis_end_y,permis_end_z)
		            Citizen.CreateThread(function()		
			            Wait(0)
        	            SetBlipSprite(blipermis, 1)
        	            SetBlipColour(blipermis, 2)
        	            SetBlipAsMissionCreatorBlip(blipermis,true)
        	            SetBlipRoute(blipermis, true)
		            end)
				epreuve = true
			else
			    drawNotification("~r~Vous n'avez pas assez d'argent")
				epreuve = false
            end						
		end		
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if GetDistanceBetweenCoords(permis_end_x,permis_end_y,permis_end_z,GetEntityCoords(LocalPed())) < 3 and epreuve then
				DisplayHelp("Appuyer sur ~INPUT_CONTEXT~ pour terminer l'épreuve", false)
				--drawTxt("Appuyer sur ~g~E~s~ pour terminer l'épreuve",0,1,0.5,0.8,0.6,255,255,255,255)
				if IsControlJustPressed(1, 86) then
					local ped = GetPlayerPed(-1)
					local vehicle = GetVehiclePedIsUsing(ped)
					SetEntityAsMissionEntity(vehicle, true, true)
					local vehplate = GetVehicleNumberPlateText(vehicle)					
					if vehplate == permis_plate then
						local vehiclehealth = GetEntityHealth(vehicle) - 100
						local maxhealth = GetEntityMaxHealth(vehicle) - 100
						local damage = (vehiclehealth / maxhealth) * 100
						if damage <= 95 then							
							drawNotification("~r~Epreuve ratée, le véhicule est trop endommagé")							
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						else							
							drawNotification("~g~Epreuve réussie, ~n~~w~L'Etat vous rembouse la moitiée de la somme engagée")
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
							TriggerServerEvent("ply_autoecole:Userlicenceb", permisb)
							TriggerServerEvent("ply_autoecole:moneyupdate", 25000)
							epreuve = false
							SetEntityAsNoLongerNeeded(blipermis)
							SetBlipAsMissionCreatorBlip(blipermis,false)
							Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(blipermis))
						end
					else
						drawNotification("~r~Ce n'est pas le bon vehicule")
					end
				end
			end
		end
	end)
end)