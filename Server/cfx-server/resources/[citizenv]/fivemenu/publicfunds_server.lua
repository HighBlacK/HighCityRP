require "resources/mysql-async/lib/MySQL"

function identifier(player)
  local player = 'GOVERNMENT'
   return MySQL.Sync.fetchScalar("SELECT identifier FROM users WHERE identifier =@identifier ",{['@identifier'] = player})
end

function updateCoffre(player, prixavant,prixtotal,prixajoute)
 return MySQL.Sync.fetchScalar("UPDATE caisse_publique SET `solde`= @prixtotal , identifier = @identifier , lasttransfert = @prixajoute WHERE solde = @prixavant ",{['@prixtotal'] = prixtotal, ['@identifier'] = player ,['@prixajoute'] = prixajoute,['@prixavant'] = prixavant })
end

function updateCoffresale(player, prixavantsale,prixtotalsale,prixajoutesale)
 return MySQL.Sync.fetchScalar("UPDATE caisse_publique SET `soldesale`= @prixtotalsale , identifier = @identifier , lasttransfertsale = @prixajoutesale WHERE soldesale = @prixavantsale ",{['@prixtotalsale'] = prixtotalsale, ['@identifier'] = player ,['@prixajoutesale'] = prixajoutesale,['@prixavantsale'] = prixavantsale })
end


function GetSolde(player)
    local solde = solde
  return MySQL.Sync.fetchScalar("SELECT solde FROM caisse_publique WHERE identifier =@identifier ",{['@identifier'] = player})
end

function GetSoldesale(player)
    local soldesale = soldesale
  return MySQL.Sync.fetchScalar("SELECT soldesale FROM caisse_publique WHERE identifier =@identifier ",{['@identifier'] = player})
end



RegisterServerEvent('caisse_publique:getsolde')
AddEventHandler('caisse_publique:getsolde',function()
    TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = 'GOVERNMENT'
    local data = GetSolde(player)
    print(data)
    TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Caisses publiques", false, "Solde restant : ~g~ "..data.."~g~$")
    end)
end)

RegisterServerEvent('caisse_publique:getsoldesale')
AddEventHandler('caisse_publique:getsoldesale',function()
    TriggerEvent('es:getPlayerFromId', source, function(user)

  local player = 'GOVERNMENT'
  local datasale = GetSoldesale(player)
  print(datasale)
  TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Caisses publiques", false, "Solde restant : ~r~ "..datasale.."~r~$")
    end)

end)




RegisterServerEvent('caisse_publique:ajoutsolde')
AddEventHandler('caisse_publique:ajoutsolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = 'GOVERNMENT'
    local prixavant = GetSolde(player)
    local prixajoute = ajout
    local prixtotal = prixavant+prixajoute
     
    print(player)
    print(prixavant)
    print(prixajoute)
    print(prixtotal)

    if((user.money - prixajoute)>=0)then
     
        user:removeMoney((prixajoute))

        updateCoffre(player,prixavant,prixtotal,prixajoute)
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez rajouter : ~g~ "..prixajoute.." ~g~$")
    else
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas assez d'argent !")

    end
end)
end)

RegisterServerEvent('caisse_publique:ajoutsoldeext')
AddEventHandler('caisse_publique:ajoutsoldeext',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = 'GOVERNMENT'
    local prixavant = GetSolde(player)
    local prixajoute = ajout
    local prixtotal = prixavant+prixajoute
     
    print(player)
    print(prixavant)
    print(prixajoute)
    print(prixtotal)

    updateCoffre(player,prixavant,prixtotal,prixajoute)

    end
end
end)



RegisterServerEvent('caisse_publique:ajoutersoldesale')
AddEventHandler('caisse_publique:ajoutersoldesale',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = 'GOVERNMENT'
    local prixavantsale = GetSoldesale(player)
    local prixajoutesale = ajout
    local prixtotalsale = prixavantsale+prixajoutesale
     
    print(player)
    print(prixavantsale)
    print(prixajoutesale)
    print(prixtotalsale)

    if((user.dirtymoney - prixajoutesale)>=0)then    
        user:removeDMoney((prixajoutesale))
        updateCoffresale(player,prixavantsale,prixtotalsale,prixajoutesale)
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez rajouter : ~r~ "..prixajoutesale.." ~r~$")
    else
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Vous n'avez pas assez d'argent !")
    end
end)
end)


RegisterServerEvent('caisse_publique:retirersolde')
AddEventHandler('caisse_publique:retirersolde',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = 'GOVERNMENT'
    local prixavant = GetSolde(player)
    local prixenleve = ajout
    local prixtotal = prixavant-prixenleve
     
    print(player)
    print(prixavant)
    print(prixenleve)
    print(prixtotal)
    

    if(prixtotal<-1)then
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Coffre vide !")    
    else
        updateCoffre(player,prixavant,prixtotal,prixenleve)
        user:addMoney((prixenleve))
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez retirer : ~g~ "..prixenleve.." ~g~$")
    end

end)
end)

RegisterServerEvent('caisse_publique:retirersoldesale')
AddEventHandler('caisse_publique:retirersoldesale',function(ajout)
TriggerEvent('es:getPlayerFromId', source, function(user)

    local player = 'GOVERNMENT'
    local prixavantsale = GetSoldesale(player)
    local prixenlevesale = ajout
    local prixtotalsale = prixavantsale-prixenlevesale
     
    print(player)
    print(prixavantsale)
    print(prixenlevesale)
    print(prixtotalsale)
    
    if(prixtotalsale<-1)then
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Attention", false, "~r~Coffre vide !")        
    else      
        updateCoffresale(player,prixavantsale,prixtotalsale,prixenlevesale)
        user:addDMoney((prixenlevesale))
        TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Accuse de reception", false, "Vous avez retirer : ~r~ "..prixenlevesale.." ~r~$")
    end
end)
end)

--Createur Nelyo  :   https://github.com/ElNelyo/cop-coffre

--Modifications et Ameliorations  : Irtas Momaki / Walter White

