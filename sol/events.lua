
function on.paint(gc)
    RootLayout:_draw(gc)
end

function on.construction()
    init()
end

function on.mouseDown(x, y)
    RootLayout:OnClick(x, y)
    platform.window:invalidate()
end

function on.timer()
    RootLayout:update()
    platform.window:invalidate()
end
