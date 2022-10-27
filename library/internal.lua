
function Lib.Internal.ShowAboutDialog()
    Lib.Dialog.AddTextWindow("About "..App.Name, "Author: "..App.Author.."\nLicense: "..App.License.."\nHomepage: "..App.Homepage)
    Lib.Dialog.AddButton("Close",function() Lib.Dialog.CloseWindow() end)
end

function Lib.Internal.IsRunnable(var)
    return (var ~= nil) and (type(var) == "function")
end
