function isValidEmail(email)
    emailPattern = CreateObject("roRegex", "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}", "i")
    return emailPattern.IsMatch(email)
end function