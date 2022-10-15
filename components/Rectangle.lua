
Components.Base.Rectangle = {
    PosX = 0,
    PosY = 0,
    Width = 10,
    Height = 10,
    Fill = false,
    Color = {0, 0, 0}
}

function Components.Base.Rectangle:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Components.Base.Rectangle:_touches(x, y)
    if x >= self.PosX and x <= (self.PosX + self.Width) then
        if y >= self.PosY and y <= (self.PosY + self.Height) then
            return true
        end
    end
    return false
end

function Components.Base.Rectangle:_draw(gc, focused)
    gc:setColorRGB(unpack(self.Color))
    if self.Fill then
        gc:fillRect(self.PosX, self.PosY, self.Width, self.Height)
    else
        gc:drawRect(self.PosX, self.PosY, self.Width, self.Height)
    end
    gc:setColorRGB(0, 0, 0)
    if focused then
        Lib.Gui:DrawFocusBox(self.PosX, self.PosY, self.Width, self.Height, gc)
    end
end
