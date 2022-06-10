RegisterCommand('lockpick', function()

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)
    local vehpos = GetEntityCoords(veh)
    local locked = GetVehicleDoorLockStatus(veh)
    local distance = #(vehpos - pos)

    print(distance)

    if distance < 3 then
        if locked ~= 2 then

            local seconds = math.random(9,12)
            local circles = math.random(1,3)
            local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
            
            if success then

            SetVehicleDoorsLocked(veh, 7)

            RequestAnimDict("mp_arresting")
            while (not HasAnimDictLoaded("mp_arresting")) do Citizen.Wait(0) end
            TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 1.0 ,-1.0 , 5500, 0, 1, true, true, true)

            SetVehicleDoorsLocked(veh, 1)
            SetVehicleAlarm(veh, true)
            SetVehicleNeedsToBeHotwired(veh, true)
            SetVehicleDoorsLockedForAllPlayers(veh, false)
            FreezeEntityPosition(ped, true)

    Citizen.Wait(5500)
    SetVehicleAlarmTimeLeft(veh, 11000)

    FreezeEntityPosition(ped, false)

        end
end
end
end)
