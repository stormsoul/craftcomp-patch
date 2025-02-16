
-- Chat log filter.
-- Controls chat messages and actions the appropriate functions based on the message.

function InitiateChatLogger()

	CHATLOG = Turbine.Chat;
	CHATLOG.Received = function (sender, args)

	local tempMessage = tostring(args.Message);

		if args.ChatType == Turbine.ChatType.Standard then
			FilterStandard(tempMessage);
		end

	end
end


function FilterStandard(cMessage)
-- Filters here for use with the combat channel.


	if string.find(cMessage,_LANG.CHATLOG.NEWRECIPE[SETTINGS.LANGUAGE]) ~= nil then
		--GetNewRecipe(cMessage);
	end

end



function GetNewRecipe(cMessage) -- Currently not used as the recipe API doesn't update when new recipes are learned.

	-- New recipe message, extract the profession.
	local RECIPEPROFESSION = "";

	for k,v in pairs (_LANG.CHATLOG.PROFESSIONS) do

		if string.find(cMessage,v[SETTINGS.LANGUAGE],-20) ~= nil then

			RECIPEPROFESSION = k;

			-- Update recipes.
			GetMyRecipes(RECIPEPROFESSION,true);
			RefreshRecipeList(RECIPEPROFESSION);
			break;

		end
	end
end
