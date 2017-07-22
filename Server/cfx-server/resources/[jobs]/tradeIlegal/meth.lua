----------------------------------------------------
--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Price = 185
local Position = {
    -- VOS POINTS ICI
    Recolet={x=334.84967041016,y=-1083.2797851563,z=29.435209274292, distance=3},
    traitement={x=1390.51037597656,y=3609.09399414063,z=38.9419288635254, distance=1},
    traitement2={x=1389.52404785156,y=3604.15209960938,z=38.9419288635254, distance=1},
    traitement3={x=1394.45300292969,y=3601.97973632813,z=38.94189453125, distance=1},
    vente={x=1443.0411376953,y=6333.455078125,z=23.868028640747, distance=3},
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
local weedcount = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  weedcount = itemQty
end)

local methserver = 0

RegisterNetEvent("f_drogue:getmeth")
AddEventHandler("f_drogue:getmeth", function(itemQty)
  methserver = itemQty
end)

Citizen.CreateThread(function()
    while true do
                    Citizen.Wait(0)
      if ShowMsgtime.time ~= 0 then
        drawTxt(ShowMsgtime.msg, 0, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
        ShowMsgtime.time = ShowMsgtime.time - 1
      end
    end
end)

Citizen.CreateThread(function()

    if DrawBlipTradeShow then
        --SetBlipTrade(140, "~g~ Voler ~b~Matière première illégale", 2, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)
        --SetBlipTrade(50, "~g~ Traitement ~b~Matière illégale", 1, Position.traitement.x, Position.traitement.y, Position.traitement.z)
        --SetBlipTrade(50, "~g~ Traitement ~b~Matière illégale", 1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z)
        --SetBlipTrade(50, "~g~ Traitement ~b~Matière illégale", 1, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z)
        --SetBlipTrade(277, "~g~ Vendre ~b~Meth", 1, Position.vente.x, Position.vente.y, Position.vente.z)
    end

    while true do
                    Citizen.Wait(0)
       if DrawMarkerShow then
          --DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.traitement.x, Position.traitement.y, Position.traitement.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 25, 0, 0, 2, 0, 0, 0, 0)
          --DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
       end
    end
end)

Citizen.CreateThread(function()
    while true do
                    Citizen.Wait(0)
        local playerPos = GetEntityCoords(GetPlayerPed(-1))

        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.Recolet.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour ramasser', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 4, function(data)
                   --     weedcount = data.count
                   -- end)
				  TriggerServerEvent('drogue:getmeth')
				  Wait(500)
                  TriggerEvent("player:getQuantity", 9)
                  Wait(100)
                  Citizen.Wait(1)
				if methserver > 0 then
                  if weedcount < 30 then
                          ShowMsgtime.msg = '~g~ Prendre ~b~Ephedrine '
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Ephedrine '
                          ShowMsgtime.time = 150
                          TriggerEvent("player:receiveItem", 9, 1) --9
						  TriggerServerEvent('drogue:remmeth')
                  else
                          ShowMsgtime.msg = '~r~ Inventaire plein !'
                          ShowMsgtime.time = 150
                  end
				else
					ShowMsgtime.msg = '~r~ Le champs est vide revenez plus tard !'
                    ShowMsgtime.time = 150
				end
             end
          end
        end
-------------------------Bloc Pour rajouter un traitement-------------------------------------------
        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement.x, Position.traitement.y, Position.traitement.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour traiter ~b~Matière illégale', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 6, function(data)
                   --      weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 9) --9
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Traitement ~b~Matière illégale'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Matière illégale 33%'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 9, 1) --9
                          TriggerEvent("player:receiveItem", 10, 1) --10
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas de Matière illégale !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end

		local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement2.x, Position.traitement2.y, Position.traitement2.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement2.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour traiter ~b~Matière illégale', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 6, function(data)
                   --      weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 10)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Traitement ~b~Matière illégale'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~Matière illégale 66%'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 10, 1) --10
                          TriggerEvent("player:receiveItem", 11, 1) --11
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas de Matière illégale 33% !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end

		local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitement3.x, Position.traitement3.y, Position.traitement3.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.traitement3.distance then
             ShowInfo('~b~Appuyer sur ~g~E~b~ pour traiter ~b~Matière illégale', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 6, function(data)
                   --      weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 11)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Traitement ~b~Matière illégale traiter'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ + 1 ~b~ Meth'
                          ShowMsgtime.time = 150

                          TriggerEvent("player:looseItem", 11, 1) --11
                          TriggerEvent("player:receiveItem", 12, 1) --12
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas de Matière illégale 66% !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end
-------------------------Fin Du Bloc Pour rajouter un traitement-------------------------------------------
        local distanceWeedFarm = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
        if not IsInVehicle() then
          if distanceWeedFarm < Position.vente.distance then
             ShowInfo('~b~ Appuyer sur ~g~E~b~ pour vendre', 0)
             if IsControlJustPressed(1, 38) then
                   weedcount = 0
                   -- TriggerEvent("player:getQuantity", 7, function(data)
                   --         weedcount = data.count
                   -- end)
                  TriggerEvent("player:getQuantity", 12)
                  Wait(100)
                  if weedcount ~= 0 then
                          ShowMsgtime.msg = '~g~ Vendre ~b~Meth'
                          ShowMsgtime.time = 250
                          TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
                          Wait(2500)
                          ShowMsgtime.msg = '~g~ +'..Price..'$'
                          ShowMsgtime.time = 150
                          TriggerEvent("player:sellItem", 12, Price) --12
                  else
                          ShowMsgtime.msg = "~r~ Vous n'avez pas de Meth !"
                          ShowMsgtime.time = 150
                  end
             end
           end
        end

    end
end)

function SetBlipTrade(id, text, color, x, y, z)
    local Blip = AddBlipForCoord(x, y, z)

    SetBlipSprite(Blip, id)
    SetBlipColour(Blip, color)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(Blip)
end
