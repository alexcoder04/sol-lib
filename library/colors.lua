
-- A part of BetterLuaAPI by Adriweb was used
-- see <https://github.com/adriweb/BetterLuaAPI-for-TI-Nspire.git> for more useful functions

Lib.Colors = {
    Black = { 0, 0, 0 },
    Blue  = { 0, 0, 255 },
    Brown = { 165, 42, 42 },
    Cyan = { 0, 255, 255 },
    Darkblue = { 0, 0, 139 },
    Darkred = { 139, 0, 0 },
    Fuchsia = { 255, 0, 255 },
    Gold = { 255, 215, 0 },
    Gray = { 127, 127, 127 },
    Green = { 0, 255, 0 },
    Grey = { 127, 127, 127 },
    Lightblue = { 173, 216, 230 },
    Lightgreen = { 144, 238, 144 },
    Magenta = { 255, 0, 255 },
    Maroon = { 128, 0, 0 },
    Navyblue = { 159, 175, 223 },
    Orange = { 255, 165, 0 },
    Palegreen = { 152, 251, 152 },
    Pink = { 255, 192, 203 },
    Purple = { 128, 0, 128 },
    Red = { 255, 0, 0 },
    Royalblue = { 65, 105, 225 },
    Salmon = { 250, 128, 114 },
    Seagreen = { 46, 139, 87 },
    Silver = { 192, 192, 192 },
    Turquoise = { 64, 224, 208 },
    Violet = { 238, 130, 238 },
    White = { 255, 255, 255 },
    Yellow = { 255, 255, 0 }
}

function Lib.Colors.UpdateColorscheme()
    for key, val in pairs(App.Gui[_get_colorscheme()]) do
        Lib.Colors[key] = val
    end
    platform.window:invalidate()
end

function Lib.Colors.DarkModeOn()
    App.Gui.DarkMode = true
    Lib.Colors.UpdateColorscheme()
end

function Lib.Colors.DarkModeOff()
    App.Gui.DarkMode = false
    Lib.Colors.UpdateColorscheme()
end

function Lib.Colors.DarkModeToggle()
    App.Gui.DarkMode = not App.Gui.DarkMode
    Lib.Colors.UpdateColorscheme()
end

function Lib.Colors.Parse(c)
    if type(c) == "table" then return unpack(c) end
    if type(c) == "string" then return unpack(Lib.Colors[c]) end
    return 0, 0, 0
end

function _get_colorscheme()
    if App.Gui.DarkMode then
        return "DarkColorscheme"
    end
    return "LightColorscheme"
end
