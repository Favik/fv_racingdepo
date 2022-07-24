local isNearDepo = false

RegisterNetEvent('racingDepo:build')
AddEventHandler('racingDepo:build', function()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    tentCoords = (coords + forward * 2.0)
    toolboxCoords = (tentCoords + forward * 1.6)
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(Config.BuildTime*1000)
    ClearPedTasksImmediately(playerPed)
    ESX.Game.SpawnObject('prop_gazebo_02', tentCoords, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        FreezeEntityPosition(obj, true)
        PlaceObjectOnGroundProperly(obj)
    end)
    ESX.Game.SpawnObject('prop_toolchest_05', toolboxCoords, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        FreezeEntityPosition(obj, true)
        PlaceObjectOnGroundProperly(obj)
    end)
    TriggerServerEvent('racingDepo:item', true)
end)

CreateThread(function()
    AddTextEntry('REMOVEOBJECT', 'Sbalit depo ~INPUT_CONTEXT~')
    AddTextEntry('FIXVEHICLE', 'Opravit vozidlo ~INPUT_CONTEXT~')
    local playerPed = PlayerPedId()
    while true do
        Wait(20)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local DepoObject, depoDistance = FindNearestDepo()
        local sleep = true
        
        if not IsPedInAnyVehicle(playerPed, false) then
            if depoDistance < 1.7 then
                isNearDepo = DepoObject
                sleep = false
                DisplayHelpTextThisFrame('REMOVEOBJECT') 
                if IsControlJustReleased(0, 38) then
                    removeDepo(playerPed, DepoObject)
                end
            else
                isNearDepop = false
            end
        else
            if depoDistance < 1.5 then
                isNearDepo = DepoObject
                sleep = false
                DisplayHelpTextThisFrame('FIXVEHICLE') 
                if IsControlJustReleased(0, 38) then
                    fixVehicle(vehicle)
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

function fixVehicle(vehicle)
    if ESXnotify then
        ESX.ShowNotification(_U('start_fix'))
    else
        exports['mythic_notify']:SendAlert('inform', _U('fixed'))
    end
    Wait(3000)
    SetVehicleFixed(vehicle)
    SetVehicleFuelLevel(vehicle, Config.Refuel)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    if ESXnotify then
        ESX.ShowNotification(_U('start_fix'))
    else
        exports['mythic_notify']:SendAlert('success', _U('fixed'))
    end
end

function removeDepo(player, depo)
    TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(Config.FoldTime*1000)
    ClearPedTasksImmediately(player)
    local object = ObjToNet(depo)
    TriggerServerEvent("racingDepo:DeleteObject", object)
    Wait(500)
    local DepoObject = FindNearestDepo()
    while DepoObject == 0 do
        Wait(100)
        TriggerServerEvent('racingDepo:item', false)
        break
    end
end

function FindNearestDepo()
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
	local depoDistance = 10

	for _, Object in pairs(DepoProps) do
		local dstcheck = #(coords - GetEntityCoords(Object))

		if dstcheck < depoDistance then
			depoDistance = dstcheck
			depoObject = Object
		end
	end

	return depoObject, depoDistance
end