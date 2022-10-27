
function on.mouseDown(x, y)
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._mouse_down(x,y)
        return
    end
    App:_onMouseClick(x, y)
    platform.window:invalidate()
end

function on.enterKey()
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._enter_key()
        return
    end
    App:_onElementClick()
    platform.window:invalidate()
end

function on.arrowKey(ar)
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._arrow_key(ar)
        return
    end
end

function on.tabKey()
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._tab_key()
        return
    end
    local foc = App._focused + 1
    for i = 1, #(App._elements) do
        if foc > #(App._elements) then
            foc = 1
        end
        if not App._elements[foc].Hidden then
            App._focused = foc
            platform.window:invalidate()
            return
        end
        foc = foc + 1
    end
    App._focused = 0
    platform.window:invalidate()
end

function on.backtabKey()
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._back_tab_key()
        return
    end
    local foc = App._focused - 1
    for i = 1, #(App._elements) do
        if foc < 1 then
            foc = #(App._elements)
        end
        if not App._elements[foc].Hidden then
            App._focused = foc
            platform.window:invalidate()
            return
        end
        foc = foc - 1
    end
    App._focused = 0
    platform.window:invalidate()
end

function on.escapeKey()
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._escape_key()
        return
    end
    App._focused = 0
    platform.window:invalidate()
end

function on.charIn(c)
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._char_in(ch)
        return
    end
    if App._focused == 0 then
        if Lib.Internal.IsRunnable(Hooks.CharIn) then
            if Hooks.CharIn(c) then
                platform.window:invalidate()
            end
        end
        return
    end
    if Lib.Internal.IsRunnable(App._elements[App._focused].AcceptChar) then
        App._elements[App._focused]:AcceptChar(c)
        platform.window:invalidate()
    end
end

function on.backspaceKey()
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._backspace_key()
        return
    end
    if App._focused == 0 then
        if Lib.Internal.IsRunnable(Hooks.Backspace) then
            if Hooks.Backspace() then
                platform.window:invalidate()
            end
        end
        return
    end
    if Lib.Internal.IsRunnable(App._elements[App._focused].AcceptBackspace) then
        App._elements[App._focused]:AcceptBackspace()
        platform.window:invalidate()
    end
end

function on.help()
    Lib.Internal.ShowAboutDialog()
end
