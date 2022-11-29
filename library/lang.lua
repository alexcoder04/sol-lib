
-- check if variable is function
function Lib.Lang.IsRunnable(var)
    return (var ~= nil) and (type(var) == "function")
end

function Lib.Lang.ArrayContains(array, element)
    for _, v in ipairs(array) do
        if v == element then return true end
    end
    return false
end

function Lib.Lang.IsDigit(char)
    for _, d in ipairs({"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}) do
        if char == d then return true end
    end
    return false
end
