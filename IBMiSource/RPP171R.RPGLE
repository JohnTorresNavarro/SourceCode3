0001000205310002  *?****************************************************************
0002000405110003  *?RPP171R    GROUP BENEFIT SERVICES SOFTWARE           2004      *
0003000205310013  *? DESCRIPTION - THIS PROGRAM WILL PRODUCE A RENEWAL SYNOPSIS    *
0004000205310014  *?               FOR SMALL GROUP REFORM SHOWING RATE ALTERNATIVES*
0005000205310015  *?               FOR EXISTING ACCOUNTS.                          *
000600020531
000700020531      *? MODIFICATION:
000800020808      *?  TWP: 08.08.02 CHANGED ROUNDING ON ALL MULT AND DIV
000900020830      *?  TWP: 08.30.02 ADDED AADDR2 IF NEEDED
001000040511      *?  szz: 05.11.04 Remove Renewal Rate & Certification sections from
001100040511      *?                 page 2 and remove page 3 per Carol Fabiszak.
001200050518      *   dma  05.18.05 Removed plan cat MM logic.  BUG                *
0013000205310016  *?****************************************************************
0014000405120018 FRPP151P   IF   E           K DISK
0015000205310020 FGRATE     IF   E           K DISK    PREFIX(G_)
0016000205310023 FACCMST    IF   E           K DISK    PREFIX(A_)
0017000205310024 FPLNMST    IF   E           K DISK    PREFIX(P_)
0018000205310014 FSMAN      IF   E           K DISK    PREFIX(S_)
0019000205310014 FPROMSG    IF   E           K DISK    PREFIX(PM)
0020000205310014 FPACCPK    IF   E           K DISK
0021000205310014 FPACKAG    IF   E           K DISK
0022000205310014 FAPLNP     IF   E           K DISK
002300020531     FCOUNTIES  IF   E           K DISK
002400020531     FAC2MST    IF   E           K DISK
0025000206270026 FRPP010P   O    F  122        PRINTER OFLIND(*INOF)
002600950821     F                                     FORMLEN(66)
002700950821     F                                     FORMOFL(63)
002800020531
002900020531     D PRIND           S              8  2 INZ(*ZEROS)
003000020531     D UDSYMD          S              8  0 INZ(*ZEROS)
003100020531     D ATOTP           S              7  4 INZ(*ZEROS)
003200020531     D F_X             S              7  4 INZ(*ZEROS)
003300020531     D FACTOR          S              7  4 INZ(*ZEROS)
003400020531     D FACTP           S              7  3 INZ(*ZEROS)
003500020531     D FACTO2          S              7  3 INZ(*ZEROS)
003600020531     D FACT            S              7  2 INZ(*ZEROS)
003700020531     D LHLD            S              7  2 INZ(*ZEROS)
003800020531     D HHLD            S              7  2 INZ(*ZEROS)
003900020531     D PREM            S              7  2 INZ(*ZEROS)
004000020531     D ATOT            S              5  3 INZ(*ZEROS)
004100020531     D TAGE            S              7  0 INZ(*ZEROS)
004200020531     D TNAGE           S                   LIKE(TAGE) INZ(*ZEROS)
004300020531     D TMAGE           S                   LIKE(TAGE) INZ(*ZEROS)
004400020531     D MEDSUP          S              5  0 INZ(*ZEROS)
004500020531     D MEDSUH          S              5  0 INZ(*ZEROS)
004600020531     D TAGI            S              5  0 INZ(*ZEROS)
004700020531     D TAGH            S              5  0 INZ(*ZEROS)
004800020531     D IN_X            S              4  0 INZ(*ZEROS)
004900020531     D INH             S              4  0 INZ(*ZEROS)
005000020531     D HM_X            S                   LIKE(IN_X) INZ(*ZEROS)
005100020531     D A_X             S                   LIKE(IN_X) INZ(*ZEROS)
005200020611     D INDEX           S              3  0 INZ(*ZEROS)
005300020605     D TPHLD           S              3  0 INZ(*ZEROS)
005400020531     D AVGOUT          S              3  0 INZ(*ZEROS)
005500020610     D IH_X            S              3  0 INZ(*ZEROS)
005600020610     D YZ_X            S              3  0 INZ(*ZEROS)
005700020604     D J_X             S              3  0 INZ(*ZEROS)
005800020531     D Z_X             S                   LIKE(J_X) INZ(*ZEROS)
005900020610     D YY_X            S                   LIKE(J_X) INZ(*ZEROS)
006000020531     D GCOUNT          S                   LIKE(J_X) INZ(*ZEROS)
006100020604     D AAGE            S              3  0 INZ(*ZEROS)
006200020531     D ANAGE           S                   LIKE(AAGE) INZ(*ZEROS)
006300020531     D AMAGE           S                   LIKE(AAGE) INZ(*ZEROS)
006400020531     D X_X             S              1  0 INZ(*ZEROS)
006500020604     D RNAGE_2         S              2  0 INZ(*ZEROS)
006600020614     D SZIP5           S              5    INZ(*ZEROS)
006700020614     D SZIP4           S              4    INZ(*ZEROS)
006800020607     D AGE_P           S                   LIKE(RNAGE_2) INZ(*ZEROS)
006900020531     D S_X             S                   LIKE(X_X) INZ(*ZEROS)
007000020531     D K_X             S                   LIKE(X_X) INZ(*ZEROS)
007100020531     D L_X             S                   LIKE(X_X) INZ(*ZEROS)
007200020605     D R2COVTP         S                   LIKE(RNCOVTP)
007300020531     D $R1             S              1
007400020531     D MSFLG           S              1
007500020531     D STAFLG          S              2
007600020531     D BCFLG           S              3
0077000206100141 D AP_PLAN         S              4
007800020531     D CTAC            S             30
007900020614     D SMANNAME        S             30
008000020614     D SMANADDR        S             30
008100020614     D CNAME           S             60
008200020607     D RNAGEB_H        S                   LIKE(RNAGEB)
008300020611     D RNTRST_H        S                   LIKE(RNTRST)
008400020611     D RNSUB#_H        S                   LIKE(RNSUB#)
008500020611     D RNACC#_H        S                   LIKE(RNACC#)
008600020612     D RNTRST_HD       S                   LIKE(RNTRST)
008700020612     D RNSUB#_HD       S                   LIKE(RNSUB#)
008800020614     D RNSMCD_HD       S                   LIKE(RNSMCD)
008900020611     D TSA_HOLD        S             10  0 INZ(*ZEROS)
009000020606     D TSA_HOLD2       S             10  0 INZ(*ZEROS)
0091000206120154 D  RNPLAN_HD      S              4
009200020606     D ONE_TIME        S               N   INZ('0')
009300020808     D PAGES           S              1
009400030212     D LEADR           S              1
009500020531
009600020531      *?COMPILE TIME ARRAYS
009700020531
009800020610     D AB_A            S              3  0 DIM(10) CTDATA PERRCD(1) ASCEND
009900020610     D AB2_A           S              3  0 DIM(11) CTDATA PERRCD(1) ASCEND
010000020610     D AM_A            S              3  0 DIM(15) CTDATA PERRCD(1) ASCEND
010100020610     D A4_A            S              3  0 DIM(13) CTDATA PERRCD(1) ASCEND
010200020531     D AFI             S              3  2 DIM(10) CTDATA PERRCD(1)
010300020531     D AIP             S              4  3 DIM(15) CTDATA PERRCD(1)
010400020531     D AFH             S              4  3 DIM(10) CTDATA PERRCD(1)
010500020610     D GF_A            S              3  2 DIM(4) CTDATA PERRCD(1)
010600020531     D CG1             S              2    DIM(4) CTDATA PERRCD(1)
010700020531     D CG2             S              2    DIM(2) CTDATA PERRCD(1)
010800020531     D CG3             S              2    DIM(5) CTDATA PERRCD(1)
010900020531     D CG4             S              2    DIM(12) CTDATA PERRCD(1)
011000020531     D CG7             S              2    DIM(5) CTDATA PERRCD(1)
011100020531     D CG8             S              2    DIM(2) CTDATA PERRCD(1)
011200020531     D CG9             S              2    DIM(2) CTDATA PERRCD(1)
011300020531     D C10             S              2    DIM(4) CTDATA PERRCD(1)
011400020531     D C11             S              2    DIM(10) CTDATA PERRCD(1)
011500020531     D C12             S              2    DIM(7) CTDATA PERRCD(1)
011600020531     D C13             S              2    DIM(2) CTDATA PERRCD(1)
011700020610     D CG5             S              2    DIM(20) CTDATA PERRCD(1)
011800020531     D C14             S              2    DIM(4) CTDATA PERRCD(1)
011900020531     D C15             S              2    DIM(5) CTDATA PERRCD(1)
012000020531     D C16             S              2    DIM(3) CTDATA PERRCD(1)
012100020531     D C17             S              2    DIM(8) CTDATA PERRCD(1)
012200020531     D C18             S              2    DIM(5) CTDATA PERRCD(1)
012300020531     D C20             S              2    DIM(12) CTDATA PERRCD(1)
012400020531     D AAF             S              3  2 DIM(10) CTDATA PERRCD(1)
012500020531     D GO4             S              4  3 DIM(2) CTDATA PERRCD(1)
012600020531     D GO3             S              4  3 DIM(4) CTDATA PERRCD(1)
012700020610     D MA_A            S              3  0 DIM(4) CTDATA PERRCD(1) ASCEND
012800020531     D GFP             S              3  2 DIM(4) CTDATA PERRCD(1)
012900020531     D PHNE            S              2    DIM(11) CTDATA PERRCD(1)
013000020610     D AK_A            S              3  0 DIM(11) CTDATA PERRCD(1) ASCEND
013100020531      *?EXECUTION ARRAYS
013200020610     D AGI             S              4  0 DIM(10) INZ(*ZEROS)
013300020610     D AGH             S              4  0 DIM(10) INZ(*ZEROS)
013400020610     D AGP             S              4  0 DIM(15) INZ(*ZEROS)
013500050520     D PL_A            S              4    DIM(15) INZ('0000')
013600050520     D AG_A            S              4  0 DIM(15) INZ(*ZEROS)
013700020610     D AT_A            S              5  3 DIM(10) INZ(*ZEROS)
013800020610     D ATM             S              5  3 DIM(12) INZ(*ZEROS)
013900020610     D ATP             S              5  3 DIM(15) INZ(*ZEROS)
014000020610     D PARY            S              7  2 DIM(4)  INZ(*ZEROS)
014100020610     D L2P             S              7  2 DIM(4)  INZ(*ZEROS)
014200020610     D MS_A            S              7  2 DIM(4)  INZ(*ZEROS)
014300020610     D MS2             S              7  2 DIM(4)  INZ(*ZEROS)
014400020610     D PH_A            S              7  2 DIM(4)  INZ(*ZEROS)
014500020610     D PA_A            S              4    DIM(15) INZ('0000')
014600020610     D PP_A            S              5  0 DIM(15) INZ(*ZEROS)
014700020610     D PP2             S              5    DIM(15) INZ('00000')
014800020610     D CP_A            S              4    DIM(20) INZ('0000')
014900020605     D                 DS
015000020610     D ACP80                         80A   INZ('0000')
015100020605     D ACP1                                OVERLAY(ACP80)
015200020605     D ACP2                                OVERLAY(ACP80:*NEXT)
015300020605     D ACP3                                OVERLAY(ACP80:*NEXT)
015400020605     D ACP4                                OVERLAY(ACP80:*NEXT)
015500020605     D ACP5                                OVERLAY(ACP80:*NEXT)
015600020605     D ACP6                                OVERLAY(ACP80:*NEXT)
015700020605     D ACP7                                OVERLAY(ACP80:*NEXT)
015800020605     D ACP8                                OVERLAY(ACP80:*NEXT)
015900020605     D ACP9                                OVERLAY(ACP80:*NEXT)
016000020605     D ACP10                               OVERLAY(ACP80:*NEXT)
016100020605     D ACP11                               OVERLAY(ACP80:*NEXT)
016200020605     D ACP12                               OVERLAY(ACP80:*NEXT)
016300020605     D ACP13                               OVERLAY(ACP80:*NEXT)
016400020605     D ACP14                               OVERLAY(ACP80:*NEXT)
016500020605     D ACP15                               OVERLAY(ACP80:*NEXT)
016600020605     D ACP16                               OVERLAY(ACP80:*NEXT)
016700020605     D ACP17                               OVERLAY(ACP80:*NEXT)
016800020605     D ACP18                               OVERLAY(ACP80:*NEXT)
016900020605     D ACP19                               OVERLAY(ACP80:*NEXT)
017000020605     D ACP20                               OVERLAY(ACP80:*NEXT)
017100020606   X*
017200020606     D                 DS
017300020610     D PACC75                        75A   INZ(*ZEROS)
017400020606     D PAGP1                               OVERLAY(PACC75)
017500020606     D PAGP2                               OVERLAY(PACC75:*NEXT)
017600020606     D PAGP3                               OVERLAY(PACC75:*NEXT)
017700020606     D PAGP4                               OVERLAY(PACC75:*NEXT)
017800020606     D PAGP5                               OVERLAY(PACC75:*NEXT)
017900020606     D PAGP6                               OVERLAY(PACC75:*NEXT)
018000020606     D PAGP7                               OVERLAY(PACC75:*NEXT)
018100020606     D PAGP8                               OVERLAY(PACC75:*NEXT)
018200020606     D PAGP9                               OVERLAY(PACC75:*NEXT)
018300020606     D PAGP10                         5  0 OVERLAY(PACC75:*NEXT)
018400020606     D PAGP11                         5  0 OVERLAY(PACC75:*NEXT)
018500020606     D PAGP12                         5  0 OVERLAY(PACC75:*NEXT)
018600020606     D PAGP13                         5  0 OVERLAY(PACC75:*NEXT)
018700020606     D PAGP14                         5  0 OVERLAY(PACC75:*NEXT)
018800020606     D PAGP15                         5  0 OVERLAY(PACC75:*NEXT)
018900020606   X*
019000020606     D                 DS
019100020606     D PACK60                        60A   INZ('0000')
019200020606     D PKGP1                               OVERLAY(PACK60)
019300020606     D PKGP2                               OVERLAY(PACK60:*NEXT)
019400020606     D PKGP3                               OVERLAY(PACK60:*NEXT)
019500020606     D PKGP4                               OVERLAY(PACK60:*NEXT)
019600020606     D PKGP5                               OVERLAY(PACK60:*NEXT)
019700020606     D PKGP6                               OVERLAY(PACK60:*NEXT)
019800020606     D PKGP7                               OVERLAY(PACK60:*NEXT)
019900020606     D PKGP8                               OVERLAY(PACK60:*NEXT)
020000020606     D PKGP9                               OVERLAY(PACK60:*NEXT)
020100020606     D PKGP10                              OVERLAY(PACK60:*NEXT)
020200020606     D PKGP11                              OVERLAY(PACK60:*NEXT)
020300020606     D PKGP12                              OVERLAY(PACK60:*NEXT)
020400020606     D PKGP13                              OVERLAY(PACK60:*NEXT)
020500020606     D PKGP14                              OVERLAY(PACK60:*NEXT)
020600020606     D PKGP15                              OVERLAY(PACK60:*NEXT)
0207000205310143
0208009309270144 D                 DS
0209000206100145 D  COVTDT                        8  0 INZ(*ZEROS)
0210000206100146 D  COVMM                         2  0 OVERLAY(COVTDT)
0211000206100147 D  COVDD                         2  0 OVERLAY(COVTDT:*NEXT)
0212000206100148 D  COVYY                         4  0 OVERLAY(COVTDT:*NEXT)
0213009309270149 D                 DS
0214000206100150 D  CYMD                          8  0 INZ(*ZEROS)
0215000206100152 D  HCOVYY                        4  0 OVERLAY(CYMD)
0216000206100153 D  HCOVMM                        2  0 OVERLAY(CYMD:*NEXT)
0217000206100154 D  HCOVDD                        2  0 OVERLAY(CYMD:*NEXT)
0218009310250149 D                UDS
021900981130     D  UDSDAT                11     18  0
0220009310250152 D  UDSMM                 11     12  0
0221009310250153 D  UDSDD                 13     14  0
0222009811300153 D  UDSMD                 11     14  0
0223009811300154 D  UDSYY                 15     18  0
022400000502     D  SPC                   19     21
022500020808     D  PAGE_IN               30     30
022600030212     D  LEADR_IN              31     31
022700020604     D  PREFIX_U             198    198
022800020531     D  UD8YMD               248    255  0
022900020531     D  UD8Y                 248    251  0
023000020531     D  UD8MD                252    255  0
0231000206060149 D                 DS
0232000206070150 D TSA_CUR                       10  0
0233000206070152 D  RNTRST                             OVERLAY(TSA_CUR)
0234000206070153 D  RNSUB#                             OVERLAY(TSA_CUR:*NEXT)
0235000206070154 D  RNACC#                             OVERLAY(TSA_CUR:*NEXT)
023600020607   X*
0237000206030149 D                 DS
0238000206100150 D RATE_G                        16
0239000206100152 D  G_GRTRST                           OVERLAY(RATE_G)
0240000206100153 D  G_GRSUB#                           OVERLAY(RATE_G:*NEXT)
0241000206100154 D  RNPLAN_H                      4    OVERLAY(RATE_G:*NEXT)
0242000206100154 D  RNAGE                              OVERLAY(RATE_G:*NEXT)
0243000206100154 D  RNCOVTP                            OVERLAY(RATE_G:*NEXT)
024400020531
024500020605     C     *LOVAL        SETLL     RPP151R
024600020606     C                   DOU       %EOF(RPP151P)
024700020605     C                   READ      RPP151R
024800020606     C                   IF        NOT %EOF(RPP151P)
024900020606     C                   IF        ONE_TIME = *OFF
025000020606     C                   EVAL      ONE_TIME = *ON
025100020607     C                   EVAL      TSA_HOLD  = TSA_CUR
025200020612     C                   EVAL      RNPLAN_HD    = RNPLAN
025300020606     C                   END
025400020614
025500020612     C                   IF        RNPLAN_HD   <> RNPLAN
025600020606     C                   EXSR      L1_TOT_SR
025700020606     C                   END
025800020607     C                   IF        TSA_HOLD  <> TSA_CUR
025900020607     C                   EXSR      L2_TOT_SR
026000020607     C                   EVAL      TSA_HOLD   = TSA_CUR
026100020607     C                   END
026200020607
026300020531      *?IF SALESMAN IS EQUAL TO USER SELECTION, PROCESS.
026400020605
026500020606     C                   IF        SPC = RNSMCD OR
026600020605     C                             SPC = 'ALL'
026700020612     C                   IF        TSA_HOLD2 <> TSA_CUR
026800020612     C                   EVAL      TSA_HOLD2  = TSA_CUR
026900020612     C                   EVAL      RNTRST_HD = RNTRST
027000020612     C                   EVAL      RNSUB#_HD = RNSUB#
027100020612     C                   EVAL      RNACC#_H = RNACC#
027200020612     C                   Z-ADD     UMONTH        COVMM
027300020612     C                   Z-ADD     01            COVDD
027400020612     C                   Z-ADD     UD8Y          COVYY
027500020612
027600020612     C                   MOVE      '  '          STAFLG
027700020612     C     *NOKEY        CLEAR     *ALL          ACCMSR
027800020612     C     ACCMST_KEY    CHAIN     ACCMSR
027900020612     C                   IF        NOT %FOUND(ACCMST)
028000020612     C                   ITER
028100020612     C                   END
028200020612
028300020612      *?SMALL GROUP REFORM APPLIES ONLY TO MARYLAND EMPLOYERS
028400020612     C                   IF        A_ASTATE <> 'MD'
028500020612     C                   MOVE      'NO'          STAFLG
028600020612     C                   END
028700020612     C     *NOKEY        CLEAR     *ALL          SMANR
028800020612     C     A_SMANCD      CHAIN     SMANR
028900020612     C                   IF        NOT %FOUND(SMAN)
029000020612     C                   ITER
029100020612     C                   END
029200020829     C                   EVAL      *IN50 = *OFF
029300020829     C                   IF        A_AADDR2 <> *BLANKS
029400020829     C                   EVAL      *IN50 = *ON
029500020829     C                   END
029600020614
029700020614     C                   MOVE      *BLANKS       SMANNAME
029800020614     C                   MOVEL     S_SFNAME      SMANNAME
029900020614
030000020614     C                   CAT       S_SLNAME:1    SMANNAME
030100020614     C                   MOVE      *BLANKS       SMANADDR
030200020614     C                   MOVEL     S_SCITY       SMANADDR
030300020614
030400020614     C                   CAT       ',':0         SMANADDR
030500020614     C                   CAT       S_SSTATE:1    SMANADDR
030600020614     C                   MOVEL     S_SZIPCD      SZIP5
030700020614     C                   MOVE      S_SZIPCD      SZIP4
030800020614     C                   CAT       SZIP5:1       SMANADDR
030900020614     C                   IF        SZIP4 <> '0000'
031000020614     C                   CAT       '-':0         SMANADDR
031100020614     C                   CAT       SZIP4:0       SMANADDR
031200020614     C                   END
031300020614
031400020614     C                   IF        RNSMCD_HD <> RNSMCD AND
031500020614     C                             SPC    = 'ALL'
031600030212     C                   IF        LEADR <> '2'
031700040512
031800040513     C                   EXCEPT    LEADER
031900020905     C                   END
032000020614     C                   EVAL      RNSMCD_HD = RNSMCD
032100020614     C                   END
032200020612     C                   IF        A_ECNTAC <> *BLANKS
032300020612     C                   MOVEL     A_ECNTAC      CTAC
032400020612     C                   ELSE
032500020612     C                   MOVEL     A_CONTAC      CTAC
032600020612     C                   END
032700020612
032800020612      *?RETRIEVE FEDERAL TAX ID FROM ACCOUNT ADDITIONAL INFO FILE
032900020612
033000020612     C     *NOKEY        CLEAR     *ALL          ACCMSR2
033100020612     C     AC2MST_KEY    CHAIN     ACCMSR2
033200020612     C                   IF        %FOUND(AC2MST)
033300020612     C                   IF        A2TAX_ID# = *ZEROS
033400020612     C                   SETOFF                                       76
033500020612     C                   ELSE
033600020612     C                   SETON                                        76
033700020612     C                   END
033800020612     C                   ELSE
033900020612     C                   EVAL      A2TAX_ID# = *ZEROS
034000020612     C                   SETOFF                                       76
034100020612     C                   END
034200020612
034300020612     C                   END
034400020612
034500020612      *?SMALL GROUP REFORM APPLIES ONLY TO MARYLAND EMPLOYERS
034600020612
034700020612     C                   EVAL      RNPLAN_HD    = RNPLAN
034800020612     C                   EVAL      RNAGEB_H    = RNAGEB
034900020612     C                   IF        STAFLG = 'NO'
035000020612     C                   ITER
035100020612     C                   END
035200020612
035300020612     C                   IF        RNCANDT > 0 AND
035400020612     C                             RNCANDT <= UDSYMD
035500020612     C                   ELSE
035600020612
035700020612      *?ADD TO INDEMNITY COUNTER IF OLD PLAN IS BC/BS INDEMNITY
035800020612      *?ADD TO HMO COUNTER OTHERWISE
035900020612      *?THEN FIND CORRECT AGE BAND, AND ADD TO TOTAL EMPLOYEES
036000020612      *?IN EACH AGE BAND. WILL THEN APPLY FACTORS TO PREMIUM CALCULATION
036100020612      *?PROGRAM WK451 PLACED THE CORRECT AGE OF EMPLOYEE INTO THE
036200020612      *?AGEBND FIELD. EXCLUDE MED SUPP, PLAN# 0075.
036300020612
036400020612     C     *NOKEY        CLEAR     *ALL          PLNMSR
036500020612     C     PLNMST_KEY    CHAIN     PLNMSR
036600020612     C                   IF        %FOUND(PLNMST)
036700050518     C*****              IF        P_PLNCAT <> 'PMM'
036800050518     C*****              ITER
036900050518     C*****              END
037000020612     C                   IF        P_PCARR = 'BCM' OR
037100020612     C                             P_PCARR = 'BMS'
037200020612     C                   IF        RNCOVTP = 'TMI'
037300020612     C                   ADD       1             MEDSUP
037400020612     C                   ITER
037500020612     C                   END
037600020612     C                   ADD       1             IN_X
037700020612     C                   ELSE
037800020612     C                   IF        RNCOVTP = 'TMI' OR
037900020612     C                             RNCOVTP = 'TMH' OR
038000020612     C                             RNCOVTP = 'TMP' OR
038100020612     C                             RNCOVTP = 'TMF'
038200020612     C                   ADD       1             MEDSUH
038300020612     C                   ITER
038400020612     C                   END
038500020612
038600020612     C                   ADD       1             HM_X
038700020612     C                   END
038800020612
038900020612      *?ADD TOTAL AGES TO CALCULATE AGE BAND FOR AETNA RATES
039000020612
039100020612      *?NAGE IS USED FOR NLYCARE RATES. AGE FOR CURRENT YEAR ANYTIME.
039200020612     C                   ADD       RNAGE         TAGE
039300020612     C                   ADD       RNNAGE        TNAGE
039400020612     C                   ADD       RNMAGE        TMAGE
039500020612
039600020612     C                   IF        RNAGE > 99
039700020612     C                   EVAL      RNAGE = 99
039800020612     C                   END
039900020612     C                   Z-ADD     1             A_X
040000020612     C     RNAGE         LOOKUP    AB_A(A_X)                            3232
040100020612     C                   IF        *IN32 = *ON
040200020612     C                   IF        RNAGE <> AB_A(A_X)
040300020612     C                   ADD       1             A_X
040400020612     C                   END
040500020612     C                   IF        P_PCARR = 'BCM' OR
040600020612     C                             P_PCARR = 'BMS'
040700020612     C                   ADD       1             AGI(A_X)
040800020612     C                   ELSE
040900020612     C                   ADD       1             AGH(A_X)
041000020612     C                   END
041100020612     C                   END
041200020612
041300020612      *?AGE BANDS FOR PHN
041400020612     C                   Z-ADD     1             A_X
041500020612     C     RNAGE         LOOKUP    AM_A(A_X)                            3232
041600020612     C                   IF        *IN32 = *ON
041700020612     C                   IF        RNAGE <> AM_A(A_X)
041800020612     C                   ADD       1             A_X
041900020612     C                   END
042000020612     C                   ADD       1             AGP(A_X)
042100020612     C                   END
042200020612
042300020612     C                   Z-ADD     1             A_X
042400020612     C     RNMAGE        LOOKUP    MA_A(A_X)                            3535
042500020612     C                   IF        *IN35 = *ON
042600020612     C                   IF        RNMAGE <> MA_A(A_X)
042700020612     C                   ADD       1             A_X
042800020612     C                   END
042900020612     C                   END
043000020612
043100020612     C                   ADD       1             TPHLD
043200020612     C                   END
043300020612     C                   END
043400020606     C                   END
043500020606     C                   END
043600020606     C                   ENDDO
043700020607     C                   EXSR      L1_TOT_SR
043800020607     C                   EXSR      L2_TOT_SR
043900020531
044000020606     C                   EVAL      *INLR = *ON
044100020606      *?*****************************************************
044200020606
044300020606     C     L1_TOT_SR     BEGSR
044400050520     c     X_X           ifeq      15
044500050520     c                   z-add     0             X_X
044600050520     c                   endif
044700020612     C                   IF        RNPLAN_HD   <> '0075'
044800020606     C                   ADD       1             X_X
044900050520     c     X_X           ifeq      0
045000050520     c                   z-add     1             X_X
045100050520     c                   endif
045200020612     C                   MOVE      RNPLAN_HD     PL_A(X_X)
045300020612     C                   MOVE      RNAGEB_H      AG_A(X_X)
045400020606     C                   END
045500020606     C                   ENDSR
045600020606      *?*****************************************************************
045700020606     C     L2_TOT_SR     BEGSR
045800020531      *?GET COUNTY DESCRIPTION
045900020531
046000020606     C     *NOKEY        CLEAR     *ALL          COUNTYR
046100020610     C     COUNTY2KEY    CHAIN     COUNTYR
046200020531
046300020531      *?SMALL GROUP REFORM APPLIES ONLY TO MARYLAND EMPLOYERS
046400020606
046500020606      *?EXCLUDE EMPLOYERS WITH ONLY ONE EMPLOYEE AND EMPLOYERS
046600020606      *?WITH 50 OR MORE EMPLOYERS FOR SMALL GROUP REFORM
046700020531
046800020606     C                   IF        STAFLG = 'NO' OR
046900020606     C                             TPHLD < 1     OR
047000020606     C                             TPHLD >= 50
047100020606     C                   ELSE
047200020531
047300041109     C                   EVAL      AVGOUT = TAGE / TPHLD
047400020531
047500020531      *?SEND INPUT SCREEN TO OUTPUT TO VERIFY ENTRY
047600020606     C                   XFOOT     AGI           TAGI
047700020606     C                   XFOOT     AGH           TAGH
047800020808     C                   IF        PAGES <> '2'
047900020606     C                   EXCEPT    HEADR
048000020808     C                   END
048100020606     C                   EVAL      A2TAX_ID# = *ZEROS
048200020606     C                   EXCEPT    #SYN
048300020617     C                   EXCEPT    #SYN1
048400020610     C                   MOVE      'Y'           $R1
048500020610     C                   SETON                                        58
048600020612     C                   EVAL      RNTRST_H = RNTRST_HD
048700020612     C                   EVAL      RNSUB#_H = RNSUB#_HD
048800020610     C                   DO        15            Z_X
048900020610     C                   IF        PL_A(Z_X) <> '0000' AND
049000020610     C                             PL_A(Z_X) <> '    '
049100020610     C                   MOVE      PL_A(Z_X)     RNPLAN_H
049200020610     C                   Z-ADD     AG_A(Z_X)     AGE_P
049300020610     C                   EXSR      $GETP
049400040511     C                   EXCEPT    #CUR2
049500020617     C                   END
049600020610     C                   ENDDO
049700020610     C                   SETOFF                                       58
049800020606     C                   MOVE      ' '           $R1
049900020606     C                   Z-ADD     0             L2P
050000020606     C                   Z-ADD     UDSMM         COVMM
050100020606     C                   Z-ADD     UDSDD         COVDD
050200020606     C                   Z-ADD     UDSYY         COVYY
050300020610     C                   MOVE      '0001'        AP_PLAN
050400020617     C                   EVAL      A_ACTRST = 794
050500020617     C                   EVAL      A_ACSUB# = 001
050600040511     C****               EXCEPT    #SYN1B
050700020531      *?GET RENEWAL RATES FOR CURRENT PLANS
050800020610     C     APLNP2KEY     SETLL     APLNPR
050900020606     C                   DOU       %EOF(APLNP)
051000020610     C     ACCMST2KEY    READE     APLNPR
051100020606     C                   IF        NOT %EOF(APLNP)
051200020610     C                   MOVEA     ACP80         CP_A
051300020610     C                   MOVEA     CP_A          PA_A
051400020617     C                   DO        15            Z_X
051500020617     C                   IF        PA_A(Z_X) = '0000' OR
051600020617     C                             PA_A(Z_X) = '    '
051700020617     C                   ELSE
051800020617     C                   EXSR      PLNMST7SR
051900020617     C                   END
052000020617
052100020617     C                   ENDDO
052200020610     C                   MOVEA     L2P           MS_A
052300020606     C                   XFOOT     L2P           PRIND
052400020606     C                   IF        PRIND <> *ZEROS
052500040511     C*****              EXCEPT    #CUR3
052600020617     C                   END
052700020606     C                   IF        MSFLG = 'I'
052800020610     C                   Z-ADD     0             MS_A
052900020610     C                   Z-ADD     269.61        MS_A(1)
053000020606     C                   EXCEPT    #MS
053100020617     C                   END
053200020606     C                   IF        MSFLG = 'H'
053300020610     C                   EVAL      MS_A = MS_A - MS2
053400020808     C                   EVAL(H)   MS_A(1) = MS_A(1) * .80
053500020808     C                   EVAL(H)   MS_A(2) = MS_A(2) * .80
053600020808     C                   EVAL(H)   MS_A(3) = MS_A(3) * .80
053700020808     C                   EVAL(H)   MS_A(4) = MS_A(4) * .80
053800020610     C                   EVAL      MS_A = MS_A + MS2
053900020606     C                   EXCEPT    #MS
054000020617     C                   END
054100020606     C                   IF        MSFLG = *BLANKS
054200020606     C                   EXCEPT    #SPACE
054300020617     C                   END
054400020606     C                   MOVE      *BLANKS       MSFLG
054500020606     C                   END
054600020606     C                   ENDDO
054700040511     C************       EXCEPT    #DONE1
054800020808     C                   IF        PAGES = '2'
054900020808     C                   GOTO      PAG3TAG
055000020808     C                   END
055100020531
055200020531      *?RENEWAL RATES HELD IN TRUST 794 SUB-DIVISION 001
055300020531      *?FOR SMALL GROUP REFORM
055400040511     C********           EXCEPT    #SYN
055500040511     C********           EXCEPT    #L2D
055600040511     C********           EXCEPT    #NEWP
055700020606     C                   EXSR      $L2SUB
055800020808     C                   IF        PAGES = '3'
055900020808     C                   GOTO      PAG3TAG
056000020808     C                   END
056100040511     C*************      EXCEPT    #DONE
056200020617     C                   END
056300020606
056400020808     C     PAG3TAG       TAG
056500020606     C                   Z-ADD     0             X_X
056600020610     C                   MOVEA     *ZEROS        PL_A
056700020610     C                   MOVEA     *ZEROS        PA_A
056800020610     C                   Z-ADD     0             AG_A
056900020606     C                   Z-ADD     0             TPHLD
057000020606     C                   Z-ADD     0             TAGE
057100020606     C                   Z-ADD     0             TNAGE
057200020606     C                   Z-ADD     0             TMAGE
057300020606     C                   Z-ADD     0             IN_X
057400020606     C                   Z-ADD     0             HM_X
057500020610     C                   Z-ADD     0             IH_X
057600020606     C                   Z-ADD     0             AGI
057700020606     C                   Z-ADD     0             AGH
057800020606     C                   Z-ADD     0             AGP
057900020610     C                   Z-ADD     0             AT_A
058000020606     C                   Z-ADD     0             MS2
058100020606     C                   ENDSR
058200020531
058300020531      *?*****************************************************
058400930927     C     $GETP         BEGSR
0585000205310301  *?GET PLAN RECORD
0586000205310302
0587000206110303 C     PLNMST2KEY    CHAIN     PLNMSR
058800020610     C                   IF        %FOUND(PLNMST)
0589000206110304
059000020611     C                   DO        4             INDEX
059100020611     C                   SELECT
059200020611     C                   WHEN      INDEX = 1
059300020611     C                   MOVE      'TIN'         R2COVTP
059400020611     C                   WHEN      INDEX = 2
059500020611     C                   MOVE      'TPC'         R2COVTP
059600020611     C                   WHEN      INDEX = 3
059700020611     C                   MOVE      'THW'         R2COVTP
059800020611     C                   WHEN      INDEX = 4
059900020611     C                   MOVE      'TFA'         R2COVTP
060000020611     C                   ENDSL
060100020611     C                   EXSR      $PREM
060200020611     C                   ADD       PREM          PARY(INDEX)
060300020611     C                   IF        $R1 = 'Y' AND
060400020611     C                             INDEX = 1
060500020611     C                   IF        PARY(INDEX) = *ZEROS
060600020611     C                   MOVE      'TMI'         R2COVTP
060700020611     C                   EXSR      $PREM
060800020611     C                   ADD       PREM          PARY(INDEX)
060900020611     C                   END
061000020611     C                   END
061100020611     C                   ENDDO
061200020531
061300020611     C                   END
061400020531      *?TOTAL EACH PACKAGE 10/95
061500930928     C                   ENDSR
061600020531
061700020531      *?*****************************************************
061800020531
061900930928     C     $L2SUB        BEGSR
062000020605     C     *NOKEY        CLEAR     *ALL          PACCR
062100020607     C     PACCR_KEY     CHAIN     PACCR
062200020606     C                   MOVEA     PACC75        PP2
062300020610     C                   MOVE      PP2           PP_A
062400020610     C                   DO        15            YZ_X
062500020610     C                   IF        PP_A(YZ_X) = *ZEROS
062600020606     C                   ELSE
062700020531      *?WRITE OUT PREVIOUS TOTALS, SKIP 1ST CYCLE
062800020617     C                   IF        YZ_X > 1
062900020610     C                   MOVEA     L2P           MS_A
063000040511     C****               EXCEPT    #CUR3
063100020606     C                   IF        MSFLG = 'I'
063200020610     C                   Z-ADD     0             MS_A
063300020531      *?MED.SUPP. LITERAL RATE !!!!!!!!
063400020610     C                   Z-ADD     269.61        MS_A(1)
063500951025     C                   EXCEPT    #MS
063600020606     C                   END
063700020606     C                   IF        MSFLG = 'H'
063800020808     C                   EVAL(H)   MS_A(1) = MS_A(1) * .80
063900020808     C                   EVAL(H)   MS_A(2) = MS_A(2) * .80
064000020808     C                   EVAL(H)   MS_A(3) = MS_A(3) * .80
064100020808     C                   EVAL(H)   MS_A(4) = MS_A(4) * .80
064200951025     C                   EXCEPT    #MS
064300020606     C                   END
064400951025     C                   MOVE      *BLANKS       MSFLG
064500020606     C                   END
064600020808     C                   IF        YZ_X = 3  AND
064700020808     C                             PAGES = '2'
064800020808     C                   LEAVESR
064900020808     C                   END
065000020611     C                   IF        YZ_X = 4 OR
065100020611     C                             YZ_X = 7
065200020808     C                   IF        PAGES = '3'
065300020808     C                   LEAVESR
065400020808     C                   END
065500040511     C*************      EXCEPT    #DONE1
065600040511     C********           EXCEPT    #SYN
065700040511     C********           EXCEPT    #L2D
065800040511     C********           EXCEPT    #NEWP
065900020606     C                   END
066000020610     C                   MOVEA     *ZEROS        PA_A
066100020605     C     *NOKEY        CLEAR     *ALL          PACKR
066200020610     C     PP_A(YZ_X)    CHAIN     PACKR
066300020606     C                   IF        NOT %FOUND(PACKAG)
066400020605     C                   MOVEL     'ERROR   '    CNAME
066500020605     C                   ELSE
066600020605     C                   MOVEL     PKGDSC        CNAME
066700020606     C                   END
066800020610     C                   MOVEA     PACK60        PA_A
066900040511     C***************    EXCEPT    #CARR
067000020617     C                   DO        15            Z_X
067100020617     C                   IF        PA_A(Z_X) = '0000' OR
067200020617     C                             PA_A(Z_X) = '    '
067300020617     C                   ELSE
067400020617     C                   EXSR      PLNMST7SR
067500020617     C                   END
067600020617
067700020617     C                   ENDDO
067800020606     C                   END
067900020606
068000020606     C                   ENDDO
068100020606
068200040511     C*****              EXCEPT    #CUR3
068300020606     C                   IF        MSFLG = 'I'
068400020610     C                   Z-ADD     0             MS_A
068500020531      *?MED.SUPP. LITERAL RATE !!!!!!!!
068600020610     C                   Z-ADD     269.61        MS_A(1)
068700951102     C                   EXCEPT    #MS
068800951102     C                   END
068900020606     C                   IF        MSFLG = 'H'
069000020610     C                   EVAL      MS_A = MS_A - MS2
069100020808     C                   EVAL(H)   MS_A(1) = MS_A(1) * .80
069200020808     C                   EVAL(H)   MS_A(2) = MS_A(2) * .80
069300020808     C                   EVAL(H)   MS_A(3) = MS_A(3) * .80
069400020808     C                   EVAL(H)   MS_A(4) = MS_A(4) * .80
069500020610     C                   EVAL      MS_A = MS_A + MS2
069600951102     C                   EXCEPT    #MS
069700951102     C                   END
069800951102     C                   MOVE      *BLANKS       MSFLG
069900930928     C                   ENDSR
070000020531
070100020611      *?*****************************************************
070200020611     C     PLNMST7SR     BEGSR
070300020617     C                   EVAL      RNTRST_H = 794
070400020617     C                   EVAL      RNSUB#_H = 001
070500020617     C                   MOVE      PA_A(Z_X)     RNPLAN_H
070600020617     C     *NOKEY        CLEAR     *ALL          PLNMSR
070700020617     C     PLNMST2KEY    CHAIN     PLNMSR
070800020617     C                   IF        %FOUND(PLNMST)
070900020617     C                   EXSR      RATES_SR
071000020617     C                   END
071100020611     C                   ENDSR
071200020610      *?*****************************************************
071300020610     C     RATES_SR      BEGSR
071400020610     C                   SELECT
071500020610     C                   WHEN      P_PCARR = 'BCM'
071600020610     C                   EXSR      $RAT2
071700020610     C                   MOVE      'I'           MSFLG
071800020610
071900020610     C                   WHEN      P_PCARR = 'CFS'
072000020610     C                   EXSR      $RAT2
072100020610     C                   MOVE      'H'           MSFLG
072200020610
072300020610     C                   WHEN      P_PCARR = 'PHN'
072400020610     C                   EXSR      $RAT2P
072500020610
072600020610     C                   WHEN      P_PCARR = 'BCS' OR
072700020610      *?(VSP IS A BC/BS VISION RIDER TO BC/BS MEDICAL)
072800020610     C                             P_PCARR = 'VSP' OR
072900020610     C                             P_PCARR = 'HMD' OR
073000020610     C                             P_PCARR = 'HMV' OR
073100020610     C                             P_PCARR = 'FSD' OR
073200020610     C                             P_PCARR = 'FSV'
073300020610     C                   EXSR      $RAT2D
073400020610
073500020610      *?FOR BC/BS TESTS, UNCOMMENT NEXT LINES
073600020610     C                   WHEN      P_PCARR = 'AET' OR
073700020610     C                             P_PCARR = 'AHT' OR
073800020610     C                             P_PCARR = 'AIH' OR
073900020610     C                             P_PCARR = 'AIM'
074000020610     C                   EXSR      $RAT3
074100020610
074200020610     C                   WHEN      P_PCARR = 'KP '
074300020610     C                   EXSR      $RAT4
074400020610
074500020610     C                   WHEN      P_PCARR = 'PRN'
074600020610     C                   EXSR      $RAT5
074700020610
074800020610      *?GET JUST DENTAL AND COBRA RATES
074900020610
075000020610     C                   WHEN      P_PCARR = 'JD ' OR
075100020610     C                             P_PCARR = 'CDC' OR
075200020610     C                             P_PCARR = 'AS '
075300020610     C                   EXSR      $RAT7
075400020610
075500020610     C                   WHEN      P_PCARR = 'HP '
075600020610     C                   EXSR      $RAT8
075700020610
075800020610     C                   WHEN      P_PCARR = 'MF '
075900020610     C                   EXSR      $RAT9
076000020610
076100020610     C                   WHEN      P_PCARR = 'USH'
076200020610     C                   EXSR      $RAT10
076300020610
076400020610     C                   WHEN      P_PCARR = 'CHP'
076500020610     C                   EXSR      $RAT11
076600020610
076700020610     C                   WHEN      P_PCARR = 'CBC'
076800020610     C                   EXSR      $RATBC
076900020610
077000020610     C                   ENDSL
077100020610     C                   ENDSR
077200020531      *?*****************************************************
077300930928     C     $RAT2         BEGSR
077400020531
077500020531      *?LIST BC/BS INDEMNITY PLANS, PRINT CARRIER
077600020531      *?CALCULATE RATE FACTORS
077700951023     C                   MOVE      *BLANKS       CNAME
077800020531
077900020606     C                   IF        P_PCARR = 'CFS'
078000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
078100020607     C                   Z-ADD     0             AGE_P
078200020606     C                   EXSR      $GETP
078300020606     C                   EXSR      #HMOF
078400020610     C                   MOVEA     PARY          PH_A
078500020606
078600020606     C                   DO        4             S_X
078700020606     C                   EVAL(H)   PARY(S_X) = PARY(S_X) * FACTO2
078800020606      *?NO GEOGRAPHICAL FACTOR FOR HMO RATES
078900020606
079000020606     C                   EXSR      #LIMT
079100020606     C                   ENDDO
079200020606
079300020606      *?SKIP TO NEW PAGE BUT DON'T PRINT HEADINGS ON OVERFLOW
079400020606
079500020606     C   OF              EXCEPT    NEWPAG
079600020606     C                   EVAL      L2P = L2P + PARY
079700040511     C****               EXCEPT    #CUR2
079800020606
079900020606     C                   ELSE
080000020531
080100020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
080200020607     C                   Z-ADD     0             AGE_P
080300940623     C                   EXSR      $GETP
080400940623     C                   EXSR      #INDF
080500020610     C                   MOVEA     PARY          PH_A
080600940623     C                   EXSR      #GEO
080700020606     C                   DO        4             S_X
080800020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACT) * F_X
080900940623     C                   EXSR      #LIMT
081000020606     C                   ENDDO
081100020606     C                   EVAL      L2P = L2P + PARY
081200040511     C****               EXCEPT    #CUR2
081300020531
081400020531      *?LIST HMO INDEMNITY PLANS, PRINT CARRIER
081500020531      *?CALCULATE RATE FACTORS
081600020531
081700020606     C                   END
081800020531
081900930928     C                   ENDSR
082000020531      *?*****************************************************
082100970908     C     $RAT2P        BEGSR
082200020531
082300020607     C     A_ACONTY      LOOKUP    PHNE                                   63
082400020606     C                   IF        *IN63 = *OFF
082500020531      *?LIST PHN PLANS, PRINT CARRIER
082600020531      *?CALCULATE RATE FACTORS
082700970908     C                   MOVE      *BLANKS       CNAME
082800020531
082900020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
083000020607     C                   Z-ADD     0             AGE_P
083100970908     C                   EXSR      $GETP
083200970908     C                   EXSR      #INDFP
083300020610     C                   MOVEA     PARY          PH_A
083400970908     C                   EXSR      #GEOP
083500020531     C                   DO        4             S_X
083600020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACTP) * F_X
083700970908     C                   EXSR      #LIMT
083800020606     C                   ENDDO
083900020606     C                   EVAL      L2P = L2P + PARY
084000040511     C****               EXCEPT    #CUR2
084100020531
084200020606     C                   END
084300970908     C                   ENDSR
084400020531
084500020531      *?*****************************************************
084600950622     C     $RAT2D        BEGSR
084700020531
084800020531      *?LIST BC/BS DENTAL AND VISION PLANS...PRINT DENTAL/VISION CARR.
084900020531      *?CALCULATE RATE FACTORS
085000020531      *?LIST BOTH HMO AND INDEMNITY DENTAL AND VISION PLANS
085100020531
085200951023     C                   MOVE      *BLANKS       CNAME
085300020531
085400020531      *?LIST HMO VISION AND DENTAL PLANS
085500020531      *?THERE ARE NO FACTORS TO APPLY..STRAIGHT RATES
085600020531
085700020606     C                   IF        P_PCARR = 'VSP'  OR
085800020606     C                             P_PCARR = 'FSD'  OR
085900020606     C                             P_PCARR = 'BCS'  OR
086000020606     C                             P_PCARR = 'FSV'
086100020606
086200020606      *?FREESTANDING DENTAL PLANS FOR BC/BS
086300020606
086400020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
086500020607     C                   Z-ADD     0             AGE_P
086600020606     C                   EXSR      $GETP
086700020610     C                   MOVEA     PARY          PH_A
086800020606     C                   EXSR      #GEO
086900020606     C                   DO        4             S_X
087000020606     C                   EVAL(H)   PARY(S_X) = PARY(S_X) * F_X
087100020606     C                   EXSR      #LIMT
087200020606     C                   ENDDO
087300020606     C                   EVAL      L2P = L2P + PARY
087400040511     C****               EXCEPT    #CUR2
087500020606
087600020606     C                   ELSE
087700020531
087800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
087900020607     C                   Z-ADD     0             AGE_P
088000950623     C                   EXSR      $GETP
088100020531
088200020606     C                   EVAL      L2P = L2P + PARY
088300020606     C                   EVAL      MS2 = MS2 + PARY
088400040511     C****               EXCEPT    #CUR2
088500020531
088600020606     C                   END
088700020531
088800950622     C                   ENDSR
088900020531      *?*****************************************************
089000020531
089100020531      *?AETNA RATES
089200020531      *?LIST AETNA INDEMNITY PLANS, PRINT CARRIER
089300020531      *?CALCULATE RATE FACTORS, AGE BAND
089400020531
089500940630     C     $RAT3         BEGSR
089600951023     C                   MOVE      *BLANKS       CNAME
089700020531
089800020531     C                   Z-ADD     0             AAGE
089900020607     C                   Z-ADD     0             AGE_P
090000020531
090100020531      *?GET GEOGRAPHICAL FACTOR FOR INDEMNITY
090200020531
090300950616     C                   EXSR      #GEO3
090400020531
090500020531      *?AETNA INDEMNITY           *
090600020531
090700020531      *?GEOGRAPHICAL AREA BALTIMORE
090800020531
090900020531     C                   Z-ADD     0             PARY
091000951026     C                   Z-ADD     0             L2P
091100020606     C                   IF        P_PCARR = 'AET'
091200020531
091300020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
091400950616     C                   EXSR      $GETP
091500950616     C                   EXSR      #INDF3
091600020610     C                   MOVEA     PARY          PH_A
091700020606     C                   DO        4             S_X
091800020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACTOR) * F_X
091900020531      *?IF NO COUNTY RATING EXISTS, PRINT ZEROES
092000020606     C                   IF        PARY(S_X) <> *ZEROS
092100950616     C                   EXSR      #LIMT2
092200020606     C                   END
092300020606     C                   ENDDO
092400020606     C                   EVAL      L2P = L2P + PARY
092500040511     C****               EXCEPT    #CUR2
092600020606     C                   END
092700020531
092800020531      *?NOW PRINT AETNA HMO RATES *
092900020531
093000020531
093100020606     C                   IF        P_PCARR = 'AHT'
093200950616     C                   EXSR      #GEO4
093300020531      *?HMO BALTIMORE RATES
093400020531
093500020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
093600950616     C                   EXSR      $GETP
093700950616     C                   EXSR      #INDF3
093800020610     C                   MOVEA     PARY          PH_A
093900020531     C                   DO        4             S_X
094000020808     C                   EVAL(H)   PARY(S_X) = (PARY(S_X) * FACTOR) * F_X
094100020531      *?IF NO COUNTY RATING EXISTS, PRINT ZEROES
094200020606     C                   IF        PARY(S_X) <> *ZEROS
094300950616     C                   EXSR      #LIMT2
094400950619     C                   END
094500020606     C                   ENDDO
094600020606     C                   EVAL      L2P = L2P + PARY
094700040511     C****               EXCEPT    #CUR2
094800991116     C                   END
094900020531
095000951024     C                   ENDSR
095100020531      *?********************************
095200941021     C     $RAT5         BEGSR
095300020531
095400020531      *?CALCULATE AVERAGE AGE
095500020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
095600020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
095700020531      *?FIELD "J" WILL CONTAIN AGE BAND
095800020531
095900041109     C                   EVAL      AAGE = TAGE / TPHLD
096000020531
096100020531     C                   Z-ADD     1             J_X
096200020610     C     AAGE          LOOKUP    AB2_A(J_X)                           2222
096300020606     C                   IF        *IN22 = *ON AND
096400020610     C                             AAGE = AB2_A(J_X)
096500020606     C                   EVAL      J_X = J_X - 1
096600941021     C                   END
096700020531
096800020607     C                   EVAL      AGE_P = J_X
096900020531
097000020531      *?GET GEOGRAPHICAL FACTOR
097100020531
097200941021     C                   EXSR      #GEO2
097300020531
097400020531      *?ONLY PRINT CARRIER NAME IF COUNTY IS AVAILABLE
097500020531
097600020531      *?IF PRINCIPAL NOT OFFERED FOR THIS GEOGRAPHICAL AREA
097700020531      *?SKIP PRINTING OF THE RATES
097800020531
097900020606     C                   IF        K_X = *ZEROS
098000020606     C                   ELSE
098100020531
098200020531      *?PRINCIPAL 2 TIER          *
098300020531
098400020531      *?GEOGRAPHICAL AREA BALTIMORE
098500020531
098600020606     C                   SELECT
098700020606     C                   WHEN      K_X = 1
098800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
098900941021     C                   EXSR      $GETP
099000020610     C                   MOVEA     PARY          PH_A
099100020606     C                   EVAL      L2P = L2P + PARY
099200040511     C****               EXCEPT    #CUR2
099300020531
099400020531      *?GEOGRAPHICAL AREA D.C.
099500020606     C                   WHEN      K_X = 2
099600020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
099700941021     C                   EXSR      $GETP
099800020610     C                   MOVEA     PARY          PH_A
099900020606     C                   EVAL      L2P = L2P + PARY
100000040511     C****               EXCEPT    #CUR2
100100020531
100200020531      *?GEOGRAPHICAL AREA OTHER
100300020606     C                   WHEN      K_X = 3
100400020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
100500950308     C                   EXSR      $GETP
100600020610     C                   MOVEA     PARY          PH_A
100700020606     C                   EVAL      L2P = L2P + PARY
100800040511     C****               EXCEPT    #CUR2
100900020606     C                   ENDSL
101000020531
101100020606     C                   END
101200941021     C                   ENDSR
101300020531
101400020531      *?KAISER HEALTH PLANS
101500950308     C     $RAT4         BEGSR
101600020531
101700020531      *?CALCULATE AVERAGE AGE
101800020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
101900020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
102000020531      *?FIELD "J" WILL CONTAIN AGE BAND
102100020531
102200041109     C                   EVAL      AAGE = TAGE / TPHLD
102300020531
102400020531     C                   Z-ADD     1             J_X
102500020610     C     AAGE          LOOKUP    AK_A(J_X)                            2222
102600020606     C                   IF        *IN22 = *ON  AND
102700020610     C                             AAGE = AK_A(J_X)
102800020606     C                   EVAL      J_X = J_X - 1
102900020606     C                   END
103000020531
103100020607     C                   EVAL      AGE_P = J_X
103200020531
103300020531      *?ONLY PRINT CARRIER NAME IF COUNTY IS AVAILABLE
103400020531
103500020531      *?IF KAISER NOT OFFERED FOR THIS GEOGRAPHICAL AREA
103600020531      *?SKIP PRINTING OF THE RATES
103700020531
103800020531      *?KAISER BALTIMORE          *
103900020531
104000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
104100950308     C                   EXSR      $GETP
104200020610     C                   MOVEA     PARY          PH_A
104300020606     C                   EVAL      L2P = L2P + PARY
104400040511     C****               EXCEPT    #CUR2
104500020531
104600950308     C                   ENDSR
104700020531      *?*****************************************************
104800960811     C     $RAT8         BEGSR
104900020531
105000020531      *?CALCULATE AVERAGE AGE
105100020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
105200020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
105300020531      *?FIELD "J" WILL CONTAIN AGE BAND
105400020531
105500041109     C                   EVAL      ANAGE = TNAGE / TPHLD
105600020531
105700020531     C                   Z-ADD     1             J_X
105800020610     C     ANAGE         LOOKUP    AB_A(J_X)                            2222
105900020606     C                   IF        *IN22 = *ON AND
106000020610     C                             ANAGE = AB_A(J_X)
106100020606     C                   EVAL      J_X = J_X - 1
106200960811     C                   END
106300020531
106400020607     C                   EVAL      AGE_P = J_X
106500020531
106600020531      *?NYLCARE                   *
106700020531
106800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
106900960811     C                   EXSR      $GETP
107000020610     C                   MOVEA     PARY          PH_A
107100020606     C                   EVAL      L2P = L2P + PARY
107200040511     C****               EXCEPT    #CUR2
107300020531
107400960811     C                   ENDSR
107500020531      *?********************************
107600020531
107700960811     C     $RAT9         BEGSR
107800020531
107900020531      *?MARYLAND FIDELITY         *
108000020531
108100020610     C                   EVAL      IH_X  = IN_X + HM_X
108200020531
108300020531      *?CALCULATE AVERAGE AGE
108400020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
108500020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
108600020531      *?FIELD "J" WILL CONTAIN AGE BAND
108700020531
108800041109     C                   EVAL      AMAGE = TMAGE / TPHLD
108900020531
109000020531     C                   Z-ADD     1             J_X
109100020610     C     AMAGE         LOOKUP    MA_A(J_X)                            2222
109200020606     C                   IF        *IN22 = *ON AND
109300020610     C                             AMAGE = MA_A(J_X)
109400020606     C                   EVAL      J_X = J_X - 1
109500980406     C                   END
109600020531
109700020607     C                   EVAL      AGE_P = J_X
109800020531
109900020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
110000961211     C                   EXSR      $GETP
110100020610     C                   MOVEA     PARY          PH_A
110200020606     C                   EVAL      L2P = L2P + PARY
110300040511     C****               EXCEPT    #CUR2
110400020531
110500960811     C                   ENDSR
110600020531      *?*****************************************************
110700961118     C     $RAT10        BEGSR
110800020531      *?U.S. HEALTHCARE
110900020531
111000020531      *?CALCULATE AVERAGE AGE. ATTAINED AGE THIS YEAR
111100020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
111200020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
111300020531      *?FIELD "J" WILL CONTAIN AGE BAND
111400020531
111500041109     C                   EVAL      ANAGE = TNAGE / TPHLD
111600020531
111700020531     C                   Z-ADD     1             J_X
111800020610     C     ANAGE         LOOKUP    AB_A(J_X)                            2222
111900020606     C                   IF        *IN22 = *ON AND
112000020610     C                             ANAGE = AB_A(J_X)
112100020606     C                   EVAL      J_X = J_X - 1
112200961118     C                   END
112300020531
112400020607     C                   EVAL      AGE_P = J_X
112500020531
112600020531      *?U.S. HEALTHCARE           *
112700020531
112800020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
112900961118     C                   EXSR      $GETP
113000020610     C                   MOVEA     PARY          PH_A
113100020606     C                   EVAL      L2P = L2P + PARY
113200040511     C****               EXCEPT    #CUR2
113300020531
113400961118     C                   ENDSR
113500020531      *?********************************
113600961118     C     $RAT11        BEGSR
113700020531      *?UNITED HEALTH CARE
113800020531
113900020531      *?CALCULATE AVERAGE AGE
114000020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
114100020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
114200020531      *?FIELD "J" WILL CONTAIN AGE BAND
114300020531
114400041109     C                   EVAL      AAGE = TAGE / TPHLD
114500020531
114600020531     C                   Z-ADD     1             J_X
114700020610     C     AAGE          LOOKUP    AB_A(J_X)                            2222
114800020606     C                   IF        *IN22 = *ON AND
114900020610     C                             AAGE = AB_A(J_X)
115000020606     C                   EVAL      J_X = J_X - 1
115100961118     C                   END
115200020531
115300020607     C                   EVAL      AGE_P = J_X
115400020531
115500020531      *?UNITED HEALTH CARE        *
115600020531
115700020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
115800961118     C                   EXSR      $GETP
115900020610     C                   MOVEA     PARY          PH_A
116000020606     C                   EVAL      L2P = L2P + PARY
116100040511     C****               EXCEPT    #CUR2
116200020606
116300961118     C                   ENDSR
116400020531      *?*****************************************************
116500011108     C     $RATBC        BEGSR
116600020531      *?BLUE CHOICE HMO
116700020531
116800020531      *?CALCULATE AVERAGE AGE
116900020531      *?ONCE AVG. AGE IS DETERMINED, LOOKUP ARRAY AB TO DETERMINE
117000020531      *?AGE BAND (IE. 01,02,ETC.) FOR CAPTURING PLANS AND RATES.
117100020531      *?FIELD "J" WILL CONTAIN AGE BAND
117200020531
117300011108     C                   EXSR      #GEO5
117400020606     C                   IF        BCFLG <> 'YES'
117500020606     C                   ELSE
117600020531
117700041109     C                   EVAL      AAGE = TAGE / TPHLD
117800020531
117900020531     C                   Z-ADD     1             J_X
118000020610     C     AAGE          LOOKUP    A4_A(J_X)                            2222
118100020606     C                   IF        *IN22 = *ON AND
118200020610     C                             AAGE = A4_A(J_X)
118300020606     C                   EVAL      J_X = J_X - 1
118400011108     C                   END
118500020531
118600020607     C                   EVAL      AGE_P = J_X
118700020531
118800020531      *?BLUE CHOICE HMO           *
118900020531
119000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
119100011108     C                   EXSR      $GETP
119200020610     C                   MOVEA     PARY          PH_A
119300020606     C                   EVAL      L2P = L2P + PARY
119400040511     C****               EXCEPT    #CUR2
119500020531
119600020606     C                   END
119700011108     C                   ENDSR
119800020531      *?*****************************************************
119900020531      *?JUST DENTAL/COBRA PLANS
120000950810     C     $RAT7         BEGSR
120100020531      *?JUST DENTAL
120200020606     C                   IF        P_PCARR = 'AS '
120300020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
120400020606     C                   EXSR      $GETP
120500020610     C                   MOVEA     PARY          PH_A
120600020606     C                   EVAL      L2P = L2P + PARY
120700040511     C****               EXCEPT    #CUR2
120800020606
120900020606     C                   ELSE
121000020610     C                   MOVE      PA_A(Z_X)     RNPLAN_H
121100950810     C                   EXSR      $GETP
121200020610     C                   MOVEA     PARY          PH_A
121300020606     C                   EVAL      L2P = L2P + PARY
121400040511     C****               EXCEPT    #CUR2
121500020531
121600020606     C                   END
121700950810     C                   ENDSR
121800020531      *?*****************************************************
121900020531
122000940623     C     #INDF         BEGSR
122100020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
122200020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
122300020531      *?ELSE USE HMO AGES
122400020531
122500020610     C                   Z-ADD     0             AT_A
122600950713     C                   Z-ADD     0             FACT
122700020531
122800020606     C                   IF        IN_X <> *ZEROS
122900020610     C                   DO        10            YY_X
123000020610     C                   IF        AGI(YY_X) <> *ZEROS
123100020808     C                   EVAL(H)   AT_A(YY_X) = AGI(YY_X) * AFI(YY_X)
123200940623     C                   END
123300020606     C                   ENDDO
123400020610     C                   XFOOT     AT_A          ATOT
123500020606     C                   EVAL(H)   FACT = ATOT / IN_X
123600940623     C                   END
123700020531
123800020531      *?NO INDEMNITY EMPLOYEES, USE HMO AGES
123900020531
124000020606     C                   IF        IN_X = *ZEROS
124100020610     C                   DO        10            YY_X
124200020610     C                   IF        AGH(YY_X) <> *ZEROS
124300020808     C                   EVAL(H)   AT_A(YY_X) = AGH(YY_X) * AFI(YY_X)
124400940623     C                   END
124500020606     C                   ENDDO
124600020610     C                   XFOOT     AT_A          ATOT
124700020606     C                   EVAL(H)   FACT = ATOT / HM_X
124800940623     C                   END
124900020531
125000940623     C                   ENDSR
125100020531      *?***************************************************************
125200020531
125300970908     C     #INDFP        BEGSR
125400020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
125500020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
125600020531
125700020610     C                   Z-ADD     0             AT_A
125800970908     C                   Z-ADD     0             ATP
125900970908     C                   Z-ADD     0             FACT
126000970908     C                   Z-ADD     0             ATOT
126100970917     C                   Z-ADD     0             INH
126200020606     C                   EVAL      INH = IN_X + HM_X
126300020610     C                   DO        15            YY_X
126400020610     C                   IF        AGP(YY_X) <> *ZEROS
126500020808     C                   EVAL(H)   ATP(YY_X) = AGP(YY_X) * AIP(YY_X)
126600970908     C                   END
126700020606     C                   ENDDO
126800020531     C                   XFOOT     ATP           ATOTP
126900020606     C                   EVAL(H)   FACTP = ATOTP / INH
127000970908     C                   ENDSR
127100020531      *?***************************************************************
127200020531
127300020531      *?AETNA AGE FACTORS
127400020531
127500950612     C     #INDF3        BEGSR
127600020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
127700020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
127800020531      *?ELSE USE HMO AGES
127900020531
128000020610     C                   Z-ADD     0             AT_A
128100950612     C                   Z-ADD     0             FACTOR
128200020531
128300020606     C                   IF        IN_X <> *ZEROS
128400020610     C                   DO        10            YY_X
128500020610     C                   IF        AGI(YY_X) <> *ZEROS
128600020808     C                   EVAL(H)   AT_A(YY_X) = AGI(YY_X) * AAF(YY_X)
128700950612     C                   END
128800020606     C                   ENDDO
128900020610     C                   XFOOT     AT_A          ATOT
129000020606     C                   EVAL(H)   FACTOR = ATOT / IN_X
129100950612     C                   END
129200020531
129300020531      *?NO INDEMNITY EMPLOYEES, USE HMO AGES
129400020531
129500020606     C                   IF        IN_X = *ZEROS
129600020610     C                   DO        10            YY_X
129700020610     C                   IF        AGH(YY_X) <> *ZEROS
129800020808     C                   EVAL(H)   AT_A(YY_X) = AGH(YY_X) * AAF(YY_X)
129900950612     C                   END
130000020606     C                   ENDDO
130100020610     C                   XFOOT     AT_A          ATOT
130200020606     C                   EVAL(H)   FACTOR = ATOT / HM_X
130300950612     C                   END
130400020531
130500950612     C                   ENDSR
130600020531      *?***************************************************************
130700940623     C     #HMOF         BEGSR
130800020531      *?CALCULATE AGE FACTOR FOR INDEMNITY
130900020531      *?USE INDEMNITY AGE IF SOME EMPLOYEES HAVE INDEMNITY
131000020531      *?ELSE USE HMO AGES
131100020531
131200020610     C                   Z-ADD     0             AT_A
131300940624     C                   Z-ADD     0             FACTO2
131400020531
131500020606     C                   IF        HM_X = *ZEROS
131600020610     C                   DO        10            YY_X
131700020610     C                   IF        AGI(YY_X) <> *ZEROS
131800020808     C                   EVAL(H)   AT_A(YY_X) = AGI(YY_X) * AFH(YY_X)
131900940623     C                   END
132000020606     C                   ENDDO
132100020610     C                   XFOOT     AT_A          ATOT
132200020606     C                   EVAL(H)   FACTO2 = ATOT / IN_X
132300940623     C                   END
132400020531
132500020531      *?NO INDEMNITY EMPLOYEES, USE HMO AGES
132600020531
132700020606     C                   IF        HM_X <> *ZEROS
132800020610     C                   DO        10            YY_X
132900020610     C                   IF        AGH(YY_X) <> *ZEROS
133000020808     C                   EVAL(H)   AT_A(YY_X) = AGH(YY_X) * AFH(YY_X)
133100940623     C                   END
133200020606     C                   ENDDO
133300020610     C                   XFOOT     AT_A          ATOT
133400020606     C                   EVAL(H)   FACTO2 = ATOT / HM_X
133500940623     C                   END
133600020531
133700940623     C                   ENDSR
133800020531      *?***************************************************************
133900940623     C     #GEO          BEGSR
134000020531      *?ESTABLISH GEOGRAPHICAL FACTOR
134100020531
134200020531     C                   Z-ADD     0             F_X
134300020531     C                   Z-ADD     0             K_X
134400020531
134500020607     C     A_ACONTY      LOOKUP    CG1                                    63
134600020606     C                   IF        *IN63 = *ON
134700020610     C                   Z-ADD     GF_A(1)       F_X
134800020606     C                   Z-ADD     1             K_X
134900020606     C                   ELSE
135000020531
135100020607     C     A_ACONTY      LOOKUP    CG2                                    63
135200020606     C                   IF        *IN63 = *ON
135300020610     C                   Z-ADD     GF_A(2)       F_X
135400020606     C                   Z-ADD     2             K_X
135500020606     C                   ELSE
135600020531
135700020607     C     A_ACONTY      LOOKUP    CG3                                    63
135800020606     C                   IF        *IN63 = *ON
135900020610     C                   Z-ADD     GF_A(3)       F_X
136000020606     C                   Z-ADD     3             K_X
136100020606     C                   ELSE
136200020531
136300020607     C     A_ACONTY      LOOKUP    CG4                                    63
136400020606     C                   IF        *IN63 = *ON
136500020610     C                   Z-ADD     GF_A(4)       F_X
136600020606     C                   Z-ADD     4             K_X
136700020606     C                   ELSE
136800020531
136900951025     C                   EXCEPT    ERROR
137000020606     C                   END
137100020606     C                   END
137200020606     C                   END
137300020606     C                   END
137400020531
137500940623     C                   ENDSR
137600020531      *?*****************************************************
137700970908     C     #GEOP         BEGSR
137800020531      *?ESTABLISH GEOGRAPHICAL FACTOR
137900020531
138000020531     C                   Z-ADD     0             F_X
138100020531     C                   Z-ADD     0             K_X
138200020531
138300020531     C     A_ACONTY      LOOKUP    CG1                                    63
138400020606     C                   IF        *IN63 = *ON
138500020606     C                   Z-ADD     GFP(1)        F_X
138600020606     C                   Z-ADD     1             K_X
138700020606     C                   ELSE
138800020531
138900020531     C     A_ACONTY      LOOKUP    CG2                                    63
139000020606     C                   IF        *IN63 = *ON
139100020606     C                   Z-ADD     GFP(2)        F_X
139200020606     C                   Z-ADD     2             K_X
139300020606     C                   ELSE
139400020531
139500020531     C     A_ACONTY      LOOKUP    CG3                                    63
139600020606     C                   IF        *IN63 = *ON
139700020606     C                   Z-ADD     GFP(3)        F_X
139800020606     C                   Z-ADD     3             K_X
139900020606     C                   ELSE
140000020531
140100020531     C     A_ACONTY      LOOKUP    CG4                                    63
140200020606     C                   IF        *IN63 = *ON
140300020606     C                   Z-ADD     GFP(4)        F_X
140400020606     C                   Z-ADD     4             K_X
140500020606     C                   ELSE
140600020531
140700970908     C                   EXCEPT    ERROR
140800020606     C                   END
140900020606     C                   END
141000020606     C                   END
141100020606     C                   END
141200020531
141300970908     C                   ENDSR
141400020531      *?*****************************************************
141500941021     C     #GEO2         BEGSR
141600020531      *?ESTABLISH GEOGRAPHICAL FACTOR FOR PRINCIPAL
141700020531
141800020531     C                   Z-ADD     0             F_X
141900020531     C                   Z-ADD     0             K_X
142000020531
142100020531     C     A_ACONTY      LOOKUP    CG5                                    63
142200020606     C                   IF        *IN63 = *ON
142300020610     C                   Z-ADD     GF_A(1)       F_X
142400020606     C                   Z-ADD     1             K_X
142500020606     C                   ELSE
142600020531
142700020531     C     A_ACONTY      LOOKUP    C14                                    63
142800020606     C                   IF        *IN63 = *ON
142900020610     C                   Z-ADD     GF_A(3)       F_X
143000020606     C                   Z-ADD     3             K_X
143100020606     C                   ELSE
143200020531
143300020531      *?NO ERROR FOR PRINCIPAL NO FIND OF COUNTY. NOT OFFERED
143400020531      *?IN MANY LOCATIONS.
143500020531
143600941021     C                   EXCEPT    ERROR
143700020606     C                   END
143800020606     C                   END
143900020531
144000941021     C                   ENDSR
144100020531      *?*****************************************************
144200950308     C     #GEO3         BEGSR
144300020531      *?ESTABLISH GEOGRAPHICAL FACTOR FOR AETNA INDEMNITY
144400020531
144500020531     C                   Z-ADD     0             F_X
144600020531     C                   Z-ADD     0             K_X
144700020531
144800020531     C     A_ACONTY      LOOKUP    CG7                                    63
144900020606     C                   IF        *IN63 = *ON
145000020606     C                   Z-ADD     GO3(1)        F_X
145100020606     C                   Z-ADD     1             K_X
145200020606     C                   ELSE
145300020531
145400020531     C     A_ACONTY      LOOKUP    CG8                                    63
145500020606     C                   IF        *IN63 = *ON
145600020606     C                   Z-ADD     GO3(2)        F_X
145700020606     C                   Z-ADD     2             K_X
145800020606     C                   ELSE
145900020531
146000020531     C     A_ACONTY      LOOKUP    CG9                                    63
146100020606     C                   IF        *IN63 = *ON
146200020606     C                   Z-ADD     GO3(3)        F_X
146300020606     C                   Z-ADD     3             K_X
146400020606     C                   ELSE
146500020531
146600020531     C     A_ACONTY      LOOKUP    C10                                    63
146700020606     C                   IF        *IN63 = *ON
146800020606     C                   Z-ADD     GO3(3)        F_X
146900020606     C                   Z-ADD     4             K_X
147000020606     C                   ELSE
147100020531
147200020531     C     A_ACONTY      LOOKUP    C11                                    63
147300020606     C                   IF        *IN63 = *ON
147400020606     C                   Z-ADD     GO3(4)        F_X
147500020606     C                   Z-ADD     5             K_X
147600020606     C                   ELSE
147700020531
147800950308     C                   EXCEPT    ERROR
147900020606     C                   END
148000020606     C                   END
148100020606     C                   END
148200020606     C                   END
148300020606     C                   END
148400020531
148500950308     C                   ENDSR
148600020531      *?*****************************************************
148700950308     C     #GEO4         BEGSR
148800020531      *?ESTABLISH GEOGRAPHICAL FACTOR FOR AETNA HMO'S
148900020531
149000020531     C                   Z-ADD     0             F_X
149100020531     C                   Z-ADD     0             K_X
149200020531
149300020531     C     A_ACONTY      LOOKUP    C12                                    63
149400020605     C                   IF        *IN63 = *ON
149500020605     C                   Z-ADD     GO4(1)        F_X
149600020605     C                   Z-ADD     1             K_X
149700020606     C                   ELSE
149800020531
149900020531     C     A_ACONTY      LOOKUP    C13                                    63
150000020605     C                   IF        *IN63 = *ON
150100020605     C                   Z-ADD     GO4(2)        F_X
150200020605     C                   Z-ADD     2             K_X
150300020605     C                   END
150400020531
150500020606     C                   END
150600950308     C                   ENDSR
150700020531      *?*****************************************************
150800011108     C     #GEO5         BEGSR
150900020531      *?ESTABLISH GEOGRAPHICAL AVAILABILITY FOR BLUE CHOICE PRODUCTS
151000020531
151100020531     C                   MOVE      *BLANKS       BCFLG
151200020531
151300020531     C     A_ACONTY      LOOKUP    C20                                    63
151400020605     C                   IF        *IN63 = *ON
151500020605     C                   MOVE      'YES'         BCFLG
151600020605     C                   END
151700020531
151800011108     C                   ENDSR
151900020531      *?*****************************************************
152000940623     C     #LIMT         BEGSR
152100020531      *?CHECK FOR EXCEEDING 150 % OF BASE PREMIUM
152200020531      *?OR FOR BELOW 50 % OF BASE PREMIUM
152300020531
152400020808     C                   EVAL(H)   LHLD = PH_A(S_X) * .60
152500020808     C                   EVAL(H)   HHLD = PH_A(S_X) * 1.40
152600020531
152700020606     C                   IF        PARY(S_X) < LHLD
152800020606     C                   EVAL      PARY(S_X) = LHLD
152900940623     C                   END
153000020606     C                   IF        PARY(S_X) > HHLD
153100020606     C                   EVAL      PARY(S_X) = HHLD
153200940623     C                   END
153300020531
153400940623     C                   ENDSR
153500020531      *?*****************************************************
153600940701     C     #LIMT2        BEGSR
153700020531      *?CHECK FOR EXCEEDING 150 % OF BASE PREMIUM
153800020531      *?OR FOR BELOW 50 % OF BASE PREMIUM
153900020531
154000020531     C                   DO        4             L_X
154100020808     C                   EVAL(H)   LHLD = PH_A(L_X) * .60
154200020808     C                   EVAL(H)   HHLD = PH_A(L_X) * 1.40
154300020531
154400020606     C                   IF        PARY(L_X) < LHLD
154500020606     C                   EVAL      PARY(L_X) = LHLD
154600940701     C                   END
154700020606     C                   IF        PARY(L_X) > HHLD
154800020606     C                   EVAL      PARY(L_X) = HHLD
154900940701     C                   END
155000020531
155100020606     C                   ENDDO
155200940701     C                   ENDSR
155300020531      *?*****************************************************
1554009309270283 C     $PREM         BEGSR
1555000205310285  *? CALCULATE PREMIUM BASED ON ACTIVE PLANS AND CURRENT RATES
1556000205310286  *? CALCULATE AGE AND AGE BAND IF AGE BANDED
1557000205310287
1558000205310288  *?ZERO OUT PREMIUM
1559000205310289
1560009309270290 C                   MOVE      *ZEROS        PREM
1561009309270331 C                   Z-ADD     COVYY         HCOVYY
1562009309270332 C                   Z-ADD     COVMM         HCOVMM
1563009309270333 C                   Z-ADD     COVDD         HCOVDD
1564000205310339
1565009309270341 C                   Z-ADD     *ZEROS        GCOUNT
156600020612     C                   EVAL      G_GRTRST = A_ACTRST
156700020612     C                   EVAL      G_GRSUB# = A_ACSUB#
156800020607     C                   EVAL      RNAGE_2 = AGE_P
1569000206070342 C     GRATE2KEY     SETLL     GRATE
1570000205310343
157100020603     C                   DOU       %EOF(GRATE)
1572000206070346 C     GRATE2KEY     READE     GRATER
157300020603     C                   IF        NOT %EOF(GRATE)
1574000206060350 C                   IF        CYMD >= G_FRMDAT
1575000206060350 C                   IF        CYMD <= G_TODAT
157600020606     C                   EVAL      GCOUNT = GCOUNT + 1
1577000206030353 C                   LEAVE
1578009309270354 C                   END
1579009309270355 C                   END
1580000206030357 C                   END
1581000206030359 C                   ENDDO
1582000205310360
1583000206060361 C                   IF        GCOUNT = *ZEROS
158400020606     C                   EVAL      PREM = *ZEROS
158500020606     C                   ELSE
1586000205310364
1587000205310368  *?ACCUMULATE PREMIUM IF PLAN RATE TYPE IS PREMIUM
1588000205310369
1589000206060370 C                   IF        P_PRTYPE = 'P'
159000020606     C                   EVAL      PREM = PREM + G_BILRTE
1591009309270372 C                   END
1592000206060363 C                   END
1593000205310373
1594009309270382 C                   ENDSR
1595000205310383
159600020531 385  *?**************************************************************
159700020531
159800020531     C     *INZSR        BEGSR
159900020606     C     PACCR_KEY     KLIST
160000020611     C                   KFLD                    TSA_HOLD
160100020606     C     ACCMST_KEY    KLIST
160200020606     C                   KFLD                    RNTRST
160300020604     C                   KFLD                    RNSUB#
160400020604     C                   KFLD                    RNACC#
160500020531     C     PLNMST_KEY    KLIST
160600020604     C                   KFLD                    RNTRST
160700020604     C                   KFLD                    RNSUB#
160800020607     C                   KFLD                    RNPLAN
160900020610
161000020531     C     AC2MST_KEY    KLIST
161100020531     C                   KFLD                    PREFIX_U
161200020604     C                   KFLD                    RNTRST
161300020604     C                   KFLD                    RNSUB#
161400020604     C                   KFLD                    RNACC#
161500020607     C     ACCMST2KEY    KLIST
161600020612     C                   KFLD                    RNTRST_HD
161700020612     C                   KFLD                    RNSUB#_HD
161800020612     C                   KFLD                    RNACC#_H
161900020607     C     PLNMST2KEY    KLIST
162000020607     C                   KFLD                    RNTRST_H
162100020607     C                   KFLD                    RNSUB#_H
162200020607     C                   KFLD                    RNPLAN_H
162300020607
162400020607     C     GRATE2KEY     KLIST
162500020612     C                   KFLD                    A_ACTRST
162600020612     C                   KFLD                    A_ACSUB#
162700020607     C                   KFLD                    RNPLAN_H
162800020607     C                   KFLD                    RNAGE_2
162900020607     C                   KFLD                    R2COVTP
163000020607     C     APLNP2KEY     KLIST
163100020612     C                   KFLD                    RNTRST_HD
163200020612     C                   KFLD                    RNSUB#_HD
163300020612     C                   KFLD                    RNACC#_H
163400020610     C                   KFLD                    AP_PLAN
163500020607     C     COUNTY2KEY    KLIST
163600020607     C                   KFLD                    A_ASTATE
163700020607     C                   KFLD                    A_ACONTY
163800020605
163900020605      *?SHOW WHICH, IF ANY, SALESPERSON CODE WAS SELECTED ON THE REPORT
164000020605
164100020606     C                   IF        SPC = *BLANKS
164200020605     C                   MOVEL     'ALL'         SPC
164300020605     C                   END
164400020605     C                   MOVEL     UDSYY         UDSYMD
164500020605     C                   MOVE      UDSMD         UDSYMD
164600020611     C     *NOKEY        CLEAR     *ALL          PROMSR
164700020611     C     'CMP'         CHAIN     PROMSR
164800020808     C                   EVAL      PAGES = PAGE_IN
164900030212     C                   EVAL      LEADR = LEADR_IN
165000020531
1651000205310382 C                   ENDSR
165200020627     ORPP010P   E            #SYN             04
165300940624     O                                           55 'B E N E F I T  &  R A T'
165400940624     O                                           78 ' E  C O M P A R I S O N'
165500940624     O          E            #SYN           1
165600940624     O                                           55 'B E N E F I T  &  R A T'
165700940624     O                                           78 ' E  C O M P A R I S O N'
165800940624     O          E            #SYN           1
165900940624     O                                           55 '-- Prepared by Group Be'
166000940624     O                                           78 'nefit Services, Inc. --'
166100931001     O          E            #SYN           1
166200930929     O                                           14 'Account Name:'
166300020531     O                       A_ACNAM1            55
166400951030     O                                           70 'Acct.#:'
166500020611     O                       TSA_HOLD            83 '   -   -    '
166600951030     O                                           94 'Eff.Date:'
166700981130     O                       UDSDAT             107 '  /  /    '
166800951025     O          E            #SYN           1
166900930929     O                                           24 '________________________'
167000930928     O                                           48 '________________________'
167100930928     O                                           72 '________________________'
167200930929     O                                           96 '________________________'
167300930929     O                                          120 '________________________'
167400951025     O          E            #SYN1          2
167500951025     O                                           24 '________________________'
167600951025     O                                           48 '_____ C U R R E N T  B E'
167700951025     O                                           72 ' N E F I T  P L A N S  A'
167800951025     O                                           96 ' N D  R A T E S ________'
167900951025     O                                          120 '________________________'
168000941021     O          E            #SYN1          1
168100951025     O                                           22 'CURRENT BENEFIT PLANS'
168200950919     O                                           50 'GROUP#'
168300940624     O                                           74 'IND'
168400940624     O                                           84 'P&C'
168500940624     O                                           98 'H&W'
168600940624     O                                          109 'FAM'
168700941021     O          E            #SYN1          1
168800951025     O                                           24 '------------------------'
168900951025     O                                           48 '------------------------'
169000951025     O                                           72 '------------------------'
169100951025     O                                           96 '------------------------'
169200951025     O                                          120 '------------------------'
169300040511     O****      E            #SYN1B      1  2 20
169400040511     O****                                       24 '________________________'
169500040511     O****                                       48 ' R E N E W A L  R A T E '
169600040511     O****                                       72 'S ______________________'
169700040511     O****                                       96 '________________________'
169800040511     O****                                      120 '________________________'
169900040511     O****      E            #SYN1B         1
170000040511     O****                                       14 'BENEFIT PLANS'
170100040511     O****                                       74 'IND'
170200040511     O****                                       84 'P&C'
170300040511     O****                                       98 'H&W'
170400040511     O****                                      109 'FAM'
170500040511     O****      E            #SYN1B         1
170600040511     O****                                       24 '------------------------'
170700040511     O****                                       48 '------------------------'
170800040511     O****                                       72 '------------------------'
170900951025     O                                           96 '------------------------'
171000951025     O                                          120 '------------------------'
171100040511     O******    E            #NEWP          1
171200040511     O****                                       74 'IND'
171300040511     O****                                       84 'P&C'
171400040511     O****                                       98 'H&W'
171500040511     O****                                      109 'FAM'
171600040511     O          E            #CUR2          1
171700040511     O                       P_PDESCR       B    40
171800040511     O               58      G_GROUP#            60
171900040511     O                       PARY(1)       2B    75
172000040511     O                       PARY(2)       2B    85
172100040511     O                       PARY(3)       2B    99
172200040511     O                       PARY(4)       2B   110
172300040511     O          E            #SPACE         1
172400040511     O                                            1 ' '
172500040511     O****      E            #CUR3          1
172600040511     O****                                       75 '-------'
172700040511     O****                                       85 '-------'
172800040511     O****                                       99 '-------'
172900040511     O****                                      110 '-------'
173000040511     O****      E            #CUR3          1
173100040511     O****                                       35 'TOTAL RATES:'
173200040511     O****                                       45 '(____)  '
173300040511     O****                   L2P(1)        1B    75
173400040511     O****                   L2P(2)        1B    85
173500040511     O****                   L2P(3)        1B    99
173600040511     O****                   L2P(4)        1B   110
173700951026     O          E            #MS            2
173800020409     O                                              ' '
173900940705     O          E            NEWPAG         1 02
174000940705     O                                              ' '
174100040511     O****      E            #L2D           1
174200040511     O****                                       24 '         S M A L L  G R '
174300040511     O****                                       48 'O U P  R E F O R M  A L '
174400040511     O****                                       72 'T E R N A T I V E  B E N'
174500040511     O****                                       96 ' E F I T  P L A N S  A N'
174600040511     O****                                      120 ' D  R A T E S           '
174700040511     O****      E            #L2D           1
174800040511     O****                                       24 '________________________'
174900040511     O****                                       48 '________________________'
175000040511     O****                                       72 '________________________'
175100040511     O****                                       96 '________________________'
175200040511     O****                                      120 '________________________'
175300040511     O****      E            #CARR       1  2
175400040511     O****                   CNAME               60
175500040511     O****      E            #DONE1         1 60
175600040511     O****                                       24 '........................'
175700040511     O****                                       48 '........................'
175800040511     O****                                       72 '........................'
175900040511     O****                                       96 '........................'
176000040511     O****                                      120 '........................'
176100040511     O****      E            #DONE1         1
176200040511     O****                                       44 'I CERTIFY MY ELECTION OF'
176300040511     O****                                       68 ' THE BENEFIT PLAN AND RA'
176400040511     O****                                       92 'TES(S) SELECTED ABOVE.  '
176500040511     O****      E            #DONE1      1  2
176600040511     O****                                       44 'ACCEPTED BY COMPANY OFFI'
176700040511     O****                                       68 'CIAL:___________________'
176800040511     O****                                       92 '________________________'
176900040511     O****                                      120 'DATE:___________________'
177000020531      *?PRINT ON LAST PAGE
177100040511     O****      E            #DONE          1 54
177200040511     O****                                       44 'I CERTIFY MY ELECTION OF'
177300040511     O****                                       68 ' THE BENEFIT PLAN AND RA'
177400040511     O****                                       92 'TES(S) SELECTED ABOVE.  '
177500040511     O****      E            #DONE       1  2
177600040511     O****                                       44 'ACCEPTED BY COMPANY OFFI'
177700040511     O****                                       68 'CIAL:___________________'
177800040511     O****                                       92 '________________________'
177900040511     O****                                      120 'DATE:___________________'
178000040511     O****      E            #DONE          1
178100040511     O****                                       24 '* Rates based upon'
178200040511     O****                   TPHLD         Z     27
178300040511     O****                                       52 'employees with Medical C'
178400040511     O****                                       76 'overage, excluding Medic'
178500040511     O****                                      100 'are Supplement enrollees'
178600040511     O****                                      101 '.'
178700040511     O****      E            #DONE          1
178800040511     O****                                       24 '________________________'
178900040511     O****                                       48 '________________________'
179000040511     O****                                       72 '________________________'
179100040511     O****                                       96 '________________________'
179200040511     O****                                      120 '________________________'
179300040511     O****      E            #DONE          1
179400040511     O****                   PMMONE             120
179500040511     O****      E            #DONE          1
179600040511     O****                   PMMTWO             120
179700040511     O****      E            #DONE          1
179800040511     O****                   PMMTHREE           120
179900040511     O****      E            #DONE          1
180000040511     O****                   A_ACNAM1           111
180100020531      *?* PRINT OUT FOR DATA ENTERED ON INPUT SCREEN
180200971209     O          E            HEADR          3 03
180300971210     O                                           65 '        RENEWAL  NOTIFIC'
180400971210     O                                           72 'ATION  '
180500971209     O          E            HEADR          1
180600971209     O                                           31 'GBS ACCOUNT NUMBER:'
180700020611     O                       TSA_HOLD            45 '   -   -    '
180800971209     O                                          110 'RATE/BENEFIT CHANGE ____'
180900971209     O          E            HEADR          1
181000971209     O                                           31 'EFFECTIVE DATE    :'
181100981130     O                       UDSDAT              43 '  /  /    '
181200971209     O                                          110 'RATE CHANGE ONLY    ____'
181300971209     O          E            HEADR          3
181400971209     O                                           31 'DATE PREPARED     :'
181500981130     O                       UD8MD               38 '  /  '
181600981130     O                                           39 '/'
181700981130     O                       UD8Y                43
181800971209     O                                          110 '    (GBS USE ONLY)      '
181900971209     O          E            HEADR          1
182000971209     O                                           25 ' '
182100951025     O          E            HEADR          1
182200951025     O                                           25 'COMPANY NAME:'
182300020531     O                       A_ACNAM1            68
182400951025     O          E            HEADR          1
182500951025     O                                           25 'CONTACT NAME:'
182600020531     O                       A_ECNTAC            58
182700951025     O          E            HEADR          1
182800971209     O                                           25 'ADDRESS     :'
182900020531     O                       A_AADDR1            58
183000020829     O          E    50      HEADR          1
183100020829     O                                           25 '            :'
183200020829     O                       A_AADDR2            58
183300971209     O          E            HEADR          2
183400971209     O                                           25 'CITY/STATE  :'
183500020531     O                       A_ACITY             43
183600020531     O                       A_ASTATE            46
183700020531     O                       A_AZIP              57 '     -    '
183800020830     O          E   N50      HEADR          1
183900971210     O                                          103 ' '
184000940921     O          E            HEADR          1
184100940921     O                                           19 'COUNTY:'
184200020531     O                       A_ACONTY            22
184300001205     O                                           24 '-'
184400001205     O                       CNDESC              45
184500020624     O                                           97 'BROKER :'
184600020624     O                       S_SMANCD           101
184700940921     O          E            HEADR          1
184800940921     O                                           19 'PHONE: '
184900020531     O                       A_AAREA             23
185000940921     O                                           24 '-'
185100020531     O                       A_APHONE            33 '   -    '
185200020614     O                       SMANNAME           120
185300940921     O          E            HEADR          1
185400020614     O                       S_SADDR            120
185500940921     O          E            HEADR          1
185600940921     O                                           20 'AVG.AGE:'
185700941025     O                       AVGOUT        Z     24
185800020614     O                       SMANADDR           120
185900040512
186000040513     O          E            LEADER         1 13
186100040513     O                       SMANNAME            43
186200040513     O          E            LEADER         1
186300040513     O                       S_SADDR             43
186400040513     O          E            LEADER         1
186500040513     O                       SMANADDR            43
186600040512
186700940921     O          E            HEADR          1
186800940921     O                                           27 'INDEMNITY:'
186900971210     O                                          101 '('
187000020531     O                       S_SAREA            104
187100971210     O                                          105 ')'
187200971210     O                                          106 ' '
187300020531     O                       S_SPHONE           113 '   -    '
187400940921     O          E            HEADR          1
187500940921     O                                           20 '<30:'
187600941021     O                       AGI(2)        Z     24
187700940921     O                                           35 '30 - 34:'
187800941021     O                       AGI(3)        Z     39
187900940921     O                                           50 '35 - 39:'
188000941021     O                       AGI(4)        Z     54
188100940921     O          E            HEADR          1
188200940921     O                                           20 '40 -44:'
188300941021     O                       AGI(5)        Z     24
188400940921     O                                           35 '45 - 49:'
188500941021     O                       AGI(6)        Z     39
188600940921     O                                           50 '50 - 54:'
188700941021     O                       AGI(7)        Z     54
188800940921     O          E            HEADR          1
188900940921     O                                           20 '55 -59:'
189000941021     O                       AGI(8)        Z     24
189100940921     O                                           35 '60 - 64:'
189200941021     O                       AGI(9)        Z     39
189300940921     O                                           50 '65+:    '
189400941021     O                       AGI(10)       Z     54
189500951031     O                                           72 'MED.SUPP:'
189600951025     O                       MEDSUP        ZB    80
189700951025     O                                          110 'TOTAL INDEMNITY:'
189800951025     O                       TAGI          Z    115
189900940921     O          E            HEADR          1
190000940921     O                                           20 'HMO:'
190100940921     O          E            HEADR          1
190200940921     O                                           20 '<30:'
190300941021     O                       AGH(2)        Z     24
190400940921     O                                           35 '30 - 34:'
190500941021     O                       AGH(3)        Z     39
190600940921     O                                           50 '35 - 39:'
190700941021     O                       AGH(4)        Z     54
190800940921     O          E            HEADR          1
190900940921     O                                           20 '40 -44:'
191000941021     O                       AGH(5)        Z     24
191100940921     O                                           35 '45 - 49:'
191200941021     O                       AGH(6)        Z     39
191300940921     O                                           50 '50 - 54:'
191400941021     O                       AGH(7)        Z     54
191500940921     O          E            HEADR          1
191600940921     O                                           20 '55 -59:'
191700941021     O                       AGH(8)        Z     24
191800940921     O                                           35 '60 - 64:'
191900941021     O                       AGH(9)        Z     39
192000940921     O                                           50 '65+:    '
192100941021     O                       AGH(10)       Z     54
192200951031     O                                           72 'MED.SUPP:'
192300951025     O                       MEDSUH        ZB    80
192400951025     O                                          110 'TOTAL H.M.O.:'
192500951025     O                       TAGH          Z    115
192600950919     O          E            HEADR          2
192700950922     O                                           24 '________________________'
192800950922     O                                           48 '________________________'
192900950922     O                                           72 '________________________'
193000950922     O                                           96 '________________________'
193100950922     O                                          120 '________________________'
193200990607     O          E            HEADR          1
193300020422     O                                           34 '1) Is the Company offeri'
193400020422     O                                           58 'ng coverage for part tim'
193500020422     O                                           82 'e employees?   _______ Y'
193600020422     O                                          106 'es      _______ No      '
193700990607     O          E            HEADR          1
193800020422     O                                           34 '2) Is the Company offeri'
193900020422     O                                           58 'ng coverage to retirees?'
194000020422     O                                           82 '               _______ Y'
194100020422     O                                          106 'es      _______ No      '
194200020422     O          E            HEADR          1
194300020422     O                                           34 '3) Is the Company offeri'
194400020422     O                                           58 'ng coverage to those emp'
194500020422     O                                           82 'loyees with other Insura'
194600020422     O                                          106 'nce?    _______ Yes     '
194700020422     O                                          116 '_______ No '
194800020430     O          E            HEADR          2
194900020422     O                                           34 'If answer is "Yes" for q'
195000020422     O                                           58 'uestion #2, answer MUST '
195100020422     O                                           82 'be "Yes" for question #3'
195200020422     O                                           83 '.'
195300961103     O          E            HEADR          1
195400951025     O                                           34 'Rates for quoted benefit'
195500951025     O                                           58 's are for the effective '
195600951025     O                                           82 'date as shown above and '
195700951025     O                                          106 'are guaranteed through a'
195800951025     O                                          120 ' period of no '
195900970116     O          E            HEADR          2
196000971210     O                                           34 'longer than 12 months. F'
196100971210     O                                           58 'INAL RATES MAY DIFFER FR'
196200971210     O                                           82 'OM THIS FORM BY PENNIES.'
196300961103     O          E            HEADR          1
196400961105     O                                           24 'Please sign and return t'
196500961105     O                                           48 'his rate proposal. Your '
196600961105     O                                           72 'signature will indicate '
196700961105     O                                           96 'your acceptance of these'
196800961105     O                                          120 ' benefits and rates.    '
196900961103     O          E            HEADR          1
197000961105     O                                           24 'For renewing business, i'
197100961105     O                                           48 'f a signed acceptance is'
197200971210     O                                           72 ' not returned by the car'
197300971210     O                                           96 'rier submission deadline'
197400971210     O                                          120 ', the benefits and      '
197500961103     O          E            HEADR          1
197600961105     O                                           24 'renewal rates presented '
197700961105     O                                           48 'on the original renewal '
197800961105     O                                           72 'package will apply as of'
197900961105     O                                           96 ' the effective date note'
198000961103     O                                          120 'd. Payment of premium   '
198100961103     O          E            HEADR          2
198200961105     O                                           24 'will constitute acceptan'
198300961105     O                                           48 'ce of the rates and bene'
198400961105     O                                           72 'fits quoted.            '
198500961105     O          E            HEADR          2
198600961105     O                                           24 'Early renewal of an exis'
198700961105     O                                           48 'ting account will result'
198800961105     O                                           72 ' in new deductibles and '
198900971210     O                                           96 'maximums, when applied, '
199000971210     O                                          120 'for each subscriber.    '
199100950919     O          E            HEADR          1
199200971210     O                                           24 'The carrier reserves the'
199300971210     O                                           48 ' right to revise or with'
199400971210     O                                           72 'draw the rates quoted in'
199500971210     O                                           96 ' this proposal or to can'
199600971210     O                                          120 'cel the proposal alto-  '
199700950919     O          E            HEADR          1
199800971210     O                                           24 'gether in the event the '
199900971210     O                                           48 'carrier determines that '
200000971210     O                                           72 'the account is not eligi'
200100971210     O                                           96 'ble for the coverage cho'
200200971210     O                                          120 'sen or that any derived '
200300950919     O          E            HEADR          1
200400971210     O                                           24 'calculations are found t'
200500971210     O                                           48 'o be inaccurate, or the '
200600971210     O                                           72 'census is incorrect and '
200700971210     O                                           96 'causes a material change'
200800971210     O                                          120 'in the rates quoted. The'
200900950919     O          E            HEADR          1
201000971210     O                                           24 'account will be promptly'
201100971210     O                                           48 ' notified in the event t'
201200971210     O                                           72 'he carrier chooses to ex'
201300971210     O                                           96 'ercise such right. The a'
201400971210     O                                          120 'ccount will not be bound'
201500950919     O          E            HEADR          1
201600971210     O                                           24 'by such new or revised r'
201700971210     O                                           48 'ates and no contract wil'
201800971210     O                                           72 'l be established unless '
201900971210     O                                           96 'the account is presented'
202000971210     O                                          120 ' with and accepts a new '
202100950919     O          E            HEADR          1
202200971210     O                                           24 'proposal documenting the'
202300971210     O                                           48 ' new or revised rates.  '
202400950919     O          E            HEADR       1  1
202500020409     O                                           24 'Date:  _________________'
202600020409     O                                           46 '______________________'
202700020409     O                                           73 'Accepted by:      ______'
202800020409     O                                           97 '________________________'
202900020409     O                                          111 '________________________'
203000950919     O          E            HEADR       1  1
203100020409     O                                           73 'Print Name:       ______'
203200020409     O                                           97 '________________________'
203300020409     O                                          111 '________________________'
203400950919     O          E            HEADR          1
203500950919     O                                           24 'Preferred Risk Code:  20'
203600950919     O          E            HEADR          1
203700951025     O                                           24 'Actuarial Class Code: 03'
203800020409     O                                           73 'Company Name:     ______'
203900020409     O                                           97 '________________________'
204000020409     O                                          111 '________________________'
204100950919     O          E            HEADR          1
204200950922     O                                           24 'Rating Method Code:   02'
204300951031     O          E            HEADR          1
204400020430     O              N76                          73 'Federal Tax ID#:  ______'
204500020430     O              N76                          97 '________________________'
204600020430     O              N76                         111 '________________________'
204700020603     O               76                          65 'Federal Tax ID#:'
204800020604     O               76      A2TAX_ID#     Z     77
204900020603     O               76                          87 '_________'
205000020603     O               76                         111 '________________________'
205100020830     O          E            HEADR       1  3
205200951031     O                                           53 'THIS PAGE MUST BE SIGNED'
205300951031     O                                           77 ' IN ADDITION TO ANY OTHE'
205400951031     O                                          101 'R SELECTION PAGE OF THIS'
205500951031     O                                          111 ' PROPOSAL.'
205600930930     O          E            ERROR          2
205700950317     O                                           24 'RATE DATA STRUCTURE  :'
205800020531     O                       A_ACONTY            35
205900020610     O                       RATE_G              45
206000931001     O                       PREM                66
206100020607     O                       AGE_P               86
206200981130     O                       CYMD                97
206300020531     O                       G_FRMDAT           108
206400020531     O                       G_TODAT            120
206500020610** AGE BANDS FOR SMALL GROUP REFORM AB
206600020604001
206700020604029
206800020604034
206900020604039
207000020604044
207100020604049
207200020604054
207300020604059
207400020604064
207500020604099
207600020610** AGE BANDS FOR SMALL GROUP REFORM(PRINCIPAL) AB2
207700020604001
207800020604024
207900020604029
208000020604034
208100020604039
208200020604044
208300020604049
208400020604054
208500020604059
208600020604064
208700020604099
208800020610** AGE BANDS FOR PHN   AM_A
208900020604001
209000020604015
209100020604019
209200020604024
209300020604029
209400020604034
209500020604039
209600020604044
209700020604049
209800020604054
209900020604059
210000020604064
210100020604069
210200020604074
210300020604099
210400020610** AGE BANDS FOR BLUE CHOICE 11/2001   A4
210500020604001
210600020604030
210700020604032
210800020604035
210900020604038
211000020604041
211100020604044
211200020604047
211300020604050
211400020604053
211500020604056
211600020604059
211700020604099
211800020610** AGE FACTORS INDEMNITY FOR SMALL GROUP REFORM  AFI
211900940630063
212000940623063
212100940623069
212200940623079
212300940623102
212400940623108
212500940623135
212600940623179
212700940623220
212800940623315
212900020610** AGE FACTORS FOR PHN  AIP
2130009709080630
2131009709080630
2132009709080630
2133009709080630
2134009709080630
2135009709080700
2136009709080800
2137009709081030
2138009709081100
2139009709081350
2140009709081760
2141009709082100
2142009709082600
2143009709082600
2144009709082600
214500020610** AGE FACTORS HMO PLANS FOR SMALL GROUP REFORM  AFH
2146009406300825
2147009406230825
2148009406230905
2149009406230905
2150009406230965
2151009406230965
2152009406231300
2153009406231300
2154009611181650
2155009611181650
215600020610** GEOGRAPHICAL FACTORS FOR SGR  GF
215700010928100
215800010928104
215900010928090
216000010928093
216100020610** COUNTY CODES FOR BALTIMORE METRO AREA    CG1
216200940623AA
216300940623BA
216400940623HA
216500940623HO
216600020610** COUNTY CODES FOR WASHINGTON METRO AREA  CG2
216700940623MO
216800940623PG
216900020610** COUNTY CODES FOR WESTERN MD. AREA       CG3
217000940623AL
217100950810CR
217200940623GA
217300940623FR
217400940623WA
217500020610** COUNTY CODES FOR EASTERN AND SOUTHERN MD. CG4
217600940623CL
217700940623CA
217800940623CE
217900940623CH
218000940623DO
218100940623KT
218200940623QA
218300940623SO
218400940623SM
218500940623TA
218600940623WI
218700940623WO
218800020610** AETNA COUNTY CODES FOR BALTIMORE METRO AREA  CG7
218900950308AA
219000950308BA
219100950308CR
219200950308HA
219300950308HO
219400020610** AETNA COUNTY CODES FOR WASHINGTON METRO AREA  CG8
219500950308MO
219600950308PG
219700020610** AETNA COUNTY CODES FOR WESTERN MD. AREA       CG9
219800950308AL
219900950308GA
220000020610** AETNA COUNTY CODES FOR FRED.,CECIL,WASHINGTON, AND CHARLES   C10
220100950308FR
220200950308WA
220300950317CE
220400950317CH
220500020610** AETNA COUNTY CODES FOR EASTERN AND SOUTHERN MD. C11
220600950308CL
220700950308CA
220800950308DO
220900950308KT
221000950308QA
221100950308SO
221200950308SM
221300950308TA
221400950308WI
221500950308WO
221600020610** AETNA COUNTY CODES FOR BALTIMORE HMO'S    C12
221700950308AA
221800950308BA
221900950308CR
222000950308HA
222100950308HO
222200950308CE
222300950619FR
222400020610** AETNA COUNTY CODES FOR WASHINGTON HMO'S   C13
222500950308MO
222600950308PG
222700020610** PRINCIPAL BALTIMORE AREA COUNTIES  CG5
222800000605WA
222900000605FR
223000000605MO
223100000605PG
223200000605CE
223300000605QA
223400941021BA
223500941021HO
223600941021HA
223700941021AA
223800000605CA
223900000605CH
224000000605SM
224100000605KT
224200000605CL
224300000605TA
224400000605DO
224500000605WI
224600000605WO
224700000605SO
224800020610** PRINCIPAL OTHER AREA COUNTIES         C14
224900960811CR
225000960811FR
225100950308WA
225200950308CE
225300020610** KAISER BALTIMORE AREA COUNTIES        C15
225400950308BA
225500950308HO
225600950308HA
225700950308AA
225800950308CR
225900020610** KAISER WASHINGTON AREA COUNTIES      C16
226000950308MO
226100950308PG
226200950308FR
226300020610** HEALTH PLUS BALTIMORE COUNTIES      C17
226400950310AA
226500950310BA
226600950310CL
226700950310CR
226800950310CE
226900950310HA
227000950310HO
227100950310SM
227200020610** HEALTH PLUS D.C. COUNTIES          C18
227300950310CH
227400950310FR
227500950310MO
227600950310PG
227700950310WA
227800020610** BLUE CHOICE COUNTIES 11/2001       C20
227900011108AA
228000011108BA
228100011108CL
228200011108CR
228300011108CE
228400011108CH
228500011108FR
228600011108HA
228700011108HO
228800011108MO
228900011108PG
229000011108SM
229100020610** AGE FACTORS FOR AETNA PLANS            AAF
229200951024057
229300951024057
229400951024068
229500951024068
229600951024085
229700951024099
229800951024112
229900951024120
230000951024126
230100951024131
230200020610** AETNA GEO. AREA FACTORS HMO (GO4 ARRAY)   GO4
2303009506121000
2304009510241131
230500020610** AETNA GEO. AREA FACTORS IND.(GO3 ARRAY)   GO3
2306009506121000
2307009508211430
2308009508211000
2309009508211000
231000020610** AGE BANDS FOR MD. FIDELITY                     MA
231100020604001
231200020604039
231300020604044
231400020604099
231500020610** GEO FACTORS FOR PHN                            GFP
231600970908100
231700970908104
231800970908100
231900970908100
232000020610** EXCLUDE COUNTIES FOR PHN      PHNE
232100980406AL
232200980406GA
232300980406KT
232400980406CA
232500980406SO
232600980406DO
232700980406WI
232800980406QA
232900980406TA
233000980406WO
233100980406WA
233200020610** AGE BANDS FOR KAISER SMALL GROUP REFORM AK
233300020604001
233400020604024
233500020604029
233600020604034
233700020604039
233800020604044
233900020604049
234000020604054
234100020604059
234200020604064
234300020604099
