function isValidEmail(email)
    emailPattern = CreateObject("roRegex", "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}", "i")
   if  emailPattern.IsMatch(email)
       valid = true
   else 
       valid= false
   end if
    return valid
end function