
function Lib.Internal.ShowAboutDialog()
    gui.addTextWindow("About "..App.Name, "Author: "..App.Author.."\nLicense: "..App.License.."\nHomepage: "..App.Homepage)
    gui.addButton("Close",function() gui.closeWindow() end)
end
