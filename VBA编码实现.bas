Attribute VB_Name = "模块1"
Option Explicit

' 【仅需修改这里的路径】
Const SRC_PATH As String = "D:\新建文件夹 (4)\实验任务\课程成绩\"
Const OUT_PATH As String = "D:\新建文件夹 (4)\实验任务\学生成绩\"

Sub 计算综合绩点_最终版()
    Dim wb As Workbook, wsSum As Worksheet, wsGPA As Worksheet
    Dim lastRow As Long, i As Long, r As Long
    Dim sid As String, stuName As String, cred As Double, gpaVal As Double
    Dim totalWeight As Double, totalCredit As Double
    Dim dictStuName As Object, dictStuGPA As Object
    Dim newWb As Workbook, exportCount As Long
    
    Application.ScreenUpdating = False
    Application.DisplayAlerts = False
    Set wb = ThisWorkbook
    Set wsSum = wb.Sheets("成绩汇总")
    lastRow = wsSum.Cells(wsSum.Rows.Count, 1).End(xlUp).Row
    
    ' 固定列号（适配你的表格）
    Const 学号列 As Long = 2    ' B列
    Const 姓名列 As Long = 3    ' C列
    Const 学分列 As Long = 6    ' F列
    Const 绩点列 As Long = 9    ' I列
    
    ' 1. 收集所有学生
    Set dictStuName = CreateObject("Scripting.Dictionary")
    For i = 2 To lastRow
        sid = Trim(Replace(Replace(wsSum.Cells(i, 学号列).Value, Chr(10), ""), Chr(9), ""))
        stuName = Trim(wsSum.Cells(i, 姓名列).Value)
        If sid <> "" And Not dictStuName.Exists(sid) Then
            dictStuName(sid) = stuName
        End If
    Next i
    
    ' 2. 逐个学生计算综合绩点
    Set dictStuGPA = CreateObject("Scripting.Dictionary")
    For i = 0 To dictStuName.Count - 1
        sid = dictStuName.Keys()(i)
        totalWeight = 0
        totalCredit = 0
        
        For r = 2 To lastRow
            Dim currentSid As String
            currentSid = Trim(Replace(Replace(wsSum.Cells(r, 学号列).Value, Chr(10), ""), Chr(9), ""))
            
            If currentSid = sid Then
                ' 强制学分转数字
                cred = 0
                If IsNumeric(wsSum.Cells(r, 学分列).Value) Then
                    cred = CDbl(wsSum.Cells(r, 学分列).Value)
                End If
                
                ' 读取单科学绩点
                gpaVal = 0
                If IsNumeric(wsSum.Cells(r, 绩点列).Value) Then
                    gpaVal = CDbl(wsSum.Cells(r, 绩点列).Value)
                End If
                
                ' 累加（只要学分>0就统计，包括绩点0）
                If cred > 0 Then
                    totalWeight = totalWeight + gpaVal * cred
                    totalCredit = totalCredit + cred
                End If
            End If
        Next r
        
        ' 计算综合绩点
        If totalCredit > 0 Then
            dictStuGPA(sid) = Round(totalWeight / totalCredit, 4)
        Else
            dictStuGPA(sid) = 0
        End If
    Next i
    
    ' 3. 生成综合绩点汇总表
    On Error Resume Next
    wb.Sheets("综合绩点汇总").Delete
    On Error GoTo 0
    Set wsGPA = wb.Worksheets.Add(After:=wsSum)
    wsGPA.Name = "综合绩点汇总"
    wsGPA.Range("A1:C1").Value = Array("学号", "姓名", "综合绩点")
    wsGPA.Range("A1:C1").Font.Bold = True
    
    r = 2
    For i = 0 To dictStuName.Count - 1
        sid = dictStuName.Keys()(i)
        wsGPA.Cells(r, 1).Value = "'" & sid
        wsGPA.Cells(r, 2).Value = dictStuName(sid)
        wsGPA.Cells(r, 3).Value = dictStuGPA(sid)
        r = r + 1
    Next i
    wsGPA.Columns.AutoFit
    
    ' 4. 导出带综合绩点的个人成绩单
    If Dir(OUT_PATH, vbDirectory) = "" Then MkDir OUT_PATH
    exportCount = 0
    For i = 0 To dictStuName.Count -
