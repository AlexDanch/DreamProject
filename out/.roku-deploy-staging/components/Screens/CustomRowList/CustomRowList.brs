sub init()
    populateContentNode()
end sub

sub populateContentNode()
    for i = 0 to 3 step 1 
        child = CreateObject("roSGNODE", "CustomRowListElement")
        m.top.insertChild(child, i)
    end for
    
end sub