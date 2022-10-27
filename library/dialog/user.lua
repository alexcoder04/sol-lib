
function Lib.Dialog.ErrorMessage(errorText)
    Lib.Dialog.AddWindow("dialogBox","Error",{{"OK",function() Lib.Dialog.CloseWindow() end}},errorText)
end

function Lib.Dialog.AddTextWindow(title,text)
    Lib.Dialog.AddWindow("dialogBox",title,{},text)
end

function Lib.Dialog.AddCustomWindow(title,width,height)
    Lib.Dialog.AddWindow("custom",title,{},{},{width,height})
end

function Lib.Dialog.AddButton(text,buttonFunction)
    table.insert(Lib.Dialog.Current().buttons,{text,buttonFunction})
end

function Lib.Dialog.AddTextBox(xPos,yPos,width,initialText,textBoxFunction)
    if Lib.Dialog.Current().wtype=="custom" then
        table.insert(Lib.Dialog.Current().layout,{"textBox",text=initialText,x=xPos,y=yPos,sizeX=width,cursor=0,func=textBoxFunction})
    end
end

function Lib.Dialog.AddLabel(xPos,yPos,labelText,labelColor)
    if Lib.Dialog.Current().wtype=="custom" then
        table.insert(Lib.Dialog.Current().layout,{"label",text=labelText,x=xPos,y=yPos,color=labelColor})
    end
end

function Lib.Dialog.AddSlider(xPos,yPos,sliderColor,initialValue,sliderFunction)
    if Lib.Dialog.Current().wtype=="custom" then
        table.insert(Lib.Dialog.Current().layout,{"colorSlider",value=initialValue,x=xPos,y=yPos,color=sliderColor,func=sliderFunction})
    end
end

function Lib.Dialog.AddList(xPos,yPos,width,height,listElements,listFunction)
    if Lib.Dialog.Current().wtype=="custom" then
        table.insert(Lib.Dialog.Current().layout,{"list",x=xPos,y=yPos,sizeX=width,sizeY=height,scroll=0,selected=1,elements=listElements,func=listFunction})
    end
end

function Lib.Dialog.CloseWindow()
    table.remove(gui.windows)
    Lib.Dialog.DefaultFocus()
    platform.window:invalidate()
end

function Lib.Dialog.NbWindows()
    return #gui.windows
end

function Lib.Dialog.DefaultFocus()
    if Lib.Dialog.NbWindows()>0 then
        gui.focus=-#Lib.Dialog.Current().buttons
        gui.moveFocus(1)
        gui.focus=gui.focus>0 and gui.focus or -1
    end
end
