
function Lib.Dialog.textBox.charIn(char,textBox)
    if string.len(char)==1 then
        textBox.prev={textBox.text,textBox.cursor}
        textBox.text=string.usub(textBox.text,1,textBox.cursor)..char..string.usub(textBox.text,textBox.cursor+1)
        textBox.cursor=textBox.cursor+1
    end
end

function Lib.Dialog.textBox.arrowKey(arrow,textBox)
    if arrow=="right" and textBox.cursor<string.len(textBox.text) then
        textBox.cursor=textBox.cursor+1
    elseif arrow=="left" and textBox.cursor>0 then
        textBox.cursor=textBox.cursor-1
    end
end

function Lib.Dialog.textBox.mouseDown(textBox,x)
    textBox.setCursor=x-2
end

function Lib.Dialog.textBox.backspaceKey(textBox)
    if string.len(textBox.text)>0 and textBox.cursor>0 then
        textBox.text=string.usub(textBox.text,1,textBox.cursor-1)..string.usub(textBox.text,textBox.cursor+1)
        textBox.cursor=textBox.cursor-1
    end
end

function Lib.Dialog.colorSlider.arrowKey(arrow,slider)
    if arrow=="right" then
        slider.value=slider.value<250 and slider.value+5 or 255
        Lib.Dialog._execute_func(slider,slider.value)
    elseif arrow=="left" then
        slider.value=slider.value>5 and slider.value-5 or 0
        Lib.Dialog._execute_func(slider,slider.value)
    end
end

function Lib.Dialog.colorSlider.mouseDown(slider,x)
    x=(x-2)*4
    x=x>0 and x or 0
    x=x<255 and x or 255
    slider.value=x
    Lib.Dialog._execute_func(slider,slider.value)
end

function Lib.Dialog.list.arrowKey(arrow,list)
    if arrow=="up" and list.selected>1 then
        list.selected=list.selected-1
        Lib.Dialog._execute_func(list,list.elements[list.selected])
    elseif arrow=="down" and list.selected<#list.elements then
        list.selected=list.selected+1
        Lib.Dialog._execute_func(list,list.elements[list.selected])
    end
end

function Lib.Dialog.list.mouseDown(list,x,y)
    if #list.elements>0 then
        if x>list.sizeX-17 then
            if y>list.sizeY/2 and list.selected<#list.elements then
                list.selected=list.selected+1
                Lib.Dialog._execute_func(list,list.elements[list.selected])
            elseif y<list.sizeY/2 and list.selected>1 then
                list.selected=list.selected-1
                Lib.Dialog._execute_func(list,list.elements[list.selected])
            end
        elseif list.fontHeight  then
            list.selected=math.floor(y/list.fontHeight)+1+list.scroll
            list.selected=list.selected<#list.elements and list.selected or #list.elements
            Lib.Dialog._execute_func(list,list.elements[list.selected])
        end
    end
end
