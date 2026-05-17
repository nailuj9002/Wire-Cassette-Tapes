WireToolSetup.setCategory("Memory")
WireToolSetup.open("cassette_tape", "Cassette Tape", "gmod_wire_cassette_tape", nil, "Cassette Tape")

if CLIENT then
	language.Add("Tool.wire_cassette_tape.name", "Cassette Tape Tool (Wire)")
	language.Add("Tool.wire_cassette_tape.desc", "Spawns a Cassette Tape.")
	language.Add("sboxlimit_wire_cassette_tapes", "You've hit the Cassette Tape limit!")
	TOOL.Information = {
		{ name = "left", text = "Create/Update " .. TOOL.Name },
	}
end

WireToolSetup.BaseLang()

if SERVER then
	CreateConVar("sbox_maxwire_cassette_tapes", 20)
end

TOOL.ClientConVar["model"] = "models/gmod_wire_cassette_tape/gmod_wire_cassette_tape.mdl"

if SERVER then
	-- Uses default WireToolObj:MakeEnt's WireLib.MakeWireEnt function
end

function TOOL.BuildCPanel(panel) 
	panel:Help("A Cassette Tape to insert into a Cassette Reader.")
	panel:Help("It stores a table of 3840 strings (\"sectors\") 4 KB each, first sector is #1")
	panel:Help("Total capacity: 15 MB")
end
