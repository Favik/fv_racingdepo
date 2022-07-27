EventTimer = {}
BuildTimer = {}

ESX.RegisterUsableItem(Config.Item, function(source)
    if BuildTimer[source] and BuildTimer[source] > GetGameTimer() then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'warn', text = _U('cooldown') })
        return
    end    
    TriggerClientEvent('fv_racingDepot:build', source)
    BuildTimer[source] = GetGameTimer() + (Config.BuildTime*1000)
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

RegisterServerEvent("fv_racingDepot:checkEvent")
AddEventHandler("fv_racingDepot:checkEvent", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playername = GetPlayerName(source)
    if EventTimer[source] and EventTimer[source] > GetGameTimer() then
        print('^3Player [ID:'..source..'] '..playername..' has triggered the event more times than possible!^0')
        if Config.TriggerEventKick then
            xPlayer.kick(Config.KickReason)
        end
        return
    end    
    EventTimer[source] = GetGameTimer() + (Config.BuildTime*1000)
end)