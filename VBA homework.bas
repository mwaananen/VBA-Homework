Attribute VB_Name = "Module1"
Sub stockcounter():
    For Each WS In Worksheets
        WS.Activate

'define items

        'Dim stockname As String
        'Dim i As Long
        'Dim OpenPrice As Double
        'OpenPrice = Cells(2, 3).Value '=24.44
        'Dim PercentChange As Double
        'Dim YearlyChange As Double
        'Dim ClosePrice As Double
        'Dim PriceDiff As Double = YearlyChange
        
        Dim OpenPrice_pointer As Long
        OpenPrice_pointer = 2
        
        Dim Summary_Table_Row As Integer
        Summary_Table_Row = 2
    
        Dim TotalVolume As Double
        TotalVolume = 0
       
    
        Range("I1").Value = "Ticker"
        Range("J1").Value = "Yearly Change"
        Range("K1").Value = "Percent Change"
        Range("L1").Value = "Total Stock Volume"
        Range("P1").Value = "Ticker"
        Range("Q1").Value = "Value"
        Range("O2").Value = "Greatest % Increase"
        Range("O3").Value = "Greatest % Decrease"
        Range("O4").Value = "Greatest Total Volume"
        
        RowCount = Cells(Rows.Count, "A").End(xlUp).Row

    
        For i = 2 To RowCount
        
            If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
                TotalVolume = TotalVolume + Cells(i, "G").Value
                stockname = Cells(i, "A").Value
                OpenPrice = Cells(OpenPrice_pointer, "C").Value
                ClosePrice = Cells(i, "F").Value
            
                PercentChange = 0
                'Math
                YearlyChange = ClosePrice - OpenPrice
                PercentChange = YearlyChange / OpenPrice * 100
                
                'New Table
                Range("I" & Summary_Table_Row).Value = stockname
                Range("J" & Summary_Table_Row).Value = YearlyChange
                Range("L" & Summary_Table_Row).Value = TotalVolume
                Range("K" & Summary_Table_Row).Value = PercentChange
                
                If YearlyChange > 0 Then
                    Cells(Summary_Table_Row, "J").Interior.ColorIndex = 4
                ElseIf YearlyChange < 0 Then
                    Cells(Summary_Table_Row, "J").Interior.ColorIndex = 3
                Else
                    Cells(Summary_Table_Row, "J").Interior.ColorIndex = 2
                    
                End If
                
                
                TotalVolume = 0
                OpenPrice_pointer = i + 1
                Summary_Table_Row = Summary_Table_Row + 1
                
            Else
                TotalVolume = TotalVolume + Cells(i, "G").Value
        
            End If

    
        Next i 'Stop Loop
        
        RowCount = Cells(Rows.Count, "I").End(xlUp).Row
        
        
        Greatest_percent_Increase = 0
        Greatest_percent_Decrease = 0
        Greatest_Total = 0

        
        For i = 2 To RowCount
            If Cells(i, "K").Value > Greatest_percent_Increase Then
                Greatest_percent_Increase = Cells(i, "K").Value
                Greatest_Name = Cells(i, "I").Value
            End If
            
             If Cells(i, "K").Value < Greatest_percent_Decrease Then
                Greatest_percent_Decrease = Cells(i, "K").Value
                Decrease_Name = Cells(i, "I").Value
            End If
            
            If Cells(i, "L").Value > Greatest_Total Then
                Greatest_Total = Cells(i, "L").Value
                Total_Name = Cells(i, "I").Value
            End If

        
        
        Next i
        
        Range("P2") = Greatest_Name
        Range("Q2") = Greatest_percent_Increase & "%"
        Range("P3") = Decrease_Name
        Range("Q3") = Greatest_percent_Decrease & "%"
        Range("P4") = Total_Name
        Range("Q4") = Greatest_Total

        WS.Columns("P:Q").AutoFit

        
    Next WS
    
    MsgBox ("Complete")

