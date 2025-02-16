
--	_PROFESSIONSINFO[MYNAME] - table storing information about each profession (xp, name, etc) - organised by name
-- 	_RECIPES - table storing all the known recipes for each of the profession (name, ingredients etc)


function GetMyVocation()

	-- This function gets the players vocation (eg Tinker or Historian) and returns the name as a string.
	local MYVOCATIONINFO = MYATTS:GetVocation();

	if MYVOCATIONINFO == nil then return nil end;

	local VOCATION = "";

	for k,v in pairs(Turbine.Gameplay.Vocation) do

		if v == MYVOCATIONINFO then
			VOCATION = k;
			break;
		end

	end

	return VOCATION;
end


function GetMyProfessions()

	-- This function fills the _PROFESSIONSINFO table with all the profession info
	_PROFESSIONSINFO[MYNAME] = nil;
	_PROFESSIONSINFO[MYNAME] = {};

	-- This function gets each of the characters professions.
	for k,v in pairs (Turbine.Gameplay.Profession) do

		local PROFESSIONINFO = MYATTS:GetProfessionInfo(v); -- If character is not of the profession, this returns nil.

		if PROFESSIONINFO ~= nil then

			_PROFESSIONSINFO[MYNAME][k] =
			{
			["ProfessionName"] = PROFESSIONINFO:GetName(); -- string e.g. Prospector
			["ProficiencyLevel"] = PROFESSIONINFO:GetProficiencyLevel(); -- number e.g. 7 (Westfold)
			["ProficiencyExperience"] = PROFESSIONINFO:GetProficiencyExperience(); -- number
			["ProficiencyExperienceTarget"] = PROFESSIONINFO:GetProficiencyExperienceTarget(); -- number e.g. 760 (Eastemnet)
			["MasteryLevel"] = PROFESSIONINFO:GetMasteryLevel(); -- number e.g. 7 (Westfold). The current level you're at, not where you are heading
			["MasteryExperience"] = PROFESSIONINFO:GetMasteryExperience(); -- number
			["MasteryExperienceTarget"] = PROFESSIONINFO:GetMasteryExperienceTarget(); -- number e.g. 1520 (Eastemnet)
			};



			-- Event listeners

			PROFESSIONINFO.ProficiencyExperienceChanged = function (sender,args) -- TESTED AND WORKS
				_PROFESSIONSINFO[MYNAME][k]["ProficiencyExperience"] = PROFESSIONINFO:GetProficiencyExperience();
				RefreshRecipeLabels(k,1);
				-- Debug("Proficiency Experience Changed");
			end

			PROFESSIONINFO.MasteryExperienceChanged = function (sender,args) -- TESTED AND WORKS
				_PROFESSIONSINFO[MYNAME][k]["MasteryExperience"] = PROFESSIONINFO:GetMasteryExperience(); -- Sets the new xp amount
				RefreshRecipeLabels(k,2);
			end

			PROFESSIONINFO.ProficiencyLevelChanged = function (sender,args) -- TESTED AND WORKS
				_PROFESSIONSINFO[MYNAME][k]["ProficiencyExperienceTarget"] = PROFESSIONINFO:GetProficiencyExperienceTarget();
				_PROFESSIONSINFO[MYNAME][k]["ProficiencyLevel"] = PROFESSIONINFO:GetProficiencyLevel();
				-- I guess refresh the recipe tree to get new tier recipes?
				GetMyRecipes(k);
				RefreshRecipeList(k,1); -- u1.4.1 - changed from RefreshRecipeList(k);
				--Debug("Proficiency level changed");
			end

			PROFESSIONINFO.MasteryLevelChanged = function (sender,args) -- TESTED AND WORKS
				_PROFESSIONSINFO[MYNAME][k]["MasteryExperienceTarget"] = PROFESSIONINFO:GetMasteryExperienceTarget();
				_PROFESSIONSINFO[MYNAME][k]["MasteryLevel"] = PROFESSIONINFO:GetMasteryLevel();
				RefreshRecipeLabels(k,2);
			end

			PROFESSIONINFO.RecipeCountChanged = function (sender,args) -- CURRENT EVENT NOT RECOGNISED
				GetMyRecipes(k);
				RefreshRecipeList(k);
				Debug("RecipeCountChanged - if you see this message please let Galuhad know at lotrointerface.com, thanks.");
			end

		end

	end

	--Debug(dump(_PROFESSIONSINFO));

end


-- this function refreshes the labels in the recipe view
-- Used when xp is earned to update xp remaining etc.
-- Update will only either be Proficiency or Mastery, never both.

function RefreshRecipeLabels(PROF,IDPROFMAST) -- PROF = string name of profession , IDPROFMAST = no. 1 (Proficiency) or 2 (Mastery)

	local iMin, iMax = MAXGAMETIER,1;

	for k,v in pairs (_RECIPELABELS[PROF]) do

		if tonumber(k) < iMin then iMin = tonumber(k) end;
		if tonumber(k) > iMax then iMax = tonumber(k) end;

	end

	-- if Mastery then use iMin
	-- if Proficiency then use iMax

	local _CURPROFESSION = _PROFESSIONSINFO[MYNAME][PROF];

	if IDPROFMAST == 1 then -- Proficiency

		local tempLabel = _RECIPELABELS[PROF][iMax]["TIERLABEL"];

		local REMAININGXP = (_CURPROFESSION.ProficiencyExperienceTarget - _CURPROFESSION.ProficiencyExperience) + Data._MASTERYXP[iMax];

		_RECIPELABELS[PROF][iMax]["REMAININGXP"] = REMAININGXP;

		tempLabel:SetText(GetCraftTier(iMax) .. " <rgb=#" .. XPTIERHEX .. ">(" .. _LANG.NEED[SETTINGS.LANGUAGE] .. " " .. CommaNumbers(REMAININGXP) .. "xp)</rgb>");

		-- Update labels
		UpdateLabels(_RECIPELABELS[PROF][iMax]["LABELS"],REMAININGXP);


	elseif IDPROFMAST == 2 then -- Mastery

		--Debug("PROF="..PROF.."; iMin="..iMin);
		local tempLabel = _RECIPELABELS[PROF][iMin]["TIERLABEL"]; -- error caused by iMin not setting to the highest possible value when initialised. This was because MAXGAMETIER was using the game database (max 8). This is now based on Data._MASTERYXP count.

		REMAININGXP = (_CURPROFESSION.MasteryExperienceTarget - _CURPROFESSION.MasteryExperience);

		_RECIPELABELS[PROF][iMin]["REMAININGXP"] = REMAININGXP;

		if REMAININGXP > 0 then

			tempLabel:SetText(GetCraftTier(iMin) .. " <rgb=#" .. XPTIERHEX .. ">(" .. _LANG.NEED[SETTINGS.LANGUAGE] .. " " .. CommaNumbers(REMAININGXP) .. "xp)</rgb>");

		else

			-- Just mastered current level.
			tempLabel:SetForeColor(YELLOW2);
			tempLabel:SetText(GetCraftTier(iMin));

		end

		UpdateLabels(_RECIPELABELS[PROF][iMin]["LABELS"],REMAININGXP);

	end

end


-- This function is used by RefreshRecipeLabels() to update each recipe in the treeview with new xp
function UpdateLabels(LABELTABLE,REMAININGXP)

	for k,v in pairs (LABELTABLE) do

		local templblRecipe = v.LABELCONTROL;
		local tempRecName = v.NAME;

		if REMAININGXP > 0 then
			-- Still xp to be earned
			if string.len(tempRecName) > 23 then tempRecName=string.sub(tempRecName,1,23) .. "..." end;
			local TOCRAFTFORMAXXP = math.ceil(REMAININGXP/v.XP);
			templblRecipe:SetText(tempRecName .. " <rgb=#" .. XPRECIPEHEX .. ">(" .. TOCRAFTFORMAXXP .. " " .. _LANG.AT[SETTINGS.LANGUAGE] .. " " .. v.XP .. "xp)</rgb>");

		else
			-- No more xp
			if string.len(tempRecName) > 33 then tempRecName=string.sub(tempRecName,1,33) .. "..." end;
			templblRecipe:SetText(tempRecName);
		end
	end
end


-- This function updates the displayed recipe with the new quantity wanted to craft.
function UpdateRecipeIngredientsQuantities(NEWQTY)

	if type (_INGREDIENTLIST) ~= 'table' then return end;

	for k,v in pairs (_INGREDIENTLIST) do

		if v.SINGLEQTY ~= nil then

			local NEWREQQTY = v.SINGLEQTY * NEWQTY;

			local LABELSTRING = "";

			if v.PROFESSION == "" then
				LABELSTRING = CommaNumbers(NEWREQQTY) .. "x " .. v.NAME .. " (" .. GetItemInventoryCount(v.NAME) .. ")";
			else
				LABELSTRING = CommaNumbers(NEWREQQTY) .. "x " .. v.NAME .. " (" .. GetItemInventoryCount(v.NAME) .. ") - " .. v.PROFESSION;
			end

			if GetItemInventoryCount(v.NAME) >= NEWREQQTY then
				v.ICON:SetEnabled(true);
				v.LABEL:SetForeColor(INGSUBCOLOR);
			else
				v.ICON:SetEnabled(false);
				v.LABEL:SetForeColor(WHITE);
			end

			v.LABEL:SetText(LABELSTRING);
			v.ICON:SetQuantity(NEWREQQTY);


			-- Need to update right-click menu with the new quantities
			-- Need to make use of GetParent and GetControls passing to find the correct controls.
			local NodeParent = v.LABEL:GetParent():GetParent();

			NodeParent.MouseClick = function(sender,args)
				if args.Button == Turbine.UI.MouseButton.Right then
					CreatePopup(v.NAME,NEWREQQTY);
				else
					-- Need to check if it is a node or not - and also to get the correct expand icon

					if NodeParent.IsExpanded ~= nil then

						-- Get the icon control..
						local ICONPARENT = v.LABEL:GetParent();
						local CHILDCONTROLSLIST = ICONPARENT:GetControls();
						local ICONEXPAND = "";

						for i=1, CHILDCONTROLSLIST:GetCount() do
							local CURCHILD = CHILDCONTROLSLIST:Get(i);
							if CURCHILD:GetBackground() == _IMAGES.ICONCOLLAPSE or CURCHILD:GetBackground() == _IMAGES.ICONEXPAND then
								ICONEXPAND = CURCHILD;
								break;
							end
						end

						if NodeParent:IsExpanded() == true then
							if ICONEXPAND.SetBackground ~= nil then ICONEXPAND:SetBackground(_IMAGES.ICONCOLLAPSE) end;
						else
							if ICONEXPAND.SetBackground ~= nil then ICONEXPAND:SetBackground(_IMAGES.ICONEXPAND) end;
						end
					end
				end
			end
		end
	end
end


-- This function gets the known recipes of the given profession
function GetMyRecipes(PROFESSION)

	if PROFESSION == nil then return end;


	_RECIPES[PROFESSION] = nil;

	local _TEMPRECIPETABLE = {};

	-- Check PROFESSIONS is valid and a known profession
	local PROFESSIONINFO = MYATTS:GetProfessionInfo(Turbine.Gameplay.Profession[PROFESSION]);


	if PROFESSIONINFO ~= nil then

		-- Get recipes.
		if PROFESSIONINFO.GetRecipeCount == nil then return end;
		local MAXRECIPES = PROFESSIONINFO:GetRecipeCount();	-- Number e.g 35 (all recipes across all tiers)

		--Debug(PROFESSION .. " = " .. MAXRECIPES);


		for i=1, MAXRECIPES do

			local TEMPRECIPE = PROFESSIONINFO:GetRecipe(i);

			TEMPRECIPE.IsKnownChanged = function (sender,args) -- Not tested
				Debug("IsKnownChanged - if you see this message please let Galuhad know at lotrointerface.com - thanks :)");
			end

			_TEMPRECIPETABLE[i] =
			{
			["Name"] = TEMPRECIPE:GetName(); -- string e.g. Polished Red Agate
			["IsKnown"] = true;
			["CategoryName"] = TEMPRECIPE:GetCategoryName(); -- string e.g. Gemstones
			["OptionalIngredientCount"] = TEMPRECIPE:GetOptionalIngredientCount(); -- number e.g. 1
			["Tier"] = TEMPRECIPE:GetTier(); -- number e.g. 8 (8 = Eastemnet from Turbine.Gameplay.CraftTier)
			["ExperienceReward"] = TEMPRECIPE:GetExperienceReward(); -- number e.g. 8 (xp)
			["Cooldown"] = TEMPRECIPE:GetCooldown(); -- number e.g. -1 (I guess for no cd.) Time is given in seconds e.g. 237600 seconds = 2 days 18 hours
			["Profession"] = TEMPRECIPE:GetProfession(); -- number e.g. 4 (4 = Jeweller from Turbine.Gameplay.Profession)
			["IngredientCount"] = TEMPRECIPE:GetIngredientCount(); -- number e.g 1
			["HasCriticalResultItem"] = TEMPRECIPE:HasCriticalResultItem(); -- boolean
			["Category"] = TEMPRECIPE:GetCategory(); -- number e.g. 12
			["IsSingleUse"] = TEMPRECIPE:IsSingleUse(); -- boolean
			["BaseCriticalSuccessChance"] = TEMPRECIPE:GetBaseCriticalSuccessChance(); -- number in decimal format e.g. 0.050000000745058 == 5%
			["CriticalSuccessItemQuantity"] = TEMPRECIPE:GetCriticalResultItemQuantity(); -- number e.g. 3
			["ResultItemQuantity"] = TEMPRECIPE:GetResultItemQuantity(); -- number e.g. 1

			["IngredientPack"] = TEMPRECIPE:GetIngredientPack(); -- returns nil if there is none.
			["ResultItemInfo"] = TEMPRECIPE:GetResultItemInfo(); -- returns type ITEM
			["ResultItemName"] = TEMPRECIPE:GetResultItemInfo():GetName(); -- string

			["CriticalResultItemInfo"] = ""; -- Blank to be filled later.
			["CriticalResultItemName"] = ""; -- Blank to be filled later.

			["Ingredients"] = {}; -- Blank to be filled later.
			["OptionalIngredient"] = {}; -- Blank to be filled later.

			};


			-- If the item has a critial result item then get the info for it.
			if _TEMPRECIPETABLE[i].HasCriticalResultItem == true then

				_TEMPRECIPETABLE[i].CriticalResultItemInfo =TEMPRECIPE:GetCriticalResultItemInfo(); -- returns type ITEM
				_TEMPRECIPETABLE[i].CriticalResultItemName = TEMPRECIPE:GetCriticalResultItemInfo():GetName(); -- string

			end


			-- Ingredients table
			local _TEMPINGREDIENTTABLE = _TEMPRECIPETABLE[i].Ingredients;

			for a=1, _TEMPRECIPETABLE[i].IngredientCount do

				local TEMPINGREDIENT = TEMPRECIPE:GetIngredient(a); -- Returns RECIPE INGREDIENT

				_TEMPINGREDIENTTABLE[a] =
				{
				["Name"] = TEMPINGREDIENT:GetItemInfo():GetName(); -- String e.g. Polished Green Garnet
				["CriticaChanceBonus"] = TEMPINGREDIENT:GetCriticalChanceBonus(); -- number e.g. 0.44999998807907 (45%)
				["RequiredQuantity"] = TEMPINGREDIENT:GetRequiredQuantity(); -- number e.g. 3
				["ItemInfo"] = TEMPINGREDIENT:GetItemInfo(); -- Returns type ITEM
				};
			end


			-- Optional ingredients table
			local _TEMPOPTINGREDIENTTABLE = _TEMPRECIPETABLE[i].OptionalIngredient;

			for a=1, _TEMPRECIPETABLE[i].OptionalIngredientCount do

				local TEMPINGREDIENT = TEMPRECIPE:GetOptionalIngredient(a); -- Returns RECIPE INGREDIENT

				_TEMPOPTINGREDIENTTABLE[a] =
				{
				["Name"] = TEMPINGREDIENT:GetItemInfo():GetName(); -- String e.g. Polished Green Garnet
				["CriticaChanceBonus"] = TEMPINGREDIENT:GetCriticalChanceBonus(); -- number e.g. 0.44999998807907 (45%)
				["RequiredQuantity"] = TEMPINGREDIENT:GetRequiredQuantity(); -- number e.g. 3
				["ItemInfo"] = TEMPINGREDIENT:GetItemInfo(); -- Returns type ITEM
				};
			end

		end

		_RECIPES[PROFESSION]  = deepcopy(_TEMPRECIPETABLE);

	end

end


-- This function calls GetMyProfessions() followed by GetMyRecipes()
-- Used for loading sequence to construct tables for the plugin.
function ConstructProfessionTables()

	GetMyProfessions();

	for k,v in pairs (_PROFESSIONSINFO[MYNAME]) do
		GetMyRecipes(k);
	end

end


-- This function merges the known recipes table (_RECIPES) with the built-in recipes database (Data._RECIPEDB)
-- It also adds the 'IsKnown' key/value.
function MergeRecipeTables()

	_RECIPES = mergeTables(Data._RECIPEDB,_RECIPES);

end


function GetCraftTier(TIERVALUE)

	if TIERVALUE == nil then return "" end;

	-- This function gets the craft tier name from the value (e.g. 7 == Westfold).
	if _LANG.CRAFTTIER[TIERVALUE] ~= nil then
		return _LANG.CRAFTTIER[TIERVALUE][SETTINGS.LANGUAGE];
	else
		return _LANG.CRAFTTIER[0][SETTINGS.LANGUAGE];
	end
end


-- This function gets the highest craft tier in the game
function GetMaxGameCraftTier()
	MAXGAMETIER = 1;
	local tCount = 0;
	for k in pairs (Data._MASTERYXP) do
		tCount = tCount + 1;
	end
	MAXGAMETIER = tCount;
end


function GetMaxTier(PROFESSION)

	if PROFESSION == nil then return end;

	-- this function sorts through the recipes, and gets the highest tier listed.
	local _CURRECIPES = _RECIPES[PROFESSION];
	local MAXTIER = 1;

	if type(_CURRECIPES) ~= 'table' then return MAXTIER end;

	for k,v in pairs (_CURRECIPES) do

		local CURTIER = v.Tier;
		if CURTIER > MAXTIER then MAXTIER = CURTIER end;

	end

	return MAXTIER;
end


function GetTierCategories(PROFESSION,TIER)

	if PROFESSION == nil or TIER == nil then return nil end;

	-- This function gets the category names for the recipes at the requested profession and tier and returns
	-- the results in table form.

	local _TEMPCATEGORIES = {};

	local _CURRECIPES = _RECIPES[PROFESSION];

	if type(_CURRECIPES) ~= 'table' then return _TEMPCATEGORIES end;

	for k,v in pairs (_CURRECIPES) do

		if v.Tier == TIER then
			-- Recipe matches request, get the category.

			local TEMPCATNAME = v.CategoryName;
			local blCATEXISTS = false;

			-- Check if the category exists already
			for a,b in pairs (_TEMPCATEGORIES) do

				if b == TEMPCATNAME then blCATEXISTS = true end;

			end

			-- If it doesn't exist insert into table
			if blCATEXISTS == false and TEMPCATNAME ~= nil then table.insert(_TEMPCATEGORIES,TEMPCATNAME) end;

			--Turbine.Shell.WriteLine(TIER .. " - " .. TEMPCATNAME);

		end
	end

	table.sort(_TEMPCATEGORIES); -- Sorts categories alphabetically.

	return _TEMPCATEGORIES;
end


function GetCategoryRecipes(GETRECPROFESSION,GETRECTIER,GETRECCATEGORY)

	if GETRECPROFESSION == nil or GETRECTIER == nil or GETRECCATEGORY == nil then
		local RETURNTABLE = {};
		return RETURNTABLE;
	end

	-- This function gets the recipe names and IDs from the selected GETRECCATEGORY and GETRECTIER.
	-- Returns the results in a sorted table

	local _TEMPCATRECIPES = {};

	local _CURRECIPES = _RECIPES[GETRECPROFESSION];

	for k,v in pairs (_CURRECIPES) do

		if v.Tier ~= nil and v.CategoryName ~= nil and v.Name ~= nil then

			if v.Tier == GETRECTIER and v.CategoryName == GETRECCATEGORY then
				-- Match so add to the table

				_TEMPCATRECIPES[k] = v.Name; -- k = Recipe ID in the recipe table, to be used later for easy searching.

			end

		end

	end

	return _TEMPCATRECIPES;
end


function ConvertProfessionValue(PROFESSIONINDEX)

	-- This function takes a value (e.g 4) and returns the string value of the profession (e.g. Jeweller)

	local RETURNSTRING = "";

	for k,v in pairs (Turbine.Gameplay.Profession) do

		if v == PROFESSIONINDEX then
			RETURNSTRING = k;
			break;
		end
	end

	return RETURNSTRING;

end


function GetProfessionID(PROFNAME)

	if PROFNAME == nil then return 0 end;

	local PROFID = 0;

	if Turbine.Gameplay.Profession[PROFNAME] ~= nil then PROFID = Turbine.Gameplay.Profession[PROFNAME] end;

	return PROFID;

end


function GetCraftTool()

	local EQUIPMENT = MYCHAR:GetEquipment();
	local CRAFTTOOL = EQUIPMENT:GetItem(Turbine.Gameplay.Equipment.CraftTool);
	local TOOLDESCRIPTION = CRAFTTOOL:GetItemInfo():GetDescription(); -- A collection of indispensable tools for jewellers, prospectors and cooks.

	return CRAFTTOOL;

end


function ExpandIcons(PARENT,EXPAND)

	if PARENT == nil then return end;
	if EXPAND == nil then EXPAND = true end;

	-- This function adjusts the expand icons for the controls child nodes to show all as expanded or collapsed.

	local BACKIMAGE = _IMAGES.ICONCOLLAPSE; -- Collapse Icon

	if EXPAND == false then
		BACKIMAGE = _IMAGES.ICONEXPAND; -- Expand Icon
	end


	-- Get the child nodes for the parent then change icon. Lastly recall the function on itself for each child
	-- node incase that also has an expand icon.


	-- Load the settings
	function GetParentsNodes()
		local TEST = PARENT:GetNodes();
	end

	if pcall(GetParentsNodes) then
		-- Loaded without error
		local _MATCHINGNODES = GetTreeNodes(PARENT:GetNodes(),true);

		if type(_MATCHINGNODES) == 'table' then

			for k,v in pairs (_MATCHINGNODES) do

				v:SetBackground(BACKIMAGE);

			end

		end

	else
		-- Loaded with errors
		function GetParentsChildNodes()
			local TEST = PARENT:GetChildNodes();
		end

		if pcall(GetParentsChildNodes) then
			-- Loaded without error
			local _MATCHINGNODES = GetTreeNodes(PARENT:GetChildNodes(),true);

			if type(_MATCHINGNODES) == 'table' then

			for k,v in pairs (_MATCHINGNODES) do

				v:SetBackground(BACKIMAGE);

			end

		end

		end

	end

end


function GetTreeNodes(CURNODELIST,IGNORENONEXPANDING)

	if IGNORENONEXPANDING == nil then IGNORENONEXPANDING = false end;

	local _MATCHINGCONTROLS = {};
	local _MATCHINGCHILDCONTROLS = {};
	local _RETURNTABLE = {};

	local CURNODECOUNT = CURNODELIST:GetCount();

	-- loop through each node, test its controls, then check for child nodes.
	for i=1, CURNODECOUNT do

		local CURNODE = CURNODELIST:Get(i);

		-- Check controls, and return the one that matches.
		_MATCHINGCONTROLS = GetChildControls(CURNODE:GetControls());

		if type(_MATCHINGCONTROLS) == 'table' then

			for k,v in pairs (_MATCHINGCONTROLS) do

				table.insert(_RETURNTABLE,v);

			end

		end

		-- check for child nodes.
		_MATCHINGCHILDCONTROLS = GetTreeNodes(CURNODE:GetChildNodes(),IGNORENONEXPANDING);

		if type(_MATCHINGCHILDCONTROLS) == 'table' then

			for k,v in pairs (_MATCHINGCHILDCONTROLS) do

				table.insert(_RETURNTABLE,v);

			end

		else -- No child nodes.. only get controls if IGNORENONEXPANDING is false.

			if IGNORENONEXPANDING == false then

				-- Check controls, and return the one that matches.
				_MATCHINGCONTROLS = GetChildControls(CURNODE:GetControls());

				if type(_MATCHINGCONTROLS) == 'table' then

					for k,v in pairs (_MATCHINGCONTROLS) do

						table.insert(_RETURNTABLE,v);

					end

				end

			end

		end

	end


	if _RETURNTABLE[1] == nil then
		return nil;
	else
		return _RETURNTABLE;
	end
end


function GetChildControls(CURCONTROLLIST)

	local _MATCHINGCONTROLS = {};
	local _MATCHINGCHILDCONTROLS = {};
	local _RETURNTABLE = {};

	local CURCONTROLCOUNT = CURCONTROLLIST:GetCount();

	-- Loop through each control to check if it matches, then also check for child controls.
	for i=1, CURCONTROLCOUNT do

		local CURCONTROL = CURCONTROLLIST:Get(i);

		-----------------------------------------------------------------------------------------------------------
		-- Test current control -----------------------------------------------------------------------------------

		local CURCONTROLBACKGROUND = CURCONTROL:GetBackground();


		if CURCONTROLBACKGROUND == _IMAGES.ICONEXPAND or CURCONTROLBACKGROUND == _IMAGES.ICONCOLLAPSE then

			if CURCONTROL:GetWidth() == 16 then
				table.insert(_MATCHINGCONTROLS,CURCONTROL);
			end
		end


		-- End of test --------------------------------------------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------

		-- Check for child controls
		_MATCHINGCHILDCONTROLS = GetChildControls(CURCONTROL:GetControls());

		if type(_MATCHINGCHILDCONTROLS) == 'table' then

			for k,v in pairs (_MATCHINGCHILDCONTROLS) do

				table.insert(_RETURNTABLE,v);

			end

		end

	end


	for k,v in pairs (_MATCHINGCONTROLS) do

		table.insert(_RETURNTABLE,v);

	end


	if _RETURNTABLE[1] == nil then
		return nil;
	else
		return _RETURNTABLE;
	end
end




