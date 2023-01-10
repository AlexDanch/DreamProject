sub init()
    _subViews()
end sub

sub _subViews()
    m._screenApeareAnimation = m.top.findNode("screenApeareAnimation")
    m._screenApeareAnimation.control = "run"
end sub