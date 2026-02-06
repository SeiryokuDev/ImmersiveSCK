local ADDON_NAME, ISCK = ...

local AceAddon       = LibStub("AceAddon-3.0")

_G.ISCK                = ISCK
ISCK.ADDON_NAME_PRINT  = "[" .. WrapTextInColorCode(ADDON_NAME, "ffE6CC80") .. "]"

AceAddon:NewAddon(
    ISCK,
    ADDON_NAME,
    "AceEvent-3.0",
    "AceConsole-3.0"
)

ISCK.defaults = {
    global = {
        enabled = true,
    }
}

function ISCK:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("ISCKDB", self.defaults, true)
    self.config = self.db.global

    self:RegisterChatCommand("isck", "HandleSlash")
end

function ISCK:HandleSlash()
    self:SetEnabled(not self.config.enabled)
end

function ISCK:OnEnable()
    if not self.config.enabled then
        return
    end

    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "StartSpinning")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "StopSpinning")
end

function ISCK:OnDisable()
    self:UnregisterAllEvents()
end

function ISCK:SetEnabled(value)
    local enabled = not not value
    self.config.enabled = enabled

    if enabled then
        self:Enable()
        print(string.format("%s enabled", self.ADDON_NAME_PRINT))
    else
        self:Disable()
        print(string.format("%s disabled", self.ADDON_NAME_PRINT))
    end
end