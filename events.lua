
function on.restore(state)
    App.Data.Var = state
end

function on.construction()
    math.randomseed(timer:getMilliSecCounter())
    timer.start(App.RefreshRate)
    if init ~= nil then
        init()
    end
end

function on.paint(gc)
    App:_draw(gc)
    if Hooks.Paint ~= nil then
        Hooks:Paint(gc)
    end
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
    App:_onMouseClick(x, y)
    platform.window:invalidate()
end

function on.enterKey()
    App:_onElementClick()
    platform.window:invalidate()
end

function on.tabKey()
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

function on.escapeKey()
    App._focused = 0
    platform.window:invalidate()
end

function on.charIn(c)
    if App._focused == 0 then
        if Hooks.CharIn ~= nil then
            Hooks:CharIn(c)
        end
        return
    end
    if App._elements[App._focused].AcceptChar ~= nil then
        App._elements[App._focused]:AcceptChar(c)
        platform.window:invalidate()
    end
end

function on.backspaceKey()
    if App._focused == 0 then
        if Hooks.Backspace ~= nil then
            Hooks:Backspace()
        end
        return
    end
    if App._elements[App._focused].AcceptBackspace ~= nil then
        App._elements[App._focused]:AcceptBackspace()
        platform.window:invalidate()
    end
end

function on.timer()
    if App:_update() then
        platform.window:invalidate()
    end
end

function on.save()
    return App.Data.Var
end
