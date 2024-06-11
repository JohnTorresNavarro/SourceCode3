0001009102150002 F******************************************************************  UTL001
0002009909300003 F* RPF080     GROUP BENEFIT SERVICES SOFTWARE           1994      *  UTL001
0003009102150004 F*                                                                *  UTL001
0004009210280005 F*            WRITTEN BY - DAVID KETTERMAN                        *  UTL001
0005009408010006 F*            DATE - 08/01/94                                     *  UTL001
0006009102150007 F*                                                                *  UTL001
0007009505250013 F*  DESCRIPTION - THIS PROGRAM WILL PRINT A STATEMENT FOR         *  UTL001
0008009407280014 F*            CANCELED ACCTS WITH AN OUTSTANDING BALANCE DUE.     *  UTL001
0009009210280015 F*                                                                *  UTL001
001000981201     F*  MODIFICATION 10/07/97 MARY FONTI - REFORMAT LETTER; HISTORY   *
001100981201     F*               RECORD REPLACE NOTE 1, 2 ETC. WITH UDATE ONLY;   *
001200981201     F*               ADD SUB & ACCT SELECTION.                        *
001300981201     F*               *PRINT INDIVIDUAL ONLY. PER C.S.                 *
001400981201     F* 12/01/98 DLW CHANGED DATE USAGE TO INCLUDE CENT. -Y2K COMPLIANT*
001500990405     F*  4/05/99 DLK FIX DLW CODE                                      *
001600000216     F*  2/16/00 DLK change name from Carol S to Stacie K              *
001700000222     F*  2/22/00 DLK change phone #                                    *
001800131010     F* 10/10/13 SBT Hist file expansion project                       *
001801141021     F* 10/21/14 DLK increase total due to 9.2 to avoid truncation     *
001802150325     F*  3/25/15 DLK letter changes requested by Admin
0019009102150016 F******************************************************************  UTL001
0020009102150017 F*                                                                   UTL001
0021009407280018 FACCMST    IP   E             DISK
0022001310100028 FHIST      O  A F  216        DISK
0023000410080027 FRPF080P   O    e             PRINTER
0024009407280030 D AL              S              1    DIM(30)
002500971008     D TABQ            S              2  0 DIM(12) CTDATA PERRCD(1)
002600041008     D TABR            S              2  0 DIM(12) ALT(TABQ)
002700041008     D WDATE           S              8S 0 INZ
002800041008     D WAL             S             30A   INZ
002900131010     D hstrtime        S              8t
002901131025     D thispgmname     S             10a   inz('RPF080    ')
0030009407280055 D                 DS
003001150325     d tsa                     1     10  0
003002150325     d actrst                  1      3  0
003003150325     d acsub#                  4      6  0
003004150325     d acacct                  7     10  0
0030051503250055 D                 DS
0031009407280129 D  BAL                  361    420P 2
003200940728     D                                     DIM(12)
0033009407280130 D  BAL1                 361    365P 2
0034009407280131 D  BAL2                 366    370P 2
0035009407280132 D  BAL3                 371    375P 2
0036009407280133 D  BAL4                 376    380P 2
0037009407280134 D  BAL5                 381    385P 2
0038009407280135 D  BAL6                 386    390P 2
0039009407280136 D  BAL7                 391    395P 2
0040009407280137 D  BAL8                 396    400P 2
0041009407280138 D  BAL9                 401    405P 2
0042009407280139 D  BAL10                406    410P 2
0043009407280140 D  BAL11                411    415P 2
0044009407280141 D  BAL12                416    420P 2
0045009407280055 D                UDS
0046001310140067 D  USER                  25     34
0047009710070067 D  T                    100    102
0048009505250067 D  LTRUST               100    102  0
004900971007     D  S                    103    105
005000971007     D  LSUB                 103    105  0
005100971007     D  A                    106    109
005200971007     D  LACCT                106    109  0
0053009102150056 D  CONAME               201    240
005301150325
0075001503250058  * skip these
007501150325     c                   if        actrst = 990 or actrst = 811 or
007502150325     c                             atrmdt = 0
007900910710     C                   GOTO      #END
008000910710     C                   END
008001150325
008002150325      * print selected acct if balance is over $5.00
008100150325     C                   if        actrst = ltrust and acsub# = lsub and
008101150325     c                             acacct = lacct
008500141021     C                   XFOOT     BAL           TOTDUE            9 2
008501150325     c                   if        totdue > 5.00
008502150325     c                   exsr      #letter
008503150325     c                   end
008504150325     c                   end
008505150325
008506150325     c     #end          tag
008507150325
008508150325      ***********************************
008510150325      * print letter                    *
008511150325      ***********************************
008512150325     c     #letter       begsr
008700940728     C                   EXSR      #ADDR
008800990405     C*
008900990405     C                   MOVE      ATRMDT        @DATIN
009000990405     C                   EXSR      #DATYM
009100990405     C                   MOVE      @DATOU        ATRMDY            8 0
0093000410080111 C*
009400041008     C                   Eval      WDATE = *DATE
009500041008     C                   Movel     WDATE         Input_Date
009600041008     C                   Eval      Input_Format = 'MMDDYYYY'
009700150325     C*****              Eval      Output_Format = 'DD Mmmmmmmmmz YYYY'
009701150325     C                   Eval      Output_Format = 'Mmmmmmmmmz DD, YYYY'
009800041008     C                   Exsr      FMDATE
009900041008     C                   Eval      LTRDAT = %trim(Output_Date)
0100000410080111 C*
010100041008     C                   Eval      ADR1 = *Blanks
010200041008     C                   Eval      ADR2 = *Blanks
010300041008     C                   Eval      ADR3 = *Blanks
010400041008     C                   Eval      ADR4 = *Blanks
010500041008     C                   Eval      ADR5 = *Blanks
0106000410080111 C*
010700041008     C                   Eval      ADR1 = %trim(ACNAM1)
010800041013     C                   Eval      ADR2 = %trim(ACNAM2)
0109000410130111 C*
011000041013     C                   If        ADR2 = *Blanks
011100041013     C                   Eval      ADR2 = %trim(AADDR1)
011200041013     C                   Eval      ADR3 = %trim(AADDR2)
011300041013     C                   Else
011400041013     C                   Eval      ADR3 = %trim(AADDR1)
011500041013     C                   Eval      ADR4 = %trim(AADDR2)
011600041013     C                   End
0117000410130111 C*
011800041013     C                   movea     al            wal
011900041013     C                   Select
012000041013     C                   When      ADR3 = *Blanks
012100041008     C                   Eval      ADR3 = %trim(WAL)
012200041013     C                   When      ADR4 = *Blanks
012300041013     C                   Eval      ADR4 = %trim(WAL)
012400041013     C                   When      ADR5 = *Blanks
012500041008     C                   Eval      ADR5 = %trim(WAL)
012600041013     C                   Endsl
0127000410080111 C*
012800150325     C                   Eval      WACT = %editw(tsa:'0   -   -    ')
012801150325     C**                 Evalr     WACT = %editw(ACTRST:'0   ') + '-' +
012900150325     C**                                  %editw(ACSUB#:'0   ') + '-' +
013000150325     C**                                  %editw(ACACCT:'0    ')
0131000410080111 C*
013200150325     C                   Evalr     WDUE1 = %editc(TOTDUE:'1':*cursym)
013300150325     C                   Evalr     WDUE2 = %editc(TOTDUE:'1':*cursym)
0134000410080111 C*
013501150325      * contact name on letter
013502150325     c                   clear                   wcnt
013503150325     c                   clear                   wcnt2
013504150325     c                   if        contac <> *blanks
013505150325     C                   Eval      WCNT = %trim(CONTAC)
013506150325     c                   else
013507150325     C                   Eval      WCNT = %trim(ecntac)
013509150325     c                   end
013510150325     C                   Eval      WCNT2 = %trim(wcnt)
013511150325     C                   cat       ':':0         wcnt2
013512150325
0136000410080111 C*
013700150325     C                   Eval      WDAT1 = %editw(ATRMDY:'0  /  /    ')
013800150325     C                   Eval      WDAT2 = %editw(LSMDY:'0  /  /    ')
0139000410080111 C*
014000150325     C**                 Eval      WISTR = %trim(ADR1)
014100150325     C**                 Exsr      FMTDTA
014200150325     C**                 Eval      ADR1 = %trim(WISTR)
0143000410080111 C*
014400150325     C**                 Eval      WISTR = %trim(ADR2)
014500150325     C**                 Exsr      FMTDTA
014600150325     C**                 Eval      ADR2 = %trim(WISTR)
0147000410080111 C*
014800150325     C**                 Eval      WISTR = %trim(ADR3)
014900150325     C**                 Exsr      FMTDTA
015000150325     C**                 Eval      ADR3 = %trim(WISTR)
0151000410080111 C*
015200150325     C**                 Eval      WISTR = %trim(ADR4)
015300150325     C**                 Exsr      FMTDTA
015400150325     C**                 Eval      ADR4 = %trim(WISTR)
0155000410080111 C*
015600150325     C**                 Eval      WISTR = %trim(ADR5)
015700150325     C**                 Exsr      FMTDTA
015800150325     C**                 Eval      ADR5 = %trim(WISTR)
0159000410080111 C*
016000150325     C**                 Eval      WISTR = %trim(WCNT)
016100150325     C**                 Exsr      FMTDTA
016200150325     C**                 Eval      WCNT = %trim(WISTR)
0163009904050111 C*
016400150325     C                   WRITE     LTRVR
016500041008     C                   WRITE     LTRPS
016501131105     c                   eval      hstrtime = %time
016600940801     C                   EXCEPT    ADDHIS
016800921028     C*
017200150325     C                   endsr
017300041008     C*--------------------------------------------------------------------
0174001503250356 C**   FMTDTA        BEGSR
017500150325     C**                 Call      'UTLUPLW2'
017600150325     C**                 Parm      '*FIRST'      WIRQS             8
017700150325     C**                 Parm                    WORTN             8
017800150325     C**                 Parm                    WISTR           256
017900150325     C**                 ENDSR
018000041008     C*--------------------------------------------------------------------
0181000410080356 C     FMDATE        BEGSR
018200041008     C                   CALL      'FMTDATE'
018300041008     C                   Parm                    Input_Date       32
018400041008     C                   Parm                    Input_Format     32
018500041008     C                   Parm                    Output_Format    32
018600041008     C                   Parm                    Output_Date      32
018700041008     C                   Parm                    Output_Error     10
018800041008     C                   ENDSR
018900041008     C*--------------------------------------------------------------------
0190009407280351 C****************************************************************
0191009407280352 C*    AL = CITY, ST  ZIP+4                                      *
0192009407280353 C*------------------- COMPRESS CITY/STATE/ZIP ------------------*
0193009407280356 C     #ADDR         BEGSR
0194009407280360 C                   MOVE      *BLANKS       AL
0195009407280361 C                   Z-ADD     30            N#                2 0
0196009407280362 C                   MOVEA     ACITY         AL(1)
0197009407280366 C     AL(N#)        DOUGT     ' '
0198009407280367 C                   SUB       1             N#
0199009407280368 C     N#            IFEQ      00
0200009407280370 C                   GOTO      ENDADR
0201009407280371 C                   END
0202009407280372 C                   END
0203009407280376 C                   ADD       1             N#
0204009407280377 C                   MOVEA     ','           AL(N#)
0205009407280378 C                   ADD       2             N#
0206009407280379 C                   MOVEA     ASTATE        AL(N#)
0207009407280380 C                   ADD       2             N#
0208009407280381 C                   MOVE      '.'           AL(N#)
0209009407280382 C*
0210009407280385 C                   MOVEL     AZIP          ZIP5              5 0
0211009407280181 C                   MOVE      ZIP5          ZIP5C             5
0212009407280386 C                   MOVEA     ZIP5C         AL(21)
0213009407280387 C*
0214009407280388 C                   MOVE      AZIP          ZIP4              4 0
0215009407280389 C     ZIP4          IFNE      0
0216009407280390 C                   MOVEA     '-'           AL(26)
0217009407280181 C                   MOVE      ZIP4          ZIP4C             4
0218009407280391 C                   MOVEA     ZIP4C         AL(27)
0219009407280392 C                   END
0220009407280393 C*
022100940802     C                   MOVEA     '00'          *IN(20)
022200940802     C     ACNAM2        IFNE      *BLANKS
022300940802     C                   SETON                                        21
022400940802     C                   END
022500940802     C*
022600940802     C     AADDR2        IFNE      *BLANKS
022700940802     C                   SETON                                        20
022800940802     C                   END
0229009407280394 C     ENDADR        ENDSR
0230009408020357 C*
0231009904050107 C*
0232009904050103 C***************************************************
0233009904050104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0234009904050105 C***************************************************
0235009904050107 C*
0236009904050107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0237009904050107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0238009904050107 C*
0239009904050106 C     #DATYM        BEGSR
024000990405     C                   MOVE      @DATIN        @MD               4 0
024100990405     C                   MOVEL     @DATIN        @Y                4 0
024200990405     C                   MOVEL     @MD           @DATOU            8 0
024300990405     C                   MOVE      @Y            @DATOU
024400990405     C                   MOVE      *ZEROS        @DATIN            8 0
0245009904050120 C                   ENDSR
024501150325
0245021503250056 C***********************************
0245031503250057 C* FIRST CYCLE ONLY                *
0245041503250056 C***********************************
0245061503250120 C     *inzsr        begsr
0245081503250060 C                   MOVEL     *YEAR         UD8YMD            8 0
0245091503250060 C                   MOVEL     *MONTH        UD8MD             4 0
0245101503250060 C                   MOVE      *DAY          UD8MD
0245111503250060 C                   MOVE      UD8MD         UD8YMD
024512150325     C                   TIME                    HTIME             6 0
024513150325     C                   Z-ADD     0             ZERO9             9 0
024514150325     C                   Z-ADD     0             ZERO8             8 0
024515150325     C                   Z-ADD     0             ZERO7             7 0
024517150325     C     UMONTH        LOOKUP    TABQ          TABR                     76
024518150325     C     *IN76         IFEQ      '1'
024519150325     C                   MOVEL     TABR          LSTDAY            2 0
024520150325     C                   END
024521150325     C                   MOVEL     *MONTH        LSMD              4 0
024522150325     C                   MOVE      LSTDAY        LSMD
024523150325     C                   MOVEL     LSMD          LSMDY
024524150325     C                   MOVE      *YEAR         LSMDY             8 0
0245251503250120 C                   ENDSR
024600990405     C*
0247009102150104 O******************************************************              DB020
0248009102150105 O*  OUTPUT SPECIFICATIONS                             *              DB020
0249009102150106 O******************************************************              DB020
0250009408010278 OHIST      EADD         ADDHIS
025100940801     O                       ACTRST               3
025200940801     O                       ACSUB#               6
025300940801     O                       ACACCT              10
0254009408010284 O                                           19 'UHM'
0255009408010285 O                       ZERO9               24P
0256009710070286 O                                           43 'PAST DUE STATEMENT'
0257009812010286 O                       *DATE               52
0258001410210606 O                                           67 'TOT.BAL.DUE-'
0259009408010607 O                       TOTDUE        L     78
026000040615     O                                           90 '00'
026101131025     O                       thispgmname        107
026102131025     O                                          108 ' '
026200940801     O                       ACTRST             112
026300940801     O                       ACSUB#             115
026400940801     O                       ACACCT             119
026401131112     O                       zero8              127
0265009408010294 O                                          128 'A'
0266009904050283 O                       UD8YMD             136
026700131112   01O                       zero8              144
026800131112   01O                       zero8              152
0269009904050289 O                       UD8YMD             160
0270001310100285 O                       ZERO9              184
0271001310100285 O                       ZERO7              191
0272001310100285 O                       hstrtime           199
0273001310100285 O                       ZERO7              206
0274001310140293 O                       USER               216
027500971008**
0276009710080131
0277009710080228
0278009710080331
0279009710080430
0280009710080531
0281009710080630
0282009710080731
0283009710080831
0284009710080930
0285009710081031
0286009710081130
0287009710081231
