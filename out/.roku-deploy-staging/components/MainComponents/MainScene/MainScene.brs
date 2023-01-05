sub init()
   _subViews()
end sub

sub _subViews()
   m.loginScreen = m.top.findNode("loginScreen")
   m.loginScreen.setFocus(true)
end sub