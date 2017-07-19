ITEMS = {}

local MoneyOk = false
local giveItemConfirmed = false

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

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

function new(qty, id, price, name)
	TriggerServerEvent("inventory:setItem_s", qty, id, price, name)
	TriggerServerEvent("inventory:getItems_s")
end

function newf(item, quantity)
	TriggerServerEvent("inventory:setItem_sf", item, quantity)
	TriggerServerEvent("inventory:getItems_s")
end

function delete(arg)
	local itemId = tonumber(arg[1])
	local qty = arg[2]
	local item = ITEMS[itemId]
	item.quantity = item.quantity - qty
	TriggerServerEvent("inventory:updateQuantity_sf", item.quantity, itemId)
	if giveItemConfirmed == true then
		TriggerEvent("vmenu:MainMenuOG", source)
	end
	giveItemConfirmed = false
	--TriggerServerEvent("inventory:getItems_s")
end

function add(arg)
	if #arg == 4 then
		local itemId = tonumber(arg[1])
		local qty = arg[2]
		local price = arg[3]
		local name = arg[4]
		local item = ITEMS[itemId]
		item.quantity = item.quantity + qty
		TriggerServerEvent("inventory:updateQuantity_s", item.quantity, itemId, price, name)
	else
		local itemId = tonumber(arg[1])
		local qty = arg[2]
		local item = ITEMS[itemId]
		item.quantity = item.quantity + qty
		TriggerServerEvent("inventory:updateQuantity_sf", item.quantity, itemId)
	end
end

function sell(arg)
	if #arg == 3 then
		local itemId = tonumber(arg[1])
		local price = arg[2]
		local name = arg[3]
		local item = ITEMS[itemId]
		item.quantity = item.quantity - 1
		TriggerServerEvent("inventory:sell_s", itemId, item.quantity, price, name)
	else
		local itemId = tonumber(arg[1])
		local price = arg[2]
		local item = ITEMS[itemId]
		item.quantity = item.quantity - 1
		TriggerServerEvent("inventory:sell_sf", itemId, item.quantity, price)
	end
end
----------- EVENT FROM MENU TARGET TARGET!!!

AddEventHandler("inventory:buy", function(target, qty, id, price, name) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	local price = price * qty
	TriggerServerEvent("inventory:checkMoney", price)
	Wait(200)
	if MoneyOk then
		item = tonumber(id)
		if (ITEMS[item] == nil) then
			new(qty, item, price, name)
		else
			add({ item, qty, price, name })
		end
		MoneyOk = false
	end
end)

AddEventHandler("inventory:sell", function(target, qty, id, price, name) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	item = tonumber(id)
	if (ITEMS[item].quantity > 0) then
		sell({ item, price, name })
	end
end)

RegisterNetEvent("inventory:menuItem")
AddEventHandler("inventory:menuItem", function(target, id, name, quantity)
    VMenu.inventory = true
    VMenu.ResetMenu(98, "", "default")
    Wait(100)
	if id == 1 then
        VMenu.AddTxT(98,"~y~Bouteille d'eau")
	elseif id == 2 then
        VMenu.AddTxT(98,"~y~Sandwich")
	elseif id == 3 then
        VMenu.AddTxT(98,"~y~Poulet Roti")
	elseif id == 4 then
        VMenu.AddTxT(98,"~r~Chanvre")
	elseif id == 5 then
        VMenu.AddTxT(98,"~r~Cannabis roulé")
	elseif id == 6 then
        VMenu.AddTxT(98,"~r~Feuille de coka")
	elseif id == 7 then
        VMenu.AddTxT(98,"~r~Coka")
	elseif id == 8 then
        VMenu.AddTxT(98,"~r~Coka")
	elseif id == 9 then
        VMenu.AddTxT(98,"~r~Ephedrine")
	elseif id == 10 then
        VMenu.AddTxT(98,"~r~Matière illégale")
	elseif id == 11 then
        VMenu.AddTxT(98,"~r~Matière illégale")
	elseif id == 12 then
        VMenu.AddTxT(98,"~r~Meth")
	elseif id == 13 then
        VMenu.AddTxT(98,"~r~Organe")
	elseif id == 14 then
        VMenu.AddTxT(98,"~r~Organe Emballé")
	elseif id == 15 then
        VMenu.AddTxT(98,"~r~Organe Analysé")
	elseif id == 16 then
        VMenu.AddTxT(98,"~r~Organe Livrable")
	elseif id == 17 then
        VMenu.AddTxT(98,"~g~Cuivre")
	elseif id == 18 then
        VMenu.AddTxT(98,"~g~Fer")
	elseif id == 19 then
        VMenu.AddTxT(98,"~g~Diamants")
	elseif id == 20 then
        VMenu.AddTxT(98,"~g~Cables")
	elseif id == 21 then
        VMenu.AddTxT(98,"~g~~g~Fil de fer")
	elseif id == 22 then
        VMenu.AddTxT(98,"~g~Diamants taillés")
	elseif id == 23 then
        VMenu.AddTxT(98,"~g~Roche")
	elseif id == 24 then
        VMenu.AddTxT(98,"~g~Décoration")
	elseif id == 25 then
        VMenu.AddTxT(98,"~g~Poisson")
	elseif id == 26 then
        VMenu.AddTxT(98,"~g~Corps")
	elseif id == 27 then
        VMenu.AddTxT(98,"~g~Corps traité")
	elseif id == 28 then
        VMenu.AddTxT(98,"~y~Soda")
	elseif id == 29 then
        VMenu.AddTxT(98,"~y~Soupe de légumes BIO")
	elseif id == 30 then
        VMenu.AddTxT(98,"~y~Tarte aux fraises")
	elseif id == 31 then
        VMenu.AddTxT(98,"~y~Café")
	elseif id == 32 then
        VMenu.AddTxT(98,"~y~Pizza")
	elseif id == 33 then
        VMenu.AddTxT(98,"~y~Filet de thon")
	elseif id == 34 then
        VMenu.AddTxT(98,"~g~Carotte")
	elseif id == 35 then
        VMenu.AddTxT(98,"~g~Carotte rapée")
	elseif id == 36 then
        VMenu.AddTxT(98,"~g~Pomme de terre")
	elseif id == 37 then
        VMenu.AddTxT(98,"~g~Purée")
	elseif id == 38 then
        VMenu.AddTxT(98,"~g~Tomate")
	elseif id == 39 then
        VMenu.AddTxT(98,"~g~Concentré de tomate")
	elseif id == 40 then
        VMenu.AddTxT(98,"~g~Blé")
	elseif id == 41 then
        VMenu.AddTxT(98,"~g~Pain")
	elseif id == 42 then
        VMenu.AddTxT(98,"~y~Pain")
	elseif id == 43 then
        VMenu.AddTxT(98,"~y~Croissant")
	elseif id == 44 then
        VMenu.AddTxT(98,"~y~Chocolatine")
	elseif id == 45 then
        VMenu.AddTxT(98,"~y~Pain au raisin")
	elseif id == 46 then
        VMenu.AddTxT(98,"~y~Donut")
	elseif id == 47 then
        VMenu.AddTxT(98,"~y~Eclair au chocolat")
	elseif id == 48 then
        VMenu.AddTxT(98,"~y~Gateau d'anniversaire")
	elseif id == 49 then
        VMenu.AddTxT(98,"~g~Pétrole")
	elseif id == 50 then
        VMenu.AddTxT(98,"~g~Gaz Naturel")
	elseif id == 51 then
        VMenu.AddTxT(98,"~g~Essence")
	elseif id == 52 then
        VMenu.AddTxT(98,"~g~Gaz brut")
	elseif id == 53 then
        VMenu.AddTxT(98,"~y~Kit de réparation")
	elseif id == 54 then
        VMenu.AddTxT(98,"~p~Bière")
	elseif id == 55 then
        VMenu.AddTxT(98,"~p~Tequila")
	elseif id == 56 then
        VMenu.AddTxT(98,"~p~Whiskey")
	elseif id == 57 then
        VMenu.AddTxT(98,"~p~Vodka")
	elseif id == 58 then
        VMenu.AddTxT(98,"~p~Vin")
	elseif id == 59 then
        VMenu.AddTxT(98,"~p~Champagne")
	elseif id == 60 then
        VMenu.AddTxT(98,"~b~Couteau")
	elseif id == 61 then
        VMenu.AddTxT(98,"~b~Marteau")
	elseif id == 62 then
        VMenu.AddTxT(98,"~b~Batte")
	elseif id == 63 then
        VMenu.AddTxT(98,"~b~Bouteille")
	elseif id == 64 then
        VMenu.AddTxT(98,"~b~Poignard")
	elseif id == 65 then
        VMenu.AddTxT(98,"~b~Poing américain")
	elseif id == 66 then
        VMenu.AddTxT(98,"~b~Lampe de poche")
	elseif id == 67 then
        VMenu.AddTxT(98,"~b~Pistolet")
	elseif id == 68 then
        VMenu.AddTxT(98,"~b~Pistol Cal.50")
	elseif id == 69 then
        VMenu.AddTxT(98,"~b~Pistolet Lourd")
	elseif id == 70 then
        VMenu.AddTxT(98,"~b~Pistolet Vintage")
	elseif id == 71 then
        VMenu.AddTxT(98,"~b~Revolver")
	elseif id == 72 then
        VMenu.AddTxT(98,"~b~Pistolet de détresse")
	elseif id == 73 then
        VMenu.AddTxT(98,"~r~Uzi")
	elseif id == 74 then
        VMenu.AddTxT(98,"~r~TEC-9")
	elseif id == 75 then
        VMenu.AddTxT(98,"~r~Magpul PDR")
	elseif id == 76 then
        VMenu.AddTxT(98,"~r~MPX")
	elseif id == 77 then
        VMenu.AddTxT(98,"~r~Fusil à Pompe")
	elseif id == 78 then
        VMenu.AddTxT(98,"~r~Fusil à canon scié")
	elseif id == 79 then
        VMenu.AddTxT(98,"~r~AK-47")
	elseif id == 80 then
        VMenu.AddTxT(98,"~r~TAR-21")
	elseif id == 81 then
        VMenu.AddTxT(98,"~r~QBZ-95")
	elseif id == 82 then
        VMenu.AddTxT(98,"~r~Gaz BZ")
	elseif id == 83 then
        VMenu.AddTxT(98,"~r~Molotov")
	elseif id == 84 then
        VMenu.AddTxT(98,"~r~Extincteur")
	elseif id == 85 then
        VMenu.AddTxT(98,"~r~Jerrican")
	elseif id == 86 then
        VMenu.AddTxT(98,"~r~Flare")
	end
	VMenu.AddTxT(98,"Quantité posédée: (" .. quantity .. ")")	
    VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddFunc(98, "Utiliser", "inventory:useItem", {id}, "Utiliser l'objet")
    VMenu.AddFunc(98, "Donner", "inventory:giveItem", {id, name, quantity}, "Donner l'objet à un autre citoyen")
    VMenu.AddFunc(98, "~r~Jeter", "inventory:dropItem", {id, name, quantity}, "~r~Jeter l'objet")
end)

AddEventHandler("inventory:useItem", function(target, id) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	local useItem = {}
	local value = 0
	for _, val in ipairs(inv_array_legal) do
		if id == val.id then
			value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if id == 1 then
		if IsInVehicle() then
			TriggerEvent("food:vdrink", value)
		else
			TriggerEvent("food:drink", useItem)
		end
    elseif id == 28 then
		if IsInVehicle() then
			TriggerEvent("food:vdrink", value)
		else
			TriggerEvent("food:drink", useItem)
		end
    elseif id == 31 then
		if IsInVehicle() then
			TriggerEvent("food:vdrink", value)
		else
			TriggerEvent("food:drink", useItem)
		end
	elseif id == 53 then
	    if not IsInVehicle() then
	        TriggerEvent("repair:repairkit")
		else
		    ShowMsgtime.msg = '~r~Vous ne pouvez par réparer le véhicule de l\'intérieur'
            ShowMsgtime.time = 250
			TriggerEvent("player:receiveItem", 53, 1)
		end
	elseif (id == 42 or id == 43 or id == 44 or id == 45 or id == 46 or id == 47 or id == 48 or id == 30) then
	    TriggerEvent("inventory:useItemB", target, id)
	elseif (id == 54 or id == 55 or id == 56 or id == 57 or id == 58 or id == 59) then
	    TriggerEvent("inventory:useItemA", target, id)
	elseif (id == 17 or id == 18 or id == 19 or id == 20 or id == 21 or id == 22 or id == 23 or id == 24 or id == 25 or id == 26 or id == 27 or id == 34 or id == 35 or id == 36 or id == 37 or id == 38 or id == 39 or id == 40 or id == 41 or id == 49 or id == 50 or id == 51 or id == 52) then
	    TriggerEvent("inventory:useItemL", target, id)
	elseif (id == 4 or id == 5 or id == 6 or id == 7 or id == 8 or id == 9 or id == 10 or id == 11 or id == 12 or id == 13 or id == 14 or id == 15 or id == 16) then
	    TriggerEvent("inventory:useItemI", target, id)
	elseif (id == 60 or id == 61 or id == 62 or id == 63 or id == 64 or id == 65 or id == 66) then
        TriggerEvent("inventory:useItemGunM", target, id)	
	elseif (id == 67 or id == 68 or id == 69 or id == 70 or id == 71 or id == 72) then
	    TriggerEvent("inventory:useItemGunP", target, id)
	elseif (id == 73 or id == 74 or id == 75 or id == 76) then
	    TriggerEvent("inventory:useItemGuniSMG", target, id)
	elseif (id == 77 or id == 78) then
	    TriggerEvent("inventory:useItemGuniSG", target, id)
	elseif (id == 79 or id == 80 or id == 81) then
	    TriggerEvent("inventory:useItemGuniAR", target, id)
	elseif (id == 82 or id == 83 or id == 84 or id == 85 or id == 86) then
	    TriggerEvent("inventory:useItemGuniT", target, id)
	else
		if IsInVehicle() then
			TriggerEvent("food:veat", value)
		else
			TriggerEvent("food:eat", useItem)
		end
	end	
	TriggerEvent("vmenu:MainMenuOG")
end)

AddEventHandler("inventory:useItemB", function(target, id)
	for _, val in ipairs(inv_array_boulangerie) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
    if IsInVehicle() then
		TriggerEvent("food:veat", value)
	else
		TriggerEvent("food:eat", useItem)
	end
end)

AddEventHandler("inventory:useItemL", function(target, id)
    for _, val in ipairs(inv_array) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
    if (id == 25 or id == 34 or id == 35 or id == 36 or id == 37 or id == 38 or id == 39 or id == 40 or id == 41) then
        if IsInVehicle() then
		    delete({ id, 1})
		    TriggerEvent("food:veat", value)
	    else
		    delete({ id, 1})
		    TriggerEvent("food:eat", useItem)
	    end
	else
        ShowMsgtime.msg = '~r~Vous ne pouvez pas utiliser cet objet'
        ShowMsgtime.time = 250
		TriggerEvent("player:receiveItem", id, 1)
	end
end)

AddEventHandler("inventory:useItemA", function(target, id)
    for _, val in ipairs(inv_array_alcool) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if id == 54 then
	    if IsInVehicle() then
		    TriggerEvent("food:vdrink", value)
		    TriggerClientEvent('alcool:drink', 0.05)
	    else
		    TriggerEvent("food:drink", useItem)
			TriggerClientEvent('alcool:drink', 0.05)
		end
	elseif id == 58 then
	    if IsInVehicle() then
		    TriggerEvent("food:vdrink", value)
			TriggerClientEvent('alcool:drink', 0.1)
	    else 
		    TriggerEvent("food:drink", useItem)
			TriggerClientEvent('alcool:drink', 0.1)
		end
    elseif id == 55 then
	    if IsInVehicle() then		    
		    TriggerEvent("food:vdrink", value)
			TriggerClientEvent('alcool:drink', 0.2)
	    else
		    TriggerEvent("food:drink", useItem)
			TriggerClientEvent('alcool:drink', 0.2)
		end
    elseif id == 56 then
	    if IsInVehicle() then
		    TriggerEvent("food:vdrink", value)
			TriggerClientEvent('alcool:drink', 0.3)
	    else
		    TriggerEvent("food:drink", useItem)
			TriggerClientEvent('alcool:drink', 0.3)
		end
    elseif id == 57 then
	    if IsInVehicle() then
		    TriggerEvent("food:vdrink", value)
			TriggerClientEvent('alcool:drink', 0.4)
	    else
		    TriggerEvent("food:drink", useItem)
			TriggerClientEvent('alcool:drink', 0.4)
		end
    elseif id == 59 then
        if IsInVehicle() then
		    TriggerEvent("food:vdrink", value)
		    TriggerClientEvent('alcool:drink', 0.5)			
	    else
		    TriggerEvent("food:drink", useItem)
		    TriggerClientEvent('alcool:drink', 0.5)			
		end	
	end
end)

AddEventHandler("inventory:useItemI", function(target, id)
    for _, val in ipairs(inv_array_illegal) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)

AddEventHandler("inventory:useItemGunM", function(target, id)
    for _, val in ipairs(inv_array_meleeweapon) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)

AddEventHandler("inventory:useItemGunP", function(target, id)
    for _, val in ipairs(inv_array_pistolweapon) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)

AddEventHandler("inventory:useItemGuniSMG", function(target, id)
    for _, val in ipairs(inv_array_illegalsmg) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)

AddEventHandler("inventory:useItemGuniSG", function(target, id)
    for _, val in ipairs(inv_array_illegalshotgun) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)

AddEventHandler("inventory:useItemGuniAR", function(target, id)
    for _, val in ipairs(inv_array_illegalrifles) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)


AddEventHandler("inventory:useItemGuniT", function(target, id)
    for _, val in ipairs(inv_array_illegalthrown) do
	    if id == val.id then
		    value = val.value
			useItem = val
		end
	end
	delete({ id, 1})
	if IsInVehicle() then
		TriggerEvent("food:vdrink", value)
	else
		TriggerEvent("food:drink", useItem)
	end
end)

--------    EVENT POUR LE GATHER DES RESSOURCES ILLÉGALES SANS PRICE

AddEventHandler("player:getQuantity", function(itemId)
	local _amount = 0
	_amount = ITEMS[tonumber(itemId)].quantity
	TriggerEvent("tradeill:cbgetQuantity", _amount)
end)

AddEventHandler("player:getQuantityMine", function(itemId)
	local _amount = 0
	_amount = ITEMS[tonumber(itemId)].quantity
	return _amount
end)


function getQuantity(itemId)
	return ITEMS[tonumber(itemId)].quantity
end

RegisterNetEvent("player:receiveItem")
AddEventHandler("player:receiveItem", function(item, quantity)
	item = tonumber(item)
	if (ITEMS[item] == nil) then
		newf(item, quantity)
	else
		add({ item, quantity})
	end
end)

RegisterNetEvent("inventory:refresh")
AddEventHandler("inventory:refresh", function()	
	giveItemConfirmed = true
end)

RegisterNetEvent("inventory:dropItem")
AddEventHandler("inventory:dropItem", function(target, id, name, quantity)
	TriggerEvent("player:looseItem", id, 1)
	TriggerEvent("itinerance:notif", "Vous avez jeté ~r~1" ..name.. "~w~.")
	giveItemConfirmed = true
	TriggerEvent("vmenu:MainMenuOG")
end)

RegisterNetEvent("player:looseItem")
AddEventHandler("player:looseItem", function(item, quantity)
	item = tonumber(item)
	if (ITEMS[item].quantity >= quantity) then
		delete({ item, quantity })
	end
end)

AddEventHandler("player:sellItem", function(item, price)
	item = tonumber(item)
	if (ITEMS[item].quantity > 0) then
		sell({ item, price })
	end
end)

AddEventHandler("item:reset", function()
	ITEMS = {}
	TriggerServerEvent("inventory:reset_s")
end)

RegisterNetEvent("inventory:giveItem_f")
AddEventHandler("inventory:giveItem_f", function(item, quantity)
	TriggerEvent("player:receiveItem", item, 1)
end)

--------- EVENT FROM SERVER NO TARGET

AddEventHandler("playerSpawned", function()
	Citizen.CreateThread(function()
		Wait(500)
		TriggerServerEvent('vmenu:lastChar')
		TriggerServerEvent("inventory:getItems_s")
		TriggerServerEvent('vmenu:updateUser', 98)
		TriggerServerEvent("poleemploi:getjobs")
		Wait(2500)
	end)
end)

RegisterNetEvent("inventory:getItems")
AddEventHandler("inventory:getItems", function(p_items) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	ITEMS = {}
	ITEMS = p_items
end)

RegisterNetEvent("inventory:MoneyOk")
AddEventHandler("inventory:MoneyOk", function(param) -- target = Dernier joueur à avoir parlé, pas besoin ici. Mais obligatoire !
	MoneyOk = param
end)

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end


RegisterNetEvent("inventory:removemenu")
AddEventHandler("inventory:removemenu", function()
	VMenu.inventory = true
	TriggerServerEvent("inventory:getItems_s")
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddSep(98, "~r~Attention: vous allez lacher ces objets")
	VMenu.AddNum(98, "Quantité", "qty", 1, 150, "Sélection")
	for ind, value in ipairs(ITEMS) do
		if value.quantity > 0 then
            VMenu.AddFunc(98, tostring(value.libelle), "player:looseItem", { ind, {getOpt("qty")}}, lang.menu.mainmenu.quantity .. tostring(value.quantity))
		end
	end
end)