VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Riser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Cont As Boolean

Public Event IntervalEvent(ByVal Time As String)

Public Sub Start()
'    Dim dt As Date
'    dt = Now
    Cont = True
    Dim tme As String
    tme = Format(Now, "yyyy-MM-dd hh:mm:ss")

    WriteToLog "Before Raise Event"
    RaiseEvent IntervalEvent(tme)
    WriteToLog "After Raise Event"
    
'    Do While Cont ' DateDiff("s", dt, Now) < 30
'        DoEvents
'        Sleep 50   ' put your app to sleep in small increments to avoid having CPU go to 100%
'        If Interval(Int(Format(Now, "s"))) Then
'            RaiseEvent IntervalEvent(Format(Now, "yyyy-MM-dd hh:mm:ss"))
'        End If
'    Loop

End Sub
Private Function Interval(Sec As Integer) As Boolean
    If (Sec = 10 Or Sec = 20 Or Sec = 30 Or Sec = 40 Or Sec = 50 Or Sec = 0) Then
        Interval = True
    Else
        Interval = False
    End If
End Function
Public Sub StopMe()
    Cont = False
End Sub

Public Sub WriteToLog(Message As String)
    Dim FSO As FileSystemObject
    Dim TS As TextStream

    Set FSO = New FileSystemObject
    
    Set TS = FSO.OpenTextFile(App.Path & "\log" & Format$(Now, "yyyy-mm-dd") & ".txt", ForAppending, True)
    
    TS.Write Format$(Now, "yyyy-mm-dd hh:mm:ss ") & Message & vbCrLf
    
    TS.Close
    
    Set TS = Nothing
    Set FSO = Nothing

End Sub

