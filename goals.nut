function TransportGoals::UpdateGoalList()
{
	// Was a previous game loaded from a save game?
	if (this._loaded_data != null) {
		// Load company data from the save game
		foreach (_, company_table in this._loaded_data)
		{
			if (company_table.company != null) {
				GSLog.Info("Loading data for company " + GSCompany.GetNAME(company_table.company));
				this._per_company.append(
					CompanyData.CreateFromTable(company_table)
				);
			}
		}

		this._loaded_data = null; // clear loaded data

	}

	// Loop over all possibly company IDs
	for(local c = GSCompany.COMPANY_FIRST; c < GSCompany.COMPANY_LAST; c++)
	{
		// Has goals already been set up for this company?
		local existing = null;
		local existing_index = 0;
		foreach(company_data in this._per_company)
		{
			if (company_data._company == c) {
				existing = company_data;
				break;
			}
			existing_index++;
		}


		// Does the company exist in the game?
		if (GSCompany.ResolveCompanyID(c) == GSCompany.COMPANY_INVALID) {
			if (existing != null) {
				// Remove data for no longer existing company
				this._per_company.remove(existing_index);
			}
			continue;
		}

		// If the company can be resolved and exist (goals has been setup) => don't do anything
		if (existing != null) continue;

		// Company goals has not yet been setup for this company
		local company_data = CompanyData(c);
		company_data._goal_value = GOAL_STEP_SIZE;
		company_data.CreateGoal();

		this._per_company.append(company_data);
	}
}

// Has any goals been fulfilled?
function TransportGoals::ScanGoals()
{
	foreach(company_data in this._per_company)
	{
		local delivered = GSCompany.GetQuarterlyCargoDelivered(company_data._company, GSCompany.CURRENT_QUARTER + 1	);
		local veh_count = GSVehicleList().Count();

		company_data._vehicle_count_average = (company_data._vehicle_count_average * 5 + veh_count * 100) / 6;

		local cargo_per_veh = company_data._vehicle_count_average == 0 ? 0 :
			delivered * 100 / company_data._vehicle_count_average;

		GSLog.Info("Cargo/Vehicle for " + GSCompany.GetName(company_data._company) + ": " + cargo_per_veh);

		UpdateHQSign(company_data);

		if (cargo_per_veh > company_data._goal_value) {
			// Goal has been fulfilled
			GSGoal.Remove(company_data._goal_id);
			company_data._goal_value += GOAL_STEP_SIZE;
			company_data.CreateGoal();
			GSLog.Info("Goal fulfilled for company " + GSCompany.GetName(company_data._company) + ".");
		}
	}
}