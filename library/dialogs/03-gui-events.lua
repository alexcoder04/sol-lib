
function gui.mouseDown(xPos,yPos)
 if gui.nbWindows()>=1 then
  local window=gui.current()
  if window.size then
   local sizeX,sizeY=unpack(window.size)
   local x,y=(width()-sizeX)/2,(height()-sizeY-15)/2
   if xPos>x and xPos<x+sizeX and yPos>y then
    gui.saveTextBox()
    if yPos<y+sizeY and gui.current().wtype=="custom" then
     gui.setFocus(xPos-x,yPos-y,window)
    elseif yPos>y+sizeY and yPos<y+sizeY+39 then
     gui.buttonDown(xPos,yPos,window.buttons)
    end
   end
  end
 end
end

function gui.paint(gc)
 for i,e in pairs(gui.windows) do
  gui[e.wtype].paint(gc,e,i)
 end
 gui.resized=false
end

function gui.resize()
 gui.resized=true
end

function gui.tabKey()
 if gui.nbWindows()>0 then
  gui.saveTextBox()
  gui.moveFocus(1)
  gui.refreshCurrent()
 end
end

function gui.backtabKey()
 if gui.nbWindows()>0 then
  gui.saveTextBox()
  gui.moveFocus(-1)
  gui.refreshCurrent()
 end
end

function gui.arrowKey(arrow)
 if gui.nbWindows()>0 then
  if gui.focus<0 then
   if arrow=="left" then
    gui.moveFocus(-1)
    gui.refreshCurrent()
   elseif arrow=="right" then
    gui.moveFocus(1)
    gui.refreshCurrent()
   end
  elseif gui.focus>0 then
   local currentElem=gui.current().layout[gui.focus]
   if gui[currentElem[1]].arrowKey then
    gui[currentElem[1]].arrowKey(arrow,currentElem)
    gui.refreshCurrent()
   end
  end
 end
end

function gui.enterKey()
 if gui.nbWindows()>0 then
  if gui.focus<0 then
   gui.current().buttons[-gui.focus][2]()
  elseif gui.current().wtype=="custom" then
   gui.OKButton()
  end
 end
end

function gui.charIn(char)
 if gui.nbWindows()>0 then
  if gui.focus>0 then
   local currentElem=gui.current().layout[gui.focus]
   if gui[currentElem[1]].charIn then
    gui[currentElem[1]].charIn(char,currentElem)
    gui.refreshCurrent()
   end
  end
 end
end

function gui.backspaceKey()
 if gui.nbWindows()>0 then
  if gui.focus>0 then
   local currentElem=gui.current().layout[gui.focus]
   if gui[currentElem[1]].backspaceKey then
    gui[currentElem[1]].backspaceKey(currentElem)
    gui.refreshCurrent()
   end
  end
 end
end

function gui.escapeKey()
 if gui.nbWindows()>0 then
  gui.closeWindow()
 end
end
