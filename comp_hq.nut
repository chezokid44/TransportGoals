function TransportGoals::UpdateHQSign(company_data)
{
	//local _hq_tile = GSCopany.GetCompanyHQ(company_data._company);
	local hq_tile = GSCompany.GetCompanyHQ(company_data._company);
	local hq_exist = GSMap.IsValidTile(hq_tile);
	local hq_sign_loc = hq_tile + GSMap.GetTileIndex(1,1); // South tile of the HQ

	if(company_data._hq_sign != null && !hq_exist)
	{
		// Sign exist, but no HQ => remove sign
		GSSign.RemoveSign(company_data._hq_sign);
		company_data._hq_sign = null;
	}
	else if(hq_exist)
	{
		// The HQ exist
		local sign_text = GSText(GSText.STR_SCORE, (company_data._goal_value - GOAL_STEP_SIZE));
		if(company_data._hq_sign == null)
		{
			// HQ exist, but no sign yet => create new sign
			company_data._hq_sign = GSSign.BuildSign(hq_sign_loc, sign_text);
		}
		else
		{
			// HQ exist as well as a sign
			if(GSSign.GetLocation(company_data._hq_sign) == hq_tile)
			{
				// The sign is at the right location => update only the text contents
				GSSign.SetName(company_data._hq_sign, sign_text);
			}
			else
			{
				// The sign exist, but at the wrong tile
				GSSign.RemoveSign(company_data._hq_sign);
				company_data._hq_sign = GSSign.BuildSign(hq_tile, sign_text);
			}
		}
	}
	else
	{
		// No HQ and no old sign
	}
}

