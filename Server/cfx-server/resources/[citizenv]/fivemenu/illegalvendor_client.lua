RegisterNetEvent("illegalvendor:weapon")
AddEventHandler("illegalvendor:weapon", function()
    VMenu.ResetMenu(30, "", "default")
	VMenu.AddFunc(30, "Retour", "vmenu:openMenu", {30}, "Accéder")
	VMenu.AddTxT(30, "Pistolets Mitrailleurs")
	for _, item in pairs(inv_array_illegalsmg) do
		VMenu.AddFunc(30, item.name, "inventory:buy", {1, item.id, item.price, item.name}, "Prix: " .. item.price .. "$")
	end
	VMenu.AddTxT(30, "Fusils à pompe")
	for _, item in pairs(inv_array_illegalshotgun) do
		VMenu.AddFunc(30, item.name, "inventory:buy", {1, item.id, item.price, item.name}, "Prix: " .. item.price .. "$")
	end
	VMenu.AddTxT(30, "Fusils d'assaut")
	for _, item in pairs(inv_array_illegalrifles) do
		VMenu.AddFunc(30, item.name, "inventory:buy", {1, item.id, item.price, item.name}, "Prix: " .. item.price .. "$")
	end
	VMenu.AddTxT(30, "Armes de jet")
	for _, item in pairs(inv_array_illegalthrown) do
		VMenu.AddFunc(30, item.name, "inventory:buy", {1, item.id, item.price, item.name}, "Prix: " .. item.price .. "$")
	end
end)