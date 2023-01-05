sub Main()
    'Indicate this is a Roku SceneGraph application'
    screen = CreateObject("roSGScreen")
    m.global = screen.getGlobalNode()
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    screen.CreateScene("MainScene")
    screen.show() : if true = CreateObject("roAppInfo").IsDev() then m.vscode_rale_tracker_task = createObject("roSGNode", "TrackerTask") ' Roku Advanced Layout Editor Support

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
