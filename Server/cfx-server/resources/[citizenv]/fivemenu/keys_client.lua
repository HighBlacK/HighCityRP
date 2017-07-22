KEYS = {}


RegisterNetEvent("menukeys:keys")
AddEventHandler("menukeys:keys", function(target)
	--VMenu.keys = true
	TriggerServerEvent('vmenu:updateUser', 98)
    VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddSep(98, "Clées")
	for ind, value in ipairs(KEYS) do
        VMenu.AddFunc(98, tostring(),"menukeys:usekey", {ind}, )
		end
	end
end)

AddEventHandler("menukeys:usekey", function(key)
    VMenu.AddFunc(98, "Donner", "menukeys:givekeys", {key}, "Donner vos clées")
	VMenu.AddFunc(98, "Jeter", "menukeys:dropkeys", {}, "Attention! Vous jetez vos clées")
end)
