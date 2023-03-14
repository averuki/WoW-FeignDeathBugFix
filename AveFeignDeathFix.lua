local UnitIsPlayer = UnitIsPlayer
local UnitIsUnit   = UnitIsUnit
local C_NamePlate  = C_NamePlate

EventRegistry:RegisterFrameEventAndCallback("NAME_PLATE_UNIT_ADDED", function(owner, ...)
	local unit = ...
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	if UnitIsPlayer(unit) and (select(3, UnitClass(unit)) == 3) and not UnitIsUnit(unit, "player") then
		nameplate.aveFeignDeath = true
		nameplate.UnitFrame.healthBar:SetScript("OnHide", function(self) if nameplate.aveFeignDeath then self:Show() end end)
	end
end)

EventRegistry:RegisterFrameEventAndCallback("NAME_PLATE_UNIT_REMOVED", function(owner, ...)
	local unit = ...
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	nameplate.aveFeignDeath = nil
end)
