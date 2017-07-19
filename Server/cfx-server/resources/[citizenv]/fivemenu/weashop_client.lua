RegisterNetEvent("menuweashop:melee")
AddEventHandler("menuweashop:melee", function()
    VMenu.ResetMenu(22, "", "armurerie")
	VMenu.AddFunc(22, "Retour", "vmenu:openMenu", {22}, "Accéder")
	for _, item in pairs(inv_array_meleeweapon) do
		VMenu.AddFunc(menu, item.name, "inventory:buy", 1, item.id, item.price, item.name}, "Prix: " .. item.price .. "$")
	end
end)

RegisterNetEvent("menuweashop:pistol")
AddEventHandler("menuweashop:pistol", function()
    VMenu.ResetMenu(22, "", "armurerie")
	VMenu.AddFunc(22, "Retour", "vmenu:openMenu", {22}, "Accéder")
	for _, item in pairs(inv_array_pistolweapon) do
		VMenu.AddFunc(menu, item.name, "inventory:buy", 1, item.id, item.price, item.name}, "Prix: " .. item.price .. "$")	
end)

RegisterNetEvent("menuweashop:checkfordollar")
AddEventHandler("menuweashop:checkfordollar", function(model, price)
    local weapon = model
	local money = price
    TriggerServerEvent('menuwea:CheckMoneyForWea', weapon, money)
end)

RegisterNetEvent('menuweashop:giveWeapon')
AddEventHandler('menuweashop:giveWeapon', function(name, delay)
	Citizen.CreateThread(function()
		local weapon = GetHashKey(name)
        Wait(delay)
        local hash = GetHashKey(name)
        GiveWeaponToPed(GetPlayerPed(-1), weapon, 1000, 0, false)
    end)
end)

	--VMenu.AddFunc(22, "Couteau", "menuweashop:checkfordollar", {WEAPON_Knife, 400}, "Prix: 400$")
	--VMenu.AddFunc(22, "Marteau", "menuweashop:checkfordollar", {WEAPON_HAMMER, 500}, "Prix: 500$")
	--VMenu.AddFunc(22, "Batte", "menuweashop:checkfordollar", {WEAPON_Bat, 750}, "Prix: 750$")
	--VMenu.AddFunc(22, "Bouteille", "menuweashop:checkfordollar", {WEAPON_Bottle, 300}, "Prix: 300$")
	--VMenu.AddFunc(22, "Poignard", "menuweashop:checkfordollar", {WEAPON_Dagger, 2000}, "Prix: 2000$")
	--VMenu.AddFunc(22, "Hachette", "menuweashop:checkfordollar", {WEAPON_Hatchet, 750}, "Prix: 750$")
	--VMenu.AddFunc(22, "Poing Américain", "menuweashop:checkfordollar", {WEAPON_KNUCKLE, 7500}, "Prix: 7500$")
	--VMenu.AddFunc(22, "Lampe de poche", "menuweashop:checkfordollar", {WEAPON_Flashlight, 5750}, "Prix: 5750$")
	--VMenu.AddFunc(22, "Pied de biche", "menuweashop:checkfordollar", {WEAPON_Crowbar, 30000}, "Prix: 30000$")
	
	--VMenu.AddFunc(22, "Pistolet", "menuweashop:checkfordollar", {WEAPON_Pistol, 25000}, "Prix: 25000$")
	--VMenu.AddFunc(22, "Pistol Cal 50", "menuweashop:checkfordollar", {WEAPON_PISTOL50, 40000}, "Prix: 40000$")
	--VMenu.AddFunc(22, "Pistolet Lourd", "menuweashop:checkfordollar", {WEAPON_HeavyPistol, 345000}, "Prix: 345000$")
	--VMenu.AddFunc(22, "Pistolet Vintage", "menuweashop:checkfordollar", {WEAPON_VintagePistol, 375000}, "Prix: 375000$")
	--VMenu.AddFunc(22, "Revolver", "menuweashop:checkfordollar", {WEAPON_Revolver, 19000}, "Prix: 19000$")
	--VMenu.AddFunc(22, "Pistolet de détresse", "menuweashop:checkfordollar", {WEAPON_FlareGun, 5750}, "Prix: 5750$")