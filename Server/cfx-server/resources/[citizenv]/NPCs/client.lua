local firstspawn = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)	
		if firstspawn == 0 then
		   local model = 0x15F8700D  -- fem cop armurerie
           RequestModel(model)
           while (not HasModelLoaded(model)) do
           Wait(1)
           end
	       CreatePed(1, model, 454.25, -980.187, 30.6896, 95.88, true, false)
	    end
		firstspawn = 1
	end	
end)
--IsPlayerTargettingEntity(player, entity)
--IsPlayerTargettingAnything(player)
--IsPlayerFreeAimingAtEntity(character, aimedEntity)
--IsPlayerFreeAiming(player)

--HasPedGotWeapon(ped, weaponHash, p2)
--RemoveWeaponFromPed(ped, weaponHash)
--GiveWeaponToPed(ped, weaponHash, ammoCount, p4, equipNow)
--GiveWeaponObjectToPed(weaponObject, ped
--GiveWeaponComponentToWeaponObject(weaponObject, addonHash)
--GetSelectedPedWeapon(ped)
--GetMaxRangeOfCurrentPedWeapon(ped)
--GetMaxAmmoInClip(ped, weaponHash, p2)
--GetMaxAmmo(ped, weaponHash)
--GetCurrentPedWeaponEntityIndex(ped)
--GetCurrentPedWeapon(ped, p2)
--GetAmmoInClip(ped, weaponHash)
--SetPedDropsWeapon(ped)
--SetPedDropsInventoryWeapon(ped, p1, p2, p3, p4, p5)
--GetAmmoInPedWeapon(ped, weaponhash)