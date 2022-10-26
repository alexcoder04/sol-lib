
--[[
window : {wtype,name,buttons,layout,size}
   --> wtype : "dialogBox","custom"
   --> size : {sizeX,sizeY} (only for custom)

buttons : {{"name",function1},{"name",function2},...}

layout : {{"type",...}}
   --> type : "label","textBox","colorSlider","list"

label : {text,x,y,color}
   --> if color is given, a color label is displayed

textBox : {text,x,y,sizeX,cursor,func}

colorSlider : {color,value,x,y,func}
   --> color : "red","green","blue"

list : {elements,scroll,x,y,sizeX,sizeY,selected,func}  ]]

gui={}
gui.windows={}
gui.dialogBox={}
gui.custom={}
gui.textBox={}
gui.colorSlider={}
gui.list={}
gui.resized=false
gui.img={}
gui.img.upButton=image.new("\011\000\000\000\010\000\000\000\000\000\000\000\022\000\000\000\016\000\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\000\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\000\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\000\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
gui.img.downButton=image.new("\011\000\000\000\010\000\000\000\000\000\000\000\022\000\000\000\016\000\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\000\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\000\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\000\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")