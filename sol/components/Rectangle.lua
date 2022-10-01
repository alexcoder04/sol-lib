
Components.Base.Rectangle = {
    PosX = 0,
    PosY = 0,
    Width = 10,
    Height = 10,
    Fill = false
}

function Components.Base.Rectangle:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.PosX = 0
    self.PosY = 0
    self.Width = 10
    self.Height = 10
    self.Fill = false
    return o
end

function Components.Base.Rectangle:Update()
end

function Components.Base.Rectangle:_draw(gc)
    if self.Fill then
        gc:fillRect(self.PosX, self.PosY, self.Width, self.Height)
        return
    end
    gc:drawRect(self.PosX, self.PosY, self.Width, self.Height)
end
