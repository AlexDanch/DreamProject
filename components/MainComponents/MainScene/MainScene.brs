sub init()
   _subViews()
   _onScreenShow()
end sub

sub  _onScreenShow()
   userLogined = RegRead("acssesToken", "DreamProject")
   if userLogined 
      appendHomeScreen()
   else 
      appendLoginScreen()
   end if
end sub

sub _subViews()
   ' m.loginScreen = m.top.findNode("loginScreen")
   ' m.loginScreen.setFocus(true)
end sub

sub appendHomeScreen()
    m._homeScreen = CreateObject("roSgNode", "HomeScreen")
    m.top.appendChild(m._homeScreen)
    m._homeScreen.setFocus(true)
    m._homeScreen.observeField("exitUser", "_onUserExit")
    if m._loginScreen <> invalid
        m.top.removeChild(m._loginScreen)
    end if
end sub 

sub appendLoginScreen()
   m._loginScreen = CreateObject("roSgNode", "LoginScreen")
   m.top.appendChild(m._loginScreen)
   m._loginScreen.observeField("userLoggin", "_onScreenShow")
   m._loginScreen.setFocus(true)
   if m._homeScreen <> invalid
      m.top.removeChild(m._homeScreen)
  end if
end sub

sub _onUserExit()
   RegDelete("acssesToken", "DreamProject")
  _onScreenShow()
end sub