
App = {
    _elements = {},
    name = "undefined",
    author = "unknown",
    license = "unknown",
    refreshRate = 10,
    solVersion = 0
}

function App:AddElement(element)
    table.insert(self._elements, element)
end

function App:_update()
    for i = 1, #(self._elements) do
        if self._elements[i].Update ~= nil then
            self._elements[i]:Update()
        end
    end
end

function App:_onClick(x, y)
    for i = 1, #(self._elements) do
        if self._elements[i]:_touches(x, y) then
            if self._elements[i].OnClick ~= nil then
                self._elements[i]:OnClick()
            end
        end
    end
end

function App:_draw(gc)
    for i = 1, #(self._elements) do
        self._elements[i]:_draw(gc)
    end
end

Hooks = {}
