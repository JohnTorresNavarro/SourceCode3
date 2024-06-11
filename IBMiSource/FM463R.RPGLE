000100030221     F*-------------------------------------------------------------------------
000200030519     F* FM463      GBS/IO SOFTWARE 2003
000300030221     F*            WRITTEN BY - S.S.K.
000400030519     F*            DATE - 05/03
000500030519     F*  DESCRIPTION - DISPLAY HISTORY RECORDS FOR SUPER AGENCY
000600030221     F*  INDICATOR USAGE:
000700030221     F*    03 = EXIT FROM INITIAL SCREEN
000800030221     F*    08 = ALTERNATE SEQUENCE OF SUBFILE
000900030221     F*    25 = SFLDSP
001000030221     F*    26 = SFL DSP CTL
001100030221     F*    27 = SFL CLR
001200030221     F*    30 = ALLOW ROLL KEY
001300030221     F*    29 = ROLL FUNCTION SELECTED
001400030221     F*
001500030221     F*-------------------------------------------------------------------------
001600030221     ** MODIFICATION HISTORY                                              **
001700030221     ** ###  UUU  MMDDCCYY  X---->                                        **
001800030519     ** 000  SSK  05192003  ORIGINAL SOURCE                               **
001900030221     **                                                                   **
002000030221     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030519     FSUPHIST1  IF   E           K DISK    RENAME(RSUPHIST:BEFSEQ)
002200030519     FSUPHIST2  IF   E           K DISK    RENAME(RSUPHIST:AFTSEQ)
002300030519     FGBSECURE  IF   E           K DISK
002400030519     FFM463D    CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
002500030519   X***X
002600030519     D P@3             S              3A
002700030519     D P@4             S              4A
002800030519     D KEY@SUP         S              3A
002900030519     D KEY@DTE         S              8S 0
003000030519     D KEY@USR         S                   LIKE(SCUSR)
003100030519    ***
003200030519     D #ISO            S               D   DATFMT(*ISO)
003300030519     D #USA            S               D   DATFMT(*USA)
003400030519     D #ISA            S              8S 0
003500030519    ***
003600030519     D                UDS
003700030519     D  TITLE                201    240A
003800030519    ***
003900030519     D WSDS            DS
004000030519     D  FKEY                 369    369A
004100030519    ***
004200030519     D  F1             C                   CONST(X'31')
004300030519     D  F2             C                   CONST(X'32')
004400030519     D  F3             C                   CONST(X'33')
004500030519     D  F4             C                   CONST(X'34')
004600030519     D  F5             C                   CONST(X'35')
004700030519     D  F6             C                   CONST(X'36')
004800030519     D  F7             C                   CONST(X'37')
004900030519     D  F8             C                   CONST(X'38')
005000030519     D  F9             C                   CONST(X'39')
005100030519     D  F10            C                   CONST(X'3A')
005200030519     D  F11            C                   CONST(X'3B')
005300030519     D  F12            C                   CONST(X'3C')
005400030519     D  F13            C                   CONST(X'B1')
005500030519     D  F14            C                   CONST(X'B2')
005600030519     D  F15            C                   CONST(X'B3')
005700030519     D  F16            C                   CONST(X'B4')
005800030519     D  F17            C                   CONST(X'B5')
005900030519     D  F18            C                   CONST(X'B6')
006000030519     D  F19            C                   CONST(X'B7')
006100030519     D  F20            C                   CONST(X'B8')
006200030519     D  F21            C                   CONST(X'B9')
006300030519     D  F22            C                   CONST(X'BA')
006400030519     D  F23            C                   CONST(X'BB')
006500030519     D  F24            C                   CONST(X'BC')
006600030519    ***
006700030519     D @STEP           S              5A
006800030519    ***
006900030519     D DS@LOD        E DS                  EXTNAME(SUPHIST0)
007000030519    ***
007100030519     D DS@B4         E DS                  EXTNAME(SUPRAGCY) PREFIX(BA:2)
007200090710     D BA_ZERO               235    250A
007300030519    ***
007400030519     D DS@AF         E DS                  EXTNAME(SUPRAGCY) PREFIX(AA:2)
007500090710     D AA_ZERO               235    250A
007600030519    ***
007700030519     D @DTA50          S             50A
007800030519   X***X
007900030519      /FREE
008000030519         O_SUPER = P@3;
008100030519         KEY@DTE = 00010101;
008200030519         KEY@SUP = P@3;
008300030519         @STEP = 'PREP1';
008400030519      /END-FREE
008500030519    ***
008600030519     C     *DTAARA       DEFINE    COMPANY       @DTA50
008700030519     C                   IN        @DTA50
008800030519     C                   EVAL      GBSREALM = %SUBST(@DTA50:1:40)
008900030519    ***
009000030519    *C                   DOU       @STEP = 'LEAVE'
009100030519    *C     @STEP         CASEQ     'PREP1'       $PREP1
009200030519    *C     @STEP         CASEQ     'STEP1'       $STEP1
009300030519    *C                   ENDCS
009400030519    *C                   ENDDO
009500030519    *C                   EVAL      *INLR = *ON
009600030519  *S***S
009700030519     C* ONETIME ROUTINE
009800030519    ***
009900030519     C     *INZSR        BEGSR
010000030519    ***
010100030519     C     *ENTRY        PLIST
010200030519     C                   PARM                    P@3
010300030519    ***
010400030519     C     KEY#SHST      KLIST
010500030519     C                   KFLD                    KEY@SUP
010600030519     C                   KFLD                    KEY@DTE
010700030519    ***
010800030519     C                   MOVE      *ZEROS        RRT               3 0
010900030519     C                   MOVE      *ZEROS        #CNTREC           2 0
011000030519    ***
011100030519     C                   MOVE      '0'           @1STLOOP          1
011200030519     C                   MOVE      '0'           @SFLOOP           1
011300030519    *C*                  MOVE      '0'           @CNFRM            1
011400030519     C                   MOVE      '1'           @LOOPIT           1
011500030519     C                   MOVE      '0'           @ACTION           1
011600030519     C                   MOVE      'M'           @SEQ              1
011700030519    ***
011800030519     C                   ENDSR
011900030519  *S***S
012000030519     C     $PREP1        BEGSR
012100030519    ***
012200030519     C                   EXSR      $CLEAR
012300030519    *C*
012400030519     C                   EXSR      $BUILD
012500030519    *C*
012600030519     C                   EVAL      @STEP = 'STEP1'
012700030519    ***
012800030519     C                   ENDSR
012900030519  *S***S
013000030519     C     $CLEAR        BEGSR
013100030519    ***
013200030519     C                   MOVEA     '011'         *IN(25)
013300030519     C                   WRITE     GBSCTL
013400030519     C                   MOVEA     '010'         *IN(25)
013500030519     C                   Z-ADD     *ZERO         RRT
013600030519    ***
013700030519     C                   ENDSR
013800030519   S***S
013900030519     C     $BUILD        BEGSR
014000030519    ***
014100030519     C                   EXSR      $CLEAR
014200030519     C                   MOVE      *ZEROS        #CNTREC
014300030519     C                   MOVE      '0'           @1STLOOP
014400030519     C                   MOVE      '0'           @SFLOOP
014500030519    ***
014600030519     C                   IF        @SEQ = 'M'
014700030519     C     KEY#SHST      SETLL     BEFSEQ
014800030519     C                   EXSR      $BLDBEF
014900030519     C                   ELSE
015000030519     C     KEY#SHST      SETLL     AFTSEQ
015100030519     C                   EXSR      $BLDAFT
015200030519     C                   ENDIF
015300030519    ***
015400030519     C                   EVAL      I_DTE = 0
015500030519    ***
015600030519     C                   ENDSR
015700030519   S***S
015800030519     C* BUILD BY BEFORE IMAGE
015900030519    ***
016000030519     C     $BLDBEF       BEGSR
016100030519    ***
016200030519     C                   DOU       %EOF(SUPHIST1) OR @SFLOOP = '1'
016300030519     C     KEY@SUP       READE     BEFSEQ
016400030519     C                   IF        NOT %EOF(SUPHIST1)
016500030519     C                   EXSR      $LOADSFL
016600030519     C                   ENDIF
016700030519     C                   ENDDO
016800030519    ***
016900030519     C                   ENDSR
017000030519   S***S
017100030519     C     $LOADSFL      BEGSR
017200030519    ***
017300030519     C                   MOVE      *ON           *IN25
017400030519    ***
017500030519     C                   EVAL      HDATA = DS@LOD
017600030519     C                   MOVE      *BLANKS       SEL01
017700030519     C                   EVAL      SFADES = %SUBST(HAFTER:4:30)
017800030519     C*
017900030519     C                   MOVEL(P)  HUSERID       KEY@USR
018000030519     C     KEY@USR       CHAIN     SECR
018100030519     C                   IF        %FOUND(GBSECURE)
018200030519     C                   MOVEL(P)  SCNAME        SFUSERID
018300030519     C                   ELSE
018400030519     C                   MOVE      *BLANKS       SFUSERID
018500030519     C                   END
018600030519     C*
018700030519     C                   MOVE      HDATE         #ISO
018800030519     C                   MOVE      #ISO          #USA
018900030519     C                   MOVE      #USA          SFDATE
019000030519     C                   Z-ADD     HTIME         SFTIME
019100030519     C*
019200030519     C                   ADD       1             RRT
019300030519     C                   IF        @1STLOOP = '0'
019400030519     C                   Z-ADD     RRT           SFLPOS
019500030519     C                   MOVE      '1'           @1STLOOP
019600030519     C                   ENDIF
019700030519     C*
019800030519     C                   WRITE     GBSSFL
019900030519    ***
020000030519     C                   ENDSR
020100030519   S***S
020200030519     C     $BLDAFT       BEGSR
020300030519     C*
020400030519     C                   DOU       %EOF(SUPHIST2) OR @SFLOOP = '1'
020500030519     C     KEY@SUP       READE     AFTSEQ
020600030519     C                   IF        NOT %EOF(SUPHIST2)
020700030519     C                   EXSR      $LOADSFL
020800030519     C                   ENDIF
020900030519     C                   ENDDO
021000030519    ***
021100030519     C                   ENDSR
021200030519   S***S
021300030519     C     $STEP1        BEGSR
021400030519    ***
021500030519     C                   EXSR      $DISPLAY
021600030519    ***
021700030519     C                   IF        FKEY = F1
021800030519     C                   EVAL      @STEP = 'LEAVE'
021900030519     C                   LEAVESR
022000030519     C                   ENDIF
022100030519    ***
022200030519     C                   IF        FKEY = F8
022300030519     C                   IF        @SEQ = 'M'
022400030519     C                   MOVE      'X'           @SEQ
022500030519     C                   ELSE
022600030519     C                   MOVE      'M'           @SEQ
022700030519     C                   ENDIF
022800030519     C                   EVAL      @STEP = 'PREP1'
022900030519     C                   LEAVESR
023000030519     C                   ENDIF
023100030519    ***
023200030519     C                   IF        I_DTE <> 0
023300030519     C                   EVAL      @STEP = 'PREP1'
023400030519     C                   LEAVESR
023500030519     C                   ENDIF
023600030519    ***
023700030519     C                   IF        RRT > 0
023800030519     C                   EXSR      $CHKSELC
023900030519     C                   ENDIF
024000030519    ***
024100030519     C                   ENDSR
024200030519   S***S
024300030519     C     $DISPLAY      BEGSR
024400030519    ***
024500030519     C                   WRITE     GBSREC
024600030519     C                   EXFMT     GBSCTL
024700030519    ***
024800030519     C                   ENDSR
024900030519   S***S
025000030519    SC     $CHKSELC      BEGSR
025100030519     C*
025200030519    1C                   DOU       %EOF(FM463D)
025300030519     C                   READC(E)  GBSSFL
025400030519    2C                   IF        NOT %EOF(FM463D) AND SEL01 = 'X' AND
025500030519     C                             NOT %ERROR
025600030519     C                   EXSR      $DSPCTL
025700030519     C                   EVAL      SEL01 = *BLANKS
025800030519     C                   UPDATE    GBSSFL
025900030519    3C                   ENDIF
026000030519    1C                   ENDDO
026100030519    ***
026200030519    SC                   ENDSR
026300030519   S***S
026400030519    SC     $DSPCTL       BEGSR
026500030519    ***
026600030519     C                   EXSR      $FMTDSP
026700030519    ***
026800030519     C                   DOU       FKEY = F1
026900030519     C*
027000030519     C                   EXFMT     EXPNDSCRA
027100030519     C*
027200030519    1C                   ENDDO
027300030519     C                   CLEAR                   FKEY
027400030519    ***
027500030519    SC                   ENDSR
027600030519   S***S
027700030519    SC     $FMTDSP       BEGSR
027800030519    ***
027900030519     C                   EVAL      *IN30 = *OFF
028000030519     C                   Z-ADD     41            ZZ
028100030519     C                   DO        20
028200030519     C                   ADD       1             ZZ                2 0
028300030519     C                   EVAL      *IN(ZZ) = *OFF
028400030519     C                   ENDDO
028500030519    ***
028600090710     C                   EVAL      DS@LOD = HDATA
028700090710    ***
028800030519     C                   MOVEL(P)  HUSERID       KEY@USR
028900030519     C     KEY@USR       CHAIN     SECR
029000030519     C                   IF        %FOUND(GBSECURE)
029100030519     C                   MOVEL(P)  SCNAME        GBSUSER
029200030519     C                   ELSE
029300030519     C                   MOVE      *BLANKS       GBSUSER
029400030519     C                   END
029500030519    ***
029600090710    ***DS@LOD = HDATA;
029700030519      /FREE
029800030519       DS@B4 = HBEFORE;
029900030519       DS@AF = HAFTER;
030000030519       IF BANAME1    <> AANAME1;
030100030519         *IN41 = *ON;
030200030519       ENDIF;
030300030519       IF BANAME2     <> AANAME2;
030400030519         *IN42 = *ON;
030500030519       ENDIF;
030600030519       IF BAADD1     <> AAADD1;
030700030519         *IN43 = *ON;
030800030519       ENDIF;
030900030519       IF BAADD2     <> AAADD2;
031000030519         *IN44 = *ON;
031100030519       ENDIF;
031200030519       IF BACITY     <> AACITY;
031300030519         *IN45 = *ON;
031400030519       ENDIF;
031500030519       IF (BASTATE <> AASTATE) OR (BAZIP <> AAZIP);
031600030519         *IN46 = *ON;
031700030519       ENDIF;
031800030519       IF BAPHONE <> AAPHONE;
031900030519         *IN47 = *ON;
032000030519       ENDIF;
032100030519       IF BAFAX <> AAFAX;
032200030519         *IN48 = *ON;
032300030519       ENDIF;
032400030519       IF BACNTCT <> AACNTCT;
032500030519         *IN49 = *ON;
032600030519       ENDIF;
032700030519       IF BATAXID <> AATAXID;
032800030519         *IN50 = *ON;
032900030519       ENDIF;
033000030519      /END-FREE
033100090710     C     ' ':'0'       XLATE     BA_ZERO       BA_ZERO
033200090710     C     ' ':'0'       XLATE     AA_ZERO       AA_ZERO
033300030519     C                   IF        BAEFFDTE <> AAEFFDTE
033400030519     C                   EVAL      *IN51 = *ON
033500030519     C                   IF        BAEFFDTE > 0
033600030519     C     BAEFFDTE      MULT      10000.0001    BAEFFDTE
033700030519     C                   ENDIF
033800030519     C                   IF        AAEFFDTE > 0
033900030519     C     AAEFFDTE      MULT      10000.0001    AAEFFDTE
034000030519     C                   ENDIF
034100030519     C                   ENDIF
034200030519    ***
034300030519     C                   MOVE      HDATE         #ISO
034400030519     C                   MOVE      #ISO          #USA
034500030519     C                   MOVE      #USA          HDATE
034600030519    ***
034700030519     C                   IF        BATRMDTE <> AATRMDTE
034800030519     C                   EVAL      *IN52 = *ON
034900030519     C                   IF        BATRMDTE > 0
035000030519     C     BATRMDTE      MULT      10000.0001    BATRMDTE
035100030519     C                   ENDIF
035200030519     C                   IF        AATRMDTE > 0
035300030519     C     AATRMDTE      MULT      10000.0001    AATRMDTE
035400030519     C                   ENDIF
035500030519     C                   ENDIF
035600030519    ***
035700030519    SC                   ENDSR
035800030519   S***S
