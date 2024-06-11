000100210826      //Indent ('| ')
000200210826    ? //_________________________________________________________________________
000300210826    ? //                                                                *
000400210826      //  Retrieve pevious week from and to dates                       *
000500210826      //                                                                *
000600210826      //  J.Allen     08.26.2021                                        *
000700210826      //                                                                *
000800210826    ? //_________________________________________________________________________
000900210826
001000210903     D OneWeekAgo      S               D   datfmt(*ISO)
001100210903     D Yesterday       S               D   datfmt(*ISO)
001200130528    ?D ISOToday        S               D   datfmt(*ISO)
001300210826
001400210826     D wwfr            s              8s 0 inz
001500210826     D wwto            s              8s 0 inz
001600210826
001700210826     C     *Entry        plist
001800210901     C                   parm                    wi1               8
001900210901     C                   parm                    wi2               8
002000210901     C                   parm                    wiFrom           10
002100210901     C                   parm                    wiTo             10
002200080619
002300210826                wwto = %int(%char(%date : *iso0));
002400210826                isoToday = %Date(wwto:*iso);
002500210826
002600210903     C     ISOToday      Subdur    1:*d          Yesterday
002700210903     C     ISOToday      Subdur    8:*d          OneWeekAgo
002800210826
002900210903                wwto = %dec(Yesterday);
003000210826                wwfr = %dec(OneWeekAgo);
003100210826
003200210901                wi1 = %char(wwfr);
003300210901                wi2 = %char(wwto);
003400210901
003500210901     C                   movel     wi1           Input_Date
003600210901     C                   exsr      EDTDAT
003700210901     C                   movel     Output_Date   wiFrom
003800210901
003900210901     C                   movel     wi2           Input_Date
004000210901     C                   exsr      EDTDAT
004100210901     C                   movel     Output_Date   wiTo
004200210826
004300210826    ?           Return;
004400210901    ? *___________________________________________________________________
004500210901    ? * format Date edit
004600210901    ? *___________________________________________________________________
004700210901    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
004800210901     C                   movel     'YYYYMMDD'    Input_Format
004900210901     C                   movel     'MM/DD/YYYY'  Output_Format
005000210901     C                   Call      'FMTDATE'
005100210901     C                   Parm                    Input_Date       32
005200210901     C                   Parm                    Input_Format     32
005300210901     C                   Parm                    Output_Format    32
005400210901     C                   Parm                    Output_Date      32
005500210901     C                   Parm                    Output_Error     10
005600210901    ?C                   Endsr                                                  END DLT RQST
