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
014700181109
014800181109          if oeretd <> 0;
014900170822
015000170822          chain oeretf SLCMRDLF;
015100170822          if %found(SLCMRDLF);
015200181109
015300181109       // force - usually the HEADER records
015400181109          if oeretf = 'N';
015500181109          eval sldesc = 'OLE SUBMIT';
015600181109          endif;
015700180301
015800180301          chain (OETRST:OESUB#:OEACCT) accmst ;
015900170620
016000170628          chain (A_AACODE) AACODE ;
016100170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
016200170622
016300170622          chain oessno member ;
016400170622          wsname = %trim(mfname) + ' ' + %trim(MMI) + ' ' + %trim(MLNAME) ;
016500170517
016600170517               d_CCYYMMDD = %date(OEADDD:*ISO);
016700170517               d_MMDDCCYY = d_CCYYMMDD;
016800170517               OEADDD = %dec(d_MMDDCCYY:*USA);
016900170829
017000180807            if OERETD > 0;
017100170829               d_CCYYMMDD = %date(OERETD:*ISO);
017200170829               d_MMDDCCYY = d_CCYYMMDD;
017300170829               OERETD = %dec(d_MMDDCCYY:*USA);
017400180807            Endif;
017500170517
017600170627            RRN += 1;
017700170627            CNT += 1;
017800170628            Write SFL1;
017900170822
018000170822          Endif;
018100170620
018200181109          Endif;
018300180301            Reade (SRSSN) WEBTRANL39;
018400170517          EndDo;
018500170517
018600170517          // Search on SSID
018700170622          when  GOSSID = *ON and SRSSID <> *blanks ;
018800170622          SRSSN = *zeros ;
018900180308          SRTRS  = *blanks ;
019000180308          SRSUB  = *blanks ;
019100180308          SRACT  = *blanks ;
019200170517
019300170517          // Load the subfile.
019400180301          SetLL (SRSSID:*LOVAL) WEBTRANL25;
019500180309          Reade    (SRSSID) WEBTRANL25;
019600180301          DoW Not %EOF(WEBTRANL25);
019700181109
019800181109          if oeretd <> 0;
019900170822
020000170822          chain oeretf SLCMRDLF;
020100170822          if %found(SLCMRDLF);
020200181109
020300181109       // force - usually the HEADER records
020400181109          if oeretf = 'N';
020500181109          eval sldesc = 'OLE SUBMIT';
020600181109          endif;
020700180301
020800180301          chain (OETRST:OESUB#:OEACCT) accmst ;
020900170622
021000170628          chain (A_AACODE) AACODE ;
021100170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
021200170622
021300170622          chain oessno member ;
021400170622          wsname = %trim(mfname) + ' ' + %trim(MMI) + ' ' + %trim(MLNAME) ;
021500170517
021600170517               d_CCYYMMDD = %date(OEADDD:*ISO);
021700170517               d_MMDDCCYY = d_CCYYMMDD;
021800170517               OEADDD = %dec(d_MMDDCCYY:*USA);
021900170829
022000180807            if OERETD > 0;
022100170829               d_CCYYMMDD = %date(OERETD:*ISO);
022200170829               d_MMDDCCYY = d_CCYYMMDD;
022300170829               OERETD = %dec(d_MMDDCCYY:*USA);
022400180807            Endif;
022500170517
022600170627            RRN += 1;
022700170627            CNT += 1;
022800170517            Write SFL1;
022900170822
023000170822          Endif;
023100170620
023200181109          Endif;
023300180309            Reade    (SRSSID) WEBTRANL25;
023400170517          EndDo;
023500170517
023600180308          // Other ;
023700180308          when  GOTSA = *ON and SRTRS <> ' ' and
023800180309                SRSUB <> ' ' and SRACT <> ' ' or
023900180309                PageDown = *ON and SRTRS <> ' ' and
024000180309                SRSUB <> ' ' and SRACT <> ' ' or
024100180309                PageUp   = *ON and SRTRS <> ' ' and
024200180309                SRSUB <> ' ' and SRACT <> ' ' ;
024300180309
024400180308          SRSSID = *blanks ;
024500180308          SRSSN  = *zeros  ;
024600180308
024700180308          SAVTRS = %dec(SRTRS:3:0);
024800180308          SAVSUB = %dec(SRSUB:3:0);
024900180308          SAVACT = %dec(SRACT:4:0);
025000170517
025100170621            CNT = 0;
025200100520          // Load the subfile.
025300180307
025400180307          select;
025500180307          when PageDown = *on;
025600180309          SetLL (SAVTRS:SAVSUB:SAVACT:LSTSSN:LSTSEQ:LSTTRN) WEBTRANLF;
025700180309          Reade    (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
025800180307
025900180307          when PageUp = *on;
026000180309          SetLL (SAVTRS:SAVSUB:SAVACT:LSTSSN:LSTSEQ:LSTTRN) WEBTRANLF;
026100180307          exsr Prev;
026200180309          Reade    (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
026300180307
026400180307          Other;
026500180308          SetLL (SAVTRS:SAVSUB:SAVACT:*LoVal) WEBTRANLF;
026600180309          Reade    (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
026700180307          Endsl;
026800180307
026900180308          DoW Not %EOF(WEBTRANLF);
027000181109
027100181109          if oeretd <> 0;
027200170822
027300170822          chain oeretf SLCMRDLF;
027400170822          if %found(SLCMRDLF);
027500181109
027600181109       // force - usually the HEADER records
027700181109          if oeretf = 'N';
027800181109          eval sldesc = 'OLE SUBMIT';
027900181109          endif;
028000180305
028100180309          LSTSSN = OESSNO;
028200180309          LSTSEQ = OEDSEQ;
028300180309          LSTTRN = OETRN#;
028400180309
028500180807            if OERETD > 0;
028600180305          isotoday = %date(OERETD : *iso);
028700180305          curYear  = %subdt(ISOtoday: *Y);
028800180305          curMon   = %subdt(ISOtoday: *M);
028900180807            endif;
029000180307       // if curYear = myYear and curMon = myMon;
029100180301
029200180301          chain (OETRST:OESUB#:OEACCT) accmst ;
029300170621
029400170628          chain (A_AACODE) AACODE ;
029500170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
029600170621
029700170621          chain oessno member ;
029800170621          wsname = %trim(mfname) + ' ' + %trim(MMI) + ' ' + %trim(MLNAME) ;
029900170621
030000170517               d_CCYYMMDD = %date(OEADDD:*ISO);
030100170517               d_MMDDCCYY = d_CCYYMMDD;
030200170517               OEADDD = %dec(d_MMDDCCYY:*USA);
030300170829
030400180807            if OERETD > 0;
030500170829               d_CCYYMMDD = %date(OERETD:*ISO);
030600170829               d_MMDDCCYY = d_CCYYMMDD;
030700170829               OERETD = %dec(d_MMDDCCYY:*USA);
030800180807            endif;
030900170623
031000180308            SAVTRS  = OETRST;
031100180308            SAVSUB  = OESUB#;
031200180308            SAVACT  = OEACCT;
031300170627            CNT += 1;
031400170627            RRN += 1;
031500100520            Write SFL1;
031600170822
031700180307       // endif;
031800170822          endif;
031900180301
032000180307          if cnt = 10;
032100180307          CNT = 0;
032200180307          leave;
032300180301          endif;
032400170626
032500181109          endif;
032600181109
032700180307          select;
032800180307          when PageDown = *on;
032900180308            Read WEBTRANLF;
033000180307          when PageUp = *on;
033100180308            Read WEBTRANLF;
033200180307          Other;
033300180308            Read WEBTRANLF;
033400180307          Endsl;
033500170620
033600100520          EndDo;
033700170517
033800170517          Endsl;
033900170517
034000180307            PageDown = *off;
034100180307            PageUp = *off;
034200180307
034300180307          //?Setup Directional Links.
034400180307          //?Page Down
034500180307          EnableDown = *On;
034600180307
034700180307        //Setgt (SAVTRN#) WEBTRAN;
034800180307        //read  WEBTRAN;
034900180307        //if %eof(WEBTRAN);
035000180307        //   EnableDown = *Off;
035100180307        //endif;
035200180307
035300180307          //?Page Up
035400180307          EnableUp = *On;
035500180307
035600180307        //Setll (SAVTRN#) WEBTRAN;
035700180307        //readp WEBTRAN;
035800180307        //if %eof(WEBTRAN);
035900180307        //   EnableUp = *Off;
036000180307        //endif;
036100180307
036200170517
036300100520          // Display the subfile.
036400100520          SFLDSP = *On;
036500100520          ExFmt SFLCTL1;
036600170628
036700170628        dow HELP1 = *ON;
036800170628          ExFmt HELPPNL;
036900170628        if  CLSHLP1 = *On;
037000170628        HELP1 = *off;
037100170628        endif;
037200170628        enddo;
037300170628
037400170515
037500170515        readc SFL1;
037600170515        if not %eof();
037700170515
037800170516        BACK = *Off;
037900170515
038000180301        chain (OESSID) webtranl25;
038100170515        wsssid = oessid;
038200170628
038300180301        chain (oetrst:oesub#:oeacct) ACCMST;
038400170628          chain (A_AACODE) AACODE ;
038500170628          wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
038600170517
038700170517            wstsa = %editc(OETRST: 'X') + '-' +
038800170517                    %editc(OESUB#: 'X') + '-' +
038900170517                    %editc(OEACCT: 'X') ;
039000170517
039100170515               d_CCYYMMDD = %date(OEADDD:*ISO);
039200170515               d_MMDDCCYY = d_CCYYMMDD;
039300170829               OEADDD = %dec(d_MMDDCCYY:*USA);
039400170829
039500180807            if OERETD > 0;
039600170829               d_CCYYMMDD = %date(OERETD:*ISO);
039700170829               d_MMDDCCYY = d_CCYYMMDD;
039800170829               OERETD = %dec(d_MMDDCCYY:*USA);
039900180807            endif;
040000170515
040100170829          chain oeretf SLCMRDLF;
040200181109
040300181109       // force - usually the HEADER records
040400181109          if oeretf = 'N';
040500181109          eval sldesc = 'OLE SUBMIT';
040600181109          endif;
040700170515
040800170515        DoW BACK = *Off;
040900170515
041000170515          // Clear the subfile.
041100170515          SFLCLR2 = *On;
041200170515          Write SFLCTL2;
041300170515          SFLCLR2 = *Off;
041400170515          RRN2 = 0;
041500170515
041600170515          // Load the subfile.
041700180301          SetLL (oessid) WEBTRANL25;
041800180309          Reade    (oessid) WEBTRANL25;
041900180301          DoW Not %EOF(WEBTRANL25);
042000181109
042100181109          if oeretd <> 0;
042200170822
042300170822          chain oeretf SLCMRDLF;
042400170822          if %found(SLCMRDLF);
042500181109
042600181109       // force - usually the HEADER records
042700181109          if oeretf = 'N';
042800181109          eval sldesc = 'OLE SUBMIT';
042900181109          endif;
043000170515
043100170515          wsafter  = %trim(OEAFTER) ;
043200170515          if %trim(wsafter) = '00000000';
043300170515          eval wsafter = *blanks ;
043400170515          endif;
043500170518
043600170518          if %trim(OEFLDV) = 'TERM_REASON' ;
043700170518          PCGRPR = 'TE_REASON' ;
043800170518          PCCODE = %trim(OEAFTER) ;
043900170518          Chain (OETRST:OESUB#:OEACCT:PCGRPR:PCCODE) WEBPAYCHP ;
044000170518          if %found(WEBPAYCHP) ;
044100170518          wsafter  = %trim(PCDESC) ;
044200170518          else;
044300170518          Chain (000:000:0000:PCGRPR:PCCODE) WEBPAYCHP ;
044400170518          if %found(WEBPAYCHP) ;
044500170518          wsafter  = %trim(PCDESC) ;
044600170518          endif;
044700170518          endif;
044800170518          endif;
044900170518
045000170620          pos = %scan('Date':OEFLDV) ;
045100170518          if pos > 0 ;
045200170518          exsr edtdat ;
045300170518          endif ;
045400170829
045500170829          pos = %scan('ADD_COVG_COV':OEFLDV) ;
045600170829          if pos > 0 ;
045700170829          OEFLDV = '**PROGRAMMER ONLY**' ;
045800170829          endif ;
045900190225
046000190225            if OERETD > 0;
046100190225               d_CCYYMMDD = %date(OERETD:*ISO);
046200190225               d_MMDDCCYY = d_CCYYMMDD;
046300190225               OERETD = %dec(d_MMDDCCYY:*USA);
046400190225            endif;
046500170517
046600170620          If  %trim(OEFLDV) <> '**PROGRAMMER ONLY**' ;
046700170515
046800170517            RRN2 += 1;
046900170626            Slc += 1;
047000170515            Write SFL2;
047100170517
047200170822            endif ;
047300181109            endif ;
047400170515            endif ;
047500180309            Reade    (oessid) WEBTRANL25;
047600170515          EndDo;
047700170829
047800170829               d_CCYYMMDD = %date(OEADDD:*ISO);
047900170829               d_MMDDCCYY = d_CCYYMMDD;
048000170829               OEADDD = %dec(d_MMDDCCYY:*USA);
048100170515
048200170515          // Display the subfile.
048300170515          SFLDSP2 = *On;
048400170515          ExFmt SFLCTL2;
048500170515
048600170515        EndDo;
048700170515
048800170515        Endif;
048900170515
049000100520        EndDo;
049100100520
049200100520        *InLr = *On;
049300100520        Return;
049400180306
049500170620      /END-FREE
049600170621    ? *___________________________________________________________________
049700170621    ? * format Date edit
049800170621    ? *___________________________________________________________________
049900170621    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
050000170518     C                   movel     'YYYYMMDD'    Input_Format
050100170518     C                   movel     'MM/DD/YYYY'  Output_Format
050200170518     C                   movel     OEAFTER       Input_Date
050300170518     C                   Call      'FMTDATE'
050400170518     C                   Parm                    Input_Date       32
050500170518     C                   Parm                    Input_Format     32
050600170518     C                   Parm                    Output_Format    32
050700170518     C                   Parm                    Output_Date      32
050800170518     C                   Parm                    Output_Error     10
050900170518     C                   movel     Output_Date   WSAFTER
051000170518    ?C                   Endsr                                                  END DLT RQST
051100170621    ? *___________________________________________________________________
051200170808    ? * key list
051300170621    ? *___________________________________________________________________
051400170808    ?C     KEYLIST       Begsr                                                  EDIT DELETE RQS
051500170621     C     oekey         klist
051600170713     C                   kfld                    SAVTRS
051700170713     C                   kfld                    SAVSUB
051800170713     C                   kfld                    SAVACT
051900170621     C                   kfld                    OETRN#
052000170621     C                   kfld                    OEGRPV
052100170621     C                   kfld                    OEFLDV
052200170621    ?C                   Endsr                                                  END DLT RQST
052300180307       // ----------------------------------------------------------------
052400180307       Begsr Prev;
052500180307
052600180307          cnt = 0;
052700180307
052800180307          //?Read the previous 10 records to set the pointer
052900180307          //?to the right spot.
053000180308          Dou %Eof(WEBTRANLF);
053100180309          Readpe (SAVTRS:SAVSUB:SAVACT) WEBTRANLF;
053200180308             if %eof(WEBTRANLF);
053300180307                leave;
053400180307             endif;
053500180307
053600180307
053700180307          chain oeretf SLCMRDLF;
053800180307          if %found(SLCMRDLF);
053900181109
054000181109       // force - usually the HEADER records
054100181109          if oeretf = 'N';
054200181109          eval sldesc = 'OLE SUBMIT';
054300181109          endif;
054400181109
054500180307                Cnt = Cnt + 1;
054600180308            SAVTRS  = OETRST;
054700180308            SAVSUB  = OESUB#;
054800180308            SAVACT  = OEACCT;
054900180309            LSTSSN = OESSNO;
055000180309            LSTSEQ = OEDSEQ;
055100180309            LSTTRN = OETRN#;
055200180307             endif;
055300180307
055400180309             if Cnt = 10;
055500180307                leave;
055600180307             endif;
055700180307          enddo;
055800180307
055900180307          cnt = 0;
056000180309          //SetLL (SAVTRS:SAVSUB:SAVACT:*LoVal) WEBTRANLF;
056100180309          SetLL (SAVTRS:SAVSUB:SAVACT:LSTSSN:LSTSEQ:LSTTRN) WEBTRANLF;
056200180307
056300180307       Endsr;
056400170808      // ----------------------------------------------------------------
056500170810       Begsr chkSecurity;
056600170808
056700170808         //?Check Program Authority
056800170810         ChkWebAuth(@pgmq : psuserid : oContinue);
056900170808         if oContinue = 'N';
057000170808            *inlr = *on;
057100170808            Return;
057200170808         endif;
057300170808
057400170808       Endsr;
