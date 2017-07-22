----------------------------------------------------
--A FAIRE
-- -Point pour ranger vehicule
-- -Check if veh is on place pas spawn autre veh
-- -Veh enregistré
-- -Blips apparaisent qu'on prend sa tenue.
-- -Tenue retirer sur meme point

--===================Aurelien=====================--
----------------------------------------------------
------------------------Lua-------------------------

local DrawMarkerShow = true
local DrawBlipTradeShow = true

-- -900.0, -3002.0, 13.0
-- -800.0, -3002.0, 13.0
-- -1078.0, -3002.0, 13.0

local Pricec = 750
local Pricep = 1000
local Pricet = 1250
local Priceb = 1500
local chance = 1
local qte = 0
local Position = {
  Recolet={x=2221.84,y=5132.88,z=55.2553, distance=10},
  traitementc={x=2890.42,y=4391.42,z=50.3389, distance=10},
  traitementp={x=906.076 ,y=3587.11 ,z=33.3849 ,distance=10},
  traitementt={x=-266.096 ,y=6068.29 ,z=31.4645 ,distance=10},
  traitementb={x=-581.744 ,y=-1780.65 ,z=22.623 ,distance=10},
  vente={x=-224.892,y=-271.751,z=49.02, distance=10},
  ventepain={x=336.016,y=-1019.24,z=29.2976, distance=4},
}

local Bliptraitementc
local Bliptraitementp
local Bliptraitementt
local Bliptraitementb

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
local carotte = 0
local patate= 0
local tomate = 0
local ble = 0

AddEventHandler("tradeill:cbgetQuantity", function(itemQty)
  qte = 0
  qte = itemQty
end)

local myjob = 0

RegisterNetEvent("fish:getJobs")
AddEventHandler("fish:getJobs", function(job)
  myjob = job
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
    SetBlipTrade(267, "~g~Port de pêche", 2, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z)
  --  SetBlipTrade(402, "Traitement de carottes", 2, Position.traitementc.x, Position.traitementc.y, Position.traitementc.z)
  --  SetBlipTrade(402, "Traitement de pommes de terre", 2, Position.traitementp.x, Position.traitementp.y, Position.traitementp.z)
  --  SetBlipTrade(402, "Traitement de tomates", 2, Position.traitementt.x, Position.traitementt.y, Position.traitementt.z)
	--SetBlipTrade(402, "Traitement de blé", 2, Position.traitementb.x, Position.traitementb.y, Position.traitementb.z)
    SetBlipTrade(52, "Supermaché", 1, Position.vente.x, Position.vente.y, Position.vente.z)
    --SetBlipTrade(403, "Boulanger", 5, Position.ventepain.x, Position.ventepain.y, Position.ventepain.z)
  end

 -- while true do
 --   Citizen.Wait(0)
 --   if DrawMarkerShow then
 --     DrawMarker(1, Position.Recolet.x, Position.Recolet.y, Position.Recolet.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
 --     DrawMarker(1, Position.traitementc.x, Position.traitementc.y, Position.traitementc.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
 --	  DrawMarker(1, Position.traitementp.x, Position.traitementp.y, Position.traitementp.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
--	  DrawMarker(1, Position.traitementt.x, Position.traitementt.y, Position.traitementt.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
--	  DrawMarker(1, Position.traitementb.x, Position.traitementb.y, Position.traitementb.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
 --     DrawMarker(1, Position.vente.x, Position.vente.y, Position.vente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
  --    DrawMarker(1, Position.ventepain.x, Position.ventepain.y, Position.ventepain.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 1.0, 0, 0, 255, 75, 0, 0, 2, 0, 0, 0, 0)
    --end
  --end
end)


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
    DrawMarker(1,2251.38,5155.5,57.8871,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
		if GetDistanceBetweenCoords(2243.6,5154.26,57.8869,GetEntityCoords(LocalPed())) < 1 then
		  ShowInfo('Appuyer sur ~INPUT_CONTEXT~ pour ranger votre ~b~tenue de travail',0)
		    if IsControlJustPressed(1,38) then
              TriggerServerEvent("vmenu:lastChar")
			  removeBlip()
			end  
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
        ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour ~b~pécher', 0)
        if IsControlJustPressed(1, 38) then
          TriggerServerEvent("poleemploi:getjobs")
          Wait(100)
          if myjob == 18 then
            TriggerEvent("player:getQuantity", 34)
            carotte = qte
            TriggerEvent("player:getQuantity", 36)
            patate = qte
            TriggerEvent("player:getQuantity", 38)
            tomate = qte
            TriggerEvent("player:getQuantity", 40)
            ble = qte
            -- TriggerEvent("player:getQuantity", 4, function(data)
            --     weedcount = data.count
            -- end)
            local chance_mat = math.random(chance,100)
            Wait(100)
            Citizen.Wait(1)
            if (carotte+patate+tomate+ble) < 30 and chance_mat <=50  then
              ShowMsgtime.msg = 'Vous étes en train de récolter'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Carotte'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 34, 1)
              chance = chance + 1

            elseif (carotte+patate+tomate+ble) < 30 and chance_mat <=80  then
              ShowMsgtime.msg = 'Vous étes en train de récolter'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Pomme de terre'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 36, 1)
              chance = chance + 1

            elseif (carotte+patate+tomate+ble) < 30 and chance_mat <= 98 then
              ShowMsgtime.msg = 'Vous étes en train de récolter'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Tomate'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 38, 1)
              chance = chance + 1

            elseif (carotte+patate+tomate+ble) < 30 and chance_mat <= 100  then
              ShowMsgtime.msg = 'Vous étes en train de récolter'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Blé'
              ShowMsgtime.time = 150
              TriggerEvent("player:receiveItem", 40, 1)
              chance = 1

            else
              ShowMsgtime.msg = '~r~ Inventaire plein !'
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
    -------------------------Bloc Pour rajouter un traitement-------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitementc.x, Position.traitementc.y, Position.traitementc.z, true)
    if not IsInVehicle() then
        if distance < Position.traitementc.distance then
          ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour traiter les ~b~carottes', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
            TriggerEvent("player:getQuantity", 34)
            carotte = qte
            --TriggerEvent("player:getQuantity", 36)
            --pomme de terre = qte
            --TriggerEvent("player:getQuantity", 38)
            --tomate = qte
            --TriggerEvent("player:getQuantity", 40)
            --blé = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if carotte ~= 0 then
              ShowMsgtime.msg = 'Traitement des ~b~carottes'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Carrote rapée'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 34, 1)
              TriggerEvent("player:receiveItem", 35, 1)
			  
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucune carotte !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
	
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitementp.x, Position.traitementp.y, Position.traitementp.z, true)
    if not IsInVehicle() then
        if distance < Position.traitementp.distance then
          ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour traiter les ~b~pommes de terre', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
            --TriggerEvent("player:getQuantity", 34)
            --carotte = qte
            TriggerEvent("player:getQuantity", 36)
            patate = qte
            --TriggerEvent("player:getQuantity", 38)
            --tomate = qte
            --TriggerEvent("player:getQuantity", 40)
            --blé = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if patate ~= 0 then
              ShowMsgtime.msg = 'Traitement des ~b~pommes de terre'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Purée'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 36, 1)
              TriggerEvent("player:receiveItem", 37, 1)
			  
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucune pomme de terre !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
	
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitementt.x, Position.traitementt.y, Position.traitementt.z, true)
    if not IsInVehicle() then
        if distance < Position.traitementt.distance then
          ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour traiter les ~b~tomates', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
            --TriggerEvent("player:getQuantity", 34)
            --carotte = qte
            --TriggerEvent("player:getQuantity", 36)
            --pomme de terre = qte
            TriggerEvent("player:getQuantity", 38)
            tomate = qte
            --TriggerEvent("player:getQuantity", 40)
            --blé = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if tomate ~= 0 then
              ShowMsgtime.msg = 'Traitement des ~b~tomates'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~b~Concentré de tomate'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 38, 1)
              TriggerEvent("player:receiveItem", 39, 1)
			  
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucune tomate !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
	
	local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.traitementb.x, Position.traitementb.y, Position.traitementb.z, true)
    if not IsInVehicle() then
        if distance < Position.traitementb.distance then
          ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour traiter le ~b~blé', 0)
        if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
            --TriggerEvent("player:getQuantity", 34)
            --carotte = qte
            --TriggerEvent("player:getQuantity", 36)
            --pomme de terre = qte
            --TriggerEvent("player:getQuantity", 38)
            --tomate = qte
            TriggerEvent("player:getQuantity", 40)
            ble = qte
            -- TriggerEvent("player:getQuantity", 6, function(data)
            --      weedcount = data.count
            -- end)
            Wait(100)
            if ble ~= 0 then
              ShowMsgtime.msg = 'Traitement du ~y~blé'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ + 1 ~y~Pain'
              ShowMsgtime.time = 150

              TriggerEvent("player:looseItem", 40, 1)
              TriggerEvent("player:receiveItem", 41, 1)
			  
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus de blé !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
    -------------------------Fin Du Bloc Pour rajouter un traitement-------------------------------------------
    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.vente.x, Position.vente.y, Position.vente.z, true)
    if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour vendre vos ~b~produits', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
            TriggerEvent("player:getQuantity", 35)
            carotte_rapee = qte
            TriggerEvent("player:getQuantity", 37)
            puree = qte
            TriggerEvent("player:getQuantity", 39)
            concentre_de_tomate = qte
            --TriggerEvent("player:getQuantity", 41)
            --pain = qte
            -- TriggerEvent("player:getQuantity", 7, function(data)
            --         weedcount = data.count
            -- end)
            Wait(100)
            if carotte_rapee ~= 0 then
              ShowMsgtime.msg = 'Vous vendez des ~b~carottes rapées'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Pricec..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell",0, 1, 35, Pricec, "")
            elseif puree ~= 0 then
              ShowMsgtime.msg = 'Vous vendez de la ~b~purée'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Pricep..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell", 0, 1, 37, Pricep, "")
            elseif concentre_de_tomate ~= 0 then
              ShowMsgtime.msg = 'Vous vendez du ~b~concentré de tomate'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Pricet..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell", 0, 1, 39, Pricet, "")
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun produit !"
              ShowMsgtime.time = 150
            end
          --else
          --  ShowMsgtime.msg = '~r~ Vous devez être fermier !'
          --  ShowMsgtime.time = 150
          end
        end
      end
    end


    local distance = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, Position.ventepain.x, Position.ventepain.y, Position.ventepain.z, true)
    if not IsInVehicle() then
        if distance < Position.vente.distance then
          ShowInfo('Appuyez sur ~INPUT_CONTEXT~ pour vendre vos ~b~pains', 0)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent("poleemploi:getjobs")
            Wait(100)
            if myjob == 14 then
            TriggerEvent("player:getQuantity", 41)
            pain = qte
            -- TriggerEvent("player:getQuantity", 7, function(data)
            --         weedcount = data.count
            -- end)
            Wait(100)
            if pain ~= 0 then
              ShowMsgtime.msg = 'Vous vendez du ~y~pain'
              ShowMsgtime.time = 250
              TriggerEvent("vmenu:anim" ,"pickup_object", "pickup_low")
              Wait(2500)
              ShowMsgtime.msg = '~g~ +'..Priceb..'$'
              ShowMsgtime.time = 150
              TriggerEvent("inventory:sell",0, 1, 41, priceb, "")
            else
              ShowMsgtime.msg = "~r~ Vous n'avez plus aucun pain !"
              ShowMsgtime.time = 150
            end
          else
            ShowMsgtime.msg = '~r~ Vous devez être fermier !'
            ShowMsgtime.time = 150
          end
        end
      end
    end
  end
end)

function AfficherBlip()

  Bliptraitementc = AddBlipForCoord(Position.traitementc.x, Position.traitementc.y, Position.traitementc.z)

  SetBlipSprite(Bliptraitementc, 402)
  SetBlipColour(Bliptraitementc, 2)
  SetBlipAsShortRange(Bliptraitementc, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de carottes')
  EndTextCommandSetBlipName(Bliptraitementc)

  Bliptraitementp = AddBlipForCoord(Position.traitementp.x, Position.traitementp.y, Position.traitementp.z)

  SetBlipSprite(Bliptraitementp, 402)
  SetBlipColour(Bliptraitementp, 2)
  SetBlipAsShortRange(Bliptraitementp, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de pommes de terre')
  EndTextCommandSetBlipName(Bliptraitementp)
  
  Bliptraitementt = AddBlipForCoord(Position.traitementt.x, Position.traitementt.y, Position.traitementt.z)

  SetBlipSprite(Bliptraitementt, 402)
  SetBlipColour(Bliptraitementt, 2)
  SetBlipAsShortRange(Bliptraitementt, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de tomates')
  EndTextCommandSetBlipName(Bliptraitementt)
  
  Bliptraitementb = AddBlipForCoord(Position.traitementb.x, Position.traitementb.y, Position.traitementb.z)

  SetBlipSprite(Bliptraitementb, 402)
  SetBlipColour(Bliptraitementb, 2)
  SetBlipAsShortRange(Bliptraitementb, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Traitement de blé')
  EndTextCommandSetBlipName(Bliptraitementb)

end

function removeBlip()
  RemoveBlip(Bliptraitementc)
  RemoveBlip(Bliptraitementp)
  RemoveBlip(Bliptraitementt)
  RemoveBlip(Bliptraitementb)
end

function SetBlipTrade(id, text, color, x, y, z)
  local Blip = AddBlipForCoord(x, y, z)

  SetBlipSprite(Blip, id)
  SetBlipColour(Blip, color)
  SetBlipAsShortRange(Blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(Blip)
end