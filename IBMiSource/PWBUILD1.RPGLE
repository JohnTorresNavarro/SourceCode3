000100080618     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200080618     H option(*SRCSTMT: *NODEBUGIO)
000300000000    ? *_________________________________________________________________________
000400000000    ? *
000500220131    ? *  Description:  Check for invalid dates
000600000000    ? *___________________________________________________________________
000700070718     FACCOSP    UP   E           K DISK
000800080618
000900220131     D updflg          s              1a   inz
001000070719     D Today           s              8S 0 inz
001100070719     D Tomorrow        s              8S 0 inz
001200070719    ?D  TodayISO       S               D   datfmt(*ISO)
001300070718
001400070718      *---------------------------------------------------------------*
001500220131     C                   eval      updflg = 'N'
001600130524
001700220131     C                   if        AOBEDT <> 0
001800220131     C                   Movel     AOBEDT        Input_Date
001900220131     C                   Exsr      EDTDAT
002000220131     C                   If        Output_Error <> *Blanks
002100220131     C                   eval      updflg = 'Y'
002200220131     C     AOBEDT        Mult      10000.0001    AOBEDT
002300220131     C                   Movel     AOBEDT        Input_Date
002400220131     C                   Exsr      EDTDAT
002500220131     C                   If        Output_Error <> *Blanks
002600220131     C                   eval      updflg = 'Y'
002700220131     C                   clear                   AOBEDT
002800220131     C                   Endif
002900220131     C                   Endif
003000220131     C                   Endif
003100220131
003200220131     C                   if        AOENDT <> 0
003300220131     C                   Movel     AOENDT        Input_Date
003400220131     C                   Exsr      EDTDAT
003500220131     C                   If        Output_Error <> *Blanks
003600220131     C                   eval      updflg = 'Y'
003700220131     C     AOENDT        Mult      10000.0001    AOENDT
003800220131     C                   Movel     AOENDT        Input_Date
003900220131     C                   Exsr      EDTDAT
004000220131     C                   If        Output_Error <> *Blanks
004100220131     C                   eval      updflg = 'Y'
004200220131     C                   clear                   AOENDT
004300220131     C                   Endif
004400220131     C                   Endif
004500220131     C                   Endif
004600130524
004700220131     C                   if        updflg = 'Y'
004800220131     C                   update    ACCOSPR
004900220131     C                   eval      updflg = ' '
005000220131     C                   Endif
005100070718      *---------------------------------------------------------------*
005200070718     C     *inzsr        Begsr
005300070718     C                   Endsr
005400220131    ? *___________________________________________________________________
005500220131    ? * format Date edit
005600220131    ? *___________________________________________________________________
005700220131    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
005800220131     C                   movel     'YYYYMMDD'    Input_Format
005900220131     C                   Call      'FMTDATE'
006000220131     C                   Parm                    Input_Date       32
006100220131     C                   Parm                    Input_Format     32
006200220131     C                   Parm                    Output_Format    32
006300220131     C                   Parm                    Output_Date      32
006400220131     C                   Parm                    Output_Error     10
006500220131    ?C                   Endsr                                                  END DLT RQST
