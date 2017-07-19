require "resources/mysql-async/lib/MySQL"

local max_number_weapons = 6 --maximum number of weapons that the player can buy. Weapons given at spawn doesn't count.
local cost_ratio = 100 --Ratio for withdrawing the weapons. This is price/cost_ratio = cost.

RegisterServerEvent('menuwea:CheckMoneyForWea')
AddEventHandler('menuwea:CheckMoneyForWea', function(weapon,price)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			if (tonumber(user.money) >= tonumber(price)) then
				local player = user.identifier
				local nb_weapon = 0
				MySQL.Async.fetchAll("SELECT * FROM user_weapons WHERE identifier = @username",{['@username'] = player}, function (result)
					if result then
						for k,v in ipairs(result) do
							nb_weapon = nb_weapon + 1
						end
					end
					if (tonumber(max_number_weapons) > tonumber(nb_weapon)) then
						-- Pay the shop (price)
						user:removeMoney((price))
						MySQL.Async.execute("INSERT INTO user_weapons (identifier,weapon_model,withdraw_cost) VALUES (@username,@weapon,@cost)",
						{['@username'] = player, ['@weapon'] = weapon, ['@cost'] = (price)/cost_ratio})
						TriggerClientEvent('menuweashop:giveWeapon', weapon, 250)
						-- Trigger some client stuff
						TriggerClientEvent("citizenv:notify", source, "CHAR_AMMUNATION", 1, "AMMUNATION", false, "Amuse toi bien avec ces joujous!\n")
					else
						TriggerClientEvent("citizenv:notify", source, "CHAR_AMMUNATION", 1, "AMMUNATION", false, "Tu as atteint la limite d armes ! (max: "..max_number_weapons..")\n")
					end
				end)
			else
				-- Inform the player that he needs more money
				TriggerClientEvent("citizenv:notify", source, "CHAR_AMMUNATION", 1, "AMMUNATION", false, "Reviens quand t'auras l'argent !\n")
			end
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)
