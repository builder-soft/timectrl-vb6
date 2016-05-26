Attribute VB_Name = "Functions"
Public Sub WriteToLog(Message As String)
    Dim FSO As FileSystemObject
    Dim TS As TextStream

    Set FSO = New FileSystemObject
    
    Set TS = FSO.OpenTextFile(App.Path & "\log" & Format$(Now, "yyyy-mm-dd") & ".txt", ForWriting, True)
    TS.Write Message
    TS.Close
    
    Set TS = Nothing
    Set FSO = Nothing

End Sub

