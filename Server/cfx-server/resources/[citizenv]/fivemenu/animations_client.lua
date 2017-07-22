AddEventHandler("menuanim:AnimOG", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "vmenu:MainMenuOG", {}, "Retour")
	VMenu.AddFunc(98, "Salutations", "animmenu:salute", {}, "Accéder")
	VMenu.AddFunc(98, "Humeurs", "animmenu:humor", {}, "Accéder")
	VMenu.AddFunc(98, "Travail", "animmenu:work", {}, "Accéder")
	VMenu.AddFunc(98, "Festives", "animmenu:festive", {}, "Accéder")
	VMenu.AddFunc(98, "Autres", "animmenu:other", {}, "Accéder")
	VMenu.AddFunc(98, "LaLife Gamemode", "menuanim:AnimNewOG", {}, "Accéder")
	VMenu.AddFunc(98, "Tester","menuanim:test", {}, "Accéder")
end)

AddEventHandler("animmenu:salute", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Saluer", "anim:play", {23}, "Jouer")
	VMenu.AddFunc(98, "Serrer la main", "anim:play", {24}, "Jouer")
	VMenu.AddFunc(98, "Tape en 5", "anim:play", {25}, "Jouer")
	VMenu.AddFunc(98, "Salut Militaire", "anim:play", {26}, "Jouer")
end)

AddEventHandler("animmenu:humor", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Féliciter", "anim:play", {11}, "Jouer")
	VMenu.AddFunc(98, "Pouce en l'air", "anim:play", {27}, "Jouer")
	VMenu.AddFunc(98, "Calme-toi", "anim:play", {28}, "Jouer")
	VMenu.AddFunc(98, "Avoir peur", "anim:play", {29}, "Jouer")
	VMenu.AddFunc(98, "C'est pas possible!", "anim:play", {30}, "Jouer")
	VMenu.AddFunc(98, "Enlacer", "anim:play", {31}, "Jouer")
	VMenu.AddFunc(98, "Doigt d'honneur", "anim:play", {32}, "Jouer")
	VMenu.AddFunc(98, "Branleur", "anim:play", {33}, "Jouer")
	VMenu.AddFunc(98, "Balle dans la tête", "anim:play", {34}, "Jouer")
end)

AddEventHandler("animmenu:work", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Pêcheur", "anim:play", {12}, "Jouer")
	VMenu.AddFunc(98, "Agriculteur", "anim:play", {13}, "Jouer")
	VMenu.AddFunc(98, "Dépanneur", "anim:play", {14}, "Jouer")
	VMenu.AddFunc(98, "Prendre des notes", "anim:play", {15}, "Jouer")
end)

AddEventHandler("animmenu:festive", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Danser", "anim:play", {35}, "Jouer")
	VMenu.AddFunc(98, "Jouer de la musique", "anim:play", {16}, "Jouer")
	VMenu.AddFunc(98, "Boire une biere", "anim:play", {17}, "Jouer")
	VMenu.AddFunc(98, "Air Guitar", "anim:play", {36}, "Jouer")
end)

AddEventHandler("animmenu:other", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Fumer une clope", "anim:play", {18}, "Jouer")
	VMenu.AddFunc(98, "S'asseoir", "anim:play", {37}, "Jouer")
	VMenu.AddFunc(98, "S'asseoir (Par terre)", "anim:play", {19}, "Jouer")
	VMenu.AddFunc(98, "Attendre", "anim:play", {20}, "Jouer")
	VMenu.AddFunc(98, "Nettoyer quelque chose", "anim:play", {21}, "Jouer")
	VMenu.AddFunc(98, "Se laisser fouiller", "anim:play", {38}, "Jouer")
	VMenu.AddFunc(98, "Se gratter los cojones", "anim:play", {39}, "Jouer")
	VMenu.AddFunc(98, "Prendre un selfie", "anim:play", {22}, "Jouer")
end)

AddEventHandler("menuanim:AnimNewOG", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Applaudir", "anim:play", {1}, "Valider")
	VMenu.AddFunc(98, "Filmer", "anim:play", {2}, "Valider")
	VMenu.AddFunc(98, "Jouer de la musique", "anim:play", {3}, "Valider")
	VMenu.AddFunc(98, "Regarder la carte", "anim:play", {4}, "Valider")
	VMenu.AddFunc(98, "Yoga", "anim:play", {5}, "Valider")
	VMenu.AddFunc(98, "Push up", "anim:play", {6}, "Valider")
	VMenu.AddFunc(98, "Humble discours", "anim:play", {7}, "Valider")
	VMenu.AddFunc(98, "Le Nabil en forêt", "anim:play", {8}, "Valider")
	VMenu.AddFunc(98, "Viens, je suis là!", "anim:play", {9}, "Valider")
	VMenu.AddFunc(98, "Two thumbs up", "anim:play", {10}, "Valider")
end)

AddEventHandler("menuanim:test", function(target)
	VMenu.animations = true
	VMenu.ResetMenu(98, "", "default")
	Wait(100)
	VMenu.AddFunc(98, "Retour", "menuanim:AnimOG", {}, "Retour")
	VMenu.AddFunc(98, "Animation test", "anim:play", {40}, "Valider")
end)

AddEventHandler("anim:play", function(target, anim)
	Wait(100)
	TriggerEvent("vmenu:closeMenu")
	Wait(1000)
	if anim == 1 then
		PlayScenario("WORLD_HUMAN_CHEERING","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 2 then
		PlayScenario("WORLD_HUMAN_MOBILE_FILM_SHOCKING","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 3 then
		PlayScenario("WORLD_HUMAN_MUSICIAN","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 4 then
		PlayScenario("WORLD_HUMAN_TOURIST_MAP","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 5 then
		PlayScenario("WORLD_HUMAN_YOGA","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 6 then
		PlayScenario("WORLD_HUMAN_PUSH_UPS","GENERIC_CURSE_MED" ,"SPEECH_PARAMS_FORCE")
	elseif anim == 7 then
		TriggerEvent("vmenu:anim", "missmic4premiere", "prem_4stars_a_benton")
	elseif anim == 8 then
		TriggerEvent("vmenu:anim", "missmic4premiere", "prem_actress_star_a")
	elseif anim == 9 then
		TriggerEvent("vmenu:anim", "missmic4premiere", "wave_c")
	elseif anim == 10 then
		TriggerEvent("vmenu:anim", "mp_action", "thanks_male_06")
	elseif anim == 11 then
	    PlayScenario("WORLD_HUMAN_CHEERING")
	elseif anim == 12 then
	    PlayScenario("world_human_stand_fishing")
	elseif anim == 13 then
	    PlayScenario("world_human_gardener_plant")
	elseif anim == 14 then
	    PlayScenario("world_human_vehicle_mechanic")
	elseif anim == 15 then
	    PlayScenario("WORLD_HUMAN_CLIPBOARD")
	elseif anim == 16 then
	    PlayScenario("WORLD_HUMAN_MUSICIAN")
	elseif anim == 17 then
	    PlayScenario("WORLD_HUMAN_DRINKING")
	elseif anim == 18 then
	    PlayScenario("WORLD_HUMAN_SMOKING")
	elseif anim == 19 then
	    PlayScenario("WORLD_HUMAN_PICNIC")
	elseif anim == 20 then
	    PlayScenario("world_human_leaning")
	elseif anim == 21 then
	    PlayScenario("world_human_maid_clean")
	elseif anim == 22 then
	    PlayScenario("world_human_tourist_mobile")
	elseif anim == 23 then
	    TriggerEvent("vmenu:anim", "gestures@m@standing@casual", "gesture_hello")
	elseif anim == 24 then
	    TriggerEvent("vmenu:anim", "mp_common", "givetake1_a")
	elseif anim == 25 then
	    TriggerEvent("vmenu:anim", "mp_ped_interaction", "highfive_guy_a")
	elseif anim == 26 then
	    TriggerEvent("vmenu:anim", "mp_player_int_uppersalute", "mp_player_int_salute")
	elseif anim == 27 then
	    TriggerEvent("vmenu:anim", "anim@mp_player_intcelebrationmale@thumbs_up", "thumbs_up")
	elseif anim == 28 then
	    TriggerEvent("vmenu:anim", "gestures@m@standing@casual", "gesture_easy_now")
	elseif anim == 29 then
	    TriggerEvent("vmenu:anim", "amb@code_human_cower_stand@female@idle_a", "idle_c")
	elseif anim == 30 then
	    TriggerEvent("vmenu:anim", "gestures@m@standing@casual", "gesture_damn")
	elseif anim == 31 then
	    TriggerEvent("vmenu:anim", "mp_ped_interaction", "kisses_guy_a")
	elseif anim == 32 then
	    TriggerEvent("vmenu:anim", "mp_player_int_upperfinger", "mp_player_int_finger_01_enter")
	elseif anim == 33 then
	    TriggerEvent("vmenu:anim", "mp_player_int_upperwank", "mp_player_int_wank_01")
	elseif anim == 34 then
	    TriggerEvent("vmenu:anim", "mp_suicide", "pistol")
	elseif anim == 35 then
	    TriggerEvent("vmenu:anim", "amb@world_human_partying@female@partying_beer@base", "base")
	elseif anim == 36 then
	    TriggerEvent("vmenu:anim", "anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar")
	elseif anim == 37 then
	    TriggerEvent("vmenu:anim", "anim@heists@prison_heistunfinished_biztarget_idle", "target_idle")
	elseif anim == 38 then
	    TriggerEvent("vmenu:anim", "mini@prostitutes@sexlow_veh", "low_car_bj_to_prop_female")
	elseif anim == 39 then
	    TriggerEvent("vmenu:anim", "mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch")
	elseif anim == 40 then
	    TriggerEvent("vmenu:anim", "anim@heists@narcotics@trash", "pickup_90_l_bin_bag")
	end
end)

function PlayScenario(param1, param2, param3)
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(GetPlayerPed(-1), param1, 0, 1)
		PlayAmbientSpeech1(GetPlayerPed(-1), param2, param3)
		Citizen.Wait(20000)
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end)
end

function PlayScenarioAlt(param1)
	Citizen.CreateThread(function()
		TaskStartScenarioInPlace(GetPlayerPed(-1), param1, 0, 1)
		Citizen.Wait(20000)
		ClearPedTasksImmediately(GetPlayerPed(-1))
	end)
end