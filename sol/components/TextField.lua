
Components.Base.TextField = {
    PosX = 0,
    PosY = 0,
    Label = ""
}

function Components.Base.TextField:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.PosX = 0
    self.PosY = 0
    self.Label = ""
    return o
end

function Components.Base.TextField:Update()
end

function Components.Base.TextField:_draw(gc)
    gc:drawString(self.Label, self.PosX, self.PosY, "top")
end
