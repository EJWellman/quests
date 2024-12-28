local ng = {};

-- These are the allowed NG+ combinations allowed
function ng.Definitions(e)

	local configs = {};
	local num_configs = 3;
	local barbarianPaladinDiscovered = ng.IsBarbarianPaladinUnlocked(e);

	-- Default NG+: Requires level 60. Race changes. Back to level 10.
	configs[1] = {
		name = "(Race Change) NewGame+",
		minLevel = 60,
		isRaceChange = true,
		setLevel = 10,
		discovered = true
	};

	-- Barbarian Paladin race-change. Available to non-barbarian paladins.
	configs[2] = {
		name = "(Race Change) Barbarian Paladin",
		minLevel = 1,
		isRaceChange = true,
		curClass = "Paladin",
		mustRaceChange = "Barbarian",  -- Must change to Barbarian, and must not already be Barbarian
		setLevel = 1,
		discovered = barbarianPaladinDiscovered
	};
	configs.size = num_configs;

	return configs;
end

function ng.IsBarbarianPaladinUnlocked(e)
	return (e.other:HasCharacterCreateCombination(ng.FindClass("paladin"), ng.FindRace("barbarian"), ng.FindDeity("mithaniel"), ng.FindCityChoice("halas"))) or
		   (e.other:HasCharacterCreateCombination(ng.FindClass("paladin"), ng.FindRace("barbarian"), ng.FindDeity("tribunal"),  ng.FindCityChoice("halas")));
end

-- Parse a string such as "10 STR 15 STA 10 DEX"
function ng.ParseAttributes(message)

    -- Initialize attributes with default value of 0
    local attributes = { STR = 0, STA = 0, DEX = 0, AGI = 0, INT = 0, WIS = 0, CHA = 0 };
    
    -- Convert the input string to uppercase for case-insensitivity
    message = message:upper();
    
    -- Pattern to match the number followed by the attribute name
    for value, attribute in message:gmatch("(%d+)%s*(%a+)") do
        value = tonumber(value) -- Convert matched value to a number
        if attributes[attribute] ~= nil and value >= 0 and value <= 35 then
            attributes[attribute] = value
        end
    end

    return attributes;
end

function ng.FindClass(message)
	if (message:findi("warrior")) then
		return 1;
	elseif (message:findi("cleric")) then
		return 2;
	elseif (message:findi("paladin")) then
		return 3;
	elseif (message:findi("ranger")) then
		return 4;
	elseif (message:findi("shadowknight") or message:findi("shadow knight")) then
		return 5;
	elseif (message:findi("druid")) then
		return 6;
	elseif (message:findi("monk")) then
		return 7;
	elseif (message:findi("bard")) then
		return 8;
	elseif (message:findi("rogue")) then
		return 9;
	elseif (message:findi("shaman")) then
		return 10;
	elseif (message:findi("necro")) then
		return 11;
	elseif (message:findi("wizard")) then
		return 12;
	elseif (message:findi("mage") or message:findi("magician")) then
		return 13;
	elseif (message:findi("enchanter")) then
		return 14;
	elseif (message:findi("beastlord")) then
		return 15;
	end
	return -1;
end

-- Parses the race name to its ID
function ng.FindRace(message)
	if (message:findi("human")) then
		return 1;
	elseif (message:findi("barbarian")) then
		return 2;
	elseif (message:findi("erudite")) then
		return 3;
	elseif (message:findi("wood elf") or message:findi("wood-elf")) then
		return 4;
	elseif (message:findi("high elf") or message:findi("high-elf")) then
		return 5;
	elseif (message:findi("dark elf") or message:findi("dark-elf")) then
		return 6;
	elseif (message:findi("half elf") or message:findi("half-elf")) then
		return 7;
	elseif (message:findi("dwarf")) then
		return 8;
	elseif (message:findi("troll")) then
		return 9;
	elseif (message:findi("ogre")) then
		return 10;
	elseif (message:findi("halfling")) then
		return 11;
	elseif (message:findi("gnome")) then
		return 12;
	elseif (message:findi("iksar")) then
		return 128;
	elseif (message:findi("vah shir") or message:findi("vahshir")) then
		return 130;
	end
	return -1;
end

function ng.FindGender(message)
	if (message:findi("female")) then
		return 1;
	elseif (message:findi("male")) then
		return 0;
	else
		return -1;
	end
end

-- Parses a diety name to its ID
function ng.FindDeity(message)
	if (message:findi("agnostic")) then
		return 396;
	elseif (message:findi("bertox")) then
		return 201;
	elseif (message:findi("brell")) then
		return 202;
	elseif (message:findi("cazic")) then
		return 203;
	elseif (message:findi("erollisi")) then
		return 204;
	elseif (message:findi("fizzle")) then
		return 205;
	elseif (message:findi("innoruuk")) then
		return 206;
	elseif (message:findi("karana")) then
		return 207;
	elseif (message:findi("mithaniel")) then
		return 208;
	elseif (message:findi("prexus")) then
		return 209;
	elseif (message:findi("quellious")) then
		return 210;
	elseif (message:findi("rallos")) then
		return 211;
	elseif (message:findi("rodect")) then
		return 212;
	elseif (message:findi("solusek")) then
		return 213;
	elseif (message:findi("tribunal")) then
		return 214;
	elseif (message:findi("tunare")) then
		return 215;
	elseif (message:findi("veeshan")) then
		return 216;
	end
	return -1;
end

-- Parses a city name to it's 'player_choice' value in the start_zone db
function ng.FindCityChoice(message)
	if (message:findi("paineel") or message:findi("erudin")) then
		return 0;
	elseif (message:findi("qeynos")) then
		return 1;
	elseif (message:findi("halas")) then
		return 2;
	elseif (message:findi("rivervale")) then
		return 3;
	elseif (message:findi("freeport")) then
		return 4;
	elseif (message:findi("neriak") or message:findi("grobb")) then
		return 5;
	elseif (message:findi("oggok")) then
		return 7;
	elseif (message:findi("kaladim")) then
		return 8;
	elseif (message:findi("kelethin")) then
		return 9;
	elseif (message:findi("felwithe")) then
		return 10;
	elseif (message:findi("akanon")) then
		return 11;
	elseif (message:findi("cabilis")) then
		return 12;
	elseif (message:findi("sharvahl") or message:findi("shar vahl")) then
		return 13;
	end
	return -1;
end

-- returns has_input, is_complete
function ng.ValidateInput(e, data, warn)

	local has_input = false;
	local is_complete = false;

	if (data.class >= 0) then
		has_input = true;
	elseif (data.race >= 0) then
		has_input = true;
	elseif (data.gender >= 0) then
		has_input = true;
	elseif (data.deity >= 0) then
		has_input = true;
	elseif (data.city >= 0) then
		has_input = true;
	elseif (data.stats_total > 0) then
		has_input = true;
	end
	
	is_complete = has_input;
	
	if (data.class == -1) then
		is_complete = false;
		if (has_input and warn and not data.class_warned) then
			data.class_warned = true;
			e.other:Message(15, "You must choose a [class].");
		end
	end
	
	if (data.race == -1) then
		is_complete = false;
		if (has_input and warn and not data.race_warned) then
			data.race_warned = true;
			e.other:Message(15, "You must choose a [race].");
		end
	end
	
	if (data.gender == -1) then
		is_complete = false;
		if (has_input and warn and not data.gender_warned) then
			data.gender_warned = true;
			e.other:Message(15, "You must choose a [gender].");
		end
	end
	
	if (data.deity == -1) then
		is_complete = false;
		if (has_input and warn and not data.deity_warned) then
			data.deity_warned = true;
			e.other:Message(15, "You must choose a [deity].");
		end
	end
	
	if (data.city == -1) then
		is_complete = false;
		if (has_input and warn and not data.city_warned) then
			data.city_warned = true;
			e.other:Message(15, "You must choose a [home city].");
		end
	end
	
	if (data.stats_total == 0) then
		is_complete = false;
		if (has_input and warn and not data.stats_warned) then
			data.stats_warned = true;
			e.other:Message(15, "You must choose your [attribute points]. (Example: 10 sta 10 str)");
		end
	end
	
	return has_input, is_complete;
end

function ng.ParseInput(message)
	local data = {
		class = ng.FindClass(message),
		race = ng.FindRace(message),
		gender = ng.FindGender(message),
		deity = ng.FindDeity(message),
		city = ng.FindCityChoice(message),
		stats = ng.ParseAttributes(message);
	}
	data.stats_total = data.stats.STR + data.stats.STA + data.stats.AGI + data.stats.DEX + data.stats.WIS + data.stats.INT + data.stats.CHA;
	return data;
end

function ng.PrintModes(e)
	local definitions = ng.Definitions(e);
	e.other:Message(15, "------- NewGame Plus Options ---------");
	for i = 1, definitions.size do
		local ngoption = definitions[i];
		local is_match, error_reason = ng.IsMeetingBaseRequirements(e, ngoption);
		if (is_match) then
			e.other:Message(15, "[Unlocked] " .. ngoption.name);
		else
			e.other:Message(13, "[Locked] " .. ngoption.name .. " " .. error_reason);
		end
	end
end

-- returns is_match, error_reason
function ng.IsMeetingBaseRequirements(e, ngoption)
	if (not ngoption.isRaceChange and not ngoption.isClassChange) then
		return false, "is unavailable (Internal Error). Not configured for race or class changes.";
	end
	if (not ngoption.discovered) then
		return false, "is not discovered.";
	end
	if (ngoption.minLevel and ngoption.minLevel > e.other:GetLevel()) then
		return false, "requires level " .. ngoption.minLevel .. ".";
	end
	if (ngoption.curRace and ng.FindRace(ngoption.curRace) ~= e.other:GetBaseRace()) then
		return false, "is not available to this race.";
	end
	if (ngoption.curClass and ng.FindClass(ngoption.curClass) ~= e.other:GetClass()) then
		return false, "is not available to this class.";
	end
	if (ngoption.mustRaceChange and ng.FindRace(ngoption.mustRaceChange) == e.other:GetBaseRace()) then
		return false, "is not available to " .. ngoption.mustRaceChange .. ".";
	end
	if (ngoption.mustClassChange and ng.FindClass(ngoption.mustClassChange) == e.other:GetClass()) then
		return false, "is not available to " .. ngoption.mustClassChange .. ".";
	end
	return true, nil;
end

function ng.IsMeetingCompleteRequirements(e, data, ngoption)

	if (not ng.IsMeetingBaseRequirements(e, ngoption)) then
		return false;
	end
	
	local has_data, is_complete = ng.ValidateInput(e, data, false);
	if (not has_data or not is_complete) then
		return false;
	end

	if (ngoption.mustRaceChange and ng.FindRace(ngoption.mustRaceChange) ~= data.race) then
		return false; -- Requires a specific new race, but character chose a different race
	end
	if (ngoption.mustClassChange and ng.FindClass(ngoption.mustClassChange) ~= data.class) then
		return false; -- Requires a specific new class, but character chose a different class
	end
	if (ngoption.isRaceChange and data.class ~= e.other:GetClass()) then
		return false; -- Cannot change class during a race change
	end
	if (ngoption.isClassChange and data.race ~= e.other:GetBaseRace()) then
		return false; -- Cannot change race during a class change.
	end

	return true;
end

-- returns was_tried
function ng.TryApplyOption(e, data, ngoption)

	if (not ng.IsMeetingCompleteRequirements(e, data, ngoption)) then
		return false;
	end

	local newLevel = ngoption.setLevel or 10;
	local newLevel2 = ngoption.setLevel2 or 255
	local resetPoints = ngoption.resetPoints or false;	
	local PermaFunction = nil; -- PermaRace or PermaClass
	local param1 = -1; -- race or class depending on PermaFunction

	if (ngoption.isRaceChange) then
		PermaFunction = e.other.PermaRace;
		param1 = data.race;
	elseif (ngoption.isClassChange) then
		PermaFunction = e.other.PermaClass;
		param1 = data.class;
	else
		return false;
	end

	if (PermaFunction(e.other, param1, data.deity, data.city, data.stats.STR, data.stats.STA, data.stats.AGI, data.stats.DEX, data.stats.WIS, data.stats.INT, data.stats.CHA)) then
		e.other:SetBaseGender(data.gender);
		e.other:ResetPlayerForNewGamePlus(newLevel, newLevel2, resetPoints);
	end
	return true;
end

function ng.HasAnyOptions(e, definitions)
	for i = 1, definitions.size do
		local ngoption = definitions[i];
		if (ng.IsMeetingBaseRequirements(e, ngoption)) then
			return true;
		end
	end
	return false;
end

-- Return: success, found_eligible, has_input
function ng.HandleReborn(e)

	local definitions = ng.Definitions(e)

	if (not ng.HasAnyOptions(e, definitions)) then
		e.self:Say("You lack experience to be reborn. Begone.");
		ng.PrintModes(e);
		return;
	end

	local data = ng.ParseInput(e.message);
	local reqs = "race class gender deity city stats"; -- We always require everything to be set for NG+, to avoid confusion.
	local has_input, is_complete = ng.ValidateInput(e, data, true);

	if (not has_input) then
		e.self:Say("To be [reborn] is to shed the weight of your past trials and embrace a new beginning. Through the path of Discord, you may start anew, carrying forward the wisdom of your journey. Fear not, your hard-won items and treasured equipment shall remain with you, symbols of your strength and perseverance. Those who walk this road will earn the title 'the Reborn' - a badge of both your sacrifice and your triumph. Speak to me again and declare your [reborn] [race], [class], [gender], [deity], [home city], and [attribute points].");
		e.other:Message(15, "Your level will be reset back to level 10, along with your faction and location. Your spells, AAs, and skill ranks will remain intact.");
		if (e.other:GetLevel() > 59) then
			e.other:Message(15, "Your surname will be changed to a Norrathian numeral indicating how many times you have been reborn. It will be possible to change the surname's style in the future.");
		end
		ng.PrintModes(e);
		return;
	end

	if (not is_complete) then
		return; -- ValidateInput generated missing prompts.
	end

	for i = 1, definitions.size do
		local ngoption = definitions[i];
		if (ng.TryApplyOption(e, data, ngoption)) then
			return; -- PermaRace/PermaClass will generate output when attempted.
		end
	end

	e.other:Message(13, "That reborn combination is not available.");
	ng.PrintModes(e);
end

return ng;