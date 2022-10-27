
function gui.executeFunction(element,arg)
 if element.func then
  element.func(arg)
 end
end

function gui.saveTextBox()
 local elem=Lib.Dialog.Current().layout[gui.focus]
 if elem then
  if elem[1]=="textBox" then
   gui.executeFunction(elem,elem.text)
  end
 end
end

function gui.moveFocus(nb)
 local currentWindow=Lib.Dialog.Current()
 local test=false
 local originalFocus=gui.focus
 nb=gui.focus<0 and -nb or nb
 gui.focus=gui.focus+nb
 if #currentWindow.buttons==0 then
  gui.focus=-1
  test=true
 end
 while not test do
  if gui.focus<0 then
   if -gui.focus<=#currentWindow.buttons then
    test=true
   else
    gui.focus=1
    nb=1
   end
  elseif gui.focus==0 then
   if originalFocus<0 then
    if currentWindow.wtype=="dialogBox" then
     gui.focus=-#currentWindow.buttons
     test=true
    elseif #currentWindow.layout==0 then
     gui.focus=-#currentWindow.buttons
     test=true
    else
     gui.focus=#currentWindow.layout
     nb=-1
    end
   else
    gui.focus=nb<0 and -#currentWindow.buttons or 1
   end
  else
   if currentWindow.wtype=="dialogBox" then
    test=true
    gui.focus=-1
   elseif currentWindow.wtype=="custom" then
    if gui.focus<=#currentWindow.layout then
     if currentWindow.layout[gui.focus][1]=="label" then
      gui.focus=gui.focus+(nb<0 and -1 or 1)
     else
      test=true
     end
    else
     test=true
     gui.focus=-1
    end
   end
  end
 end
end

function gui.buttonDown(x,y,buttons)
 for i,e in pairs(buttons) do
  if x>e.pos and x<e.pos+e.size then
   gui.focus=-i
   e[2]()
  end
 end
end

function gui.OKButton()
 local buttons=Lib.Dialog.Current().buttons
 for i=1,#buttons do
  if buttons[i][1]=="OK" then
   gui.saveTextBox()
   buttons[i][2]()
  end
 end
end

function gui.setFocus(x,y,window)
 for i,e in pairs(window.layout) do
  if e[1]=="list" then
   if x>e.x and y>e.y and x<e.x+e.sizeX and y<e.y+e.sizeY then
    gui.focus=i
    gui.list.mouseDown(e,x-e.x,y-e.y)
    Lib.Dialog.RefreshCurrent()
   end
  elseif e[1]=="textBox" then
   if x>e.x and y>e.y and x<e.x+e.sizeX and y<e.y+22 then
    gui.focus=i
    gui.textBox.mouseDown(e,x-e.x,y-e.y)
    Lib.Dialog.RefreshCurrent()
   end
  elseif e[1]=="colorSlider" then
   if x>e.x and y>e.y and x<e.x+68 and y<e.y+20 then
    gui.focus=i
    gui.colorSlider.mouseDown(e,x-e.x,y-e.y)
    Lib.Dialog.RefreshCurrent()
   end
  end
 end
end
