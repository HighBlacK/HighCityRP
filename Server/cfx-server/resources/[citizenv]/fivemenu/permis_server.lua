require "resources/mysql-async/lib/MySQL"

function getPlayerID(source)
	return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
	for _, v in ipairs(id) do
		return v
	end
end

RegisterServerEvent("menupermis:getpermis_s")
AddEventHandler("menupermis:getpermis_s", function()
    local player = getPlayerID(source)
	MySQL.Async.fetchAll("SELECT * FROM user_licence WHERE identifier = @name",{['@name'] = player}, function(result)
	TriggerClientEvent("menupermis:f_getpermis", source, tonumber(result[1].permisv), tonumber(result[1].permism), tonumber(result[1].permisvel), tonumber(result[1].permisc), tonumber(result[1].permisb), tonumber(result[1].permish), tonumber(result[1].permisgun))
	end)
end)