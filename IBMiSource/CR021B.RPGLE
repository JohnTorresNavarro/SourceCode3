000100001016     H DFTNAME(CR021B) FIXNBR(*ZONED)
000200991109      ******************************************************************
000300991115      * CR021B     GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400991109      *                                                                *
000500991109      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600991109      *            DATE - 10/23/89                                     *
000700991109      *                                                                *
000800991109      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE PROMPT AND CREATE     *
000900991109      *                SORT SPECS FOR MEDICAL FORMAT TRANSMITTAL       *
001000991109      *                PRINTOUT                                        *
001100991109      *                                                                *
001200991109      *  Y2K CONVERT - 1998                                            *
001300991109      *                                                                *
001400991109      *  11.09.99 - KSJ  Converted to RPG ILE                          *
001500991109      *                                                                *
001600000103      * NOTE: When re-compiling this program change 'Fix Numeric'      *
001700000103      *       option from *NONE to *ZONED and *INPUTPACKED             *
001800000103      *                                                                *
001900991109      ******************************************************************
002000991109     FCR021BFM  CF   E             WORKSTN
002100991109     FTRSMST    IF   E           K DISK
002200991229
002300991229      *   OUTPUT SORTSPEC'S STORAGE ARRAY
002400991109     D MSG             S             45    DIM(10) CTDATA PERRCD(1)
002500991229
002600991229      *      DATA STRUCTURE TO REARRANGE FROM & TO DATES
002700991109     D                 DS
002800991109     D  FRYMD                  1      8  0
002900991109     D  FRYY                   1      4  0
003000991109     D  FRMD                   5      8  0
003100991229
003200991109     D                 DS
003300991109     D  TOYMD                  1      8  0
003400991109     D  TOYY                   1      4  0
003500991109     D  TOMD                   5      8  0
003600991229
003700991109     D                UDS
003800991109     D  LRDATE                 1      6  0
003900991109     D  TRUST#                 7      9
004000991109     D  LCATCD                13     15
004100991109     D  LFDATE                21     28  0
004200991109     D  LTDATE                29     36  0
004300991109     D  FRDAT                 37     44  0
004400991109     D  TODAT                 45     52  0
004500980806     D  TCODE                 53     86
004600980806     D  SELECT                90     90
004700991109     D  CONAME               201    240
004800991109
004900991109     DX                S              2  0
005000991109     DTRST#            S              3  0
005100991109
005200991109     ITRSMSR
005300991109     I              TSCODE                      TSCOD
005400991109
005500991109      ******************************************************************
005600991109      *                                                                *
005700991109      *    M A I N   L I N E    C A L C U L A T I O N S                *
005800991109      *                                                                *
005900991109      ******************************************************************
006000991109      *
006100991109      *      SET OUTPUT SCREEN INDICATORS AND ERROR INDICATORS
006200991109      *
006300991109     C                   MOVEA     '00'          *IN(11)
006400991109     C                   MOVEA     '000000'      *IN(50)
006500991229
006600991109     C     #START        TAG
006700991229
006800991109     C                   EXFMT     IO01
006900991109      *
007000991109      *      CANCEL JOB UPON A CMD/7
007100991109      *
007200991109
007300991109     C                   IF        *INKG = *ON
007400991109     C                   EVAL      *INLR = *ON
007500991109     C                   EVAL      *INU5 = *ON
007600991109     C                   GOTO      END
007700991109     C                   ENDIF
007800991229
007900991109     C                   MOVE      FRDATE        FRYY
008000991109     C                   MOVEL     FRDATE        FRMD
008100991109     C                   MOVE      TODATE        TOYY
008200991109     C                   MOVEL     TODATE        TOMD
008300991229
008400991109     C                   EXSR      #SEL
008500991229
008600991109     C                   EXFMT     IO02
008700991229
008800991109     C                   EXSR      #SORT
008900991229
009000991109     C     END           TAG
009100991109      ******************************************************************
009200991109      * --------  SELECT ROUTINE  -------------------------------------*
009300991109      ******************************************************************
009400991109     C     #SEL          BEGSR
009500991109      *
009600991109      *    VALIDATE SELECTED TRUST
009700991109      *
009800991116     C                   EVAL      TCODE = TSCODE
009900991116     C     TCODE         CAT       FLD001:0      TCODE
010000991116     C                   CAT       FLD002:0      TCODE
010100991116     C                   CAT       FLD003:0      TCODE
010200991116     C                   CAT       FLD004:0      TCODE
010300991116     C                   CAT       FLD005:0      TCODE
010400991116     C                   CAT       FLD006:0      TCODE
010500991116     C                   CAT       FLD007:0      TCODE
010600991116     C                   CAT       FLD008:0      TCODE
010700991116     C                   CAT       FLD009:0      TCODE
010800991116     C                   CAT       FLD010:0      TCODE
010900991116     C                   CAT       FLD011:0      TCODE
011000991116     C                   CAT       FLD012:0      TCODE
011100991116     C                   CAT       FLD013:0      TCODE
011200991116     C                   CAT       FLD014:0      TCODE
011300991116     C                   CAT       FLD015:0      TCODE
011400991116     C                   CAT       FLD016:0      TCODE
011500991116     C                   CAT       FLD017:0      TCODE
011600991116     C                   CAT       FLD018:0      TCODE
011700991116     C                   CAT       FLD019:0      TCODE
011800991116     C                   CAT       FLD020:0      TCODE
011900991116     C                   CAT       FLD021:0      TCODE
012000991116     C                   CAT       FLD022:0      TCODE
012100991116     C                   CAT       FLD023:0      TCODE
012200991116     C                   CAT       FLD024:0      TCODE
012300991116     C                   CAT       FLD025:0      TCODE
012400991116     C                   CAT       FLD026:0      TCODE
012500991116     C                   CAT       FLD027:0      TCODE
012600991116     C                   CAT       FLD028:0      TCODE
012700991116     C                   CAT       FLD029:0      TCODE
012800991116     C                   CAT       FLD030:0      TCODE
012900991116     C                   CAT       FLD031:0      TCODE
013000991116     C                   CAT       FLD032:0      TCODE
013100991116     C                   CAT       FLD033:0      TCODE
013200991229
013300991229     C                   IF        TRUST# <> 'ALL'
013400991109     C                   MOVE      TRUST#        TRST#
013500991109     C     TRST#         CHAIN     TRSMST                             40
013600991109     C                   IF        *IN40 = *ON
013700991109     C                   EVAL      *IN51 = *ON
013800991109     C                   EVAL      *IN50 = *ON
013900991109     C                   EVAL      X = 1
014000991109     C                   EVAL      EMSG = MSG(X)
014100991109     C                   IF        TCODE <> *BLANKS
014200991109     C                   EVAL      *IN50 = *ON
014300991109     C                   EVAL      *IN55 = *ON
014400991109     C                   EVAL      X = 6
014500991109     C                   EVAL      EMSG = MSG(X)
014600991109     C                   END
014700991109     C                   END
014800991109     C                   ELSE
014900991109     C                   EVAL      *IN50 = *OFF
015000991109     C                   EVAL      *IN51 = *OFF
015100991109     C                   EVAL      *IN55 = *OFF
015200991109     C                   ENDIF
015300991109      *
015400991109      *    VALIDATE SELECTION AND DATES
015500991109      *
015600991109     C                   IF        SELECT <> 'Y' AND SELECT <> 'N'
015700991109     C                   EVAL      *IN50 = *ON
015800991109     C                   EVAL      *IN52 = *ON
015900991109     C                   EVAL      X = 2
016000991109     C                   EVAL      EMSG = MSG(X)
016100991109     C                   ELSE
016200991109     C                   EVAL      *IN50 = *OFF
016300991109     C                   EVAL      *IN52 = *OFF
016400991109     C                   END
016500991229
016600991109     C                   IF        SELECT = 'Y' AND (FRDAT <> 0 OR TODAT <> 0)
016700991109     C                   EVAL      *IN50 = *ON
016800991109     C                   EVAL      *IN53 = *ON
016900991109     C                   EVAL      X = 3
017000991109     C                   EVAL      EMSG = MSG(X)
017100991109     C                   ELSE
017200991109     C                   EVAL      *IN50 = *OFF
017300991109     C                   EVAL      *IN53 = *OFF
017400991109     C                   END
017500991229
017600991109     C                   IF        SELECT = 'N' AND FRYMD > TOYMD
017700991109     C                   EVAL      *IN50 = *ON
017800991109     C                   EVAL      *IN53 = *ON
017900991109     C                   EVAL      X = 4
018000991109     C                   EVAL      EMSG = MSG(X)
018100991109     C                   ELSE
018200991109     C                   EVAL      *IN50 = *OFF
018300991109     C                   EVAL      *IN53 = *OFF
018400991109     C                   END
018500991109      *
018600991109      * IF ERROR WRITE SAME SCREEN
018700991109      *
018800991109     C                   IF        *IN50 = *ON
018900991109     C                   GOTO      #START
019000991109     C                   ELSE
019100991109     C                   EVAL      *IN50 = *ON
019200991109     C                   EVAL      X = 5
019300991109     C                   EVAL      EMSG = MSG(X)
019400991109     C                   ENDIF
019500991229
019600991109     C                   ENDSR
019700991109      ******************************************************************
019800991109      * --------  PRODUCE SORT SPECS ----------------------------------*
019900991109      ******************************************************************
020000991109     C     #SORT         BEGSR
020100991109      *
020200991109      * ON CMD 1  BLANK FIELDS AND WRITE SCREEN 1
020300991109      *
020400991109     C  NKA              GOTO      #T0010
020500991229
020600991109     C                   MOVE      *BLANKS       TRUST#
020700991109     C                   MOVE      *BLANKS       SELECT
020800991109     C                   MOVE      *BLANKS       FRDATE
020900991109     C                   MOVE      *BLANKS       TODATE
021000991109     C                   SETOFF                                       U1
021100991109     C                   SETON                                        11
021200991109     C                   GOTO      #T0020
021300991229
021400991109     C     #T0010        TAG
021500991109      *
021600991109      * IF SELECT = Y FULL RUN FOR SELECTED TRUST
021700991109      *
021800991109     C                   IF        SELECT = 'Y'
021900991109     C                   SETON                                        U1
022000991109     C                   END
022100991109      *
022200991109      * MOVE SELECTION CRITERIA TO LDA
022300991109      *
022400991109     C                   MOVE      FRYMD         LFDATE
022500991109     C                   MOVE      TOYMD         LTDATE
022600991222     C                   MOVE      FRDATE        FRDAT
022700991222     C                   MOVE      TODATE        TODAT
022800991109      *
022900991109      * END PROGRAM
023000991109      *
023100991109     C                   SETON                                        LR
023200991109     C                   SETOFF                                       0102
023300991229
023400991109     C     #T0020        ENDSR
023500991229
023600910215** MESSAGE ARRAY
02370091021501 INVALID TRUST SELECTION
02380091021502 INVALID SELECTION CODE (Y OR N)
02390091021503 DO NOT ENTER DATES FOR FULL RUN
02400091021504 INVALID DATE RANGE ENTERED
02410091021505 PRESS ENTER TO PLACE JOB ON -JOBQ-
02420091021506 INVALID CATEGORY CODE
02430091021507
02440091021508
02450091021509
02460091021510
