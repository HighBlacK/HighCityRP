RegisterServerEvent("farm:plate")
AddEventHandler("farm:plate", function()
  local gui = GetPlayerIdentifiers(source);
  local Identifiers = gui[1]
  local lenght = string.len(Identifiers)
  local plate = 'CTZN'..Identifiers[lenght-4]..Identifiers[lenght-3]..Identifiers[lenght-2]..Identifiers[lenght-1]
  local plateUpper = string.upper(plate)
  print(plateUpper)
  TriggerClientEvent("farm:f_plate",source, tostring(plateUpper))
end)