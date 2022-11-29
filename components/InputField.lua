
-- base table structure
Components.Base.InputField = {
    PosX = 0,
    PosY = 0,
    Width = 50,
    Value = "",
    Type = "string",
    Label = "",
    LabelWidth = 0,
    Color = {0, 0, 0},
    _cursor_on = false
}

-- object create
function Components.Base.InputField:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- utils
function Components.Base.InputField:_get_cursor(focused)
    if not focused then return " " end
    if self._cursor_on then return "|" end
    return " "
end

function Components.Base.InputField:_get_draw_text(focused)
    local dt = self.Value
    local w, h = Lib.Gui.GetStringSize(dt .. self:_get_cursor(focused))
    if w <= self.Width then return dt .. self:_get_cursor(focused) end
    while w > self.Width do
        dt = dt:sub(2)
        w, h = Lib.Gui.GetStringSize("..." .. dt .. self:_get_cursor(focused))
    end
    return "..." .. dt .. self:_get_cursor(focused)
end

function Components.Base.InputField:_get_label_width()
    if self.Label == "" then
        return 0
    end
    if self.LabelWidth ~= 0 then
        return self.LabelWidth
    end
    local wl, _ = Lib.Gui.GetStringSize(self.Label .. " ")
    return wl
end

function Components.Base.InputField:_draw_label(gc)
    if self.Label == "" then return end
    gc:drawString(self.Label .. " ", self.PosX, self.PosY, "top")
end

-- required functions
function Components.Base.InputField:_touches(x, y)
    local _, h = Lib.Gui.GetStringSize(self.Value)
    local wl = self:_get_label_width()
    if x >= self.PosX and x <= (self.PosX + wl + self.Width) then
        if y >= self.PosY and y <= (self.PosY + h) then
            return true
        end
    end
    return false
end

function Components.Base.InputField:_draw(gc, focused)
    self._cursor_on = not self._cursor_on

    local dt = self:_get_draw_text(focused)

    local _, h = Lib.Gui.GetStringSize(dt)
    local wl = self:_get_label_width()

    if not focused then
        gc:setColorRGB(unpack(Lib.Colors.Silver))
        gc:fillRect(self.PosX + wl, self.PosY, self.Width, h)
    end

    gc:setColorRGB(Lib.Colors.Parse(self.Color))
    self:_draw_label(gc)
    gc:drawString(dt, self.PosX + wl, self.PosY, "top")

    if h == 0 then
        h = 20
    end
    gc:drawRect(self.PosX + wl, self.PosY, self.Width, h)
    gc:setColorRGB(0, 0, 0)
    
    if focused then
        Lib.Gui.DrawFocusBox(self.PosX + wl, self.PosY, self.Width, h, gc)
    end
end

function Components.Base.InputField:AcceptChar(c)
    if self.Type == "number" then
        if (not Lib.Lang.IsDigit(c)) and c ~= "." and string.byte(c) ~= 226 then return end
        if c == "." and string.find(self.Value, "%.") then return end
        if string.byte(c) == 226 then
            if self.Value:sub(1,1) == "-" then
                self.Value = self.Value:sub(2,#(self.Value))
            else
                self.Value = "-" .. self.Value
            end
            return
        end
    end

    self.Value = self.Value .. c

    if self.Type == "number" then
        self.Value = Lib.Internal.NormalizeNumber(self.Value)
    end
end

function Components.Base.InputField:AcceptBackspace(c)
    self.Value = self.Value:sub(1, #(self.Value)-1)

    if self.Type == "number" then
        self.Value = Lib.Internal.NormalizeNumber(self.Value)
    end
end
