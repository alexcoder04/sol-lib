
function Lib.Dialog._execute_func(element,arg)
    if not element.func then return end
    element.func(arg)
end

function Lib.Dialog._save_text_box()
    local elem=Lib.Dialog.Current().layout[Lib.Dialog.focus]
    if elem and (elem[1] == "textBox") then
        Lib.Dialog._execute_func(elem,elem.text)
    end
end

function Lib.Dialog._move_focus(nb)
    local currentWindow=Lib.Dialog.Current()
    local test=false
    local originalFocus=Lib.Dialog.focus
    nb=Lib.Dialog.focus<0 and -nb or nb
    Lib.Dialog.focus=Lib.Dialog.focus+nb
    if #currentWindow.buttons==0 then
        Lib.Dialog.focus=-1
        test=true
    end
    while not test do
        if Lib.Dialog.focus<0 then
            if -Lib.Dialog.focus<=#currentWindow.buttons then
                test=true
            else
                Lib.Dialog.focus=1
                nb=1
            end
            return
        end

        if Lib.Dialog.focus==0 then
            if originalFocus<0 then
                if currentWindow.wtype=="dialogBox" then
                    Lib.Dialog.focus=-#currentWindow.buttons
                    test=true
                elseif #currentWindow.layout==0 then
                    Lib.Dialog.focus=-#currentWindow.buttons
                    test=true
                else
                    Lib.Dialog.focus=#currentWindow.layout
                    nb=-1
                end
            else
                Lib.Dialog.focus=nb<0 and -#currentWindow.buttons or 1
            end
            return
        end
        
        if currentWindow.wtype=="dialogBox" then
            test=true
            Lib.Dialog.focus=-1
            return
        end

        if currentWindow.wtype=="custom" then
            if Lib.Dialog.focus<=#currentWindow.layout then
                if currentWindow.layout[Lib.Dialog.focus][1]=="label" then
                    Lib.Dialog.focus=Lib.Dialog.focus+(nb<0 and -1 or 1)
                else
                    test=true
                end
            else
                test=true
                Lib.Dialog.focus=-1
            end
        end
    end
end

function Lib.Dialog._button_down(x,y,buttons)
    for i,e in pairs(buttons) do
        if x>e.pos and x<e.pos+e.size then
            Lib.Dialog.focus=-i
            e[2]()
        end
    end
end

function Lib.Dialog._ok_button()
    local buttons=Lib.Dialog.Current().buttons
    for i=1,#buttons do
        if buttons[i][1]=="OK" then
            Lib.Dialog._save_text_box()
            buttons[i][2]()
        end
    end
end

function Lib.Dialog._set_focus(x,y,window)
    for i,e in pairs(window.layout) do
        if e[1]=="list" then
            if x>e.x and y>e.y and x<e.x+e.sizeX and y<e.y+e.sizeY then
                Lib.Dialog.focus=i
                Lib.Dialog.list.mouseDown(e,x-e.x,y-e.y)
                Lib.Dialog.RefreshCurrent()
            end
            return
        end

        if e[1]=="textBox" then
            if x>e.x and y>e.y and x<e.x+e.sizeX and y<e.y+22 then
                Lib.Dialog.focus=i
                Lib.Dialog.textBox.mouseDown(e,x-e.x,y-e.y)
                Lib.Dialog.RefreshCurrent()
            end
            return
        end

        if e[1]=="colorSlider" then
            if x>e.x and y>e.y and x<e.x+68 and y<e.y+20 then
                Lib.Dialog.focus=i
                Lib.Dialog.colorSlider.mouseDown(e,x-e.x,y-e.y)
                Lib.Dialog.RefreshCurrent()
            end
            return
        end
    end
end
