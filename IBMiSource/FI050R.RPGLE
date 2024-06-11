000100020515      *-------------------------------------------------------------------------
000200020618      * FI030R     INNOVATIVE OUTSOURCING SOFTWARE 2002
000300020515      *            WRITTEN BY - TPOWERS
000400020618      *            DATE - 06/18/02
000500020624      *  DESCRIPTION - DECLINING LIFE
000600020515      *? ***************************************************************
000700020620     FFI050D    CF   E             WORKSTN
000800020620     F                                     SFILE(SFL_REC1:SRECNO1)
000900020620     F                                      INDDS(INDICATORS)
001000020620     FDECLIF    IF   E           K DISK
001100020618     FPLNMST    IF   E           K DISK
001200020619     FTRSMST    IF   E           K DISK
001300020619     FSUBMST    IF   E           K DISK
001400020515   X*
001500020619     D USA_DATE        S               D   DATFMT(*USA)
001600020515     D SRECNO1         S              4  0 INZ(*ZEROS)
001700020515     D SCREEN          S              8
001800020620     D INDEX           S              4  0 INZ(*ZEROS)
001900020715     D STATUS          S              3
002000020515
0021000205150030 D INDICATORS      DS            99
0022000206190019 D  F1_BACK               01     01N   INZ('0')
0023000206190019 D  F7_EXIT_PGM           07     07N   INZ('0')
002400020515     D  SFLDSP_11             11     11N   INZ('0')
002500020515     D  SFLEND_22             22     22N   INZ('0')
002600020618     D  CANCELED_80           80     80N   INZ('0')
002700020515
002800020515     D                 DS
002900020515     D AREA                         100
003000020515     D  TRST_E                        3    OVERLAY(AREA)
003100020516     D  SUB#_E                        3    OVERLAY(AREA:*NEXT)
003200020516     D  ACCT_E                        4    OVERLAY(AREA:*NEXT)
003300020517     D  SMAN_E                        3    OVERLAY(AREA:*NEXT)
003400020517     D  CARR_E                        3    OVERLAY(AREA:*NEXT)
003500020619     D  PLAN_E                        4    OVERLAY(AREA:*NEXT)
003600020715     D  STAT_E                        3    OVERLAY(AREA:*NEXT)
003700020717     D  AGEN_E                        3    OVERLAY(AREA:*NEXT)
003800020620
003900020620     D                UDS
004000020620     D  CONAME               201    240
004100020515    *
004200020515      *? ***************************************************************
004300020515     C                   SELECT
004400020515     C                   WHEN      SCREEN = 'INITSFL '
004500020515     C                   EXSR      INITSFL_SR
004600020515     C                   WHEN      SCREEN = 'BLDSFL  '
004700020515     C                   EXSR      BLDSFL_SR
004800020515     C                   WHEN      SCREEN = 'DSPSFL  '
004900020515     C                   EXSR      DSPSFL_SR
005000020515     C                   WHEN      SCREEN = 'EXIT    '
005100020515     C                   EXSR      EXIT_SR
005200020515     C                   OTHER
005300020515     C                   EXSR      EXIT_SR
005400020515     C                   ENDSL
005500020515   S*
005600020515      *? ***************************************************************
005700020515     C     INITSFL_SR    BEGSR
005800020515     C                   EVAL      SRECNO1 = *ZEROS
005900020515     C                   EVAL      RECNUM  = 1
006000020515     C                   EVAL      SFLDSP_11  = *ON
006100020515    ?C                   WRITE     SFL_CTL1
006200020515     C                   EVAL      SFLDSP_11  = *OFF
006300020515     C                   EVAL      SFLEND_22  = *ON
006400020515     C                   EVAL      SCREEN = 'BLDSFL  '
006500020515     C                   ENDSR
006600020515      *? ***************************************************************
006700020515     C     BLDSFL_SR     BEGSR
006800020619     C                   IF        TRST_HD = *ZEROS  AND
006900020620     C                             SUB#_HD = *ZEROS  AND
007000020620     C                             PLAN_HD = *BLANKS
007100020524     C                   EVAL      SCREEN = 'EXIT    '
007200020524     C                   ELSE
007300020620     C                   EVAL      MESSAGE  = *BLANKS
007400020620     C     PLNMST_KEY    SETLL     DECLIR
007500020620     C                   DOU       %EOF(DECLIF)
007600020620     C     PLNMST_KEY    READE     DECLIR
007700020620     C                   IF        NOT %EOF(DECLIF)
007800020620
007900020620     C                   DO        20            INDEX
008000020620     C                   EXSR      LOADBAND_SR
008100020619     C                   EVAL      SRECNO1 = SRECNO1 + 1
008200020524     C                   IF        SRECNO1 > 9997
008300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
008400020620     C                   EVAL      MESSAGE  = 'CANNOT DISPLAY ALL RECORDS'
008500020524     C                   WRITE     SFL_REC1
008600020524     C                   LEAVE
008700020524     C                   END
008800020515     C                   WRITE     SFL_REC1
008900020620     C                   ENDDO
009000020620     C                   END
009100001222     C                   ENDDO
009200020524     C                   IF        SRECNO1 = *ZEROS
009300020524     C                   EVAL      SRECNO1 = SRECNO1 + 1
009400020620     C                   EVAL      MESSAGE  = 'NOT FOUND'
009500020524     C                   WRITE     SFL_REC1
009600020524     C                   END
009700020515     C                   EVAL      SCREEN = 'DSPSFL  '
009800020524     C                   END
009900020515    *
010000001222     C                   ENDSR
010100020515      *? ***************************************************************
010200020515     C     DSPSFL_SR     BEGSR
010300020515    ?C                   WRITE     CMD_LINE1
010400020515    ?C                   EXFMT     SFL_CTL1
010500020620     C                   EVAL      SCREEN = 'EXIT    '
010600020715     C                   IF        F1_BACK = *ON
010700020715     C                   EVAL      STATUS = 'F1 '
010800020715     C                   EVAL      SCREEN = 'EXIT    '
010900020715     C                   END
011000020715     C                   IF        F7_EXIT_PGM = *ON
011100020715     C                   EVAL      STATUS = 'F7 '
011200020715     C                   EVAL      SCREEN = 'EXIT    '
011300020715     C                   END
011400020515
011500020515     C                   ENDSR
011600020515
011700020620      *? ***************************************************************
011800020620    SC     LOADBAND_SR   BEGSR
011900020620
012000020620     C                   SELECT
012100020620     C                   WHEN      INDEX = 1
012200020620     C                   EVAL      SFABF      = ABF01
012300020620     C                   EVAL      SFABT      = ABT01
012400020620     C                   EVAL      SFDPER     = DPER01
012500020620     C                   WHEN      INDEX = 2
012600020620     C                   EVAL      SFABF      = ABF02
012700020620     C                   EVAL      SFABT      = ABT02
012800020620     C                   EVAL      SFDPER     = DPER02
012900020620     C                   WHEN      INDEX = 3
013000020620     C                   EVAL      SFABF      = ABF03
013100020620     C                   EVAL      SFABT      = ABT03
013200020620     C                   EVAL      SFDPER     = DPER03
013300020620     C                   WHEN      INDEX = 4
013400020620     C                   EVAL      SFABF      = ABF04
013500020620     C                   EVAL      SFABT      = ABT04
013600020620     C                   EVAL      SFDPER     = DPER04
013700020620     C                   WHEN      INDEX = 5
013800020620     C                   EVAL      SFABF      = ABF05
013900020620     C                   EVAL      SFABT      = ABT05
014000020620     C                   EVAL      SFDPER     = DPER05
014100020620     C                   WHEN      INDEX = 6
014200020620     C                   EVAL      SFABF      = ABF06
014300020620     C                   EVAL      SFABT      = ABT06
014400020620     C                   EVAL      SFDPER     = DPER06
014500020620     C                   WHEN      INDEX = 7
014600020620     C                   EVAL      SFABF      = ABF07
014700020620     C                   EVAL      SFABT      = ABT07
014800020620     C                   EVAL      SFDPER     = DPER07
014900020620     C                   WHEN      INDEX = 8
015000020620     C                   EVAL      SFABF      = ABF08
015100020620     C                   EVAL      SFABT      = ABT08
015200020620     C                   EVAL      SFDPER     = DPER08
015300020620     C                   WHEN      INDEX = 9
015400020620     C                   EVAL      SFABF      = ABF09
015500020620     C                   EVAL      SFABT      = ABT09
015600020620     C                   EVAL      SFDPER     = DPER09
015700020620     C                   WHEN      INDEX = 10
015800020620     C                   EVAL      SFABF      = ABF10
015900020620     C                   EVAL      SFABT      = ABT10
016000020620     C                   EVAL      SFDPER     = DPER10
016100020620     C                   WHEN      INDEX = 11
016200020620     C                   EVAL      SFABF      = ABF11
016300020620     C                   EVAL      SFABT      = ABT11
016400020620     C                   EVAL      SFDPER     = DPER11
016500020620     C                   WHEN      INDEX = 12
016600020620     C                   EVAL      SFABF      = ABF12
016700020620     C                   EVAL      SFABT      = ABT12
016800020620     C                   EVAL      SFDPER     = DPER12
016900020620     C                   WHEN      INDEX = 13
017000020620     C                   EVAL      SFABF      = ABF13
017100020620     C                   EVAL      SFABT      = ABT13
017200020620     C                   EVAL      SFDPER     = DPER13
017300020620     C                   WHEN      INDEX = 14
017400020620     C                   EVAL      SFABF      = ABF14
017500020620     C                   EVAL      SFABT      = ABT14
017600020620     C                   EVAL      SFDPER     = DPER14
017700020620     C                   WHEN      INDEX = 15
017800020620     C                   EVAL      SFABF      = ABF15
017900020620     C                   EVAL      SFABT      = ABT15
018000020620     C                   EVAL      SFDPER     = DPER15
018100020620     C                   WHEN      INDEX = 16
018200020620     C                   EVAL      SFABF      = ABF16
018300020620     C                   EVAL      SFABT      = ABT16
018400020620     C                   EVAL      SFDPER     = DPER16
018500020620     C                   WHEN      INDEX = 17
018600020620     C                   EVAL      SFABF      = ABF17
018700020620     C                   EVAL      SFABT      = ABT17
018800020620     C                   EVAL      SFDPER     = DPER17
018900020620     C                   WHEN      INDEX = 18
019000020620     C                   EVAL      SFABF      = ABF18
019100020620     C                   EVAL      SFABT      = ABT18
019200020620     C                   EVAL      SFDPER     = DPER18
019300020620     C                   WHEN      INDEX = 19
019400020620     C                   EVAL      SFABF      = ABF19
019500020620     C                   EVAL      SFABT      = ABT19
019600020620     C                   EVAL      SFDPER     = DPER19
019700020620     C                   WHEN      INDEX = 20
019800020620     C                   EVAL      SFABF      = ABF20
019900020620     C                   EVAL      SFABT      = ABT20
020000020620     C                   EVAL      SFDPER     = DPER20
020100020620     C                   ENDSL
020200020620
020300020620    SC                   ENDSR
020400020515      *? ***************************************************************
020500020515     C     EXIT_SR       BEGSR
020600020715     C     *LOCK         IN        AREA
020700020715     C                   MOVE      STATUS        STAT_E
020800020715     C                   OUT       AREA
020900020515     C                   EVAL      *INLR = *ON
021000020515     C                   RETURN
021100020515     C                   ENDSR
021200020515      *? ***************************************************************
021300020515     C     *INZSR        BEGSR
021400020515     C     *DTAARA       DEFINE    FI060A        AREA
021500020715     C     *LOCK         IN        AREA
021600020619     C                   MOVE      TRST_E        TRST_HD
021700020619     C                   MOVE      SUB#_E        SUB#_HD
021800020619     C                   MOVE      PLAN_E        PLAN_HD
021900020715     C                   MOVE      STAT_E        STATUS
022000020715     C                   OUT       AREA
022100020619     C     PLNMST_KEY    KLIST
022200020619     C                   KFLD                    TRST_HD
022300020619     C                   KFLD                    SUB#_HD
022400020619     C                   KFLD                    PLAN_HD
022500020619     C     SUBMST_KEY    KLIST
022600020620     C                   KFLD                    TRST_HD
022700020620     C                   KFLD                    SUB#_HD
022800020620     C     TRST_HD       CHAIN     TRSMSR
022900020620     C     PLNMST_KEY    CHAIN     PLNMSR
023000020620     C     SUBMST_KEY    CHAIN     SUBMSR
023100020517    *
023200020620     C                   EVAL      CANCELED_80 = *OFF
023300020620     C                   IF        PLDLTD <> 'A'
023400020620     C                   EVAL      CANCELED_80 = *ON
023500020620     C                   END
023600020515    *
023700020515     C                   EVAL      SCREEN = 'INITSFL '
023800020515     C                   ENDSR
