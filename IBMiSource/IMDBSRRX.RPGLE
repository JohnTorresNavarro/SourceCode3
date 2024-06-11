000100160708     H option(*noDebugIo) DftActGrp(*no)
000200160708    ? *-------------------------------------------------------------------------
000300160708    ? *
000400191003    ? *  Description: IMD Broker Status Report  nge
000500160708      *
000600170629    ? *  Programmer.: Jon Allen
000700191003    ? *  Date.......: 10/03/2019
000800160708    ? *
000900160708    ? *
001000160708    ? *-------------------------------------------------------------------------
001100191003    ?FIMDBSRD   CF   E             WORKSTN
001200160926     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300160926
001400160708    ? *-------------------------------------------------------------------------
001500170629     d hasError        s               n   inz
001600191003     d errYN           s               n   inz
001700170630     d errDate         s               n   inz
001800170630     d wdate           s              8s 0 inz
001900170630     d mydate          s               d
002000191004
002100191004     d pgrp            s              5
002200191004     d cancel          s              1
002300191004     d Today           s              8s 0 inz
002400191004     d fdate           s              8s 0 inz
002500191004     d Tdate           s              8s 0 inz
002600191004     d  wisoT          s               d   datfmt(*iso)
002700191004     d  wisoF          s               d   datfmt(*iso)
002800161010
002900191003     d parm@ds         ds
003000191003     d  p@grp                  1      5a
003100191003     d  p@fr                   6     13s 0
003200191003     d  p@to                  14     21s 0
003300191004
003400191004     d broker          pr                  ExtPgm('WNBRKSRCHR')
003500191004     d  pgrp                          5
003600191004     d  cancel                        1
003700191003
003800160926    ? *-------------------------------------------------------------------------
003900170310      *?Mainline Program
004000160926      *-------------------------------------------------------------------------
004100170629     C     *Entry        plist
004200191003     C                   parm                    PARM             21
004300191003     C                   parm                    SBMJ              1
004400191004
004500191004     C                   eval      Today  = %int(%char(%date : *iso0))
004600191004     C                   eval      Tdate  = %int(%char(%date : *iso0))
004700191004     C                   eval      wisoF = %date
004800191004     C     wisoF         Subdur    6:*M          wisoF
004900191004     C                   eval      wisoT = %date
005000191004     C                   move      wisoF         dateFR
005100191004     C                   move      wisoT         dateTO
005200160926
005300170310      /Free
005400191003
005500191004          eval sbmj = 'N';
005600160708
005700170630             //?Stay unless exit is clicked
005800160708          Dou btnExit = *on;
005900191003             Exfmt rcdfmt1;
006000160922
006100170630             //?If exit button leave
006200160926             if btnExit = *on;
006300160926                leave;
006400160926             endif;
006500191004
006600191004           select;
006700191004           when btnView = '1';
006800191004            exsr getBroker;
006900191004            btnView = '0';
007000191004
007100191004           when btnRefresh = '1';
007200191004            btnRefresh = '0';
007300191004
007400191004           other;
007500160926             //?Check for Errors
007600160926             exsr Validate;
007700161103
007800191004           endsl;
007900191004
008000191004
008100170630             //?If error then show error popup
008200170629             if hasError = *on ;
008300191003             if errYN = *off and errDate = *on;
008400170630             exfmt DATerror ;
008500170630             endif;
008600191004             if errYN = *on and errDate = *off;
008700191003             exfmt YNerror ;
008800170630             endif;
008900170629             endif;
009000170629
009100170630             //?If Print clicked and no errors, run report
009200191003             if btnRun = *on and hasError = *off;
009300170629             exsr report;
009400170630             exfmt submitted;
009500170629             leave;
009600170629             endif;
009700170629
009800160926
009900160922          enddo;
010000160922
010100170630       eval *inlr = *on;
010200170630       return;
010300160926      *-------------------------------------------------------------------------
010400160926       Begsr Validate;
010500160926
010600160926          hasError = *off;
010700160926
010800191003          errYN   = *off;
010900170630          errDate = *off;
011000160926
011100191004          //?Yes No.
011200191003          if s1otherYN = *blanks;
011300160926             hasError = *on;
011400191003             errYN  = *on;
011500160926          endif;
011600170630
011700170630          //?From Date
011800170630          if DateFR = *blanks;
011900170630             hasError = *on;
012000170630             errDate = *on;
012100170630          endif;
012200170630
012300170630          //?From Date
012400170630          if DateTo = *blanks;
012500170630             hasError = *on;
012600170630             errDate = *on;
012700170630          endif;
012800170630
012900170630          monitor;
013000170630          mydate = %date( dateFR : *ISO );
013100170630          on-error;
013200170630             hasError = *on;
013300170630             errDate = *on;
013400170630             dateFR = *blanks;
013500170630          endmon;
013600170630
013700170630          monitor;
013800170630          mydate = %date( dateTO : *ISO );
013900170630          on-error;
014000170630             hasError = *on;
014100170630             errDate = *on;
014200170630             dateTO = *blanks;
014300170630          endmon;
014400160926
014500160926
014600160926       Endsr;
014700160926      *-------------------------------------------------------------------------
014800160926       Begsr ErrorWindow;
014900160926
015000191003          btnRun = *off;
015100161103
015200160926       Endsr;
015300191004      //========================================================================
015400191004      // get broker
015500191004      //========================================================================
015600191004
015700191004        begsr getBroker;
015800191004
015900191004         broker(pgrp : cancel);
016000191004         if cancel = ' ';
016100191004          s1broker = pgrp;
016200191004         endif;
016300191004
016400191004        endsr;
016500191004
016600170629      *-------------------------------------------------------------------------
016700170629     C     report        begsr
016800191004     C                   select
016900191004     C                   when      %trim(s1broker) = '*ALL'
017000191003     C                   movel     'ALL'         p@grp
017100191004     C                   when      %trim(s1broker) <> *blanks
017200191003     C                   movel     s1broker      p@grp
017300191004     C                   other
017400191004     C                   movel     'ALL'         p@grp
017500191004     C                   endsl
017600191004     C                   eval      wdate = %dec(%char(%date(dateFR:*iso)
017700170630     C                             :*iso0):8:0)
017800191003     C                   move      wdate         p@fr
017900191004     C                   eval      wdate = %dec(%char(%date(dateTO:*iso)
018000170630     C                             :*iso0):8:0)
018100191003     C                   move      wdate         p@to
018200191004     C                   eval      parm = parm@ds
018300191003     C                   eval      sbmj = 'Y'
018400170629     C                   endsr
