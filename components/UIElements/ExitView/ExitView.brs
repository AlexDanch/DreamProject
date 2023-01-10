sub init()
  _subViews()
  _observeFields()
end sub

sub _subViews()
    m._exitApply = m.top.findNode("exitApply")
    m._exitDecline = m.top.findNode("exitDecline")
    m._decision = m.top.findNode("decision")
end sub

sub _observeFields()
    m._exitApply.observeField("itemSelected", "_onExitBtnPressed")
    m._exitDecline.observeField("itemSelected", "_onDeclineBtnPressed")
end sub

sub _onExitBtnPressed()
    m.top.exitUser = true
end sub

sub _onDeclineBtnPressed()
    m._decision.visible = true
end sub