require "resources/mysql-async/lib/MySQL"

function getoldalcool()
    local identifier = getPlayerID(source)
    local oldalcool = MySQL.Async.fetchAll("SELECT taux FROM alcoolrate WHERE identifier = @name", {['@name'] = identifier}, function (oldalcool)
	end)
	return oldalcool
end

function updatealcool(alcooltaux)
    local alcoolrate = alcooltaux
    local identifier = getPlayerID(source)
    MySQL.Async.execute("UPDATE alcoolrate SET `taux` = @newtaux WHERE `identifier` = @identifier", { ['@identifier'] = identifier, ['@newtaux'] = alcoolrate})
end

RegisterServerEvent("alcool:drink_s")
AddEventHandler("alcool:drink_s", function(alcool)
    local newalcool = alcool
	local oldalcool = getoldalcool()
	local alcooltaux = oldalcool+newalcool
	TriggerClientEvent("alcool:alcooleffect", alcooltaux)
	Wait(250)
	updatealcool(alcooltaux)
end)

RegisterServerEvent("alcool:death")
AddEventHandler("alcool:death", function()
    local identifier = getPlayerID(source)
    MySQL.Async.execute("UPDATE alcoolrate SET `taux` = @deathtaux WHERE `identifier` = @identifier", { ['@identifier'] = identifier, ['@deathtaux'] = 0})
	end
	TriggerClientEvent("alcool:alcooleffect", 0)
end)

RegisterServerEvent("alcool:zerorate")
AddEventHandler("alcool:zerorate", function()
    local identifier = getPlayerID(source)
    MySQL.Async.execute("UPDATE alcoolrate SET `taux` = @zerotaux WHERE `identifier` = @identifier", { ['@identifier'] = identifier, ['@zerotaux'] = 0})
end)