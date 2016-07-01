Attribute VB_Name = "Functions"
Public Sub WriteToLog(Message As String, Optional IsError As Boolean = False)
    Dim FSO As FileSystemObject
    Dim TS As TextStream

    Set FSO = New FileSystemObject
    
    Set TS = FSO.OpenTextFile(App.Path & "\BSzkem-" & Format$(Now, "yyyy-mm-dd") & ".log", ForAppending, True)
    
    If IsError Then
        Message = "ERROR:" & Message
    End If
    TS.Write Format$(Now, "yyyy-mm-dd hh:mm:ss ") & Message & vbCrLf
    
    TS.Close
    
    Set TS = Nothing
    Set FSO = Nothing

End Sub
Public Function SetLong(ByVal Value As Long) As Long
    SetLong = Value
End Function
Public Function SetString(ByVal Value As String) As String
    SetString = Value
End Function
Public Function SetBoolean(ByVal Value As Boolean) As Boolean
    SetBoolean = Value
End Function
Public Function SetInteger(ByVal Value As Integer) As Integer
    SetInteger = Value
End Function
