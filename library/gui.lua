
function _getStringSize(str, gc)
    return gc:getStringWidth(str), gc:getStringHeight(str)
end

function Lib.Gui:GetStringSize(str)
    return platform.withGC(_getStringSize, str)
end

function Lib.Gui:DrawFocusBox(x, y, w, h, gc)
    gc:setColorRGB(unpack(Lib.Colors.Blue))
    gc:drawRect(x, y, w, h)
    gc:setColorRGB(0, 0, 0)
end
