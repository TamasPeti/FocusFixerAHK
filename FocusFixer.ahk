NumpadAdd::
    ; Select all text
    Send, ^a
    Sleep, 100

    ; Copy selected text
    Send, ^c
    ClipWait

    ; Split into words
    StringSplit, words, Clipboard, %A_Space%

    ; Process each word
    newClipboard := ""
    Loop, % words0
    {
        word := words%A_Index%

        ; Determine the number of characters to bold based on word length
        boldCount := 0
        if (StrLen(word) <= 3)
            boldCount := 1
        else if (StrLen(word) >= 4 && StrLen(word) <= 6)
            boldCount := 2
        else if (StrLen(word) >= 7 && StrLen(word) <= 7)
            boldCount := 3
        else if (StrLen(word) >= 8)
            boldCount := 4
        
        ; Add artificial fixation points to the specified number of characters
        modifiedWord := "**" SubStr(word, 1, boldCount) "**" SubStr(word, boldCount + 1)

        ; Concatenate modified word to the new clipboard content
        newClipboard := newClipboard modifiedWord " "
    }

    ; Clear clipboard
    Clipboard :=

    ; Set modified content to clipboard
    Clipboard := Trim(newClipboard)

    ; Type the modified content and press Enter
    SendInput, {Raw}%Clipboard%
    Send {Enter}
return
