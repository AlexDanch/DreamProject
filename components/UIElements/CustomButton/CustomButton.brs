sub init()
    m.top.focusable = true
    m.background = m.top.findNode("background")
    m.btnText = m.top.findNode("button_text")
    m.top.observeField("focusedChild", "onFocusedChild")
end sub

sub onCentrBtnText()
    m.btnText.width = m.background.width
    m.btnText.height = m.background.height
    m.btnText.horizAlign = "CENTER"
    m.btnText.vertAlign = "CENTER"
end sub

sub onFocusedChild()
     if m.top.hasFocus()
        m.background.blendColor="#800080"
     else
        m.background.blendColor="#b7410e"
     end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press
       if key="OK"
        m.top.itemSelected = true
       end if
    end if
    return result
end function
