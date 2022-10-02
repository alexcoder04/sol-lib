
Components.Base.TextField = {
    PosX = 0,
    PosY = 0,
    Label = "",
    Border = false
}

function Components.Base.TextField:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.PosX = 0
    self.PosY = 0
    self.Label = ""
    self.Border = false
    self.Color = {0, 0, 0}
    return o
end

function Components.Base.TextField:_touches(x, y)
    w, h = Library.Gui:GetStringSize(self.Label)
    if x >= self.PosX and x <= (self.PosX + w) then
        if y >= self.PosY and y <= (self.PosY + h) then
            return true
        end
    end
    return false
end

function Components.Base.TextField:_draw(gc)
    gc:setColorRGB(unpack(self.Color))
    gc:drawString(self.Label, self.PosX, self.PosY, "top")
    if self.Border then
        w, h = Library.Gui:GetStringSize(self.Label)
        gc:drawRect(self.PosX, self.PosY, w, h)
    end
    gc:setColorRGB(0, 0, 0)
end
