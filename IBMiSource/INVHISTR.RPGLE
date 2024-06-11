000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Retrieve Invoice Totals by TSA date range
000400000000      *
000500000000      *  (c)Copyright 2023 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - July 06, 2023
000800000000      *_________________________________________________________________________
000900230706     FHISTAA    IF   E           K DISK    extfile('QS36F/F.HISTAA')
001000230706
001100230706     D wTrs            S              3S 0
001200230706     D wSub            S              3S 0
001300230706     D wAcc            S              4S 0
001400230706
001500230706     D wFrdt           S              8S 0
001600230706     D wTodt           S              8S 0
001700230706
001800000000      * Program status data structure
001900000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000230706
002100230706     C     *Entry        Plist
002200230706     C                   Parm                    Trs               3
002300230706     C                   Parm                    Sub               3
002400230706     C                   Parm                    Acc               4
002500230706     C                   Parm                    Frdt              8
002600230706     C                   Parm                    Todt              8
002700230706     C                   Parm                    OutAmt           12 2
002800230706
002900230706     C                   eval      wTrs = %dec(Trs:3:0)
003000230706     C                   eval      wSub = %dec(Sub:3:0)
003100230706     C                   eval      wAcc = %dec(Acc:4:0)
003200230706     C                   eval      wFrdt = %dec(Frdt:8:0)
003300230706     C                   eval      wTodt = %dec(Todt:8:0)
003400230706
003500230706     C                   eval      TSA = trs + sub + acc
003600230706     C                   eval      code = 'BMP'
003700230706     C                   clear                   OutAmt
003800230706
003900230706     C     HistKey       setll     HISTAA
004000230706     C     HistKey       reade     HISTAA
004100230706     C                   dow       not %eof(HISTAA)
004200230706     C                   If        TRDATE >= wFrdt and
004300230706     C                             TRDATE <= wTodt
004400230706     C                   eval      OutAmt = OutAmt + TRAMT
004500230706     C                   End
004600230706     C     HistKey       reade     HISTAA
004700230706     C                   enddo
004800230706
004900230706     C                   Return
005000000000      *___________________________________________________________________
005100000000      * Key Lists
005200000000      *___________________________________________________________________
005300000000     C     KLIST         BEGSR
005400230706     C     HistKey       Klist
005500230706     C                   Kfld                    TSA              10
005600230706     C                   Kfld                    CODE              3
005700000000     C                   ENDSR
005800000000      *___________________________________________________________________
005900000000      * Program open
006000000000      *___________________________________________________________________
006100000000     C     *INZSR        BEGSR
006200000000     C                   ENDSR
006300000000      *___________________________________________________________________
006400000000      * Program error handler
006500000000      *___________________________________________________________________
006600000000     C     *PSSR         BEGSR
006700000000     C                   CALL      'SNDRPGM'                            50
006800000000     C                   PARM                    WQPGMN
006900000000     C                   PARM                    WQSTSC
007000000000     C                   PARM                    WQRPGS
007100000000     C                   PARM                    WQMSG
007200000000     C                   ENDSR     '*CANCL'
