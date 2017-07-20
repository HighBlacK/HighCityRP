local affichemenu = true

RegisterNetEvent("publicfunds:gestion")
AddEventHandler("publicfunds:gestion", function()
    if affichemenu then
    	VMenu.ResetMenu(23, "", "default")
        VMenu.AddFunc(23, "Fermer", "vmenu:closeMenu", {23}, "Fermer le menu")
        VMenu.AddFunc(23, "Voir solde", "publicfunds:getsolde", {}, "Afficher solde")
    	VMenu.AddFunc(23, "Ajouter un montant", "publicfunds:addmoney", {}, "Accèder")
    	VMenu.AddFunc(23, "Retirer un montant", "publicfunds:removemoney", {}, "Accèder")
	else
	    TriggerEvent("vmenu:closeMenu", 23)
	end
end)

RegisterNetEvent("publicfunds:addmoney")
AddEventHandler("publicfunds:addmoney", function ()
    affichemenu = false
	TriggerEvent("publicfunds:gestion")
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(100);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
       	TriggerServerEvent('caisse_publique:ajoutsolde', result)
    end
end)

RegisterNetEvent("publicfunds:removemoney")
AddEventHandler("publicfunds:removemoney", function ()
    affichemenu = false
	TriggerEvent("publicfunds:gestion")
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
       	TriggerServerEvent('caisse_publique:retirersolde', result)
    end
end)

RegisterNetEvent("publicfunds:getsolde")
AddEventHandler("publicfunds:getsolde", function()
    TriggerServerEvent("caisse_publique:getsolde")
end)