require "resources/mysql-async/lib/MySQL"

local items = {}

RegisterServerEvent("inventory:getItems_s")
AddEventHandler("inventory:getItems_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    items = {}
    local player = user.identifier

    MySQL.Async.fetchAll("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = @username", {
      ['@username'] = player
    }, function (result)
      if (result) then
        for _, v in ipairs(result) do
          t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle }
          table.insert(items, tonumber(v.item_id), t)
        end
      end
      TriggerClientEvent("inventory:getItems", source, items)
    end)
  end)
end)

RegisterServerEvent("inventory:giveItem_s")
AddEventHandler("inventory:giveItem_s", function(netID, id, name, quantity)
  TriggerEvent('es:getPlayerFromId', netID, function(user)
	if (user) then
		TriggerClientEvent("inventory:refresh", source)
		TriggerClientEvent("player:looseItem", source, id, quantity)
		TriggerClientEvent("inventory:giveItem_f", netID, id, quantity)
		TriggerClientEvent("itinerance:notif", source, "Vous avez donné ~g~" .. quantity .. " " ..name.. "~w~.")
		TriggerClientEvent("inventory:menuItem", source, target, id, name, tonumber(quantity)-1)
		TriggerClientEvent("itinerance:notif", netID, "Vous avez reçu ~g~" .. quantity .. " " ..name.. "~w~.")
	end
  end)
end)

RegisterServerEvent("inventory:setItem_s")
AddEventHandler("inventory:setItem_s", function(qty, item, iprice, name)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      local rounded = tonumber(iprice)
      if(tonumber(rounded) <= tonumber(user:money)) then
        user:removeMoney((rounded))
        MySQL.Async.execute("INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES (@player, @item, @qty)",{
          ['@player'] = player,
          ['@item'] = item,
          ['@qty'] = qty
        })
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Vous avez acheté : ~g~".. name)
        CancelEvent()
      else
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~r~Vous n'avez pas assez d'argent")
        CancelEvent()
      end
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:setItem_sf")
AddEventHandler("inventory:setItem_sf", function(item, qty)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      MySQL.Async.execute(
        "INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES (@player, @item, @qty)", {
        ['@player'] = user.identifier,
        ['@item'] = item,
        ['@qty'] = qty
      })
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:updateQuantity_s")
AddEventHandler("inventory:updateQuantity_s", function(qty, id, iprice, name)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      local rounded = tonumber(iprice)
      if(tonumber(rounded) <= tonumber(user:money)) then
        user:removeMoney((rounded))
        MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", {
          ['@username'] = player,
          ['@qty'] = tonumber(qty),
          ['@id'] = tonumber(id) }
        )
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Vous avez acheté : ~g~".. name)
        CancelEvent()
      else
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~r~Vous n'avez pas assez d'argent!")
        CancelEvent()
      end
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:updateQuantity_sf")
AddEventHandler("inventory:updateQuantity_sf", function(qty, id)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
      CancelEvent()
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:checkMoney")
AddEventHandler("inventory:checkMoney", function(iprice)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local rounded = tonumber(iprice)
      if(tonumber(rounded) <= tonumber(user:money)) then
        TriggerClientEvent("inventory:MoneyOk", source, true)
      else
        TriggerClientEvent("inventory:MoneyOk", source, false)
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~r~Vous n'avez pas assez d'argent!")
        CancelEvent()
      end
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:checkMoneyDistrib")
AddEventHandler("inventory:checkMoneyDistrib", function(iprice)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local rounded = tonumber(iprice)
      if(tonumber(rounded) <= tonumber(user:money)) then
        TriggerClientEvent("inventory:MoneyOk", source, true)
        user:removeMoney((rounded))
      else
        TriggerClientEvent("inventory:MoneyOk", source, false)
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~r~Vous n'avez pas assez d'argent!")
        CancelEvent()
      end
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:sell_s")
AddEventHandler("inventory:sell_s", function(id, qty, iprice, name)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
      user:addMoney(tonumber(iprice))
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:sell_sf")
AddEventHandler("inventory:sell_sf", function(id, qty, iprice)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id", { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
      --TriggerEvent('bank:addDcash', source, iprice)
      user:addDMoney(tonumber(iprice))
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)

RegisterServerEvent("inventory:reset_s")
AddEventHandler("inventory:reset_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local player = user.identifier
      MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username", { ['@username'] = player, ['@qty'] = 0 })
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)
