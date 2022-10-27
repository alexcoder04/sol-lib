
function Lib.Dialog._mouse_down(xPos,yPos)
    if Lib.Dialog.NbWindows()>=1 then
        local window=Lib.Dialog.Current()
        if window.size then
            local sizeX,sizeY=unpack(window.size)
            local x,y=(platform.window:width()-sizeX)/2,(platform.window:height()-sizeY-15)/2
            if xPos>x and xPos<x+sizeX and yPos>y then
                Lib.Dialog._save_text_box()
                if yPos<y+sizeY and Lib.Dialog.Current().wtype=="custom" then
                    Lib.Dialog._set_focus(xPos-x,yPos-y,window)
                elseif yPos>y+sizeY and yPos<y+sizeY+39 then
                    Lib.Dialog._button_down(xPos,yPos,window.buttons)
                end
            end
        end
    end
end

function Lib.Dialog._paint(gc)
    for i,e in pairs(Lib.Dialog._windows) do
        Lib.Dialog[e.wtype].paint(gc,e,i)
    end
    Lib.Dialog._resized=false
end

function Lib.Dialog._resize()
    Lib.Dialog._resized=true
end

function Lib.Dialog._tab_key()
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._save_text_box()
        Lib.Dialog._move_focus(1)
        Lib.Dialog.RefreshCurrent()
    end
end

function Lib.Dialog._back_tab_key()
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._save_text_box()
        Lib.Dialog._move_focus(-1)
        Lib.Dialog.RefreshCurrent()
    end
end

function Lib.Dialog._arrow_key(arrow)
    if Lib.Dialog.NbWindows()>0 then
        if Lib.Dialog.focus<0 then
            if arrow=="left" then
                Lib.Dialog._move_focus(-1)
                Lib.Dialog.RefreshCurrent()
            elseif arrow=="right" then
                Lib.Dialog._move_focus(1)
                Lib.Dialog.RefreshCurrent()
            end
        elseif Lib.Dialog.focus>0 then
            local currentElem=Lib.Dialog.Current().layout[Lib.Dialog.focus]
            if Lib.Dialog[currentElem[1]].arrowKey then
                Lib.Dialog[currentElem[1]].arrowKey(arrow,currentElem)
                Lib.Dialog.RefreshCurrent()
            end
        end
    end
end

function Lib.Dialog._enter_key()
    if Lib.Dialog.NbWindows()>0 then
        if Lib.Dialog.focus<0 then
            Lib.Dialog.Current().buttons[-Lib.Dialog.focus][2]()
        elseif Lib.Dialog.Current().wtype=="custom" then
            Lib.Dialog._ok_button()
        end
    end
end

function Lib.Dialog._char_in(char)
    if Lib.Dialog.NbWindows()>0 then
        if Lib.Dialog.focus>0 then
            local currentElem=Lib.Dialog.Current().layout[Lib.Dialog.focus]
            if Lib.Dialog[currentElem[1]].charIn then
                Lib.Dialog[currentElem[1]].charIn(char,currentElem)
                Lib.Dialog.RefreshCurrent()
            end
        end
    end
end

function Lib.Dialog._backspace_key()
    if Lib.Dialog.NbWindows()>0 then
        if Lib.Dialog.focus>0 then
            local currentElem=Lib.Dialog.Current().layout[Lib.Dialog.focus]
            if Lib.Dialog[currentElem[1]].backspaceKey then
                Lib.Dialog[currentElem[1]].backspaceKey(currentElem)
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
