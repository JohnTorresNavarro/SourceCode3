000200000000      *_________________________________________________________________________
000300000000      *
000400110912      *  Description:  MASTER Key Payroll screen 2
000500000000      *
000600110525      *  (c)Copyright 2011 by GBS, Inc.
000700000000      *
000800110525      *    Created by:  JALLEN - May 25, 2011
000900000000      *_________________________________________________________________________
000902110913     FMKEYRAW2  IP   E           K Disk
000903110913     FMKEYRAW   UF   E           K Disk
001423101217
001424110913     C     XSSN          Chain     MKEYRAW
001425110913     C                   If        %found(MKEYRAW)
001426110913     C                   Eval      DPT = XDPT
001427110913     C                   Eval      LJC = XLJC
001428110913     C                   Eval      LOC = XLOC
001500110913     C                   Update    MARR
001501110913     C                   End
001502110913
001600101217    ? *___________________________________________________________________
001700101217    ? * format Date edit
001800101217    ? *___________________________________________________________________
001900101217    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
001901101217     C                   movel     'MM/DD/YY'    Input_Format
002000101217     C                   movel     'YYYYMMDD'    Output_Format
002100101217     C                   Call      'FMTDATE'
002200101217     C                   Parm                    Input_Date       32
002300101217     C                   Parm                    Input_Format     32
002400101217     C                   Parm                    Output_Format    32
002500101217     C                   Parm                    Output_Date      32
002600101217     C                   Parm                    Output_Error     10
002700101217    ?C                   Endsr                                                  END DLT RQST
