000100170808     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200170808     H option(*SRCSTMT: *NODEBUGIO)
000300160708    ? *-------------------------------------------------------------------------
000400160708    ? *
000500191029    ? *  Description: Daily OE Transactions Report
000600160708      *
000700170629    ? *  Programmer.: Jon Allen
000800191029    ? *  Date.......: 10/29/2019
000900160708    ? *
001000160708    ? *
001100160708    ? *-------------------------------------------------------------------------
001200191029    ?FDSH1007D  CF   E             WORKSTN
001300160926     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001400170808
001500170808     D/COPY *LIBL/QMODSRC,PR0003RPR            // Check Program Authority
001600160926
001700160708    ? *-------------------------------------------------------------------------
001800170629     d hasError        s               n   inz
001900170630     d errTsa          s               n   inz
002000170630     d errDate         s               n   inz
002100170630     d wdate           s              8s 0 inz
002200170630     d mydate          s               d
002300170808
002400170808    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002500170808     D  @pgmq            *proc
002600161010
002700160926    ? *-------------------------------------------------------------------------
002800170310      *?Mainline Program
002900160926      *-------------------------------------------------------------------------
003000170629     C     *Entry        plist
003100170629     C                   parm                    TRS               3
003200170629     C                   parm                    SUB               3
003300170629     C                   parm                    ACT               4
003400170629     C                   parm                    DATE1             8
003500170630     C                   parm                    DATE2             8
003600170630     C                   parm                    SBMPGM            1
003700160926
003800170310      /Free
003900160708
004000170630             //?Stay unless exit is clicked
004100160708          Dou btnExit = *on;
004200160926             Exfmt Screen1;
004300160922
004400170630             //?If exit button leave
004500160926             if btnExit = *on;
004600160926                leave;
004700160926             endif;
004800160926
004900160926             //?Check for Errors
005000160926             exsr Validate;
005100161103
005200170630             //?If error then show error popup
005300170629             if hasError = *on ;
005400170630             if errTSA = *on and errDate = *off;
005500170630             exfmt TSAerror ;
005600170629             endif;
005700170630             if errTSA = *off and errDate = *on;
005800170630             exfmt DATerror ;
005900170630             endif;
006000170630             if errTSA = *on and errDate = *on;
006100170630             exfmt TDerror ;
006200170630             endif;
006300170629             endif;
006400170629
006500170630             //?If Print clicked and no errors, run report
006600170630             if btnPrint = *on and hasError = *off;
006700170629             exsr report;
006800170630             exfmt submitted;
006900170629             leave;
007000170630             else;
007100170630             trs = *blanks;
007200170630             sub = *blanks;
007300170630             act = *blanks;
007400170630             date1 = *blanks;
007500170630             date2 = *blanks;
007600170630             sbmpgm = *blanks;
007700170629             endif;
007800170629
007900160926
008000160922          enddo;
008100160922
008200170630       eval *inlr = *on;
008300170630       return;
008400160926      *-------------------------------------------------------------------------
008500160926       Begsr Validate;
008600160926
008700160926          hasError = *off;
008800160926
008900170630          errTSA  = *off;
009000170630          errDate = *off;
009100170811
009200170811          //?Only required if selecting by account
009300170811       if s1Trst <> 0 or s1Sub <> 0 or s1Acct <> 0;
009400160926
009500160926          //?Trust Number.
009600160926          if s1Trst = *Zero;
009700160926             hasError = *on;
009800170630             errTsa  = *on;
009900160926          endif;
010000160926
010100160926          //?Sub Account Number.
010200160926          if s1Sub = *Zero;
010300160926             hasError = *on;
010400170630             errTsa = *on;
010500160926          endif;
010600160926
010700160926          //?Account Number.
010800160926          if s1Acct = *Zero;
010900160926             hasError = *on;
011000170630             errTsa  = *on;
011100160926          endif;
011200170630
011300170811       endif;
011400170630          //?From Date
011500170630          if DateFR = *blanks;
011600170630             hasError = *on;
011700170630             errDate = *on;
011800170630          endif;
011900170630
012000170630          //?From Date
012100170630          if DateTo = *blanks;
012200170630             hasError = *on;
012300170630             errDate = *on;
012400170630          endif;
012500170630
012600170630          monitor;
012700170809          mydate = %date( dateFR : *USA );
012800170630          on-error;
012900170630             hasError = *on;
013000170630             errDate = *on;
013100170630             dateFR = *blanks;
013200170630          endmon;
013300170630
013400170630          monitor;
013500170809          mydate = %date( dateTO : *USA );
013600170630          on-error;
013700170630             hasError = *on;
013800170630             errDate = *on;
013900170630             dateTO = *blanks;
014000170630          endmon;
014100160926
014200160926
014300160926       Endsr;
014400160926      *-------------------------------------------------------------------------
014500160926       Begsr ErrorWindow;
014600160926
014700170630          btnPrint = *off;
014800161103
014900160926       Endsr;
015000170629      *-------------------------------------------------------------------------
015100170629     C     report        begsr
015200170629     C                   move      s1trst        TRS
015300170629     C                   move      s1sub         SUB
015400170629     C                   move      s1acct        ACT
015500170630     C                   eval      wdate = %dec(%char(%date(dateFR:*usa)
015600170809     C                             :*iso0):8:0)
015700170630     C                   move      wdate         DATE1
015800170630     C                   eval      wdate = %dec(%char(%date(dateTO:*usa)
015900170809     C                             :*iso0):8:0)
016000170630     C                   move      wdate         DATE2
016100170630     C                   movel     'Y'           SBMPGM
016200170629     C                   endsr
016300170808      // ----------------------------------------------------------------
016400170808       Begsr *Inzsr;
016500170808
016600170808         //?Check Program Authority
016700170808         ChkPgmAuth(@pgmq : oContinue);
016800170808         if oContinue = 'N';
016900170808            *inlr = *on;
017000170808            Return;
017100170808         endif;
017200170808
017300170808       Endsr;
