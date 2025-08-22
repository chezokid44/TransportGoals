
require("version.nut");

class FTransportGoals extends GSInfo {
	function GetAuthor()		{ return "Chezokid"; }
	function GetName()			{ return "Transport Goals v1.5"; }
	function GetDescription() 	{ return "Goal: Have a high ratio of cargo delivered / vehicle"; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return "2025-08-17"; }
	function CreateInstance()	{ return "TransportGoals"; }
	function GetShortName()		{ return "CHTG"; }
	function GetAPIVersion()	{ return "14"; }
	function GetUrl()			{ return ""; }

	function GetSettings() {
		//AddSetting({name = "log_level", description = "Debug: Log level (higher = print more)", easy_value = 1, medium_value = 1, hard_value = 1, custom_value = 1, flags = CONFIG_INGAME, min_value = 1, max_value = 3});
		AddSetting({name = "by_cargo_type",	description = "Enable goals for each cargo type", default_value = 0, flags = CONFIG_NONE | CONFIG_BOOLEAN });
		AddSetting({name = "goal_step_size", description = "Goal step size", easy_value = 1, medium_value = 5, hard_value = 10, custom_value = 5, flags = CONFIG_NONE, min_value = 1, max_value = 10, default_value = 5});
	}

}

RegisterGS(FTransportGoals());
