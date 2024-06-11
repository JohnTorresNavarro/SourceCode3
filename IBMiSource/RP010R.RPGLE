000100050920      ******************************************************************
000200050920      *                                                                *
000300050920      *  RP010R     GROUP BENEFIT SERVICES SOFTWARE           1989     *
000400050920      *                                                                *
000500050920      *            MODIFIED BY - DAVID V. GOBEL                        *
000600050920      *            DATE - 03/89                                        *
000700050920      *                                                                *
000800050920      *  DESCRIPTION - THIS PROGRAM WILL PRODUCE A MEMBER COVERAGE     *
000900050920      *                LISTING BY ACCOUNT#.                            *
001000050920      *                                                                *
001100050920      *  DMA  05.11.98 - ADDED COUNTY CODE TO REPORT                   *
001200050920      *  DMA  04.19.99 - TOOK OUT FUTURE COVERAGE TEST PER EB/MARK.    *
0013000509200015  * 11/15/01 DLK - CONVERT TO RPGLE                                *
0014000509200015  * 06/13/02 TWP - ADDED SALESMAN CODE TO PRINTOUT                 *
0015000509200015  * 06/13/02 TWP - ALLOWED SORT BY SALESMAN CODE                   *
0016000509200015  * 10/02/02 TWP - TEST FOR INVALID DATES                          *
0017000509200015  * 12/02/04 DLK - Include empst = 'C' for '*' display             *
0018000509200015  * 09/20/05 DLK - Add mask SSN option                             *
001900071011      * 10/11/07 dlk - convert to use external pgm for grate           *
002000110419      * 04/19/11 dlk - add benefit amount and increase report width    *
002100130614      * 06/14/13 dlk - add csv output choice                           *
002200141107      * 11/07/14 dpb - Write to ext DDS file for xls - calling CL now  *
002300141107      *                uses SQL2JXL to create true xls instead of csv. *
002400050920      ******************************************************************
002500020613JGE01FUTL040    IP   E           K DISK
002600011115JGE01FACCMST    IF   E           K DISK
002700011115JGE01FPLNMST    IF   E           K DISK
002800011115     FCODES     IF   E           K DISK
002900020624     FSMAN      IF   E           K DISK
0030001411060019 Frp010xld  o    e             disk
003100110419     FRP010P    O    F  198        PRINTER OFLIND(*INOF)
003200141106
003300020613     D ISO_DATE        S               D   DATFMT(*ISO)
003400020613     D USA_DATE        S               D   DATFMT(*USA)
003500020613     D DATEIN          S              8  0 INZ(*ZEROS)
003600020613     D DATEOUT         S              8  0 INZ(*ZEROS)
003700020613     D PDESCR2         S             38
003800020613     D MEMCNT          S              5  0 INZ(*ZEROS)
003900020613     D MEMTOT          S              6  0 INZ(*ZEROS)
004000020613     D MEMOUT          S              6  0 INZ(*ZEROS)
004100141106     D AGE             S              3  0 INZ(*ZEROS)
004200020613     D GCOUNT          S              2  0 INZ(*ZEROS)
004300020613     D NAME            S             17
004400020613     D HMSG            S             40
004500020613     D AL              S             30
004600020613     D ZIP5            S              5
004700020613     D ZIP4            S              4
004800020613     D FINIT           S              1
004900020613     D MSG             S             75    DIM(5) CTDATA PERRCD(1)
005000020624     D SMANNAME        S             30
0051000509200037 D ssnoout         S             12
005200071011
0053000710110048 D                 DS
0054001306140133 D  tsa                    1     10  0
0055001306140134 D  MBTRST                 1      3  0
0056001306140135 D  MBSUB#                 4      6  0
0057001306140136 D  MBACCT                 7     10  0
005800130614
0059001306140048 D                 DS
0060000710110055 D tspabct                 1     15
0061000710110055 D mctrst                  1      3  0
0062000710110055 D mcsub#                  4      6  0
0063000710110055 D mcplan                  7     10
0064000710110055 D mcageb                 11     12  0
0065000710110055 D mcovtp2                13     15
006600020624
006700000000     D                 DS
0068001306140055 D birthmdy                1      8  0
006900130614     D  BMO                    1      2  0
007000130614     D  BYR                    5      8  0
007100011115     D                 DS
007200020613     D  MCOVTP
007300020613     D  PRE                           1    OVERLAY(MCOVTP)
007400020613     D  SUF                           2    OVERLAY(MCOVTP:*NEXT)
007500011115     D                 DS
007600071011     D  GRgroup                      15
007700071011     D  GRP#                          6    OVERLAY(GRgroup)
007800000000     D                UDS
007900050920     D  lmask                 33     33
008000130614     D  lpors                 34     34
008100050920     D  CONAME               201    240
008200000000JGE01D  LD8YMD               248    255  0
008300000000JGE01D  LD8YY                248    251  0
008400000000JGE01D  LD8MM                252    253  0
008500141106
008600011115     IUTL04R
008700011115     I                                          MBSSNO        L1
008800011115     I                                          MBTRST        L2
008900011115     I                                          MBSUB#        L2
009000011115     I                                          MBACCT        L2
009100071011
009200071011     c                   move      mcovtp        mcovtp2
009300071011
009400020613     C                   IF        *INL2
009500020613     C     *NOKEY        CLEAR     *ALL          ACCMSR
009600020613     C     ACCKEY        CHAIN     ACCMSR
009700020613     C                   IF        NOT %FOUND(ACCMST)
009800020613     C                   GOTO      END
009900020613     C                   END
010000020624     C                   EXSR      SMAN_SR
010100020624     C                   EXSR      #ADDR
0102001306140262 C                   if        lpors = 'P'
010300011115     C                   EXCEPT    L2HEAD
010400020613     C                   END
010500130614     C                   END
010600011115
010700020612      *?ON MEMBER CHANGE ...
010800020709     C                   IF        *INL1
010900041202     C                   IF        CEXPDT <> 0 or empst = 'C'
011000011115     C                   EVAL      *IN38 = *ON
011100011115     C                   ELSE
011200011115     C                   EVAL      *IN38 = *OFF
011300020613     C                   END
011400011116
011500020613JGE01C                   Z-ADD     BIRTH         DATEIN
011600011116JGE01C                   EXSR      #DATYM
011700130614JGE01C                   Z-ADD     DATEOUT       BIRTHmdy          8 0
011800020612JGE01
011900020613JGE01C                   Z-ADD     EMPDT         DATEIN
012000011116JGE01C                   EXSR      #DATYM
012100130614JGE01C                   Z-ADD     DATEOUT       EMPDTmdy          8 0
012200020612      *?NAME FIELD
012300011115     C                   EXSR      #NAME
012400020612
012500020613     C                   EVAL      *IN25 = *ON
012600020613     C                   ADD       1             MEMCNT
012700020612      *? CALCULATE AGE
012800020613     C                   EVAL      AGE = LD8YY - BYR
012900020613     C                   IF        UMONTH <= 12 AND
013000020613     C                             UMONTH < BMO
013100020613     C                   EVAL      AGE = AGE - 1
013200020613     C                   END
013300020709     C                   END
013400011115
013500020613     C     *NOKEY        CLEAR     *ALL          PLNMSR
013600011116     C     PLNKEY        CHAIN     PLNMST
013700020613     C                   MOVEL     PDESCR        PDESCR2
013800020612
013900020612      *? GET RATE
014000020612
0141000111150074 C                   EVAL      *IN80 = *OFF
0142000710110385 C* clear fields first
0143000710110387 C                   clear                   grgroup
0144000710110073 C*
014500071011     c     grplist       plist
014600071011     c                   parm                    parmkey          15
014700140106     C                   PARM                    PARMSSN           9
014800140106     C                   PARM                    PARMSEQ           2
014900071011     c                   parm                    parmeffymd        8
015000071011     c                   parm                    parmbenamt        7
015100071011     c                   parm                    parmgroup        15
015200071011     c                   parm                    parmbilrte       11
015300071011     c                   parm                    parmnetrte       11
015400071011     c                   parm                    parmbilprem       7
015500071011     c                   parm                    parmnetprem       7
015600071011     c                   parm                    parmfound         1
015700140106    *
015800140106     C                   EVAL      PARMSSN = *BLANKS
015900140106     C                   EVAL      PARMSEQ = *BLANKS
016000071011
016100071011     c                   move      tspabct       parmkey
016200071011     c                   move      ld8ymd        parmeffymd
016300071011     c                   move      benamt        parmbenamt
016400071011     c                   clear                   parmgroup
016500071011     c                   clear                   parmbilrte
016600071011     c                   clear                   parmnetrte
016700071011     c                   clear                   parmbilprem
016800071011     c                   clear                   parmnetprem
016900071011     c                   clear                   parmfound
017000071011
017100071011     c                   call      'GETRATE'     grplist
017200071011
017300071011      * grate not returned
0174000710110361 C                   if        parmfound = 'Y'
017500071011     c                   move      parmgroup     grgroup
017600071011     c                   else
017700071011     C                   EVAL      *IN80 = *ON
017800071011     C                   MOVEL     MSG(1)        HMSG
017900020613     C                   END
018000020612
018100020612      *? GET CODES RECORD
018200020612
018300020613     C     *NOKEY        CLEAR     *ALL          CODESR
018400020613     C     CODKEY        CHAIN     CODESR
018500020612
018600020613JGE01C                   Z-ADD     ENRLDT        DATEIN
018700011116JGE01C                   EXSR      #DATYM
018800130614JGE01C                   Z-ADD     DATEOUT       ENRLDTmdy         8 0
018900020612
019000130614     c                   if        lpors = 'P'
019100020613     C                   IF        *INOF
019200020613     C                   EXCEPT    L2HEAD
019300020613     C                   END
019400130614     c                   end
019500011115
019600050920      * mask SSN
019700050920     c                   eval      ssnoout = (%editw(mbssno:'0   -  -    '))
0198000509200261 c                   if        lmask = 'Y'
0199000509200261 c                   movel     ' XXX-XX'     ssnoout
0200000509200261 c                   end
020100050920
020200130614      * print or xl
020300130614     c                   if        lpors = 'P'
020400011115     C                   EXCEPT    PRT
020500130614     C                   EVAL      *IN25 = *OFF
0206001306140262 C                   else
0207001306140262 C                   exsr      writexldet
020800130614     c                   clear                   hmsg
020900130614     c                   end
021000130614
021100130614
021200020613     C     END           TAG
021300130822     cL1                 if        lpors = 'P'
021400130614     cL1                 except    l1tot
021500130822     cL1                 end
021600020612
021700020613     CL2                 EVAL      MEMTOT = MEMTOT + MEMCNT
021800020613     CL2                 EVAL      MEMOUT = MEMCNT
021900020613     CL2                 EVAL      MEMCNT = *ZEROS
022000130822     cL2                 if        lpors = 'P'
022100130614     cL2                 except    l2tot
022200130822     cL2                 end
022300130614
022400130822     cLR                 if        lpors = 'P'
022500130614     cLR                 except    lrtot
022600130822     cLR                 end
022700020612
022800020612      *?*****************************************************
022900020612      *?   AL = CITY, ST  ZIP
023000020612      *?*****************************************************
023100000000     C     #ADDR         BEGSR
023200020612
023300020613     C                   MOVE      *BLANKS       AL
023400011115     C                   MOVEL     ACITY         AL
023500011115
023600011115     C                   CAT       ',':0         AL
023700011115     C                   CAT       ASTATE:1      AL
023800020613     C                   MOVEL     AZIP          ZIP5
023900020613     C                   MOVE      AZIP          ZIP4
024000011115     C                   CAT       ZIP5:1        AL
024100020613     C                   IF        ZIP4 <> '0000'
024200011115     C                   CAT       '-':0         AL
024300011115     C                   CAT       ZIP4:0        AL
024400011115     C                   END
024500011115
024600011116     C                   IF        ACNAM2 = *BLANKS
024700011115     C                   EVAL      *IN61 = *ON
024800011115     C                   ELSE
024900011115     C                   EVAL      *IN61 = *OFF
025000011115     C                   END
025100011115
025200011116     C                   IF        AADDR2 = *BLANKS
025300011115     C                   EVAL      *IN62 = *ON
025400011115     C                   ELSE
025500011115     C                   EVAL      *IN62 = *OFF
025600011115     C                   END
025700011115
025800000000     C     ENDADR        ENDSR
025900020612
026000020612      *?*****************************************************
026100020612      *?------------- COMPRESS LAST NAME FIRST INIT. -----------*
026200020612      *?    N = LAST, F.
026300020612      *?*****************************************************
026400020612
026500000000     C     #NAME         BEGSR
026600020613     C                   MOVEL     MFNAME        FINIT
026700011115
026800020613     C                   MOVE      *BLANKS       NAME
026900020613     C                   MOVEL     MLNAME        NAME
027000020612
027100020613     C                   CAT       ',':0         NAME
027200020613     C                   CAT       FINIT:1       NAME
027300020613     C                   CAT       '.':0         NAME
027400130614
0275001306140429 C* lname, fname mi.
0276001306140430 C                   clear                   N2               35
0277001306140432 C                   MOVEl     mlname        N2
027800130614     C                   CAT       ',':0         n2
027900130614     C                   CAT       mfname:1      n2
028000130614     C     mmi           IFNE      ' '
028100130614     C                   CAT       mmi:1         N2
028200130614     C                   CAT       '.':0         N2
028300130614     C                   END
0284001306140450 C*
028500011115
028600000000     C                   ENDSR
028700020624      *?*****************************************************
028800020624
028900020624     C     SMAN_SR       BEGSR
029000020624     C     *NOKEY        CLEAR     *ALL          SMANR
029100020624     C     MCSMCD        CHAIN     SMANR
029200020624     C                   IF        %FOUND(SMAN)
029300020624
029400020624     C                   MOVE      *BLANKS       SMANNAME
029500020624     C                   MOVEL     SFNAME        SMANNAME
029600020624
029700020624     C                   CAT       SLNAME:1      SMANNAME
029800020624     C                   END
029900020624
030000020624     C                   ENDSR
030100020612
030200020612      *?*************************************************
030300020612      *?CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
030400020612      *?*************************************************
030500020612
030600020613      *?DATE IN  = DATEIN (8.0) YYYYMMDD
030700020613      *?DATE OUT = DATEOUT (8.0) MMDDYYYY
030800020612
030900000000     C     #DATYM        BEGSR
031000021002     C                   TEST(D)                 DATEIN                 26
031100021002     C                   IF        *IN26 = *ON
031200021002     C                   EVAL      DATEOUT = DATEIN
031300021002     C                   ELSE
031400020613     C     *ISO          MOVE      DATEIN        USA_DATE
031500020613     C                   MOVE      USA_DATE      DATEOUT
031600021002     C                   END
031700021002     C                   ENDSR
031800130614
0319001411060164  *---------------------------------------------------------------------
0320001411060164  * Write Spreadsheet Detail - detailed report only
0321001411060164  *---------------------------------------------------------------------
032200141106       begsr writexldet ;
032300141106
032400141106        account = %trim(%editw(tsa:'0   -   -    ')) ;
032500141106        acctname = acnam1 ;
032600141106        membername = n2 ;
032700141106        ssn = ssnoout ;
032800141106        mbr_age = age ;
032900141106        plan = mcplan ;
033000141106        birthdate = %editw(birthmdy:'  /  /    ') ;
033100141106        employdate = %editw(empdtmdy:'  /  /    ') ;
033200141106        effdate = %editw(enrldtmdy:'  /  /    ') ;
033300141106        group# = grgroup ;
033400141106        covg_type = ldescr ;
033500141106        benefitamt = benamt ;
033600141106        write rp010xldr ;
033700141106        clear rp010xldr ;
033800141106
0339001411060320   endsr ;
034000020612
0341001411060164  *---------------------------------------------------------------------
034200011115     C     *INZSR        BEGSR
034300011115
034400011115     C     PLNKEY        KLIST
034500011115     C                   KFLD                    MCTRST
034600011115     C                   KFLD                    MCSUB#
034700011115     C                   KFLD                    MCPLAN
034800011116
034900011115     C     ACCKEY        KLIST
035000011115     C                   KFLD                    MBTRST
035100011115     C                   KFLD                    MBSUB#
035200011115     C                   KFLD                    MBACCT
035300011116
035400011115     C     CODKEY        KLIST
035500011115     C                   KFLD                    PRE
035600011115     C                   KFLD                    SUF
035700130614
035800141107      * if user requested xls - insert a row showing the date this was exec
035900141106     c                   if        lpors = 'S'
036000141106     C                   eval      account = 'Member Covg'
036100141106     C                   eval      acctname = 'As of ' + %char((%date):*usa)
036200141106     C                   write     rp010xldr
036300141106     C                   clear                   rp010xldr
036400141106     C                   endif
036500141106
036600011115     C                   ENDSR
0367001411060164  *---------------------------------------------------------------------
036800011115     ORP010P    E            L2HEAD         2 03
036900000000     O                                           45 '*****'
037000000000     O                       CONAME              85
037100000000     O                                           91 '*****'
037200011115     O          E            L2HEAD         2
037300000000     O                                           66 'M E M B E R   C O V E R '
037400000000     O                                           87 'A G E   L I S T I N G'
037500011115     O          E            L2HEAD         1
037600000000     O                                           24 'PROGRAM NAME: RP010'
037700110419     O                                          131 'PAGE:'
037800110419     O                       PAGE          Z    142
037900011115     O          E            L2HEAD         1
038000000000     O                                           14 'RUN DATE:'
038100000000     O                       UDATE         Y     25
038200011115     O          E            L2HEAD         1
038300000000     O                                           24 '""""""""""""""""""""""""'
038400000000     O                                           48 '""""""""""""""""""""""""'
038500000000     O                                           72 '""""""""""""""""""""""""'
038600000000     O                                           96 '""""""""""""""""""""""""'
038700000000     O                                          120 '""""""""""""""""""""""""'
038800110419     O                                          142 '""""""""""""""""""""""'
038900011115     O          E            L2HEAD         1
039000000000     O                                            8 'MEMBER'
039100000000     O                                           21 'MEMBER'
039200000000     O                                           43 'BIRTH'
039300000000     O                                           58 'EMPLOYED'
039400000000     O                                           72 'GROUP '
039500000000     O                                           84 'EFFECT.'
039600110419     O                                          142 'BENEFIT'
039700011115     O          E            L2HEAD         1
039800000000     O                                           11 'SOC.SEC.#'
039900000000     O                                           19 'NAME'
040000000000     O                                           35 'SEX'
040100000000     O                                           42 'DATE'
040200000000     O                                           48 'AGE'
040300000000     O                                           56 'DATE'
040400000000     O                                           72 'NUMBER'
040500000000     O                                           82 'DATE'
040600000000     O                                           94 'COV.TYPE'
040700000000     O                                          115 'PLAN DESCRIPTION'
040800110419     O                                          142 'AMOUNT'
040900011115     O          E            L2HEAD         2
041000000000     O                                           24 '""""""""""""""""""""""""'
041100000000     O                                           48 '""""""""""""""""""""""""'
041200000000     O                                           72 '""""""""""""""""""""""""'
041300000000     O                                           96 '""""""""""""""""""""""""'
041400000000     O                                          120 '""""""""""""""""""""""""'
041500110419     O                                          142 '""""""""""""""""""""""'
041600011115     O          E            L2HEAD         1
041700011115     O                       MBTRST              11
041800000000     O                                           12 '-'
041900011115     O                       MBSUB#              15
042000000000     O                                           16 '-'
042100011115     O                       MBACCT              20
042200000000     O                                           31 'PHONE:'
042300000000     O                                           34 '('
042400000000     O                       AAREA         Z     37
042500000000     O                                           38 ')'
042600000000     O                       APHONE              47 '   -   0'
042700000000     O                                           63 'AA CODE    -'
042800000000     O                       AACODE              67
042900020613     O                                           84 'SALESMAN:'
043000020613     O                       MCSMCD              90
043100020624     O                       SMANNAME            +1
043200011115     O          E            L2HEAD         1
043300000000     O                       ACNAM1              48
043400011116     O                                           63 'AVG. AGE   -'
043500000000     O                       AVGAGE              67 '  0'
043600011115     O          E            L2HEAD         1
043700000000     O              N61      ACNAM2              48
043800000000     O               61                          18 'CONTACT IS'
043900000000     O               61      CONTAC              49
044000011115     O          E            L2HEAD         1
044100000000     O              N61                          18 'CONTACT IS'
044200000000     O              N61      CONTAC              49
044300000000     O               61      AADDR1              38
044400000000     O                                           63 'COUNTY     -'
044500011115     O                       ACONTY              66
044600011115     O          E            L2HEAD         1
044700000000     O              N61      AADDR1              38
044800000000     O               61N62   AADDR2              38
044900011116     O               61 62   AL                  38
045000000000     O                                           63 'FAX  #     -'
045100000000     O                                           65 '('
045200000000     O                       FAXARE        Z     68
045300000000     O                                           69 ')'
045400000000     O                       FAX#                78 '   -   0'
045500011115     O          E            L2HEAD         1
045600000000     O              N61N62   AADDR2              38
045700011116     O               61N62   AL                  38
045800011116     O              N61 62   AL                  38
045900011116     O          E   N61N62   L2HEAD         2
046000011116     O                       AL                  38
046100011115     O          E            PRT            1
046200000000     O               25 38                        1 '*'
046300050920     O               25      ssnoout             13
046400020613     O               25      NAME                32
046500000000     O               25      SEX                 34
046600130614JGE01O               25      BIRTHMDY            45 '0 /  /    '
046700000000     O               25      AGE           Z     48
046800130614JGE01O               25      EMPDTmdy            59 '0 /  /    '
046900011115JGE01O                       MCPLAN              64
047000990209JGE01O                       GRP#                71
047100130614JGE01O                       ENRLDTmdy           82 '0 /  /    '
047200990209     O                       SDESCR              93
047300011115JGE01O                       PDESCR2            132
047400000000     O               80      HMSG           B   132
047500110419     O                       benamt        2    142
047600130614     O          e            l1tot          1
047700000000     O                                            5 ' '
047800130614     O          e            l2tot          1
047900000000     O                                           80 '........................'
048000000000     O                                          104 '........................'
048100000000     O                                          120 '................'
048200130614     O          e            l2tot          1
048300000000     O                                           88 'TOTAL MEMBERS FOR THIS'
048400000000     O                                           96 'ACCOUNT'
048500000000     O                       MEMOUT        Z    120
048600130614     O          e            l2tot          1
048700000000     O                                           90 'NOTE : * = COBRA MEMBERS'
048800130614     O          e            l2tot          1
048900000000     O                                           24 '------------------------'
049000000000     O                                           48 '------------------------'
049100000000     O                                           72 '------------------------'
049200000000     O                                           96 '------------------------'
049300000000     O                                          120 '------------------------'
049400110419     O                                          142 '----------------------'
049500130614     O          e            lrtot       2  1
049600000000     O                                           24 '------------------------'
049700000000     O                                           48 '------------------------'
049800000000     O                                           72 '------------------------'
049900000000     O                                           96 '------------------------'
050000000000     O                                          120 '------------------------'
050100110419     O                                          142 '----------------------'
050200130614     O          e            lrtot       1  3
050300000000     O                                           90 'TOTAL MEMBERS FOR THIS L'
050400000000     O                                           96 'ISTING'
050500000000     O                       MEMTOT        Z    120
050600000000** INVOICE MESSAGE ARRAY
050700000000 ** ERROR - RATE RECORD NOT FOUND                                        **
050800000000 ** MSG 2                                                                **
050900000000 ** MSG 3                                                                **
051000000000 ** MSG 4                                                                **
051100000000 ** MSG 5                                                                **
