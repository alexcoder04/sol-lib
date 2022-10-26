
function gui.errorMessage(errorText)
 gui.addWindow("dialogBox","Error",{{"OK",function() gui.closeWindow() end}},errorText)
end

function gui.addTextWindow(title,text)
 gui.addWindow("dialogBox",title,{},text)
end

function gui.addCustomWindow(title,width,height)
 gui.addWindow("custom",title,{},{},{width,height})
end

function gui.addButton(text,buttonFunction)
 table.insert(gui.current().buttons,{text,buttonFunction})
end

function gui.addTextBox(xPos,yPos,width,initialText,textBoxFunction)
 if gui.current().wtype=="custom" then
  table.insert(gui.current().layout,{"textBox",text=initialText,x=xPos,y=yPos,sizeX=width,cursor=0,func=textBoxFunction})
 end
end

function gui.addLabel(xPos,yPos,labelText,labelColor)
 if gui.current().wtype=="custom" then
  table.insert(gui.current().layout,{"label",text=labelText,x=xPos,y=yPos,color=labelColor})
 end
end

function gui.addSlider(xPos,yPos,sliderColor,initialValue,sliderFunction)
 if gui.current().wtype=="custom" then
  table.insert(gui.current().layout,{"colorSlider",value=initialValue,x=xPos,y=yPos,color=sliderColor,func=sliderFunction})
 end
end

function gui.addList(xPos,yPos,width,height,listElements,listFunction)
 if gui.current().wtype=="custom" then
  table.insert(gui.current().layout,{"list",x=xPos,y=yPos,sizeX=width,sizeY=height,scroll=0,selected=1,elements=listElements,func=listFunction})
 end
end

function gui.closeWindow()
 table.remove(gui.windows)
 gui.defaultFocus()
 refresh()
end

function gui.nbWindows()
 return #gui.windows
end

function gui.defaultFocus()
 if gui.nbWindows()>0 then
  gui.focus=-#gui.current().buttons
  gui.moveFocus(1)
  gui.focus=gui.focus>0 and gui.focus or -1
 end
end
