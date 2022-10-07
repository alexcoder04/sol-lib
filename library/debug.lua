
Lib.Debug.Buffer = nil
Lib.Debug.FlashRedraws = false

function Lib.Debug:Print(message)
    Lib.Debug.Buffer = message
    platform.window:invalidate()
end

function Lib.Debug:UnPrint()
    Lib.Debug.Buffer = nil
    platform.window:invalidate()
end
