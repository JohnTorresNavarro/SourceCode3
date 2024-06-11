000001991020     H DFTNAME(FI080)
000002991020      **************************************************************************
000003991020      * FI080      GROUP BENEFIT SERVICES SOFTWARE           1988
000004991020      *
000006991020      *            WRITTEN BY - MICHAEL C. DUNPHY
000007991020      *            DATE - 06/29/88
000008991020      *
000009991020      *  MODIFICATION : COPY OF FM080 MODIFIED FOR CARRIER MASTER
000010991020      *                 FILE INQUIRY ONLY.                3/98   MLF
000011991020      *  y2kgsp
000012991020      *
000013991020      *       MODIFIED by Kimberly S. Johnson 10/19/99
000014991020      *               Added Proration Rule Field
000015991020      *
000016991020      **************************************************************************
001401991020     FFI080D    CF   E             WORKSTN
001402991020     FCARMST    IF   E           K DISK
001403991021     FPRRULE    IF   E           K DISK
001404991019
001600991020     D MSG             S             45    DIM(2) CTDATA PERRCD(1)
001601991019
001700991019      * LDA INPUT FOR SCREEN TITLE
001800991019     D                UDS
001900991019     D  TITLE                201    240
007000991019
007011991019     DX                S              2  0
007012991019
007100991020      *  SET OFF OUTPUT AND FIELD HIGHLIGHT INDICATORS
007200991019
007300991019     C                   MOVEA     '000'         *IN(11)
007301991019     C                   MOVEA     '000000000'   *IN(61)
007302991019     C                   MOVEA     '0'           *IN(81)
007702991020
007703991020     C     #START        TAG
007704991020
007705991019     C                   EXFMT     IO01
007706991019
007800991019      *  ON CMD 7 END
007900991019
008000991019     C                   IF        *INKG = *ON
008001991019     C                   EVAL      *INLR = *ON
008100991019     C                   GOTO      END
008101991019     C                   ENDIF
008200991019
008300991019      *  EXECUTE RETRIEVE OR UPDATE SUBROUTINE BASED IN INPUT SCREEN
008400991019
008500991019     C                   EXSR      #RTRV
008501991020
008502991020      *  SETON UPDATE SCREEN OUTPUT INDICATOR
008503991020
008504991020     C***  #START2       TAG
008505991020
008506991020     C                   EXFMT     IO02
008507991020
008600991019     C                   EXSR      #UPDT
008700991019
008800991019     C     END           TAG
008900991019
009000991019      ****************************************************************
009100991019      *  END OF MAINLINE CALCULATIONS                                *
009200991019      ****************************************************************
009300991019
009400991019      ****************************************************************
009500991019      *----------------------- RETRIEVE -----------------------------*
009600991019
009700991019     C     #RTRV         BEGSR
009800991019
009900991019      *  CHECK TO SEE IF CARRIER CODE IS BLANK
010000991019
010101991020     C                   IF        TRUST# = *BLANKS
010200991019     C                   EVAL      X = 1
010201991019     C                   EVAL      ERR = MSG(X)
010202991019     C                   EVAL      *IN81 = *ON
010300991020     C                   GOTO      #START
010301991020     C                   ELSE
010302991020     C                   EVAL      *IN81 = *OFF
010303991019     C                   ENDIF
010400991019
010500991019      *  GET RECORD IF IT IS ON FILE  - BLANK FIELDS IF NOT ON FILE
010600991019
010701991020     C     TRUST#        CHAIN     CARMST                             42
010702991019     C                   IF        *IN42 = *ON
010703991020     C                   EVAL      X = 1
010704991020     C                   EVAL      ERR = MSG(X)
010705991020     C                   EVAL      *IN81 = *ON
010706991020     C                   GOTO      #START
010707991020     C                   ELSE
010708991021     C     CPRRUL        CHAIN     PRRULR                             43
010709991020     C                   EVAL      *IN81 = *OFF
012600991019     C                   ENDIF
012700991019
012800991019      *  CHECK FOR DELETED RECORD      - 89 ON BLOCKS UPDATE OF
012900991019      *                                  DELETED RECORD
013000991019     C                   IF        CADLTD = 'D'
013001991019     C                   EVAL      X = 2
013002991019     C                   EVAL      *IN89 = *ON
013003991019     C                   EVAL      ERR = MSG(X)
013004991019     C                   EVAL      *IN81 = *ON
013005991020     C                   ELSE
013006991020     C                   EVAL      *IN89 = *OFF
013007991020     C                   EVAL      *IN81 = *OFF
013008991020     C                   ENDIF
013200991019
013201991020     C                   MOVE      CZIP          CZIP4
013202991020     C                   MOVEL     CZIP          CZIP5
013203991020     C                   MOVE      CAREA         AREAC
013204991020     C                   MOVE      CPHONE        F#0001
013205991020     C                   MOVEL     CPHONE        PHONE
013206991020
013700991019     C     #ENDR         ENDSR
013800991019
013900991019      ****************************************************************
014000991019      *----------------------- UPDATE  ------------------------------*
014100991019
014200991019     C     #UPDT         BEGSR
014300991019
014400991019      * IF CMD1 EXIT WITH NO UPDATE
014500991019
014501991019     C                   IF        *INKA = *ON
014502991019     C                   GOTO      #START
014700991019     C                   ENDIF
014800991019
015200991019
015300991019      * REDISPLAY SCREEN IF ERROR
015400991019
015401991019     C                   IF        *IN81 = *ON
015500991019     C                   EXFMT     IO02
015600991019     C                   GOTO      #ENDU
015601991019     C                   ENDIF
015700991019
016127991020
016200991019     C     #ENDU         ENDSR
016300991019
028000910215**   ERROR MESSAGE ARRAY
028100991020 **          INVALID CARRIER CODE         **
028200991020 **             DELETED RECORD            **
