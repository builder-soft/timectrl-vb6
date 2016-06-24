VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ZKProxy2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private WithEvents CZKEM As zkemkeeper.CZKEM
Attribute CZKEM.VB_VarHelpID = -1

Public Event OnConnected()
Public Event OnDeleteTemplate(ByVal EnrollNumber As Long, ByVal FingerIndex As Long)
Public Event OnDisConnected()
Public Event OnDoor(ByVal EventType As Long)
Public Event OnEmptyCard(ByVal ActionResult As Long)
Public Event OnEnrollFinger(ByVal EnrollNumber As Long, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
Public Event OnEnrollFingerEx(ByVal EnrollNumber As String, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
Public Event OnFinger()
Public Event OnFingerFeature(ByVal Score As Long)
Public Event OnHIDNum(ByVal CardNumber As Long)
Public Event OnKeyPress(ByVal Key As Long)
Public Event OnNewUser(ByVal EnrollNumber As Long)
Public Event OnVerify(ByVal UserID As Long)
Public Event OnWriteCard(ByVal EnrollNumber As Long, ByVal ActionResult As Long, ByVal Length As Long)
Public Event OnAttTransaction(ByVal EnrollNumber As Long, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long)
Public Event OnAttTransactionEx(ByVal EnrollNumber As String, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long, ByVal WorkCode As Long)

Private Sub Class_Initialize()
    Set CZKEM = New zkemkeeper.CZKEM ' CreateObject("zkemkeeper.CZKEM")
End Sub
Private Sub Class_Terminate()
    Set CZKEM = Nothing
End Sub
Public Function Connect_Net(ByVal IP As String, ByVal Port As Integer) As Boolean
    Connect_Net = CZKEM.Connect_Net(IP, Port)
End Function
Public Sub Disconnect()
    CZKEM.Disconnect
End Sub
Public Function EnableDevice(ByVal Machine As Long, ByVal Enable As Boolean) As Boolean
    EnableDevice = CZKEM.EnableDevice(Machine, Enable)
End Function
Public Function ReadGeneralLogData(ByVal Machine As Long) As Boolean
    ReadGeneralLogData = CZKEM.ReadGeneralLogData(Machine)
End Function
Public Function SSR_GetGeneralLogData(ByVal Machine As Long, ByRef EnrollNumber As String, ByRef VerifyMode As Long, _
                ByRef InOutMode As Long, ByRef Year As Long, ByRef Month As Long, ByRef Day As Long, ByRef Hour As Long, _
                ByRef Minute As Long, ByRef Second As Long, ByRef WorkCode As Long) As Boolean
    Dim dwEnrollNumber As String
    Dim dwVerifyMode As Long
    Dim dwInOutMode As Long
    Dim dwYear  As Long
    Dim dwMonth As Long
    Dim dwDay As Long
    Dim dwHour As Long
    Dim dwMinute As Long
    Dim dwSecond As Long
    Dim dwWorkCode As Long
                
    Dim Out As Boolean
                
    Out = CZKEM.SSR_GetGeneralLogData(Machine, dwEnrollNumber, dwVerifyMode, dwInOutMode, _
                dwYear, dwMonth, dwDay, dwHour, _
                dwMinute, dwSecond, dwWorkCode)
    
    EnrollNumber = SetString(dwEnrollNumber)
    VerifyMode = SetLong(dwVerifyMode)
    InOutMode = SetLong(dwInOutMode)
    Year = SetLong(dwYear)
    Month = SetLong(dwMonth)
    Day = SetLong(dwDay)
    Hour = SetLong(dwHour)
    Minute = SetLong(dwMinute)
    Second = SetLong(dwSecond)
    WorkCode = SetLong(dwWorkCode)
    
    SSR_GetGeneralLogData = Out
End Function

Public Sub GetLastError(ByRef ErrorCode As Long)
    Dim dwErrorCode As Long
    CZKEM.GetLastError dwErrorCode
    ErrorCode = SetLong(dwErrorCode)
End Sub
Public Function ReadAllUserID(ByVal Machine As Long) As Boolean
    ReadAllUserID = CZKEM.ReadAllUserID(Machine)
End Function
Public Function SSR_GetUserInfo(ByVal MachineNumber As Long, ByRef EnrollNumber As String, ByRef Name As String, _
                ByRef Password As String, ByRef Privilege As Long, ByRef Enabled As Boolean) As Boolean
 On Error GoTo Handler
    Dim dwEnrollNumber As String
    Dim dwName As String
    Dim dwPassword As String
    Dim dwPrivilege As Long
    Dim dwEnabled As Boolean
    Dim IsFound As Boolean
    
    IsFound = False
    Call CZKEM.ReadAllUserID(MachineNumber)
    While CZKEM.SSR_GetAllUserInfo(MachineNumber, dwEnrollNumber, dwName, dwPassword, dwPrivilege, dwEnabled) And Not IsFound
        If EnrollNumber = dwEnrollNumber Then
'            EnrollNumber = SetString(dwEnrollNumber)
            Name = SetString(dwName)
            Password = SetString(dwPassword)
            Privilege = SetLong(dwPrivilege)
            Enabled = SetBoolean(dwEnabled)
            IsFound = True
        End If
    Wend
    
'    EnrollNumber = SetString(dwEnrollNumber)
'    Name = SetString(dwName)
'    Password = SetString(dwPassword)
'    Privilege = SetLong(dwPrivilege)
'    Enabled = SetBoolean(dwEnabled)
    
    SSR_GetUserInfo = IsFound
    Exit Function
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Function
Public Function SSR_GetAllUserInfo(ByVal MachineNumber As Long, ByRef EnrollNumber As String, ByRef Name As String, _
                ByRef Password As String, ByRef Privilege As Long, ByRef Enabled As Boolean) As Boolean
On Error GoTo Handler
    Dim dwEnrollNumber As String
    Dim dwName As String
    Dim dwPassword As String
    Dim dwPrivilege As Long
    Dim dwEnabled As Boolean
    Dim Out As Boolean

    Out = CZKEM.SSR_GetAllUserInfo(MachineNumber, dwEnrollNumber, dwName, dwPassword, dwPrivilege, dwEnabled)
    
    EnrollNumber = SetString(dwEnrollNumber)
    Name = SetString(dwName)
    Password = SetString(dwPassword)
    Privilege = SetLong(dwPrivilege)
    Enabled = SetBoolean(dwEnabled)
    
    SSR_GetAllUserInfo = Out
    Exit Function
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Function

Public Function GetUserTmpExStr(ByVal Machine As Long, ByVal EnrollNumber As String, ByVal FingerIndex As Long, _
                ByRef Flag As Long, ByRef TmpData As String, ByRef TmpLength As Long) As Boolean
    Dim dwFlag As Long
    Dim dwTmpData As String
    Dim dwTmpLength As Long
    Dim Out As Boolean
    
    Out = CZKEM.GetUserTmpExStr(Machine, EnrollNumber, FingerIndex, dwFlag, dwTmpData, dwTmpLength)
    
    Flag = SetLong(dwFlag)
    TmpData = SetString(dwTmpData)
    TmpLength = SetInteger(dwTmpLength)
    
    GetUserTmpExStr = Out
End Function
Public Function BeginBatchUpdate(ByVal Machine As Long, ByVal UpdateFlag As Long) As Boolean
    BeginBatchUpdate = CZKEM.BeginBatchUpdate(Machine, UpdateFlag)
End Function

Public Function BatchUpdate(ByVal Machine As Long) As Boolean
    BatchUpdate = CZKEM.BatchUpdate(Machine)
End Function
Public Function RefreshData(ByVal Machine As Long) As Boolean
    RefreshData = CZKEM.RefreshData(Machine)
End Function
Public Function SSR_SetUserInfo(ByVal Machine As Long, ByVal EnrollNumber As String, ByVal Name As String, _
                ByVal Password As String, ByVal Privilege As Long, ByVal Enabled As Boolean) As Boolean
    SSR_SetUserInfo = CZKEM.SSR_SetUserInfo(Machine, EnrollNumber, Name, Password, Privilege, Enabled)
End Function
Public Function SetUserTmpExStr(ByVal Machine As Long, ByVal EnrollNumber As String, ByVal FingerIndex As Long, _
                ByVal Flag As Long, ByVal TmpData As String) As Boolean
    SetUserTmpExStr = CZKEM.SetUserTmpExStr(Machine, EnrollNumber, FingerIndex, Flag, TmpData)
End Function
Public Function SSR_DeleteEnrollData(ByVal Machine As Long, ByVal EnrollNumber As String, _
                ByVal BackupNumber As Long) As Boolean
    SSR_DeleteEnrollData = CZKEM.SSR_DeleteEnrollData(Machine, EnrollNumber, BackupNumber)
End Function
Public Function GetSerialNumber(ByVal Machine As Long, ByRef SerialNumber As String) As Boolean
    Dim dwSerialNumber As String
    Dim Out As Boolean
    
    Out = CZKEM.GetSerialNumber(Machine, dwSerialNumber)
    
    SerialNumber = SetString(dwSerialNumber)
    GetSerialNumber = Out
End Function
Public Function ClearGLog(ByVal Machine As Long) As Boolean
    ClearGLog = CZKEM.ClearGLog(Machine)
End Function
Public Function GetStrCardNumber(ByRef ACardNumber As String) As Boolean
    Dim dwACardNumber As String
    Dim Out As Boolean
    
    Out = CZKEM.GetStrCardNumber(dwACardNumber)
    ACardNumber = SetString(dwACardNumber)
    
    GetStrCardNumber = Out
End Function
Public Function SetStrCardNumber(ByRef ACardNumber As String) As Boolean
    Dim dwACardNumber As String
    Dim Out As Boolean
    
    dwACardNumber = SetString(ACardNumber)
    Out = CZKEM.SetStrCardNumber(dwACardNumber)
    
    SetStrCardNumber = Out
End Function
Private Sub CZKEM_OnConnected()
On Error GoTo Handler
    WriteToLog "CZKEM_OnConnected()"
    RaiseEvent OnConnected
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnDeleteTemplate(ByVal EnrollNumber As Long, ByVal FingerIndex As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ", FingerIndex:" & FingerIndex & ")"
    WriteToLog "CZKEM_OnDeleteTemplate" & Params
    RaiseEvent OnDeleteTemplate(EnrollNumber, FingerIndex)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnDisConnected()
On Error GoTo Handler
    WriteToLog "CZKEM_OnDisConnected()"
    RaiseEvent OnDisConnected
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnDoor(ByVal EventType As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EventType:" & EventType & ")"
    WriteToLog "CZKEM_OnDoor" & Params
    RaiseEvent OnDoor(EventType)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnEmptyCard(ByVal ActionResult As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(ActionResult:" & ActionResult & ")"
    WriteToLog "CZKEM_OnEmptyCard" & Params
    RaiseEvent OnEmptyCard(ActionResult)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnEnrollFinger(ByVal EnrollNumber As Long, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ", FingerIndex:" & FingerIndex & ", ActionResult:" & ActionResult & ", TemplateLength:" & TemplateLength & ")"
    WriteToLog "CZKEM_OnEnrollFinger" & Params
    RaiseEvent OnEnrollFinger(EnrollNumber, FingerIndex, ActionResult, TemplateLength)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnEnrollFingerEx(ByVal EnrollNumber As String, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ", FingerIndex:" & FingerIndex & ", ActionResult:" & ActionResult & ", TemplateLength:" & TemplateLength & ")"
    WriteToLog "CZKEM_OnEnrollFingerEx" & Params
    RaiseEvent OnEnrollFingerEx(EnrollNumber, FingerIndex, ActionResult, TemplateLength)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnFinger()
On Error GoTo Handler
    WriteToLog "CZKEM_OnFinger()"
    RaiseEvent OnFinger
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnFingerFeature(ByVal Score As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(Score:" & Score & ")"
    WriteToLog "CZKEM_OnFingerFeature" & Params
    RaiseEvent OnFingerFeature(Score)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnHIDNum(ByVal CardNumber As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(CardNumber:" & CardNumber & ")"
    WriteToLog "CZKEM_OnHIDNum" & Params
    RaiseEvent OnHIDNum(CardNumber)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnKeyPress(ByVal Key As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(Key:" & Key & ")"
    WriteToLog "CZKEM_OnKeyPress" & Params
    RaiseEvent OnKeyPress(Key)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnNewUser(ByVal EnrollNumber As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ")"
    WriteToLog "CZKEM_OnNewUser" & Params
    RaiseEvent OnNewUser(EnrollNumber)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnVerify(ByVal UserID As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(UserID:" & UserID & ")"
    WriteToLog "CZKEM_OnVerify" & Params
    RaiseEvent OnVerify(UserID)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnWriteCard(ByVal EnrollNumber As Long, ByVal ActionResult As Long, ByVal Length As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ", ActionResult:" & ", ActionResult:" & ActionResult & ", Length:" & Length & ")"
    WriteToLog "CZKEM_OnWriteCard" & Params
    RaiseEvent OnWriteCard(EnrollNumber, ActionResult, Length)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnAttTransaction(ByVal EnrollNumber As Long, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ", IsInValid:" & IsInValid & ", AttState:" & AttState & ", VerifyMethod:" & VerifyMethod & ", Year:" & Year & ", Month:" & Month & ", Day:" & Day & ", Hour:" & Hour & ", Minute:" & Minute & ", Second:" & Second & ")"
    WriteToLog "CZKEM_OnAttTransaction" & Params
    RaiseEvent OnAttTransaction(EnrollNumber, IsInValid, AttState, VerifyMethod, Year, Month, Day, Hour, Minute, Second)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
Private Sub CZKEM_OnAttTransactionEx(ByVal EnrollNumber As String, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long, ByVal WorkCode As Long)
On Error GoTo Handler
    Dim Params As String
    Params = "(EnrollNumber:" & EnrollNumber & ", IsInValid:" & IsInValid & ", AttState:" & AttState & ", VerifyMethod:" & VerifyMethod & ", Year:" & Year & ", Month:" & Month & ", Day:" & Day & ", Hour:" & Hour & ", Minute:" & Minute & ", Second:" & Second & ", WorkCode:" & WorkCode & ")"
    WriteToLog "CZKEM_OnAttTransactionEx" & Params
    RaiseEvent OnAttTransactionEx(EnrollNumber, IsInValid, AttState, VerifyMethod, Year, Month, Day, Hour, Minute, Second, WorkCode)
    Exit Sub
Handler:
    Call WriteToLog(Err.Number & " - " & Err.Description, True)
End Sub
