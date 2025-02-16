-- Turbine Imports..
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

-- Plugin Imports..
import "GaluhadPlugins.CraftingComp.AddCallBack";
import "GaluhadPlugins.CraftingComp.VindarPatch";
import "GaluhadPlugins.CraftingComp.UTF";
import "GaluhadPlugins.CraftingComp.KeyEvents";
import "GaluhadPlugins.CraftingComp.GeneralFunctions";
import "GaluhadPlugins.CraftingComp.Globals";
import "GaluhadPlugins.CraftingComp.CraftFunctions";
import "GaluhadPlugins.CraftingComp.Images";
import "GaluhadPlugins.CraftingComp.Strings";
import "GaluhadPlugins.CraftingComp.Onscreen";
import "GaluhadPlugins.CraftingComp.Tooltip";
import "GaluhadPlugins.CraftingComp.NewToolTip";
import "GaluhadPlugins.CraftingComp.MessageBox";
import "GaluhadPlugins.CraftingComp.DropDown";
import "GaluhadPlugins.CraftingComp.ChatLogger";
import "GaluhadPlugins.CraftingComp.Data.Guilds";
import "GaluhadPlugins.CraftingComp.Data.Recipes";
import "GaluhadPlugins.CraftingComp.Data.XP";
import "GaluhadPlugins.CraftingComp.Inventory";

-- Windows --
import "GaluhadPlugins.CraftingComp.MainWin";
import "GaluhadPlugins.CraftingComp.InventoryWin";
import "GaluhadPlugins.CraftingComp.GuildWin";
import "GaluhadPlugins.CraftingComp.ShoppingList";
import "GaluhadPlugins.CraftingComp.AltsWin";

-- Other imports --
import "GaluhadPlugins.CraftingComp.Commands";



-----------------------------------------------------------------------------------------------------------

function saveData()

	_ALTRECIPES[MYNAME] = RecipeDump();

	-- Store the settings table.
	PatchDataSave(Turbine.DataScope.Character, "CraftingComp_Settings", SETTINGS);
	PatchDataSave(Turbine.DataScope.Server, "CraftingComp_Inv", _INVENTORY);
	PatchDataSave(Turbine.DataScope.Server, "CraftingComp_Professions", _PROFESSIONSINFO);
	PatchDataSave(Turbine.DataScope.Server, "CraftingComp_ShoppingList", _SHOPPINGLIST);
	PatchDataSave(Turbine.DataScope.Server, "CraftingComp_Recipes", _ALTRECIPES);


end


-- This function prepares the character recipes for sharing..
function RecipeDump()

	local _TEMPRECIPES = {};

	for k,v in pairs (_PROFESSIONSINFO[MYNAME]) do	-- loops through profession titles, e.g. weaponsmith, cook.

		-- Loop through each recipe for the given profession and add to table.
		for a,b in pairs (_RECIPES[k]) do

			if _TEMPRECIPES[k] == nil then _TEMPRECIPES[k] = {} end;
			if _TEMPRECIPES[k][b.Tier] == nil then _TEMPRECIPES[k][b.Tier] = {} end;
			if _TEMPRECIPES[k][b.Tier][b.CategoryName] == nil then _TEMPRECIPES[k][b.Tier][b.CategoryName] = {} end;
			if _TEMPRECIPES[k][b.Tier][b.CategoryName][a] == nil then _TEMPRECIPES[k][b.Tier][b.CategoryName][a] = {} end;

			local _TEMPCURRECIPE = _TEMPRECIPES[k][b.Tier][b.CategoryName][a];

			_TEMPCURRECIPE["Name"] = b.Name;
			_TEMPCURRECIPE["IsKnown"] = b.IsKnown;
			_TEMPCURRECIPE["ExperienceReward"] = b.ExperienceReward;
			_TEMPCURRECIPE["Cooldown"] = b.Cooldown;
			_TEMPCURRECIPE["IsSingleUse"] = b.IsSingleUse;
			_TEMPCURRECIPE["IMAGE"] = b.ResultItemInfo:GetIconImageID();
			_TEMPCURRECIPE["BACKIMAGE"] = b.ResultItemInfo:GetBackgroundImageID();
			_TEMPCURRECIPE["QUALITY"] = b.ResultItemInfo:GetQuality();

			_TEMPCURRECIPE["Ingredients"] = {};

			local _TEMPINGREDIENTS = _TEMPCURRECIPE["Ingredients"];

			local INGCOUNT = 0;

			for c,d in pairs (b.Ingredients) do

				INGCOUNT = INGCOUNT + 1;

				_TEMPINGREDIENTS[INGCOUNT] = {};

				_TEMPINGREDIENTS[INGCOUNT]["Name"] = d.Name;
				_TEMPINGREDIENTS[INGCOUNT]["RequiredQuantity"] = d.RequiredQuantity;
				_TEMPINGREDIENTS[INGCOUNT]["IMAGE"] = d.ItemInfo:GetIconImageID();
				_TEMPINGREDIENTS[INGCOUNT]["BACKIMAGE"] = d.ItemInfo:GetBackgroundImageID();

			end

		end

	end

	return _TEMPRECIPES;
end


-------------------------------------------------------------------------------------------------------------------------------------

function loadData()

	---------------------------------------------------------------------------------------------------------------------------------

	-- SAVED SETTINGS --

	local SavedSettings = {};

	-- Load the settings
	function GetSavedSettings()
		SavedSettings = PatchDataLoad(Turbine.DataScope.Character, "CraftingComp_Settings");
	end

	if pcall(GetSavedSettings) then
		-- Loaded without error
		SavedSettings = PatchDataLoad(Turbine.DataScope.Character, "CraftingComp_Settings");
	else
		-- Loaded with errors
		SavedSettings = nil;
		Turbine.Shell.WriteLine(_LANG.SETTINGSLOADERROR[SETTINGS.LANGUAGE]);
	end


	-- Check the saved settings to make sure it is still compatible with newer updates, add in any missing default settings
	if type(SavedSettings) == 'table' then

		local tempSETTINGS = {};
		tempSETTINGS = deepcopy(DEFAULT_SETTINGS);

		SETTINGS = mergeTables(tempSETTINGS,SavedSettings);

	else

		SETTINGS = deepcopy(DEFAULT_SETTINGS);

	end

	SavedSettings = nil;

	----------------------------------------------------------------------------------------------------------------------------------

	-- SAVED INVENTORY --

	local SavedInventory = {};

	-- Load the settings
	function GetSavedInventory()
		SavedInventory = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_Inv");
	end

	if pcall(GetSavedInventory) then
		-- Loaded without error
		SavedInventory = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_Inv");
	else
		-- Loaded with errors
		SavedInventory = nil;
		Turbine.Shell.WriteLine(_LANG.INVLOADERROR[SETTINGS.LANGUAGE]);
	end


	-- Check the saved settings to make sure it is still compatible with newer updates, add in any missing default settings
	if type(SavedInventory) == 'table' then
		_INVENTORY = deepcopy(SavedInventory);
	else
		_INVENTORY = {};
	end

	SavedInventory = nil;

	----------------------------------------------------------------------------------------------------------------------------------


	-- SAVED PROFESSIONS --

	local SavedProfessions = {};

	-- Load the settings
	function GetSavedProfessions()
		SavedProfessions = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_Professions");
	end

	if pcall(GetSavedProfessions) then
		-- Loaded without error
		SavedProfessions = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_Professions");
	else
		-- Loaded with errors
		SavedProfessions = nil;
	end


	-- Check the saved settings to make sure it is still compatible with newer updates, add in any missing default settings
	if type(SavedProfessions) == 'table' then
		_PROFESSIONSINFO = deepcopy(SavedProfessions);
	else
		_PROFESSIONSINFO = {};
	end

	SavedProfessions = nil;

	----------------------------------------------------------------------------------------------------------------------------------

	-- SAVED SHOPPING LIST --

	local SavedShoppingList = {};

	-- Load the settings
	function GetSavedShoppingList()
		SavedShoppingList = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_ShoppingList");
	end

	if pcall(GetSavedShoppingList) then
		-- Loaded without error
		SavedShoppingList = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_ShoppingList");
	else
		-- Loaded with errors
		SavedShoppingList = nil;
	end


	-- Check the saved settings to make sure it is still compatible with newer updates, add in any missing default settings
	if type(SavedShoppingList) == 'table' then
		_SHOPPINGLIST = deepcopy(SavedShoppingList);
	else
		_SHOPPINGLIST = {};
	end

	SavedShoppingList = nil;

	----------------------------------------------------------------------------------------------------------------------------------

	-- SAVED RECIPE LIST --

	local SavedRecipeList = {};

	-- Load the settings
	function GetSavedRecipeList()
		SavedRecipeList = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_Recipes");
	end

	if pcall(GetSavedRecipeList) then
		-- Loaded without error
		SavedRecipeList = PatchDataLoad(Turbine.DataScope.Server, "CraftingComp_Recipes");
	else
		-- Loaded with errors
		SavedRecipeList = nil;
	end


	-- Check the saved settings to make sure it is still compatible with newer updates, add in any missing default settings
	if type(SavedRecipeList) == 'table' then
		_ALTRECIPES = deepcopy(SavedRecipeList);
	else
		_ALTRECIPES = {};
	end

	SavedRecipeList = nil;

	----------------------------------------------------------------------------------------------------------------------------------

end


function DrawWindows()

	CreateDesktopIcon(_IMAGES.MAINICON);

	DrawMainWin();
	DrawInvWin();
	DrawGuildWin();
	DrawAltsWin();
	DrawShoppingListWindow();
	DrawAltRecipeWin();

end


Turbine.Plugin.Unload = function (sender, args)
	-- Save the data when the plugin unloads.
	saveData();
end


function PluginMessage(Message)
	local CURTIME = Turbine.Engine.GetDate();
	local CURMINUTE = CURTIME.Minute;
	if CURMINUTE < 10 then CURMINUTE = "0" .. CURMINUTE end;

	--Turbine.Shell.WriteLine("<rgb=#" .. SETTINGS.MSGCOLOR .. ">" .. _LANG.PLUGINNAME[SETTINGS.LANGUAGE] .. ": " .. Message .. ".</rgb>");
	Turbine.Shell.WriteLine("<rgb=#FFFF88>" .. CURTIME.Hour .. ":" .. CURMINUTE .. " - " .. _LANG.PLUGINNAME[SETTINGS.LANGUAGE] .. ": " .. Message .. ".</rgb>");
end


function checkTierUpdates()
	local highestCharTier = 0;
	for k,v in pairs (_PROFESSIONSINFO[MYNAME]) do
		if v["ProficiencyLevel"] > highestCharTier then highestCharTier = v["ProficiencyLevel"] end;
	end
	if Data._MASTERYXP[highestCharTier] == nil then
		Turbine.Shell.WriteLine("<rgb=#00FF7F>" .. _LANG.TIERUPDATE[SETTINGS.LANGUAGE] .. "</rgb>");
	end;
end


Debug("Crafting Companion v" .. Plugins["Crafting Companion"]:GetVersion() .. " by Galuhad [Evernight]");

-- Initiate load sequence
loadData();
--Turbine.Shell.WriteLine("loadData() Ok.");
InitiateChatLogger();
--Turbine.Shell.WriteLine("InitiateChatLogger() Ok.");
GetMaxGameCraftTier();

ConstructProfessionTables();
--Turbine.Shell.WriteLine("ConstructProfessionTables() Ok.");
MergeRecipeTables();
--Turbine.Shell.WriteLine("MergeRecipeTables() Ok.");
DrawWindows();
--Turbine.Shell.WriteLine("DrawWindows() Ok.");
RegisterCommands();
--Turbine.Shell.WriteLine("RegisterCommands() Ok.");
GetBackpackInv();
--Turbine.Shell.WriteLine("GetBackpackInv() Ok.");
GetVaultInv();
--Turbine.Shell.WriteLine("GetVaultInv() Ok.");
GetSharedInv();
--Turbine.Shell.WriteLine("GetSharedInv() Ok.");
checkTierUpdates();


if wMainWinParent:IsVisible() == true then
	Turbine.Shell.WriteLine("<rgb=#FFFF88>" .. _LANG.PLUGLOADED[SETTINGS.LANGUAGE] .. "</rgb>");
else
	Turbine.Shell.WriteLine("<rgb=#FFFF88>" .. _LANG.PLUGLOADED[SETTINGS.LANGUAGE] .. "</rgb>");
	Turbine.Shell.WriteLine("<rgb=#FFFF88>" .. _LANG.COMMANDWARNING[SETTINGS.LANGUAGE] .. "</rgb>");
end



