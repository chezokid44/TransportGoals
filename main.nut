GOAL_STEP_SIZE <- 5;
require("version.nut"); // get SELF_VERSION

class CompanyData
{
	_company = null;
	_goal_id = null;
	_goal_value = null;
	_vehicle_count_average = 0; // average * 100
	_transported = 0;
	_hq_sign = null; // sign id of the sign sitting ontop of the HQ

	constructor(company)
	{
		this._company = company;
		this._goal_id = null;
		this._goal_value = null;
		this._vehicle_count_average = 0;
		this._transported = 0;
		this._hq_sign = null;
	}

	function CreateGoal();

	// For save/load
	function SaveToTable();
	function CreateFromTable(table);
}

function CompanyData::CreateGoal()
{
	this._goal_id =
		GSGoal.New(this._company, GSText(GSText.STR_GOAL, this._goal_value), GSGoal.GT_NONE, 0);
}

function CompanyData::SaveToTable()
{
	local result = {
		company = this._company,
		goal_id = this._goal_id,
		goal_value = this._goal_value,
		vehicle_count_average = this._vehicle_count_average,
		transported = this._transported,
		hq_sign = this._hq_sign,
	};

	return result;
}

function CompanyData::CreateFromTable(table)
{
	local result = CompanyData(table.company);

	result._goal_id = table.goal_id;
	result._goal_value = table.goal_value;
	result._vehicle_count_average = table.vehicle_count_average;
	result._transported = table.transported;
	result._hq_sign = table.hq_sign;

	return result;
}

class TransportGoals extends GSController
{
	_per_company = null;

	_loaded_data = null; // assigned when loading a save game
	_loaded_from_version = null; // assigned when loading a save game


	constructor()
	{
		_per_company = [];
	}

	function Save();
	function Load();
}

require("goals.nut");
require("comp_hq.nut");
require("save_load.nut");

function TransportGoals::Start()
{
	this.UpdateGoalList();

	GSLog.Info("Setup Done")

	this.Sleep(1);

	local last_goal_setup = GSDate.GetCurrentDate();
	while(true) {
		local loop_start_tick = GSController.GetTick();
		this.HandleEvents();

		local current_date = GSDate.GetCurrentDate();
		if(current_date > last_goal_setup + 30)
		{
			// Check goals setup once a month to fix problems when events has been lost
			//GSLog.Info("Checking goal setup");
			this.UpdateGoalList();
			last_goal_setup = current_date;
		}
		this.ScanGoals();

		local ticks_used = GSController.GetTick() - loop_start_tick;
		this.Sleep(max(1, 5 * 74 - ticks_used)); // 5 ticks per second, 74 ticks per second is the default game speed
	}


}

// Helper function to get the maximum of two values
function max(x1, x2)
{
	return x1 > x2 ? x1 : x2;
}


function TransportGoals::HandleEvents()
{
	if(GSEventController.IsEventWaiting())
	{
		local ev = GSEventController.GetNextEvent();

		if(ev == null)
			return;

		local ev_type = ev.GetEventType();
		if(ev_type == GSEvent.ET_COMPANY_NEW ||
				ev_type == GSEvent.ET_COMPANY_BANKRUPT ||
				ev_type == GSEvent.ET_COMPANY_MERGER)
		{
			GSLog.Info("A company was created/bankrupt/merged => update goal list");

			// Update the goal list when:
			// - a new company has been created
			// - a company has gone bankrupt
			// - a company has been bought by another company
			this.UpdateGoalList();
		}
	}
}

