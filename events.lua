
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
    App:_onClick(x, y)
    platform.window:invalidate()
end

function on.timer()
    if App:_update() then
        platform.window:invalidate()
    end
end

function on.save()
    return App.Data.Var
end
