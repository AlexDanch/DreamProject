sub Main()
    'Indicate this is a Roku SceneGraph application'
    screen = CreateObject("roSGScreen")
    m.global = screen.getGlobalNode()
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    screen.CreateScene("MainScene")
    screen.show() ' vscode_rale_tracker_entry

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

