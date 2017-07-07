INSTALLATION

Français
POUR LE LALIFE GAMEMODE: https://github.com/ldlac/La_LifeRP

----ETAPE 1----
AJOUTER LES KITS DE REPARATION A VOTRE BASE DE DONNEE(MySQL):
       INSERT INTO `items` VALUES ('ITEM ID', 'Kits de réparations', '0', '0');  ----REMPLACER ITEM ID---
	   
----ETAPE 2----
PLACER LE FICHIER repairkit_client.lua DANS LE DOSSIER fivemenu ET OUVRER LE POUR LE CONFIGURER SELON LES INSTRUCTIONS
AJOUTER LA LIGNE client_script 'repairkit_client.lua' DANS LE FICHIER __resource.lua

----ETAPE 3----
MODIFIER LE FICHIER inventory.lua:
DANS inv_array_legal AJOUTEZ LA LIGNE SUIVANTE: {name="Kit de réparation", id=ITEM ID , price=PRIX , value=0}, ----REMPLACER ITEM ID ET PRIX----SI VOUS AVEZ UN JOB DE DEPANEUR SUR VOTRE SERVER JE CONSEILLE UN PRIX ELEVE

----ETAPE 4----
MODIFIER LE FICHIER inventory_client.lua
AJOUTER APRES LA FONCTION drawTxt LES LIGNES SUIVANTES:

local ShowMsgtime = { msg = "", time = 0 }

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxt(ShowMsgtime.msg, 1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

AJOUTER A L'EVENT "inventory:useItem" les lignes suivantes:

	elseif id == ITEM ID then     ----REMPLACER ITEM ID---
	    if not IsInVehicle() then
	        TriggerEvent("repair:repairkit")
		else
		    ShowMsgtime.msg = '~r~Vous ne pouvez par réparer le véhicule de l\'intérieur'
            ShowMsgtime.time = 250
			TriggerEvent("player:receiveItem", ITEM ID, 1)  ----REMPLACER ITEM ID----PERMET DE RECUPERER LE REPAIRKIT QUI A ETE CONSOME AUTOMATIQUEMENT
		end

----ETAPE 5----
PLACER LE FICHIER repair.ogg DANS LE DOSSIER client_base\lock\client\html\sounds 
AJOUTER LA LIGNE file 'lock/client/html/sounds/repair.ogg' DANS LE FICHIER client_base\__resource.lua

English
FOR LALIFE GAMEMODE: https://github.com/ldlac/La_LifeRP

----STEP 1----
ADD REPAIR KITS ON YOUR MySQL DATABASE:
       INSERT INTO `items` VALUES ('ITEM ID', 'Repair Kit', '0', '0');  ----REPLACE ITEM ID---
	   
----STEP 2----
PLACE THE FILE repairkit_client.lua ON THE FOLDER fivemenu AND OPEN IT TO CONFIGURE IT
ADD THE LINE client_script 'repairkit_client.lua' ON THE FILE __resource.lua

----STEP 3----
MODIFY THE FILE inventory.lua:
ON inv_array_legal ADD THIS FOLLOWING LINE: {name="Repair Kit", id=ITEM ID , price=PRICE, value=0}, ----REPLACE ITEM ID AND PRICE----IF YOU HAVE A REPAIRMAN JOB ON YOUR SERVER I ADVICE YOU TO SET A HIGH PRICE

----STEP 4----
MODIFY THE FILE inventory_client.lua
ADD AFTER THE FUNCTION drawTxt THE FOLLOWING LINES:

local ShowMsgtime = { msg = "", time = 0 }

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ShowMsgtime.time ~= 0 then
      drawTxt(ShowMsgtime.msg, 1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
      ShowMsgtime.time = ShowMsgtime.time - 1
    end
  end
end)

ADD TO THE EVENT "inventory:useItem" THE FOLLOWING LINES:

	elseif id == ITEM ID then     ----REMPLACER ITEM ID---
	    if not IsInVehicle() then
	        TriggerEvent("repair:repairkit")
		else
		    ShowMsgtime.msg = '~r~Vous ne pouvez par réparer le véhicule de l\'intérieur'
            ShowMsgtime.time = 250
			TriggerEvent("player:receiveItem", ITEM ID, 1)  ----REMPLACER ITEM ID----PERMET DE RECUPERER LE REPAIRKIT QUI A ETE CONSOME AUTOMATIQUEMENT
		end

----STEP 5----
PLACE THE FILE repair.ogg ON THE FOLDER client_base\lock\client\html\sounds 
ADD THE LINE file 'lock/client/html/sounds/repair.ogg' ON THE FILE client_base\__resource.lua