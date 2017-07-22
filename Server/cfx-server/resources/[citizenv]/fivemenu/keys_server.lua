require "resources/mysql-async/lib/MySQL"

local keys = {}

RegisterServerEvent("menukeys:getkeys_s")
AddEventHandler("inventory:getItems_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    keys = {}
    local player = user.identifier

    MySQL.Async.fetchAll("SELECT * FROM user_vehicle JOIN items ON `user_vehicle`.`vehicle_name` = `keys`.`id` WHERE identifier = @username", {
      ['@username'] = player
    }, function (result)
      if (result) then
        for _, v in ipairs(result) do
          t = { ["price"] = v.price, ["name"] = v.name }
          table.insert(keys, tonumber(v.vehicle_name), t)
        end
      end
      TriggerClientEvent("menukeys:getkeys", source, items)
    end)
  end)
end)