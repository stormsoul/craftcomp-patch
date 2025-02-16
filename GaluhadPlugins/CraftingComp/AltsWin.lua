
function DrawAltsWin()

	local tempWidth,tempHeight = 420,460;

	wAltsMainWin = Turbine.UI.Lotro.Window();
	wAltsMainWin:SetSize(tempWidth,tempHeight);
	wAltsMainWin:SetPosition(SETTINGS.ALTSWINDOW.X,SETTINGS.ALTSWINDOW.Y);
	wAltsMainWin:SetText(_LANG.ALTSWINTITLE[SETTINGS.LANGUAGE]);
	wAltsMainWin:SetVisible(false);
	wAltsMainWin:SetHideF12(true);
	wAltsMainWin:SetCloseEsc(true);


	local CURTOP = 50;

	-- Alt drop downs.
	local _ALTNAMES = {};
	for k,v in pairs (_PROFESSIONSINFO) do
		table.insert(_ALTNAMES,k);
	end
	table.sort(_ALTNAMES);

	ddAlts = DropDown.Create(_ALTNAMES);
	ddAlts:SetParent(wAltsMainWin);
	ddAlts:SetPosition(30,CURTOP);
	ddAlts:ApplyWidth(140);

	ddAlts.ItemChanged = function ()

		local ALTNAME = ddAlts:GetText();
		RefreshAltInfo(ALTNAME);

	end



	-- Professions
	_lblProfTitle = {};
	_lblProficiency = {};
	_lblMastery = {};
	_lblProficiencyXP = {};
	_lblMasteryXP = {};
	_imgProfProgressBar = {};
	_ProficOverlay = {};
	_imgMastProgressBar = {};
	_MastOverlay = {};
	lblPROFICIENCY = {};
	lblMASTERY = {};
	_btnAltRecipes = {};


	local BARWIDTH = 170;
	local PROFMASTLEFT = 30;
	local TIERLEFT = 130;
	local BARLEFT = 220;
	CURTOP = CURTOP + 40;


	for i=1,4 do

		_btnAltRecipes[i] = Turbine.UI.Lotro.Button();
		_btnAltRecipes[i]:SetParent(wAltsMainWin);
		_btnAltRecipes[i]:SetSize(20,20);
		_btnAltRecipes[i]:SetPosition(PROFMASTLEFT,CURTOP);
		_btnAltRecipes[i]:SetText("R");


		_lblProfTitle[i] = Turbine.UI.Label();
		_lblProfTitle[i]:SetParent(wAltsMainWin);
		_lblProfTitle[i]:SetSize(130,20);
		_lblProfTitle[i]:SetPosition(PROFMASTLEFT+45,CURTOP);
		_lblProfTitle[i]:SetTextAlignment(LEFTALIGN);
		--_lblProfTitle[i]:SetBackColor(HDBLUE);
		_lblProfTitle[i]:SetFont(TrajanPro16);
		_lblProfTitle[i]:SetForeColor(Turbine.UI.Color.DarkOrange);

		CURTOP = CURTOP + 25;


		lblPROFICIENCY[i] = Turbine.UI.Label();
		lblPROFICIENCY[i]:SetParent(wAltsMainWin);
		lblPROFICIENCY[i]:SetSize(90,20);
		lblPROFICIENCY[i]:SetPosition(PROFMASTLEFT,CURTOP);
		lblPROFICIENCY[i]:SetTextAlignment(LEFTALIGN);
		--lblPROFICIENCY[i]:SetBackColor(HDBLUE);
		lblPROFICIENCY[i]:SetFont(Verdana14);
		lblPROFICIENCY[i]:SetForeColor(Turbine.UI.Color.DarkKhaki);
		lblPROFICIENCY[i]:SetText(_LANG.PROFICIENCY[SETTINGS.LANGUAGE]);

		_lblProficiency[i] = Turbine.UI.Label();
		_lblProficiency[i]:SetParent(wAltsMainWin);
		_lblProficiency[i]:SetSize(90,20);
		_lblProficiency[i]:SetPosition(TIERLEFT,CURTOP);
		_lblProficiency[i]:SetTextAlignment(LEFTALIGN);
		--_lblProficiency[i]:SetBackColor(HDBLUE);
		_lblProficiency[i]:SetFont(Verdana14);

		_imgProfProgressBar[i] = Turbine.UI.Control();
		_imgProfProgressBar[i]:SetParent(wAltsMainWin);
		_imgProfProgressBar[i]:SetSize(170,24);
		_imgProfProgressBar[i]:SetPosition(BARLEFT,CURTOP);
		_imgProfProgressBar[i]:SetBackground(_IMAGES.PROGRESSBARBACK);
		_imgProfProgressBar[i]:SetBlendMode(4);

		_ProficOverlay[i] = Turbine.UI.Control();
		_ProficOverlay[i]:SetParent(_imgProfProgressBar[i]);
		_ProficOverlay[i]:SetSize(148,13);
		_ProficOverlay[i]:SetPosition(12,6);
		_ProficOverlay[i]:SetBackground(_IMAGES.PROGRESSBARFILLRED);
		_ProficOverlay[i]:SetBlendMode(4);

		_lblProficiencyXP[i] = Turbine.UI.Label();
		_lblProficiencyXP[i]:SetParent(wAltsMainWin);
		_lblProficiencyXP[i]:SetSize(170,24);
		_lblProficiencyXP[i]:SetPosition(BARLEFT,CURTOP);
		_lblProficiencyXP[i]:SetTextAlignment(MIDALIGN);
		--_lblProficiencyXP[i]:SetBackColor(HDBLUE);
		_lblProficiencyXP[i]:SetFont(Verdana12);
        _lblProficiencyXP[i]:SetOutlineColor(Turbine.UI.Color(0.05,0.05,0.05));
		_lblProficiencyXP[i]:SetFontStyle(Turbine.UI.FontStyle.Outline);

		CURTOP = CURTOP + 25;


		lblMASTERY[i] = Turbine.UI.Label();
		lblMASTERY[i]:SetParent(wAltsMainWin);
		lblMASTERY[i]:SetSize(90,20);
		lblMASTERY[i]:SetPosition(PROFMASTLEFT,CURTOP);
		lblMASTERY[i]:SetTextAlignment(LEFTALIGN);
		--lblMASTERY[i]:SetBackColor(HDBLUE);
		lblMASTERY[i]:SetFont(Verdana14);
		lblMASTERY[i]:SetForeColor(Turbine.UI.Color.DarkKhaki);
		lblMASTERY[i]:SetText(_LANG.MASTERY[SETTINGS.LANGUAGE]);

		_lblMastery[i] = Turbine.UI.Label();
		_lblMastery[i]:SetParent(wAltsMainWin);
		_lblMastery[i]:SetSize(90,20);
		_lblMastery[i]:SetPosition(TIERLEFT,CURTOP);
		_lblMastery[i]:SetTextAlignment(LEFTALIGN);
		--_lblMastery[i]:SetBackColor(HDBLUE);
		_lblMastery[i]:SetFont(Verdana14);

		_imgMastProgressBar[i] = Turbine.UI.Control();
		_imgMastProgressBar[i]:SetParent(wAltsMainWin);
		_imgMastProgressBar[i]:SetSize(170,24);
		_imgMastProgressBar[i]:SetPosition(BARLEFT,CURTOP);
		_imgMastProgressBar[i]:SetBackground(_IMAGES.PROGRESSBARBACK);
		_imgMastProgressBar[i]:SetBlendMode(4);

		_MastOverlay[i] = Turbine.UI.Control();
		_MastOverlay[i]:SetParent(_imgMastProgressBar[i]);
		_MastOverlay[i]:SetSize(148,13);
		_MastOverlay[i]:SetPosition(12,6);
		_MastOverlay[i]:SetBackground(_IMAGES.PROGRESSBARFILLYELLOW);
		_MastOverlay[i]:SetBlendMode(4);

		_lblMasteryXP[i] = Turbine.UI.Label();
		_lblMasteryXP[i]:SetParent(wAltsMainWin);
		_lblMasteryXP[i]:SetSize(170,24);
		_lblMasteryXP[i]:SetPosition(BARLEFT,CURTOP);
		_lblMasteryXP[i]:SetTextAlignment(MIDALIGN);
		--_lblMasteryXP[i]:SetBackColor(HDBLUE);
		_lblMasteryXP[i]:SetFont(Verdana12);
		 _lblMasteryXP[i]:SetOutlineColor(Turbine.UI.Color(0.05,0.05,0.05));
		_lblMasteryXP[i]:SetFontStyle(Turbine.UI.FontStyle.Outline);

		CURTOP = CURTOP + 40;

	end



	RefreshAltInfo(ddAlts:GetText());

	-- Window events
	wAltsMainWin.PositionChanged = function()
		SETTINGS.ALTSWINDOW.X = wAltsMainWin:GetLeft();
		SETTINGS.ALTSWINDOW.Y = wAltsMainWin:GetTop();
	end

end



function RefreshAltInfo(ALTNAME)

	if ALTNAME == nil then return end;

	local i=1;

	for k,v in pairs (_PROFESSIONSINFO[ALTNAME]) do

		local OVERLAYWIDTH = 148;

		local PROFESSIONTITLE = k;
		local PROFICLEVEL = v.ProficiencyLevel;
		local MASTLEVEL = v.MasteryLevel;
		local PROFICXP = v.ProficiencyExperience;
		local PROFICTARGET = v.ProficiencyExperienceTarget;
		local MASTERXP = v.MasteryExperience;
		local MASTERTARGET = v.MasteryExperienceTarget;


		_lblProfTitle[i]:SetText(PROFESSIONTITLE);

		_btnAltRecipes[i].Click = function ()
			GetAltRecipes(ALTNAME,k);
		end


		if PROFICTARGET == 0 then
			_lblProficiencyXP[i]:SetText(_LANG.MAX[SETTINGS.LANGUAGE]);
			_ProficOverlay[i]:SetWidth(0);
		else
			_lblProficiencyXP[i]:SetText(PROFICXP .. "/" .. PROFICTARGET);
			_ProficOverlay[i]:SetWidth(OVERLAYWIDTH*(PROFICXP/PROFICTARGET));
			PROFICLEVEL = PROFICLEVEL + 1;
		end

		if MASTERTARGET == 0 then
			_lblMasteryXP[i]:SetText(_LANG.MAX[SETTINGS.LANGUAGE]);
			_MastOverlay[i]:SetWidth(0);
		else
			_lblMasteryXP[i]:SetText(MASTERXP .. "/" .. MASTERTARGET);
			_MastOverlay[i]:SetWidth(OVERLAYWIDTH*(MASTERXP/MASTERTARGET));
			MASTLEVEL = MASTLEVEL + 1;
		end

		if PROFICLEVEL ~= 0 then
			_lblProficiency[i]:SetText(GetCraftTier(PROFICLEVEL));
		else
			_lblProficiency[i]:SetText("-");
		end;

		if MASTLEVEL ~= 0 then
			_lblMastery[i]:SetText(GetCraftTier(MASTLEVEL));
		else
			_lblMastery[i]:SetText("-");
		end


		i = i + 1;

	end

end



function DrawAltRecipeWin()

	wAltRecipeWin = Turbine.UI.Lotro.Window();
	wAltRecipeWin:SetSize(800,580);
	wAltRecipeWin:SetPosition(SETTINGS.MAINWIN.X,SETTINGS.MAINWIN.Y);
	wAltRecipeWin:SetVisible(false);
	wAltRecipeWin:SetHideF12(true);
	wAltRecipeWin:SetCloseEsc(true);

	btnAltAlts = Turbine.UI.Lotro.GoldButton();
	btnAltAlts:SetParent(wAltRecipeWin);
	btnAltAlts:SetWidth(80);
	btnAltAlts:SetPosition(800-btnAltAlts:GetWidth()-80,10);
	btnAltAlts:SetText(_LANG.ALTS[SETTINGS.LANGUAGE]);

	btnAltAlts.MouseClick = function (sender, args)
		if wAltsMainWin:IsVisible() == false then
			wAltsMainWin:SetVisible(true);
		else
			wAltsMainWin:SetVisible(false);
		end
	end


	-- Background control to hold the background image
	wAltRecipeWinBack = Turbine.UI.Control();
	wAltRecipeWinBack:SetParent(wAltRecipeWin);
	wAltRecipeWinBack:SetSize(800,586);
	wAltRecipeWinBack:SetPosition(0,-7);
	wAltRecipeWinBack:SetBlendMode(4);
	wAltRecipeWinBack:SetBackground(_IMAGES.MAINWINBACK);
	wAltRecipeWinBack:SetMouseVisible(false);

	wAltRecipeBackNoCrit = Turbine.UI.Control();
	wAltRecipeBackNoCrit:SetParent(wAltRecipeWin);
	wAltRecipeBackNoCrit:SetSize(446,481);
	wAltRecipeBackNoCrit:SetPosition(336,50);
	wAltRecipeBackNoCrit:SetBlendMode(4);
	wAltRecipeBackNoCrit:SetBackground(_IMAGES.INGREDIENTSBACK_NOCRIT);
	wAltRecipeBackNoCrit:SetMouseVisible(false);
	wAltRecipeBackNoCrit:SetVisible(true);

	-- Holding window
	wAltWinHolder = Turbine.UI.Control();
	wAltWinHolder:SetParent(wAltRecipeWin);
	wAltWinHolder:SetSize(780,490);
	wAltWinHolder:SetPosition(10,40);


	-- Create the tree view control.
    tvAltRecipes = Turbine.UI.TreeView();
    tvAltRecipes:SetParent(wAltWinHolder);
    tvAltRecipes:SetPosition(10,150);
    tvAltRecipes:SetSize(300,330);
    --tvAltRecipes:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
    tvAltRecipes:SetIndentationWidth(7);


    -- Give the tree view a scroll bar.
    local sctvAltRecipes = Turbine.UI.Lotro.ScrollBar();
    sctvAltRecipes:SetOrientation(Turbine.UI.Orientation.Vertical);
    sctvAltRecipes:SetParent(wAltWinHolder);
    sctvAltRecipes:SetPosition(tvAltRecipes:GetLeft() + tvAltRecipes:GetWidth(),tvAltRecipes:GetTop());
    sctvAltRecipes:SetSize(8,tvAltRecipes:GetHeight());
	sctvAltRecipes:SetVisible(false);

    tvAltRecipes:SetVerticalScrollBar(sctvAltRecipes);


	-- Recipe View
	wRecipeAltView = Turbine.UI.Control();
	wRecipeAltView:SetParent(wAltWinHolder);
	wRecipeAltView:SetSize(440,tvAltRecipes:GetHeight()-20);
	wRecipeAltView:SetPosition(tvAltRecipes:GetLeft() + tvAltRecipes:GetWidth() + 20,20);
	--wRecipeAltView:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
	wRecipeAltView:SetVisible(true);


	-- Recipe Info
	wRecipeAltInfo = Turbine.UI.Control();
	wRecipeAltInfo:SetParent(wAltWinHolder);
	wRecipeAltInfo:SetSize(tvAltRecipes:GetWidth(),80);
	wRecipeAltInfo:SetPosition(10,20);
	--wRecipeAltInfo:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
	wRecipeAltInfo:SetVisible(true);


	-- Window events --
	wAltRecipeWin.Closing = function()
		SETTINGS.MAINWIN.VISIBLE = false;
		Debug(_LANG.COMMANDWARNING[SETTINGS.LANGUAGE]);
	end

	wAltRecipeWin.PositionChanged = function()
		SETTINGS.MAINWIN.X = wAltRecipeWin:GetLeft();
		SETTINGS.MAINWIN.Y = wAltRecipeWin:GetTop();
	end

end



function GetAltRecipes(ALTNAME,ALTPROFESSION)

	wRecipeAltInfo:GetControls():Clear();
	wRecipeAltView:GetControls():Clear();

	local RootNode = tvAltRecipes:GetNodes();
	RootNode:Clear();

	if ALTNAME == MYNAME then
		wAltRecipeWin:SetVisible(false);
		wMainWinParent:SetVisible(true);
		wMainWinParent:SetPosition(SETTINGS.MAINWIN.X,SETTINGS.MAINWIN.Y);
		wMainWinParent:Activate();
	else
		wMainWinParent:SetVisible(false);
		wAltRecipeWin:SetVisible(true);
		wAltRecipeWin:SetText(_LANG.RECIPES[SETTINGS.LANGUAGE] .. ": " .. ALTNAME);
		wAltRecipeWin:SetPosition(SETTINGS.MAINWIN.X,SETTINGS.MAINWIN.Y);
		wAltRecipeWin:Activate();


		if type(_ALTRECIPES[ALTNAME]) == 'nil' then
			Debug("Recipes not available, please load Crafting Companion from your alt to get the recipes");
			return;
		end


		local _TEMPRECIPETABLE = _ALTRECIPES[ALTNAME][ALTPROFESSION];

		-- Build the recipe tree
		--local RootNode = tvAltRecipes:GetNodes();
		--RootNode:Clear();

		local MAXTIER = 0;

		for k,v in pairs (_TEMPRECIPETABLE) do
			if k > MAXTIER then MAXTIER = k end;
		end


		for i=MAXTIER, 1, -1 do

			local CURTIERNODE = Turbine.UI.TreeNode();
			CURTIERNODE:SetSize(tvAltRecipes:GetWidth()-2,18);

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

			if i > _PROFESSIONSINFO[ALTNAME][ALTPROFESSION].MasteryLevel then

				lblTier:SetForeColor(GREY4);

				if i == (_PROFESSIONSINFO[ALTNAME][ALTPROFESSION].ProficiencyLevel + 1) then
					-- Proficiency at this tier only.
					REMAININGXP = (_PROFESSIONSINFO[ALTNAME][ALTPROFESSION].ProficiencyExperienceTarget - _PROFESSIONSINFO[ALTNAME][ALTPROFESSION].ProficiencyExperience) + Data._MASTERYXP[i];
				elseif i == (_PROFESSIONSINFO[ALTNAME][ALTPROFESSION].MasteryLevel + 1) then
					-- Mastery at this tier only
					REMAININGXP = (_PROFESSIONSINFO[ALTNAME][ALTPROFESSION].MasteryExperienceTarget - _PROFESSIONSINFO[ALTNAME][ALTPROFESSION].MasteryExperience);
				end

				lblTier:SetText(GetCraftTier(i) .. " <rgb=#" .. XPTIERHEX .. ">(" .. _LANG.NEED[SETTINGS.LANGUAGE] .. " " .. CommaNumbers(REMAININGXP) .. "xp)</rgb>");


			else
				-- Mastered current level.
				lblTier:SetForeColor(YELLOW2);
				lblTier:SetText(GetCraftTier(i));
			end


			RootNode:Add(CURTIERNODE);


			-- Child nodes for each category for that tier.
			local CATNODES = CURTIERNODE:GetChildNodes();

			for k,v in pairs (_TEMPRECIPETABLE[i]) do

				local CURCATNODE = Turbine.UI.TreeNode();
				CURCATNODE:SetSize(tvAltRecipes:GetWidth()-2,18);

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
				lblCat:SetText(k);


				CATNODES:Add(CURCATNODE);


				-- Child nodes for each recipe in that category
				local RECIPENODES = CURCATNODE:GetChildNodes();

				for a,b in pairs (_TEMPRECIPETABLE[i][k]) do

					local _CURRECIPE = b;

					local SINGLEUSE = _CURRECIPE.IsSingleUse;
					local RECIPEXP = _CURRECIPE.ExperienceReward;
					local RECNAME = _CURRECIPE.Name;

					local CURRECIPENODE = Turbine.UI.TreeNode();
					CURRECIPENODE:SetSize(tvAltRecipes:GetWidth()-2,18);

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

					if SINGLEUSE == true then

						RECIPEICON:SetBackground(_IMAGES.SINGLEUSE);

					elseif _CURRECIPE.Cooldown > 0 then

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

					if _CURRECIPE.IsKnown == false then
						lblRecipe:SetForeColor(Turbine.UI.Color.Maroon);
					end

					if REMAININGXP == 0 then

						if string.len(RECNAME) > 33 then RECNAME=string.sub(RECNAME,1,33) .. "..." end;

						CURRECIPENODE.MouseClick = function (sender,args)
							RefreshAltRecipeView(_CURRECIPE,ALTPROFESSION,ALTNAME,i); -- Update the recipe view window when clicked.
						end

					else

						if string.len(RECNAME) > 23 then RECNAME=string.sub(RECNAME,1,23) .. "..." end;

						local TOCRAFTFORMAXXP = math.ceil(REMAININGXP/RECIPEXP);

						RECNAME = RECNAME .. " <rgb=#" .. XPRECIPEHEX .. ">(" .. TOCRAFTFORMAXXP .. " " .. _LANG.AT[SETTINGS.LANGUAGE] .. " " .. RECIPEXP .. "xp)</rgb>";

						CURRECIPENODE.MouseClick = function (sender,args)
							RefreshAltRecipeView(_CURRECIPE,ALTPROFESSION,ALTNAME,i); -- Update the recipe view window when clicked.
						end

					end

					lblRecipe:SetText(RECNAME);

					RECIPENODES:Add(CURRECIPENODE);

				end
			end
		end
	end
end


function RefreshAltRecipeView(SELECTEDRECIPE,PROFESSION,ALTNAME,TIER)


	wRecipeAltInfo:GetControls():Clear();
	wRecipeAltView:GetControls():Clear();


	local iconNOMALITEMBACK = Turbine.UI.Lotro.ItemInfoControl();
	iconNOMALITEMBACK:SetParent(wRecipeAltInfo);
	iconNOMALITEMBACK:SetPosition(5,2);
	iconNOMALITEMBACK:SetSize(32,32);
	iconNOMALITEMBACK:SetBackground(SELECTEDRECIPE.BACKIMAGE);
	iconNOMALITEMBACK:SetBlendMode(4);

	local iconNOMALITEM = Turbine.UI.Lotro.ItemInfoControl();
	iconNOMALITEM:SetParent(wRecipeAltInfo);
	iconNOMALITEM:SetPosition(iconNOMALITEMBACK:GetPosition());
	iconNOMALITEM:SetSize(iconNOMALITEMBACK:GetSize());
	iconNOMALITEM:SetBackground(SELECTEDRECIPE.IMAGE);
	iconNOMALITEM:SetBlendMode(4);

	local lblRECIPENAME = Turbine.UI.Label();
	lblRECIPENAME:SetParent(wRecipeAltInfo);
	lblRECIPENAME:SetPosition(50,0);
	lblRECIPENAME:SetSize(wRecipeAltInfo:GetWidth()-55,35);
	lblRECIPENAME:SetTextAlignment(LEFTALIGN);
	lblRECIPENAME:SetMultiline(true);
	lblRECIPENAME:SetFont(TrajanPro16);
	lblRECIPENAME:SetForeColor(GetItemFontColor(SELECTEDRECIPE.QUALITY));
	--lblRECIPENAME:SetBackColor(HDBLUE);
	lblRECIPENAME:SetText(SELECTEDRECIPE.Name);


	local lblRECIPEEXPERIENCE = Turbine.UI.Label();
	lblRECIPEEXPERIENCE:SetParent(wRecipeAltInfo);
	lblRECIPEEXPERIENCE:SetSize(185,18);
	lblRECIPEEXPERIENCE:SetPosition(wRecipeAltInfo:GetWidth()-lblRECIPEEXPERIENCE:GetWidth()-5,42);
	lblRECIPEEXPERIENCE:SetForeColor(Turbine.UI.Color.Aquamarine);
	--lblRECIPEEXPERIENCE:SetBackColor(HDBLUE);
	lblRECIPEEXPERIENCE:SetFont(Verdana14);
	lblRECIPEEXPERIENCE:SetTextAlignment(RIGHTALIGN);
	lblRECIPEEXPERIENCE:SetText(SELECTEDRECIPE.ExperienceReward .. "xp");


	if TIER > _PROFESSIONSINFO[ALTNAME][PROFESSION].MasteryLevel then
		lblRECIPEEXPERIENCE:SetText(SELECTEDRECIPE.ExperienceReward .. "xp");
	else
		lblRECIPEEXPERIENCE:SetText(_LANG.MASTERED[SETTINGS.LANGUAGE]);
	end


	local RECCOOLDOWN = SELECTEDRECIPE.Cooldown;

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

		local lblRECIPECOOLDOWN = Turbine.UI.Label();
		lblRECIPECOOLDOWN:SetParent(wRecipeAltInfo);
		lblRECIPECOOLDOWN:SetPosition(5,60);
		lblRECIPECOOLDOWN:SetSize(wRecipeAltInfo:GetWidth()-10,18);
		lblRECIPECOOLDOWN:SetForeColor(Turbine.UI.Color.Aquamarine);
		--lblRECIPECOOLDOWN:SetBackColor(HDBLUE);
		lblRECIPECOOLDOWN:SetFont(Verdana14);
		lblRECIPECOOLDOWN:SetTextAlignment(RIGHTALIGN);
		lblRECIPECOOLDOWN:SetText(TIMESTRING);

	end

	if SELECTEDRECIPE.IsSingleUse == true then

		local lblRECIPESINGLEUSE = Turbine.UI.Label();
		lblRECIPESINGLEUSE:SetParent(wRecipeAltInfo);
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
	ingredientTitlebar:SetParent(wRecipeAltView);
	ingredientTitlebar:SetSize(408,31);
	ingredientTitlebar:SetPosition(28,4);
	ingredientTitlebar:SetBackground(_IMAGES.INGREDIENTTITLEBAR);
	ingredientTitlebar:SetBlendMode(4);
	ingredientTitlebar:SetMouseVisible(false);


	local iconLBLINGREDIENTS = Turbine.UI.Control();
	iconLBLINGREDIENTS:SetParent(wRecipeAltView);
	iconLBLINGREDIENTS:SetSize(40,41);
	iconLBLINGREDIENTS:SetPosition(5,0);
	iconLBLINGREDIENTS:SetMouseVisible(false);
	iconLBLINGREDIENTS:SetBlendMode(BLEND_OVERLAY);
	iconLBLINGREDIENTS:SetBackground(_IMAGES.INGREDIENTICON);
	iconLBLINGREDIENTS:SetVisible(true);


	local lblINGREDIENTS = Turbine.UI.Label();
	lblINGREDIENTS:SetParent(wRecipeAltView);
	lblINGREDIENTS:SetPosition(105,0);
	lblINGREDIENTS:SetSize(150,41);
	lblINGREDIENTS:SetForeColor(Turbine.UI.Color.DarkKhaki);
	lblINGREDIENTS:SetFont(TrajanPro18);
	--lblINGREDIENTS:SetBackColor(HDBLUE);
	lblINGREDIENTS:SetTextAlignment(LEFTALIGN);
	lblINGREDIENTS:SetText(_LANG.INGREDIENTS[SETTINGS.LANGUAGE]);

	-- Create the tree view control.
    local tvRECIPEINGREDIENTS = Turbine.UI.TreeView();
    tvRECIPEINGREDIENTS:SetParent(wRecipeAltView);
    tvRECIPEINGREDIENTS:SetPosition(5,45);
    tvRECIPEINGREDIENTS:SetSize(wRecipeAltView:GetWidth()-18,wRecipeAltView:GetHeight()-55); -- top (315) - 165
	--tvRECIPEINGREDIENTS:SetBackColor(Turbine.UI.Color(0.1,0.1,0.1));
    tvRECIPEINGREDIENTS:SetIndentationWidth(20);


    -- Give the tree view a scroll bar.
    local sctvRECIPEINGREDIENTS = Turbine.UI.Lotro.ScrollBar();
    sctvRECIPEINGREDIENTS:SetOrientation(Turbine.UI.Orientation.Vertical);
    sctvRECIPEINGREDIENTS:SetParent(wRecipeAltView);
    sctvRECIPEINGREDIENTS:SetPosition(tvRECIPEINGREDIENTS:GetLeft() + tvRECIPEINGREDIENTS:GetWidth()+1,tvRECIPEINGREDIENTS:GetTop());
    sctvRECIPEINGREDIENTS:SetSize(8,tvRECIPEINGREDIENTS:GetHeight());
	sctvRECIPEINGREDIENTS:SetVisible(false);

    tvRECIPEINGREDIENTS:SetVerticalScrollBar(sctvRECIPEINGREDIENTS);


	local RootNode = tvRECIPEINGREDIENTS:GetNodes();
	RootNode:Clear();


	-- Loop through each ingredient and add to tree view - then test each item to see if it is a craftable ingredient
	-- if so add those ingredients as a child node
	for k,v in pairs (SELECTEDRECIPE.Ingredients) do

		local CURINGREDNAME = v.Name;
		local CURINGREQQTY = v.RequiredQuantity;

		local CURPRIMARYINGREDIENTNODE = Turbine.UI.TreeNode();
		CURPRIMARYINGREDIENTNODE:SetSize(tvRECIPEINGREDIENTS:GetWidth()-2,39);

		local PRIMARYINGHOLDER = Turbine.UI.Control();
		PRIMARYINGHOLDER:SetParent(CURPRIMARYINGREDIENTNODE);
		PRIMARYINGHOLDER:SetSize(CURPRIMARYINGREDIENTNODE:GetWidth(),39);
		--PRIMARYINGHOLDER:SetBackColor(HDBLUELT);
		PRIMARYINGHOLDER:SetMouseVisible(false);

		local INGREDIENTICONBACK = Turbine.UI.Control();
		INGREDIENTICONBACK:SetParent(PRIMARYINGHOLDER);
		INGREDIENTICONBACK:SetPosition(18,2);
		INGREDIENTICONBACK:SetSize(32,32);
		INGREDIENTICONBACK:SetBackground(v.BACKIMAGE);
		INGREDIENTICONBACK:SetBlendMode(4);

		local INGREDIENTICON = Turbine.UI.Control();
		INGREDIENTICON:SetParent(PRIMARYINGHOLDER);
		INGREDIENTICON:SetPosition(18,2);
		INGREDIENTICON:SetSize(INGREDIENTICONBACK:GetSize());
		INGREDIENTICON:SetBackground(v.IMAGE);
		INGREDIENTICON:SetBlendMode(4);


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

		TooltipInventory(CURPRIMARYINGREDIENTNODE,CURINGREDNAME);

		if GetItemInventoryCount(CURINGREDNAME) >= CURINGREQQTY then
			lblPRIMARYING:SetForeColor(INGSUBCOLOR);
		end


		RootNode:Add(CURPRIMARYINGREDIENTNODE);

	end



end

