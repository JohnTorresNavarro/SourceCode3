000100170808     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200170808     H option(*SRCSTMT: *NODEBUGIO)
000300160708    ? *-------------------------------------------------------------------------
000400160708    ? *
000500190508    ? *  Description: Print Welcome To Group Letters
000600160708      *
000700170629    ? *  Programmer.: Jon Allen
000800190508    ? *  Date.......: 05/08/2019
000900160708    ? *
001000160708    ? *
001100160708    ? *-------------------------------------------------------------------------
001200190508    ?FPRTWLT01D CF   E             WORKSTN
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
002300190508     d pos             s              2s 0 inz
002400170808
002500170808    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002600170808     D  @pgmq            *proc
002700161010
002800160926    ? *-------------------------------------------------------------------------
002900170310      *?Mainline Program
003000160926      *-------------------------------------------------------------------------
003100170629     C     *Entry        plist
003200170629     C                   parm                    TRS               3
003300170629     C                   parm                    SUB               3
003400170629     C                   parm                    ACT               4
003500190508     C                   parm                    DATE1             6
003600190508     C                   parm                    FILTER1           1
003700190508     C                   parm                    SORT1             1
003800190508     C                   parm                    SBMPGM            1
003900160926
004000170310      /Free
004100160708
004200170630             //?Stay unless exit is clicked
004300160708          Dou btnExit = *on;
004400160926             Exfmt Screen1;
004500160922
004600170630             //?If exit button leave
004700160926             if btnExit = *on;
004800160926                leave;
004900160926             endif;
005000160926
005100160926             //?Check for Errors
005200160926             exsr Validate;
005300161103
005400170630             //?If error then show error popup
005500170629             if hasError = *on ;
005600170630             if errTSA = *on and errDate = *off;
005700170630             exfmt TSAerror ;
005800170629             endif;
005900170630             if errTSA = *off and errDate = *on;
006000170630             exfmt DATerror ;
006100170630             endif;
006200170630             if errTSA = *on and errDate = *on;
006300170630             exfmt TDerror ;
006400170630             endif;
006500170629             endif;
006600170629
006700170630             //?If Print clicked and no errors, run report
006800170630             if btnPrint = *on and hasError = *off;
006900170629             exsr report;
007000170630             exfmt submitted;
007100170629             leave;
007200170630             else;
007300170630             trs = *blanks;
007400170630             sub = *blanks;
007500170630             act = *blanks;
007600170630             date1 = *blanks;
007700190508             filter1 = *blanks;
007800190508             sort1 = *blanks;
007900190508             sbmpgm = *blanks;
008000170629             endif;
008100170629
008200160926
008300160922          enddo;
008400160922
008500170630       eval *inlr = *on;
008600170630       return;
008700160926      *-------------------------------------------------------------------------
008800160926       Begsr Validate;
008900160926
009000160926          hasError = *off;
009100160926
009200170630          errTSA  = *off;
009300170630          errDate = *off;
009400170811
009500170811          //?Only required if selecting by account
009600170811       if s1Trst <> 0 or s1Sub <> 0 or s1Acct <> 0;
009700160926
009800160926          //?Trust Number.
009900160926          if s1Trst = *Zero;
010000160926             hasError = *on;
010100170630             errTsa  = *on;
010200160926          endif;
010300160926
010400160926          //?Sub Account Number.
010500160926          if s1Sub = *Zero;
010600160926             hasError = *on;
010700170630             errTsa = *on;
010800160926          endif;
010900160926
011000160926          //?Account Number.
011100160926          if s1Acct = *Zero;
011200160926             hasError = *on;
011300170630             errTsa  = *on;
011400160926          endif;
011500170630
011600170811       endif;
011700170630          //?From Date
011800170630          if DateFR = *blanks;
011900170630             hasError = *on;
012000170630             errDate = *on;
012100170630          endif;
012200190508
012300190508          eval pos = %scan('/':DateFR);
012400190508          if   pos = 0 ;
012500190508             hasError = *on;
012600190508             errDate = *on;
012700190508          endif;
012800170630
012900190508      //  monitor;
013000190508      //  mydate = %date( dateFR : *USA );
013100190508      //  on-error;
013200190508      //     hasError = *on;
013300190508      //     errDate = *on;
013400190508      //     dateFR = *blanks;
013500190508      //  endmon;
013600160926
013700160926       Endsr;
013800160926      *-------------------------------------------------------------------------
013900160926       Begsr ErrorWindow;
014000160926
014100170630          btnPrint = *off;
014200161103
014300160926       Endsr;
014400170629      *-------------------------------------------------------------------------
014500170629     C     report        begsr
014600170629     C                   move      s1trst        TRS
014700170629     C                   move      s1sub         SUB
014800190508     C                   move      s1acct        ACT
014900190508     C                   move      datefr        date1
015000190508     C                   eval      date1 = %subst(datefr:1:2) +
015100190508     C                                     %subst(datefr:4:4)
015200190508     C                   if        s1filter <> *blanks
015300190508     C                   move      s1filter      Filter1
015400190508     C                   else
015500190508     C                   move      'A'           Filter1
015600190508     C                   end
015700190508     C                   if        s1sort <> *blanks
015800190508     C                   move      s1sort        Sort1
015900190508     C                   else
016000190508     C                   move      'A'           Sort1
016100190508     C                   end
016200190508     C                   movel     'Y'           SBMPGM
016300170629     C                   endsr
016400170808      // ----------------------------------------------------------------
016500170808       Begsr *Inzsr;
016600170808
016700190828       //?Check Program Authority - *OFF No longer need it
016800190828       //  ChkPgmAuth(@pgmq : oContinue);
016900190828       //  if oContinue = 'N';
017000190828       //     *inlr = *on;
017100190828       //     Return;
017200190828       //  endif;
017300170808
017400170808       Endsr;
