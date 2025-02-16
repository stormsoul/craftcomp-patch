

function RegisterCommands()

	---------------------------------------------------------------------------------------------

	-- COMMAND TO DISPLAY / HIDE THE MAIN WINDOW.
	cmdMainWin = Turbine.ShellCommand();

	function cmdMainWin:Execute( command, arguments )

		if wMainWinParent:IsVisible() == false then
			wMainWinParent:SetVisible(true);
			SETTINGS.MAINWIN.VISIBLE = true;
		else
			wMainWinParent:SetVisible(false);
			SETTINGS.MAINWIN.VISIBLE = false;
		end
	end

	function cmdMainWin:GetHelp()
		return "Crafting Companion: Shows/hides the main window.";
	end

	function cmdMainWin:GetShortHelp()
		return "Crafting Companion: Shows/hides the main window.";
	end

	Turbine.Shell.AddCommand( "craftcomp", cmdMainWin);

	---------------------------------------------------------------------------------------------


end





