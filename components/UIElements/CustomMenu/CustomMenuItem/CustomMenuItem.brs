sub init()
      m.elementTex = m.top.findNode("elementTex")
end sub


sub displayContent()
   dataSource = m.top.itemContent
   m.elementTex.text = dataSource.screenName
   centralizeMenuElement()
end sub

sub centralizeMenuElement()
   m.elementTex.width = m.top.width
   m.elementTex.height = m.top.height
   m.elementTex.horizAlign = "center"
   m.elementTex.vertAlign = "center"
end sub