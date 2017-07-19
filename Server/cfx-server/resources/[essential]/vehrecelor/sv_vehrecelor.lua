require "resources/mysql-async/lib/MySQL"

RegisterServerEvent('garages:SelVeh')

function vehiclePlate(plate)
  local plate = plate
  return MySQL.Sync.fetchScalar("SELECT vehicle_plate FROM user_vehicle WHERE vehicle_plate=@plate",{['@plate'] = plate})
end

function vehiclePrice(plate)
  local plate = plate
  return MySQL.Sync.fetchScalar("SELECT vehicle_price FROM user_vehicle WHERE vehicle_plate=@plate",{['@plate'] = plate})
end

vehicles = {}

AddEventHandler('garages:SelVeh', function(plate, vehicle)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    --local player = user.identifier
    local plate = plate
    local vehicle = vehicle
    MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE  vehicle_plate =@plate AND vehicle_model=@vehicle",{['@vehicle'] = vehicle, ['@plate'] = plate}, function (result)
      if(result)then
        for k,v in ipairs(result)do
          price = v.vehicle_price
          local price = price / 2
          user:addDirtyMoney((price))
        end
      end
      MySQL.Async.execute("DELETE from user_vehicle WHERE vehicle_plate = @plate AND vehicle_model=@vehicle",
        {['@plate'] = plate, ['@vehicle'] = vehicle})
      TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Simeon", false, "~r~Véhicule volé vendu!\n")
    end)
  end)
end)
