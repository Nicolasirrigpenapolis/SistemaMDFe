VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "GBdTrans"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Public Event BeforeCommitTrans()
Public Event BeforeBeginTrans()
Public Event BeforeRollBackTrans()

Public Event AfterCommitTrans()
Public Event AfterBeginTrans()
Public Event AfterRollBackTrans()

Public Sub AfterBeginTrans()
   RaiseEvent AfterBeginTrans
End Sub

Public Sub AfterCommitTrans()
   RaiseEvent AfterCommitTrans
End Sub

Public Sub AfterRollBackTrans()
   RaiseEvent AfterRollBackTrans
End Sub

Public Sub BeforeBeginTrans()
   RaiseEvent BeforeBeginTrans
End Sub

Public Sub BeforeCommitTrans()
   RaiseEvent BeforeCommitTrans
End Sub

Public Sub BeforeRollBackTrans()
   RaiseEvent BeforeRollBackTrans
End Sub
