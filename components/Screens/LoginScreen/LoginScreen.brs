sub init()
   m.requstObj = {
      login: "a@a.com"
      password: "Password"
   }
   subViews()
   observeFields()
end sub

sub subViews()
   m.signinBtn = m.top.findNode("signinBtn")
   m.signupBtn = m.top.findNode("signupBtn")
   m.login = m.top.findNode("login")
   m.password = m.top.findNode("password")
   m.errorMsg = m.top.findNode("errorMsg")
end sub

sub observeFields()
   m.signinBtn.observeField("itemSelected", "onBtnSignInPressed")
   m.signupBtn.observeField("itemSelected", "onBtnSingUpPressed")
   m.login.observeField("createKeyboard", "onLoginKeyboardSetup")
   m.password.observeField("createKeyboard", "onPasswordKeyboardSetup")
end sub

sub onBtnSignInPressed()
    isEmailValid = isValidEmail(m.requstObj.login)
    m.passwordCount = Len(m.requstObj.password)
    if isEmailValid And m.passwordCount > 7
       setUpPostRequest()
    else
       launchValidation(isEmailValid)
    end if
end sub

sub setUpPostRequest()
   ? "m.requstObj"  m.requstObj
   m.urlRequest = CreateObject("roSgNode", "UrlRequest")
   m.urlRequest.observeField("response", "onLoginResponseRecived")
   m.urlRequest.url = "https://43847d26-a572-4b8f-8dd4-65f5f1a82598.mock.pstmn.io/login"
   m.urlRequest.body =  m.requstObj
   m.urlRequest.control = "run"
end sub

sub onLoginResponseRecived(event)
      loginResponseRecieve = event.getData()
      if loginResponseRecieve.success 
         if IsString(loginResponseRecieve.accessToken)
           RegWrite("acssesToken",  loginResponseRecieve.accessToken)
           m.top.userLoggin = true
         else
            m.errorMsg.text = "You have one part wrong"
         end if
      end if
end sub

sub launchValidation(validEmail)
   if not validEmail
      m.errorMsg.text = "Enter your valid NinjaMail "
   else if m.passwordCount < 8 
      m.errorMsg.text = "Your password too short at least it should be 8 char "
   end if
end sub

sub onBtnSingUpPressed()
   m.errorMsg.text = "Hi ninja, we are here not to make signUp, we are here to make signIn"
end sub

sub onLoginKeyboardSetup()
   m.activiHg = "login"
   m.loginHighlight = "Ninja Login"
   if m.login.text <> "Enter Your Ninja Login"
      m.inputText = m.login.text
   end if
   m.activeBox = m.login
   createKeyboard()
end sub

sub onPasswordKeyboardSetup()
   m.activiHg = "password"
   m.loginHighlight = "Ninja Password"
   if m.password.text <> "Enter Your Ninja Password"
      m.inputText = m.password.text
   end if
   m.activeBox = m.password
   createKeyboard()
end sub

sub createKeyboard()
    m.keyboard = CreateObject("roSgNode", "KeyboardDialog")
    textLangth = Len(m.activeBox.text)
    m.keyboard.buttons = ["OK", "Cancel"]
    m.keyboard.setFields({
       text: m.inputText
       buttons: ["OK", "Cancel"]
       title: m.loginHighlight
       titleColor: "#960018"
       width: 1920
       maxHeight: 1080
    })  
    m.keyboard.keyboard.textEditBox.cursorPosition = textLangth
    m.keyboard.observeField("buttonSelected", "onButtonSelected")
    m.top.appendChild(m.keyboard)
    m.keyboard.setFocus(true)
end sub

sub onButtonSelected(event)
   buttonIndex = event.getData()
   text = m.keyboard.text
   textLangth = Len(text)
   if buttonIndex = 0
       if textLangth > 0
         m.requstObj.[m.activiHg] = text
         m.activeBox.hintVisibility = false
         m.activeBox.inputVisibility = true
       else
         m.activeBox.hintVisibility = true
         m.activeBox.inputVisibility = false
       end if
    else 
       if textLangth > 0 
         m.activeBox.hintVisibility = false
         m.activeBox.inputVisibility = true
       else
         m.activeBox.hintVisibility = true
         m.activeBox.inputVisibility = false
       end if
   end if
   m.activeBox.text = m.keyboard.text
   m.top.removeChild(m.keyboard)
   m.keyboard = invalid
   m.activeBox.setFocus(true)
end sub