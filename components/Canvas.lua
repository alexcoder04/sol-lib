
-- TODO relative drawing (x,y -> position on canvas, not globally)
Components.Base.Canvas = {
    PosX = 0,
    PosY = 0,
    Width = 10,
    Height = 10,
}

function Components.Base.Canvas:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Components.Base.Canvas:_touches(x, y)
    if x >= self.PosX and x <= (self.PosX + self.Width) then
        if y >= self.PosY and y <= (self.PosY + self.Height) then
            return true
        end
    end
    return false
end

function Components.Base.Canvas:_draw(gc, focused, focused)
    gc:setColorRGB(unpack(Lib.Colors.Royalblue))
    gc:fillRect(self.PosX, self.PosY, self.Width, self.Height)
    gc:setColorRGB(0, 0, 0)
    self:Draw(gc)
    if focused then
        Lib.Gui:DrawFocusBox(self.PosX, self.PosY, self.Width, self.Height, gc)
    end
end

function Components.Base.Canvas:Draw(gc)
end
