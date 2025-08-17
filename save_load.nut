function TransportGoals::Save()
{
	GSLog.Info("Saving data");
	local result = {};

	foreach(company_data in this._per_company)
	{
		result[company_data._company] <- company_data.SaveToTable();
	}

	foreach(i, k in result)
	{
		GSLog.Info(i + " has " + k);
	}

	return result;
}

function TransportGoals::Load(version, table)
{
	GSLog.Info("Loading..");
	GSLog.Info("Previously saved with Game Script version " + version);

	if(version > SELF_VERSION)
	{
		GSLog.Warning("Warning: Loading from a newer version of TransportGoals");
	}
	else
	{
		GSLog.Info("Loading from version " + SELF_VERSION + " of TransportGoals.");
	   	//GSLog.Warning("Version 1 did not support save/load, so you will get duplicate goals.");
	}
	this._loaded_data = table;
	this._loaded_from_version = version;
}