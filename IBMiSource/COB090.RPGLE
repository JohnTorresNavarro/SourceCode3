0001009102150002 F******************************************************************
0002000004140003 F* COB090     GROUP BENEFIT SERVICES SOFTWARE           1990      *
0003009102150004 F*                                                                *
0004009102150005 F*            WRITTEN BY - DAVID KETTERMAN                        *
0005009104240006 F*            DATE - 04/24/91                                     *
0006009102150007 F*                                                                *
0007009104240008 F*  DESCRIPTION - THIS PROGRAM WILL REINSTATE A MEMBER AND        *
0008009104240009 F*                NOT BLANK OUT COBRA INFORMATION LIKE THE        *
0009009104240010 F*                NORMAL REINSTATE DOES IN FM070.                 *
0010009102150011 F*                                                                *
0011009807290010 F*  Y2K CONVERT - 1998                                            *
0012000003300010 F* 03/30/00 dlk - convert to rpgle                                *
0013000412130010 F* 12/13/04 dlk - add edit for cobra service                      *
0014000506130010 F* 06/13/05 dlk - fix operid                                      *
001500130521      * 05/21/13 dlk - add depend reinstate hist rec
001600131010     F* 10/10/13 sbt - hist file expansion project                     *
0017009102150012 F*                                                                *
0018009102150013 F******************************************************************
0019000412130014 FWKSTN     CP   F  152        WORKSTN
0020000003300016 FMEMBER    UF   F  648     9AIDISK    KEYLOC(1)
0021000003300051 FDEPEND    UF   F  360     9AIDISK    KEYLOC(1)
0022000412130017 FACCMST    UF   e           k DISK
0023001310100061 FHIST      O  A F  216    10AIDISK    KEYLOC(1)
0024009102150018 D*   ERROR MESSAGE ARRAY
0025009102150019 D MSG             S             45    DIM(5) CTDATA PERRCD(1)
0026009104250095 D DOM             S              2  0 DIM(12) CTDATA PERRCD(12)
002700130521     D his_covtdt      s              8s 0
002800130521     D zero8           s              8s 0 inz
002900130521     D trcode          s              3a
003000131010     D hstrtime        s              8t
003001131025     D thispgmname     S             10a   inz('COB090    ')
0031009102150041 D*
0032009104250042 D                 DS
0033009807290042 D  REFDT                  1      8  0
0034009104250042 D  MM                     1      2  0
0035009807290042 D  DD                     3      4  0
0036009102150042 D                UDS
0037001310140692 D  loperid                1     10
0038009102150043 D  CONAME               201    240
0039009807290043 D  UDATE8               248    255
0040009104250031 IWKSTN     NS  01    1 C0    2 C1
0041009104250032 I* FORMAT-SCRN01
0042009104250034 I                                  3   11 0SSN
0043009104250035 I          NS  02    1 C0    2 C2
0044009104250036 I* FORMAT-SCRN02
0045009807290038 I                                  3   10 0REFDT
0046009104290040 I          NS  90
0047009102150020 IMEMBER    NS
0048009102150021 I*  MEMBER FILE
0049009102150022 I                                  1    9 0SSNO
0050009102150023 I                                 10   27  LNAME
0051009102150024 I                                 28   39  FNAME
0052009102150025 I                                 40   40  MI
0053009102150026 I                                136  145 0TSA
0054000412130026 I                                136  138 0mbtrst
0055000412130026 I                                139  141 0mbsub#
0056000412130026 I                                142  145 0mbacct
0057009807290027 I                                577  584 0TERMDT
0058009104240333 IDEPEND    NS
0059009104240335 I                                  1    9 0DSSNO
0060009104240336 I                                 10   11 0DSEQ#
006100910429     I                                320  320  DDLTCD
0062009102150044 C*
0063009102150045 C* FIRST CYCLE ONLY
0064009102150046 C*
0065009102150047 C   90              EXCEPT    SCRN01
0066009104290048 C   90              Z-ADD     *ZEROS        ZERO9             9 0
0067009104290048 C   90              Z-ADD     *ZEROS        ZERO7             7 0
0068009104290048 C   90              GOTO      #END
006900041213
007000041213     c     memkey        klist
007100041213     c                   kfld                    mbtrst
007200041213     c                   kfld                    mbsub#
007300041213     c                   kfld                    mbacct
0074009102150049 C*
0075009102150050 C*  SETOF SCREEN OUTPUT
0076009102150051 C*
0077009102150052 C                   SETOFF                                       55
0078009102150053 C*
0079009102150054 C* RETURN TO SCREEN 1 ON CMD-1
0080009102150055 C*
0081009102150056 C   KA              EXCEPT    SCRN01
0082009102150057 C   KA              GOTO      #END
0083009102150058 C*
0084009102150059 C* END ON CMD-7
0085009102150060 C*
0086009102150061 C   KG              SETOFF                                       0102
0087009102150062 C   KG              SETON                                        LR
0088009102150063 C*
0089009102150064 C* SELECT SCREEN
0090009102150065 C*
0091009102150066 C   01              EXSR      #SCR1
0092009102150067 C   02              EXSR      #SCR2
0093009102150068 C*
0094009102150069 C     #END          TAG
0095009102150070 C/EJECT
0096009102150071 C********************************************************************
0097009102150072 C*                S U B R O U T I N E S                             *
0098009102150073 C********************************************************************
009900910429     C/SPACE
0100009102150074 C**************************************
0101009102150075 C* SCREEN 1 SUBROUTINE                *
0102009102150076 C**************************************
0103009102150077 C     #SCR1         BEGSR
0104009102150078 C   KG              SETON                                            LR
0105009102150079 C   KG              GOTO      #EN01
0106009102150080 C*
0107009102150081 C     SSN           CHAIN     MEMBER                             11
0108009102150082 C   11              Z-ADD     1             X                 1 055
0109009102150083 C   11              GOTO      #T0005
0110009102150084 C*
0111009104250085 C     TERMDT        IFEQ      0
0112009104250086 C                   Z-ADD     2             X                    55
0113009102150087 C                   GOTO      #T0005
011400980729     C                   ELSE
011500980729     C                   MOVE      TERMDT        @DATIN
011600980729     C                   EXSR      #DATYM
011700980729     C                   MOVE      @DATOU        TERMDT
0118009102150088 C                   END
0119009102150089 C*
0120000412130090 C     memkey        CHAIN     ACCMST                             H1
012100041213
012200041213     c                   if        fcstfl = 'N' or acobsrv = 'L'
0123000412130086 C                   Z-ADD     4             X                    55
012400041213     c                   except    relacc
0125000412130087 C                   GOTO      #T0005
012600041213     c                   end
012700041213
012800910430     C                   MOVE      *ZEROS        REFDT
0129009102150091 C                   EXCEPT    SCRN02
0130009102150092 C* SKIP ERROR TAG
0131009102150093 C                   GOTO      #EN01
0132009102150094 C*
0133009102150095 C* #T0005 IS THE TAG TO DISPLAY THE ERROR MESSAGES FOR SCREEN 1
0134009102150096 C* AND END THE SUBROUTINE. ALL SCREEN 1 ERRORS WILL GO TO HERE.
0135009102150097 C*
0136009102150098 C     #T0005        TAG
0137009102150099 C                   EXCEPT    SCRN01
0138009102150100 C*
0139009102150101 C     #EN01         ENDSR
0140009104290102 C/EJECT
0141009102150103 C**************************************
0142009102150104 C* SCREEN 2 SUBROUTINE                *
0143009102150105 C**************************************
0144009102150106 C     #SCR2         BEGSR
0145009102150107 C*
0146009102150108 C   KA              EXCEPT    SCRN01
0147009102150109 C   KA              GOTO      #EN02
0148009102150110 C*
0149009102150111 C   KG              SETON                                        LR
0150009102150112 C   KG              GOTO      #EN02
0151009102150113 C*
0152009104250113 C* VALIDATE EFFECTIVE DATE
0153009104250113 C*
0154009104253887 C     MM            COMP      1                                    98
0155009104253888 C  N98MM            COMP      12                                 98
0156009104253891 C*
0157009104253892 C  N98DD            COMP      1                                    98
0158009104253893 C  N98DD            COMP      DOM(MM)                            98
0159009104253894 C*
016000910429     C   98              Z-ADD     3             X                    55
016100910425     C   98              EXCEPT    SCRN02
016200910425     C   98              GOTO      #EN02
0163009104292473 C*
0164009104292474 C* UPDATE MEMBER REC AND ADD HIST REC.
0165009104292475 C*
016600980729     C                   MOVE      REFDT         @DATIN
016700980729     C                   EXSR      #DATMY
016800980729     C                   MOVE      @DATOU        REFDT
0169009807292451 C*
0170009104290115 C                   EXCEPT    UPMEM
017100131010     c                   eval      hstrtime = %time
0172009104290115 C                   EXCEPT    ADHIS
0173009104292451 C*
0174000002172452 C* LOOP AND REINSTATE DEPENDENTS
0175009104292453 C*
0176009104292454 C                   SETOFF                                           95
0177009104292455 C     SSN           SETLL     DEPEND
0178009104292456 C     #T0010        TAG
0179009104292457 C     SSN           READE     DEPEND                                 95
018000910429     C   95              EXCEPT    RELDEP
0181009104292458 C   95              GOTO      #T0020
0182009104292459 C     DDLTCD        IFEQ      'C'
0183009104292462 C                   EXCEPT    REDEP
018400130521      ******
018500130521      * write depend reinstate hist rec
018600130521     c                   clear                   note2            30
018700130521     c                   eval      trcode = 'MDF'
018800130521     c                   eval      note2 = 'Dep#-'
018900130521     c                   move      dseq#         dseq#char         2
019000130521     c                   cat       dseq#char:1   note2
019100130521     c*** No code avail  cat       'Code-':2     note2
019200130521     c*** No code avail  cat       key3:1        note2
019300130521     c                   eval      his_covtdt = refdt
019400131010     c                   eval      hstrtime = %time
019500130521     c                   except    histdep
019600130521      ******
0197009104292464 C                   END
0198009104292465 C                   GOTO      #T0010
0199009104292466 C     #T0020        TAG
0200009104292467 C*
0201009104292468 C* UPDATE MEMBER COUNT IN ACCMST
0202009104292469 C*
0203000412132470 C     memkey        CHAIN     ACCMST                             H1
0204009104292471 C                   ADD       1             NOEMPL
0205009104292472 C                   EXCEPT    UPACC
0206009102150117 C*
0207009102150118 C                   EXCEPT    SCRN01
0208009102150119 C*
0209009102150120 C     #EN02         ENDSR
0210009807290107 C*
0211009807290103 C***************************************************
0212009807290104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0213009807290105 C***************************************************
0214009807290107 C*
0215009807290107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0216009807290107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0217009807290107 C*
0218009807290106 C     #DATYM        BEGSR
021900980729     C                   MOVE      @DATIN        @MD               4 0
022000980729     C                   MOVEL     @DATIN        @Y                4 0
022100980729     C                   MOVEL     @MD           @DATOU            8 0
022200980729     C                   MOVE      @Y            @DATOU
022300980729     C                   MOVE      *ZEROS        @DATIN            8 0
0224009807290120 C                   ENDSR
022500980729     C*
0226009807290103 C***************************************************
0227009807290104 C* CONVERT FIELD FROM MMDDYYYY TO YYYYMMDD         *
0228009807290105 C***************************************************
0229009807290107 C*
0230009807290107 C* DATE IN  = @DATIN (8.0) MMDDYYYY
0231009807290107 C* DATE OUT = @DATOU (8.0) YYYYMMDD
0232009807290107 C*
0233009807290106 C     #DATMY        BEGSR
023400980729     C                   MOVEL     @DATIN        @MD               4 0
023500980729     C                   MOVE      @DATIN        @Y                4 0
023600980729     C                   MOVE      @MD           @DATOU            8 0
023700980729     C                   MOVEL     @Y            @DATOU
023800980729     C                   MOVE      *ZEROS        @DATIN            8 0
0239009807290120 C                   ENDSR
024000980729     C*
0241000003301658 Owkstn     D    90N1P
0242000003301658 O         OR    1PN90
0243000003300122 O                                           K8 'SCRN01  '
0244000003300123 O                       CONAME              40
0245000003300124 O                       SSN            B    49
0246009102150121 OWKSTN     E            SCRN01
0247009102150122 O                                           K8 'SCRN01  '
0248009102150123 O                       CONAME              40
0249009104240124 O                       SSN            B    49
0250009102150125 O               55      MSG(X)              94
0251009102150126 OWKSTN     E            SCRN02
0252009102150127 O                                           K8 'SCRN02  '
0253009102150128 O                       CONAME              40
0254009102150129 O                       SSNO           B    49
0255009102150130 O                       LNAME               67
0256009102150131 O                       FNAME               79
0257009102150132 O                       MI                  80
025800910424     O                       TSA                 90
025900041213     O                       acobsrv             91
026000041213     O                       TERMDT              99
0261000412130134 O                       REFDT              107
026200041213     O               55      MSG(X)             152
0263009104290135 OMEMBER    E            UPMEM
026400910424     O                                          148 'C'
0265009807290137 O                                          584 '00000000'
0266009104290137 O                                          331 '   '
026700910424     O                                          512 'A'
026800910429     ODEPEND    E            RELDEP
026900910429     O*
0270009104294706 O          E            REDEP
0271009104294707 O                                          320 'A'
0272000412134765 OACCMSr    E            UPACC
0273000412134766 O                       NOEMPL
0274000412134765 O          E            relacc
0275009104294435 OHIST      EADD         ADHIS
0276009104294451 O                       SSN                 10
0277009104294455 O                                           19 'ECO'
0278009104294456 O                       ZERO9               24P
027900040615     O                                           90 '00'
028001131025     O                       thispgmname        107
028002131025     O                                          108 ' '
0281009104294464 O                       TSA                119
0281011311124456 O                       zero8              127
0282009104294466 O                                          128 'A'
0283009807294465 O                       UDATE8             136
0284001311124465 O                       zero8              144
0285001311124465 O                       zero8              152
0286009807294465 O                       REFDT              160
0287001310104456 O                       ZERO9              184
0288001310104456 O                       ZERO7              191
0289001310104456 O                       hstrtime           199
0290001310104456 O                       ZERO7              206
0291001310144465 O                       loperid            216
029200130521
0293001305214434 O*  HISTORY RECORD FOR DEPENDENT TERM
0294001305214435 O          eADD         histdep
0295001305214436 O                       SSN                 10
0296001305214440 O                       trcode              19
0297001305214441 O                       ZERO9               24P
0298001305214458 O                       NOTE2          B    85
029900130521     O                       dseq#               90
030001131025     O                       thispgmname        107
030002131025     O                                          108 ' '
0301001305214446 O                       TSA                119
0301011311124456 O                       zero8              127
0302001305214448 O                                          128 'A'
030300130521JGE01O                       udate8             136
030400130521     O                       ZERO8              144
030500130521y2k  O                       ZERO8              152
030600130521y2k  O                       his_covtdt     b   160
0307001310104456 O                       ZERO9              184
0308001310104456 O                       ZERO7              191
0309001310104456 O                       hstrtime           199
0310001310104456 O                       ZERO7              206
0311001310144447 O                       loperid            216
031200130521
031300910425**   ERROR MESSAGE ARRAY
031400910215************   SSN NOT FOUND     ***********
031500910424*****     MEMBER NOT CANCELLED       *******
031600910425******   INVALID EFFECTIVE DATE   **********
031700041213* ACCT COBRA = NO OR SERVICE = LETTER ONLY *
031800910215********************************************
031900910425**  DAYS IN MONTH ARRAY
032000910425312931303130313130313031
