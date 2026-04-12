AddCSLuaFile()
DEFINE_BASECLASS("base_wire_entity")
ENT.PrintName = "Wire Cassette Tape"
ENT.WireDebugName = "VHS"

if CLIENT then
	return
end -- No more client

function ENT:Initialize()
	self:SetModel("models/gmod_wire_cassette_tape/gmod_wire_cassette_tape.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	timer.Simple(0,function()
		self:SetCollisionGroup(0)
	end)

	self.Storage = {}
	self.CurrentSector = 1
end

function ENT:BuildDupeInfo()
	local info = BaseClass.BuildDupeInfo(self) or {}

	info["Storage"] = {}

	for k, v in pairs(self.Storage) do
		info["Storage"][k] = v
	end

	return info
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
	BaseClass.ApplyDupeInfo(self, ply, ent, info, GetEntByID)

	self.Storage = {}
	for k, v in pairs(info["Storage"]) do
		self.Storage[k] = v
	end
	self.CurrentSector = 1
end

function ENT:AdvanceTape()
	self.CurrentSector = math.min(WIRE_CASETTE_TOTAL_CAPACITY / WIRE_CASETTE_CHUNK_SIZE, self.CurrentSector + 1)
end

function ENT:RewindTape()
	self.CurrentSector = math.max(1, self.CurrentSector - 1)
end

function ENT:AccessTape()
	return self.Storage[self.CurrentSector] or "This would be an empty string but I return this for a test"
end

function ENT:ModifyTape(newSector)
	self.Storage[self.CurrentSector] = newSector
end

function ENT:TapePosition()
	return self.CurrentSector
end

function ENT:Use(...)
	if IsValid(self:GetParent()) then self:GetParent():Use(...) end
end

duplicator.RegisterEntityClass("gmod_wire_cassette_tape", WireLib.MakeWireEnt, "Data")
