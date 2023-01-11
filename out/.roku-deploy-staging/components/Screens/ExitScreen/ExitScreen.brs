sub init()
   m._exitView = m.top.findNode("exit")
   _centerView()
end sub

sub _centerView() 
    sizes = m._exitView.boundingRect()
    m._exitView.translation = [(1920 - sizes.width) / 2 , (1080 - sizes.height) / 2 - sizes.height/2  ]
end sub