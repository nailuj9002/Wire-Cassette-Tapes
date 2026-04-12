AddCSLuaFile()
DEFINE_BASECLASS("base_wire_entity")
ENT.PrintName = "Wire Cassette Reader"
ENT.WantsTranslucency = true
ENT.WireDebugName = "Cassette Ray"

if CLIENT then
	return
end -- No more client

function ENT:Initialize()
	self:SetModel("models/gmod_wire_cassette_reader/gmod_wire_cassette_reader.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	timer.Simple(0,function()
		self:SetCollisionGroup(0)
	end)

	Wire_CreateInputs(self, { "Read", "Write", "Advance", "Rewind", "Eject" })
	Wire_CreateOutputs(self, { "CurrentSector" })

	self.Buffer = {}
	self.Cassette = nil
	self.Connection = nil
end

function ENT:ReadCell(address)
	if not (address >= 1 or address <= WIRE_CASETTE_CHUNK_SIZE) then
		return
	end
	return self.Buffer[address] or 0
end

function ENT:WriteCell(address, value)
	if not (address >= 1 or address <= WIRE_CASETTE_CHUNK_SIZE) then
		return
	end
	if not isnumber(value) then
		return
	end
	self.Buffer[address] = value
end

function ENT:TriggerInput(iname, value)
	if value == 0 then return end
	if not IsValid(self.Cassette) or self.Cassette:GetClass() ~= "gmod_wire_cassette_tape" then
		self.Buffer = {}
		return
	end

	Wire_TriggerOutput(self, "CurrentSector", self.Cassette:TapePosition())

	if iname == "Read" or iname == "Write" then
		if iname == "Read" then
			self.Buffer = {}
			local source = self.Cassette:AccessTape()
			for i = 1, WIRE_CASETTE_CHUNK_SIZE do
				if i <= #source then
					self.Buffer[i] = string.byte(source[i])
				else
					break
				end
			end
		elseif iname == "Write" then
			self.Cassette:ModifyTape(string.char(unpack(self.Buffer)))
		end
	elseif iname == "Advance" then
		self.Cassette:AdvanceTape()
	elseif iname == "Rewind" then
		self.Cassette:RewindTape()
	elseif iname == "Eject" then
		self:Use(self)
	end
end

function ENT:PhysicsCollide(colData, collider)
	if IsValid(colData.HitEntity) and colData.HitEntity:GetClass() == "gmod_wire_cassette_tape" and not IsValid(self.Cassette) then
		self.Cassette = colData.HitEntity
		self.Cassette:SetPos(self:GetPos())
		self.Cassette:SetAngles(self:GetAngles())
		self.Cassette:SetParent(self)
		self.Cassette:GetPhysicsObject():EnableMotion(false)
		self:EmitSound("47ak.magin")
	end
end

function ENT:Think()
	if not IsValid(self.Cassette) or self.Cassette:GetClass() ~= "gmod_wire_cassette_tape" then
		Wire_TriggerOutput(self, "CurrentSector", 0)
		return
	end

	Wire_TriggerOutput(self, "CurrentSector", self.Cassette:TapePosition())
	self:NextThink(CurTime())
	return true
end

function ENT:Use()
	if IsValid(self.Cassette) then
		self.Cassette:SetParent(nil)
		self.Cassette:SetPos(self:LocalToWorld(Vector(0,0,10)))
		self.Cassette:GetPhysicsObject():EnableMotion(false)
		self.Cassette = nil
		self:EmitSound("47ak.magout")
	end
end

duplicator.RegisterEntityClass("gmod_wire_cassette_reader", WireLib.MakeWireEnt, "Data")
