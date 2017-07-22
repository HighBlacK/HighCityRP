Menu = {}
Menu.GUI = {}
Menu.buttonCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"

local yoffset = 0.43
local xoffset = 0.05
local xmin = 0.0
local xmax = 0.3
local ysize = 0.04
local xtext = xmin + xoffset + 0.025
local ytitle = yoffset - 0.059

function Menu.addButton(name, func,args)
	Menu.GUI[Menu.buttonCount +1] = {}
	Menu.GUI[Menu.buttonCount +1]["name"] = name
	Menu.GUI[Menu.buttonCount+1]["func"] = func
	Menu.GUI[Menu.buttonCount+1]["args"] = args
	Menu.GUI[Menu.buttonCount+1]["active"] = false
	Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin
	Menu.GUI[Menu.buttonCount+1]["ymin"] = yoffset - ysize
	Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax
	Menu.GUI[Menu.buttonCount+1]["ymax"] = ysize
	Menu.buttonCount = Menu.buttonCount+1
end


function Menu.updateSelection() 
	if IsControlJustPressed(3, 173) then 
		if(Menu.selection < Menu.buttonCount -1 ) then
			Menu.selection = Menu.selection +1
		else
			Menu.selection = 0
		end		
	elseif IsControlJustPressed(3, 172) then
		if(Menu.selection > 0)then
			Menu.selection = Menu.selection -1
		else
			Menu.selection = Menu.buttonCount-1
		end	
	elseif IsControlJustPressed(3, 176)  then
		MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
	end
	local iterator = 0
	for id, settings in ipairs(Menu.GUI) do
		Menu.GUI[id]["active"] = false
		if(iterator == Menu.selection ) then
			Menu.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function Menu.renderGUI()
	if not Menu.hidden then
		Menu.renderButtons()
		Menu.updateSelection()
	end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function Menu.renderButtons()
	SetTextFont(1)
	SetTextScale(0.0,0.35)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(true)
	SetTextDropShadow(0, 0, 0, 0, 0)
	SetTextEdge(0, 0, 0, 0, 0)
	SetTextEntry("STRING")
	-- AddTextComponentString(string.upper(MenuTitle)..(Menu.selection + 1).."/"..Menu.buttonCount)
	AddTextComponentString(string.upper(MenuTitle))
	DrawText(xtext, ytitle)
	Menu.renderBox(xmin, xmax, (yoffset - 0.04), 0.05, 189,47,50,255)

	for id, settings in pairs(Menu.GUI) do
		if id > Menu.from and id <= Menu.to then
			local yPos = settings["ymin"] + (id * ysize) - (Menu.from * ysize)
			if(settings["active"]) then
				boxColor = {255,255,255,255}
				textColor = {0,0,0,255}
			else
				boxColor = {0,0,0,255}
				textColor = {255,255,255,200}
			end
			SetTextFont(4)
			SetTextScale(0.0,0.35)
			SetTextColour(textColor[1],textColor[2],textColor[3],textColor[4])
			SetTextCentre(true)
			-- SetTextDropShadow(0, 0, 0, 0, 0)
			SetTextEdge(0, 0, 0, 0, 0)
			SetTextEntry("STRING")
			AddTextComponentString(settings["name"])
			DrawText(xtext, (yPos - 0.0125))
			Menu.renderBox(settings["xmin"] ,settings["xmax"], yPos, settings["ymax"], boxColor[1], boxColor[2], boxColor[3], boxColor[4])
		end
	end
end

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
	_G[fnc](arg)
end