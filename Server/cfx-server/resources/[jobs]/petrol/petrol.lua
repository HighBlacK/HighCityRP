----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Price = 8000
local qte = 0
local Position = {
    Recolet={x=609.002,y=2853.23,z=39.9908, distance=10},
    traitement={x=2708.83,y=1522.88,z=24.5075, distance=15},
    vente={x=-961.326,y=-1966.14,z=13.1916, distance=10},
	camion={x=2748.18 ,y=3590.91 ,z=24.4975 , distance=5}
}

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

function ShowInfo(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

local ShowMsgtime = { msg = "", time = 0 }
local petrole = 0
local essence = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

Citizen.CreateThread(function()
    while true do
     Citizen.Wait(0)
      if ShowMsgtime.time ~= 0 then
        drawTxt(ShowMsgtime.msg, 1, 2, 0.5, 0.9, 0.6, 255, 255, 255, 255)
        ShowMsgtime.time = ShowMsgtime.time - 1
      end
    end
end)

Citizen.CreateThread(function()

    if DrawBlipTradeShow then
        --SetBlipTrade(140, "Puis de pétrole", 2, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)
        SetBlipTrade(436, "Rafinerie", 5, Position.traitement.x, Position.traitement.y, Position.traitement.z)
        --SetBlipTrade(67, "Camion citerne", 5, Position.camion.x, Position.camion.y, Position.camion.z)
        SetBlipTrade(415, "Compagnie de pétrole", 5, Position.vente.x, Position.vente.y, Position.vente.z)
    end

    while true do
      Citizen.Wait(0)
        if DrawMarkerShow then
            DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
            DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
            DrawMarker(1, Position.camion.x, Position.camion.y, Position.camion.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
            DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPos = GetEntityCoords(GetPlayerPed(-1))

        local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
        if not IsInVehicle() then
            if distance < Position.Recolet.distance then
                ShowInfo('Appuyer sur ~INPUT_CONTEXT~ pour puiser du ~b~pétrole', 0)
                if IsControlJustPressed(1, 38) then
                    TriggerEvent("player:getQuantity", 49)
                    petrole = qte
                    Wait(100)
                    if petrole ~= 0 then
                        ShowMsgtime.msg = "Vous puisez du~b~pétrole"
                        ShowMsgtime.time = 250
                        TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                        Wait(2500)
                        ShowMsgtime.msg = '~g~+1 ~b~Baril de pétrole'
                        ShowMsgtime.time = 150
                        TriggerEvent("player:receiveItem", 49, 1) --9
                    else
                        ShowMsgtime.msg = '~r~ Inventaire plein !'
                        ShowMsgtime.time = 150
		    		end
				end	
            end
        end

    -------------------------Bloc Pour rajouter un traitement-------------------------------------------
        local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
        if not IsInVehicle() then
            if distance < Position.traitement.distance then
                ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour rafiner le ~b~pétrole', 0)
                if IsControlJustPressed(1, 38) then
                    TriggerEvent("player:getQuantity", 49)
                    petrole = qte
                    Wait(100)
                    if petrole ~= 0 then
                        ShowMsgtime.msg = 'Rafinage du ~b~pétrole'
                        ShowMsgtime.time = 250
                        TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                        Wait(2500)
                        ShowMsgtime.msg = "~g~ + 1 ~b~Baril d'essence"
                        ShowMsgtime.time = 150
                        TriggerEvent("player:looseItem", 49, 1)
                        TriggerEvent("player:receiveItem", 51, 1)			  
                    else
                        ShowMsgtime.msg = "~r~ Vous n'avez plus de pétrole !"
                        ShowMsgtime.time = 150
		     		end
                end
            end
        end	
    -------------------------Fin Du Bloc Pour rajouter un traitement-------------------------------------------
	    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
        if not IsInVehicle() then
            if distance < Position.vente.distance then
                ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour vendre de ~b~l\'essence', 0)
                if IsControlJustPressed(1, 38) then
                    TriggerEvent("player:getQuantity", 51)
                    essence = qte
                    Wait(100)
                    if essence ~= 0 then
                        ShowMsgtime.msg = "Vous vendez un ~b~baril d'essence"
                        ShowMsgtime.time = 250
                        TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                        Wait(2500)
                        ShowMsgtime.msg = '~g~ +'..Price..'$'
                        ShowMsgtime.time = 150
                        TriggerEvent("inventory:sell",0, 1, 51, Price, "")
                    else
                        ShowMsgtime.msg = "~r~ Vous n'avez plus d'essence !"
                        ShowMsgtime.time = 150
			    	end
                end
            end
        end
    end)
end)

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)
  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end)
