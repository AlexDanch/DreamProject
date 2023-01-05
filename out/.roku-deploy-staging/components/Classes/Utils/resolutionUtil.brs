'******************************************************
' Resolution Helper function
' *****************************************************

function getSizeMaskGroupWith(size) as object
    deviceInfo = CreateObject("roDeviceInfo")
    resolution = deviceInfo.GetUIResolution()
    if resolution.name = "HD"
        size[0] = size[0] * 2 / 3
        size[1] = size[1] * 2 / 3
        return size
    end if
    return size
end function