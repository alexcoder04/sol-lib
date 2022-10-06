
function _getStringSize(str, gc)
    return gc:getStringWidth(str), gc:getStringHeight(str)
end

function Library.Gui:GetStringSize(str)
    return platform.withGC(_getStringSize, str)
end
