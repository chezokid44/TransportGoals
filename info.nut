require("version.nut");

class FTransportGoals extends GSInfo {
	function GetAuthor()		{ return "Chezokid"; }
	function GetName()			{ return "TransportGoals"; }
	function GetDescription() 	{ return "Goal: Have a high ratio of cargo delivered / vehicle"; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return "2025-08-17"; }
	function CreateInstance()	{ return "TransportGoals"; }
	function GetShortName()		{ return "CHTG"; }
	function GetAPIVersion()	{ return "14"; }
	function GetUrl()			{ return "https://github.com/chezokid44/TransportGoals"; }

	function GetSettings() {
		AddSetting({name = "log_level", description = "Debug: Log level (higher = print more)", easy_value = 1, medium_value = 1, hard_value = 1, custom_value = 1, flags = CONFIG_INGAME, min_value = 1, max_value = 3});
	}
}

RegisterGS(FTransportGoals());


