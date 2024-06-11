000100101209     FFTRD060   CF   E             WORKSTN INFDS(WSDS) SFILE(FTRSFL:RRT)
000200101209     FFRMTRKP   UF   E           K DISK    RENAME(FRMTRKR:FMTUNQ) PREFIX(XX:2)
000300100621     FFRMTRKL   IF   E           K DISK    RENAME(FRMTRKR:FMTNAM)
000400100811     FFRMTRKL2  IF   E           K DISK    RENAME(FRMTRKR:FMTSSN) PREFIX(ZX:2)
000500100621     FFRMTRKL3  IF   E           K DISK    RENAME(FRMTRKR:FMTGRP)
000600100621     FFRMTRKL4  IF   E           K DISK    RENAME(FRMTRKR:FMTTSA)
000700101209     FFTRW020   IF   E           K DISK
000800100715     FACCNAM    IF   E           K DISK    RENAME(ACCMSR:BYNAMF) PREFIX(P)
000900100628     FACCMSTSP  IF   E           K DISK
001000100715     FMEMNAM    IF   E           K DISK    RENAME(MEMBR:MNAMF) PREFIX(I)
001100100708     FMEMBER    IF   E           K DISK
001200100621   X***X
001300101209     D @MODE           S              3A
001400100622     D DS@UNQ        E DS                  EXTNAME(FRMTRKP) PREFIX(XX:2)
001500100811     D DS@LF2        E DS                  EXTNAME(FRMTRKP) PREFIX(ZX:2)
001600100622     D DS@ALL        E DS                  EXTNAME(FRMTRKP)
001700100622     D H@GROUP         S                   LIKE(FTGROUP) INZ
001800100622     D H@TRST          S                   LIKE(FTTRST) INZ
001900100715     D H@TC            S                   LIKE(FTTYPCOD)
002000100623     D KF@CODE         S                   LIKE(FTCLSCOD) INZ
002100100622     D H@SUB#          S                   LIKE(FTSUB#) INZ
002200100622     D H@ACCT          S                   LIKE(FTACCT) INZ
002300100623     D @EMSG           S                   LIKE(EMSG) INZ
002400100623     D @100            S            100A   INZ
002500100623     D EXIT_SFL        S               N   INZ
002600100723     D DUPE_DATA       S               N   INZ
002700100622     D VALID_DTA       S               N   INZ
002800100624     D REPOS_SFL       S               N   INZ
002900100622     D YES             S               N   INZ(*ON)
003000100622     D NO              S               N   INZ(*OFF)
003100100624     D #USA            S               D   DATFMT(*USA)
003200100624     D #ISO            S               D   DATFMT(*ISO)
003300100628     D KF@SSN          S                   LIKE(FTSSN)
003400100621    ***
003500100621     D WSDS            DS
003600100621     D  FKEY                 369    369A
003700100621    ***
003800100621     D  F1             C                   CONST(X'31')
003900100621     D  F2             C                   CONST(X'32')
004000100621     D  F3             C                   CONST(X'33')
004100100621     D  F4             C                   CONST(X'34')
004200100621     D  F5             C                   CONST(X'35')
004300100621     D  F6             C                   CONST(X'36')
004400100621     D  F7             C                   CONST(X'37')
004500100621     D  F8             C                   CONST(X'38')
004600100621     D  F9             C                   CONST(X'39')
004700100621     D  F10            C                   CONST(X'3A')
004800100621     D  F11            C                   CONST(X'3B')
004900100621     D  F12            C                   CONST(X'3C')
005000100621     D  F13            C                   CONST(X'B1')
005100100621     D  F14            C                   CONST(X'B2')
005200100621     D  F15            C                   CONST(X'B3')
005300100621     D  F16            C                   CONST(X'B4')
005400100621     D  F17            C                   CONST(X'B5')
005500100621     D  F18            C                   CONST(X'B6')
005600100621     D  F19            C                   CONST(X'B7')
005700100621     D  F20            C                   CONST(X'B8')
005800100621     D  F21            C                   CONST(X'B9')
005900100621     D  F22            C                   CONST(X'BA')
006000100621     D  F23            C                   CONST(X'BB')
006100100621     D  F24            C                   CONST(X'BC')
006200100621    ***
006300100622     D @TIMESTAMP      DS
006400100622     D  #TSCYMD                1      8S 0
006500100622     D  #TSTIME                9     14S 0
006600100622     D  @TSJOB                15     24
006700100622     D  @TSUSER               25     34
006800100622     D  #TSNBR                35     40S 0
006900100622    * *
007000100622     D @TS40           S             40A
007100100621    ***
007200100621     D @STEP           S              5A
007300100621    ***
007400100621     D #SORTBY         S              1S 0
007500100621     D RRT             S              4S 0
007600100621     D #CNTREC         S              4S 0
007700100621     D @1STLOOP        S              1A
007800100621     D @FLAG           S              1A
007900100621    ***
008000100721     D CONFRM          S               N
008100100621   X***X
008200100628     C     KL#ACM        KLIST
008300100628     C                   KFLD                    FTTRST
008400100628     C                   KFLD                    FTSUB#
008500100628     C                   KFLD                    FTACCT
008600100628    ***
008700100628     C     KL#L3         KLIST
008800100628     C                   KFLD                    PSNGROUP
008900100628    ***
009000100628     C     KL#L4         KLIST
009100100628     C                   KFLD                    PSNTRS
009200100628     C                   KFLD                    PSNSUB#
009300100628     C                   KFLD                    PSNACCT
009400100628    ***
009500100628     C     KL#L2B        KLIST
009600100628     C                   KFLD                    KF@SSN
009700100628    ***
009800100628     C     KL#L2         KLIST
009900100628     C                   KFLD                    PSNSSN
010000100628    ***
010100100628     C     KL#P          KLIST
010200100628     C                   KFLD                    PSNUNIQ
010300100628    ***
010400100628     C     KL#L          KLIST
010500100628     C                   KFLD                    PSNAMEL
010600100628    ***
010700100628   X***X
010800100621    ***
010900100621     C                   DOU       @STEP = 'LEAVE'
011000100621     C     @STEP         CASEQ     'STEP1'       $STEP1
011100100621     C     @STEP         CASEQ     'STEP2'       $STEP2
011200100621     C     @STEP         CASEQ     'STEP3'       $STEP3
011300100621     C     @STEP         CASEQ     'STEP4'       $STEP4
011400100621     C                   ENDCS
011500100621     C                   ENDDO
011600100621    ***
011700100621     C                   MOVE      *ON           *INLR
011800100621   S***S
011900100621     C* ONETIME ROUTINE
012000100621    ***
012100100621     C     *INZSR        BEGSR
012200100624    ***
012300100624     C                   CLEAR                   FTRCTL
012400100624     C                   CLEAR                   FTRSFL
012500100624     C                   CLEAR                   FTRREC
012600100624     C                   CLEAR                   FTRSCR
012700100621    ***
012800100624     C                   SETOFF                                       353637
012900101209     C                   MOVEA     '000'         *IN(31)
013000101209     C                   EVAL      *IN70 = *ON
013100101209     C                   EVAL      #SORTBY = 3
013200100621     C                   EVAL      @STEP = 'STEP1'
013300100621    ***
013400100621     C                   ENDSR
013500100621   S***S
013600100622     C     $STEP1        BEGSR
013700100621    ***
013800100622     C                   MOVEA     '011'         *IN(25)
013900100622     C                   WRITE     FTRCTL
014000100622     C                   MOVEA     '010'         *IN(25)
014100100622     C                   Z-ADD     *ZERO         RRT
014200100622    ***
014300100622     C                   MOVE      *ZEROS        #CNTREC
014400100622     C                   MOVE      '0'           @1STLOOP
014500100622     C                   EVAL      @FLAG = 'L'
014600100622     C                   EVAL      EXIT_SFL = NO
014700100622    ***
014800100622     C                   MOVE      'STEP2'       @STEP
014900100622    ***
015000100622     C                   ENDSR
015100100622   S***S
015200100622     C     $STEP2        BEGSR
015300100621    ***
015400100621     C                   SELECT
015500100621     C                   WHEN      #SORTBY = 1
015600100621     C     KL#L3         SETLL     FMTGRP
015700100624     C                   EVAL      PSNGROUP = *BLANKS
015800100621     C                   WHEN      #SORTBY = 2
015900100621     C     KL#L4         SETLL     FMTTSA
016000100624     C                   MOVE      *ZEROS        PSNTRS
016100100624     C                   MOVE      *ZEROS        PSNSUB#
016200100624     C                   MOVE      *ZEROS        PSNACCT
016300100621     C                   WHEN      #SORTBY = 3
016400100621     C     KL#L2         SETLL     FMTSSN
016500100624     C                   MOVE      *ZEROS        PSNSSN
016600100621     C                   WHEN      #SORTBY = 4
016700100621     C     KL#L          SETLL     FMTNAM
016800100624     C                   MOVE      *BLANKS       PSNAMEL
016900100621     C                   WHEN      #SORTBY = 5
017000100621     C     KL#P          SETLL     FMTUNQ
017100100621     C                   OTHER
017200100621     C                   EVAL      #SORTBY = 1
017300100621     C     KL#L3         SETLL     FMTGRP
017400100624     C                   EVAL      PSNGROUP = *BLANKS
017500100621     C                   ENDSL
017600100621    ***
017700100622     C                   MOVE      'STEP3'       @STEP
017800100622    ***
017900100621     C                   ENDSR
018000100621   S***S
018100100622     C     $STEP3        BEGSR
018200100622    ***
018300100622     C                   IF        EXIT_SFL = YES OR #CNTREC >= 360
018400100622     C                   MOVE      'STEP4'       @STEP
018500100622     C                   LEAVESR
018600100622     C                   ENDIF
018700100621    ***
018800100621     C                   EXSR      $READBY
018900100621    ***
019000100621     C                   IF        EXIT_SFL = YES
019100100621     C                   LEAVESR
019200100621     C                   ENDIF
019300100722    ***
019400100722     C                   IF        *IN70 = *ON
019500100722     C                   IF        FTCLSCOD <> *BLANKS
019600100722     C                   LEAVESR
019700100722     C                   ENDIF
019800100722     C                   ENDIF
019900100621    ***
020000100621     C                   MOVE      *ON           *IN25
020100100621     C                   MOVE      *BLANKS       SEL
020200100702      *
020300100702     C                   IF        FTRPTDTE = D'0001-01-01'
020400100702     C                   MOVE      *ZEROS        SFRPTDTE
020500100702     C                   ELSE
020600100702     C     *USA          MOVE      FTRPTDTE      SFRPTDTE
020700100702     C                   ENDIF
020800100702     C*
020900100702     C                   IF        FTRCVDT  = D'0001-01-01'
021000100702     C                   MOVE      *ZEROS        SFRCVDT
021100100702     C                   ELSE
021200100702     C     *USA          MOVE      FTRCVDT       SFRCVDT
021300100702     C                   ENDIF
021400100702     C*
021500100702     C                   IF        FTCLSDT  = D'0001-01-01'
021600100702     C                   MOVE      *ZEROS        SFCLSDT
021700100702     C                   ELSE
021800100702     C     *USA          MOVE      FTCLSDT       SFCLSDT
021900100702     C                   ENDIF
022000100621     C*
022100100622     C                   MOVE      *BLANKS       @100
022200100622     C                   MOVEL(P)  FTGROUP       SFGROUP
022300100622     C                   EVAL      @100 = %TRIM(FTNAMEL) + ', ' +
022400100622     C                             %TRIM(FTNAMEF) + ' ' + FTNAMEM
022500100624     C                   MOVEL(P)  @100          SFNAMEM
022600100622     C                   EVAL      HUNIQ = FTUNIQUE
022700100621     C*
022800100621     C                   ADD       1             #CNTREC
022900100621     C                   ADD       1             RRT
023000100621     C*
023100100621     C                   IF        @1STLOOP = '0'
023200100621     C                   Z-ADD     RRT           SFLPOS
023300100621     C                   MOVE      '1'           @1STLOOP
023400100621     C                   ENDIF
023500100621     C*
023600100621     C                   WRITE     FTRSFL
023700100621    ***
023800100621     C                   ENDSR
023900100621   S***S
024000100621     C     $READBY       BEGSR
024100100621    ***
024200100621     C                   SELECT
024300100621      *
024400100621     C                   WHEN      #SORTBY = 1
024500100621     C                   READ      FMTGRP
024600100623     C                   IF        %EOF(FRMTRKL3)
024700100621     C                   EVAL      EXIT_SFL = YES
024800100621     C                   LEAVESR
024900100621     C                   ENDIF
025000100621      *
025100100621     C                   WHEN      #SORTBY = 2
025200100621     C                   READ      FMTTSA
025300100623     C                   IF        %EOF(FRMTRKL4)
025400100621     C                   EVAL      EXIT_SFL = YES
025500100621     C                   LEAVESR
025600100621     C                   ENDIF
025700100621      *
025800100621     C                   WHEN      #SORTBY = 3
025900100621     C                   READ      FMTSSN
026000100623     C                   IF        %EOF(FRMTRKL2)
026100100621     C                   EVAL      EXIT_SFL = YES
026200100621     C                   LEAVESR
026300100811     C                   ELSE
026400100811     C                   EVAL      DS@ALL = DS@LF2
026500100621     C                   ENDIF
026600100621      *
026700100621     C                   WHEN      #SORTBY = 4
026800100621     C                   READ      FMTNAM
026900100623     C                   IF        %EOF(FRMTRKL)
027000100621     C                   EVAL      EXIT_SFL = YES
027100100621     C                   LEAVESR
027200100621     C                   ENDIF
027300100621      *
027400100621     C                   WHEN      #SORTBY = 5
027500100621     C                   READ      FMTUNQ
027600100623     C                   IF        %EOF(FRMTRKP)
027700100624     C                   EVAL      EXIT_SFL = YES
027800100621     C                   LEAVESR
027900100624     C                   ELSE
028000100624     C                   EVAL      DS@ALL = DS@UNQ
028100100621     C                   ENDIF
028200100621      *
028300100621     C                   ENDSL
028400100621    ***
028500100621     C                   ENDSR
028600100621   S***S
028700100713     **************************MAIN SFL CTL LOOP PROCESSING ROUTINE
028800100713     ************
028900100622     C     $STEP4        BEGSR
029000100621    ***
029100100621     C                   EVAL      EMSG = @EMSG
029200100621     C                   WRITE     FTRREC
029300100621     C                   EXFMT     FTRCTL
029400100621     C                   EVAL      EMSG = *BLANKS
029500100621     C                   EVAL      @EMSG = *BLANKS
029600100621    ***
029700100706     C                   IF        FKEY = F7
029800100621     C                   EVAL      @STEP = 'LEAVE'
029900100621     C                   LEAVESR
030000100621     C                   ENDIF
030100100621    ***
030200100621     C                   IF        FKEY = F10
030300100622     C                   EXSR      $F10TOG
030400100624     C                   EVAL      FKEY = F24
030500100621     C                   LEAVESR
030600100621     C                   ENDIF
030700100722    ***
030800100722     C                   IF        FKEY = F11
030900100722     C                   IF        *IN70 = *ON
031000100722     C                   EVAL      *IN70 = *OFF
031100100722     C                   ELSE
031200100722     C                   EVAL      *IN70 = *ON
031300100722     C                   ENDIF
031400100722     C                   EVAL      @STEP = 'STEP1'
031500100722     C                   LEAVESR
031600100722     C                   ENDIF
031700100621    ***
031800100624     C                   EXSR      $CHKCTL
031900100624     C                   IF        REPOS_SFL = YES
032000100624     C                   EVAL      @STEP = 'STEP1'
032100100624     C                   LEAVESR
032200100624     C                   ENDIF
032300100624    ***
032400100624     C                   IF        #CNTREC > 0
032500100621     C                   EXSR      $CHKSEL
032600100621     C                   ENDIF
032700100624    ***
032800100624     C                   ENDSR
032900100624   S***S
033000100624     C     $CHKCTL       BEGSR
033100100624    ***
033200100624     C                   EVAL      REPOS_SFL = NO
033300100624    ***
033400100624     C                   SELECT
033500100624     C                   WHEN      #SORTBY = 1 AND
033600100624     C                             PSNGROUP <> *BLANKS
033700100624     C                   EVAL      REPOS_SFL = YES
033800100624     C                   WHEN      #SORTBY = 2 AND
033900100624     C                             PSNTRS <> *ZEROS
034000100624     C                   EVAL      REPOS_SFL = YES
034100100624     C                   WHEN      #SORTBY = 3 AND
034200100624     C                             PSNSSN <> *ZEROS
034300100624     C                   EVAL      REPOS_SFL = YES
034400100624     C                   WHEN      #SORTBY = 4 AND
034500100624     C                             PSNAMEL <> *BLANKS
034600100624     C                   EVAL      REPOS_SFL = YES
034700100624     C                   WHEN      #SORTBY = 5 AND
034800100624     C                             PSNUNIQ <> *BLANKS
034900100624     C                   EVAL      REPOS_SFL = YES
035000100624     C                   ENDSL
035100100623    ***
035200100623     C                   ENDSR
035300100622   S***S
035400100622     C     $F10TOG       BEGSR
035500100622    ***
035600100622     C                   IF        *IN37 = *OFF
035700100622     C                   EVAL      *IN37 = *ON
035800100622     C                   LEAVESR
035900100622     C                   ENDIF
036000100622      *
036100100622     C                   ADD       1             #SORTBY
036200100622     C                   IF        #SORTBY > 5
036300100622     C                   Z-ADD     1             #SORTBY
036400100622     C                   ENDIF
036500100624    ***
036600100624     C                   SELECT
036700100624     C                   WHEN      #SORTBY = 1
036800100624     C                   MOVEA     '110'         *IN(31)
036900100624     C                   WHEN      #SORTBY = 2
037000100624     C                   MOVEA     '100'         *IN(31)
037100100624     C                   WHEN      #SORTBY = 3
037200100624     C                   MOVEA     '000'         *IN(31)
037300100624     C                   WHEN      #SORTBY = 4
037400100624     C                   MOVEA     '010'         *IN(31)
037500100624     C                   WHEN      #SORTBY = 5
037600100624     C                   MOVEA     '001'         *IN(31)
037700100624     C                   ENDSL
037800100623    ***
037900100623     C                   ENDSR
038000100622   S***S
038100100628     C     $DUPECHK      BEGSR
038200100628    ***
038300100723     C                   EVAL      DUPE_DATA = NO
038400100723    ***
038500100628     C                   EVAL      KF@SSN = FTSSN
038600100628     C     KL#L2B        CHAIN     FMTSSN
038700100628     C                   IF        NOT %FOUND(FRMTRKL2)
038800100628     C                   LEAVESR
038900100628     C                   ENDIF
039000100628    ***
039100100628     C     KL#L2B        SETLL     FMTSSN
039200100628     C                   DOU       %EOF(FRMTRKL2)
039300100628     C     KL#L2B        READE     FMTSSN
039400100628     C                   IF        NOT %EOF(FRMTRKL2)
039500100811     C                   IF        ZXCLSDT = D'0001-01-01'
039600100628     C                   EVAL      @EMSG = 'OPEN APP EXISTS, ADD DENIED.'
039700100723     C                   EVAL      DUPE_DATA = YES
039800100723    ***
039900100628     C                   LEAVESR
040000100628     C                   ENDIF
040100100628     C                   ENDIF
040200100628     C                   ENDDO
040300100628    ***
040400100628     C                   ENDSR
040500100628   S***S
040600100623     C     $CHKSEL       BEGSR
040700100623    ***
040800101209    1C                   DOU       %EOF(FTRD060)
040900100624     C                   READC     FTRSFL
041000101209    2C                   IF        NOT %EOF(FTRD060) AND SEL <> *BLANKS
041100100623    ***
041200100708     C                   EVAL      DCLSCODE = *BLANKS
041300100708    ***
041400100713    3C                   IF        SEL = 'D'
041500100702     C                   MOVE      'DSP'         @MODE
041600100623     C                   EXSR      $DSPREC
041700100623     C                   ITER
041800100623    3C                   ENDIF
041900100623    ***
042000100726    3C                   IF        SEL = 'C'
042100100702     C                   MOVE      'CHG'         @MODE
042200100623     C                   EXSR      $MNTREC
042300100623     C                   EVAL      @STEP = 'STEP1'
042400100623     C                   ITER
042500100623    3C                   ENDIF
042600100623    ***
042700100623     C                   ENDIF
042800100623     C                   ENDDO
042900100623    ***
043000100623     C                   ENDSR
043100100622   S***S
043200100623     C     $DSPREC       BEGSR
043300100623    ***
043400100623     C     HUNIQ         CHAIN(N)  FMTUNQ
043500100623     C                   IF        NOT %FOUND(FRMTRKP)
043600100623     C                   LEAVESR
043700100623     C                   ENDIF
043800100623    ***
043900100708     C                   EVAL      DS@ALL = DS@UNQ
044000100708      *
044100100623     C                   MOVEA     '010'         *IN(34)
044200100623     C     *USA          MOVE      FTRPTDTE      SCRPTDTE
044300100623     C     *USA          MOVE      FTRCVDT       SCRCVDT
044400100623     C     *USA          MOVE      FTCLSDT       SCCLSDT
044500100708    * *
044600100713     C                   IF        SCCLSDT = 01010001
044700100713     C                   EVAL      SCCLSDT = 0
044800100713     C                   ENDIF
044900100713     C                   IF        SCRCVDT = 01010001
045000100713     C                   EVAL      SCRCVDT = 0
045100100713     C                   ENDIF
045200100713     C                   IF        SCRPTDTE = 01010001
045300100713     C                   EVAL      SCRPTDTE = 0
045400100713     C                   ENDIF
045500100623    ***
045600100623     C                   IF        FTCLSCOD <> *BLANKS
045700100623     C     FTCLSCOD      CHAIN     FTRW020R
045800100623     C                   IF        %FOUND(FTRW020)
045900100623     C                   EVAL      DCLSCODE = F2DESC
046000100623     C                   ELSE
046100100623     C                   MOVE      *BLANKS       DCLSCODE
046200100623     C                   ENDIF
046300100623     C                   ENDIF
046400100623    ***
046500100706     C                   DOU       FKEY = F1
046600100623     C                   EXFMT     FTRSCR
046700100623    *C                   ENDDO
046800100702    ***
046900100702     C                   EVAL      @STEP = 'STEP1'
047000100623    ***
047100100623     C                   ENDSR
047200100622   S***S
047300100622     C     $MNTREC       BEGSR
047400100622    ***
047500100622     C     HUNIQ         CHAIN     FMTUNQ
047600100622     C                   IF        NOT %FOUND(FRMTRKP)
047700100622     C                   LEAVESR
047800100622     C                   EVAL      *IN36 = *OFF
047900100622     C                   ENDIF
048000100623    ***
048100100623     C                   EXSR      $FMTSCR
048200100622    ***
048300100706     C                   DOU       FKEY = F1
048400100622     C                   EXSR      $SCREEN
048500100622    *C                   ENDDO
048600100622    ***
048700100622     C     HUNIQ         CHAIN(N)  FMTUNQ
048800100715     C                   EVAL      @STEP = 'STEP1'
048900100623    ***
049000100623     C                   ENDSR
049100100623   S***S
049200100623     C     $FMTSCR       BEGSR
049300100623    ***
049400100624     C                   EVAL      DS@ALL = DS@UNQ
049500100624      *
049600100702     C     *USA          MOVE      XXRPTDTE      SCRPTDTE
049700100702     C     *USA          MOVE      XXRCVDT       SCRCVDT
049800100702     C     *USA          MOVE      XXCLSDT       SCCLSDT
049900100623    * *
050000100623     C                   EVAL      *IN35 = *OFF
050100100623    * *
050200100623     C                   EVAL      *IN36 = *OFF
050300100622    ***
050400100622     C                   ENDSR
050500100622   S***S
050600100622     C     $SCREEN       BEGSR
050700100702    ***
050800100702     C                   IF        SCCLSDT = 01010001
050900100702     C                   EVAL      SCCLSDT = 0
051000100702     C                   ENDIF
051100100702     C                   IF        SCRCVDT = 01010001
051200100702     C                   EVAL      SCRCVDT = 0
051300100702     C                   ENDIF
051400100702     C                   IF        SCRPTDTE = 01010001
051500100702     C                   EVAL      SCRPTDTE = 0
051600100702     C                   ENDIF
051700100622    ***
051800100623     C                   EVAL      EMSG = @EMSG
051900100623     C                   EXFMT     FTRSCR
052000100623     C                   EVAL      @EMSG = *BLANKS
052100100702    ***
052200100702     C                   IF        SCCLSDT = 0
052300100702     C                   EVAL      SCCLSDT = 01010001
052400100702     C                   ENDIF
052500100702     C                   IF        SCRCVDT = 0
052600100702     C                   EVAL      SCRCVDT = 01010001
052700100702     C                   ENDIF
052800100702     C                   IF        SCRPTDTE = 0
052900100702     C                   EVAL      SCRPTDTE = 01010001
053000100702     C                   ENDIF
053100101209    ***
053200100713     C                   IF        FKEY = F4
053300100713     C                   CALL      'FTRC021'
053400100713     C                   PARM                    @PRM              3
053500100721     C                   IF        @PRM <> '*LR'
053600100713     C                   EVAL      FTCLSCOD = @PRM
053700100713     C                   IF        SCCLSDT = 0 OR SCCLSDT = 0101001
053800100721     C                   CLEAR                   @TIMESTAMP
053900100721     C                   MOVE      *BLANKS       @TS40
054000100721     C                   CALL      'TIMESTMP'
054100100721     C                   PARM                    @TS40
054200100721     C                   MOVEL     @TS40         @TIMESTAMP
054300100721     C                   EVAL      FTCLSUSR = @TSUSER
054400100721     C                   MOVE      #TSCYMD       FTCLSDT
054500100721     C                   MOVE      #TSTIME       FTCLSTM
054600100713     C                   ENDIF
054700100713     C                   ENDIF
054800100713     C                   ENDIF
054900100719    ***
055000100719     C                   IF        FKEY = F1
055100100719     C     HUNIQ         CHAIN     FMTUNQ
055200100719     C                   LEAVESR
055300100719     C                   ENDIF
055400100713    ***
055500100713     C                   IF        XXCLSCOD = *BLANKS AND
055600100713     C                             FTCLSCOD <> *BLANKS AND
055700100713     C                             XXCLSDT = D'0001-01-01'
055800100713    *C                   CLEAR                   @TIMESTAMP
055900100713    *C                   MOVE      *BLANKS       @TS40
056000100713    *C                   CALL      'TIMESTMP'
056100100713    *C                   PARM                    @TS40
056200100713    *C                   MOVEL     @TS40         @TIMESTAMP
056300100713    *C                   EVAL      FTCLSUSR = @TSUSER
056400100713    *C                   MOVE      #TSCYMD       FTCLSDT
056500100713    *C                   MOVE      #TSTIME       FTCLSTM
056600100713     C                   ENDIF
056700100713    ***
056800101209     C                   EXSR      $VALIDMNT
056900100721     C                   IF        VALID_DTA = YES
057000100721     C                   IF        CONFRM = YES
057100100721     C                   EXSR      $UPDMNT
057200100721     C                   LEAVESR
057300100721     C                   ELSE
057400100721     C                   EVAL      CONFRM = YES
057500100721     C                   ENDIF
057600100721     C                   ELSE
057700100721     C                   EVAL      CONFRM = NO
057800100721     C                   ENDIF
057900100721    ***
058000100721     C                   ENDSR
058100100721   S***S
058200101209     C     $VALIDMNT     BEGSR
058300100721    ***
058400101209     C                   EVAL      VALID_DTA = NO
058500101209    ***
058600101209    *** TYPE CODE VALIDATION
058700101209    ***
058800101209     C                   IF        FTTYPCOD = *BLANKS
058900101209     C                   EVAL      @EMSG = 'TYPE CODE REQUIRED'
059000101209     C                   LEAVESR
059100101209     C                   ENDIF
059200101209    ***
059300101209     C                   IF        FTTYPCOD <> 'N' AND FTTYPCOD <> 'R'
059400101209     C                             AND FTTYPCOD <> 'M'
059500101209     C                             AND FTTYPCOD <> 'B'
059600101209     C                   EVAL      @EMSG = 'TYPE CODE IS INVALID'
059700101209     C                   LEAVESR
059800101209     C                   ENDIF
059900101209    ***
060000101209     C                   EVAL      H@TC = FTTYPCOD
060100101209    ***
060200101209     C                   IF        FTTRST > 0 AND FTSUB# > 0 AND
060300101209     C                             FTACCT > 0 AND
060400101209     C                             FTGROUP = *BLANKS
060500101209     C     KL#ACM        CHAIN     ACCMSR
060600101209     C                   IF        %FOUND(ACCMSTSP)
060700101209     C                   MOVEL(P)  ACNAM1        FTGROUP
060800101209     C                   ENDIF
060900101209     C                   ENDIF
061000101209    ***
061100101209     C                   IF        FTTRST = 0 AND FTSUB# = 0 AND
061200101209     C                             FTACCT = 0 AND
061300101209     C                             FTGROUP <> *BLANKS
061400101209     C     FTGROUP       CHAIN     BYNAMF
061500101209     C                   IF        %FOUND(ACCNAM)
061600101209     C                   EVAL      FTTRST = PACTRST
061700101209     C                   EVAL      FTSUB# = PACSUB#
061800101209     C                   EVAL      FTACCT = PACACCT
061900101209     C                   ENDIF
062000101209     C                   ENDIF
062100101209    ***
062200101209     C                   IF        FTGROUP = *BLANKS AND
062300101209     C                             FTTRST = 0 AND FTSUB# = 0 AND
062400101209     C                             FTACCT = 0
062500101209     C                   EVAL      @EMSG = 'SOME FORM OF GROUP ID IS REQUIRED' +
062600101209     C                             ' FOR ALL APPS.'
062700101209     C                   LEAVESR
062800101209     C                   ENDIF
062900101209    ***
063000101209     C                   IF        FTGROUP = *BLANKS OR
063100101209     C                             (FTTRST = 0 AND FTSUB# = 0 AND
063200101209     C                             FTACCT = 0)
063300101209     C                   EVAL      @EMSG = 'FYI - IT IS RECOMMENDED TO HAVE A' +
063400101209     C                             'LL PARTS OF ACCT INFO.'
063500101209     C                   ENDIF
063600101209    ***
063700101209     C     *LIKE         DEFINE    MBSSNO        ZZSSNO
063800101209     C                   IF        FTSSN <> 0 AND FTNAMEF = *BLANKS AND
063900101209     C                             FTNAMEL = *BLANKS AND
064000101209     C                             FTNAMEM = *BLANKS
064100101209     C                   Z-ADD     FTSSN         ZZSSNO
064200101209     C     ZZSSNO        CHAIN     MEMBR
064300101209     C                   IF        %FOUND(MEMBER)
064400101209     C                   MOVEL(P)  MFNAME        FTNAMEF
064500101209     C                   MOVEL(P)  MLNAME        FTNAMEL
064600101209     C                   MOVEL(P)  MMI           FTNAMEM
064700101209     C                   ENDIF
064800101209     C                   ENDIF
064900101209    ***
065000101209     C                   IF        FTSSN = 0 AND FTNAMEF <> *BLANKS AND
065100101209     C                             FTNAMEL <> *BLANKS
065200101209     C     KL#NAM        KLIST
065300101209     C                   KFLD                    QLNAM            18
065400101209     C                   KFLD                    QFNAM            12
065500101209     C                   KFLD                    QMMI              1
065600101209     C                   MOVEL(P)  FTNAMEL       QLNAM
065700101209     C                   MOVEL(P)  FTNAMEF       QFNAM
065800101209     C                   MOVEL(P)  FTNAMEM       QMMI
065900101209     C     KL#NAM        CHAIN     MNAMF
066000101209     C                   IF        %FOUND(MEMNAM)
066100101209     C                   MOVE      IMBSSNO       FTSSN
066200101209     C                   ENDIF
066300101209     C                   ENDIF
066400101209    ***
066500101209     C                   IF        FTSSN = 0 OR FTNAMEL = *BLANKS OR
066600101209     C                             FTNAMEF = *BLANKS
066700101209     C                   EVAL      @EMSG = 'SSN AND MEMBER NAME ARE REQUIRED.'
066800101209     C                   LEAVESR
066900101209     C                   ENDIF
067000101209    ***
067100101209     C                   IF        SCREPEAT = *BLANKS
067200101209     C                   EVAL      SCREPEAT = 'N'
067300101209     C                   ENDIF
067400101209    ***
067500101209     C                   IF        SCRCVDT = 0
067600101209     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
067700101209     C                   LEAVESR
067800101209     C                   ENDIF
067900101209     C     *USA          TEST(DE)                SCRCVDT
068000101209     C                   IF        %ERROR
068100101209     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
068200101209     C                   LEAVESR
068300101209     C                   ENDIF
068400101209     C                   MOVE      SCRCVDT       #USA
068500101209     C                   MOVE      #USA          #ISO
068600101209     C                   MOVE      #ISO          FTRCVDT
068700101209    ***
068800101209     C                   IF        FTRCVTM = 000000
068900101209     C                   EVAL      @EMSG = 'VALID RECIEVE TIME PLEASE.'
069000101209     C                   LEAVESR
069100101209     C                   ENDIF
069200101209    ***
069300101209     C                   IF        FTRCVUSR = *BLANKS
069400101209     C                   EVAL      @EMSG = 'VALID RECIEVE USER PLEASE.'
069500101209     C                   LEAVESR
069600101209     C                   ENDIF
069700101209    ***
069800101209     C                   IF        SCCLSDT <> 0 OR
069900101209     C                             FTCLSUSR <> *BLANKS OR
070000101209     C                             FTCLSTM <> 000000 OR
070100101209     C                             FTCLSCOD <> *BLANKS
070200101209    ***
070300101209     C                   IF        SCCLSDT = 0
070400101209     C                   EVAL      @EMSG = 'VALID CLOSE DATE PLEASE.'
070500101209     C                   LEAVESR
070600101209     C                   ENDIF
070700101209     C     *USA          TEST(DE)                SCCLSDT
070800101209     C                   IF        %ERROR
070900101209     C                   EVAL      @EMSG = 'VALID CLOSE DATE PLEASE.'
071000101209     C                   LEAVESR
071100101209     C                   ENDIF
071200101209     C                   MOVE      SCCLSDT       #USA
071300101209     C                   MOVE      #USA          #ISO
071400101209     C                   MOVE      #ISO          FTCLSDT
071500101209    ***
071600101209     C                   IF        FTCLSTM = 000000
071700101209     C                   EVAL      @EMSG = 'VALID RECIEVE TIME PLEASE.'
071800101209     C                   LEAVESR
071900101209     C                   ENDIF
072000101209    ***
072100101209     C                   IF        FTCLSUSR = *BLANKS
072200101209     C                   EVAL      @EMSG = 'VALID CLOSE USER PLEASE.'
072300101209     C                   LEAVESR
072400101209     C                   ENDIF
072500101209    ***
072600101209     C                   IF        FTCLSCOD = *BLANKS
072700101209     C                   EVAL      @EMSG = 'VALID CLOSE CODE PLEASE.'
072800101209     C                   LEAVESR
072900101209     C                   ENDIF
073000101209    ***
073100101209     C     FTCLSCOD      CHAIN     FTRW020R
073200101209     C                   IF        NOT %FOUND(FTRW020)
073300101209     C                   EVAL      @EMSG = 'VALID CLOSE CODE PLEASE.'
073400101209     C                   LEAVESR
073500101209     C                   ENDIF
073600101209    ***
073700101209     C                   ENDIF
073800101209    ***
073900101209     C                   IF        SCRPTDTE = 0
074000101209     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
074100101209     C                   LEAVESR
074200101209     C                   ENDIF
074300101209     C     *USA          TEST(DE)                SCRPTDTE
074400101209     C                   IF        %ERROR
074500101209     C                   EVAL      @EMSG = 'VALID REPORT DATE PLEASE.'
074600101209     C                   LEAVESR
074700101209     C                   ENDIF
074800101209     C                   MOVE      SCRPTDTE      #USA
074900101209     C                   MOVE      #USA          #ISO
075000101209     C                   MOVE      #ISO          FTRPTDTE
075100101209    ***
075200101209     C                   EVAL      VALID_DTA = YES
075300101209    ***
075400101209     C                   ENDSR
075500101209   S***S
075600101209     C     $UPDMNT       BEGSR
075700101209    ***
075800100623     C                   EVAL      *IN36 = *ON
075900100702     C                   MOVE      SCRCVDT       #USA
076000100702     C                   MOVE      #USA          #ISO
076100100702     C                   MOVE      #ISO          FTRCVDT
076200101209     C                   MOVE      SCCLSDT       #USA
076300101209     C                   MOVE      #USA          #ISO
076400101209     C                   MOVE      #ISO          FTCLSDT
076500101209     C                   MOVE      SCRPTDTE      #USA
076600101209     C                   MOVE      #USA          #ISO
076700101209     C                   MOVE      #ISO          FTRPTDTE
076800100702     C                   EVAL      DS@UNQ = DS@ALL
076900100702     C                   UPDATE    FMTUNQ
077000100721     C                   EVAL      FKEY = F1
077100100721     C                   EVAL      @EMSG = 'UPDATE COMPLETED.'
077200100623    ***
077300100622     C                   ENDSR
077400100622   S***S
