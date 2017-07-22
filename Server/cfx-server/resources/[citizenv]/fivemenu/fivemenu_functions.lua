--[[
local Keys = {
["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
]]

local arme_cadet = {
"WEAPON_NIGHTSTICK",
"WEAPON_PISTOL",
"WEAPON_FlASHLIGHT",
}

local arme_patrouille = {
"WEAPON_NIGHTSTICK",
"WEAPON_PISTOL",
"WEAPON_FlASHLIGHT",
"WEAPON_CARBINERIFLE",
"WEAPON_PUMPSHOTGUN",
}

local arme_swat = {
"WEAPON_NIGHTSTICK",
"WEAPON_PISTOL",
"WEAPON_FlASHLIGHT",
"WEAPON_SMOKEGRENADE",
"WEAPON_SPECIALCARBINE",
"WEAPON_PUMPSHOTGUN",
}

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

----- Job info for the menu ------
onJobLegal = 0

AddEventHandler("fivemenu:f_getJobInfos", function(onJobLegaly)
	onJobLegal = onJobLegaly
end)
----------------------------------

--------------- Clean cash  ------
AddEventHandler("vmenu:cleanCash", function(target)
	TriggerServerEvent("vmenu:cleanCash_s")
end)
----------------------------------

------ Animation Controller ------
AddEventHandler("vmenu:anim", function(dict, anim)
	Citizen.CreateThread(function()
		Wait(1000)
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(0)
		end

		local myPed = PlayerPedId()
		local animation = anim
		local flags = 16 -- only play the animation on the upper body

		TaskPlayAnim(myPed, dict, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
	end)
end)

AddEventHandler("vmenu:animChain", function(dict, anim, dict2, anim2, dict3, anim3)
	Citizen.CreateThread(function()
		--TriggerEvent("wrapper:cellphoneAnimOn")
		Wait(100)
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(0)
		end

		local myPed = PlayerPedId()
		local animation = anim
		local flags = 16 -- only play the animation on the upper body

		TaskPlayAnim(myPed, dict, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
		Wait(1100)
		while VMenu.visible do
			Wait(10)
			RequestAnimDict(dict2)

			while not HasAnimDictLoaded(dict2) do
				Citizen.Wait(0)
			end

			local myPed = PlayerPedId()
			local animation = anim2
			local flags = 1 -- only play the animation on the upper body

			TaskPlayAnim(myPed, dict2, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
		end

		if not VMenu.visible then
			if not VMenu.animations then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				RequestAnimDict(dict3)

				while not HasAnimDictLoaded(dict3) do
					Citizen.Wait(0)
				end

				local myPed = PlayerPedId()
				local animation = anim3
				local flags = 16 -- only play the animation on the upper body

				TaskPlayAnim(myPed, dict3, animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
				Wait(500)
				--TriggerEvent("wrapper:cellphoneAnimOff")
			else
				ClearPedTasksImmediately(GetPlayerPed(-1))
			end
		end
	end)
end)

AddEventHandler("vmenu:poleemploi", function(target, idJob) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	User.job = idJob
	TriggerServerEvent('poleemploi:jobs', idJob)
	removeBlip()
	if User.job == 2 then
	    AfficherPoolBlip()
	elseif User.job == 3 then
	    AfficherTrashBlip()
	elseif User.job == 4 then
	    AfficherMineBlip()
	    AfficherSupermarket()
	elseif User.job == 6 then
	    AfficherTruckerBlip()
	elseif User.job == 11 then
	    AfficherCemteryBlip()
	elseif User.job == 12 then
	    AfficherMorgBlip()
	elseif User.job == 14 then
	    AfficherFarmBlip()
		AfficherSupermarket()
	elseif User.job == 20 then
	    AfficherDeliveryBlip()
	else
	    removeBlip()
	end
end)

Citizen.CreateThread(function ()
	while true do
	    Citizen.Wait(60000)
		TriggerServerEvent("poleemploi:jobblips_s")
	end	
end)

RegisterNetEvent("vmenu:Updatejobblips")
AddEventHandler("vmenu:Updatejobblips", function(job)
    myjob = job
	removeBlip()
	if myjob == 2 then
	    AfficherPoolBlip()
	elseif myjob == 3 then
	    AfficherTrashBlip()
	elseif myjob == 4 then
	    AfficherMineBlip()
	    AfficherSupermarket()
	elseif myjob == 6 then
	    AfficherTruckerBlip()
	elseif myjob == 11 then
	    AfficherCemteryBlip()
	elseif myjob == 12 then
	    AfficherMorgBlip()
	elseif myjob == 14 then
	    AfficherFarmBlip()
		AfficherSupermarket()
	elseif myjob == 20 then
	    AfficherDeliveryBlip()
	else
	    removeBlip()
	end
end)

RegisterNetEvent("vmenu:MainMenuOG")
AddEventHandler("vmenu:MainMenuOG", function(target)
	VMenu.police = false
	VMenu.telephone = false
	VMenu.animations = false
	VMenu.permis = false
	VMenu.inventory = false
	VMenu.medic = false
end)

local cashconfirmed = 0
local sendMoney = 0
local sendTarget = -1

AddEventHandler("vmenu:giveCash", function(target, money)
	if target ~= -1 then
		TriggerEvent("vmenu:closeMenu")
		DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
		cashconfirmed = 1
		sendMoney = money
		sendTarget = target
	else
		TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas de cible")
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if cashconfirmed == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				cashconfirmed = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				local txt = GetOnscreenKeyboardResult()
				if (string.len(txt) > 0) and (string.match(txt, '%d+')) then -- BEAU REGEX PATTERN EN LUA PARCE QUE C'EST PAUVRE
					txt = tonumber(txt)
					if sendMoney > txt then
						if txt > 0 then
							addCash = txt
							cashconfirmed = 2
						else
							TriggerEvent("itinerance:notif", "~r~ Vous devez entrer un nombre positif")
							cashconfirmed = 0
							sendMoney = 0
							sendTarget = -1
						end
					else
						TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas assez d'argent")
						cashconfirmed = 0
						sendMoney = 0
						sendTarget = -1
					end
				else
					TriggerEvent("itinerance:notif", "~r~ Entrer un montant valide")
					cashconfirmed = 0
					sendMoney = 0
					sendTarget = -1
				end
			elseif UpdateOnscreenKeyboard() == 2 then
				cashconfirmed = 0
				sendMoney = 0
				sendTarget = -1
			end
		end
		if cashconfirmed == 2 then
			TriggerServerEvent('vmenu:giveCash_s', GetPlayerServerId(sendTarget), addCash)
			cashconfirmed = 0
			sendMoney = 0
			sendTarget = -1
		end
	end
end)

local dcashconfirmed = 0

AddEventHandler("vmenu:giveDCash", function(target, money)
	if target ~= -1 then
		TriggerEvent("vmenu:closeMenu")
		DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
		dcashconfirmed = 1
		sendMoney = money
		sendTarget = target
	else
		TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas de cible")
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if dcashconfirmed == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				dcashconfirmed = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				local txt = GetOnscreenKeyboardResult()
				if (string.len(txt) > 0) and (string.match(txt, '%d+')) then -- BEAU REGEX PATTERN EN LUA PARCE QUE C'EST PAUVRE
					txt = tonumber(txt)
					if sendMoney > txt then
						if txt > 0 then
							addCash = txt
							dcashconfirmed = 2
						else
							TriggerEvent("itinerance:notif", "~r~ Vous devez entrer un nombre positif")
							dcashconfirmed = 0
							sendMoney = 0
							sendTarget = -1
						end
					else
						TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas assez d'argent")
						dcashconfirmed = 0
						sendMoney = 0
						sendTarget = -1
					end
				else
					TriggerEvent("itinerance:notif", "~r~ Entrer un montant valide")
					dcashconfirmed = 0
					sendMoney = 0
					sendTarget = -1
				end
			elseif UpdateOnscreenKeyboard() == 2 then
				dcashconfirmed = 0
				sendMoney = 0
				sendTarget = -1
			end
		end
		if dcashconfirmed == 2 then
			TriggerServerEvent('vmenu:giveDCash_s', GetPlayerServerId(sendTarget), addCash)
			dcashconfirmed = 0
			sendMoney = 0
			sendTarget = -1
		end
	end
end)

----------------------------------

----------------------------------
AddEventHandler("vmenu:policeState", function(target, idPolice) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("player:serviceOn", "police")
	TriggerServerEvent('jobspolice:jobs', idPolice, false)
end)

AddEventHandler("vmenu:policeStateCivil", function(target, idPolice) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("vmenu:lastChar")
	TriggerServerEvent("player:serviceOn", "police")
	TriggerServerEvent('jobspolice:jobs', idPolice, true)
end)

AddEventHandler("vmenu:getArmory", function(target, idGun) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	Citizen.Trace('Dans les guns')
	if idGun == 1 then
	    for _, arme in ipairs(arme_cadet) do
            TriggerServerEvent('jobspolice:wepArmory', arme)
			Wait(500)
        end
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 0x359B7AAE)--Flashlight
	end
	if idGun == 2 then
		for _, arme in ipairs(arme_patrouille) do
            TriggerServerEvent('jobspolice:wepArmory', arme)
			Wait(500)
        end
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 0x359B7AAE)--Flashlight
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 0x7BC4CDDC)--Flashlight
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 0x7BC4CDDC)
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 0x9D2FBF29)--Flashlight
	end
	if idGun == 3 then
		for _, arme in ipairs(arme_swat) do
            TriggerServerEvent('jobspolice:wepArmory', arme)
			Wait(500)
        end
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 0x359B7AAE)--Flashlight
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 0x7BC4CDDC)--Flashlight
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), 0x7BC4CDDC)--Flashlight
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), 0xA0D89C42)
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), 0xA73D4664)--Silencieux
	end
end)

AddEventHandler("vmenu:getGarage", function(target, vehicule) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('jobspolice:vehGarage', vehicule)
end)

AddEventHandler("vmenu:getHelicoGarage", function(target, vehicule) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('jobspolice:vehHelicoGarage', vehicule)
end)

AddEventHandler("vmenu:getAmbulanceHelicoGarage", function(target, vehicule) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent('es_em:getAmbulanceHelicoGarage', vehicule)
end)

AddEventHandler("vmenu:toGarage", function(target) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		DrawNotif("Sortez du véhicule")
	else
		TriggerServerEvent('jobspolice:vehtoGarage')
	end
end)

AddEventHandler("vmenu:getSkin", function(target, sex) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	CreateThread(function()
		local model = nil
		if sex == 0 then
			model = GetHashKey("mp_m_freemode_01")
		else
			model = GetHashKey("mp_f_freemode_01")
		end

		if model ~= nil then
			RequestModel(model)
			while not HasModelLoaded(model) do -- Wait for model to load
				RequestModel(model)
				Citizen.Wait(0)
			end
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
		end
	end)
end)

AddEventHandler("vmenu:getclientOutfits", function(target, item) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	CreateThread(function()
		--SetPedPropIndex(GetPlayerPed(-1),  0,  12,  0,  0)
		--SetPedPropIndex(GetPlayerPed(-1),  1,  18,  2,  0)

		--SetPedComponentVariation(GetPlayerPed(-1), 0, item.zero[1], item.zero[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 1, item.one[1], item.one[2], 2)
		--SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 4, 2) --CHEVEUX
		SetPedComponentVariation(GetPlayerPed(-1), 3, item.three[1], item.three[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, item.four[1], item.four[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 5, item.five[1], item.five[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 6, item.six[1], item.six[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 7, item.seven[1], item.seven[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 8, item.eight[1], item.eight[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 9, item.nine[1], item.nine[2], 2) --Dessus Armure / etc
		SetPedComponentVariation(GetPlayerPed(-1), 10, item.ten[1], item.ten[2], 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, item.eleven[1], item.eleven[2], 2)

		--SetPedComponentVariation(GetPlayerPed(-1), 2, id, 0, 2)
		--SetPedComponentVariation(GetPlayerPed(-1), id, 50, 0, 2)
		--SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 0, 2)
		local itemInfo = {item.three[1], item.three[2], item.four[1], item.four[2], item.six[1], item.six[2], item.seven[1], item.seven[2], item.eight[1], item.eight[2], item.eleven[1], item.eleven[2]}

		TriggerServerEvent("vmenu:getOutfit", itemInfo)
		Wait (10)
	end)
end)

AddEventHandler("vmenu:getclientHair", function(target, hair, hairsec, hairc, haircsec) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("vmenu:getHair", hair, hairsec, hairc, haircsec)
end)

AddEventHandler("vmenu:getclientFace", function(target, sex, face, face_text) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	TriggerServerEvent("vmenu:getFace", sex, face, face_text)
end)

AddEventHandler("vmenu:spawnVeh", function(target, model, bool) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	CreateThread(function()
		local carid = GetHashKey(model)
		local ped = GetPlayerPed(-1)
		RequestModel(carid)
		while not HasModelLoaded(carid) do
			Wait(0)
		end
		local p = GetEntityCoords(ped)
		p = p + vector3(0, 10, 0)
		local veh = CreateVehicle(carid, p.x, p.y, p.z, 0.0, true, false)
		TaskWarpPedIntoVehicle(ped, veh, -1)
		--MarkModelAsNoLongerNeeded(carid)
	end)
end)

RegisterNetEvent("vmenu:teleport_marker")
AddEventHandler("vmenu:teleport_marker", function(target, pos)
	CreateThread(function()
		local carid = GetHashKey(model)
		local e = GetPlayerPed(-1)
		local blip = GetFirstBlipInfoId(8)

		local success = false
		local groundFound = false
		local groundCheck = true
		local groundHeight = { 110.0, 150.0, 0.0, 90.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0 };
		local tpZ = 0.0
		if IsWaypointActive() then
			--local coords = GetBlipCoords(blip)
			--local a = {}
			local coords = {}
			if pos == nil then
				coords = Citizen.InvokeNative(0x586AFE3FF72D996E, blip, Citizen.ResultAsVector())
			else
				coords = pos
			end

			if IsPedInAnyVehicle(e, 0) then

				e = GetVehiclePedIsUsing(e)
				h = GetEntityModel(e)

				if IsThisModelABoat(h) then
					groundCheck = false
					tpZ = 0.0
				elseif (IsThisModelAPlane(h) or IsThisModelAHeli(h)) then
					groundCheck = false
					tpZ = 800.0
				end
			end
			if groundCheck then

				SetEntityCoordsNoOffset(e, coords.x, coords.y, tpZ, 0,  0,  1)

				for i = 1, #groundHeight do

					SetEntityCoordsNoOffset(e, coords.x, coords.y, groundHeight[i], 0,  0,  1)
					Wait(200)
					--local f = GetGroundZFor_3dCoord(coords.x, coords.y, groundHeight[i])
					local f = Citizen.InvokeNative(0xC906A7DAB05C8D2B,coords.x,coords.y,groundHeight[i],Citizen.PointerValueFloat(),0)
					if f then
						groundFound = true
						tpZ = f + 5.0
						break
					end

				end

				if not groundFound then
					GiveDelayedWeaponToPed(GetPlayerPed(-1),  GetHashKey("GADGET_PARACHUTE"),  100,  false)
					coords.z = tpZ
				end

			end
			SetEntityCoordsNoOffset(e, coords.x, coords.y, tpZ, 0,  0,  1)
			Wait(10)
		else
			DrawNotif("Aucun Marqueur trouvé.")
		end

	end)
end)

-----------JOBS BLIPS--------------

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end

----POOLJOB----
local pooljob = {x=717.3234,y=-894.7209,z=24.0391}

function AfficherPoolBlip()

    Poolblip = AddBlipForCoord(pooljob.x,pooljob.y,pooljob.z)

	SetBlipSprite(Poolblip,146)
	SetBlipColour(Poolblip, 2)
	SetBlipScale(Poolblip, 0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('~g~Nettoyage de Piscine')
	EndTextCommandSetBlipName(Poolblip)
	SetBlipAsShortRange(Poolblip,true)

end

----TRASHJOB----
local trashjob = {x=-326.9868,y=-1521.877,z=27.53701}

function AfficherTrashBlip()

    Trashblip = AddBlipForCoord(trashjob.x,trashjob.y,trashjob.z)

	SetBlipSprite(Trashblip,318)
	SetBlipColour(Trashblip, 2)
	SetBlipScale(Trashblip, 1.0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('~g~Décharge')
	EndTextCommandSetBlipName(Trashblip)
	SetBlipAsShortRange(Trashblip,true)

end

----MINE----
local MinePosition = {
  Compagnie={x=978.145690917969,y=-1919.07055664063,z=31.1356315612793,distance=10},
  Recolet={x=2969.47827148438,y=2777.9873046875,z=38.5488739013672, distance=10},
  traitement={x=2682.16967773438,y=2795.44555664063,z=40.6961441040039, distance=10},
  vente={x=1137.62316894531,y=2344.03442382813,z=54.3110084533691, distance=10},
  venteDiams={x=-619.454223632813,y=-226.972839355469,z=38.0569648742676, distance=10},
}

function AfficherMineBlip()

  BlipCompagnie = AddBlipForCoord(MinePosition.Compagnie.x, MinePosition.Compagnie.y, MinePosition.Compagnie.z)

  SetBlipSprite(BlipCompagnie, 426)
  SetBlipColour(BlipCompagnie, 2)
  SetBlipAsShortRange(BlipCompagnie, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("~g~ Compagnie Minière")
  EndTextCommandSetBlipName(BlipCompagnie)

  BlipMine = AddBlipForCoord(MinePosition.Recolet.x, MinePosition.Recolet.y, MinePosition.Recolet.z)

  SetBlipSprite(BlipMine, 78)
  SetBlipColour(BlipMine, 2)
  SetBlipAsShortRange(BlipMine, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Mine')
  EndTextCommandSetBlipName(BlipMine)

  BlipTraitementMine = AddBlipForCoord(MinePosition.traitement.x, MinePosition.traitement.y, MinePosition.traitement.z)

  SetBlipSprite(BlipTraitementMine, 233)
  SetBlipColour(BlipTraitementMine, 2)
  SetBlipAsShortRange(BlipTraitementMine, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Traitement de minéraux')
  EndTextCommandSetBlipName(BlipTraitementMine)

  BlipVenteMine = AddBlipForCoord(MinePosition.vente.x, MinePosition.vente.y, MinePosition.vente.z)

  SetBlipSprite(BlipVenteMine, 277)
  SetBlipColour(BlipVenteMine, 2)
  SetBlipAsShortRange(BlipVenteMine, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Acheteur de minéraux')
  EndTextCommandSetBlipName(BlipVenteMine)

  BlipVenteDiams = AddBlipForCoord(MinePosition.venteDiams.x, MinePosition.venteDiams.y, MinePosition.venteDiams.z)

  SetBlipSprite(BlipVenteDiams, 277)
  SetBlipColour(BlipVenteDiams, 2)
  SetBlipAsShortRange(BlipVenteDiams, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Acheteur de diamant')
  EndTextCommandSetBlipName(BlipVenteDiams)
  
end


----TRUCKER----
local TruckingCompany = {
  TruckOne={x=1515.51, y=-2138.76, z=76.7922},
  TruckTwo={x=642.97, y=-3015.34, z=7.33618},
  TruckThree={x=3514.814, y=3759.489, z=30.0171},
  TruckFour={x=-552.829, y=5348.613, z=74.754}
}

function AfficherTruckerBlip()

    TruckerBlipOne = AddBlipForCoord(TruckingCompany.TruckOne.x, TruckingCompany.TruckOne.y, TruckingCompany.TruckOne.z)
	
    SetBlipSprite(TruckerBlipOne, 85)
    SetBlipColour(TruckerBlipOne, 2)
	SetBlipAsShortRange(TruckerBlipOne,true)
	SetBlipScale(TruckerBlipOne, 1.1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~g~Livraison de citerne")
    EndTextCommandSetBlipName(TruckerBlipOne)
	
	TruckerBlipTwo = AddBlipForCoord(TruckingCompany.TruckTwo.x, TruckingCompany.TruckTwo.y, TruckingCompany.TruckTwo.z)
	
    SetBlipSprite(TruckerBlipTwo, 85)
    SetBlipColour(TruckerBlipTwo, 2)
	SetBlipAsShortRange(TruckerBlipTwo,true)
	SetBlipScale(TruckerBlipTwo, 1.1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~g~Livraison de conteneur")
    EndTextCommandSetBlipName(TruckerBlipTwo)
	
	TruckerBlipThree = AddBlipForCoord(TruckingCompany.TruckThree.x, TruckingCompany.TruckThree.y, TruckingCompany.TruckThree.z)
	
    SetBlipSprite(TruckerBlipThree, 85)
    SetBlipColour(TruckerBlipThree, 2)
	SetBlipAsShortRange(TruckerBlipThree,true)
	SetBlipScale(TruckerBlipThree, 1.1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~g~Livraison de médicaments")
    EndTextCommandSetBlipName(TruckerBlipThree)
	
	TruckerBlipFour = AddBlipForCoord(TruckingCompany.TruckFour.x, TruckingCompany.TruckFour.y, TruckingCompany.TruckFour.z)
	
    SetBlipSprite(TruckerBlipFour, 85)
    SetBlipColour(TruckerBlipFour, 2)
	SetBlipAsShortRange(TruckerBlipFour,true)
	SetBlipScale(TruckerBlipFour, 1.1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~g~Livraison de bois")
    EndTextCommandSetBlipName(TruckerBlipFour)
	
end

----ORGANE---
local cemtery = {x=-1664.8740234375,y=-281.862365722656,z=51.863655090332}

function AfficherCemteryBlip()

  CemteryBlip = AddBlipForCoord(cemtery.x,cemtery.y,cemtery.z)
  
  SetBlipSprite(CemteryBlip, 273)
  SetBlipColour(CemteryBlip, 2)
  SetBlipAsShortRange(CemteryBlip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("~g~ Cimetière")
  EndTextCommandSetBlipName(CemteryBlip)

end

----MORGUE----
local morgue = {x=223.208068847656,y=-1387.89562988281,z=30.5365390777588}

function AfficherMorgBlip()

  MorgBlip = AddBlipForCoord(morgue.x,morgue.y,morgue.z)
  
  SetBlipSprite(MorgBlip, 310)
  SetBlipColour(MorgBlip, 2)
  SetBlipAsShortRange(MorgBlip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("~g~ Morgue")
  EndTextCommandSetBlipName(MorgBlip)

end

----FARM----
local FarmPosition = {
  Recolet={x=2221.84,y=5132.88,z=55.2553, distance=10},
  traitementc={x=2890.42,y=4391.42,z=50.3389, distance=10},
  traitementp={x=906.076 ,y=3587.11 ,z=33.3849 ,distance=10},
  traitementt={x=-266.096 ,y=6068.29 ,z=31.4645 ,distance=10},
  traitementb={x=-581.744 ,y=-1780.65 ,z=22.623 ,distance=10},
  vente={x=-224.892,y=-271.751,z=49.02, distance=10},
  ventepain={x=336.016,y=-1019.24,z=29.2976, distance=4},
}

function AfficherFarmBlip()

  FarmBlipFerme = AddBlipForCoord(FarmPosition.Recolet.x, FarmPosition.Recolet.y,FarmPosition.Recolet.z)
  
  SetBlipSprite(FarmBlipFerme, 210)
  SetBlipColour(FarmBlipFerme, 2)
  SetBlipAsShortRange(FarmBlipFerme, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Ferme')
  EndTextCommandSetBlipName(FarmBlipFerme)

  FarmBliptraitementc = AddBlipForCoord(FarmPosition.traitementc.x, FarmPosition.traitementc.y, FarmPosition.traitementc.z)

  SetBlipSprite(FarmBliptraitementc, 402)
  SetBlipColour(FarmBliptraitementc, 2)
  SetBlipAsShortRange(FarmBliptraitementc, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Traitement de carottes')
  EndTextCommandSetBlipName(FarmBliptraitementc)

  FarmBliptraitementp = AddBlipForCoord(FarmPosition.traitementp.x, FarmPosition.traitementp.y, FarmPosition.traitementp.z)

  SetBlipSprite(FarmBliptraitementp, 402)
  SetBlipColour(FarmBliptraitementp, 2)
  SetBlipAsShortRange(FarmBliptraitementp, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Traitement de pommes de terre')
  EndTextCommandSetBlipName(FarmBliptraitementp)
  
  FarmBliptraitementt = AddBlipForCoord(FarmPosition.traitementt.x, FarmPosition.traitementt.y, FarmPosition.traitementt.z)

  SetBlipSprite(FarmBliptraitementt, 402)
  SetBlipColour(FarmBliptraitementt, 2)
  SetBlipAsShortRange(FarmBliptraitementt, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Traitement de tomates')
  EndTextCommandSetBlipName(FarmBliptraitementt)
  
  FarmBliptraitementb = AddBlipForCoord(FarmPosition.traitementb.x, FarmPosition.traitementb.y, FarmPosition.traitementb.z)

  SetBlipSprite(FarmBliptraitementb, 402)
  SetBlipColour(FarmBliptraitementb, 2)
  SetBlipAsShortRange(FarmBliptraitementb, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~Traitement de blé')
  EndTextCommandSetBlipName(FarmBliptraitementb)

end

----DELIVERY----
local DeliveryPosition = {
    GoPostal={x=63.463, y=126.00, z=79.1902},
}

function AfficherDeliveryBlip()

  DeliveryBlip = AddBlipForCoord(DeliveryPosition.GoPostal.x, DeliveryPosition.GoPostal.y,DeliveryPosition.GoPostal.z)
  
  SetBlipSprite(DeliveryBlip, 411)
  SetBlipColour(DeliveryBlip, 2)
  SetBlipDisplay(DeliveryBlip, 4)
  SetBlipScale(DeliveryBlip, 0.9)
  SetBlipAsShortRange(DeliveryBlip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('~g~GoPostal')
  EndTextCommandSetBlipName(DeliveryBlip)
  
end

----MULTIJOB----
local supermarket = {x=-224.892,y=-271.751,z=49.02}

function AfficherSupermarket()

  SuperBlip = AddBlipForCoord(supermarket.x, supermarket.y, supermarket.z)
  
  SetBlipSprite(SuperBlip, 52)
  SetBlipColour(SuperBlip, 2)
  SetBlipDisplay(SuperBlip, 4)
  SetBlipScale(SuperBlip, 0.9)
  SetBlipAsShortRange(SuperBlip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("~g~Supermaché")
  EndTextCommandSetBlipName(SuperBlip)
  
end


----REMOVE----
function removeBlip()
  RemoveBlip(FarmBlipFerme)
  RemoveBlip(FarmBliptraitementc)
  RemoveBlip(FarmBliptraitementp)
  RemoveBlip(FarmBliptraitementt)
  RemoveBlip(FarmBliptraitementb)
  RemoveBlip(DeliveryBlip)
  RemoveBlip(TruckerBlipOne)
  RemoveBlip(TruckerBlipTwo)
  RemoveBlip(TruckerBlipThree)
  RemoveBlip(TruckerBlipFour)
  RemoveBlip(Poolblip)
  RemoveBlip(Trashblip)
  RemoveBlip(BlipVenteDiams)
  RemoveBlip(BlipVenteMine)
  RemoveBlip(BlipTraitementMine)
  RemoveBlip(BlipMine)
  RemoveBlip(BlipCompagnie)
  RemoveBlip(SuperBlip)
  RemoveBlip(CemteryBlip)
  RemoveBlip(MorgBlip)
end
