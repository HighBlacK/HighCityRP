require "resources/mysql-async/lib/MySQL"

RegisterServerEvent("dropitem:itemscoords_s")
AddEventHandler("dropitem:itemscoords_s", function()
    local result = MySQL.Async.execute("SELECT * FROM `items_dropped", function(result)
	for _, v in ipairs(result) do
        t = {["name"] = v.name, ["id"] = v.id}
        table.insert(itemdropped, tonumber(v.id), t)
    end
    TriggerClientEvent("dropitem:getitemscoords", source, itemdropped) 
	end)
end)

RegisterServerEvent("dropitem:drop_s")
AddEventHandler("dropitem:drop_s", function(itemid, qty, x, y, z)
    MySQL.Async.execute("INSERT INTO `items_dropped` VALUES (@item_id, @quantity, @x, @y, @z)", {['@item_id'] = itemid, ['@quantity'] = qty, ['@x'] = x, ['@y'] = y, ['@z'] = z})   
	end
end)

RegisterServerEvent("dropitem:take_s")
AddEventHandler("dropitem:take_s", function(itemid, qty, x, y, z)
    MySQL.Async.execute("DELETE FROM `items_dropped WHERE (@item_id, @quantity, @x, @y, @z)", {['@item_id'] = itemid, ['@quantity'] = qty, ['@x'] = x, ['@y'] = y, ['@z'] = z})
end)
