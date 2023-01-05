' ******************************************************
' Type check
' ******************************************************

function IsXmlElement(value as dynamic) as boolean
    return IsValid(value) and GetInterface(value, "ifXMLElement") <> invalid
end function

function IsFunction(value as dynamic) as boolean
    return IsValid(value) and GetInterface(value, "ifFunction") <> invalid
end function

function IsBoolean(value as dynamic) as boolean
    return IsValid(value) and GetInterface(value, "ifBoolean") <> invalid
end function

function IsNumber(value as dynamic) as boolean
    return IsInteger(value) or IsFloat(value) or IsDouble(value)
end function

function IsInteger(value as dynamic) as boolean
    return IsValid(value) and GetInterface(value, "ifInt") <> invalid and (Type(value) = "roInt" or Type(value) = "roInteger" or Type(value) = "Integer")
end function

function IsFloat(value as dynamic) as boolean
    return IsValid(value) and (GetInterface(value, "ifFloat") <> invalid or (Type(value) = "roFloat" or Type(value) = "Float"))
end function

function IsDouble(value as dynamic) as boolean
    return IsValid(value) and (GetInterface(value, "ifDouble") <> invalid or (Type(value) = "roDouble" or Type(value) = "roIntrinsicDouble" or Type(value) = "Double"))
end function

function IsList(value as dynamic) as boolean
    return IsValid(value) and GetInterface(value, "ifList") <> invalid
end function

function IsArray(value as dynamic) as boolean
    return IsValid(value) and Type(value) = "roArray"
end function

function IsNonEmptyArray(value as dynamic) as boolean
    return IsArray(value) and value.count() > 0
end function

function IsAssociativeArray(value as dynamic) as boolean
    return IsValid(value) and Type(value) = "roAssociativeArray"
end function

function IsNonEmptyAssociativeArray(value as dynamic) as boolean
    return IsAssociativeArray(value) and value.count() > 0
end function

function IsString(value as dynamic) as boolean
    return IsValid(value) and GetInterface(value, "ifString") <> invalid
end function

function IsNonEmptyString(value as dynamic) as boolean
    return IsString(value) and value <> ""
end function

function IsDateTime(value as dynamic) as boolean
    return IsValid(value) and (GetInterface(value, "ifDateTime") <> invalid or Type(value) = "roDateTime")
end function

function IsSGNode(value as dynamic) as boolean
    return IsValid(value) and (GetInterface(value, "ifSGNodeField") <> invalid or Type(value) = "roSGNode")
end function

function IsToStringConvertible(variable as dynamic) as boolean
    if Type(variable) = "roInt" or Type(variable) = "roInteger" or Type(variable) = "roFloat" or Type(variable) = "Float" then return true
    if Type(variable) = "roBoolean" or Type(variable) = "Boolean" then return true
    if Type(variable) = "roString" or Type(variable) = "String" then return true
    return false
end function

function IsValid(value as dynamic) as boolean
    return Type(value) <> "<uninitialized>" and value <> invalid
end function

function IsInvalid(value as dynamic) as boolean
    return not IsValid(value)
end function