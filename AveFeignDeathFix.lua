local UnitIsPlayer = UnitIsPlayer
local UnitIsUnit   = UnitIsUnit
local C_NamePlate  = C_NamePlate
local FDF = CreateFrame("Frame")
FDF:RegisterEvent("NAME_PLATE_UNIT_ADDED")
FDF:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
FDF:SetScript("OnEvent", function(self, event, ...)
	if event == "NAME_PLATE_UNIT_ADDED" then
		local unit = ...
		self:OnNamePlateAdded(unit)
	elseif event == "NAME_PLATE_UNIT_REMOVED" then
		local unit = ...
		self:OnNamePlateRemoved(unit)
    end
end)

local function feignDeathFix(unit, nameplate)
	if select(3, UnitClass(unit)) == 3 then
		nameplate.AveFeignDeath = true
	end
end

function FDF:OnNamePlateAdded(unit)
	local unit = unit
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	nameplate.UnitFrame.healthBar:SetScript("OnHide", function(self) if nameplate.AveFeignDeath then self:Show() end end)
	if UnitIsPlayer(unit) and not UnitIsUnit("player", unit) then
		feignDeathFix(unit, nameplate)
    end
end

function FDF:OnNamePlateRemoved(unit)
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	nameplate.AveFeignDeath = nil
end