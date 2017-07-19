RegisterNetEvent("publicfunds:gestion")
AddEventHandler("publicfunds:gestion", function()
	VMenu.publicfunds = true
	VMenu.ResetMenu(23, "", "default")
    VMenu.AddFunc(23, "Fermer", "vmenu:closeMenu", {}, "Fermer le menu")
    VMenu.AddFunc(23, "Voir solde", "publicfunds:getsolde", {}, "Afficher solde")
	VMenu.AddFunc(23, "Ajouter un montant", "publicfunds:addmoney", {}, "Accèder")
	VMenu.AddFunc(23, "Retirer un montant", "publicfunds:removemoney", {}, "Accèder")
	--VMenu.AddNum1000(23, "Choisir un montant", "Ajmont", 0, 1000000000, "Choisir montant")
	--VMenu.AddFunc(98, "Ajouter un montant", "coffrelspd:ajoutsolde", {getOpt("Ajmont")}, "Ajouter le montant défini")
	--VMenu.AddFunc(23, "Retirer un montant", "coffrelspd:retirersolde", {getOpt("Ajmont")}, "Retirer le montant défini")
end)

RegisterNetEvent("publicfunds:addmoney")
AddEventHandler("publicfunds:addmoney", function ()
	DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
        
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
       	TriggerServerEvent('caisse_publique:ajoutsolde', result)
    end
end)

RegisterNetEvent("publicfunds:removemoney")
AddEventHandler("publicfunds:removemoney", function ()
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