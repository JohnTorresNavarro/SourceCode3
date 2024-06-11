000100030221     F*-------------------------------------------------------------------------
000200040708     F* IQR153     GBS/IO SOFTWARE 2003
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
001900040708     ** ***  SSK  01022004  COPY FM463R TO IQ                             **
002000030221     ** = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = **
002100030519     FSUPHIST1  IF   E           K DISK    RENAME(RSUPHIST:BEFSEQ)
002200030519     FSUPHIST2  IF   E           K DISK    RENAME(RSUPHIST:AFTSEQ)
002300030519     FGBSECURE  IF   E           K DISK
002400040708     FIQR153D   CF   E             WORKSTN SFILE(GBSSFL:RRT) INFDS(WSDS)
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
003600030519     D WSDS            DS
003700030519     D  FKEY                 369    369A
003800030519    ***
003900030519     D  F1             C                   CONST(X'31')
004000030519     D  F2             C                   CONST(X'32')
004100030519     D  F3             C                   CONST(X'33')
004200030519     D  F4             C                   CONST(X'34')
004300030519     D  F5             C                   CONST(X'35')
004400030519     D  F6             C                   CONST(X'36')
004500030519     D  F7             C                   CONST(X'37')
004600030519     D  F8             C                   CONST(X'38')
004700030519     D  F9             C                   CONST(X'39')
004800030519     D  F10            C                   CONST(X'3A')
004900030519     D  F11            C                   CONST(X'3B')
005000030519     D  F12            C                   CONST(X'3C')
005100030519     D  F13            C                   CONST(X'B1')
005200030519     D  F14            C                   CONST(X'B2')
005300030519     D  F15            C                   CONST(X'B3')
005400030519     D  F16            C                   CONST(X'B4')
005500030519     D  F17            C                   CONST(X'B5')
005600030519     D  F18            C                   CONST(X'B6')
005700030519     D  F19            C                   CONST(X'B7')
005800030519     D  F20            C                   CONST(X'B8')
005900030519     D  F21            C                   CONST(X'B9')
006000030519     D  F22            C                   CONST(X'BA')
006100030519     D  F23            C                   CONST(X'BB')
006200030519     D  F24            C                   CONST(X'BC')
006300030519    ***
006400030519     D @STEP           S              5A
006500030519    ***
006600030519     D DS@LOD        E DS                  EXTNAME(SUPHIST0)
006700030519    ***
006800030519     D DS@B4         E DS                  EXTNAME(SUPRAGCY) PREFIX(BA:2)
006900040708     D BTRAN                 235    250A
007000030519    ***
007100030519     D DS@AF         E DS                  EXTNAME(SUPRAGCY) PREFIX(AA:2)
007200040708     D ATRAN                 235    250A
007300030519    ***
007400030519     D @DTA50          S             50A
007500030519   X***X
007600030519      /FREE
007700030519         O_SUPER = P@3;
007800030519         KEY@DTE = 00010101;
007900030519         KEY@SUP = P@3;
008000030519         @STEP = 'PREP1';
008100030519      /END-FREE
008200030519    ***
008300030519    *C                   DOU       @STEP = 'LEAVE'
008400030519    *C     @STEP         CASEQ     'PREP1'       $PREP1
008500030519    *C     @STEP         CASEQ     'STEP1'       $STEP1
008600030519    *C                   ENDCS
008700030519    *C                   ENDDO
008800030519    *C                   EVAL      *INLR = *ON
008900030519  *S***S
009000030519     C* ONETIME ROUTINE
009100030519    ***
009200030519     C     *INZSR        BEGSR
009300030519    ***
009400030519     C     *ENTRY        PLIST
009500030519     C                   PARM                    P@3
009600030519    ***
009700030519     C     KEY#SHST      KLIST
009800030519     C                   KFLD                    KEY@SUP
009900030519     C                   KFLD                    KEY@DTE
010000030519    ***
010100030519     C                   MOVE      *ZEROS        RRT               3 0
010200030519     C                   MOVE      *ZEROS        #CNTREC           2 0
010300030519    ***
010400030519     C                   MOVE      '0'           @1STLOOP          1
010500030519     C                   MOVE      '0'           @SFLOOP           1
010600030519    *C*                  MOVE      '0'           @CNFRM            1
010700030519     C                   MOVE      '1'           @LOOPIT           1
010800030519     C                   MOVE      '0'           @ACTION           1
010900030519     C                   MOVE      'M'           @SEQ              1
011000030519    ***
011100030519     C                   ENDSR
011200030519  *S***S
011300030519     C     $PREP1        BEGSR
011400030519    ***
011500030519     C                   EXSR      $CLEAR
011600030519    *C*
011700030519     C                   EXSR      $BUILD
011800030519    *C*
011900030519     C                   EVAL      @STEP = 'STEP1'
012000030519    ***
012100030519     C                   ENDSR
012200030519  *S***S
012300030519     C     $CLEAR        BEGSR
012400030519    ***
012500030519     C                   MOVEA     '011'         *IN(25)
012600030519     C                   WRITE     GBSCTL
012700030519     C                   MOVEA     '010'         *IN(25)
012800030519     C                   Z-ADD     *ZERO         RRT
012900030519    ***
013000030519     C                   ENDSR
013100030519   S***S
013200030519     C     $BUILD        BEGSR
013300030519    ***
013400030519     C                   EXSR      $CLEAR
013500030519     C                   MOVE      *ZEROS        #CNTREC
013600030519     C                   MOVE      '0'           @1STLOOP
013700030519     C                   MOVE      '0'           @SFLOOP
013800030519    ***
013900030519     C                   IF        @SEQ = 'M'
014000030519     C     KEY#SHST      SETLL     BEFSEQ
014100030519     C                   EXSR      $BLDBEF
014200030519     C                   ELSE
014300030519     C     KEY#SHST      SETLL     AFTSEQ
014400030519     C                   EXSR      $BLDAFT
014500030519     C                   ENDIF
014600030519    ***
014700030519     C                   EVAL      I_DTE = 0
014800030519    ***
014900030519     C                   ENDSR
015000030519   S***S
015100030519     C* BUILD BY BEFORE IMAGE
015200030519    ***
015300030519     C     $BLDBEF       BEGSR
015400030519    ***
015500030519     C                   DOU       %EOF(SUPHIST1) OR @SFLOOP = '1'
015600030519     C     KEY@SUP       READE     BEFSEQ
015700030519     C                   IF        NOT %EOF(SUPHIST1)
015800030519     C                   EXSR      $LOADSFL
015900030519     C                   ENDIF
016000030519     C                   ENDDO
016100030519    ***
016200030519     C                   ENDSR
016300030519   S***S
016400030519     C     $LOADSFL      BEGSR
016500030519    ***
016600030519     C                   MOVE      *ON           *IN25
016700030519    ***
016800030519     C                   EVAL      HDATA = DS@LOD
016900030519     C                   MOVE      *BLANKS       SEL01
017000030519     C                   EVAL      SFADES = %SUBST(HAFTER:4:30)
017100030519     C*
017200030519     C                   MOVEL(P)  HUSERID       KEY@USR
017300030519     C     KEY@USR       CHAIN     SECR
017400030519     C                   IF        %FOUND(GBSECURE)
017500030519     C                   MOVEL(P)  SCNAME        SFUSERID
017600030519     C                   ELSE
017700030519     C                   MOVE      *BLANKS       SFUSERID
017800030519     C                   END
017900030519     C*
018000030519     C                   MOVE      HDATE         #ISO
018100030519     C                   MOVE      #ISO          #USA
018200030519     C                   MOVE      #USA          SFDATE
018300030519     C                   Z-ADD     HTIME         SFTIME
018400030519     C*
018500030519     C                   ADD       1             RRT
018600030519     C                   IF        @1STLOOP = '0'
018700030519     C                   Z-ADD     RRT           SFLPOS
018800030519     C                   MOVE      '1'           @1STLOOP
018900030519     C                   ENDIF
019000030519     C*
019100030519     C                   WRITE     GBSSFL
019200030519    ***
019300030519     C                   ENDSR
019400030519   S***S
019500030519     C     $BLDAFT       BEGSR
019600030519     C*
019700030519     C                   DOU       %EOF(SUPHIST2) OR @SFLOOP = '1'
019800030519     C     KEY@SUP       READE     AFTSEQ
019900030519     C                   IF        NOT %EOF(SUPHIST2)
020000030519     C                   EXSR      $LOADSFL
020100030519     C                   ENDIF
020200030519     C                   ENDDO
020300030519    ***
020400030519     C                   ENDSR
020500030519   S***S
020600030519     C     $STEP1        BEGSR
020700030519    ***
020800030519     C                   EXSR      $DISPLAY
020900030519    ***
021000030519     C                   IF        FKEY = F1
021100030519     C                   EVAL      @STEP = 'LEAVE'
021200030519     C                   LEAVESR
021300030519     C                   ENDIF
021400030519    ***
021500030519     C                   IF        FKEY = F8
021600030519     C                   IF        @SEQ = 'M'
021700030519     C                   MOVE      'X'           @SEQ
021800030519     C                   ELSE
021900030519     C                   MOVE      'M'           @SEQ
022000030519     C                   ENDIF
022100030519     C                   EVAL      @STEP = 'PREP1'
022200030519     C                   LEAVESR
022300030519     C                   ENDIF
022400030519    ***
022500030519     C                   IF        I_DTE <> 0
022600030519     C                   EVAL      @STEP = 'PREP1'
022700030519     C                   LEAVESR
022800030519     C                   ENDIF
022900030519    ***
023000030519     C                   IF        RRT > 0
023100030519     C                   EXSR      $CHKSELC
023200030519     C                   ENDIF
023300030519    ***
023400030519     C                   ENDSR
023500030519   S***S
023600030519     C     $DISPLAY      BEGSR
023700030519    ***
023800030519     C                   WRITE     GBSREC
023900030519     C                   EXFMT     GBSCTL
024000030519    ***
024100030519     C                   ENDSR
024200030519   S***S
024300030519    SC     $CHKSELC      BEGSR
024400030519     C*
024500040708    1C                   DOU       %EOF(IQR153D)
024600030519     C                   READC(E)  GBSSFL
024700040708    2C                   IF        NOT %EOF(IQR153D) AND SEL01 = 'X' AND
024800030519     C                             NOT %ERROR
024900030519     C                   EXSR      $DSPCTL
025000030519     C                   EVAL      SEL01 = *BLANKS
025100030519     C                   UPDATE    GBSSFL
025200030519    3C                   ENDIF
025300030519    1C                   ENDDO
025400030519    ***
025500030519    SC                   ENDSR
025600030519   S***S
025700030519    SC     $DSPCTL       BEGSR
025800030519    ***
025900030519     C                   EXSR      $FMTDSP
026000030519    ***
026100030519     C                   DOU       FKEY = F1
026200030519     C*
026300030519     C                   EXFMT     EXPNDSCRA
026400030519     C*
026500030519    1C                   ENDDO
026600030519     C                   CLEAR                   FKEY
026700030519    ***
026800030519    SC                   ENDSR
026900030519   S***S
027000030519    SC     $FMTDSP       BEGSR
027100030519    ***
027200030519     C                   EVAL      *IN30 = *OFF
027300030519     C                   Z-ADD     41            ZZ
027400030519     C                   DO        20
027500030519     C                   ADD       1             ZZ                2 0
027600030519     C                   EVAL      *IN(ZZ) = *OFF
027700030519     C                   ENDDO
027800030519    ***
027900030519     C                   MOVEL(P)  HUSERID       KEY@USR
028000030519     C     KEY@USR       CHAIN     SECR
028100030519     C                   IF        %FOUND(GBSECURE)
028200030519     C                   MOVEL(P)  SCNAME        GBSUSER
028300030519     C                   ELSE
028400030519     C                   MOVE      *BLANKS       GBSUSER
028500030519     C                   END
028600030519    ***
028700030519      /FREE
028800030519       DS@LOD = HDATA;
028900030519       DS@B4 = HBEFORE;
029000030519       DS@AF = HAFTER;
029100030519       IF BANAME1    <> AANAME1;
029200030519         *IN41 = *ON;
029300030519       ENDIF;
029400030519       IF BANAME2     <> AANAME2;
029500030519         *IN42 = *ON;
029600030519       ENDIF;
029700030519       IF BAADD1     <> AAADD1;
029800030519         *IN43 = *ON;
029900030519       ENDIF;
030000030519       IF BAADD2     <> AAADD2;
030100030519         *IN44 = *ON;
030200030519       ENDIF;
030300030519       IF BACITY     <> AACITY;
030400030519         *IN45 = *ON;
030500030519       ENDIF;
030600030519       IF (BASTATE <> AASTATE) OR (BAZIP <> AAZIP);
030700030519         *IN46 = *ON;
030800030519       ENDIF;
030900030519       IF BAPHONE <> AAPHONE;
031000030519         *IN47 = *ON;
031100030519       ENDIF;
031200030519       IF BAFAX <> AAFAX;
031300030519         *IN48 = *ON;
031400030519       ENDIF;
031500030519       IF BACNTCT <> AACNTCT;
031600030519         *IN49 = *ON;
031700030519       ENDIF;
031800030519       IF BATAXID <> AATAXID;
031900030519         *IN50 = *ON;
032000030519       ENDIF;
032100030519      /END-FREE
032200040708     C     ' ':'0'       XLATE     BTRAN         BTRAN
032300040708     C     ' ':'0'       XLATE     ATRAN         ATRAN
032400030519     C                   IF        BAEFFDTE <> AAEFFDTE
032500030519     C                   EVAL      *IN51 = *ON
032600030519     C                   IF        BAEFFDTE > 0
032700030519     C     BAEFFDTE      MULT      10000.0001    BAEFFDTE
032800030519     C                   ENDIF
032900030519     C                   IF        AAEFFDTE > 0
033000030519     C     AAEFFDTE      MULT      10000.0001    AAEFFDTE
033100030519     C                   ENDIF
033200030519     C                   ENDIF
033300030519    ***
033400030519     C                   MOVE      HDATE         #ISO
033500030519     C                   MOVE      #ISO          #USA
033600030519     C                   MOVE      #USA          HDATE
033700030519    ***
033800030519     C                   IF        BATRMDTE <> AATRMDTE
033900030519     C                   EVAL      *IN52 = *ON
034000030519     C                   IF        BATRMDTE > 0
034100030519     C     BATRMDTE      MULT      10000.0001    BATRMDTE
034200030519     C                   ENDIF
034300030519     C                   IF        AATRMDTE > 0
034400030519     C     AATRMDTE      MULT      10000.0001    AATRMDTE
034500030519     C                   ENDIF
034600030519     C                   ENDIF
034700030519    ***
034800030519    SC                   ENDSR
034900030519   S***S
