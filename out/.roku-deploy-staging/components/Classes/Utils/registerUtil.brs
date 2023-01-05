'******************************************************
' Registry Helper Functions
' ******************************************************

function RegRead(key, section = invalid)
    if section = invalid then section = "InStat"
    sec = CreateObject("roRegistrySection", section)
    if sec.Exists(key)
        return parseJson(sec.Read(key))
    end if
    return invalid
end function

function RegReadMulti(arr, section = invalid)
    if section = invalid then section = "InStat"
    sec = CreateObject("roRegistrySection", section)
    return sec.ReadMulti(arr)
end function

function RegWrite(key, val, section = invalid)
    if section = invalid then section = "InStat"
    sec = CreateObject("roRegistrySection", section)
    sec.Write(key, val)
    sec.Flush()
end function

function RegWriteMulti(obj, section = "InStat")
    sec = CreateObject("roRegistrySection", section)
    for each key in obj
        obj[key] = FormatJson(obj[key], 1)
    end for
    sec.WriteMulti(obj)
    sec.Flush()
end function

function RegDelete(key = invalid, section = "InStat")
    if key = invalid
        sec = CreateObject("roRegistry")
        sec.Delete(section)
    else
        sec = CreateObject("roRegistrySection", section)
        sec.Delete(key)
    end if
end function

sub saveInGlobal(key, data)
    if m.global[key] <> invalid
        m.global[key] = data
    else
        obj = {}
        obj[key] = data
        m.global.addFields(obj)
    end if
end sub

sub eraseGlobal(key)
    m.global.removeField(key)
end sub

function GetAuthToken()
    return RegRead("AUTH_TOKEN")
end function

function GetRefreshToken()
    return RegRead("REFRESH_TOKEN")
end function