sub init()
    m.top.functionName = "postRequest"
end sub

function postRequest()
    url = m.top.url
    body = m.top.body
    if body = invalid
        body = m.top.arrayBody
    end if
    http = CreateObject("roUrlTransfer")
    http.RetainBodyOnError(true)
    port = CreateObject("roMessagePort")
    http.SetPort(port)
    http.SetCertificatesFile("common:/certs/ca-bundle.crt")
    http.InitClientCertificates()
    http.setURL(url)
    http.EnableEncodings(true)
    h = getDefaultHeders()
    http.SetHeaders(h)
    body = FormatJson(body)
    if http.AsyncPostFromString(body) then
        event = Wait(35000, http.GetPort())
        if Type(event) = "roUrlEvent" then
            resJson = invalid
            if event.GetResponseCode() = 200
                resJson = ParseJson(event.GetString())
                if IsAssociativeArray(resJson) and resJson["access_token"] <> invalid
                    RegWriteMulti({ "AUTH_TOKEN": resJson["access_token"] })
                end if
                if IsAssociativeArray(resJson) and resJson["refresh_token"] <> invalid
                    RegWriteMulti({ "REFRESH_TOKEN": resJson["refresh_token"] })
                end if
                if IsArray(resJson)
                    m.top.arrayResponse = resJson
                else
                    m.top.response = resJson
                end if
            else
                erroObj = {
                    code: event.GetResponseCode()
                    message: ParseJson(event.GetString())
                }
                m.top.error = erroObj
            end if
            ? "======================POST========================== "
            ? "URL: " url
            ? "BODY: " body
            ? "HEADERS: " h
            ? "RESPONSE CODE: " event.GetResponseCode().toStr()
            ? "=================================================== "
            ? "RESPONSE: " resJson
            ? "ERROR: " erroObj
        else if event = invalid then
            http.asynccancel()
        end if
    end if
end function

function getRequest() as object
    url = m.top.url
    res = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    res.SetPort(port)
    res.setURL(url)
    h = getDefaultHeders()
    ' if headers <> invalid
    '     h.Append(headers)
    ' end if
    res.SetHeaders(h)
    res.EnableEncodings(true)
    res.SetCertificatesFile("common:/certs/ca-bundle.crt")
    res.InitClientCertificates()

    if res.AsyncGetToString()
        while true
            msg = Wait (0, port)
            if Type (msg) = "roUrlEvent"
                resJson = invalid
                if msg.GetResponseCode() = 200
                    resJson = ParseJson(msg.GetString())
                end if
                ? "======================GET========================== "
                ? "URL: " url
                ? "HEADERS: " h
                ? "RESPONSE CODE: " msg.GetResponseCode().toStr()
                ? "=================================================== "
                ? "RESPONSE: " resJson
                m.top.arrayResponse = resJson
                exit while
            else if Type (msg) = "Invalid"
                res.AsyncCancel()
                exit while
            end if
        end while
    end if
end function

function getDefaultHeders()
    ' headers = {}
    ' headers["Accept"] = "application/json"
    ' headers["Content-Type"] = "application/json"
    ' getToket = GetAuthToken()
    ' token = invalid
    ' if IsValid(getToket)
        ' token = "Bearer " + getToket
    ' end if
    ' if token <> invalid
        ' headers["Authorization"] = token
    ' end if
    ' return headers
end function