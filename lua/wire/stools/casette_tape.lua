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
	panel:Help("It stores a table of "..math.Truncate((WIRE_CASETTE_TOTAL_CAPACITY/WIRE_CASETTE_CHUNK_SIZE)).." strings (\"sectors\") "..math.Truncate((WIRE_CASETTE_CHUNK_SIZE/1024)).." KB each, first sector is #1")
	panel:Help("Total capacity: "..math.Truncate((WIRE_CASETTE_TOTAL_CAPACITY/1024/1024),1).." MB")
end
