function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

nameTarget = ""
local all_arme = {
--"WEAPON_COUGAR",
"WEAPON_KNIFE",
"WEAPON_NIGHTSTICK",
"WEAPON_HAMMER",
"WEAPON_BAT",
"WEAPON_GOLFCLUB",
"WEAPON_CROWBAR",
"WEAPON_PISTOL",
"WEAPON_COMBATPISTOL",
"WEAPON_APPISTOL",
"WEAPON_PISTOL50",
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_ASSAULTSMG",
"WEAPON_ASSAULTRIFLE",
"WEAPON_CARBINERIFLE",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_STUNGUN",
"WEAPON_SNIPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_REMOTESNIPER",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_PASSENGER_ROCKET",
"WEAPON_AIRSTRIKE_ROCKET",
"WEAPON_STINGER",
"WEAPON_MINIGUN",
"WEAPON_GRENADE",
"WEAPON_STICKYBOMB",
"WEAPON_SMOKEGRENADE",
"WEAPON_BZGAS",
"WEAPON_MOLOTOV",
"WEAPON_FIREEXTINGUISHER",
"WEAPON_PETROLCAN",
"WEAPON_DIGISCANNER",
"WEAPON_BRIEFCASE",
"WEAPON_BRIEFCASE_02",
"WEAPON_BALL",
"WEAPON_FLARE",
"WEAPON_GUSENBERG",
"WEAPON_BOTTLE",
"WEAPON_SNSPISTOL",
"WEAPON_SPECIALCARBINE",
"WEAPON_HEAVYPISTOL",
"WEAPON_BULLPUPRIFLE",
"WEAPON_DAGGER",
"WEAPON_VINTAGEPISTOL",
"WEAPON_FIREWORK",
"WEAPON_MUSKET",
"WEAPON_HEAVYSHOTGUN",
"WEAPON_MARKSMANRIFLE",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_GARBAGEBAG",
"WEAPON_PROXMINE",
"WEAPON_FLAREGUN",
"WEAPON_GARBAGEBAG",
"WEAPON_HANDCUFFS",
"WEAPON_COMBATPDW",
"WEAPON_MARKSMANPISTOL",
"WEAPON_KNUCKLE",
"WEAPON_HATCHET",
"WEAPON_RAILGUN",
"WEAPON_MACHETE",
"WEAPON_MACHINEPISTOL",
"WEAPON_AIR_DEFENCE_GUN",
"WEAPON_SWITCHBLADE",
"WEAPON_REVOLVER",
"WEAPON_DBSHOTGUN",
"WEAPON_COMPACTRIFLE",
"WEAPON_AUTOSHOTGUN",
"WEAPON_BATTLEAXE",
"WEAPON_COMPACTLAUNCHER",
"WEAPON_MINISMG",
"WEAPON_PIPEBOMB",
"WEAPON_POOLCUE",
"WEAPON_WRENCH",
}
local arme_illegal = {
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_ASSAULTSMG",
"WEAPON_ASSAULTRIFLE",
"WEAPON_CARBINERIFLE",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_STUNGUN",
"WEAPON_SNIPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_REMOTESNIPER",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_PASSENGER_ROCKET",
"WEAPON_AIRSTRIKE_ROCKET",
"WEAPON_STINGER",
"WEAPON_MINIGUN",
"WEAPON_GRENADE",
"WEAPON_STICKYBOMB",
"WEAPON_SMOKEGRENADE",
"WEAPON_BZGAS",
"WEAPON_MOLOTOV",
"WEAPON_GUSENBERG",
"WEAPON_SPECIALCARBINE",
"WEAPON_BULLPUPRIFLE",
"WEAPON_FIREWORK",
"WEAPON_MUSKET",
"WEAPON_HEAVYSHOTGUN",
"WEAPON_MARKSMANRIFLE",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_PROXMINE",
"WEAPON_COMBATPDW",
"WEAPON_MARKSMANPISTOL",
"WEAPON_RAILGUN",
"WEAPON_MACHINEPISTOL",
"WEAPON_AIR_DEFENCE_GUN",
"WEAPON_DBSHOTGUN",
"WEAPON_COMPACTRIFLE",
"WEAPON_AUTOSHOTGUN",
"WEAPON_COMPACTLAUNCHER",
"WEAPON_MINISMG",
"WEAPON_PIPEBOMB",
}

RegisterNetEvent("menupolice:f_getTargetN")
AddEventHandler('menupolice:f_getTargetN', function(info)
	nameTarget = info[1].. " " ..info[2]
end)

AddEventHandler("menupolice:PoliceOG", function(target, rangPolice) -- 0 rien, 1 Cadet, 2 Brigadier, 3 Sergent, 4 Lieutenant, 5 Capitaine, 6 Commandant
		if target ~= -1 then
				nameTarget = "Vous cilblez un civil"
		else
				nameTarget = "Aucune target"
		end
		VMenu.police = true
		VMenu.ResetMenu(98, "", "default")
		Wait(100)
		VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
		VMenu.AddSep(98, tostring(nameTarget))
		if rangPolice == 6 then
				VMenu.AddTxT(98, "Commandant")
		elseif rangPolice == 5 then
				VMenu.AddTxT(98, "Capitaine")
		elseif rangPolice == 4 then
				VMenu.AddTxT(98, "Lieutenant")
		elseif rangPolice == 3 then
				VMenu.AddTxT(98, "Sergent")
		elseif rangPolice == 2 then
				VMenu.AddTxT(98, "Brigadier")
		elseif rangPolice == 1 then
				VMenu.AddTxT(98, "Cadet")
		end
	 	VMenu.AddFunc(98, "Verifier papier", "menupolice:verifp", {}, "Accéder")
		VMenu.AddFunc(98, "Verifier permis", "menupolice:verifpermis", {target}, "Accéder")
		VMenu.AddFunc(98, "Donner contravention", "menupolice:donneramande", {}, "Accèder")
		VMenu.AddFunc(98, "Fouiller le véhicule le plus près", "menupolice:searchveh", {}, "Accéder")
		VMenu.AddFunc(98, "Fouiller le civil le plus près", "menupolice:searchciv", {}, "Accéder")
		VMenu.AddFunc(98, "Saisir l'argent sale", "menupolice:seizecash", {}, "Accéder")
		VMenu.AddFunc(98, "Saisir les objets illégaux", "menupolice:seizedrug", {}, "Accéder")
		VMenu.AddFunc(98, "Saisir les armes illégales", "menupolice:seizeillegalweapons", {}, "Accéder")
		VMenu.AddFunc(98, "Saisir les armes", "menupolice:seizeweapons", {}, "Accéder")
		VMenu.AddBool(98, "Escorter un civil menotté", "EscortM", false, "Toggle")
		VMenu.AddBool(98, "Menotter/Démenotter", "Menotter", false, "Toggle")
		VMenu.AddFunc(98, "Forcer l'entrée d'un civil dans un véhicule", "menupolice:civtocar", {}, "Accéder")
		VMenu.AddFunc(98, "Forcer la sortie des civils du véhicule", "menupolice:civuncar", {}, "Accéder")
		VMenu.AddFunc(98, "Enfermer le civil en prison", "menupolice:jail", {}, "Accéder")
		VMenu.AddFunc(98, "Crocheter la serrure du véhicule", "menupolice:unlock", {}, "Accéder")
		VMenu.AddFunc(98, "Consulter la liste des suspects recherchés ", "menupolice:consultwanted", {}, "Accéder")
		--VMenu.AddFunc(98, "Utiliser un mégaphone", "menupolice:megaphone", {}, "Accéder")
		if rangPolice >= 5 then
		    VMenu.AddFunc(98, "Recrutements et promotions", 'menupolice:recrut', {target, rangPolice}, "Accéder")
		end
		-- Ajouter/Retirer dans le commissariat
end)

RegisterNetEvent('menupolice:recrut')
AddEventHandler('menupolice:recrut', function(target, rangPolice)
	if target ~= -1 then
		nameTarget = "Vous cilblez un civil"
	else
		nameTarget = "Aucune target"
	end
	VMenu.police = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddSep(98, tostring(nameTarget))
	if rangPolice == 6 then
		VMenu.AddSep(98, "Commandant")
	elseif rangPolice == 5 then
		VMenu.AddSep(98, "Capitaine")
	end
	VMenu.AddFunc(98, "Recruter", "", {}, "Accéder")
	VMenu.AddSep(98, "Promotions et rétrogradations")
	VMenu.AddFunc(98, "Cadet", "", {}, "Definir comme cadet")
	VMenu.AddFunc(98, "Brigadier", "", {}, "Definir comme brigadier")
	VMenu.AddFunc(98, "Sergent", "", {}, "Definir comme sergent")
	VMenu.AddFunc(98, "Lieutenant", "", {}, "Definir comme lieutenant")
	if rangPolice == 6 then
	    VMenu.AddFunc(98, "Capitaine", "", {}, "Definir comme Capitaine")
	end
end)

PhandCuffed = false
PEscorthandCuffed = false
PhandCuffedName = ""

handCuffed = false
EscorthandCuffed = false

EscortGuy = 0

RegisterNetEvent("menupolice:donneramande")
AddEventHandler("menupolice:donneramande", function ()
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
    	--if (assert(type(x) == "number"))then
        local result = GetOnscreenKeyboardResult()
		TriggerEvent("menupolice:givecon", result)
	end
end)

RegisterNetEvent("menupolice:f_cuff")
AddEventHandler('menupolice:f_cuff', function(civitem)
	handCuffed = true
end)

AddEventHandler('menupolice:cuff', function(target)
	PhandCuffed = true
end)

RegisterNetEvent("menupolice:f_escortcuff")
AddEventHandler('menupolice:f_escortcuff', function(civitem, pname, lebool)
	EscortGuy = civitem
	if lebool == true then
		PhandCuffedName  = pname
		EscorthandCuffed = not EscorthandCuffed
		handCuffed = not handCuffed
	else

	end
end)

RegisterNetEvent("menupolice:f_uncuff")
AddEventHandler('menupolice:f_uncuff', function()
	handCuffed = false
end)

AddEventHandler('menupolice:uncuff', function(target)
	if PhandCuffed then
		PhandCuffed = false
	else
		DrawNotif("Aucun civil à proximité n'est menotté")
	end
end)

AddEventHandler('menupolice:consultwanted', function()
	TriggerServerEvent("wanted:getWanted")
end)

AddEventHandler('menupolice:seizeillegalweapons', function(target)
	if target ~= -1 then
	TriggerServerEvent("menupolice:seizeillegalweapons_s",GetPlayerServerId(VMenu.target))
	Wait(3000)
	TriggerEvent("itinerance:notif", "~r~ Les armes ont été saisie")
	else
		TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas de cible")
	end
end)

AddEventHandler('menupolice:seizeweapons', function(target)
	if target ~= -1 then
	Citizen.Trace('ICI')
	TriggerServerEvent("menupolice:seizeweapons_s",GetPlayerServerId(VMenu.target))
	Wait(3000)
	TriggerEvent("itinerance:notif", "~r~ Les armes ont été saisie")
	else
		TriggerEvent("itinerance:notif", "~r~ Vous n'avez pas de cible")
	end
end)

RegisterNetEvent("menupolice:f_seizeillegalweapons")
AddEventHandler('menupolice:f_seizeillegalweapons', function(target)
	        for _, arme in ipairs(arme_illegal) do
			Wait(1)
			Citizen.Trace(arme)
            RemoveWeaponFromPed(GetPlayerPed(-1),GetHashKey(arme))
			Wait(10)
			TriggerServerEvent('menupolice:delillegalweapon',arme)
			Wait(100)
			end
end)

RegisterNetEvent("menupolice:f_seizeweapons")
AddEventHandler('menupolice:f_seizeweapons', function(target)
			Citizen.Trace('ICI2')
			for _, arme in ipairs(all_arme) do
			Wait(1)
			Citizen.Trace(arme)
            RemoveWeaponFromPed(GetPlayerPed(-1),GetHashKey(arme))
			Wait(10)
			end
			TriggerServerEvent('menupolice:delweapon')
end)

local showIdPolice = false

RegisterNetEvent("menupolice:f_verifp")
AddEventHandler("menupolice:f_verifp", function(name, tel, job, police, entreprise, permis, permisArme, permisBateau, permisPilote)
	showIdPolice = true
		Citizen.Wait(0)
		if (showIdPolice == true) then
			TriggerEvent("itinerance:notif", "~h~Carte d'identité")
			TriggerEvent("itinerance:notif", "~b~Nom: ~w~" ..name)
			TriggerEvent("itinerance:notif", "~b~Numéro de téléphone: ~w~" ..tel)
			if tonumber(job) == 1 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Sans emploi")
			elseif tonumber(job) == 2 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Nettoyeur de piscines")
			elseif tonumber(job) == 3 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Éboueur")
			elseif tonumber(job) == 4 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Mineur")
			elseif tonumber(job) == 5 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Chauffeur de taxi")
			elseif tonumber(job) == 6 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Livreur de bois")
			elseif tonumber(job) == 7 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Livreur de citerne")
			elseif tonumber(job) == 8 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Livreur de conteneur")
			elseif tonumber(job) == 9 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Livreur de médicament")
			elseif tonumber(job) == 10 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Policier")
			elseif tonumber(job) == 11 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Fossoyeur")
			elseif tonumber(job) == 12 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Préposé à la morgue")
			elseif tonumber(job) == 13 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Ambulancier")
			elseif tonumber(job) == 14 then
				TriggerEvent("itinerance:notif", "~y~Métier: ~w~Gouverneur")
			else
				TriggerEvent("itinerance:notif", "~y~Métier: ~r~Erreur")
			end
			-- elseif entreprise >= 1 then
				-- if entreprise == 1 then
					-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~y~Métier: ~w~" ..job.. " - Stagiaire", 255, 255, 255, 255, 6, 1)
				-- elseif entreprise == 2 then
					-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~y~Métier: ~w~" ..job.. " - Employé", 255, 255, 255, 255, 6, 1)
				-- elseif entreprise == 3 then
					-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~y~Métier: ~w~" ..job.. " - Chef de service", 255, 255, 255, 255, 6, 1)
				-- elseif entreprise == 4 then
					-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~y~Métier: ~w~" ..job.. " - Directeur", 255, 255, 255, 255, 6, 1)
				-- elseif entreprise == 5 then
					-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~y~Métier: ~w~" ..job.. " - Comptable", 255, 255, 255, 255, 6, 1)
				-- elseif entreprise == 6 then
					-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~y~Métier: ~w~" ..job.. " - PDG", 255, 255, 255, 255, 6, 1)
				-- end
			-- DrawAdvancedText(0.874000000000001, 0.338, 0.005, 0.0028, 0.4, "~g~Permis de conduire (points): ~w~" ..permis, 255, 255, 255, 255, 6, 1)
			--if tonumber(permisArme) == 0 then
				--TriggerEvent("itinerance:notif", "~g~Permis de port d'armes: ~r~Non")
			--elseif tonumber(permisArme) == 1 then
				--TriggerEvent("itinerance:notif", "~g~Permis de port d'armes: ~g~Oui")
			--else
				--TriggerEvent("itinerance:notif", "~g~Permis de port d'armes: ~r~Erreur")
			--end
			-- if permisArme == 0 then
				-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~g~Permis de port d'armes: ~r~Non", 255, 255, 255, 255, 6, 1)
			-- elseif permisArme == 1 then
				-- DrawAdvancedText(0.874000000000001, 0.318, 0.005, 0.0028, 0.4, "~g~Permis de port d'armes: ~g~Oui", 255, 255, 255, 255, 6, 1)
			-- end
			-- if permisBateau == 0 then
				-- DrawAdvancedText(0.874000000000001, 0.378, 0.005, 0.0028, 0.4, "~g~Permis bateau: ~r~Non", 255, 255, 255, 255, 6, 1)
			-- elseif permisBateau == 1 then
				-- DrawAdvancedText(0.874000000000001, 0.378, 0.005, 0.0028, 0.4, "~g~Permis bateau: ~g~Oui", 255, 255, 255, 255, 6, 1)
			-- end
			-- if permisPilote == 0 then
				-- DrawAdvancedText(0.874000000000001, 0.398, 0.005, 0.0028, 0.4, "~g~Permis de pilote: ~r~Non", 255, 255, 255, 255, 6, 1)
			-- elseif permisPilote == 1 then
				-- DrawAdvancedText(0.874000000000001, 0.398, 0.005, 0.0028, 0.4, "~g~Permis de pilote: ~g~Oui", 255, 255, 255, 255, 6, 1)
			-- end
		end
end)

RegisterNetEvent("menupolice:f_verifpermis")
AddEventHandler("menupolice:f_verifpermis", function(target, permisv, permism, permisvel, permisc, permisb, permish, permisgun)
	if tonumber(permisgun) == 1 then
	   TriggerEvent("itinerance:notif", "Permis de port d'arme ~g~Validé")
	elseif tonumber(permisgun) == 0 then
	   TriggerEvent("itinerance:notif", "Permis de port d'arme ~r~ Non Validé")
	else 
	   TriggerEvent("itinerance:notif", "Permis de port d'arme ~r~ ERREUR")
	end
    if tonumber(permisv) == 1 then
	    TriggerEvent("itinerance:notif", "Permis de conduire ~g~Validé")
    elseif tonumber(permisv) == 0 then
	    TriggerEvent("itinerance:notif", "Permis de conduire ~r~Non Validé")
	else 
	   TriggerEvent("itinerance:notif", "Permis de conduire ~r~ ERREUR")
	end
	if tonumber(permism) == 1 then
	    TriggerEvent("itinerance:notif", "Permis de Moto ~g~Validé")
    elseif tonumber(permism) == 0 then
	    TriggerEvent("itinerance:notif", "Permis de Moto ~r~Non Validé")
	else 
	   TriggerEvent("itinerance:notif", "Permis de Moto ~r~ ERREUR")	
	end
	if tonumber(permisvel) == 1 then
	    TriggerEvent("itinerance:notif", "Permis de Vélo ~g~Validé")
    elseif tonumber(permisvel) == 0 then
	    TriggerEvent("itinerance:notif", "Permis de Vélo ~r~Non Validé")
	else 
	   TriggerEvent("itinerance:notif", "Permis de Vélo ~r~ ERREUR")	
    end
    if tonumber(permisc) == 1 then
	    TriggerEvent("itinerance:notif", "Permis de Poids Lourds ~g~Validé") 
    elseif tonumber(permisc) == 0 then
	    TriggerEvent("itinerance:notif", "Permis de Poids Lourds ~r~Non Validé") 
	else 
	   TriggerEvent("itinerance:notif", "Permis de Poids Lourds ~r~ ERREUR")	
	end
	if tonumber(permisb) == 1 then
	    TriggerEvent("itinerance:notif", "Permis de Bateau ~g~Validé") 
    elseif tonumber(permisb) == 0 then
	    TriggerEvent("itinerance:notif", "Permis de Bateau ~r~Non Validé") 
	else 
	   TriggerEvent("itinerance:notif", "Permis de Bateau ~r~ ERREUR")		
	end
	if tonumber(permish) == 1 then
	    TriggerEvent("itinerance:notif", "Permis d'hélicoptère ~g~Validé") 
    elseif tonumber(permish) == 0 then
	    TriggerEvent("itinerance:notif","Permis d'hélicoptère ~r~Non Validé")	
    else 
	   TriggerEvent("itinerance:notif", "Permis d'hélicoptère ~r~ ERREUR")		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if showIdPolice == true then
			Citizen.Wait(10000)
			showIdPolice = false
		end
	end
end)

function getPlayerID(source)
	return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

RegisterServerEvent("menupermis:getpermis_s")
AddEventHandler("menupermis:getpermis_s", function()
    local player = getPlayerID(source)
	MySQL.Async.fetchAll("SELECT * FROM user_licence WHERE identifier = @name",{['@name'] = player}, function(result)
	TriggerClientEvent("menupermis:f_getpermis", source, tonumber(result[1].permisv), tonumber(result[1].permism), tonumber(result[1].permisvel), tonumber(result[1].permisc), tonumber(result[1].permisb), tonumber(result[1].permish), tonumber(result[1].permisgun))
	end)
end)

--megaphone = 0

--RegisterNetEvent("menupolice:megaphone")
--AddEventHandler("menupolice:megaphone", function()
  -- 	if megaphone = 0 then
	--   TriggerEvent("vmenu:anim" ,"rbh_2a_mcs_2_p7-0", "prop_megaphone_01-0")
	  -- Wait(250)
	  -- NetworkSetTalkerProximity(30.001)
	  -- DrawNotif("Vous parlez dans un ~b~mégaphone")
	  -- megaphone = 1
	--else
	  -- NetworkSetTalkerProximity(5.001)
	  -- DrawNotif("Vous parlez ~b~normalement")
	  -- megaphone = 0
	--end)	
--end)