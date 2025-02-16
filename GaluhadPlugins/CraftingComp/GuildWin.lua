
function DrawGuildWin()

	local tempWidth = 400;
	local tempHeight = 500;

	wGuildWinParent = Turbine.UI.Lotro.Window();
	wGuildWinParent:SetPosition(SETTINGS.GUILDWIN.X,SETTINGS.GUILDWIN.Y);
	wGuildWinParent:SetSize(tempWidth,tempHeight);
	wGuildWinParent:SetText(_LANG.GUILDS[SETTINGS.LANGUAGE]);
	wGuildWinParent:SetVisible(false);


	-- tree view control.
    tvGuilds = Turbine.UI.TreeView();
    tvGuilds:SetParent(wGuildWinParent);
    tvGuilds:SetPosition(20,90);
    tvGuilds:SetSize(tempWidth-50,tempHeight-120);
    --tvGuilds:SetBackColor(Turbine.UI.Color(0.2,0.2,0.2));
    tvGuilds:SetIndentationWidth(18);

    -- tree view scroll bar.
    sbGuilds = Turbine.UI.Lotro.ScrollBar();
    sbGuilds:SetOrientation(Turbine.UI.Orientation.Vertical);
    sbGuilds:SetParent(wGuildWinParent);
    sbGuilds:SetPosition(tvGuilds:GetLeft() + tvGuilds:GetWidth()+2,tvGuilds:GetTop());
    sbGuilds:SetSize(8,tvGuilds:GetHeight());
	sbGuilds:SetVisible(false);

    tvGuilds:SetVerticalScrollBar(sbGuilds);


	RefreshGuildTree();


	-- Window event
	wGuildWinParent.PositionChanged = function()
		SETTINGS.GUILDWIN.X = wGuildWinParent:GetLeft();
		SETTINGS.GUILDWIN.Y = wGuildWinParent:GetTop();
	end

end


function RefreshGuildTree()

	-- This function refreshes the tree view for the guild Window
	local RootNodes = tvGuilds:GetNodes();
	RootNodes:Clear();

	local t2 = {}

	table.foreach (Data._GUILDDATA, function (k) table.insert (t2, k) end );

	table.sort (t2);

	for k,v in pairs(t2) do

		local _GUILDITEMDATA = FormulateGuildData(v);

		local CurTreeNode = Turbine.UI.TreeNode();
		CurTreeNode:SetSize(tvGuilds:GetWidth(),25);


		local HeaderHolder = Turbine.UI.Control();
		HeaderHolder:SetParent(CurTreeNode);
		HeaderHolder:SetSize(CurTreeNode:GetWidth(),23);
		HeaderHolder:SetBackColor(HDBLUE);
		HeaderHolder:SetMouseVisible(false);


		local lblProfession = Turbine.UI.Label();
		lblProfession:SetParent(HeaderHolder);
		lblProfession:SetSize(HeaderHolder:GetWidth()-10,23);
		lblProfession:SetPosition(5,0);
		lblProfession:SetTextAlignment(LEFTALIGN);
		lblProfession:SetForeColor(WHITE);
		lblProfession:SetFont(BFONT);
		lblProfession:SetText(v .. " (" .. CommaNumbers(_GUILDITEMDATA.TOTALITEMSXP) .. "xp)");
		lblProfession:SetMouseVisible(false);


		RootNodes:Add(CurTreeNode);


		local ChildNodes = CurTreeNode:GetChildNodes();


		local iKeyCount = 0;
		for a,b in pairs (Data._GUILDDATA[v]) do iKeyCount = iKeyCount + 1 end;


		for i=1, iKeyCount do

			local _CURGUILDITEM = Data._GUILDDATA[v][i];
			local GUILDITEMNAME = _CURGUILDITEM.NAME[SETTINGS.LANGUAGE];

			local CurChildNode = Turbine.UI.TreeNode();
			CurChildNode:SetSize(tvGuilds:GetWidth()-tvGuilds:GetIndentationWidth(),23);

			local RowHolder = Turbine.UI.Control();
			RowHolder:SetParent(CurChildNode);
			RowHolder:SetSize(CurChildNode:GetWidth(),23);

			local lblGuildItems  = Turbine.UI.Label();
			lblGuildItems:SetParent(RowHolder);
			lblGuildItems:SetPosition(0,0);
			lblGuildItems:SetSize(RowHolder:GetWidth(),23);
			lblGuildItems:SetFont(TrajanPro14);
			lblGuildItems:SetTextAlignment(LEFTALIGN);
			lblGuildItems:SetForeColor(WHITE);

			if _GUILDITEMDATA.ITEMS[GUILDITEMNAME].TOTALQTY > 0 then
				lblGuildItems:SetText(_GUILDITEMDATA.ITEMS[GUILDITEMNAME].TOTALQTY .. "x " .. GUILDITEMNAME .. " (" .. CommaNumbers(_GUILDITEMDATA.ITEMS[GUILDITEMNAME].TOTALXP) .. "xp)");
			else
				lblGuildItems:SetText(_GUILDITEMDATA.ITEMS[GUILDITEMNAME].TOTALQTY .. "x " .. GUILDITEMNAME);
			end

			ChildNodes:Add(CurChildNode);

		end

	end

end


function FormulateGuildData(PROFESSION)

	if PROFESSION == nil then return {} end;

	-- This function checks for the given profession how many are in the recorded inventory
	-- and returns a table with the inventories and total xp of the combined items.
	local _REPTOTAL =
		{
		["TOTALITEMSXP"] = 0;
		["ITEMS"] = {};
		};

	-- Check how many rep items are in the table.
	local iKeyCount = 0;
	for a,b in pairs (Data._GUILDDATA[PROFESSION]) do iKeyCount = iKeyCount + 1 end;

	-- Loop through the table for each rep item
	for i=1, iKeyCount do

		local _CURGUILDITEM = Data._GUILDDATA[PROFESSION][i];
		local GUILDITEMNAME = _CURGUILDITEM.NAME[SETTINGS.LANGUAGE]; -- e.g. Medium Artisan Repast


		_REPTOTAL.ITEMS[GUILDITEMNAME] =
				{
				["TOTALXP"] = 0;
				["TOTALQTY"] = 0;
				["INVENTORY"] = {};
				};


		-- Check the _INVENTORY table to see if the item exists.
		if type(_INVENTORY[GUILDITEMNAME]) == 'table' then

			-- Item is known in the _INVENTORY

			local _INVAREAS = _INVENTORY[GUILDITEMNAME].AREAS;
			local _REFORMINVAREAS = {};

			local totalQTY = 0;

			for k,v in pairs (_INVAREAS) do

				local AREA = k;
				local QTY = 0;

				if type (v) == 'table' then
					for a,b in pairs (v) do
						QTY = QTY + b;
					end
				else
					QTY = QTY + v;
				end

				_REFORMINVAREAS[AREA] = QTY;

				totalQTY = totalQTY + QTY;

			end


			_REPTOTAL.ITEMS[GUILDITEMNAME] =
				{
				["TOTALXP"] = totalQTY * _CURGUILDITEM.XP;
				["TOTALQTY"] = totalQTY;
				["INVENTORY"] = deepcopy(_REFORMINVAREAS);
				};

		end

		-- Add the xp to the overall total.
		_REPTOTAL.TOTALITEMSXP = _REPTOTAL.TOTALITEMSXP + _REPTOTAL.ITEMS[GUILDITEMNAME].TOTALXP;

	end

	return _REPTOTAL;
end
