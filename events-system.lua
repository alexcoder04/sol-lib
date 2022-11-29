
function on.restore(state)
    App.Data.Var = state.data
    App.Gui.DarkMode = state.darkMode
    Lib.Colors.UpdateColorscheme()
    document.markChanged()
end

function on.construction()
    math.randomseed(timer:getMilliSecCounter())
    timer.start(App.RefreshRate)

    if Lib.Lang.IsRunnable(App.Interactions.Copy) then toolpalette.enableCopy(true) end
    if Lib.Lang.IsRunnable(App.Interactions.Cut) then toolpalette.enableCut(true) end
    if Lib.Lang.IsRunnable(App.Interactions.Paste) then toolpalette.enablePaste(true) end

    if Lib.Lang.IsRunnable(init) then
        init()
    end
end

function on.paint(gc)
    -- 1) components
    App:_draw(gc)

    -- 2) hooks
    if Lib.Lang.IsRunnable(App.Hooks.Paint) then
        App.Hooks.Paint(gc)
    end

    -- 3) dialog windows
    Lib.Dialog._paint(gc)

    -- 4) debug
    if (Lib.Debug.Buffer ~= nil) and (type(Lib.Debug.Buffer) == "string") then
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

function on.resize()
    Lib.Dialog._resize()
end

function on.timer()
    if Lib.Lang.IsRunnable(Lib.Timeout.Next) then
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
