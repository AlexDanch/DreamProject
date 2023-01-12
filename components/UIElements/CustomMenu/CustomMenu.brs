sub init()
    m.clean = false
    initViews()
    m.dataSource = [
        {screenName: "AppleAplePAsdasda"}
        {screenName: "Netflix"}
        {screenName: "NBA"}
        {screenName: "Setting"}
    ]
    _populateMenu()
    _centerMenu()
end sub

sub initViews()
     m._transInterpolator = m.top.findNode("transInterpolator")
     m._widthInterpolator = m.top.findNode("widthInterpolator")
     m._translationAnimation = m.top.findNode("parallelAnimation")
     m._menuBg = m.top.findNode("menu_Bg")
     m._translationAnimation.observeField("state", "_onStateChange")
     m._elementLayout = m.top.findNode("elementLayout")
     m._focusMirror = m.top.findNode("focusMirror")
    m.top.observeField("focusedChild", "onFocusedChild")
end sub

sub _onStateChange(event)
    state = event.getData()
    if state = "stopped"
        m._elementLayout.setFocus(true) 
    end if
end sub

sub sss()
    m._focusMirror.opacity = 0
    childCount = m._elementLayout.getChildCount()
    children = m._elementLayout.getChildren(childCount, 0)
     for each item in  children
        if item.hasFocus()
            item.buttonOpacity = 0.6
            exit for
        end if
     end for
end sub
sub onFocusedChild()
    ? "onFocusChild"
    if m.top.hasFocus()
        childCount = m._elementLayout.getChildCount()
        children = m._elementLayout.getChildren(childCount, 0)
           for each item in  children
             item.buttonOpacity = 0
           end for
       m.count = m._elementLayout.getChildCount() 
       element = m._elementLayout.getChild(0) 
       element.setFocus(true)
    end if
    if m.clean
    _cleanUpOpacity()
    end if
end sub

sub _cleanUpOpacity()
    childCount = m._elementLayout.getChildCount()
    children = m._elementLayout.getChildren(childCount, 0)
    for each item in  children
      item.buttonOpacity = 0
    end for
end sub

sub _moveFocusMirror(event)
    m._index = event.getData()
    if m._index < m.count AND m._index >= 0
        if m.top.moveDirection = "right"
             m._focusMirror.setFocus(true)
            _rightSwing()
        else if m.top.moveDirection = "left"
             m._focusMirror.setFocus(true)
            _leftSwing()
        end if
    end if
end sub

sub _leftSwing()
   index = m._index 
   ? "index" index
   if index < 0
    index = 0
   end if
    stepMove =  m._focusMirror.translation[0] - m._buttonSizes[index]
    ?"leftStepMove" stepMove
   _animatePoster(stepMove)
end sub

sub _rightSwing()
    stepMove =  m._focusMirror.translation[0] + m._buttonSizes[m._index - 1]
    _animatePoster(stepMove)
    ? "rightSwing" stepMove
end sub

sub  _animatePoster(moveStep)
    ?"m._index" m._index
    if m._index = 0
    end if
    trans = m._focusMirror.translation
    m._transInterpolator.keyValue = [trans , [moveStep , 0 ]]
    m._widthInterpolator.keyValue = [m._focusMirror.width, m._buttonSizes[m._index]]
    m._translationAnimation.control = "start"
end sub

sub _populateMenu()
    m._buttonSizes = _setItemSizing()
    m.stepToTranslate = m._buttonSizes[0]
    _setFocusMirror(m._buttonSizes[0])
    counter = 0
    for each element in m.dataSource
        menuElement = CreateObject("roSGNode", "CustomButton")
        menuElement.setFields({
            "color": "#ED2939"
            "buttonOpacity": 0
            "buttonWidth": m._buttonSizes[counter]
            "buttonHeight": 72
            "buttonText": element.screenName
            "fontSize": 26
            "centerBtn": true
        })
        m._elementLayout.appendChild(menuElement)
        counter++
    end for 
end sub

sub _centerMenu()
   layoutSizes = m._elementLayout.boundingRect()
   m._menuBg.width = layoutSizes.width + 200
   m._menuBg.height = layoutSizes.height + 10
   sizes = m.top.boundingRect()
   m.top.translation = [(1920 - sizes.width) / 2, 50]
   m._elementLayout.translation = [(sizes.width - layoutSizes.width) / 2 , (m._menuBg.height - layoutSizes.height) / 2]
end sub

function _setItemSizing() 
    rowItemSize = []
    for each item in  m.dataSource
        lable = createObject("roSgNode", "CustomLable")
        lable.text = item.screenName
        lable.fontSize = 26
        elementWidth = lable.boundingRect().width
        rowItemSize.push(elementWidth  + 70)
    end for

     return rowItemSize
end function 

sub _setFocusMirror(buttonSize)
    m._focusMirror.width = buttonSize
    m._focusMirror.height = 72 + 10
    m._focusMirror.translation = [100, 0]
    m._focusMirror.scaleRotateCenter = [m._focusMirror.width / 2, m._focusMirror.height / 2 ]
    m._focusMirror.scale = [1, 1.1]
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if not press 
      if (key = "down") then
        sss()
        m.clean = false
        m._focusMirror.setFocus(true)
      else if key = "up"
        m._focusMirror.opacity = 1
        m.clean = true
        m._elementLayout.setFocus(true)
      end if
    end if
    return handled
  end function
  
