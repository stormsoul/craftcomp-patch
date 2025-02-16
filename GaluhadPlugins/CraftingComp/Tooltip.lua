
function TooltipInventory(SENDER,ITEM)

	if SENDER == nil or ITEM == nil then return nil end;

	-- This function handles the request for a tooltip when a mouse hovers over a label and the delay etc..

	local TIMESTAMP = 0;

	SENDER.MouseEnter = function (sender,args)

		TIMESTAMP = Turbine.Engine.GetLocalTime();
		SENDER:SetWantsUpdates(true);

	end

	SENDER.Update = function (sender, args)

		if Turbine.Engine.GetLocalTime() > TIMESTAMP+0.6 then

			SENDER:SetWantsUpdates(false);
			DrawTooltip(SENDER,ITEM);

		end

	end

	SENDER.MouseLeave = function (sender,args)

		SENDER:SetWantsUpdates(false);
		TooltipWin:Close();

	end

end


	TooltipWin = Turbine.UI.Window();
	TooltipWin:SetWidth(240);
	TooltipWin:SetPosition(0,0);
	TooltipWin:SetBackColor(Turbine.UI.Color.DimGray);
	TooltipWin:SetMouseVisible(false);
	TooltipWin:SetVisible(false);


function DrawTooltip(SENDER,ITEM) -- can take item or itemname for ITEM

	local ITEMNAME = "";

	if type(ITEM) == 'string' then
		ITEMNAME = ITEM;
	else
		ITEMNAME = ITEM:GetName();
	end

	local TOOLTIPHEIGHT = 41;

	local childs = TooltipWin:GetControls();
	childs:Clear();


	local TooltipWinBack = Turbine.UI.Control();
	TooltipWinBack:SetParent(TooltipWin);
	TooltipWinBack:SetWidth(TooltipWin:GetWidth()-2);
	TooltipWinBack:SetPosition(1,1);
	TooltipWinBack:SetBackColor(Turbine.UI.Color.Black);
	TooltipWinBack:SetMouseVisible(false);
	TooltipWinBack:SetVisible(true);

	if type(ITEM) ~= 'string' then
		local iconTOOLTIP = Turbine.UI.Lotro.ItemInfoControl();
		iconTOOLTIP:SetParent(TooltipWin);
		iconTOOLTIP:SetPosition(2,2);
		iconTOOLTIP:SetSize(35,35);
		iconTOOLTIP:SetQuantity(1);
		iconTOOLTIP:SetMouseVisible(false);
		iconTOOLTIP:SetItemInfo(ITEM);
	end


	local lblItemName = Turbine.UI.Label();
	lblItemName:SetParent(TooltipWin);
	lblItemName:SetSize(TooltipWin:GetWidth()-44,35);
	lblItemName:SetPosition(42,2);
	lblItemName:SetMultiline(true);
	lblItemName:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	if type(ITEM) == 'string' then
		lblItemName:SetForeColor(WHITE);
		lblItemName:SetLeft(5);
	else
		lblItemName:SetForeColor(GetItemFontColor(ITEM));
	end
	lblItemName:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
	lblItemName:SetMouseVisible(false);
	lblItemName:SetText(ITEMNAME);


	local lblNoInv = Turbine.UI.Label();
	lblNoInv:SetParent(TooltipWin);
	lblNoInv:SetSize(TooltipWin:GetWidth()-8,20);
	lblNoInv:SetPosition(4,TOOLTIPHEIGHT);
	lblNoInv:SetMultiline(false);
	lblNoInv:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	lblNoInv:SetForeColor(Turbine.UI.Color.Khaki);
	lblNoInv:SetFont(Turbine.UI.Lotro.Font.Verdana14);
	lblNoInv:SetMouseVisible(false);

	TOOLTIPHEIGHT = TOOLTIPHEIGHT + lblNoInv:GetHeight() + 2;

	local INVCOUNT = GetItemInventoryCount(ITEMNAME);

	if INVCOUNT == 0 then

		lblNoInv:SetText(_LANG.ZEROQTY[SETTINGS.LANGUAGE]);

	else

		local QUANTITY = 0;

		local _AREAS = _INVENTORY[ITEMNAME].AREAS;

		for k,v in pairs (_AREAS) do

			-- Only add characters that have >0 qty
			if k == "Shared Storage" then

				if v > 0 then

					local lblArea = Turbine.UI.Label();
					lblArea:SetParent(TooltipWin);
					lblArea:SetSize(TooltipWin:GetWidth()-8,20);
					lblArea:SetPosition(4,TOOLTIPHEIGHT);
					lblArea:SetMultiline(false);
					lblArea:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
					lblArea:SetForeColor(Turbine.UI.Color.Khaki);
					lblArea:SetFont(Turbine.UI.Lotro.Font.Verdana14);
					lblArea:SetMouseVisible(false);
					lblArea:SetText(v .. " - Shared Storage");

					QUANTITY = QUANTITY + v;
					TOOLTIPHEIGHT = TOOLTIPHEIGHT + lblArea:GetHeight() + 2;

				end

			else

				for c,d in pairs (v) do

					if d > 0 then

						local lblArea = Turbine.UI.Label();
						lblArea:SetParent(TooltipWin);
						lblArea:SetSize(TooltipWin:GetWidth()-8,20);
						lblArea:SetPosition(4,TOOLTIPHEIGHT);
						lblArea:SetMultiline(false);
						lblArea:SetMarkupEnabled(true);
						lblArea:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
						lblArea:SetForeColor(Turbine.UI.Color.Khaki);
						lblArea:SetFont(Turbine.UI.Lotro.Font.Verdana14);
						lblArea:SetMouseVisible(false);

						local TURCOLOR = Turbine.UI.Color.Cyan;
						local HEXCOLOR = TO_HEX(RoundNumber(TURCOLOR.R*255)) .. TO_HEX(RoundNumber(TURCOLOR.G*255)) .. TO_HEX(RoundNumber(TURCOLOR.B*255));

						if k == MYNAME then
							lblArea:SetText(d .. " - <rgb=#" .. HEXCOLOR .. ">" .. k .. "</rgb> (" .. string.lower(c) .. ")");
						else
							lblArea:SetText(d .. " - " .. k .. " (" .. string.lower(c) .. ")");
						end

						QUANTITY = QUANTITY + d;
						TOOLTIPHEIGHT = TOOLTIPHEIGHT + lblArea:GetHeight() + 2;

					end

				end

			end

		end

		--lblNoInv:SetText(_LANG.INVENTORY[SETTINGS.LANGUAGE] .. " (" .. QUANTITY .. ") :");
		lblNoInv:SetText(_LANG.INVENTORY[SETTINGS.LANGUAGE] .. ":");

		if SETTINGS.LANGUAGE == "ENGLISH" and QUANTITY > 1 then
			lblItemName:SetText(QUANTITY .. " " .. ITEMNAME .. "s");
		else
			lblItemName:SetText(QUANTITY .. " " .. ITEMNAME);
		end

	end


	-- Set control heights
	TooltipWin:SetHeight(TOOLTIPHEIGHT);
	TooltipWinBack:SetHeight(TOOLTIPHEIGHT-2);

	TooltipWin:SetPosition(Turbine.UI.Display.GetMouseX()+30,Turbine.UI.Display.GetMouseY()+10);
	TooltipWin:SetVisible(true);
	TooltipWin:Activate();

end


