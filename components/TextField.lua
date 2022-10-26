
Components.Base.TextField = {
    PosX = 0,
    PosY = 0,
    Label = "",
    Border = false,
    Color = {0, 0, 0},
    FontSize = 12
}

function Components.Base.TextField:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Components.Base.TextField:_touches(x, y)
    local w, h = Lib.Gui.GetStringSize(self.Label)
    if x >= self.PosX and x <= (self.PosX + w) then
        if y >= self.PosY and y <= (self.PosY + h) then
            return true
        end
    end
    return false
end

function Components.Base.TextField:_draw(gc, focused)
    local c
    if type(self.Color) == "function" then
        c = self.Color()
    else
        c = self.Color
    end
    gc:setColorRGB(unpack(c))
    gc:setFont("sansserif", "r", self.FontSize)
    gc:drawString(self.Label, self.PosX, self.PosY, "top")
    gc:setFont("sansserif", "r", 12)
    local w, h = Lib.Gui.GetStringSize(self.Label)
    if self.Border then
        gc:drawRect(self.PosX, self.PosY, w, h)
    end
    gc:setColorRGB(0, 0, 0)
    if focused then
        Lib.Gui.DrawFocusBox(self.PosX, self.PosY, w, h, gc)
    end
end
