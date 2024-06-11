000100170714      *_________________________________________________________________________
000200170714      *
000300170821      *  Description:  Manually Retired Inquiry
000400170714      *
000500170714      *  (c)Copyright 2017 by GBS, Inc.
000600170714      *
000700170821      *    Created by:  JALLEN - Aug 21, 2017
000800170714      *
000900170714      *  Modifications:
001000170714      *
001100170714      *_________________________________________________________________________
001200000000
001300100520      /DEFINE PROFOUNDUI
001400170626
001500170626     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
001600170626     H option(*SRCSTMT: *NODEBUGIO)
001700100520
001800170821     FDSH1005D  CF   E             WorkStn Handler('PROFOUNDUI(HANDLER)')
001900170515     F                                     SFile(SFL1 : RRN)
002000170515     F                                     SFile(SFL2 : RRN2)
002100100520
002200180308     FWEBTRANLF IF   E           K Disk    INFDS(DBFD)
002300180301     FWEBTRANL25UF   E           K Disk    rename(webtranr:webl25)
002400180301     FWEBTRANL39UF   E           K Disk    rename(webtranr:webl39)
002500170628     FACCMST    IF   E           K DISK    extfile('F.ACCMST') prefix(A_)
002600170628     FAACODE    IF   E           K DISK
002700170621     FMEMBER    IF   E           K DISK    extfile('F.MEMBER')
002800170518     FWEBPAYCHP IF   E           K DISK
002900170713     FPLSESSIDP IF   E           K DISK
003000170822     FSLCMRDLF  IF   E           k disk
003100100520
003200170626      * Prototypes
003300170626      /COPY *LIBL/QMODSRC,#chkdectpr
003400170626
003500180305     D RRN             S              5I 0
003600180305     D SETRRN          S              5I 0
003700180305     D PRODRRN         S              5I 0
003800180305     D i               S              5I 0
003900170621     D wwretf          S              1a
004000170518     D wsssid          S             16a
004100170620     D pos             S              3s 0
004200170623     D cnt             S              9s 0
004300170626     D slc             S              3s 0
004400180301     D x               S              3s 0
004500170713     D curtime         s               z
004600180307     D oContinue       S              1a
004700180307     D wsyear          S              6a
004800180305     D curyear         s              4s 0
004900180305     D curmon          s              2s 0
005000180305     D myyear          s              4s 0
005100180305     D mymon           s              2s 0
005200180305     D isoToday        s               d   datfmt(*ISO)
005300180307     D savtrn#         s              9s 0
005400180307     D savgrpv         s             10a
005500180307     D savfldv         s             20a
005600180307     D hldtrn#         s              9s 0
005700170620
005800170713     D savtrs          S              3s 0
005900170713     D savsub          S              3s 0
006000170713     D savact          S              4s 0
006100180309
006200180309     D lstssn          S              9s 0
006300180309     D lstseq          S              2s 0
006400180309     D lsttrn          S              9s 0
006500170713
006600170620     D SFLPAG          C                   Const(13)
006700170621
006800170621     D DSH002R         PR                  ExtPgm('DSH002R')
006900170621     D  retflg                             Like(OERETF)
007000170810
007100170810     D CHKWEBAUTH      PR                  ExtPgm('CHKWEBAUTH')
007200170810     D  pgm                                Like(WQPGMN)
007300170810     D  usr                                Like(WQUSRN)
007400170810     D  flg                                Like(OERETF)
007500100520
007600170515     d d_CCYYMMDD...
007700170515     d                 S               D   datfmt(*ISO)
007800170515     d d_MMDDCCYY...
007900170515     d                 S               D   datfmt(*USA)
008000170515
008100180307     D DBFD          E DS                  EXTNAME(IODBFD)
008200180307
008300170621    ? * Program status data structure
008400170621    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
008500170808     D  @pgmq            *proc
008600170713
008700170713     c     *entry        Plist
008800170713     C                   parm                    inGeni           25
008900170515
009000170713     C     inGeni        Chain     PLSESSIDP
009100170713     C                   if        %found(PLSESSIDP)
009200170713     C                   eval      curtime = %timestamp
009300170713     C                   if        curtime > PSEXPTM
009400170713     C                   eval      *InLr = *On
009500170713     C                   Return
009600170713     C                   else
009700170810     C                   exsr      chkSecurity
009800170713     C                   eval      savtrs = PSTRST
009900170713     C                   eval      savsub = PSSUB#
010000170713     C                   eval      savact = PSACCT
010100170713     C                   end
010200170713     C                   else
010300180307     C****               eval      *InLr = *On
010400180307     C****               Return
010500170713     C                   end
010600170713
010700170713      /FREE
010800100520
010900100520        // Initialize "named indicators.
011000170512        VIEW = *Off;
011100170628        EXIT = *Off;
011200170628        HELP1 = *Off;
011300100520        SFLDSP = *Off;
011400170517        SFLCLR = *Off;
011500170517        GOSSN  = *Off;
011600170623        GOSSID = *Off;
011700170623        Slc = 0;
011800100520
011900180307        if  refresh = *on;
012000180307        SAVTRN# = *zeros;
012100180307        SAVGRPV = *blanks;
012200180307        SAVFLDV = *blanks;
012300180307        endif;
012400180307
012500100520        DoW EXIT = *Off;
012600100520
012700100520          // Clear the subfile.
012800100520          SFLCLR = *On;
012900170512          Write SFLCTL1;
013000100520          SFLCLR = *Off;
013100170620          CNT = 0;
013200100520          RRN = 0;
013300170713
013400100520
013500170517          select ;
013600170517          // Search on SSN
013700170622          when  GOSSN = *ON and SRSSN <> 0 ;
013800170622          SRSSID = *blanks ;
013900180308          SRTRS  = *blanks ;
014000180308          SRSUB  = *blanks ;
014100180308          SRACT  = *blanks ;
014200170517
014300170517          // Load the subfile.
014400180301          SetLL (SRSSN:*LOVAL) WEBTRANL39;
014500180301          Reade (SRSSN) WEBTRANL39;
014600180301          DoW Not %EOF(WEBTRANL39);
014700190226
014800190226          if oeretd <> 0;
014900170822
015000170822          chain oeretf SLCMRDLF;
015100170822          if %found(SLCMRDLF);
015200180301
015300180301          chain (OETRST:OESUB#:OEACCT) accmst ;
015400170620
015500170628          chain (A_AACODE) AACODE ;
015600170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
015700170622
015800170622          chain oessno member ;
015900170622          wsname = %trim(mfname) + ' ' + %trim(MMI) + ' ' + %trim(MLNAME) ;
016000170517
016100170517               d_CCYYMMDD = %date(OEADDD:*ISO);
016200170517               d_MMDDCCYY = d_CCYYMMDD;
016300170517               OEADDD = %dec(d_MMDDCCYY:*USA);
016400170829
016500170829               d_CCYYMMDD = %date(OERETD:*ISO);
016600170829               d_MMDDCCYY = d_CCYYMMDD;
016700170829               OERETD = %dec(d_MMDDCCYY:*USA);
016800170517
016900170627            RRN += 1;
017000170627            CNT += 1;
017100170628            Write SFL1;
017200170822
017300190226          Endif;
017400190226
017500170822          Endif;
017600170620
017700180301            Reade (SRSSN) WEBTRANL39;
017800170517          EndDo;
017900170517
018000170517          // Search on SSID
018100170622          when  GOSSID = *ON and SRSSID <> *blanks ;
018200170622          SRSSN = *zeros ;
018300180308          SRTRS  = *blanks ;
018400180308          SRSUB  = *blanks ;
018500180308          SRACT  = *blanks ;
018600170517
018700170517          // Load the subfile.
018800180301          SetLL (SRSSID:*LOVAL) WEBTRANL25;
018900180309          Reade    (SRSSID) WEBTRANL25;
019000180301          DoW Not %EOF(WEBTRANL25);
019100220203
019200220203          if oeretd <> 0;
019300170822
019400170822          chain oeretf SLCMRDLF;
019500170822          if %found(SLCMRDLF);
019600180301
019700180301          chain (OETRST:OESUB#:OEACCT) accmst ;
019800170622
019900170628          chain (A_AACODE) AACODE ;
020000170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
020100170622
020200170622          chain oessno member ;
020300170622          wsname = %trim(mfname) + ' ' + %trim(MMI) + ' ' + %trim(MLNAME) ;
020400170517
020500170517               d_CCYYMMDD = %date(OEADDD:*ISO);
020600170517               d_MMDDCCYY = d_CCYYMMDD;
020700170517               OEADDD = %dec(d_MMDDCCYY:*USA);
020800170829
020900170829               d_CCYYMMDD = %date(OERETD:*ISO);
021000170829               d_MMDDCCYY = d_CCYYMMDD;
021100170829               OERETD = %dec(d_MMDDCCYY:*USA);
021200170517
021300170627            RRN += 1;
021400170627            CNT += 1;
021500170517            Write SFL1;
021600170822
021700170822          Endif;
021800170620
021900220203          Endif;
022000220203
022100180309            Reade    (SRSSID) WEBTRANL25;
022200170517          EndDo;
022300170517
022400180308          // Other ;
022500180308          when  GOTSA = *ON and SRTRS <> ' ' and
022600180309                SRSUB <> ' ' and SRACT <> ' ' or
022700180309                PageDown = *ON and SRTRS <> ' ' and
022800180309                SRSUB <> ' ' and SRACT <> ' ' or
022900180309                PageUp   = *ON and SRTRS <> ' ' and
023000180309                SRSUB <> ' ' and SRACT <> ' ' ;
023100180309
023200180308          SRSSID = *blanks ;
023300180308          SRSSN  = *zeros  ;
023400180308
023500180308          SAVTRS = %dec(SRTRS:3:0);
023600180308          SAVSUB = %dec(SRSUB:3:0);
023700180308          SAVACT = %dec(SRACT:4:0);
023800170517
023900170621            CNT = 0;
024000100520          // Load the subfile.
024100180307
024200180307          select;
024300180307          when PageDown = *on;
024400180309          SetLL (SAVTRS:SAVSUB:SAVACT:LSTSSN:LSTSEQ:LSTTRN) WEBTRANLF;
024500180309          Reade    (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
024600180307
024700180307          when PageUp = *on;
024800180309          SetLL (SAVTRS:SAVSUB:SAVACT:LSTSSN:LSTSEQ:LSTTRN) WEBTRANLF;
024900180307          exsr Prev;
025000180309          Reade    (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
025100180307
025200180307          Other;
025300180308          SetLL (SAVTRS:SAVSUB:SAVACT:*LoVal) WEBTRANLF;
025400180309          Reade    (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
025500180307          Endsl;
025600180307
025700180308          DoW Not %EOF(WEBTRANLF);
025800170822
025900170822          chain oeretf SLCMRDLF;
026000170822          if %found(SLCMRDLF);
026100180305
026200180309          LSTSSN = OESSNO;
026300180309          LSTSEQ = OEDSEQ;
026400180309          LSTTRN = OETRN#;
026500180309
026600180305          isotoday = %date(OERETD : *iso);
026700180305          curYear  = %subdt(ISOtoday: *Y);
026800180305          curMon   = %subdt(ISOtoday: *M);
026900180307       // if curYear = myYear and curMon = myMon;
027000180301
027100180301          chain (OETRST:OESUB#:OEACCT) accmst ;
027200170621
027300170628          chain (A_AACODE) AACODE ;
027400170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
027500170621
027600170621          chain oessno member ;
027700170621          wsname = %trim(mfname) + ' ' + %trim(MMI) + ' ' + %trim(MLNAME) ;
027800170621
027900170517               d_CCYYMMDD = %date(OEADDD:*ISO);
028000170517               d_MMDDCCYY = d_CCYYMMDD;
028100170517               OEADDD = %dec(d_MMDDCCYY:*USA);
028200170829
028300170829               d_CCYYMMDD = %date(OERETD:*ISO);
028400170829               d_MMDDCCYY = d_CCYYMMDD;
028500170829               OERETD = %dec(d_MMDDCCYY:*USA);
028600170623
028700180308            SAVTRS  = OETRST;
028800180308            SAVSUB  = OESUB#;
028900180308            SAVACT  = OEACCT;
029000170627            CNT += 1;
029100170627            RRN += 1;
029200100520            Write SFL1;
029300170822
029400180307       // endif;
029500170822          endif;
029600180301
029700180307          if cnt = 10;
029800180307          CNT = 0;
029900180307          leave;
030000180301          endif;
030100170626
030200180307          select;
030300180307          when PageDown = *on;
030400180308            Read WEBTRANLF;
030500180307          when PageUp = *on;
030600180308            Read WEBTRANLF;
030700180307          Other;
030800180308            Read WEBTRANLF;
030900180307          Endsl;
031000170620
031100100520          EndDo;
031200170517
031300170517          Endsl;
031400170517
031500180307            PageDown = *off;
031600180307            PageUp = *off;
031700180307
031800180307          //?Setup Directional Links.
031900180307          //?Page Down
032000180307          EnableDown = *On;
032100180307
032200180307        //Setgt (SAVTRN#) WEBTRAN;
032300180307        //read  WEBTRAN;
032400180307        //if %eof(WEBTRAN);
032500180307        //   EnableDown = *Off;
032600180307        //endif;
032700180307
032800180307          //?Page Up
032900180307          EnableUp = *On;
033000180307
033100180307        //Setll (SAVTRN#) WEBTRAN;
033200180307        //readp WEBTRAN;
033300180307        //if %eof(WEBTRAN);
033400180307        //   EnableUp = *Off;
033500180307        //endif;
033600180307
033700170517
033800100520          // Display the subfile.
033900100520          SFLDSP = *On;
034000100520          ExFmt SFLCTL1;
034100170628
034200170628        dow HELP1 = *ON;
034300170628          ExFmt HELPPNL;
034400170628        if  CLSHLP1 = *On;
034500170628        HELP1 = *off;
034600170628        endif;
034700170628        enddo;
034800170628
034900170515
035000170515        readc SFL1;
035100170515        if not %eof();
035200170515
035300170516        BACK = *Off;
035400170515
035500180301        chain (OESSID) webtranl25;
035600170515        wsssid = oessid;
035700170628
035800180301        chain (oetrst:oesub#:oeacct) ACCMST;
035900170628          chain (A_AACODE) AACODE ;
036000170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
036100170517
036200170517            wstsa = %editc(OETRST: 'X') + '-' +
036300170517                    %editc(OESUB#: 'X') + '-' +
036400170517                    %editc(OEACCT: 'X') ;
036500170517
036600170515               d_CCYYMMDD = %date(OEADDD:*ISO);
036700170515               d_MMDDCCYY = d_CCYYMMDD;
036800170829               OEADDD = %dec(d_MMDDCCYY:*USA);
036900170829
037000170829               d_CCYYMMDD = %date(OERETD:*ISO);
037100170829               d_MMDDCCYY = d_CCYYMMDD;
037200170829               OERETD = %dec(d_MMDDCCYY:*USA);
037300170515
037400170829          chain oeretf SLCMRDLF;
037500170515
037600170515        DoW BACK = *Off;
037700170515
037800170515          // Clear the subfile.
037900170515          SFLCLR2 = *On;
038000170515          Write SFLCTL2;
038100170515          SFLCLR2 = *Off;
038200170515          RRN2 = 0;
038300170515
038400170515          // Load the subfile.
038500180301          SetLL (oessid) WEBTRANL25;
038600180309          Reade    (oessid) WEBTRANL25;
038700180301          DoW Not %EOF(WEBTRANL25);
038800170822
038900170822          chain oeretf SLCMRDLF;
039000170822          if %found(SLCMRDLF);
039100170515
039200170515          wsafter  = %trim(OEAFTER) ;
039300170515          if %trim(wsafter) = '00000000';
039400170515          eval wsafter = *blanks ;
039500170515          endif;
039600170518
039700170518          if %trim(OEFLDV) = 'TERM_REASON' ;
039800170518          PCGRPR = 'TE_REASON' ;
039900170518          PCCODE = %trim(OEAFTER) ;
040000170518          Chain (OETRST:OESUB#:OEACCT:PCGRPR:PCCODE) WEBPAYCHP ;
040100170518          if %found(WEBPAYCHP) ;
040200170518          wsafter  = %trim(PCDESC) ;
040300170518          else;
040400170518          Chain (000:000:0000:PCGRPR:PCCODE) WEBPAYCHP ;
040500170518          if %found(WEBPAYCHP) ;
040600170518          wsafter  = %trim(PCDESC) ;
040700170518          endif;
040800170518          endif;
040900170518          endif;
041000170518
041100170620          pos = %scan('Date':OEFLDV) ;
041200170518          if pos > 0 ;
041300170518          exsr edtdat ;
041400170518          endif ;
041500170829
041600170829          pos = %scan('ADD_COVG_COV':OEFLDV) ;
041700170829          if pos > 0 ;
041800170829          OEFLDV = '**PROGRAMMER ONLY**' ;
041900170829          endif ;
042000190226
042100190226            if OERETD > 0;
042200190226               d_CCYYMMDD = %date(OERETD:*ISO);
042300190226               d_MMDDCCYY = d_CCYYMMDD;
042400190226               OERETD = %dec(d_MMDDCCYY:*USA);
042500190226            endif;
042600170517
042700170620          If  %trim(OEFLDV) <> '**PROGRAMMER ONLY**' ;
042800170515
042900170517            RRN2 += 1;
043000170626            Slc += 1;
043100170515            Write SFL2;
043200170517
043300170822            endif ;
043400170515            endif ;
043500180309            Reade    (oessid) WEBTRANL25;
043600170515          EndDo;
043700170829
043800170829               d_CCYYMMDD = %date(OEADDD:*ISO);
043900170829               d_MMDDCCYY = d_CCYYMMDD;
044000170829               OEADDD = %dec(d_MMDDCCYY:*USA);
044100170515
044200170515          // Display the subfile.
044300170515          SFLDSP2 = *On;
044400170515          ExFmt SFLCTL2;
044500170515
044600170515        EndDo;
044700170515
044800170515        Endif;
044900170515
045000100520        EndDo;
045100100520
045200100520        *InLr = *On;
045300100520        Return;
045400180306
045500170620      /END-FREE
045600170621    ? *___________________________________________________________________
045700170621    ? * format Date edit
045800170621    ? *___________________________________________________________________
045900170621    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
046000170518     C                   movel     'YYYYMMDD'    Input_Format
046100170518     C                   movel     'MM/DD/YYYY'  Output_Format
046200170518     C                   movel     OEAFTER       Input_Date
046300170518     C                   Call      'FMTDATE'
046400170518     C                   Parm                    Input_Date       32
046500170518     C                   Parm                    Input_Format     32
046600170518     C                   Parm                    Output_Format    32
046700170518     C                   Parm                    Output_Date      32
046800170518     C                   Parm                    Output_Error     10
046900170518     C                   movel     Output_Date   WSAFTER
047000170518    ?C                   Endsr                                                  END DLT RQST
047100170621    ? *___________________________________________________________________
047200170808    ? * key list
047300170621    ? *___________________________________________________________________
047400170808    ?C     KEYLIST       Begsr                                                  EDIT DELETE RQS
047500170621     C     oekey         klist
047600170713     C                   kfld                    SAVTRS
047700170713     C                   kfld                    SAVSUB
047800170713     C                   kfld                    SAVACT
047900170621     C                   kfld                    OETRN#
048000170621     C                   kfld                    OEGRPV
048100170621     C                   kfld                    OEFLDV
048200170621    ?C                   Endsr                                                  END DLT RQST
048300180307       // ----------------------------------------------------------------
048400180307       Begsr Prev;
048500180307
048600180307          cnt = 0;
048700180307
048800180307          //?Read the previous 10 records to set the pointer
048900180307          //?to the right spot.
049000180308          Dou %Eof(WEBTRANLF);
049100180309          Readpe (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
049200180308             if %eof(WEBTRANLF);
049300180307                leave;
049400180307             endif;
049500180307
049600180307
049700180307          chain oeretf SLCMRDLF;
049800180307          if %found(SLCMRDLF);
049900180307                Cnt = Cnt + 1;
050000180308            SAVTRS  = OETRST;
050100180308            SAVSUB  = OESUB#;
050200180308            SAVACT  = OEACCT;
050300180309            LSTSSN = OESSNO;
050400180309            LSTSEQ = OEDSEQ;
050500180309            LSTTRN = OETRN#;
050600180307             endif;
050700180307
050800180309             if Cnt = 10;
050900180307                leave;
051000180307             endif;
051100180307          enddo;
051200180307
051300180307          cnt = 0;
051400180309          //SetLL (SAVTRS:SAVSUB:SAVACT:*LoVal) WEBTRANLF;
051500180309          SetLL (SAVTRS:SAVSUB:SAVACT:LSTSSN:LSTSEQ:LSTTRN) WEBTRANLF;
051600180307
051700180307       Endsr;
051800170808      // ----------------------------------------------------------------
051900170810       Begsr chkSecurity;
052000170808
052100170808         //?Check Program Authority
052200170810         ChkWebAuth(@pgmq : psuserid : oContinue);
052300170808         if oContinue = 'N';
052400170808            *inlr = *on;
052500170808            Return;
052600170808         endif;
052700170808
052800170808       Endsr;
