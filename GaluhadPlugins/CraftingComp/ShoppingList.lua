
function DrawShoppingListWindow()

	local tempWidth = 470;
	local tempHeight = 400;

	-- Main Parent window to hold all the elements
	wShoppingListWin = Turbine.UI.Lotro.Window();
	wShoppingListWin:SetSize(tempWidth,tempHeight);
	wShoppingListWin:SetPosition(SETTINGS.SHOPPINGLIST.X,SETTINGS.SHOPPINGLIST.Y);
	wShoppingListWin:SetText(_LANG.SHOPPINGLIST[SETTINGS.LANGUAGE]);
	wShoppingListWin:SetVisible(false);
	wShoppingListWin:SetHideF12(true);
	wShoppingListWin:SetCloseEsc(true);
	Onscreen(wShoppingListWin);

	-- Background control to hold the background image
	wSListBack = Turbine.UI.Control();
	wSListBack:SetParent(wShoppingListWin);
	wSListBack:SetSize(468,397);
	wSListBack:SetPosition(0,0);
	wSListBack:SetBlendMode(4);
	wSListBack:SetBackground(_IMAGES.SHOPPINGLISTBACK);
	wSListBack:SetMouseVisible(false);

	-- Delete all button
	btnSListDeleteAll = Turbine.UI.Lotro.Button();
	btnSListDeleteAll:SetParent(wShoppingListWin);
	btnSListDeleteAll:SetWidth(100);
	btnSListDeleteAll:SetPosition(tempWidth-btnSListDeleteAll:GetWidth()-30,35);
	btnSListDeleteAll:SetText(_LANG.DELETEALL[SETTINGS.LANGUAGE]);

	btnSListDeleteAll.Click = function ()
		local tempMsg = MessageBox.Create(_LANG.DELETEALL[SETTINGS.LANGUAGE] .. "?","MBYESNO");
		tempMsg.Prompt = function () -- Event executed when a button is pressed.
			if tempMsg:GetResponse() == "MBYES" then -- Tells you which button.
				_SHOPPINGLIST = nil;
				_SHOPPINGLIST = {};
				RefreshShoppingList();
			end
		end
	end

	-- Create the tree view control.
    treeSList = Turbine.UI.TreeView();
    treeSList:SetParent(wShoppingListWin);
    treeSList:SetPosition(30,70);
    treeSList:SetSize(tempWidth-68,tempHeight-110);
    --treeSList:SetBackColor(Turbine.UI.Color(0.2,0.2,0.2));
    treeSList:SetIndentationWidth(7);

    -- Give the tree view a scroll bar.
    scrollSList = Turbine.UI.Lotro.ScrollBar();
    scrollSList:SetOrientation(Turbine.UI.Orientation.Vertical);
    scrollSList:SetParent(wShoppingListWin);
    scrollSList:SetPosition(treeSList:GetLeft() + treeSList:GetWidth(),treeSList:GetTop());
    scrollSList:SetSize(8,treeSList:GetHeight());
	scrollSList:SetVisible(false);

    treeSList:SetVerticalScrollBar(scrollSList);


	-- Expand All icon
	cSListExpandAll = Turbine.UI.Control();
	cSListExpandAll:SetParent(wShoppingListWin);
	cSListExpandAll:SetSize(16,16);
	cSListExpandAll:SetPosition(30,40);
	cSListExpandAll:SetBlendMode(4);
	cSListExpandAll:SetBackground(_IMAGES.ICONEXPANDALL);

	cSListExpandAll.MouseEnter = function(sender,args)
		cSListExpandAll:SetBackground(_IMAGES.ICONEXPANDALLOVER);
	end

	cSListExpandAll.MouseLeave = function(sender,args)
		cSListExpandAll:SetBackground(_IMAGES.ICONEXPANDALL);
	end

	cSListExpandAll.MouseClick = function(sender,args)
		treeSList:ExpandAll();

		local tempTreeList = treeSList:GetNodes();
		local tempNodeCount = tempTreeList:GetCount();

		for i=1,tempNodeCount do

			local tempCurNode = tempTreeList:Get(i);
			local tempChildControls = tempCurNode:GetControls();

			local tempHeaderHold = tempChildControls:Get(1);
			local tempHeadChilds = tempHeaderHold:GetControls();

			local expandicon = tempHeadChilds:Get(1);
			expandicon:SetBackground(_IMAGES.ICONCOLLAPSE);

			----

			local tempPlayerList = tempCurNode:GetChildNodes();
			local tempPlayersCount = tempPlayerList:GetCount();

			for a=1,tempPlayersCount do

				local tempCurNode = tempPlayerList:Get(a);
				local tempChildControls = tempCurNode:GetControls();

				local tempHeaderHold = tempChildControls:Get(1);
				local tempHeadChilds = tempHeaderHold:GetControls();

				local expandicon = tempHeadChilds:Get(1);
				expandicon:SetBackground(_IMAGES.ICONCOLLAPSE);
			end
		end
	end

	-- Collapse All icon
	cSListCollapseAll = Turbine.UI.Control();
	cSListCollapseAll:SetParent(wShoppingListWin);
	cSListCollapseAll:SetSize(16,16);
	cSListCollapseAll:SetPosition(50,40);
	cSListCollapseAll:SetBlendMode(4);
	cSListCollapseAll:SetBackground(_IMAGES.ICONCOLLAPSEALL);

	cSListCollapseAll.MouseEnter = function(sender,args)
		cSListCollapseAll:SetBackground(_IMAGES.ICONCOLLAPSEALLOVER);
	end

	cSListCollapseAll.MouseLeave = function(sender,args)
		cSListCollapseAll:SetBackground(_IMAGES.ICONCOLLAPSEALL);
	end

	cSListCollapseAll.MouseClick = function(sender,args)
		treeSList:CollapseAll();

		local tempTreeList = treeSList:GetNodes();
		local tempNodeCount = tempTreeList:GetCount();

		for i=1,tempNodeCount do

			local tempCurNode = tempTreeList:Get(i);
			local tempChildControls = tempCurNode:GetControls();

			local tempHeaderHold = tempChildControls:Get(1);
			local tempHeadChilds = tempHeaderHold:GetControls();

			local expandicon = tempHeadChilds:Get(1);
			expandicon:SetBackground(_IMAGES.ICONEXPAND);

			----

			local tempPlayerList = tempCurNode:GetChildNodes();
			local tempPlayersCount = tempPlayerList:GetCount();

			for a=1,tempPlayersCount do

				local tempCurNode = tempPlayerList:Get(a);
				local tempChildControls = tempCurNode:GetControls();

				local tempHeaderHold = tempChildControls:Get(1);
				local tempHeadChilds = tempHeaderHold:GetControls();

				local expandicon = tempHeadChilds:Get(1);
				expandicon:SetBackground(_IMAGES.ICONEXPAND);
			end
		end
	end

	RefreshShoppingList();


	-- Window Events
	wShoppingListWin.PositionChanged = function()
		SETTINGS.SHOPPINGLIST.X = wShoppingListWin:GetLeft();
		SETTINGS.SHOPPINGLIST.Y = wShoppingListWin:GetTop();
	end

end


-- This function repopulates the tree view with uptodate info
function RefreshShoppingList()

	-- Clear the treeview first
	local RootNode = treeSList:GetNodes();
	RootNode:Clear();

	-- Add each item to the list
	for k,v in pairs (_SHOPPINGLIST) do -- first loop gets each item name

		local INGTOTAL = 0;

		local curIngNode = Turbine.UI.TreeNode();
		curIngNode:SetSize(treeSList:GetWidth()-2,24);

		TooltipInventory(curIngNode,k);

		local IngHolder = Turbine.UI.Control();
		IngHolder:SetParent(curIngNode);
		IngHolder:SetSize(curIngNode:GetWidth(),curIngNode:GetHeight()-2);
		IngHolder:SetBackColor(HDBLUE);
		IngHolder:SetMouseVisible(false);

		local IngItemExpand = Turbine.UI.Control();
		IngItemExpand:SetParent(IngHolder);
		IngItemExpand:SetSize(16,16);
		IngItemExpand:SetPosition(0,3);
		IngItemExpand:SetMouseVisible(false);
		IngItemExpand:SetBlendMode(BLEND_OVERLAY);
		IngItemExpand:SetBackground(_IMAGES.ICONEXPAND);

		curIngNode.MouseClick = function(sender,args)
			if curIngNode:IsExpanded() == true then
				IngItemExpand:SetBackground(_IMAGES.ICONCOLLAPSE);
			else
				IngItemExpand:SetBackground(_IMAGES.ICONEXPAND);
			end
		end

		local lblSListIng = Turbine.UI.Label();
		lblSListIng:SetParent(IngHolder);
		lblSListIng:SetSize(IngHolder:GetWidth()-40,IngHolder:GetHeight());
		lblSListIng:SetPosition(20,0);
		lblSListIng:SetTextAlignment(LEFTALIGN);
		lblSListIng:SetMouseVisible(false);
		lblSListIng:SetMarkupEnabled(true);
		lblSListIng:SetOutlineColor(Turbine.UI.Color(0.05,0.05,0.05));
        lblSListIng:SetFontStyle(Turbine.UI.FontStyle.Outline);
		--lblSListIng:SetBackColor(HDBLUELT);
		lblSListIng:SetFont(Verdana16);


		RootNode:Add(curIngNode);


		local NAMENODES = curIngNode:GetChildNodes();


		for a,b in pairs (v) do -- second loop gets each player name


			local INGPLAYERTOTAL = 0;

			local nodeIngPlayer = Turbine.UI.TreeNode();
			nodeIngPlayer:SetSize(treeSList:GetWidth()-treeSList:GetIndentationWidth(),24);

			local nameHolder = Turbine.UI.Control();
			nameHolder:SetParent(nodeIngPlayer);
			nameHolder:SetSize(nodeIngPlayer:GetWidth(),nodeIngPlayer:GetHeight()-2);
			--nameHolder:SetBackColor(HDBLUELT);
			nameHolder:SetMouseVisible(false);

			local IngNameExpand = Turbine.UI.Control();
			IngNameExpand:SetParent(nameHolder);
			IngNameExpand:SetSize(16,16);
			IngNameExpand:SetPosition(0,3);
			IngNameExpand:SetMouseVisible(false);
			IngNameExpand:SetBlendMode(BLEND_OVERLAY);
			IngNameExpand:SetBackground(_IMAGES.ICONEXPAND);

			nodeIngPlayer.MouseClick = function(sender,args)
				if nodeIngPlayer:IsExpanded() == true then
					IngNameExpand:SetBackground(_IMAGES.ICONCOLLAPSE);
				else
					IngNameExpand:SetBackground(_IMAGES.ICONEXPAND);
				end
			end

			local lblSListPlayer = Turbine.UI.Label();
			lblSListPlayer:SetParent(nameHolder);
			lblSListPlayer:SetSize(nameHolder:GetWidth()-20,nameHolder:GetHeight());
			lblSListPlayer:SetPosition(20,0);
			lblSListPlayer:SetTextAlignment(LEFTALIGN);
			lblSListPlayer:SetMouseVisible(false);
			lblSListPlayer:SetMarkupEnabled(true);
			lblSListPlayer:SetFont(Verdana16);

			NAMENODES:Add(nodeIngPlayer);


			local RECIPENODES = nodeIngPlayer:GetChildNodes();

			for c,d in pairs (b) do -- third loop gets each recipe and required quantity.

				local nodeIngRecipe = Turbine.UI.TreeNode();
				nodeIngRecipe:SetSize(treeSList:GetWidth()-(treeSList:GetIndentationWidth()*2),26);

				local recipeHolder = Turbine.UI.Control();
				recipeHolder:SetParent(nodeIngRecipe);
				recipeHolder:SetSize(nodeIngRecipe:GetWidth(),nodeIngRecipe:GetHeight()-2);
				--recipeHolder:SetBackColor(HDBLUELT);
				recipeHolder:SetMouseVisible(false);

				local txtSListRec = Turbine.UI.Lotro.TextBox();
				txtSListRec:SetParent(recipeHolder);
				txtSListRec:SetSize(40,21);
				txtSListRec:SetPosition(20,2);
				txtSListRec:SetTextAlignment(MIDALIGN);
				txtSListRec:SetFont(Verdana16);
				txtSListRec:SetText(d);


				txtSListRec.TextChanged = function (sender,args)

					local NEWQTY = txtSListRec:GetText();

					if string.len(NEWQTY) > 0 then

						local OUTPUTQTY = "";

						for a in string.gmatch(NEWQTY,"[0123456789]") do
							OUTPUTQTY = OUTPUTQTY .. a;
						end

						txtSListRec:SetText(OUTPUTQTY);

						-- Check if valid number
						if tonumber(OUTPUTQTY) ~= nil then
							_SHOPPINGLIST[k][MYNAME][c] = OUTPUTQTY;

							-- Get the new totals and redo the labels.
							if _SHOPPINGLIST[k] ~= nil then

								local INGREDIENTTOTAL = 0;

								for e,f in pairs (_SHOPPINGLIST[k]) do -- loops through player names

									local PLAYERINGREDIENTTOTAL = 0;

									for g,h in pairs (f) do  -- loops through recipe and quantites
										PLAYERINGREDIENTTOTAL = PLAYERINGREDIENTTOTAL + h;
									end

									lblSListPlayer:SetText(a .. " (" .. PLAYERINGREDIENTTOTAL .. ")");
									INGREDIENTTOTAL = INGREDIENTTOTAL + PLAYERINGREDIENTTOTAL;

								end

								if GetItemInventoryCount(k) >= INGREDIENTTOTAL then
									lblSListIng:SetForeColor(INGSUBCOLOR);
								else
									lblSListIng:SetForeColor(WHITE);
								end

								lblSListIng:SetText(INGREDIENTTOTAL .. "x " .. k);

							end
						end
					end
				end


				local lblSListRec = Turbine.UI.Label();
				lblSListRec:SetParent(recipeHolder);
				lblSListRec:SetSize(nameHolder:GetWidth()-65,nameHolder:GetHeight());
				lblSListRec:SetPosition(65,0);
				lblSListRec:SetTextAlignment(LEFTALIGN);
				lblSListRec:SetMouseVisible(false);
				lblSListRec:SetMarkupEnabled(true);
				lblSListRec:SetFont(Verdana16);
				lblSListRec:SetText(c);

				INGPLAYERTOTAL = INGPLAYERTOTAL + d;


				local btnDeleteSList = Turbine.UI.Control();
				btnDeleteSList:SetParent(recipeHolder);
				btnDeleteSList:SetSize(16,16);
				btnDeleteSList:SetPosition(recipeHolder:GetWidth()-16,3);
				btnDeleteSList:SetBlendMode(4);
				btnDeleteSList:SetBackground(_IMAGES.ICONDELETENORMAL);
				btnDeleteSList:SetMouseVisible(true);
				btnDeleteSList:SetVisible(true);

				btnDeleteSList.MouseEnter = function ()
					btnDeleteSList:SetBackground(_IMAGES.ICONDELETEOVER);
				end

				btnDeleteSList.MouseLeave = function ()
					btnDeleteSList:SetBackground(_IMAGES.ICONDELETENORMAL);
				end

				btnDeleteSList.MouseClick = function ()

					local tempMsg = MessageBox.Create((_LANG.DELETE[SETTINGS.LANGUAGE] .. " " .. _SHOPPINGLIST[k][MYNAME][c] .. "x " .. k .. " (" .. c .. ")"),"MBYESNO");
					tempMsg.Prompt = function () -- Event executed when a button is pressed.
						if tempMsg:GetResponse() == "MBYES" then -- Tells you which button.

							-- Check to see if there are any other recipes for this char, if not set to nil.
							_SHOPPINGLIST[k][MYNAME][c] = nil;

							nodeIngRecipe:GetParentNode():GetChildNodes():Remove(nodeIngRecipe);

							local RECIPECOUNTER = 0;

							for e,f in pairs(_SHOPPINGLIST[k][MYNAME]) do
								RECIPECOUNTER = RECIPECOUNTER + 1;
							end

							if RECIPECOUNTER == 0 then

								_SHOPPINGLIST[k][MYNAME] = nil;

								nodeIngPlayer:GetParentNode():GetChildNodes():Remove(nodeIngPlayer);

								local NAMECOUNTER = 0;

								for g,h in pairs (_SHOPPINGLIST[k]) do
									NAMECOUNTER = NAMECOUNTER + 1;
								end

								if NAMECOUNTER == 0 then
									_SHOPPINGLIST[k] = nil;
									RootNode:Remove(curIngNode);
								end
							end

							-- Get the new totals and redo the labels.
							if _SHOPPINGLIST[k] ~= nil then

								local INGREDIENTTOTAL = 0;

								for e,f in pairs (_SHOPPINGLIST[k]) do -- loops through player names

									local PLAYERINGREDIENTTOTAL = 0;

									for g,h in pairs (f) do  -- loops through recipe and quantites
										PLAYERINGREDIENTTOTAL = PLAYERINGREDIENTTOTAL + h;
									end

									lblSListPlayer:SetText(a .. " (" .. PLAYERINGREDIENTTOTAL .. ")");
									INGREDIENTTOTAL = INGREDIENTTOTAL + PLAYERINGREDIENTTOTAL;

								end

								if GetItemInventoryCount(k) >= INGREDIENTTOTAL then
									lblSListIng:SetForeColor(INGSUBCOLOR);
								else
									lblSListIng:SetForeColor(WHITE);
								end

								lblSListIng:SetText(INGREDIENTTOTAL .. "x " .. k);

							end
						end
					end
				end

				RECIPENODES:Add(nodeIngRecipe);

			end

			lblSListPlayer:SetText(a .. " (" .. INGPLAYERTOTAL .. ")");
			INGTOTAL = INGTOTAL + INGPLAYERTOTAL;

		end

	if GetItemInventoryCount(k) >= INGTOTAL then
		lblSListIng:SetForeColor(INGSUBCOLOR);
	end

	lblSListIng:SetText(INGTOTAL .. "x " .. k);

	end

end


function CreatePopup(ITEMNAME,QUANTITY)

	local popupMenu = Turbine.UI.ContextMenu();
	local popupItems = popupMenu:GetItems();

	local pItemName = Turbine.UI.MenuItem();
	pItemName:SetText(QUANTITY .. "x " .. ITEMNAME);
	pItemName:SetEnabled(false);
	popupItems:Add(pItemName);

	local pSList = Turbine.UI.MenuItem();
	pSList:SetText(_LANG.ADDSHOPLIST[SETTINGS.LANGUAGE]);
	pSList.Click = function (sender,args)
		AddToShoppingList(ITEMNAME,QUANTITY);
	end
	popupItems:Add(pSList);


	popupMenu:ShowMenu();

end


function AddToShoppingList(ITEMNAME,QUANTITY)

	if ITEMNAME == nil or QUANTITY == nil then return end;

	if _SHOPPINGLIST[ITEMNAME] == nil then _SHOPPINGLIST[ITEMNAME] = {} end;
	if _SHOPPINGLIST[ITEMNAME][MYNAME] == nil then _SHOPPINGLIST[ITEMNAME][MYNAME] = {} end;

	_SHOPPINGLIST[ITEMNAME][MYNAME][GLOBALRECIPENAME] = QUANTITY;

	if wShoppingListWin:IsVisible() == true then RefreshShoppingList() end;

	Debug(_LANG.DONEADDSHOPLIST[SETTINGS.LANGUAGE] .. "\n" .. QUANTITY .. "x " .. ITEMNAME);

end
