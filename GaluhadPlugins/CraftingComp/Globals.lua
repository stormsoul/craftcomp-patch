
SETTINGS = {}; -- Table used when loading settings.
_INVENTORY = {}; -- Table used to store craft inventory.
_SHOPPINGLIST = {};	-- Table used to store shopping list ingredientes.

MYCHAR = Turbine.Gameplay.LocalPlayer.GetInstance();
MYATTS = MYCHAR:GetAttributes();
MYNAME = MYCHAR:GetName();


_PROFESSIONSINFO = {};
_RECIPES = {};
_ALTRECIPES = {};
_wProfTabWins = {};
_tvRecipes = {};
_wRecipeView = {};
_BASEITEMSLIST = {};
_wRecipeInfo = {};
_RECIPELABELS = {};


XPTIERHEX = "FFFF00";
XPRECIPEHEX = "8BFF15";


GLOBALPROFESSION = "";
GLOBALRECIPEID = nil;
GLOBALRECIPENAME = "";
ORIGINALINGREDIENT = "";
ORIGINALTIER = true;
PLUGINNAME = "Crafting Companion";


-- Item categories to look out for
COMPONENT = Turbine.Gameplay.ItemCategory.Component;
INGREDIENT = Turbine.Gameplay.ItemCategory.Ingredient;
RESOURCE = Turbine.Gameplay.ItemCategory.Resource;
OPTIONALINGREDIENT = Turbine.Gameplay.ItemCategory.OptionalIngredient;
CRAFTINGTROPHY = Turbine.Gameplay.ItemCategory.CraftingTrophy;
REPUTATION = Turbine.Gameplay.ItemCategory.Reputation;
TROPHY = Turbine.Gameplay.ItemCategory.Trophy;

blSAVED = false;

SELECTEDBUTTON = 1;


SCREENWIDTH = Turbine.UI.Display.GetWidth();
SCREENHEIGHT = Turbine.UI.Display.GetHeight();

TRANSPARENT = Turbine.UI.Color(0,0,0,0); -- ARGB
WHITE = Turbine.UI.Color(1,1,1);
BLACK = Turbine.UI.Color(0,0,0);
GREEN = Turbine.UI.Color(0,1,0);
HDBLUE = Turbine.UI.Color(19/255,28/255,47/255);
HDBLUELT = Turbine.UI.Color(70/255,78/255,97/255);
YELLOW = Turbine.UI.Color(1,1,0);
YELLOW2 = Turbine.UI.Color(184/255,151/255,53/255);
RED = Turbine.UI.Color(1,0,0);
GREY = Turbine.UI.Color(0.1,0.1,0.1);
GREY2 = Turbine.UI.Color(0.5,0.5,0.5);
GREY3 = Turbine.UI.Color(0.3,0.3,0.3);
GREY4 = Turbine.UI.Color(0.8,0.8,0.8);
TEAL = Turbine.UI.Color(60/255,227/255,220/255);
BEIGE = Turbine.UI.Color(191/255,194/255,151/255);
PURPLE = Turbine.UI.Color(200/255,46/255,200/255);
LIGHTGREY = Turbine.UI.Color(0.3,0.3,0.3);
ORANGE = Turbine.UI.Color(247/255,148/255,29/255);
INGSUBCOLOR = Turbine.UI.Color.GreenYellow;
MIDALIGN = Turbine.UI.ContentAlignment.MiddleCenter;
RIGHTALIGN = Turbine.UI.ContentAlignment.MiddleRight;
LEFTALIGN = Turbine.UI.ContentAlignment.MiddleLeft;
TOPLEFT = Turbine.UI.ContentAlignment.TopLeft;
BOTTOMLEFT = Turbine.UI.ContentAlignment.BottomLeft;

BLEND_ALPHA = Turbine.UI.BlendMode.AlphaBlend;
BLEND_COLOR = Turbine.UI.BlendMode.Color;
BLEND_GRAYSCALE = Turbine.UI.BlendMode.Grayscale;
BLEND_MULTIPLY = Turbine.UI.BlendMode.Multiply;
BLEND_NONE = Turbine.UI.BlendMode.None;
BLEND_NORMAL = Turbine.UI.BlendMode.Normal;
BLEND_OVERLAY = Turbine.UI.BlendMode.Overlay;
BLEND_SCREEN = Turbine.UI.BlendMode.Screen;

TrajanPro18 = Turbine.UI.Lotro.Font.TrajanPro18;
TrajanPro16 = Turbine.UI.Lotro.Font.TrajanPro16;
TrajanPro15 = Turbine.UI.Lotro.Font.TrajanPro15;
TrajanPro14 = Turbine.UI.Lotro.Font.TrajanPro14;
TrajanPro13 = Turbine.UI.Lotro.Font.TrajanPro13;
Verdana12 = Turbine.UI.Lotro.Font.Verdana12;
Verdana14 = Turbine.UI.Lotro.Font.Verdana14;
Verdana16 = Turbine.UI.Lotro.Font.Verdana16;
Arial12 = Turbine.UI.Lotro.Font.Arial12;


-- Random Variables
blDRAGGING = false;
relX = 0;
relY = 0;

-- Detect client lang.
CLIENTLANG = "ENGLISH";
if Turbine.Shell.IsCommand("hilfe") then
	CLIENTLANG = "GERMAN";
elseif Turbine.Shell.IsCommand("aide") then
	CLIENTLANG = "FRENCH";
elseif Turbine.Shell.IsCommand("плагины") then
	CLIENTLANG = "RUSSIAN";
end

-- Default Settings
DEFAULT_SETTINGS =
	{
	["LANGUAGE"] = CLIENTLANG;
	["MSGCOLOR"] = "FFFFFF";
	["SHOWSCREEN"] = true;

	["GUILD"] = "";

	["CRITVIEW"] =
		{
		["BASETOP"] = 315; -- SETTINGS.CRITVIEW.BASETOP
		};

	["NONCRITVIEW"] =
		{
		["BASETOP"] = 255; -- SETTINGS.NONCRITVIEW.BASETOP
		};

	["MAINWIN"] =
		{
		["VISIBLE"] = true;
		["X"] = (SCREENWIDTH/2)-400;
		["Y"] = (SCREENHEIGHT/2)-290;
		};

	["ALTSWINDOW"] =
		{
		["X"] = (SCREENWIDTH/2)-(300/2);
		["Y"] = (SCREENHEIGHT/2)-(400/2);
		};

	["SHOPPINGLIST"] =
		{
		["X"] = (SCREENWIDTH/2)-(470/2);
		["Y"] = (SCREENHEIGHT/2)-(400/2);
		};

	["INVENTORY"] =
		{
		["X"] = (SCREENWIDTH/2)-225;
		["Y"] = SCREENHEIGHT/3;
		};

	["GUILDWIN"] =
		{
		["X"] = (SCREENWIDTH/2)-225;
		["Y"] = SCREENHEIGHT/3;
		};

	};

