local weashop_locations = {
  {entering = {1692.379,3758.194,33.71}, inside = {1692.379,3758.194,33.71}, outside = {1692.379,3758.194,33.71}},
  {entering = {252.915,-48.186,68.941}, inside = {252.915,-48.186,69.941}, outside = {252.915,-48.186,69.941}},
  {entering = {844.352,-1033.517,27.094}, inside = {844.352,-1033.517,28.194}, outside = {844.352,-1033.517,28.194}},
  {entering = {-331.487,6082.348,30.354}, inside = {-331.487,6082.348,31.454}, outside = {-331.487,6082.348,31.454}},
  {entering = {-664.268,-935.479,20.729}, inside = {-664.268,-935.479,21.829}, outside = {-664.268,-935.479,21.829}},
  {entering = {-1305.427,-392.428,35.595}, inside = {-1305.427,-392.428,36.695}, outside = {-1305.427,-392.428,36.695}},
  {entering = {-1119.146,2697.061,17.454}, inside = {-1119.146,2697.061,18.554}, outside = {-1119.146,2697.061,18.554}},
  {entering = {2569.978,294.472,107.634}, inside = {2569.978,294.472,108.734}, outside = {2569.978,294.472,108.734}},
  {entering = {-3172.584,1085.858,19.738}, inside = {-3172.584,1085.858,20.838}, outside = {-3172.584,1085.858,20.838}},
  {entering = {20.0430,-1106.469,28.697}, inside = {20.0430,-1106.469,29.797}, outside = {20.0430,-1106.469,29.797}},
  {entering = {810.319,-2157.670,29.619}, inside = {810.319,-2157.670,29.619}, outside = {810.319,-2157.670,29.619}},
}

function ShowWeashopBlips(bool)
	for station,pos in pairs(weashop_locations) do
		local loc = pos
		pos = pos.entering
		local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
		-- 60 58 137
		SetBlipSprite(blip,110)
		SetBlipColour(blip, 1)
		SetBlipScale(blip, 0.9)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ammunation')
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,true)
		SetBlipAsMissionCreatorBlip(blip,true)
		table.insert(weashop_blips, {blip = blip, pos = loc})
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		ShowWeashopBlips(true)
	end
end)