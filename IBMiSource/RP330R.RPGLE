000100910215      ******************************************************************
000200030314     F* RP330      GROUP BENEFIT SERVICES SOFTWARE           1990      *
000300030314     F*                                                                *
000400030314     F*            WRITTEN BY - DEBORAH R. BEYER                       *
000500030314     F*            DATE - 05/22/90                                     *
000600030314     F*                                                                *
000700030314     F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE A LISTING OF ACCOUNT  *
000800030314     F*            PENETRATION BY SIZE                                 *
000900030314     F*            SCREEN:    RP3PM                                    *
001000030314     F*            PROCEDURE: RP330                                    *
001100030314     F*                                                                *
001200030314     F*  MODIFICATION : LOOP PROBLEM DUE TO CENTURY PROBLEM.           *
001300030314     F*                 TEMPORARY SOLUTION = TEST ENROLL YEAR          *
001400030314     F*                 70-99 MOVE 19 INTO CENTURY   MLF 10/97         *
001500981120     F*                                                                *
001600981120     F*  Y2K CONVERT - 1998                                            *
001700981120     F*                                                                *
001800910215      ******************************************************************
001900030314     F* CONVERT TO NATIVE CODE FROM S/36                               *
002000030314     F* CONVERT O-SPECS TO PRINT FILES                                 *
002100030314      ******************************************************************
002200030314     FACCMST    IF   E           K DISK    USROPN RENAME(ACCMSR:ACCINP)
002300030317     FRP330WF   IF A E           K DISK    USROPN
002400030314     FTRSMST    IF   E           K DISK
002500030314     FCODES     IF   E           K DISK
002600030314     FSMAN      IF   E           K DISK
002700030314     FRP330P1   O    E             PRINTER OFLIND(*IN98)
002800030314     FRP330P2   O    E             PRINTER OFLIND(*IN99)
002900030314   X***X
003000030314     D #EMPBRK1        S              7S 0
003100030314     D #EMPBRK2        S              7S 0
003200030314     D KEY@TYPE        S                   LIKE(TYPE)
003300030314     D KEY@CODE        S                   LIKE(CODE)
003400030317     D KEY@TRS         S                   LIKE(ACTRST)
003500030314    ***
003600030314     D #XSX            S              8S 0
003700030314     D #ISOANV         S               D   DATFMT(*ISO)
003800030314     D #ISOLDY         S               D   DATFMT(*ISO)
003900030314    ***
004000910215     D                UDS
004100030317     D @TR                     1      3A
004200030317     D @RM                     4      9A
004300030317     D CONAME                201    240A
004400030317     D TIME                  242    247S 0
004500030314   X***X
004600031217     C                   EXSR      $EXTRACT
004700030314    ***
004800031217     C                   IF        @EF <> 'Y'
004900030314     C                   EXSR      $INITHDG
005000030314     C                   OPEN      RP330WF
005100030314     C                   EXSR      $REPORT
005200030314     C                   CLOSE     RP330WF
005300030317     C                   EXSR      $FINLWRT
005400031217     C                   ENDIF
005500030314    ***
005600030314     C                   MOVE      *ON           *INLR
005700030314     C*
005800030314   S***S
005900030317     C     *INZSR        BEGSR
006000030317    ***
006100030314     C     KEY@CODES     KLIST
006200030314     C                   KFLD                    KEY@TYPE
006300030314     C                   KFLD                    KEY@CODE
006400030314    ***
006500030314     C                   ENDSR
006600030314   S***S
006700030314     C     $EXTRACT      BEGSR
006800030314    ***
006900030314     C                   MOVE      'N'           @EF               1
007000030314     C                   OPEN      ACCMST
007100030314     C                   OPEN      RP330WF
007200030314    ***
007300030317     C                   IF        @TR <> 'ALL'
007400030317     C                   MOVE      @TR           #3
007500030317     C                   EVAL      KEY@TRS = #3
007600030317     C     KEY@TRS       CHAIN     TRSMST
007700030314     C                   IF        %FOUND(TRSMST)
007800030314     C                   EXSR      $COMNLOD
007900030314     C                   ELSE
008000030317     C                   MOVE      'Y'           @EF
008100030314     C                   ENDIF
008200030314     C                   ELSE
008300030314     C                   EXSR      $LOADALL
008400030314     C                   ENDIF
008500030314    ***
008600030314     C                   CLOSE     ACCMST
008700030314     C                   CLOSE     RP330WF
008800030314    ***
008900030314     C                   ENDSR
009000030314   S***S
009100030314     C     $COMNLOD      BEGSR
009200030314    ***
009300030314     C     KEY@TRS       SETLL     ACCINP
009400030314     C                   DOU       %EOF(ACCMST)
009500030314     C     KEY@TRS       READE     ACCINP
009600030314     C                   IF        NOT %EOF(ACCMST) AND ATRMDT = 0
009700030314     C                   WRITE     ACCMSR
009800030314     C                   ENDIF
009900030314     C                   ENDDO
010000030314    ***
010100030314     C                   ENDSR
010200030314   S***S
010300030317     C     $LOADALL      BEGSR
010400030317    ***
010500030317     C                   DOU       %EOF(TRSMST)
010600030317     C                   READ      TRSMSR
010700030317     C                   IF        NOT %EOF(TRSMST)
010800030317     C                   EVAL      KEY@TRS = TRTRST
010900030317     C                   EXSR      $COMNLOD
011000030317     C                   ENDIF
011100030317     C                   ENDDO
011200030317    ***
011300030317     C                   ENDSR
011400030317   S***S
011500030317     C     $REPORT       BEGSR
011600030317    ***
011700030317     C                   DOU       %EOF(RP330WF)
011800030317     C                   READ      ACCMSR
011900030317     C                   IF        NOT %EOF(RP330WF) AND NOEMPL > 0
012000030317    ***
012100030317     C     SMANCD        CHAIN     SMANR
012200030317     C                   MOVEL     STYPE         KEY@TYPE
012300030317     C                   MOVE      STYPE         KEY@CODE
012400030317     C     KEY@CODES     CHAIN(N)  CODESR
012500030317    ***
012600030317     C                   IF        @RM <> 'ALL   '
012700030317     C                   EXSR      $CHKRNWL
012800030317     C                   IF        @RENEW = 'N'
012900030317     C                   ITER
013000030317     C                   ENDIF
013100030317     C                   ENDIF
013200030317    ***
013300030317      * ACTION = 'B' IS BROKER ACCOUNTS
013400030317      * ACTION <> 'B' IS GBS ACCOUNTS
013500030317      *
013600030317     C     ACTION        CASEQ     'B'           $BROKER
013700030317     C     ACTION        CASNE     'B'           $GBS
013800030317     C                   ENDCS
013900030317    ***
014000030317     C                   ENDIF
014100030317     C                   ENDDO
014200030317    ***
014300030317     C                   ENDSR
014400030317   S***S
014500030317     C     $CHKRNWL      BEGSR
014600030317    ***
014700030317     C                   MOVE      'Y'           @RENEW            1
014800030317    ***
014900030317     C                   MOVE      ENROLL        @8                8
015000030317     C                   EVAL      %SUBST(@8:7:2) = '01'
015100030317     C                   MOVE      @8            #XSX
015200030317     C                   MOVE      #XSX          #ISOANV
015300030317     C                   EVAL      @8 = %SUBST(@RM:3:4) + %SUBST(@RM:1:2) + '01'
015400030317     C                   MOVE      @8            #XSX
015500030317     C                   MOVE      #XSX          #ISOLDY
015600030317     C*
015700030317     C                   IF        RNEWPD <> 0
015800030317     C                   DOU       #ISOANV >= #ISOLDY
015900030317     C                   ADDDUR    RNEWPD:*M     #ISOANV
016000030317     C                   ENDDO
016100030317     C                   ENDIF
016200030317     C*
016300030317     C                   IF        #ISOANV <> #ISOLDY
016400030317     C                   MOVE      'N'           @RENEW
016500030317     C                   ENDIF
016600030317    ***
016700030317     C                   ENDSR
016800030317   S***S
016900030314     C     $INITHDG      BEGSR
017000030314    ***
017100030317     C                   IF        @RM = 'ALL   '
017200030317     C                   EVAL      O_RD1 = 'ALL    '
017300030317     C                   EVAL      O_RD2 = 'ALL    '
017400030317     C                   ELSE
017500030317     C                   EVAL      O_RD1 = %SUBST(@RM:1:2) + '/' +
017600030317     C                                     %SUBST(@RM:3:4)
017700030317     C                   EVAL      O_RD2 = O_RD1
017800030317     C                   ENDIF
017900030317    ***
018000030317     C                   IF        @TR = 'ALL'
018100030317     C                   EVAL      O_TRS1 = 'ALL'
018200030317     C                   EVAL      O_TN1 = 'ALL TRUSTS'
018300030317     C                   EVAL      O_TRS2 = 'ALL'
018400030317     C                   EVAL      O_TN2 = 'ALL TRUSTS'
018500030317     C                   ELSE
018600030317     C                   MOVE      @TR           #3                3 0
018700030317     C                   EVAL      KEY@TRS = #3
018800030317     C     KEY@TRS       CHAIN     TRSMST
018900030317     C                   EVAL      O_TRS1 = @TR
019000030317     C                   EVAL      O_TN1 = %TRIM(TNAME)
019100030317     C                   EVAL      O_TRS2 = @TR
019200030317     C                   EVAL      O_TN2 = %TRIM(TNAME)
019300030317     C                   ENDIF
019400030317    ***
019500030317     C                   WRITE     HDGF1
019600030317     C                   WRITE     HDGF2
019700030314    ***
019800030314     C                   ENDSR
019900030314   S***S
020000030314     C     $GBS          BEGSR
020100030314    ***
020200030314     C                   IF        #EMPBRK1 = 0
020300030314     C                   Z-ADD     NOEMPL        #EMPBRK1
020400030314     C                   ENDIF
020500030314    ***
020600030314     C                   IF        NOEMPL <> #EMPBRK1
020700030317     C                   EXSR      $WRTRPT1
020800030314     C                   Z-ADD     NOEMPL        #EMPBRK1
020900030314     C                   EVAL      NA1 = 0
021000030314     C                   EVAL      TE1 = 0
021100030314     C                   EVAL      TP1 = 0
021200030314    1C                   ENDIF
021300030314    ***
021400030314     C                   ADD       APREMI        TP1
021500030314     C                   ADD       APREMI        GTP1
021600030314     C                   ADD       1             NA1
021700030314     C                   ADD       1             GNA1
021800030314    ***
021900030314     C                   ENDSR
022000030314   S***S
022100030317     C     $WRTRPT1      BEGSR
022200030317    ***
022300030317     C                   Z-ADD     #EMPBRK1      NE1
022400030317     C                   EVAL      TE1 = NA1 * NE1
022500030317     C                   ADD       TE1           GTE1
022600030317     C                   IF        *IN98 = *ON
022700030317     C                   WRITE     HDGF1
022800030317     C                   EVAL      *IN98 = *OFF
022900030317     C                   ENDIF
023000030317     C                   WRITE     DTLF1
023100030317    ***
023200030317     C                   ENDSR
023300030317   S***S
023400030314     C     $BROKER       BEGSR
023500030314    ***
023600030314     C                   IF        #EMPBRK2 = 0
023700030314     C                   Z-ADD     NOEMPL        #EMPBRK2
023800030314     C                   ENDIF
023900030314    ***
024000030314     C                   IF        NOEMPL <> #EMPBRK2
024100030317     C                   EXSR      $WRTRPT2
024200030314     C                   Z-ADD     NOEMPL        #EMPBRK2
024300030314     C                   EVAL      NA2 = 0
024400030314     C                   EVAL      TE2 = 0
024500030314     C                   EVAL      TP2 = 0
024600030314    1C                   ENDIF
024700030314    ***
024800030314     C                   ADD       APREMI        TP2
024900030314     C                   ADD       APREMI        GTP2
025000030314     C                   ADD       1             NA2
025100030314     C                   ADD       1             GNA2
025200030317    ***
025300030317     C                   ENDSR
025400030317   S***S
025500030317     C     $WRTRPT2      BEGSR
025600030317    ***
025700030317     C                   Z-ADD     #EMPBRK2      NE2
025800030317     C                   EVAL      TE2 = NA2 * NE2
025900030317     C                   ADD       TE2           GTE2
026000030317     C                   IF        *IN99 = *ON
026100030317     C                   WRITE     HDGF2
026200030317     C                   EVAL      *IN99 = *OFF
026300030317     C                   ENDIF
026400030317     C                   WRITE     DTLF2
026500030317    ***
026600030317     C                   ENDSR
026700030317   S***S
026800030317     C     $FINLWRT      BEGSR
026900030317    ***
027000030317     C                   EXSR      $WRTRPT1
027100030317     C*
027200030317     C                   IF        *IN98 = *ON
027300030317     C                   WRITE     HDGF1
027400030317     C                   EVAL      *IN98 = *OFF
027500030317     C                   ENDIF
027600030317     C                   WRITE     SUMF1
027700030317    ***
027800030317     C                   EXSR      $WRTRPT2
027900030317     C*
028000030317     C                   IF        *IN99 = *ON
028100030317     C                   WRITE     HDGF2
028200030317     C                   EVAL      *IN99 = *OFF
028300030317     C                   ENDIF
028400030317     C                   WRITE     SUMF2
028500030314    ***
028600030314     C                   ENDSR
028700030314   X***X
