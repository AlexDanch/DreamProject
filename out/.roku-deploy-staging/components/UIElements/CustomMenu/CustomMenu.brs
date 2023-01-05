sub init()
    initViews()
    observeField()
    m.dataSource = [
        {screenName: "Apple"}
        {screenName: "Netflix"}
        {screenName: "NBA"}
        {screenName: "Setting"}
    ]
    populateMenu()
end sub

sub initViews()
     m.menuBg = m.top.findNode("menu_Bg")
     m.menuList = m.top.findNode("menuList")
end sub

sub observeField()
    m.top.observeField("focusedChild", "onFocusedChild")
end sub

sub onFocusedChild()
    if m.top.hasFocus()
        m.menuList.setFocus(true)
    end if
end sub

sub populateMenu()
    rowItemSize = setItemSizing()

    content = CreateObject("roSgNode", "ContentNode") 
    row = content.createChild("ContentNode")
    For Each item in m.dataSource
        rowItem = row.createChild("ContentNode")
        rowItem.addFields({
            "screenName": item.screenName  
        }) 
    end for
    m.menuList.content = content
    m.menuList.rowItemSize = rowItemSize 
end sub

function setItemSizing()
    width = 0
    rowItemSize= []
    for each item in  m.dataSource
        lable = createObject("roSgNode", "CustomLable")
        lable.text = item.screenName
        lable.fontSize = 26
        elementWidth = lable.boundingRect().width
        width = width + elementWidth  + 50
        rowItemSize.push([elementWidth  + 50, 72])
    end for
    m.menuBg.width = width
    return rowItemSize

end function 

