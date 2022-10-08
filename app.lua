
App = {
    _elements = {},
    Name = "undefined",
    Author = "unknown",
    License = "unknown",
    RefreshRate = 10,
    SolVersion = 0,
    Data = {
        Const = {},
        Var = {}
    }
}

function App:AddElement(element)
    table.insert(self._elements, element)
end

function App:_update()
    redraw_required = false
    for i = 1, #(self._elements) do
        if self._elements[i].Update ~= nil then
            if self._elements[i]:Update() then
                redraw_required = true
            end
        end
    end
    return redraw_required
end

function App:_onClick(x, y)
    for i = 1, #(self._elements) do
        if self._elements[i]:_touches(x, y) and (not self._elements[i].Hidden) then
            if self._elements[i].OnClick ~= nil then
                self._elements[i]:OnClick()
            end
        end
    end
end

function App:_draw(gc)
    for i = 1, #(self._elements) do
        if not self._elements[i].Hidden then
            self._elements[i]:_draw(gc)
        end
    end
end

Hooks = {}
