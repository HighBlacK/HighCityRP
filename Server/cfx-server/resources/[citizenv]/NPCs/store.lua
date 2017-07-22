local firstspawn = 0
	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)	
		if firstspawn == 0 then
		    local model = 0x76284640  -- 24/7 Shop man
            RequestModel(model)
            while (not HasModelLoaded(model)) do
            Wait(1)
            end
	        local storeped = {
		       {CreatePed(1, model, -46.7508, -1758.15, 29.421, 35.88, true, false)}, 
			   {CreatePed(1, model, 24.1944, -1345.8, 29.497, -95.88, true, false)},
			   {CreatePed(1, model, 1133.81, -982.508, 46.4158, -95.88, true, false)},
			   {CreatePed(1, model, 372.768, 328.128, 103.566, -95.88, true, false)},
			   {CreatePed(1, model, -1221.93, -908.522, 12.3264, 40.88, true, false)},
			   {CreatePed(1, model, -1486.06, -377.842, 40.1634, 130.88, true, false)},
			   {CreatePed(1, model, -705.758, -913.609, 19.2156, 80.88, true, false)},
			   {CreatePed(1, model, 1165.08, -322.681, 69.2051, 85.88, true, false)},
			}
			
			SetPedAlertness(storeped, false)
		    SetEntityInvincible(storeped, true) 
		    SetPedCanBeTargetted(storeped, false)
		    SetEntityCanBeDamaged(storeped, false)
			SetPedKeepTask(storeped, true)
			--SetPedAlternateMovementAnim(ped, stance, animDictionary, animationName, p4, p5)
			
			--SetEntityDynamic(storeped, false)

			
			x1, y1, z1 = table.unpack(GetEntityCoords(storeped, true))
            x2, y2, z2 = table.unpack(GetEntityCoords(storeped, true))
		    DrawText3D(x2, y2, z2+1, "Appuyer sur ~r~ENTREE~s~ pour ~r~braquer l'épicerie")
			
		    firstspawn = 1
	    end
	end	
end)

function DrawText3D(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end