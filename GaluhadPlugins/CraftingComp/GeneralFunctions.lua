
function CommaNumbers(NUMBERTOCONVERT)

	-- This function takes a number and inserts a comma every third position.
	if NUMBERTOCONVERT == nil then return "" end;

	local sOLDNUMBER = tostring(NUMBERTOCONVERT);
	local sNEWNUMBER = "";

	if string.len(sOLDNUMBER) > 3 then -- No point in function if a comma is not even needed.

		-- e.g. 148600
		local POINTTOINSERT = string.len(sOLDNUMBER);

		while POINTTOINSERT > 0 do
			local iStart = POINTTOINSERT - 2;
			local iEnd = POINTTOINSERT;

			if iStart < 1 then iStart = 1 end;

			if iStart == 1 then
				sNEWNUMBER = string.sub(sOLDNUMBER,iStart,iEnd) .. sNEWNUMBER;
			else
				sNEWNUMBER = "," .. string.sub(sOLDNUMBER,iStart,iEnd) .. sNEWNUMBER;
			end

			POINTTOINSERT = POINTTOINSERT - 3;
		end

	end

	if sNEWNUMBER == "" then sNEWNUMBER = sOLDNUMBER end;

	return sNEWNUMBER;

end


function AutoHeight(SCROLLABLECONTROL)

	-- This function sets the height of a scrollable control (label, listbox, treeview)

	local vScroll = Turbine.UI.Lotro.ScrollBar();
	vScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
	vScroll:SetSize(1,1);
	vScroll:SetParent(SCROLLABLECONTROL);
	SCROLLABLECONTROL:SetVerticalScrollBar(vScroll);

	if vScroll:IsVisible() == true then
		local iCount = 1;

		while vScroll:IsVisible() == true and iCount < 50 do
			SCROLLABLECONTROL:SetHeight(SCROLLABLECONTROL:GetHeight() + 2);
			iCount = iCount + 1;
		end
	end

	SCROLLABLECONTROL:SetVerticalScrollBar(nil);

end


function AutoWidth(SCROLLABLECONTROL)

	-- This function sets the width of a scrollable control (label, listbox, treeview)

	local hScroll = Turbine.UI.Lotro.ScrollBar();
	hScroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
	hScroll:SetSize(1,1);
	hScroll:SetParent(SCROLLABLECONTROL);
	SCROLLABLECONTROL:SetHorizontalScrollBar(hScroll);

	if hScroll:IsVisible() == true then
		local iCount = 1;

		while hScroll:IsVisible() == true and iCount < 100 do
			SCROLLABLECONTROL:SetWidth(SCROLLABLECONTROL:GetWidth() + 2);
			iCount = iCount + 1;
		end
	end

	SCROLLABLECONTROL:SetHorizontalScrollBar(nil);

end


function RoundNumber(NUMBER,DECPLACES)

	-- This function takes a number and the decimal place to round to.
	-- Then returns the rounded number.

	if NUMBER == nil then return 0 end;
	if DECPLACES == nil then DECPLACES = 0 end;

	local ABSNUMBER = 0;
	local REMAINDER = 0;

	local MULTIPLIER = math.pow(10,DECPLACES);

	ABSNUMBER,REMAINDER = math.modf(NUMBER*MULTIPLIER);

	if REMAINDER >= 0.5 then
		ABSNUMBER = ABSNUMBER + 1;
	end

	local NUMTORETURN = ABSNUMBER * (math.pow(10,-(DECPLACES)));

	return NUMTORETURN;

end


function ConvertTime(PASSEDSECONDS)

	-- This function takes a seconds value and returns a table with the value
	-- broken down into days, hours, minutes and seconds.

	if PASSEDSECONDS == nil then return nil end;

	local _TIME =
	{
	["DAYS"] = 0;
	["HOURS"] = 0;
	["MINUTES"] = 0;
	["SECONDS"] = 0;
	};

	_TIME.DAYS,_TIME.HOURS = math.modf(PASSEDSECONDS/86400);

	_TIME.HOURS,_TIME.MINUTES = math.modf(_TIME.HOURS*24);

	_TIME.MINUTES,_TIME.SECONDS = math.modf(_TIME.MINUTES*60);

	_TIME.SECONDS = math.floor(_TIME.SECONDS * 60);

	return _TIME;

end


function GetEndTime(EXPIRES)

	if EXPIRES == nil then return nil end;

	local ENDSTRING = "";

	local _REMAINING = ConvertTime(EXPIRES - Turbine.Engine.GetGameTime());
	local _CURDATE = Turbine.Engine.GetDate();

	local endSECOND = _CURDATE.Second + _REMAINING.SECONDS;
	local endMINUTE = _CURDATE.Minute + _REMAINING.MINUTES;
	local endHOUR = _CURDATE.Hour + _REMAINING.HOURS;
	local endDAY = _CURDATE.Day + _REMAINING.DAYS;
	local endMONTH = _CURDATE.Month;
	local endYEAR = _CURDATE.Year;

	if endSECOND >= 60 then
		endSECOND = endSECOND - 60;
		endMINUTE = endMINUTE + 1;
	end

	if endMINUTE >= 60 then
		endMINUTE = endMINUTE - 60;
		endHOUR = endHOUR + 1;
	end

	if endHOUR >= 24 then
		endHOUR = endHOUR - 24;
		endDAY = endDAY + 1;
	end

	if endDAY > GetDaysInMonth(endMONTH) then
		endDAY = endDAY - GetDaysInMonth(endMONTH);
		endMONTH = endMONTH + 1;
	end

	if endMONTH > 12 then
		endMONTH = endMONTH - 12;
		endYEAR = endYEAR + 1;
	end


	_ENDTIME =
		{
		["SECOND"] = endSECOND;
		["MINUTE"] = endMINUTE;
		["HOUR"] = endHOUR;
		["DAY"] = endDAY;
		["MONTH"] = endMONTH;
		["YEAR"] = endYEAR;
		};


	return _ENDTIME;

end


function GetDaysInMonth(MONTH)

	if MONTH == nil then return nil end;
	if MONTH > 12 or MONTH < 1 then return nil end;


	if MONTH == 1 then return 31 end; 	-- January
	if MONTH == 2 then return 28 end; 	-- February
	if MONTH == 3 then return 31 end; 	-- March
	if MONTH == 4 then return 30 end;	-- April
	if MONTH == 5 then return 31 end;	-- May
	if MONTH == 6 then return 30 end;	-- June
	if MONTH == 7 then return 31 end;	-- July
	if MONTH == 8 then return 31 end;	-- August
	if MONTH == 9 then return 30 end; 	-- September
	if MONTH == 10 then return 31 end; 	-- October
	if MONTH == 11 then return 30 end; 	-- November
	if MONTH == 12 then return 31 end; 	-- December

end


function Debug(STRING)

	if STRING == nil or STRING == "" then return end;

	Turbine.Shell.WriteLine("<rgb=#FF5555>" .. STRING .. "</rgb>");

end


-- Converts an RGB color (0 - 255) number to hex. ---------------------------------
function TO_HEX(IN)
	local B,K,OUT,I,D=16,"0123456789ABCDEF","",0,0;

		if IN == 0 or IN == "0" then
			return "00";
		end

		while IN>0 do
		I=I+1
		IN,D=math.floor(IN/B),math.mod(IN,B)+1
		OUT=string.sub(K,D,D)..OUT
	end
	if string.len(OUT) == 1 then OUT = "0" .. OUT end;
	return OUT
end


-- Dump table function for checking tables on the fly ---------------
function dump(o)
    if type(o) == 'table' then
        local s = '{\n'
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. '\n'
        end
        return s .. '}\n'
    else
		if type(o) == 'string' then
			return "\"" .. o .. "\""
		else
			return tostring(o)
		end
    end
end


--This function returns a deep copy of a given table ---------------
function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end


-- This function merges table two into table one, overwriting any matching entries.
function mergeTables(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			mergeTables(t1[k], t2[k])
		else
			t1[tostring(k)] = v
		end
	end
	return t1
end


-- This function counts the number of elements within a table.
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


-- This function deletes a control and it's children from memory.
function DestroyControl(CONTROL)

	local ChildControlList = CONTROL:GetControls();

	for i=1, ChildControlList:GetCount() do
		DestroyControl(ChildControlList:Get(i));
	end

	CONTROL = nil;
end


-- This function makes sure the object is positioned on the screen and not off it
function Onscreen(OBJECT)

	local DISPLAYWIDTH = Turbine.UI.Display.GetWidth();
	local DISPLAYHEIGHT = Turbine.UI.Display.GetHeight();

	local objWidth = OBJECT:GetWidth();
	local objHeight = OBJECT:GetHeight();
	local objLeft = OBJECT:GetLeft();
	local objTop = OBJECT:GetTop();
	local objRight = objLeft + objWidth;
	local objBottom = objTop + objHeight;

	if objRight > DISPLAYWIDTH then objLeft = DISPLAYWIDTH - objWidth end;
	if objLeft < 0 then objLeft = 0 end;
	if objTop < 0 then objTop = 0 end;
	if objBottom > DISPLAYHEIGHT then objTop = DISPLAYHEIGHT - objHeight end;

	OBJECT:SetPosition(objLeft,objTop);

end


-- Creates a desktop icon to use for opening windows rather than relying on commands
-- windows will need to be assigned to the icon to open when clicked using the AssignToDesktopIcon() funcion
function CreateDesktopIcon(image)
	if image == nil then
		print("CreateDesktopIcon(image) - No image assigned");
		return;
	end

	if SETTINGS.DESKICON == nil then
		SETTINGS.DESKICON = {};
		SETTINGS.DESKICON["X"] = 5;
		SETTINGS.DESKICON["Y"] = 5;
	end

	cDeskIcon = Turbine.UI.Window();
	cDeskIcon:SetSize(32,32);
	cDeskIcon:SetPosition(SETTINGS.DESKICON.X,SETTINGS.DESKICON.Y);
	cDeskIcon:SetBackground(image);
	cDeskIcon:SetBlendMode(0);
	cDeskIcon:SetToolTip(PLUGINNAME);
	cDeskIcon:SetVisible(true);
	cDeskIcon:SetHideF12(true);
	cDeskIcon:SetCloseEsc(false);
	cDeskIcon:SetWantsKeyEvents(true);
	cDeskIcon["Windows"] = {};

	Onscreen(cDeskIcon);


	-- WINDOW MOUSE EVENTS ---------------------------------------------------------------------------------------------------
	local blDragging = false;
	local relX = 0;
	local relY = 0;

	cDeskIcon.MouseDown = function (sender, args)
		blDragging = true;
		relX = args.X;
		relY = args.Y;
	end

	cDeskIcon.MouseUp = function (sender, args)
		blDragging = false;
	end

	cDeskIcon.MouseMove = function (sender, args)
		if blDragging == true then
			local scX = Turbine.UI.Display.GetMouseX();
			local scY = Turbine.UI.Display.GetMouseY();
			SETTINGS.DESKICON.X = scX - relX;
			SETTINGS.DESKICON.Y = scY - relY;

			if SETTINGS.DESKICON.X < 0 then SETTINGS.DESKICON.X = 0 end
			if SETTINGS.DESKICON.X > (SCREENWIDTH-32) then SETTINGS.DESKICON.X = (SCREENWIDTH-32) end
			if SETTINGS.DESKICON.Y < 0 then SETTINGS.DESKICON.Y = 0 end
			if SETTINGS.DESKICON.Y > (SCREENHEIGHT-32) then SETTINGS.DESKICON.Y = (SCREENHEIGHT-32) end

			cDeskIcon:SetPosition(SETTINGS.DESKICON.X,SETTINGS.DESKICON.Y);
		end
	end

	cDeskIcon.MouseDoubleClick = function (sender, args)
		if (args.Button == Turbine.UI.MouseButton.Left) then
			if type(cDeskIcon.Windows) ~= 'table' then return end;
			for k,v in pairs(cDeskIcon.Windows) do
				v:SetVisible(true);
				v:Activate();
			end
		end
	end

end


-- Once an icon has been created, windows can be assigned to it using this function
function Turbine.UI.Window.AssignToDesktopIcon(sender,add)
	if sender == nil or add == false then return end;

	if type(cDeskIcon.Windows) ~= 'table' then cDeskIcon.Windows = {} end;
	local added = false;

	for k,v in pairs (cDeskIcon.Windows) do -- check to make sure it's not entered twice
		if v == sender then
			added = true;
			break;
		end
	end

	if added == false then table.insert(cDeskIcon.Windows,sender) end;
end



