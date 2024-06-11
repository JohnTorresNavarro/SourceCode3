000100001016     H DFTNAME(CR022B) FIXNBR(*ZONED)
000200991230      ******************************************************************
000300991230      * CR022B     GROUP BENEFIT SERVICES SOFTWARE           1989      *
000400991230      *                                                                *
000500991230      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600991230      *            DATE - 10/23/89                                     *
000700991230      *                                                                *
000800991230      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A WORKFILE TO BE USED *
000900991230      *                FOR PRINTING MEDICAL FORMAT TRANSMITTALS        *
001000991230      *                                                                *
001100991230      *  Y2K CONVERT - 1998                                            *
001200991230      *                                                                *
001300000103      * NOTE: When re-compiling this program change 'Fix Numeric'      *
001400000103      *       option from *NONE to *ZONED and *INPUTPACKED             *
001500000103      *                                                                *
001600071008      *  09/28/07  dlk  change bilrte & netrte to 6 decimal. Also      *
001700071008      *                 convert rate calc to use external pgm          *
001800120822      *  08/22/12 dlk - add new proration rule 03 - full month rule    *
001900131007      *  10/07/13 sbt - hist file expansion project                    *
002000070926      *                                                                *
002100991230      ******************************************************************
002200131007     FHIST      UP   F  216        DISK
002300991230     FCODES     IF   F   64     3AIDISK    KEYLOC(1)
002400991230     FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
002500991230     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
002600991230     FMCOV30    IF   F   88    30AIDISK    KEYLOC(1)
002700991230     FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
002800991230     FCARMST    IF   E           K DISK
002900991230     FTRANSREC  O  A F  232        DISK
003000991230     FREPORT    O    F  132        PRINTER OFLIND(*INOF)
003100991230
003200991230     D MSG             S             40    DIM(10) CTDATA PERRCD(1)
003300991230     D workdt          S               d   datfmt(*iso)
003400991230     D prorateb        S              7  2
003500991230     D dayrateb        S             12  7
003600991230     D daystoadj       S              2  0
003700991230     D daysinmo        S              2  0
003800991230     D holddd          S              2  0
0039001208220037 D prwhat          S              3
004000071008     D ter2            S              8  0
0041000710080037 D grgroup         S                   like(parmgroup)
0042000710080037 D benamtwk        S                   like(benamt)
004300991230
004400991230     D                 DS
004500071008      * rate key
004600071008     D  tspabct               12     26
004700071008      * PLAN MASTER FILE KEY
004800991230     D  PLNKEY                12     21
004900991230      *                          PLAN MASTER FILE KEY
005000991230     D  TRUST#                12     14  0
005100991230     D  SUB#                  15     17  0
005200991230     D  PLAN#                 18     21
005300991230     D  AGEBND                22     23  0
005400991230     D  T                     24     24
005500991230     D  TCODE                 25     26
005600991230
005700991109     D                 DS
005800991109     D  FRSTDT                 1      8  0
005900991109     D  FRSTYM                 1      6  0
006000991109     D  FRSTDY                 7      8  0
006100991230
006200000217     D                 DS
006300071008     D  effymd                 1      8  0
006400000217     D  EFFYM                  1      6  0
006500000217     D  EFFDY                  7      8  0
006600000217
006700000106     D                 DS
006800000106     D  COV2                   1      8  0
006900000106     D  COV2Y                  1      4  0
007000000106     D  COV2M                  5      6  0
007100000106
007200991230     D                 DS
007300991230      *  DATA STRUCTURE -------- MCOV30 FILE KEY
007400991230     D  MCKEY                  1     30
007500991230     D  SSNO                   1      9  0
007600991230     D  DSEQ#                 10     11  0
007700991230     D  HTRS                  12     14  0
007800991230     D  HSUB                  15     17  0
007900991230     D  HACC                  18     21  0
008000991230     D  HPLAN                 22     25
008100991230     D  HAGB                  26     27  0
008200991230     D  HT                    28     28
008300991230     D  TYPCOD                29     30
008400991230
008500991230     D                UDS
008600991230      *  LDA TRUST CATEGORY SELECTION
008700991230     D  LTRUST                 7      9
008800991230     D  LCAT                  53     86
008900941013     D                                     DIM(34)
009000991230
009100991230      * HIST RECORD
009200991230     IHIST      NS  01
009300991230     I                                  2   10 0SSNO          L1
009400991230     I                                 17   17  CODE#1
009500991230     I                                 18   19  CODECK
009600991230     I                                 17   19  TRCODE
009700991230     I                                 26   55  CK#NOT
009800991230     I                                 56   85  NOTE2
009900991230     I                                 26   29  PLAN#
010000991230     I                                 26   29  HPLAN
010100991230     I                                 40   41 0AGEBND
010200991230     I                                 40   41 0HAGB
010300991230     I                                 52   53  TYPCOD
010400991230     I*******                          68   69 0OAGEBN
010500991230     I                                 68   69  OAGEBN
010600991230     I                                 68   69  OLDCOD
010700991230     I                                 63   69 0OBAMT
010800991230     I                                 79   85 0NBAMT
010900991230     I                                 78   85 0TOCAN
011000000217     I                                 78   85 0NEWDAT
011100000217     I                                 82   83 0NEWMO
011200991230     I                                 87   87  TRLFLG
011300991230     I                                110  112 0TRUST#
011400991230     I                                110  112 0HTRS
011500991230     I                                113  115 0SUB#
011600991230     I                                113  115 0HSUB
011700991230     I                                116  119 0ACCNO
011800991230     I                                116  119 0HACC
011900991230     I                                129  136 0TRDATE
012000991230     I                                153  160 0COVYMD
012100000217     I                                157  158 0COVMO
012200991230     I                                159  160 0COVDAY
012300131007     I                                  1  160  RECORD
012400991230
012500991230      *  CODES MASTER FILE
012600991230     ICODES     NS
012700991230     I                                 44   44  ACTION
012800991230     I                                 45   45  ACTN2
012900991230     I                                 64   64  CSTATS
013000991230
013100991230      *  MEMBER FILE
013200991230     IMEMBER    NS
013300991230     I                                 10   27  LNAME
013400991230     I                                 28   39  FNAME
013500991230     I                                 40   40  MI
013600991230
013700991230      * PLAN MASTER FILE
013800991230     IPLNMST    NS
013900991230     I                                 53   55  PCARR
014000991230     I                                155  155  PRTYPE
014100991230     I                             P  138  139 2REMITP
014200991230     I                                162  162  SGRREM
014300930518     I                                164  165  PLNCAT
014400991230     I                                182  182  REMITF
014500991230
014600991230     IMCOV30    NS
014700991230      *  MEMBER COVERAGE FILE
014800991230     I                             P   44   47 0BENAMT
014900991230     I                                 73   80 0CANDT
015000991230     I                                 79   80 0CANDTD
015100991230
015200991230     ITRSMST    NS
015300991230      *  TRUST MASTER FILE
015400991230     I                                255  255  TSCODE
015500991230      ****************************************************************
015600991230      *  F I R S T  C Y C L E   O N L Y                              *
015700991230      ****************************************************************
015800991230     C                   IF        FIRST <> 'N'
015900991230     C                   MOVE      'T'           T                 1
016000991230     C                   MOVE      'T'           HT                1
016100991230     C                   TIME                    TIME              6 0
016200000306     C*****              SETON                                        U4
016300991230     C                   MOVE      *ZEROS        DSEQ#
016400991230     C                   MOVE      'N'           FIRST             1
016500991230     C                   EXCEPT    HEADER
016600991230     C                   END
016700991230      *
016800991230      * BLANK OUT PRINT FLAG BEFORE UPDATE
016900991230      *
017000991230     C                   MOVE      ' '           TRLFLG
017100991230      *
017200991230      * ON SS# CHANGE SET TRUST SELECT FLAG
017300991230      *
017400991230     C   L1              IF        LTRUST <> 'ALL'
017500991230     C                   MOVE      'Y'           SELTRS            1
017600941013     C                   MOVE      LTRUST        CTLFLD            3
017700991230
017800991230     C                   ELSE
017900991230      *
018000991230      * SELECT BY CATEGORY
018100991230      *
018200991230     C     TRUST#        CHAIN     TRSMST                             98
018300991230     C  N98              GOTO      #T0005
018400991230     C                   Z-ADD     9             X
018500991230     C                   MOVE      'N'           SELTRS
018600991230     C                   MOVE      TRUST#        ERRTXT
018700991230     C                   ADD       1             CNT
018800071008     c                   move      covymd        effymd
018900991230     C                   EXCEPT    PRTERR
019000991230     C                   GOTO      #END
019100991230     C     #T0005        TAG
019200991230
019300991230     C                   DO        34            D                 2 0
019400991230     C                   IF        LCAT(D) = TSCODE
019500991230     C                   MOVE      'Y'           SELTRS
019600941013     C                   MOVE      LCAT(D)       CTLFLD
019700941013     C                   MOVEL     '  '          CTLFLD
019800991230     C                   GOTO      #T0007
019900991230     C                   END
020000991230     C                   END
020100991230
020200991230     C                   MOVE      'N'           SELTRS
020300991230
020400991230     C                   END
020500991230      *
020600991230      * SKIP RECORD IF SELECT TRUST FLAG = N
020700991230      *
020800941013     C     #T0007        TAG
020900991230     C                   IF        SELTRS = 'N'
021000991230     C                   SETOFF                                       01
021100991230     C                   GOTO      #END
021200991230     C                   END
021300991230      *
021400991230      * ON SS# CHANGE GET NEW MEMBER
021500991230      *
021600991230     C   L1              SETOFF                                       22
021700991230     C   L1SSNO          CHAIN     MEMBER                             22
021800990216     C   L1
021900991230     CAN 22              EXCEPT    ERR1
022000991230     C   22              GOTO      #END
022100991230      *****************************************************************
022200991230      * SKIP RECORD IF TRCODE IS = MDX BECAUSE THE HISTORY RECORD IS
022300930119      * MISSING THE AGE BAND AND COVERAGE TYPE SO IT CAN NOT FIND A
022400930119      * RATE RECORD IN THE GRATE FILE
022500991230      *****************************************************************
022600991230     C                   IF        TRCODE = 'MDX'
022700991230     C                   SETOFF                                       01
022800991230     C                   GOTO      #END
022900991230     C                   END
023000991230      ****************************************************************
023100991230      *         PROCESS AND FLAG HISTORY RECORD                      *
023200991230      ****************************************************************
023300991230      *
023400991230      * CHAIN TO CODES FILE FOR ACTION CODES
023500991230      *
023600991230     C     TRCODE        CHAIN     CODES                              98
023700991230     C  N98              GOTO      #T0010
023800991230     C                   Z-ADD     3             X                 2 0
023900991230     C                   MOVE      TRCODE        ERRTXT           30
024000991230     C                   ADD       1             CNT               2 0
024100071008     c                   move      covymd        effymd
024200991230     C                   EXCEPT    PRTERR
024300991230     C                   GOTO      #END
024400991230     C     #T0010        TAG
024500991230      *
024600991230      * --- EXIT AND FLAG RECORD IF NOT NEEDED ACTION CODE AND U1 IS ON
024700991230      *
024800991230     C                   IF        ACTION <> 'A'
024900991230     C                   IF        ACTION <> 'B'
025000991230     C                   IF        ACTION <> 'C'
025100991230     C                   IF        ACTION <> 'D'
025200991230     C                   IF        ACTION <> 'E'
025300991230     C                   IF        ACTION <> 'G'
025400991230     C                   IF        ACTION <> 'R'
025500991230     C                   IF        ACTION <> 'H'
025600991230     C                   MOVE      'X'           TRLFLG
025700991230     C                   GOTO      #END
025800991230     C                   END
025900991230     C                   END
026000991230     C                   END
026100991230     C                   END
026200991230     C                   END
026300991230     C                   END
026400991230     C                   END
026500991230     C                   END
026600991230     C                   IF        ACTN2 <> 'S'
026700991230     C                   MOVE      'X'           TRLFLG
026800991230     C                   GOTO      #END
026900991230     C                   END
027000991230      *
027100991230      * CHAIN TO PLAN FILE FOR FORMAT TYPE
027200991230      *
027300991230     C     PLNKEY        CHAIN     PLNMST                             98
027400991230     C  N98              GOTO      #T0020
027500991230     C                   Z-ADD     4             X
027600991230     C                   MOVE      PLNKEY        ERRTXT
027700991230      * INSERT CHECK FOR MEMBER RECORD CANCEL DATE CHANGE. DO NOT
027800991230      * PRINT ERROR LISTING, AS THERE IS NO PLAN HELD FOR CHAIN TO
027900991230      * MASTER FILE IN THAT TRANSACTION RECORD.
028000940804     C                   IF        TRCODE = 'MMX'
028100940804     C                   GOTO      #END
028200940804     C                   END
028300071008     c                   move      covymd        effymd
028400991230     C                   EXCEPT    PRTERR
028500991230     C                   GOTO      #END
028600991230     C     #T0020        TAG
028700071008      *
028800071008      * --- EXIT AND FLAG RECORD IF NOT LIFE TYPE PLAN
028900071008      *
029000071008     C                   IF        REMITF <> 'L'
029100071008     C                   MOVE      'F'           TRLFLG
029200071008     C                   GOTO      #END
029300071008     C                   END
029400991230      *
029500991230     C                   MOVE      TYPCOD        TCODE
029600991230
029700991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
029800991230      * PROCESS ADD OR DELETE COVERAGE
029900991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
030000071008     C                   IF        ACTION = 'A' or
030100071008     C                             ACTION = 'D' or
030200071008     C                             ACTION = 'R'
030300071008     C                   Z-ADD     OBAMT         benamtwk
030400991230     C                   GOTO      #T0035
030500991230     C                   END
030600991230
030700991230     C                   GOTO      #T0040
030800991230
030900991230     C     #T0035        TAG
031000991230      *
031100991230      *  EXECUTE PREMIUM CALCULATION ROUTINE
031200991230      *
031300071008     C                   MOVE      COVYMD        effymd
031400071008     C                   EXSR      #GRATE
031500071008
031600071008     C                   IF        parmfound <> 'Y'
031700071008     C                   Z-ADD     5             X
031800071008     C                   MOVE      tspabct       ERRTXT
031900071008     C                   ADD       1             CNT
032000071008     C                   EXCEPT    PRTERR
032100071008     C                   GOTO      #END
032200071008     C                   END
032300071008
032400991230     C                   EXSR      #PREM
032500991230
032600991230      * WRITE OUT PLAN ADD OR DELETE RECORD
032700991230      * IF DELETE TRANS., CREDIT PREMIUM.
032800991230
032900991230     C                   MOVE      'P'           TRLFLG
033000991230     C                   IF        ACTION = 'D'
033100991230     C                   Z-SUB     PREM          PREM
033200991230     C                   END
033300991230
033400991230     C                   EXCEPT    RECHST
033500991230     C                   SETOFF                                       U4
033600991230     C     #T0040        TAG
033700991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
033800991230      * PROCESS COVERAGE TYPE CHANGE
033900991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
034000991230     C                   IF        ACTION = 'C'
034100071008     C                   Z-ADD     NBAMT         benamtwk
034200071008      *  get PREMIUM
034300071008     C                   MOVE      COVYMD        effymd
034400071008     C                   EXSR      #GRATE
034500071008
034600071008     C                   IF        parmfound <> 'Y'
034700071008     C                   Z-ADD     5             X
034800071008     C                   MOVE      tspabct       ERRTXT
034900071008     C                   ADD       1             CNT
035000071008     C                   EXCEPT    PRTERR
035100071008     C                   GOTO      #END
035200071008     C                   END
035300071008
035400991230     C                   EXSR      #PREM
035500991230     C                   Z-ADD     PREM          PREMH             7 2
035600991230      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
035700991230     C                   MOVE      OLDCOD        TCODE
035800000106     C                   EXSR      #GRATE
035900991230
036000071008     C                   IF        parmfound <> 'Y'
036100991230     C                   Z-ADD     7             X
036200071008     C                   MOVE      tspabct       ERRTXT
036300991230     C                   ADD       1             CNT
036400991230     C                   EXCEPT    PRTERR
036500991230     C                   GOTO      #END
036600991230     C                   END
036700991230
036800991230      *  EXECUTE PREMIUM CALCULATION ROUTINE
036900991230
037000991230     C                   EXSR      #PREM
037100991230     C     PREMH         SUB       PREM          PREM
037200991230      *
037300991230      * WRITE OUT PLAN CHANGE RECORD
037400991230      *
037500991230     C                   MOVE      'P'           TRLFLG
037600991230     C                   EXCEPT    RECHST
037700991230     C                   SETOFF                                       U4
037800991230
037900991230     C                   END
038000991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
038100991230      * PROCESS ENROLLMENT DATE CHANGE
038200991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
038300991230     C                   IF        ACTION = 'E'
038400000217     C                   IF        NEWMO = COVMO
038500991230      *
038600991230      *  EXECUTE PREMIUM CALCULATION ROUTINE
038700991230      *
038800071008     C                   MOVE      COVYMD        effymd
038900071008     C                   EXSR      #GRATE
039000071008
039100071008     C                   IF        parmfound <> 'Y'
039200071008     C                   Z-ADD     5             X
039300071008     C                   MOVE      tspabct       ERRTXT
039400071008     C                   ADD       1             CNT
039500071008     C                   EXCEPT    PRTERR
039600071008     C                   GOTO      #END
039700071008     C                   END
039800000217
039900991230     C                   EXSR      #PREM
040000000217     C                   Z-ADD     PREM          PREMH             7 2
040100000217      *
040200000217      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
040300000217      *
040400071008     C                   MOVE      NEWDAT        effymd
040500071008     C                   EXSR      #GRATE
040600071008
040700071008     C                   IF        parmfound <> 'Y'
040800071008     C                   Z-ADD     5             X
040900071008     C                   MOVE      tspabct       ERRTXT
041000071008     C                   ADD       1             CNT
041100071008     C                   EXCEPT    PRTERR
041200071008     C                   GOTO      #END
041300071008     C                   END
041400071008
041500000217     C                   EXSR      #PREM
041600010921     C     PREM          SUB       PREMH         PREM
041700071008
041800000217     C                   ELSE
041900071008
042000000217     C                   MOVE      *ZEROS        PREM
042100000217     C                   END
042200991230      *
042300991230      * WRITE OUT PLAN CHANGE RECORD
042400991230      *
042500991230     C                   MOVE      'P'           TRLFLG
042600991230     C                   EXCEPT    RECHST
042700991230     C                   SETOFF                                       U4
042800991230
042900991230     C                   END
043000991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
043100991230      * PROCESS CANCEL DATE CHANGE
043200991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
043300991230     C                   IF        ACTION = 'H'
043400991230
043500991230      * READ MCOV FILE FOR BENEFIT AMOUNT SINCE IT IS NOT
043600991230      * HELD IN THE HISTORY RECORD FOR "MCX"
043700991230
043800071008     c                   clear                   benamtwk
043900931027     C                   SETOFF                                           98
044000931027     C     MCKEY         SETLL     MCOV30
044100931027     C     #T0030        TAG
044200931027     C     MCKEY         READE     MCOV30                                 98
044300991230     C   98              Z-ADD     8             X
044400991230     C   98              MOVE      MCKEY         ERRTXT
044500071008     C   98              MOVE      COVYMD        effymd
044600991230     C   98              EXCEPT    PRTERR
044700991230     C   98              GOTO      #END
044800980806     C                   IF        TOCAN <> CANDT
044900931027     C                   GOTO      #T0030
045000931027     C                   END
045100071008     c                   move      benamt        benamtwk
045200000217
045300000217     C                   IF        NEWMO = COVMO
045400000217      *
045500000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
045600000217      *
045700071008     C                   MOVE      COVYMD        effymd
045800071008     C                   EXSR      #GRATE
045900071008
046000071008     C                   IF        parmfound <> 'Y'
046100071008     C                   Z-ADD     5             X
046200071008     C                   MOVE      tspabct       ERRTXT
046300071008     C                   ADD       1             CNT
046400071008     C                   EXCEPT    PRTERR
046500071008     C                   GOTO      #END
046600071008     C                   END
046700071008
046800991230     C                   EXSR      #PREM
046900000217     C                   Z-ADD     PREM          PREMH             7 2
047000000217      *
047100000217      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
047200000217      *
047300071008     C                   MOVE      NEWDAT        effymd
047400071008     C                   EXSR      #GRATE
047500071008
047600071008     C                   IF        parmfound <> 'Y'
047700071008     C                   Z-ADD     5             X
047800071008     C                   MOVE      tspabct       ERRTXT
047900071008     C                   ADD       1             CNT
048000071008     C                   EXCEPT    PRTERR
048100071008     C                   GOTO      #END
048200071008     C                   END
048300071008
048400000217
048500000217     C                   EXSR      #PREM
048600000217     C     PREMH         SUB       PREM          PREM
048700000217     C                   ELSE
048800000217     C                   MOVE      *ZEROS        PREM
048900000217     C                   END
049000991230      *
049100991230      * WRITE OUT PLAN CHANGE RECORD
049200991230      *
049300991230     C                   MOVE      'P'           TRLFLG
049400991230     C                   EXCEPT    RECHST
049500991230     C                   SETOFF                                       U4
049600991230
049700991230     C                   END
049800991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
049900991230      * PROCESS MEMBER AGE BAND CHANGE
050000991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
050100991230     C                   IF        ACTION = 'G'
050200991230      *
050300991230      *  EXECUTE PREMIUM CALCULATION ROUTINE
050400991230      *
050500071008     C                   MOVE      COVYMD        effymd
050600071008     C                   EXSR      #GRATE
050700071008
050800071008     C                   IF        parmfound <> 'Y'
050900071008     C                   Z-ADD     6             X
051000071008     C                   MOVE      tspabct       ERRTXT
051100071008     C                   ADD       1             CNT
051200071008     C                   EXCEPT    PRTERR
051300071008     C                   GOTO      #END
051400071008     C                   END
051500071008
051600991230     C                   EXSR      #PREM
051700991230     C                   Z-ADD     PREM          PREMH             7 2
051800991230      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
051900991230     C                   MOVE      OAGEBN        AGEBND
052000071008     C                   MOVE      COVYMD        effymd
052100000106     C                   EXSR      #GRATE
052200000106
052300071008     C                   IF        parmfound <> 'Y'
052400991230     C                   Z-ADD     10            X
052500071008     C                   MOVE      tspabct       ERRTXT
052600991230     C                   ADD       1             CNT
052700991230     C                   EXCEPT    PRTERR
052800991230     C                   GOTO      #END
052900991230     C                   END
053000991230
053100991230     C                   EXSR      #PREM
053200991230     C     PREMH         SUB       PREM          PREM
053300991230      *
053400991230      * WRITE OUT PLAN CHANGE RECORD
053500991230      *
053600991230     C                   MOVE      'P'           TRLFLG
053700991230     C                   EXCEPT    RECHST
053800991230     C                   SETOFF                                       U4
053900991230
054000991230     C                   END
054100991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
054200991230      * PROCESS BENEFIT AMOUNT CHANGE
054300991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
054400991230     C                   IF        ACTION = 'B'
054500991230      *
054600991230      *  EXECUTE PREMIUM CALCULATION ROUTINE
054700991230      *
054800071008     C                   MOVE      NBAMT         benamtwk
054900071008     C                   MOVE      COVYMD        effymd
055000071008     C                   EXSR      #GRATE
055100071008
055200071008     C                   IF        parmfound <> 'Y'
055300071008     C                   Z-ADD     6             X
055400071008     C                   MOVE      tspabct       ERRTXT
055500071008     C                   ADD       1             CNT
055600071008     C                   EXCEPT    PRTERR
055700071008     C                   GOTO      #END
055800071008     C                   END
055900071008
056000991230     C                   EXSR      #PREM
056100991230     C                   Z-ADD     PREM          PREMH             7 2
056200991230      *
056300991230      * CALULATE PREMIUM DIFFERENCE FOR BENEFIT CHANGE   *
056400991230      *
056500071008     C                   MOVE      OBAMT         benamtwk
056600071008     C                   MOVE      COVYMD        effymd
056700071008     C                   EXSR      #GRATE
056800071008
056900071008     C                   IF        parmfound <> 'Y'
057000071008     C                   Z-ADD     7             X
057100071008     C                   MOVE      tspabct       ERRTXT
057200071008     C                   ADD       1             CNT
057300071008     C                   EXCEPT    PRTERR
057400071008     C                   GOTO      #END
057500071008     C                   END
057600071008
057700991230     C                   EXSR      #PREM
057800991230     C     PREMH         SUB       PREM          PREM
057900991230      *
058000991230      * WRITE OUT PLAN CHANGE RECORD
058100991230      *
058200991230     C                   MOVE      'P'           TRLFLG
058300991230     C                   EXCEPT    RECHST
058400991230     C                   SETOFF                                       U4
058500991230
058600991230     C                   END
058700991230
058800991230     C     #END          TAG
058900991230      ****************************************************************
059000991230
059100991230      *------------------- CALCULATE PREMIUM ------------------------*
059200991230
059300071008      ****************************************************************
059400071008      * adjust premium by remittance percent and prorate
059500071008      ****************************************************************
059600071008
059700991230     C     #PREM         BEGSR
059800991230
059900071008     C                   clear                   prem              7 2
060000991230
060100991230     C                   IF        REMITP = 0
060200071008     C                   z-add     netprem       prem
060300991230     C                   ELSE
060400071008     C     REMITP        MULT      bilprem       prem
060500991230     C                   END
060600991109     c
060700991230      * check for prorate - if needed the field "prem"
060800991230      * will be returned prorated
060900991230      *
061000000217     c                   if        EFFDY > 01
061100991101     c     pcarr         chain     carmst                             51
061200991101     c                   if        *in51 = *off and cprrul <> '  '
061300000217     c                   eval      holddd = EFFDY
061400071008     c                   eval      FRSTDT = effymd
061500991109     C                   MOVE      01            FRSTDY
061600120822   8 C* set what date to prorate as ENROLLMENT DATE
061700120822     c                   eval      prwhat = 'ENR'
061800991101     c                   exsr      #prorate
061900991101     c                   end
062000991101     c                   end
062100991230
062200991230     C     #ENDSR        ENDSR
062300991230      ***************************************************************
062400991230      * prorate adjustment                                          *
062500991230      ***************************************************************
062600991101     C     #prorate      BEGSR
062700991230
062800991230      *  fields used in pro rate calculation
062900991230      *  -----------------------------------
063000991230      *  holddd    = effective day of term (2.0)
063100991230      *  cprrul    = pro rate rule from carmst (2)
063200991230      *  prem      = billed amount (7.2) (full month)
063300991230      *  dayrateb  = daily rate billed (12.7)
063400991230      *  daysinmo  = # of days in month of prorated amount (2.0)
063500991230      *  daystoadj = # of days to adjust prorated amount   (2.0)
063600991230      *  prorateb  = prorated amount billed (7.2 rounded)
063700991230      *  workdt    = date field for finding last day in month (*ISO)
063800120822   4 C*  prwhat    = prorate what date (3) - BOT, ENR, CAN
063900991230
064000991230      * skip if no pro-ration necessary
064100991230
064200991230     C                   if        holddd = 01 or cprrul = '  '
064300991207     c                   goto      #endpr
064400991207     c                   endif
064500991207     c
064600991230      * get total # of days in month of prorated amount
064700991230
064800991109     c                   move      frstdt        workdt
064900991101     c                   adddur    1:*m          workdt
065000991101     c                   subdur    1:*d          workdt
065100991101     c                   extrct    workdt:*d     daysinmo
065200991230
065300991230      * if a bad effymd causes the daysinmo to be zero, the divide will
065400991230      * not work so skip
065500991230
065600991101     c                   if        daysinmo = 0
065700991101     c                   goto      #endpr
065800991230     c                   end
065900991230      *
066000991230      * daily rule (01)- prorate to the day
066100991230      *
066200991101     c                   if        cprrul = '01'
066300991109     c                   eval      daystoadj = (daysinmo - holddd) + 1
066400991101     c                   eval      dayrateb  = prem / daysinmo
066500991101     c                   eval(h)   prorateb  = dayrateb * daystoadj
066600991101     c                   eval      prem      = prorateb
066700991101     c                   endif
066800991230      *
066900991230      * mid month rule (02)- cancelled up to the 15th = no premium billed
067000991230      *
067100000209     c                   if        cprrul = '02' and holddd > 15
067200991101     c                   eval      prem   = *zeros
067300991101     c                   endif
067400120822     C*
067500120822   5 C* Full month rule (03) - only charge for full FIRST month when day=01
067600120822   5 C*                        always charge for full LAST month unless
067700120822   4 C*                        day = 01 (no coverage)
067800120822   4 C*
067900120822     c                   if        cprrul = '03' and
068000120822     c                             ((prwhat = 'BOT') or
068100120822     c                             (prwhat = 'ENR' and holddd <> 01) or
068200120822     c                             (prwhat = 'CAN' and holddd = 01))
068300120822     c                   eval      prem   = *zeros
068400120822     c                   endif
068500120822     C*
068600991230
068700991230     C     #endpr        ENDSR
068800000106
068900000106      ***************************************************************
0690000710080325 C* GET group# and calc prem
069100000106      ***************************************************************
069200000106     C     #GRATE        BEGSR
0693000710080385 C* clear fields first
0694000710090387 C                   clear                   bilprem
0695000710090387 C                   clear                   netprem
0696000710090387 C                   clear                   grgroup
069700071008
069800071008     c     grplist       plist
069900071008     c                   parm                    parmkey          15
070000140106     C                   PARM                    PARMSSN           9
070100140106     C                   PARM                    PARMSEQ           2
070200071008     c                   parm                    parmeffymd        8
070300071008     c                   parm                    parmbenamt        7
070400071008     c                   parm                    parmgroup        15
070500071008     c                   parm                    parmbilrte       11
070600071008     c                   parm                    parmnetrte       11
070700071008     c                   parm                    parmbilprem       7
070800071008     c                   parm                    parmnetprem       7
070900071008     c                   parm                    parmfound         1
071000140106    *
071100140106     C                   EVAL      PARMSSN = *BLANKS
071200140106     C                   EVAL      PARMSEQ = *BLANKS
071300071008
071400071008     c                   move      tspabct       parmkey
071500071008     c                   move      effymd        parmeffymd
071600071008     c                   move      benamtwk      parmbenamt
071700071008     c                   clear                   parmgroup
071800071008     c                   clear                   parmbilrte
071900071008     c                   clear                   parmnetrte
072000071008     c                   clear                   parmbilprem
072100071008     c                   clear                   parmnetprem
072200071008     c                   clear                   parmfound
072300071008
072400071008     c                   call      'GETRATE'     grplist
072500071008
072600071008      * premium returned
0727000710080361 C                   if        parmfound = 'Y'
072800071008     c                   move      parmbilprem   bilprem           7 2
072900071008     c                   move      parmnetprem   netprem           7 2
073000071008     c                   move      parmgroup     grgroup
073100071008
073200071008     c                   else
073300071008      * no rate found - do second rate search for 1 month less
0734000710080361 C                   if        effymd = 0
073500071008     C                   leavesr
073600071008     c                   end
073700071008
073800071008     C                   move      effymd        workdt
073900071008     C                   subdur    1:*m          workdt
074000071008     C                   move      workdt        ter2
074100071008     c                   move      tspabct       parmkey
074200071008     c                   move      ter2          parmeffymd
074300071008     c                   move      benamtwk      parmbenamt
074400071008     c                   clear                   parmgroup
074500071008     c                   clear                   parmbilrte
074600071008     c                   clear                   parmnetrte
074700071008     c                   clear                   parmbilprem
074800071008     c                   clear                   parmnetprem
074900071008     c                   clear                   parmfound
075000071008
075100071008     c                   call      'GETRATE'     grplist
075200071008
075300071008      * premium returned
0754000710080361 C                   if        parmfound = 'Y'
075500071008     c                   move      parmbilprem   bilprem
075600071008     c                   move      parmnetprem   netprem
075700071008     c                   move      parmgroup     grgroup
0758000710080363 C                   end
075900071008
0760000710080363 C                   end
0761000710080324 C*******************************************
076200071008
076300000106     C                   ENDSR
076400000106
076500000307      * THIS INITIALIZATION SUBROUTINE IS EXECUTED ONLY ONCE
076600000306     C     *INZSR        BEGSR
076700000306     C                   SETON                                        U4
076800000306     C                   ENDSR
076900000306
077000991230      *****************************************************************
077100991230      *                                                               *
077200991230      *   O U T  P U T   S E C T I O N                                *
077300991230      *                                                               *
077400991230      *****************************************************************
077500991230     OREPORT    E            HEADER         2 03
077600991230     O                       TIME                15 '  :  :  '
077700991230     O                                           40 '************************'
077800991230     O                                           66 'E R R O R  L I S T I N G'
077900991230     O                                           93 '************************'
078000991230     O                       UDATE         Y    110
078100991230     O          E            HEADER         1
078200991230     O                                           16 'CR022B'
078300991230     O                                           65 'LIFE FORMAT TRANSMITTALS'
078400991230     O          E            HEADER         1
078500991230     O                                           30 'THE FOLLOWING MEMBERS QU'
078600991230     O                                           54 'ALIFIED FOR THE TRANSMIT'
078700991230     O                                           78 'TAL BUT HAD INVALID DATA'
078800991230     O                                           88 'REASONS:'
078900991230     O          E            HEADER         1
079000991230     O                                           25 '------------------------'
079100991230     O                                           49 '------------------------'
079200991230     O                                           73 '------------------------'
079300991230     O                                           93 '------------------------'
079400991230     O                                          115 '------------------------'
079500991230     O          E            PRTERR      1  1
079600991230     O                       CNT           Z      4
079700991230     O                                            5 ')'
079800991230     O                       SSNO                17 '   -  -    '
079900991230     O                       TRDATE              27
080000991230     O                       TRCODE              32
080100991230     O                       TRUST#              39
080200991230     O                                           40 '-'
080300991230     O                       SUB#                43
080400991230     O                                           44 '-'
080500991230     O                       ACCNO               48
080600991230     O                       CK#NOT             100
080700991230     O                       NOTE2              132
080800991230
080900991230     O          E            PRTERR         1
081000991230     O                       MSG(X)              50
081100991230     O                       ERRTXT         B    80
081200071008     O                       effymd              98
081300991230     O                                           90 'EFF DT-'
081400991230     O          E            ERR1           1
081500991230     O                       SSNO                 9
081600991230     O                                           30 'INVALID SSN'
081700991230      *
081800991230      *  OUTPUT TRANSMITTAL SORT RECORD / HISTORY RECORD
081900991230      *
082000991230     OTRANSREC  EADD         RECHST
082100991230     O                       RECORD             160
082200980806     O                       SGRREM             125
082300980806     O                       CTLFLD             128
082400991230     O                       OBAMT          B    97P
082500991230     O                       NBAMT          B   101P
082600071008     O                       grgroup            177
082700991230     O                       LNAME              202
082800991230     O                       FNAME              215
082900991230     O                       MI                 217
083000991230     O                       PREM           B   228
083100991230     O                       PCARR              231
083200991230     O                       ACTION             232
083300991230
083400991230      *  OUTPUT TRANSMITTAL SORT RECORD / NEW RECORD
083500991230
083600991230      *-----------------------------------------------------------------*
083700991230      * UPDATE HISTORY RECORD 'TRLFLG' TRANSMITTAL PRINT FLAG
083800991230
083900991230     OHIST      D    01 U1
084000991230     O                       TRLFLG              87
084100910215**  OUTPUT MESSAGES
084200910215INVALID PLAN KEY FOR TERMINATED EMPLOYEE
084300910215INVALID RATE KEY FOR TERMINATED EMPLOYEE
084400910215INVALID TRANSACTION CODE  ------------->
084500910215INVALID PLAN KEY FOR ADD OR DELETE----->
084600910215INVALID RATE KEY FOR ADD OR DELETE----->
084700910215INVALID RATE KEY FOR CHANGE FROM------->
084800910215INVALID RATE KEY FOR CHANGE TO--------->
084900931028MCOV REC NOT FOUND, NEEDED FOR PREM---->
085000910215INVALID TRUST KEY --------------------->
085100910215INVALID AGEBAND CHANGE TO-------------->
