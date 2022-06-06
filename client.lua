local ped = PlayerPedId()

local function LockPick()

    Citizen.Wait(10)

    local pos = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)
    local time = math.random(7,10)
    local circles = math.random(2,4)
    local success = exports['qb-lock']:StartLockPickCircle(circles, time, success)

    if success then

            RequestAnimDict("mp_arresting")
            while (not HasAnimDictLoaded("mp_arresting")) do Citizen.Wait(0) end
            TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 1.0 ,-1.0 , 5500, 0, 1, true, true, true)
            exports['mythic_notify']:DoCustomHudText('inform', 'Lockpicking was a sucess! Quick, drive away before the cops come!', 4500, { ['background-color'] = '#2F5C73', ['color'] = '#ffffff' })
            
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

RegisterCommand('lockpick', function()

    local pos = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)
    local vehpos = GetEntityCoords(veh)
    local locked = GetVehicleDoorLockStatus(veh)
    local distance = #(vehpos - pos)

    print(distance)

    if distance < 3 then
        if locked ~= 2 then
            SetVehicleDoorsLocked(veh, 7)
            exports['mythic_notify']:DoCustomHudText ('inform', 'Lockpicking vehicle....', 4500, { ['background-color'] = '#2F5C73', ['color'] = '#ffffff' })
            LockPick()

        end
end
end)




