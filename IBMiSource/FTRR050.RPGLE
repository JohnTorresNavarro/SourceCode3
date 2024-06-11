000100100811     FFTRD050   CF   E             WORKSTN INFDS(WSDS) SFILE(FTRSFL:RRT)
000200100622     FFRMTRKP   UF A E           K DISK    RENAME(FRMTRKR:FMTUNQ) PREFIX(XX:2)
000300100621     FFRMTRKL   IF   E           K DISK    RENAME(FRMTRKR:FMTNAM)
000400100811     FFRMTRKL2  IF   E           K DISK    RENAME(FRMTRKR:FMTSSN) PREFIX(ZX:2)
000500100621     FFRMTRKL3  IF   E           K DISK    RENAME(FRMTRKR:FMTGRP)
000600100621     FFRMTRKL4  IF   E           K DISK    RENAME(FRMTRKR:FMTTSA)
000700100623     FFTRW020   IF   E           K DISK
000800100715     FACCNAM    IF   E           K DISK    RENAME(ACCMSR:BYNAMF) PREFIX(P)
000900100628     FACCMSTSP  IF   E           K DISK
001000100715     FMEMNAM    IF   E           K DISK    RENAME(MEMBR:MNAMF) PREFIX(I)
001100100708     FMEMBER    IF   E           K DISK
001200100621   X***X
001300100622     D DS@UNQ        E DS                  EXTNAME(FRMTRKP) PREFIX(XX:2)
001400100811     D DS@LF2        E DS                  EXTNAME(FRMTRKP) PREFIX(ZX:2)
001500100622     D DS@ALL        E DS                  EXTNAME(FRMTRKP)
001600100622     D H@GROUP         S                   LIKE(FTGROUP) INZ
001700100622     D H@TRST          S                   LIKE(FTTRST) INZ
001800100715     D H@TC            S                   LIKE(FTTYPCOD)
001900100623     D KF@CODE         S                   LIKE(FTCLSCOD) INZ
002000100622     D H@SUB#          S                   LIKE(FTSUB#) INZ
002100100622     D H@ACCT          S                   LIKE(FTACCT) INZ
002200100623     D @EMSG           S                   LIKE(EMSG) INZ
002300100811     D @MODE           S              3A
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
011400100623     C     @STEP         CASEQ     'PREP5'       $PREP5
011500100621     C     @STEP         CASEQ     'STEP5'       $STEP5
011600100621     C     @STEP         CASEQ     'STEP6'       $STEP6
011700100621     C     @STEP         CASEQ     'STEP7'       $STEP7
011800100621     C                   ENDCS
011900100621     C                   ENDDO
012000100621    ***
012100100621     C                   MOVE      *ON           *INLR
012200100621   S***S
012300100621     C* ONETIME ROUTINE
012400100621    ***
012500100621     C     *INZSR        BEGSR
012600100624    ***
012700100624     C                   CLEAR                   FTRCTL
012800100624     C                   CLEAR                   FTRSFL
012900100624     C                   CLEAR                   FTRREC
013000100624     C                   CLEAR                   FTRSCR
013100100621    ***
013200100811     C                   EVAL      *IN70 = *ON
013300100624     C                   SETOFF                                       353637
013400100624     C                   MOVEA     '110'         *IN(31)
013500100621     C                   EVAL      #SORTBY = 1
013600100621     C                   EVAL      @STEP = 'STEP1'
013700100621    ***
013800100621     C                   ENDSR
013900100621   S***S
014000100622     C     $STEP1        BEGSR
014100100621    ***
014200100622     C                   MOVEA     '011'         *IN(25)
014300100622     C                   WRITE     FTRCTL
014400100622     C                   MOVEA     '010'         *IN(25)
014500100622     C                   Z-ADD     *ZERO         RRT
014600100622    ***
014700100622     C                   MOVE      *ZEROS        #CNTREC
014800100622     C                   MOVE      '0'           @1STLOOP
014900100622     C                   EVAL      @FLAG = 'L'
015000100622     C                   EVAL      EXIT_SFL = NO
015100100622    ***
015200100622     C                   MOVE      'STEP2'       @STEP
015300100622    ***
015400100622     C                   ENDSR
015500100622   S***S
015600100622     C     $STEP2        BEGSR
015700100621    ***
015800100621     C                   SELECT
015900100621     C                   WHEN      #SORTBY = 1
016000100621     C     KL#L3         SETLL     FMTGRP
016100100624     C                   EVAL      PSNGROUP = *BLANKS
016200100621     C                   WHEN      #SORTBY = 2
016300100621     C     KL#L4         SETLL     FMTTSA
016400100624     C                   MOVE      *ZEROS        PSNTRS
016500100624     C                   MOVE      *ZEROS        PSNSUB#
016600100624     C                   MOVE      *ZEROS        PSNACCT
016700100621     C                   WHEN      #SORTBY = 3
016800100621     C     KL#L2         SETLL     FMTSSN
016900100624     C                   MOVE      *ZEROS        PSNSSN
017000100621     C                   WHEN      #SORTBY = 4
017100100621     C     KL#L          SETLL     FMTNAM
017200100624     C                   MOVE      *BLANKS       PSNAMEL
017300100621     C                   WHEN      #SORTBY = 5
017400100621     C     KL#P          SETLL     FMTUNQ
017500100621     C                   OTHER
017600100621     C                   EVAL      #SORTBY = 1
017700100621     C     KL#L3         SETLL     FMTGRP
017800100624     C                   EVAL      PSNGROUP = *BLANKS
017900100621     C                   ENDSL
018000100621    ***
018100100622     C                   MOVE      'STEP3'       @STEP
018200100622    ***
018300100621     C                   ENDSR
018400100621   S***S
018500100622     C     $STEP3        BEGSR
018600100622    ***
018700100622     C                   IF        EXIT_SFL = YES OR #CNTREC >= 360
018800100622     C                   MOVE      'STEP4'       @STEP
018900100622     C                   LEAVESR
019000100622     C                   ENDIF
019100100621    ***
019200100621     C                   EXSR      $READBY
019300100621    ***
019400100621     C                   IF        EXIT_SFL = YES
019500100621     C                   LEAVESR
019600100621     C                   ENDIF
019700100722    ***
019800100811     C                   IF        *IN70 = *ON
019900100811     C                   IF        FTRPTDTE = D'0001-01-01'
020000100722     C                   LEAVESR
020100100722     C                   ENDIF
020200100722     C                   ENDIF
020300100621    ***
020400100621     C                   MOVE      *ON           *IN25
020500100621     C                   MOVE      *BLANKS       SEL
020600100702      *
020700100702     C                   IF        FTRPTDTE = D'0001-01-01'
020800100702     C                   MOVE      *ZEROS        SFRPTDTE
020900100702     C                   ELSE
021000100702     C     *USA          MOVE      FTRPTDTE      SFRPTDTE
021100100702     C                   ENDIF
021200100702     C*
021300100702     C                   IF        FTRCVDT  = D'0001-01-01'
021400100702     C                   MOVE      *ZEROS        SFRCVDT
021500100702     C                   ELSE
021600100702     C     *USA          MOVE      FTRCVDT       SFRCVDT
021700100702     C                   ENDIF
021800100702     C*
021900100702     C                   IF        FTCLSDT  = D'0001-01-01'
022000100702     C                   MOVE      *ZEROS        SFCLSDT
022100100702     C                   ELSE
022200100702     C     *USA          MOVE      FTCLSDT       SFCLSDT
022300100702     C                   ENDIF
022400100621     C*
022500100622     C                   MOVE      *BLANKS       @100
022600100622     C                   MOVEL(P)  FTGROUP       SFGROUP
022700100622     C                   EVAL      @100 = %TRIM(FTNAMEL) + ', ' +
022800100622     C                             %TRIM(FTNAMEF) + ' ' + FTNAMEM
022900100624     C                   MOVEL(P)  @100          SFNAMEM
023000100622     C                   EVAL      HUNIQ = FTUNIQUE
023100100621     C*
023200100621     C                   ADD       1             #CNTREC
023300100621     C                   ADD       1             RRT
023400100621     C*
023500100621     C                   IF        @1STLOOP = '0'
023600100621     C                   Z-ADD     RRT           SFLPOS
023700100621     C                   MOVE      '1'           @1STLOOP
023800100621     C                   ENDIF
023900100621     C*
024000100621     C                   WRITE     FTRSFL
024100100621    ***
024200100621     C                   ENDSR
024300100621   S***S
024400100621     C     $READBY       BEGSR
024500100621    ***
024600100621     C                   SELECT
024700100621      *
024800100621     C                   WHEN      #SORTBY = 1
024900100621     C                   READ      FMTGRP
025000100623     C                   IF        %EOF(FRMTRKL3)
025100100621     C                   EVAL      EXIT_SFL = YES
025200100621     C                   LEAVESR
025300100621     C                   ENDIF
025400100621      *
025500100621     C                   WHEN      #SORTBY = 2
025600100621     C                   READ      FMTTSA
025700100623     C                   IF        %EOF(FRMTRKL4)
025800100621     C                   EVAL      EXIT_SFL = YES
025900100621     C                   LEAVESR
026000100621     C                   ENDIF
026100100621      *
026200100621     C                   WHEN      #SORTBY = 3
026300100621     C                   READ      FMTSSN
026400100623     C                   IF        %EOF(FRMTRKL2)
026500100621     C                   EVAL      EXIT_SFL = YES
026600100621     C                   LEAVESR
026700100811     C                   ELSE
026800100811     C                   EVAL      DS@ALL = DS@LF2
026900100621     C                   ENDIF
027000100621      *
027100100621     C                   WHEN      #SORTBY = 4
027200100621     C                   READ      FMTNAM
027300100623     C                   IF        %EOF(FRMTRKL)
027400100621     C                   EVAL      EXIT_SFL = YES
027500100621     C                   LEAVESR
027600100621     C                   ENDIF
027700100621      *
027800100621     C                   WHEN      #SORTBY = 5
027900100621     C                   READ      FMTUNQ
028000100623     C                   IF        %EOF(FRMTRKP)
028100100624     C                   EVAL      EXIT_SFL = YES
028200100621     C                   LEAVESR
028300100624     C                   ELSE
028400100624     C                   EVAL      DS@ALL = DS@UNQ
028500100621     C                   ENDIF
028600100621      *
028700100621     C                   ENDSL
028800100621    ***
028900100621     C                   ENDSR
029000100621   S***S
029100100713     **************************MAIN SFL CTL LOOP PROCESSING ROUTINE
029200100713     ************
029300100622     C     $STEP4        BEGSR
029400100621    ***
029500100621     C                   EVAL      EMSG = @EMSG
029600100621     C                   WRITE     FTRREC
029700100621     C                   EXFMT     FTRCTL
029800100621     C                   EVAL      EMSG = *BLANKS
029900100621     C                   EVAL      @EMSG = *BLANKS
030000100621    ***
030100100706     C                   IF        FKEY = F7
030200100621     C                   EVAL      @STEP = 'LEAVE'
030300100621     C                   LEAVESR
030400100621     C                   ENDIF
030500100621    ***
030600100811    *C*                  IF        FKEY = F6
030700100811    *C*                  MOVE      'ADD'         @MODE             3
030800100811    *C*                  EVAL      @STEP = 'PREP5'
030900100811    *C*                  LEAVESR
031000100811    *C*                  ENDIF
031100100811    ***
031200100621     C                   IF        FKEY = F10
031300100622     C                   EXSR      $F10TOG
031400100624     C                   EVAL      FKEY = F24
031500100621     C                   LEAVESR
031600100621     C                   ENDIF
031700100722    ***
031800100722     C                   IF        FKEY = F11
031900100722     C                   IF        *IN70 = *ON
032000100722     C                   EVAL      *IN70 = *OFF
032100100722     C                   ELSE
032200100722     C                   EVAL      *IN70 = *ON
032300100722     C                   ENDIF
032400100722     C                   EVAL      @STEP = 'STEP1'
032500100722     C                   LEAVESR
032600100722     C                   ENDIF
032700100621    ***
032800100624     C                   EXSR      $CHKCTL
032900100624     C                   IF        REPOS_SFL = YES
033000100624     C                   EVAL      @STEP = 'STEP1'
033100100624     C                   LEAVESR
033200100624     C                   ENDIF
033300100624    ***
033400100624     C                   IF        #CNTREC > 0
033500100621     C                   EXSR      $CHKSEL
033600100621     C                   ENDIF
033700100624    ***
033800100624     C                   ENDSR
033900100624   S***S
034000100624     C     $CHKCTL       BEGSR
034100100624    ***
034200100624     C                   EVAL      REPOS_SFL = NO
034300100624    ***
034400100624     C                   SELECT
034500100624     C                   WHEN      #SORTBY = 1 AND
034600100624     C                             PSNGROUP <> *BLANKS
034700100624     C                   EVAL      REPOS_SFL = YES
034800100624     C                   WHEN      #SORTBY = 2 AND
034900100624     C                             PSNTRS <> *ZEROS
035000100624     C                   EVAL      REPOS_SFL = YES
035100100624     C                   WHEN      #SORTBY = 3 AND
035200100624     C                             PSNSSN <> *ZEROS
035300100624     C                   EVAL      REPOS_SFL = YES
035400100624     C                   WHEN      #SORTBY = 4 AND
035500100624     C                             PSNAMEL <> *BLANKS
035600100624     C                   EVAL      REPOS_SFL = YES
035700100624     C                   WHEN      #SORTBY = 5 AND
035800100624     C                             PSNUNIQ <> *BLANKS
035900100624     C                   EVAL      REPOS_SFL = YES
036000100624     C                   ENDSL
036100100623    ***
036200100623     C                   ENDSR
036300100622   S***S
036400100622     C     $F10TOG       BEGSR
036500100622    ***
036600100622     C                   IF        *IN37 = *OFF
036700100622     C                   EVAL      *IN37 = *ON
036800100622     C                   LEAVESR
036900100622     C                   ENDIF
037000100622      *
037100100622     C                   ADD       1             #SORTBY
037200100622     C                   IF        #SORTBY > 5
037300100622     C                   Z-ADD     1             #SORTBY
037400100622     C                   ENDIF
037500100624    ***
037600100624     C                   SELECT
037700100624     C                   WHEN      #SORTBY = 1
037800100624     C                   MOVEA     '110'         *IN(31)
037900100624     C                   WHEN      #SORTBY = 2
038000100624     C                   MOVEA     '100'         *IN(31)
038100100624     C                   WHEN      #SORTBY = 3
038200100624     C                   MOVEA     '000'         *IN(31)
038300100624     C                   WHEN      #SORTBY = 4
038400100624     C                   MOVEA     '010'         *IN(31)
038500100624     C                   WHEN      #SORTBY = 5
038600100624     C                   MOVEA     '001'         *IN(31)
038700100624     C                   ENDSL
038800100623    ***
038900100623     C                   ENDSR
039000100623   S***S
039100100623     C     $PREP5        BEGSR
039200100623    ***
039300100623     C                   CLEAR                   FTRSCR
039400100811     C*                  EVAL      SCREPEAT = 'N'
039500100623     C                   EVAL      H@GROUP = *BLANKS
039600100623     C                   EVAL      H@TRST = 0
039700100623     C                   EVAL      H@SUB# = 0
039800100623     C                   EVAL      H@ACCT = 0
039900100713     C                   EVAL      H@TC = *BLANKS
040000100623    ***
040100100623     C                   EVAL      @STEP = 'STEP5'
040200100622    ***
040300100622     C                   ENDSR
040400100622   S***S
040500100622     C     $STEP5        BEGSR
040600100622    ***
040700100622     C                   SETOFF                                       3536
040800100622    ***
040900100622     C                   CALL      'FTRC010'
041000100622     C                   PARM                    @15              15
041100100622     C                   MOVE      @15           FTUNIQUE
041200100622    ***
041300100622     C                   CLEAR                   @TIMESTAMP
041400100622     C                   MOVE      *BLANKS       @TS40
041500100622     C                   CALL      'TIMESTMP'
041600100622     C                   PARM                    @TS40
041700100622     C                   MOVEL     @TS40         @TIMESTAMP
041800100622     C                   EVAL      FTRCVUSR = @TSUSER
041900100622     C                   MOVE      #TSCYMD       FTRCVDT
042000100622     C                   MOVE      #TSTIME       FTRCVTM
042100100621    ***
042200100702     C                   MOVE      *ZEROS        SCCLSDT
042300100702     C                   MOVE      *ZEROS        SCRPTDTE
042400100625     C     *USA          MOVE      FTRCVDT       SCRCVDT
042500100622     C                   MOVE      *ZEROS        FTCLSTM
042600100622     C                   EVAL      FTCLSDT = D'0001-01-01'
042700100622     C                   EVAL      FTRPTDTE = D'0001-01-01'
042800100622    ***
042900100811    *C*                  IF        SCREPEAT = 'Y'
043000100811    *C*                  EVAL      FTGROUP = H@GROUP
043100100811    *C*                  EVAL      FTTRST = H@TRST
043200100811    *C*                  EVAL      FTSUB#  = H@SUB#
043300100811    *C*                  EVAL      FTACCT  = H@ACCT
043400100811    *C*                  SETOFF                                       34
043500100811    *C*                  ELSE
043600100702     C                   EVAL      FTGROUP = *BLANKS
043700100702     C                   EVAL      FTTRST = 0
043800100702     C                   EVAL      FTSUB#  = 0
043900100702     C                   EVAL      FTACCT  = 0
044000100811     C*                  EVAL      SCREPEAT = 'N'
044100100702     C                   EVAL      H@GROUP = *BLANKS
044200100702     C                   EVAL      H@TRST = 0
044300100702     C                   EVAL      H@SUB# = 0
044400100702     C                   EVAL      H@ACCT = 0
044500100713     C                   EVAL      H@TC = *BLANKS
044600100702     C                   SETON                                        34
044700100811     C*                  ENDIF
044800100622    ***
044900100715     C                   EVAL      FTTYPCOD = H@TC
045000100625     C                   EVAL      FTSSN = 0
045100100625     C                   EVAL      FTNAMEL = *BLANKS
045200100625     C                   EVAL      FTNAMEF = *BLANKS
045300100625     C                   EVAL      FTNAMEM = *BLANKS
045400100622     C                   EVAL      @STEP = 'STEP6'
045500100721     C                   EVAL      CONFRM = NO
045600100622    ***
045700100621     C                   ENDSR
045800100621   S***S
045900100622     C     $STEP6        BEGSR
046000100622    ***
046100100622     C                   EVAL      EMSG = @EMSG
046200100622     C                   EXFMT     FTRSCR
046300100622     C                   EVAL      EMSG = *BLANKS
046400100622     C                   EVAL      @EMSG = *BLANKS
046500100622    ***
046600100706     C                   IF        FKEY = F1
046700100622     C                   EVAL      @STEP = 'STEP1'
046800100622     C                   LEAVESR
046900100622     C                   ENDIF
047000100622    ***
047100100622     C                   EXSR      $VALID
047200100721    ***
047300100721     C                   IF        VALID_DTA = YES
047400100721     C                   IF        CONFRM = YES
047500100721     C                   EVAL      @STEP = 'STEP7'
047600100721     C                   LEAVESR
047700100721     C                   ELSE
047800100721     C                   EVAL      CONFRM = YES
047900100721     C                   ENDIF
048000100721     C                   ELSE
048100100721     C                   EVAL      CONFRM = NO
048200100721     C                   ENDIF
048300100622    ***
048400100622     C                   ENDSR
048500100622   S***S
048600100622     C     $VALID        BEGSR
048700100622    ***
048800100622     C                   EVAL      VALID_DTA = NO
048900100622    ***
049000100811     C*                  IF        SCREPEAT = *BLANKS
049100100811     C*                  EVAL      SCREPEAT = 'N'
049200100811     C*                  ENDIF
049300100622    ***
049400100702     C                   IF        FTTYPCOD = *BLANKS
049500100702     C                   EVAL      @EMSG = 'TYPE CODE REQUIRED'
049600100702     C                   LEAVESR
049700100702     C                   ENDIF
049800100702    ***
049900100702     C                   IF        FTTYPCOD <> 'N' AND FTTYPCOD <> 'R'
050000100702     C                             AND FTTYPCOD <> 'M'
050100100713     C                             AND FTTYPCOD <> 'B'
050200100702     C                   EVAL      @EMSG = 'TYPE CODE IS INVALID'
050300100702     C                   LEAVESR
050400100702     C                   ENDIF
050500100715    ***
050600100715     C                   EVAL      H@TC = FTTYPCOD
050700100702    ***
050800100628     C                   IF        FTTRST > 0 AND FTSUB# > 0 AND
050900100628     C                             FTACCT > 0 AND
051000100628     C                             FTGROUP = *BLANKS
051100100628     C     KL#ACM        CHAIN     ACCMSR
051200100628     C                   IF        %FOUND(ACCMSTSP)
051300100628     C                   MOVEL(P)  ACNAM1        FTGROUP
051400100628     C                   ENDIF
051500100628     C                   ENDIF
051600100715    ***
051700100715     C                   IF        FTTRST = 0 AND FTSUB# = 0 AND
051800100715     C                             FTACCT = 0 AND
051900100715     C                             FTGROUP <> *BLANKS
052000100715     C     FTGROUP       CHAIN     BYNAMF
052100100715     C                   IF        %FOUND(ACCNAM)
052200100715     C                   EVAL      FTTRST = PACTRST
052300100715     C                   EVAL      FTSUB# = PACSUB#
052400100715     C                   EVAL      FTACCT = PACACCT
052500100715     C                   ENDIF
052600100715     C                   ENDIF
052700100622    ***
052800100715     C                   IF        FTGROUP = *BLANKS AND
052900100715     C                             FTTRST = 0 AND FTSUB# = 0 AND
053000100715     C                             FTACCT = 0
053100100715     C                   EVAL      @EMSG = 'SOME FORM OF GROUP ID IS REQUIRED' +
053200100715     C                             ' FOR ALL APPS.'
053300100715     C                   LEAVESR
053400100715     C                   ENDIF
053500100715    ***
053600100721     C                   IF        FTGROUP = *BLANKS OR
053700100721     C                             (FTTRST = 0 AND FTSUB# = 0 AND
053800100721     C                             FTACCT = 0)
053900100721     C                   EVAL      @EMSG = 'FYI - IT IS RECOMMENDED TO HAVE A' +
054000100721     C                             'LL PARTS OF ACCT INFO.'
054100100721     C                   ENDIF
054200100721    ***
054300100708     C     *LIKE         DEFINE    MBSSNO        ZZSSNO
054400100708     C                   IF        FTSSN <> 0 AND FTNAMEF = *BLANKS AND
054500100708     C                             FTNAMEL = *BLANKS AND
054600100708     C                             FTNAMEM = *BLANKS
054700100708     C                   Z-ADD     FTSSN         ZZSSNO
054800100708     C     ZZSSNO        CHAIN     MEMBR
054900100708     C                   IF        %FOUND(MEMBER)
055000100708     C                   MOVEL(P)  MFNAME        FTNAMEF
055100100708     C                   MOVEL(P)  MLNAME        FTNAMEL
055200100708     C                   MOVEL(P)  MMI           FTNAMEM
055300100708     C                   ENDIF
055400100708     C                   ENDIF
055500100715    ***
055600100715     C                   IF        FTSSN = 0 AND FTNAMEF <> *BLANKS AND
055700100715     C                             FTNAMEL <> *BLANKS
055800100715     C     KL#NAM        KLIST
055900100715     C                   KFLD                    QLNAM            18
056000100715     C                   KFLD                    QFNAM            12
056100100715     C                   KFLD                    QMMI              1
056200100715     C                   MOVEL(P)  FTNAMEL       QLNAM
056300100715     C                   MOVEL(P)  FTNAMEF       QFNAM
056400100715     C                   MOVEL(P)  FTNAMEM       QMMI
056500100715     C     KL#NAM        CHAIN     MNAMF
056600100715     C                   IF        %FOUND(MEMBER)
056700100715     C                   MOVE      IMBSSNO       FTSSN
056800100715     C                   ENDIF
056900100715     C                   ENDIF
057000100628    ***
057100100721     C                   IF        FTSSN = 0 OR FTNAMEL = *BLANKS OR
057200100721     C                             FTNAMEF = *BLANKS
057300100723     C                   EVAL      @EMSG = 'SSN AND MEMBER NAME ARE REQUIRED.'
057400100715     C                   LEAVESR
057500100715     C                   ENDIF
057600100715    ***
057700100702     C                   IF        @MODE = 'ADD'
057800100628     C                   IF        FTSSN > 0
057900100628     C                   EXSR      $DUPECHK
058000100723     C                   IF        DUPE_DATA = YES
058100100628     C                   LEAVESR
058200100628     C                   ENDIF
058300100702     C                   ENDIF
058400100628     C                   ENDIF
058500100623    ***
058600100702     C                   IF        SCRCVDT = 0
058700100702     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
058800100702     C                   LEAVESR
058900100702     C                   ENDIF
059000100702     C     *USA          TEST(DE)                SCRCVDT
059100100702     C                   IF        %ERROR
059200100702     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
059300100702     C                   LEAVESR
059400100702     C                   ENDIF
059500100702     C                   MOVE      SCRCVDT       #USA
059600100702     C                   MOVE      #USA          #ISO
059700100702     C                   MOVE      #ISO          FTRCVDT
059800100622    ***
059900100623     C                   IF        FTRCVTM = 000000
060000100623     C                   EVAL      @EMSG = 'VALID RECIEVE TIME PLEASE.'
060100100623     C                   LEAVESR
060200100623     C                   ENDIF
060300100623    ***
060400100622     C                   EVAL      VALID_DTA = YES
060500100622    ***
060600100622     C                   ENDSR
060700100622   S***S
060800100628     C     $DUPECHK      BEGSR
060900100628    ***
061000100723     C                   EVAL      DUPE_DATA = NO
061100100723    ***
061200100628     C                   EVAL      KF@SSN = FTSSN
061300100628     C     KL#L2B        CHAIN     FMTSSN
061400100628     C                   IF        NOT %FOUND(FRMTRKL2)
061500100628     C                   LEAVESR
061600100628     C                   ENDIF
061700100628    ***
061800100628     C     KL#L2B        SETLL     FMTSSN
061900100628     C                   DOU       %EOF(FRMTRKL2)
062000100628     C     KL#L2B        READE     FMTSSN
062100100628     C                   IF        NOT %EOF(FRMTRKL2)
062200100811     C                   IF        ZXCLSDT = D'0001-01-01'
062300100628     C                   EVAL      @EMSG = 'OPEN APP EXISTS, ADD DENIED.'
062400100723     C                   EVAL      DUPE_DATA = YES
062500100723    ***
062600100628     C                   LEAVESR
062700100628     C                   ENDIF
062800100628     C                   ENDIF
062900100628     C                   ENDDO
063000100628    ***
063100100628     C                   ENDSR
063200100628   S***S
063300100622     C     $STEP7        BEGSR
063400100622    ***
063500100622     C                   EVAL      DS@UNQ = DS@ALL
063600100622     C                   WRITE     FMTUNQ
063700100622    ***
063800100811    *C*                  IF        SCREPEAT = 'Y'
063900100811    *C*                  EVAL      H@GROUP = XXGROUP
064000100811    *C*                  EVAL      H@TRST = XXTRST
064100100811    *C*                  EVAL      H@SUB#  = XXSUB#
064200100811    *C*                  EVAL      H@ACCT  = XXACCT
064300100811    *C*                  ENDIF
064400100622    ***
064500100622     C                   EVAL      @STEP = 'STEP5'
064600100721     C                   EVAL      @EMSG = 'APP ADDED, GOOD JOB.'
064700100622    ***
064800100622     C                   ENDSR
064900100622   S***S
065000100623     C     $CHKSEL       BEGSR
065100100623    ***
065200100811    1C                   DOU       %EOF(FTRD050)
065300100624     C                   READC     FTRSFL
065400100811    2C                   IF        NOT %EOF(FTRD050) AND SEL <> *BLANKS
065500100623    ***
065600100708     C                   EVAL      DCLSCODE = *BLANKS
065700100708    ***
065800100713    3C                   IF        SEL = 'D'
065900100702     C                   MOVE      'DSP'         @MODE
066000100623     C                   EXSR      $DSPREC
066100100623     C                   ITER
066200100623    3C                   ENDIF
066300100623    ***
066400100811    3C*                  IF        SEL = 'C'
066500100811    *C*                  MOVE      'CHG'         @MODE
066600100811    *C*                  EXSR      $MNTREC
066700100811    *C*                  EVAL      @STEP = 'STEP1'
066800100811    *C*                  ITER
066900100811    3C*                  ENDIF
067000100623    ***
067100100623     C                   ENDIF
067200100623     C                   ENDDO
067300100623    ***
067400100623     C                   ENDSR
067500100622   S***S
067600100623     C     $DSPREC       BEGSR
067700100623    ***
067800100623     C     HUNIQ         CHAIN(N)  FMTUNQ
067900100623     C                   IF        NOT %FOUND(FRMTRKP)
068000100623     C                   LEAVESR
068100100623     C                   ENDIF
068200100623    ***
068300100708     C                   EVAL      DS@ALL = DS@UNQ
068400100708      *
068500100623     C                   MOVEA     '010'         *IN(34)
068600100623     C     *USA          MOVE      FTRPTDTE      SCRPTDTE
068700100623     C     *USA          MOVE      FTRCVDT       SCRCVDT
068800100623     C     *USA          MOVE      FTCLSDT       SCCLSDT
068900100708    * *
069000100713     C                   IF        SCCLSDT = 01010001
069100100713     C                   EVAL      SCCLSDT = 0
069200100713     C                   ENDIF
069300100713     C                   IF        SCRCVDT = 01010001
069400100713     C                   EVAL      SCRCVDT = 0
069500100713     C                   ENDIF
069600100713     C                   IF        SCRPTDTE = 01010001
069700100713     C                   EVAL      SCRPTDTE = 0
069800100713     C                   ENDIF
069900100623    ***
070000100623     C                   IF        FTCLSCOD <> *BLANKS
070100100623     C     FTCLSCOD      CHAIN     FTRW020R
070200100623     C                   IF        %FOUND(FTRW020)
070300100623     C                   EVAL      DCLSCODE = F2DESC
070400100623     C                   ELSE
070500100623     C                   MOVE      *BLANKS       DCLSCODE
070600100623     C                   ENDIF
070700100623     C                   ENDIF
070800100623    ***
070900100706     C                   DOU       FKEY = F1
071000100623     C                   EXFMT     FTRSCR
071100100623    *C                   ENDDO
071200100702    ***
071300100702     C                   EVAL      @STEP = 'STEP1'
071400100623    ***
071500100623     C                   ENDSR
071600100622   S***S
071700100811    *C*    $MNTREC       BEGSR
071800100811    ***
071900100811    *C*    HUNIQ         CHAIN     FMTUNQ
072000100811    *C*                  IF        NOT %FOUND(FRMTRKP)
072100100811    *C*                  LEAVESR
072200100811    *C*                  EVAL      *IN36 = *OFF
072300100811    *C*                  ENDIF
072400100811    ***
072500100811    *C*                  EXSR      $FMTSCR
072600100811    ***
072700100811    *C*                  DOU       FKEY = F1
072800100811    *C*                  EXSR      $SCREEN
072900100811    *C*                  ENDDO
073000100811    ***
073100100811    *C*    HUNIQ         CHAIN(N)  FMTUNQ
073200100811    *C*                  EVAL      @STEP = 'STEP1'
073300100811    ***
073400100811    *C*                  ENDSR
073500100811   S***S
073600100811    *C*    $FMTSCR       BEGSR
073700100811    ***
073800100811    *C*                  EVAL      DS@ALL = DS@UNQ
073900100811    ***
074000100811    *C*    *USA          MOVE      XXRPTDTE      SCRPTDTE
074100100811    *C*    *USA          MOVE      XXRCVDT       SCRCVDT
074200100811    *C*    *USA          MOVE      XXCLSDT       SCCLSDT
074300100811    ***
074400100811    *C*                  IF        XXRPTDTE = D'0001-01-01'
074500100811    *C*                  EVAL      *IN35 = *OFF
074600100811    *C*                  ELSE
074700100811    ***
074800100811    *C*                  ENDIF
074900100811    ***
075000100811    *C*                  EVAL      *IN36 = *OFF
075100100811    ***
075200100811    *C*                  ENDSR
075300100622   S***S
075400100622     C     $SCREEN       BEGSR
075500100702    ***
075600100702     C                   IF        SCCLSDT = 01010001
075700100702     C                   EVAL      SCCLSDT = 0
075800100702     C                   ENDIF
075900100702     C                   IF        SCRCVDT = 01010001
076000100702     C                   EVAL      SCRCVDT = 0
076100100702     C                   ENDIF
076200100702     C                   IF        SCRPTDTE = 01010001
076300100702     C                   EVAL      SCRPTDTE = 0
076400100702     C                   ENDIF
076500100622    ***
076600100623     C                   EVAL      EMSG = @EMSG
076700100623     C                   EXFMT     FTRSCR
076800100623     C                   EVAL      @EMSG = *BLANKS
076900100702    ***
077000100702     C                   IF        SCCLSDT = 0
077100100702     C                   EVAL      SCCLSDT = 01010001
077200100702     C                   ENDIF
077300100702     C                   IF        SCRCVDT = 0
077400100702     C                   EVAL      SCRCVDT = 01010001
077500100702     C                   ENDIF
077600100702     C                   IF        SCRPTDTE = 0
077700100702     C                   EVAL      SCRPTDTE = 01010001
077800100702     C                   ENDIF
077900100623    ***
078000100719     C                   IF        FKEY = F8
078100100719     C     HUNIQ         CHAIN(N)  FMTUNQ
078200100719     C                   EVAL      @PRM15 = HUNIQ
078300100719     C                   CALL      'FTRC022'
078400100719     C                   PARM                    @PRM15           15
078500100719     C                   EVAL      FKEY = F1
078600100623     C                   LEAVESR
078700100623     C                   ENDIF
078800100622    ***
078900100713     C                   IF        FKEY = F4
079000100713     C                   CALL      'FTRC021'
079100100713     C                   PARM                    @PRM              3
079200100721     C                   IF        @PRM <> '*LR'
079300100713     C                   EVAL      FTCLSCOD = @PRM
079400100713     C                   IF        SCCLSDT = 0 OR SCCLSDT = 0101001
079500100721     C                   CLEAR                   @TIMESTAMP
079600100721     C                   MOVE      *BLANKS       @TS40
079700100721     C                   CALL      'TIMESTMP'
079800100721     C                   PARM                    @TS40
079900100721     C                   MOVEL     @TS40         @TIMESTAMP
080000100721     C                   EVAL      FTCLSUSR = @TSUSER
080100100721     C                   MOVE      #TSCYMD       FTCLSDT
080200100721     C                   MOVE      #TSTIME       FTCLSTM
080300100713     C                   ENDIF
080400100713     C                   ENDIF
080500100713     C                   ENDIF
080600100719    ***
080700100719     C                   IF        FKEY = F1
080800100719     C     HUNIQ         CHAIN     FMTUNQ
080900100719     C                   LEAVESR
081000100719     C                   ENDIF
081100100713    ***
081200100713     C                   IF        XXCLSCOD = *BLANKS AND
081300100713     C                             FTCLSCOD <> *BLANKS AND
081400100713     C                             XXCLSDT = D'0001-01-01'
081500100713    *C                   CLEAR                   @TIMESTAMP
081600100713    *C                   MOVE      *BLANKS       @TS40
081700100713    *C                   CALL      'TIMESTMP'
081800100713    *C                   PARM                    @TS40
081900100713    *C                   MOVEL     @TS40         @TIMESTAMP
082000100713    *C                   EVAL      FTCLSUSR = @TSUSER
082100100713    *C                   MOVE      #TSCYMD       FTCLSDT
082200100713    *C                   MOVE      #TSTIME       FTCLSTM
082300100713     C                   ENDIF
082400100713    ***
082500100721     C                   EXSR      $VALID
082600100721     C                   IF        VALID_DTA = YES
082700100721     C                   IF        CONFRM = YES
082800100721     C                   EXSR      $UPDMNT
082900100721     C                   LEAVESR
083000100721     C                   ELSE
083100100721     C                   EVAL      CONFRM = YES
083200100721     C                   ENDIF
083300100721     C                   ELSE
083400100721     C                   EVAL      CONFRM = NO
083500100721     C                   ENDIF
083600100721    ***
083700100721     C                   ENDSR
083800100721   S***S
083900100721     C     $UPDMNT       BEGSR
084000100721    ***
084100100623     C                   EVAL      *IN36 = *ON
084200100702     C                   MOVE      SCRCVDT       #USA
084300100702     C                   MOVE      #USA          #ISO
084400100702     C                   MOVE      #ISO          FTRCVDT
084500100702     C                   EVAL      DS@UNQ = DS@ALL
084600100702     C                   UPDATE    FMTUNQ
084700100721     C                   EVAL      FKEY = F1
084800100721     C                   EVAL      @EMSG = 'UPDATE COMPLETED.'
084900100623    ***
085000100622     C                   ENDSR
085100100622   S***S
