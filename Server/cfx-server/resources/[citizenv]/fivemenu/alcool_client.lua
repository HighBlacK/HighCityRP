RegisterNetEvent('alcool:drink')
AddEventHandler('alcool:drink', function(alcool)
	local newalcool = alcool
	TriggerServerEvent("alcool:drink_s", newalcool)
end)

RegisterNetEvent('alcool:alcooleffect')
AddEventHandler('alcool:alcooleffect', function(alcoolrate)
	if alcoolrate >= 0.5 then
		slightlyDrunk()
		Wait(2000000)
		Desouler()
	elseif alcoolrate >= 1 then
	    Drunked()
		Wait(4000000)
		Desouler()
	elseif alcoolrate >= 2 then
	    Dead()
		TriggerServerEvent("alcool:death")
	elseif alcoolrate =< 0 then
		TriggerServerEvent("alcool:zerorate")
		Desouler()
    end
end)

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function slightlyDrunk()
    SetPedIsDrunk(GetPlayerPed(-1), true)
    SetPedMotionBlur(GetPlayerPed(-1), true)
    DrawNotif("Vous êtes en ~r~état d'ébrièté")
end

function Dead()
    DrawNotif('~r~Vous faites un coma éthilyque')
    SetEntityHealth(GetPlayerPed(-1), 0)
end

function Drunked()
    RequestAnimSet("move_m@drunk@verydrunk")
    while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
      Citizen.Wait(0)
    end
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(GetPlayerPed(-1), true)
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@verydrunk", true)
    SetPedIsDrunk(GetPlayerPed(-1), true)
    DoScreenFadeIn(1000)
    DrawNotif("~r~Vous êtes completement bourré")
end

function Desouler()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    Citizen.Trace("~g~Vous désoulez.\n")
end
