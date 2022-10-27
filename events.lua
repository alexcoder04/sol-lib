
function on.restore(state)
    App.Data.Var = state.data
    App.Gui.DarkMode = state.darkMode
end

function on.construction()
    math.randomseed(timer:getMilliSecCounter())
    timer.start(App.RefreshRate)
    App.Gui.LightColorscheme = {
        Background = Lib.Colors.White,
        Foreground = Lib.Colors.Black,
        Secondary = Lib.Colors.Grey,
        Accent = Lib.Colors.Blue
    }
    App.Gui.DarkColorscheme = {
        Background = Lib.Colors.Black,
        Foreground = Lib.Colors.White,
        Secondary = Lib.Colors.Silver,
        Accent = Lib.Colors.Blue
    }
    if init ~= nil then
        init()
    end
end

function on.paint(gc)
    App:_draw(gc)
    if Hooks.Paint ~= nil then
        Hooks:Paint(gc)
    end
    Lib.Dialog._paint(gc)
    if Lib.Debug.Buffer ~= nil then
        gc:setFont("sansserif", "r", 9)
        gc:drawString(Lib.Debug.Buffer, 0, 0, "top")
        gc:setFont("sansserif", "r", 12)
    end
    if Lib.Debug.FlashRedraws then
        gc:setColorRGB(math.random(255), math.random(255), math.random(255))
        gc:fillRect(platform.window:width() - 10, 0, 10, 10)
        gc:setColorRGB(0, 0, 0)
    end
end

function on.mouseDown(x, y)
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._mouse_down(x,y)
        return
    end
    App:_onMouseClick(x, y)
    platform.window:invalidate()
end

function on.enterKey()
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._enter_key()
        return
    end
    App:_onElementClick()
    platform.window:invalidate()
end

function on.arrowKey(ar)
    Lib.Dialog._arrow_key(ar)
end

function on.tabKey()
    if Lib.Dialog.NbWindows()>0 then
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
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._back_tab_key()
        return
    end
    -- TODO
end

function on.escapeKey()
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._escape_key()
        return
    end
    App._focused = 0
    platform.window:invalidate()
end

function on.charIn(c)
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._char_in(ch)
        return
    end
    if App._focused == 0 then
        if Hooks.CharIn ~= nil then
            if Hooks:CharIn(c) then
                platform.window:invalidate()
            end
        end
        return
    end
    if App._elements[App._focused].AcceptChar ~= nil then
        App._elements[App._focused]:AcceptChar(c)
        platform.window:invalidate()
    end
end

function on.backspaceKey()
    if Lib.Dialog.NbWindows()>0 then
        Lib.Dialog._backspace_key()
        return
    end
    if App._focused == 0 then
        if Hooks.Backspace ~= nil then
            if Hooks:Backspace() then
                platform.window:invalidate()
            end
        end
        return
    end
    if App._elements[App._focused].AcceptBackspace ~= nil then
        App._elements[App._focused]:AcceptBackspace()
        platform.window:invalidate()
    end
end

function on.resize()
    xScroll=0
    yScroll=0
    Lib.Dialog._resize()
end

function on.help()
    Lib.Internal.ShowAboutDialog()
end

function on.timer()
    if Lib.Timeout.Next ~= nil then
        Lib.Timeout.Next()
        Lib.Timeout.Next = nil
    end
    if App:_update() then
        platform.window:invalidate()
    end
end

function on.save()
    return {
        data = App.Data.Var,
        darkMode = App.Gui.DarkMode
    }
end
