sub init()
    _subViews()
end sub

sub _subViews()
    m._menu = m.top.findNode("menu")
    m.top.observeField("focusedChild", "onFocusedChild")
    ' m._screenApeareAnimation = m.top.findNode("screenApeareAnimation")
    ' m._screenApeareAnimation.control = "run"
end sub

sub onFocusedChild()
    if m.top.hasFocus()
        m._menu.setFocus(true)
    end if
end sub