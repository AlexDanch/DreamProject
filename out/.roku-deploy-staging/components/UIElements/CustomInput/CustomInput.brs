sub init()
    subViews()
end sub

sub subViews()
    m.opacityAnimation = m.top.findNode("opacityAnimation")
    m.top.observeField("focusedChild", "onFocusedChild")
    m.customRect = m.top.findNode("customRect")
end sub

sub onFocusedChild()
    if m.top.hasFocus()
        m.opacityAnimation.control = "start" 
    else
        m.opacityAnimation.control = "stop" 
        m.customRect.opacity = 0.0 
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press
       if key="OK"
          m.top.createKeyboard = true
       end if
    end if
    return result
end function
