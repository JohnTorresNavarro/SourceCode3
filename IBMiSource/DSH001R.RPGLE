000100170714      *_________________________________________________________________________
000200170714      *
000300170714      *  Description:  Manual Retirement
000400170714      *
000500170714      *  (c)Copyright 2017 by GBS, Inc.
000600170714      *
000700170714      *    Created by:  JALLEN - July 14, 2017
000800170714      *
000900170714      *  Modifications:
001000180327      *    Added Array to speed up Grid Load
001100200803      *
001200200803      *  mod2  08.03.2020  J.Allen - skip retiring spousal life/Ad&d plans
001300200803      *                              when the plan is flagged as spouse age.
001400200803      *
001500210730      *  mod3  07.30.2021  J.Allen - problem loading SFL1
001600210730      *
001700170714      *_________________________________________________________________________
001800000000
001900170626
002000170626     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
002100170626     H option(*SRCSTMT: *NODEBUGIO)
002200100520
002300170620     FDSH001D   CF   E             WorkStn Handler('PROFOUNDUI(HANDLER)')
002400170515     F                                     SFile(SFL1 : RRN)
002500170515     F                                     SFile(SFL2 : RRN2)
002600100520
002700170620     FWEBTRANL36IF   E           K Disk
002800170621     FWEBTRANl37UF   E           K Disk    rename(webtranr:webl37)
002900170621     FWEBTRANL38UF   E           K Disk    rename(webtranr:webl38)
003000170628     FACCMST    IF   E           K DISK    extfile('F.ACCMST') prefix(A_)
003100170628     FAACODE    IF   E           K DISK
003200170621     FMEMBER    IF   E           K DISK    extfile('F.MEMBER')
003300170518     FWEBPAYCHP IF   E           K DISK
003400170713     FPLSESSIDP IF   E           K DISK
003500100520
003600170626      * Prototypes
003700200803      /COPY *LIBL/QMODSRC,#chkdectpr
003800200803mod2  /COPY *LIBL/QMODSRC,#getspspr
003900200803mod2  /COPY *LIBL/QMODSRC,#skpretpr
004000170626
004100170620     D RRN             S              5I 0
004200170620     D SETRRN          S              5I 0
004300170620     D PRODRRN         S              5I 0
004400170620     D i               S              5I 0
004500170621     D wwretf          S              1a
004600170518     D wsssid          S             16a
004700180327     D pos             S              5s 0
004800170623     D cnt             S              9s 0
004900170626     D slc             S              3s 0
005000170626     D x               S              3s 0
005100170713     D curtime         s               z
005200170810     D oContinue       S              1a
005300200803mod2 D rtvpsp          S              9s 0
005400200803mod2 D rtvpsa          S              9s 0
005500200803mod2 D rtvpspD         S              9s 0
005600200803mod2 D rtvpsaD         S              9s 0
005700200803mod2 D spsseq          S              2s 0
005800200804     D skip            S              1a
005900170620
006000170713     D savtrs          S              3s 0
006100170713     D savsub          S              3s 0
006200170713     D savact          S              4s 0
006300170713
006400170620     D SFLPAG          C                   Const(13)
006500170621
006600170621     D DSH002R         PR                  ExtPgm('DSH002R')
006700170621     D  retflg                             Like(OERETF)
006800170810
006900170810     D CHKWEBAUTH      PR                  ExtPgm('CHKWEBAUTH')
007000170810     D  pgm                                Like(WQPGMN)
007100170810     D  usr                                Like(WQUSRN)
007200170810     D  flg                                Like(OERETF)
007300100520
007400170515     d d_CCYYMMDD...
007500170515     d                 S               D   datfmt(*ISO)
007600170515     d d_MMDDCCYY...
007700170515     d                 S               D   datfmt(*USA)
007800170515
007900170621    ? * Program status data structure
008000170621    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
008100170808     D  @pgmq            *proc
008200180327      *--------------------------------------------------------------
008300180327
008400170713     c     *entry        Plist
008500170713     C                   parm                    inGeni           25
008600170515
008700170713     C     inGeni        Chain     PLSESSIDP
008800170713     C                   if        %found(PLSESSIDP)
008900170713     C                   eval      curtime = %timestamp
009000170713     C                   if        curtime > PSEXPTM
009100170713     C                   eval      *InLr = *On
009200170713     C                   Return
009300170713     C                   else
009400170810     C                   exsr      chkSecurity
009500170713     C                   eval      savtrs = PSTRST
009600170713     C                   eval      savsub = PSSUB#
009700170713     C                   eval      savact = PSACCT
009800170713     C                   end
009900170713     C                   else
010000170713     C                   eval      *InLr = *On
010100170713     C                   Return
010200170713     C                   end
010300170713
010400170713      /FREE
010500100520
010600180326       // Initialize "named indicators.
010700180326       VIEW = *Off;
010800180326       EXIT = *Off;
010900180326       HELP1 = *Off;
011000180326       HELP2 = *Off;
011100180326       SFLDSP = *Off;
011200180326       SFLCLR = *Off;
011300180326       GOSSN  = *Off;
011400180326       GOSSID = *Off;
011500180326       Slc = 0;
011600100520
011700180326       DoW EXIT = *Off;
011800100520
011900180326          // Clear the subfile.
012000180326          SFLCLR = *On;
012100180326          Write SFLCTL1;
012200180326          SFLCLR = *Off;
012300180326          CNT = 0;
012400180326          RRN = 0;
012500170713
012600100520
012700180326          select ;
012800180326          // Search on SSN
012900180326          when  GOSSN = *ON and SRSSN <> 0 ;
013000180326             SRSSID = *blanks ;
013100170517
013200180326             // Load the subfile.
013300180326             SetLL (SRSSN) WEBTRANL36;
013400180326             Reade (SRSSN) WEBTRANL36;
013500180326             DoW Not %EOF(WEBTRANL36);
013600170620
013700180326                chain (OETRST:OESUB#:OEACCT) accmst ;
013800180326                chain (A_AACODE) AACODE ;
013900180326                wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
014000170622
014100180326                chain oessno member ;
014200180327                wsname = %trim(mfname) + ' ' + %trim(MMI) +
014300180327                          ' ' + %trim(MLNAME) ;
014400170517
014500180327                d_CCYYMMDD = %date(OEADDD:*ISO);
014600180326                d_MMDDCCYY = d_CCYYMMDD;
014700180326                OEADDD = %dec(d_MMDDCCYY:*USA);
014800170517
014900180327
015000180518                select;
015100181107                when  %trim(PSUSERID) = 'JALLEN' or
015200220822                    %trim(PSUSERID) = 'CFALLIN'  or
015300220822                    %trim(PSUSERID) = 'cfallin'  or
015400220818                    %trim(PSUSERID) = 'CANDACEF'  or
015500181113                    %trim(PSUSERID) = 'SHELLY';
015600180518                   RRN += 1;
015700180518                   CNT += 1;
015800180518                   Write SFL1;
015900180518                other;
016000180327    *           if #chkdect(oetrn#) <> 'Y';
016100180326                   RRN += 1;
016200180326                   CNT += 1;
016300180326                   Write SFL1;
016400180518                Endif;
016500180518                Endsl;
016600170620
016700180326                Reade (SRSSN) WEBTRANL36;
016800180326             EndDo;
016900170517
017000180326          // Search on SSID
017100180326          when  GOSSID = *ON and SRSSID <> *blanks ;
017200180326             SRSSN = *zeros ;
017300170517
017400180326             // Load the subfile.
017500180326             SetLL (SRSSID) WEBTRANL38;
017600180326             Reade(n) (SRSSID) WEBTRANL38;
017700180326             DoW Not %EOF(WEBTRANL38);
017800170622
017900180326                chain (OETRST:OESUB#:OEACCT) accmst ;
018000180326                chain (A_AACODE) AACODE ;
018100180326                wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
018200170622
018300180326                chain oessno member ;
018400180327                wsname = %trim(mfname) + ' ' + %trim(MMI) +
018500180327                              ' ' + %trim(MLNAME) ;
018600170517
018700180326                d_CCYYMMDD = %date(OEADDD:*ISO);
018800180326                d_MMDDCCYY = d_CCYYMMDD;
018900180326                OEADDD = %dec(d_MMDDCCYY:*USA);
019000170517
019100180327
019200180518                select;
019300181107                when  %trim(PSUSERID) = 'JALLEN' or
019400220822                    %trim(PSUSERID) = 'CFALLIN'  or
019500220822                    %trim(PSUSERID) = 'cfallin'  or
019600220818                    %trim(PSUSERID) = 'CANDACEF'  or
019700181113                    %trim(PSUSERID) = 'SHELLY';
019800180518                   RRN += 1;
019900180518                   CNT += 1;
020000180518                   Write SFL1;
020100180518                other;
020200180518    *           if #chkdect(oetrn#) <> 'Y';
020300180518                   RRN += 1;
020400180518                   CNT += 1;
020500180518                   Write SFL1;
020600180518                Endif;
020700180518                Endsl;
020800170620
020900180326                Reade(n) (SRSSID) WEBTRANL38;
021000180326             EndDo;
021100170517
021200180326          Other ;
021300170517
021400180326             CNT = 0;
021500180326             // Load the subfile.
021600180326             SetLL (*LoVal) WEBTRANL37;
021700180326             Read(n) WEBTRANL37;
021800180326             DoW Not %EOF(WEBTRANL37);
021900170621
022000180326                chain (OETRST:OESUB#:OEACCT) accmst ;
022100180326                chain (A_AACODE) AACODE ;
022200180326                wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
022300170621
022400180326                chain oessno member ;
022500180327                wsname = %trim(mfname) + ' ' + %trim(MMI) + ' '
022600180327                       + %trim(MLNAME) ;
022700170621
022800180326                d_CCYYMMDD = %date(OEADDD:*ISO);
022900180326                d_MMDDCCYY = d_CCYYMMDD;
023000180326                OEADDD = %dec(d_MMDDCCYY:*USA);
023100170623
023200180327
023300180518
023400180518    *           if #chkdect(oetrn#) <> 'Y';
023500180518                   RRN += 1;
023600180518                   CNT += 1;
023700180518                   Write SFL1;
023800180518                Endif;
023900210730
024000210730          // mod3
024100210730                if cnt >= 10;
024200210730                leave ;
024300210730                Endif;
024400210730
024500170626
024600180326                Read(n) WEBTRANL37;
024700170620
024800180326             EndDo;
024900170620
025000180326             If %EOF(WEBTRANL37) ;
025100180326             Else;
025200180326             EndIf;
025300170620
025400180326             If PRODRRN <= SFLPAG;
025500180326             Else;
025600180326             EndIf;
025700100520
025800170517
025900180326          Endsl;
026000170517
026100170517
026200180326          // Display the subfile.
026300180326          SFLDSP = *On;
026400180326          ExFmt SFLCTL1;
026500170628
026600180326          dow HELP1 = *ON;
026700180326             ExFmt HELPPNL;
026800180326             if  CLSHLP1 = *On;
026900180326                HELP1 = *off;
027000180326             endif;
027100180326          enddo;
027200170628
027300170515
027400180326          readc SFL1;
027500180326          if not %eof();
027600170515
027700180326             BACK = *Off;
027800170515
027900180326             chain (OESSID) webtranl38;
028000180326             wsssid = oessid;
028100170628
028200180326             chain (oetrst:oesub#:oeacct) ACCMST;
028300180326             chain (A_AACODE) AACODE ;
028400180326             wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
028500170517
028600180326             wstsa = %editc(OETRST: 'X') + '-' +
028700180326                %editc(OESUB#: 'X') + '-' +
028800180326                %editc(OEACCT: 'X') ;
028900170517
029000180326             d_CCYYMMDD = %date(OEADDD:*ISO);
029100180326             d_MMDDCCYY = d_CCYYMMDD;
029200180326             WSADDD = %dec(d_MMDDCCYY:*USA);
029300170515
029400170515
029500180326             DoW BACK = *Off;
029600170515
029700180326                // Clear the subfile.
029800180326                SFLCLR2 = *On;
029900180326                Write SFLCTL2;
030000180326                SFLCLR2 = *Off;
030100180326                RRN2 = 0;
030200170515
030300180326                // Load the subfile.
030400180326                SetLL (oessid) WEBTRANL38;
030500180326                Reade(n) (oessid) WEBTRANL38;
030600180326                DoW Not %EOF(WEBTRANL38);
030700170518
030800180326                   wsbefore = %trim(OEBEFORE) ;
030900180326                   if %trim(wsbefore) = '00000000';
031000180326                      eval wsbefore = *blanks ;
031100180326                   endif;
031200180326                   if %trim(wsbefore) = '000';
031300180326                      eval wsbefore = *blanks ;
031400180326                   endif;
031500180326                   if %trim(wsbefore) = '0000000';
031600180326                      eval wsbefore = *blanks ;
031700180326                   endif;
031800180326                   if %trim(wsbefore) = '000000000';
031900180326                      eval wsbefore = *blanks ;
032000180326                   endif;
032100170515
032200180326                   wsafter  = %trim(OEAFTER) ;
032300180326                   if %trim(wsafter) = '00000000';
032400180326                      eval wsafter = *blanks ;
032500180326                   endif;
032600170518
032700180326                   if %trim(OEFLDV) = 'TERM_REASON' ;
032800180326                      PCGRPR = 'TE_REASON' ;
032900180326                      PCCODE = %trim(OEAFTER) ;
033000180326                      Chain (OETRST:OESUB#:OEACCT:PCGRPR:PCCODE) WEBPAYCHP ;
033100180326                      if %found(WEBPAYCHP) ;
033200180326                         wsafter  = %trim(PCDESC) ;
033300180326                      else;
033400180326                         Chain (000:000:0000:PCGRPR:PCCODE) WEBPAYCHP ;
033500180326                         if %found(WEBPAYCHP) ;
033600180326                            wsafter  = %trim(PCDESC) ;
033700180326                         endif;
033800180326                      endif;
033900180326                   endif;
034000170518
034100180326                   pos = %scan('Date':OEFLDV) ;
034200180326                   if pos > 0 ;
034300180326                      exsr edtdat ;
034400180326                   endif ;
034500170517
034600180326                   If  %trim(OEFLDV) <> '**PROGRAMMER ONLY**' ;
034700180518                      if oeretd = 0;
034800180326
034900180326                         RRN2 += 1;
035000180326                         Slc += 1;
035100180326                         Write SFL2;
035200180326
035300180326                      endif ;
035400180326                   endif ;
035500180326                   Reade(n) (oessid) WEBTRANL38;
035600180326                EndDo;
035700170515
035800180326                // Display the subfile.
035900180326                SFLDSP2 = *On;
036000180326                ExFmt SFLCTL2;
036100170628
036200180326                dow HELP2 = *ON;
036300180326                   ExFmt HELPPNL2;
036400180326                   if  CLSHLP2 = *On;
036500180326                      HELP2 = *off;
036600180326                   endif;
036700180326                enddo;
036800170621
036900180326                // Process prompt, if required.
037000180326                If RETIRE_ALL = *On;
037100180326                   callp DSH002R(WWRETF) ;
037200180326                   exsr RETIRE_A;
037300200804                if skip = 'Y';
037400200804                      ExFmt SKIPPED;
037500200804                Endif;
037600180326                Endif;
037700180326                If RETIRE_SEL = *On;
037800180326                   readc sfl2;
037900180326                   if not %eof ;
038000180326                      callp DSH002R(WWRETF) ;
038100180326                      exsr RETIRE_S;
038200180326                   else ;
038300180326                      ExFmt WARNING;
038400180326                   Endif;
038500180326                Endif;
038600170515
038700180326             EndDo;
038800170515
038900180326          Endif;
039000170515
039100180326       EndDo;
039200100520
039300180326       *InLr = *On;
039400180326       Return;
039500170620
039600170620      /END-FREE
039700170518    ? *___________________________________________________________________
039800170621    ? * Retire All
039900170518    ? *___________________________________________________________________
040000170621    ?C     RETIRE_A      Begsr                                                  EDIT DELETE RQS
040100170622     C                   If        WWRETF = *blanks
040200170622     C                   LeaveSR
040300170622     C                   end
040400200803
040500200803mod2 C                   clear                   rtvpsp
040600200803mod2 C                   clear                   rtvpspD
040700200803mod2 C                   clear                   rtvpsa
040800200804mod2 C                   clear                   rtvpsaD
040900200804mod2 C                   clear                   skip
041000200803
041100200803mod2 C                   eval      rtvpsp = #skpret(oessid:'PSP':0)
041200200803mod2 C                   eval      rtvpsa = #skpret(oessid:'PSA':0)
041300200803mod2 C                   eval      spsseq = #getsps(oetrst:oesub#:oeacct:oessno)
041400200803mod2 C                   eval      rtvpspD = #skpret(oessid:'PSP':spsseq)
041500200803mod2 C                   eval      rtvpsaD = #skpret(oessid:'PSA':spsseq)
041600200803
041700170713     C     KEYSSI        klist
041800170713     C                   kfld                    OESSID
041900170713     C     KEYSSI        setll     WEBTRANL38
042000170713     C     KEYSSI        reade     WEBTRANL38
042100170621     C                   dow       not %eof(WEBTRANL38)
042200181106    *C                   if        #chkdect(oetrn#) <> 'Y' or
042300181107     C                             %trim(PSUSERID) = 'JALLEN' or
042400220818     C                             %trim(PSUSERID) = 'CANDACEF' or
042500220822     C                             %trim(PSUSERID) = 'CFALLIN'  or
042600220822     C                             %trim(PSUSERID) = 'cfallin'  or
042700181113     C                             %trim(PSUSERID) = 'SHELLY'
042800180518     C                   If        oeretd = 0
042900200803mod2 C                   select
043000200803 |   C                   when      oetrn# = rtvpsp
043100200804 |   C                   eval      skip = 'Y'
043200200803 |    * skip
043300200803 |   C                   when      oetrn# = rtvpspD
043400200804 |   C                   eval      skip = 'Y'
043500200803 |    * skip
043600200803 |   C                   when      oetrn# = rtvpsa
043700200804 |   C                   eval      skip = 'Y'
043800200803 |    * skip
043900200803 |   C                   when      oetrn# = rtvpsaD
044000200804 |   C                   eval      skip = 'Y'
044100200803 |    * skip
044200200803mod2 C                   other
044300170621     C                   eval      oeretf = WWRETF
044400170811     C                   eval      oeretu = %trim(PSUSERID)
044500170621     C                   eval      oeretd = %int(%char(%date : *iso0))
044600170621     C                   time                    oerett
044700170621     C                   update    webl38
044800200803mod2 C                   endsl
044900181106     C                   end
045000171213     C                   end
045100170713     C     KEYSSI        reade     WEBTRANL38
045200170621     C                   Enddo
045300170621     C                   Endsr
045400170621    ? *___________________________________________________________________
045500170621    ? * Retire Selected
045600170621    ? *___________________________________________________________________
045700170621    ?C     RETIRE_S      Begsr                                                  EDIT DELETE RQS
045800170622     C                   If        WWRETF = *blanks
045900170626     C                   eval      x = 0
046000170626     C                   dow       x <= slc
046100170626     C     x             chain     sfl2
046200170626     C                   eval      mybox  = ' '
046300170626     C                   update(e) sfl2
046400170626     C                   eval      x = x+1
046500170626     C                   enddo
046600170622     C                   LeaveSR
046700170622     C                   end
046800170626     C                   eval      x = 0
046900170626     C                   dow       x <= slc
047000170626     C     x             chain     sfl2
047100170621     C                   if        %trim(mybox) = 'Y'
047200170621     C     oekey         chain     WEBTRANL37
047300170621     C                   if        %found(WEBTRANL37)
047400181106    *C                   if        #chkdect(oetrn#) <> 'Y' or
047500181107     C                             %trim(PSUSERID) = 'JALLEN' or
047600220818     C                             %trim(PSUSERID) = 'CANDACEF' or
047700220822     C                             %trim(PSUSERID) = 'CFALLIN'  or
047800220822     C                             %trim(PSUSERID) = 'cfallin'  or
047900181113     C                             %trim(PSUSERID) = 'SHELLY'
048000170621     C                   eval      oeretf = WWRETF
048100170811     C                   eval      oeretu = %trim(PSUSERID)
048200170621     C                   eval      oeretd = %int(%char(%date : *iso0))
048300170621     C                   time                    oerett
048400170621     C                   update    webl37
048500170626     C                   end
048600181106     C                   end
048700170621     C                   end
048800170622     C                   eval      mybox = ' '
048900170626     C                   eval      x = x+1
049000170621     C                   enddo
049100170621     C                   Endsr
049200170626    ? *___________________________________________________________________
049300170626    ? * Retire Selected
049400170626    ? *___________________________________________________________________
049500170626    ?C     RETIRE_X      Begsr                                                  EDIT DELETE RQS
049600170626     C                   If        WWRETF = *blanks
049700170626     C                   LeaveSR
049800170626     C                   end
049900170626     C**                 read      sfl2
050000170626     C                   dow       not %eof
050100170626     C                   if        %trim(mybox) = 'Y'
050200170626     C     oekey         chain     WEBTRANL37
050300170626     C                   if        %found(WEBTRANL37)
050400181106    *C                   if        #chkdect(oetrn#) <> 'Y' or
050500181107     C                             %trim(PSUSERID) = 'JALLEN' or
050600220818     C                             %trim(PSUSERID) = 'CANDACEF' or
050700220822     C                             %trim(PSUSERID) = 'CFALLIN'  or
050800220822     C                             %trim(PSUSERID) = 'cfallin'  or
050900181113     C                             %trim(PSUSERID) = 'SHELLY'
051000170626     C                   eval      oeretf = WWRETF
051100170811     C                   eval      oeretu = %trim(PSUSERID)
051200170626     C                   eval      oeretd = %int(%char(%date : *iso0))
051300170626     C                   time                    oerett
051400170626     C                   update    webl37
051500170626     C                   end
051600181106     C                   end
051700170626     C                   end
051800170626     C                   eval      mybox = ' '
051900170626     C**                 read      sfl2
052000170626     C                   enddo
052100170626     C                   Endsr
052200170621    ? *___________________________________________________________________
052300170621    ? * format Date edit
052400170621    ? *___________________________________________________________________
052500170621    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
052600170518     C                   movel     'YYYYMMDD'    Input_Format
052700170518     C                   movel     'MM/DD/YYYY'  Output_Format
052800170518     C                   movel     OEAFTER       Input_Date
052900170518     C                   Call      'FMTDATE'
053000170518     C                   Parm                    Input_Date       32
053100170518     C                   Parm                    Input_Format     32
053200170518     C                   Parm                    Output_Format    32
053300170518     C                   Parm                    Output_Date      32
053400170518     C                   Parm                    Output_Error     10
053500170518     C                   movel     Output_Date   WSAFTER
053600170518    ?C                   Endsr                                                  END DLT RQST
053700170621    ? *___________________________________________________________________
053800170808    ? * key list
053900170621    ? *___________________________________________________________________
054000170808    ?C     KEYLIST       Begsr                                                  EDIT DELETE RQS
054100170621     C     oekey         klist
054200170621     C                   kfld                    OETRN#
054300170621     C                   kfld                    OEGRPV
054400170621     C                   kfld                    OEFLDV
054500170621    ?C                   Endsr                                                  END DLT RQST
054600180326       // ----------------------------------------------------------------
054700180326       Begsr chkSecurity;
054800170808
054900180326          //?Check Program Authority
055000180326          ChkWebAuth(@pgmq : psuserid : oContinue);
055100180326          if oContinue = 'N';
055200180326             *inlr = *on;
055300180326             Return;
055400180326          endif;
055500170808
055600180326       Endsr;
055700180327
