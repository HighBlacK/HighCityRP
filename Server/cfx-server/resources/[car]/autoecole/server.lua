--[[Info]]--

require "resources/mysql-async/lib/MySQL"



--[[Register]]--

RegisterServerEvent("ply_autoecole:GetLicences")
RegisterServerEvent("ply_autoecole:CheckForPermis")



--[[Function]]--

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function licenceID(permis_id)  
    local permis_id = permis_id
    local user = getPlayerID(source)
    return MySQL.Sync.fetchScalar("SELECT licence_id FROM user_licence WHERE identifier=@identifier and licence_id=@licence_id",{['@identifier'] = user, ['@licence_id'] = permis_id})
end



--[[Local/Global]]--

permis = {}



--[[Events]]--

AddEventHandler("ply_autoecole:GetLicences", function()
    permis = {}
    local user = getPlayerID(source)    
    local theme = "Conduire"
    MySQL.Async.fetchAll("SELECT * FROM autoecole",{}, function(data)
        for _, v in ipairs(data) do
            t = {["name"] = v.name, ["id"] = v.id}
            table.insert(permis, tonumber(v.id), t)
        end
        TriggerClientEvent("ply_autoecole:GetLicences", source, permis) 
    end)
end)

AddEventHandler("ply_autoecole:CheckForPermis", function(permis_id)
    local user = getPlayerID(source)    
    local permis_id = permis_id
    local licence_id = licenceID(permis_id) 
    if licence_id > 0 then
        TriggerClientEvent("ply_autoecole:StartPermisFalse", source)
    else
        MySQL.Async.fetchAll("SELECT * FROM autoecole WHERE id = @id",{['@id'] = permis_id}, function(data)
            TriggerClientEvent("ply_autoecole:StartPermisTrue", source)
        end)
    end
end)

RegisterServerEvent("ply_autoecole:SetLicence")
AddEventHandler("ply_autoecole:SetLicence", function()
    local user = getPlayerID(source)
    MySQL.Async.execute("INSERT INTO user_licence (identifier) VALUES (@identifier)",{['@identifier'] = user}, function(data)
    end)
end)

RegisterServerEvent("ply_autoecole:Userlicencev")
AddEventHandler("ply_autoecole:Userlicencev", function(permisv)
	local user = getPlayerID(source)
	permisv = permisv
	MySQL.Async.fetchAll("UPDATE user_licence SET `permisv`=@value WHERE identifier = @identifier", {['@value'] = permisv, ['@identifier'] = user})
end)

RegisterServerEvent("ply_autoecole:Userlicencem")
AddEventHandler("ply_autoecole:Userlicencem", function(permism)
	local user = getPlayerID(source)
	permism = permism
	MySQL.Async.fetchAll("UPDATE user_licence SET `permism`=@value WHERE identifier = @identifier", {['@value'] = permism, ['@identifier'] = user})
end)

RegisterServerEvent("ply_autoecole:Userlicencevel")
AddEventHandler("ply_autoecole:Userlicencevel", function(permisvel)
	local user = getPlayerID(source)
	permisvel = permisvel
	MySQL.Async.fetchAll("UPDATE user_licence SET `permisvel`=@value WHERE identifier = @identifier", {['@value'] = permisvel, ['@identifier'] = user})
end)

RegisterServerEvent("ply_autoecole:Userlicencec")
AddEventHandler("ply_autoecole:Userlicencec", function(permisc)
	local user = getPlayerID(source)
	permisc = permisc
	MySQL.Async.fetchAll("UPDATE user_licence SET `permisc`=@value WHERE identifier = @identifier", {['@value'] = permisc, ['@identifier'] = user})
end)

RegisterServerEvent("ply_autoecole:Userlicenceb")
AddEventHandler("ply_autoecole:Userlicenceb", function(permisb)
	local user = getPlayerID(source)
	permisb = permisb
	MySQL.Async.fetchAll("UPDATE user_licence SET `permisb`=@value WHERE identifier = @identifier", {['@value'] = permisb, ['@identifier'] = user})
end)

RegisterServerEvent("ply_autoecole:Userlicenceh")
AddEventHandler("ply_autoecole:Userlicenceh", function(permish)
	local user = getPlayerID(source)
	permish = permish
	MySQL.Async.fetchAll("UPDATE user_licence SET `permish`=@value WHERE identifier = @identifier", {['@value'] = permish, ['@identifier'] = user})
end)

RegisterServerEvent("ply_autoecole:moneyupdate")
AddEventHandler("ply_autoecole:moneyupdate", function(money)
    TriggerEvent('es:getPlayerFromId', source, function(user)
	user:addMoney((money))
	end)
end)
RegisterServerEvent("ply_autoecole:getCash_s")
AddEventHandler("ply_autoecole:getCash_s", function()
  TriggerEvent('es:getPlayerFromId', source, function(user)
    if (user) then
      local argent = user:getMoney()
      TriggerClientEvent("ply_autoecole:f_getCash", source, argent)
    else
      TriggerEvent("es:desyncMsg")
    end
  end)
end)