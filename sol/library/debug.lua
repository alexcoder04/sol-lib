
Library.Debug.Buffer = nil
Library.Debug.FlashRedraws = false

function Library.Debug:Print(message)
    Library.Debug.Buffer = message
    platform.window:invalidate()
end

function Library.Debug:UnPrint()
    Library.Debug.Buffer = nil
    platform.window:invalidate()
end
