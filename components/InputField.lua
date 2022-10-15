
Components.Base.InputField = {
    PosX = 0,
    PosY = 0,
    Width = 50,
    Value = "",
    Color = {0, 0, 0},
    _cursor_on = false
}

function Components.Base.InputField:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Components.Base.InputField:_touches(x, y)
    local w, h = Lib.Gui:GetStringSize(self.Value)
    if x >= self.PosX and x <= (self.PosX + self.Width) then
        if y >= self.PosY and y <= (self.PosY + h) then
            return true
        end
    end
    return false
end

function Components.Base.InputField:_get_cursor(focused)
    if not focused then return " " end
    if self._cursor_on then return "|" end
    return " "
end

function Components.Base.InputField:_get_draw_text(focused)
    local dt = self.Value
    local w, h = Lib.Gui:GetStringSize(dt .. self:_get_cursor(focused))
    if w <= self.Width then return dt .. self:_get_cursor(focused) end
    while w > self.Width do
        dt = dt:sub(2)
        w, h = Lib.Gui:GetStringSize("..." .. dt .. self:_get_cursor(focused))
    end
    return "..." .. dt .. self:_get_cursor(focused)
end

function Components.Base.InputField:_draw(gc, focused)
    self._cursor_on = not self._cursor_on
    local dt = self:_get_draw_text(focused)
    local w, h = Lib.Gui:GetStringSize(dt)
    if not focused then
        gc:setColorRGB(unpack(Lib.Colors.Silver))
        gc:fillRect(self.PosX, self.PosY, self.Width, h)
    end
    gc:setColorRGB(unpack(self.Color))
    gc:drawString(dt, self.PosX, self.PosY, "top")
    if h == 0 then
        h = 20
    end
    gc:drawRect(self.PosX, self.PosY, self.Width, h)
    gc:setColorRGB(0, 0, 0)
    if focused then
        Lib.Gui:DrawFocusBox(self.PosX, self.PosY, self.Width, h, gc)
    end
end

function Components.Base.InputField:AcceptChar(c)
    self.Value = self.Value .. c
end

function Components.Base.InputField:AcceptBackspace(c)
    self.Value = self.Value:sub(1, #(self.Value)-1)
end
