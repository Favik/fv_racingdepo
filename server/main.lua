ESX.RegisterUsableItem('depokit', function(source)
    TriggerClientEvent('racingDepo:build', source)
end)

RegisterNetEvent("racingDepo:item")
AddEventHandler("racingDepo:item", function(use)
    local xPlayer = ESX.GetPlayerFromId(source)
    if use then
        xPlayer.removeInventoryItem('depokit', 1)
    elseif not use then
        xPlayer.addInventoryItem('depokit', 1)
    end
end)

RegisterNetEvent("racingDepo:DeleteObject")
AddEventHandler("racingDepo:DeleteObject", function(object)
    local ent = NetworkGetEntityFromNetworkId(object)
	DeleteEntity(ent)
end)