
improvedStr={}

function improvedStr.draw(gc,str,x,y)
 str=tostring(str)
 local table1={improvedStr.cut(str)}
 for i,e in pairs(table1) do
  gc:drawString(e,x,y+(i-1)*gc:getStringHeight("a"),"top")
 end
end

function improvedStr.width(gc,str)
 str=tostring(str)
 local table1={improvedStr.cut(str)}
 local table2={}
 for i,e in pairs(table1) do
  table2[i]=gc:getStringWidth(e)
 end
 table.sort(table2)
 return table2[#table2]
end

function improvedStr.height(gc,str)
 str=tostring(str)
 local table1={improvedStr.cut(str)}
 return gc:getStringHeight("a")*#table1
end

function improvedStr.cut(str)
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
