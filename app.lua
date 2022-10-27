
App = {
    _elements = {},
    _focused = 0,
    Name = "sol-app",
    Author = "unknown",
    License = "unknown",
    Homepage = "unknown",
    RefreshRate = 10,
    SolVersion = 0,
    Hooks = {},
    Gui = {
        DarkMode = false,
        LightColorscheme = {},
        DarkColorscheme = {}
    },
    Data = {
        Const = {},
        Var = {}
    }
}

function App:AddElement(element)
    table.insert(self._elements, element)
end

function App:_update()
    local redraw_required = false
    for i = 1, #(self._elements) do
        if Lib.Internal.IsRunnable(self._elements[i].Update) then
            if self._elements[i]:Update() then
                redraw_required = true
            end
        end
    end
    return redraw_required
end

function App:_onMouseClick(x, y)
    for i = 1, #(self._elements) do
        if self._elements[i]:_touches(x, y) and (not self._elements[i].Hidden) then
            if Lib.Internal.IsRunnable(self._elements[i].OnClick) then
                self._elements[i]:OnClick()
            end
        end
    end
end

function App:_onElementClick()
    if self._focused == 0 then return end
    if Lib.Internal.IsRunnable(self._elements[self._focused].OnClick) then
        self._elements[self._focused]:OnClick()
    end
end

function App:_draw(gc)
    if Lib.Colors.Background ~= Lib.Colors.White then
        gc:setColorRGB(unpack(Lib.Colors.Background))
        gc:fillRect(0, 0, platform.window:width(), platform.window:height())
        gc:setColorRGB(0, 0, 0)
    end
    for i = 1, #(self._elements) do
        if not self._elements[i].Hidden then
            self._elements[i]:_draw(gc, self._focused == i)
        end
    end
end
