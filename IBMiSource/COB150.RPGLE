0001009111250002 F******************************************************************
0002000004140003 F* COB150     GROUP BENEFIT SERVICES SOFTWARE           1990      *
0003009111250004 F*                                                                *
0004009111250005 F*            WRITTEN  BY - WALTER J. PICCININI                   *
0005009111250006 F*            DATE - 11/91                                        *
0006009111250008 F*                                                                *
0007009111250013 F*  DESCRIPTION - THIS PROGRAM WILL PRINT FILE CREATED BY TR201   *
0008009111250014 F*                COBRA MEMBERS WHOSE EXPIRATION DATE IS EITHER   *
0009009111250014 F*                ONE MONTH OR SIX MONTHS FROM LDA ENTERED...     *
0010001310100011  *
0011000111150015 F* 11/14/01 dlk - convert to RPGLE                                *
0012000508010015 F* 08/01/05 dlk - change fill01 to fill02                         *
0013001105170015 F* 05/17/11 dlk - add 1 month and 6 month letters from cob310     *
0014001111100011  * 11/10/11 dlk - mask ssn when no alt id avail
001500131010     F* 10/10/13 sbt - hist file expansion project                     *
0016001405010011  * 05/01/14 dlk - email report
0017001712040017  * 12/04/17 dlk - add letterhead ovelay and send back to user as pdf.  h
0018002104270017  * 04/27/21 dlk - recompile to pick up COB310P changes.                h
0019002106150017  * 06/15/21 dlk - recompile to pick up COB310P changes.                h
0020001712040017  *                                                                     h
0021002104270017  *                                                                     h
0022002104270017  *                                                                     h
0023002104270015  *  ** Note: this program shares the printer file
0024002104270015  *     with COB310 so any changes will need to occur
0025002104270015  *     in both programs. **
0026002104270015  *
0027002106150017  *   ** Note - The letterhead overlay (COB31LHC) is used in            h
0028002104270017  *             COB310, COB315 and this program.                        h
0029001105180015 F*                                                                *
0030009111250016 F******************************************************************
0031009111250017 F*                                                                *
0032000111150012 Fmemout    IP   e             DISK
003300110518     FMEMALTL3  IF   E           K Disk
003400110518JGE01Faacode    IF   e           k DISK
003500110518     FCOBRAAA   IF   E           K DISK
0036001105180034 FACCMST    IF   E           K DISK
0037001105170020 FHIST      O  A E             DISK
003800140501     Fcob150p   O    F  132        PRINTER OFLIND(*INOF)
0039001105170020 Fcob310p   O    E             PRINTER
004000131025     D thispgmname     S             10a   inz('COB150    ')
0041001105180037 D YR              S              9    DIM(12) CTDATA PERRCD(1)
004200110518     D AND1            C                   CONST(', spouse and all eligible +
004300110518     D                                     dependents')
004400110518     D AND2            C                   CONST(', spouse and all covered +
004500110518     D                                     dependents')
0046001105180037 D dat2wkdt        S               d   datfmt(*usa)
0047001105180055 D                 DS
0048001105180056 Dsmdy01                   1      8  0
0049001105180056 Dsmdyd01                  3      4  0
005000110518     d SS#             DS
005100110518     d SFirst3                 1      3
005200110518     d SMiddle2                4      5
005300110518     d SLast4                  6      9
0054009111250320 D                UDS
005500980729     D  LMMYY                  1      6  0
005600110518     D  LLET                   7      7
0057001310140056 D  LUSER                 25     34
0058009111250322 D  CONAME               201    240
005900011115     Imembr
006000050801     I                                          fill02        L1
006100110518     Iaccmsr
006200110518     i              aacode                      a_aacode
006300911122     C*
006400911125     C   OF              EXCEPT    HEAD
006500911125     C*
006600911125     C                   SETOFF                                       88
006700911125     C     ADDR2         IFNE      *BLANKS
006800911125     C                   SETON                                        88
006900911125     C                   END
007000911125     C*
007100980729     C                   MOVE      CEXPDT        @DATIN
007200980729     C                   EXSR      #DATYM
007300110518     C                   MOVE      @DATOU        CEXPDTmdy         8 0
007400911125     C                   EXCEPT    PRINT
007500110517
007600110518     c* print letter is selected
007700110518     c                   if        llet = 'Y'
007800110518      * create fields on letter
007900110518
0080001105180144 C     ACCKEY        CHAIN     ACCMST
008100110518     c                   if        not %found(accmst)
008200110518     c                   clear                   acnam1
008300110518     c                   end
008400110518
008500110518     C                   MOVE      cexpdtmdy     smdy              8 0
008600110518     C*
008700110518     C* 1 MONTH PRIOR TO EFFDT
008800110518     C*
0089001105180331 C                   MOVEl     smdy          WM                2 0
0090001105180331 C                   MOVE      smdy          WY                4 0
009100110518     C                   SUB       1             WM
009200110518     C     WM            IFLT      1
009300110518     C                   MOVE      12            WM
009400110518     C                   sub       1             wy
009500110518     C                   END
009600110518
009700110518     C                   MOVEL     YR(WM)        RENMO3            9
009800110518
009900110518     C*
010000110518     C* last day of 1 MONTH PRIOR TO EFFDT (cexpdt in this program)
010100110518     C*
010200110518     c                   move      smdy          smdy01
010300110518     c                   move      01            smdyd01
0104001105180331 C                   MOVE      smdy01        dat2wkdt
010500110518     c                   subdur    1:*d          dat2wkdt
010600110518     C                   MOVE      dat2wkdt      date3             8 0
010700110518
010800110518     c                   exsr      #adr
010900110518     c                   exsr      #name
011000110518      * Determine whether there is an alternate ID
011100110518     C                   Eval      AltType   =   'GBS'
011200110518     C                   Clear                   ALTSS
011300110518     C     AltKey        Chain     MEMALTL3
011400110518     C                   If        %Found(MEMALTL3)
011500110518     C                   Eval      ALTSS = %Trim(MAALTID)
011600110518     C                   Else
011700110518     C                   Move      MBSSNO        SS#
011800111110      * 11/10/11 mask ssn
011900111110     C*                  Eval      ALTSS = %Trim(SFirst3  +
012000111110     C*                                          '-'      +
012100111110     C*                                          SMiddle2 +
012200111110     C*                                          '-'      +
012300111110     C                   Eval      ALTSS = %Trim('XXX-XX-' +
012400110518     C                                           SLast4)
012500110518     C                   End
012600110518
012700110518     C*  GET COBRA aa name
012800110518     C*
012900110518     c                   eval      aaname = *blanks
013000110518     c     mbtrst        Chain     COBRAAA
013100110518     c                   if        %found(COBRAAA)
013200110518     c     CACODE        chain     AACODE
013300110518     c                   if        %found(AACODE)
013400110518     c                   movel     afnam         aaname           30
013500110518     c                   if        afnam <> *blanks
013600110518     c                   cat(p)    alnam:1       aaname
013700110518     c                   else
013800110518     c                   cat(p)    alnam:0       aaname
013900110518     c                   endif
014000110518     c                   endif
014100110518     c                   endif
014200110518
014300110517     c* letter 3 : 1 month
014400110517     c                   if        fill02 = ' 1'
014500110517
014600110517     C                   WRITE     LET3
014700171204      * letter head overlay
014800171204     c                   write     lethdol
014900171204
015000110517     C                   MOVE      'U03'         TRCODE
015100110517     C                   exsr      #hist
015200110517     c                   end
015300110517
015400110517     c* letter 4 : 6 month
015500110517     c                   if        fill02 = ' 2'
015600110517     C                   WRITE     LET4
015700171204      * letter head overlay
015800171204     c                   write     lethdol
015900171204
016000110517     C                   MOVE      'U04'         TRCODE
016100110517     C                   exsr      #hist
016200110517     c                   end
016300110518     c                   end
016400911125     C*
016500911126     CL1NLR              EXCEPT    HEAD
016600911125     C*
016700110517     C************************************************************
016800110517     C* ROUTINE FOR history record
016900110517     C************************************************************
017000110517     C*
017100110517     C     #hist         BEGSR
0172001105170103 C*
0173001105170103 C* WRITE HIST REC
0174001105170103 C*
017500110517     C                   MOVE      MBSSNO        HKEY
017600110517     C                   MOVE      *ZEROS        TRAMT
017700131025     C                   MOVEL     thispgmname   HPRGNM
017800110517     C                   MOVE      MBTRST        HSTRST
017900110517     C                   MOVE      MBSUB#        HSSUB#
018000110517     C                   MOVE      MBACCT        HSACCT
018100131010     C                   MOVEL     LUSER         HOPER
018200110517     C                   MOVE      'A'           HSDLTD
018300110517     C                   MOVE      UD8YMD        TRDATE
018400110518     C                   MOVE      cexpdt        COVTDT
018500131010     c                   eval      hstrtime = %time
018600110517     C                   WRITE     HISTR
0187001105170120 C                   ENDSR
0188009807290107 C*
018900110518     C****************************************************************
019000110518     C* NAME LINES - N1 = FIRST MI. LAST, spouse and all eligible dependents *
019100110518     C*              N2 = first mi. last                             *
019200110518     C*              N3 = first mi. last:                            *
019300110518     C*              N6 = FIRST MI. LAST, spouse and all covered dependents  *
019400110518     C****************************************************************
019500110518     C*
019600110518     C     #NAME         BEGSR
019700110518     C*
019800110518     C                   MOVE      *BLANKS       N1               69
019900110518     C                   MOVE      *BLANKS       N2               35
020000110518     C                   MOVE      *BLANKS       N3               36
020100110518     C                   MOVE      *BLANKS       N6               69
020200110518     C                   MOVEL     MFNAME        N1
020300110518     C*
020400110518     C     MMI           IFNE      ' '
020500110518     C                   CAT       MMI:1         N1
020600110518     C                   CAT       '.':0         N1
020700110518     C                   END
020800110518     C*
020900110518     C                   CAT       MLNAME:1      N1
021000110518
021100110518     c                   movel     n1            n2
021200110518     c                   movel     n1            n3
021300110518     c                   movel     n1            n6
021400110518     C                   CAT       ':':0         N3
021500110518
021600110518     C                   CAT       AND1:0        N1
021700110518     C                   CAT       AND2:0        N6
021800110518     C                   ENDSR
021900110518     C*
022000110518     C************************************************************
022100110518     C* ROUTINE FOR city,state zip+4 - MEMBER
022200110518     C************************************************************
022300110518     C*
022400110518     C     #ADR          BEGSR
022500110518     C                   MOVE      *blanks       AL               31
022600110518     C                   MOVEL     CITY          AL
022700110518     C                   CAT       ',':0         AL
022800110518     C                   CAT       STATE:1       AL
022900110518     C                   MOVEL     ZIP           ZIP5              5
023000110518     C                   MOVE      ZIP           ZIP4              4
023100110518     C                   CAT       ZIP5:1        AL
023200110518     C     ZIP4          IFNE      '0000'
023300110518     C                   CAT       '-':0         AL
023400110518     C                   CAT       ZIP4:0        AL
023500110518     C                   END
023600110518
023700110518     c* set address for output
023800110518
023900110518     c                   eval      a2 = *blanks
024000110518     c                   eval      a3 = *blanks
024100110518     c                   if        addr2 <> *blanks
024200110518     c                   movel     addr2         a2
024300110518     c                   movel     al            a3
024400110518     c                   else
024500110518     c                   movel     al            a2
024600110518     c                   end
024700110518
024800110518     C                   ENDSR
024900110518     C*
0250009807290103 C***************************************************
0251009807290104 C* CONVERT FIELD FROM YYYYMMDD TO MMDDYYYY         *
0252009807290105 C***************************************************
0253009807290107 C*
0254009807290107 C* DATE IN  = @DATIN (8.0) YYYYMMDD
0255009807290107 C* DATE OUT = @DATOU (8.0) MMDDYYYY
0256009807290107 C*
0257009807290106 C     #DATYM        BEGSR
025800980729     C                   MOVE      @DATIN        @MD               4 0
025900980729     C                   MOVEL     @DATIN        @Y                4 0
026000980729     C                   MOVEL     @MD           @DATOU            8 0
026100980729     C                   MOVE      @Y            @DATOU
026200980729     C                   MOVE      *ZEROS        @DATIN            8 0
0263009807290120 C                   ENDSR
026400980729     C*
026500011115     c     *inzsr        begsr
026600110518     C     ACCKEY        KLIST
026700110518     C                   KFLD                    MBTRST
026800110518     C                   KFLD                    MBSUB#
026900110518     C                   KFLD                    MBACCT
027000110518    ?C     AltKey        Klist
027100110518    ?C                   Kfld                    MBSSNO
027200110518    ?C                   Kfld                    AltType           4
027300110518
027400011115     c                   time                    time              6 0
027500110518     C                   MOVE      *DATE         @DATIN
027600110518     C                   EXSR      #DATYM
027700110518     C                   MOVE      @DATOU        UD8YMD            8 0
027800110518     C*
0279001105180323 C* FIRST DATE LINE - UDATE
0280001105180328 C*
0281001105180329 C                   MOVE      *BLANKS       DL               19
0282001105180331 C                   MOVE      *MONTH        M                 2 0
0283001105180331 C                   MOVE      *DAY          D                 2
0284001105180331 C                   MOVE      *YEAR         Y                 4
0285001105180332 C                   MOVEL     YR(M)         DL
028600110518     C                   CAT       D:1           DL
028700110518     C                   CAT       ',':0         DL
028800110518     C                   CAT       Y:1           DL
028900011115     C                   EXCEPT    HEAD
029000011115     c                   endsr
0291001405010766 Ocob150p   E            HEAD           1  3
0292009111250767 O                                           44 '***'
0293009111250768 O                       CONAME              84
0294009111250769 O                                           89 '***'
0295001105190766 O          E            HEAD           1
0296000111150776 O                                           16 'PROGRAM : COB150'
0297001105190772 O                                           86 'C.O.B.R.A.  EXPIRATIONS - -
029800110519     O                                              ONE MONTH/SIX MONTHS'
0299009111250773 O                                          122 'PAGE :'
0300000111150774 O                       PAGE          Z    131
0301001105190766 O          E            HEAD           2
030200110519     O                                           76 'PRINT LETTERS:'
030300110519     O                       LLET                78
0304000111150253 O                                            9 'RUN DATE:'
0305000111150254 O                       *DATE         Y     20
030600110519     O                                           52 'FOR DATE:'
030700110519     O                       LMMYY               60 '  /    '
0308000111150255 O                                          122 'TIME :'
0309000111150256 O                       TIME               131 '  :  :  '
0310001105190766 O          E            HEAD           1
0311009111250779 O                                           24 '------------------------'
0312009111250780 O                                           48 '------------------------'
0313009111250781 O                                           72 '------------------------'
0314009111250782 O                                           96 '------------------------'
0315009111250783 O                                          120 '------------------------'
0316009111250784 O                                          132 '------------'
0317001105190766 O          E            HEAD           1
0318009111260789 O                                           10 'SOC SEC #'
0319009111260790 O                                           27 'LAST NAME '
0320009111260791 O                                           50 'FIRST NAME'
0321009111260792 O                                           60 'INIT'
0322009111260793 O                                           70 'ADDRESS'
032300980729     O                                          121 'EXPIRATION'
0324001105190766 O          E            HEAD           2
0325009111250797 O                                           24 '------------------------'
0326009111250798 O                                           48 '------------------------'
0327009111250799 O                                           72 '------------------------'
0328009111250800 O                                           96 '------------------------'
0329009111250801 O                                          120 '------------------------'
0330009111250802 O                                          132 '------------'
0331001105190796 O          E            PRINT          1
033200011115     O                       MBSSNO              11 '   -  -   0'
033300011115     O                       MLNAME              35
033400011115     O                       MFNAME              52
033500011115     O                       MMI                 58
033600911125     O                       ADDR1               93
033700110518     O                       CEXPDTMDY          121 '  /  /    '
0338001105190796 O          E    88      PRINT          1
033900911125     O                       ADDR2               93
0340001105190796 O          E            PRINT          2
034100911126     O                       CITY                78
034200911125     O                       STATE               84
034300911203     O                       ZIP                 99 '    0-    '
034400110518**
034500110518January
034600110518February
034700110518March
034800110518April
034900110518May
035000110518June
035100110518July
035200110518August
035300110518September
035400110518October
035500110518November
035600110518December
