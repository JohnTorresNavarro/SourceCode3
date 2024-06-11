000100980916      * RPE010RG - Called from RPE010CL. Prints the 'Daily Member Transfer
000200980916      *             Report' based on a date range submitted via RPE010CL.
000300980916      * Pgmr-GSPHIPPS 9/98
000400980916      *
000500990316      *
000600981221      *DLW 12.98 CHANGED TO USE 8 BYTE DATES ONLY -Y2L COMPLIANT
000700131024      *SBT 10/24/13 Hist file expansion project - use HIST instead of wrkf
000800981221      *
000900131024     FHIST      IF   E             DISK
001000980914     FMEMBER    IF   E           K DISK
001100980914     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
001200970619      *
001300980914     D                 DS
001400980914     D  CK#NOT                 1     30
001500980915     D  OLDTSA                20     29  0
001600980915      * New account number
001700980915     D                 DS
001800980915     D  NEWTSA                 1     10  0
001900980915     D  HSTRST                 1      3  0
002000980915     D  HSSUB#                 4      6  0
002100980915     D  HSACCT                 7     10  0
002200970619     C/EJECT
002300131024     C                   READ      HIST                                   99
002400981221     C                   Z-ADD     TRDATE        TDHLD             8 0
002500970619      *
002600970619     C     *IN99         DOWEQ     *OFF
002700980915     C                   MOVE      HKEY          HKEY9             9 0
002800980914     C     MBRKEY        CHAIN     MEMBR                              98
002900970619      *
003000970619     C     *IN98         IFEQ      *OFF
003100980915      * Don't process record if not in member
003200980916     C                   EXSR      #NMESR
003300980914      *
003400980916     C     TRDATE        IFNE      TDHLD
003500980916     C                   EXCEPT    SPACE
003600980916     C                   Z-ADD     TRDATE        TDHLD
003700980916     C                   ENDIF
003800980916      *
003900980916     C     *INOF         IFEQ      *ON
004000980916     C                   EXCEPT    HEADER
004100980916     C                   MOVE      *OFF          *INOF
004200980916     C                   ENDIF
004300980917     C                   MOVE      TERMCD        TRMCD             2
004400981221     C                   MOVE      TRDATE        CYMD#             8
004500981221     C                   EXSR      #CYMD8
004600981221     C                   MOVE      MDCY#         TRDATE
004700981221     C                   MOVE      COVTDT        CYMD#             8
004800981221     C                   EXSR      #CYMD8
004900981221     C                   MOVE      MDCY#         COVTDT
005000980914     C                   EXCEPT    LOG
005100980915     C                   ADD       1             LRCNT             5 0
005200970619     C                   ENDIF
005300970619      *
005400131024     C                   READ      HIST                                   99
005500970619      *
005600970619     C                   ENDDO
005700970619     C                   MOVE      *ON           *INLR
005800131024     C     lrcnt         ifeq      0
005900131024     C                   MOVE      *ON           *IN88
006000131024     C                   ENDIF
006100980915     C                   EXCEPT    TOTALS
006200970619     C                   RETURN
006300970619     C/EJECT
006400980914      **-------------------------------------------------**
006500970619      **  Begin subroutines
006600980914      **-------------------------------------------------**
006700980916     C     #NMESR        BEGSR
006800980915      **-------------------------------------------------**
006900980915     C                   MOVEL(P)  MFNAME        FLD1             34
007000980915     C     MMI           IFNE      *BLANKS
007100980915     C     MFNAME        CAT       MMI:1         FLD1
007200980915     C                   CAT       '.':0         FLD1
007300980915     C                   ENDIF
007400980915     C                   CAT       MLNAME:1      FLD1
007500980915     C                   MOVE(P)   FLD1          N2#              34
007600980915     C                   ENDSR
007700980917      **-------------------------------------------------**
007800981221      * Convert dates from CCYYMMDD to MMDDCCYY
007900980917      **-------------------------------------------------**
008000981221     C     #CYMD8        BEGSR
008100981221     C                   MOVE      CYMD#         MMDD#             4
008200981221     C                   MOVEL     CYMD#         CCYY#             4
008300981221     C                   MOVEL     MMDD#         MDCY#             8
008400981221     C                   MOVE      CCYY#         MDCY#
008500980917     C                   ENDSR
008600970619     C/EJECT
008700980914      **-------------------------------------------------**
008800970619     C     *INZSR        BEGSR
008900980914      **-------------------------------------------------**
009000970619     C     MBRKEY        KLIST
009100980915     C                   KFLD                    HKEY9
009200980914      **
009300970620     C     *ENTRY        PLIST
009400981221     C                   PARM                    @BDATE            8
009500981221     C                   PARM                    @EDATE            8
009600980915     C                   PARM                    @88ON             1
009700980915     C                   PARM                    @CONAM           40
009800980914      *
009900981221     C                   MOVE      @BDATE        BDATE             8 0
010000981221     C                   MOVE      @EDATE        EDATE             8 0
010100980917      *
010200980917     C     BDATE         IFEQ      EDATE
010300980917     C                   MOVE      *ON           *IN77
010400980917     C                   ENDIF
010500980917      *
010600981221     C                   MOVE      BDATE         CYMD#             8
010700981221     C                   EXSR      #CYMD8
010800981221     C                   MOVE      MDCY#         BDATE
010900980917      **
011000981221     C                   MOVE      EDATE         CYMD#
011100981221     C                   EXSR      #CYMD8
011200981221     C                   MOVE      MDCY#         EDATE
011300980917      **
011400980914     C                   TIME                    TIMFLD            6 0
011500980914     C                   EXCEPT    HEADER
011600980914     C                   ENDSR
011700980914     O/EJECT
011800980916     OREPORT    E            HEADER         1 03
011900980916     O                                            8 'RPE010RG'
012000980916     O                       @CONAM              85
012100980914     O                                          126 'PAGE'
012200980914     O                       PAGE          Z    130
012300980914     O          E            HEADER         1
012400980914     O                       *DATE         Y     10
012500980916     O          E            HEADER         2
012600980914     O                       TIMFLD               8 ' 0:  :  '
012700980916     O                                           73 'DAILY MEMBER TRANSFER '
012800980916     O                                           79 'REPORT'
012900980917     O          E   N77      HEADER         2
013000980916     O                       BDATE         Y     62
013100980916     O                                           66 'to'
013200981221     O                       EDATE         Y     77
013300980917     O          E    77      HEADER         2
013400980917     O                                           60 'For'
013500980917     O                       EDATE         Y     71
013600980916     O          E            HEADER         1
013700980914     O                                            7 'Trans'
013800980916     O                                           82 'Trust - Sub - Acct'
013900980915     O                                          101 'Effect Date'
014000980915     O                                          109 'BC/BS'
014100980914     O          E            HEADER         1
014200981221     O                                            8 'Date'
014300980915     O                                           22 'Member Name'
014400980915     O                                           53 'SSN'
014500980915     O                                           67 'Old'
014600980915     O                                           82 'New'
014700980915     O                                          101 'of Transfer'
014800980915     O                                          113 'Term Code'
014900980914     O          E            HEADER         2
015000980914     O                                           24 '------------------------'
015100980914     O                                           48 '------------------------'
015200980914     O                                           72 '------------------------'
015300980914     O                                           96 '------------------------'
015400980914     O                                          120 '------------------------'
015500980914     O                                          144 '------------------------'
015600980914     O                                          168 '------------------------'
015700980914     O                                          192 '------------------------'
015800980914     O                                          198 '------'
015900980914      **
016000980916     O          E            SPACE          1
016100980916     O          E            LOG            1
016200981221     O                       TRDATE        Y     10
016300980915     O                       N2#                 44
016400980915     O                       HKEY9               57 '   .  .    '
016500980916     O                       OLDTSA              72 '   .   .    '
016600980916     O                       NEWTSA              87 '   .   .    '
016700980915     O                       COVTDT        Y     98
016800980917     O                       TRMCD              107
016900980915      *
017000980916     O          E       LR   TOTALS      2  0
017100980916     O                                           22 '*** Number of Members'
017200980914     O                                           37 'Transfered ***'
017300980915     O                       LRCNT         2     44
017400980915     O               88 LR                       62 '*ZERO RECORDS SELECTED*'
