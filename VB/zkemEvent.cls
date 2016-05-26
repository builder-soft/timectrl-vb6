VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "zkemEvent"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public WithEvents Instance As zkemkeeper.CZKEM
Attribute Instance.VB_VarHelpID = -1

Private Sub Instance_OnAttTransaction(ByVal EnrollNumber As Long, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long)
    WriteToLog "Instance_OnAttTransaction"
End Sub

Private Sub Instance_OnAttTransactionEx(ByVal EnrollNumber As String, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long, ByVal WorkCode As Long)
    WriteToLog "Instance_OnAttTransactionEx"
End Sub

Private Sub Instance_OnConnected()
    WriteToLog "Instance_OnConnected"
End Sub

Private Sub Instance_OnDeleteTemplate(ByVal EnrollNumber As Long, ByVal FingerIndex As Long)
    WriteToLog "Instance_OnDeleteTemplate"
End Sub

Private Sub Instance_OnDisConnected()
    WriteToLog "Instance_OnDisConnected"
End Sub

Private Sub Instance_OnDoor(ByVal EventType As Long)
    WriteToLog "Instance_OnDoor"
End Sub

Private Sub Instance_OnEmptyCard(ByVal ActionResult As Long)
    WriteToLog "Instance_OnEmptyCard"
End Sub

Private Sub Instance_OnEnrollFinger(ByVal EnrollNumber As Long, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
    WriteToLog "Instance_OnEnrollFinger"
End Sub

Private Sub Instance_OnEnrollFingerEx(ByVal EnrollNumber As String, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
    WriteToLog "Instance_OnEnrollFingerEx"
End Sub

Private Sub Instance_OnFinger()
    WriteToLog "Instance_OnFinger"
End Sub

Private Sub Instance_OnFingerFeature(ByVal Score As Long)
    WriteToLog "Instance_OnFingerFeature"
End Sub

Private Sub Instance_OnHIDNum(ByVal CardNumber As Long)
    WriteToLog "Instance_OnHIDNum"
End Sub

Private Sub Instance_OnKeyPress(ByVal Key As Long)
    WriteToLog "Instance_OnKeyPress"
End Sub

Private Sub Instance_OnNewUser(ByVal EnrollNumber As Long)
    WriteToLog "Instance_OnNewUser"
End Sub

Private Sub Instance_OnVerify(ByVal UserID As Long)
    WriteToLog "Instance_OnVerify"
End Sub

Private Sub Instance_OnWriteCard(ByVal EnrollNumber As Long, ByVal ActionResult As Long, ByVal Length As Long)
    WriteToLog "Instance_OnWriteCard"
End Sub
