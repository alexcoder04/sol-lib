
function Lib.Internal.ShowAboutDialog()
    Lib.Dialog.AddTextWindow("About "..App.Name, "Author: "..App.Author.."\nLicense: "..App.License.."\nHomepage: "..App.Homepage)
    Lib.Dialog.AddButton("Close",function() Lib.Dialog.CloseWindow() end)
end

-- check if variable is function
function Lib.Internal.IsRunnable(var)
    return (var ~= nil) and (type(var) == "function")
end

function Lib.Internal.ArrayContains(array, element)
    for _, v in ipairs(array) do
        if v == element then return true end
    end
    return false
end

function Lib.Internal.IsDigit(char)
    for _, d in ipairs({"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}) do
        if char == d then return true end
    end
    return false
end

function Lib.Internal.NormalizeNumber(num)
    local offset
    while num:sub(1,2) == "--" do
        num = num:sub(2,#(num))
    end
    if num:sub(1,1) == "-" then
        offset = 2
    else
        offset = 1
    end

    while num:sub(offset,offset) == "0" do
        num = num:sub(offset+1,#(num))
    end

    if num == "" then return "0" end
    if num:sub(1,1) == "." then num = "0" .. num end
    return num
end
