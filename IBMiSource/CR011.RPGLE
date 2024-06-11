000100001016     H DFTNAME(CR011) FIXNBR(*ZONED)
000200991108      ******************************************************************
000300991115      * CR011      GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400991108      *                                                                *
000500991108      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600991108      *            DATE - 10/23/89                                     *
000700991108      *                                                                *
000800991108      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE PROMPT AND CREATE     *
000900991108      *                SORT SPECS FOR MEDICAL FORMAT TRANSMITTAL       *
001000991108      *                PRINTOUT                                        *
001100991108      *                                                                *
001200991108      *  Y2K CONVERT - 1998                                            *
001300991108      *                                                                *
001400991108      *  11.05.99 - KSJ  Converted to RPG ILE                          *
001500000103      *                                                                *
001600000103      * NOTE: When re-compiling this program change 'Fix Numeric'      *
001700000103      *       option from *NONE to *ZONED and *INPUTPACKED             *
001800000103      *                                                                *
001900991108      ******************************************************************
002000991108     FCR011FM   CF   E             WORKSTN
002100991108     FTRSMST    IF   E           K DISK
002200991229
002300991108      *   OUTPUT SORTSPEC'S STORAGE ARRAY
002400991108     D MSG             S             45    DIM(10) CTDATA PERRCD(1)
002500991229
002600991108      *      DATA STRUCTURE TO REARRANGE FROM & TO DATES
002700991108     D                 DS
002800991108     D  FRYMD                  1      8  0
002900991108     D  FRYY                   1      4  0
003000991108     D  FRMD                   5      8  0
003100991229
003200991108     D                 DS
003300991108     D  TOYMD                  1      8  0
003400991108     D  TOYY                   1      4  0
003500991108     D  TOMD                   5      8  0
003600991229
003700991108     D                UDS
003800991108     D  TRUST#                 7      9
003900991108     D  LCATCD                13     15
004000991108     D  LFDATE                21     28  0
004100991108     D  LTDATE                29     36  0
004200991102     D  FRDAT                 37     44  0
004300991102     D  TODAT                 45     52  0
004400991108     D  TCODE                 53     86
004500991108     D  CONAME               201    240
004600991102     D
004700991102     DX                S              2  0
004800991102     DTRST#            S              3  0
004900991102     D
005000991102     D
005100991102     ITRSMSR
005200991102     I              TSCODE                      TSCOD
005300991108      ******************************************************************
005400991108      *                                                                *
005500991108      *    M A I N   L I N E    C A L C U L A T I O N S                *
005600991108      *                                                                *
005700991108      ******************************************************************
005800991108      *
005900991108      *      SET OUTPUT SCREEN INDICATORS AND ERROR INDICATORS
006000991108      *
006100991102     C                   MOVEA     '00'          *IN(11)
006200991102     C                   MOVEA     '000000'      *IN(50)
006300991229
006400991102     C     #START        TAG
006500991229
006600991102     C                   EXFMT     IO01
006700991108      *
006800991108      *      CANCEL JOB UPON A CMD/7
006900991108      *
007000991102     C                   IF        *INKG = *ON
007100991102     C                   EVAL      *INLR = *ON
007200991102     C                   EVAL      *INU5 = *ON
007300991102     C                   GOTO      END
007400991108     C                   ENDIF
007500991229
007600991102     C                   MOVE      FRDATE        FRYY
007700991102     C                   MOVEL     FRDATE        FRMD
007800991102     C                   MOVE      TODATE        TOYY
007900991102     C                   MOVEL     TODATE        TOMD
008000991229
008100991108     C                   EXSR      #SEL
008200991229
008300991102     C                   EXFMT     IO02
008400991229
008500991108     C                   EXSR      #SORT
008600991229
008700991108     C     END           TAG
008800991108      ******************************************************************
008900991108      * --------  SELECT ROUTINE  -------------------------------------*
009000991108      ******************************************************************
009100991108     C     #SEL          BEGSR
009200991108      *
009300991108      *    VALIDATE SELECTED TRUST
009400991108      *
009500991116     C                   EVAL      TCODE = TSCODE
009600991116     C     TCODE         CAT       FLD001:0      TCODE
009700991116     C                   CAT       FLD002:0      TCODE
009800991116     C                   CAT       FLD003:0      TCODE
009900991116     C                   CAT       FLD004:0      TCODE
010000991116     C                   CAT       FLD005:0      TCODE
010100991116     C                   CAT       FLD006:0      TCODE
010200991116     C                   CAT       FLD007:0      TCODE
010300991116     C                   CAT       FLD008:0      TCODE
010400991116     C                   CAT       FLD009:0      TCODE
010500991116     C                   CAT       FLD010:0      TCODE
010600991116     C                   CAT       FLD011:0      TCODE
010700991116     C                   CAT       FLD012:0      TCODE
010800991116     C                   CAT       FLD013:0      TCODE
010900991116     C                   CAT       FLD014:0      TCODE
011000991116     C                   CAT       FLD015:0      TCODE
011100991116     C                   CAT       FLD016:0      TCODE
011200991116     C                   CAT       FLD017:0      TCODE
011300991116     C                   CAT       FLD018:0      TCODE
011400991116     C                   CAT       FLD019:0      TCODE
011500991116     C                   CAT       FLD020:0      TCODE
011600991116     C                   CAT       FLD021:0      TCODE
011700991116     C                   CAT       FLD022:0      TCODE
011800991116     C                   CAT       FLD023:0      TCODE
011900991116     C                   CAT       FLD024:0      TCODE
012000991116     C                   CAT       FLD025:0      TCODE
012100991116     C                   CAT       FLD026:0      TCODE
012200991116     C                   CAT       FLD027:0      TCODE
012300991116     C                   CAT       FLD028:0      TCODE
012400991116     C                   CAT       FLD029:0      TCODE
012500991116     C                   CAT       FLD030:0      TCODE
012600991116     C                   CAT       FLD031:0      TCODE
012700991116     C                   CAT       FLD032:0      TCODE
012800991116     C                   CAT       FLD033:0      TCODE
012900991229
013000991108     C                   IF        TRUST# <> 'ALL'
013100991102     C                   MOVE      TRUST#        TRST#
013200991108     C     TRST#         CHAIN     TRSMST                             40
013300991102     C                   IF        *IN40 = *ON
013400991102     C                   EVAL      *IN51 = *ON
013500991102     C                   EVAL      *IN50 = *ON
013600991102     C                   EVAL      X = 1
013700991102     C                   EVAL      EMSG = MSG(X)
013800991108     C                   IF        TCODE <> *BLANKS
013900991102     C                   EVAL      *IN50 = *ON
014000991102     C                   EVAL      *IN55 = *ON
014100991102     C                   EVAL      X = 6
014200991102     C                   EVAL      EMSG = MSG(X)
014300991108     C                   END
014400991108     C                   END
014500991108     C                   ELSE
014600991102     C                   EVAL      *IN50 = *OFF
014700991102     C                   EVAL      *IN51 = *OFF
014800991102     C                   EVAL      *IN55 = *OFF
014900991108     C                   ENDIF
015000991108      *
015100991108      *    VALIDATE SELECTION AND DATES
015200991108      *
015300991108     C                   IF        SELECT <> 'Y' AND SELECT <> 'N'
015400991102     C                   EVAL      *IN50 = *ON
015500991102     C                   EVAL      *IN52 = *ON
015600991109     C                   EVAL      X = 2
015700991102     C                   EVAL      EMSG = MSG(X)
015800991108     C                   ELSE
015900991102     C                   EVAL      *IN50 = *OFF
016000991102     C                   EVAL      *IN52 = *OFF
016100991108     C                   END
016200991229
016300991108     C                   IF        SELECT = 'Y' AND (FRDAT <> 0 OR TODAT <> 0)
016400991102     C                   EVAL      *IN50 = *ON
016500991102     C                   EVAL      *IN53 = *ON
016600991102     C                   EVAL      X = 3
016700991102     C                   EVAL      EMSG = MSG(X)
016800991108     C                   ELSE
016900991102     C                   EVAL      *IN50 = *OFF
017000991102     C                   EVAL      *IN53 = *OFF
017100991108     C                   END
017200991229
017300991108     C                   IF        SELECT = 'N' AND FRYMD > TOYMD
017400991102     C                   EVAL      *IN50 = *ON
017500991102     C                   EVAL      *IN53 = *ON
017600991102     C                   EVAL      X = 4
017700991102     C                   EVAL      EMSG = MSG(X)
017800991108     C                   ELSE
017900991102     C                   EVAL      *IN50 = *OFF
018000991102     C                   EVAL      *IN53 = *OFF
018100991108     C                   END
018200991229      *
018300991108      * IF ERROR WRITE SAME SCREEN
018400991108      *
018500991108     C                   IF        *IN50 = *ON
018600991102     C                   GOTO      #START
018700991102     C                   ELSE
018800991102     C                   EVAL      *IN50 = *ON
018900991102     C                   EVAL      X = 5
019000991102     C                   EVAL      EMSG = MSG(X)
019100991102     C                   ENDIF
019200991229
019300991108     C                   ENDSR
019400991108      ******************************************************************
019500991108      * --------  PRODUCE SORT SPECS ----------------------------------*
019600991108      ******************************************************************
019700991108     C     #SORT         BEGSR
019800991108      *
019900991108      * ON CMD 1  BLANK FIELDS AND WRITE SCREEN 1
020000991108      *
020100991108     C  NKA              GOTO      #T0010
020200991229
020300991108     C                   MOVE      *BLANKS       TRUST#
020400991108     C                   MOVE      *BLANKS       SELECT
020500991108     C                   MOVE      *BLANKS       FRDATE
020600991108     C                   MOVE      *BLANKS       TODATE
020700991108     C                   SETOFF                                       U1
020800991116     C                   GOTO      #START
020900991229
021000991108     C     #T0010        TAG
021100991108      *
021200991108      * IF SELECT = Y FULL RUN FOR SELECTED TRUST
021300991108      *
021400991108     C                   IF        SELECT = 'Y'
021500991108     C                   SETON                                        U1
021600991108     C                   END
021700991108      *
021800991108      * MOVE SELECTION CRITERIA TO LDA
021900991108      *
022000991108     C                   MOVE      FRYMD         LFDATE
022100991108     C                   MOVE      TOYMD         LTDATE
022200991108      *
022300991108      * END PROGRAM
022400991108      *
022500991108     C                   SETON                                        LR
022600991229
022700991108     C     #T0020        ENDSR
022800991116
022900910215** MESSAGE ARRAY
02300091021501 INVALID TRUST SELECTION
02310091021502 INVALID SELECTION CODE (Y OR N)
02320091021503 DO NOT ENTER DATES FOR FULL RUN
02330091021504 INVALID DATE RANGE ENTERED
02340091021505 PRESS ENTER TO PLACE JOB ON -JOBQ-
02350091021506 INVALID CATEGORY CODE
02360091021507
02370091021508
02380091021509
02390091021510
