
function DrawMainWin()

	local tempWidth = 800;
	local tempHeight = 580;

	-- Main Parent window to hold all the elements
	wMainWinParent = Turbine.UI.Lotro.Window();
	wMainWinParent:SetSize(tempWidth,tempHeight);
	wMainWinParent:SetPosition(SETTINGS.MAINWIN.X,SETTINGS.MAINWIN.Y);
	wMainWinParent:SetText(_LANG.MAINWINTITLE[SETTINGS.LANGUAGE] .. ": " .. GetMyVocation());
	wMainWinParent:SetVisible(SETTINGS.MAINWIN.VISIBLE);
	wMainWinParent:AssignToDesktopIcon(true);
	wMainWinParent:SetHideF12(true);
	wMainWinParent:SetCloseEsc(true);

	Onscreen(wMainWinParent); -- Makes sure the window is still onscreen (perhaps user changed resolution since last playing)


	-- Background control to hold the background image
	wMainWinBack = Turbine.UI.Control();
	wMainWinBack:SetParent(wMainWinParent);
	wMainWinBack:SetSize(800,586);
	wMainWinBack:SetPosition(0,-7);
	wMainWinBack:SetBlendMode(4);
	wMainWinBack:SetBackground(_IMAGES.MAINWINBACK);
	wMainWinBack:SetMouseVisible(false);

	wRecipeBackCrit = Turbine.UI.Control();
	wRecipeBackCrit:SetParent(wMainWinParent);
	wRecipeBackCrit:SetSize(446,481);
	wRecipeBackCrit:SetPosition(336,50);
	wRecipeBackCrit:SetBlendMode(4);
	wRecipeBackCrit:SetBackground(_IMAGES.INGREDIENTSBACK_CRIT);
	wRecipeBackCrit:SetMouseVisible(false);
	wRecipeBackCrit:SetVisible(false);

	wRecipeBackNoCrit = Turbine.UI.Control();
	wRecipeBackNoCrit:SetParent(wMainWinParent);
	wRecipeBackNoCrit:SetSize(446,481);
	wRecipeBackNoCrit:SetPosition(336,50);
	wRecipeBackNoCrit:SetBlendMode(4);
	wRecipeBackNoCrit:SetBackground(_IMAGES.INGREDIENTSBACK_NOCRIT);
	wRecipeBackNoCrit:SetMouseVisible(false);
	wRecipeBackNoCrit:SetVisible(false);


	-- Holding window
	wMainWinHolder = Turbine.UI.Control();
	wMainWinHolder:SetParent(wMainWinParent);
	wMainWinHolder:SetSize(tempWidth-20,tempHeight-90);
	wMainWinHolder:SetPosition(10,40);


	local _MYPROFS = {};


	for k,v in pairs (_PROFESSIONSINFO[MYNAME]) do

		table.insert(_MYPROFS,k);
		DrawTabWindow(k);

	end


	btnProfOne = Turbine.UI.Button();
	btnProfOne:SetParent(wMainWinParent);
	btnProfOne:SetSize(110,30);
	btnProfOne:SetPosition(10,tempHeight-49);
	btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
	btnProfOne:SetBlendMode(BLEND_ALPHA);
	btnProfOne:SetForeColor(Turbine.UI.Color.DarkKhaki);
	btnProfOne:SetOutlineColor(BLACK);
	btnProfOne:SetFontStyle(Turbine.UI.FontStyle.Outline);
	btnProfOne:SetFont(TrajanPro14);
	btnProfOne:SetText(_MYPROFS[1]);
	btnProfOne:SetVisible(true);

	btnProfOne.MouseClick = function (sender, args)
		SetProfession(_MYPROFS[1]);
		SELECTEDBUTTON = 1;
		btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		btnProfOne:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfOne.MouseEnter = function (sender, args)
		btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_OVER);
		btnProfOne:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfOne.MouseLeave = function (sender, args)
		if SELECTEDBUTTON == 1 then
			btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		else
			btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		end
		btnProfOne:SetForeColor(Turbine.UI.Color.DarkKhaki);
	end


	btnProfTwo = Turbine.UI.Button();
	btnProfTwo:SetParent(wMainWinParent);
	btnProfTwo:SetSize(110,30);
	btnProfTwo:SetPosition(120,tempHeight-49);
	btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
	btnProfTwo:SetBlendMode(BLEND_ALPHA);
	btnProfTwo:SetForeColor(btnProfOne:GetForeColor());
	btnProfTwo:SetOutlineColor(btnProfOne:GetOutlineColor());
	btnProfTwo:SetFontStyle(Turbine.UI.FontStyle.Outline);
	btnProfTwo:SetFont(TrajanPro14);
	btnProfTwo:SetText(_MYPROFS[2]);
	btnProfTwo:SetVisible(true);

	btnProfTwo.MouseClick = function (sender, args)
		SetProfession(_MYPROFS[2]);
		SELECTEDBUTTON = 2;
		btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		btnProfTwo:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfTwo.MouseEnter = function (sender, args)
		btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_OVER);
		btnProfTwo:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfTwo.MouseLeave = function (sender, args)
		if SELECTEDBUTTON == 2 then
			btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		else
			btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		end
		btnProfTwo:SetForeColor(Turbine.UI.Color.DarkKhaki);
	end


	btnProfThree = Turbine.UI.Button();
	btnProfThree:SetParent(wMainWinParent);
	btnProfThree:SetSize(110,30);
	btnProfThree:SetPosition(230,tempHeight-49);
	btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
	btnProfThree:SetBlendMode(BLEND_ALPHA);
	btnProfThree:SetForeColor(btnProfOne:GetForeColor());
	btnProfThree:SetOutlineColor(btnProfOne:GetOutlineColor());
	btnProfThree:SetFontStyle(Turbine.UI.FontStyle.Outline);
	btnProfThree:SetFont(TrajanPro14);
	btnProfThree:SetText(_MYPROFS[3]);
	btnProfThree:SetVisible(true);

	btnProfThree.MouseClick = function (sender, args)
		SetProfession(_MYPROFS[3]);
		SELECTEDBUTTON = 3;
		btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		btnProfThree:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfThree.MouseEnter = function (sender, args)
		btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_OVER);
		btnProfThree:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfThree.MouseLeave = function (sender, args)
		if SELECTEDBUTTON == 3 then
			btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		else
			btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		end
		btnProfThree:SetForeColor(Turbine.UI.Color.DarkKhaki);
	end


	btnProfFour = Turbine.UI.Button();
	btnProfFour:SetParent(wMainWinParent);
	btnProfFour:SetSize(110,30);
	btnProfFour:SetPosition(340,tempHeight-49);
	btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
	btnProfFour:SetBlendMode(BLEND_ALPHA);
	btnProfFour:SetForeColor(btnProfOne:GetForeColor());
	btnProfFour:SetOutlineColor(btnProfOne:GetOutlineColor());
	btnProfFour:SetFontStyle(Turbine.UI.FontStyle.Outline);
	btnProfFour:SetFont(TrajanPro14);
	btnProfFour:SetText(_MYPROFS[4]);
	btnProfFour:SetVisible(true);

	btnProfFour.MouseClick = function (sender, args)
		SetProfession(_MYPROFS[4]);
		SELECTEDBUTTON = 4;
		btnProfOne:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfTwo:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfThree:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		btnProfFour:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfFour.MouseEnter = function (sender, args)
		btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_OVER);
		btnProfFour:SetForeColor(Turbine.UI.Color.Yellow);
	end

	btnProfFour.MouseLeave = function (sender, args)
		if SELECTEDBUTTON == 4 then
			btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_SELECTED);
		else
			btnProfFour:SetBackground(_IMAGES.BTNPROFESSION_NORMAL);
		end
		btnProfFour:SetForeColor(Turbine.UI.Color.DarkKhaki);
	end


	GLOBALPROFESSION = _MYPROFS[1];

	SetProfession(_MYPROFS[1]);


	btnAlts = Turbine.UI.Lotro.GoldButton();
	btnAlts:SetParent(wMainWinParent);
	btnAlts:SetWidth(80);
	btnAlts:SetPosition(tempWidth-btnAlts:GetWidth()-80,10);
	btnAlts:SetText(_LANG.ALTS[SETTINGS.LANGUAGE]);
	btnAlts:SetVisible(true);

	btnAlts.MouseClick = function (sender, args)
		if wAltsMainWin:IsVisible() == false then
			wAltsMainWin:SetVisible(true);
		else
			wAltsMainWin:SetVisible(false);
		end
	end

	btnInv = Turbine.UI.Lotro.GoldButton();
	btnInv:SetParent(wMainWinParent);
	btnInv:SetWidth(130);
	btnInv:SetPosition(tempWidth-btnInv:GetWidth()-40,tempHeight-40);
	btnInv:SetText(_LANG.INVENTORY[SETTINGS.LANGUAGE]);
	btnInv:SetVisible(true);

	btnInv.MouseClick = function (sender, args)
		if wWishlistWin:IsVisible() == false then
			OpenWishList();
		else
			wWishlistWin:SetVisible(false);
		end
	end

	btnShopList = Turbine.UI.Lotro.GoldButton();
	btnShopList:SetParent(wMainWinParent);
	btnShopList:SetWidth(130);
	btnShopList:SetPosition(btnInv:GetLeft()-btnShopList:GetWidth()-15,tempHeight-40);
	btnShopList:SetText(_LANG.SHOPPINGLIST[SETTINGS.LANGUAGE]);
	btnShopList:SetVisible(true);

	btnShopList.MouseClick = function (sender, args)
		if wShoppingListWin:IsVisible() == false then
			RefreshShoppingList();
			wShoppingListWin:SetVisible(true);
			wShoppingListWin:Activate();
		else
			wShoppingListWin:SetVisible(false);
		end
	end


	-- Window events
	wMainWinParent.Closing = function()
		SETTINGS.MAINWIN.VISIBLE = false;
		Debug(_LANG.COMMANDWARNING[SETTINGS.LANGUAGE]);
	end

	wMainWinParent.PositionChanged = function()
		SETTINGS.MAINWIN.X = wMainWinParent:GetLeft();
		SETTINGS.MAINWIN.Y = wMainWinParent:GetTop();
	end


end


function SetProfession(SELPROFESSION) -- SELPROFESSION = string name of profession

	if SELPROFESSION == nil then return end;

	GLOBALPROFESSION = SELPROFESSION;

	-- Sets the appropriate tab window to visible
	for k,v in pairs (_wProfTabWins) do

		if k == SELPROFESSION then
			_wProfTabWins[k]:SetVisible(true);
		else
			_wProfTabWins[k]:SetVisible(false);
		end
	end
end


function DrawTabWindow(KEY)

	if KEY == nil then return end;

	_wProfTabWins[KEY] = Turbine.UI.Control();
	_wProfTabWins[KEY]:SetParent(wMainWinHolder);
	_wProfTabWins[KEY]:SetSize(wMainWinHolder:GetSize());
	_wProfTabWins[KEY]:SetPosition(0,0);
	_wProfTabWins[KEY]:SetVisible(false);

--~ 	local lblProfession = Turbine.UI.Label();
--~ 	lblProfession:SetParent(_wProfTabWins[KEY]);
--~ 	lblProfession:SetSize(140,18);
--~ 	lblProfession:SetPosition(40,124);
--~ 	lblProfession:SetFont(TrajanPro16);
--~ 	lblProfession:SetForeColor(Turbine.UI.Color.Goldenrod);
--~ 	lblProfession:SetText(KEY);


	-- Create the tree view control.
    _tvRecipes[KEY] = Turbine.UI.TreeView();
    _tvRecipes[KEY]:SetParent(_wProfTabWins[KEY]);
    _tvRecipes[KEY]:SetPosition(10,150);
    _tvRecipes[KEY]:SetSize(300,_wProfTabWins[KEY]:GetHeight()-160);
    --_tvRecipes[KEY]:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
    _tvRecipes[KEY]:SetIndentationWidth(7);


    -- Give the tree view a scroll bar.
    local sctvRecipes = Turbine.UI.Lotro.ScrollBar();
    sctvRecipes:SetOrientation(Turbine.UI.Orientation.Vertical);
    sctvRecipes:SetParent(_wProfTabWins[KEY]);
    sctvRecipes:SetPosition(_tvRecipes[KEY]:GetLeft() + _tvRecipes[KEY]:GetWidth(),_tvRecipes[KEY]:GetTop());
    sctvRecipes:SetSize(8,_tvRecipes[KEY]:GetHeight());
	sctvRecipes:SetVisible(false);

    _tvRecipes[KEY]:SetVerticalScrollBar(sctvRecipes);


	-- Expand all button
	local iconRECIPEEXPAND = Turbine.UI.Control();
	iconRECIPEEXPAND:SetParent(_wProfTabWins[KEY]);
	iconRECIPEEXPAND:SetSize(16,16);
	iconRECIPEEXPAND:SetPosition(10,124);
	iconRECIPEEXPAND:SetBlendMode(BLEND_OVERLAY);
	iconRECIPEEXPAND:SetBackground(_IMAGES.ICONEXPANDALL);

	iconRECIPEEXPAND.MouseClick = function(sender,args)
		_tvRecipes[KEY]:ExpandAll();
		ExpandIcons(_tvRecipes[KEY])
	end

	iconRECIPEEXPAND.MouseEnter = function(sender,args)
		iconRECIPEEXPAND:SetBackground(_IMAGES.ICONEXPANDALLOVER);
	end

	iconRECIPEEXPAND.MouseLeave = function(sender,args)
		iconRECIPEEXPAND:SetBackground(_IMAGES.ICONEXPANDALL);
	end

	-- collapse all button
	local iconRECIPECOLLAPSE = Turbine.UI.Control();
	iconRECIPECOLLAPSE:SetParent(_wProfTabWins[KEY]);
	iconRECIPECOLLAPSE:SetSize(16,16);
	iconRECIPECOLLAPSE:SetPosition(30,124);
	iconRECIPECOLLAPSE:SetBlendMode(BLEND_OVERLAY);
	iconRECIPECOLLAPSE:SetBackground(_IMAGES.ICONCOLLAPSEALL);

	iconRECIPECOLLAPSE.MouseClick = function(sender,args)
		_tvRecipes[KEY]:CollapseAll();
		ExpandIcons(_tvRecipes[KEY],false)
	end

	iconRECIPECOLLAPSE.MouseEnter = function(sender,args)
		iconRECIPECOLLAPSE:SetBackground(_IMAGES.ICONCOLLAPSEALLOVER);
	end

	iconRECIPECOLLAPSE.MouseLeave = function(sender,args)
		iconRECIPECOLLAPSE:SetBackground(_IMAGES.ICONCOLLAPSEALL);
	end


	-- Fill the tree with the relative craft recipes.

	RefreshRecipeList(KEY);

	-- Recipe View
	_wRecipeView[KEY] = Turbine.UI.Control();
	_wRecipeView[KEY]:SetParent(_wProfTabWins[KEY]);
	_wRecipeView[KEY]:SetSize(440,_wProfTabWins[KEY]:GetHeight()-20);
	_wRecipeView[KEY]:SetPosition(_tvRecipes[KEY]:GetLeft() + _tvRecipes[KEY]:GetWidth() + 20,20);
	--_wRecipeView[KEY]:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
	_wRecipeView[KEY]:SetVisible(false);


	-- Recipe Info
	_wRecipeInfo[KEY] = Turbine.UI.Control();
	_wRecipeInfo[KEY]:SetParent(_wProfTabWins[KEY]);
	_wRecipeInfo[KEY]:SetSize(_tvRecipes[KEY]:GetWidth(),80);
	_wRecipeInfo[KEY]:SetPosition(10,20);
	--_wRecipeInfo[KEY]:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
	_wRecipeInfo[KEY]:SetVisible(true);

end


function RefreshRecipeList(KEY,CHARNAME) -- KEY = string name of profession e.g. jeweller.

	if CHARNAME == nil then CHARNAME = MYNAME end;

	-- Clear the treeview first
	local RootNode = _tvRecipes[KEY]:GetNodes();
	RootNode:Clear();

	-- Reset recipe labels for this profession
	_RECIPELABELS[KEY] = nil;
	_RECIPELABELS[KEY] = {};

	local _CURPROFESSION = _PROFESSIONSINFO[MYNAME][KEY];
	local _CURRECIPES = _RECIPES[KEY];

	local MAXTIER = GetMaxTier(KEY);

	--Debug(CHARNAME..": " ..KEY.." = "..MAXTIER);

	-- Loop through each craft tier to add the recipes, start at the highest..
	for i=MAXTIER, 1, -1 do

		-- Root Nodes for the Tiers of crafting.
		local CURTIERNODE = Turbine.UI.TreeNode();
		CURTIERNODE:SetSize(_tvRecipes[KEY]:GetWidth()-2,18);

		local TierHolder = Turbine.UI.Control();
		TierHolder:SetParent(CURTIERNODE);
		TierHolder:SetSize(CURTIERNODE:GetWidth(),18);
		--TierHolder:SetBackColor(HDBLUELT);
		TierHolder:SetMouseVisible(false);

		local ICONEXPAND = Turbine.UI.Control();
		ICONEXPAND:SetParent(TierHolder);
		ICONEXPAND:SetSize(16,16);
		ICONEXPAND:SetPosition(0,1);
		ICONEXPAND:SetMouseVisible(false);
		ICONEXPAND:SetBlendMode(BLEND_OVERLAY);
		ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);

		CURTIERNODE.MouseClick = function(sender,args)
			if CURTIERNODE:IsExpanded() == true then
				ICONEXPAND:SetBackground(_IMAGES.ICONCOLLAPSE);
			else
				ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);
			end
		end

		local lblTier = Turbine.UI.Label();
		lblTier:SetParent(TierHolder);
		lblTier:SetSize(TierHolder:GetWidth()-20,TierHolder:GetHeight());
		lblTier:SetPosition(20,0);
		lblTier:SetTextAlignment(LEFTALIGN);
		lblTier:SetMouseVisible(false);
		lblTier:SetMarkupEnabled(true);
		lblTier:SetFont(TrajanPro15);

		local REMAININGXP = 0;

		if i > _CURPROFESSION.MasteryLevel then

			lblTier:SetForeColor(GREY4);

			--[[
			Debug("i".. " = "..i);
			Debug("ProficiencyLevel".. " = ".._CURPROFESSION.ProficiencyLevel);
			Debug("ProficiencyExperienceTarget".. " = ".._CURPROFESSION.ProficiencyExperienceTarget);
			--]]

			if i == (_CURPROFESSION.ProficiencyLevel + 1) then
				-- Proficiency at this tier only.
				if Data._MASTERYXP[i] == nil then
					REMAININGXP = 9999;
				else
					REMAININGXP = (_CURPROFESSION.ProficiencyExperienceTarget - _CURPROFESSION.ProficiencyExperience) + Data._MASTERYXP[i];
				end
			elseif i == (_CURPROFESSION.MasteryLevel + 1) then
				-- Mastery at this tier only
				REMAININGXP = (_CURPROFESSION.MasteryExperienceTarget - _CURPROFESSION.MasteryExperience);
			end

			--[[
			["Jeweller"] = {
				["ProficiencyExperienceTarget"] = 840
				["MasteryExperience"] = 0
				["ProficiencyLevel"] = 10
				["MasteryLevel"] = 10
				["ProfessionName"] = "Jeweller"
				["MasteryExperienceTarget"] = 1680
				["ProficiencyExperience"] = 0
			}
			--]]


			lblTier:SetText(GetCraftTier(i) .. " <rgb=#" .. XPTIERHEX .. ">(" .. _LANG.NEED[SETTINGS.LANGUAGE] .. " " .. CommaNumbers(REMAININGXP) .. "xp)</rgb>");

			_RECIPELABELS[KEY][i] =
				{
				["TIERLABEL"] = lblTier;
				["REMAININGXP"] = REMAININGXP;
				["LABELS"] = {};
				};



		else
			-- Mastered current level.
			lblTier:SetForeColor(YELLOW2);
			lblTier:SetText(GetCraftTier(i));
		end


		RootNode:Add(CURTIERNODE);


			-- Child nodes for each category for that tier.
			local CATNODES = CURTIERNODE:GetChildNodes();

			local _CURCATNAMES = {};
			_CURCATNAMES = GetTierCategories(KEY,i);


			for k,v in pairs (_CURCATNAMES) do

				local CURCATNODE = Turbine.UI.TreeNode();
				CURCATNODE:SetSize(_tvRecipes[KEY]:GetWidth()-2,18);

				local CatHolder = Turbine.UI.Control();
				CatHolder:SetParent(CURCATNODE);
				CatHolder:SetSize(CURCATNODE:GetWidth(),18);
				--CatHolder:SetBackColor(HDBLUE);
				CatHolder:SetMouseVisible(false);

				local CATICONEXPAND = Turbine.UI.Control();
				CATICONEXPAND:SetParent(CatHolder);
				CATICONEXPAND:SetSize(16,16);
				CATICONEXPAND:SetPosition(0,1);
				CATICONEXPAND:SetMouseVisible(false);
				CATICONEXPAND:SetBlendMode(BLEND_OVERLAY);
				CATICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);

				CURCATNODE.MouseClick = function(sender,args)
					if CURCATNODE:IsExpanded() == true then
						CATICONEXPAND:SetBackground(_IMAGES.ICONCOLLAPSE);
					else
						CATICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);
					end
				end

				local lblCat = Turbine.UI.Label();
				lblCat:SetParent(CatHolder);
				lblCat:SetSize(CatHolder:GetSize());
				lblCat:SetPosition(20,0);
				lblCat:SetMouseVisible(false);
				lblCat:SetFont(Verdana14);
				lblCat:SetTextAlignment(LEFTALIGN);
				lblCat:SetText(v);

				CATNODES:Add(CURCATNODE);

					-- Child nodes for each recipe in that category
					local RECIPENODES = CURCATNODE:GetChildNodes();

					local _CURRECEIPENAMES = {};
					_CURRECEIPENAMES = GetCategoryRecipes(KEY,i,v);

					for a,b in pairs (_CURRECEIPENAMES) do

						local SINGLEUSE = _CURRECIPES[a].IsSingleUse;
						local RECIPEXP = _CURRECIPES[a].ExperienceReward;
						local RECNAME = b;

						local CURRECIPENODE = Turbine.UI.TreeNode();
						CURRECIPENODE:SetSize(_tvRecipes[KEY]:GetWidth()-2,18);

						local RecipeHolder = Turbine.UI.Control();
						RecipeHolder:SetParent(CURRECIPENODE);
						RecipeHolder:SetSize(CURRECIPENODE:GetWidth(),18);
						--RecipeHolder:SetBackColor(HDBLUE);
						RecipeHolder:SetMouseVisible(false);


						local RECIPEICON = Turbine.UI.Control();
						RECIPEICON:SetParent(RecipeHolder);
						RECIPEICON:SetSize(16,16);
						RECIPEICON:SetPosition(0,1);
						RECIPEICON:SetBlendMode(BLEND_OVERLAY);

						if _CURRECIPES[a].IsSingleUse == true then

							RECIPEICON:SetBackground(_IMAGES.SINGLEUSE);

						elseif _CURRECIPES[a].Cooldown > 0 then

							RECIPEICON:SetBackground(_IMAGES.RECIPEREADY);

						end


						local lblRecipe = Turbine.UI.Label();
						lblRecipe:SetParent(RecipeHolder);
						lblRecipe:SetSize(RecipeHolder:GetSize());
						lblRecipe:SetPosition(20,0);
						lblRecipe:SetTextAlignment(LEFTALIGN);
						lblRecipe:SetFont(Verdana14);
						lblRecipe:SetMultiline(false);
						lblRecipe:SetMarkupEnabled(true);
						lblRecipe:SetMouseVisible(false);

						if _CURRECIPES[a].IsKnown == false then
							lblRecipe:SetForeColor(Turbine.UI.Color.Maroon);
						end

						if REMAININGXP == 0 then

							if string.len(b) > 33 then b=string.sub(b,1,33) .. "..." end;

							CURRECIPENODE.MouseClick = function (sender,args)
								RefreshRecipeView(KEY,a,1,0); -- Update the recipe view window when clicked.
							end

						else

							if string.len(b) > 23 then b=string.sub(b,1,23) .. "..." end;

							--local TOCRAFTFORMAXXP = math.ceil(REMAININGXP/RECIPEXP);

							local TOCRAFTFORMAXXP = math.ceil(_RECIPELABELS[KEY][i]["REMAININGXP"]/RECIPEXP);


							b = b .. " <rgb=#" .. XPRECIPEHEX .. ">(" .. TOCRAFTFORMAXXP .. " " .. _LANG.AT[SETTINGS.LANGUAGE] .. " " .. RECIPEXP .. "xp)</rgb>";

							_RECIPELABELS[KEY][i]["LABELS"][a] =
								{
								["XP"] = RECIPEXP;
								["LABELCONTROL"] = lblRecipe;
								["NAME"] = RECNAME;
								};

							CURRECIPENODE.MouseClick = function (sender,args)
								local TOCRAFTFORMAXXP = math.ceil(_RECIPELABELS[KEY][i]["REMAININGXP"]/RECIPEXP);
								RefreshRecipeView(KEY,a,TOCRAFTFORMAXXP,_RECIPELABELS[KEY][i]["REMAININGXP"]); -- Update the recipe view window when clicked.
							end

						end

						lblRecipe:SetText(b);

--~ 						CURRECIPENODE.MouseClick = function (sender,args)
--~ 							RefreshRecipeView(KEY,a); -- Update the recipe view window when clicked.
--~ 						end

						RECIPENODES:Add(CURRECIPENODE);

					end
				--
			end
		--
	end
end


function RefreshRecipeView(PROFESSION,RECIPEID,RECIPEQTY,XPREMAINING)

	if PROFESSION == nil or RECIPEID == nil then return end;
	if RECIPEQTY == nil then RECIPEQTY = 1 end;

	GLOBALRECIPEID = RECIPEID;

	-- This function is called when the user clicks a recipe name in the tree list.
	-- It takes PROFESSION which is the profession name and RECIPEID which is the key number in the recipe table.

	-- Clear the old controls.
	_wRecipeView[PROFESSION]:GetControls():Clear();
	_wRecipeInfo[PROFESSION]:GetControls():Clear();

	-- Reset the base items table
	_BASEITEMSLIST = nil;
	_BASEITEMSLIST = {};

	_INGREDIENTLIST = nil;
	_INGREDIENTLIST = {};


	local _CURRECIPE = _RECIPES[PROFESSION][RECIPEID]; -- Exact recipe based on RECIPEID.

	GLOBALRECIPENAME = _CURRECIPE.ResultItemName;

	CURRECIPETIER = _CURRECIPE.Tier;
	local MASTERYLEVEL = _PROFESSIONSINFO[MYNAME][PROFESSION].MasteryLevel;
	local RECCOOLDOWN = _CURRECIPE.Cooldown;
	RECIPEMAXXP = _CURRECIPE.ExperienceReward;

	------------------------------------------------------------------------------------------


	local iconNOMALITEM = Turbine.UI.Lotro.ItemInfoControl();
	iconNOMALITEM:SetParent(_wRecipeInfo[PROFESSION]);
	iconNOMALITEM:SetPosition(5,0);
	iconNOMALITEM:SetSize(35,35);
	iconNOMALITEM:SetQuantity(_CURRECIPE.ResultItemQuantity);
	iconNOMALITEM:SetItemInfo(_CURRECIPE.ResultItemInfo);


	local lblRECIPENAME = Turbine.UI.Label();
	lblRECIPENAME:SetParent(_wRecipeInfo[PROFESSION]);
	lblRECIPENAME:SetPosition(50,0);
	lblRECIPENAME:SetSize(_wRecipeInfo[PROFESSION]:GetWidth()-55,35);
	lblRECIPENAME:SetTextAlignment(LEFTALIGN);
	lblRECIPENAME:SetMultiline(true);
	lblRECIPENAME:SetFont(TrajanPro16);
	lblRECIPENAME:SetForeColor(GetItemFontColor(_CURRECIPE.ResultItemInfo));
	--lblRECIPENAME:SetBackColor(HDBLUE);
	lblRECIPENAME:SetText(_CURRECIPE.ResultItemName);


	local lblRECIPEEXPERIENCE = Turbine.UI.Label();
	lblRECIPEEXPERIENCE:SetParent(_wRecipeInfo[PROFESSION]);
	lblRECIPEEXPERIENCE:SetSize(185,18);
	lblRECIPEEXPERIENCE:SetPosition(_wRecipeInfo[PROFESSION]:GetWidth()-lblRECIPEEXPERIENCE:GetWidth()-5,42);
	lblRECIPEEXPERIENCE:SetForeColor(Turbine.UI.Color.Aquamarine);
	--lblRECIPEEXPERIENCE:SetBackColor(HDBLUE);
	lblRECIPEEXPERIENCE:SetFont(Verdana14);
	lblRECIPEEXPERIENCE:SetTextAlignment(RIGHTALIGN);


	--RECCOOLDOWN = 101880;

	if RECCOOLDOWN > 0 then

		local TIMESTRING = _LANG.COOLDOWN[SETTINGS.LANGUAGE] .. ": ";

		-- RECCOOLDOWN is in seconds.. Need to convert to days & hours.
		local CDHOURS = RECCOOLDOWN / 3600; -- 3600 seconds an hour

		if CDHOURS <= 1 then
			-- Less that 1 hour on CD.
			local CDMINS = math.floor(CDHOURS * 60);
			local sMINS = "";

			if CDMINS == 1 then
				sMINS = _LANG.MINUTE[SETTINGS.LANGUAGE];
			else
				sMINS = _LANG.MINUTES[SETTINGS.LANGUAGE];
			end

			TIMESTRING = TIMESTRING .. CDMINS .. " " .. sMINS;

		elseif CDHOURS > 1 and CDHOURS <=24 then

			-- Between 1 hour and 1 day.
			local sHOURS = "";
			local sMINS = "";
			local CDMINS = 0;

			CDHOURS,CDMINS = math.modf(CDHOURS);

			CDMINS = math.floor(CDMINS * 60);

			if CDHOURS == 1 then
				sHOURS = _LANG.HOUR[SETTINGS.LANGUAGE];
			else
				sHOURS = _LANG.HOURS[SETTINGS.LANGUAGE];
			end

			if CDMINS == 1 then
				sMINS = _LANG.MINUTE[SETTINGS.LANGUAGE];
			else
				sMINS = _LANG.MINUTES[SETTINGS.LANGUAGE];
			end

			TIMESTRING = TIMESTRING .. CDHOURS .. " " .. sHOURS .. " " .. CDMINS .. " " .. sMINS;

		else -- CDHOURS > 24 hours.

			local sDAYS = "";
			local sHOURS = "";
			local CDDAYS = CDHOURS/24;

			CDDAYS,CDHOURS = math.modf(CDDAYS);

			CDHOURS = math.floor(CDHOURS * 24);

			if CDDAYS == 1 then
				sDAYS = _LANG.DAY[SETTINGS.LANGUAGE];
			else
				sDAYS = _LANG.DAYS[SETTINGS.LANGUAGE];
			end

			if CDHOURS == 1 then
				sHOURS = _LANG.HOUR[SETTINGS.LANGUAGE];
			else
				sHOURS = _LANG.HOURS[SETTINGS.LANGUAGE];
			end

			TIMESTRING = TIMESTRING .. CDDAYS .. " " .. sDAYS .. " " .. CDHOURS .. " " .. sHOURS;

		end

	--end -- DELETE


		local lblRECIPECOOLDOWN = Turbine.UI.Label();
		lblRECIPECOOLDOWN:SetParent(_wRecipeInfo[PROFESSION]);
		lblRECIPECOOLDOWN:SetPosition(5,60);
		lblRECIPECOOLDOWN:SetSize(_wRecipeInfo[PROFESSION]:GetWidth()-10,18);
		lblRECIPECOOLDOWN:SetForeColor(Turbine.UI.Color.Aquamarine);
		--lblRECIPECOOLDOWN:SetBackColor(HDBLUE);
		lblRECIPECOOLDOWN:SetFont(Verdana14);
		lblRECIPECOOLDOWN:SetTextAlignment(RIGHTALIGN);
		lblRECIPECOOLDOWN:SetText(TIMESTRING);

	end


	if _CURRECIPE.IsSingleUse == true then

		local lblRECIPESINGLEUSE = Turbine.UI.Label();
		lblRECIPESINGLEUSE:SetParent(_wRecipeInfo[PROFESSION]);
		lblRECIPESINGLEUSE:SetPosition(5,42);
		lblRECIPESINGLEUSE:SetSize(85,18);
		lblRECIPESINGLEUSE:SetForeColor(RED);
		--lblRECIPESINGLEUSE:SetBackColor(HDBLUE);
		lblRECIPESINGLEUSE:SetFont(Verdana14);
		lblRECIPESINGLEUSE:SetTextAlignment(LEFTALIGN);
		lblRECIPESINGLEUSE:SetText(_LANG.SINGLEUSE[SETTINGS.LANGUAGE]);

	end


	-----------------------------------------------------------------------------------------------------------
	-- INGREDIENTS LIST ---------------------------------------------------------------------------------------


	local ingredientTitlebar = Turbine.UI.Control();
	ingredientTitlebar:SetParent(_wRecipeView[PROFESSION]);
	ingredientTitlebar:SetSize(408,31);
	ingredientTitlebar:SetPosition(28,104);
	ingredientTitlebar:SetBackground(_IMAGES.INGREDIENTTITLEBAR);
	ingredientTitlebar:SetBlendMode(4);
	ingredientTitlebar:SetMouseVisible(false);


	local iconLBLINGREDIENTS = Turbine.UI.Control();
	iconLBLINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
	iconLBLINGREDIENTS:SetSize(40,41);
	iconLBLINGREDIENTS:SetPosition(5,100);
	iconLBLINGREDIENTS:SetMouseVisible(false);
	iconLBLINGREDIENTS:SetBlendMode(BLEND_OVERLAY);
	iconLBLINGREDIENTS:SetBackground(_IMAGES.INGREDIENTICON);
	iconLBLINGREDIENTS:SetVisible(true);


	local lblINGREDIENTS = Turbine.UI.Label();
	lblINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
	lblINGREDIENTS:SetPosition(105,100);
	lblINGREDIENTS:SetSize(150,41);
	lblINGREDIENTS:SetForeColor(Turbine.UI.Color.DarkKhaki);
	lblINGREDIENTS:SetFont(TrajanPro18);
	--lblINGREDIENTS:SetBackColor(HDBLUE);
	lblINGREDIENTS:SetTextAlignment(LEFTALIGN);
	lblINGREDIENTS:SetText(_LANG.INGREDIENTS[SETTINGS.LANGUAGE]);

	lblRecipeQty = Turbine.UI.Label();
	lblRecipeQty:SetParent(_wRecipeView[PROFESSION]);
	lblRecipeQty:SetPosition(315,100);
	lblRecipeQty:SetSize(60,41);
	lblRecipeQty:SetForeColor(Turbine.UI.Color.DarkKhaki);
	lblRecipeQty:SetFont(TrajanPro18);
	--lblRecipeQty:SetBackColor(HDBLUE);
	lblRecipeQty:SetTextAlignment(RIGHTALIGN);
	lblRecipeQty:SetText(_LANG.QTY[SETTINGS.LANGUAGE]);

	txtRecipeQty = Turbine.UI.Lotro.TextBox();
	txtRecipeQty:SetParent(_wRecipeView[PROFESSION]);
	txtRecipeQty:SetPosition(380,109);
	txtRecipeQty:SetSize(40,21);
	txtRecipeQty:SetFont(TrajanPro16);
	txtRecipeQty:SetBackColor(Turbine.UI.Color(0.3,0,0));
	txtRecipeQty:SetTextAlignment(MIDALIGN);
	txtRecipeQty:SetText(RECIPEQTY);

	txtRecipeQty.TextChanged = function (sender,args)

		local NEWQTY = txtRecipeQty:GetText();

		if string.len(NEWQTY) > 0 then

			local OUTPUTQTY = "";

			for a in string.gmatch(NEWQTY,"[0123456789]") do
				OUTPUTQTY = OUTPUTQTY .. a;
			end

			txtRecipeQty:SetText(OUTPUTQTY);

			-- Check if valid number
			if tonumber(OUTPUTQTY) ~= nil then
				UpdateRecipeIngredientsQuantities(tonumber(OUTPUTQTY));
			end
		end
	end


	-- Create the tree view control.
    local tvRECIPEINGREDIENTS = Turbine.UI.TreeView();
    tvRECIPEINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
    tvRECIPEINGREDIENTS:SetPosition(5,146);
    tvRECIPEINGREDIENTS:SetSize(_wRecipeView[PROFESSION]:GetWidth()-18,SETTINGS.CRITVIEW.BASETOP - 165); -- top (315) - 165
	--tvRECIPEINGREDIENTS:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
    tvRECIPEINGREDIENTS:SetIndentationWidth(20);


    -- Give the tree view a scroll bar.
    local sctvRECIPEINGREDIENTS = Turbine.UI.Lotro.ScrollBar();
    sctvRECIPEINGREDIENTS:SetOrientation(Turbine.UI.Orientation.Vertical);
    sctvRECIPEINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
    sctvRECIPEINGREDIENTS:SetPosition(tvRECIPEINGREDIENTS:GetLeft() + tvRECIPEINGREDIENTS:GetWidth()+1,tvRECIPEINGREDIENTS:GetTop());
    sctvRECIPEINGREDIENTS:SetSize(8,tvRECIPEINGREDIENTS:GetHeight());
	sctvRECIPEINGREDIENTS:SetVisible(false);

    tvRECIPEINGREDIENTS:SetVerticalScrollBar(sctvRECIPEINGREDIENTS);


	-- Expand all button
	local iconINGEXPAND = Turbine.UI.Control();
	iconINGEXPAND:SetParent(_wRecipeView[PROFESSION]);
	iconINGEXPAND:SetSize(16,16);
	iconINGEXPAND:SetPosition(55,lblINGREDIENTS:GetTop()+12);
	iconINGEXPAND:SetBlendMode(BLEND_OVERLAY);
	iconINGEXPAND:SetBackground(_IMAGES.ICONEXPANDALL);
	iconINGEXPAND:SetVisible(false);

	iconINGEXPAND.MouseClick = function(sender,args)
		tvRECIPEINGREDIENTS:ExpandAll();
		ExpandIcons(tvRECIPEINGREDIENTS);
	end

	iconINGEXPAND.MouseEnter = function(sender,args)
		iconINGEXPAND:SetBackground(_IMAGES.ICONEXPANDALLOVER);
	end

	iconINGEXPAND.MouseLeave = function(sender,args)
		iconINGEXPAND:SetBackground(_IMAGES.ICONEXPANDALL);
	end

	-- collapse all button
	local iconINGCOLLAPSE = Turbine.UI.Control();
	iconINGCOLLAPSE:SetParent(_wRecipeView[PROFESSION]);
	iconINGCOLLAPSE:SetSize(16,16);
	iconINGCOLLAPSE:SetPosition(iconINGEXPAND:GetLeft()+21,iconINGEXPAND:GetTop());
	iconINGCOLLAPSE:SetBlendMode(BLEND_OVERLAY);
	iconINGCOLLAPSE:SetBackground(_IMAGES.ICONCOLLAPSEALL);
	iconINGCOLLAPSE:SetVisible(false);

	iconINGCOLLAPSE.MouseClick = function(sender,args)
		tvRECIPEINGREDIENTS:CollapseAll();
		ExpandIcons(tvRECIPEINGREDIENTS,false);
	end

	iconINGCOLLAPSE.MouseEnter = function(sender,args)
		iconINGCOLLAPSE:SetBackground(_IMAGES.ICONCOLLAPSEALLOVER);
	end

	iconINGCOLLAPSE.MouseLeave = function(sender,args)
		iconINGCOLLAPSE:SetBackground(_IMAGES.ICONCOLLAPSEALL);
	end


	local RootNode = tvRECIPEINGREDIENTS:GetNodes();
	RootNode:Clear();


	-- Loop through each ingredient and add to tree view - then test each item to see if it is a craftable ingredient
	-- if so add those ingredients as a child node
	for k,v in pairs (_CURRECIPE.Ingredients) do

		local CURINGREDNAME = v.Name;
		local CURINGREQQTY = v.RequiredQuantity * RECIPEQTY;
		local CURINGITEM = v.ItemInfo;
		local CURSINGLEQTY = v.RequiredQuantity;

		local CURPRIMARYINGREDIENTNODE = Turbine.UI.TreeNode();
		CURPRIMARYINGREDIENTNODE:SetSize(tvRECIPEINGREDIENTS:GetWidth()-2,39);

		local PRIMARYINGHOLDER = Turbine.UI.Control();
		PRIMARYINGHOLDER:SetParent(CURPRIMARYINGREDIENTNODE);
		PRIMARYINGHOLDER:SetSize(CURPRIMARYINGREDIENTNODE:GetWidth(),39);
		--PRIMARYINGHOLDER:SetBackColor(HDBLUELT);
		PRIMARYINGHOLDER:SetMouseVisible(false);

		local INGREDIENTICON = Turbine.UI.Lotro.ItemInfoControl();
		INGREDIENTICON:SetParent(PRIMARYINGHOLDER);
		INGREDIENTICON:SetPosition(18,2);
		INGREDIENTICON:SetSize(35,35);
		INGREDIENTICON:SetQuantity(CURINGREQQTY);
		INGREDIENTICON:SetItemInfo(CURINGITEM);
		INGREDIENTICON:SetEnabled(false);


		local lblPRIMARYING = Turbine.UI.Label();
		lblPRIMARYING:SetParent(PRIMARYINGHOLDER);
		lblPRIMARYING:SetSize(PRIMARYINGHOLDER:GetWidth()-70,PRIMARYINGHOLDER:GetHeight());
		lblPRIMARYING:SetPosition(63,0);
		lblPRIMARYING:SetFont(Verdana14);
		lblPRIMARYING:SetTextAlignment(LEFTALIGN);
		lblPRIMARYING:SetForeColor(WHITE);
		lblPRIMARYING:SetMultiline(true);
		lblPRIMARYING:SetMouseVisible(false);
		lblPRIMARYING:SetText(CommaNumbers(CURINGREQQTY) .. "x " .. CURINGREDNAME.. " (" .. GetItemInventoryCount(CURINGREDNAME) .. ")");

		TooltipInventory(CURPRIMARYINGREDIENTNODE,CURINGITEM);

		CURPRIMARYINGREDIENTNODE.MouseClick = function(sender,args)

			if args.Button == Turbine.UI.MouseButton.Right then
				CreatePopup(CURINGREDNAME,CURINGREQQTY);
			end

		end

		if GetItemInventoryCount(CURINGREDNAME) >= CURINGREQQTY then
			INGREDIENTICON:SetEnabled(true)
			lblPRIMARYING:SetForeColor(INGSUBCOLOR);
		end


		local _CURINGREDIENTINFO =
		{
		["NAME"] = CURINGREDNAME;
		["REQQTY"] = CURINGREQQTY;
		["SINGLEQTY"] = CURSINGLEQTY;
		["ICON"] = INGREDIENTICON;
		["LABEL"] = lblPRIMARYING;
		["PROFESSION"] = "";
		};

		RootNode:Add(CURPRIMARYINGREDIENTNODE);

		-- Get base ingredients then add as child nodes
		local _INGREDIENTS = GetBaseIngredients(CURINGREDNAME,CURINGREQQTY,CURSINGLEQTY);
		AddChildIngredientNodes(CURPRIMARYINGREDIENTNODE,_INGREDIENTS);

		--Turbine.Shell.WriteLine(dump(_INGREDIENTS));

		if _INGREDIENTS == nil then
			--PRIMARYINGHOLDER:SetBackColor(HDBLUE)
			CreateBaseItemsList(CURINGITEM,CURINGREQQTY,CURSINGLEQTY);
		else
			local RECIPEPROFESSION = _INGREDIENTS[1].PROFESSION;
			lblPRIMARYING:SetText(CommaNumbers(CURINGREQQTY) .. "x " .. CURINGREDNAME.. " (" .. GetItemInventoryCount(CURINGREDNAME) .. ")" .. " - " .. RECIPEPROFESSION);
			--lblPRIMARYING:SetForeColor(INGSUBCOLOR);

			_CURINGREDIENTINFO["PROFESSION"] = RECIPEPROFESSION;

			-- Expand icon
			local ICONEXPAND = Turbine.UI.Control();
			ICONEXPAND:SetParent(PRIMARYINGHOLDER);
			ICONEXPAND:SetSize(16,16);
			ICONEXPAND:SetPosition(0,11);
			ICONEXPAND:SetMouseVisible(false);
			ICONEXPAND:SetBlendMode(BLEND_OVERLAY);
			ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);
			ICONEXPAND:SetVisible(true);

			CURPRIMARYINGREDIENTNODE.MouseClick = function(sender,args)

				if args.Button == Turbine.UI.MouseButton.Right then
					CreatePopup(CURINGREDNAME,CURINGREQQTY);
				else

					if CURPRIMARYINGREDIENTNODE:IsExpanded() == true then
						ICONEXPAND:SetBackground(_IMAGES.ICONCOLLAPSE);
					else
						ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);
					end

				end

			end

			iconINGCOLLAPSE:SetVisible(true);
			iconINGEXPAND:SetVisible(true);

		end

		table.insert(_INGREDIENTLIST,_CURINGREDIENTINFO);

	end


	-- BASE INGREDIENTS LIST ---------------------------------------------------

	-- Default top = 315
	local baseIngredientTitlebar = Turbine.UI.Control();
	baseIngredientTitlebar:SetParent(_wRecipeView[PROFESSION]);
	baseIngredientTitlebar:SetSize(408,31);
	baseIngredientTitlebar:SetPosition(28,SETTINGS.CRITVIEW.BASETOP+4);
	baseIngredientTitlebar:SetBackground(_IMAGES.INGREDIENTTITLEBAR);
	baseIngredientTitlebar:SetBlendMode(4);
	baseIngredientTitlebar:SetMouseVisible(false);


	local iconLBLBASEINGREDIENTS = Turbine.UI.Control();
	iconLBLBASEINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
	iconLBLBASEINGREDIENTS:SetSize(40,41);
	iconLBLBASEINGREDIENTS:SetPosition(5,SETTINGS.CRITVIEW.BASETOP);	-- Default 315
	iconLBLBASEINGREDIENTS:SetMouseVisible(false);
	iconLBLBASEINGREDIENTS:SetBlendMode(BLEND_OVERLAY);
	iconLBLBASEINGREDIENTS:SetBackground(_IMAGES.INGREDIENTICON);
	iconLBLBASEINGREDIENTS:SetVisible(true);

	local lblBASEINGREDIENTS = Turbine.UI.Label();
	lblBASEINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
	lblBASEINGREDIENTS:SetPosition(55,SETTINGS.CRITVIEW.BASETOP);
	lblBASEINGREDIENTS:SetSize(220,41);
	lblBASEINGREDIENTS:SetForeColor(lblINGREDIENTS:GetForeColor());
	lblBASEINGREDIENTS:SetFont(lblINGREDIENTS:GetFont());
	--lblBASEINGREDIENTS:SetBackColor(HDBLUE);
	lblBASEINGREDIENTS:SetTextAlignment(LEFTALIGN);
	lblBASEINGREDIENTS:SetText(_LANG.BASEINGREDIENTS[SETTINGS.LANGUAGE]);

	local btnResizeIngredients = Turbine.UI.Control();
	btnResizeIngredients:SetParent(_wRecipeView[PROFESSION]);
	btnResizeIngredients:SetPosition(400,SETTINGS.CRITVIEW.BASETOP+7);
	btnResizeIngredients:SetSize(16,25);
	btnResizeIngredients:SetBackground(_IMAGES.UPDOWNBUTTONNORMAL);
	btnResizeIngredients:SetBlendMode(4);

	-- Create the tree view control.
    local tvBASEINGREDIENTS = Turbine.UI.TreeView();
    tvBASEINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
    tvBASEINGREDIENTS:SetPosition(5,SETTINGS.CRITVIEW.BASETOP + 45);									-- top + 45
    tvBASEINGREDIENTS:SetSize(_wRecipeView[PROFESSION]:GetWidth()-18,460 - (SETTINGS.CRITVIEW.BASETOP+45));	-- 460 - top
    --tvBASEINGREDIENTS:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
    tvBASEINGREDIENTS:SetIndentationWidth(7);


    -- Give the tree view a scroll bar.
    local sctvBASEINGREDIENTS = Turbine.UI.Lotro.ScrollBar();
    sctvBASEINGREDIENTS:SetOrientation(Turbine.UI.Orientation.Vertical);
    sctvBASEINGREDIENTS:SetParent(_wRecipeView[PROFESSION]);
    sctvBASEINGREDIENTS:SetPosition(tvBASEINGREDIENTS:GetLeft() + tvBASEINGREDIENTS:GetWidth(),tvBASEINGREDIENTS:GetTop());
    sctvBASEINGREDIENTS:SetSize(8,tvBASEINGREDIENTS:GetHeight());
	sctvBASEINGREDIENTS:SetVisible(false);

    tvBASEINGREDIENTS:SetVerticalScrollBar(sctvBASEINGREDIENTS);


	btnResizeIngredients.MouseEnter = function (sender,args)
		btnResizeIngredients:SetBackground(_IMAGES.UPDOWNBUTTONOVER);
	end

	btnResizeIngredients.MouseLeave = function (sender,args)
		btnResizeIngredients:SetBackground(_IMAGES.UPDOWNBUTTONNORMAL);
	end

	btnResizeIngredients.MouseDown = function (Sender,args)
		blDRAGGING = true;
		relY = args.Y;
	end

	btnResizeIngredients.MouseUp = function (sender,args)
		blDRAGGING = false;
	end

	btnResizeIngredients.MouseMove = function (sender,args)
		if blDRAGGING == true then

			function RepositionIngredients(VIEW)

				local MAINLISTHEIGHT = 0;

				if VIEW == "CRIT" then
					NEWTOP = SETTINGS.CRITVIEW.BASETOP;
					MAINLISTHEIGHT= NEWTOP - 165;
				else
					NEWTOP = SETTINGS.NONCRITVIEW.BASETOP;
					MAINLISTHEIGHT= NEWTOP - 55;
				end

				-- INGREDIENTS TREE
				tvRECIPEINGREDIENTS:SetHeight(MAINLISTHEIGHT);	-- top - 55

				sctvRECIPEINGREDIENTS:SetTop(tvRECIPEINGREDIENTS:GetTop());
				sctvRECIPEINGREDIENTS:SetHeight(tvRECIPEINGREDIENTS:GetHeight());

				-- BASE INGREDIENTS TREE
				baseIngredientTitlebar:SetTop(NEWTOP+4);

				lblBASEINGREDIENTS:SetTop(NEWTOP);			-- Default 255
				iconLBLBASEINGREDIENTS:SetTop(NEWTOP);

				tvBASEINGREDIENTS:SetTop(NEWTOP + 45); 		-- top + 45
				tvBASEINGREDIENTS:SetHeight(460 - (NEWTOP+45));  	-- 460 - (top + 45)

				sctvBASEINGREDIENTS:SetTop(tvBASEINGREDIENTS:GetTop());
				sctvBASEINGREDIENTS:SetHeight(tvBASEINGREDIENTS:GetHeight());

				btnResizeIngredients:SetTop(NEWTOP+7);

			end

			local scX,scY = _wRecipeView[PROFESSION]:GetMousePosition();
			local NEWTOP = scY - relY;

			local iMAXPOSITION = 410; -- CRIT VIEW
			if NEWTOP > iMAXPOSITION then NEWTOP = iMAXPOSITION end;

			if _CURRECIPE.HasCriticalResultItem == true then

				local iMINPOSITION = 148; -- CRIT VIEW
				if NEWTOP < iMINPOSITION then NEWTOP = iMINPOSITION end;

				SETTINGS.CRITVIEW.BASETOP = NEWTOP;
				RepositionIngredients("CRIT");

			else

				local iMINPOSITION = 47; -- NON CRIT VIEW
				if NEWTOP < iMINPOSITION then NEWTOP = iMINPOSITION end;

				SETTINGS.NONCRITVIEW.BASETOP = NEWTOP;
				RepositionIngredients("NONCRIT");
			end

		end
	end



	local RootNode = tvBASEINGREDIENTS:GetNodes();
	RootNode:Clear();




	-- Loop through each ingredient and add to tree view - then test each item to see if it is a craftable ingredient
	-- if so add those ingredients as a child node
	for k,v in pairs (_BASEITEMSLIST) do

		local CURINGREDNAME = k;
		local CURINGREQQTY = v.QUANTITY;
		local CURINGITEM = v.ITEM;
		local CURINGSINGLE = v.SINGLEQTY;

		local CURPRIMARYINGREDIENTNODE = Turbine.UI.TreeNode();
		CURPRIMARYINGREDIENTNODE:SetSize(tvBASEINGREDIENTS:GetWidth()-2,39);

		TooltipInventory(CURPRIMARYINGREDIENTNODE,CURINGITEM);

		local PRIMARYINGHOLDER = Turbine.UI.Control();
		PRIMARYINGHOLDER:SetParent(CURPRIMARYINGREDIENTNODE);
		PRIMARYINGHOLDER:SetSize(CURPRIMARYINGREDIENTNODE:GetWidth(),39);
		--PRIMARYINGHOLDER:SetBackColor(HDBLUE);
		PRIMARYINGHOLDER:SetMouseVisible(false);

		local INGREDIENTICON = Turbine.UI.Lotro.ItemInfoControl();
		INGREDIENTICON:SetParent(PRIMARYINGHOLDER);
		INGREDIENTICON:SetPosition(18,2);
		INGREDIENTICON:SetSize(35,35);
		INGREDIENTICON:SetQuantity(CURINGREQQTY);
		INGREDIENTICON:SetItemInfo(CURINGITEM);
		INGREDIENTICON:SetEnabled(false);


		local lblPRIMARYING = Turbine.UI.Label();
		lblPRIMARYING:SetParent(PRIMARYINGHOLDER);
		lblPRIMARYING:SetSize(PRIMARYINGHOLDER:GetWidth()-70,PRIMARYINGHOLDER:GetHeight());
		lblPRIMARYING:SetPosition(63,0);
		lblPRIMARYING:SetFont(Verdana14);
		lblPRIMARYING:SetTextAlignment(LEFTALIGN);
		--lblPRIMARYING:SetForeColor(GetItemFontColor(CURINGITEM));
		lblPRIMARYING:SetForeColor(WHITE);
		lblPRIMARYING:SetMouseVisible(false);
		lblPRIMARYING:SetMultiline(true);
		lblPRIMARYING:SetText(CommaNumbers(CURINGREQQTY) .. "x " .. CURINGREDNAME.. " (" .. GetItemInventoryCount(CURINGREDNAME) .. ")");


		if GetItemInventoryCount(CURINGREDNAME) >= CURINGREQQTY then
			INGREDIENTICON:SetEnabled(true)
			lblPRIMARYING:SetForeColor(INGSUBCOLOR);
		end


		CURPRIMARYINGREDIENTNODE.MouseClick = function(sender,args)
			if args.Button == Turbine.UI.MouseButton.Right then
				CreatePopup(CURINGREDNAME,CURINGREQQTY);
			end
		end


		RootNode:Add(CURPRIMARYINGREDIENTNODE);

		local _CURINGREDIENTINFO =
		{
		["NAME"] = CURINGREDNAME;
		["REQQTY"] = CURINGREQQTY;
		["SINGLEQTY"] = CURINGSINGLE;
		["ICON"] = INGREDIENTICON;
		["LABEL"] = lblPRIMARYING;
		["PROFESSION"] = "";
		};

		table.insert(_INGREDIENTLIST,_CURINGREDIENTINFO);

	end


	-- CRITICAL SECTION (IF ITEM HAS)-------------------------------------------------------

	if _CURRECIPE.HasCriticalResultItem == true then

		wRecipeBackNoCrit:SetVisible(false);
		wRecipeBackCrit:SetVisible(true);

		local CRITTOP = 0;

		-- LABEL ---
		local lblCRITICAL = Turbine.UI.Label();
		lblCRITICAL:SetParent(_wRecipeView[PROFESSION]);
		lblCRITICAL:SetSize(210,20);
		lblCRITICAL:SetPosition(5,CRITTOP);
		lblCRITICAL:SetMultiline(false);
		lblCRITICAL:SetFont(TrajanPro16);
		lblCRITICAL:SetForeColor(lblINGREDIENTS:GetForeColor());
		lblCRITICAL:SetTextAlignment(LEFTALIGN);
		--lblCRITICAL:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
		lblCRITICAL:SetText(_LANG.CRITICALSUCCESS[SETTINGS.LANGUAGE]);


		-- CRITICAL RESULT ITEM --
		local iconCRITITEM = Turbine.UI.Lotro.ItemInfoControl();
		iconCRITITEM:SetParent(_wRecipeView[PROFESSION]);
		iconCRITITEM:SetPosition(5,CRITTOP+25);
		iconCRITITEM:SetSize(35,35);
		iconCRITITEM:SetQuantity(_CURRECIPE.CriticalSuccessItemQuantity);
		iconCRITITEM:SetItemInfo(_CURRECIPE.CriticalResultItemInfo);

		local lblCRITITEMNAME = Turbine.UI.Label();
		lblCRITITEMNAME:SetParent(_wRecipeView[PROFESSION]);
		lblCRITITEMNAME:SetPosition(50,iconCRITITEM:GetTop());
		lblCRITITEMNAME:SetSize(lblRECIPENAME:GetWidth()-30,lblRECIPENAME:GetHeight());
		lblCRITITEMNAME:SetFont(lblRECIPENAME:GetFont());
		lblCRITITEMNAME:SetTextAlignment(LEFTALIGN);
		lblCRITITEMNAME:SetForeColor(GetItemFontColor(_CURRECIPE.CriticalResultItemInfo));
		lblCRITITEMNAME:SetMultiline(true);
		--lblCRITITEMNAME:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
		lblCRITITEMNAME:SetText(_CURRECIPE.CriticalResultItemName);


		-- Check to see if it has an optional item (e.g. old prospector recipes which may crit without).
		if _CURRECIPE.OptionalIngredient[1] ~= nil then

			-- CRITICAL INGREDIENTS --
			local lblOPTING = Turbine.UI.Label();
			lblOPTING:SetParent(_wRecipeView[PROFESSION]);
			lblOPTING:SetSize(205,20);
			lblOPTING:SetPosition(220,CRITTOP);
			lblOPTING:SetMultiline(false);
			lblOPTING:SetFont(TrajanPro16);
			lblOPTING:SetForeColor(lblINGREDIENTS:GetForeColor());
			lblOPTING:SetTextAlignment(RIGHTALIGN);
			--lblOPTING:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
			lblOPTING:SetText(_LANG.OPTIONALINGREDIENT[SETTINGS.LANGUAGE]);

			local iconCRITING = Turbine.UI.Lotro.ItemInfoControl();
			iconCRITING:SetParent(_wRecipeView[PROFESSION]);
			iconCRITING:SetPosition(lblCRITITEMNAME:GetLeft() + lblCRITITEMNAME:GetWidth() + 10,CRITTOP+25);
			iconCRITING:SetSize(35,35);
			iconCRITING:SetQuantity(_CURRECIPE.OptionalIngredient[1].RequiredQuantity);
			iconCRITING:SetItemInfo(_CURRECIPE.OptionalIngredient[1].ItemInfo);
			iconCRITING:SetEnabled(false);

			local lblCRITINGNAME = Turbine.UI.Label();
			lblCRITINGNAME:SetParent(_wRecipeView[PROFESSION]);
			lblCRITINGNAME:SetPosition(iconCRITING:GetLeft() + 45,iconCRITING:GetTop());
			lblCRITINGNAME:SetSize(105,35);
			lblCRITINGNAME:SetFont(Verdana12);
			lblCRITINGNAME:SetTextAlignment(LEFTALIGN);
			lblCRITINGNAME:SetForeColor(WHITE);
			lblCRITINGNAME:SetMultiline(true);
			--lblCRITINGNAME:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
			lblCRITINGNAME:SetText(_CURRECIPE.OptionalIngredient[1].RequiredQuantity .. "x " .. _CURRECIPE.OptionalIngredient[1].Name .. " (" .. GetItemInventoryCount(_CURRECIPE.OptionalIngredient[1].Name) .. ")");

			TooltipInventory(lblCRITINGNAME,_CURRECIPE.OptionalIngredient[1].ItemInfo);


			lblCRITINGNAME.MouseClick = function(sender,args)
				if args.Button == Turbine.UI.MouseButton.Right then
					CreatePopup(_CURRECIPE.OptionalIngredient[1].Name,_CURRECIPE.OptionalIngredient[1].RequiredQuantity);
				end
			end


			local lblCRITITEMCHANCE = Turbine.UI.Label();
			lblCRITITEMCHANCE:SetParent(_wRecipeView[PROFESSION]);
			lblCRITITEMCHANCE:SetPosition(iconCRITING:GetLeft() + 45,iconCRITING:GetTop()+38);
			lblCRITITEMCHANCE:SetSize(105,18);
			lblCRITITEMCHANCE:SetFont(Verdana12);
			lblCRITITEMCHANCE:SetTextAlignment(LEFTALIGN);
			lblCRITITEMCHANCE:SetForeColor(WHITE);
			lblCRITITEMCHANCE:SetMultiline(true);
			--lblCRITITEMCHANCE:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
			lblCRITITEMCHANCE:SetText("+" .. 100*RoundNumber(_CURRECIPE.OptionalIngredient[1].CriticaChanceBonus,2) .. "%");


			if GetItemInventoryCount(_CURRECIPE.OptionalIngredient[1].Name) >= _CURRECIPE.OptionalIngredient[1].RequiredQuantity then
				iconCRITING:SetEnabled(true)
				lblCRITINGNAME:SetForeColor(INGSUBCOLOR);
			end

			local _CURINGREDIENTINFO =
			{
			["NAME"] = _CURRECIPE.OptionalIngredient[1].Name;
			["REQQTY"] = _CURRECIPE.OptionalIngredient[1].RequiredQuantity;
			["ICON"] = iconCRITING;
			--["SINGLEQTY"] = _CURRECIPE.OptionalIngredient[1].RequiredQuantity;
			["LABEL"] = lblCRITINGNAME;
			["PROFESSION"] = "";
			};

			table.insert(_INGREDIENTLIST,_CURINGREDIENTINFO);

		end

	else

		-- No critical item, so make ingredients windows fill the screen.
		-- INGREDIENTS TREE
		lblINGREDIENTS:SetTop(0);
		txtRecipeQty:SetTop(9);
		lblRecipeQty:SetTop(0);
		iconLBLINGREDIENTS:SetTop(0);

		ingredientTitlebar:SetTop(4);

		tvRECIPEINGREDIENTS:SetTop(45);
		tvRECIPEINGREDIENTS:SetHeight(SETTINGS.NONCRITVIEW.BASETOP - 55);	-- top - 55

		sctvRECIPEINGREDIENTS:SetPosition(tvRECIPEINGREDIENTS:GetLeft() + tvRECIPEINGREDIENTS:GetWidth()+1,tvRECIPEINGREDIENTS:GetTop());
		sctvRECIPEINGREDIENTS:SetSize(8,tvRECIPEINGREDIENTS:GetHeight());


		-- BASE INGREDIENTS TREE
		baseIngredientTitlebar:SetTop(SETTINGS.NONCRITVIEW.BASETOP+4);

		lblBASEINGREDIENTS:SetTop(SETTINGS.NONCRITVIEW.BASETOP);			-- Default 255
		iconLBLBASEINGREDIENTS:SetTop(SETTINGS.NONCRITVIEW.BASETOP);

		tvBASEINGREDIENTS:SetTop(SETTINGS.NONCRITVIEW.BASETOP + 45); 		-- top + 45
		tvBASEINGREDIENTS:SetHeight(460 - (SETTINGS.NONCRITVIEW.BASETOP+45));  	-- 460 - (top + 45)

		sctvBASEINGREDIENTS:SetPosition(tvBASEINGREDIENTS:GetLeft() + tvBASEINGREDIENTS:GetWidth(),tvBASEINGREDIENTS:GetTop());
		sctvBASEINGREDIENTS:SetSize(8,tvBASEINGREDIENTS:GetHeight());


		btnResizeIngredients:SetTop(SETTINGS.NONCRITVIEW.BASETOP+7);


		-- Expand / collapse icons
		iconINGCOLLAPSE:SetTop(12);
		iconINGEXPAND:SetTop(12);

		-- Show normal background
		wRecipeBackNoCrit:SetVisible(true);
		wRecipeBackCrit:SetVisible(false);

	end

	_wRecipeView[PROFESSION]:SetVisible(true);

	if CURRECIPETIER > MASTERYLEVEL then
		local CURRECIPEQTY = math.ceil(XPREMAINING/_CURRECIPE.ExperienceReward) .. " " .. _LANG.AT[SETTINGS.LANGUAGE] .. " " .. _CURRECIPE.ExperienceReward .."xp";
		local MAXRECIPEQTY = math.ceil(XPREMAINING/RECIPEMAXXP) .. " " .. _LANG.AT[SETTINGS.LANGUAGE] .. " " .. RECIPEMAXXP .."xp";

		if RECIPEMAXXP == _CURRECIPE.ExperienceReward then
			lblRECIPEEXPERIENCE:SetText(CURRECIPEQTY);
		else
			lblRECIPEEXPERIENCE:SetText(CURRECIPEQTY .. " / " .. MAXRECIPEQTY);
		end
	else
		lblRECIPEEXPERIENCE:SetText(_LANG.MASTERED[SETTINGS.LANGUAGE]);
	end

end


function AddChildIngredientNodes(PARENTNODE,INGREDIENT)

	if type(INGREDIENT) == 'table' then

		-- Child nodes for each category for that tier.
		local CHILDNODES = PARENTNODE:GetChildNodes();

		local RECIPEPROFESSION = "";
		local RECIPEALTS = tablelength(INGREDIENT);
		local ALTRECIPE = "";


		for k,v in pairs (INGREDIENT) do

			if k == 1 then
				ALTRECIPE = "";
			else
				ALTRECIPE = _LANG.OR[SETTINGS.LANGUAGE] .. ": ";
			end


			for a,b in pairs (v.INGREDIENTS) do

				local CURINGNODE = Turbine.UI.TreeNode();
				CURINGNODE:SetSize(PARENTNODE:GetSize());

				local CatHolder = Turbine.UI.Control();
				CatHolder:SetParent(CURINGNODE);
				CatHolder:SetSize(CURINGNODE:GetWidth(),39);
				--CatHolder:SetBackColor(HDBLUE);
				CatHolder:SetMouseVisible(false);


				local iconINGREDIENT = Turbine.UI.Lotro.ItemInfoControl();
				iconINGREDIENT:SetParent(CatHolder);
				iconINGREDIENT:SetPosition(18,2);
				iconINGREDIENT:SetSize(35,35);
				iconINGREDIENT:SetQuantity(b.QTY);
				iconINGREDIENT:SetItemInfo(b.ITEM);
				iconINGREDIENT:SetEnabled(false);


				local lblCat = Turbine.UI.Label();
				lblCat:SetParent(CatHolder);
				lblCat:SetSize(280,CatHolder:GetHeight());
				lblCat:SetPosition(63,0);
				lblCat:SetTextAlignment(LEFTALIGN);
				lblCat:SetMouseVisible(false);
				lblCat:SetFont(Verdana14);
				lblCat:SetMultiline(true);

				TooltipInventory(CURINGNODE,b.ITEM);

				CURINGNODE.MouseClick = function(sender,args)
					if args.Button == Turbine.UI.MouseButton.Right then
						CreatePopup(a,b.QTY);
					end
				end


				if GetItemInventoryCount(a) >= b.QTY then
					iconINGREDIENT:SetEnabled(true)
					lblCat:SetForeColor(INGSUBCOLOR);
				end

				local _CURINGREDIENTINFO =
					{
					["NAME"] = a;
					["REQQTY"] = b.QTY;
					["SINGLEQTY"] = b.SINGLEQTY;
					["ICON"] = iconINGREDIENT;
					["LABEL"] = lblCat;
					["PROFESSION"] = "";
					};


				if RECIPEALTS == 1 then
					lblCat:SetText(ALTRECIPE .. CommaNumbers(b.QTY) .. "x " .. a .. " (" .. GetItemInventoryCount(a) .. ")");
				else
					RECIPEPROFESSION = v.PROFESSION;
					lblCat:SetText(ALTRECIPE .. CommaNumbers(b.QTY) .. "x " .. a .. " (" .. GetItemInventoryCount(a) .. ") - " .. RECIPEPROFESSION);
				end

				if b.INGREDIENTS ~= nil then

					--CatHolder:SetBackColor(HDBLUELT);
					--lblCat:SetForeColor(INGSUBCOLOR);

					-- Expand icon
					local ICONEXPAND = Turbine.UI.Control();
					ICONEXPAND:SetParent(CatHolder);
					ICONEXPAND:SetSize(16,16);
					ICONEXPAND:SetPosition(0,11);
					ICONEXPAND:SetMouseVisible(false);
					ICONEXPAND:SetBlendMode(BLEND_OVERLAY);
					ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);
					ICONEXPAND:SetVisible(true);

					CURINGNODE.MouseClick = function(sender,args)
						if args.Button == Turbine.UI.MouseButton.Right then
							CreatePopup(a,b.QTY);
						else
							if CURINGNODE:IsExpanded() == true then
								ICONEXPAND:SetBackground(_IMAGES.ICONCOLLAPSE);
							else
								ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND);
							end
						end
					end


					-- Get's the profession for the recipe.
					for c,d in pairs(b.INGREDIENTS[1]) do
						if c == "PROFESSION" then
							RECIPEPROFESSION = d;
						end
					end

					lblCat:SetText(CommaNumbers(b.QTY) .. "x " .. a .. " (" .. GetItemInventoryCount(a) .. ") - " .. RECIPEPROFESSION);

					_CURINGREDIENTINFO["PROFESSION"] = RECIPEPROFESSION;

				end

				CHILDNODES:Add(CURINGNODE);

				AddChildIngredientNodes(CURINGNODE,b.INGREDIENTS);

				table.insert(_INGREDIENTLIST,_CURINGREDIENTINFO);

			end

		end

	end

end


-- This function formulates a table for the entered ingredient.
function GetBaseIngredients(INGREDIENT,QUANTITY,SINGLEQTY)

	if QUANTITY == nil then QUANTITY = 1 end;
	if SINGLEQTY == nil then SINGLEQTY = 1 end;

	local _TEMPINGTABLE = {};
	local blMATCHFOUND = false;

	local RECIPECOUNT = 1;

	for k,v in pairs (_RECIPES) do	-- Loops through professions (Cook / Prospector / Jeweller)

		local _TEMPRECIPES = v;

		for a,b in pairs(_TEMPRECIPES) do	-- loops through recipes for each profession

			if b.Name == INGREDIENT and b.CategoryName ~= _LANG.PROCESSING[SETTINGS.LANGUAGE] then -- Match, recipe found matching ingredient
			-- Need this to ignore processing recipes otherwise stack overflow from endless loop

				blMATCHFOUND = true;


				--_TEMPINGTABLE[INGREDIENT] =
				_TEMPINGTABLE[RECIPECOUNT] =
					{
					["PROFESSION"] = k;
					["TIER"] = b.Tier;
					["RECIPEID"] = a;
					["ITEM"] = b.ResultItemInfo;
					["INGREDIENTS"] = {};
					};

				if k == GLOBALPROFESSION and b.Tier == CURRECIPETIER then
					RECIPEMAXXP = RECIPEMAXXP + b.ExperienceReward;
				end

				-- Create child node of ingredients.
				local _TEMPINGREDIENTS = b.Ingredients;

				local _TEMPINGTABLEINGREDIENTS = _TEMPINGTABLE[RECIPECOUNT].INGREDIENTS;


				for c,d in pairs (_TEMPINGREDIENTS) do

					local TEMPNAME = d.Name;
					local TEMPQTY = QUANTITY * d.RequiredQuantity;
					local TEMPSINGLQTY = SINGLEQTY * d.RequiredQuantity;
					local TEMPITEM = d.ItemInfo;

					--Debug(TEMPNAME .. ": TEMPQTY = " .. TEMPQTY .. "; SINGLEQTY = " .. SINGLEQTY .. " (" .. TEMPSINGLQTY .. ")");

					_TEMPINGTABLEINGREDIENTS[TEMPNAME] =
						{
						["QTY"] = TEMPQTY;
						["SINGLEQTY"] = TEMPSINGLQTY;
						["ITEM"] = TEMPITEM;
						["INGREDIENTS"] = GetBaseIngredients(TEMPNAME,TEMPQTY,TEMPSINGLQTY); -- Check if this ingredient has base ingredients
						};

					if _TEMPINGTABLEINGREDIENTS[TEMPNAME].INGREDIENTS == nil then
						CreateBaseItemsList(TEMPITEM,TEMPQTY,TEMPSINGLQTY);
					end

				end

				RECIPECOUNT = RECIPECOUNT + 1;

			end
		end
	end

	if blMATCHFOUND == true then
		return _TEMPINGTABLE;
	else
		return nil;
	end
end


function CreateBaseItemsList(NEWINGREDIENTITEM,QUANTITY,SINGLEQTY)

	-- This function manages the base ingredients list.
	-- Results stored in _BASEITEMSLIST
	if NEWINGREDIENTITEM == nil then return end;

	if QUANTITY == nil then QUANTITY = 1 end;

	local INGREDIENTITEMNAME = NEWINGREDIENTITEM:GetName();


	if _BASEITEMSLIST[INGREDIENTITEMNAME] == nil then

		_BASEITEMSLIST[INGREDIENTITEMNAME] =
			{
			["ITEM"] = NEWINGREDIENTITEM;
			["QUANTITY"] = QUANTITY;
			["SINGLEQTY"] = SINGLEQTY;
			};

	else

		local TEMPQUANTITY = _BASEITEMSLIST[INGREDIENTITEMNAME].QUANTITY;
		_BASEITEMSLIST[INGREDIENTITEMNAME].QUANTITY = TEMPQUANTITY + QUANTITY;
		local TEMPSINGLEQTY = _BASEITEMSLIST[INGREDIENTITEMNAME].SINGLEQTY;
		_BASEITEMSLIST[INGREDIENTITEMNAME].SINGLEQTY = TEMPSINGLEQTY + SINGLEQTY;

	end

end


function ShowBaseItemList(RECIPENAME)

	-- This function gets the items in _BASEITEMSLIST and displays them to the user.

	if RECIPENAME == nil then RECIPENAME = "" end;

	Turbine.Shell.WriteLine("<u>" .. RECIPENAME .. "</u>");

	for k,v in pairs (_BASEITEMSLIST) do

		Turbine.Shell.WriteLine(k .. " = " .. v.QUANTITY);

	end

end


function GetItemFontColor(ITEM)

	-- This function takes an item, then returns a Turbine color based on the quality of that item.

	if ITEM == nil then return Turbine.UI.Color.White end;

	local TEMPCOLOR = Turbine.UI.Color.White;

	local ITEMQUALITY = "";

	if type(ITEM) == 'number' then
		ITEMQUALITY = ITEM;
	else
		ITEMQUALITY = ITEM:GetQuality();
	end

	if ITEMQUALITY == Turbine.Gameplay.ItemQuality.Common then
		TEMPCOLOR = Turbine.UI.Color.White;
	elseif ITEMQUALITY == Turbine.Gameplay.ItemQuality.Incomparable then
		TEMPCOLOR = Turbine.UI.Color.Aqua;
	elseif ITEMQUALITY == Turbine.Gameplay.ItemQuality.Legendary then
		TEMPCOLOR = Turbine.UI.Color.Orange;
	elseif ITEMQUALITY == Turbine.Gameplay.ItemQuality.Rare then
		TEMPCOLOR = Turbine.UI.Color.Fuchsia;
	elseif ITEMQUALITY == Turbine.Gameplay.ItemQuality.Uncommon then
		TEMPCOLOR = Turbine.UI.Color.Yellow;
	end


	return TEMPCOLOR;

end

