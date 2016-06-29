VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "update cardnumber"
      Height          =   495
      Left            =   2880
      TabIndex        =   6
      Top             =   1200
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Leer usuario"
      Height          =   495
      Left            =   2400
      TabIndex        =   5
      Top             =   2040
      Width           =   1215
   End
   Begin VB.TextBox txtPort 
      Height          =   285
      Left            =   1080
      TabIndex        =   4
      Text            =   "4370"
      Top             =   600
      Width           =   1215
   End
   Begin VB.TextBox txtIP 
      Height          =   285
      Left            =   1080
      TabIndex        =   1
      Text            =   "192.168.0.16"
      Top             =   240
      Width           =   1575
   End
   Begin VB.CommandButton ViaProxy 
      Caption         =   "Conectar vía Proxy"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   1200
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "Puerto"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   600
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "IP"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim IsConnected  As Boolean
Dim zk As Object
Dim zk2 As Object

Dim TheName As String
Dim password As String
Dim privilege As Long
Dim IsEnabled As Boolean
Dim CardNumber As String

Private Sub Command1_Click()
    Dim dwMachineNumber As Long
    Dim dwEnrollNumber As String
 
     If IsConnected = False Then
        MsgBox "No conectado"
        Exit Sub
    End If
    
    Call zk.EnableDevice(1, False)
    
    dwMachineNumber = 1
    dwEnrollNumber = "3"
    
    MsgBox zk.SetStrCardNumber("125553")
    MsgBox zk.SSR_SetUserInfo(dwMachineNumber, dwEnrollNumber, TheName, password, privilege, IsEnabled)
    zk.RefreshData (dwMachineNumber)
    
    Call zk.EnableDevice(1, True)
End Sub

Private Sub Command2_Click()
    Dim dwMachineNumber As Long
    Dim dwEnrollNumber As String
        
    If IsConnected = False Then
        MsgBox "No conectado"
        Exit Sub
    End If
    
    Call zk.EnableDevice(1, False)
    
    dwMachineNumber = 1
    dwEnrollNumber = "3"
    
 '   MsgBox zk.ReadAllUserID(dwMachineNumber)
    
    MsgBox zk.SSR_GetUserInfo(dwMachineNumber, dwEnrollNumber, TheName, password, privilege, IsEnabled)
    MsgBox zk.GetStrCardNumber(CardNumber)
    
    MsgBox TheName & " " & password & " " & privilege & " " & IsEnabled & " " & CardNumber
    
    Call zk.EnableDevice(1, True)
End Sub

Private Sub Form_Load()
    IsConnected = False
    Set zk = CreateObject("BSzkem.zkemProxy")
    Set zk2 = CreateObject("BSzkem.ZKProxy2")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    zk.Disconnect
    zk2.Disconnect
End Sub

Private Sub ViaProxy_Click()
    IsConnected = zk2.Connect_Net(txtIP.Text, Int(txtPort.Text))
    Call zk2.EnableDevice(1, True)
    MsgBox ("Listo " & IsConnected)
End Sub

 
