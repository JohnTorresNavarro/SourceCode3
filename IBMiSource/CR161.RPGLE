000100001016     H DFTNAME(CR161) FIXNBR(*ZONED)
000200991229      ******************************************************************
000300991229      * CR161      GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400991229      *                                                                *
000500991229      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600991229      *            DATE - 10/23/89                                     *
000700991229      *                                                                *
000800991229      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE PROMPT AND CREATE     *
000900991229      *                SORT SPECS FOR MEDICAL FORMAT TRANSMITTAL       *
001000991229      *                PRINTOUT                                        *
001100991229      *                                                                *
001200991229      *  Y2K CONVERT - 1998                                            *
001300991229      *                                                                *
001400991229      * 12/1999  KSJ - Converted to RPG ILE                            *
001500991229      *                                                                *
001600000103      * NOTE: When re-compiling this program change 'Fix Numeric'      *
001700000103      *       option from *NONE to *ZONED and *INPUTPACKED             *
001800000103      *                                                                *
001900991229      ******************************************************************
002000991229     FCR161FM   CF   E             WORKSTN
002100991229     FTRSMST    IF   E           K DISK
002200991229
002300991116      *   OUTPUT SORTSPEC'S STORAGE ARRAY
002400991229     D MSG             S             45    DIM(10) CTDATA PERRCD(1)
002500991229
002600991229      *      DATA STRUCTURE TO REARRANGE FROM & TO DATES
002700991229     D                 DS
002800991229     D  FRYMD                  1      8  0
002900991229     D  FRYY                   1      4  0
003000991116     D  FRMD                   5      8  0
003100991229
003200991229     D                 DS
003300991229     D  TOYMD                  1      8  0
003400991229     D  TOYY                   1      4  0
003500991116     D  TOMD                   5      8  0
003600991229
003700991229     D                UDS
003800991229     D  TRUST#                 7      9
003900991229     D  LFDATE                21     28  0
004000991229     D  LTDATE                29     36  0
004100991116     D  FRDAT                 37     44  0
004200991116     D  TODAT                 45     52  0
004300991229     D  TCODE                 53     86
004400980817     D  BC                    90     90
004500991229     D  CONAME               201    240
004600991229
004700991116     DX                S              2  0
004800991116     DTRST#            S              3  0
004900991116     D
005000991229
005100991116     ITRSMSR
005200991116     I              TSCODE                      TSCOD
005300991229
005400991229      ******************************************************************
005500991229      *                                                                *
005600991229      *    M A I N   L I N E    C A L C U L A T I O N S                *
005700991229      *                                                                *
005800991229      ******************************************************************
005900991229
006000991229      *      SET OUTPUT SCREEN INDICATORS AND ERROR INDICATORS
006100991229
006200991116     C                   MOVEA     '00'          *IN(11)
006300991116     C                   MOVEA     '000000'      *IN(50)
006400991229
006500991116     C     #START        TAG
006600991229
006700991116     C                   EXFMT     IO01
006800991229
006900991229      *      CANCEL JOB UPON A CMD/7
007000991229
007100991116     C                   IF        *INKG = *ON
007200991116     C                   EVAL      *INLR = *ON
007300991116     C                   EVAL      *INU5 = *ON
007400991116     C                   GOTO      END
007500991116     C                   ENDIF
007600991229
007700991116     C                   MOVE      FRDATE        FRYY
007800991116     C                   MOVEL     FRDATE        FRMD
007900991116     C                   MOVE      TODATE        TOYY
008000991116     C                   MOVEL     TODATE        TOMD
008100991229
008200991229     C                   EXSR      #SEL
008300991229
008400991116     C                   EXFMT     IO02
008500991229
008600991229     C                   EXSR      #SORT
008700991229
008800991116     C     END           TAG
008900991229      ******************************************************************
009000991229      * --------  SELECT ROUTINE  -------------------------------------*
009100991229      ******************************************************************
009200991229     C     #SEL          BEGSR
009300991229
009400991229      *    VALIDATE SELECTED TRUST
009500991229
009600991116     C                   EVAL      TCODE = TSCODE
009700991116     C     TCODE         CAT       FLD001:0      TCODE
009800991116     C                   CAT       FLD002:0      TCODE
009900991116     C                   CAT       FLD003:0      TCODE
010000991116     C                   CAT       FLD004:0      TCODE
010100991116     C                   CAT       FLD005:0      TCODE
010200991116     C                   CAT       FLD006:0      TCODE
010300991116     C                   CAT       FLD007:0      TCODE
010400991116     C                   CAT       FLD008:0      TCODE
010500991116     C                   CAT       FLD009:0      TCODE
010600991116     C                   CAT       FLD010:0      TCODE
010700991116     C                   CAT       FLD011:0      TCODE
010800991116     C                   CAT       FLD012:0      TCODE
010900991116     C                   CAT       FLD013:0      TCODE
011000991116     C                   CAT       FLD014:0      TCODE
011100991116     C                   CAT       FLD015:0      TCODE
011200991116     C                   CAT       FLD016:0      TCODE
011300991116     C                   CAT       FLD017:0      TCODE
011400991116     C                   CAT       FLD018:0      TCODE
011500991116     C                   CAT       FLD019:0      TCODE
011600991116     C                   CAT       FLD020:0      TCODE
011700991116     C                   CAT       FLD021:0      TCODE
011800991116     C                   CAT       FLD022:0      TCODE
011900991116     C                   CAT       FLD023:0      TCODE
012000991116     C                   CAT       FLD024:0      TCODE
012100991116     C                   CAT       FLD025:0      TCODE
012200991116     C                   CAT       FLD026:0      TCODE
012300991116     C                   CAT       FLD027:0      TCODE
012400991116     C                   CAT       FLD028:0      TCODE
012500991116     C                   CAT       FLD029:0      TCODE
012600991116     C                   CAT       FLD030:0      TCODE
012700991116     C                   CAT       FLD031:0      TCODE
012800991116     C                   CAT       FLD032:0      TCODE
012900991116     C                   CAT       FLD033:0      TCODE
013000991229
013100991116     C                   IF        TRUST# <> 'ALL'
013200991116     C                   MOVE      TRUST#        TRST#
013300991116     C     TRST#         CHAIN     TRSMST                             40
013400991116     C                   IF        *IN40 = *ON
013500991116     C                   EVAL      *IN51 = *ON
013600991116     C                   EVAL      *IN50 = *ON
013700991116     C                   EVAL      X = 1
013800991116     C                   EVAL      EMSG = MSG(X)
013900991116     C                   IF        TCODE <> *BLANKS
014000991116     C                   EVAL      *IN50 = *ON
014100991116     C                   EVAL      *IN55 = *ON
014200991116     C                   EVAL      X = 6
014300991116     C                   EVAL      EMSG = MSG(X)
014400991116     C                   END
014500991116     C                   END
014600991116     C                   ELSE
014700991116     C                   EVAL      *IN50 = *OFF
014800991116     C                   EVAL      *IN51 = *OFF
014900991116     C                   EVAL      *IN55 = *OFF
015000991116     C                   ENDIF
015100991229
015200991229      *    VALIDATE SELECTION AND DATES
015300991229
015400991116     C                   IF        FRYMD > TOYMD
015500991116     C                   EVAL      *IN50 = *ON
015600991116     C                   EVAL      *IN53 = *ON
015700991116     C                   EVAL      X = 4
015800991116     C                   EVAL      EMSG = MSG(X)
015900991116     C                   ELSE
016000991116     C                   EVAL      *IN50 = *OFF
016100991116     C                   EVAL      *IN53 = *OFF
016200991116     C                   END
016300991229
016400991229      * IF ERROR WRITE SAME SCREEN
016500991229
016600991116     C                   IF        *IN50 = *ON
016700991116     C                   GOTO      #START
016800991116     C                   ELSE
016900991116     C                   EVAL      *IN50 = *ON
017000991116     C                   EVAL      X = 5
017100991116     C                   EVAL      EMSG = MSG(X)
017200991116     C                   ENDIF
017300991229
017400991229     C                   ENDSR
017500991229      ******************************************************************
017600991229      * --------  PRODUCE SORT SPECS ----------------------------------*
017700991229      ******************************************************************
017800991229     C     #SORT         BEGSR
017900991229
018000991229      * ON CMD 1  BLANK FIELDS AND WRITE SCREEN 1
018100991229
018200991229     C  NKA              GOTO      #T0010
018300991229
018400991229     C                   MOVE      *BLANKS       TRUST#
018500991229     C                   MOVE      *BLANKS       FRDATE
018600991229     C                   MOVE      *BLANKS       TODATE
018700991229     C                   GOTO      #START
018800991229
018900991229     C     #T0010        TAG
019000991229
019100991229      * MOVE SELECTION CRITERIA TO LDA
019200991229
019300991229     C                   MOVE      FRYMD         LFDATE
019400991229     C                   MOVE      TOYMD         LTDATE
019500991229
019600991229      * END PROGRAM
019700991229
019800991229     C                   SETON                                        LR
019900991229
020000991229     C     #T0020        ENDSR
020100991116
020200910215** MESSAGE ARRAY
020300991229   INVALID TRUST SELECTION
020400991229
020500991229
020600991229   INVALID DATE RANGE ENTERED
020700991229   PRESS ENTER TO PLACE JOB ON -JOBQ-
020800991229   INVALID CATEGORY CODE
020900991229
021000991229
021100991229
021200991229
