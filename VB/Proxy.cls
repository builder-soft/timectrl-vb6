VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "zkemProxy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Public WithEvents zk As zkemkeeper.CZKEM
Attribute zk.VB_VarHelpID = -1

Private Sub Class_Initialize()
    Set zk = New zkemkeeper.CZKEM ' CreateObject("zkemkeeper.CZKEM")
End Sub
Private Sub Class_Terminate()
    Set zk = Nothing
End Sub
Private Function SetLong(ByVal Value As Long) As Long
    SetLong = Value
End Function
Private Function SetString(ByVal Value As String) As String
    SetString = Value
End Function
Private Function SetBoolean(ByVal Value As Boolean) As Boolean
    SetBoolean = Value
End Function
Private Function SetInteger(ByVal Value As Integer) As Integer
    SetInteger = Value
End Function
Public Function Connect_Net(ByVal IP As String, ByVal Port As Integer) As Boolean
    Connect_Net = zk.Connect_Net(IP, Port)
End Function
Public Sub Disconnect()
    zk.Disconnect
End Sub
Public Function EnableDevice(ByVal Machine As Long, ByVal Enable As Boolean) As Boolean
    EnableDevice = zk.EnableDevice(Machine, Enable)
End Function
Public Function ReadGeneralLogData(ByVal Machine As Long) As Boolean
    ReadGeneralLogData = zk.ReadGeneralLogData(Machine)
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
                
    Out = zk.SSR_GetGeneralLogData(Machine, dwEnrollNumber, dwVerifyMode, dwInOutMode, _
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
    zk.GetLastError dwErrorCode
    ErrorCode = SetLong(dwErrorCode)
End Sub
Public Function ReadAllUserID(ByVal Machine As Long) As Boolean
    ReadAllUserID = zk.ReadAllUserID(Machine)
End Function
Public Function SSR_GetUserInfo(ByVal MachineNumber As Long, ByRef EnrollNumber As String, ByRef Name As String, _
                ByRef Password As String, ByRef Privilege As Long, ByRef Enabled As Boolean) As Boolean
 On Error GoTo Handler
    Dim dwEnrollNumber As String
    Dim dwName As String
    Dim dwPassword As String
    Dim dwPrivilege As Long
    Dim dwEnabled As Boolean
    Dim Out As Boolean
    
    Out = False
    Call zk.ReadAllUserID(MachineNumber)
    While zk.SSR_GetAllUserInfo(MachineNumber, dwEnrollNumber, dwName, dwPassword, dwPrivilege, dwEnabled)
        If EnrollNumber = dwEnrollNumber Then
'            EnrollNumber = SetString(dwEnrollNumber)
            Name = SetString(dwName)
            Password = SetString(dwPassword)
            Privilege = SetLong(dwPrivilege)
            Enabled = SetBoolean(dwEnabled)
            Out = True
        End If
    Wend
    
'    EnrollNumber = SetString(dwEnrollNumber)
'    Name = SetString(dwName)
'    Password = SetString(dwPassword)
'    Privilege = SetLong(dwPrivilege)
'    Enabled = SetBoolean(dwEnabled)
    
    SSR_GetUserInfo = Out
    Exit Function
Handler:
    WriteToLog Err.Number & " - " & Err.Description
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

    Out = zk.SSR_GetAllUserInfo(MachineNumber, dwEnrollNumber, dwName, dwPassword, dwPrivilege, dwEnabled)
    
    EnrollNumber = SetString(dwEnrollNumber)
    Name = SetString(dwName)
    Password = SetString(dwPassword)
    Privilege = SetLong(dwPrivilege)
    Enabled = SetBoolean(dwEnabled)
    
    SSR_GetAllUserInfo = Out
    Exit Function
Handler:
    WriteToLog Err.Number & " - " & Err.Description
End Function

Public Function GetUserTmpExStr(ByVal Machine As Long, ByVal EnrollNumber As String, ByVal FingerIndex As Long, _
                ByRef Flag As Long, ByRef TmpData As String, ByRef TmpLength As Long) As Boolean
    Dim dwFlag As Long
    Dim dwTmpData As String
    Dim dwTmpLength As Long
    Dim Out As Boolean
    
    Out = zk.GetUserTmpExStr(Machine, EnrollNumber, FingerIndex, dwFlag, dwTmpData, dwTmpLength)
    
    Flag = SetLong(dwFlag)
    TmpData = SetString(dwTmpData)
    TmpLength = SetInteger(dwTmpLength)
    
    GetUserTmpExStr = Out
End Function
Public Function BeginBatchUpdate(ByVal Machine As Long, ByVal UpdateFlag As Long) As Boolean
    BeginBatchUpdate = zk.BeginBatchUpdate(Machine, UpdateFlag)
End Function

Public Function BatchUpdate(ByVal Machine As Long) As Boolean
    BatchUpdate = zk.BatchUpdate(Machine)
End Function
Public Function RefreshData(ByVal Machine As Long) As Boolean
    RefreshData = zk.RefreshData(Machine)
End Function
Public Function SSR_SetUserInfo(ByVal Machine As Long, ByVal EnrollNumber As String, ByVal Name As String, _
                ByVal Password As String, ByVal Privilege As Long, ByVal Enabled As Boolean) As Boolean
    SSR_SetUserInfo = zk.SSR_SetUserInfo(Machine, EnrollNumber, Name, Password, Privilege, Enabled)
End Function
Public Function SetUserTmpExStr(ByVal Machine As Long, ByVal EnrollNumber As String, ByVal FingerIndex As Long, _
                ByVal Flag As Long, ByVal TmpData As String) As Boolean
    SetUserTmpExStr = zk.SetUserTmpExStr(Machine, EnrollNumber, FingerIndex, Flag, TmpData)
End Function
Public Function SSR_DeleteEnrollData(ByVal Machine As Long, ByVal EnrollNumber As String, _
                ByVal BackupNumber As Long) As Boolean
    SSR_DeleteEnrollData = zk.SSR_DeleteEnrollData(Machine, EnrollNumber, BackupNumber)
End Function
Public Function GetSerialNumber(ByVal Machine As Long, ByRef SerialNumber As String) As Boolean
    Dim dwSerialNumber As String
    Dim Out As Boolean
    
    Out = zk.GetSerialNumber(Machine, dwSerialNumber)
    
    SerialNumber = SetString(dwSerialNumber)
    GetSerialNumber = Out
End Function
Public Function ClearGLog(ByVal Machine As Long) As Boolean
    ClearGLog = zk.ClearGLog(Machine)
End Function
Public Function GetStrCardNumber(ByRef ACardNumber As String) As Boolean
    Dim dwACardNumber As String
    Dim Out As Boolean
    
    Out = zk.GetStrCardNumber(dwACardNumber)
    ACardNumber = SetString(dwACardNumber)
    
    GetStrCardNumber = Out
End Function
Public Function SetStrCardNumber(ByRef ACardNumber As String) As Boolean
    Dim dwACardNumber As String
    Dim Out As Boolean
    
    dwACardNumber = SetString(ACardNumber)
    Out = zk.SetStrCardNumber(dwACardNumber)
    
    SetStrCardNumber = Out
End Function

Private Sub zk_OnAttTransaction(ByVal EnrollNumber As Long, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long)
    WriteToLog "zk_OnAttTransaction"
End Sub

Private Sub zk_OnAttTransactionEx(ByVal EnrollNumber As String, ByVal IsInValid As Long, ByVal AttState As Long, ByVal VerifyMethod As Long, ByVal Year As Long, ByVal Month As Long, ByVal Day As Long, ByVal Hour As Long, ByVal Minute As Long, ByVal Second As Long, ByVal WorkCode As Long)
    WriteToLog "zk_OnAttTransactionEx"
End Sub

Private Sub zk_OnConnected()
    WriteToLog "zk_OnConnected"
End Sub

Private Sub zk_OnDeleteTemplate(ByVal EnrollNumber As Long, ByVal FingerIndex As Long)
    WriteToLog "zk_OnDeleteTemplate"
End Sub

Private Sub zk_OnDisConnected()
    WriteToLog "zk_OnDisConnected"
End Sub

Private Sub zk_OnDoor(ByVal EventType As Long)
    WriteToLog "zk_OnDoor"
End Sub

Private Sub zk_OnEmptyCard(ByVal ActionResult As Long)
    WriteToLog "zk_OnEmptyCard"
End Sub

Private Sub zk_OnEnrollFinger(ByVal EnrollNumber As Long, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
    WriteToLog "zk_OnEnrollFinger"
End Sub

Private Sub zk_OnEnrollFingerEx(ByVal EnrollNumber As String, ByVal FingerIndex As Long, ByVal ActionResult As Long, ByVal TemplateLength As Long)
    WriteToLog "zk_OnEnrollFingerEx"
End Sub

Private Sub zk_OnFinger()
    WriteToLog "zk_OnFinger"
End Sub

Private Sub zk_OnFingerFeature(ByVal Score As Long)
    WriteToLog "zk_OnFingerFeature"
End Sub

Private Sub zk_OnHIDNum(ByVal CardNumber As Long)
    WriteToLog "zk_OnHIDNum"
End Sub

Private Sub zk_OnKeyPress(ByVal Key As Long)
    WriteToLog "zk_OnKeyPress"
End Sub

Private Sub zk_OnNewUser(ByVal EnrollNumber As Long)
    WriteToLog "zk_OnNewUser"
End Sub

Private Sub zk_OnVerify(ByVal UserID As Long)
    WriteToLog "zk_OnVerify"
End Sub

Private Sub zk_OnWriteCard(ByVal EnrollNumber As Long, ByVal ActionResult As Long, ByVal Length As Long)
    WriteToLog "zk_OnWriteCard"
End Sub

