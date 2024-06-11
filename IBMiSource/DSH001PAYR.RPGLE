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
003800170626
003900170620     D RRN             S              5I 0
004000170620     D SETRRN          S              5I 0
004100170620     D PRODRRN         S              5I 0
004200170620     D i               S              5I 0
004300170621     D wwretf          S              1a
004400170518     D wsssid          S             16a
004500180327     D pos             S              5s 0
004600170623     D cnt             S              9s 0
004700170626     D slc             S              3s 0
004800170626     D x               S              3s 0
004900170713     D curtime         s               z
005000170810     D oContinue       S              1a
005100200803mod2 D rtvpsp          S              9s 0
005200200803mod2 D rtvpsa          S              9s 0
005300200803mod2 D rtvpspD         S              9s 0
005400200803mod2 D rtvpsaD         S              9s 0
005500200803mod2 D spsseq          S              2s 0
005600200804     D skip            S              1a
005700170620
005800170713     D savtrs          S              3s 0
005900170713     D savsub          S              3s 0
006000170713     D savact          S              4s 0
006100170713
006200170620     D SFLPAG          C                   Const(13)
006300170621
006400170621     D DSH002R         PR                  ExtPgm('DSH002R')
006500170621     D  retflg                             Like(OERETF)
006600170810
006700170810     D CHKWEBAUTH      PR                  ExtPgm('CHKWEBAUTH')
006800170810     D  pgm                                Like(WQPGMN)
006900170810     D  usr                                Like(WQUSRN)
007000170810     D  flg                                Like(OERETF)
007100100520
007200170515     d d_CCYYMMDD...
007300170515     d                 S               D   datfmt(*ISO)
007400170515     d d_MMDDCCYY...
007500170515     d                 S               D   datfmt(*USA)
007600170515
007700170621    ? * Program status data structure
007800170621    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
007900170808     D  @pgmq            *proc
008000180327      *--------------------------------------------------------------
008100180327
008200170713     c     *entry        Plist
008300170713     C                   parm                    inGeni           25
008400170515
008500170713     C     inGeni        Chain     PLSESSIDP
008600170713     C                   if        %found(PLSESSIDP)
008700170713     C                   eval      curtime = %timestamp
008800170713     C                   if        curtime > PSEXPTM
008900170713     C                   eval      *InLr = *On
009000170713     C                   Return
009100170713     C                   else
009200170810     C                   exsr      chkSecurity
009300170713     C                   eval      savtrs = PSTRST
009400170713     C                   eval      savsub = PSSUB#
009500170713     C                   eval      savact = PSACCT
009600170713     C                   end
009700170713     C                   else
009800170713     C                   eval      *InLr = *On
009900170713     C                   Return
010000170713     C                   end
010100170713
010200170713      /FREE
010300100520
010400180326       // Initialize "named indicators.
010500180326       VIEW = *Off;
010600180326       EXIT = *Off;
010700180326       HELP1 = *Off;
010800180326       HELP2 = *Off;
010900180326       SFLDSP = *Off;
011000180326       SFLCLR = *Off;
011100180326       GOSSN  = *Off;
011200180326       GOSSID = *Off;
011300180326       Slc = 0;
011400100520
011500180326       DoW EXIT = *Off;
011600100520
011700180326          // Clear the subfile.
011800180326          SFLCLR = *On;
011900180326          Write SFLCTL1;
012000180326          SFLCLR = *Off;
012100180326          CNT = 0;
012200180326          RRN = 0;
012300170713
012400100520
012500180326          select ;
012600180326          // Search on SSN
012700180326          when  GOSSN = *ON and SRSSN <> 0 ;
012800180326             SRSSID = *blanks ;
012900170517
013000180326             // Load the subfile.
013100180326             SetLL (SRSSN) WEBTRANL36;
013200180326             Reade (SRSSN) WEBTRANL36;
013300180326             DoW Not %EOF(WEBTRANL36);
013400170620
013500180326                chain (OETRST:OESUB#:OEACCT) accmst ;
013600180326                chain (A_AACODE) AACODE ;
013700180326                wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
013800170622
013900180326                chain oessno member ;
014000180327                wsname = %trim(mfname) + ' ' + %trim(MMI) +
014100180327                          ' ' + %trim(MLNAME) ;
014200170517
014300180327                d_CCYYMMDD = %date(OEADDD:*ISO);
014400180326                d_MMDDCCYY = d_CCYYMMDD;
014500180326                OEADDD = %dec(d_MMDDCCYY:*USA);
014600170517
014700180327
014800180518                select;
014900181107                when  %trim(PSUSERID) = 'JALLEN' or
015000220822                    %trim(PSUSERID) = 'CFALLIN'  or
015100220822                    %trim(PSUSERID) = 'cfallin'  or
015200220818                    %trim(PSUSERID) = 'CANDACEF'  or
015300181113                    %trim(PSUSERID) = 'SHELLY';
015400180518                   RRN += 1;
015500180518                   CNT += 1;
015600180518                   Write SFL1;
015700180518                other;
015800180327    *           if #chkdect(oetrn#) <> 'Y';
015900180326                   RRN += 1;
016000180326                   CNT += 1;
016100180326                   Write SFL1;
016200180518                Endif;
016300180518                Endsl;
016400170620
016500180326                Reade (SRSSN) WEBTRANL36;
016600180326             EndDo;
016700170517
016800180326          // Search on SSID
016900180326          when  GOSSID = *ON and SRSSID <> *blanks ;
017000180326             SRSSN = *zeros ;
017100170517
017200180326             // Load the subfile.
017300180326             SetLL (SRSSID) WEBTRANL38;
017400180326             Reade(n) (SRSSID) WEBTRANL38;
017500180326             DoW Not %EOF(WEBTRANL38);
017600170622
017700180326                chain (OETRST:OESUB#:OEACCT) accmst ;
017800180326                chain (A_AACODE) AACODE ;
017900180326                wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
018000170622
018100180326                chain oessno member ;
018200180327                wsname = %trim(mfname) + ' ' + %trim(MMI) +
018300180327                              ' ' + %trim(MLNAME) ;
018400170517
018500180326                d_CCYYMMDD = %date(OEADDD:*ISO);
018600180326                d_MMDDCCYY = d_CCYYMMDD;
018700180326                OEADDD = %dec(d_MMDDCCYY:*USA);
018800170517
018900180327
019000180518                select;
019100181107                when  %trim(PSUSERID) = 'JALLEN' or
019200220822                    %trim(PSUSERID) = 'CFALLIN'  or
019300220822                    %trim(PSUSERID) = 'cfallin'  or
019400220818                    %trim(PSUSERID) = 'CANDACEF'  or
019500181113                    %trim(PSUSERID) = 'SHELLY';
019600180518                   RRN += 1;
019700180518                   CNT += 1;
019800180518                   Write SFL1;
019900180518                other;
020000180518    *           if #chkdect(oetrn#) <> 'Y';
020100180518                   RRN += 1;
020200180518                   CNT += 1;
020300180518                   Write SFL1;
020400180518                Endif;
020500180518                Endsl;
020600170620
020700180326                Reade(n) (SRSSID) WEBTRANL38;
020800180326             EndDo;
020900170517
021000180326          Other ;
021100170517
021200180326             CNT = 0;
021300180326             // Load the subfile.
021400180326             SetLL (*LoVal) WEBTRANL37;
021500180326             Read(n) WEBTRANL37;
021600180326             DoW Not %EOF(WEBTRANL37);
021700170621
021800180326                chain (OETRST:OESUB#:OEACCT) accmst ;
021900180326                chain (A_AACODE) AACODE ;
022000180326                wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
022100170621
022200180326                chain oessno member ;
022300180327                wsname = %trim(mfname) + ' ' + %trim(MMI) + ' '
022400180327                       + %trim(MLNAME) ;
022500170621
022600180326                d_CCYYMMDD = %date(OEADDD:*ISO);
022700180326                d_MMDDCCYY = d_CCYYMMDD;
022800180326                OEADDD = %dec(d_MMDDCCYY:*USA);
022900170623
023000180327
023100180518
023200180518    *           if #chkdect(oetrn#) <> 'Y';
023300180518                   RRN += 1;
023400180518                   CNT += 1;
023500180518                   Write SFL1;
023600180518                Endif;
023700210730
023800210730          // mod3
023900210730                if cnt >= 10;
024000210730                leave ;
024100210730                Endif;
024200210730
024300170626
024400180326                Read(n) WEBTRANL37;
024500170620
024600180326             EndDo;
024700170620
024800180326             If %EOF(WEBTRANL37) ;
024900180326             Else;
025000180326             EndIf;
025100170620
025200180326             If PRODRRN <= SFLPAG;
025300180326             Else;
025400180326             EndIf;
025500100520
025600170517
025700180326          Endsl;
025800170517
025900170517
026000180326          // Display the subfile.
026100180326          SFLDSP = *On;
026200180326          ExFmt SFLCTL1;
026300170628
026400180326          dow HELP1 = *ON;
026500180326             ExFmt HELPPNL;
026600180326             if  CLSHLP1 = *On;
026700180326                HELP1 = *off;
026800180326             endif;
026900180326          enddo;
027000170628
027100170515
027200180326          readc SFL1;
027300180326          if not %eof();
027400170515
027500180326             BACK = *Off;
027600170515
027700180326             chain (OESSID) webtranl38;
027800180326             wsssid = oessid;
027900170628
028000180326             chain (oetrst:oesub#:oeacct) ACCMST;
028100180326             chain (A_AACODE) AACODE ;
028200180326             wsaanm = %trim(AFNAM) + ' ' + %trim(ALNAM);
028300170517
028400180326             wstsa = %editc(OETRST: 'X') + '-' +
028500180326                %editc(OESUB#: 'X') + '-' +
028600180326                %editc(OEACCT: 'X') ;
028700170517
028800180326             d_CCYYMMDD = %date(OEADDD:*ISO);
028900180326             d_MMDDCCYY = d_CCYYMMDD;
029000180326             WSADDD = %dec(d_MMDDCCYY:*USA);
029100170515
029200170515
029300180326             DoW BACK = *Off;
029400170515
029500180326                // Clear the subfile.
029600180326                SFLCLR2 = *On;
029700180326                Write SFLCTL2;
029800180326                SFLCLR2 = *Off;
029900180326                RRN2 = 0;
030000170515
030100180326                // Load the subfile.
030200180326                SetLL (oessid) WEBTRANL38;
030300180326                Reade(n) (oessid) WEBTRANL38;
030400180326                DoW Not %EOF(WEBTRANL38);
030500170518
030600180326                   wsbefore = %trim(OEBEFORE) ;
030700180326                   if %trim(wsbefore) = '00000000';
030800180326                      eval wsbefore = *blanks ;
030900180326                   endif;
031000180326                   if %trim(wsbefore) = '000';
031100180326                      eval wsbefore = *blanks ;
031200180326                   endif;
031300180326                   if %trim(wsbefore) = '0000000';
031400180326                      eval wsbefore = *blanks ;
031500180326                   endif;
031600180326                   if %trim(wsbefore) = '000000000';
031700180326                      eval wsbefore = *blanks ;
031800180326                   endif;
031900170515
032000180326                   wsafter  = %trim(OEAFTER) ;
032100180326                   if %trim(wsafter) = '00000000';
032200180326                      eval wsafter = *blanks ;
032300180326                   endif;
032400170518
032500180326                   if %trim(OEFLDV) = 'TERM_REASON' ;
032600180326                      PCGRPR = 'TE_REASON' ;
032700180326                      PCCODE = %trim(OEAFTER) ;
032800180326                      Chain (OETRST:OESUB#:OEACCT:PCGRPR:PCCODE) WEBPAYCHP ;
032900180326                      if %found(WEBPAYCHP) ;
033000180326                         wsafter  = %trim(PCDESC) ;
033100180326                      else;
033200180326                         Chain (000:000:0000:PCGRPR:PCCODE) WEBPAYCHP ;
033300180326                         if %found(WEBPAYCHP) ;
033400180326                            wsafter  = %trim(PCDESC) ;
033500180326                         endif;
033600180326                      endif;
033700180326                   endif;
033800170518
033900180326                   pos = %scan('Date':OEFLDV) ;
034000180326                   if pos > 0 ;
034100180326                      exsr edtdat ;
034200180326                   endif ;
034300170517
034400180326                   If  %trim(OEFLDV) <> '**PROGRAMMER ONLY**' ;
034500180518                      if oeretd = 0;
034600180326
034700180326                         RRN2 += 1;
034800180326                         Slc += 1;
034900180326                         Write SFL2;
035000180326
035100180326                      endif ;
035200180326                   endif ;
035300180326                   Reade(n) (oessid) WEBTRANL38;
035400180326                EndDo;
035500170515
035600180326                // Display the subfile.
035700180326                SFLDSP2 = *On;
035800180326                ExFmt SFLCTL2;
035900170628
036000180326                dow HELP2 = *ON;
036100180326                   ExFmt HELPPNL2;
036200180326                   if  CLSHLP2 = *On;
036300180326                      HELP2 = *off;
036400180326                   endif;
036500180326                enddo;
036600170621
036700180326                // Process prompt, if required.
036800180326                If RETIRE_ALL = *On;
036900180326                   callp DSH002R(WWRETF) ;
037000180326                   exsr RETIRE_A;
037100200804                if skip = 'Y';
037200200804                      ExFmt SKIPPED;
037300200804                Endif;
037400180326                Endif;
037500180326                If RETIRE_SEL = *On;
037600180326                   readc sfl2;
037700180326                   if not %eof ;
037800180326                      callp DSH002R(WWRETF) ;
037900180326                      exsr RETIRE_S;
038000180326                   else ;
038100180326                      ExFmt WARNING;
038200180326                   Endif;
038300180326                Endif;
038400170515
038500180326             EndDo;
038600170515
038700180326          Endif;
038800170515
038900180326       EndDo;
039000100520
039100180326       *InLr = *On;
039200180326       Return;
039300170620
039400170620      /END-FREE
039500170518    ? *___________________________________________________________________
039600170621    ? * Retire All
039700170518    ? *___________________________________________________________________
039800170621    ?C     RETIRE_A      Begsr                                                  EDIT DELETE RQS
039900170622     C                   If        WWRETF = *blanks
040000170622     C                   LeaveSR
040100170622     C                   end
040200200803
040300200803mod2 C                   clear                   rtvpsp
040400200803mod2 C                   clear                   rtvpspD
040500200803mod2 C                   clear                   rtvpsa
040600200804mod2 C                   clear                   rtvpsaD
040700200804mod2 C                   clear                   skip
040800200803
040900240405mod2 C**********         eval      rtvpsp = #skpret(oessid:'PSP':0)
041000240405mod2 C**********         eval      rtvpsa = #skpret(oessid:'PSA':0)
041100240405mod2 C**********         eval      spsseq = #getsps(oetrst:oesub#:oeacct:oessno)
041200240405mod2 C**********         eval      rtvpspD = #skpret(oessid:'PSP':spsseq)
041300240405mod2 C**********         eval      rtvpsaD = #skpret(oessid:'PSA':spsseq)
041400200803
041500170713     C     KEYSSI        klist
041600170713     C                   kfld                    OESSID
041700170713     C     KEYSSI        setll     WEBTRANL38
041800170713     C     KEYSSI        reade     WEBTRANL38
041900170621     C                   dow       not %eof(WEBTRANL38)
042000181106    *C                   if        #chkdect(oetrn#) <> 'Y' or
042100181107     C                             %trim(PSUSERID) = 'JALLEN' or
042200220818     C                             %trim(PSUSERID) = 'CANDACEF' or
042300220822     C                             %trim(PSUSERID) = 'CFALLIN'  or
042400220822     C                             %trim(PSUSERID) = 'cfallin'  or
042500181113     C                             %trim(PSUSERID) = 'SHELLY'
042600180518     C                   If        oeretd = 0
042700200803mod2 C                   select
042800200803 |   C                   when      oetrn# = rtvpsp
042900200804 |   C                   eval      skip = 'Y'
043000200803 |    * skip
043100200803 |   C                   when      oetrn# = rtvpspD
043200200804 |   C                   eval      skip = 'Y'
043300200803 |    * skip
043400200803 |   C                   when      oetrn# = rtvpsa
043500200804 |   C                   eval      skip = 'Y'
043600200803 |    * skip
043700200803 |   C                   when      oetrn# = rtvpsaD
043800200804 |   C                   eval      skip = 'Y'
043900200803 |    * skip
044000200803mod2 C                   other
044100170621     C                   eval      oeretf = WWRETF
044200170811     C                   eval      oeretu = %trim(PSUSERID)
044300170621     C                   eval      oeretd = %int(%char(%date : *iso0))
044400170621     C                   time                    oerett
044500170621     C                   update    webl38
044600200803mod2 C                   endsl
044700181106     C                   end
044800171213     C                   end
044900170713     C     KEYSSI        reade     WEBTRANL38
045000170621     C                   Enddo
045100170621     C                   Endsr
045200170621    ? *___________________________________________________________________
045300170621    ? * Retire Selected
045400170621    ? *___________________________________________________________________
045500170621    ?C     RETIRE_S      Begsr                                                  EDIT DELETE RQS
045600170622     C                   If        WWRETF = *blanks
045700170626     C                   eval      x = 0
045800170626     C                   dow       x <= slc
045900170626     C     x             chain     sfl2
046000170626     C                   eval      mybox  = ' '
046100170626     C                   update(e) sfl2
046200170626     C                   eval      x = x+1
046300170626     C                   enddo
046400170622     C                   LeaveSR
046500170622     C                   end
046600170626     C                   eval      x = 0
046700170626     C                   dow       x <= slc
046800170626     C     x             chain     sfl2
046900170621     C                   if        %trim(mybox) = 'Y'
047000170621     C     oekey         chain     WEBTRANL37
047100170621     C                   if        %found(WEBTRANL37)
047200181106    *C                   if        #chkdect(oetrn#) <> 'Y' or
047300181107     C                             %trim(PSUSERID) = 'JALLEN' or
047400220818     C                             %trim(PSUSERID) = 'CANDACEF' or
047500220822     C                             %trim(PSUSERID) = 'CFALLIN'  or
047600220822     C                             %trim(PSUSERID) = 'cfallin'  or
047700181113     C                             %trim(PSUSERID) = 'SHELLY'
047800170621     C                   eval      oeretf = WWRETF
047900170811     C                   eval      oeretu = %trim(PSUSERID)
048000170621     C                   eval      oeretd = %int(%char(%date : *iso0))
048100170621     C                   time                    oerett
048200170621     C                   update    webl37
048300170626     C                   end
048400181106     C                   end
048500170621     C                   end
048600170622     C                   eval      mybox = ' '
048700170626     C                   eval      x = x+1
048800170621     C                   enddo
048900170621     C                   Endsr
049000170626    ? *___________________________________________________________________
049100170626    ? * Retire Selected
049200170626    ? *___________________________________________________________________
049300170626    ?C     RETIRE_X      Begsr                                                  EDIT DELETE RQS
049400170626     C                   If        WWRETF = *blanks
049500170626     C                   LeaveSR
049600170626     C                   end
049700170626     C**                 read      sfl2
049800170626     C                   dow       not %eof
049900170626     C                   if        %trim(mybox) = 'Y'
050000170626     C     oekey         chain     WEBTRANL37
050100170626     C                   if        %found(WEBTRANL37)
050200181106    *C                   if        #chkdect(oetrn#) <> 'Y' or
050300181107     C                             %trim(PSUSERID) = 'JALLEN' or
050400220818     C                             %trim(PSUSERID) = 'CANDACEF' or
050500220822     C                             %trim(PSUSERID) = 'CFALLIN'  or
050600220822     C                             %trim(PSUSERID) = 'cfallin'  or
050700181113     C                             %trim(PSUSERID) = 'SHELLY'
050800170626     C                   eval      oeretf = WWRETF
050900170811     C                   eval      oeretu = %trim(PSUSERID)
051000170626     C                   eval      oeretd = %int(%char(%date : *iso0))
051100170626     C                   time                    oerett
051200170626     C                   update    webl37
051300170626     C                   end
051400181106     C                   end
051500170626     C                   end
051600170626     C                   eval      mybox = ' '
051700170626     C**                 read      sfl2
051800170626     C                   enddo
051900170626     C                   Endsr
052000170621    ? *___________________________________________________________________
052100170621    ? * format Date edit
052200170621    ? *___________________________________________________________________
052300170621    ?C     EDTDAT        Begsr                                                  EDIT DELETE RQS
052400170518     C                   movel     'YYYYMMDD'    Input_Format
052500170518     C                   movel     'MM/DD/YYYY'  Output_Format
052600170518     C                   movel     OEAFTER       Input_Date
052700170518     C                   Call      'FMTDATE'
052800170518     C                   Parm                    Input_Date       32
052900170518     C                   Parm                    Input_Format     32
053000170518     C                   Parm                    Output_Format    32
053100170518     C                   Parm                    Output_Date      32
053200170518     C                   Parm                    Output_Error     10
053300170518     C                   movel     Output_Date   WSAFTER
053400170518    ?C                   Endsr                                                  END DLT RQST
053500170621    ? *___________________________________________________________________
053600170808    ? * key list
053700170621    ? *___________________________________________________________________
053800170808    ?C     KEYLIST       Begsr                                                  EDIT DELETE RQS
053900170621     C     oekey         klist
054000170621     C                   kfld                    OETRN#
054100170621     C                   kfld                    OEGRPV
054200170621     C                   kfld                    OEFLDV
054300170621    ?C                   Endsr                                                  END DLT RQST
054400180326       // ----------------------------------------------------------------
054500180326       Begsr chkSecurity;
054600170808
054700180326          //?Check Program Authority
054800180326          ChkWebAuth(@pgmq : psuserid : oContinue);
054900180326          if oContinue = 'N';
055000180326             *inlr = *on;
055100180326             Return;
055200180326          endif;
055300170808
055400180326       Endsr;
055500180327
