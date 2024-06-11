000100991124     F*-------------------------------------------------------------------------
000200040708     F* IQR141     GBS SOFTWARE 2003   FM12* AGENCY MASTER APPLICATION
000300991124     F*            WRITTEN BY - S.S.K.
000400030514     F*            DATE - 05/03
000500030514     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR AGENCY MASTER MAINT
000600991124     F*  INDICATOR USAGE:
000700020208     F*    01 = EXIT FROM INITIAL SCREEN
000800000211     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900991124     F*    25 = SFLDSP
001000991124     F*    26 = SFL DSP CTL
001100991124     F*    27 = SFL CLR
001200991124     F*
001300991124     F*-------------------------------------------------------------------------
001400991209     ** MODIFICATION HISTORY                                              **
001500991209     ** ###  UUU  MMDDCCYY  X---->                                        **
001600030514     ** 000  SSK  05142003  ORIGINAL SOURCE                               **
001700040708     ** ***  SSK  01022004  COPY FM122 TO IQ                              **
001800991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900030514     FAGCHIST1  IF   E           K DISK    RENAME(RAGCHIST:BEFSEQ)
002000030514     FAGCHIST2  IF   E           K DISK    RENAME(RAGCHIST:AFTSEQ)
002100020612     FGBSECURE  IF   E           K DISK
002200040708     FIQR141D   CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002300991124   X***X
002400020614     D P@3             S              3A
002500020614     D P@4             S              4A
002600030514     D KEY@AGC         S              3A
002700020612     D KEY@DTE         S              8S 0
002800020208     D KEY@USR         S                   LIKE(SCUSR)
002900001019    ***
003000001019     D #ISO            S               D   DATFMT(*ISO)
003100001019     D #USA            S               D   DATFMT(*USA)
003200020208     D #ISA            S              8S 0
003300000211    ***
003400991216     D WSDS            DS
003500991216     D  FKEY                 369    369A
003600991216    ***
003700991216     D  F1             C                   CONST(X'31')
003800991216     D  F2             C                   CONST(X'32')
003900991216     D  F3             C                   CONST(X'33')
004000991216     D  F4             C                   CONST(X'34')
004100991216     D  F5             C                   CONST(X'35')
004200991216     D  F6             C                   CONST(X'36')
004300991216     D  F7             C                   CONST(X'37')
004400991216     D  F8             C                   CONST(X'38')
004500991216     D  F9             C                   CONST(X'39')
004600991216     D  F10            C                   CONST(X'3A')
004700991216     D  F11            C                   CONST(X'3B')
004800991216     D  F12            C                   CONST(X'3C')
004900991216     D  F13            C                   CONST(X'B1')
005000991216     D  F14            C                   CONST(X'B2')
005100991216     D  F15            C                   CONST(X'B3')
005200991216     D  F16            C                   CONST(X'B4')
005300991216     D  F17            C                   CONST(X'B5')
005400991216     D  F18            C                   CONST(X'B6')
005500991216     D  F19            C                   CONST(X'B7')
005600991216     D  F20            C                   CONST(X'B8')
005700991216     D  F21            C                   CONST(X'B9')
005800991216     D  F22            C                   CONST(X'BA')
005900991216     D  F23            C                   CONST(X'BB')
006000991216     D  F24            C                   CONST(X'BC')
006100020208    ***
006200020208     D @STEP           S              5A
006300020208    ***
006400030514     D DS@LOD        E DS                  EXTNAME(AGCHIST0)
006500030401    ***
006600030514     D DS@B4         E DS                  EXTNAME(AGENCY) PREFIX(BB:2)
006700040708     D BTRAN                 215    230A
006800030401    ***
006900030514     D DS@AF         E DS                  EXTNAME(AGENCY) PREFIX(AA:2)
007000040708     D ATRAN                 215    230A
007100020208    ***
007200030514     D @DTA50          S             50A
007300991124   X***X
007400020208      /FREE
007500030514         O_AGCY = P@3;
007600020612         KEY@DTE = 00010101;
007700030514         KEY@AGC = P@3;
007800020614         @STEP = 'PREP1';
007900020208      /END-FREE
008000030514    ***
008100020208    *C                   DOU       @STEP = 'LEAVE'
008200020208    *C     @STEP         CASEQ     'PREP1'       $PREP1
008300020208    *C     @STEP         CASEQ     'STEP1'       $STEP1
008400020208    *C                   ENDCS
008500020208    *C                   ENDDO
008600020208    *C                   EVAL      *INLR = *ON
008700020208  *S***S
008800020208     C* ONETIME ROUTINE
008900020208    ***
009000020208     C     *INZSR        BEGSR
009100020208    ***
009200020208     C     *ENTRY        PLIST
009300020614     C                   PARM                    P@3
009400020208    ***
009500020612     C     KEY#SHST      KLIST
009600030514     C                   KFLD                    KEY@AGC
009700020612     C                   KFLD                    KEY@DTE
009800020208    ***
009900020208     C                   MOVE      *ZEROS        RRT               3 0
010000020208     C                   MOVE      *ZEROS        #CNTREC           2 0
010100020208    ***
010200020208     C                   MOVE      '0'           @1STLOOP          1
010300020208     C                   MOVE      '0'           @SFLOOP           1
010400020208    *C*                  MOVE      '0'           @CNFRM            1
010500020208     C                   MOVE      '1'           @LOOPIT           1
010600020208     C                   MOVE      '0'           @ACTION           1
010700020208     C                   MOVE      'M'           @SEQ              1
010800020208    ***
010900020208     C                   ENDSR
011000020208  *S***S
011100020208     C     $PREP1        BEGSR
011200020208    ***
011300020208     C                   EXSR      $CLEAR
011400020208    *C*
011500020208     C                   EXSR      $BUILD
011600020208    *C*
011700020208     C                   EVAL      @STEP = 'STEP1'
011800020208    ***
011900020208     C                   ENDSR
012000020208  *S***S
012100020208     C     $CLEAR        BEGSR
012200020208    ***
012300020208     C                   MOVEA     '011'         *IN(25)
012400020208     C                   WRITE     GBSCTL
012500020208     C                   MOVEA     '010'         *IN(25)
012600020208     C                   Z-ADD     *ZERO         RRT
012700020208    ***
012800020208     C                   ENDSR
012900020208   S***S
013000020208     C     $BUILD        BEGSR
013100020208    ***
013200020208     C                   EXSR      $CLEAR
013300020208     C                   MOVE      *ZEROS        #CNTREC
013400020208     C                   MOVE      '0'           @1STLOOP
013500020208     C                   MOVE      '0'           @SFLOOP
013600020208    ***
013700020208     C                   IF        @SEQ = 'M'
013800020612     C     KEY#SHST      SETLL     BEFSEQ
013900020208     C                   EXSR      $BLDBEF
014000020208     C                   ELSE
014100020612     C     KEY#SHST      SETLL     AFTSEQ
014200020208     C                   EXSR      $BLDAFT
014300020208     C                   ENDIF
014400020614    ***
014500020614     C                   EVAL      I_DTE = 0
014600020208    ***
014700020208     C                   ENDSR
014800020208   S***S
014900020208     C* BUILD BY BEFORE IMAGE
015000020208    ***
015100020208     C     $BLDBEF       BEGSR
015200020208    ***
015300030514     C                   DOU       %EOF(AGCHIST1) OR @SFLOOP = '1'
015400030514     C     KEY@AGC       READE     BEFSEQ
015500030514     C                   IF        NOT %EOF(AGCHIST1)
015600020208     C                   EXSR      $LOADSFL
015700020208     C                   ENDIF
015800020208     C                   ENDDO
015900020208    ***
016000020208     C                   ENDSR
016100020208   S***S
016200020208     C     $LOADSFL      BEGSR
016300020208    ***
016400020208     C                   MOVE      *ON           *IN25
016500020208    ***
016600020208     C                   EVAL      HDATA = DS@LOD
016700020208     C                   MOVE      *BLANKS       SEL01
016800030514     C                   EVAL      SFNAM1 = %SUBST(HAFTER:4:30)
016900020208     C*
017000020208     C                   MOVEL(P)  HUSERID       KEY@USR
017100020208     C     KEY@USR       CHAIN     SECR
017200020208     C                   IF        %FOUND(GBSECURE)
017300020208     C                   MOVEL(P)  SCNAME        SFUSERID
017400020208     C                   ELSE
017500020208     C                   MOVE      *BLANKS       SFUSERID
017600020208     C                   END
017700020208     C*
017800020208     C                   MOVE      HDATE         #ISO
017900020208     C                   MOVE      #ISO          #USA
018000020208     C                   MOVE      #USA          SFDATE
018100020208     C                   Z-ADD     HTIME         SFTIME
018200020208     C*
018300020208     C                   ADD       1             RRT
018400020208     C                   IF        @1STLOOP = '0'
018500020208     C                   Z-ADD     RRT           SFLPOS
018600020208     C                   MOVE      '1'           @1STLOOP
018700020208     C                   ENDIF
018800020208     C*
018900020208     C                   WRITE     GBSSFL
019000020208    ***
019100020208     C                   ENDSR
019200020208   S***S
019300020208     C     $BLDAFT       BEGSR
019400020208     C*
019500030514     C                   DOU       %EOF(AGCHIST2) OR @SFLOOP = '1'
019600030514     C     KEY@AGC       READE     AFTSEQ
019700030514     C                   IF        NOT %EOF(AGCHIST2)
019800020208     C                   EXSR      $LOADSFL
019900020208     C                   ENDIF
020000020208     C                   ENDDO
020100020208    ***
020200020208     C                   ENDSR
020300020208   S***S
020400020208     C     $STEP1        BEGSR
020500020208    ***
020600020208     C                   EXSR      $DISPLAY
020700020208    ***
020800020208     C                   IF        FKEY = F1
020900020208     C                   EVAL      @STEP = 'LEAVE'
021000020208     C                   LEAVESR
021100020208     C                   ENDIF
021200020208    ***
021300020208     C                   IF        FKEY = F8
021400020208     C                   IF        @SEQ = 'M'
021500020208     C                   MOVE      'X'           @SEQ
021600040708     C                   Z-ADD     99999999      KEY@DTE
021700020208     C                   ELSE
021800020208     C                   MOVE      'M'           @SEQ
021900040708     C                   Z-ADD     1             KEY@DTE
022000020208     C                   ENDIF
022100020208     C                   EVAL      @STEP = 'PREP1'
022200020208     C                   LEAVESR
022300020208     C                   ENDIF
022400020614    ***
022500020614     C                   IF        I_DTE <> 0
022600040708     C     I_DTE         MULT      10000.0001    KEY@DTE
022700020614     C                   EVAL      @STEP = 'PREP1'
022800020614     C                   LEAVESR
022900020614     C                   ENDIF
023000020208    ***
023100020214     C                   IF        RRT > 0
023200020208     C                   EXSR      $CHKSELC
023300020214     C                   ENDIF
023400020208    ***
023500020208     C                   ENDSR
023600991124   S***S
023700991124     C     $DISPLAY      BEGSR
023800991124    ***
023900000211     C                   WRITE     GBSREC
024000000211     C                   EXFMT     GBSCTL
024100991124    ***
024200991124     C                   ENDSR
024300000113   S***S
024400020208    SC     $CHKSELC      BEGSR
024500020208     C*
024600040708    1C                   DOU       %EOF(IQR141D)
024700020214     C                   READC(E)  GBSSFL
024800040708    2C                   IF        NOT %EOF(IQR141D) AND SEL01 = 'X' AND
024900020214     C                             NOT %ERROR
025000020208     C                   EXSR      $DSPCTL
025100020208     C                   EVAL      SEL01 = *BLANKS
025200020208     C                   UPDATE    GBSSFL
025300020208    3C                   ENDIF
025400020208    1C                   ENDDO
025500020208    ***
025600020208    SC                   ENDSR
025700020208   S***S
025800020208    SC     $DSPCTL       BEGSR
025900020208    ***
026000020208     C                   EXSR      $FMTDSP
026100020208    ***
026200020208     C                   DOU       FKEY = F1
026300021203     C*
026400020208     C                   EXFMT     EXPNDSCRA
026500021203     C*
026600020208    1C                   ENDDO
026700020208     C                   CLEAR                   FKEY
026800020208    ***
026900020208    SC                   ENDSR
027000020208   S***S
027100020208    SC     $FMTDSP       BEGSR
027200020208    ***
027300021203     C                   EVAL      *IN30 = *OFF
027400020612     C                   Z-ADD     41            ZZ
027500020612     C                   DO        20
027600020306     C                   ADD       1             ZZ                2 0
027700020306     C                   EVAL      *IN(ZZ) = *OFF
027800020306     C                   ENDDO
027900020614    ***
028000020614     C                   MOVEL(P)  HUSERID       KEY@USR
028100020614     C     KEY@USR       CHAIN     SECR
028200020614     C                   IF        %FOUND(GBSECURE)
028300020614     C                   MOVEL(P)  SCNAME        GBSUSER
028400020614     C                   ELSE
028500020614     C                   MOVE      *BLANKS       GBSUSER
028600020614     C                   END
028700020306    ***
028800020208      /FREE
028900020208       DS@LOD = HDATA;
029000020208       DS@B4 = HBEFORE;
029100020208       DS@AF = HAFTER;
029200030514       IF BBNAM1     <> AANAM1;
029300020612         *IN41 = *ON;
029400020208       ENDIF;
029500030514       IF BBNAM2     <> AANAM2;
029600020612         *IN42 = *ON;
029700020306       ENDIF;
029800030514       IF BBADD1     <> AAADD1;
029900020612         *IN43 = *ON;
030000020306       ENDIF;
030100030514       IF BBADD2     <> AAADD2;
030200020612         *IN44 = *ON;
030300020306       ENDIF;
030400030514       IF BBCITY     <> AACITY;
030500020612         *IN45 = *ON;
030600020306       ENDIF;
030700030519       IF (BBSTAT <> AASTAT) OR (BBZIP5 <> AAZIP5) OR (BBZIP4 <> AAZIP4);
030800030514         IF BBZIP5 <> 0;
030900030514           EVAL BBZIPX = (BBZIP5 * 10000) + BBZIP4;
031000030514         ENDIF;
031100030514         IF AAZIP5 <> 0;
031200030514           EVAL AAZIPX = (AAZIP5 * 10000) + AAZIP4;
031300030514         ENDIF;
031400030514         *IN46 = *ON;
031500020306       ENDIF;
031600030514       IF BBTXID <> AATXID;
031700030514         *IN47 = *ON;
031800020306       ENDIF;
031900030514       IF BBACH <> AAACH;
032000020612         *IN48 = *ON;
032100020306       ENDIF;
032200030514       IF (BBTLX3 <> AATLX3) OR (BBTLX7 <> AATLX7);
032300020612         *IN49 = *ON;
032400020306       ENDIF;
032500030514       IF (BBFAX3 <> AAFAX3) OR (BBFAX7 <> AAFAX7);
032600030514         *IN50 = *ON;
032700020306       ENDIF;
032800030514       IF BBCONT <> AACONT;
032900030514         *IN53 = *ON;
033000021203       ENDIF;
033100020208      /END-FREE
033200040708     C     ' ':'0'       XLATE     BTRAN         BTRAN
033300040708     C     ' ':'0'       XLATE     ATRAN         ATRAN
033400030514     C                   IF        BBEFDT <> AAEFDT
033500030514     C                   EVAL      *IN51 = *ON
033600030514     C                   IF        BBEFDT > 0
033700030514     C     BBEFDT        MULT      10000.0001    BBEFDT
033800020220     C                   ENDIF
033900030514     C                   IF        AAEFDT > 0
034000030514     C     AAEFDT        MULT      10000.0001    AAEFDT
034100030514     C                   ENDIF
034200020220     C                   ENDIF
034300020614    ***
034400020614     C                   MOVE      HDATE         #ISO
034500020614     C                   MOVE      #ISO          #USA
034600020614     C                   MOVE      #USA          HDATE
034700020208    ***
034800030514     C                   IF        BBTMDT <> AATMDT
034900030519     C                   EVAL      *IN52 = *ON
035000030514     C                   IF        BBTMDT > 0
035100030514     C     BBTMDT        MULT      10000.0001    BBTMDT
035200030514     C                   ENDIF
035300030514     C                   IF        AATMDT > 0
035400030514     C     AATMDT        MULT      10000.0001    AATMDT
035500030514     C                   ENDIF
035600030514     C                   ENDIF
035700020612    ***
035800020208    SC                   ENDSR
035900020208   S***S
