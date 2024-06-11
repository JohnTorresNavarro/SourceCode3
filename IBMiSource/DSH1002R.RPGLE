000100160708     H option(*noDebugIo) DftActGrp(*no)
000200160708    ? *-------------------------------------------------------------------------
000300160708    ? *
000400170630    ? *  Description: Prompt for TSA and Date Range
000500160708      *
000600170629    ? *  Programmer.: Jon Allen
000700170630    ? *  Date.......: 06/30/2017
000800160708    ? *
000900160708    ? *
001000160708    ? *-------------------------------------------------------------------------
001100170630    ?FDSH1002D  CF   E             WORKSTN
001200160926     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300160926
001400160708    ? *-------------------------------------------------------------------------
001500170629     d hasError        s               n   inz
001600170630     d errTsa          s               n   inz
001700170630     d errDate         s               n   inz
001800170630     d wdate           s              8s 0 inz
001900170630     d mydate          s               d
002000161010
002100160926    ? *-------------------------------------------------------------------------
002200170310      *?Mainline Program
002300160926      *-------------------------------------------------------------------------
002400170629     C     *Entry        plist
002500170629     C                   parm                    TRS               3
002600170629     C                   parm                    SUB               3
002700170629     C                   parm                    ACT               4
002800170629     C                   parm                    DATE1             8
002900170630     C                   parm                    DATE2             8
003000170630     C                   parm                    SBMPGM            1
003100160926
003200170310      /Free
003300160708
003400170630             //?Stay unless exit is clicked
003500160708          Dou btnExit = *on;
003600160926             Exfmt Screen1;
003700160922
003800170630             //?If exit button leave
003900160926             if btnExit = *on;
004000160926                leave;
004100160926             endif;
004200160926
004300160926             //?Check for Errors
004400160926             exsr Validate;
004500161103
004600170630             //?If error then show error popup
004700170629             if hasError = *on ;
004800170630             if errTSA = *on and errDate = *off;
004900170630             exfmt TSAerror ;
005000170629             endif;
005100170630             if errTSA = *off and errDate = *on;
005200170630             exfmt DATerror ;
005300170630             endif;
005400170630             if errTSA = *on and errDate = *on;
005500170630             exfmt TDerror ;
005600170630             endif;
005700170629             endif;
005800170629
005900170630             //?If Print clicked and no errors, run report
006000170630             if btnPrint = *on and hasError = *off;
006100170629             exsr report;
006200170630             exfmt submitted;
006300170629             leave;
006400170630             else;
006500170630             trs = *blanks;
006600170630             sub = *blanks;
006700170630             act = *blanks;
006800170630             date1 = *blanks;
006900170630             date2 = *blanks;
007000170630             sbmpgm = *blanks;
007100170629             endif;
007200170629
007300160926
007400160922          enddo;
007500160922
007600170630       eval *inlr = *on;
007700170630       return;
007800160926      *-------------------------------------------------------------------------
007900160926       Begsr Validate;
008000160926
008100160926          hasError = *off;
008200160926
008300170630          errTSA  = *off;
008400170630          errDate = *off;
008500160926
008600160926          //?Trust Number.
008700160926          if s1Trst = *Zero;
008800160926             hasError = *on;
008900170630             errTsa  = *on;
009000160926          endif;
009100160926
009200160926          //?Sub Account Number.
009300160926          if s1Sub = *Zero;
009400160926             hasError = *on;
009500170630             errTsa = *on;
009600160926          endif;
009700160926
009800160926          //?Account Number.
009900160926          if s1Acct = *Zero;
010000160926             hasError = *on;
010100170630             errTsa  = *on;
010200160926          endif;
010300170630
010400170630          //?From Date
010500170630          if DateFR = *blanks;
010600170630             hasError = *on;
010700170630             errDate = *on;
010800170630          endif;
010900170630
011000170630          //?From Date
011100170630          if DateTo = *blanks;
011200170630             hasError = *on;
011300170630             errDate = *on;
011400170630          endif;
011500170630
011600170630          monitor;
011700170630          mydate = %date( dateFR : *ISO );
011800170630          on-error;
011900170630             hasError = *on;
012000170630             errDate = *on;
012100170630             dateFR = *blanks;
012200170630          endmon;
012300170630
012400170630          monitor;
012500170630          mydate = %date( dateTO : *ISO );
012600170630          on-error;
012700170630             hasError = *on;
012800170630             errDate = *on;
012900170630             dateTO = *blanks;
013000170630          endmon;
013100160926
013200160926
013300160926       Endsr;
013400160926      *-------------------------------------------------------------------------
013500160926       Begsr ErrorWindow;
013600160926
013700170630          btnPrint = *off;
013800161103
013900160926       Endsr;
014000170629      *-------------------------------------------------------------------------
014100170629     C     report        begsr
014200170629     C                   move      s1trst        TRS
014300170629     C                   move      s1sub         SUB
014400170629     C                   move      s1acct        ACT
014500170630     C                   eval      wdate = %dec(%char(%date(dateFR:*usa)
014600170630     C                             :*iso0):8:0)
014700170630     C                   move      wdate         DATE1
014800170630     C                   eval      wdate = %dec(%char(%date(dateTO:*usa)
014900170630     C                             :*iso0):8:0)
015000170630     C                   move      wdate         DATE2
015100170630     C                   movel     'Y'           SBMPGM
015200170629     C                   endsr
