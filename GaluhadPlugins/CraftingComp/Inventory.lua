
BACKPACK = MYCHAR:GetBackpack();
VAULT = MYCHAR:GetVault();
SHAREDSTORAGE = MYCHAR:GetSharedStorage();


wBACKPACKREFRESH = Turbine.UI.Control();
wBACKPACKREFRESH:SetSize(1,1);

wBACKPACKREFRESH.Update = function (sender,args)

	wBACKPACKREFRESH:SetWantsUpdates(false);
	GetBackpackInv();
	UpdateRecipeIngredientsInventory(GLOBALREMOVEITEM);
	if wShoppingListWin:IsVisible() == true then RefreshShoppingList() end;

end


-- Vault availability listener -------------
VAULT.IsAvailableChanged = function (sender, args)
	if VAULT:IsAvailable() == true then
		GetVaultInv();
	end
end

SHAREDSTORAGE.IsAvailableChanged = function (sender, args)
	if SHAREDSTORAGE:IsAvailable() == true then
		GetSharedInv();
	end
end

-- Inventory changes listeners -------------

VAULT.CountChanged = function (sender, args)
	if VAULT:IsAvailable() == true then
		GetVaultInv();
	end
end

SHAREDSTORAGE.CountChanged = function (sender, args)
	if SHAREDSTORAGE:IsAvailable() == true then
		GetSharedInv();
	end
end

BACKPACK.ItemAdded = function (sender, args)
	--GetBackpackInv();
	UpdateRecipeIngredientsInventory(args.Item);
	if wShoppingListWin:IsVisible() == true then RefreshShoppingList() end;
end

BACKPACK.ItemRemoved = function (sender, args) -- seems to be some delay in this event
	GLOBALREMOVEITEM = BACKPACK:GetItem(args.Index);
	wBACKPACKREFRESH:SetWantsUpdates(true);
end


---------------------------------------------



function UpdateRecipeIngredientsInventory(NEWITEM)

	local NEWITEMNAME = NEWITEM:GetName();

	if type (_INGREDIENTLIST) == 'table' then

		for k,v in pairs (_INGREDIENTLIST) do

			if v.NAME == NEWITEMNAME then

				local NEWQTY = txtRecipeQty:GetText();

				if NEWQTY == "" then NEWQTY = 1 end;

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

			end

		end

	end

end



function GetBackpackInv()

	-- MAKE THIS SO IT ONLY UPDATES WHEN THE PLUGIN WINDOWS ARE PHYSICALLY OPEN?

	--_INVENTORY = nil;  -- DELETE AFTER TESTING --
	--_INVENTORY = {}; -- DELETE AFTER TESTING --

	ResetBackPackInv(); -- Set's the backpack quantities for all items on this character to zero.


	-- Get's the Guild table relative to the players craft guild and stores it in a new table.
	_RELGUILDDATA = {};
	_RELGUILDDATA = deepcopy(Data._GUILDDATA[SETTINGS.GUILD]);

	--Turbine.Shell.WriteLine(dump(_RELGUILDDATA));

	_TEMPBACKPACK = nil;
	local _TEMPBACKPACK = {};

	-- Loop through the backpack looking for items related to crafting
	for i=1, BACKPACK:GetSize() do

		local TEMPITEM = BACKPACK:GetItem(i);

		if TEMPITEM ~= nil then -- Ignore empty bag space

			-- Qty changed event listener:
			TEMPITEM.QuantityChanged = function (sender,args)
				GetBackpackInv();
				UpdateRecipeIngredientsInventory(TEMPITEM);
			end

			local TEMPCATEGORY = TEMPITEM:GetCategory();

			-- Filter out irrelevant item categories so only those related to crafting will be processed
			if TEMPCATEGORY == COMPONENT or TEMPCATEGORY == TROPHY or TEMPCATEGORY == INGREDIENT or TEMPCATEGORY == RESOURCE or TEMPCATEGORY == OPTIONALINGREDIENT or TEMPCATEGORY == CRAFTINGTROPHY or TEMPCATEGORY == REPUTATION then

				local TEMPNAME = TEMPITEM:GetName();
				local TEMPQTY = TEMPITEM:GetQuantity();
				local TEMPIMAGE = TEMPITEM:GetIconImageID();
				local TEMPBACKIMAGE = TEMPITEM:GetBackgroundImageID();

				-- Store items in _TEMPBACKPACK table to check for multiple stacks, then copy that to the main _INVENTORY table
				-- Check if current item exists, if not add it, otherwise add the quantity.

				if _TEMPBACKPACK[TEMPNAME] == nil then
					-- Does not exist
					local _TEMPITEMINV = {};
					_TEMPITEMINV["CAT"] = TEMPCATEGORY;
					_TEMPITEMINV["IMAGE"] = TEMPIMAGE;
					_TEMPITEMINV["BACKIMAGE"] = TEMPBACKIMAGE;
					_TEMPITEMINV["QTY"] = TEMPQTY;

					_TEMPBACKPACK[TEMPNAME] = deepcopy(_TEMPITEMINV);
				else
					-- Does exist
					local _TEMPITEMINV = _TEMPBACKPACK[TEMPNAME];
					_TEMPITEMINV["QTY"] = _TEMPITEMINV["QTY"] + TEMPQTY;
				end

			end

		end

	end

	-- Loop through the _TEMPBACKPACK table and copy quantities across to the _INVENTORY table.

	for k,v in pairs (_TEMPBACKPACK) do

		-- load the current item into variables
		local TEMPNAME = k;

		local TEMPQTY = _TEMPBACKPACK[k].QTY;
		local TEMPIMAGE = _TEMPBACKPACK[k].IMAGE;
		local TEMPCATEGORY = _TEMPBACKPACK[k].CAT;
		local TEMPBACKIMAGE = _TEMPBACKPACK[k].BACKIMAGE;


		-- Check the _INVENTORY table to see if the item already exists.
		if _INVENTORY[TEMPNAME] ~= nil then
			-- Exists so loop through and check the total.

			local _TEMPITEMINV = _INVENTORY[TEMPNAME];
			local _TEMPINVAREAS = _TEMPITEMINV["AREAS"];

			if type(_TEMPINVAREAS[MYNAME]) == 'table' then

				local _TEMPMYINV = _TEMPINVAREAS[MYNAME];

				-- Check if the quantity has changed, if so update
				if _TEMPMYINV["BACKPACK"] ~= TEMPQTY then
					_TEMPMYINV["BACKPACK"] = TEMPQTY;
				end

			else

				-- Table does not exist for this character name
				_TEMPINVAREAS[MYNAME] =
					{
					["BACKPACK"] = TEMPQTY;
					["VAULT"] = 0;
					};

			end

		else
			-- Doesn't exist so create a new entry for this item.

			local _TEMPITEMINV = {};
			_TEMPITEMINV["CAT"] = TEMPCATEGORY;
			_TEMPITEMINV["IMAGE"] = TEMPIMAGE;
			_TEMPITEMINV["BACKIMAGE"] = TEMPBACKIMAGE;

			_TEMPITEMINV["AREAS"] =
				{
				[MYNAME] =
					{
					["BACKPACK"] = TEMPQTY;
					["VAULT"] = 0;
					};
				};

			_INVENTORY[TEMPNAME] = deepcopy(_TEMPITEMINV);

		end

	end

	_TEMPBACKPACK = nil;
	UpdateDisplays();

end


function GetVaultInv()

	-- Only process this if vault is available..
	if VAULT:IsAvailable() == true then

		ResetVaultInv();

		_TEMPVAULT = nil;
		local _TEMPVAULT = {};
		local ITEMCOUNT = 0;

		-- Loop through the vault looking for items related to crafting
		for i=1, VAULT:GetCount() do

			local TEMPITEM = VAULT:GetItem(i);
			local ITEMINFO = TEMPITEM:GetItemInfo();

			if TEMPITEM ~= nil then -- Ignore empty vault space

				local TEMPNAME = TEMPITEM:GetName();
				local TEMPCATEGORY = ITEMINFO:GetCategory();

				-- Filter out irrelevant item categories so only those related to crafting will be processed
				if TEMPCATEGORY == COMPONENT or TEMPCATEGORY == TROPHY or TEMPCATEGORY == INGREDIENT or TEMPCATEGORY == RESOURCE or TEMPCATEGORY == OPTIONALINGREDIENT or TEMPCATEGORY == CRAFTINGTROPHY or TEMPCATEGORY == REPUTATION then

					local TEMPNAME = TEMPITEM:GetName();
					local TEMPQTY = TEMPITEM:GetQuantity();
					local TEMPIMAGE = ITEMINFO:GetIconImageID();
					local TEMPBACKIMAGE = ITEMINFO:GetBackgroundImageID();

					-- Store items in _TEMPVAULT table to check for multiple stacks, then copy that to the main _INVENTORY table
					-- Check if current item exists, if not add it, otherwise add the quantity.

					if _TEMPVAULT[TEMPNAME] == nil then
						-- Does not exist
						local _TEMPITEMINV = {};
						_TEMPITEMINV["CAT"] = TEMPCATEGORY;
						_TEMPITEMINV["IMAGE"] = TEMPIMAGE;
						_TEMPITEMINV["BACKIMAGE"] = TEMPBACKIMAGE;
						_TEMPITEMINV["QTY"] = TEMPQTY;

						_TEMPVAULT[TEMPNAME] = deepcopy(_TEMPITEMINV);
					else
						-- Does exist
						local _TEMPITEMINV = _TEMPVAULT[TEMPNAME];
						_TEMPITEMINV["QTY"] = _TEMPITEMINV["QTY"] + TEMPQTY;
					end

					ITEMCOUNT = ITEMCOUNT + 1;

				end

			end

		end

		-- Loop through the _TEMPVAULT table and copy quantities across to the _INVENTORY table.

		for k,v in pairs (_TEMPVAULT) do

			-- load the current item into variables
			local TEMPNAME = k;

			local TEMPQTY = _TEMPVAULT[k].QTY;
			local TEMPIMAGE = _TEMPVAULT[k].IMAGE;
			local TEMPCATEGORY = _TEMPVAULT[k].CAT;
			local TEMPBACKIMAGE = _TEMPVAULT[k].BACKIMAGE;


			-- Check the _INVENTORY table to see if the item already exists.
			if _INVENTORY[TEMPNAME] ~= nil then
				-- Exists so loop through and check the total.

				local _TEMPITEMINV = _INVENTORY[TEMPNAME];
				local _TEMPINVAREAS = _TEMPITEMINV["AREAS"];

				if type(_TEMPINVAREAS[MYNAME]) == 'table' then

					local _TEMPMYINV = _TEMPINVAREAS[MYNAME];

					_TEMPMYINV["VAULT"] = TEMPQTY;

				else

					-- Table does not exist for this character name
					_TEMPINVAREAS[MYNAME] =
						{
						["BACKPACK"] = 0;
						["VAULT"] = TEMPQTY;
						};

				end

			else
				-- Doesn't exist so create a new entry for this item.

				local _TEMPITEMINV = {};
				_TEMPITEMINV["CAT"] = TEMPCATEGORY;
				_TEMPITEMINV["IMAGE"] = TEMPIMAGE;
				_TEMPITEMINV["BACKIMAGE"] = TEMPBACKIMAGE;

				_TEMPITEMINV["AREAS"] =
					{
					[MYNAME] =
						{
						["BACKPACK"] = 0;
						["VAULT"] = TEMPQTY;
						};
					};

				_INVENTORY[TEMPNAME] = deepcopy(_TEMPITEMINV);

			end

		end

		_TEMPVAULT = nil;
		UpdateDisplays();

	end
end


function GetSharedInv()

	-- Only process this if shared is available..
	if SHAREDSTORAGE:IsAvailable() == true then

		ResetSharedInv();

		_TEMPSHARED = nil;
		local _TEMPSHARED = {};

		-- Loop through the shared storage looking for items related to crafting
		for i=1, SHAREDSTORAGE:GetCount() do

			local TEMPITEM = SHAREDSTORAGE:GetItem(i);
			local ITEMINFO = TEMPITEM:GetItemInfo();

			if TEMPITEM ~= nil then -- Ignore empty vault space

				local TEMPNAME = TEMPITEM:GetName();
				local TEMPCATEGORY = ITEMINFO:GetCategory();

				-- Filter out irrelevant item categories so only those related to crafting will be processed
				if TEMPCATEGORY == COMPONENT or TEMPCATEGORY == TROPHY or TEMPCATEGORY == INGREDIENT or TEMPCATEGORY == RESOURCE or TEMPCATEGORY == OPTIONALINGREDIENT or TEMPCATEGORY == CRAFTINGTROPHY or TEMPCATEGORY == REPUTATION then

					local TEMPNAME = TEMPITEM:GetName();
					local TEMPQTY = TEMPITEM:GetQuantity();
					local TEMPIMAGE = ITEMINFO:GetIconImageID();
					local TEMPBACKIMAGE = ITEMINFO:GetBackgroundImageID();

					-- Store items in _TEMPSHARED table to check for multiple stacks, then copy that to the main _INVENTORY table
					-- Check if current item exists, if not add it, otherwise add the quantity.

					if _TEMPSHARED[TEMPNAME] == nil then
						-- Does not exist
						local _TEMPITEMINV = {};
						_TEMPITEMINV["CAT"] = TEMPCATEGORY;
						_TEMPITEMINV["IMAGE"] = TEMPIMAGE;
						_TEMPITEMINV["BACKIMAGE"] = TEMPBACKIMAGE;
						_TEMPITEMINV["QTY"] = TEMPQTY;

						_TEMPSHARED[TEMPNAME] = deepcopy(_TEMPITEMINV);
					else
						-- Does exist
						local _TEMPITEMINV = _TEMPSHARED[TEMPNAME];
						_TEMPITEMINV["QTY"] = _TEMPITEMINV["QTY"] + TEMPQTY;
					end

				end

			end

		end

		-- Loop through the _TEMPSHARED table and copy quantities across to the _INVENTORY table.

		for k,v in pairs (_TEMPSHARED) do

			-- load the current item into variables
			local TEMPNAME = k;

			local TEMPQTY = _TEMPSHARED[k].QTY;
			local TEMPIMAGE = _TEMPSHARED[k].IMAGE;
			local TEMPCATEGORY = _TEMPSHARED[k].CAT;
			local TEMPBACKIMAGE = _TEMPSHARED[k].BACKIMAGE;

			-- Check the _INVENTORY table to see if the item already exists.
			if _INVENTORY[TEMPNAME] ~= nil then
				-- Exists so loop through and check the total.

				local _TEMPITEMINV = _INVENTORY[TEMPNAME];
				local _TEMPINVAREAS = _TEMPITEMINV["AREAS"];

				_TEMPINVAREAS["Shared Storage"] = TEMPQTY;

			else
				-- Doesn't exist so create a new entry for this item.

				local _TEMPITEMINV = {};
				_TEMPITEMINV["CAT"] = TEMPCATEGORY;
				_TEMPITEMINV["IMAGE"] = TEMPIMAGE;
				_TEMPITEMINV["BACKIMAGE"] = TEMPBACKIMAGE;

				_TEMPITEMINV["AREAS"] =
					{
					["Shared Storage"] = TEMPQTY;
					};

				_INVENTORY[TEMPNAME] = deepcopy(_TEMPITEMINV);

			end
		end

		_TEMPSHARED = nil;
		UpdateDisplays();

	end
end


function ResetBackPackInv()

	-- This function loops through the _INVENTORY table and resets the Backpack values to zero..
	-- Function is used before GetBackpackInv() refreshes the quantites in inventory, this helps eliminate items that have been removed since the plugin last ran.

	for k,v in pairs (_INVENTORY) do

		local TEMPNAME = k;
		local _TEMPITEMINV = _INVENTORY[TEMPNAME];
		local _TEMPAREAS = _TEMPITEMINV["AREAS"];

		if _TEMPAREAS[MYNAME] ~= nil then
			_TEMPAREAS[MYNAME].BACKPACK = 0;
		end
	end

end


function ResetVaultInv()

	-- This function loops through the _INVENTORY table and resets the Vault values to zero..
	-- Function is used before GetVaultInv() refreshes the quantites in inventory, this helps eliminate items that have been removed since the plugin last ran.

	for k,v in pairs (_INVENTORY) do

		local TEMPNAME = k;
		local _TEMPITEMINV = _INVENTORY[TEMPNAME];
		local _TEMPAREAS = _TEMPITEMINV["AREAS"];

		if _TEMPAREAS[MYNAME] ~= nil then
			_TEMPAREAS[MYNAME].VAULT = 0;
		end
	end

end


function ResetSharedInv()

	-- This function loops through the _INVENTORY table and resets the Vault values to zero..
	-- Function is used before GetVaultInv() refreshes the quantites in inventory, this helps eliminate items that have been removed since the plugin last ran.

	for k,v in pairs (_INVENTORY) do

		local TEMPNAME = k;
		local _TEMPITEMINV = _INVENTORY[TEMPNAME];
		local _TEMPAREAS = _TEMPITEMINV["AREAS"];

		if _TEMPAREAS["Shared Storage"] ~= nil then
			_TEMPAREAS["Shared Storage"] = 0;
		end
	end

end


function UpdateDisplays()

	if wWishlistWin:IsVisible() == true then
		RefreshWL();
	end
	--RefreshRecipeView(GLOBALPROFESSION,GLOBALRECIPEID);

end


function GetItemInventoryCount(ITEMNAME)

	-- This function checks for a given ITEMNAME in the inventory table and returns the quantity.
	if ITEMNAME == nil then return 0 end;

	local ITEMQTY = 0;

	-- Loop through _INVENTORY table checking for matches.
	for k,v in pairs (_INVENTORY) do

		if k == ITEMNAME then

			-- Match - Get total quantity amongst all alts.
			local _AREAS = v.AREAS;

			for a,b in pairs (_AREAS) do

				if a == "Shared Storage" then

					ITEMQTY = ITEMQTY + b;

				else

					for c,d in pairs (b) do
						ITEMQTY = ITEMQTY + d;
					end

				end
			end
			break;
		end
	end

	return ITEMQTY;

end
