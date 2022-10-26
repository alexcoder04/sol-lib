
function gui.refreshCurrent()
 local current=gui.current()
 if current.size then
  local sizeX,sizeY=unpack(current.size)
  local xPos,yPos=(width()-sizeX)/2,(height()-sizeY-15)/2
  refresh(xPos,yPos,sizeX,sizeY+39)
 else
  refresh()
 end
end

function gui.addWindow(windowType,windowName,windowButtons,windowLayout,windowSize)
 table.insert(gui.windows,{wtype=windowType,name=windowName,buttons=windowButtons,layout=windowLayout,size=windowSize})
 gui.focus=-1
 refresh()
end

function gui.current()
 return gui.windows[#gui.windows]
end
