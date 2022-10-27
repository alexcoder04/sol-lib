
function on.restore(state)
    App.Data.Var = state.data
    App.Gui.DarkMode = state.darkMode
    Lib.Colors.UpdateColorscheme()
    document.markChanged()
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
    Lib.Colors.UpdateColorscheme()

    if Lib.Internal.IsRunnable(init) then
        init()
    end
end

function on.paint(gc)
    App:_draw(gc)

    if Lib.Internal.IsRunnable(App.Hooks.Paint) then
        App.Hooks.Paint(gc)
    end

    Lib.Dialog._paint(gc)

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
    if Lib.Internal.IsRunnable(Lib.Timeout.Next) then
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
