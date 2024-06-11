000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Write flags to DBEDTL834 at end of process
000400000000      *
000500000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 21, 2010
000800000000      *_________________________________________________________________________
000900100421     FDBEDTL834 UP   E             DISK
000901110407
000905110705     D W80EFF          s              8s 0
000906110705     D W80TRM          s              8s 0
001204110407
001300000000      * Program status data structure
001400000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001401110705
001402110705      * Sometimes the TRM date is 5/31 should be 6/01.
001403110705      * Same Day Terms
003501110407
003504120626     C********           If        D3MNTYP = 'T' and
003505120626     C                   If        D3FIL41 = 'S' and
003506110705     C                             D3SCEF1 > *blanks and
003507110705     C                             D3SCTR1 > *blanks
003508110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003509110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003510110705     C                   Movel     D3SCEF1       Input_Date
003511110705     C                   Exsr      FormatDateSR
003512110705     C                   Movel     Output_Date   W80EFF
003513110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003514110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003515110705     C                   Movel     D3SCTR1       Input_Date
003516110705     C                   Exsr      FormatDateSR
003517110705     C                   Movel     Output_Date   W80TRM
003518110705     C                   If        W80TRM < W80EFF
003519110705     C                   Eval      D3SCTR1 = %trim(D3SCEF1)
003523110705     C                   End
003524110407     C                   End
003525110705
003526120626     C**************     If        D3MNTYP = 'T' and
003527120626     C                   If        D3FIL42 = 'S' and
003528110705     C                             D3SCEF2 > *blanks and
003529110705     C                             D3SCTR2 > *blanks
003530110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003531110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003532110705     C                   Movel     D3SCEF2       Input_Date
003533110705     C                   Exsr      FormatDateSR
003534110705     C                   Movel     Output_Date   W80EFF
003535110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003536110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003537110705     C                   Movel     D3SCTR2       Input_Date
003538110705     C                   Exsr      FormatDateSR
003539110705     C                   Movel     Output_Date   W80TRM
003540110705     C                   If        W80TRM < W80EFF
003541110705     C                   Eval      D3SCTR2 = %trim(D3SCEF2)
003543110705     C                   End
003544110705     C                   End
003545110705
003546120626     C**************     If        D3MNTYP = 'T' and
003547120626     C                   If        D3FIL43 = 'S' and
003548110705     C                             D3SCEF3 > *blanks and
003549110705     C                             D3SCTR3 > *blanks
003550110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003551110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003552110705     C                   Movel     D3SCEF3       Input_Date
003553110705     C                   Exsr      FormatDateSR
003554110705     C                   Movel     Output_Date   W80EFF
003555110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003556110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003557110705     C                   Movel     D3SCTR3       Input_Date
003558110705     C                   Exsr      FormatDateSR
003559110705     C                   Movel     Output_Date   W80TRM
003560110705     C                   If        W80TRM < W80EFF
003561110705     C                   Eval      D3SCTR3 = %trim(D3SCEF3)
003562110705     C                   End
003563110705     C                   End
003564110705
003565120626     C**************     If        D3MNTYP = 'T' and
003566120626     C                   If        D3FIL44 = 'S' and
003567110705     C                             D3SCEF4 > *blanks and
003568110705     C                             D3SCTR4 > *blanks
003569110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003570110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003571110705     C                   Movel     D3SCEF4       Input_Date
003572110705     C                   Exsr      FormatDateSR
003573110705     C                   Movel     Output_Date   W80EFF
003574110705     C                   Eval      Input_Format = 'MM/DD/YYYY'
003575110705     C                   Eval      Output_Format  = 'YYYYMMDD'
003576110705     C                   Movel     D3SCTR4       Input_Date
003577110705     C                   Exsr      FormatDateSR
003578110705     C                   Movel     Output_Date   W80TRM
003579110705     C                   If        W80TRM < W80EFF
003580110705     C                   Eval      D3SCTR4 = %trim(D3SCEF4)
003581110705     C                   End
003582110705     C                   End
003583110705
003584110705     C                   Update    DBEDTLR
004300110705      *___________________________________________________________________
004400110705      * Format Date
004500110705      *___________________________________________________________________
004600110705     C     FormatDateSR  BEGSR
004700110705     C                   Call      'FMTDATE'
004800110705     C                   Parm                    Input_Date       32
004900110705     C                   Parm                    Input_Format     32
005000110705     C                   Parm                    Output_Format    32
005100110705     C                   Parm                    Output_Date      32
005200110705     C                   Parm                    Output_Error     10
005300110705     C                   Eval      Input_Date   = *blanks
005400110705     C                   Eval      Input_Format = *blanks
005500110705     C                   Eval      OutPut_Format = *blanks
005600110705     C                   ENDSR
