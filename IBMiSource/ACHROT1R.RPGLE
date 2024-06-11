000100020621     H*Indent ('| ')
000200990630      *? ***************************************************************
000300020523      *
000400090709      *             GROUP BENIFIT SERVICES SOFTWARE           2009     *
000500060829      *                                                                *
000600000118      *  Written by:    S. Zien                                        *
000700090917      *  Date Written:   9/17/09                                       *
000800090917      *  Description:   Replace Routing# by terming ACH record and     *
000900090917      *                  adding a new range.                           *
001000000118      *                                                                *
001100000118      *                                                                *
001200000118      *                R E V I S I O N    H I S T O R Y                *
001300000118      *  Date                                                          *
001400000118      *  Revised   Initials    Revision                                *
001500000118      *  --------  --------    --------------------------------------  *
001600131010      *  10/10/13  sbt         Hist file expansion project             *
001700131017      *  10/17/13  sbt         Hist file expansion project - chg       *
001800131017      *                            move to movel                       *
001900990630      *? ***************************************************************
002000090918     FACCACHL2  UF   E           K Disk
002100090918     FACCACH    O  A E           K Disk    Rename(ACCACHR:ACHR) Prefix(A)
002200090918     FHIST      O  A E             DISK
002300090917     FACHROTCSV O  A E             Disk
002400010326
002500090909     D                 DS
0026000910290125 D  TSA                    1     10  0
0027000910290125 D  AHTRST                 1      3  0
0028000910290125 D  AHSUB#                 4      6  0
0029000910290125 D  AHACCT                 7     10  0
003000090918     D @TRST           S              3A
003100090918     D @SUBD           S              3A
003200090918     D @ACCT           S              4A
003300090918     D #ISO            S               D   DATFMT(*ISO)
003400090918     D NewTrst         S                   Like(AHTRST)
003500090918     D NewSub#         S                   Like(AHSUB#)
003600090918     D NewAcct         S                   Like(AHACCT)
003700090918     D NewAct#         S                   Like(AHACT#)
003800090918     D NewCSfl         S                   Like(AHCSFL)
003900090918     D NewPren         S                   Like(AHPREN)
004000090918     D NewPrdt         S                   Like(AHPRDT)
004100090918    ?D CalcDate        S               D   Datfmt(*ISO)
004200090918     D NextDay         S               D   Datfmt(*ISO)
004300061017     D                UDS
004400131014     D @USER                  25     34
004500061017
004600060816      *
004700090917     C                   Movel     WSOLRT        WSOLRTN           9 0
004800090917     C                   Movel     WSNERT        WSNERTN           9 0
004900090917     C                   Movel     WSEDT         WSEDTN            8 0
005000090917     C     WSEDTN        Mult      10000.0001    WSEDTN
005100090904     C
005200090917     C     WSOLRTN       Setll     ACCACHL2
005300090917     C     WSOLRTN       Reade     ACCACHL2
005400090917     C                   Dow       Not %Eof(ACCACHL2)
005500061010     C                   Exsr      Process
005600090917     C     WSOLRTN       Reade     ACCACHL2
005700061010     C                   EndDo
005800060817     C                   Eval      *InLR     =   *On
005900060815     C                   Return
006000010403
006100060817      *---------------------------------------------------------------*
006200061010     C     Process       Begsr
006300060817      *---------------------------------------------------------------*
006400090917     C                   Exsr      AutoTerm
006500090917     C                   Exsr      AutoCreate
006600090909     C                   Exsr      WriteOut
006700090904      *
006800090909     C                   EndSr
006900090909      *---------------------------------------------------------------*
007000090909     C     WriteOut      Begsr
007100090909      *---------------------------------------------------------------*
007200090917     C                   Clear                   ACHROTR
007300090909     C                   Eval      WKRECORD  =   '"' +
007400090909     C                             %Trim(%Editw(TSA:'0   -   -    '))   +
007500090909     C                                                            '","' +
007600090917     C                             %Trim(%Editc(WSOLRTN:'P'))   + '","' +
007700090917     C                             %Trim(%Editc(WSNERTN:'P'))   + '","' +
007800091030     C*********************        %Trim(%Editc(AAHBEDT:'P'))   + '",'
007900091030     C                             %Trim(%Editc(OutBeDt:'P'))   + '",'
008000090917     C                   Write     ACHROTR
008100090709     C                   EndSr
008200090903      *---------------------------------------------------------------*
008300090917     C     AutoTerm      Begsr
008400090903      *---------------------------------------------------------------*
008500090918      *
008600090918      * Save data from current record to use to duplicate for new record
008700090918      *
008800090918     C                   Eval      NewTrst   =   AHTRST
008900090918     C                   Eval      NewSub#   =   AHSUB#
009000090918     C                   Eval      NewAcct   =   AHACCT
009100090918     C                   Eval      NewAct#   =   AHACT#
009200090918     C                   Eval      NewCSfl   =   AHCSFL
009300090918     C                   Eval      NewPren   =   AHPREN
009400090918     C                   Eval      NewPrdt   =   AHPRDT
009500090918      *
009600090918      * Term record by using routing# term date from user prompt screen
009700090918      *
009800090918     C                   Eval      AHCHGU    =   %Trim(@USER)
009900090918     C                   Eval      AHENDT    =   WSEDTN
010000090918     C     *DATE         Mult      10000.0001    AHCHDT
010100090918     C                   Update    ACCACHR
010200091029     C                   Clear                   ACCACHR
010300091030     C                   Eval      AHTRST    =   NewTrst
010400091030     C                   Eval      AHSUB#    =   NewSub#
010500091030     C                   Eval      AHACCT    =   NewAcct
010600090918      *
010700090918      * Write a history record showing that the routing# has changed
010800090918      *
010900090918     C                   EXSR      $COMNHIST
011000090918     C                   MOVE      'L66'         TRCODE
011100090918     C                   Eval      CK#NOT    =   WSOLRT
011200090918     C                   Eval      NOTE2     =   WSNERT
011300090918     C                   Eval      COVTDT    =   WSEDTN
011400131010     c                   eval      hstrtime = %time
011500090918     C                   WRITE     HISTR
011600090903    ?C                   Endsr
011700070111      *
011800090917      *---------------------------------------------------------------*
011900090917    ?C     AutoCreate    Begsr
012000090917      *---------------------------------------------------------------*
012100090918     C     *ISO          Move      WSEDTN        CalcDate
012200090918     C     CalcDate      Adddur    1:*d          NextDay
012300090918     C                   Move      NextDay       AAHBEDT
012400091030     C                   Move      NextDay       OutBeDt           8 0
012500090918     C                   Eval      AAHENDT   =   *Zeros
012600090918     C                   Eval      AAHTRST   =   NewTrst
012700090918     C                   Eval      AAHSUB#   =   NewSub#
012800090918     C                   Eval      AAHACCT   =   NewAcct
012900090918     C                   Eval      AAHROUT   =   WSNERTN
013000090918     C                   Eval      AAHACT#   =   NewAct#
013100090918     C                   Eval      AAHCSFL   =   NewCSfl
013200090918     C                   Eval      AAHPREN   =   NewPren
013300090918     C                   Eval      AAHPRDT   =   NewPrdt
013400090918     C                   Eval      AAHCHGU   =   %Trim(@USER)
013500090918     C     *DATE         Mult      10000.0001    AAHCHDT
013600090918     C                   WRITE     ACHR
013700091030     C                   Clear                   ACHR
013800090904    ?C                   Endsr
013900080409      * ? _____________________________________________________________
014000080409      *? *                                                             *
014100080409      *? *        Write Excel Spreadsheet Title to CSV File            *
014200080409      *? *_____________________________________________________________*
014300080409     C     WriteSpTitle  BEGSR
014400080409     C*
014500090917     C                   Eval      WKRECORD  =    '"' + 'Account#' + '","' +
014600090917     C                                             'Old Routing #' + '","' +
014700090917     C                                             'New Routing #' + '","' +
014800090917     C                                         'Replacement Date'  + '",'
014900090917     C                   Write     ACHROTR
015000090917     C                   Clear                   ACHROTR
015100080409     C*
0152000804090320 C                   ENDSR
015300060817
015400090918      *---------------------------------------------------------------*
015500090918     C     $COMNHIST     BEGSR
015600090918      *---------------------------------------------------------------*
015700090918     C                   CLEAR                   HISTR
015800090918     C                   MOVE      AHTRST        @TRST
015900090918     C                   MOVE      AHSUB#        @SUBD
016000090918     C                   MOVE      AHACCT        @ACCT
016100090918     C     @TRST         CAT(P)    @SUBD:0       HKEY
016200090918     C                   CAT       @ACCT:0       HKEY
016300090918     C                   MOVE      *Blanks       TRMFLG
016400090918     C                   MOVE      *Blanks       TRLFLG
016500090918     C                   MOVE      'N'           DTRFLG
016600090918     C                   MOVE      *ZEROS        HDSEQ#
016700131025     C                   MOVEL     'ACHROT1R'    HPRGNM
016800090918     C                   Z-ADD     AHTRST        HSTRST
016900090918     C                   Z-ADD     AHSUB#        HSSUB#
017000090918     C                   Z-ADD     AHACCT        HSACCT
017100090918     C                   MOVEL     @USER         HOPER
017200090918     C                   MOVE      'A'           HSDLTD
017300090918     C                   MOVE      #TISO         TRDATE
017400090918    ***
017500090918     C                   ENDSR
017600090813    ? *___________________________________________________________________
017700090813    ? * Parameter lists
017800090813    ? *___________________________________________________________________
017900090904    ?C     PLIST         Begsr
018000090904    ?C     *ENTRY        Plist
018100090917    ?C                   Parm                    WSOLRT            9
018200090917    ?C                   Parm                    WSNERT            9
018300090917     C                   Parm                    WSEDT             8
018400090813    ?C                   Endsr
018500090903    ? *___________________________________________________________________
018600090903    ? * Klists
018700090903    ? *___________________________________________________________________
018800090904    ?C     KList         Begsr
018900090903    ? *
019000090903      *
019100090903    ?C                   Endsr
019200090903    ? *___________________________________________________________________
019300090903     C     *Inzsr        BEGSR
019400090903    ? *___________________________________________________________________
019500060817     C     *DATE         Mult      10000.0001    Today             8 0
019600090918     C                   MOVE      *DATE         #ISO
019700090918     C                   MOVE      #ISO          #TISO             8 0
019800080409     C                   Exsr      WriteSpTitle
019900060817     C                   ENDSR
020000010412
020100010403     C/EJECT
