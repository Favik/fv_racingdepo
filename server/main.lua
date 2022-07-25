ESX.RegisterUsableItem(Config.Item, function(source)
    TriggerClientEvent('fv_racingDepot:build', source)
end)

RegisterNetEvent("fv_racingDepot:item")
AddEventHandler("fv_racingDepot:item", function(use)
    local xPlayer = ESX.GetPlayerFromId(source)
    if use then
        xPlayer.removeInventoryItem(Config.Item, 1)
    elseif not use then
        xPlayer.addInventoryItem(Config.Item, 1)
    end
end)

RegisterNetEvent("fv_racingDepot:DeleteObject")
AddEventHandler("fv_racingDepot:DeleteObject", function(object)
    local ent = NetworkGetEntityFromNetworkId(object)
	DeleteEntity(ent)
end)