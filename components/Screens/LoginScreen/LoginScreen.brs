sub init()
   subViews()
   observeFields()
end sub

sub subViews()
   m.login = m.top.findNode("login")
   m.password = m.top.findNode("password")
end sub

sub observeFields()
   m.login.observeField("createKeyboard", "onLoginKeyboardSetup")
   m.password.observeField("createKeyboard", "onPasswordKeyboardSetup")
end sub

sub onLoginKeyboardSetup()
   m.loginHighlight = "Ninja Login"
   if m.login.text <> "Enter Your Ninja Login"
      m.inputText = m.login.text
   end if
   m.activeBox = m.login
   createKeyboard()
end sub

sub onPasswordKeyboardSetup()
   m.loginHighlight = "Ninja Password"
   if m.password.text <> "Enter Your Ninja Password"
      m.inputText = m.password.text
   end if
   m.activeBox = m.password
   createKeyboard()
end sub

sub createKeyboard()
    m.keyboard = CreateObject("roSgNode", "KeyboardDialog")
    if  m.activeBox.text <> "Enter Your Ninja Login" AND m.activeBox.text <> "Enter Your Ninja Password" 
      textLangth = Len(m.activeBox.text)
      m.keyboard.keyboard.textEditBox.cursorPosition = textLangth
    end if
    m.keyboard.buttons = ["OK", "Cancel"]
    m.keyboard.setFields({
       text: m.inputText
       buttons: ["OK", "Cancel"]
       title: m.loginHighlight
       titleColor: "#960018"
       width: 1920
       maxHeight: 1080
    })  
    m.keyboard.observeField("buttonSelected", "onButtonSelected")
    m.top.appendChild(m.keyboard)
    m.keyboard.setFocus(true)
end sub

sub onButtonSelected(event)
   buttonIndex = event.getData()
   if buttonIndex = 0
       text = m.keyboard.text
       m.password.text = m.activeBox
   end if
   if Len(m.activeBox.text) <> 0
        m.activeBox.text = m.keyboard.text
        m.activeBox.color = "#FF0000"
   else 
      if m.activeBox.id = "login"
         m.activeBox.text = "Enter Your Ninja Login"
      else
         m.activeBox.text = "Enter Your Ninja Password"
      end if
      m.activeBox.color = "#ffffff"
   end if
   m.top.removeChild(m.keyboard)
   m.keyboard = invalid
   m.activeBox.setFocus(true)
end sub