000100991124     F*-------------------------------------------------------------------------
000200030514     F* FM122      GBS SOFTWARE 2003   FM12* AGENCY MASTER APPLICATION
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
001700991209     **                                                                   **
001800991209     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
001900030514     FAGCHIST1  IF   E           K DISK    RENAME(RAGCHIST:BEFSEQ)
002000030514     FAGCHIST2  IF   E           K DISK    RENAME(RAGCHIST:AFTSEQ)
002100020612     FGBSECURE  IF   E           K DISK
002200030514     FFM122D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
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
003400000211     D                UDS
003500000211     D  TITLE                201    240A
003600000211    ***
003700991216     D WSDS            DS
003800991216     D  FKEY                 369    369A
003900991216    ***
004000991216     D  F1             C                   CONST(X'31')
004100991216     D  F2             C                   CONST(X'32')
004200991216     D  F3             C                   CONST(X'33')
004300991216     D  F4             C                   CONST(X'34')
004400991216     D  F5             C                   CONST(X'35')
004500991216     D  F6             C                   CONST(X'36')
004600991216     D  F7             C                   CONST(X'37')
004700991216     D  F8             C                   CONST(X'38')
004800991216     D  F9             C                   CONST(X'39')
004900991216     D  F10            C                   CONST(X'3A')
005000991216     D  F11            C                   CONST(X'3B')
005100991216     D  F12            C                   CONST(X'3C')
005200991216     D  F13            C                   CONST(X'B1')
005300991216     D  F14            C                   CONST(X'B2')
005400991216     D  F15            C                   CONST(X'B3')
005500991216     D  F16            C                   CONST(X'B4')
005600991216     D  F17            C                   CONST(X'B5')
005700991216     D  F18            C                   CONST(X'B6')
005800991216     D  F19            C                   CONST(X'B7')
005900991216     D  F20            C                   CONST(X'B8')
006000991216     D  F21            C                   CONST(X'B9')
006100991216     D  F22            C                   CONST(X'BA')
006200991216     D  F23            C                   CONST(X'BB')
006300991216     D  F24            C                   CONST(X'BC')
006400020208    ***
006500020208     D @STEP           S              5A
006600020208    ***
006700030514     D DS@LOD        E DS                  EXTNAME(AGCHIST0)
006800030401    ***
006900030514     D DS@B4         E DS                  EXTNAME(AGENCY) PREFIX(BB:2)
007000030401    ***
007100030514     D DS@AF         E DS                  EXTNAME(AGENCY) PREFIX(AA:2)
007200020208    ***
007300030514     D @DTA50          S             50A
007400991124   X***X
007500020208      /FREE
007600030514         O_AGCY = P@3;
007700020612         KEY@DTE = 00010101;
007800030514         KEY@AGC = P@3;
007900020614         @STEP = 'PREP1';
008000020208      /END-FREE
008100030514    ***
008200030514     C     *DTAARA       DEFINE    COMPANY       @DTA50
008300030514     C                   IN        @DTA50
008400030514     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
008500030514    ***
008600020208    *C                   DOU       @STEP = 'LEAVE'
008700020208    *C     @STEP         CASEQ     'PREP1'       $PREP1
008800020208    *C     @STEP         CASEQ     'STEP1'       $STEP1
008900020208    *C                   ENDCS
009000020208    *C                   ENDDO
009100020208    *C                   EVAL      *INLR = *ON
009200020208  *S***S
009300020208     C* ONETIME ROUTINE
009400020208    ***
009500020208     C     *INZSR        BEGSR
009600020208    ***
009700020208     C     *ENTRY        PLIST
009800020614     C                   PARM                    P@3
009900020208    ***
010000020612     C     KEY#SHST      KLIST
010100030514     C                   KFLD                    KEY@AGC
010200020612     C                   KFLD                    KEY@DTE
010300020208    ***
010400020208     C                   MOVE      *ZEROS        RRT               3 0
010500020208     C                   MOVE      *ZEROS        #CNTREC           2 0
010600020208    ***
010700020208     C                   MOVE      '0'           @1STLOOP          1
010800020208     C                   MOVE      '0'           @SFLOOP           1
010900020208    *C*                  MOVE      '0'           @CNFRM            1
011000020208     C                   MOVE      '1'           @LOOPIT           1
011100020208     C                   MOVE      '0'           @ACTION           1
011200020208     C                   MOVE      'M'           @SEQ              1
011300020208    ***
011400020208     C                   ENDSR
011500020208  *S***S
011600020208     C     $PREP1        BEGSR
011700020208    ***
011800020208     C                   EXSR      $CLEAR
011900020208    *C*
012000020208     C                   EXSR      $BUILD
012100020208    *C*
012200020208     C                   EVAL      @STEP = 'STEP1'
012300020208    ***
012400020208     C                   ENDSR
012500020208  *S***S
012600020208     C     $CLEAR        BEGSR
012700020208    ***
012800020208     C                   MOVEA     '011'         *IN(25)
012900020208     C                   WRITE     GBSCTL
013000020208     C                   MOVEA     '010'         *IN(25)
013100020208     C                   Z-ADD     *ZERO         RRT
013200020208    ***
013300020208     C                   ENDSR
013400020208   S***S
013500020208     C     $BUILD        BEGSR
013600020208    ***
013700020208     C                   EXSR      $CLEAR
013800020208     C                   MOVE      *ZEROS        #CNTREC
013900020208     C                   MOVE      '0'           @1STLOOP
014000020208     C                   MOVE      '0'           @SFLOOP
014100020208    ***
014200020208     C                   IF        @SEQ = 'M'
014300020612     C     KEY#SHST      SETLL     BEFSEQ
014400020208     C                   EXSR      $BLDBEF
014500020208     C                   ELSE
014600020612     C     KEY#SHST      SETLL     AFTSEQ
014700020208     C                   EXSR      $BLDAFT
014800020208     C                   ENDIF
014900020614    ***
015000020614     C                   EVAL      I_DTE = 0
015100020208    ***
015200020208     C                   ENDSR
015300020208   S***S
015400020208     C* BUILD BY BEFORE IMAGE
015500020208    ***
015600020208     C     $BLDBEF       BEGSR
015700020208    ***
015800030514     C                   DOU       %EOF(AGCHIST1) OR @SFLOOP = '1'
015900030514     C     KEY@AGC       READE     BEFSEQ
016000030514     C                   IF        NOT %EOF(AGCHIST1)
016100020208     C                   EXSR      $LOADSFL
016200020208     C                   ENDIF
016300020208     C                   ENDDO
016400020208    ***
016500020208     C                   ENDSR
016600020208   S***S
016700020208     C     $LOADSFL      BEGSR
016800020208    ***
016900020208     C                   MOVE      *ON           *IN25
017000020208    ***
017100020208     C                   EVAL      HDATA = DS@LOD
017200020208     C                   MOVE      *BLANKS       SEL01
017300030514     C                   EVAL      SFNAM1 = %SUBST(HAFTER:4:30)
017400020208     C*
017500020208     C                   MOVEL(P)  HUSERID       KEY@USR
017600020208     C     KEY@USR       CHAIN     SECR
017700020208     C                   IF        %FOUND(GBSECURE)
017800020208     C                   MOVEL(P)  SCNAME        SFUSERID
017900020208     C                   ELSE
018000020208     C                   MOVE      *BLANKS       SFUSERID
018100020208     C                   END
018200020208     C*
018300020208     C                   MOVE      HDATE         #ISO
018400020208     C                   MOVE      #ISO          #USA
018500020208     C                   MOVE      #USA          SFDATE
018600020208     C                   Z-ADD     HTIME         SFTIME
018700020208     C*
018800020208     C                   ADD       1             RRT
018900020208     C                   IF        @1STLOOP = '0'
019000020208     C                   Z-ADD     RRT           SFLPOS
019100020208     C                   MOVE      '1'           @1STLOOP
019200020208     C                   ENDIF
019300020208     C*
019400020208     C                   WRITE     GBSSFL
019500020208    ***
019600020208     C                   ENDSR
019700020208   S***S
019800020208     C     $BLDAFT       BEGSR
019900020208     C*
020000030514     C                   DOU       %EOF(AGCHIST2) OR @SFLOOP = '1'
020100030514     C     KEY@AGC       READE     AFTSEQ
020200030514     C                   IF        NOT %EOF(AGCHIST2)
020300020208     C                   EXSR      $LOADSFL
020400020208     C                   ENDIF
020500020208     C                   ENDDO
020600020208    ***
020700020208     C                   ENDSR
020800020208   S***S
020900020208     C     $STEP1        BEGSR
021000020208    ***
021100020208     C                   EXSR      $DISPLAY
021200020208    ***
021300020208     C                   IF        FKEY = F1
021400020208     C                   EVAL      @STEP = 'LEAVE'
021500020208     C                   LEAVESR
021600020208     C                   ENDIF
021700020208    ***
021800020208     C                   IF        FKEY = F8
021900020208     C                   IF        @SEQ = 'M'
022000020208     C                   MOVE      'X'           @SEQ
022100020208     C                   ELSE
022200020208     C                   MOVE      'M'           @SEQ
022300020208     C                   ENDIF
022400020208     C                   EVAL      @STEP = 'PREP1'
022500020208     C                   LEAVESR
022600020208     C                   ENDIF
022700020614    ***
022800020614     C                   IF        I_DTE <> 0
022900020614     C                   EVAL      @STEP = 'PREP1'
023000020614     C                   LEAVESR
023100020614     C                   ENDIF
023200020208    ***
023300020214     C                   IF        RRT > 0
023400020208     C                   EXSR      $CHKSELC
023500020214     C                   ENDIF
023600020208    ***
023700020208     C                   ENDSR
023800991124   S***S
023900991124     C     $DISPLAY      BEGSR
024000991124    ***
024100000211     C                   WRITE     GBSREC
024200000211     C                   EXFMT     GBSCTL
024300991124    ***
024400991124     C                   ENDSR
024500000113   S***S
024600020208    SC     $CHKSELC      BEGSR
024700020208     C*
024800030514    1C                   DOU       %EOF(FM122D)
024900020214     C                   READC(E)  GBSSFL
025000030514    2C                   IF        NOT %EOF(FM122D) AND SEL01 = 'X' AND
025100020214     C                             NOT %ERROR
025200020208     C                   EXSR      $DSPCTL
025300020208     C                   EVAL      SEL01 = *BLANKS
025400020208     C                   UPDATE    GBSSFL
025500020208    3C                   ENDIF
025600020208    1C                   ENDDO
025700020208    ***
025800020208    SC                   ENDSR
025900020208   S***S
026000020208    SC     $DSPCTL       BEGSR
026100020208    ***
026200020208     C                   EXSR      $FMTDSP
026300020208    ***
026400020208     C                   DOU       FKEY = F1
026500021203     C*
026600020208     C                   EXFMT     EXPNDSCRA
026700021203     C*
026800020208    1C                   ENDDO
026900020208     C                   CLEAR                   FKEY
027000020208    ***
027100020208    SC                   ENDSR
027200020208   S***S
027300020208    SC     $FMTDSP       BEGSR
027400020208    ***
027500021203     C                   EVAL      *IN30 = *OFF
027600020612     C                   Z-ADD     41            ZZ
027700020612     C                   DO        20
027800020306     C                   ADD       1             ZZ                2 0
027900020306     C                   EVAL      *IN(ZZ) = *OFF
028000020306     C                   ENDDO
028100090710    ***
028200090710     C                   EVAL      DS@LOD = HDATA
028300020614    ***
028400020614     C                   MOVEL(P)  HUSERID       KEY@USR
028500020614     C     KEY@USR       CHAIN     SECR
028600020614     C                   IF        %FOUND(GBSECURE)
028700020614     C                   MOVEL(P)  SCNAME        GBSUSER
028800020614     C                   ELSE
028900020614     C                   MOVE      *BLANKS       GBSUSER
029000020614     C                   END
029100020306    ***
029200090710     **DS@LOD = HDATA;
029300020208      /FREE
029400020208       DS@B4 = HBEFORE;
029500020208       DS@AF = HAFTER;
029600030514       IF BBNAM1     <> AANAM1;
029700020612         *IN41 = *ON;
029800020208       ENDIF;
029900030514       IF BBNAM2     <> AANAM2;
030000020612         *IN42 = *ON;
030100020306       ENDIF;
030200030514       IF BBADD1     <> AAADD1;
030300020612         *IN43 = *ON;
030400020306       ENDIF;
030500030514       IF BBADD2     <> AAADD2;
030600020612         *IN44 = *ON;
030700020306       ENDIF;
030800030514       IF BBCITY     <> AACITY;
030900020612         *IN45 = *ON;
031000020306       ENDIF;
031100030519       IF (BBSTAT <> AASTAT) OR (BBZIP5 <> AAZIP5) OR (BBZIP4 <> AAZIP4);
031200030514         IF BBZIP5 <> 0;
031300030514           EVAL BBZIPX = (BBZIP5 * 10000) + BBZIP4;
031400030514         ENDIF;
031500030514         IF AAZIP5 <> 0;
031600030514           EVAL AAZIPX = (AAZIP5 * 10000) + AAZIP4;
031700030514         ENDIF;
031800030514         *IN46 = *ON;
031900020306       ENDIF;
032000030514       IF BBTXID <> AATXID;
032100030514         *IN47 = *ON;
032200020306       ENDIF;
032300030514       IF BBACH <> AAACH;
032400020612         *IN48 = *ON;
032500020306       ENDIF;
032600030514       IF (BBTLX3 <> AATLX3) OR (BBTLX7 <> AATLX7);
032700020612         *IN49 = *ON;
032800020306       ENDIF;
032900030514       IF (BBFAX3 <> AAFAX3) OR (BBFAX7 <> AAFAX7);
033000030514         *IN50 = *ON;
033100020306       ENDIF;
033200030514       IF BBCONT <> AACONT;
033300030514         *IN53 = *ON;
033400021203       ENDIF;
033500020208      /END-FREE
033600030514     C                   IF        BBEFDT <> AAEFDT
033700030514     C                   EVAL      *IN51 = *ON
033800030514     C                   IF        BBEFDT > 0
033900030514     C     BBEFDT        MULT      10000.0001    BBEFDT
034000020220     C                   ENDIF
034100030514     C                   IF        AAEFDT > 0
034200030514     C     AAEFDT        MULT      10000.0001    AAEFDT
034300030514     C                   ENDIF
034400020220     C                   ENDIF
034500020614    ***
034600020614     C                   MOVE      HDATE         #ISO
034700020614     C                   MOVE      #ISO          #USA
034800020614     C                   MOVE      #USA          HDATE
034900020208    ***
035000030514     C                   IF        BBTMDT <> AATMDT
035100030519     C                   EVAL      *IN52 = *ON
035200030514     C                   IF        BBTMDT > 0
035300030514     C     BBTMDT        MULT      10000.0001    BBTMDT
035400030514     C                   ENDIF
035500030514     C                   IF        AATMDT > 0
035600030514     C     AATMDT        MULT      10000.0001    AATMDT
035700030514     C                   ENDIF
035800030514     C                   ENDIF
035900020612    ***
036000020208    SC                   ENDSR
036100020208   S***S
