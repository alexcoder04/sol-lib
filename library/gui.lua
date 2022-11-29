
function Lib.Gui._getStringSize(str, gc)
    return gc:getStringWidth(str), gc:getStringHeight(str)
end

function Lib.Gui.GetStringSize(str)
    return platform.withGC(Lib.Gui._getStringSize, str)
end

function Lib.Gui.DrawFocusBox(x, y, w, h, gc)
    gc:setColorRGB(unpack(Lib.Colors.Blue))
    gc:drawRect(x, y, w, h)
    gc:setColorRGB(0, 0, 0)
end

function Lib.Gui.GenTextField(label, x, y)
    local tf = Components.Base.TextField:new()
    tf.Label = label
    tf.PosX = x
    tf.PosY = y
    return tf
end



-- mutiline string draw based on nSpaint GUI engine

function Lib.Gui.MultiLineStr.draw(gc,str,x,y)
    str=tostring(str)
    local table1={Lib.Gui.MultiLineStr.cut(str)}
    for i,e in pairs(table1) do
        gc:drawString(e,x,y+(i-1)*gc:getStringHeight("a"),"top")
    end
end

function Lib.Gui.MultiLineStr.width(gc,str)
    str=tostring(str)
    local table1={Lib.Gui.MultiLineStr.cut(str)}
    local table2={}
    for i,e in pairs(table1) do
        table2[i]=gc:getStringWidth(e)
    end
    table.sort(table2)
    return table2[#table2]
end

function Lib.Gui.MultiLineStr.height(gc,str)
    str=tostring(str)
    local table1={Lib.Gui.MultiLineStr.cut(str)}
    return gc:getStringHeight("a")*#table1
end

function Lib.Gui.MultiLineStr.cut(str)
    local table1,finished={},false
    local posStart,posEnd,last=1,0,1
    while not finished do
        posStart,posEnd=string.find(str,"\n",posEnd+1)
        if posStart then
            table.insert(table1,string.sub(str,last,posStart-1))
            last=posEnd+1
        else
            table.insert(table1,string.sub(str,last))
            finished=true
        end
    end
    return unpack(table1)
end
