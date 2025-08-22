function GetRndCargo()
{
	local cargo_list = GSCargoList();
	local cargo_count = cargo_list.Count();
	local rnd_cargo_id = GSBase.Rand();
	rnd_cargo_id = rnd_cargo_id % cargo_count; // make sure we don't go out of bounds
	return rnd_cargo_id;
}

