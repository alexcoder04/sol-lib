
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
    table.insert(gui.windows,{wtype=windowType,name=windowName,buttons=windowButtons,layout=windowLayout,size=windowSize})
    gui.focus=-1
    platform.window:invalidate()
end

function Lib.Dialog.Current()
    return gui.windows[#gui.windows]
end
