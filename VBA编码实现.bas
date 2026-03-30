Option Explicit

' 【仅需修改这里的路径，其他不用动】
Const SRC_PATH As String = "D:\新建文件夹 (4)\实验任务\课程成绩\"
Const OUT_PATH As String = "D:\新建文件夹 (4)\实验任务\学生成绩\"

Sub 成绩绩点全流程_固定列号终极版()
    ' 变量声明
    Dim wb As Workbook
    Dim wsSum As Worksheet
    Dim fName As String, lastRow As Long, nextRow As Long
    Dim tempWb As Workbook
    Dim firstFile As Boolean
    Dim i As Long, r As Long
    Dim scoreVal As String, sid As String, stuName As String
    Dim numScore As Double, cred As Double, gpaVal As Double
    Dim totalWeight As Double, totalCredit As Double
    Dim dictStuGPA As Object, dictStuName As Object
    Dim wsGPA As Worksheet
    Dim newWb As Workbook
    Dim exportCount As Long
    
    ' Excel设置
    Application.ScreenUpdating = False
    Application.DisplayAlerts = False
    Application.Calculation = xlCalculationManual ' 关闭自动计算，提速
    Set wb = ThisWorkbook
    
    ' ======================================
    ' 1. 初始化成绩汇总表
    ' ======================================
    On Error Resume Next
    Set wsSum = wb.Sheets("成绩汇总")
    On Error GoTo 0
    
    If wsSum Is Nothing Then
        Set wsSum = wb.Worksheets.Add(Before:=wb.Sheets(1))
        wsSum.Name = "成绩汇总"
    Else
        wsSum.Cells.Clear
    End If
    
    ' ======================================
    ' 2. 批量合并所有成绩文件
    ' ======================================
    fName = Dir(SRC_PATH & "*.xlsx")
    nextRow = 1
    firstFile = True
    
    Do While fName <> ""
        If fName <> wb.Name Then
            Set tempWb = Workbooks.Open(SRC_PATH & fName, ReadOnly:=True)
            
            With tempWb.Sheets(1)
                lastRow = .Cells(.Rows.Count, 1).End(xlUp).Row
                If lastRow >= 1 Then
                    ' 复制表头
                    If firstFile Then
                        .Rows(1).Copy wsSum.Cells(1, 1)
                        firstFile = False
                        nextRow = 2
                    End If
                    ' 复制数据
                    If lastRow >= 2 Then
                        .Rows("2:" & lastRow).Copy wsSum.Cells(nextRow, 1)
                        nextRow = wsSum.Cells(wsSum.Rows.Count, 1).End(xlUp).Row + 1
                    End If
                End If
            End With
            
            tempWb.Close SaveChanges:=False
        End If
        fName = Dir
    Loop
    
    ' 无数据容错
    If wsSum.Cells(1, 1).Value = "" Then
        MsgBox "未找到任何成绩文件！请检查路径是否正确", vbCritical
        GoTo 程序结束
    End If
    lastRow = wsSum.Cells(wsSum.Rows.Count, 1).End(xlUp).Row
    MsgBox "✅ 数据合并完成，共 " & lastRow - 1 & " 条成绩记录", vbInformation
    
    ' ======================================
    ' 3. 【固定列号，彻底杜绝匹配错误】
    ' ======================================
    Const 学号列 As Long = 2    ' B列
    Const 姓名列 As Long = 3    ' C列
    Const 成绩列 As Long = 4    ' D列
    Const 学分列 As Long = 6    ' F列
    Dim 绩点列 As Long: 绩点列 = 9 ' I列
    
    ' 清空原有绩点列
    wsSum.Columns(绩点列).Clear
    wsSum.Cells(1, 绩点列).Value = "绩点"
    
    ' ======================================
    ' 4. 【加固版】单科学绩点计算（再也不会算成0）
    ' ======================================
    For i = 2 To lastRow
        ' 读取成绩，彻底清理空格和不可见字符
        scoreVal = Trim(Replace(Replace(Replace(wsSum.Cells(i, 成绩列).Value, Chr(10), ""), Chr(13), ""), Chr(9), ""))
        
        Select Case True
            Case scoreVal = "缓考"
                wsSum.Cells(i, 绩点列).Value = "缓考"
            Case scoreVal = "旷考" Or scoreVal = "缺考" Or scoreVal = "取消"
                wsSum.Cells(i, 绩点列).Value = 0
            Case IsNumeric(scoreVal)
                ' 强制转数字，兼容文本型成绩
                numScore = CDbl(scoreVal)
                ' 绩点规则
                If numScore >= 95 Then
                    gpaVal = 5.0
                ElseIf numScore >= 60 Then
                    gpaVal = Round(1.5 + (numScore - 60) * 0.1, 2)
                Else
                    gpaVal = 0
                End If
                wsSum.Cells(i, 绩点列).Value = gpaVal
            Case Else
                ' 非数字内容，绩点0
                wsSum.Cells(i, 绩点列).Value = 0
        End Select
    Next i
    MsgBox "✅ 单科学绩点计算完成", vbInformation
    
    ' ======================================
    ' 5. 【彻底修复】按学号计算加权综合绩点
    ' ======================================
    Set dictStuName = CreateObject("Scripting.Dictionary") ' 学号-姓名
    Set dictStuGPA = CreateObject("Scripting.Dictionary")  ' 学号-综合绩点
    
    ' 第一步：先收集所有不重复的学生
    For i = 2 To lastRow
        ' 彻底清理学号的空格和不可见字符
        sid = Trim(Replace(Replace(Replace(wsSum.Cells(i, 学号列).Value, Chr(10), ""), Chr(13), ""), Chr(9), ""))
        stuName = Trim(wsSum.Cells(i, 姓名列).Value)
        If sid <> "" And Not dictStuName.Exists(sid) Then
            dictStuName(sid) = stuName
        End If
    Next i
    
    ' 第二步：逐个学生计算综合绩点
    For i = 0 To dictStuName.Count - 1
        sid = dictStuName.Keys()(i)
        totalWeight = 0 ' 绩点×学分 总和
        totalCredit = 0 ' 总学分
        
        ' 循环所有成绩行，累加当前学生的绩点和学分
        For r = 2 To lastRow
            Dim currentSid As String
            currentSid = Trim(Replace(Replace(Replace(wsSum.Cells(r, 学号列).Value, Chr(10), ""), Chr(13), ""), Chr(9), ""))
            
            If currentSid = sid Then
                ' 强制学分转数字，彻底解决文本学分问题
                cred = 0
                If IsNumeric(wsSum.Cells(r, 学分列).Value) Then
                    cred = CDbl(wsSum.Cells(r, 学分列).Value)
                End If
                
                ' 读取单科学绩点
                gpaVal = 0
                If IsNumeric(wsSum.Cells(r, 绩点列).Value) Then
                    gpaVal = CDbl(wsSum.Cells(r, 绩点列).Value)
                End If
                
                ' 累加
                If cred > 0 Then
                    totalWeight = totalWeight + gpaVal * cred
                    totalCredit = totalCredit + cred
                End If
            End If
        Next r
        
        ' 计算最终综合绩点
        If totalCredit > 0 Then
            dictStuGPA(sid) = Round(totalWeight / totalCredit, 4)
        Else
            dictStuGPA(sid) = 0
        End If
    Next i
    
    ' ======================================
    ' 6. 生成综合绩点汇总表（再也不会空白/全0）
    ' ======================================
    On Error Resume Next
    wb.Sheets("综合绩点汇总").Delete
    On Error GoTo 0
    
    Set wsGPA = wb.Worksheets.Add(After:=wsSum)
    wsGPA.Name = "综合绩点汇总"
    wsGPA.Range("A1:C1").Value = Array("学号", "姓名", "综合绩点")
    wsGPA.Range("A1:C1").Font.Bold = True
    
    ' 写入所有学生的综合绩点
    r = 2
    For i = 0 To dictStuName.Count - 1
        sid = dictStuName.Keys()(i)
        wsGPA.Cells(r, 1).Value = "'" & sid ' 强制文本格式，避免科学计数法
        wsGPA.Cells(r, 2).Value = dictStuName(sid)
        wsGPA.Cells(r, 3).Value = dictStuGPA(sid)
        r = r + 1
    Next i
    wsGPA.Columns.AutoFit
    wsSum.Columns.AutoFit
    MsgBox "✅ 综合绩点汇总表生成完成，共 " & dictStuName.Count & " 名学生", vbInformation
    
    ' ======================================
    ' 7. 导出带综合绩点的个人成绩单
    ' ======================================
    If Dir(OUT_PATH, vbDirectory) = "" Then MkDir OUT_PATH
    exportCount = 0
    
    For i = 0 To dictStuName.Count - 1
        sid = dictStuName.Keys()(i)
        stuName = dictStuName(sid)
        Dim finalGPA As Double: finalGPA = dictStuGPA(sid)
        
        ' 筛选当前学生的成绩
        wsSum.Range("A1").CurrentRegion.AutoFilter Field:=学号列, Criteria1:="*" & sid & "*"
        
        ' 新建工作簿，复制成绩
        Set newWb = Workbooks.Add(xlWBATWorksheet)
        wsSum.Range("A1").CurrentRegion.SpecialCells(xlCellTypeVisible).Copy
        newWb.Sheets(1).Range("A1").PasteSpecial xlPasteAll
        
        ' 顶部添加综合绩点
        newWb.Sheets(1).Rows("1:2").Insert
        newWb.Sheets(1).Range("A1").Value = "学号：" & sid
        newWb.Sheets(1).Range("B1").Value = "姓名：" & stuName
        newWb.Sheets(1).Range("C1").Value = "综合绩点：" & finalGPA
        newWb.Sheets(1).Range("A1:C1").Font.Bold = True
        newWb.Sheets(1).Columns.AutoFit
        
        ' 保存
        newWb.SaveAs OUT_PATH & sid & "_" & stuName & ".xlsx"
        newWb.Close SaveChanges:=False
        exportCount = exportCount + 1
        
        wsSum.AutoFilterMode = False
    Next i
    
    ' ======================================
    ' 程序结束
    ' ======================================
程序结束:
    Application.ScreenUpdating = True
    Application.DisplayAlerts = True
    Application.Calculation = xlCalculationAutomatic
    Application.CutCopyMode = False
    
    MsgBox "✅ 全部处理完成！" & vbCrLf & _
           "共统计 " & dictStuName.Count & " 名学生" & vbCrLf & _
           "成功导出 " & exportCount & " 个个人成绩单", vbInformation
End Sub
