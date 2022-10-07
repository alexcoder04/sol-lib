
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

function Components.Base.Canvas:_draw(gc)
    gc:setColorRGB(Lib.Colors.Royalblue)
    gc:drawRect(self.PosX, self.PosY, self.Width, self.Height)
    self:Draw(gc)
    gc:setColorRGB(0, 0, 0)
end

function Components.Base.Canvas:Draw(gc)
end
