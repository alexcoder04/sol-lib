
function on.paint(gc)
    RootLayout:_draw(gc)
end

function on.construction()
    init()
end

function on.timer()
    RootLayout:update()
    platform.window:invalidate()
end
