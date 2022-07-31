UseTimer = {}
BuildTimer = {}

ESX.RegisterUsableItem(Config.Item, function(source)
    local _source = source
    if UseTimer[_source] and UseTimer[_source] > GetGameTimer() then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'warn', text = _U('cooldown') })
        return
    end    
    TriggerClientEvent('fv_racingDepot:build', source)
    UseTimer[_source] = GetGameTimer() + (Config.BuildTime*1200)
end)

RegisterNetEvent("fv_racingDepot:buildSW")
AddEventHandler("fv_racingDepot:buildSW", function(use ,tentCoords, toolboxCoords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xItem = xPlayer.getInventoryItem(Config.Item)
    if BuildTimer[src] and BuildTimer[src] > GetGameTimer() then
        local playername = GetPlayerName(source)
        print('^3Player [ID:'..source..'] '..playername..' has triggered the event more times than possible!^0')
        if Config.TriggerEventKick then
            DropPlayer(source, Config.KickReason)
        end
        return
    elseif xItem.count > 0 and use and tentCoords and toolboxCoords then
        local object1 = CreateObject(468818960, tentCoords.x,tentCoords.y,tentCoords.z-1, true, true, false)
        SetEntityHeading(object1, GetEntityHeading(GetPlayerPed(source)))
        FreezeEntityPosition(object1, true)
        local object2 = CreateObject(-573669520, toolboxCoords.x,toolboxCoords.y,toolboxCoords.z-1, true, true, false)  
        SetEntityHeading(object2, GetEntityHeading(GetPlayerPed(source)))
        FreezeEntityPosition(object2, true)
        xPlayer.removeInventoryItem(Config.Item, 1)
    elseif not use then
        xPlayer.addInventoryItem(Config.Item, 1)
    end
    BuildTimer[src] = GetGameTimer() + (Config.BuildTime*1000) 
end)

RegisterNetEvent("fv_racingDepot:DeleteObject")
AddEventHandler("fv_racingDepot:DeleteObject", function(object)
    local ent = NetworkGetEntityFromNetworkId(object)
	DeleteEntity(ent)
end)
