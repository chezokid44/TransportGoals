/*
 * This file is part of Transportgoals, which is a GameScript for OpenTTD
 * Copyright (C) 2011  Leif Linse
 *
 * Transportgoals is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License
 *
 * Transportgoals is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Transportgoals; If not, see <http://www.gnu.org/licenses/> or
 * write to the Free Software Foundation, Inc., 51 Franklin Street,
 * Fifth Floor, Boston, MA 02110-1301 USA.
 *
 */

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

