000100000000      *_________________________________________________________________________
000200000000      *
000300230815      *  Description:  BLI License Expiring Report
000400000000      *
000500230815      *  (c)Copyright 2023 by Amwins Connect.
000600000000      *
000700230815      *    Created by:  JALLEN - August 15, 2023
000800000000      *_________________________________________________________________________
000900230814     FSMANRLT   IF   E           k DISK
001000060911     FSPRAGXR2  IF   E           k DISK
001100060911     FSMAN      IF   E           k DISK
001200060911     FAGENCY    IF   E           k DISK
001300060911     FSUPRAGCY  IF   E           k DISK
001400060911     FBLILMANL2 IF   E           k DISK
001500060911     FBLILSM    IF   E           k DISK
001600230814     FBLIEOC    IF   E           k DISK
001700230816     FBLICYB    IF   E           k DISK
001800230816     FBLICON    IF   E           k DISK
001900230816     FBLIGEN    IF   E           k DISK
002000230811     FBLICXLSP  O    E             DISK
002100230816
002200230816    ?d isoeff          S               D   datfmt(*iso)
002300230816    ?d isotoday        S               D   datfmt(*ISO)
002400230816    ?d isodat          S               D   datfmt(*iso)                         Input Request
002500230816     d w80date         s              8  0
002600230816     d days            s              4s 0 inz
002700230816     d wwreli          s              8a   inz
002800230816
002900230816       dcl-s LICREPORT Char(8) dtaara;
003000230816
003100230816           in *lock licreport;
003200230816           w80date = %dec(licreport:8:0);
003300230816
003400230816      * Update run date to last day of next month.
003500230816       isoDat = %date(%subst(%char(%date(w80date)):1:8) + '01':*ISO);
003600230816       isoDat  = isoDat + %months(2) - %days(1);
003700230816
003800230816       w80date = %int(%char(isodat : *iso0));
003900230816       licreport = %char(w80date);
004000230816           out licreport;
004100230816
004200230814     C     *loval        setll     SMANRLT
004300230814     C                   read      SMANRLT
004400230814     C                   dow       not %eof(SMANRLT)
004500230811
004600230816     C                   if        SRTRMDTE = 0
004700230816     C                   eval      WWRELI = SRRELID
004800060911     C                   eval      LMANC = SRSMAN
004900060911     C     SRASID        Chain     SPRAGXR2
005000230816     C                   If        %found and SXTRMDTE = 0
005100060911     C                   eval      LMANC = SRSMAN
005200060911     C                   eval      LAGCY = SXAGCY
005300060911     C                   eval      LSUPR = SXSUPER
005400060911     C                   Exsr      FAGENCY
005500230814     C                   If        SENDDT = 0
005600060911     C                   Exsr      GETLIC
005700060911     C                   End
005800230816     C                   End
005900060911     C                   End
006000230814
006100230814     C                   read      SMANRLT
006200230814     C                   enddo
006300230811
006400230811     C                   eval      *inLR = *on
006500230811     C                   return
006600060911
006700060911     C     GETLIC        Begsr
006800060911     C     LMANC         SETLL     BLILSM
006900060911     C     LMANC         READE     BLILSM
007000060911     C                   Dow       not %eof(BLILSM)
007100230816     C                   if        LSEXPD >= 20220101  and
007200230816     C                             LSEXPD <= w80date
007300230815
007400230815     C                   eval      WWEXPDL = *blanks
007500230815     C                   eval      WWEXPDE = *blanks
007600230815     C                   eval      WWLPOE = *zeros
007700230815     C                   eval      WWAGLE = *zeros
007800230815     C                   eval      WWEXPDC = *blanks
007900230815     C                   eval      WWLPOC = *zeros
008000230815     C                   eval      WWAGLC = *zeros
008100230815      * LSM
008200230815     C                   Movel     LSEXPD        Input_Date
008300230815     C                   Eval      Input_Format  = 'YYYYMMDD'
008400230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
008500230815     C                   Exsr      FormatDateSR
008600230815     C                   Eval      WWEXPDL = %trim(Output_Date)
008700230815
008800230815      * E&O
008900230815     C                   clear                   LELPO
009000230815     C                   clear                   LEAGL
009100230815     C                   clear                   LEEXPD
009200230816     C     WWRELI        Chain     BLIEOC
009300230815     C                   if        %found(BLIEOC)
009400230815     C                   if        LEEXPD >= 20220101  and
009500230816     C                             LEEXPD <= w80date
009600230815
009700230815     C                   eval      WWLPOE = LELPO
009800230815     C                   eval      WWAGLE = LEAGL
009900230815     C                   Movel     LEEXPD        Input_Date
010000230815     C                   Eval      Input_Format  = 'YYYYMMDD'
010100230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
010200230815     C                   Exsr      FormatDateSR
010300230815     C                   Eval      WWEXPDE = %trim(Output_Date)
010400230815
010500230815     C                   else
010600230815     C                   clear                   LELPO
010700230815     C                   clear                   LEAGL
010800230815     C                   clear                   LEEXPD
010900230815     C                   end
011000230815     C                   end
011100230815      * CYBER
011200230814     C                   clear                   LELPO
011300230814     C                   clear                   LEAGL
011400230814     C                   clear                   LEEXPD
011500230816     C     WWRELI        Chain     BLICYB
011600230814     C                   if        %found(BLICYB)
011700230814     C                   if        LEEXPD >= 20220101  and
011800230816     C                             LEEXPD <= w80date
011900230815
012000230815     C                   eval      WWLPOC = LELPO
012100230815     C                   eval      WWAGLC = LEAGL
012200230815     C                   Movel     LEEXPD        Input_Date
012300230815     C                   Eval      Input_Format  = 'YYYYMMDD'
012400230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
012500230815     C                   Exsr      FormatDateSR
012600230815     C                   Eval      WWEXPDC = %trim(Output_Date)
012700230815
012800230814     C                   else
012900230814     C                   clear                   LELPO
013000230814     C                   clear                   LEAGL
013100230814     C                   clear                   LEEXPD
013200230814     C                   end
013300230814     C                   end
013400230816      * GEN
013500230816     C                   clear                   LELPO
013600230816     C                   clear                   LEAGL
013700230816     C                   clear                   LEEXPD
013800230816     C     WWRELI        Chain     BLIGEN
013900230816     C                   if        %found(BLIGEN)
014000230816     C                   if        LEEXPD >= 20220101  and
014100230816     C                             LEEXPD <= w80date
014200230816
014300230816     C                   eval      WWLPOG = LELPO
014400230816     C                   eval      WWAGLG = LEAGL
014500230816     C                   Movel     LEEXPD        Input_Date
014600230816     C                   Eval      Input_Format  = 'YYYYMMDD'
014700230816     C                   Eval      Output_Format = 'MM/DD/YYYY'
014800230816     C                   Exsr      FormatDateSR
014900230816     C                   Eval      WWEXPDG = %trim(Output_Date)
015000230816
015100230816     C                   else
015200230816     C                   clear                   LELPO
015300230816     C                   clear                   LEAGL
015400230816     C                   clear                   LEEXPD
015500230816     C                   end
015600230816     C                   end
015700230816      * CON
015800230816     C                   clear                   LCCARR
015900230816     C                   clear                   LCCNTR
016000230816     C     WWRELI        Chain     BLICON
016100230816     C                   if        %found(BLICON)
016200230816     C                   if        LCEXPD >= 20220101  and
016300230816     C                             LCEXPD <= w80date
016400230816
016500230816     C                   eval      WWCARRN = LCCARR
016600230816     C                   select
016700230816     C                   when      %trim(LCCNTR) = '1'
016800230816     C                   eval      WWCNTRN = 'Salesman'
016900230816     C                   when      %trim(LCCNTR) = '2'
017000230816     C                   eval      WWCNTRN = 'Agency'
017100230816     C                   other
017200230816     C                   eval      WWCNTRN = LCCNTR
017300230816     C                   endsl
017400230816     C                   Movel     LCEXPD        Input_Date
017500230816     C                   Eval      Input_Format  = 'YYYYMMDD'
017600230816     C                   Eval      Output_Format = 'MM/DD/YYYY'
017700230816     C                   Exsr      FormatDateSR
017800230816     C                   Eval      WWEXPDN = %trim(Output_Date)
017900230816
018000230816     C                   else
018100230816     C                   clear                   LCCARR
018200230816     C                   clear                   LCCNTR
018300230816     C                   end
018400230816     C                   end
018500230815
018600230815     C                   Movel     LSEXPD        Input_Date
018700230815     C                   Eval      Input_Format  = 'YYYYMMDD'
018800230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
018900230815     C                   Exsr      FormatDateSR
019000230815     C                   Eval      WWEXPDL = %trim(Output_Date)
019100230816
019200230816     C                   if        LCRELI = *blanks
019300230816     C                   eval      LCRELI = WWRELI
019400230816     C                   end
019500230815
019600230811     C                   Write     BLICXLSR
019700230814     C                   end
019800060911     C     LMANC         READE     BLILSM
019900060911     C                   Enddo
020000230811     C                   Clear                   BLICXLSR
020100060911     C                   Endsr
020200060911
020300060911     C     FAGENCY       Begsr
020400060911     C     LMANC         Chain     SMAN
020500060911     C                   If        %found
020600230811     C                   Eval      LMANN = %trim(SFNAME) + ' ' +
020700230811     C                                     %trim(SLNAME)
020800060911     C                   End
020900060911     C     LAGCY         Chain     AGENCY
021000060911     C                   If        %found
021100230811     C                   Eval      LAGCN = %trim(AGNAM1)
021200230811     C                   Eval      LADDR = %trim(AGADD1)
021300230811     C                   Eval      LCITY = %trim(AGCITY)
021400230811     C                   Eval      LSTATE = %trim(AGSTAT)
021500230811     C                   Eval      LZIP   = %char(AGZIP5)
021600060911     C                   End
021700060911     C     LSUPR         Chain     SUPRAGCY
021800060911     C                   If        %found
021900060911     C                   Eval      LSUPN = %trim(SANAME1)
022000060911     C                   End
022100060911     C                   Endsr
022200230815      *___________________________________________________________________
022300230815      * Format Date
022400230815      *___________________________________________________________________
022500230815     C     FormatDateSR  BEGSR
022600230815     C                   Call      'FMTDATE'
022700230815     C                   Parm                    Input_Date       32
022800230815     C                   Parm                    Input_Format     32
022900230815     C                   Parm                    Output_Format    32
023000230815     C                   Parm                    Output_Date      32
023100230815     C                   Parm                    Output_Error     10
023200230815     C                   ENDSR
023300230816      *___________________________________________________________________
023400230816      * Save Logic
023500230816      *___________________________________________________________________
023600230816     C     Save_Logic    BEGSR
023700230816     C                   Move      20240131      isoeff
023800230816     C                   Extrct    isoeff:*d     days
023900230816
024000230816      * if not the first, make frist of next month.
024100230816     C                   if        days > 1
024200230816     C                   Eval      days = days - 1
024300230816     C     isoeff        Subdur    days:*d       isoeff
024400230816     C     isoeff        adddur    2:*m          isoeff
024500230816     C                   Else
024600230816     C     isoeff        adddur    2:*m          isoeff
024700230816     C                   End
024800230816     C     isoeff        subdur    1:*d          isoeff
024900230816     C                   Move      isoeff        w80date
025000230816     C                   ENDSR
