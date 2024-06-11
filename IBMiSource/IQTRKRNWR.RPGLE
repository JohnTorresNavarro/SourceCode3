000100060309      * ****************************************************************
000200060309      *                                                                *
000300060309      *            GROUP BENEFIT SERVICES SOFTWARE                     *
000400060309      *                                                                *
000500060309      *            WRITTEN BY - TERRY POWERS                           *
000600060309      *            DATE - 09/06/02                                     *
000700060309      *                                                                *
000800060309      *  DESCRIPTION - THIS PROGRAM INQUIRES TRKRNWLP
000900060309      * ****************************************************************
001000060309
001100020906     FIQTRKRNWD CF   E             WORKSTN
001200020506     F                                     SFILE(SFL_REC1:SRECNO1)
001300020729     F                                     SFILE(SFL_REC2:SRECNO2)
001400020430     F                                      INDDS(INDICATORS)
001500020703     FSUBMST    IF   E           K DISK
001600020703     FACCMST    IF   E           K DISK
001700020906     FTRKRNWL1  IF   E           K DISK    RENAME(TRKRNWLR:TRKRNL1)
001800020906     FTRKRNWL2  IF   E           K DISK    RENAME(TRKRNWLR:TRKRNL2)
001900020709     FTRSMST    IF   E           K DISK
002000020906     FTRKRNWLP  IF   E           K DISK
002100011004
002200020730     D DIVIDERS        S             79    INZ('------------------------------+
002300020730     D                                          -------------------------------+
002400020730     D                                          ------------------')
002500020730     D SCH_A           S              1    DIM(40) INZ(*BLANKS)
002600020703     D SRECNO1         S              4  0 INZ(*ZEROS)
002700020801     D SRECNO2         S                   LIKE(SRECNO1) INZ(*ZEROS)
002800020801     D SRECNO2_H       S                   LIKE(SRECNO1) INZ(*ZEROS)
002900020801     D ADV_REC         S                   LIKE(SRECNO1) INZ(*ZEROS)
003000020430     D SCREEN          S              8
003100020729     D DATE_IN         S              8  0 INZ(*ZEROS)
003200020801     D DATE_OUT        S                   LIKE(DATE_IN) INZ(*ZEROS)
003300020628     D BACK_TO         S                   LIKE(SCREEN)
003400020710     D INDEX           S              4  0 INZ(*ZEROS)
003500020801     D INDEX2          S                   LIKE(INDEX) INZ(*ZEROS)
003600020801     D INDEX3          S                   LIKE(INDEX) INZ(*ZEROS)
003700020718     D WHERE           S              4  0 INZ(*ZEROS)
003800020729     D SFLRECHDR2      S                   LIKE(SFLRECHDR)
003900020801     D TEST_MM         S                   LIKE(I_MM) INZ(*ZEROS)
004000020730     D I_CAT2          S              2
004100020731     D ADV_TRST2       S                   LIKE(TRTRST)
004200020710
004300020710     D ISO_DATE        S               D   DATFMT(*ISO)
004400020710     D USA_DATE        S               D   DATFMT(*USA)
004500020710
0046000207310030 D                 DS
004700020731     D ADVANCE2                       2
004800020731     D  ADVANCE1                      1    OVERLAY(ADVANCE2)
004900020731     D  ADVANCE11                     1    OVERLAY(ADVANCE2:2)
0050000207100030 D                 DS
005100020710     D I_NAM1
005200020710     D  SCH1                          1    OVERLAY(I_NAM1)
005300020710     D  SCH2                          2    OVERLAY(I_NAM1)
005400020710     D  SCH3                          3    OVERLAY(I_NAM1)
005500020710     D  SCH4                          4    OVERLAY(I_NAM1)
005600020710     D  SCH5                          5    OVERLAY(I_NAM1)
005700020710     D  SCH6                          6    OVERLAY(I_NAM1)
005800020710     D  SCH7                          7    OVERLAY(I_NAM1)
005900020710     D  SCH8                          8    OVERLAY(I_NAM1)
006000020710     D  SCH9                          9    OVERLAY(I_NAM1)
006100020710     D  SCH10                        10    OVERLAY(I_NAM1)
006200020710     D  SCH11                        11    OVERLAY(I_NAM1)
006300020710     D  SCH12                        12    OVERLAY(I_NAM1)
006400020710     D  SCH13                        13    OVERLAY(I_NAM1)
006500020710     D  SCH14                        14    OVERLAY(I_NAM1)
006600020710     D  SCH15                        15    OVERLAY(I_NAM1)
006700020710     D  SCH16                        16    OVERLAY(I_NAM1)
006800020710     D  SCH17                        17    OVERLAY(I_NAM1)
006900020710     D  SCH18                        18    OVERLAY(I_NAM1)
007000020710     D  SCH19                        19    OVERLAY(I_NAM1)
007100020710     D  SCH20                        20    OVERLAY(I_NAM1)
007200020710     D  SCH21                        21    OVERLAY(I_NAM1)
007300020710     D  SCH22                        22    OVERLAY(I_NAM1)
007400020710     D  SCH23                        23    OVERLAY(I_NAM1)
007500020710     D  SCH24                        24    OVERLAY(I_NAM1)
007600020710     D  SCH25                        25    OVERLAY(I_NAM1)
007700020710     D  SCH26                        26    OVERLAY(I_NAM1)
007800020710     D  SCH27                        27    OVERLAY(I_NAM1)
007900020710     D  SCH28                        28    OVERLAY(I_NAM1)
008000020710     D  SCH29                        29    OVERLAY(I_NAM1)
008100020710     D  SCH30                        30    OVERLAY(I_NAM1)
008200020710     D  SCH31                        31    OVERLAY(I_NAM1)
008300020710     D  SCH32                        32    OVERLAY(I_NAM1)
008400020710     D  SCH33                        33    OVERLAY(I_NAM1)
008500020710     D  SCH34                        34    OVERLAY(I_NAM1)
008600020710     D  SCH35                        35    OVERLAY(I_NAM1)
008700020710     D  SCH36                        36    OVERLAY(I_NAM1)
008800020710     D  SCH37                        37    OVERLAY(I_NAM1)
008900020710     D  SCH38                        38    OVERLAY(I_NAM1)
009000020710     D  SCH39                        39    OVERLAY(I_NAM1)
009100020710     D  SCH40                        40    OVERLAY(I_NAM1)
009200020710
0093000207100030 D                 DS
009400020710     D TRNAME
009500020710     D  NAM1                          1    OVERLAY(TRNAME)
009600020710     D  NAM2                          2    OVERLAY(TRNAME)
009700020710     D  NAM3                          3    OVERLAY(TRNAME)
009800020710     D  NAM4                          4    OVERLAY(TRNAME)
009900020710     D  NAM5                          5    OVERLAY(TRNAME)
010000020710     D  NAM6                          6    OVERLAY(TRNAME)
010100020710     D  NAM7                          7    OVERLAY(TRNAME)
010200020710     D  NAM8                          8    OVERLAY(TRNAME)
010300020710     D  NAM9                          9    OVERLAY(TRNAME)
010400020710     D  NAM10                        10    OVERLAY(TRNAME)
010500020710     D  NAM11                        11    OVERLAY(TRNAME)
010600020710     D  NAM12                        12    OVERLAY(TRNAME)
010700020710     D  NAM13                        13    OVERLAY(TRNAME)
010800020710     D  NAM14                        14    OVERLAY(TRNAME)
010900020710     D  NAM15                        15    OVERLAY(TRNAME)
011000020710     D  NAM16                        16    OVERLAY(TRNAME)
011100020710     D  NAM17                        17    OVERLAY(TRNAME)
011200020710     D  NAM18                        18    OVERLAY(TRNAME)
011300020710     D  NAM19                        19    OVERLAY(TRNAME)
011400020710     D  NAM20                        20    OVERLAY(TRNAME)
011500020710     D  NAM21                        21    OVERLAY(TRNAME)
011600020710     D  NAM22                        22    OVERLAY(TRNAME)
011700020710     D  NAM23                        23    OVERLAY(TRNAME)
011800020710     D  NAM24                        24    OVERLAY(TRNAME)
011900020710     D  NAM25                        25    OVERLAY(TRNAME)
012000020710     D  NAM26                        26    OVERLAY(TRNAME)
012100020710     D  NAM27                        27    OVERLAY(TRNAME)
012200020710     D  NAM28                        28    OVERLAY(TRNAME)
012300020710     D  NAM29                        29    OVERLAY(TRNAME)
012400020710     D  NAM30                        30    OVERLAY(TRNAME)
012500020710     D  NAM31                        31    OVERLAY(TRNAME)
012600020710     D  NAM32                        32    OVERLAY(TRNAME)
012700020710     D  NAM33                        33    OVERLAY(TRNAME)
012800020710     D  NAM34                        34    OVERLAY(TRNAME)
012900020710     D  NAM35                        35    OVERLAY(TRNAME)
013000020710     D  NAM36                        36    OVERLAY(TRNAME)
013100020710     D  NAM37                        37    OVERLAY(TRNAME)
013200020710     D  NAM38                        38    OVERLAY(TRNAME)
013300020710     D  NAM39                        39    OVERLAY(TRNAME)
013400020710     D  NAM40                        40    OVERLAY(TRNAME)
013500020710     D  ACNAM1                             OVERLAY(TRNAME)
013600020731     D  LINE_DS1                      1    OVERLAY(ACNAM1)
013700020731     D  LINE_DS                       2    OVERLAY(ACNAM1)
013800020430
0139000204300030 D INDICATORS      DS            99
014000020626     D  F1_BACK               01     01N   INZ('0')
014100020731     D  F2_ACCSORT            02     02N   INZ('0')
014200020731     D  F7_EXIT               07     07N   INZ('0')
014300020725     D  F12_SCRN1             12     12N   INZ('0')
014400020506     D  SFLDSP_11             11     11N   INZ('0')
014500020506     D  SFLEND_22             22     22N   INZ('0')
014600020731     D  IN50                  50     50N   INZ('0')
014700020731     D  IN51                  51     51N   INZ('0')
014800020731     D  IN53                  53     53N   INZ('0')
014900020730     D  ADV_ONCE                       N   INZ('0')
015000020731     D  LEAVEDO                        N   INZ('0')
015100020718
015200020718     D                 DS
015300020730     D SFLRECHDR                     79
015400020729     D  TRTRST                             OVERLAY(SFLRECHDR) INZ(*ZEROS)
015500020729     D  BLK1                          1    OVERLAY(SFLRECHDR:*NEXT)
015600020729     D  TRSUB#                             OVERLAY(SFLRECHDR:*NEXT) INZ(*ZEROS)
015700020729     D  BLK2                          1    OVERLAY(SFLRECHDR:*NEXT)
015800020729     D  TRACCT                             OVERLAY(SFLRECHDR:*NEXT) INZ(*ZEROS)
015900020729     D  BLK3                          1    OVERLAY(SFLRECHDR:*NEXT)
016000020729     D  TRNAME_S                           OVERLAY(SFLRECHDR:*NEXT)
016100020729     D                                     LIKE(TRNAME)
016200020729
016300020729     D                 DS
016400021001     D SFLRECDTL                     80
016500020729     D  TRGROUP#                           OVERLAY(SFLRECDTL:*NEXT)
016600020729     D  BLK4                          1    OVERLAY(SFLRECDTL:*NEXT)
016700020729     D  TRPLNCAT3                          OVERLAY(SFLRECDTL:*NEXT)
016800021001     D                                     LIKE(TRPLNCAT)
016900020730     D  BLK5                          2    OVERLAY(SFLRECDTL:*NEXT)
017000020814     D  TRPLAN                             OVERLAY(SFLRECDTL:*NEXT)
017100020730     D  BLK6                          2    OVERLAY(SFLRECDTL:*NEXT)
017200020814     D  BEGDAT_USA                   10    OVERLAY(SFLRECDTL:*NEXT)
017300020730     D  BLK7                          3    OVERLAY(SFLRECDTL:*NEXT)
017400020814     D  TRRENMM                            OVERLAY(SFLRECDTL:*NEXT)
017500020730     D  BLK8                          3    OVERLAY(SFLRECDTL:*NEXT)
017600020909     D  NRNDT_USA                    10    OVERLAY(SFLRECDTL:*NEXT)
017700020814     D  BLK9                          3    OVERLAY(SFLRECDTL:*NEXT)
017800020814     D  TRNONRN                            OVERLAY(SFLRECDTL:*NEXT)
017900020814     D  BLK10                         5    OVERLAY(SFLRECDTL:*NEXT)
018000020814     D  TRMKTSIZE                          OVERLAY(SFLRECDTL:*NEXT)
018100020814     D  BLK11                         4    OVERLAY(SFLRECDTL:*NEXT)
018200020814     D  TRPCARR                            OVERLAY(SFLRECDTL:*NEXT)
018300020730
018400020730     D                 DS
018500020906     D TRNRNDT                             INZ(*ZEROS)
018600020906     D   FILE_MM                      2  0 OVERLAY(TRNRNDT:5)
018700020626
018800020626     D                UDS
018900020712     D  APPL_E                        2
019000020626     D  CONAME               201    240
019100011106
019200020430      *? ***************************************************************
019300020430
019400020430     C                   SELECT
019500020628     C                   WHEN      SCREEN = 'SCRN1   '
019600020628     C                   EXSR      SCRN1_SR
019700020703     C                   WHEN      SCREEN = 'SFL1    '
019800020703     C                   EXSR      SFL1_SR
019900020731     C                   WHEN      SCREEN = 'SEARCH  '
020000020731     C                   EXSR      SEARCH_SR
020100020626     C                   WHEN      SCREEN = 'EXIT    '
020200020626     C                   EXSR      EXIT_SR
020300020430     C                   OTHER
020400020701     C                   EXSR      SCRN1_SR
020500020430     C                   ENDSL
020600020628      *? ***************************************************************
020700020628     C     SCRN1_SR      BEGSR
020800020703     C                   RESET                   SCRN1
020900020628     C                   EXFMT     SCRN1
021000020628     C                   IF        F1_BACK = *ON  OR
021100020628     C                             F7_EXIT     = *ON
021200020628     C                   EVAL      SCREEN = 'EXIT    '
021300020628     C                   LEAVESR
021400020628     C                   END
021500020731
021600020801      *? DISPLAY ADVANCE MESSAGE OR NOT,IN50 AND IN51   ****************
021700020731     C                   EVAL      IN50 = *OFF
021800020731     C                   EVAL      IN51 = *ON
021900020801     C                   IF        I_TRST <> *ZEROS
022000020801     C                   EVAL      SCREEN = 'SFL1    '
022100020801     C                   LEAVESR
022200020801     C                   END
022300020731
022400020731     C                   EVAL      SCREEN = 'SEARCH  '
022500020731     C                   IF        I_NAM1     = *BLANKS AND
022600020731     C                             I_MM       = *ZEROS  AND
022700020731     C                             I_CAT      = *BLANKS
022800020731     C                   EXFMT     NAME_WIN
022900020731     C                   EVAL      SCREEN = 'SCRN1   '
023000020731     C                   LEAVESR
023100020731     C                   END
023200020731     C                   IF        I_NAM1    <> *BLANKS
023300020731     C                   EVAL      IN50 = *ON
023400020731     C                   EVAL      I_MM    = *ZEROS
023500020731     C                   EVAL      I_CAT      = *BLANKS
023600020731     C                   LEAVESR
023700020731     C                   END
023800020731
023900020731     C                   IF        I_MM   >= 1      AND
024000020731     C                             I_MM   <= 12
024100020731     C                   EVAL      IN51 = *OFF
024200020731     C                   EVAL      I_NAM1     = *BLANKS
024300020801     C                   EVAL      I_NON = I_NON2
024400020731     C                   ELSE
024500020731     C                   EXFMT     DATE_WIN
024600020731     C                   EVAL      SCREEN = 'SCRN1   '
024700020731     C                   LEAVESR
024800020731     C                   END
024900020628     C                   ENDSR
025000020703      *? ***************************************************************
025100020703     C     ACC_SR        BEGSR
025200020703     C     *NOKEY        CLEAR     *ALL          ACCMSR
025300020703     C     ACCMST_KEY    CHAIN     ACCMSR
025400020703
025500020709     C     *NOKEY        CLEAR     *ALL          TRSMSR
025600020709     C     TRTRST        CHAIN     TRSMSR
025700020703     C     *NOKEY        CLEAR     *ALL          SUBMSR
025800020703     C     SUBMST_KEY    CHAIN     SUBMSR
025900020703     C                   ENDSR
026000020701      *? TRST SUB ACCT *************************************************
026100020703     C     SFL1_SR       BEGSR
026200020701     C                   EVAL      SRECNO1 = *ZEROS
026300020701     C                   EVAL      RECNUM  = 1
026400020701     C                   EVAL      SFLDSP_11  = *ON
026500020701    ?C                   WRITE     SFL_CTL1
026600020701     C                   EVAL      SFLDSP_11  = *OFF
026700020701     C                   EVAL      SFLEND_22  = *ON
026800020729     C                   EVAL      TRTRST = I_TRST
026900020729     C                   EVAL      TRSUB# = I_SUB#
027000020729     C                   EVAL      TRACCT = I_ACCT
027100020703     C                   EXSR      ACC_SR
027200020909     C     TRK_KEY       SETLL     TRKRNWLR
027300020906     C                   DOU       %EOF(TRKRNWLP)
027400020909     C     TRK_KEY       READE     TRKRNWLR
027500020906     C                   IF        NOT %EOF(TRKRNWLP)
027600020701
027700020701      *? ISO TO USA
027800020701     C                   EXSR      DATES_SR
027900020801     C                   IF        I_NON =  'Y'
028000020801     C                   ELSE
028100020801     C                   IF        TRNONRN <> *BLANKS
028200020801     C                   ITER
028300020801     C                   END
028400020801     C                   END
028500020701
028600020701     C                   EVAL      SRECNO1  = SRECNO1 + 1
028700020701     C                   IF        SRECNO1 > 9997
028800020729     C                   EVAL      ACNAM1  = 'CANNOT DISPLAY ALL RECORDS'
028900020701     C                   LEAVE
029000020701     C                   END
029100020701    ?C                   WRITE     SFL_REC1
029200020730     C                   END
029300020701     C                   ENDDO
029400020701     C                   IF        SRECNO1 = *ZEROS
029500020701     C                   EVAL      SRECNO1  = SRECNO1 + 1
029600020702
029700020702     C                   CLEAR                   SFL_REC1
029800020730     C                   EVAL      TRGROUP# = 'NOT FOUND'
029900020701    ?C                   WRITE     SFL_REC1
030000020701     C                   END
030100020701     C
030200020701     C                   WRITE     CMD_LINE1
030300020701    ?C                   EXFMT     SFL_CTL1
030400020701
030500020703     C                   IF        F1_BACK = *ON OR
030600020725     C                             F12_SCRN1   = *ON
030700020701     C                   EVAL      SCREEN = 'SCRN1   '
030800020701     C                   LEAVESR
030900020701     C                   END
031000020701
031100020701     C                   IF        F7_EXIT     = *ON
031200020701     C                   EVAL      SCREEN = 'EXIT    '
031300020701     C                   LEAVESR
031400020701     C                   END
031500020702
031600020702     C                   EVAL      BACK_TO = 'SFL1    '
031700020701
031800020701     C                   EVAL      SCREEN = 'SFL1    '
031900020701
032000020701     C                   ENDSR
032100020731      *? ALPHA1        *************************************************
032200020731     C     ALPHA1_SR     BEGSR
032300020731     C                   MOVEA     I_NAM1        SCH_A
032400020731     C                   EVAL      INDEX2 = 41
032500020731     C                   EVAL      INDEX3 = *ZEROS
032600020731     C                   DO        40            INDEX
032700020731     C                   EVAL      INDEX3 = INDEX2 - INDEX
032800020731     C                   IF        SCH_A(INDEX3) = *BLANKS
032900020731     C                   ITER
033000020731     C                   ELSE
033100020731     C                   LEAVE
033200020731     C                   END
033300020731     C                   ENDDO
033400020731     C                   ENDSR
033500020523
033600020703      *? ALPHA SEARCH  *************************************************
033700020731     C     SEARCH_SR     BEGSR
033800020801     C                   EVAL      SRECNO2_H = *ZEROS
033900020730     C                   EVAL      ADVANCE  = *BLANKS
034000020731     C                   EVAL      ADV_TRST = *ZEROS
034100020730     C                   EVAL      ADV_ONCE = *OFF
034200020731     C                   EVAL      BACK_TO = 'SEARCH  '
034300020718     C                   EVAL      SRECNO2 = *ZEROS
034400020718     C                   EVAL      RECNUM2 = 1
034500020718     C                   EVAL      SFLDSP_11  = *ON
034600020718    ?C                   WRITE     SFL_CTL2
034700020718     C                   EVAL      SFLDSP_11  = *OFF
034800020718     C                   EVAL      SFLEND_22  = *ON
034900020718
035000020821     C                   EVAL      IN51 = *OFF
035100020731     C                   IF        I_MM    = *ZEROS
035200020821     C                   EVAL      IN51 = *ON
035300020731     C                   EXSR      ALPHA1_SR
035400020730     C                   END
035500020731     C                   IF        F2_ACCSORT = *OFF
035600020906     C     I_NAM1        SETLL     TRKRNL1
035700020731     C                   ELSE
035800020906     C     *LOVAL        SETLL     TRKRNL2
035900020731     C                   END
036000020731     C                   DOU       %EOF
036100020731     C                   IF        F2_ACCSORT = *OFF
036200020906     C                   READ      TRKRNL1
036300020731     C                   ELSE
036400020906     C                   READ      TRKRNL2
036500020731     C                   END
036600020731     C                   IF        NOT %EOF
036700020731     C                   IF        I_MM  = *ZEROS
036800020731     C                   EXSR      ALPHA_SR
036900020731     C                   ELSE
037000020731     C                   EXSR      MM_CAT_SR
037100020731     C                   END
037200020731     C                   IF        LEAVEDO = *ON
037300020731     C                   EVAL      LEAVEDO = *OFF
037400020731     C                   ITER
037500020731     C                   END
037600020730
037700020718      *? ISO TO USA
037800020718     C                   EXSR      DATES_SR
037900020801     C                   IF        I_NON =  'Y'
038000020801     C                   ELSE
038100020801     C                   IF        TRNONRN <> *BLANKS
038200020801     C                   ITER
038300020801     C                   END
038400020801     C                   END
038500020731     C                   IF        SRECNO2 > 9980
038600020730     C                   EVAL      TRNAME  = 'CANNOT DISPLAY ALL RECORDS'
038700020730     C                   EVAL      SRECNO2  = SRECNO2 + 1
038800020730    ?C                   WRITE     SFL_REC2
038900020730     C                   LEAVE
039000020731     C                   END
039100020731      *? BREAK
039200020731     C                   IF        SFLRECHDR2 <> SFLRECHDR
039300020730     C                   EVAL      LINE     = DIVIDERS
039400020729     C                   EVAL      SRECNO2  = SRECNO2 + 1
039500020729    ?C                   WRITE     SFL_REC2
039600020801      *? DSPATR(HI) FIRST LINE BREAK
039700020731     C                   EVAL      IN53 = *ON
039800020729     C                   EVAL      TRNAME_S = TRNAME
039900020729     C                   EVAL      SFLRECHDR2  = SFLRECHDR
040000020729     C                   EVAL      LINE     = SFLRECHDR
040100020729     C                   EVAL      SRECNO2  = SRECNO2 + 1
040200020729    ?C                   WRITE     SFL_REC2
040300020731     C                   EVAL      IN53 = *OFF
040400020801      *? GET HIGHEST PAGE #
040500020801     C                   IF        SRECNO2_H < SRECNO2
040600020801     C                   EVAL      SRECNO2_H = SRECNO2
040700020801     C                   END
040800020731     C                   IF        F2_ACCSORT = *ON
040900020731     C                   IF        ADV_TRST2 <> *ZEROS
041000020801     C                   IF        ADV_TRST2 <= TRTRST
041100020731     C                   IF        ADV_ONCE = *OFF
041200020731     C                   EVAL      ADV_ONCE = *ON
041300020731     C                   EVAL      ADV_REC = SRECNO2
041400020731     C                   END
041500020731     C                   END
041600020731     C                   END
041700020731     C                   ELSE
041800020801     C                   IF        ADVANCE2 <> *BLANKS
041900020731     C                   IF        ADVANCE11 =  *BLANKS
042000020731     C                   IF        ADVANCE1 <= LINE_DS1
042100020731     C                   IF        ADV_ONCE = *OFF
042200020731     C                   EVAL      ADV_ONCE = *ON
042300020731     C                   EVAL      ADV_REC = SRECNO2
042400020731     C                   END
042500020731     C                   END
042600020731     C                   ELSE
042700020731     C                   IF        ADVANCE2 <= LINE_DS
042800020731     C                   IF        ADV_ONCE = *OFF
042900020730     C                   EVAL      ADV_ONCE = *ON
043000020730     C                   EVAL      ADV_REC = SRECNO2
043100020731     C                   END
043200020731     C                   END
043300020731     C                   END
043400020731     C                   END
043500020801     C                   END
043600020731     C                   END
043700020731      *? DETAILS
043800021001     C                   MOVE      TRPLNCAT      TRPLNCAT3
043900020729     C                   EVAL      LINE     = SFLRECDTL
044000020729     C                   EVAL      SRECNO2  = SRECNO2 + 1
044100020718    ?C                   WRITE     SFL_REC2
044200020731     C                   END
044300020731     C                   ENDDO
044400020718     C                   IF        SRECNO2 = *ZEROS
044500020718     C                   EVAL      SRECNO2  = SRECNO2 + 1
044600020718
044700020718     C                   CLEAR                   SFL_REC2
044800020730     C                   EVAL      LINE    = 'NOT FOUND'
044900020718    ?C                   WRITE     SFL_REC2
045000020718     C                   END
045100020731     C                   IF        F2_ACCSORT = *ON
045200020801     C                   IF        ADV_TRST2 <> *ZEROS
045300020731     C                   EVAL      RECNUM2 = ADV_REC
045400020731     C                   EVAL      ADV_REC = *ZEROS
045500020801     C                   IF        RECNUM2 <= 1
045600020801     C                   EVAL      RECNUM2 = SRECNO2_H
045700020801     C                   END
045800020801     C                   END
045900020801     C                   EVAL      ADV_TRST  = 1
046000020731     C                   ELSE
046100020730     C                   IF        ADVANCE2 <> *BLANKS
046200020730     C                   EVAL      RECNUM2 = ADV_REC
046300020731     C                   EVAL      ADV_REC = *ZEROS
046400020801     C                   IF        RECNUM2 <= 1
046500020801     C                   EVAL      RECNUM2 = SRECNO2_H
046600020801     C                   END
046700020730     C                   END
046800020731     C                   END
046900020731     C                   IF        RECNUM2 = *ZEROS
047000020731     C                   EVAL      RECNUM2 = 1
047100020731     C                   END
047200020718     C
047300020718     C                   WRITE     CMD_LINE2
047400020718    ?C                   EXFMT     SFL_CTL2
047500020718
047600020731     C                   EVAL      ADVANCE2 = *BLANKS
047700020731     C                   EVAL      ADV_TRST2 = *ZEROS
047800020718     C                   IF        F1_BACK = *ON OR
047900020725     C                             F12_SCRN1   = *ON
048000020718     C                   EVAL      SCREEN = 'SCRN1   '
048100020718     C                   LEAVESR
048200020718     C                   END
048300020718
048400020718     C                   IF        F7_EXIT     = *ON
048500020718     C                   EVAL      SCREEN = 'EXIT    '
048600020718     C                   LEAVESR
048700020718     C                   END
048800020731
048900020731     C                   IF        F2_ACCSORT  = *ON   OR
049000020731     C                             ADV_TRST   <> *ZEROS
049100020731     C                   EVAL      IN51 = *OFF
049200020731     C                   EVAL      IN50 = *ON
049300020731     C                   EVAL      SCREEN = 'SEARCH  '
049400020731     C                   EVAL      ADV_TRST2 = ADV_TRST
049500020731     C                   EVAL      F2_ACCSORT = *ON
049600020731     C                   LEAVESR
049700020731     C                   END
049800020730     C                   IF        ADVANCE <> *BLANKS
049900020731     C                   EVAL      SCREEN = 'SEARCH  '
050000020730     C                   EVAL      ADVANCE2 = ADVANCE
050100020730     C                   LEAVESR
050200020730     C                   END
050300020718
050400020718     C                   EVAL      SCREEN = BACK_TO
050500020718
050600020718     C                   ENDSR
050700020731      *? ****************************************************************
050800020731     C     ALPHA_SR      BEGSR
050900020731     C                   EVAL      WHERE  = *ZEROS
051000020731     C                   SELECT
051100020731     C                   WHEN      INDEX3 = 1
051200020731     C                   EVAL      WHERE = %SCAN(SCH1:NAM1)
051300020731     C                   WHEN      INDEX3 = 2
051400020731     C                   EVAL      WHERE = %SCAN(SCH2:NAM2)
051500020731     C                   WHEN      INDEX3 = 3
051600020731     C                   EVAL      WHERE = %SCAN(SCH3:NAM3)
051700020731     C                   WHEN      INDEX3 = 4
051800020731     C                   EVAL      WHERE = %SCAN(SCH4:NAM4)
051900020731     C                   WHEN      INDEX3 = 5
052000020731     C                   EVAL      WHERE = %SCAN(SCH5:NAM5)
052100020731     C                   WHEN      INDEX3 = 6
052200020731     C                   EVAL      WHERE = %SCAN(SCH6:NAM6)
052300020731     C                   WHEN      INDEX3 = 7
052400020731     C                   EVAL      WHERE = %SCAN(SCH7:NAM7)
052500020731     C                   WHEN      INDEX3 = 8
052600020731     C                   EVAL      WHERE = %SCAN(SCH8:NAM8)
052700020731     C                   WHEN      INDEX3 = 9
052800020731     C                   EVAL      WHERE = %SCAN(SCH9:NAM9)
052900020731     C                   WHEN      INDEX3 = 10
053000020731     C                   EVAL      WHERE = %SCAN(SCH10:NAM10)
053100020731     C                   WHEN      INDEX3 = 11
053200020731     C                   EVAL      WHERE = %SCAN(SCH11:NAM11)
053300020731     C                   WHEN      INDEX3 = 12
053400020731     C                   EVAL      WHERE = %SCAN(SCH12:NAM12)
053500020731     C                   WHEN      INDEX3 = 13
053600020731     C                   EVAL      WHERE = %SCAN(SCH13:NAM13)
053700020731     C                   WHEN      INDEX3 = 14
053800020731     C                   EVAL      WHERE = %SCAN(SCH14:NAM14)
053900020731     C                   WHEN      INDEX3 = 15
054000020731     C                   EVAL      WHERE = %SCAN(SCH15:NAM15)
054100020731     C                   WHEN      INDEX3 = 16
054200020731     C                   EVAL      WHERE = %SCAN(SCH16:NAM16)
054300020731     C                   WHEN      INDEX3 = 17
054400020731     C                   EVAL      WHERE = %SCAN(SCH17:NAM17)
054500020731     C                   WHEN      INDEX3 = 18
054600020731     C                   EVAL      WHERE = %SCAN(SCH18:NAM18)
054700020731     C                   WHEN      INDEX3 = 19
054800020731     C                   EVAL      WHERE = %SCAN(SCH19:NAM19)
054900020731     C                   WHEN      INDEX3 = 20
055000020731     C                   EVAL      WHERE = %SCAN(SCH20:NAM20)
055100020731     C                   WHEN      INDEX3 = 21
055200020731     C                   EVAL      WHERE = %SCAN(SCH21:NAM21)
055300020731     C                   WHEN      INDEX3 = 22
055400020731     C                   EVAL      WHERE = %SCAN(SCH22:NAM22)
055500020731     C                   WHEN      INDEX3 = 23
055600020731     C                   EVAL      WHERE = %SCAN(SCH23:NAM23)
055700020731     C                   WHEN      INDEX3 = 24
055800020731     C                   EVAL      WHERE = %SCAN(SCH24:NAM24)
055900020731     C                   WHEN      INDEX3 = 25
056000020731     C                   EVAL      WHERE = %SCAN(SCH25:NAM25)
056100020731     C                   WHEN      INDEX3 = 26
056200020731     C                   EVAL      WHERE = %SCAN(SCH26:NAM26)
056300020731     C                   WHEN      INDEX3 = 27
056400020731     C                   EVAL      WHERE = %SCAN(SCH27:NAM27)
056500020731     C                   WHEN      INDEX3 = 28
056600020731     C                   EVAL      WHERE = %SCAN(SCH28:NAM28)
056700020731     C                   WHEN      INDEX3 = 29
056800020731     C                   EVAL      WHERE = %SCAN(SCH29:NAM29)
056900020731     C                   WHEN      INDEX3 = 30
057000020731     C                   EVAL      WHERE = %SCAN(SCH30:NAM30)
057100020731     C                   WHEN      INDEX3 = 31
057200020731     C                   EVAL      WHERE = %SCAN(SCH31:NAM31)
057300020731     C                   WHEN      INDEX3 = 32
057400020731     C                   EVAL      WHERE = %SCAN(SCH32:NAM32)
057500020731     C                   WHEN      INDEX3 = 33
057600020731     C                   EVAL      WHERE = %SCAN(SCH33:NAM33)
057700020731     C                   WHEN      INDEX3 = 34
057800020731     C                   EVAL      WHERE = %SCAN(SCH34:NAM34)
057900020731     C                   WHEN      INDEX3 = 35
058000020731     C                   EVAL      WHERE = %SCAN(SCH35:NAM35)
058100020731     C                   WHEN      INDEX3 = 36
058200020731     C                   EVAL      WHERE = %SCAN(SCH36:NAM36)
058300020731     C                   WHEN      INDEX3 = 37
058400020731     C                   EVAL      WHERE = %SCAN(SCH37:NAM37)
058500020731     C                   WHEN      INDEX3 = 38
058600020731     C                   EVAL      WHERE = %SCAN(SCH38:NAM38)
058700020731     C                   WHEN      INDEX3 = 39
058800020731     C                   EVAL      WHERE = %SCAN(SCH39:NAM39)
058900020731     C                   WHEN      INDEX3 = 40
059000020731     C                   EVAL      WHERE = %SCAN(SCH40:NAM40)
059100020731     C                   ENDSL
059200020731     C                   IF        WHERE  = *ZEROS
059300020731     C                   EVAL      LEAVEDO = *ON
059400020731     C                   END
059500020731     C                   ENDSR
059600020731      *? MONTH/CAT SEARCH **********************************************
059700020731     C     MM_CAT_SR     BEGSR
059800020731     C                   IF        I_MM     = FILE_MM
059900020731     C                   ELSE
060000020731     C                   EVAL      LEAVEDO = *ON
060100020731     C                   LEAVESR
060200020731     C                   END
060300020731     C                   IF        I_CAT  = *BLANKS
060400020731     C                   ELSE
060500021001     C                   IF        I_CAT = TRPLNCAT
060600020731     C                   ELSE
060700020731     C                   EVAL      LEAVEDO = *ON
060800020913     C                   LEAVESR
060900020731     C                   END
061000020731     C                   END
061100020913     C                   IF        I_MKTSZ = *BLANKS
061200020913     C                   ELSE
061300020913     C                   IF        TRMKTSIZE <> I_MKTSZ
061400020913     C                   EVAL      LEAVEDO = *ON
061500020913     C                   LEAVESR
061600020913     C                   END
061700020913     C                   END
061800020913     C                   IF        I_CARCD = *BLANKS
061900020913     C                   ELSE
062000020913     C                   IF        TRPCARR   <> I_CARCD
062100020913     C                   EVAL      LEAVEDO = *ON
062200020913     C                   END
062300020913     C                   END
062400020731     C                   ENDSR
062500020627      *? DATE CONVERSION              **********************************
062600020627     C     DATES_SR      BEGSR
062700020627
062800020906     C                   EVAL      DATE_IN = TRNRNDT
062900020627     C                   EXSR      ISO2USA_SR
063000020906     C                   EVAL      TRNRNDT = DATE_OUT
063100020906     C                   IF        TRNRNDT  = *ZEROS
063200020909     C                   EVAL      NRNDT_USA = *BLANKS
063300020730     C                   ELSE
063400020909     C                   MOVEL     USA_DATE      NRNDT_USA
063500020730     C                   END
063600020627
063700020701     C                   EVAL      DATE_IN = TRBEGDAT
063800020627     C                   EXSR      ISO2USA_SR
063900020701     C                   EVAL      TRBEGDAT = DATE_OUT
064000020730     C                   IF        TRBEGDAT = *ZEROS
064100020730     C                   EVAL      BEGDAT_USA = *BLANKS
064200020730     C                   ELSE
064300020729     C                   MOVEL     USA_DATE      BEGDAT_USA
064400020730     C                   END
064500020726
064600020627     C                   ENDSR
064700020627
064800020627      *? DATE CONVERSION ISO TO USA   **********************************
064900020627     C     ISO2USA_SR    BEGSR
065000020627     C                   IF        DATE_IN  = *ZEROS
065100020627     C                   EVAL      DATE_OUT = *ZEROS
065200020627     C                   LEAVESR
065300020627     C                   END
065400020627     C     *ISO          MOVE      DATE_IN       USA_DATE
065500020729     C                   MOVE      USA_DATE      DATE_OUT
065600020627     C                   ENDSR
065700020430      *? ***************************************************************
065800020430     C     EXIT_SR       BEGSR
065900020430     C                   EVAL      *INLR = *ON
066000020430     C                   RETURN
066100020430     C                   ENDSR
066200011004      *? ***************************************************************
066300011004     C     *INZSR        BEGSR
066400020626    *
066500020626     C                   IF        APPL_E = 'F.'
066600020626     C                   EVAL      W_APPL = 'FULL'
066700020626     C                   ELSE
066800020626     C                   EVAL      W_APPL = 'SELF'
066900020626     C                   END
067000020627     C                   EVAL      SCREEN = 'SCRN1   '
067100020801     C                   EVAL      I_NON  = 'Y'
067200020801     C                   EVAL      I_NON2 = 'Y'
067300020909     C     TRK_KEY       KLIST
067400020729     C                   KFLD                    TRTRST
067500020729     C                   KFLD                    TRSUB#
067600020729     C                   KFLD                    TRACCT
067700020703     C     ACCMST_KEY    KLIST
067800020703     C                   KFLD                    TRTRST
067900020703     C                   KFLD                    TRSUB#
068000020703     C                   KFLD                    TRACCT
068100020703     C     SUBMST_KEY    KLIST
068200020703     C                   KFLD                    TRTRST
068300020703     C                   KFLD                    TRSUB#
068400020709     C     PLNMST_KEY    KLIST
068500020709     C                   KFLD                    TRTRST
068600020709     C                   KFLD                    TRSUB#
068700020709     C                   KFLD                    TRPLAN
068800020430
068900011004     C                   ENDSR
