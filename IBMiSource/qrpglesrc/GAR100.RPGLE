000001240508      *========================================================================
000101240506     h dftactgrp(*no) option(*noDebugIo)
000102240506      *========================================================================
000103240506      * GAR100 - Enhanced Manual Batch Entry
000104240506      *========================================================================
000105240506      * Date         Int  Description
000106240506      * ----------   ---  -----------------------------------------------------
000107240506      * 01/30/2009   ssk  Remove SQL and add WFEE contract count
000109240506      * 04/30/2024   jt   Created new PL screen, while keeping the old RPG pgm
                  *              jt   test
000110240506      *========================================================================
002500240506
003100240506     fgar100db  cf   e             WorkStn Handler('PROFOUNDUI(HANDLER)')
003101240506     f                                     SFILE(GASSFL:RRT)
003102240506
003200090130     FBCHHDRP   UF A E           K DISK    PREFIX(RN:2)
003201240506
003300090313     FBCHDTLL1  IF   E           K DISK    RENAME(BCHDTLR:DTLDUP)
003400090313     F                                     PREFIX(WQ:2)
003401240506
003500040826     FBCHDTLL   IF   E           K DISK    RENAME(BCHDTLR:DTLINP)
003501240506
003600040826     FBCHDTLP   UF A E           K DISK
003601240506
003700040826     FCARMSTP   IF   E           K DISK
003701240506
003800040826     FCDEMSTP   IF   E           K DISK
003801240506
003900040830     FACCPRDL2  IF   E           K DISK
003901240506
004000040930     FACCPRDL4  IF   E           K DISK    RENAME(ACCPRDR:APF4) PREFIX(A4:2)
004001240506
004100041012     FPRDCOML1  IF   E           K DISK
004101240506
004200100913     FPRDMSTL1  IF   E           K DISK
004201240506
004300040830     FACCMSTP   IF   E           K DISK
004400240506
004401240506      *========================================================================
004402240506
004501240507     D WSDS            DS
004502240507     D  FKEY                 369    369A
004503240507    ***
004504240507     D  F1             C                   CONST(X'31')
004505240507     D  F2             C                   CONST(X'32')
004506240507     D  F3             C                   CONST(X'33')
004507240507     D  F4             C                   CONST(X'34')
004508240507     D  F5             C                   CONST(X'35')
004509240507     D  F6             C                   CONST(X'36')
004510240507     D  F7             C                   CONST(X'37')
004511240507     D  F8             C                   CONST(X'38')
004512240507     D  F9             C                   CONST(X'39')
004513240507     D  F10            C                   CONST(X'3A')
004514240507     D  F11            C                   CONST(X'3B')
004515240507     D  F12            C                   CONST(X'3C')
004516240507     D  F13            C                   CONST(X'B1')
004517240507     D  F14            C                   CONST(X'B2')
004518240507     D  F15            C                   CONST(X'B3')
004519240507     D  F16            C                   CONST(X'B4')
004520240507     D  F17            C                   CONST(X'B5')
004521240507     D  F18            C                   CONST(X'B6')
004522240507     D  F19            C                   CONST(X'B7')
004523240507     D  F20            C                   CONST(X'B8')
004524240507     D  F21            C                   CONST(X'B9')
004525240507     D  F22            C                   CONST(X'BA')
004526240507     D  F23            C                   CONST(X'BB')
004527240507     D  F24            C                   CONST(X'BC')
004600240506
004700040930     D                 DS
004800041209     D PARMS@IO                1     97A
004900040930     D  KEY@MKSZ               1     10A
005000040930     D  KEY@CAID              11     20A
005100040930     D  KEY@PRID              21     30A
005200040930     D  KEY@ACCT              31     40A
005300040930     D  KEY@CGRP              41     60A
005400040930     D  PRM#EFDT              61     70D   DATFMT(*ISO)
005500040930     D  RTN#CMRT              71     77S 2
005600040930     D  RTN#WFRT              78     84S 2
005700041208     D  RTN#AFTY              85     85A
005800041208     D  RTN#AFRT              86     94S 4
005900041209     D  RTN#GSC               95     95A
006000041209     D  RTN#GSW               96     96A
006100041209     D  RTN#GSA               97     97A
006200240506
006300100914     D KEY@PDTY        S             20A
006400040930     D X@C             S             11S 2
006500040930     D X@CALC          S             12S 3
006600050629     D SORT_BY         S              3A
006700240506
006800041018     D WUACPP        E DS                  EXTNAME(ACCPRDP)
006900240506
007000090130     D @DTL          E DS                  EXTNAME(BCHDTLP)
007100240506
007200090130     D @HDR          E DS                  EXTNAME(BCHHDRP)
007300240506
007400090130     D IO@HDR        E DS                  EXTNAME(BCHHDRP)
007500090130     D                                     PREFIX(RN:2)
007600240506
007601240509       dcl-s #seq2 Packed(9) dtaara('AHBATCH');
007602240506
007700090130     D #LSEQ           S                   LIKE(BHLSEQ)
007800090130     D #OSEQ           S                   LIKE(BHLSEQ)
007900040826     D @STEP           S              5A
008000040826     D KEY@BCHNO       S                   LIKE(BHBCHNO)
008100040826     D KEY@CODE        S                   LIKE(CDCODE)
008200040826     D KEY@TYPE        S                   LIKE(CDTYPE)
008300040830     D @EMSG           S                   LIKE(EMSG)
008400040826     D ACHDTA        E DS                  EXTNAME(ACCHSTP)
008500040826     D #ISO            S               D   DATFMT(*ISO)
008600040826     D #USA            S               D   DATFMT(*USA)
008700040826     D #CNTREC         S              4S 0
008800040826     D @1STLOOP        S              1A
008900240506
008901240506     D KEY@CGR2        S             20
009000050629     D K@SEQ           S              9S 0
009100040830     D LOOP_ADD        S               N
009200040826     D YES             S               N   INZ(*ON)
009300040826     D NO              S               N   INZ(*OFF)
009400050502     D XIT_RCR         S               N
009500040930     D VALID_ACP4      S               N
009600040830     D ADD_MODE        S               N
009700040830     D CHG_MODE        S               N
009800040830     D DSP_MODE        S               N
009900040830     D DLT_MODE        S               N
010100040830     D VALID_DTA       S               N
010200040826     D EXIST_BCH       S               N
010300040826     D @291            S            291A
010400040826     D WWRQS           S              8A
010500040826     D WWRTN           S              8A
010600040826     D WUPGM           S             10A
010700240506
010801240506     D BCH@LDA         DS
010802240506     D LB@BCHNO                1      9A
010803240506     D LB@CPREM               10     20S 2
010804240506     D LB@CCOMM               21     31S 2
010805240506     D LB@CWFEE               32     42S 2
010806240506     D LB@CBENRC              43     49S 0
010807240506     D LB@CBENRW              50     56S 0
010808240506     D LB@CNOLV               57     63S 0
010809240506     D LB@NUM                 10     63A
010810240506     D LB@MISC                64     64A
010811240506     D LB@CCAMT               65     75S 2
010812240506
010813240508     d valid           s              1
010814240506     d cancel          s              1
010815240506     d hide            s              1
010816240506     d selection       s              1
010820240506
010821240506     d batchNumber     pr                  ExtPgm('GETBATCH')
010822240506     d  bhbchno                       9
010823240506     d  selection                     1
010824240506     d  hide                          1
010825240506     d  cancel                        1
010826240506
010827240508     d gar100c         pr                  ExtPgm('GAR100C')
010828240508     d  bhbchno                       9
010829240508
010830240509       //===================================================================
010831240509       // mainline
010832240509       //===================================================================
010900240506
011000050629     C     *DTAARA       DEFINE    *LDA          BCH@LDA
011100050629     C                   IN        BCH@LDA
013800240506
014600040826     C                   MOVEL     'STP00'       @STEP
014700050629     C                   EVAL      SORT_BY = 'RRN'
014800240506
014900040826     C                   DOU       @STEP = 'LEAVE'
015000040826     C     @STEP         CASEQ     'STP00'       $STP00
015100040830     C     @STEP         CASEQ     'STP01'       $STP01
015200040830     C     @STEP         CASEQ     'STP02'       $STP02
015300040830     C     @STEP         CASEQ     'STP03'       $STP03
015400040826     C                   ENDCS
015500040830     C                   ENDDO
015600240506
015700040830     C                   EVAL      *INLR = *ON
015800240506
016000040826     C     $STP00        BEGSR
016100240506
016200090202     C                   EVAL      EXIST_BCH = NO
016300090202     C                   CLEAR                   @HDR
016400090202     C                   CLEAR                   IO@HDR
016500090202     C                   EVAL      D_BTYP = *BLANKS
016600090202     C                   EVAL      O_CNAME = *BLANKS
016700090313     C                   EVAL      DUPESCHK = 'Y'
016800240506
016900040826     C                   EVAL      @STEP = 'STP01'
017000240506
017100040826     C                   ENDSR
017200240506
017300040826     C     $STP01        BEGSR
017400040826    ***
017500040826     C                   EVAL      EMSG = %TRIM(@EMSG)
017600040826     C                   EXFMT     HDRSCRN
017700040826     C                   EVAL      @EMSG = *BLANKS
017800040826    ***
017900240506     C****                   IF        FKEY = F3
018000240506     C****                   EVAL      @STEP = 'LEAVE'
018100240506     C****                   LEAVESR
018200240506     C****                   ENDIF
018300240506
018301240506       if btnExit = '1';
018302240509         @step = 'LEAVE';
018303240506       endif;
018304240506
018305240506       if btnSBatch = '1';
018306240509         batchNumber(bhbchno : selection : hide : cancel);
018307240506         btnSBatch = '0';
018308240509         leavesr;
018309240506       endif;
018310240506
018311240506       if btnNew = '1';
018312240509         in *Lock #seq2;
018313240509         bhbchno = %editc(#seq2:'X');
018314240509         //holdBatch = bhbchno;
018315240509         #seq2 = #seq2 + 1;
018316240509         out #seq2;
018317240509         btnNew = '0';
018318240509         leavesr;
018319240506       endif;
018320240506
018400240506     C****               IF        FKEY = F4
018500240506     C****               EXSR      $F4_HDR
018600240506     C****               LEAVESR
018700240506     C****               ENDIF
018800040826    ***
018900240506     C****               IF        FKEY = F6
019000240506     C****               EXSR      $NXTNUM
019100240506     C****               EVAL      EXIST_BCH = NO
019200240506     C****               LEAVESR
019300240506     C****               ENDIF
019400240508
019401240508       if btnEnter = '1';
019500240509         exsr validate;
019600240508
019700240509         if valid = '0';
019800240508
020300240509           if exist_bch = yes;
020400240510             chain bhbchno bchhdrr;
020500240509             io@hdr = @hdr;
020600240509             update bchhdrr;
020700240509           else;
020701240509             io@hdr = @hdr;
020802240509             bhbtyp = 'M';
020803240509             bhstatus = 'N';
020806240509             bhcrtdt = %date;
020900240509             write bchhdrr;
021000240509           endif;
021001240508
021002240509           gar100c(bhbchno);
021003240509           btnEnter = '0';
021004240509           leavesr;
021005240509         endif;
021300240508
021400090202     C                   Z-ADD     BHLSEQ        #LSEQ
021500090202     C                   Z-ADD     BHLSEQ        #OSEQ
021600040826     C                   EVAL      @STEP = 'STP02'
021700040826    * *
021800040826     C                   ENDIF
021900040826    ***
022000040826     C                   ENDSR
022100040826   S***S
022200040826     C     $F4_HDR       BEGSR
022300040826    ***
022400040830     C                   IF        WHFLD = 'BHBCHNO   '
022500040826    * *
022600090202     C                   CLEAR                   @HDR
022700240509     C                   CALL      'SLCBHH  '
022800240509     C                   PARM                    WWRQS
022900240509     C                   PARM                    WWRTN
023000240509     C                   PARM                    WUPGM
023100240509     C                   PARM                    @HDR
023200040826    * *
023300040826     C                   IF        WWRTN <> 'CANCEL '
023400090202     C                   EVAL      KEY@BCHNO = BHBCHNO
023500090202     C     KEY@BCHNO     CHAIN(N)  BCHHDRR
023600090202     C                   IF        %FOUND(BCHHDRP)
023700240506     C****               MOVE      BHPMTR        I_PMTR
023800040826     C                   EVAL      EXIST_BCH = YES
023900240508     C*********          EXSR      $VLD_HDR
024000090202     C                   ENDIF
024100040826     C                   ENDIF
024200040826    * *
024300040826     C                   LEAVESR
024400040826     C                   ENDIF
024500040826    ***
024600040830     C                   IF        WHFLD = 'BHCAID    '
024700040826    * *
024800040826     C                   EVAL      @291 = *BLANKS
024900040826    C                   CALL      'SLCCRM  '
025000040826    C                   PARM                    WWRQS
025100040826    C                   PARM                    WWRTN
025200040826    C                   PARM                    WUPGM
025300040826    C                   PARM                    @291
025400040826    * *
025500040826     C                   IF        WWRTN <> 'CANCEL '
025600040826     C                   EVAL      BHCAID = %SUBST(@291:1:10)
025700040826     C                   EVAL      O_CNAME = %SUBST(@291:11:40)
025800040826     C                   ENDIF
025900040826    * *
026000040826     C                   LEAVESR
026100040826     C                   ENDIF
026200040826    ***
026300040826     C                   ENDSR
026400240506
026500040830     C     $NXTNUM       BEGSR
026600040826    ***
026700090514     C                   Call      'CHKAHS  '
026800040826     C                   Parm      'DFTBCH'      WWRQS
026900040826     C                   Parm                    WWRTN
027000040826     C                   Parm                    ACHDTA
027100240506
027200040826B1   C                   IF        WWRTN <> *BLANKS
027300040826     C                   EVAL      @EMSG = 'ERROR IN GETTING NEXT NUMBER'
027400040826     C                   ELSE
027500090202     C                   CLEAR                   @HDR
027600090202     C                   CLEAR                   IO@HDR
027700090202     C                   EVAL      BHBCHNO = AHBCHNO
027800090202     C                   EVAL      RNBCHNO = AHBCHNO
027900090202     C                   EVAL      EXIST_BCH = NO
028000090202     C                   EVAL      BHBTYP = 'M'
028100240506     C                   EVAL      bhstatus = 'N'
028200040826E1   C                   Endif
028300240506
028400040826     C                   ENDSR
028500240506
028501240509       //===================================================================
028502240509       // validate header
028503240509       //===================================================================
028504240506
028600240508       begsr validate;
028700240508
028800240509         valid = '0';
028801240509         errBatch = '0';
028802240509         errBatch2 = '0';
028803240509         errCarrier = '0';
028804240509         errCarrie2 = '0';
028805240509         errCheck = '0';
028806240509         errSelect = '0';
028807240509         errDesc = '0';
028808240509         errDate = '0';
028809240509         errDate2 = '0';
028900240508
028901240509         if bhbchno = ' ';
028902240509           errBatch2 = '1';
028903240509           valid = '1';
028904240509           leavesr;
028905240509         endif;
028906240508
028907240509         chain(n) bhbchno bchhdrr;
028908240509         if not %found;
028909240509           if btnSbatch = '0' and btnNew = '0';
028910240509             errBatch2 = '1';
028911240509             valid = '1';
028912240509             leavesr;
028913240509           endif;
028914240509         endif;
028915240508
028916240509         if bhcaid = ' ';
028917240509           errCarrier = '1';
028918240509           valid = '1';
028919240509           leavesr;
028920240509         endif;
028921240508
029000240509         if bhcaid = 'MBI';
029001240509           errCarrie2 = '1';
029002240509           valid = '1';
029003240509           leavesr;
029004240509         endif;
030000240508
030001240509         if bhchkno = ' ';
030002240509           errCheck = '1';
030003240509           valid = '1';
030004240509           leavesr;
030005240509         endif;
030006240508
030007240509         if bhbtyp = ' ';
030008240509           errSelect = '1';
030009240509           valid = '1';
030010240509           leavesr;
030011240509         endif;
030012240508
030013240509         if bhcsdes = ' ';
030014240509           errDesc = '1';
030015240509           valid = '1';
030016240509           leavesr;
030017240509         endif;
030018240508
030101240509         chain(n) bhbchno bchhdrr;
030300240509         if %found;
030400240509           @HDR = IO@HDR;
030500240509           EXIST_BCH = YES;
030600240509         else;
030700240509           clear io@hdr;
030900240509           EXIST_BCH = NO;
031100240509         endif;
031300240508
031501240509         chain ('BHT' : bhbtyp) cdemstr;
031502240509         if %found;
031800240509           D_BTYP = %SUBST(CDDESC:1:20);
031801240509         else;
032000240509           D_BTYP = '*UNKNOWN';
032001240509         endif;
032200240508
032401240509         chain ('BHS' : bhstatus) cdemstr;
032402240509         if %found;
032700240509           D_STATUS = %SUBST(CDDESC:1:20);
032701240509         else;
032900240509           D_STATUS = '*UNKNOWN';
032901240509         endif;
033100240508
034900240509         if bhpmtr = d'0001-01-01' or bhpmtr = D'9999-12-31';
034901240509           errDate = '1';
034902240509           valid = '1';
034903240509           leavesr;
034904240509         endif;
035400240508
035401240509         if bhpmtr > cmtrdt or bhpmtr < cmefdt;
035402240509           errDate2 = '1';
035403240509           valid = '1';
035404240509           leavesr;
035405240509         endif;
035406240508
036800240508
036900240508       endsr;
036901240508
036902240509       //===================================================================
037000240508
037100040826     C     $STP02        BEGSR
037200040826    ***
037300040826     C                   EXSR      $CLRSFL
037400040826    ***
037500040826     C                   IF        EXIST_BCH = YES
037600040826     C                   EVALR     KEY@CGRP = '*'
037700040826     C                   EXSR      $BLDSFL
037800040826     C                   ENDIF
037900090202    ***
038000240506     C                   IF        bhcaid = 'NCA' OR BHCAID = 'CFW'
038100090202     C                   EVAL      *IN76 = *OFF
038200090202     C                   ELSE
038300090202     C                   EVAL      *IN76 = *ON
038400090202     C                   ENDIF
038500040826    ***
038600040826     C                   EVAL      @STEP = 'STP03'
038700100914     C                   EVAL      KEY@ACCT = *BLANKS
038800100914     C                   EVAL      KEY@PRID = *BLANKS
038900100914     C                   EVAL      KEY@CGRP = *BLANKS
039000100914     C                   EVAL      KEY@PDTY = *BLANKS
039100040826    ***
039200040826     C                   ENDSR
039300040826   S***S
039400040826     C     $CLRSFL       BEGSR
039500040826    ***
039600040826     C                   MOVEA     '011'         *IN(25)
039700040826     C                   WRITE     GASCTL
039800040826     C                   MOVEA     '010'         *IN(25)
039900040830     C                   Z-ADD     *ZERO         RRT               4 0
040000040826    ***
040100040826     C                   ENDSR
040200040826   S***S
040300040826     C     $BLDSFL       BEGSR
040400040826    ***
040500040826     C                   EXSR      $CLRSFL
040600040826     C                   MOVE      *ZEROS        #CNTREC
040700040826     C                   MOVE      '0'           @1STLOOP
040800050629     c                   move      '0'           fnd_it            1
040900040826    ***
041000050629     C                   IF        SORT_BY = 'KEY'
041001240506
041002240506       setll (bhbchno : key@cgr2) dtlinp;
041200090331     C                   DOU       %EOF(BCHDTLL) OR #CNTREC >= 900
041300040826     C                   EXSR      $LOADSFL
041400040826     C                   ENDDO
041500050629     C                   ELSE
041600050629     C                   Z-ADD     1             K@SEQ
041601240506
041700050629     c                   if        wspsn1 = *blanks
041800050629     c                   eval      fnd_it = '1'
041900050629     c                   endif
041901240506
041902240506       setll (bhbchno : k@seq) bchdtlr;
042100090331     C                   DOU       %EOF(BCHDTLP) OR #CNTREC >= 900
042200050629     C                   EXSR      $LOADSFL
042300050629     C                   ENDDO
042301240506
042400050629     C                   ENDIF
042500040826    ***
042600040826     C                   ENDSR
042700040826   S***S
042800040826     C     $LOADSFL      BEGSR
042900040826    ***
043000050629     C                   IF        SORT_BY = 'KEY'
043100040826     C     BHBCHNO       READE     DTLINP
043200040826     C                   IF        %EOF(BCHDTLL)
043300040826     C                   LEAVESR
043400040826     C                   ENDIF
043500050629     C                   ELSE
043600050629     C     BHBCHNO       READE     BCHDTLR
043700050629     C                   IF        %EOF(BCHDTLP)
043800050629     C                   LEAVESR
043900050629     C                   ENDIF
044000050629     C                   ENDIF
044100040826    ***
044200040826     C                   MOVE      *ON           *IN25
044300040826     C                   EVAL      WSOPC = ' '
044400090202     C                   MOVEL(P)  BDCGRP        ADCGRP
044500040826     C                   EVAL      ADPDTY = BDPDTY
044600040826     C                   EVAL      WSPMTE = BDPMTE
044700090202     C                   EVAL      ADBENRC = BDBENRC
044800090202     C                   EVAL      ADBENRW = BDBENRW
044900040826     C                   EVAL      ADPREM = BDPREM
045000040826     C                   EVAL      ADCOMM = BDCOMM
045100040826     C                   EVAL      ADWHSL = BDWHSL
045200090202     C                   EVAL      DTLDS = @DTL
045300041008     C                   EVAL      ADCAMT = BDCAMT
045400040826     C*
045500040826     C                   ADD       1             #CNTREC
045600040826     C                   ADD       1             RRT
045700040826     C*
045800040826     C                   IF        @1STLOOP = '0'
045900040830     C                   Z-ADD     RRT           WSPAG
046000040826     C                   MOVE      '1'           @1STLOOP
046100040826     C                   ENDIF
046200040826     C*
046300040826     C                   WRITE     GASSFL
046400040826    ***
046500040826     C                   ENDSR
046600040826   S***S
046700090331     C     $CLRSFLR      BEGSR
046800090331    ***
046900090331     C                   MOVEA     '011'         *IN(25)
047000090331     C                   WRITE     GASCTL
047100090331     C                   MOVEA     '010'         *IN(25)
047200090331     C                   Z-ADD     *ZERO         RRT               4 0
047300090331    ***
047400090331     C                   ENDSR
047500090331   S***S
047600090331     C     $BLDSFLR      BEGSR
047700090331    ***
047800090331     C                   EXSR      $CLRSFLR
047900090331     C                   MOVE      *ZEROS        #CNTREC
048000090331     C                   MOVE      '0'           @1STLOOP
048100090331     c                   move      '0'           fnd_it            1
048200090331    ***
048300090331     C                   IF        SORT_BY = 'KEY'
048400090413     C     BHBCHNO       SETGT     DTLINP
048500090331     C                   DOU       %EOF(BCHDTLL) OR #CNTREC >= 900
048600090331     C                   EXSR      $LOADSFLR
048700090331     C                   ENDDO
048800090331     C                   ELSE
048900090331     C     BHBCHNO       SETGT     BCHDTLR
049000090331     C                   DOU       %EOF(BCHDTLP) OR #CNTREC >= 900
049100090331     C                   EXSR      $LOADSFLR
049200090331     C                   ENDDO
049300090331     C                   ENDIF
049400090331    ***
049500090331     C                   ENDSR
049600090331   S***S
049700090331     C     $LOADSFLR     BEGSR
049800090331    ***
049900090331     C                   IF        SORT_BY = 'KEY'
050000090331     C     BHBCHNO       READPE    DTLINP
050100090331     C                   IF        %EOF(BCHDTLL)
050200090331     C                   LEAVESR
050300090331     C                   ENDIF
050400090331     C                   ELSE
050500090331     C     BHBCHNO       READPE    BCHDTLR
050600090331     C                   IF        %EOF(BCHDTLP)
050700090331     C                   LEAVESR
050800090331     C                   ENDIF
050900090331     C                   ENDIF
051000090331    ***
051100090331     C                   MOVE      *ON           *IN25
051200090331     C                   EVAL      WSOPC = ' '
051300090331     C                   MOVEL(P)  BDCGRP        ADCGRP
051400090331     C                   EVAL      ADPDTY = BDPDTY
051500090331     C                   EVAL      WSPMTE = BDPMTE
051600090331     C                   EVAL      ADBENRC = BDBENRC
051700090331     C                   EVAL      ADBENRW = BDBENRW
051800090331     C                   EVAL      ADPREM = BDPREM
051900090331     C                   EVAL      ADCOMM = BDCOMM
052000090331     C                   EVAL      ADWHSL = BDWHSL
052100090331     C                   EVAL      DTLDS = @DTL
052200090331     C                   EVAL      ADCAMT = BDCAMT
052300090331     C*
052400090331     C                   ADD       1             #CNTREC
052500090331     C                   ADD       1             RRT
052600090331     C*
052700090331     C                   IF        @1STLOOP = '0'
052800090331     C                   Z-ADD     RRT           WSPAG
052900090331     C                   MOVE      '1'           @1STLOOP
053000090331     C                   ENDIF
053100090331     C*
053200090331     C                   WRITE     GASSFL
053300090331    ***
053400090331     C                   ENDSR
053500090331   S***S
053600040826     C     $STP03        BEGSR
053700050629    ***
053800050629     C                   EXSR      $PREPCTL
053900040826    ***
054000040826     C                   EVAL      EMSG = @EMSG
054100050502     C                   EVAL      LOOP_ADD = NO
054200240507     C*****              WRITE     GASREC
054201240507       if emsg > ' ';
054202240509         exfmt msgWindow;
054203240507       endif;
054300040826     C                   EXFMT     GASCTL
054400040826     C                   EVAL      @EMSG = *BLANKS
054500050629     c                   eval      *in80 = *off
054600050629    ***
054700240507     C                   IF        *in01 = '1'
054800050629     C                   IF        SORT_BY = 'KEY'
054900050629     C                   EVAL      SORT_BY = 'RRN'
055000050629     C                   ELSE
055100050629     C                   EVAL      SORT_BY = 'KEY'
055200050629     C                   ENDIF
055300050629     c                   eval      key@cgrp = *blanks
055400050629     C                   EXSR      $CLRSFL
055500050629     C                   EXSR      $BLDSFL
055600050629     C                   LEAVESR
055700050629     C                   ENDIF
055800040826    ***
055900240507     C                   IF        *in03 = '1'
056000090202      *
056100090202     C                   IF        #OSEQ < #LSEQ
056200090202     C     BHBCHNO       CHAIN     BCHHDRR
056300090202     C                   IF        %FOUND(BCHHDRP)
056400090202     C                   EVAL      RNLSEQ = #LSEQ
056500090202     C                   UPDATE    BCHHDRR
056600090202     C                   EVAL      #OSEQ = #LSEQ
056700090202     C                   EVAL      @STEP = 'LEAVE'
056800090202     C                   EVAL      @EMSG = *BLANKS
056900090202     C                   ELSE
057000090202     C                   EVAL      @EMSG = 'BATCH HEADER CANNOT UPDAT' +
057100090202     C                             'E TO SEQ#: ' +
057200090202     C                             %TRIM(%EDITC(#LSEQ:'Z')) +
057300090202     C                             ' TRY AGAIN LATER.'
057400240507     C****               EVAL      FKEY = *in23
057500090202     C                   ENDIF
057600090202     C                   LEAVESR
057700090202     C                   ENDIF
057800040826     C                   EVAL      @STEP = 'LEAVE'
057900041018     C                   EVAL      @EMSG = *BLANKS
058000040826     C                   LEAVESR
058100040826     C                   ENDIF
058200090331    ***
058300240507     C                   IF        *in05 = '1'
058400090331     C                   EXSR      $CLRSFLR
058500090331     C                   EXSR      $BLDSFLR
058600090331     C                   LEAVESR
058700090331     C                   ENDIF
058800090203    ***
058900240507     C                   IF        *in11 = '1'
059000090203     c                   IF        *in76 = *on
059100090203     c                   eval      *in76 = *OFF
059200090203     C                   ELSE
059300090203     c                   eval      *in76 = *on
059400090203     C                   ENDIF
059500090203     C                   LEAVESR
059600090203     C                   ENDIF
059700050629    ***
059800240507     C                   IF        *in10 = '1'
059900050629     c                   eval      *in80 = *on
060000050629     C                   LEAVESR
060100050629     C                   ENDIF
060200040826    ***
060300050629     C                   IF        wspsn1 <> *blanks
060400050629     c                   exsr      $f10
060500050629     c                   eval      wspsn1 = *blanks
060600040826     C                   LEAVESR
060700040826     C                   ENDIF
060800040830    ***
060900040830     C                   EVAL      ADD_MODE = NO
061000040830     C                   EVAL      CHG_MODE = NO
061100040830     C                   EVAL      DSP_MODE = NO
061200040830     C                   EVAL      DLT_MODE = NO
061300040826    ***
061400240507     C                   IF        *in06 = '1'
061500040830     C                   EVAL      LOOP_ADD = NO
061600040830     C                   EVAL      ADD_MODE = YES
061700040826     C                   EXSR      $F6
061800050502     C                   EVAL      @EMSG = *BLANKS
061900040826     C                   LEAVESR
062000040826     C                   ENDIF
062100040826    ***
062200240507     C                   IF        *in08 = '1'
062300040830     C                   EVAL      LOOP_ADD = YES
062400040830     C                   EVAL      ADD_MODE = YES
062500040830     C                   EXSR      $F6
062600050502     C                   EVAL      @EMSG = *BLANKS
062700040830     C                   LEAVESR
062800040826     C                   ENDIF
062900040826    ***
063000040830     C                   EXSR      $CHKSELC
063100050629    ***
063200050629     C                   ENDSR
063300050629   S***S
063400050629     C     $F10          begsr
063500050629    ***
063600050629     c                   eval      key@cgrp = *blanks
063700090406     c                   EVAL      sort_by = 'KEY'
063800090313     C                   EVAL      KEY@CGR2 = WSPSN1
063900050629     C                   EXSR      $CLRSFL
064000050629     C                   EXSR      $BLDSFL
065600040826    ***
065700040826     C                   ENDSR
065800040826   S***S
065900050629     C     $PREPCTL      BEGSR
066000050629    ***
066100050629     C                   MOVE      BHBCHNO       LB@BCHNO
066200050629     C                   OUT       BCH@LDA
066300050629     C                   CALL      'ADDUPBCH'
066400050629     C                   IN        BCH@LDA
066500050629    ***
066600050629     C                   Z-ADD     LB@CPREM      WSCPREM
066700050629     C                   Z-ADD     LB@CCOMM      WSCCOMM
066800050629     C                   Z-ADD     LB@CWFEE      WSCWFEE
066900090202     C                   Z-ADD     LB@CBENRC     WSCBENRC
067000090202     C                   Z-ADD     LB@CBENRW     WSCBENRW
067100050629     C                   Z-ADD     LB@CCAMT      WSCCAMT
067200050629    ***
067300050629     C                   MOVEA     '000000'      *IN(70)
067400050629    ***
067500050629     C                   IF        WSCPREM < BHCPREM
067600050629     C                   EVAL      *IN70 = *ON
067700050629     C                   ENDIF
067800050629    ***
067900050629     C                   IF        WSCCOMM < BHCCOMM
068000050629     C                   EVAL      *IN71 = *ON
068100050629     C                   ENDIF
068200050629    ***
068300050629     C                   IF        WSCWFEE < BHCWFEE
068400050629     C                   EVAL      *IN72 = *ON
068500050629     C                   ENDIF
068600050629    ***
068700090202     C                   IF        WSCBENRC < BHCBENRC
068800050629     C                   EVAL      *IN73 = *ON
068900050629     C                   ENDIF
069000050629    ***
069100090202     C                   IF        BHCAID = 'NCA' OR BHCAID = 'CFW'
069200090202     C                   IF        WSCBENRW < BHCBENRW
069300090202     C                   EVAL      *IN75 = *ON
069400090202     C                   ENDIF
069500090202     C                   ELSE
069600050629     C                   IF        WSCCAMT < BHCCAMT
069700050629     C                   EVAL      *IN74 = *ON
069800090202     C                   ENDIF
069900050629     C                   ENDIF
070000050629    ***
070100050629     C                   Endsr                                                  END DSPPNL
070200050629   S***S
070300040826     C     $F6           BEGSR
070400040826    ***
070500040830     C                   EXSR      $COMN_CLR
070600240507     C                   DOU       *in12 = '1'
070700040830     C                   EXSR      $DTL_SCRN
070800040830     C                   ENDDO
070900041018    ***
071000041018     C                   EVAL      KEY@CGRP = '0'
071100041209     C                   EXSR      $COMN_CLR
071200040830    ***
071300040830     C                   ENDSR
071400040830   S***S
071500040830     C     $COMN_CLR     BEGSR
071600040830    ***
071700040830     C                   EVAL      I_PMTE = D'0001-01-01'
071800090202     C                   EVAL      I_COED = D'0001-01-01'
071900040830     C                   EVAL      I_CPYDT = BHPMTR
072000040830     C                   MOVEA     '00000001000' *IN(29)
072100050502     C                   MOVEA     '1000'        *IN(50)
072200041008     C                   MOVE      *OFF          *IN40
072300040830     C                   CLEAR                   BCHDTLR
072400040830     C                   EVAL      BDBCHNO = BHBCHNO
072500050502     C                   EVAL      O_NAME = *BLANKS
072600040830     C                   EVAL      O_PNAME = *BLANKS
072700040830     C                   EVAL      O_PRID  = *BLANKS
072800040830     C                   EVAL      O_CPRPM = 0
072900040830     C                   EVAL      O_PCPM  = 0
073000040830     C                   EVAL      O_WPCPM = 0
073100040830     C                   EVAL      O_WCMPC = 0
073200041209     C                   EVAL      SC_AFEE = 0.00
073300041008     C                   MOVE      *BLANKS       O_NAME
073400040830     C                   Z-ADD     1             #SC               1 0
073500040826    ***
073600090202     C                   IF        O_CAID = 'NCA ' OR
073700041008     C                             O_CAID = 'CFW '
073800041008     C                   EVAL      *IN33 = *ON
073900041008     C                   ELSE
074000041008     C                   EVAL      *IN33 = *OFF
074100041008     C                   ENDIF
074200041008    ***
074300050504     C                   IF        BHCAID = 'KHC '
074400050502     C                   EVAL      *IN41 = *ON
074500050502     C                   ELSE
074600050502     C                   EVAL      *IN41 = *OFF
074700050502     C                   ENDIF
074800050502    ***
074900050502     C                   IF        LOOP_ADD = YES
075000050502     C                   EVAL      *IN42 = *ON
075100050502     C                   ELSE
075200050502     C                   EVAL      *IN42 = *OFF
075300050502     C                   ENDIF
075400050502    ***
075500040826     C                   ENDSR
075600040826   S***S
075700040830     C     $DTL_SCRN     BEGSR
075800040830    ***
075900040827     C                   EVAL      EMSG = @EMSG
076000040827     C                   EXFMT     DTLSCRN
076100040827     C                   EVAL      @EMSG = *BLANKS
076200041018     C                   MOVEA     '0000'        *IN(50)
076300050502    ***
076400240507     C                   IF        *in02 = '1' AND *IN42 = *ON
076500050502     C                   EXSR      $RCRSV
076600050502     C                   LEAVESR
076700050502     C                   ENDIF
076800040830    ***
076900240507     C                   IF        *in04 = '1' AND *IN36 = *ON
077000040830     C                   EXSR      $F4_DTL
077100040830     C                   LEAVESR
077200040830     C                   ENDIF
077300040830    ***
077400240507     C                   IF        *in12 = '1' AND *IN35 = *ON
077500041008     C                   CLEAR                   FKEY
077600041008     C                   MOVEA     '01'          *IN(35)
077700041008     C                   LEAVESR
077800041008     C                   ENDIF
077900041008    ***
078000240507     C                   IF        DSP_MODE = NO AND *in10 = '1'
078100040830     C                   EXSR      $UPDATES
078200041008     C                   IF        LOOP_ADD = YES
078300050502     C                   EXSR      $F8_RCRSV
078400040830     C                   LEAVESR
078500040830     C                   ENDIF
078600050502     C                   ENDIF
078700040830    ***
078800041008     C                   IF        *IN35 = *OFF
078900040830     C                   EXSR      $VALIDATE
079000040830     C                   ENDIF
079100050502    ***
079200050502     C                   ENDSR
079300050502   S***S
079400050502     C     $F8_RCRSV     BEGSR
079500050502    ***
079600050502     C                   EVAL      #SC = 1
079700050502     C                   MOVEA     '00000001000' *IN(29)
079800050502     C                   MOVEA     '1000'        *IN(50)
079900050502     C                   EVAL      BDBCHNO = BHBCHNO
080000050502     C                   EVAL      SC_AFEE = 0.00
080100240507     C****               EVAL      FKEY = *in24
080200050502    ***
080300050502     C                   IF        FPT <> 'X'
080400050502     C                   EVAL      BDPDTY = *BLANKS
080500050502     C                   EVAL      O_PNAME = *BLANKS
080600050502     C                   EVAL      O_PRID  = *BLANKS
080700050502     C                   EVAL      O_CPRPM = 0
080800050502     C                   EVAL      O_PCPM  = 0
080900050502     C                   EVAL      O_WPCPM = 0
081000050502     C                   EVAL      O_WCMPC = 0
081100050502     C                   ENDIF
081200050502    ***
081300050502     C                   IF        FCG <> 'X'
081400050502     C                   EVAL      BDCGRP = *BLANKS
081500050502     C                   EVAL      O_NAME = *BLANKS
081600050502     C                   ENDIF
081700050502    ***
081800050502     C                   IF        FAM <> 'X'
082000050502     C                   EVAL      BDCAMT = 0
082100050502     C                   EVAL      BDPREM = 0
082200050502     C                   EVAL      BDCOMM = 0
082300050502     C                   EVAL      BDWHSL = 0
082400050502     C                   ENDIF
082500050623    ***
082600050623     C                   IF        FNC <> 'X'
082700090202     C                   EVAL      BDBENRC = 0
082800090202     C                   EVAL      BDBENRW = 0
082900090202     C                   EVAL      BDCCON  = 0
083000090202     C                   EVAL      BDACON  = 0
083100050623     C                   ENDIF
083200090202    ***
083300090202     C                   IF        FPR <> 'X'
083400090202     C                   EVAL      BDPPREM = 0
083500090202     C                   ENDIF
083600050502    ***
083700050502     C                   IF        FED <> 'X'
083800050502     C                   EVAL      I_PMTE = D'0001-01-01'
083900050502     C                   EVAL      BDPMTE = I_PMTE
084000050502     C                   ENDIF
084100050502    ***
084200050502     C                   IF        O_CAID = 'NCA ' OR O_CAID = 'NAS ' OR
084300050502     C                             O_CAID = 'CFW '
084400050502     C                   EVAL      *IN33 = *ON
084500050502     C                   ELSE
084600050502     C                   EVAL      *IN33 = *OFF
084700050502     C                   ENDIF
084800050502    ***
084900050504     C                   IF        BHCAID = 'KHC '
085000050502     C                   EVAL      *IN41 = *ON
085100050502     C                   ELSE
085200050502     C                   EVAL      *IN41 = *OFF
085300050502     C                   ENDIF
085400050502    ***
085500050502     C                   ENDSR
085600050502   S***S
085700050502     C     $RCRSV        BEGSR
085800050502    ***
085900050502     C                   EVAL      XIT_RCR = NO
086000050502    ***
086100050502     C                   DOU       XIT_RCR = YES
086200050502    * *
086300050502     C                   EXFMT     RCRSV
086400050502    * *
086500240507     C                   IF        *in12 = '1'
086600050502     C                   EVAL      XIT_RCR = YES
086700050502     C                   ITER
086800050502     C                   ENDIF
086900050502    * *
087000240507     C                   IF        *in05 = '1'
087100050502     C                   EVAL      FCG = 'X'
087200050502     C                   EVAL      FPT = 'X'
087300050502     C                   EVAL      FED = 'X'
087400050502     C                   EVAL      FAM = 'X'
087500050623     C                   EVAL      FNC = 'X'
087600090202     C                   EVAL      FPR = 'X'
087700050502     C                   ITER
087800050502     C                   ENDIF
087900050502    * *
088000050502     C                   EVAL      XIT_RCR = YES
088100050502    * *
088200050502     C                   ENDDO
088300040830    ***
088400040830     C                   ENDSR
088500040830   S***S
088600040830     C     $F4_DTL       BEGSR
088700040830    ***
088800041008     C                   IF        WDFLD = 'BDCGRP '
088900041008    * *
089000040830    C                   MOVEL(P)  O_CAID        @@20                           RETURN CODE
089100040830     C                   CALL      'SLCGRP'
089200040830    C                   Parm                    @@20             20            PROGRAM REQUEST
089300040830    * *
089400040830     C                   IF        @@20 <> *BLANKS
089500040830     C                   EVAL      BDCGRP = @@20
089600041018     C                   MOVEA     '0100'        *IN(50)
089700050502     C                   EXSR      $V1
089800040830     C                   ENDIF
089900040830    * *
090000041008     C                   LEAVESR
090100041008     C                   ENDIF
090200040830    ***
090300041008     C                   IF        WDFLD = 'BDPDTY '
090400040830    * *
090500041018    C                   MOVEL(P)  ADACCT        WUPGM                          RETURN CODE
090600070926    C                   MOVEL(P)  O_CAID        apcaid                         RETURN CODE
090700070926     c                   move      *blanks       wortn
090800041018     C                   CALL      'SLCACP2'
090900040830    C                   Parm                    WIRQS             8            PROGRAM REQUEST
091000040830    C                   Parm                    WORTN             8            RETURN CODE
091100040830    C                   Parm                    WUPGM            10            LAST PGM NAME
091200041018    C                   Parm                    WUACPP                         RECORD DS
091300040830    * *
091400040830     C                   IF        WORTN <> 'CANCEL'
091500041018     C                   EVAL      BDPDTY = APPDTY
091600041018     C                   MOVEA     '0010'        *IN(50)
091700100913     C                   EXSR      $V2PRMPT
091800040830     C                   ENDIF
091900040830    * *
092000041008     C                   LEAVESR
092100041008     C                   ENDIF
092200040830    ***
092300040830     C                   ENDSR
092400040830   S***S
092500040830     C     $VALIDATE     BEGSR
092600040830    ***
092700041008     C                   MOVEA     '01'          *IN(35)
092800041008    ***
092900040830     C                   EVAL      VALID_DTA = NO
093000041008     C                   EXSR      $V1
093100041008     C                   IF        VALID_DTA = NO
093200041008     C                   LEAVESR
093300041008     C                   ENDIF
093400041018     C                   MOVEA     '0100'        *IN(50)
093500041008    ***
093600041008     C                   EVAL      VALID_DTA = NO
093700041008     C                   EXSR      $V2
093800041008     C                   IF        VALID_DTA = NO
093900041008     C                   LEAVESR
094000041008     C                   ENDIF
094100041018     C                   MOVEA     '0010'        *IN(50)
094200041008    ***
094300041008     C                   EVAL      VALID_DTA = NO
094400041008     C                   EXSR      $V3
094500041008     C                   IF        VALID_DTA = NO
094600041008     C                   LEAVESR
094700041008     C                   ENDIF
094800041018     C                   MOVEA     '0001'        *IN(50)
094900041008    ***
095000041008     C                   EVAL      VALID_DTA = NO
095100041008     C                   EXSR      $V4
095200041008     C                   IF        VALID_DTA = NO
095300041008     C                   LEAVESR
095400041008     C                   ENDIF
095500041008    ***
095600050502     C                   IF        LOOP_ADD = NO
095700041008     C                   MOVEA     '10'          *IN(35)
095800050502     C                   ENDIF
095900040830    ***
096000040830     C                   ENDSR
096100040830   S***S
096200040830     C     $V1           BEGSR
096300040830    ***
096400040830     C                   IF        BDCGRP = *BLANKS
096500040830     C                   EVAL      @EMSG = 'ENTER A CARRIER GROUP NUMBER'
096600040830     C                   LEAVESR
096700040830     C                   ENDIF
096800040830    ***
096900040830     C                   EVAL      O_NAME = '**WARNING-ACCOUNT UNKNOWN'
097000040830    * *
097001240506       chain (o_caid : bdcgrp) accprdr;
097200040830     C                   IF        %FOUND(ACCPRDL2)
097300040830     C     APACCT        CHAIN     ACCMSTR
097400040830     C                   IF         %FOUND(ACCMSTP)
097500040830     C                   EVAL      O_NAME = ADNAME
097600090202     C                   IF        ADMBF <> 'M' AND ADMBF <> 'N'
097700090202     C                   EVAL      *IN37 = *ON
097800090202     C                   ELSE
097900090202     C                   EVAL      *IN37 = *OFF
098000090202     C                   ENDIF
098100040830     C                   ENDIF
098200040830     C                   ENDIF
098300040830    ***
098400040830     C                   EVAL      VALID_DTA = YES
098500040830    ***
098600040826     C                   ENDSR
098700040826   S***S
098800040830     C     $V2           BEGSR
098900040830    ***
099000040830     C                   IF        BDPDTY = *BLANKS
099100040830     C                   EVAL      @EMSG = 'ENTER A PRODUCT TYPE'
099200040830     C                   LEAVESR
099300040830     C                   ENDIF
099400040830    ***
099500100914     C                   IF        KEY@PDTY <> BDPDTY
099501240506       chain (apcaid : appdty : apprid) prdmstr;
099700100913     C                   IF        %FOUND(PRDMSTL1)
099800040830     C                   EVAL      O_PRID = PMPRID
099900040830     C                   EVAL      O_PNAME = PMNAME
100000040930     C                   ELSE
100100040930     C                   EVAL      O_PRID = '*ERROR P/U'
100200040930     C                   EVAL      O_PNAME = '**ERROR-PRODUCT UNKNOWN'
100300040930     C                   LEAVESR
100400100914     C                   ENDIF
100500040830     C                   ENDIF
100600040830    ***
100700040830     C                   EVAL      VALID_DTA = YES
100800040830    ***
100900100914     C                   EVAL      KEY@CAID = O_CAID
101000100914     C                   IF        KEY@ACCT = *BLANKS OR
101100100914     C                             KEY@PRID = *BLANKS OR
101200100914     C                             KEY@CGRP = *BLANKS
101300040930     C                   EVAL      KEY@ACCT = APACCT
101400040930     C                   EVAL      KEY@PRID = PMPRID
101500100914     C                   EVAL      KEY@PDTY = PMPDTY
101600040930     C                   EVAL      KEY@CGRP = BDCGRP
101700100914     C                   ENDIF
101800040826    ***
101900040826     C                   ENDSR
102000040826   S***S
102100100913     C     $V2PRMPT      BEGSR
102200100913    ***
102300100913     C                   EVAL      BDPDTY = APPDTY
102400100913    ***
102401240506       chain (apcaid : appdty : apprid) prdmstr;
102600100913     C                   IF        %FOUND(PRDMSTL1)
102700100913     C                   EVAL      O_PRID = PMPRID
102800100913     C                   EVAL      O_PNAME = PMNAME
102900100913     C                   ELSE
103000100913     C                   EVAL      O_PRID = '*ERROR P/U'
103100100913     C                   EVAL      O_PNAME = '**ERROR-PRODUCT UNKNOWN'
103200100913     C                   LEAVESR
103300100913     C                   ENDIF
103400100913    ***
103500100913     C                   EVAL      VALID_DTA = YES
103600100913    ***
103700100913     C                   EVAL      KEY@ACCT = APACCT
103800100913     C                   EVAL      KEY@CAID = APCAID
103900100913     C                   EVAL      KEY@PRID = APPRID
104000100914     C                   EVAL      KEY@PDTY = APPDTY
104100100913     C                   EVAL      KEY@CGRP = APCGRP
104200100913    ***
104300100913     C                   ENDSR
104400100913   S***S
104500040830     C     $V3           BEGSR
104600040826    ***
104700040830     C                   IF        I_PMTE = D'0001-01-01' OR
104800040830     C                             I_PMTE = D'9999-12-31'
104900040830     C                   EVAL      @EMSG = 'ENTER A VALID EFFECTIVE DATE'
105000040830     C                   LEAVESR
105100040830     C                   ENDIF
105200041008    ***
105300041008     C                   EVAL      BDPMTE = I_PMTE
105400090202    ***
105500090202     C                   IF        I_PMTE > ADTRDT OR I_PMTE < ADGEFD
105600090202     C                   EVAL      @EMSG = 'EFF DATE WILL CAUSE ANOMALY'
105700090202     C                   ENDIF
105800040930    ***
105900040930     C                   EXSR      $CHK_ACP4
106000040930    * *
106100040930     C                   IF        VALID_ACP4 = NO
106200040930     C                   LEAVESR
106300040930     C                   ENDIF
106400040826    ***
106500040830     C                   EVAL      BDCPYDT = I_CPYDT
106600040930     C                   EVAL      PRM#EFDT = I_PMTE
106700040930     C                   EVAL      RTN#CMRT = 0
106800040930     C                   EVAL      RTN#WFRT = 0
106900040830    ***
107000040830     C                   EVAL      VALID_DTA = YES
107100040830    ***
107200040830     C                   EVAL      O_PCPM = 0
107300040830     C                   EVAL      O_CPRPM = 0
107400040830     C                   EVAL      O_WCMPC = 0
107500040830     C                   EVAL      O_WPCPM = 0
107600040830    ***
107700041012     C                   EXSR      $GET_PDC
107800041012    ***
107900041012     C                   IF        VALID_DTA = NO
108000041012     C                   LEAVESR
108100041012     C                   ENDIF
108200041012    ***
108300040830     C                   EVAL      O_PCPM = PCPCPM
108400040830     C                   EVAL      O_CPRPM = PCCMPC
108500040930    * *
108600080509     C                   If        ADMBF = 'M' OR ADMBF = 'N'
108700080509     C                   EVAL      O_WCMPC = PCWCMPC
108800080509     C                   EVAL      O_WPCPM = PCWPCPM
108900080509     C                   ELSE
109000080509     C                   EVAL      O_WCMPC = PCMCMPC
109100080509     C                   EVAL      O_WPCPM = PCMPCPM
109200080509     C                   ENDIF
109300040930    ***
109400041012     C                   ENDSR
109500041012   S***S
109600041012     C     $GET_PDC      BEGSR
109700041012    ***
110201240506       setll (key@mksz : key@caid : key@prid) prdcomr;
110400041012     C                   DOU       %EOF(PRDCOML1)
110401240506       reade (key@mksz : key@caid : key@prid) prdcomr;
110600041012     C                   IF        NOT %EOF(PRDCOML1)
110700041012    * *
110800041012     C                   IF        PCEFDT <= BDPMTE AND PCTRDT >= BDPMTE
110900041012     C                   LEAVESR
111000041012     C                   ENDIF
111100041012    * *
111200041012     C                   ENDIF
111300041012     C                   ENDDO
111400041012    ***
111500060518     C                   EVAL      @EMSG = 'PDT COMM HAS NOT BEEN SETUP.'
111600041012     C                   EVAL      VALID_DTA = NO
111700041008    ***
111800040930     C                   ENDSR
111900040930   S***S
112000040930     C     $CHK_ACP4     BEGSR
112100040930    ***
112200040930     C                   EVAL      VALID_ACP4 = NO
112300040930    ***
112301240506       chain (key@caid : key@cgrp : bdpdty) apf4;
112500040930     C                   IF        NOT %FOUND(ACCPRDL4)
112600040930     C                   EVAL      @EMSG = 'ACCT PDT HAS NOT BEEN SETUP.'
112700040930     C                   LEAVESR
112800040930     C                   ENDIF
112900040930    ***
113000041008     C                   EVAL      A4EFDT = D'0001-01-01'
113001240506       setll (key@caid : key@cgrp : bdpdty) apf4;
113200040930     C                   DOU       %EOF(ACCPRDL4)
113201240506       reade (key@caid : key@cgrp : bdpdty) apf4;
113400040930     C                   IF        NOT %EOF(ACCPRDL4) AND
113500040930     C                             (A4EFDT <= BDPMTE AND A4TRDT >= BDPMTE)
113600040930    * *
113700040930     C                   EVAL      KEY@MKSZ = A4MKSZ
113800040930     C                   EVAL      VALID_ACP4 = YES
113900040930     C                   LEAVESR
114000040930    * *
114100040930     C                   ENDIF
114200040930     C                   ENDDO
114300040830    ***
114301240506       setll (key@caid : key@cgrp : bdpdty) apf4;
114302240506       reade (key@caid : key@cgrp : bdpdty) apf4;
114600060518     c                   if        a4efdt > bdpmte
114700060413     C                   EVAL      KEY@MKSZ = A4MKSZ
114800060413     C                   EVAL      VALID_ACP4 = YES
114900060413     C                   LEAVESR
115000060413     C                   ENDIF
115100060413    ***
115101240506       setgt (key@caid : key@cgrp : bdpdty) apf4;
115102240506       readpe (key@caid : key@cgrp : bdpdty) apf4;
115400060413     c                   if        a4trdt <= bdpmte
115500060413     C                   EVAL      KEY@MKSZ = A4MKSZ
115600060413     C                   EVAL      VALID_ACP4 = YES
115700060413     C                   LEAVESR
115800060413     C                   ENDIF
115900060413    ***
116000040826     C                   ENDSR
116100040826   S***S
116200040830     C     $V4           BEGSR
116300050629    ***
116400040830     C                   IF        BDPREM = 0 AND BDCOMM = 0 AND
116500090202     C                             BDBENRC = 0 AND BDWHSL = 0 AND
116600090202     C                             BDBENRW = 0 AND BDCAMT = 0
116700040830     C                   EVAL      @EMSG = 'ENTER AN AMOUNT'
116800040830     C                   LEAVESR
116900040830     C                   ENDIF
117000040930    ***
117100050502     C                   IF        *IN41 = *ON
117200050502    * *
117300041012     C                   IF        BDCAMT <> 0 AND (BDCOMM = 0 AND BDWHSL = 0)
117400050502    * **
117500040930     C                   EXSR      $SPLT_AMT
117600041027     C     BDCOMM        ADD       BDWHSL        ##R               9 2
117700041209     C                   ADD       SC_AFEE       ##R
117800041027     C     BDCAMT        SUB       ##R           ##S               9 2
117900050502    * ***
118000041027     C                   IF        ##S < 0.00
118100041027     C                   MULT      -1            ##S
118200041027     C                   ENDIF
118300050502    * ***
118400041027     C                   IF        ##S > .10
118500050502     C                   EVAL      @EMSG = 'WARNING - CARR AMT NOT' +
118600050502     C                             ' = CM+WF+AF; OVER .10'
118700040930     C                   LEAVESR
118800040930     C                   ENDIF
118900050502    * **
119000040930     C                   ENDIF
119100050629    * *
119200050629     C                   ENDIF
119300040830    ***
119400040830     C                   EVAL      VALID_DTA = YES
119500040830    ***
119600090202     C                   IF        (BHCAID = 'NCA' OR BHCAID = 'CFW' OR
119700090202     C                             PCRULE = 'RULE 001') AND BDPPREM = 0
119800040930     C                   EVAL      BDPPREM = BDPREM
119900090202     C                   ENDIF
120000090313    ***
120100090824     C                   IF        ADD_MODE = YES AND DUPESCHK = 'Y'
120200090313     C                   EXSR      $DUPECHK
120300090313     C                   ENDIF
120400040830    ***
120500040830     C                   SELECT
120600040830     C                   WHEN      ADD_MODE = YES
120700040830     C                   EVAL      *IN35 = *ON
120800040830     C                   EVAL      *IN34 = *OFF
120900040830     C                   WHEN      CHG_MODE = YES
121000040830     C                   EVAL      *IN35 = *ON
121100040830     C                   EVAL      *IN34 = *OFF
121200040830     C                   WHEN      DSP_MODE = YES
121300040830     C                   EVAL      *IN35 = *OFF
121400040830     C                   EVAL      *IN34 = *OFF
121500040830     C                   WHEN      DLT_MODE = YES
121600040830     C                   EVAL      *IN35 = *ON
121700040830     C                   EVAL      *IN34 = *ON
121800040830     C                   ENDSL
121900090313    ***
122000090313     C                   ENDSR
122100090313   S***S
122200090313     C     $DUPECHK      BEGSR
122201240506
122901240506       setll (bhbchno : key@cgrp : bdpmte : bdpdty) dtldup;
123100090316     C                   DOU       %EOF(BCHDTLL1)
123101240506       reade (bhbchno : key@cgrp : bdpmte : bdpdty) dtldup;
123300090316     C                   IF        NOT %EOF(BCHDTLL1)
123400090316     C                   IF        BDPREM = WQPREM AND
123500090313     C                             BDCOMM = WQCOMM AND
123600090313     C                             BDWHSL = WQWHSL AND
123700090313     C                             BDBENRC = WQBENRC AND
123800090316     C                             BDBENRW = WQBENRW
123900090313     C                   EVAL      @EMSG = 'WARNING - THIS ENTRY M' +
124000090313     C                             'AY BE A DUPE, PLEASE CHECK.'
124100090316     C                   ENDIF
124200090316     C                   ENDIF
124300090316     C                   ENDDO
124400050629    ***
124500050629     C                   ENDSR
124600040930   S***S
124700050629     C     $SPLT_AMT     BEGSR
124800050629    ***
124900041208     C                   EXSR      $GET_RATES
125000040930    ***
125100041208     C                   EXSR      $CLC_RULES
125200041208    ***
125300041208     C                   EXSR      $CLC_AFEE
125400041209    ***
125500041209     C                   IF        RTN#GSW = 'G' AND (RTN#AFTY = 'P'
125600041209     C                             OR RTN#AFTY = 'C')
125700041209     C                   EVAL      BDWHSL = BDWHSL - SC_AFEE
125800041209     C                   ENDIF
125900041208    ***
126000041208     C                   ENDSR
126100041208   S***S
126200041208     C     $GET_RATES    BEGSR
126300041208    ***
126400051229     C                   EVAL      KEY@MKSZ = A4MKSZ
126500051229     C                   EVAL      KEY@CAID = A4CAID
126600051229     C                   EVAL      KEY@PRID = A4PRID
126700051229     C                   EVAL      KEY@ACCT = A4ACCT
126800051229     C                   EVAL      KEY@CGRP = A4CGRP
126900041208     C                   MOVE      I_PMTE        PRM#EFDT
127000041208     C                   EVAL      RTN#CMRT = 0.00
127100041208     C                   EVAL      RTN#WFRT = 0.00
127200041208     C                   EVAL      RTN#AFTY = *BLANKS
127300041208     C                   EVAL      RTN#AFRT = 0.00
127400041209     C                   EVAL      @97 = PARMS@IO
127500041208     C                   CALL      'GAC103'
127600041209     C                   PARM                    @97              97
127700041209     C                   EVAL      PARMS@IO = @97
127800041208    ***
127900041208     C                   ENDSR
128000041208   S***S
128100041208     C     $CLC_RULES    BEGSR
128200041208    ***
128300041208     C                   IF        PCRULE = 'RULE 001'
128400041208    * *
128500041208     C                   EVAL      X@CALC = BDPREM * (RTN#CMRT * .01)
128600041208     C                   EVAL      X@C = X@CALC + .005
128700041208     C                   Z-ADD     X@C           BDCOMM
128800041208    * *
128900041208     C                   EVAL      X@CALC = BDPREM * (RTN#WFRT * .01)
129000041208     C                   EVAL      X@C = X@CALC + .005
129100041208     C                   Z-ADD     X@C           BDWHSL
129200041208    * *
129300041208     C                   LEAVESR
129400041208     C                   ENDIF
129500041208    ***
129600041208     C                   IF        PCRULE = 'RULE 002'
129700041208    * *
129800090202     C                   EVAL      X@CALC = BDBENRC * RTN#CMRT
129900041208     C                   EVAL      X@C = X@CALC + .005
130000041208     C                   Z-ADD     X@C           BDCOMM
130100041208    * *
130200090202     C                   EVAL      X@CALC = BDBENRW * RTN#WFRT
130300041208     C                   EVAL      X@C = X@CALC + .005
130400041208     C                   Z-ADD     X@C           BDWHSL
130500041208    * *
130600041208     C                   LEAVESR
130700041208     C                   ENDIF
130800041208    ***
130900041208     C                   IF        PCRULE = 'RULE 003'
131000041208    * *
131100041208     C                   EVAL      X@CALC = BDPREM * (RTN#CMRT * .01)
131200041208     C                   EVAL      X@C = X@CALC + .005
131300041208     C                   Z-ADD     X@C           BDCOMM
131400041208    * *
131500090202     C                   EVAL      X@CALC = BDBENRW * RTN#WFRT
131600041208     C                   EVAL      X@C = X@CALC + .005
131700041208     C                   Z-ADD     X@C           BDWHSL
131800041208    * *
131900041208     C                   LEAVESR
132000041208     C                   ENDIF
132100041208    ***
132200041208     C                   IF        PCRULE = 'RULE 004'
132300041208    * *
132400041208     C                   EVAL      BDCOMM = BDCAMT
132500041208    * *
132600041208     C                   EVAL      BDWHSL = 0.00
132700041208    * *
132800041208     C                   LEAVESR
132900041208     C                   ENDIF
133000041208    ***
133100041208     C                   IF        PCRULE = 'RULE 005'
133200041208    * *
133300090202     C                   EVAL      X@CALC = BDBENRC * RTN#CMRT
133400041208     C                   EVAL      X@C = X@CALC + .005
133500041208     C                   Z-ADD     X@C           BDCOMM
133600041208    * *
133700041208     C                   EVAL      BDWHSL = 0.00
133800041208    * *
133900041208     C                   LEAVESR
134000041208     C                   ENDIF
134100041208    ***
134200041208     C                   IF        PCRULE = 'RULE 006'
134300041208    * *
134400041208     C                   EVAL      X@CALC = BDPREM * (RTN#CMRT * .01)
134500041208     C                   EVAL      X@C = X@CALC + .005
134600041208     C                   Z-ADD     X@C           BDCOMM
134700041208    * *
134800041208     C                   EVAL      BDWHSL = 0.00
134900041208    * *
135000041208     C                   LEAVESR
135100041208     C                   ENDIF
135200041208    ***
135300041208     C                   IF        PCRULE = 'RULE 999'
135400041208    * *
135500041208     C                   EVAL      BDCOMM = 0.00
135600041208     C                   EVAL      BDWHSL = 0.00
135700041208     C                   EVAL      @EMSG = 'AMT SPLIT NOT ALLOWED FOR RULE 999'
135800041208    * *
135900041208     C                   LEAVESR
136000041208     C                   ENDIF
136100041208    ***
136200041208     C                   ENDSR
136300041208   S***S
136400041208     C     $CLC_AFEE     BEGSR
136500041208    ***
136600041208     C                   SELECT
136700041208     C                   WHEN      RTN#AFTY = 'P'
136800041208     C                   EVAL      X@CALC = BDPREM * (RTN#AFRT * .01)
136900041208     C                   EVAL      X@C = X@CALC + .005
137000041209     C                   Z-ADD     X@C           SC_AFEE
137100041209     C                   WHEN      RTN#AFTY = 'C'
137200041209     C                   EVAL      X@CALC = BDCOMM * (RTN#AFRT * .01)
137300041209     C                   EVAL      X@C = X@CALC + .005
137400041209     C                   Z-ADD     X@C           SC_AFEE
137500041209     C                   WHEN      RTN#AFTY = 'F'
137600041209     C                   EVAL      X@CALC = RTN#AFRT
137700041209     C                   EVAL      X@C = X@CALC
137800041209     C                   Z-ADD     X@C           SC_AFEE
137900041209     C                   ENDSL
138000040930    ***
138100040830     C                   ENDSR
138200040830   S***S
138300040830     C     $UPDATES      BEGSR
138400040830    ***
138500240507     C                   EVAL      *in12 = '1'
138600041008    ***
138700040830     C                   IF        ADD_MODE = YES
138800040830     C                   EVAL      BDMANL = 'Y'
138900040830    * *
139000090202     C                   ADD       1             #LSEQ
139100090202     C                   EVAL      BDSEQNO = #LSEQ
139200040830     C                   WRITE     BCHDTLR
139300090406     C                   EVAL      @EMSG = 'RECORD ADDED.'
139400090406     C                   CALL      'GAC104'
139500100914     C                   EVAL      KEY@ACCT = *BLANKS
139600100914     C                   EVAL      KEY@PDTY = *BLANKS
139700100914     C                   EVAL      KEY@PRID = *BLANKS
139800100914     C                   EVAL      KEY@CGRP = *BLANKS
139900040830     C                   ENDIF
140000040830    ***
140100040830     C                   IF        CHG_MODE = YES
140200040830     C                   UPDATE    BCHDTLR
140300040830     C                   ENDIF
140400040830    ***
140500040830     C                   IF        DSP_MODE = YES
140600040830     C* DO NOTHING
140700040830     C                   ENDIF
140800040830    ***
140900040830     C                   IF        DLT_MODE = YES
141000240506       delete (bhbchno : bdseqno) BCHDTLR;
141100040830     C                   ENDIF
141200040830    ***
141300040830     C                   EVAL      #SC = 0
141400040830    ***
141500040830     C                   ENDSR
141600040830   S***S
141700040830     C     $CHKSELC      BEGSR
141800040830    ***
141900040830     C                   IF        #CNTREC = 0
142000040830     C                   LEAVESR
142100040830     C                   ENDIF
142200040830    ***
142300240506    1C                   DOU       %EOF(gar100db)
142400040830     C                   READC     GASSFL
142500240506    2C                   IF        NOT %EOF(gar100db) AND WSOPC <> *BLANKS
142600040830     C*
142700040830     C                   Z-ADD     1             #SC
142800040830     C*
142900040830    3C                   IF        WSOPC = '2'
143000040830     C                   EVAL      CHG_MODE = YES
143100040830     C                   EXSR      $CHANGE
143200040830    3C                   ENDIF
143300040830     C*
143400040830    3C                   IF        WSOPC = '4'
143500040830     C                   EVAL      DLT_MODE = YES
143600040830     C                   EXSR      $DELETE
143700040830    3C                   ENDIF
143800040830     C*
143900040830    3C                   IF        WSOPC = '5'
144000040830     C                   EVAL      DSP_MODE = YES
144100040830     C                   EXSR      $DISPLAY
144200040830    3C                   ENDIF
144300040831     C*
144400040831     C                   EVAL      WSOPC = *BLANKS
144500041008     C                   IF        CHG_MODE = YES
144600090202     C                   MOVEL(P)  BDCGRP        ADCGRP
144700040831     C                   EVAL      ADPDTY = BDPDTY
144800040831     C                   EVAL      WSPMTE = BDPMTE
144900090202     C                   EVAL      ADBENRC = BDBENRC
145000090202     C                   EVAL      ADBENRW = BDBENRW
145100040831     C                   EVAL      ADPREM = BDPREM
145200040831     C                   EVAL      ADCOMM = BDCOMM
145300090202
145400041008     C                   EVAL      ADCAMT = BDCAMT
145500090202     C                   EVAL      DTLDS = @DTL
145600040831     C                   ENDIF
145700040831     C                   UPDATE    GASSFL
145800040830     C*
145900040830    2C                   ENDIF
146000040830    1C                   ENDDO
146100040830    ***
146200040830     C                   ENDSR
146300040830   S***S
146400040830     C     $CHANGE       BEGSR
146500040830    ***
146600040830     C                   EXSR      $RTVREC
146700040830     C                   MOVEA     '00000001000' *IN(29)
146800050502     C                   MOVEA     '000'         *IN(40)
146900040830     C                   EVAL      O_PNAME = *BLANKS
147000040830     C                   EVAL      O_PRID  = *BLANKS
147100040830     C                   EVAL      O_CPRPM = 0
147200040830     C                   EVAL      O_PCPM  = 0
147300040830     C                   EVAL      O_WPCPM = 0
147400040830     C                   EVAL      O_WCMPC = 0
147500040830    ***
147600240507     C                   DOU       *in12 = '1' OR #SC = 0
147700040830     C                   EXSR      $DTL_SCRN
147800040830     C                   ENDDO
147900040830    ***
148000040830     C                   ENDSR
148100040830   S***S
148200040830     C     $RTVREC       BEGSR
148300090202    ***
148400090202     C                   EVAL      @DTL = DTLDS
148500040830    ***
148501240506       chain (bhbchno : bdseqno) BCHDTLR;
148700040830     C                   EVAL      I_PMTE = BDPMTE
148800040830     C                   EVAL      I_CPYDT = BDCPYDT
148900040830    ***
149000040830     C                   ENDSR
149100040830   S***S
149200040830     C     $DELETE       BEGSR
149300040830    ***
149400040830     C                   EXSR      $RTVREC
149500041008     C                   MOVEA     '000011100'   *IN(29)
149600050502     C                   MOVEA     '000'         *IN(40)
149700040830    ***
149800040830     C                   EXSR      $COMN_D_D
149900040830    ***
150000240507     C                   DOU       *in12 = '1'
150100041008    * *
150200041008     C                   EVAL      EMSG = @EMSG
150300041008     C                   EXFMT     DTLSCRN
150400041008     C                   EVAL      @EMSG = *BLANKS
150500041008    * *
150600240507     C                   IF        *in10 = '1'
150700041008     C                   EXSR      $UPDATES
150800041008     C                   EVAL      ADCGRP = '** DELETED **'
150900041008     C                   EVAL      ADPDTY = '** DELETED **'
151000041008     C                   EVAL      WSPMTE = D'0001-01-01'
151100090202     C                   EVAL      ADBENRC = 0
151200090202     C                   EVAL      ADBENRW = 0
151300041008     C                   EVAL      ADPREM = 0
151400041008     C                   EVAL      ADCOMM = 0
151500041008     C                   EVAL      ADWHSL = 0
151600041008     C                   EVAL      ADCAMT = 0
151700090202     C                   CLEAR                   DTLDS
151800041008     C                   LEAVESR
151900041008     C                   ENDIF
152000041008    * *
152100040830     C                   ENDDO
152200040830    ***
152300040830     C                   ENDSR
152400040830   S***S
152500040830     C     $COMN_D_D     BEGSR
152600040830    ***
152700040830     C                   IF        O_CAID = 'NCA ' OR O_CAID = 'NAS ' OR
152800040830     C                             O_CAID = 'CFW '
152900050502     C                   EVAL      *IN33 = *ON
153000040830     C                   ELSE
153100050502     C                   EVAL      *IN33 = *OFF
153200040830     C                   ENDIF
153300050502    ***
153400050504     C                   IF        BHCAID = 'KHC '
153500050502     C                   EVAL      *IN41 = *ON
153600050502     C                   ELSE
153700050502     C                   EVAL      *IN41 = *OFF
153800050502     C                   ENDIF
153900050502    ***
154000040830     C                   EVAL      O_PNAME = *BLANKS
154100040830     C                   EVAL      O_PRID  = *BLANKS
154200040830     C                   EVAL      O_CPRPM = 0
154300040830     C                   EVAL      O_PCPM  = 0
154400040830     C                   EVAL      O_WPCPM = 0
154500040830     C                   EVAL      O_WCMPC = 0
154600040830    ***
154700040830     C                   EXSR      $V1
154800040830     C                   EXSR      $V2
154900040830     C                   EXSR      $V3
155000040830    ***
155100040830     C                   ENDSR
155200040830   S***S
155300040830     C     $DISPLAY      BEGSR
155400040830    ***
155500040830     C                   EXSR      $RTVREC
155600041008     C                   MOVEA     '111110100'   *IN(29)
155700040830    ***
155800040830     C                   EXSR      $COMN_D_D
155900050502     C                   MOVEA     '100'         *IN(40)
156000040830    ***
156100040831     C                   Z-ADD     5             #SC
156200040831    ***
156300040830     C                   EXSR      $DTL_SCRN
156400040830    ***
156500040830     C                   ENDSR
156600040830   S***S
