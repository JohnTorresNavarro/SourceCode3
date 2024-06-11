000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Write flags to DBEDTL834 at end of process
000400000000      *
000500000000      *  (c)Copyright 2010 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - April 21, 2010
000800000000      *_________________________________________________________________________
000900150713     FDBEDTL834 UP   E             DISK
001000160201     FDBESHP834 O  a E             DISK
001100110407
001200110705     D W80EFF          s              8s 0
001300110705     D W80TRM          s              8s 0
001400110407
001500000000      * Program status data structure
001600000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001700110705
001800150713      * Split out SHOP
001900150713     C                   If        %trim(D3CNTR) = 'SC'
002000160201     C                   Write     DBESHPR
002100150713     C                   Delete    DBEDTLR
002200150713     C                   End
002300110705      *___________________________________________________________________
002400110705      * Format Date
002500110705      *___________________________________________________________________
002600110705     C     FormatDateSR  BEGSR
002700110705     C                   Call      'FMTDATE'
002800110705     C                   Parm                    Input_Date       32
002900110705     C                   Parm                    Input_Format     32
003000110705     C                   Parm                    Output_Format    32
003100110705     C                   Parm                    Output_Date      32
003200110705     C                   Parm                    Output_Error     10
003300110705     C                   Eval      Input_Date   = *blanks
003400110705     C                   Eval      Input_Format = *blanks
003500110705     C                   Eval      OutPut_Format = *blanks
003600110705     C                   ENDSR
