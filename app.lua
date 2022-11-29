
-- initialize App table
App = {
    _elements = {},
    _focused = 0,
    Name = "sol-app",
    Author = "unknown",
    License = "unknown",
    Homepage = "unknown",
    RefreshRate = 10,
    SolVersion = "unknown",
    Hooks = {},
    Gui = {
        DarkMode = false,
        LightColorscheme = {},
        DarkColorscheme = {}
    },
    Interactions = {},
    Data = {
        Const = {},
        Var = {}
    }
}

-- register element and return its id
function App:AddElement(element)
    table.insert(self._elements, element)
    return #(self._elements)
end

-- execute a function as if it is running on an element
function App:ElementExec(id, callback)
    if id > #(self._elements) or id < 1 or (not Lib.Internal.IsRunnable(callback)) then return end
    return callback(self._elements[id])
end

function App:ElValGet(id, key)
    if id > #(self._elements) or id < 1 then return end
    return App._elements[id][key]
end

function App:ElValSet(id, key, val)
    if id > #(self._elements) or id < 1 then return end
    App._elements[id][key] = val
end

-- initialize colorscheme, is called after Lib.Colors.* is initialized
function App:_init_coloscheme()
    self.Gui.LightColorscheme = {
        Background = Lib.Colors.White,
        Foreground = Lib.Colors.Black,
        Secondary = Lib.Colors.Grey,
        Accent = Lib.Colors.Blue
    }
    self.Gui.DarkColorscheme = {
        Background = Lib.Colors.Black,
        Foreground = Lib.Colors.White,
        Secondary = Lib.Colors.Silver,
        Accent = Lib.Colors.Blue
    }
end

-- dir=true => next, dir=false => prev
function App:_change_focused(dir)
    local foc
    if dir then
        foc = self._focused + 1
    else
        foc = self._focused - 1
    end

    for i = 1, #(self._elements) do
        if dir and (foc > #(self._elements)) then
            foc = 1
        elseif foc < 1 then
            foc = #(self._elements)
        end

        if not self._elements[foc].Hidden then
            self._focused = foc
            platform.window:invalidate()
            return
        end
        foc = foc + 1
    end
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
