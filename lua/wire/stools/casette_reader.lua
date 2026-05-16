WireToolSetup.setCategory("Memory")
WireToolSetup.open("cassette_reader", "Cassette Reader", "gmod_wire_cassette_reader", nil, "Cassette Readers")

if CLIENT then
	language.Add("Tool.wire_cassette_reader.name", "Cassette Reader Tool (Wire)")
	language.Add("Tool.wire_cassette_reader.desc", "Spawns a Cassette Reader.")
	language.Add("WireCDRayTool_cd_ray", "Cassette Reader:")
	language.Add("sboxlimit_wire_cassette_readers", "You've hit the Cassette Reader limit!")
	TOOL.Information = {
		{ name = "left", text = "Create/Update " .. TOOL.Name },
	}
end

WireToolSetup.BaseLang()

if SERVER then
	CreateConVar("sbox_maxwire_cassette_readers", 20)
end

TOOL.ClientConVar["model"] = "models/gmod_wire_cassette_reader/gmod_wire_cassette_reader.mdl"

if SERVER then
	-- Uses default WireToolObj:MakeEnt's WireLib.MakeWireEnt function
end

function TOOL.BuildCPanel(panel) 
	panel:Help("A Cassette Tape reader.")
	panel:Help("First 4096 Hi-Speed interface cells are BYTES of a buffer")
	panel:Help("Cassette sector is copied onto buffer when Read input is triggered")
	panel:Help("Buffer content is copied onto the cassette sector on Write trigger")
	panel:Help("All inputs (except Eject) are triggered on write (so, you can send same number to each input and it will get triggered)")
end
