000100100624     FFTRD020   CF   E             WORKSTN INFDS(WSDS) SFILE(FTRSFL:RRT)
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
002300100623     D @100            S            100A   INZ
002400100623     D EXIT_SFL        S               N   INZ
002500100723     D DUPE_DATA       S               N   INZ
002600100622     D VALID_DTA       S               N   INZ
002700100624     D REPOS_SFL       S               N   INZ
002800100622     D YES             S               N   INZ(*ON)
002900100622     D NO              S               N   INZ(*OFF)
003000100624     D #USA            S               D   DATFMT(*USA)
003100100624     D #ISO            S               D   DATFMT(*ISO)
003200100628     D KF@SSN          S                   LIKE(FTSSN)
003300100621    ***
003400100621     D WSDS            DS
003500100621     D  FKEY                 369    369A
003600100621    ***
003700100621     D  F1             C                   CONST(X'31')
003800100621     D  F2             C                   CONST(X'32')
003900100621     D  F3             C                   CONST(X'33')
004000100621     D  F4             C                   CONST(X'34')
004100100621     D  F5             C                   CONST(X'35')
004200100621     D  F6             C                   CONST(X'36')
004300100621     D  F7             C                   CONST(X'37')
004400100621     D  F8             C                   CONST(X'38')
004500100621     D  F9             C                   CONST(X'39')
004600100621     D  F10            C                   CONST(X'3A')
004700100621     D  F11            C                   CONST(X'3B')
004800100621     D  F12            C                   CONST(X'3C')
004900100621     D  F13            C                   CONST(X'B1')
005000100621     D  F14            C                   CONST(X'B2')
005100100621     D  F15            C                   CONST(X'B3')
005200100621     D  F16            C                   CONST(X'B4')
005300100621     D  F17            C                   CONST(X'B5')
005400100621     D  F18            C                   CONST(X'B6')
005500100621     D  F19            C                   CONST(X'B7')
005600100621     D  F20            C                   CONST(X'B8')
005700100621     D  F21            C                   CONST(X'B9')
005800100621     D  F22            C                   CONST(X'BA')
005900100621     D  F23            C                   CONST(X'BB')
006000100621     D  F24            C                   CONST(X'BC')
006100100621    ***
006200100622     D @TIMESTAMP      DS
006300100622     D  #TSCYMD                1      8S 0
006400100622     D  #TSTIME                9     14S 0
006500100622     D  @TSJOB                15     24
006600100622     D  @TSUSER               25     34
006700100622     D  #TSNBR                35     40S 0
006800100622    * *
006900100622     D @TS40           S             40A
007000100621    ***
007100100621     D @STEP           S              5A
007200100621    ***
007300100621     D #SORTBY         S              1S 0
007400100621     D RRT             S              4S 0
007500100621     D #CNTREC         S              4S 0
007600100621     D @1STLOOP        S              1A
007700100621     D @FLAG           S              1A
007800100621    ***
007900100721     D CONFRM          S               N
008000100621   X***X
008100100628     C     KL#ACM        KLIST
008200100628     C                   KFLD                    FTTRST
008300100628     C                   KFLD                    FTSUB#
008400100628     C                   KFLD                    FTACCT
008500100628    ***
008600100628     C     KL#L3         KLIST
008700100628     C                   KFLD                    PSNGROUP
008800100628    ***
008900100628     C     KL#L4         KLIST
009000100628     C                   KFLD                    PSNTRS
009100100628     C                   KFLD                    PSNSUB#
009200100628     C                   KFLD                    PSNACCT
009300100628    ***
009400100628     C     KL#L2B        KLIST
009500100628     C                   KFLD                    KF@SSN
009600100628    ***
009700100628     C     KL#L2         KLIST
009800100628     C                   KFLD                    PSNSSN
009900100628    ***
010000100628     C     KL#P          KLIST
010100100628     C                   KFLD                    PSNUNIQ
010200100628    ***
010300100628     C     KL#L          KLIST
010400100628     C                   KFLD                    PSNAMEL
010500100628    ***
010600100628   X***X
010700100621    ***
010800100621     C                   DOU       @STEP = 'LEAVE'
010900100621     C     @STEP         CASEQ     'STEP1'       $STEP1
011000100621     C     @STEP         CASEQ     'STEP2'       $STEP2
011100100621     C     @STEP         CASEQ     'STEP3'       $STEP3
011200100621     C     @STEP         CASEQ     'STEP4'       $STEP4
011300100623     C     @STEP         CASEQ     'PREP5'       $PREP5
011400100621     C     @STEP         CASEQ     'STEP5'       $STEP5
011500100621     C     @STEP         CASEQ     'STEP6'       $STEP6
011600100621     C     @STEP         CASEQ     'STEP7'       $STEP7
011700100621     C                   ENDCS
011800100621     C                   ENDDO
011900100621    ***
012000100621     C                   MOVE      *ON           *INLR
012100100621   S***S
012200100621     C* ONETIME ROUTINE
012300100621    ***
012400100621     C     *INZSR        BEGSR
012500100624    ***
012600100624     C                   CLEAR                   FTRCTL
012700100624     C                   CLEAR                   FTRSFL
012800100624     C                   CLEAR                   FTRREC
012900100624     C                   CLEAR                   FTRSCR
013000100621    ***
013100100624     C                   SETOFF                                       353637
013200100811     C                   MOVEA     '000'         *IN(31)
013300100812     C                   EVAL      *IN70 = *ON
013400100811     C                   EVAL      #SORTBY = 3
013500100621     C                   EVAL      @STEP = 'STEP1'
013600100621    ***
013700100621     C                   ENDSR
013800100621   S***S
013900100622     C     $STEP1        BEGSR
014000100621    ***
014100100622     C                   MOVEA     '011'         *IN(25)
014200100622     C                   WRITE     FTRCTL
014300100622     C                   MOVEA     '010'         *IN(25)
014400100622     C                   Z-ADD     *ZERO         RRT
014500100622    ***
014600100622     C                   MOVE      *ZEROS        #CNTREC
014700100622     C                   MOVE      '0'           @1STLOOP
014800100622     C                   EVAL      @FLAG = 'L'
014900100622     C                   EVAL      EXIT_SFL = NO
015000100622    ***
015100100622     C                   MOVE      'STEP2'       @STEP
015200100622    ***
015300100622     C                   ENDSR
015400100622   S***S
015500100622     C     $STEP2        BEGSR
015600100621    ***
015700100621     C                   SELECT
015800100621     C                   WHEN      #SORTBY = 1
015900100621     C     KL#L3         SETLL     FMTGRP
016000100624     C                   EVAL      PSNGROUP = *BLANKS
016100100621     C                   WHEN      #SORTBY = 2
016200100621     C     KL#L4         SETLL     FMTTSA
016300100624     C                   MOVE      *ZEROS        PSNTRS
016400100624     C                   MOVE      *ZEROS        PSNSUB#
016500100624     C                   MOVE      *ZEROS        PSNACCT
016600100621     C                   WHEN      #SORTBY = 3
016700100621     C     KL#L2         SETLL     FMTSSN
016800100624     C                   MOVE      *ZEROS        PSNSSN
016900100621     C                   WHEN      #SORTBY = 4
017000100621     C     KL#L          SETLL     FMTNAM
017100100624     C                   MOVE      *BLANKS       PSNAMEL
017200100621     C                   WHEN      #SORTBY = 5
017300100621     C     KL#P          SETLL     FMTUNQ
017400100621     C                   OTHER
017500100621     C                   EVAL      #SORTBY = 1
017600100621     C     KL#L3         SETLL     FMTGRP
017700100624     C                   EVAL      PSNGROUP = *BLANKS
017800100621     C                   ENDSL
017900100621    ***
018000100622     C                   MOVE      'STEP3'       @STEP
018100100622    ***
018200100621     C                   ENDSR
018300100621   S***S
018400100622     C     $STEP3        BEGSR
018500100622    ***
018600100622     C                   IF        EXIT_SFL = YES OR #CNTREC >= 360
018700100622     C                   MOVE      'STEP4'       @STEP
018800100622     C                   LEAVESR
018900100622     C                   ENDIF
019000100621    ***
019100100621     C                   EXSR      $READBY
019200100621    ***
019300100621     C                   IF        EXIT_SFL = YES
019400100621     C                   LEAVESR
019500100621     C                   ENDIF
019600100811    ***
019700100811     C                   IF        FTRPTDTE <> D'0001-01-01'
019800100811     C                   LEAVESR
019900100811     C                   ENDIF
020000100722    ***
020100100722     C                   IF        *IN70 = *ON
020200100722     C                   IF        FTCLSCOD <> *BLANKS
020300100722     C                   LEAVESR
020400100722     C                   ENDIF
020500100722     C                   ENDIF
020600100621    ***
020700100621     C                   MOVE      *ON           *IN25
020800100621     C                   MOVE      *BLANKS       SEL
020900100702      *
021000100702     C                   IF        FTRPTDTE = D'0001-01-01'
021100100702     C                   MOVE      *ZEROS        SFRPTDTE
021200100702     C                   ELSE
021300100702     C     *USA          MOVE      FTRPTDTE      SFRPTDTE
021400100702     C                   ENDIF
021500100702     C*
021600100702     C                   IF        FTRCVDT  = D'0001-01-01'
021700100702     C                   MOVE      *ZEROS        SFRCVDT
021800100702     C                   ELSE
021900100702     C     *USA          MOVE      FTRCVDT       SFRCVDT
022000100702     C                   ENDIF
022100100702     C*
022200100702     C                   IF        FTCLSDT  = D'0001-01-01'
022300100702     C                   MOVE      *ZEROS        SFCLSDT
022400100702     C                   ELSE
022500100702     C     *USA          MOVE      FTCLSDT       SFCLSDT
022600100702     C                   ENDIF
022700100621     C*
022800100622     C                   MOVE      *BLANKS       @100
022900100622     C                   MOVEL(P)  FTGROUP       SFGROUP
023000100622     C                   EVAL      @100 = %TRIM(FTNAMEL) + ', ' +
023100100622     C                             %TRIM(FTNAMEF) + ' ' + FTNAMEM
023200100624     C                   MOVEL(P)  @100          SFNAMEM
023300100622     C                   EVAL      HUNIQ = FTUNIQUE
023400100621     C*
023500100621     C                   ADD       1             #CNTREC
023600100621     C                   ADD       1             RRT
023700100621     C*
023800100621     C                   IF        @1STLOOP = '0'
023900100621     C                   Z-ADD     RRT           SFLPOS
024000100621     C                   MOVE      '1'           @1STLOOP
024100100621     C                   ENDIF
024200100621     C*
024300100621     C                   WRITE     FTRSFL
024400100621    ***
024500100621     C                   ENDSR
024600100621   S***S
024700100621     C     $READBY       BEGSR
024800100621    ***
024900100621     C                   SELECT
025000100621      *
025100100621     C                   WHEN      #SORTBY = 1
025200100621     C                   READ      FMTGRP
025300100623     C                   IF        %EOF(FRMTRKL3)
025400100621     C                   EVAL      EXIT_SFL = YES
025500100621     C                   LEAVESR
025600100621     C                   ENDIF
025700100621      *
025800100621     C                   WHEN      #SORTBY = 2
025900100621     C                   READ      FMTTSA
026000100623     C                   IF        %EOF(FRMTRKL4)
026100100621     C                   EVAL      EXIT_SFL = YES
026200100621     C                   LEAVESR
026300100621     C                   ENDIF
026400100621      *
026500100621     C                   WHEN      #SORTBY = 3
026600100621     C                   READ      FMTSSN
026700100623     C                   IF        %EOF(FRMTRKL2)
026800100621     C                   EVAL      EXIT_SFL = YES
026900100621     C                   LEAVESR
027000100811     C                   ELSE
027100100811     C                   EVAL      DS@ALL = DS@LF2
027200100621     C                   ENDIF
027300100621      *
027400100621     C                   WHEN      #SORTBY = 4
027500100621     C                   READ      FMTNAM
027600100623     C                   IF        %EOF(FRMTRKL)
027700100621     C                   EVAL      EXIT_SFL = YES
027800100621     C                   LEAVESR
027900100621     C                   ENDIF
028000100621      *
028100100621     C                   WHEN      #SORTBY = 5
028200100621     C                   READ      FMTUNQ
028300100623     C                   IF        %EOF(FRMTRKP)
028400100624     C                   EVAL      EXIT_SFL = YES
028500100621     C                   LEAVESR
028600100624     C                   ELSE
028700100624     C                   EVAL      DS@ALL = DS@UNQ
028800100621     C                   ENDIF
028900100621      *
029000100621     C                   ENDSL
029100100621    ***
029200100621     C                   ENDSR
029300100621   S***S
029400100713     **************************MAIN SFL CTL LOOP PROCESSING ROUTINE
029500100713     ************
029600100622     C     $STEP4        BEGSR
029700100621    ***
029800100621     C                   EVAL      EMSG = @EMSG
029900100621     C                   WRITE     FTRREC
030000100621     C                   EXFMT     FTRCTL
030100100621     C                   EVAL      EMSG = *BLANKS
030200100621     C                   EVAL      @EMSG = *BLANKS
030300100621    ***
030400100706     C                   IF        FKEY = F7
030500100621     C                   EVAL      @STEP = 'LEAVE'
030600100621     C                   LEAVESR
030700100621     C                   ENDIF
030800100621    ***
030900100622     C                   IF        FKEY = F6
031000100702     C                   MOVE      'ADD'         @MODE             3
031100100623     C                   EVAL      @STEP = 'PREP5'
031200100622     C                   LEAVESR
031300100622     C                   ENDIF
031400100622    ***
031500100621     C                   IF        FKEY = F10
031600100622     C                   EXSR      $F10TOG
031700100624     C                   EVAL      FKEY = F24
031800100621     C                   LEAVESR
031900100621     C                   ENDIF
032000100722    ***
032100100722     C                   IF        FKEY = F11
032200100812     C                   EVAL      *IN70 = *ON
032300100722     C                   EVAL      @STEP = 'STEP1'
032400100722     C                   LEAVESR
032500100722     C                   ENDIF
032600100621    ***
032700100811     C                   IF        FKEY = F12
032800100812     C                   EVAL      *IN70 = *OFF
032900100811     C                   EVAL      @STEP = 'STEP1'
033000100811     C                   LEAVESR
033100100811     C                   ENDIF
033200100811    ***
033300100624     C                   EXSR      $CHKCTL
033400100624     C                   IF        REPOS_SFL = YES
033500100624     C                   EVAL      @STEP = 'STEP1'
033600100624     C                   LEAVESR
033700100624     C                   ENDIF
033800100624    ***
033900100624     C                   IF        #CNTREC > 0
034000100621     C                   EXSR      $CHKSEL
034100100621     C                   ENDIF
034200100624    ***
034300100624     C                   ENDSR
034400100624   S***S
034500100624     C     $CHKCTL       BEGSR
034600100624    ***
034700100624     C                   EVAL      REPOS_SFL = NO
034800100624    ***
034900100624     C                   SELECT
035000100624     C                   WHEN      #SORTBY = 1 AND
035100100624     C                             PSNGROUP <> *BLANKS
035200100624     C                   EVAL      REPOS_SFL = YES
035300100624     C                   WHEN      #SORTBY = 2 AND
035400100624     C                             PSNTRS <> *ZEROS
035500100624     C                   EVAL      REPOS_SFL = YES
035600100624     C                   WHEN      #SORTBY = 3 AND
035700100624     C                             PSNSSN <> *ZEROS
035800100624     C                   EVAL      REPOS_SFL = YES
035900100624     C                   WHEN      #SORTBY = 4 AND
036000100624     C                             PSNAMEL <> *BLANKS
036100100624     C                   EVAL      REPOS_SFL = YES
036200100624     C                   WHEN      #SORTBY = 5 AND
036300100624     C                             PSNUNIQ <> *BLANKS
036400100624     C                   EVAL      REPOS_SFL = YES
036500100624     C                   ENDSL
036600100623    ***
036700100623     C                   ENDSR
036800100622   S***S
036900100622     C     $F10TOG       BEGSR
037000100622    ***
037100100622     C                   IF        *IN37 = *OFF
037200100622     C                   EVAL      *IN37 = *ON
037300100622     C                   LEAVESR
037400100622     C                   ENDIF
037500100622      *
037600100622     C                   ADD       1             #SORTBY
037700100622     C                   IF        #SORTBY > 5
037800100622     C                   Z-ADD     1             #SORTBY
037900100622     C                   ENDIF
038000100624    ***
038100100624     C                   SELECT
038200100624     C                   WHEN      #SORTBY = 1
038300100624     C                   MOVEA     '110'         *IN(31)
038400100624     C                   WHEN      #SORTBY = 2
038500100624     C                   MOVEA     '100'         *IN(31)
038600100624     C                   WHEN      #SORTBY = 3
038700100624     C                   MOVEA     '000'         *IN(31)
038800100624     C                   WHEN      #SORTBY = 4
038900100624     C                   MOVEA     '010'         *IN(31)
039000100624     C                   WHEN      #SORTBY = 5
039100100624     C                   MOVEA     '001'         *IN(31)
039200100624     C                   ENDSL
039300100623    ***
039400100623     C                   ENDSR
039500100623   S***S
039600100623     C     $PREP5        BEGSR
039700100623    ***
039800100623     C                   CLEAR                   FTRSCR
039900100623     C                   EVAL      SCREPEAT = 'N'
040000100623     C                   EVAL      H@GROUP = *BLANKS
040100100623     C                   EVAL      H@TRST = 0
040200100623     C                   EVAL      H@SUB# = 0
040300100623     C                   EVAL      H@ACCT = 0
040400100713     C                   EVAL      H@TC = *BLANKS
040500100623    ***
040600100623     C                   EVAL      @STEP = 'STEP5'
040700100622    ***
040800100622     C                   ENDSR
040900100622   S***S
041000100622     C     $STEP5        BEGSR
041100100622    ***
041200100622     C                   SETOFF                                       3536
041300100622    ***
041400100622     C                   CALL      'FTRC010'
041500100622     C                   PARM                    @15              15
041600100622     C                   MOVE      @15           FTUNIQUE
041700100622    ***
041800100622     C                   CLEAR                   @TIMESTAMP
041900100622     C                   MOVE      *BLANKS       @TS40
042000100622     C                   CALL      'TIMESTMP'
042100100622     C                   PARM                    @TS40
042200100622     C                   MOVEL     @TS40         @TIMESTAMP
042300100622     C                   EVAL      FTRCVUSR = @TSUSER
042400100622     C                   MOVE      #TSCYMD       FTRCVDT
042500100622     C                   MOVE      #TSTIME       FTRCVTM
042600100621    ***
042700100702     C                   MOVE      *ZEROS        SCCLSDT
042800100702     C                   MOVE      *ZEROS        SCRPTDTE
042900100625     C     *USA          MOVE      FTRCVDT       SCRCVDT
043000100622     C                   MOVE      *ZEROS        FTCLSTM
043100100622     C                   EVAL      FTCLSDT = D'0001-01-01'
043200100622     C                   EVAL      FTRPTDTE = D'0001-01-01'
043300100622    ***
043400100622     C                   IF        SCREPEAT = 'Y'
043500100622     C                   EVAL      FTGROUP = H@GROUP
043600100622     C                   EVAL      FTTRST = H@TRST
043700100622     C                   EVAL      FTSUB#  = H@SUB#
043800100622     C                   EVAL      FTACCT  = H@ACCT
043900100702     C                   SETOFF                                       34
044000100702     C                   ELSE
044100100702     C                   EVAL      FTGROUP = *BLANKS
044200100702     C                   EVAL      FTTRST = 0
044300100702     C                   EVAL      FTSUB#  = 0
044400100702     C                   EVAL      FTACCT  = 0
044500100702     C                   EVAL      SCREPEAT = 'N'
044600100702     C                   EVAL      H@GROUP = *BLANKS
044700100702     C                   EVAL      H@TRST = 0
044800100702     C                   EVAL      H@SUB# = 0
044900100702     C                   EVAL      H@ACCT = 0
045000100713     C                   EVAL      H@TC = *BLANKS
045100100702     C                   SETON                                        34
045200100622     C                   ENDIF
045300100622    ***
045400100715     C                   EVAL      FTTYPCOD = H@TC
045500100625     C                   EVAL      FTSSN = 0
045600100625     C                   EVAL      FTNAMEL = *BLANKS
045700100625     C                   EVAL      FTNAMEF = *BLANKS
045800100625     C                   EVAL      FTNAMEM = *BLANKS
045900100622     C                   EVAL      @STEP = 'STEP6'
046000100721     C                   EVAL      CONFRM = NO
046100100622    ***
046200100621     C                   ENDSR
046300100621   S***S
046400100622     C     $STEP6        BEGSR
046500100622    ***
046600100622     C                   EVAL      EMSG = @EMSG
046700100622     C                   EXFMT     FTRSCR
046800100622     C                   EVAL      EMSG = *BLANKS
046900100622     C                   EVAL      @EMSG = *BLANKS
047000100622    ***
047100100706     C                   IF        FKEY = F1
047200100622     C                   EVAL      @STEP = 'STEP1'
047300100622     C                   LEAVESR
047400100622     C                   ENDIF
047500100622    ***
047600100622     C                   EXSR      $VALID
047700100721    ***
047800100721     C                   IF        VALID_DTA = YES
047900100721     C                   IF        CONFRM = YES
048000100721     C                   EVAL      @STEP = 'STEP7'
048100100721     C                   LEAVESR
048200100721     C                   ELSE
048300100721     C                   EVAL      CONFRM = YES
048400100721     C                   ENDIF
048500100721     C                   ELSE
048600100721     C                   EVAL      CONFRM = NO
048700100721     C                   ENDIF
048800100622    ***
048900100622     C                   ENDSR
049000100622   S***S
049100100622     C     $VALID        BEGSR
049200100622    ***
049300100622     C                   EVAL      VALID_DTA = NO
049400100622    ***
049500100622     C                   IF        SCREPEAT = *BLANKS
049600100622     C                   EVAL      SCREPEAT = 'N'
049700100622     C                   ENDIF
049800100622    ***
049900100702     C                   IF        FTTYPCOD = *BLANKS
050000100702     C                   EVAL      @EMSG = 'TYPE CODE REQUIRED'
050100100702     C                   LEAVESR
050200100702     C                   ENDIF
050300100702    ***
050400100702     C                   IF        FTTYPCOD <> 'N' AND FTTYPCOD <> 'R'
050500100702     C                             AND FTTYPCOD <> 'M'
050600100713     C                             AND FTTYPCOD <> 'B'
050700100702     C                   EVAL      @EMSG = 'TYPE CODE IS INVALID'
050800100702     C                   LEAVESR
050900100702     C                   ENDIF
051000100715    ***
051100100715     C                   EVAL      H@TC = FTTYPCOD
051200100702    ***
051300100628     C                   IF        FTTRST > 0 AND FTSUB# > 0 AND
051400100628     C                             FTACCT > 0 AND
051500100628     C                             FTGROUP = *BLANKS
051600100628     C     KL#ACM        CHAIN     ACCMSR
051700100628     C                   IF        %FOUND(ACCMSTSP)
051800100628     C                   MOVEL(P)  ACNAM1        FTGROUP
051900100628     C                   ENDIF
052000100628     C                   ENDIF
052100100715    ***
052200100715     C                   IF        FTTRST = 0 AND FTSUB# = 0 AND
052300100715     C                             FTACCT = 0 AND
052400100715     C                             FTGROUP <> *BLANKS
052500100715     C     FTGROUP       CHAIN     BYNAMF
052600100715     C                   IF        %FOUND(ACCNAM)
052700100715     C                   EVAL      FTTRST = PACTRST
052800100715     C                   EVAL      FTSUB# = PACSUB#
052900100715     C                   EVAL      FTACCT = PACACCT
053000100715     C                   ENDIF
053100100715     C                   ENDIF
053200100622    ***
053300100715     C                   IF        FTGROUP = *BLANKS AND
053400100715     C                             FTTRST = 0 AND FTSUB# = 0 AND
053500100715     C                             FTACCT = 0
053600100715     C                   EVAL      @EMSG = 'SOME FORM OF GROUP ID IS REQUIRED' +
053700100715     C                             ' FOR ALL APPS.'
053800100715     C                   LEAVESR
053900100715     C                   ENDIF
054000100715    ***
054100100721     C                   IF        FTGROUP = *BLANKS OR
054200100721     C                             (FTTRST = 0 AND FTSUB# = 0 AND
054300100721     C                             FTACCT = 0)
054400100721     C                   EVAL      @EMSG = 'FYI - IT IS RECOMMENDED TO HAVE A' +
054500100721     C                             'LL PARTS OF ACCT INFO.'
054600100721     C                   ENDIF
054700100721    ***
054800100708     C     *LIKE         DEFINE    MBSSNO        ZZSSNO
054900100708     C                   IF        FTSSN <> 0 AND FTNAMEF = *BLANKS AND
055000100708     C                             FTNAMEL = *BLANKS AND
055100100708     C                             FTNAMEM = *BLANKS
055200100708     C                   Z-ADD     FTSSN         ZZSSNO
055300100708     C     ZZSSNO        CHAIN     MEMBR
055400100708     C                   IF        %FOUND(MEMBER)
055500100708     C                   MOVEL(P)  MFNAME        FTNAMEF
055600100708     C                   MOVEL(P)  MLNAME        FTNAMEL
055700100708     C                   MOVEL(P)  MMI           FTNAMEM
055800100708     C                   ENDIF
055900100708     C                   ENDIF
056000100715    ***
056100100715     C                   IF        FTSSN = 0 AND FTNAMEF <> *BLANKS AND
056200100715     C                             FTNAMEL <> *BLANKS
056300100715     C     KL#NAM        KLIST
056400100715     C                   KFLD                    QLNAM            18
056500100715     C                   KFLD                    QFNAM            12
056600100715     C                   KFLD                    QMMI              1
056700100715     C                   MOVEL(P)  FTNAMEL       QLNAM
056800100715     C                   MOVEL(P)  FTNAMEF       QFNAM
056900100715     C                   MOVEL(P)  FTNAMEM       QMMI
057000100715     C     KL#NAM        CHAIN     MNAMF
057100100715     C                   IF        %FOUND(MEMBER)
057200100715     C                   MOVE      IMBSSNO       FTSSN
057300100715     C                   ENDIF
057400100715     C                   ENDIF
057500100628    ***
057600100721     C                   IF        FTSSN = 0 OR FTNAMEL = *BLANKS OR
057700100721     C                             FTNAMEF = *BLANKS
057800100723     C                   EVAL      @EMSG = 'SSN AND MEMBER NAME ARE REQUIRED.'
057900100715     C                   LEAVESR
058000100715     C                   ENDIF
058100100715    ***
058200100702     C                   IF        @MODE = 'ADD'
058300100628     C                   IF        FTSSN > 0
058400100628     C                   EXSR      $DUPECHK
058500100723     C                   IF        DUPE_DATA = YES
058600100628     C                   LEAVESR
058700100628     C                   ENDIF
058800100702     C                   ENDIF
058900100628     C                   ENDIF
059000100623    ***
059100100702     C                   IF        SCRCVDT = 0
059200100702     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
059300100702     C                   LEAVESR
059400100702     C                   ENDIF
059500100702     C     *USA          TEST(DE)                SCRCVDT
059600100702     C                   IF        %ERROR
059700100702     C                   EVAL      @EMSG = 'VALID RECIEVE DATE PLEASE.'
059800100702     C                   LEAVESR
059900100702     C                   ENDIF
060000100702     C                   MOVE      SCRCVDT       #USA
060100100702     C                   MOVE      #USA          #ISO
060200100702     C                   MOVE      #ISO          FTRCVDT
060300100622    ***
060400100623     C                   IF        FTRCVTM = 000000
060500100623     C                   EVAL      @EMSG = 'VALID RECIEVE TIME PLEASE.'
060600100623     C                   LEAVESR
060700100623     C                   ENDIF
060800100623    ***
060900100622     C                   EVAL      VALID_DTA = YES
061000100622    ***
061100100622     C                   ENDSR
061200100622   S***S
061300100628     C     $DUPECHK      BEGSR
061400100628    ***
061500100723     C                   EVAL      DUPE_DATA = NO
061600100723    ***
061700100628     C                   EVAL      KF@SSN = FTSSN
061800100628     C     KL#L2B        CHAIN     FMTSSN
061900100628     C                   IF        NOT %FOUND(FRMTRKL2)
062000100628     C                   LEAVESR
062100100628     C                   ENDIF
062200100628    ***
062300100628     C     KL#L2B        SETLL     FMTSSN
062400100628     C                   DOU       %EOF(FRMTRKL2)
062500100628     C     KL#L2B        READE     FMTSSN
062600100628     C                   IF        NOT %EOF(FRMTRKL2)
062700100811     C                   IF        ZXCLSDT = D'0001-01-01'
062800100628     C                   EVAL      @EMSG = 'OPEN APP EXISTS, ADD DENIED.'
062900100723     C                   EVAL      DUPE_DATA = YES
063000100723    ***
063100100628     C                   LEAVESR
063200100628     C                   ENDIF
063300100628     C                   ENDIF
063400100628     C                   ENDDO
063500100628    ***
063600100628     C                   ENDSR
063700100628   S***S
063800100622     C     $STEP7        BEGSR
063900100622    ***
064000100622     C                   EVAL      DS@UNQ = DS@ALL
064100100622     C                   WRITE     FMTUNQ
064200100622    ***
064300100622     C                   IF        SCREPEAT = 'Y'
064400100622     C                   EVAL      H@GROUP = XXGROUP
064500100623     C                   EVAL      H@TRST = XXTRST
064600100622     C                   EVAL      H@SUB#  = XXSUB#
064700100622     C                   EVAL      H@ACCT  = XXACCT
064800110725     C                   EVAL      *IN34 = *OFF
064900100622     C                   ENDIF
065000100622    ***
065100100622     C                   EVAL      @STEP = 'STEP5'
065200100721     C                   EVAL      @EMSG = 'APP ADDED, GOOD JOB.'
065300100622    ***
065400100622     C                   ENDSR
065500100622   S***S
065600100623     C     $CHKSEL       BEGSR
065700100623    ***
065800100624    1C                   DOU       %EOF(FTRD020)
065900100624     C                   READC     FTRSFL
066000100624    2C                   IF        NOT %EOF(FTRD020) AND SEL <> *BLANKS
066100100623    ***
066200100708     C                   EVAL      DCLSCODE = *BLANKS
066300100708    ***
066400100713    3C                   IF        SEL = 'D'
066500100702     C                   MOVE      'DSP'         @MODE
066600100623     C                   EXSR      $DSPREC
066700100623     C                   ITER
066800100623    3C                   ENDIF
066900100623    ***
067000100726    3C                   IF        SEL = 'C'
067100100702     C                   MOVE      'CHG'         @MODE
067200100623     C                   EXSR      $MNTREC
067300100623     C                   EVAL      @STEP = 'STEP1'
067400100623     C                   ITER
067500100623    3C                   ENDIF
067600100623    ***
067700100623     C                   ENDIF
067800100623     C                   ENDDO
067900100623    ***
068000100623     C                   ENDSR
068100100622   S***S
068200100623     C     $DSPREC       BEGSR
068300100623    ***
068400100623     C     HUNIQ         CHAIN(N)  FMTUNQ
068500100623     C                   IF        NOT %FOUND(FRMTRKP)
068600100623     C                   LEAVESR
068700100623     C                   ENDIF
068800100623    ***
068900100708     C                   EVAL      DS@ALL = DS@UNQ
069000100708      *
069100100623     C                   MOVEA     '010'         *IN(34)
069200100623     C     *USA          MOVE      FTRPTDTE      SCRPTDTE
069300100623     C     *USA          MOVE      FTRCVDT       SCRCVDT
069400100623     C     *USA          MOVE      FTCLSDT       SCCLSDT
069500100708    * *
069600100713     C                   IF        SCCLSDT = 01010001
069700100713     C                   EVAL      SCCLSDT = 0
069800100713     C                   ENDIF
069900100713     C                   IF        SCRCVDT = 01010001
070000100713     C                   EVAL      SCRCVDT = 0
070100100713     C                   ENDIF
070200100713     C                   IF        SCRPTDTE = 01010001
070300100713     C                   EVAL      SCRPTDTE = 0
070400100713     C                   ENDIF
070500100623    ***
070600100623     C                   IF        FTCLSCOD <> *BLANKS
070700100623     C     FTCLSCOD      CHAIN     FTRW020R
070800100623     C                   IF        %FOUND(FTRW020)
070900100623     C                   EVAL      DCLSCODE = F2DESC
071000100623     C                   ELSE
071100100623     C                   MOVE      *BLANKS       DCLSCODE
071200100623     C                   ENDIF
071300100623     C                   ENDIF
071400100623    ***
071500100706     C                   DOU       FKEY = F1
071600100623     C                   EXFMT     FTRSCR
071700100623    *C                   ENDDO
071800100702    ***
071900100702     C                   EVAL      @STEP = 'STEP1'
072000100623    ***
072100100623     C                   ENDSR
072200100622   S***S
072300100622     C     $MNTREC       BEGSR
072400100622    ***
072500100622     C     HUNIQ         CHAIN     FMTUNQ
072600100622     C                   IF        NOT %FOUND(FRMTRKP)
072700100622     C                   LEAVESR
072800100622     C                   EVAL      *IN36 = *OFF
072900100622     C                   ENDIF
073000100623    ***
073100100623     C                   EXSR      $FMTSCR
073200100622    ***
073300100706     C                   DOU       FKEY = F1
073400100622     C                   EXSR      $SCREEN
073500100622    *C                   ENDDO
073600100622    ***
073700100622     C     HUNIQ         CHAIN(N)  FMTUNQ
073800100715     C                   EVAL      @STEP = 'STEP1'
073900100623    ***
074000100623     C                   ENDSR
074100100623   S***S
074200100623     C     $FMTSCR       BEGSR
074300100623    ***
074400100624     C                   EVAL      DS@ALL = DS@UNQ
074500100624      *
074600100702     C     *USA          MOVE      XXRPTDTE      SCRPTDTE
074700100702     C     *USA          MOVE      XXRCVDT       SCRCVDT
074800100702     C     *USA          MOVE      XXCLSDT       SCCLSDT
074900100623    * *
075000100623     C                   IF        XXRPTDTE = D'0001-01-01'
075100100623     C                   EVAL      *IN35 = *OFF
075200100623     C                   ELSE
075300100715
075400100623     C                   ENDIF
075500100623    * *
075600100623     C                   EVAL      *IN36 = *OFF
075700100622    ***
075800100622     C                   ENDSR
075900100622   S***S
076000100622     C     $SCREEN       BEGSR
076100100702    ***
076200100702     C                   IF        SCCLSDT = 01010001
076300100702     C                   EVAL      SCCLSDT = 0
076400100702     C                   ENDIF
076500100702     C                   IF        SCRCVDT = 01010001
076600100702     C                   EVAL      SCRCVDT = 0
076700100702     C                   ENDIF
076800100702     C                   IF        SCRPTDTE = 01010001
076900100702     C                   EVAL      SCRPTDTE = 0
077000100702     C                   ENDIF
077100100622    ***
077200100623     C                   EVAL      EMSG = @EMSG
077300100623     C                   EXFMT     FTRSCR
077400100623     C                   EVAL      @EMSG = *BLANKS
077500100702    ***
077600100702     C                   IF        SCCLSDT = 0
077700100702     C                   EVAL      SCCLSDT = 01010001
077800100702     C                   ENDIF
077900100702     C                   IF        SCRCVDT = 0
078000100702     C                   EVAL      SCRCVDT = 01010001
078100100702     C                   ENDIF
078200100702     C                   IF        SCRPTDTE = 0
078300100702     C                   EVAL      SCRPTDTE = 01010001
078400100702     C                   ENDIF
078500100623    ***
078600100719     C                   IF        FKEY = F8
078700100719     C     HUNIQ         CHAIN(N)  FMTUNQ
078800100719     C                   EVAL      @PRM15 = HUNIQ
078900100719     C                   CALL      'FTRC022'
079000100719     C                   PARM                    @PRM15           15
079100100719     C                   EVAL      FKEY = F1
079200100623     C                   LEAVESR
079300100623     C                   ENDIF
079400100622    ***
079500100713     C                   IF        FKEY = F4
079600100713     C                   CALL      'FTRC021'
079700100713     C                   PARM                    @PRM              3
079800100721     C                   IF        @PRM <> '*LR'
079900100713     C                   EVAL      FTCLSCOD = @PRM
080000100812     C                   IF        SCCLSDT = 0 OR SCCLSDT = 01010001
080100100721     C                   CLEAR                   @TIMESTAMP
080200100721     C                   MOVE      *BLANKS       @TS40
080300100721     C                   CALL      'TIMESTMP'
080400100721     C                   PARM                    @TS40
080500100721     C                   MOVEL     @TS40         @TIMESTAMP
080600100721     C                   EVAL      FTCLSUSR = @TSUSER
080700100721     C                   MOVE      #TSCYMD       FTCLSDT
080800100812     C                   MOVE      #TSCYMD       #ISO
080900100812     C     *USA          MOVE      #ISO          SCCLSDT
081000100721     C                   MOVE      #TSTIME       FTCLSTM
081100100713     C                   ENDIF
081200100713     C                   ENDIF
081300100713     C                   ENDIF
081400100719    ***
081500100719     C                   IF        FKEY = F1
081600100719     C     HUNIQ         CHAIN     FMTUNQ
081700100719     C                   LEAVESR
081800100719     C                   ENDIF
081900100713    ***
082000100812     C                   IF        (SCCLSDT = 0 OR SCCLSDT = 01010001)
082100100812     C                             AND FTCLSCOD <> *BLANKS
082200100713    *C                   CLEAR                   @TIMESTAMP
082300100713    *C                   MOVE      *BLANKS       @TS40
082400100713    *C                   CALL      'TIMESTMP'
082500100713    *C                   PARM                    @TS40
082600100713    *C                   MOVEL     @TS40         @TIMESTAMP
082700100713    *C                   EVAL      FTCLSUSR = @TSUSER
082800100713    *C                   MOVE      #TSCYMD       FTCLSDT
082900100812     C                   MOVE      #TSCYMD       #ISO
083000100812     C     *USA          MOVE      #ISO          SCCLSDT
083100100713    *C                   MOVE      #TSTIME       FTCLSTM
083200100713     C                   ENDIF
083300100713    ***
083400100721     C                   EXSR      $VALID
083500100721     C                   IF        VALID_DTA = YES
083600100721     C                   IF        CONFRM = YES
083700100721     C                   EXSR      $UPDMNT
083800100721     C                   LEAVESR
083900100721     C                   ELSE
084000100721     C                   EVAL      CONFRM = YES
084100100721     C                   ENDIF
084200100721     C                   ELSE
084300100721     C                   EVAL      CONFRM = NO
084400100721     C                   ENDIF
084500100721    ***
084600100721     C                   ENDSR
084700100721   S***S
084800100721     C     $UPDMNT       BEGSR
084900100721    ***
085000100623     C                   EVAL      *IN36 = *ON
085100100812     C*                  MOVE      SCCLSDT       #USA
085200100812     C*                  MOVE      #USA          #ISO
085300100812     C*                  MOVE      #ISO          FTCLSDT
085400100702     C                   EVAL      DS@UNQ = DS@ALL
085500100702     C                   UPDATE    FMTUNQ
085600100721     C                   EVAL      FKEY = F1
085700100721     C                   EVAL      @EMSG = 'UPDATE COMPLETED.'
085800100623    ***
085900100622     C                   ENDSR
086000100622   S***S
