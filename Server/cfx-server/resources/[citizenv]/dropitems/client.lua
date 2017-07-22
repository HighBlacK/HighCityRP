itemsdropped = {}

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent("dropitem:getitemscoords")
AddEventHandler("dropitem:getitemscoords", function(x1,y1,z1, item, qty)
    local x = x1
	local y = y1
	local x = x1
	local itemid = item 
	local qte = qty
	itemdropped = (itemid, qte, x, y, z) 
end)

Citizen.CreateThread(function()
	while true do
	   	Wait(1)
		local player = GetPlayerPed(-1)
		TriggerServerEvent("dropitem:itemscoords_s", itemdropped.x, itemdropped.y, itemdropped.z)
		if GetDistanceBetweenCoords(player.x, player.y, player.z, itemdropped.x, itemdropped.y, itemdropped.z) < 1 then
		    ShowInfo("Appuyer sur ~INPUT_CONTEXT~ pour rammaser l'objet", 0)
			if IsControlJustPressed(0,38) then
			    TriggerEvent("player:receiveItem", itemdropped.itemid, 1)
				TriggerServerEvent("dropitem:takeitem", itemdropped.itemid, itemdropped.qte, itemdropped.x, itemdropped.y, itemdropped.z)
				if itemdropped.itemid == 1 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Bouteille d'eau (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 2 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Sandwich (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 3 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Poulet Roti (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 4 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Chanvre (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 5 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Cannabis roulé (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 6 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Feuille de coka (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 7 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Coka (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 8 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Coka (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 9 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Ephedrine (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 10 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Matière illégale 30% (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 11 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Matière illégale 66% (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 12 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Meth (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 13 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Organe (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 14 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Organe emballé (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 15 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Organe analysé (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 16 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~r~Organe livrable (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 17 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Cuivre (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 18 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Fer (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 19 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Diamants (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 20 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Cables (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 21 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Fil de fer (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 22 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Diamants taillés (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 23 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Roche (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 24 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Décoration (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 25 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Poisson (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 26 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Corps (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 27 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Corps inhumé (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 28 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Soda (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 29 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Soupe de légumes Bio (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 30 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Tarte aux fraises (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 31 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Café (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 32 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Pizza (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 33 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Filet de thon (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 34 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Carotte (" .. itemdropped.qte.. "")
				elseif itemdropped.itemid == 35 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Carotte rapée (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 36 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Pomme de terre (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 37 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Purée (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 38 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Tomate (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 39 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Concentré de tomate (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 40 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Blé (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 41 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Pain (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 42 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Pain (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 43 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Croissant (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 44 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Chocolatine (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 45 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Pain aux raisins (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 46 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Donut (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 47 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Eclair au chocolat( " .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 48 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Gateau d'anniversaire (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 49 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Pétrole (" .. itemdropped.qte.. ")")
                elseif itemdropped.itemid == 50 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Gaz naturel (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 51 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Essence (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 52 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Gaz brut (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 53 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Kit de réparation (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 54 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Biere (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 55 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Tequila (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 56 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Whiskey (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 57 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Vodka (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 58 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Vin (" .. itemdropped.qte.. ")")
				elseif itemdropped.itemid == 59 then				
			        DrawNotif("L'objet est ~g~rammasé~s~: ~n~~y~Champagne (" .. itemdropped.qte.. ")")					
				else
				    DrawNotif("L'objet est ~g~rammasé: ~n~(" .. itemdropped.qte.. ")")
                end					
			end
		end
	end
end)