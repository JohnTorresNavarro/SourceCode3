0001000206030002  *?****************************************************************
0002000207110003  *?RPP151R1   GROUP BENEFIT SERVICES SOFTWARE
0003000206030013  *? DESCRIPTION - THIS PROGRAM WILL PRODUCE A WORK FILE TO FEED   *
0004000206030014  *?               RPP151R
0005000206030015  *?               ATTACHES PLAN CATEGORY TO THE MCOV FILE TO      *
000600020603      *?               BE USED IN SORT TO INCLUDE ONLY MEDICAL PLANS
000700020603      *?               FOR THE SYNOPSIS.
0008000306260011  * 6/26/03 COMMENT SMAN OUT                                       *
000900050520      * 05.20.05 DMA   Added type VS                                   *
0010000206030016  *?****************************************************************
0011000206250017
0012000206040018 FMCOVC15   IF   E           K DISK
0013000206030023 FACCMST    IF   E           K DISK
0014000206030024 FPLNMST    IF   E           K DISK
0015000206030012 FMEMBER    IF   E           K DISK
0016000306260014 F*MAN      IF   E           K DISK
001700020604     FRPP151P   O    E             DISK
001800020604
001900020605     D ISO_DATE        S               D   DATFMT(*ISO)
002000020604     D UDSCMP          S              8  0 INZ(*ZEROS)
002100020604     D TRST            S                   LIKE(MCTRST) INZ(*ZEROS)
002200020604     D SUB             S                   LIKE(MCSUB#) INZ(*ZEROS)
002300020604     D ACC             S                   LIKE(ACC#) INZ(*ZEROS)
002400020604
002500020603     D                 DS
0026000206250076 D BIRTH                               INZ(*ZEROS)
0027000206030076 D  BYY                           4  0 OVERLAY(BIRTH)
0028000206030076 D  BMM                           2  0 OVERLAY(BIRTH:*NEXT)
002900020604     D                 DS
003000020604     D MCPLAN
003100020604     D  RNPLAN                             OVERLAY(MCPLAN)
003200020604     D                 DS
003300020604     D MCSSNO
003400020604     D  RNSSNO                             OVERLAY(MCSSNO)
003500020604     D                 DS
003600020604     D MCTRST
003700020604     D  RNTRST                             OVERLAY(MCTRST)
003800020604     D                 DS
003900020604     D MCSUB#
004000020604     D  RNSUB#                             OVERLAY(MCSUB#)
004100020604     D                 DS
004200020604     D MCOVTP
004300020604     D  RNCOVTP                            OVERLAY(MCOVTP)
004400020604     D                 DS
004500020604     D ACC#
004600020604     D  RNACC#                             OVERLAY(ACC#)
004700020604     D                 DS
004800020604     D SMANCD
004900020604     D  RNSMCD                             OVERLAY(SMANCD)
005000020604     D                 DS
005100020604     D MCDLTD
005200020604     D  RNDLTD                             OVERLAY(MCDLTD)
005300020604     D                 DS
005400020604     D CANDT
005500020604     D  RNCANDT                            OVERLAY(CANDT)
005600020603     D                UDS
0057000206040076 D  UDSTST                        3
0058000206040076 D  UDSSUB                        3  0
0059000206040076 D  UDSACT                        4  0
006000020604     D  UDSDAT                        8  0
006100020605     D   UDSMM                        2  0 OVERLAY(UDSDAT)
006200020605     D   UDSYY                        4  0 OVERLAY(UDSDAT:5)
006300020604     D  UDSSPC                        3
006400020604     D  UDSAGC                        3
006500020603
006600020604      *?****************************************************************
006700020711      *?CHAIN TO PLAN RECORD. IF PLAN CATEGORY IS NOT EQUAL
006800020625      *?TO MEDICAL (PMM) DO NOT WRITE TO WORK FILE.
006900020604     C                   IF        UDSTST =  'ALL'
007000020701     C                   EVAL      TRST  = *ZEROS
007100020604     C                   END
007200020603
007300020701     C     *LOVAL        SETLL     MCOVR
007400020604     C                   DOU       %EOF(MCOVC15)
007500020701     C                   READ      MCOVR
007600020604     C                   IF        NOT %EOF(MCOVC15)
007700020701     C                   SELECT
007800020701     C                   WHEN      TRST  = *ZEROS AND
007900020701     C                             SUB   = *ZEROS AND
008000020701     C                             ACC   = *ZEROS
008100020701     C                   GOTO      SKIP
008200020701
008300020701     C                   WHEN      TRST  = *ZEROS AND
008400020701     C                             SUB  <> *ZEROS AND
008500020701     C                             ACC   = *ZEROS
008600020701     C                   IF        SUB   = MCSUB#
008700020701     C                   GOTO      SKIP
008800020701     C                   ELSE
008900020701     C                   ITER
009000020701     C                   END
009100020701     C                   WHEN      TRST <> *ZEROS AND
009200020701     C                             SUB   = *ZEROS AND
009300020701     C                             ACC  <> *ZEROS
009400020701     C                   IF        TRST  = MCTRST AND
009500020701     C                             ACC   = ACC#
009600020701     C                   GOTO      SKIP
009700020701     C                   ELSE
009800020701     C                   ITER
009900020701     C                   END
010000020701     C                   WHEN      TRST  = *ZEROS AND
010100020701     C                             SUB  <> *ZEROS AND
010200020701     C                             ACC  <> *ZEROS
010300020701     C                   IF        SUB   = MCSUB# AND
010400020701     C                             ACC   = ACC#
010500020701     C                   GOTO      SKIP
010600020701     C                   ELSE
010700020701     C                   ITER
010800020701     C                   END
010900020701
011000020701     C                   WHEN      TRST  = *ZEROS AND
011100020701     C                             SUB   = *ZEROS AND
011200020701     C                             ACC  <> *ZEROS
011300020701     C                   IF        ACC   = ACC#
011400020701     C                   GOTO      SKIP
011500020701     C                   ELSE
011600020701     C                   ITER
011700020701     C                   END
011800020701
011900020701     C                   WHEN      TRST <> *ZEROS AND
012000020701     C                             SUB   = *ZEROS AND
012100020701     C                             ACC   = *ZEROS
012200020701     C                   IF        TRST  = MCTRST
012300020701     C                   GOTO      SKIP
012400020701     C                   ELSE
012500020701     C                   ITER
012600020701     C                   END
012700020701
012800020701     C                   WHEN      TRST <> *ZEROS AND
012900020701     C                             SUB  <> *ZEROS AND
013000020701     C                             ACC   = *ZEROS
013100020701     C                   IF        TRST  = MCTRST AND
013200020701     C                             SUB   = MCSUB#
013300020701     C                   GOTO      SKIP
013400020701     C                   ELSE
013500020701     C                   ITER
013600020701     C                   END
013700020701
013800020701     C                   WHEN      TRST <> *ZEROS AND
013900020701     C                             SUB  <> *ZEROS AND
014000020701     C                             ACC  <> *ZEROS
014100020701     C                   IF        TRST  = MCTRST AND
014200020701     C                             SUB   = MCSUB# AND
014300020701     C                             ACC   = ACC#
014400020701     C                   GOTO      SKIP
014500020701     C                   ELSE
014600020701     C                   ITER
014700020701     C                   END
014800020701     C                   OTHER
014900020701     C                   ITER
015000020701     C                   ENDSL
015100020701
015200020701     C     SKIP          TAG
015300020604     C                   IF        CANDT <> *ZEROS AND
015400020604     C                             CANDT < UDSCMP
015500020604     C                   ITER
015600020604     C                   END
015700020603
015800020604     C     *NOKEY        CLEAR     *ALL          MEMBR
015900020603     C     MCSSNO        CHAIN     MEMBER
016000020604
016100020604     C                   EVAL      RNAGE = UDSYY - BYY
016200020604     C                   EVAL      RNNAGE = RNAGE
016300020604     C                   EVAL      RNMAGE = RNAGE
016400020604     C                   IF        BMM >= UDSMM
016500020604     C                   EVAL      RNAGE = RNAGE - 1
016600020604     C                   END
016700020604     C                   IF        BMM >= UDSMM
016800020604     C                   EVAL      RNMAGE = RNMAGE - 1
016900020604     C                   END
017000020604
017100020604     C     *NOKEY        CLEAR     *ALL          PLNMSR
017200020603     C     PLNMST_KEY    CHAIN     PLNMST
017300020604     C                   IF        %FOUND(PLNMST)
017400020604     C     *NOKEY        CLEAR     *ALL          ACCMSR
017500020603     C     ACCMST_KEY    CHAIN     ACCMST
017600020604518
017700020604     C                   IF        UDSSPC <> *BLANKS AND
017800020604     C                             UDSSPC <> SMANCD
017900020604     C                   ITER
018000020604     C                   END
018100020604518
018200030626     C*                  IF        UDSAGC <> *BLANKS
018300030626     C*    *NOKEY        CLEAR     *ALL          SMANR
018400030626518  C*    SMANCD        CHAIN     SMAN
018500030626     C*                  IF        UDSAGC <> SCOCD
018600030626     C*                  ITER
018700030626     C*                  END
018800030626     C*                  END
018900020607     C                   EVAL      RNAGEB = MCAGEB
019000020604      *?OUTPUT MEDICAL,MED.SUPP.,DENTAL,VISION,AND RXDRUG
019100020604     C                   SELECT
019200021115     C                   WHEN      PLNCAT = 'PMM'
019300021115     C                   WRITE     RPP151R
019400021115     C                   WHEN      PLNCAT = 'PME'
019500020604     C                   WRITE     RPP151R
019600021115     C                   WHEN      PLNCAT = 'PVE'
019700021115     C                   WRITE     RPP151R
019800021115     C                   WHEN      PLNCAT = 'PDS'
019900021115     C                   WRITE     RPP151R
020000021115     C                   WHEN      PLNCAT = 'PCS'
020100021115     C                   WRITE     RPP151R
020200021115     C                   WHEN      PLNCAT = 'PMC'
020300021115     C                   WRITE     RPP151R
020400021115     C                   WHEN      PLNCAT = 'PCE'
020500021115     C                   WRITE     RPP151R
020600020604     C                   WHEN      PLNCAT = 'PMS'
020700020604     C                   WRITE     RPP151R
020800020604     C                   WHEN      PLNCAT = 'PDN'
020900020604     C                   WRITE     RPP151R
021000020604     C                   WHEN      PLNCAT = 'PVS'
021100020604     C                   WRITE     RPP151R
021200020604     C                   WHEN      PLNCAT = 'PRX'
021300020604     C                   WRITE     RPP151R
021400050520     C                   WHEN      PLNCAT = 'PVR'
021500050520     C                   WRITE     RPP151R
021600020604
021700020604     C                   ENDSL
021800020604
021900020604     C                   END
022000020604     C     *NOKEY        CLEAR     *ALL          RPP151R
022100020604     C                   END
022200020604     C                   ENDDO
022300020604     C                   EVAL      *INLR = *ON
022400020604      *?****************************************************************
022500020604     C     *INZSR        BEGSR
022600020604     C     MCOVC1_KEY    KLIST
022700020604     C                   KFLD                    TRST
022800020604     C                   KFLD                    SUB
022900020604     C                   KFLD                    ACC
023000020604     C     MCOVC2_KEY    KLIST
023100020604     C                   KFLD                    TRST
023200020604     C                   KFLD                    SUB
023300020605     C     *USA          TEST(D)                 UDSDAT                 26
023400020605     C                   IF        *IN26 = *ON
023500020605     C                   EVAL      *INLR = *ON
023600020605     C                   RETURN
023700020605     C                   ELSE
023800020605     C     *USA          MOVEL     UDSDAT        ISO_DATE
023900020605     C                   MOVE      ISO_DATE      UDSCMP
024000020605     C                   END
024100020605     C                   IF        UDSTST = 'ALL'
024200020604     C                   EVAL      TRST = *ZEROS
024300020604     C                   ELSE
024400020604     C                   MOVE      UDSTST        TRST
024500020604     C                   END
024600020604     C                   EVAL      SUB  = UDSSUB
024700020604     C                   EVAL      ACC  = UDSACT
024800020604     C     ACCMST_KEY    KLIST
024900020604     C                   KFLD                    MCTRST
025000020604     C                   KFLD                    MCSUB#
025100020604     C                   KFLD                    ACC#
025200020604     C     PLNMST_KEY    KLIST
025300020604     C                   KFLD                    MCTRST
025400020604     C                   KFLD                    MCSUB#
025500020604     C                   KFLD                    MCPLAN
025600020604     C                   ENDSR
