000100000000      ******************************************************************
000200000000      *                                                                *
000300000414      *   RP020     GROUP BENEFIT SERVICES SOFTWARE           1988     *
000400000000      *                                                                *
000500000000      *            WRITTEN BY - MICHAEL C. DUNPHY                      *
000600000000      *            DATE - 02/20/89                                     *
000700000000      *                                                                *
000800000000      *   DESCRIPTION - THIS PROGRAM WILL PRODUCE AN ACCOUNT LISTING   *
000900990113      *                 FOR                 ALL       ACCOUNTS, WITH   *
001000000000      *                 A MEMBER DETAIL LINE.                          *
001100000000      *                                                                *
003000050923      * 09/23/05 DLK - convert to rpgle                                *
0030010511090020  * 11/09/05 DLK - add column heading override by acct             *
003100000000      *                                                                *
003200000000      ******************************************************************
003300050927     Fmemjoin1  IP   F  736        DISK
003400050923     FGRATE     IF   F   80    15AIDISK    KEYLOC(1)
003500050923     FTRSMST    IF   F  264     3AIDISK    KEYLOC(1)
003600050923     FSUBMST    IF   F  370     6AIDISK    KEYLOC(1)
003700050923     FACCMST    IF   F  560    10AIDISK    KEYLOC(1)
003701051109     fac2mst    IF   E           K Disk
003800050923     FPLNMST    IF   F  200    10AIDISK    KEYLOC(1)
003900050923     FREPORT    O    F  198        PRINTER OFLIND(*INOF)
004000000000     F                                     FORMLEN(88)
004100000000     F                                     FORMOFL(78)
004200000000     D CT              S              8  2 DIM(9)
004300000000     D IT              S              8  2 DIM(9)
004600000000     D BAL             S              9  2 DIM(12)
004700000000     D TAB1            S              2  0 DIM(12) CTDATA PERRCD(1)
004800000000     D TAB2            S             10    DIM(12) ALT(TAB1)
004801051109     D fprefix         s              1a   inz('F')
004802051109     D COLUMN1T        s                   like(ih1t)
004803051109     D COLUMN2T        s                   like(ih2t)
004804051109     D COLUMN3T        s                   like(ih3t)
004805051109     D COLUMN4T        s                   like(ih4t)
004806051109     D COLUMN5T        s                   like(ih5t)
004807051109     D COLUMN6T        s                   like(ih6t)
004808051109     D COLUMN7T        s                   like(ih7t)
004809051109     D COLUMN8T        s                   like(ih8t)
004810051109     D COLUMN9T        s                   like(ih9t)
004811051109     D COLUMN1B        s                   like(ih1b)
004812051109     D COLUMN2B        s                   like(ih2b)
004813051109     D COLUMN3B        s                   like(ih3b)
004814051109     D COLUMN4B        s                   like(ih4b)
004815051109     D COLUMN5B        s                   like(ih5b)
004816051109     D COLUMN6B        s                   like(ih6b)
004817051109     D COLUMN7B        s                   like(ih7b)
004818051109     D COLUMN8B        s                   like(ih8b)
004819051109     D COLUMN9B        s                   like(ih9b)
004901051109
004902051109gsp  D ac2head         DS
004903051109gsp  D  A2IH1T
004904051109gsp  D  A2IH1B
004905051109gsp  D  A2IH2T
004906051109gsp  D  A2IH2B
004907051109gsp  D  A2IH3T
004908051109gsp  D  A2IH3B
004909051109gsp  D  A2IH4T
004910051109gsp  D  A2IH4B
004911051109gsp  D  A2IH5T
004912051109gsp  D  A2IH5B
004913051109gsp  D  A2IH6T
004914051109gsp  D  A2IH6B
004915051109gsp  D  A2IH7T
004916051109gsp  D  A2IH7B
004917051109gsp  D  A2IH8T
004918051109gsp  D  A2IH8B
004919051109gsp  D  A2IH9T
004920051109gsp  D  A2IH9B
004921051109
005100000000     D                 DS
005200000000     D  SUBKEY                 1      6  0
005300000000     D  ACCKEY                 1     10  0
005400000000     D  TRUST                  1      3  0
005500000000     D  SUBNO                  4      6  0
005600000000     D  ACCNO                  7     10  0
005700000000     D***
005800000000     D/SPACE
005900000000     D                UDS
005901050927JGE01D  Lmem                  28     28
006000050923     D  LYEAR                 29     32  0
006100050923     D  LMD                   33     36  0
006200050923     D  LYMD                  29     36  0
006400000000     D  CONAME               201    240
006500000000     D  TIME                 242    247  0
006600990113     D  LD8YMD               248    255  0
006700050927     Imemjoin1  NS  01
006800000000     I                                  1    9 0SSNO          L2
006900000000     I                                 10   27  LNAME
007000000000     I                                 28   28  FINIT
007100000000     I                                 28   39  FNAME
007200000000     I                                 40   40  MI
007300000000     I                             P  125  128 0PHONE
007400000000     I                                136  138 0TRUST         L5
007500000000     I                                139  141 0SUBNO         L4
007600000000     I                                142  145 0ACCNO         L3
008400050923     I                                561  568 0MENRL
008500050923     I                                577  584 0TERMDT
008700050923     I                                660  669  PLNKEY
008800050923     I                                660  674  RATKEY
009000050923     I                                672  674  COVTYP
009100050923     I                             P  687  690 2PREM
009300050923     I                                713  720 0MCENRL
009400050923     I                                721  728 0CANDT
009600000000     I***
009700000000     IPLNMST    NS
009800000000     I*  PLAN MASTER
009900000000     I                                 56   56 0PC
010000000000     I                                163  165  PLNCAT
010100000000     I***
010200000000     IGRATE     NS
010300000000     I*  GROUP RATE FILE
010400000000     I                                  1   15  GRTKEY
010500000000     I                                 24   38  GROUP#
010600050923     I                                 65   72 0FRCYMD
010700050923     I                                 73   80 0TOCYMD
010800000000     I***
010900000000     ITRSMST    NS
011000000000     I*  TRUST MASTER FILE
011100000000     I                                  4   23  TNAME
011200000000     I***
011300000000     ISUBMST    NS
011400000000     I*  SUBDIVISION MASTER FILE
011500000000     I                                  7   26  SUBNAM
011600000000     I                                 77   83  IH1T
011700000000     I                                 84   90  IH1B
011800000000     I                                 91   97  IH2T
011900000000     I                                 98  104  IH2B
012000000000     I                                105  111  IH3T
012100000000     I                                112  118  IH3B
012200000000     I                                119  125  IH4T
012300000000     I                                126  132  IH4B
012400000000     I                                133  139  IH5T
012500000000     I                                140  146  IH5B
012600000000     I                             P  147  149 2ADMFEE
012700000000     I                                150  150 0AC
012800000000     I                                214  220  IH6T
012900000000     I                                221  227  IH6B
013000000000     I                                228  234  IH7T
013100000000     I                                235  241  IH7B
013200000000     I                                242  248  IH8T
013300000000     I                                249  255  IH8B
013400000000     I                                257  263  IH9T
013500000000     I                                264  270  IH9B
013600000000     I***
013700000000     IACCMST    NS
013800000000     I*  ACCOUNT MASTER FILE
013900000000     I                                 11   50  ACNAM1
014000000000     I                                 51   90  ACNAM2                  61
014100000000     I                                 91  120  AADDR1
014200000000     I                                121  150  AADDR2                  62
014300000000     I                                151  165  ACITY
014400000000     I                                166  167  ASTATE
014500000000     I                             P  168  172 0AZIP
014600000000     I                                179  208  CONTAC
014900000000     I                                254  283  INVMSG
015000000000     I                             P  361  420 2BAL
015100000000     I                                424  424 0CI
015200050923     I                                513  520 0ACVTDT
015300050923     I                                517  518 0AM
015400050923     I                                537  544 0ATERM
015500050923     I                                545  552 0AENROL
015501051109
015502051109     C*  CHAIN TO TRUST MASTER FILE FOR TNAME
015503051109     c                   if        *inl5
015506051109     C     TRUST         CHAIN     TRSMST                             H3
015508051109     C                   END
015509051109
015510051109     C*  CHAIN TO SUBDIVISION MASTER FILE FOR SNAME
015511051109     c                   if        *inl4
015514051109     C     SUBKEY        CHAIN     SUBMST                             H4
015516051109     C                   END
015517051109
016500051110     C* ACCOUNT CHANGE
016601051109     c                   if        *inl3
016700051109     C                   SETOFF                                       51
016800051109     C     ACCKEY        CHAIN     ACCMST                             H5
016900051109     C                   MOVE      'Y'           AACT              1
017000051110
017100051109     C     AENROL        IFGT      LYMD
017200000000     C                   MOVE      'N'           AACT
017300000000     C                   GOTO      END
017400000000     C                   END
017500051110
017600051109     C     ATERM         IFGT      0
017700051109     C     ATERM         IFLE      LYMD
017800000000     C                   MOVE      'N'           AACT
017900000000     C                   GOTO      END
018000000000     C                   END
018100000000     C                   END
018101051109
018102051110     c                   if        aact = 'Y'
019100051109     C                   EXSR      #ADDR
0191010511090236 C                   EXSR      #headings
019500051110     C                   SETON                                        2024
019501051110     c                   except
019502051110     C                   SETOff                                       2024
019503051110     c                   end
019504051109     c                   end
019505051109
019506051110      * member change
020201051110     c                   if        *inl2
020300051110     C                   MOVE      'Y'           MACT              1
020500000000     C* CHECK MEMBER TO SEE IF THEY ARE ACTIVE DURING THE SELECTED TIME
020700051110     C     MENRL         IFGT      LYMD
020800000000     C                   MOVE      'N'           MACT
020900000000     C                   END
021100051110     C     TERMDT        IFGT      0
021200051110     C     TERMDT        IFLE      LYMD
021300000000     C                   MOVE      'N'           MACT
021400000000     C                   END
021500000000     C                   END
021900051110     C                   EXSR      #NAME
021901051110     c                   end
021902051110
021903051110
022100000000     C* IS MEMBER ACTIVE ?
022300000000     C     MACT          IFEQ      'N'
022400000000     C                   GOTO      END
022500000000     C                   END
022600051110
022700000000     C* CHECK COVERAGE TO SEE IF IT IS ACTIVE DURING THE SELECTED TIME
022900050923     C     MCENRL        IFGT      LYMD
023000000000     C                   GOTO      END
023100000000     C                   END
023200051110
023300000000     C     CANDT         IFGT      0
023400050923     C     CANDT         IFLE      LYMD
023500000000     C                   GOTO      END
023600000000     C                   END
023700000000     C                   END
023800000000     C***
023900000000     C* GET PLAN RECORD
024000000000     C***
024100000000     C     PLNKEY        CHAIN     PLNMST                             H1
024200000000     C/SPACE
024300000000     C***
024400000000     C*  GET RATE RECORD
024500000000     C***
024600000000     C*------- WJP 06/90: NEW GRATE PROCESSING. READ INSTEAD OF CHAIN
024700000000     C***
024800000000     C                   SETOFF                                       44  60
024900000000     C                   Z-ADD     *ZEROS        GCOUNT
025000000000     C     RATKEY        SETLL     GRATE
025100000000     C***
025200000000     C     #READ         TAG
025300000000     C***
025400000000     C                   READ      GRATE                                  60
025500000000     C  N60RATKEY        COMP      GRTKEY                             6060
025600000000     C   60              GOTO      #SKIP1
025700000000     C***
025800050923     C     LYMD          IFGE      FRCYMD
025900050923     C     LYMD          IFLE      TOCYMD
026000000000     C                   ADD       1             GCOUNT            2 0
026100000000     C                   GOTO      #SKIP1
026200000000     C                   END
026300000000     C                   END
026400000000     C***
026500000000     C                   GOTO      #READ
026600000000     C***
026700000000     C     #SKIP1        TAG
026800000000     C***
026900000000     C     GCOUNT        IFEQ      *ZERO
027000000000     C                   SETON                                            44
027100000000     C                   END
027200000000     C***
027300000000     C     PLNCAT        IFEQ      'PMM'
027400000000     C***
027500000000     C*  PLACE GRP#,EFF DATE, AND COV TYPE IN OUTPUT ARRAY
027600000000     C***
027700000000     C                   MOVEL     GROUP#        GRPOUT            6
027800990113    1C                   MOVE      MCENRL        @DATIN
027900990113   01C                   EXSR      #DATYM
028000990113   01C                   MOVE      @DATOU        ENROUT            8 0
028100000000     C                   MOVE      COVTYP        COVOUT            2
028200000000     C                   MOVE      'Y'           MEDPLN            1
028300000000     C                   SETON                                        50
028400000000     C/SPACE
028500000000     C                   ELSE
028600000000     C/SPACE
028700000000     C     PLNCAT        IFEQ      'PMS'
028800000000     C                   MOVEL     GROUP#        GRPOUT
028900990113    1C                   MOVE      MCENRL        @DATIN
029000990113   01C                   EXSR      #DATYM
029100990113   01C                   MOVE      @DATOU        ENROUT
029200000000     C                   MOVE      COVTYP        COVOUT
029300000000     C                   SETON                                        50
029400000000     C                   END
029500000000     C                   END
029600000000     C***
029700000000     C***
029800000000     C* TOTAL UP PREMIUMS
029900000000     C***
030000000000     C                   ADD       PREM          CT(PC)
030100000000     C                   ADD       PREM          IT(PC)
030200000000     C***
030300000000     C     END           TAG
030400000000     C***
030500000000     C************************************************************
030600000000     C*  END OF DETAIL CALCULATIONS                              *
030700000000     C************************************************************
030800000000     C/SPACE
030900000000     C***
031000000000     C*  SKIP NON ACTIVE ACCOUNTS
031100000000     C***
031200000000     CL2   AACT          IFEQ      'N'
031300000000     CL2                 GOTO      SKIP2
031400000000     CL2                 END
031500000000     C***
031600000000     C*  SKIP NON ACTIVE MEMBERS
031700000000     C***
031800000000     CL2   MACT          IFEQ      'N'
031900000000     CL2                 GOTO      SKIP2
032000000000     CL2                 END
032100000000     C***
032200000000     C*  EXCEPT SSNO LINE AFTER ALL COVERAGES PROCESSED
032300000000     C***
032400000000     CL2                 XFOOT     CT            STOT              8 2
032500000000     CL2                 ADD       STOT          ATOT              8 2
032600000000     CL2                 SETON                                        22
032601051110     Cl2 of              SETON                                        2024
032700000000     CL2                 EXCEPT
032703051110     Cl2                 SETOFF                                       2024
032800000000     CL2                 SETOFF                                       2250
032900000000     C***
033000000000     CL2   SKIP2         TAG
033100000000     C***
033200000000     C*  IF NON-ACTIVE ACCOUNT - SKIP
033300000000     C***
033400000000     CL3   AACT          IFEQ      'N'
033500000000     CL3                 GOTO      SKIP3
033600000000     CL3                 END
033700000000     C***
033800000000     C*  EXCEPT ACCOUNT TOTALS AFTER ALL MEMBERS PROCESSED
033900000000     C***
034000000000     C*3         APRBAL    ADD  ACUBAL    TOTDUE  82
034100000000     CL3                 XFOOT     BAL           TOTDUE            8 2
034200000000     CL3   TOTDUE        SUB       BAL(AM)       APRBAL            9 2
034300000000     CL3                 Z-ADD     BAL(AM)       ACUBAL            9 2
034400000000     C***
034500000000     CL3                 SETON                                        23
034501051110     CL3 of              SETON                                        2024
034600000000     CL3                 EXCEPT
034700000000     CL3                 SETOFF                                       2332
034701051110     CL3                 SETOFF                                       2024
034800000000     C***
034900000000     CL3   SKIP3         TAG
034901050923
034902050923      **********************************************************
035500000000     C*    AL = CITY, ST  ZIP
035600000000     C*--------------- COMPRESS CITY/STATE/ZIP ------------------*
035800000000     C     #ADDR         BEGSR
036200050923     C                   clear                   AL               30
036400050923     C                   MOVEl     ACITY         AL
036401050923     c                   cat       ',':0         al
036402050923     c                   cat       astate:1      al
036403050923     c                   cat       '.':0         al
036404050923
036405050923     C                   MOVEL     AZIP          ZIP5              5
036406050923     C                   MOVE      AZIP          ZIP4              4
036407050923     c                   cat       zip5:1        al
036408050923     C                   IF        ZIP4 <> '0000'
036409050923     c                   cat       '-':0         al
036410050923     c                   cat       zip4:0        al
036411050923     C                   END
039600000000     C     ENDADR        ENDSR
039700000000     C***
039800000000     C*     N = LAST, F.
039900000000     C*--------------- COMPRESS LAST NAME FIRST INIT. -------------*
040000000000     C***
040100000000     C     #NAME         BEGSR
040101050923     C                   clear                   N                17
040102050923     C                   MOVEL     lname         N
040105050923     C                   CAT       ',':0         N
040107050923     C                   CAT       finit:1       N
040108050923     C                   CAT       '.':0         N
040109050923
042600000000     C                   ENDSR
042700000000     C***
042800000000     C***************************************************
042900000000     C*   CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY       *
043000000000     C***************************************************
043100000000     C***
043200000000     C*  DATE IN  = @DATIN (8.0) YYYYMMDD
043300000000     C*  DATE OUT = @DATOU (8.0) MMDDYYYY
043400000000     C***
043500000000     C     #DATYM        BEGSR
043600000000     C                   MOVE      @DATIN        @MD               4 0
043700000000     C                   MOVEL     @DATIN        @Y                4 0
043800000000     C                   MOVEL     @MD           @DATOU            8 0
043900000000     C                   MOVE      @Y            @DATOU
044000000000     C                   MOVE      *ZEROS        @DATIN            8 0
044100000000     C                   ENDSR
044101051109
044102051109      ****************************************
044103051109      * set headings for this account
044104051109      ****************************************
044105051109   9 C     #headings     begsr
044106051109
044107051109      * if override was entered, use it
044108051109
0441090511090234 C     ac2key        CHAIN     ac2mst
044110051109     c                   if        %found(ac2mst) and ac2head <> *blanks
044111051109     c                   movel     A2IH1T        column1t
044112051109     c                   movel     A2IH1B        column1b
044113051109     c                   movel     A2IH2T        column2t
044114051109     c                   movel     A2IH2B        column2b
044115051109     c                   movel     A2IH3T        column3t
044116051109     c                   movel     A2IH3B        column3b
044117051109     c                   movel     A2IH4T        column4t
044118051109     c                   movel     A2IH4B        column4b
044119051109     c                   movel     A2IH5T        column5t
044120051109     c                   movel     A2IH5B        column5b
044121051109     c                   movel     A2IH6T        column6t
044122051109     c                   movel     A2IH6B        column6b
044123051109     c                   movel     A2IH7T        column7t
044124051109     c                   movel     A2IH7B        column7b
044125051109     c                   movel     A2IH8T        column8t
044126051109     c                   movel     A2IH8B        column8b
044127051109     c                   movel     A2IH9T        column9t
044128051109     c                   movel     A2IH9B        column9b
044129051109
044130051109     c                   else
044131051109
044132051109     c                   movel     IH1T          column1t
044133051109     c                   movel     IH1B          column1b
044134051109     c                   movel     IH2T          column2t
044135051109     c                   movel     IH2B          column2b
044136051109     c                   movel     IH3T          column3t
044137051109     c                   movel     IH3B          column3b
044138051109     c                   movel     IH4T          column4t
044139051109     c                   movel     IH4B          column4b
044140051109     c                   movel     IH5T          column5t
044141051109     c                   movel     IH5B          column5b
044142051109     c                   movel     IH6T          column6t
044143051109     c                   movel     IH6B          column6b
044144051109     c                   movel     IH7T          column7t
044145051109     c                   movel     IH7B          column7b
044146051109     c                   movel     IH8T          column8t
044147051109     c                   movel     IH8B          column8b
044148051109     c                   movel     IH9T          column9t
044149051109     c                   movel     IH9B          column9b
044150051109     c                   end
044151051109
044152051109   9 C                   ENDSR
044153050923
044200000000     C***
044201050923     C*  FIRST CYCLE INITIALIZE FIELDS
044202050923     C***
044203050923     C     *inzsr        begsr
044204050923     C                   MOVEL     'I'           CONTRL           15
044205050923     C                   MOVE      'N'           MEDPLN
044206050923     C                   SETON                                        24
044207050927      * set heading control
044208050927     c                   if        lmem = 'C'
044209050927     c                   eval      *in91 = *on
044210050927     c                   else
044211050927     c                   if        lmem = 'B'
044212050927     c                   eval      *in92 = *on
044213050927     c                   end
044214050927     c                   end
044215050927
044216051109     C     ac2key        KLIST
044217051109     C                   KFLD                    fprefix
044218051109     C                   KFLD                    TRUST
044219051109     C                   KFLD                    SUBNO
044220051109     C                   KFLD                    ACCNO
044221051109     C*
044222050923     C                   ENDSR
044300000000     O***
044400000000     O/EJECT
044500000000     O******************************************************
044600000000     O*  OUTPUT SPECIFICATIONS                             *
044700000000     O******************************************************
044800000000     O***
044900000000     OREPORT    E    24                     2 03
045000000000     O                                           78 '*****'
045100000000     O                       CONAME             118
045200000000     O                                          124 '*****'
045300000000     O***
045400000000     O          E    24                     2
045500000000     O                                           99 'A C C O U N T'
045600000000     O                                          108 'L I S T'
045700000000     O                                          110 '-'
045800990113     O                       LMD                114 '  /  '
045900990113     O                                          115 '/'
046000990113     O                       LYEAR              119
046100000000     O***
046200050927     O          E    24 91                  1
046300000000     O                                          100 'COBRA '
046400000000     O***
046500050927     O          E    24 92                  1
046600000000     O                                          108 'COBRA & NON-COBRA'
046700000000     O***
046800050927     O          E    24N91N92               1
046900000000     O                                          103 'NON-COBRA'
047000000000     O***
047100000000     O          E    24                     1
047200000000     O                                           24 'PROGRAM NAME: RP020'
047300000000     O                                          190 'PAGE:'
047400000000     O                       PAGE          Z    198
047500000000     O***
047600000000     O          E    24                     1
047700000000     O                                           14 'RUN DATE:'
047800000000     O                       UDATE         Y     25
047900000000     O                                          190 'TIME:'
048000000000     O                       TIME               198 '  :  :  '
048100000000     O***
048200000000     O          E    24                     1
048300000000     O                                           24 '""""""""""""""""""""""""'
048400000000     O                                           48 '""""""""""""""""""""""""'
048500000000     O                                           72 '""""""""""""""""""""""""'
048600000000     O                                           96 '""""""""""""""""""""""""'
048700000000     O                                          120 '""""""""""""""""""""""""'
048800000000     O                                          144 '""""""""""""""""""""""""'
048900000000     O                                          168 '""""""""""""""""""""""""'
049000000000     O                                          192 '""""""""""""""""""""""""'
049100000000     O                                          198 '""""""'
049200000000     O***
049300000000     O          E    24                     1
049400000000     O                                            8 'MEMBER'
049500000000     O                                           28 'MEMBER'
049600000000     O                                           40 'GROUP '
049700050923     O                                           54 'EFFECT.'
049800000000     O                                           60 'COV.'
049900051109     O                       COLUMN1T            71
050000051109     O                       COLUMN2T            83
050100051109     O                       COLUMN3T            95
050200051109     O                       COLUMN4T           107
050300051109     O                       COLUMN5T           119
050400051109     O                       COLUMN6T           131
050500051109     O                       COLUMN7T           143
050600051109     O                       COLUMN8T           155
050700051109     O                       COLUMN9T           167
050800000000     O                                          198 'TOTAL'
050900000000     O***
051000000000     O          E    24                     1
051100000000     O                                           10 'SOC.SEC.#'
051200000000     O                                           27 'NAME'
051300000000     O                                           40 'NUMBER'
051400000000     O                                           51 'DATE'
051500000000     O                                           60 'TYPE'
051600051109     O                       COLUMN1B            71
051700051109     O                       COLUMN2B            83
051800051109     O                       COLUMN3B            95
051900051109     O                       COLUMN4B           107
052000051109     O                       COLUMN5B           119
052100051109     O                       COLUMN6B           131
052200051109     O                       COLUMN7B           143
052300051109     O                       COLUMN8B           155
052400051109     O                       COLUMN9B           167
052500000000     O                                          198 'AMOUNT'
052600000000     O***
052700000000     O          E    24                     2
052800000000     O                                           24 '""""""""""""""""""""""""'
052900000000     O                                           48 '""""""""""""""""""""""""'
053000000000     O                                           72 '""""""""""""""""""""""""'
053100000000     O                                           96 '""""""""""""""""""""""""'
053200000000     O                                          120 '""""""""""""""""""""""""'
053300000000     O                                          144 '""""""""""""""""""""""""'
053400000000     O                                          168 '""""""""""""""""""""""""'
053500000000     O                                          192 '""""""""""""""""""""""""'
053600000000     O                                          198 '""""""'
053700000000     O***
053800000000     O          E    24                     1
053900000000     O                                           24 '------------------------'
054000000000     O                                           48 '------------------------'
054100000000     O                                           72 '------------------------'
054200000000     O                                           96 '------------------------'
054300000000     O                                          120 '------------------------'
054400000000     O                                          144 '------------------------'
054500000000     O                                          168 '------------------------'
054600000000     O                                          192 '------------------------'
054700000000     O                                          198 '------'
054800000000     O***
054900000000     O          E    20                     1
055000000000     O                       TRUST                8
055100000000     O                                            9 '-'
055200000000     O                       SUBNO               12
055300000000     O                                           13 '-'
055400000000     O                       ACCNO               17
055500000000     O***
055600000000     O          E    20                     1
055700000000     O                       ACNAM1              45
055800000000     O***
055900000000     O          E    20                     1
056000000000     O              N61      ACNAM2              45
056100000000     O               61                          15 'CONTACT IS'
056200000000     O               61      CONTAC              46
056300000000     O***
056400000000     O          E    20                     1
056500000000     O              N61                          15 'CONTACT IS'
056600000000     O              N61      CONTAC              46
056700000000     O               61      AADDR1              35
056800000000     O***
056900000000     O          E    20                     1
057000000000     O              N61      AADDR1              35
057100000000     O               61N62   AADDR2              35
057200000000     O               61 62N51AL                  35
057300000000     O               61 62 51                    35 'NOT AVAILABLE'
057400000000     O***
057500000000     O          E    20                     1
057600000000     O              N61N62   AADDR2              35
057700000000     O               61N62N51AL                  35
057800000000     O               61N62 51                    35 'NOT AVAILABLE'
057900000000     O              N61 62N51AL                  35
058000000000     O              N61 62 51                    35 'NOT AVAILABLE'
058100000000     O***
058200000000     O          E    20                     1
058300000000     O              N61N62N51AL                  35
058400000000     O              N61N62 51                    35 'NOT AVAILABLE'
058500000000     O***
058600000000     O          E    22                     1
058700050923     O                       SSNO                12 '0   -  -    '
058800000000     O                       N                   31
058900000000     O               50      GRPOUT         B    40
059000000000     O              N50                          40 '****'
059100000000     O               44                          44 '** NO RATE **'
059200990113     O               50      ENROUT         B    55 '  /  /    '
059300050923     O               50      COVOUT         B    59
059400000000     O                       CT(1)         MB    71
059500000000     O                       CT(2)         MB    83
059600000000     O                       CT(3)         MB    95
059700000000     O                       CT(4)         MB   107
059800000000     O                       CT(5)         MB   119
059900000000     O                       CT(6)         MB   131
060000000000     O                       CT(7)         MB   143
060100000000     O                       CT(8)         MB   155
060200000000     O                       CT(9)         MB   167
060300000000     O                       STOT          MB   198
060400000000     O***
060500000000     O          E    23                     1
060600000000     O                                           80 '     ...................'
060700000000     O                                          104 '........................'
060800000000     O                                          128 '........................'
060900000000     O                                          152 '........................'
061000000000     O                                          176 '........................'
061100000000     O                                          198 '......................'
061200000000     O***
061300000000     O          E    23                     2
061400000000     O                       IT(1)         MB    71
061500000000     O                       IT(2)         MB    83
061600000000     O                       IT(3)         MB    95
061700000000     O                       IT(4)         MB   107
061800000000     O                       IT(5)         MB   119
061900000000     O                       IT(6)         MB   131
062000000000     O                       IT(7)         MB   143
062100000000     O                       IT(8)         MB   155
062200000000     O                       IT(9)         MB   167
062300000000     O                       ATOT          MB   198
062400000000     O***
062500000000     O          E    23                     1
062600000000     O                                          170 'PREVIOUS BALANCE--->'
062700000000     O                       APRBAL        L    185
062800000000     O          E    23                     1
062900000000     O                                          170 'LAST PREMIUM BILLED--->'
063000000000     O                       ACUBAL        L    185
063100000000     O***
063200000000     O          E    23                     1
063300000000     O                                          170 'TOTAL BAL.DUE------>'
063400000000     O                       TOTDUE        L    185
063500000000     O***
063600000000     O          E    23                     1
063700000000     O                                           24 '------------------------'
063800000000     O                                           48 '------------------------'
063900000000     O                                           72 '------------------------'
064000000000     O                                           96 '------------------------'
064100000000     O                                          120 '------------------------'
064200000000     O                                          144 '------------------------'
064300000000     O                                          168 '------------------------'
064400000000     O                                          192 '------------------------'
064500000000     O                                          198 '------'
065200000000** MONTH NAME TABLE
06530000000001January
06540000000002February
06550000000003March
06560000000004April
06570000000005May
06580000000006June
06590000000007July
06600000000008August
06610000000009September
06620000000010October
06630000000011November
06640000000012December
