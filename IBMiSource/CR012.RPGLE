000100001016     H DFTNAME(CR012) FIXNBR(*ZONED)
000200140611     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('ALLSRVPGMN')
000300991108      ******************************************************************
000400991115      * CR012      GROUP BENEFIT SERVICES SOFTWARE           1989      *
000500991108      *                                                                *
000600991108      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000700991108      *            DATE - 10/23/89                                     *
000800991108      *                                                                *
000900991108      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A WORKFILE TO BE USED *
001000991108      *                FOR PRINTING MEDICAL FORMAT TRANSMITTALS        *
001100131008      *                                                                *
001200131008      * NOTE: When re-compiling this program change 'Fix Numeric'      *
001300131008      *       option from *NONE to *ZONED and *INPUTPACKED             *
001400991108      *                                                                *
001500991108      *  Y2K CONVERT - 1998                                            *
001600991108      *                                                                *
001700991108      *  11.05.99 - KSJ  Converted to RPG ILE                          *
001800071005      *  09/28/07  dlk  change bilrte & netrte to 6 decimal. Also      *
001900071005      *                 convert rate calc to use external pgm          *
002000120822      * 08/22/12 dlk - add new proration rule 03 - full month rule     *
002100130913      * 09/13/13 dlk - remove halt indicator h1                        *
002200131007      * 10/07/13 sbt - hist file expansion project                     *
002300140207      * JVA 02/07/14 - Check ACA Plan, use full rate
002400000103      *                                                                *
002500991108      ******************************************************************
002600131007     FHIST      UP   F  216        DISK
002700991108     FCODES     IF   F   64     3AIDISK    KEYLOC(1)
002800991108     FMEMBER    IF   F  648     9AIDISK    KEYLOC(1)
002900991108     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
003000991108     FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
003100991108     FCARMST    IF   E           K DISK
003200991108     FTRANSREC  O  A F  232        DISK
003300991108     FREPORT    O    F  132        PRINTER OFLIND(*INOF)
003400991230
003500991108     D MSG             S             40    DIM(10) CTDATA PERRCD(1)
003600991108     D workdt          S               d   datfmt(*iso)
003700991108     D prorateb        S              7  2
003800991108     D dayrateb        S             12  7
003900991108     D daystoadj       S              2  0
004000991108     D daysinmo        S              2  0
004100991108     D holddd          S              2  0
0042001208220037 D prwhat          S              3
004300071005     D ter2            S              8  0
0044000710050037 D grgroup         S                   like(parmgroup)
004500140207
0046001402070125 D YES             S               N   INZ(*ON)
0047001402070125 D NO              S               N   INZ(*OFF)
0048001402070125 D AM_I_ACA        S               N   INZ(*OFF)
004900140207     D @1              S              1A   INZ
005000140207
005100140207   X***X
005200140207      /DEFINE CHK_ACA_PLAN_PR
005300140207      /DEFINE CHK_ACA_PLAN_FIELDS
005400140611      /COPY QCPYSRC,ACASRVPGMP
005500140207      /UNDEFINE CHK_ACA_PLAN_PR
005600140207      /UNDEFINE CHK_ACA_PLAN_FIELDS
005700140207   X***X
005800140207
005900991230
006000991108     D                 DS
006100071005      * rate key
006200071005     D  tspabct               12     26
006300991108      *                          PLAN MASTER FILE KEY
006400991108     D  PLNKEY                12     21
006500991108     D  SSNO                   1      9  0
006600991108     D  DSEQ#                 10     11  0
006700991108     D  TRUST#                12     14  0
006800991108     D  SUB#                  15     17  0
006900991108     D  PLAN#                 18     21
007000991108     D  AGEBND                22     23  0
007100991108     D  T                     24     24
007200991108     D  TCODE                 25     26
007300991230
007400991108     D                 DS
007500991105     D  FRSTDT                 1      8  0
007600991105     D  FRSTYM                 1      6  0
007700991105     D  FRSTDY                 7      8  0
007800000217     D                 DS
007900000217     D  EFFDAT                 1      8  0
008000000217     D  EFFYM                  1      6  0
008100000217     D  EFFDY                  7      8  0
008200991230
008300000106     D                 DS
008400000106     D  COV2                   1      8  0
008500000106     D  COV2Y                  1      4  0
008600000106     D  COV2M                  5      6  0
008700000106
008800991108     D                 DS
008900930804     D  MCKEY                  1     30
009000991108     D  MFIRST                 1     17
009100991108     D  ACCNO                 18     21  0
009200991108     D  MSECND                22     30
009300991230
009400991108     D                UDS
009500991108      *  LDA TRUST CATEGORY SELECTION
009600991108     D  LTRUST                 7      9
009700991108     D  LCAT                  53     86
009800941017     D                                     DIM(34)
009900991230
010000991108      * HIST RECORD
010100991108     IHIST      NS  01
010200991108     I                                  2   10 0SSNO          L1
010300991108     I                                 17   19  TRCODE
010400991108     I                                 26   55  CK#NOT
010500991108     I                                 56   85  NOTE2
010600991108     I                                 26   29  PLAN#
010700991108     I                                 40   41 0AGEBND
010800991108     I                                 52   53  TYPCOD
010900991108     I                                 68   69  OLDCOD
011000991108     I                                 63   69  OLDBEN
011100000217     I                                 78   85 0NEWDAT
011200000217     I                                 82   83 0NEWMO
011300991108     I                                 86   86  TRMFLG
011400991108     I                                110  112 0TRUST#
011500991108     I                                113  115 0SUB#
011600991108     I                                116  119 0ACCNO
011700991108     I                                129  136 0TRDATE
011800991108     I                                153  160 0COVYMD
011900000217     I                                157  158 0COVMO
012000991108     I                                159  160 0COVDAY
012100131007     I                                  1  160  RECORD
012200991230
012300991108      *  CODES MASTER FILE
012400991108     ICODES     NS
012500991108     I                                 44   44  ACTION
012600991108     I                                 45   45  ACTN2
012700991230
012800991108      *  MEMBER FILE
012900991108     IMEMBER    NS
013000991108     I                                 10   27  LNAME
013100991108     I                                 28   39  FNAME
013200991108     I                                 40   40  MI
013300991230
013400991108      * PLAN MASTER FILE
013500991108     IPLNMST    NS
013600991108     I                                 53   55  PCARR
013700991108     I                                155  155  PRTYPE
013800991108     I                             P  138  139 2REMITP
013900991108     I                                182  182  REMITF
014000991230
014100991108     ITRSMST    NS
014200991108      *  TRUST MASTER FILE
014300991108     I                                255  255  TSCODE
014400991108      ****************************************************************
014500991108      *  F I R S T  C Y C L E   O N L Y                              *
014600991108      ****************************************************************
014700991108     C                   IF        FIRST <> 'N'
014800991108     C                   MOVE      'T'           T                 1
014900991108     C                   TIME                    TIME              6 0
015000000307     C******             SETON                                        U4
015100991108     C                   MOVE      *ZEROS        DSEQ#
015200991108     C                   MOVE      'N'           FIRST             1
015300991108     C                   EXCEPT    HEADER
015400991108     C                   END
015500991108      *
015600991108      * BLANK OUT PRINT FLAG BEFORE UPDATE
015700991108      *
015800991108     C                   MOVE      ' '           TRMFLG
015900991108      *
016000991108      * ON SS# CHANGE SET TRUST SELECT FLAG
016100991108      *
016200991108     C   L1              IF        LTRUST <> 'ALL'
016300991108     C                   MOVE      'Y'           SELTRS            1
016400991230
016500991108     C                   ELSE
016600991108      *
016700991108      * SELECT BY CATEGORY
016800991108      *
016900991108     C     TRUST#        CHAIN     TRSMST                             98
017000991108     C  N98              GOTO      #T0005
017100991108     C                   Z-ADD     9             X
017200991108     C                   MOVE      'N'           SELTRS
017300991108     C                   MOVE      TRUST#        ERRTXT
017400991108     C                   ADD       1             CNT
017500991108     C                   EXCEPT    PRTERR
017600991108     C                   GOTO      #END
017700991108     C     #T0005        TAG
017800991230
017900991108     C                   DO        34            D                 2 0
018000991108     C                   IF        LCAT(D) = TSCODE
018100991108     C                   MOVE      'Y'           SELTRS
018200991108     C                   GOTO      #T0007
018300991108     C                   END
018400991108     C                   END
018500991230
018600991108     C                   MOVE      'N'           SELTRS
018700991230
018800991108     C                   END
018900991108      *
019000991108      * SKIP RECORD IF SELECT TRUST FLAG = N
019100991108      *
019200941017     C     #T0007        TAG
019300991108     C                   IF        SELTRS = 'N'
019400991108     C                   SETOFF                                       01
019500991108     C                   GOTO      #END
019600991108     C                   END
019700991108      *
019800991108      * ON SS# CHANGE GET NEW MEMBER
019900991108      *
020000130913     c                   if        *inl1
020100130913     C     SSNO          CHAIN     MEMBER
020200130913     c                   if        not %found(member)
020300130913     c                   clear                   lname
020400130913     c                   clear                   fname
020500130913     c                   clear                   mi
020600130913     c                   end
020700130913     c                   end
020800130913
020900991108      ****************************************************************
021000991108      *         PROCESS AND FLAG HISTORY RECORD                      *
021100991108      ****************************************************************
021200991230
021300991108      * CHAIN TO CODES FILE FOR ACTION CODES
021400991230
021500930615     C                   IF        TRCODE = 'MMX'
021600930615     C                   GOTO      #END
021700930615     C                   END
021800991230
021900991108     C     TRCODE        CHAIN     CODES                              98
022000991108     C  N98              GOTO      #T0010
022100991108     C                   Z-ADD     3             X                 2 0
022200991108     C                   MOVE      TRCODE        ERRTXT           30
022300991108     C                   ADD       1             CNT               2 0
022400991108     C                   EXCEPT    PRTERR
022500991108     C                   GOTO      #END
022600991108     C     #T0010        TAG
022700991108      *
022800991108      * --- EXIT AND FLAG RECORD IF NOT NEEDED ACTION CODE AND U1 IS ON
022900991108      *
023000991108     C                   IF        ACTION <> 'A'
023100991108     C                   IF        ACTION <> 'C'
023200991108     C                   IF        ACTION <> 'D'
023300991108     C                   IF        ACTION <> 'E'
023400991108     C                   IF        ACTION <> 'R'
023500991108     C                   IF        ACTION <> 'H'
023600991108     C                   IF        ACTION <> 'G'
023700991108     C                   MOVE      'X'           TRMFLG
023800991108     C                   GOTO      #END
023900991108     C                   END
024000991108     C                   END
024100991108     C                   END
024200991108     C                   END
024300991108     C                   END
024400991108     C                   END
024500991108     C                   END
024600991108     C                   IF        ACTN2 <> 'S'
024700991108     C                   MOVE      'X'           TRMFLG
024800991108     C                   GOTO      #END
024900991108     C                   END
025000991108      *
025100991108      * CHAIN TO PLAN FILE FOR FORMAT TYPE
025200991108      *
025300991108     C     PLNKEY        CHAIN     PLNMST                             98
025400991108     C  N98              GOTO      #T0020
025500991108     C                   Z-ADD     4             X
025600991108     C                   MOVE      PLNKEY        ERRTXT
025700991108     C                   EXCEPT    PRTERR
025800991108     C                   GOTO      #END
025900991108     C     #T0020        TAG
026000991108      *
026100991108      * --- EXIT AND FLAG RECORD IF NOT MEDICAL TYPE PLAN
026200991108      *
026300991108     C                   IF        REMITF <> 'M'
026400991108     C                   IF        REMITF <> 'A'
026500991108     C                   GOTO      #END
026600991108     C                   END
026700991108     C                   END
026800071009
026900071009      *  fill coverage type code in tspabct (rate key)
027000071009     C                   MOVE      TYPCOD        TCODE
027100000106      *
027200000106      *  DON'T LOOK AT GRATE FILE FOR CHANGE CANCELLATION DATE-DCOV
027300000106      *
027400000106     C                   IF        TRCODE = 'MDX'
027500000106     C                   GOTO      SKPGRT
027600000106     C                   END
027700991230
027800000106     C                   EXSR      #GRATE
027900991230
028000071005     C                   IF        parmfound <> 'Y'
028100991108     C                   Z-ADD     5             X
028200071005     C                   MOVE      tspabct       ERRTXT
028300991108     C                   ADD       1             CNT
028400991108     C                   EXCEPT    PRTERR
028500991108     C                   GOTO      #END
028600991108     C                   END
028700991108      *
028800930615     C     SKPGRT        TAG
028900991101      *
029000991230
029100991108      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
029200991108      * PROCESS ADD OR DELETE COVERAGE
029300991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
029400991108     C                   IF        ACTION = 'A'
029500991108     C                   GOTO      #T0035
029600991108     C                   END
029700991108     C                   IF        ACTION = 'D'
029800991108     C                   GOTO      #T0035
029900991108     C                   END
030000991108     C                   IF        ACTION = 'R'
030100991108     C                   GOTO      #T0035
030200991108     C                   END
030300991230
030400991108     C                   GOTO      #T0040
030500991230
030600991108     C     #T0035        TAG
030700991108      *
030800991108      *  EXECUTE PREMIUM CALCULATION ROUTINE
030900991108      *
031000000217     C                   MOVE      COVYMD        EFFDAT
031100991108     C                   EXSR      #PREM
031200991230
031300991108      * WRITE OUT PLAN ADD OR DELETE RECORD
031400991108      * IF DELETE TRANS., CREDIT PREMIUM.
031500991230
031600991108     C                   MOVE      'P'           TRMFLG
031700991108     C                   IF        ACTION = 'D'
031800071005     C                   Z-SUB     PREM          prem
031900991108     C                   END
032000991230
032100991108     C                   EXCEPT    RECHST
032200991108     C                   SETOFF                                       U4
032300991108     C     #T0040        TAG
032400991108      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
032500991108      * PROCESS COVERAGE TYPE CHANGE
032600991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
032700991108     C                   IF        ACTION = 'C'
032800991108      *
032900991108      *  EXECUTE PREMIUM CALCULATION ROUTINE
033000991108      *
033100000217     C                   MOVE      COVYMD        EFFDAT
033200991108     C                   EXSR      #PREM
033300991108     C                   Z-ADD     PREM          PREMH             7 2
033400991108      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
033500991108      *
033600991108      *
033700991108     C                   MOVE      OLDCOD        TCODE
033800991230
033900000106     C                   EXSR      #GRATE
034000991230
034100071005     C                   IF        parmfound <> 'Y'
034200991108     C                   Z-ADD     7             X
034300071005     C                   MOVE      tspabct       ERRTXT
034400991108     C                   ADD       1             CNT
034500991108     C                   EXCEPT    PRTERR
034600991108     C                   GOTO      #END
034700991108     C                   END
034800991230
034900991108      *  EXECUTE PREMIUM CALCULATION ROUTINE
035000000217     C                   MOVE      COVYMD        EFFDAT
035100991108     C                   EXSR      #PREM
035200071005     C     PREMH         SUB       PREM          prem
035300991108      *
035400991108      * WRITE OUT PLAN CHANGE RECORD
035500991108      *
035600991108     C                   MOVE      'P'           TRMFLG
035700991108     C                   EXCEPT    RECHST
035800991108     C                   SETOFF                                       U4
035900991230
036000991108     C                   END
036100991108      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
036200991108      * PROCESS AGE BAND CHANGE
036300991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
036400991108     C                   IF        ACTION = 'G'
036500991108      *
036600991108      *  EXECUTE PREMIUM CALCULATION ROUTINE
036700991108      *
036800000217     C                   MOVE      COVYMD        EFFDAT
036900991108     C                   EXSR      #PREM
037000991108      *
037100991108      * SAVE (TO AGEBAND) PREM AND GROUP #
037200991108      *
037300920918     C                   MOVE      AGEBND        TOAGB             2 0
037400920918     C                   Z-ADD     PREM          TOPREM            7 2
037500071005     C                   MOVE      grgroup       TOGR#            15
037600991108      *
037700991108      * SAVE FROM AGEBAND
037800991108      *
037900920918     C                   MOVE      OLDCOD        FRAGB             2 0
038000920918     C                   MOVE      OLDCOD        AGEBND
038100991108      *
038200991108      * GET FROM AGEBAND GROUP# AND PREM
038300991108      *
038400000106     C                   EXSR      #GRATE
038500000106
038600071005     C                   IF        parmfound <> 'Y'
038700991108     C                   Z-ADD     7             X
038800071005     C                   MOVE      tspabct       ERRTXT
038900991108     C                   ADD       1             CNT
039000991108     C                   EXCEPT    PRTERR
039100991108     C                   GOTO      #END
039200991108     C                   END
039300991108      *
039400991108      * SAVE (FROM AGEBAND) GROUP#
039500991108      *
039600071005     C                   MOVE      grgroup       FRGR#            15
039700991230
039800991108      *---------- WJP: 06/90 -----------------------------------------
039900991230
040000991108      * SAVE (FROM AGEBAND) PREM
040100991230
040200000217     C                   MOVE      COVYMD        EFFDAT
040300991108     C                   EXSR      #PREM
040400920918     C                   Z-ADD     PREM          FRPREM            7 2
040500991230
040600991101      * IF GROUP# STAYS SAME : WRITE RECORD WITH DIFFERENCE IN
040700991101      * PREM BETWEEN OLD AND NEW AGEBAND. ELSE WRITE 2 RECORDS
040800991101      * WITH ACTUAL PREM INSTEAD DIFFERENCE AND REVERSE SIGN OF
040900991101      * PREM FIELD (NEW = POS , OLD = NEG)
041000991230
041100920918     C                   IF        FRGR# = TOGR#
041200991230
041300920925     C                   MOVE      TOAGB         AGEBND
041400920925     C                   MOVE      FRAGB         OLDCOD
041500071005     C                   MOVE      TOGR#         grgroup
041600071005     C     TOPREM        SUB       FRPREM        prem
041700991108     C                   MOVE      'P'           TRMFLG
041800991108     C                   EXCEPT    RECHST
041900991108     C                   SETOFF                                       U4
042000991230
042100920918     C                   ELSE
042200991230
042300991101      * WRITE 2 RECORDS, USE 'F' FOR ACTION CODE.
042400991101      * 1 REC- SWITCH FROM & TO AGE BAND
042500991230
042600920921     C                   MOVE      'F'           ACTION
042700991108     C                   MOVE      'P'           TRMFLG
042800071005     C                   MOVE      TOGR#         grgroup
042900071005     C                   Z-ADD     TOPREM        prem
043000991108     C                   EXCEPT    RECHST
043100991108     C                   SETOFF                                       U4
043200991230
043300071005     C                   MOVE      FRGR#         grgroup
043400071005     C                   Z-SUB     FRPREM        prem
043500991108     C                   EXCEPT    RECHST
043600991108     C                   END
043700991230
043800991108     C                   END
043900991108      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
044000991108      * PROCESS ENROLLMENT DATE CHANGE
044100991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
044200991108     C                   IF        ACTION = 'E'
044300000217     C                   IF        NEWMO = COVMO
044400000217      *
044500000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
044600000217      *
044700000217     C                   MOVE      COVYMD        EFFDAT
044800000217
044900000217     C                   EXSR      #PREM
045000000217     C                   Z-ADD     PREM          PREMH             7 2
045100000217      *
045200000217      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
045300000217      *
045400000217     C                   MOVE      NEWDAT        EFFDAT
045500000217
045600000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
045700000217
045800000217     C                   EXSR      #PREM
045900071005     C     PREM          SUB       PREMH         prem
046000000217     C                   ELSE
046100071005     C                   MOVE      *ZEROS        prem
046200000217     C                   END
046300000217      *
046400000217      * WRITE OUT PLAN CHANGE RECORD
046500000217      *
046600000217     C                   MOVE      'P'           TRMFLG
046700000217     C                   EXCEPT    RECHST
046800000217     C                   SETOFF                                       U4
046900000217     C                   END
047000000217
047100991108      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
047200991108      * PROCESS COVERAGE CANCELLATION DATE CHANGE
047300991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
047400991108     C                   IF        ACTION = 'H'
047500000217     C                   IF        NEWMO = COVMO
047600000217      *
047700000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
047800000217      *
047900000217     C                   MOVE      COVYMD        EFFDAT
048000000217
048100000217     C                   EXSR      #PREM
048200000217     C                   Z-ADD     PREM          PREMH             7 2
048300000217      *
048400000217      * CALULATE PREMIUM DIFFERENCE FOR COVERAGE CHANGE   *
048500000217      *
048600000217     C                   MOVE      NEWDAT        EFFDAT
048700000217
048800000217      *  EXECUTE PREMIUM CALCULATION ROUTINE
048900000217
049000000217     C                   EXSR      #PREM
049100071005     C     PREM          SUB       PREMH         prem
049200000217     C                   ELSE
049300071005     C                   MOVE      *ZEROS        prem
049400000217     C                   END
049500000217      *
049600000217      * WRITE OUT PLAN CHANGE RECORD
049700000217      *
049800000217     C                   MOVE      'P'           TRMFLG
049900000217     C                   EXCEPT    RECHST
050000000217     C                   SETOFF                                       U4
050100000217     C                   END
050200000217
050300991108      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
050400991108      * PROCESS BENEFIT AMOUNT CHANGE
050500991230      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
050600991108     C                   IF        ACTION = 'B'
050700991108      *
050800991108      *  EXECUTE PREMIUM CALCULATION ROUTINE
050900991108      *
051000000217     C                   MOVE      COVYMD        EFFDAT
051100991108     C                   EXSR      #PREM
051200991108     C                   Z-ADD     PREM          PREMH             7 2
051300991230
051400991108      *
051500991108      *  EXECUTE PREMIUM CALCULATION ROUTINE
051600991108      *
051700991108     C                   EXSR      #PREM
051800071005     C     PREMH         SUB       PREM          prem
051900991108      *
052000991108      * WRITE OUT PLAN CHANGE RECORD
052100991108      *
052200991108     C                   MOVE      'P'           TRMFLG
052300991108     C                   EXCEPT    RECHST
052400991108     C                   SETOFF                                       U4
052500991230
052600991108     C                   END
052700991230
052800991108     C     #END          TAG
052900071005
053000991108      ****************************************************************
053100071005      * adjust premium by remittance percent and prorate
053200071005      ****************************************************************
053300991230
053400991108     C     #PREM         BEGSR
053500991230
053600071005     C                   clear                   prem              7 2
053700991108      *
053800991108     C                   IF        REMITP = 0
053900071005     C                   z-add     netprem       prem
054000991108     C                   ELSE
054100071005     C     REMITP        MULT      bilprem       prem
054200991108     C                   END
054300991230
054400991230      * check for prorate - if needed the field "prem"
054500991230      * will be returned prorated
054600991230
054700000217     c                   if        EFFDY > 01
054800991207     c     pcarr         chain     carmst                             51
054900991207     c                   if        *in51 = *off and cprrul <> '  '
055000000217     c                   eval      holddd = EFFDY
055100000217     c                   eval      FRSTDT = EFFDAT
055200991207     C                   MOVE      01            FRSTDY
055300120822   8 C* set what date to prorate as ENROLLMENT DATE
055400120822     c                   eval      prwhat = 'ENR'
055500991207     c                   exsr      #prorate
055600991207     c                   end
055700991207     c                   end
055800991230
055900991108     C                   ENDSR
056000991230      ***************************************************************
056100991230      * prorate adjustment                                          *
056200991230      ***************************************************************
056300991101     C     #prorate      BEGSR
056400991230
056500991230      *  fields used in pro rate calculation
056600991230      *  -----------------------------------
056700991230      *  holddd    = effective day of term (2.0)
056800991230      *  cprrul    = pro rate rule from carmst (2)
056900991230      *  prem      = billed amount (7.2) (full month)
057000991230      *  dayrateb  = daily rate billed (12.7)
057100991230      *  daysinmo  = # of days in month of prorated amount (2.0)
057200991230      *  daystoadj = # of days to adjust prorated amount   (2.0)
057300991230      *  prorateb  = prorated amount billed (7.2 rounded)
057400991230      *  workdt    = date field for finding last day in month (*ISO)
057500120822   4  *  prwhat    = prorate what date (3) - BOT, ENR, CAN
057600991230
057700000103      * skip if no pro-ration necessary
057800000103
057900000103     C                   if        holddd = 01 or cprrul = '  '
058000991207     c                   goto      #endpr
058100991207     c                   endif
058200991207     c
058300991230      * get total # of days in month of prorated amount
058400991230
058500991105     c                   move      frstdt        workdt
058600991101     c                   adddur    1:*m          workdt
058700991101     c                   subdur    1:*d          workdt
058800991101     c                   extrct    workdt:*d     daysinmo
058900991101
059000991230
059100991230      * if a bad effymd causes the daysinmo to be zero, the divide will
059200991230      * not work so skip
059300991230
059400991101     c                   if        daysinmo = 0
059500991101     c                   goto      #endpr
059600991101     c                   end
059700991230      *
059800991230      * daily rule (01) - prorate to the day
059900991230      *
060000991101     c                   if        cprrul = '01'
060100991108     c                   eval      daystoadj = (daysinmo - holddd) + 1
060200991101     c                   eval      dayrateb  = prem / daysinmo
060300991101     c                   eval(h)   prorateb  = dayrateb * daystoadj
060400991101     c                   eval      prem      = prorateb
060500991101     c                   endif
060600991230      *
060700991230      * mid month rule (02)- cancelled up to the 15th = no premium billed
060800991230      *
060900000209     c                   if        cprrul = '02' and holddd > 15
061000991101     c                   eval      prem   = *zeros
061100991101     c                   endif
061200120822     C*
061300120822   5 C* Full month rule (03) - only charge for full FIRST month when day=01
061400120822   5 C*                        always charge for full LAST month unless
061500120822   4 C*                        day = 01 (no coverage)
061600120822   4 C*
061700120822     c                   if        cprrul = '03' and
061800120822     c                             ((prwhat = 'BOT') or
061900120822     c                             (prwhat = 'ENR' and holddd <> 01) or
062000120822     c                             (prwhat = 'CAN' and holddd = 01))
062100120822     c                   eval      prem   = *zeros
062200120822     c                   endif
062300991230
062400991108     C     #endpr        ENDSR
062500000106
062600000106      ***************************************************************
0627000710050325 C* GET group# and calc prem
062800000106      ***************************************************************
062900000106     C     #GRATE        BEGSR
0630000710050324
0631000710050385 C* clear fields first
0632000710090387 C                   clear                   bilprem
0633000710090387 C                   clear                   netprem
0634000710090387 C                   clear                   grgroup
063500071005
063600071005     c     grplist       plist
063700071005     c                   parm                    parmkey          15
063800140106     C                   PARM                    PARMSSN           9
063900140106     C                   PARM                    PARMSEQ           2
064000071005     c                   parm                    parmeffymd        8
064100071005     c                   parm                    parmbenamt        7
064200071005     c                   parm                    parmgroup        15
064300071005     c                   parm                    parmbilrte       11
064400071005     c                   parm                    parmnetrte       11
064500071005     c                   parm                    parmbilprem       7
064600071005     c                   parm                    parmnetprem       7
064700071005     c                   parm                    parmfound         1
064800140106    *
064900140207    *C                   Exsr      $ACA_CHK
065000140207    *
065100140207     C                   If        AM_I_ACA = YES
065200140207     C                   EVAL      PARMSSN = %EDITC(SSNO:'X')
065300140207     C                   MOVE      DSEQ#         PARMSEQ
065400140207     C                   Else
065500140207     C                   EVAL      PARMSSN = *BLANKS
065600140207     C                   EVAL      PARMSEQ = *BLANKS
065700140207     C                   End
065800140207
065900071005
066000071005     c                   move      tspabct       parmkey
066100071005     c                   move      covymd        parmeffymd
066200071005     c                   move      oldben        parmbenamt
066300071005     c                   clear                   parmgroup
066400071005     c                   clear                   parmbilrte
066500071005     c                   clear                   parmnetrte
066600071005     c                   clear                   parmbilprem
066700071005     c                   clear                   parmnetprem
066800071005     c                   clear                   parmfound
066900071005
067000071005     c                   call      'GETRATE'     grplist
067100071005
067200071005      * premium returned
0673000710050361 C                   if        parmfound = 'Y'
067400071005     c                   move      parmbilprem   bilprem           7 2
067500071005     c                   move      parmnetprem   netprem           7 2
067600071005     c                   move      parmgroup     grgroup
067700140207
067800140207      * If ACA Plan, use the full rate
067900140207     C                   If        AM_I_ACA = YES
068000140211     c                   movel     parmbilrte    bilprem
068100140211     c                   movel     parmnetrte    netprem
068200140207     c                   move      parmgroup     grgroup
068300140207     c                   end
068400071005
068500071005     c                   else
068600071005      * no rate found - do second rate search for 1 month less
0687000710050361 C                   if        covymd = 0
068800071005     C                   leavesr
068900071005     c                   end
069000071005
069100071005     C                   move      covymd        workdt
069200071005     C                   subdur    1:*m          workdt
069300071005     C                   move      workdt        ter2
069400071005     c                   move      tspabct       parmkey
069500071005     c                   move      ter2          parmeffymd
069600071005     c                   move      oldben        parmbenamt
069700071005     c                   clear                   parmgroup
069800071005     c                   clear                   parmbilrte
069900071005     c                   clear                   parmnetrte
070000071005     c                   clear                   parmbilprem
070100071005     c                   clear                   parmnetprem
070200071005     c                   clear                   parmfound
070300071005
070400071005     c                   call      'GETRATE'     grplist
070500071005
070600071005      * premium returned
0707000710050361 C                   if        parmfound = 'Y'
070800071005     c                   move      parmbilprem   bilprem
070900071005     c                   move      parmnetprem   netprem
071000071005     c                   move      parmgroup     grgroup
071100140207
071200140207      * If ACA Plan, use the full rate
071300140207     C                   If        AM_I_ACA = YES
071400140211     c                   movel     parmbilrte    bilprem
071500140211     c                   movel     parmnetrte    netprem
071600140207     c                   move      parmgroup     grgroup
071700140207     c                   end
071800140207
0719001402070363 C                   end
072000071005
0721000710050363 C                   end
0722000710050324 C*******************************************
072300000106
072400000106     C                   ENDSR
072500000106
072600000307      * THIS INITIALIZATION SUBROUTINE IS EXECUTED ONLY ONCE
072700000307     C     *INZSR        BEGSR
072800000307     C                   SETON                                        U4
072900000307     C                   ENDSR
073000140207      *****************************************************************
073100140207     C     $ACA_CHK      BEGSR
073200140207    ***
073300140207     C                   EVAL      AM_I_ACA = NO
073400140207     C                   EVAL      @1 = #CHK_ACA_PLAN(TRUST#:SUB#:PLAN#)
073500140207    ***
073600140207     C                   IF        @1 = 'Y'
073700140207     C                   EVAL      AM_I_ACA = YES
073800140207     C                   ENDIF
073900140207    ***
074000140207     C                   ENDSR
074100140207      *****************************************************************
074200000307
074300991108      *****************************************************************
074400991108      *                                                               *
074500991108      *   O U T  P U T   S E C T I O N                                *
074600991108      *                                                               *
074700991108      *****************************************************************
074800991108     OREPORT    E            HEADER         2 03
074900991108     O                       TIME                15 '  :  :  '
075000991108     O                                           40 '************************'
075100991108     O                                           66 'E R R O R  L I S T I N G'
075200991108     O                                           93 '************************'
075300991108     O                       UDATE         Y    110
075400991108     O          E            HEADER         1
075500991108     O                                           15 'CR012'
075600991108     O                                           65 'MEDICAL FORMAT TRANSMITT'
075700991108     O                                           68 'ALS'
075800991108     O          E            HEADER         1
075900991108     O                                           30 'THE FOLLOWING MEMBERS QU'
076000991108     O                                           54 'ALIFIED FOR THE TRANSMIT'
076100991108     O                                           78 'TAL BUT HAD INVALID DATA'
076200991108     O                                           88 'REASONS:'
076300991108     O          E            HEADER         1
076400991108     O                                           25 '------------------------'
076500991108     O                                           49 '------------------------'
076600991108     O                                           73 '------------------------'
076700991108     O                                           93 '------------------------'
076800991108     O                                          115 '------------------------'
076900991108     O          E            PRTERR      1  1
077000991108     O                       CNT           Z      4
077100991108     O                                            5 ')'
077200991108     O                       SSNO                17 '   -  -    '
077300991108     O                       TRDATE              27
077400991108     O                       TRCODE              32
077500991108     O                       TRUST#              39
077600991108     O                                           40 '-'
077700991108     O                       SUB#                43
077800991108     O                                           44 '-'
077900991108     O                       ACCNO               48
078000991108     O                       CK#NOT             100
078100991108     O                       NOTE2              132
078200991230
078300991108     O          E            PRTERR         1
078400991108     O                       MSG(X)              50
078500991108     O                       ERRTXT         B    80
078600991230
078700991108     O                       COVYMD              98
078800991108     O                                           90 'EFF DT-'
078900991108      *  OUTPUT TRANSMITTAL SORT RECORD / HISTORY RECORD
079000991230
079100991108     OTRANSREC  EADD         RECHST
079200991108     O                       RECORD             160
079300071005     O                       grgroup            177
079400991108     O                       LNAME              202
079500991108     O                       FNAME              215
079600991108     O                       MI                 217
079700071005     O                       prem           B   228
079800991108     O                       PCARR              231
079900991108     O                       ACTION             232
080000991230
080100991108      *  OUTPUT TRANSMITTAL SORT RECORD / NEW RECORD
080200991230
080300991108      *-----------------------------------------------------------------*
080400991108      * UPDATE HISTORY RECORD 'TRMFLG' TRANSMITTAL PRINT FLAG
080500991230
080600991108     OHIST      D    01 U1
080700991108     O                       TRMFLG              86
080800910215**  OUTPUT MESSAGES
080900910215INVALID PLAN KEY FOR TERMINATED EMPLOYEE
081000910215INVALID RATE KEY FOR TERMINATED EMPLOYEE
081100910215INVALID TRANSACTION CODE  ------------->
081200910215INVALID PLAN KEY FOR ADD OR DELETE----->
081300910215INVALID RATE KEY FOR ADD OR DELETE----->
081400910215INVALID RATE KEY FOR CHANGE FROM------->
081500910215INVALID RATE KEY FOR CHANGE TO--------->
081600910215INVALID MCOV KEY FOR ADD OR DELETE----->
081700910215INVALID TRUST KEY --------------------->
08180091021510
