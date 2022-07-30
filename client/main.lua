local isNearDepo = false

RegisterNetEvent('fv_racingDepot:build')
AddEventHandler('fv_racingDepot:build', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local tentCoords = (coords + forward * 2.0)
    local toolboxCoords = (tentCoords + forward * 1.6)
    if not IsPedInAnyVehicle(playerPed, false) then
        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
        Wait(Config.BuildTime*1000)
        ClearPedTasksImmediately(playerPed)
        local use = true
        TriggerServerEvent("fv_racingDepot:buildSW",use ,tentCoords, toolboxCoords)
    else
        if ESXnotify then
            ESX.ShowNotification(_U('out_veh'))
        else
            exports['mythic_notify']:SendAlert('inform', _U('out_veh'))
        end
    end
end)

CreateThread(function()
    AddTextEntry('REMOVEOBJECT', _U('dismant_depot')..' ~INPUT_CONTEXT~')
    AddTextEntry('FIXVEHICLE', _U('repair_veh')..' ~INPUT_CONTEXT~')
    while true do
        Wait(17)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local DepoObject, depoDistance = FindNearestDepo()
        local sleep = true       
        if not IsPedInAnyVehicle(playerPed, false) then
                if depoDistance < 1.8 then
                    isNearDepo = DepoObject
                    sleep = false
                    DisplayHelpTextThisFrame('REMOVEOBJECT') 
                    if IsControlJustReleased(0, Config.KeyBind) then
                        removeDepo()
                    end
                else
                    isNearDepop = false
                end
        else
            if depoDistance < 1.6 then
                isNearDepo = DepoObject
                sleep = false
                DisplayHelpTextThisFrame('FIXVEHICLE') 
                if IsControlJustReleased(0, Config.KeyBind) then
                    fixVehicle()
                end
            else
                isNearDepop = false
            end
        end
        if sleep then 
            Wait(1000)
        end    
    end                      
end)

function fixVehicle()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if ESXnotify then
        ESX.ShowNotification(_U('start_fix'))
    else
        exports['mythic_notify']:SendAlert('inform', _U('start_fix'))
    end
    FreezeEntityPosition(vehicle, true)
    Wait(Config.RepairTime*1000)
    SetVehicleFixed(vehicle)
    SetVehicleFuelLevel(vehicle, Config.Refuel)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    FreezeEntityPosition(vehicle, false)
    if ESXnotify then
        ESX.ShowNotification(_U('fixed'))
    else
        exports['mythic_notify']:SendAlert('success', _U('fixed'))
    end
end

function removeDepo()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(Config.DismantTime*1000)
    ClearPedTasksImmediately(playerPed)
    local object = ObjToNet(FindNearestDepo())
    TriggerServerEvent("fv_racingDepot:DeleteObject", object)
    Wait(500)
    local DepoObject = FindNearestDepo()
    while DepoObject == 0 do
        Wait(100)
        local use = false
        TriggerServerEvent("fv_racingDepot:buildSW", use)
        break
    end
end

function FindNearestDepo()
    local player = PlayerPedId()
    local getSrvId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(player))
    local coords = GetEntityCoords(PlayerPedId())
    local DepoProps = {}
    local handle, object = FindFirstObject()
    local success
    local Props = {
        [468818960] = true,
        [-573669520] = true,
    }

    repeat
        if Props[GetEntityModel(object)] then
            table.insert(DepoProps, object)
        end

        success, object = FindNextObject(handle, object)
    until not success

    EndFindObject(handle)

    local depoObject = 0
    local depoDistance = 5

    for _, Object in pairs(DepoProps) do
        local dstcheck = #(coords - GetEntityCoords(Object))

        if dstcheck < depoDistance then
            depoDistance = dstcheck
            depoObject = Object
        end
    end

    return depoObject, depoDistance
end