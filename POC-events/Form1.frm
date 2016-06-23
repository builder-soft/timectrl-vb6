VERSION 5.00
Begin VB.Form AButton 
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   2040
      TabIndex        =   0
      Top             =   1200
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   375
      Left            =   720
      TabIndex        =   1
      Top             =   240
      Width           =   3375
   End
End
Attribute VB_Name = "AButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'public widtevents  r As Library.Riser
Private WithEvents r As Library.Riser
Attribute r.VB_VarHelpID = -1

Private Sub Command1_Click()
    WriteToLog "On click button"
    
    
    Set r = CreateObject("Library.Riser")
    r.Start
End Sub


Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    r.StopMe
    Set r = Nothing

End Sub

Private Sub r_IntervalEvent(ByVal Time As String)
    Label1.Caption = Time
     
End Sub

Public Sub WriteToLog(Message As String)
    Dim FSO As FileSystemObject
    Dim TS As TextStream

    Set FSO = New FileSystemObject
    
    Set TS = FSO.OpenTextFile(App.Path & "\log" & Format$(Now, "yyyy-mm-dd") & ".txt", ForAppending, True)
    TS.Write Message & vbCrLf
    TS.Close
    
    Set TS = Nothing
    Set FSO = Nothing

End Sub
