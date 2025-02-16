
function DrawInvWin()

	local tempWidth = 470;
	local tempHeight = 400;

	-- Main Parent window to hold all the elements
	wWishlistWin = Turbine.UI.Lotro.Window();
	wWishlistWin:SetSize(tempWidth,tempHeight);
	wWishlistWin:SetPosition(SETTINGS.INVENTORY.X,SETTINGS.INVENTORY.Y);
	wWishlistWin:SetText(_LANG.INVENTORY[SETTINGS.LANGUAGE]);
	wWishlistWin:SetVisible(false);
	wWishlistWin:SetHideF12(true);
	wWishlistWin:SetCloseEsc(true);
	Onscreen(wWishlistWin);

	-- Background control to hold the background image
	wWLBack = Turbine.UI.Control();
	wWLBack:SetParent(wWishlistWin);
	wWLBack:SetSize(468,399);
	wWLBack:SetPosition(1,-4);
	wWLBack:SetBlendMode(4);
	--wWLBack:SetBackground(_IMAGES.WLBACK);
	wWLBack:SetMouseVisible(false);

	-- Create the tree view control.
    treeWL = Turbine.UI.TreeView();
    treeWL:SetParent(wWishlistWin);
    treeWL:SetPosition(30,70);
    treeWL:SetSize(tempWidth-68,tempHeight-120);
    --treeWL:SetBackColor(Turbine.UI.Color(0.2,0.2,0.2));
    treeWL:SetIndentationWidth(18);

    -- Give the tree view a scroll bar.
    scrollWL = Turbine.UI.Lotro.ScrollBar();
    scrollWL:SetOrientation(Turbine.UI.Orientation.Vertical);
    scrollWL:SetParent(wWishlistWin);
    scrollWL:SetPosition(treeWL:GetLeft() + treeWL:GetWidth(),treeWL:GetTop());
    scrollWL:SetSize(8,treeWL:GetHeight());
	scrollWL:SetVisible(false);

    treeWL:SetVerticalScrollBar(scrollWL);

	-- Expand All icon
	ctrExpandALLIcon = Turbine.UI.Control();
	ctrExpandALLIcon:SetParent(wWishlistWin);
	ctrExpandALLIcon:SetSize(16,16);
	ctrExpandALLIcon:SetPosition(30,40);
	ctrExpandALLIcon:SetBlendMode(4);
	ctrExpandALLIcon:SetBackground(_IMAGES.ICONEXPANDALL);

	ctrExpandALLIcon.MouseEnter = function(sender,args)
		ctrExpandALLIcon:SetBackground(_IMAGES.ICONEXPANDALLOVER);
	end

	ctrExpandALLIcon.MouseLeave = function(sender,args)
		ctrExpandALLIcon:SetBackground(_IMAGES.ICONEXPANDALL);
	end

	ctrExpandALLIcon.MouseClick = function(sender,args)
		treeWL:ExpandAll();

		local tempTreeList = treeWL:GetNodes();
		local tempNodeCount = tempTreeList:GetCount();

		for i=1,tempNodeCount do

			local tempCurNode = tempTreeList:Get(i);
			local tempChildControls = tempCurNode:GetControls();

			local tempHeaderHold = tempChildControls:Get(1);
			local tempHeadChilds = tempHeaderHold:GetControls();

			local expandicon = tempHeadChilds:Get(1);
			expandicon:SetBackground(_IMAGES.ICONCOLLAPSE);
		end
	end

	-- Collapse All icon
	ctrCollapseALLIcon = Turbine.UI.Control();
	ctrCollapseALLIcon:SetParent(wWishlistWin);
	ctrCollapseALLIcon:SetSize(16,16);
	ctrCollapseALLIcon:SetPosition(50,40);
	ctrCollapseALLIcon:SetBlendMode(4);
	ctrCollapseALLIcon:SetBackground(_IMAGES.ICONCOLLAPSEALL);

	ctrCollapseALLIcon.MouseEnter = function(sender,args)
		ctrCollapseALLIcon:SetBackground(_IMAGES.ICONCOLLAPSEALLOVER);
	end

	ctrCollapseALLIcon.MouseLeave = function(sender,args)
		ctrCollapseALLIcon:SetBackground(_IMAGES.ICONCOLLAPSEALL);
	end

	ctrCollapseALLIcon.MouseClick = function(sender,args)
		treeWL:CollapseAll();

		local tempTreeList = treeWL:GetNodes();
		local tempNodeCount = tempTreeList:GetCount();

		for i=1,tempNodeCount do

			local tempCurNode = tempTreeList:Get(i);
			local tempChildControls = tempCurNode:GetControls();

			local tempHeaderHold = tempChildControls:Get(1);
			local tempHeadChilds = tempHeaderHold:GetControls();

			local expandicon = tempHeadChilds:Get(1);
			expandicon:SetBackground(_IMAGES.ICONEXPAND);
		end
	end

--~ 	-- Select all checkbox
--~ 	chkSelAllWL = Turbine.UI.Lotro.CheckBox();
--~ 	chkSelAllWL:SetParent(wWishlistWin);
--~ 	chkSelAllWL:SetPosition(35,treeWL:GetTop() + treeWL:GetHeight() + 11);
--~ 	chkSelAllWL:SetSize(130,20);
--~ 	chkSelAllWL:SetFont(LISTFONT);
--~ 	chkSelAllWL:SetForeColor(BEIGE);
--~ 	chkSelAllWL:SetText(" Check all");

--~ 	chkSelAllWL.CheckedChanged = function (sender,args)

--~ 	end

--~ 	-- Delete button
--~ 	btnRemoveWL = Turbine.UI.Lotro.Button();
--~ 	btnRemoveWL:SetParent(wWishlistWin);
--~ 	btnRemoveWL:SetPosition((treeWL:GetLeft() + treeWL:GetWidth())-80,treeWL:GetTop() + treeWL:GetHeight() + 13);
--~ 	btnRemoveWL:SetWidth(80);
--~ 	btnRemoveWL:SetText("Delete");

--~ 	btnRemoveWL.Click = function(sender,args)
--~ 		RemoveFromWL();
--~ 	end

	RefreshWL();


	-- Window Events
	wWishlistWin.PositionChanged = function()
		SETTINGS.INVENTORY.X = wWishlistWin:GetLeft();
		SETTINGS.INVENTORY.Y = wWishlistWin:GetTop();
	end

end


function OpenWishList()

	RefreshWL();
	wWishlistWin:SetVisible(true);
	wWishlistWin:Activate();

end


function RemoveFromWL()
	-- Remove selected entries

end


function RefreshWL()

	-- Populates the tree from the table
	local RootNodes = treeWL:GetNodes();
	RootNodes:Clear();
	_chkCurItem = nil;
	_chkCurItem = {};

	local t2 = {}

	table.foreach (_INVENTORY, function (k) table.insert (t2, k) end );

	table.sort (t2);


	for k,v in pairs (t2) do

		local CURINVITEM = _INVENTORY[v];

		-- Add items from _TypeTable to tree
		local CurTreeNode = Turbine.UI.TreeNode();
		CurTreeNode:SetSize(treeWL:GetWidth()-2,36);

		local HeaderHolder = Turbine.UI.Control();
		HeaderHolder:SetParent(CurTreeNode);
		HeaderHolder:SetSize(CurTreeNode:GetWidth(),34);
		HeaderHolder:SetBackColor(HDBLUE);
		HeaderHolder:SetMouseVisible(false);

		local ctrExpandIcon = Turbine.UI.Control();
		ctrExpandIcon:SetParent(HeaderHolder);
		ctrExpandIcon:SetSize(16,16);
		ctrExpandIcon:SetPosition(2,10);
		ctrExpandIcon:SetBlendMode(4);
		ctrExpandIcon:SetBackground(_IMAGES.ICONEXPAND);
		ctrExpandIcon:SetMouseVisible(false);

		CurTreeNode.MouseClick = function(sender,args)
			if CurTreeNode:IsExpanded() == true then
				ctrExpandIcon:SetBackground(_IMAGES.ICONCOLLAPSE);
			else
				ctrExpandIcon:SetBackground(_IMAGES.ICONEXPAND);
			end
		end

		--Turbine.Shell.WriteLine(v["IMAGE"]);
		IMAGEID = CURINVITEM["IMAGE"];
		BACKIMAGEID = CURINVITEM["BACKIMAGE"];

		local ctrInvIconBack = Turbine.UI.Control();
		ctrInvIconBack:SetParent(HeaderHolder);
		ctrInvIconBack:SetSize(32,32);
		ctrInvIconBack:SetPosition(20,2);
		ctrInvIconBack:SetBlendMode(BLEND_NORMAL);
		ctrInvIconBack:SetBackground(BACKIMAGEID);
		ctrInvIconBack:SetMouseVisible(false);

		local ctrInvIcon = Turbine.UI.Control();
		ctrInvIcon:SetParent(ctrInvIconBack);
		ctrInvIcon:SetSize(32,32);
		ctrInvIcon:SetPosition(0,0);
		ctrInvIcon:SetBlendMode(BLEND_OVERLAY);
		ctrInvIcon:SetBackground(IMAGEID);
		ctrInvIcon:SetMouseVisible(false);

		local lblTypeHeader = Turbine.UI.Label();
		lblTypeHeader:SetParent(HeaderHolder);
		lblTypeHeader:SetSize(HeaderHolder:GetWidth()-60,20);
		lblTypeHeader:SetPosition(58,10);
		lblTypeHeader:SetTextAlignment(LEFTALIGN);
		lblTypeHeader:SetForeColor(WHITE);
		lblTypeHeader:SetFont(BFONT);
		lblTypeHeader:SetText(v);
		lblTypeHeader:SetMouseVisible(false);

		RootNodes:Add(CurTreeNode);

		local ChildNodes = CurTreeNode:GetChildNodes();

		-- Loop through _TypeTable to add each item.

		local _TEMPITEMINV = _INVENTORY[v];
		local _TEMPINVAREAS = _TEMPITEMINV["AREAS"];

		for a,b in pairs (_TEMPINVAREAS) do

			local charTotals = 0;

			if type(b) == 'table' then

				local _TEMPCHAR = b;

				if _TEMPCHAR.VAULT ~= nil then charTotals = charTotals + _TEMPCHAR.VAULT end;
				if _TEMPCHAR.BACKPACK ~= nil then charTotals = charTotals + _TEMPCHAR.BACKPACK end;

			elseif a == "Shared Storage" then

				charTotals = b;

			end


			local CurChildNode = Turbine.UI.TreeNode();
			CurChildNode:SetSize(treeWL:GetWidth(),23);

			local RowHolder = Turbine.UI.Control();
			RowHolder:SetParent(CurChildNode);
			RowHolder:SetSize(treeWL:GetWidth()-22,22)

			local lblCharsInv  = Turbine.UI.Label();
			lblCharsInv:SetParent(RowHolder);
			lblCharsInv:SetPosition(0,0);
			lblCharsInv:SetSize(RowHolder:GetWidth(),22);
			lblCharsInv:SetFont(TrajanPro14);
			lblCharsInv:SetTextAlignment(LEFTALIGN);
			lblCharsInv:SetForeColor(WHITE);
			lblCharsInv:SetText(charTotals .. " " .. a);


			if charTotals ~= 0 then ChildNodes:Add(CurChildNode) end;
		end

		if CurTreeNode:GetChildNodes():GetCount() == 0 then

			RootNodes:Remove(CurTreeNode);

		end

	end

end


