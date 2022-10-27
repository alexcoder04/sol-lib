
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
    if App._focused == 0 then
        if Lib.Internal.IsRunnable(App.Hooks.EnterKey) then
            if App.Hooks.EnterKey(c) then
                platform.window:invalidate()
            end
        end
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
    App:_change_focused(true)
end

function on.backtabKey()
    if Lib.Dialog.AreWinsOpen() then
        Lib.Dialog._back_tab_key()
        return
    end
    App:_change_focused(false)
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
        if Lib.Internal.IsRunnable(App.Hooks.CharIn) then
            if App.Hooks.CharIn(c) then
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
        if Lib.Internal.IsRunnable(App.Hooks.Backspace) then
            if App.Hooks.Backspace() then
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
