000100001016     H DFTNAME(CR141B) FIXNBR(*ZONED)
000200991229      ******************************************************************
000300991229      * CR141B     GROUP BENEFIT SERVICES SOFTWARE           1989      *
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
002000991229     FCR141BFM  CF   E             WORKSTN
002100991229     FTRSMST    IF   E           K DISK
002200991229
002300991229     D MSG             S             45    DIM(10) CTDATA PERRCD(1)
002400991229
002500991229      *      DATA STRUCTURE TO REARRANGE FROM & TO DATES
002600991229     D                 DS
002700991229     D  FRYMD                  1      8  0
002800991229     D  FRYY                   1      4  0
002900991229     D  FRMD                   5      8  0
003000991229
003100991229     D                 DS
003200991229     D  TOYMD                  1      8  0
003300991229     D  TOYY                   1      4  0
003400991229     D  TOMD                   5      8  0
003500991229
003600991229     D                UDS
003700991229     D  TRUST#                 7      9
003800991229     D  LFDATE                21     28  0
003900991229     D  LTDATE                29     36  0
004000000322     D  FRDAT                 37     44  0
004100000322     D  TODAT                 45     52  0
004200991229     D  TCODE                 53     86
004300991229     D  CONAME               201    240
004400991229
004500991110     DX                S              2  0
004600991110     DTRST#            S              3  0
004700991229
004800991110     ITRSMSR
004900991110     I              TSCODE                      TSCOD
005000991229
005100991229      ******************************************************************
005200991229      *                                                                *
005300991229      *    M A I N   L I N E    C A L C U L A T I O N S                *
005400991229      *                                                                *
005500991229      ******************************************************************
005600991229      *      SET OUTPUT SCREEN INDICATORS AND ERROR INDICATORS
005700991229
005800991110     C                   MOVEA     '00'          *IN(11)
005900991110     C                   MOVEA     '000000'      *IN(50)
006000991229
006100991110     C     #START        TAG
006200991229
006300991110     C                   EXFMT     IO01
006400991229
006500991229      *      CANCEL JOB UPON A CMD/7
006600991229
006700991110     C                   IF        *INKG = *ON
006800991110     C                   EVAL      *INLR = *ON
006900991110     C                   EVAL      *INU5 = *ON
007000991110     C                   GOTO      END
007100991110     C                   ENDIF
007200991229
007300991110     C                   MOVE      FRDATE        FRYY
007400991110     C                   MOVEL     FRDATE        FRMD
007500991110     C                   MOVE      TODATE        TOYY
007600991110     C                   MOVEL     TODATE        TOMD
007700000322     C                   MOVE      FRDATE        FRDAT
007800000322     C                   MOVE      TODATE        TODAT
007900991229
008000991229     C                   EXSR      #SEL
008100991229
008200991110     C                   EXFMT     IO02
008300991229
008400991229     C                   EXSR      #SORT
008500991229
008600991110     C     END           TAG
008700991229      ******************************************************************
008800991229      * --------  SELECT ROUTINE  -------------------------------------*
008900991229      ******************************************************************
009000991229     C     #SEL          BEGSR
009100991229
009200991229      *    VALIDATE SELECTED TRUST
009300991229
009400991124     C                   EVAL      TCODE = TSCODE
009500991124     C     TCODE         CAT       FLD001:0      TCODE
009600991124     C                   CAT       FLD002:0      TCODE
009700991124     C                   CAT       FLD003:0      TCODE
009800991124     C                   CAT       FLD004:0      TCODE
009900991124     C                   CAT       FLD005:0      TCODE
010000991124     C                   CAT       FLD006:0      TCODE
010100991124     C                   CAT       FLD007:0      TCODE
010200991124     C                   CAT       FLD008:0      TCODE
010300991124     C                   CAT       FLD009:0      TCODE
010400991124     C                   CAT       FLD010:0      TCODE
010500991124     C                   CAT       FLD011:0      TCODE
010600991124     C                   CAT       FLD012:0      TCODE
010700991124     C                   CAT       FLD013:0      TCODE
010800991124     C                   CAT       FLD014:0      TCODE
010900991124     C                   CAT       FLD015:0      TCODE
011000991124     C                   CAT       FLD016:0      TCODE
011100991124     C                   CAT       FLD017:0      TCODE
011200991124     C                   CAT       FLD018:0      TCODE
011300991124     C                   CAT       FLD019:0      TCODE
011400991124     C                   CAT       FLD020:0      TCODE
011500991124     C                   CAT       FLD021:0      TCODE
011600991124     C                   CAT       FLD022:0      TCODE
011700991124     C                   CAT       FLD023:0      TCODE
011800991124     C                   CAT       FLD024:0      TCODE
011900991124     C                   CAT       FLD025:0      TCODE
012000991124     C                   CAT       FLD026:0      TCODE
012100991124     C                   CAT       FLD027:0      TCODE
012200991124     C                   CAT       FLD028:0      TCODE
012300991124     C                   CAT       FLD029:0      TCODE
012400991124     C                   CAT       FLD030:0      TCODE
012500991124     C                   CAT       FLD031:0      TCODE
012600991124     C                   CAT       FLD032:0      TCODE
012700991124     C                   CAT       FLD033:0      TCODE
012800991229
012900991229     C                   IF        TRUST# <> 'ALL'
013000991110     C                   MOVE      TRUST#        TRST#
013100991110     C     TRST#         CHAIN     TRSMST                             40
013200991110     C                   IF        *IN40 = *ON
013300991110     C                   EVAL      *IN51 = *ON
013400991110     C                   EVAL      *IN50 = *ON
013500991110     C                   EVAL      X = 1
013600991110     C                   EVAL      EMSG = MSG(X)
013700991110     C                   IF        TCODE <> *BLANKS
013800991110     C                   EVAL      *IN50 = *ON
013900991110     C                   EVAL      *IN55 = *ON
014000991110     C                   EVAL      X = 6
014100991110     C                   EVAL      EMSG = MSG(X)
014200991110     C                   END
014300991110     C                   END
014400991110     C                   ELSE
014500991110     C                   EVAL      *IN50 = *OFF
014600991110     C                   EVAL      *IN51 = *OFF
014700991110     C                   EVAL      *IN55 = *OFF
014800991110     C                   ENDIF
014900991229
015000991110      *    VALIDATE SELECTION AND DATES
015100991229
015200991110     C                   IF        FRYMD > TOYMD
015300991110     C                   EVAL      *IN50 = *ON
015400991110     C                   EVAL      *IN53 = *ON
015500991110     C                   EVAL      X = 4
015600991110     C                   EVAL      EMSG = MSG(X)
015700991110     C                   ELSE
015800991110     C                   EVAL      *IN50 = *OFF
015900991110     C                   EVAL      *IN53 = *OFF
016000991110     C                   END
016100991229
016200991110      * IF ERROR WRITE SAME SCREEN
016300991229
016400991110     C                   IF        *IN50 = *ON
016500991110     C                   GOTO      #START
016600991110     C                   ELSE
016700991110     C                   EVAL      *IN50 = *ON
016800991110     C                   EVAL      X = 5
016900991110     C                   EVAL      EMSG = MSG(X)
017000991110     C                   ENDIF
017100991229
017200991110     C                   ENDSR
017300991110      ******************************************************************
017400991110      * --------  PRODUCE SORT SPECS ----------------------------------*
017500991110      ******************************************************************
017600991110     C     #SORT         BEGSR
017700991229
017800991110      * ON CMD 1  BLANK FIELDS AND WRITE SCREEN 1
017900991229
018000991110     C  NKA              GOTO      #T0010
018100991229
018200991110     C                   MOVE      *BLANKS       TRUST#
018300991110     C                   MOVE      *BLANKS       FRDATE
018400991110     C                   MOVE      *BLANKS       TODATE
018500991110     C                   SETOFF                                       U1
018600991124     C                   GOTO      #START
018700991229
018800991110     C     #T0010        TAG
018900991229
019000991110      * MOVE SELECTION CRITERIA TO LDA
019100991229
019200991110     C                   MOVE      FRYMD         LFDATE
019300991110     C                   MOVE      TOYMD         LTDATE
019400991229
019500991110      * END PROGRAM
019600991229
019700991110     C                   EVAL      *INLR = *ON
019800991229
019900991110     C     #T0020        ENDSR
020000991229
020100910215** MESSAGE ARRAY
020200991229   INVALID TRUST SELECTION
020300991229
020400991229
020500991229   INVALID DATE RANGE ENTERED
020600991229   PRESS ENTER TO PLACE JOB ON -JOBQ-
020700991229   INVALID CATEGORY CODE
020800991229
020900991229
021000991229
021100991229
