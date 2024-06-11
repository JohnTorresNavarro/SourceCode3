000100991020      ******************************************************************
000200991020      * FM420      GROUP BENEFIT SERVICES SOFTWARE           1999      *
000300991020      *  DESCRIPTION - THIS PROGRAM WILL ALLOW MAINTENANCE TO THE      *
000400991020      *            PRORATION RULE FILE                                 *
000500991020      *                                                                *
000600991020      *            WRITTEN BY - KIMBERLY S. JOHNSON                    *
000700991020      *            DATE - 10/19/99                                     *
000800991020      *                                                                *
000900991020      *                                                                *
000901160303      * 03/03/16 dlk - add edit for 00 code                            *
001000991020      *                                                                *
001100991020      ******************************************************************
001200991020     FFM420D    CF   E             WORKSTN
001300991020     FPRRULE    UF A E           K DISK
001400991019
001500991019     D MSG             S             45    DIM(5) CTDATA PERRCD(1)              ERROR MESSAGE ARRAY
001600991019
001700991019      * LDA INPUT FOR SCREEN TITLE
001800991019     D                UDS
001900991019     D  TITLE                201    240
002000991019
002100991019     DX                S              2  0
002200991019
002300991020      *  SET OFF OUTPUT AND FIELD HIGHLIGHT INDICATORS
002400991019
002500991019     C                   MOVEA     '0'           *IN(81)
002600991020
002700991020     C     #START        TAG
002800991020
002900991019     C                   EXFMT     IO01
003000991019
003100991019      *  ON CMD 7 END
003200991019
003300991019     C                   IF        *INKG = *ON
003400991019     C                   EVAL      *INLR = *ON
003500991019     C                   GOTO      END
003600991019     C                   ENDIF
003700991019
003800991019      *  EXECUTE RETRIEVE OR UPDATE SUBROUTINE BASED IN INPUT SCREEN
003900991019
004000991019     C                   EXSR      #RTRV
004100991020
004200991020      *  SETON UPDATE SCREEN OUTPUT INDICATOR
004300991020
004400991020     C     #START2       TAG
004500991020
004600991020     C                   EXFMT     IO02
004700991020
004800991019     C                   EXSR      #UPDT
004900991019
005000991019     C     END           TAG
005100991019
005200991019      ****************************************************************
005300991019      *  END OF MAINLINE CALCULATIONS                                *
005400991019      ****************************************************************
005500991019
005600991019      ****************************************************************
005700991019      *----------------------- RETRIEVE -----------------------------*
005800991019
005900991019     C     #RTRV         BEGSR
006000991019
006100991019      *  CHECK TO SEE IF CARRIER CODE IS BLANK
006200991019
006300160303     C                   IF        CODE = *BLANKS or code = '00'
006400991019     C                   EVAL      X = 1
006500991019     C                   EVAL      ERR = MSG(X)
006600991019     C                   EVAL      *IN81 = *ON
006700991020     C                   GOTO      #START
006800991020     C                   ELSE
006900991020     C                   EVAL      *IN81 = *OFF
007000991019     C                   ENDIF
007100991019
007200991019      *  GET RECORD IF IT IS ON FILE  - BLANK FIELDS IF NOT ON FILE
007300991019
007400991020     C     CODE          CHAIN     PRRULR                             42
007500991019     C                   IF        *IN42 = *ON
007600991020     C                   EVAL      RLNAM = *BLANKS
007700991020     C                   EVAL      RLDSC = *BLANKS
007800991019     C                   ENDIF
007900991020
008000991019     C     #ENDR         ENDSR
008100991019
008200991019      ****************************************************************
008300991019      *----------------------- UPDATE  ------------------------------*
008400991019
008500991019     C     #UPDT         BEGSR
008600991019
008700991019      * IF CMD1 EXIT WITH NO UPDATE
008800991019
008900991019     C                   IF        *INKA = *ON
009000991019     C                   GOTO      #START
009100991019     C                   ENDIF
009200991019
009300991019      * REDISPLAY SCREEN IF ERROR
009400991019
009500991019     C                   IF        *IN81 = *ON
009600991019     C                   EXFMT     IO02
009700991019     C                   GOTO      #ENDU
009800991019     C                   ENDIF
009900991019
010000991019      *  SETON ADD SCREEN AND OUTPUT INDICATORS
010100991019
010200991019     C                   IF        *IN42 = *ON
010300991020     C                   EVAL      PRRUL = CODE
010400991020     C                   WRITE     PRRULR
010500991019     C                   ELSE
010600991020     C                   UPDATE    PRRULR
010700991019     C                   ENDIF
010800991019
010900991020     C                   MOVEA     '0'           *IN(81)
011000991020
011100991020     C                   CLEAR                   CODE
011200991020
011300991019     C     #ENDU         ENDSR
011400991019
011500910215**   ERROR MESSAGE ARRAY
011600160303 ** PLEASE ENTER VALID PRORATION RULE CODE **
011700910215 ** DELETED RECORD - CMD6 TO REACTIVATE - **
011800910215 ** ENTER REQUIRED DATA                   **
011900910215 ** TRANSMIT DATA ?  ENTRY MUST BE "Y" OR "N"
012000991019 ** INVALID PRORATION RULE CODE           **
