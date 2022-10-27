
function Lib.Dialog.RefreshCurrent()
    local current=Lib.Dialog.Current()
    if current.size then
        local sizeX,sizeY=unpack(current.size)
        local xPos,yPos=(platform.window:width()-sizeX)/2,(platform.window:height()-sizeY-15)/2
        platform.window:invalidate(xPos,yPos,sizeX,sizeY+39)
    else
        platform.window:invalidate()
    end
end

function Lib.Dialog.AddWindow(windowType,windowName,windowButtons,windowLayout,windowSize)
    table.insert(Lib.Dialog._windows,{wtype=windowType,name=windowName,buttons=windowButtons,layout=windowLayout,size=windowSize})
    Lib.Dialog.focus=-1
    platform.window:invalidate()
end

function Lib.Dialog.Current()
    return Lib.Dialog._windows[#Lib.Dialog._windows]
end
