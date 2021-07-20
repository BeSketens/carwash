carwashStations = {
    {26.5906,  -1392.0261,  28.3634},
	{167.1034,  -1719.4704,  28.4},
	{-74.5693,  6427.8715,  30.5},
	{-699.6325,  -932.7043,  18.1},
	{1362.5385, 3592.1274, 34.0}
}

Citizen.CreateThread(function()
    Citizen.Wait(0)
    for i = 1, #carwashStations do
        local coords = carwashStations[i]
        addBlip("Carwash",coords[1],coords[2],coords[3])
    end
    while true do
        local interval = 1
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local pedPosition = GetEntityCoords(PlayerPedId())
            for i = 1, #carwashStations do
                cwCoords = carwashStations[i]
                local distance = GetDistanceBetweenCoords(pedPosition, cwCoords[1], cwCoords[2], cwCoords[3], true)
                if distance <= 45 then
                    DrawMarker(25, cwCoords[1], cwCoords[2], cwCoords[3], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 4.5, 4.5, 0, 0, 255, 0, 255, false, false, 2, true, nil, false)
                    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if distance < 2 and GetPedInVehicleSeat(veh, -1) then
                        AddTextEntry("HELP", 'Appuyez sur ~INPUT_PICKUP~ pour laver votre véhicule')
                        DisplayHelpTextThisFrame('HELP', false)
                        if IsControlJustPressed(1, 38) then
                            SetVehicleDirtLevel(veh, 0.0)
                        end
                    end
                end
            end
        else
            interval = 1000
        end
        Wait(interval)
    end
end)

----- Functions ------

function addBlip(name, x, y, z)
    local blip = AddBlipForCoord(x,y,z)
    SetBlipSprite(blip, 100)
    SetBlipColour(blip, 25)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    SetBlipDisplay(blip, 2)
end