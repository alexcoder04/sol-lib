
function Lib.Dialog._mouse_down(xPos,yPos)
    if Lib.Dialog.NbWindows()>=1 then
        local window=Lib.Dialog.Current()
        if window.size then
            local sizeX,sizeY=unpack(window.size)
            local x,y=(platform.window:width()-sizeX)/2,(platform.window:height()-sizeY-15)/2
            if xPos>x and xPos<x+sizeX and yPos>y then
                gui.saveTextBox()
                if yPos<y+sizeY and Lib.Dialog.Current().wtype=="custom" then
                    gui.setFocus(xPos-x,yPos-y,window)
                elseif yPos>y+sizeY and yPos<y+sizeY+39 then
                    gui.buttonDown(xPos,yPos,window.buttons)
                end
            end
        end
    end
end

function Lib.Dialog._paint(gc)
    for i,e in pairs(gui.windows) do
        gui[e.wtype].paint(gc,e,i)
    end
    gui.resized=false
end

function Lib.Dialog._resize()
    gui.resized=true
end

function Lib.Dialog._tab_key()
    if Lib.Dialog.NbWindows()>0 then
        gui.saveTextBox()
        gui.moveFocus(1)
        Lib.Dialog.RefreshCurrent()
    end
end

function Lib.Dialog._back_tab_key()
    if Lib.Dialog.NbWindows()>0 then
        gui.saveTextBox()
        gui.moveFocus(-1)
        Lib.Dialog.RefreshCurrent()
    end
end

function Lib.Dialog._arrow_key(arrow)
    if Lib.Dialog.NbWindows()>0 then
        if gui.focus<0 then
            if arrow=="left" then
                gui.moveFocus(-1)
                Lib.Dialog.RefreshCurrent()
            elseif arrow=="right" then
                gui.moveFocus(1)
                Lib.Dialog.RefreshCurrent()
            end
        elseif gui.focus>0 then
            local currentElem=Lib.Dialog.Current().layout[gui.focus]
            if gui[currentElem[1]].arrowKey then
                gui[currentElem[1]].arrowKey(arrow,currentElem)
                Lib.Dialog.RefreshCurrent()
            end
        end
    end
end

function Lib.Dialog._enter_key()
    if Lib.Dialog.NbWindows()>0 then
        if gui.focus<0 then
            Lib.Dialog.Current().buttons[-gui.focus][2]()
        elseif Lib.Dialog.Current().wtype=="custom" then
            gui.OKButton()
        end
    end
end

function Lib.Dialog._char_in(char)
    if Lib.Dialog.NbWindows()>0 then
        if gui.focus>0 then
            local currentElem=Lib.Dialog.Current().layout[gui.focus]
            if gui[currentElem[1]].charIn then
                gui[currentElem[1]].charIn(char,currentElem)
                Lib.Dialog.RefreshCurrent()
            end
        end
    end
end

function Lib.Dialog._backspace_key()
    if Lib.Dialog.NbWindows()>0 then
        if gui.focus>0 then
            local currentElem=Lib.Dialog.Current().layout[gui.focus]
            if gui[currentElem[1]].backspaceKey then
                gui[currentElem[1]].backspaceKey(currentElem)
                Lib.Dialog.RefreshCurrent()
            end
        end
    end
end

function Lib.Dialog._escape_key()
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog.CloseWindow()
    end
end
