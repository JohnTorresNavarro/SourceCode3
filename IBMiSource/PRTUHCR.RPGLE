000100000000      *_________________________________________________________________________
000200000000      *
000300171208      *  Description: Prompt United Health Care History Tracking Report
000400000000      *
000500171208      *  (c)Copyright 2017 by GBS, Inc.
000600000000      *
000700171208      *    Created by:  JALLEN - December 08, 2017
000800000000      *_________________________________________________________________________
000900180725     FUHCARCL3  IF   E           K DISK
001000171208     FACCMST    IF   E           K DISK    EXTFILE('F.ACCMST') PREFIX(A_)
001100171208     FAACODE    IF   E           K DISK
001200171212     FCODESL1   IF   E           K DISK    EXTFILE('F.CODESL1')
001300171208     FPRTUHCP   IF A E           K DISK
001400121223
001500130620     D FromDT          s              8s 0
001600130620     D ToDate          s              8s 0
001700120217
001800000000      * Program status data structure
001900000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000121223
002100121223     C     *Entry        Plist
002200130620     C                   Parm                    FromDt
002300130620     C                   Parm                    ToDate
002400171208
002500171208     C                   movel     FromDt        Input_Date
002600171208     C                   Exsr      EDTDAT
002700171208     C                   movel     OutPut_Date   WWFROM
002800171208     C                   movel     ToDate        Input_Date
002900171208     C                   Exsr      EDTDAT
003000171208     C                   movel     OutPut_Date   WWTODT
003100131127
003200180725     C     FromDt        Setll     UHCARCL3
003300180725     C                   Read      UHCARCL3
003400180725     C                   Dow       not %eof(UHCARCL3)
003500171208     C                   If        UHTRND >= FromDt and
003600171208     C                             UHTRND <= ToDate
003700171208     C     ACCKEY        chain     ACCMST
003800171208     C                   eval      ACNAM1 = %trim(A_ACNAM1)
003900171208     C     A_AACODE      chain     AACODE
004000171208     C                   eval      WWAANM = %trim(AFNAM) + ' ' +
004100171208     C                                      %trim(ALNAM)
004200171212     C     UHNOTE        chain     CODESL1
004300171212     C                   if        %found(CODESL1)
004400171212     C                   eval      WSNOTE = %trim(UHNOTE) + ' - ' +
004500171212     C                                      %trim(LDESCR)
004600171212     C                   else
004700171212     C                   eval      WSNOTE = *blanks
004800171212     C                   end
004900171208     C                   Write     PRTUHCR
005000171208     C                   End
005100180725     C                   Read      UHCARCL3
005200171208     C                   Enddo
005300131127
005400131127     C                   Eval      *inLR = *on
005500131127     C                   Return
005600111118    ? *___________________________________________________________________
005700111118    ? * format Date edit
005800111118    ? *___________________________________________________________________
005900111118    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
006000120914     C                   movel     'YYYYMMDD'    Input_Format
006100120914     C                   movel     'MM/DD/YYYY'  Output_Format
006200111118     C                   Call      'FMTDATE'
006300111118     C                   Parm                    Input_Date       32
006400111118     C                   Parm                    Input_Format     32
006500111118     C                   Parm                    Output_Format    32
006600111118     C                   Parm                    Output_Date      32
006700111118     C                   Parm                    Output_Error     10
006800111118    ?C                   Endsr                                                  END DLT RQST
006900000000      *___________________________________________________________________
007000000000      * Key Lists
007100000000      *___________________________________________________________________
007200000000     C     KLIST         BEGSR
007300171208    ***
007400171208     C     ACCKEY        klist
007500171208     C                   kfld                    UHTRST
007600171208     C                   kfld                    UHSUB#
007700171208     C                   kfld                    UHACCT
007800171208    ***
007900000000     C                   ENDSR
008000121223      *___________________________________________________________________
008100121223      * Program open
008200121223      *___________________________________________________________________
008300121223     C     *INZSR        BEGSR
008400121223     C                   ENDSR
008500000000      *___________________________________________________________________
008600000000      * Program error handler
008700000000      *___________________________________________________________________
008800000000     C     *PSSR         BEGSR
008900000000     C                   CALL      'SNDRPGM'                            50
009000000000     C                   PARM                    WQPGMN
009100000000     C                   PARM                    WQSTSC
009200000000     C                   PARM                    WQRPGS
009300000000     C                   PARM                    WQMSG
009400000000     C                   ENDSR     '*CANCL'
