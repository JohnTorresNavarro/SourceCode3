0001000205310002  *?****************************************************************
0002000205310003  *?RPP151R    GROUP BENEFIT SERVICES SOFTWARE           2002      *
0003000205310013  *? DESCRIPTION - THIS PROGRAM WILL PRODUCE A RENEWAL SYNOPSIS    *
0004000205310014  *?               FOR SMALL GROUP REFORM SHOWING RATE ALTERNATIVES*
0005000205310015  *?               FOR EXISTING ACCOUNTS.                          *
000600020531
000700020531      *? MODIFICATION:
000800020808      *?  TWP: 08.08.02 CHANGED ROUNDING ON ALL MULT AND DIV
000900020830      *?  TWP: 08.30.02 ADDED AADDR2 IF NEEDED
0010000205310016  *?****************************************************************
0011000206050018 FRPP151P   IF   E           K DISK
0012000205310020 FGRATE     IF   E           K DISK    PREFIX(G_)
0013000205310023 FACCMST    IF   E           K DISK    PREFIX(A_)
0014000205310024 FPLNMST    IF   E           K DISK    PREFIX(P_)
0015000205310014 FSMAN      IF   E           K DISK    PREFIX(S_)
0016000205310014 FPROMSG    IF   E           K DISK    PREFIX(PM)
0017000205310014 FPACCPK    IF   E           K DISK
0018000205310014 FPACKAG    IF   E           K DISK
0019000205310014 FAPLNP     IF   E           K DISK
002000020531     FCOUNTIES  IF   E           K DISK
002100020531     FAC2MST    IF   E           K DISK
0022000206270026 FRPP010P   O    F  122        PRINTER OFLIND(*INOF)
002300950821     F                                     FORMLEN(66)
002400950821     F                                     FORMOFL(63)
002500020531
002600020531     D PRIND           S              8  2 INZ(*ZEROS)
002700020531     D UDSYMD          S              8  0 INZ(*ZEROS)
002800020531     D ATOTP           S              7  4 INZ(*ZEROS)
002900020531     D F_X             S              7  4 INZ(*ZEROS)
003000020531     D FACTOR          S              7  4 INZ(*ZEROS)
003100020531     D FACTP           S              7  3 INZ(*ZEROS)
003200020531     D FACTO2          S              7  3 INZ(*ZEROS)
003300020531     D FACT            S              7  2 INZ(*ZEROS)
003400020531     D LHLD            S              7  2 INZ(*ZEROS)
003500020531     D HHLD            S              7  2 INZ(*ZEROS)
003600020531     D PREM            S              7  2 INZ(*ZEROS)
003700020531     D ATOT            S              5  3 INZ(*ZEROS)
003800020531     D TAGE            S              7  0 INZ(*ZEROS)
003900020531     D TNAGE           S                   LIKE(TAGE) INZ(*ZEROS)
004000020531     D TMAGE           S                   LIKE(TAGE) INZ(*ZEROS)
004100020531     D MEDSUP          S              5  0 INZ(*ZEROS)
004200020531     D MEDSUH          S              5  0 INZ(*ZEROS)
004300020531     D TAGI            S              5  0 INZ(*ZEROS)
004400020531     D TAGH            S              5  0 INZ(*ZEROS)
004500020531     D IN_X            S              4  0 INZ(*ZEROS)
004600020531     D INH             S              4  0 INZ(*ZEROS)
004700020531     D HM_X            S                   LIKE(IN_X) INZ(*ZEROS)
004800020531     D A_X             S                   LIKE(IN_X) INZ(*ZEROS)
004900020611     D INDEX           S              3  0 INZ(*ZEROS)
005000020605     D TPHLD           S              3  0 INZ(*ZEROS)
005100020531     D AVGOUT          S              3  0 INZ(*ZEROS)
005200020610     D IH_X            S              3  0 INZ(*ZEROS)
005300020610     D YZ_X            S              3  0 INZ(*ZEROS)
005400020604     D J_X             S              3  0 INZ(*ZEROS)
005500020531     D Z_X             S                   LIKE(J_X) INZ(*ZEROS)
005600020610     D YY_X            S                   LIKE(J_X) INZ(*ZEROS)
005700020531     D GCOUNT          S                   LIKE(J_X) INZ(*ZEROS)
005800020604     D AAGE            S              3  0 INZ(*ZEROS)
005900020531     D ANAGE           S                   LIKE(AAGE) INZ(*ZEROS)
006000020531     D AMAGE           S                   LIKE(AAGE) INZ(*ZEROS)
006100050926     D X_X             S              2  0 INZ(*ZEROS)
006200020604     D RNAGE_2         S              2  0 INZ(*ZEROS)
006300020614     D SZIP5           S              5    INZ(*ZEROS)
006400020614     D SZIP4           S              4    INZ(*ZEROS)
006500020607     D AGE_P           S                   LIKE(RNAGE_2) INZ(*ZEROS)
006600020531     D S_X             S                   LIKE(X_X) INZ(*ZEROS)
006700020531     D K_X             S                   LIKE(X_X) INZ(*ZEROS)
006800020531     D L_X             S                   LIKE(X_X) INZ(*ZEROS)
006900020605     D R2COVTP         S                   LIKE(RNCOVTP)
007000020531     D $R1             S              1
007100020531     D MSFLG           S              1
007200020531     D STAFLG          S              2
007300020531     D BCFLG           S              3
0074000206100141 D AP_PLAN         S              4
007500020531     D CTAC            S             30
007600020614     D SMANNAME        S             30
007700020614     D SMANADDR        S             30
007800020614     D CNAME           S             60
007900020607     D RNAGEB_H        S                   LIKE(RNAGEB)
008000020611     D RNTRST_H        S                   LIKE(RNTRST)
008100020611     D RNSUB#_H        S                   LIKE(RNSUB#)
008200020611     D RNACC#_H        S                   LIKE(RNACC#)
008300020612     D RNTRST_HD       S                   LIKE(RNTRST)
008400020612     D RNSUB#_HD       S                   LIKE(RNSUB#)
008500020614     D RNSMCD_HD       S                   LIKE(RNSMCD)
008600020611     D TSA_HOLD        S             10  0 INZ(*ZEROS)
008700020606     D TSA_HOLD2       S             10  0 INZ(*ZEROS)
0088000206120154 D  RNPLAN_HD      S              4
008900020606     D ONE_TIME        S               N   INZ('0')
009000020808     D PAGES           S              1
009100030212     D LEADR           S              1
009200020531
009300020531      *?COMPILE TIME ARRAYS
009400020531
009500020610     D AB_A            S              3  0 DIM(10) CTDATA PERRCD(1) ASCEND
009600020610     D AB2_A           S              3  0 DIM(11) CTDATA PERRCD(1) ASCEND
009700020610     D AM_A            S              3  0 DIM(15) CTDATA PERRCD(1) ASCEND
009800020610     D A4_A            S              3  0 DIM(13) CTDATA PERRCD(1) ASCEND
009900020531     D AFI             S              3  2 DIM(10) CTDATA PERRCD(1)
010000020531     D AIP             S              4  3 DIM(15) CTDATA PERRCD(1)
010100020531     D AFH             S              4  3 DIM(10) CTDATA PERRCD(1)
010200020610     D GF_A            S              3  2 DIM(4) CTDATA PERRCD(1)
010300020531     D CG1             S              2    DIM(4) CTDATA PERRCD(1)
010400020531     D CG2             S              2    DIM(2) CTDATA PERRCD(1)
010500020531     D CG3             S              2    DIM(5) CTDATA PERRCD(1)
010600020531     D CG4             S              2    DIM(12) CTDATA PERRCD(1)
010700020531     D CG7             S              2    DIM(5) CTDATA PERRCD(1)
010800020531     D CG8             S              2    DIM(2) CTDATA PERRCD(1)
010900020531     D CG9             S              2    DIM(2) CTDATA PERRCD(1)
011000020531     D C10             S              2    DIM(4) CTDATA PERRCD(1)
011100020531     D C11             S              2    DIM(10) CTDATA PERRCD(1)
011200020531     D C12             S              2    DIM(7) CTDATA PERRCD(1)
011300020531     D C13             S              2    DIM(2) CTDATA PERRCD(1)
011400020610     D CG5             S              2    DIM(20) CTDATA PERRCD(1)
011500020531     D C14             S              2    DIM(4) CTDATA PERRCD(1)
011600020531     D C15             S              2    DIM(5) CTDATA PERRCD(1)
011700020531     D C16             S              2    DIM(3) CTDATA PERRCD(1)
011800020531     D C17             S              2    DIM(8) CTDATA PERRCD(1)
011900020531     D C18             S              2    DIM(5) CTDATA PERRCD(1)
012000020531     D C20             S              2    DIM(12) CTDATA PERRCD(1)
012100020531     D AAF             S              3  2 DIM(10) CTDATA PERRCD(1)
012200020531     D GO4             S              4  3 DIM(2) CTDATA PERRCD(1)
012300020531     D GO3             S              4  3 DIM(4) CTDATA PERRCD(1)
012400020610     D MA_A            S              3  0 DIM(4) CTDATA PERRCD(1) ASCEND
012500020531     D GFP             S              3  2 DIM(4) CTDATA PERRCD(1)
012600020531     D PHNE            S              2    DIM(11) CTDATA PERRCD(1)
012700020610     D AK_A            S              3  0 DIM(11) CTDATA PERRCD(1) ASCEND
012800020531      *?EXECUTION ARRAYS
012900020610     D AGI             S              4  0 DIM(10) INZ(*ZEROS)
013000020610     D AGH             S              4  0 DIM(10) INZ(*ZEROS)
013100020610     D AGP             S              4  0 DIM(15) INZ(*ZEROS)
013200020610     D PL_A            S              4    DIM(15) INZ('0000')
013300020610     D AG_A            S              4  0 DIM(15) INZ(*ZEROS)
013400020610     D AT_A            S              5  3 DIM(10) INZ(*ZEROS)
013500020610     D ATM             S              5  3 DIM(12) INZ(*ZEROS)
013600020610     D ATP             S              5  3 DIM(15) INZ(*ZEROS)
013700020610     D PARY            S              7  2 DIM(4)  INZ(*ZEROS)
013800020610     D L2P             S              7  2 DIM(4)  INZ(*ZEROS)
013900020610     D MS_A            S              7  2 DIM(4)  INZ(*ZEROS)
014000020610     D MS2             S              7  2 DIM(4)  INZ(*ZEROS)
014100020610     D PH_A            S              7  2 DIM(4)  INZ(*ZEROS)
014200020610     D PA_A            S              4    DIM(15) INZ('0000')
014300020610     D PP_A            S              5  0 DIM(15) INZ(*ZEROS)
014400020610     D PP2             S              5    DIM(15) INZ('00000')
014500020610     D CP_A            S              4    DIM(20) INZ('0000')
014600020605     D                 DS
014700020610     D ACP80                         80A   INZ('0000')
014800020605     D ACP1                                OVERLAY(ACP80)
014900020605     D ACP2                                OVERLAY(ACP80:*NEXT)
015000020605     D ACP3                                OVERLAY(ACP80:*NEXT)
015100020605     D ACP4                                OVERLAY(ACP80:*NEXT)
015200020605     D ACP5                                OVERLAY(ACP80:*NEXT)
015300020605     D ACP6                                OVERLAY(ACP80:*NEXT)
015400020605     D ACP7                                OVERLAY(ACP80:*NEXT)
015500020605     D ACP8                                OVERLAY(ACP80:*NEXT)
015600020605     D ACP9                                OVERLAY(ACP80:*NEXT)
015700020605     D ACP10                               OVERLAY(ACP80:*NEXT)
015800020605     D ACP11                               OVERLAY(ACP80:*NEXT)
015900020605     D ACP12                               OVERLAY(ACP80:*NEXT)
016000020605     D ACP13                               OVERLAY(ACP80:*NEXT)
016100020605     D ACP14                               OVERLAY(ACP80:*NEXT)
016200020605     D ACP15                               OVERLAY(ACP80:*NEXT)
016300020605     D ACP16                               OVERLAY(ACP80:*NEXT)
016400020605     D ACP17                               OVERLAY(ACP80:*NEXT)
016500020605     D ACP18                               OVERLAY(ACP80:*NEXT)
016600020605     D ACP19                               OVERLAY(ACP80:*NEXT)
016700020605     D ACP20                               OVERLAY(ACP80:*NEXT)
016800020606   X*
016900020606     D                 DS
017000020610     D PACC75                        75A   INZ(*ZEROS)
017100020606     D PAGP1                               OVERLAY(PACC75)
017200020606     D PAGP2                               OVERLAY(PACC75:*NEXT)
017300020606     D PAGP3                               OVERLAY(PACC75:*NEXT)
017400020606     D PAGP4                               OVERLAY(PACC75:*NEXT)
017500020606     D PAGP5                               OVERLAY(PACC75:*NEXT)
017600020606     D PAGP6                               OVERLAY(PACC75:*NEXT)
017700020606     D PAGP7                               OVERLAY(PACC75:*NEXT)
017800020606     D PAGP8                               OVERLAY(PACC75:*NEXT)
017900020606     D PAGP9                               OVERLAY(PACC75:*NEXT)
018000020606     D PAGP10                         5  0 OVERLAY(PACC75:*NEXT)
018100020606     D PAGP11                         5  0 OVERLAY(PACC75:*NEXT)
018200020606     D PAGP12                         5  0 OVERLAY(PACC75:*NEXT)
018300020606     D PAGP13                         5  0 OVERLAY(PACC75:*NEXT)
018400020606     D PAGP14                         5  0 OVERLAY(PACC75:*NEXT)
018500020606     D PAGP15                         5  0 OVERLAY(PACC75:*NEXT)
018600020606   X*
018700020606     D                 DS
018800020606     D PACK60                        60A   INZ('0000')
018900020606     D PKGP1                               OVERLAY(PACK60)
019000020606     D PKGP2                               OVERLAY(PACK60:*NEXT)
019100020606     D PKGP3                               OVERLAY(PACK60:*NEXT)
019200020606     D PKGP4                               OVERLAY(PACK60:*NEXT)
019300020606     D PKGP5                               OVERLAY(PACK60:*NEXT)
019400020606     D PKGP6                               OVERLAY(PACK60:*NEXT)
019500020606     D PKGP7                               OVERLAY(PACK60:*NEXT)
019600020606     D PKGP8                               OVERLAY(PACK60:*NEXT)
019700020606     D PKGP9                               OVERLAY(PACK60:*NEXT)
019800020606     D PKGP10                              OVERLAY(PACK60:*NEXT)
019900020606     D PKGP11                              OVERLAY(PACK60:*NEXT)
020000020606     D PKGP12                              OVERLAY(PACK60:*NEXT)
020100020606     D PKGP13                              OVERLAY(PACK60:*NEXT)
020200020606     D PKGP14                              OVERLAY(PACK60:*NEXT)
020300020606     D PKGP15                              OVERLAY(PACK60:*NEXT)
0204000205310143
0205009309270144 D                 DS
0206000206100145 D  COVTDT                        8  0 INZ(*ZEROS)
0207000206100146 D  COVMM                         2  0 OVERLAY(COVTDT)
0208000206100147 D  COVDD                         2  0 OVERLAY(COVTDT:*NEXT)
0209000206100148 D  COVYY                         4  0 OVERLAY(COVTDT:*NEXT)
0210009309270149 D                 DS
0211000206100150 D  CYMD                          8  0 INZ(*ZEROS)
0212000206100152 D  HCOVYY                        4  0 OVERLAY(CYMD)
0213000206100153 D  HCOVMM                        2  0 OVERLAY(CYMD:*NEXT)
0214000206100154 D  HCOVDD                        2  0 OVERLAY(CYMD:*NEXT)
0215009310250149 D                UDS
021600981130     D  UDSDAT                11     18  0
0217009310250152 D  UDSMM                 11     12  0
0218009310250153 D  UDSDD                 13     14  0
0219009811300153 D  UDSMD                 11     14  0
0220009811300154 D  UDSYY                 15     18  0
022100000502     D  SPC                   19     21
022200020808     D  PAGE_IN               30     30
022300030212     D  LEADR_IN              31     31
022400020604     D  PREFIX_U             198    198
022500020531     D  UD8YMD               248    255  0
022600020531     D  UD8Y                 248    251  0
022700020531     D  UD8MD                252    255  0
0228000206060149 D                 DS
0229000206070150 D TSA_CUR                       10  0
0230000206070152 D  RNTRST                             OVERLAY(TSA_CUR)
0231000206070153 D  RNSUB#                             OVERLAY(TSA_CUR:*NEXT)
0232000206070154 D  RNACC#                             OVERLAY(TSA_CUR:*NEXT)
023300020607   X*
0234000206030149 D                 DS
0235000206100150 D RATE_G                        16
0236000206100152 D  G_GRTRST                           OVERLAY(RATE_G)
0237000206100153 D  G_GRSUB#                           OVERLAY(RATE_G:*NEXT)
0238000206100154 D  RNPLAN_H                      4    OVERLAY(RATE_G:*NEXT)
0239000206100154 D  RNAGE                              OVERLAY(RATE_G:*NEXT)
0240000206100154 D  RNCOVTP                            OVERLAY(RATE_G:*NEXT)
024100020531
024200020605     C     *LOVAL        SETLL     RPP151R
024300020606     C                   DOU       %EOF(RPP151P)
024400020605     C                   READ      RPP151R
024500020606     C                   IF        NOT %EOF(RPP151P)
024600020606     C                   IF        ONE_TIME = *OFF
024700020606     C                   EVAL      ONE_TIME = *ON
024800020607     C                   EVAL      TSA_HOLD  = TSA_CUR
024900020612     C                   EVAL      RNPLAN_HD    = RNPLAN
025000020606     C                   END
025100020614
025200020612     C                   IF        RNPLAN_HD   <> RNPLAN
025300020606     C                   EXSR      L1_TOT_SR
025400020606     C                   END
025500020607     C                   IF        TSA_HOLD  <> TSA_CUR
025600020607     C                   EXSR      L2_TOT_SR
025700020607     C                   EVAL      TSA_HOLD   = TSA_CUR
025800020607     C                   END
025900020607
026000020531      *?IF SALESMAN IS EQUAL TO USER SELECTION, PROCESS.
026100020605
026200020606     C                   IF        SPC = RNSMCD OR
026300020605     C                             SPC = 'ALL'
026400020612     C                   IF        TSA_HOLD2 <> TSA_CUR
026500020612     C                   EVAL      TSA_HOLD2  = TSA_CUR
026600020612     C                   EVAL      RNTRST_HD = RNTRST
026700020612     C                   EVAL      RNSUB#_HD = RNSUB#
026800020612     C                   EVAL      RNACC#_H = RNACC#
026900020612     C                   Z-ADD     UMONTH        COVMM
027000020612     C                   Z-ADD     01            COVDD
027100020612     C                   Z-ADD     UD8Y          COVYY
027200020612
027300020612     C                   MOVE      '  '          STAFLG
027400020612     C     *NOKEY        CLEAR     *ALL          ACCMSR
027500020612     C     ACCMST_KEY    CHAIN     ACCMSR
027600020612     C                   IF        NOT %FOUND(ACCMST)
027700020612     C                   ITER
027800020612     C                   END
027900020612
028000020612      *?SMALL GROUP REFORM APPLIES ONLY TO MARYLAND EMPLOYERS
028100020612     C                   IF        A_ASTATE <> 'MD'
028200020612     C                   MOVE      'NO'          STAFLG
028300020612     C                   END
028400020612     C     *NOKEY        CLEAR     *ALL          SMANR
028500020612     C     A_SMANCD      CHAIN     SMANR
028600020612     C                   IF        NOT %FOUND(SMAN)
028700020612     C                   ITER
028800020612     C                   END
028900020829     C                   EVAL      *IN50 = *OFF
029000020829     C                   IF        A_AADDR2 <> *BLANKS
029100020829     C                   EVAL      *IN50 = *ON
029200020829     C                   END
029300020614
029400020614     C                   MOVE      *BLANKS       SMANNAME
029500020614     C                   MOVEL     S_SFNAME      SMANNAME
029600020614
029700020614     C                   CAT       S_SLNAME:1    SMANNAME
029800020614     C                   MOVE      *BLANKS       SMANADDR
029900020614     C                   MOVEL     S_SCITY       SMANADDR
030000020614
030100020614     C                   CAT       ',':0         SMANADDR
030200020614     C                   CAT       S_SSTATE:1    SMANADDR
030300020614     C                   MOVEL     S_SZIPCD      SZIP5
030400020614     C                   MOVE      S_SZIPCD      SZIP4
030500020614     C                   CAT       SZIP5:1       SMANADDR
030600020614     C                   IF        SZIP4 <> '0000'
030700020614     C                   CAT       '-':0         SMANADDR
030800020614     C                   CAT       SZIP4:0       SMANADDR
030900020614     C                   END
031000020614
031100020614     C                   IF        RNSMCD_HD <> RNSMCD AND
031200020614     C                             SPC    = 'ALL'
031300030212     C                   IF        LEADR <> '2'
031400020614     C                   EXCEPT    LEADER
031500020905     C                   END
031600020614     C                   EVAL      RNSMCD_HD = RNSMCD
031700020614     C                   END
031800020612     C                   IF        A_ECNTAC <> *BLANKS
031900020612     C                   MOVEL     A_ECNTAC      CTAC
032000020612     C                   ELSE
032100020612     C                   MOVEL     A_CONTAC      CTAC
032200020612     C                   END
032300020612
032400020612      *?RETRIEVE FEDERAL TAX ID FROM ACCOUNT ADDITIONAL INFO FILE
032500020612
032600020612     C     *NOKEY        CLEAR     *ALL          ACCMSR2
032700020612     C     AC2MST_KEY    CHAIN     ACCMSR2
032800020612     C                   IF        %FOUND(AC2MST)
032900020612     C                   IF        A2TAX_ID# = *ZEROS
033000020612     C                   SETOFF                                       76
033100020612     C                   ELSE
033200020612     C                   SETON                                        76
033300020612     C                   END
033400020612     C                   ELSE
033500020612     C                   EVAL      A2TAX_ID# = *ZEROS
033600020612     C                   SETOFF                                       76
033700020612     C                   END
033800020612
033900020612     C                   END
034000020612
034100020612      *?SMALL GROUP REFORM APPLIES ONLY TO MARYLAND EMPLOYERS
034200020612
034300020612     C                   EVAL      RNPLAN_HD    = RNPLAN
034400020612     C                   EVAL      RNAGEB_H    = RNAGEB
034500020612     C                   IF        STAFLG = 'NO'
034600020612     C                   ITER
034700020612     C                   END
034800020612
034900020612     C                   IF        RNCANDT > 0 AND
035000020612     C                             RNCANDT <= UDSYMD
035100020612     C                   ELSE
035200020612
035300020612      *?ADD TO INDEMNITY COUNTER IF OLD PLAN IS BC/BS INDEMNITY
035400020612      *?ADD TO HMO COUNTER OTHERWISE
035500020612      *?THEN FIND CORRECT AGE BAND, AND ADD TO TOTAL EMPLOYEES
035600020612      *?IN EACH AGE BAND. WILL THEN APPLY FACTORS TO PREMIUM CALCULATION
035700020612      *?PROGRAM WK451 PLACED THE CORRECT AGE OF EMPLOYEE INTO THE
035800020612      *?AGEBND FIELD. EXCLUDE MED SUPP, PLAN# 0075.
035900020612
036000020612     C     *NOKEY        CLEAR     *ALL          PLNMSR
036100020612     C     PLNMST_KEY    CHAIN     PLNMSR
036200020612     C                   IF        %FOUND(PLNMST)
036300030903     C                   IF        P_PLNCAT <> 'PMM'
036400030903     C                   ITER
036500030903     C                   END
036600020612     C                   IF        P_PCARR = 'BCM' OR
036700020612     C                             P_PCARR = 'BMS'
036800020612     C                   IF        RNCOVTP = 'TMI'
036900020612     C                   ADD       1             MEDSUP
037000020612     C                   ITER
037100020612     C                   END
037200020612     C                   ADD       1             IN_X
037300020612     C                   ELSE
037400020612     C                   IF        RNCOVTP = 'TMI' OR
037500020612     C                             RNCOVTP = 'TMH' OR
037600020612     C                             RNCOVTP = 'TMP' OR
037700020612     C                             RNCOVTP = 'TMF'
037800020612     C                   ADD       1             MEDSUH
037900020612     C                   ITER
038000020612     C                   END
038100020612
038200020612     C                   ADD       1             HM_X
038300020612     C                   END
038400020612
038500020612      *?ADD TOTAL AGES TO CALCULATE AGE BAND FOR AETNA RATES
038600020612
038700020612      *?NAGE IS USED FOR NLYCARE RATES. AGE FOR CURRENT YEAR ANYTIME.
038800020612     C                   ADD       RNAGE         TAGE
038900020612     C                   ADD       RNNAGE        TNAGE
039000020612     C                   ADD       RNMAGE        TMAGE
039100020612
039200020612     C                   IF        RNAGE > 99
039300020612     C                   EVAL      RNAGE = 99
039400020612     C                   END
039500020612     C                   Z-ADD     1             A_X
039600020612     C     RNAGE         LOOKUP    AB_A(A_X)                            3232
039700020612     C                   IF        *IN32 = *ON
039800020612     C                   IF        RNAGE <> AB_A(A_X)
039900020612     C                   ADD       1             A_X
040000020612     C                   END
040100020612     C                   IF        P_PCARR = 'BCM' OR
040200020612     C                             P_PCARR = 'BMS'
040300020612     C                   ADD       1             AGI(A_X)
040400020612     C                   ELSE
040500020612     C                   ADD       1             AGH(A_X)
040600020612     C                   END
040700020612     C                   END
040800020612
040900020612      *?AGE BANDS FOR PHN
041000020612     C                   Z-ADD     1             A_X
041100020612     C     RNAGE         LOOKUP    AM_A(A_X)                            3232
041200020612     C                   IF        *IN32 = *ON
041300020612     C                   IF        RNAGE <> AM_A(A_X)
041400020612     C                   ADD       1             A_X
041500020612     C                   END
041600020612     C                   ADD       1             AGP(A_X)
041700020612     C                   END
041800020612
041900020612     C                   Z-ADD     1             A_X
042000020612     C     RNMAGE        LOOKUP    MA_A(A_X)                            3535
042100020612     C                   IF        *IN35 = *ON
042200020612     C                   IF        RNMAGE <> MA_A(A_X)
042300020612     C                   ADD       1             A_X
042400020612     C                   END
042500020612     C                   END
042600020612
042700020612     C                   ADD       1             TPHLD
042800020612     C                   END
042900020612     C                   END
043000020606     C                   END
043100020606     C                   END
043200020606     C                   ENDDO
043300020607     C                   EXSR      L1_TOT_SR
043400020607     C                   EXSR      L2_TOT_SR
043500020531
043600020606     C                   EVAL      *INLR = *ON
043700020606      *?*****************************************************
043800020606
043900020606     C     L1_TOT_SR     BEGSR
044000020612     C                   IF        RNPLAN_HD   <> '0075'
044100020606     C                   ADD       1             X_X
044200020612     C                   MOVE      RNPLAN_HD     PL_A(X_X)
044300020612     C                   MOVE      RNAGEB_H      AG_A(X_X)
044400020606     C                   END
044500020606     C                   ENDSR
044600020606      *?*****************************************************************
044700020606     C     L2_TOT_SR     BEGSR
044800020531      *?GET COUNTY DESCRIPTION
044900020531
045000020606     C     *NOKEY        CLEAR     *ALL          COUNTYR
045100020610     C     COUNTY2KEY    CHAIN     COUNTYR
045200020531
045300020531      *?SMALL GROUP REFORM APPLIES ONLY TO MARYLAND EMPLOYERS
045400020606
045500020606      *?EXCLUDE EMPLOYERS WITH ONLY ONE EMPLOYEE AND EMPLOYERS
045600020606      *?WITH 50 OR MORE EMPLOYERS FOR SMALL GROUP REFORM
045700020531
045800020606     C                   IF        STAFLG = 'NO' OR
045900020606     C                             TPHLD < 1     OR
046000020606     C                             TPHLD >= 50
046100020606     C                   ELSE
046200020531
046300041109     C                   EVAL      AVGOUT = TAGE / TPHLD
046400020531
046500020531      *?SEND INPUT SCREEN TO OUTPUT TO VERIFY ENTRY
046600020606     C                   XFOOT     AGI           TAGI
046700020606     C                   XFOOT     AGH           TAGH
046800020808     C                   IF        PAGES <> '2'
046900020606     C                   EXCEPT    HEADR
047000020808     C                   END
047100020606     C                   EVAL      A2TAX_ID# = *ZEROS
047200020606     C                   EXCEPT    #SYN
047300020617     C                   EXCEPT    #SYN1
047400020610     C                   MOVE      'Y'           $R1
047500020610     C                   SETON                                        58
047600020612     C                   EVAL      RNTRST_H = RNTRST_HD
047700020612     C                   EVAL      RNSUB#_H = RNSUB#_HD
047800020610     C                   DO        15            Z_X
047900020610     C                   IF        PL_A(Z_X) <> '0000' AND
048000020610     C                             PL_A(Z_X) <> '    '
048100020610     C                   MOVE      PL_A(Z_X)     RNPLAN_H
048200020610     C                   Z-ADD     AG_A(Z_X)     AGE_P
048300020610     C                   EXSR      $GETP
048400020610     C                   EXCEPT    #CUR2
048500020617     C                   END
048600020610     C                   ENDDO
048700020610     C                   SETOFF                                       58
048800020606     C                   MOVE      ' '           $R1
048900020606     C                   Z-ADD     0             L2P
049000020606     C                   Z-ADD     UDSMM         COVMM
049100020606     C                   Z-ADD     UDSDD         COVDD
049200020606     C                   Z-ADD     UDSYY         COVYY
049300020610     C                   MOVE      '0001'        AP_PLAN
049400020617     C                   EVAL      A_ACTRST = 794
049500020617     C                   EVAL      A_ACSUB# = 001
049600020606     C                   EXCEPT    #SYN1B
049700020531      *?GET RENEWAL RATES FOR CURRENT PLANS
049800020610     C     APLNP2KEY     SETLL     APLNPR
049900020606     C                   DOU       %EOF(APLNP)
050000020610     C     ACCMST2KEY    READE     APLNPR
050100020606     C                   IF        NOT %EOF(APLNP)
050200020610     C                   MOVEA     ACP80         CP_A
050300020610     C                   MOVEA     CP_A          PA_A
050400020617     C                   DO        15            Z_X
050500020617     C                   IF        PA_A(Z_X) = '0000' OR
050600020617     C                             PA_A(Z_X) = '    '
050700020617     C                   ELSE
050800020617     C                   EXSR      PLNMST7SR
050900020617     C                   END
051000020617
051100020617     C                   ENDDO
051200020610     C                   MOVEA     L2P           MS_A
051300020606     C                   XFOOT     L2P           PRIND
051400020606     C                   IF        PRIND <> *ZEROS
051500020606     C                   EXCEPT    #CUR3
051600020617     C                   END
051700020606     C                   IF        MSFLG = 'I'
051800020610     C                   Z-ADD     0             MS_A
051900020610     C                   Z-ADD     269.61        MS_A(1)
052000020606     C                   EXCEPT    #MS
052100020617     C                   END
052200020606     C                   IF        MSFLG = 'H'
052300020610     C                   EVAL      MS_A = MS_A - MS2
052400020808     C                   EVAL(H)   MS_A(1) = MS_A(1) * .80
052500020808     C                   EVAL(H)   MS_A(2) = MS_A(2) * .80
052600020808     C                   EVAL(H)   MS_A(3) = MS_A(3) * .80
052700020808     C                   EVAL(H)   MS_A(4) = MS_A(4) * .80
052800020610     C                   EVAL      MS_A = MS_A + MS2
052900020606     C                   EXCEPT    #MS
053000020617     C                   END
053100020606     C                   IF        MSFLG = *BLANKS
053200020606     C                   EXCEPT    #SPACE
053300020617     C                   END
053400020606     C                   MOVE      *BLANKS       MSFLG
053500020606     C                   END
053600020606     C                   ENDDO
053700020606     C                   EXCEPT    #DONE1
053800020808     C                   IF        PAGES = '2'
053900020808     C                   GOTO      PAG3TAG
054000020808     C                   END
054100020531
054200020531      *?RENEWAL RATES HELD IN TRUST 794 SUB-DIVISION 001
054300020531      *?FOR SMALL GROUP REFORM
054400020606     C                   EXCEPT    #SYN
054500020606     C                   EXCEPT    #L2D
054600020606     C                   EXCEPT    #NEWP
054700020606     C                   EXSR      $L2SUB
054800020808     C                   IF        PAGES = '3'
054900020808     C                   GOTO      PAG3TAG
055000020808     C                   END
055100020606     C                   EXCEPT    #DONE
055200020617     C                   END
055300020606
055400020808     C     PAG3TAG       TAG
055500020606     C                   Z-ADD     0             X_X
055600020610     C                   MOVEA     *ZEROS        PL_A
055700020610     C                   MOVEA     *ZEROS        PA_A
055800020610     C                   Z-ADD     0             AG_A
055900020606     C                   Z-ADD     0             TPHLD
056000020606     C                   Z-ADD     0             TAGE
056100020606     C                   Z-ADD     0             TNAGE
056200020606     C                   Z-ADD     0             TMAGE
056300020606     C                   Z-ADD     0             IN_X
056400020606     C                   Z-ADD     0             HM_X
056500020610     C                   Z-ADD     0             IH_X
056600020606     C                   Z-ADD     0             AGI
056700020606     C                   Z-ADD     0             AGH
056800020606     C                   Z-ADD     0             AGP
056900020610     C                   Z-ADD     0             AT_A
057000020606     C                   Z-ADD     0             MS2
057100020606     C                   ENDSR
057200020531
057300020531      *?*****************************************************
057400930927     C     $GETP         BEGSR
0575000205310301  *?GET PLAN RECORD
0576000205310302
0577000206110303 C     PLNMST2KEY    CHAIN     PLNMSR
057800020610     C                   IF        %FOUND(PLNMST)
0579000206110304
058000020611     C                   DO        4             INDEX
058100020611     C                   SELECT
058200020611     C                   WHEN      INDEX = 1
058300020611     C                   MOVE      'TIN'         R2COVTP
058400020611     C                   WHEN      INDEX = 2
058500020611     C                   MOVE      'TPC'         R2COVTP
058600020611     C                   WHEN      INDEX = 3
058700020611     C                   MOVE      'THW'         R2COVTP
058800020611     C                   WHEN      INDEX = 4
058900020611     C                   MOVE      'TFA'         R2COVTP
059000020611     C                   ENDSL
059100020611     C                   EXSR      $PREM
059200020611     C                   ADD       PREM          PARY(INDEX)
059300020611     C                   IF        $R1 = 'Y' AND
059400020611     C                             INDEX = 1
059500020611     C                   IF        PARY(INDEX) = *ZEROS
059600020611     C                   MOVE      'TMI'         R2COVTP
059700020611     C                   EXSR      $PREM
059800020611     C                   ADD       PREM          PARY(INDEX)
059900020611     C                   END
060000020611     C                   END
060100020611     C                   ENDDO
060200020531
060300020611     C                   END
060400020531      *?TOTAL EACH PACKAGE 10/95
060500930928     C                   ENDSR
060600020531
060700020531      *?*****************************************************
060800020531
060900930928     C     $L2SUB        BEGSR
061000020605     C     *NOKEY        CLEAR     *ALL          PACCR
061100020607     C     PACCR_KEY     CHAIN     PACCR
061200020606     C                   MOVEA     PACC75        PP2
061300020610     C                   MOVE      PP2           PP_A
061400020610     C                   DO        15            YZ_X
061500020610     C                   IF        PP_A(YZ_X) = *ZEROS
061600020606     C                   ELSE
061700020531      *?WRITE OUT PREVIOUS TOTALS, SKIP 1ST CYCLE
061800020617     C                   IF        YZ_X > 1
061900020610     C                   MOVEA     L2P           MS_A
062000951025     C                   EXCEPT    #CUR3
062100020606     C                   IF        MSFLG = 'I'
062200020610     C                   Z-ADD     0             MS_A
062300020531      *?MED.SUPP. LITERAL RATE !!!!!!!!
062400020610     C                   Z-ADD     269.61        MS_A(1)
062500951025     C                   EXCEPT    #MS
062600020606     C                   END
062700020606     C                   IF        MSFLG = 'H'
062800020808     C                   EVAL(H)   MS_A(1) = MS_A(1) * .80
062900020808     C                   EVAL(H)   MS_A(2) = MS_A(2) * .80
063000020808     C                   EVAL(H)   MS_A(3) = MS_A(3) * .80
063100020808     C                   EVAL(H)   MS_A(4) = MS_A(4) * .80
063200951025     C                   EXCEPT    #MS
063300020606     C                   END
063400951025     C                   MOVE      *BLANKS       MSFLG
063500020606     C                   END
063600020808     C                   IF        YZ_X = 3  AND
063700020808     C                             PAGES = '2'
063800020808     C                   LEAVESR
063900020808     C                   END
064000020611     C                   IF        YZ_X = 4 OR
064100020611     C                             YZ_X = 7
064200020808     C                   IF        PAGES = '3'
064300020808     C                   LEAVESR
064400020808     C                   END
064500951025     C                   EXCEPT    #DONE1
064600951024     C                   EXCEPT    #SYN
064700951025     C                   EXCEPT    #L2D
064800951025     C                   EXCEPT    #NEWP
064900020606     C                   END
065000020610     C                   MOVEA     *ZEROS        PA_A
065100020605     C     *NOKEY        CLEAR     *ALL          PACKR
065200020610     C     PP_A(YZ_X)    CHAIN     PACKR
065300020606     C                   IF        NOT %FOUND(PACKAG)
065400020605     C                   MOVEL     'ERROR   '    CNAME
065500020605     C                   ELSE
065600020605     C                   MOVEL     PKGDSC        CNAME
065700020606     C                   END
065800020610     C                   MOVEA     PACK60        PA_A
065900951024     C                   EXCEPT    #CARR
066000020617     C                   DO        15            Z_X
066100020617     C                   IF        PA_A(Z_X) = '0000' OR
066200020617     C                             PA_A(Z_X) = '    '
066300020617     C                   ELSE
066400020617     C                   EXSR      PLNMST7SR
066500020617     C                   END
066600020617
066700020617     C                   ENDDO
066800020606     C                   END
066900020606
067000020606     C                   ENDDO
067100020606
067200951026     C                   EXCEPT    #CUR3
067300020606     C                   IF        MSFLG = 'I'
067400020610     C                   Z-ADD     0             MS_A
067500020531      *?MED.SUPP. LITERAL RATE !!!!!!!!
067600020610     C                   Z-ADD     269.61        MS_A(1)
067700951102     C                   EXCEPT    #MS
067800951102     C                   END
067900020606     C                   IF        MSFLG = 'H'
068000020610     C                   EVAL      MS_A = MS_A - MS2
068100020808     C                   EVAL(H)   MS_A(1) = MS_A(1) * .80
068200020808     C                   EVAL(H)   MS_A(2) = MS_A(2) * .80
068300020808     C                   EVAL(H)   MS_A(3) = MS_A(3) * .80
068400020808     C                   EVAL(H)   MS_A(4) = MS_A(4) * .80
068500020610     C                   EVAL      MS_A = MS_A + MS2
068600951102     C                   EXCEPT    #MS
068700951102     C                   END
068800951102     C                   MOVE      *BLANKS       MSFLG
068900930928     C                   ENDSR
069000020531
069100020611      *?*****************************************************
069200020611     C     PLNMST7SR     BEGSR
069300020617     C                   EVAL      RNTRST_H = 794
069400020617     C                   EVAL      RNSUB#_H = 001
069500020617     C                   MOVE      PA_A(Z_X)     RNPLAN_H
069600020617     C     *NOKEY        CLEAR     *ALL          PLNMSR
069700020617     C     PLNMST2KEY    CHAIN     PLNMSR
069800020617     C                   IF        %FOUND(PLNMST)
069900020617     C                   EXSR      RATES_SR
070000020617     C                   END
070100020611     C                   ENDSR
070200020610      *?*****************************************************
070300020610     C     RATES_SR      BEGSR
070400020610     C                   SELECT
070500020610     C                   WHEN      P_PCARR = 'BCM'
070600020610     C                   EXSR      $RAT2
070700020610     C                   MOVE      'I'           MSFLG
070800020610
070900020610     C                   WHEN      P_PCARR = 'CFS'
071000020610     C                   EXSR      $RAT2
071100020610     C                   MOVE      'H'           MSFLG
071200020610
071300020610     C                   WHEN      P_PCARR = 'PHN'
071400020610     C                   EXSR      $RAT2P
071500020610
071600020610     C                   WHEN      P_PCARR = 'BCS' OR
071700020610      *?(VSP IS A BC/BS VISION RIDER TO BC/BS MEDICAL)
071800020610     C                             P_PCARR = 'VSP' OR
071900020610     C                             P_PCARR = 'HMD' OR
072000020610     C                             P_PCARR = 'HMV' OR
072100020610     C                             P_PCARR = 'FSD' OR
072200020610     C                             P_PCARR = 'FSV'
072300020610     C                   EXSR      $RAT2D
072400020610
072500020610      *?FOR BC/BS TESTS, UNCOMMENT NEXT LINES
072600020610     C                   WHEN      P_PCARR = 'AET' OR
072700020610     C                             P_PCARR = 'AHT' OR
072800020610     C                             P_PCARR = 'AIH' OR
072900020610     C                             P_PCARR = 'AIM'
073000020610     C                   EXSR      $RAT3
073100020610
073200020610     C                   WHEN      P_PCARR = 'KP '
073300020610     C                   EXSR      $RAT4
073400020610
073500020610     C                   WHEN      P_PCARR = 'PRN'
073600020610     C                   EXSR      $RAT5
073700020610
073800020610      *?GET JUST DENTAL AND COBRA RATES
073900020610
074000020610     C                   WHEN      P_PCARR = 'JD ' OR
074100020610     C                             P_PCARR = 'CDC' OR
074200020610     C                             P_PCARR = 'AS '
074300020610     C                   EXSR      $RAT7
074400020610
074500020610     C                   WHEN      P_PCARR = 'HP '
074600020610     C                   EXSR      $RAT8
074700020610
074800020610     C                   WHEN      P_PCARR = 'MF '
074900020610     C                   EXSR      $RAT9
075000020610
075100020610     C                   WHEN      P_PCARR = 'USH'
075200020610     C                   EXSR      $RAT10
075300020610
075400020610     C                   WHEN      P_PCARR = 'CHP'
075500020610     C                   EXSR      $RAT11
075600020610
075700020610     C                   WHEN      P_PCARR = 'CBC'
075800020610     C                   EXSR      $RATBC
075900020610
076000020610     C                   ENDSL
076100020610     C                   ENDSR
076200020531      *?*****************************************************
076300930928     C     $RAT2         BEGSR
076400020531
076500020531      *?LIST BC/BS INDEMNITY PLANS, PRINT CARRIER
076600020531      *?CALCULATE RATE FACTORS
076700951023     C                   MOVE      *BLANKS       CNAME
076800020531
076900020606     C                   IF        P_PCARR = 'CFS'
077000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
077100020607     C                   Z-ADD     0             AGE_P
077200020606     C                   EXSR      $GETP
077300020606     C                   EXSR      #HMOF
077400020610     C                   MOVEA     PARY          PH_A
077500020606
077600020606     C                   DO        4             S_X
077700020606     C                   EVAL(H)   PARY(S_X) = PARY(S_X) * FACTO2
077800020606      *?NO GEOGRAPHICAL FACTOR FOR HMO RATES
077900020606
078000020606     C                   EXSR      #LIMT
078100020606     C                   ENDDO
078200020606
078300020606      *?SKIP TO NEW PAGE BUT DON'T PRINT HEADINGS ON OVERFLOW
078400020606
078500020606     C   OF              EXCEPT    NEWPAG
078600020606     C                   EVAL      L2P = L2P + PARY
078700020606     C                   EXCEPT    #CUR2
078800020606
078900020606     C                   ELSE
079000020531
079100020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
079200020607     C                   Z-ADD     0             AGE_P
079300940623     C                   EXSR      $GETP
079400940623     C                   EXSR      #INDF
079500020610     C                   MOVEA     PARY          PH_A
079600940623     C                   EXSR      #GEO
079700020606     C                   DO        4             S_X
079800020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACT) * F_X
079900940623     C                   EXSR      #LIMT
080000020606     C                   ENDDO
080100020606     C                   EVAL      L2P = L2P + PARY
080200940623     C                   EXCEPT    #CUR2
080300020531
080400020531      *?LIST HMO INDEMNITY PLANS, PRINT CARRIER
080500020531      *?CALCULATE RATE FACTORS
080600020531
080700020606     C                   END
080800020531
080900930928     C                   ENDSR
081000020531      *?*****************************************************
081100970908     C     $RAT2P        BEGSR
081200020531
081300020607     C     A_ACONTY      LOOKUP    PHNE                                   63
081400020606     C                   IF        *IN63 = *OFF
081500020531      *?LIST PHN PLANS, PRINT CARRIER
081600020531      *?CALCULATE RATE FACTORS
081700970908     C                   MOVE      *BLANKS       CNAME
081800020531
081900020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
082000020607     C                   Z-ADD     0             AGE_P
082100970908     C                   EXSR      $GETP
082200970908     C                   EXSR      #INDFP
082300020610     C                   MOVEA     PARY          PH_A
082400970908     C                   EXSR      #GEOP
082500020531     C                   DO        4             S_X
082600020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACTP) * F_X
082700970908     C                   EXSR      #LIMT
082800020606     C                   ENDDO
082900020606     C                   EVAL      L2P = L2P + PARY
083000970908     C                   EXCEPT    #CUR2
083100020531
083200020606     C                   END
083300970908     C                   ENDSR
083400020531
083500020531      *?*****************************************************
083600950622     C     $RAT2D        BEGSR
083700020531
083800020531      *?LIST BC/BS DENTAL AND VISION PLANS...PRINT DENTAL/VISION CARR.
083900020531      *?CALCULATE RATE FACTORS
084000020531      *?LIST BOTH HMO AND INDEMNITY DENTAL AND VISION PLANS
084100020531
084200951023     C                   MOVE      *BLANKS       CNAME
084300020531
084400020531      *?LIST HMO VISION AND DENTAL PLANS
084500020531      *?THERE ARE NO FACTORS TO APPLY..STRAIGHT RATES
084600020531
084700020606     C                   IF        P_PCARR = 'VSP'  OR
084800020606     C                             P_PCARR = 'FSD'  OR
084900020606     C                             P_PCARR = 'BCS'  OR
085000020606     C                             P_PCARR = 'FSV'
085100020606
085200020606      *?FREESTANDING DENTAL PLANS FOR BC/BS
085300020606
085400020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
085500020607     C                   Z-ADD     0             AGE_P
085600020606     C                   EXSR      $GETP
085700020610     C                   MOVEA     PARY          PH_A
085800020606     C                   EXSR      #GEO
085900020606     C                   DO        4             S_X
086000020606     C                   EVAL(H)   PARY(S_X) = PARY(S_X) * F_X
086100020606     C                   EXSR      #LIMT
086200020606     C                   ENDDO
086300020606     C                   EVAL      L2P = L2P + PARY
086400020606     C                   EXCEPT    #CUR2
086500020606
086600020606     C                   ELSE
086700020531
086800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
086900020607     C                   Z-ADD     0             AGE_P
087000950623     C                   EXSR      $GETP
087100020531
087200020606     C                   EVAL      L2P = L2P + PARY
087300020606     C                   EVAL      MS2 = MS2 + PARY
087400950623     C                   EXCEPT    #CUR2
087500020531
087600020606     C                   END
087700020531
087800950622     C                   ENDSR
087900020531      *?*****************************************************
088000020531
088100020531      *?AETNA RATES
088200020531      *?LIST AETNA INDEMNITY PLANS, PRINT CARRIER
088300020531      *?CALCULATE RATE FACTORS, AGE BAND
088400020531
088500940630     C     $RAT3         BEGSR
088600951023     C                   MOVE      *BLANKS       CNAME
088700020531
088800020531     C                   Z-ADD     0             AAGE
088900020607     C                   Z-ADD     0             AGE_P
089000020531
089100020531      *?GET GEOGRAPHICAL FACTOR FOR INDEMNITY
089200020531
089300950616     C                   EXSR      #GEO3
089400020531
089500020531      *?AETNA INDEMNITY           *
089600020531
089700020531      *?GEOGRAPHICAL AREA BALTIMORE
089800020531
089900020531     C                   Z-ADD     0             PARY
090000951026     C                   Z-ADD     0             L2P
090100020606     C                   IF        P_PCARR = 'AET'
090200020531
090300020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
090400950616     C                   EXSR      $GETP
090500950616     C                   EXSR      #INDF3
090600020610     C                   MOVEA     PARY          PH_A
090700020606     C                   DO        4             S_X
090800020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACTOR) * F_X
090900020531      *?IF NO COUNTY RATING EXISTS, PRINT ZEROES
091000020606     C                   IF        PARY(S_X) <> *ZEROS
091100950616     C                   EXSR      #LIMT2
091200020606     C                   END
091300020606     C                   ENDDO
091400020606     C                   EVAL      L2P = L2P + PARY
091500950616     C                   EXCEPT    #CUR2
091600020606     C                   END
091700020531
091800020531      *?NOW PRINT AETNA HMO RATES *
091900020531
092000020531
092100020606     C                   IF        P_PCARR = 'AHT'
092200950616     C                   EXSR      #GEO4
092300020531      *?HMO BALTIMORE RATES
092400020531
092500020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
092600950616     C                   EXSR      $GETP
092700950616     C                   EXSR      #INDF3
092800020610     C                   MOVEA     PARY          PH_A
092900020531     C                   DO        4             S_X
093000020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACTOR) * F_X
093100020531      *?IF NO COUNTY RATING EXISTS, PRINT ZEROES
093200020606     C                   IF        PARY(S_X) <> *ZEROS
093300950616     C                   EXSR      #LIMT2
093400950619     C                   END
093500020606     C                   ENDDO
093600020606     C                   EVAL      L2P = L2P + PARY
093700950616     C                   EXCEPT    #CUR2
093800991116     C                   END
093900020531
094000951024     C                   ENDSR
094100020531      *?********************************
094200941021     C     $RAT5         BEGSR
094300020531
094400020531      *?CALCULATE AVERAGE AGE
094500020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
094600020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
094700020531      *?FIELD "J" WILL CONTAIN AGE BAND
094800020531
094900041109     C                   EVAL      AAGE = TAGE / TPHLD
095000020531
095100020531     C                   Z-ADD     1             J_X
095200020610     C     AAGE          LOOKUP    AB2_A(J_X)                           2222
095300020606     C                   IF        *IN22 = *ON AND
095400020610     C                             AAGE = AB2_A(J_X)
095500020606     C                   EVAL      J_X = J_X - 1
095600941021     C                   END
095700020531
095800020607     C                   EVAL      AGE_P = J_X
095900020531
096000020531      *?GET GEOGRAPHICAL FACTOR
096100020531
096200941021     C                   EXSR      #GEO2
096300020531
096400020531      *?ONLY PRINT CARRIER NAME IF COUNTY IS AVAILABLE
096500020531
096600020531      *?IF PRINCIPAL NOT OFFERED FOR THIS GEOGRAPHICAL AREA
096700020531      *?SKIP PRINTING OF THE RATES
096800020531
096900020606     C                   IF        K_X = *ZEROS
097000020606     C                   ELSE
097100020531
097200020531      *?PRINCIPAL 2 TIER          *
097300020531
097400020531      *?GEOGRAPHICAL AREA BALTIMORE
097500020531
097600020606     C                   SELECT
097700020606     C                   WHEN      K_X = 1
097800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
097900941021     C                   EXSR      $GETP
098000020610     C                   MOVEA     PARY          PH_A
098100020606     C                   EVAL      L2P = L2P + PARY
098200941021     C                   EXCEPT    #CUR2
098300020531
098400020531      *?GEOGRAPHICAL AREA D.C.
098500020606     C                   WHEN      K_X = 2
098600020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
098700941021     C                   EXSR      $GETP
098800020610     C                   MOVEA     PARY          PH_A
098900020606     C                   EVAL      L2P = L2P + PARY
099000941021     C                   EXCEPT    #CUR2
099100020531
099200020531      *?GEOGRAPHICAL AREA OTHER
099300020606     C                   WHEN      K_X = 3
099400020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
099500950308     C                   EXSR      $GETP
099600020610     C                   MOVEA     PARY          PH_A
099700020606     C                   EVAL      L2P = L2P + PARY
099800950308     C                   EXCEPT    #CUR2
099900020606     C                   ENDSL
100000020531
100100020606     C                   END
100200941021     C                   ENDSR
100300020531
100400020531      *?KAISER HEALTH PLANS
100500950308     C     $RAT4         BEGSR
100600020531
100700020531      *?CALCULATE AVERAGE AGE
100800020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
100900020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
101000020531      *?FIELD "J" WILL CONTAIN AGE BAND
101100020531
101200041109     C                   EVAL      AAGE = TAGE / TPHLD
101300020531
101400020531     C                   Z-ADD     1             J_X
101500020610     C     AAGE          LOOKUP    AK_A(J_X)                            2222
101600020606     C                   IF        *IN22 = *ON  AND
101700020610     C                             AAGE = AK_A(J_X)
101800020606     C                   EVAL      J_X = J_X - 1
101900020606     C                   END
102000020531
102100020607     C                   EVAL      AGE_P = J_X
102200020531
102300020531      *?ONLY PRINT CARRIER NAME IF COUNTY IS AVAILABLE
102400020531
102500020531      *?IF KAISER NOT OFFERED FOR THIS GEOGRAPHICAL AREA
102600020531      *?SKIP PRINTING OF THE RATES
102700020531
102800020531      *?KAISER BALTIMORE          *
102900020531
103000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
103100950308     C                   EXSR      $GETP
103200020610     C                   MOVEA     PARY          PH_A
103300020606     C                   EVAL      L2P = L2P + PARY
103400950308     C                   EXCEPT    #CUR2
103500020531
103600950308     C                   ENDSR
103700020531      *?*****************************************************
103800960811     C     $RAT8         BEGSR
103900020531
104000020531      *?CALCULATE AVERAGE AGE
104100020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
104200020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
104300020531      *?FIELD "J" WILL CONTAIN AGE BAND
104400020531
104500041109     C                   EVAL      ANAGE = TNAGE / TPHLD
104600020531
104700020531     C                   Z-ADD     1             J_X
104800020610     C     ANAGE         LOOKUP    AB_A(J_X)                            2222
104900020606     C                   IF        *IN22 = *ON AND
105000020610     C                             ANAGE = AB_A(J_X)
105100020606     C                   EVAL      J_X = J_X - 1
105200960811     C                   END
105300020531
105400020607     C                   EVAL      AGE_P = J_X
105500020531
105600020531      *?NYLCARE                   *
105700020531
105800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
105900960811     C                   EXSR      $GETP
106000020610     C                   MOVEA     PARY          PH_A
106100020606     C                   EVAL      L2P = L2P + PARY
106200960811     C                   EXCEPT    #CUR2
106300020531
106400960811     C                   ENDSR
106500020531      *?********************************
106600020531
106700960811     C     $RAT9         BEGSR
106800020531
106900020531      *?MARYLAND FIDELITY         *
107000020531
107100020610     C                   EVAL      IH_X  = IN_X + HM_X
107200020531
107300020531      *?CALCULATE AVERAGE AGE
107400020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
107500020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
107600020531      *?FIELD "J" WILL CONTAIN AGE BAND
107700020531
107800041109     C                   EVAL      AMAGE = TMAGE / TPHLD
107900020531
108000020531     C                   Z-ADD     1             J_X
108100020610     C     AMAGE         LOOKUP    MA_A(J_X)                            2222
108200020606     C                   IF        *IN22 = *ON AND
108300020610     C                             AMAGE = MA_A(J_X)
108400020606     C                   EVAL      J_X = J_X - 1
108500980406     C                   END
108600020531
108700020607     C                   EVAL      AGE_P = J_X
108800020531
108900020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
109000961211     C                   EXSR      $GETP
109100020610     C                   MOVEA     PARY          PH_A
109200020606     C                   EVAL      L2P = L2P + PARY
109300961211     C                   EXCEPT    #CUR2
109400020531
109500960811     C                   ENDSR
109600020531      *?*****************************************************
109700961118     C     $RAT10        BEGSR
109800020531      *?U.S. HEALTHCARE
109900020531
110000020531      *?CALCULATE AVERAGE AGE. ATTAINED AGE THIS YEAR
110100020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
110200020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
110300020531      *?FIELD "J" WILL CONTAIN AGE BAND
110400020531
110500041109     C                   EVAL      ANAGE = TNAGE / TPHLD
110600020531
110700020531     C                   Z-ADD     1             J_X
110800020610     C     ANAGE         LOOKUP    AB_A(J_X)                            2222
110900020606     C                   IF        *IN22 = *ON AND
111000020610     C                             ANAGE = AB_A(J_X)
111100020606     C                   EVAL      J_X = J_X - 1
111200961118     C                   END
111300020531
111400020607     C                   EVAL      AGE_P = J_X
111500020531
111600020531      *?U.S. HEALTHCARE           *
111700020531
111800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
111900961118     C                   EXSR      $GETP
112000020610     C                   MOVEA     PARY          PH_A
112100020606     C                   EVAL      L2P = L2P + PARY
112200961118     C                   EXCEPT    #CUR2
112300020531
112400961118     C                   ENDSR
112500020531      *?********************************
112600961118     C     $RAT11        BEGSR
112700020531      *?UNITED HEALTH CARE
112800020531
112900020531      *?CALCULATE AVERAGE AGE
113000020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
113100020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
113200020531      *?FIELD "J" WILL CONTAIN AGE BAND
113300020531
113400041109     C                   EVAL      AAGE = TAGE / TPHLD
113500020531
113600020531     C                   Z-ADD     1             J_X
113700020610     C     AAGE          LOOKUP    AB_A(J_X)                            2222
113800020606     C                   IF        *IN22 = *ON AND
113900020610     C                             AAGE = AB_A(J_X)
114000020606     C                   EVAL      J_X = J_X - 1
114100961118     C                   END
114200020531
114300020607     C                   EVAL      AGE_P = J_X
114400020531
114500020531      *?UNITED HEALTH CARE        *
114600020531
114700020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
114800961118     C                   EXSR      $GETP
114900020610     C                   MOVEA     PARY          PH_A
115000020606     C                   EVAL      L2P = L2P + PARY
115100961118     C                   EXCEPT    #CUR2
115200020606
115300961118     C                   ENDSR
115400020531      *?*****************************************************
115500011108     C     $RATBC        BEGSR
115600020531      *?BLUE CHOICE HMO
115700020531
115800020531      *?CALCULATE AVERAGE AGE
115900020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
116000020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
116100020531      *?FIELD "J" WILL CONTAIN AGE BAND
116200020531
116300011108     C                   EXSR      #GEO5
116400020606     C                   IF        BCFLG <> 'YES'
116500020606     C                   ELSE
116600020531
116700041109     C                   EVAL      AAGE = TAGE / TPHLD
116800020531
116900020531     C                   Z-ADD     1             J_X
117000020610     C     AAGE          LOOKUP    A4_A(J_X)                            2222
117100020606     C                   IF        *IN22 = *ON AND
117200020610     C                             AAGE = A4_A(J_X)
117300020606     C                   EVAL      J_X = J_X - 1
117400011108     C                   END
117500020531
117600020607     C                   EVAL      AGE_P = J_X
117700020531
117800020531      *?BLUE CHOICE HMO           *
117900020531
118000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
118100011108     C                   EXSR      $GETP
118200020610     C                   MOVEA     PARY          PH_A
118300020606     C                   EVAL      L2P = L2P + PARY
118400011108     C                   EXCEPT    #CUR2
118500020531
118600020606     C                   END
118700011108     C                   ENDSR
118800020531      *?*****************************************************
118900020531      *?JUST DENTAL/COBRA PLANS
119000950810     C     $RAT7         BEGSR
119100020531      *?JUST DENTAL
119200020606     C                   IF        P_PCARR = 'AS '
119300020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
119400020606     C                   EXSR      $GETP
119500020610     C                   MOVEA     PARY          PH_A
119600020606     C                   EVAL      L2P = L2P + PARY
119700020606     C                   EXCEPT    #CUR2
119800020606
119900020606     C                   ELSE
120000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
120100950810     C                   EXSR      $GETP
120200020610     C                   MOVEA     PARY          PH_A
120300020606     C                   EVAL      L2P = L2P + PARY
120400950810     C                   EXCEPT    #CUR2
120500020531
120600020606     C                   END
120700950810     C                   ENDSR
120800020531      *?*****************************************************
120900020531
121000940623     C     #INDF         BEGSR
121100020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
121200020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
121300020531      *?ELSE USE HMO AGES
121400020531
121500020610     C                   Z-ADD     0             AT_A
121600950713     C                   Z-ADD     0             FACT
121700020531
121800020606     C                   IF        IN_X <> *ZEROS
121900020610     C                   DO        10            YY_X
122000020610     C                   IF        AGI(YY_X) <> *ZEROS
122100020808     C                   EVAL(H)   AT_A(YY_X) = AGI(YY_X) * AFI(YY_X)
122200940623     C                   END
122300020606     C                   ENDDO
122400020610     C                   XFOOT     AT_A          ATOT
122500020606     C                   EVAL(H)   FACT = ATOT / IN_X
122600940623     C                   END
122700020531
122800020531      *?NO INDEMNITY EMPLOYEES, USE HMO AGES
122900020531
123000020606     C                   IF        IN_X = *ZEROS
123100020610     C                   DO        10            YY_X
123200020610     C                   IF        AGH(YY_X) <> *ZEROS
123300020808     C                   EVAL(H)   AT_A(YY_X) = AGH(YY_X) * AFI(YY_X)
123400940623     C                   END
123500020606     C                   ENDDO
123600020610     C                   XFOOT     AT_A          ATOT
123700020606     C                   EVAL(H)   FACT = ATOT / HM_X
123800940623     C                   END
123900020531
124000940623     C                   ENDSR
124100020531      *?***************************************************************
124200020531
124300970908     C     #INDFP        BEGSR
124400020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
124500020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
124600020531
124700020610     C                   Z-ADD     0             AT_A
124800970908     C                   Z-ADD     0             ATP
124900970908     C                   Z-ADD     0             FACT
125000970908     C                   Z-ADD     0             ATOT
125100970917     C                   Z-ADD     0             INH
125200020606     C                   EVAL      INH = IN_X + HM_X
125300020610     C                   DO        15            YY_X
125400020610     C                   IF        AGP(YY_X) <> *ZEROS
125500020808     C                   EVAL(H)   ATP(YY_X) = AGP(YY_X) * AIP(YY_X)
125600970908     C                   END
125700020606     C                   ENDDO
125800020531     C                   XFOOT     ATP           ATOTP
125900020606     C                   EVAL(H)   FACTP = ATOTP / INH
126000970908     C                   ENDSR
126100020531      *?***************************************************************
126200020531
126300020531      *?AETNA AGE FACTORS
126400020531
126500950612     C     #INDF3        BEGSR
126600020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
126700020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
126800020531      *?ELSE USE HMO AGES
126900020531
127000020610     C                   Z-ADD     0             AT_A
127100950612     C                   Z-ADD     0             FACTOR
127200020531
127300020606     C                   IF        IN_X <> *ZEROS
127400020610     C                   DO        10            YY_X
127500020610     C                   IF        AGI(YY_X) <> *ZEROS
127600020808     C                   EVAL(H)   AT_A(YY_X) = AGI(YY_X) * AAF(YY_X)
127700950612     C                   END
127800020606     C                   ENDDO
127900020610     C                   XFOOT     AT_A          ATOT
128000020606     C                   EVAL(H)   FACTOR = ATOT / IN_X
128100950612     C                   END
128200020531
128300020531      *?NO INDEMNITY EMPLOYEES, USE HMO AGES
128400020531
128500020606     C                   IF        IN_X = *ZEROS
128600020610     C                   DO        10            YY_X
128700020610     C                   IF        AGH(YY_X) <> *ZEROS
128800020808     C                   EVAL(H)   AT_A(YY_X) = AGH(YY_X) * AAF(YY_X)
128900950612     C                   END
129000020606     C                   ENDDO
129100020610     C                   XFOOT     AT_A          ATOT
129200020606     C                   EVAL(H)   FACTOR = ATOT / HM_X
129300950612     C                   END
129400020531
129500950612     C                   ENDSR
129600020531      *?***************************************************************
129700940623     C     #HMOF         BEGSR
129800020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
129900020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
130000020531      *?ELSE USE HMO AGES
130100020531
130200020610     C                   Z-ADD     0             AT_A
130300940624     C                   Z-ADD     0             FACTO2
130400020531
130500020606     C                   IF        HM_X = *ZEROS
130600020610     C                   DO        10            YY_X
130700020610     C                   IF        AGI(YY_X) <> *ZEROS
130800020808     C                   EVAL(H)   AT_A(YY_X) = AGI(YY_X) * AFH(YY_X)
130900940623     C                   END
131000020606     C                   ENDDO
131100020610     C                   XFOOT     AT_A          ATOT
131200020606     C                   EVAL(H)   FACTO2 = ATOT / IN_X
131300940623     C                   END
131400020531
131500020531      *?NO INDEMNITY EMPLOYEES, USE HMO AGES
131600020531
131700020606     C                   IF        HM_X <> *ZEROS
131800020610     C                   DO        10            YY_X
131900020610     C                   IF        AGH(YY_X) <> *ZEROS
132000020808     C                   EVAL(H)   AT_A(YY_X) = AGH(YY_X) * AFH(YY_X)
132100940623     C                   END
132200020606     C                   ENDDO
132300020610     C                   XFOOT     AT_A          ATOT
132400020606     C                   EVAL(H)   FACTO2 = ATOT / HM_X
132500940623     C                   END
132600020531
132700940623     C                   ENDSR
132800020531      *?***************************************************************
132900940623     C     #GEO          BEGSR
133000020531      *?ESTABLISH GEOGRAPHICAL FACTOR
133100020531
133200020531     C                   Z-ADD     0             F_X
133300020531     C                   Z-ADD     0             K_X
133400020531
133500020607     C     A_ACONTY      LOOKUP    CG1                                    63
133600020606     C                   IF        *IN63 = *ON
133700020610     C                   Z-ADD     GF_A(1)       F_X
133800020606     C                   Z-ADD     1             K_X
133900020606     C                   ELSE
134000020531
134100020607     C     A_ACONTY      LOOKUP    CG2                                    63
134200020606     C                   IF        *IN63 = *ON
134300020610     C                   Z-ADD     GF_A(2)       F_X
134400020606     C                   Z-ADD     2             K_X
134500020606     C                   ELSE
134600020531
134700020607     C     A_ACONTY      LOOKUP    CG3                                    63
134800020606     C                   IF        *IN63 = *ON
134900020610     C                   Z-ADD     GF_A(3)       F_X
135000020606     C                   Z-ADD     3             K_X
135100020606     C                   ELSE
135200020531
135300020607     C     A_ACONTY      LOOKUP    CG4                                    63
135400020606     C                   IF        *IN63 = *ON
135500020610     C                   Z-ADD     GF_A(4)       F_X
135600020606     C                   Z-ADD     4             K_X
135700020606     C                   ELSE
135800020531
135900951025     C                   EXCEPT    ERROR
136000020606     C                   END
136100020606     C                   END
136200020606     C                   END
136300020606     C                   END
136400020531
136500940623     C                   ENDSR
136600020531      *?*****************************************************
136700970908     C     #GEOP         BEGSR
136800020531      *?ESTABLISH GEOGRAPHICAL FACTOR
136900020531
137000020531     C                   Z-ADD     0             F_X
137100020531     C                   Z-ADD     0             K_X
137200020531
137300020531     C     A_ACONTY      LOOKUP    CG1                                    63
137400020606     C                   IF        *IN63 = *ON
137500020606     C                   Z-ADD     GFP(1)        F_X
137600020606     C                   Z-ADD     1             K_X
137700020606     C                   ELSE
137800020531
137900020531     C     A_ACONTY      LOOKUP    CG2                                    63
138000020606     C                   IF        *IN63 = *ON
138100020606     C                   Z-ADD     GFP(2)        F_X
138200020606     C                   Z-ADD     2             K_X
138300020606     C                   ELSE
138400020531
138500020531     C     A_ACONTY      LOOKUP    CG3                                    63
138600020606     C                   IF        *IN63 = *ON
138700020606     C                   Z-ADD     GFP(3)        F_X
138800020606     C                   Z-ADD     3             K_X
138900020606     C                   ELSE
139000020531
139100020531     C     A_ACONTY      LOOKUP    CG4                                    63
139200020606     C                   IF        *IN63 = *ON
139300020606     C                   Z-ADD     GFP(4)        F_X
139400020606     C                   Z-ADD     4             K_X
139500020606     C                   ELSE
139600020531
139700970908     C                   EXCEPT    ERROR
139800020606     C                   END
139900020606     C                   END
140000020606     C                   END
140100020606     C                   END
140200020531
140300970908     C                   ENDSR
140400020531      *?*****************************************************
140500941021     C     #GEO2         BEGSR
140600020531      *?ESTABLISH GEOGRAPHICAL FACTOR FOR PRINCIPAL
140700020531
140800020531     C                   Z-ADD     0             F_X
140900020531     C                   Z-ADD     0             K_X
141000020531
141100020531     C     A_ACONTY      LOOKUP    CG5                                    63
141200020606     C                   IF        *IN63 = *ON
141300020610     C                   Z-ADD     GF_A(1)       F_X
141400020606     C                   Z-ADD     1             K_X
141500020606     C                   ELSE
141600020531
141700020531     C     A_ACONTY      LOOKUP    C14                                    63
141800020606     C                   IF        *IN63 = *ON
141900020610     C                   Z-ADD     GF_A(3)       F_X
142000020606     C                   Z-ADD     3             K_X
142100020606     C                   ELSE
142200020531
142300020531      *?NO ERROR FOR PRINCIPAL NO FIND OF COUNTY. NOT OFFERED
142400020531      *?IN MANY LOCATIONS.
142500020531
142600941021     C                   EXCEPT    ERROR
142700020606     C                   END
142800020606     C                   END
142900020531
143000941021     C                   ENDSR
143100020531      *?*****************************************************
143200950308     C     #GEO3         BEGSR
143300020531      *?ESTABLISH GEOGRAPHICAL FACTOR FOR AETNA INDEMNITY
143400020531
143500020531     C                   Z-ADD     0             F_X
143600020531     C                   Z-ADD     0             K_X
143700020531
143800020531     C     A_ACONTY      LOOKUP    CG7                                    63
143900020606     C                   IF        *IN63 = *ON
144000020606     C                   Z-ADD     GO3(1)        F_X
144100020606     C                   Z-ADD     1             K_X
144200020606     C                   ELSE
144300020531
144400020531     C     A_ACONTY      LOOKUP    CG8                                    63
144500020606     C                   IF        *IN63 = *ON
144600020606     C                   Z-ADD     GO3(2)        F_X
144700020606     C                   Z-ADD     2             K_X
144800020606     C                   ELSE
144900020531
145000020531     C     A_ACONTY      LOOKUP    CG9                                    63
145100020606     C                   IF        *IN63 = *ON
145200020606     C                   Z-ADD     GO3(3)        F_X
145300020606     C                   Z-ADD     3             K_X
145400020606     C                   ELSE
145500020531
145600020531     C     A_ACONTY      LOOKUP    C10                                    63
145700020606     C                   IF        *IN63 = *ON
145800020606     C                   Z-ADD     GO3(3)        F_X
145900020606     C                   Z-ADD     4             K_X
146000020606     C                   ELSE
146100020531
146200020531     C     A_ACONTY      LOOKUP    C11                                    63
146300020606     C                   IF        *IN63 = *ON
146400020606     C                   Z-ADD     GO3(4)        F_X
146500020606     C                   Z-ADD     5             K_X
146600020606     C                   ELSE
146700020531
146800950308     C                   EXCEPT    ERROR
146900020606     C                   END
147000020606     C                   END
147100020606     C                   END
147200020606     C                   END
147300020606     C                   END
147400020531
147500950308     C                   ENDSR
147600020531      *?*****************************************************
147700950308     C     #GEO4         BEGSR
147800020531      *?ESTABLISH GEOGRAPHICAL FACTOR FOR AETNA HMO'S
147900020531
148000020531     C                   Z-ADD     0             F_X
148100020531     C                   Z-ADD     0             K_X
148200020531
148300020531     C     A_ACONTY      LOOKUP    C12                                    63
148400020605     C                   IF        *IN63 = *ON
148500020605     C                   Z-ADD     GO4(1)        F_X
148600020605     C                   Z-ADD     1             K_X
148700020606     C                   ELSE
148800020531
148900020531     C     A_ACONTY      LOOKUP    C13                                    63
149000020605     C                   IF        *IN63 = *ON
149100020605     C                   Z-ADD     GO4(2)        F_X
149200020605     C                   Z-ADD     2             K_X
149300020605     C                   END
149400020531
149500020606     C                   END
149600950308     C                   ENDSR
149700020531      *?*****************************************************
149800011108     C     #GEO5         BEGSR
149900020531      *?ESTABLISH GEOGRAPHICAL AVAILABILITY FOR BLUE CHOICE PRODUCTS
150000020531
150100020531     C                   MOVE      *BLANKS       BCFLG
150200020531
150300020531     C     A_ACONTY      LOOKUP    C20                                    63
150400020605     C                   IF        *IN63 = *ON
150500020605     C                   MOVE      'YES'         BCFLG
150600020605     C                   END
150700020531
150800011108     C                   ENDSR
150900020531      *?*****************************************************
151000940623     C     #LIMT         BEGSR
151100020531      *?CHECK FOR EXCEEDING 150 % OF BASE PREMIUM
151200020531      *?OR FOR BELOW 50 % OF BASE PREMIUM
151300020531
151400020808     C                   EVAL(H)   LHLD = PH_A(S_X) * .60
151500020808     C                   EVAL(H)   HHLD = PH_A(S_X) * 1.40
151600020531
151700020606     C                   IF        PARY(S_X) < LHLD
151800020606     C                   EVAL      PARY(S_X) = LHLD
151900940623     C                   END
152000020606     C                   IF        PARY(S_X) > HHLD
152100020606     C                   EVAL      PARY(S_X) = HHLD
152200940623     C                   END
152300020531
152400940623     C                   ENDSR
152500020531      *?*****************************************************
152600940701     C     #LIMT2        BEGSR
152700020531      *?CHECK FOR EXCEEDING 150 % OF BASE PREMIUM
152800020531      *?OR FOR BELOW 50 % OF BASE PREMIUM
152900020531
153000020531     C                   DO        4             L_X
153100020808     C                   EVAL(H)   LHLD = PH_A(L_X) * .60
153200020808     C                   EVAL(H)   HHLD = PH_A(L_X) * 1.40
153300020531
153400020606     C                   IF        PARY(L_X) < LHLD
153500020606     C                   EVAL      PARY(L_X) = LHLD
153600940701     C                   END
153700020606     C                   IF        PARY(L_X) > HHLD
153800020606     C                   EVAL      PARY(L_X) = HHLD
153900940701     C                   END
154000020531
154100020606     C                   ENDDO
154200940701     C                   ENDSR
154300020531      *?*****************************************************
1544009309270283 C     $PREM         BEGSR
1545000205310285  *? CALCULATE PREMIUM BASED ON ACTIVE PLANS AND CURRENT RATES
1546000205310286  *? CALCULATE AGE AND AGE BAND IF AGE BANDED
1547000205310287
1548000205310288  *?ZERO OUT PREMIUM
1549000205310289
1550009309270290 C                   MOVE      *ZEROS        PREM
1551009309270331 C                   Z-ADD     COVYY         HCOVYY
1552009309270332 C                   Z-ADD     COVMM         HCOVMM
1553009309270333 C                   Z-ADD     COVDD         HCOVDD
1554000205310339
1555009309270341 C                   Z-ADD     *ZEROS        GCOUNT
155600020612     C                   EVAL      G_GRTRST = A_ACTRST
155700020612     C                   EVAL      G_GRSUB# = A_ACSUB#
155800020607     C                   EVAL      RNAGE_2 = AGE_P
1559000206070342 C     GRATE2KEY     SETLL     GRATE
1560000205310343
156100020603     C                   DOU       %EOF(GRATE)
1562000206070346 C     GRATE2KEY     READE     GRATER
156300020603     C                   IF        NOT %EOF(GRATE)
1564000206060350 C                   IF        CYMD >= G_FRMDAT
1565000206060350 C                   IF        CYMD <= G_TODAT
156600020606     C                   EVAL      GCOUNT = GCOUNT + 1
1567000206030353 C                   LEAVE
1568009309270354 C                   END
1569009309270355 C                   END
1570000206030357 C                   END
1571000206030359 C                   ENDDO
1572000205310360
1573000206060361 C                   IF        GCOUNT = *ZEROS
157400020606     C                   EVAL      PREM = *ZEROS
157500020606     C                   ELSE
1576000205310364
1577000205310368  *?ACCUMULATE PREMIUM IF PLAN RATE TYPE IS PREMIUM
1578000205310369
1579000206060370 C                   IF        P_PRTYPE = 'P'
158000020606     C                   EVAL      PREM = PREM + G_BILRTE
1581009309270372 C                   END
1582000206060363 C                   END
1583000205310373
1584009309270382 C                   ENDSR
1585000205310383
158600020531 385  *?**************************************************************
158700020531
158800020531     C     *INZSR        BEGSR
158900020606     C     PACCR_KEY     KLIST
159000020611     C                   KFLD                    TSA_HOLD
159100020606     C     ACCMST_KEY    KLIST
159200020606     C                   KFLD                    RNTRST
159300020604     C                   KFLD                    RNSUB#
159400020604     C                   KFLD                    RNACC#
159500020531     C     PLNMST_KEY    KLIST
159600020604     C                   KFLD                    RNTRST
159700020604     C                   KFLD                    RNSUB#
159800020607     C                   KFLD                    RNPLAN
159900020610
160000020531     C     AC2MST_KEY    KLIST
160100020531     C                   KFLD                    PREFIX_U
160200020604     C                   KFLD                    RNTRST
160300020604     C                   KFLD                    RNSUB#
160400020604     C                   KFLD                    RNACC#
160500020607     C     ACCMST2KEY    KLIST
160600020612     C                   KFLD                    RNTRST_HD
160700020612     C                   KFLD                    RNSUB#_HD
160800020612     C                   KFLD                    RNACC#_H
160900020607     C     PLNMST2KEY    KLIST
161000020607     C                   KFLD                    RNTRST_H
161100020607     C                   KFLD                    RNSUB#_H
161200020607     C                   KFLD                    RNPLAN_H
161300020607
161400020607     C     GRATE2KEY     KLIST
161500020612     C                   KFLD                    A_ACTRST
161600020612     C                   KFLD                    A_ACSUB#
161700020607     C                   KFLD                    RNPLAN_H
161800020607     C                   KFLD                    RNAGE_2
161900020607     C                   KFLD                    R2COVTP
162000020607     C     APLNP2KEY     KLIST
162100020612     C                   KFLD                    RNTRST_HD
162200020612     C                   KFLD                    RNSUB#_HD
162300020612     C                   KFLD                    RNACC#_H
162400020610     C                   KFLD                    AP_PLAN
162500020607     C     COUNTY2KEY    KLIST
162600020607     C                   KFLD                    A_ASTATE
162700020607     C                   KFLD                    A_ACONTY
162800020605
162900020605      *?SHOW WHICH, IF ANY, SALESPERSON CODE WAS SELECTED ON THE REPORT
163000020605
163100020606     C                   IF        SPC = *BLANKS
163200020605     C                   MOVEL     'ALL'         SPC
163300020605     C                   END
163400020605     C                   MOVEL     UDSYY         UDSYMD
163500020605     C                   MOVE      UDSMD         UDSYMD
163600020611     C     *NOKEY        CLEAR     *ALL          PROMSR
163700020611     C     'CMP'         CHAIN     PROMSR
163800020808     C                   EVAL      PAGES = PAGE_IN
163900030212     C                   EVAL      LEADR = LEADR_IN
164000020531
1641000205310382 C                   ENDSR
164200020627     ORPP010P   E            #SYN             04
164300940624     O                                           55 'B E N E F I T  &  R A T'
164400940624     O                                           78 ' E  C O M P A R I S O N'
164500940624     O          E            #SYN           1
164600940624     O                                           55 'B E N E F I T  &  R A T'
164700940624     O                                           78 ' E  C O M P A R I S O N'
164800940624     O          E            #SYN           1
164900940624     O                                           55 '-- Prepared by Group Be'
165000940624     O                                           78 'nefit Services, Inc. --'
165100931001     O          E            #SYN           1
165200930929     O                                           14 'Account Name:'
165300020531     O                       A_ACNAM1            55
165400951030     O                                           70 'Acct.#:'
165500020611     O                       TSA_HOLD            83 '   -   -    '
165600951030     O                                           94 'Eff.Date:'
165700981130     O                       UDSDAT             107 '  /  /    '
165800951025     O          E            #SYN           1
165900930929     O                                           24 '________________________'
166000930928     O                                           48 '________________________'
166100930928     O                                           72 '________________________'
166200930929     O                                           96 '________________________'
166300930929     O                                          120 '________________________'
166400951025     O          E            #SYN1          2
166500951025     O                                           24 '________________________'
166600951025     O                                           48 '_____ C U R R E N T  B E'
166700951025     O                                           72 ' N E F I T  P L A N S  A'
166800951025     O                                           96 ' N D  R A T E S ________'
166900951025     O                                          120 '________________________'
167000941021     O          E            #SYN1          1
167100951025     O                                           22 'CURRENT BENEFIT PLANS'
167200950919     O                                           50 'GROUP#'
167300940624     O                                           74 'IND'
167400940624     O                                           84 'P&C'
167500940624     O                                           98 'H&W'
167600940624     O                                          109 'FAM'
167700941021     O          E            #SYN1          1
167800951025     O                                           24 '------------------------'
167900951025     O                                           48 '------------------------'
168000951025     O                                           72 '------------------------'
168100951025     O                                           96 '------------------------'
168200951025     O                                          120 '------------------------'
168300951025     O          E            #SYN1B      1  2 20
168400951025     O                                           24 '________________________'
168500951026     O                                           48 ' R E N E W A L  R A T E '
168600030212     O                                           72 'S ______________________'
168700030212     O                                           96 '________________________'
168800030212     O                                          120 '________________________'
168900951024     O          E            #SYN1B         1
169000030212     O                                           14 'BENEFIT PLANS'
169100951020     O                                           74 'IND'
169200951020     O                                           84 'P&C'
169300951020     O                                           98 'H&W'
169400951020     O                                          109 'FAM'
169500951024     O          E            #SYN1B         1
169600951025     O                                           24 '------------------------'
169700951025     O                                           48 '------------------------'
169800951025     O                                           72 '------------------------'
169900951025     O                                           96 '------------------------'
170000951025     O                                          120 '------------------------'
170100951025     O          E            #NEWP          1
170200951025     O                                           74 'IND'
170300951025     O                                           84 'P&C'
170400951025     O                                           98 'H&W'
170500951025     O                                          109 'FAM'
170600930928     O          E            #CUR2          1
170700020531     O                       P_PDESCR       B    40
170800020531     O               58      G_GROUP#            60
170900020531     O                       PARY(1)       2B    75
171000020531     O                       PARY(2)       2B    85
171100020531     O                       PARY(3)       2B    99
171200020531     O                       PARY(4)       2B   110
171300951027     O          E            #SPACE         1
171400951027     O                                            1 ' '
171500951025     O          E            #CUR3          1
171600951025     O                                           75 '-------'
171700951025     O                                           85 '-------'
171800951025     O                                           99 '-------'
171900951025     O                                          110 '-------'
172000951025     O          E            #CUR3          1
172100951025     O                                           35 'TOTAL RATES:'
172200951030     O                                           45 '(____)  '
172300951025     O                       L2P(1)        1B    75
172400951025     O                       L2P(2)        1B    85
172500951025     O                       L2P(3)        1B    99
172600951025     O                       L2P(4)        1B   110
172700951026     O          E            #MS            2
172800020409     O                                              ' '
172900940705     O          E            NEWPAG         1 02
173000940705     O                                              ' '
173100951025     O          E            #L2D           1
173200951025     O                                           24 '         S M A L L  G R '
173300951025     O                                           48 'O U P  R E F O R M  A L '
173400951025     O                                           72 'T E R N A T I V E  B E N'
173500951025     O                                           96 ' E F I T  P L A N S  A N'
173600951025     O                                          120 ' D  R A T E S           '
173700951025     O          E            #L2D           1
173800951025     O                                           24 '________________________'
173900951025     O                                           48 '________________________'
174000951025     O                                           72 '________________________'
174100951025     O                                           96 '________________________'
174200951025     O                                          120 '________________________'
174300951026     O          E            #CARR       1  2
174400951027     O                       CNAME               60
174500951025     O          E            #DONE1         1 60
174600951025     O                                           24 '........................'
174700951025     O                                           48 '........................'
174800951025     O                                           72 '........................'
174900951025     O                                           96 '........................'
175000951025     O                                          120 '........................'
175100951025     O          E            #DONE1         1
175200951025     O                                           44 'I CERTIFY MY ELECTION OF'
175300951025     O                                           68 ' THE BENEFIT PLAN AND RA'
175400951025     O                                           92 'TES(S) SELECTED ABOVE.  '
175500951025     O          E            #DONE1      1  2
175600951030     O                                           44 'ACCEPTED BY COMPANY OFFI'
175700951030     O                                           68 'CIAL:___________________'
175800951025     O                                           92 '________________________'
175900951030     O                                          120 'DATE:___________________'
176000020531      *?PRINT ON LAST PAGE
176100951031     O          E            #DONE          1 54
176200951031     O                                           44 'I CERTIFY MY ELECTION OF'
176300951031     O                                           68 ' THE BENEFIT PLAN AND RA'
176400951031     O                                           92 'TES(S) SELECTED ABOVE.  '
176500951031     O          E            #DONE       1  2
176600951031     O                                           44 'ACCEPTED BY COMPANY OFFI'
176700951031     O                                           68 'CIAL:___________________'
176800951031     O                                           92 '________________________'
176900951031     O                                          120 'DATE:___________________'
177000951031     O          E            #DONE          1
177100940701     O                                           24 '* Rates based upon'
177200940701     O                       TPHLD         Z     27
177300940701     O                                           52 'employees with Medical C'
177400940712     O                                           76 'overage, excluding Medic'
177500940713     O                                          100 'are Supplement enrollees'
177600940713     O                                          101 '.'
177700940701     O          E            #DONE          1
177800930929     O                                           24 '________________________'
177900930929     O                                           48 '________________________'
178000930929     O                                           72 '________________________'
178100930929     O                                           96 '________________________'
178200930929     O                                          120 '________________________'
178300940701     O          E            #DONE          1
178400020531     O                       PMMONE             120
178500940701     O          E            #DONE          1
178600020531     O                       PMMTWO             120
178700940701     O          E            #DONE          1
178800020531     O                       PMMTHREE           120
178900950308     O          E            #DONE          1
179000020531     O                       A_ACNAM1           111
179100020531      *?* PRINT OUT FOR DATA ENTERED ON INPUT SCREEN
179200971209     O          E            HEADR          3 03
179300971210     O                                           65 '        RENEWAL  NOTIFIC'
179400971210     O                                           72 'ATION  '
179500971209     O          E            HEADR          1
179600971209     O                                           31 'GBS ACCOUNT NUMBER:'
179700020611     O                       TSA_HOLD            45 '   -   -    '
179800971209     O                                          110 'RATE/BENEFIT CHANGE ____'
179900971209     O          E            HEADR          1
180000971209     O                                           31 'EFFECTIVE DATE    :'
180100981130     O                       UDSDAT              43 '  /  /    '
180200971209     O                                          110 'RATE CHANGE ONLY    ____'
180300971209     O          E            HEADR          3
180400971209     O                                           31 'DATE PREPARED     :'
180500981130     O                       UD8MD               38 '  /  '
180600981130     O                                           39 '/'
180700981130     O                       UD8Y                43
180800971209     O                                          110 '    (GBS USE ONLY)      '
180900971209     O          E            HEADR          1
181000971209     O                                           25 ' '
181100951025     O          E            HEADR          1
181200951025     O                                           25 'COMPANY NAME:'
181300020531     O                       A_ACNAM1            68
181400951025     O          E            HEADR          1
181500951025     O                                           25 'CONTACT NAME:'
181600020531     O                       A_ECNTAC            58
181700951025     O          E            HEADR          1
181800971209     O                                           25 'ADDRESS     :'
181900020531     O                       A_AADDR1            58
182000020829     O          E    50      HEADR          1
182100020829     O                                           25 '            :'
182200020829     O                       A_AADDR2            58
182300971209     O          E            HEADR          2
182400971209     O                                           25 'CITY/STATE  :'
182500020531     O                       A_ACITY             43
182600020531     O                       A_ASTATE            46
182700020531     O                       A_AZIP              57 '     -    '
182800020830     O          E   N50      HEADR          1
182900971210     O                                          103 ' '
183000940921     O          E            HEADR          1
183100940921     O                                           19 'COUNTY:'
183200020531     O                       A_ACONTY            22
183300001205     O                                           24 '-'
183400001205     O                       CNDESC              45
183500020624     O                                           97 'BROKER :'
183600020624     O                       S_SMANCD           101
183700940921     O          E            HEADR          1
183800940921     O                                           19 'PHONE: '
183900020531     O                       A_AAREA             23
184000940921     O                                           24 '-'
184100020531     O                       A_APHONE            33 '   -    '
184200020614     O                       SMANNAME           120
184300940921     O          E            HEADR          1
184400020614     O                       S_SADDR            120
184500940921     O          E            HEADR          1
184600940921     O                                           20 'AVG.AGE:'
184700941025     O                       AVGOUT        Z     24
184800020614     O                       SMANADDR           120
184900020614     O          E            LEADER         1 13
185000020614     O                       SMANNAME            43
185100020614     O          E            LEADER         1
185200020614     O                       S_SADDR             43
185300020614     O          E            LEADER         1
185400020614     O                       SMANADDR            43
185500940921     O          E            HEADR          1
185600940921     O                                           27 'INDEMNITY:'
185700971210     O                                          101 '('
185800020531     O                       S_SAREA            104
185900971210     O                                          105 ')'
186000971210     O                                          106 ' '
186100020531     O                       S_SPHONE           113 '   -    '
186200940921     O          E            HEADR          1
186300940921     O                                           20 '<30:'
186400941021     O                       AGI(2)        Z     24
186500940921     O                                           35 '30 - 34:'
186600941021     O                       AGI(3)        Z     39
186700940921     O                                           50 '35 - 39:'
186800941021     O                       AGI(4)        Z     54
186900940921     O          E            HEADR          1
187000940921     O                                           20 '40 -44:'
187100941021     O                       AGI(5)        Z     24
187200940921     O                                           35 '45 - 49:'
187300941021     O                       AGI(6)        Z     39
187400940921     O                                           50 '50 - 54:'
187500941021     O                       AGI(7)        Z     54
187600940921     O          E            HEADR          1
187700940921     O                                           20 '55 -59:'
187800941021     O                       AGI(8)        Z     24
187900940921     O                                           35 '60 - 64:'
188000941021     O                       AGI(9)        Z     39
188100940921     O                                           50 '65+:    '
188200941021     O                       AGI(10)       Z     54
188300951031     O                                           72 'MED.SUPP:'
188400951025     O                       MEDSUP        ZB    80
188500951025     O                                          110 'TOTAL INDEMNITY:'
188600951025     O                       TAGI          Z    115
188700940921     O          E            HEADR          1
188800940921     O                                           20 'HMO:'
188900940921     O          E            HEADR          1
189000940921     O                                           20 '<30:'
189100941021     O                       AGH(2)        Z     24
189200940921     O                                           35 '30 - 34:'
189300941021     O                       AGH(3)        Z     39
189400940921     O                                           50 '35 - 39:'
189500941021     O                       AGH(4)        Z     54
189600940921     O          E            HEADR          1
189700940921     O                                           20 '40 -44:'
189800941021     O                       AGH(5)        Z     24
189900940921     O                                           35 '45 - 49:'
190000941021     O                       AGH(6)        Z     39
190100940921     O                                           50 '50 - 54:'
190200941021     O                       AGH(7)        Z     54
190300940921     O          E            HEADR          1
190400940921     O                                           20 '55 -59:'
190500941021     O                       AGH(8)        Z     24
190600940921     O                                           35 '60 - 64:'
190700941021     O                       AGH(9)        Z     39
190800940921     O                                           50 '65+:    '
190900941021     O                       AGH(10)       Z     54
191000951031     O                                           72 'MED.SUPP:'
191100951025     O                       MEDSUH        ZB    80
191200951025     O                                          110 'TOTAL H.M.O.:'
191300951025     O                       TAGH          Z    115
191400950919     O          E            HEADR          2
191500950922     O                                           24 '________________________'
191600950922     O                                           48 '________________________'
191700950922     O                                           72 '________________________'
191800950922     O                                           96 '________________________'
191900950922     O                                          120 '________________________'
192000990607     O          E            HEADR          1
192100020422     O                                           34 '1) Is the Company offeri'
192200020422     O                                           58 'ng coverage for part tim'
192300020422     O                                           82 'e employees?   _______ Y'
192400020422     O                                          106 'es      _______ No      '
192500990607     O          E            HEADR          1
192600020422     O                                           34 '2) Is the Company offeri'
192700020422     O                                           58 'ng coverage to retirees?'
192800020422     O                                           82 '               _______ Y'
192900020422     O                                          106 'es      _______ No      '
193000020422     O          E            HEADR          1
193100020422     O                                           34 '3) Is the Company offeri'
193200020422     O                                           58 'ng coverage to those emp'
193300020422     O                                           82 'loyees with other Insura'
193400020422     O                                          106 'nce?    _______ Yes     '
193500020422     O                                          116 '_______ No '
193600020430     O          E            HEADR          2
193700020422     O                                           34 'If answer is "Yes" for q'
193800020422     O                                           58 'uestion #2, answer MUST '
193900020422     O                                           82 'be "Yes" for question #3'
194000020422     O                                           83 '.'
194100961103     O          E            HEADR          1
194200951025     O                                           34 'Rates for quoted benefit'
194300951025     O                                           58 's are for the effective '
194400951025     O                                           82 'date as shown above and '
194500951025     O                                          106 'are guaranteed through a'
194600951025     O                                          120 ' period of no '
194700970116     O          E            HEADR          2
194800971210     O                                           34 'longer than 12 months. F'
194900971210     O                                           58 'INAL RATES MAY DIFFER FR'
195000971210     O                                           82 'OM THIS FORM BY PENNIES.'
195100961103     O          E            HEADR          1
195200961105     O                                           24 'Please sign and return t'
195300961105     O                                           48 'his rate proposal. Your '
195400961105     O                                           72 'signature will indicate '
195500961105     O                                           96 'your acceptance of these'
195600961105     O                                          120 ' benefits and rates.    '
195700961103     O          E            HEADR          1
195800961105     O                                           24 'For renewing business, i'
195900961105     O                                           48 'f a signed acceptance is'
196000971210     O                                           72 ' not returned by the car'
196100971210     O                                           96 'rier submission deadline'
196200971210     O                                          120 ', the benefits and      '
196300961103     O          E            HEADR          1
196400961105     O                                           24 'renewal rates presented '
196500961105     O                                           48 'on the original renewal '
196600961105     O                                           72 'package will apply as of'
196700961105     O                                           96 ' the effective date note'
196800961103     O                                          120 'd. Payment of premium   '
196900961103     O          E            HEADR          2
197000961105     O                                           24 'will constitute acceptan'
197100961105     O                                           48 'ce of the rates and bene'
197200961105     O                                           72 'fits quoted.            '
197300961105     O          E            HEADR          2
197400961105     O                                           24 'Early renewal of an exis'
197500961105     O                                           48 'ting account will result'
197600961105     O                                           72 ' in new deductibles and '
197700971210     O                                           96 'maximums, when applied, '
197800971210     O                                          120 'for each subscriber.    '
197900950919     O          E            HEADR          1
198000971210     O                                           24 'The carrier reserves the'
198100971210     O                                           48 ' right to revise or with'
198200971210     O                                           72 'draw the rates quoted in'
198300971210     O                                           96 ' this proposal or to can'
198400971210     O                                          120 'cel the proposal alto-  '
198500950919     O          E            HEADR          1
198600971210     O                                           24 'gether in the event the '
198700971210     O                                           48 'carrier determines that '
198800971210     O                                           72 'the account is not eligi'
198900971210     O                                           96 'ble for the coverage cho'
199000971210     O                                          120 'sen or that any derived '
199100950919     O          E            HEADR          1
199200971210     O                                           24 'calculations are found t'
199300971210     O                                           48 'o be inaccurate, or the '
199400971210     O                                           72 'census is incorrect and '
199500971210     O                                           96 'causes a material change'
199600971210     O                                          120 'in the rates quoted. The'
199700950919     O          E            HEADR          1
199800971210     O                                           24 'account will be promptly'
199900971210     O                                           48 ' notified in the event t'
200000971210     O                                           72 'he carrier chooses to ex'
200100971210     O                                           96 'ercise such right. The a'
200200971210     O                                          120 'ccount will not be bound'
200300950919     O          E            HEADR          1
200400971210     O                                           24 'by such new or revised r'
200500971210     O                                           48 'ates and no contract wil'
200600971210     O                                           72 'l be established unless '
200700971210     O                                           96 'the account is presented'
200800971210     O                                          120 ' with and accepts a new '
200900950919     O          E            HEADR          1
201000971210     O                                           24 'proposal documenting the'
201100971210     O                                           48 ' new or revised rates.  '
201200950919     O          E            HEADR       1  1
201300020409     O                                           24 'Date:  _________________'
201400020409     O                                           46 '______________________'
201500020409     O                                           73 'Accepted by:      ______'
201600020409     O                                           97 '________________________'
201700020409     O                                          111 '________________________'
201800950919     O          E            HEADR       1  1
201900020409     O                                           73 'Print Name:       ______'
202000020409     O                                           97 '________________________'
202100020409     O                                          111 '________________________'
202200950919     O          E            HEADR          1
202300950919     O                                           24 'Preferred Risk Code:  20'
202400950919     O          E            HEADR          1
202500951025     O                                           24 'Actuarial Class Code: 03'
202600020409     O                                           73 'Company Name:     ______'
202700020409     O                                           97 '________________________'
202800020409     O                                          111 '________________________'
202900950919     O          E            HEADR          1
203000950922     O                                           24 'Rating Method Code:   02'
203100951031     O          E            HEADR          1
203200020430     O              N76                          73 'Federal Tax ID#:  ______'
203300020430     O              N76                          97 '________________________'
203400020430     O              N76                         111 '________________________'
203500020603     O               76                          65 'Federal Tax ID#:'
203600020604     O               76      A2TAX_ID#     Z     77
203700020603     O               76                          87 '_________'
203800020603     O               76                         111 '________________________'
203900020830     O          E            HEADR       1  3
204000951031     O                                           53 'THIS PAGE MUST BE SIGNED'
204100951031     O                                           77 ' IN ADDITION TO ANY OTHE'
204200951031     O                                          101 'R SELECTION PAGE OF THIS'
204300951031     O                                          111 ' PROPOSAL.'
204400930930     O          E            ERROR          2
204500950317     O                                           24 'RATE DATA STRUCTURE  :'
204600020531     O                       A_ACONTY            35
204700020610     O                       RATE_G              45
204800931001     O                       PREM                66
204900020607     O                       AGE_P               86
205000981130     O                       CYMD                97
205100020531     O                       G_FRMDAT           108
205200020531     O                       G_TODAT            120
205300020610** AGE BANDS FOR SMALL GROUP REFORM AB
205400020604001
205500020604029
205600020604034
205700020604039
205800020604044
205900020604049
206000020604054
206100020604059
206200020604064
206300020604099
206400020610** AGE BANDS FOR SMALL GROUP REFORM(PRINCIPAL) AB2
206500020604001
206600020604024
206700020604029
206800020604034
206900020604039
207000020604044
207100020604049
207200020604054
207300020604059
207400020604064
207500020604099
207600020610** AGE BANDS FOR PHN   AM_A
207700020604001
207800020604015
207900020604019
208000020604024
208100020604029
208200020604034
208300020604039
208400020604044
208500020604049
208600020604054
208700020604059
208800020604064
208900020604069
209000020604074
209100020604099
209200020610** AGE BANDS FOR BLUE CHOICE 11/2001   A4
209300020604001
209400020604030
209500020604032
209600020604035
209700020604038
209800020604041
209900020604044
210000020604047
210100020604050
210200020604053
210300020604056
210400020604059
210500020604099
210600020610** AGE FACTORS INDEMNITY FOR SMALL GROUP REFORM  AFI
210700940630063
210800940623063
210900940623069
211000940623079
211100940623102
211200940623108
211300940623135
211400940623179
211500940623220
211600940623315
211700020610** AGE FACTORS FOR PHN  AIP
2118009709080630
2119009709080630
2120009709080630
2121009709080630
2122009709080630
2123009709080700
2124009709080800
2125009709081030
2126009709081100
2127009709081350
2128009709081760
2129009709082100
2130009709082600
2131009709082600
2132009709082600
213300020610** AGE FACTORS HMO PLANS FOR SMALL GROUP REFORM  AFH
2134009406300825
2135009406230825
2136009406230905
2137009406230905
2138009406230965
2139009406230965
2140009406231300
2141009406231300
2142009611181650
2143009611181650
214400020610** GEOGRAPHICAL FACTORS FOR SGR  GF
214500010928100
214600010928104
214700010928090
214800010928093
214900020610** COUNTY CODES FOR BALTIMORE METRO AREA    CG1
215000940623AA
215100940623BA
215200940623HA
215300940623HO
215400020610** COUNTY CODES FOR WASHINGTON METRO AREA  CG2
215500940623MO
215600940623PG
215700020610** COUNTY CODES FOR WESTERN MD. AREA       CG3
215800940623AL
215900950810CR
216000940623GA
216100940623FR
216200940623WA
216300020610** COUNTY CODES FOR EASTERN AND SOUTHERN MD. CG4
216400940623CL
216500940623CA
216600940623CE
216700940623CH
216800940623DO
216900940623KT
217000940623QA
217100940623SO
217200940623SM
217300940623TA
217400940623WI
217500940623WO
217600020610** AETNA COUNTY CODES FOR BALTIMORE METRO AREA  CG7
217700950308AA
217800950308BA
217900950308CR
218000950308HA
218100950308HO
218200020610** AETNA COUNTY CODES FOR WASHINGTON METRO AREA  CG8
218300950308MO
218400950308PG
218500020610** AETNA COUNTY CODES FOR WESTERN MD. AREA       CG9
218600950308AL
218700950308GA
218800020610** AETNA COUNTY CODES FOR FRED.,CECIL,WASHINGTON, AND CHARLES   C10
218900950308FR
219000950308WA
219100950317CE
219200950317CH
219300020610** AETNA COUNTY CODES FOR EASTERN AND SOUTHERN MD. C11
219400950308CL
219500950308CA
219600950308DO
219700950308KT
219800950308QA
219900950308SO
220000950308SM
220100950308TA
220200950308WI
220300950308WO
220400020610** AETNA COUNTY CODES FOR BALTIMORE HMO'S    C12
220500950308AA
220600950308BA
220700950308CR
220800950308HA
220900950308HO
221000950308CE
221100950619FR
221200020610** AETNA COUNTY CODES FOR WASHINGTON HMO'S   C13
221300950308MO
221400950308PG
221500020610** PRINCIPAL BALTIMORE AREA COUNTIES  CG5
221600000605WA
221700000605FR
221800000605MO
221900000605PG
222000000605CE
222100000605QA
222200941021BA
222300941021HO
222400941021HA
222500941021AA
222600000605CA
222700000605CH
222800000605SM
222900000605KT
223000000605CL
223100000605TA
223200000605DO
223300000605WI
223400000605WO
223500000605SO
223600020610** PRINCIPAL OTHER AREA COUNTIES         C14
223700960811CR
223800960811FR
223900950308WA
224000950308CE
224100020610** KAISER BALTIMORE AREA COUNTIES        C15
224200950308BA
224300950308HO
224400950308HA
224500950308AA
224600950308CR
224700020610** KAISER WASHINGTON AREA COUNTIES      C16
224800950308MO
224900950308PG
225000950308FR
225100020610** HEALTH PLUS BALTIMORE COUNTIES      C17
225200950310AA
225300950310BA
225400950310CL
225500950310CR
225600950310CE
225700950310HA
225800950310HO
225900950310SM
226000020610** HEALTH PLUS D.C. COUNTIES          C18
226100950310CH
226200950310FR
226300950310MO
226400950310PG
226500950310WA
226600020610** BLUE CHOICE COUNTIES 11/2001       C20
226700011108AA
226800011108BA
226900011108CL
227000011108CR
227100011108CE
227200011108CH
227300011108FR
227400011108HA
227500011108HO
227600011108MO
227700011108PG
227800011108SM
227900020610** AGE FACTORS FOR AETNA PLANS            AAF
228000951024057
228100951024057
228200951024068
228300951024068
228400951024085
228500951024099
228600951024112
228700951024120
228800951024126
228900951024131
229000020610** AETNA GEO. AREA FACTORS HMO (GO4 ARRAY)   GO4
2291009506121000
2292009510241131
229300020610** AETNA GEO. AREA FACTORS IND.(GO3 ARRAY)   GO3
2294009506121000
2295009508211430
2296009508211000
2297009508211000
229800020610** AGE BANDS FOR MD. FIDELITY                     MA
229900020604001
230000020604039
230100020604044
230200020604099
230300020610** GEO FACTORS FOR PHN                            GFP
230400970908100
230500970908104
230600970908100
230700970908100
230800020610** EXCLUDE COUNTIES FOR PHN      PHNE
230900980406AL
231000980406GA
231100980406KT
231200980406CA
231300980406SO
231400980406DO
231500980406WI
231600980406QA
231700980406TA
231800980406WO
231900980406WA
232000020610** AGE BANDS FOR KAISER SMALL GROUP REFORM AK
232100020604001
232200020604024
232300020604029
232400020604034
232500020604039
232600020604044
232700020604049
232800020604054
232900020604059
233000020604064
233100020604099
