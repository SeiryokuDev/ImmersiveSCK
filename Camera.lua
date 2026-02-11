local _, ISCK = ...

function ISCK:StartSpinning(_, unit, _, spellID)
    if unit == "player" then 
        if spellID == 322729 or spellID == 101546 then
            SaveView(1)
            MoveViewRightStart(1360 / tonumber(GetCVar("cameraYawMoveSpeed")))
            self.spinning = true
        else
            if self.spinning then
                self:StopCamera()
            end
        end
    end
end

function ISCK:StopSpinning(_, unit, _, spellID)
    if unit == "player" and (spellID == 322729 or spellID == 101546) then
        if self.spinning then
            self:StopCamera()
        end
    end
end

function ISCK:StopCamera()
        MoveViewRightStop()
        SetView(1)
        self.spinning = false
end