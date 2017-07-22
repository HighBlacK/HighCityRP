RegisterNetEvent("menupermis:Permis")
AddEventHandler("menupermis:Permis", function(target)
    VMenu.permis = true
    VMenu.ResetMenu(98, "", "default")
	Wait(100)
    VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddFunc(98, "Permis", "menupermis:getpermis", {}, "Accéder")
	VMenu.AddFunc(98, "Licences", "menupermis:work", {},"Accéder")
end)

RegisterNetEvent("menupermis:getpermis")
AddEventHandler("menupermis:getpermis", function()
   TriggerServerEvent("menupermis:getpermis_s")
end)

RegisterNetEvent("menupermis:f_getpermis")
AddEventHandler("menupermis:f_getpermis", function(permisv, permism, permisvel, permisc, permisb, permish, permisgun)
    VMenu.permis = true
    VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menupermis:Permis", {}, "Retour")
	if tonumber(permisgun) == 1 then
	   VMenu.AddTxT(98,"Permis de port d'arme ~g~Validé")
	elseif tonumber(permisgun) == 0 then
	   VMenu.AddTxT(98,"Permis de port d'arme ~r~ Non Validé")
	else 
	   VMenu.AddTxT(98,"Permis de port d'arme ~r~ ERREUR")
	end
    if tonumber(permisv) == 1 then
	    VMenu.AddTxT(98,"Permis de conduire ~g~Validé")
    elseif tonumber(permisv) == 0 then
	    VMenu.AddTxT(98,"Permis de conduire ~r~Non Validé")
	else 
	   VMenu.AddTxT(98,"Permis de conduire ~r~ ERREUR")
	end
	if tonumber(permism) == 1 then
	    VMenu.AddTxT(98,"Permis de Moto ~g~Validé")
    elseif tonumber(permism) == 0 then
	    VMenu.AddTxT(98,"Permis de Moto ~r~Non Validé")
	else 
	   VMenu.AddTxT(98,"Permis de Moto ~r~ ERREUR")	
	end
	if tonumber(permisvel) == 1 then
	    VMenu.AddTxT(98,"Permis de Vélo ~g~Validé")
    elseif tonumber(permisvel) == 0 then
	    VMenu.AddTxT(98,"Permis de Vélo ~r~Non Validé")
	else 
	   VMenu.AddTxT(98,"Permis de Vélo ~r~ ERREUR")	
    end
    if tonumber(permisc) == 1 then
	    VMenu.AddTxT(98,"Permis de Poids Lourds ~g~Validé") 
    elseif tonumber(permisc) == 0 then
	    VMenu.AddTxT(98,"Permis de Poids Lourds ~r~Non Validé") 
	else 
	   VMenu.AddTxT(98,"Permis de Poids Lourds ~r~ ERREUR")	
	end
	if tonumber(permisb) == 1 then
	    VMenu.AddTxT(98,"Permis de Bateau ~g~Validé") 
    elseif tonumber(permisb) == 0 then
	    VMenu.AddTxT(98,"Permis de Bateau ~r~Non Validé") 
	else 
	   VMenu.AddTxT(98,"Permis de Bateau ~r~ ERREUR")		
	end
	if tonumber(permish) == 1 then
	    VMenu.AddTxT(98,"Permis d'hélicoptère ~g~Validé") 
    elseif tonumber(permish) == 0 then
	    VMenu.AddTxT(98,"Permis d'hélicoptère ~r~Non Validé")	
    else 
	   VMenu.AddTxT(98,"Permis d'hélicoptère ~r~ ERREUR")		
	end
end)

RegisterNetEvent("menupermis:work")
AddEventHandler("menupermis:work", function(target)
    VMenu.permis = true
	TriggerServerEvent('vmenu:updateUser', 98)
    VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menupermis:Permis", {}, "Retour")
end)