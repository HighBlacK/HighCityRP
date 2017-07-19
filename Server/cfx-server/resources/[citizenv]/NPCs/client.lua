local firstspawn = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)	
		if firstspawn == 0 then
		   local model = 0x15F8700D  -- fem cop armurerie
           RequestModel(model)
           while (not HasModelLoaded(model)) do
           Wait(1)
           end
	       CreatePed(1, model, 454.25, -980.187, 30.6896, 95.88, true, false)
	    end
		firstspawn = 1
	end	
end)