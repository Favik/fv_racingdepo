ESX.RegisterUsableItem(Config.Item, function(source)
    TriggerClientEvent('racingDepo:build', source)
end)

RegisterNetEvent("racingDepo:item")
AddEventHandler("racingDepo:item", function(use)
    local xPlayer = ESX.GetPlayerFromId(source)
    if use then
        xPlayer.removeInventoryItem(Config.Item, 1)
    elseif not use then
        xPlayer.addInventoryItem(Config.Item, 1)
    end
end)

RegisterNetEvent("racingDepo:DeleteObject")
AddEventHandler("racingDepo:DeleteObject", function(object)
    local ent = NetworkGetEntityFromNetworkId(object)
	DeleteEntity(ent)
end)