000100000000      *_________________________________________________________________________
000200000000      *
000300230815      *  Description:  BLI License Expiring Report - Agency
000400230815      *
000500230815      *  (c)Copyright 2023 by Amwins Connect.
000600230815      *
000700230815      *    Created by:  JALLEN - August 15, 2023
000800000000      *_________________________________________________________________________
000900230814     FSMANRLT   IF   E           k DISK
001000060911     FSPRAGXR2  IF   E           k DISK
001100060911     FSMAN      IF   E           k DISK
001200060911     FAGENCY    IF   E           k DISK
001300060911     FSUPRAGCY  IF   E           k DISK
001400060911     FBLILMANL2 IF   E           k DISK
001500230814     FBLILAG    IF   E           k DISK
001600230815     FBLIEOC    IF   E           k DISK
001700230815     FBLICYB    IF   E           k DISK
001800230816     FBLICON    IF   E           k DISK
001900230816     FBLIGEN    IF   E           k DISK
002000230811     FBLICXLSP  O    E             DISK
002100230814
002200230814     d pos             s              3  0
002300230814     d poc             s              3  0
002400230814     d license         s             20a   dim( 1000 )
002500230816     d w80date         s              8  0
002600230816     d wwreli          s              8a   inz
002700230816
002800230816       dcl-s LICREPORT Char(8) dtaara;
002900230816
003000230816           in licreport;
003100230816           w80date = %dec(licreport:8:0);
003200230814
003300230814     C                   clear                   poc
003400230814     C     *loval        setll     SMANRLT
003500230814     C                   read      SMANRLT
003600230814     C                   dow       not %eof(SMANRLT)
003700230811
003800230816     C                   if        SRTRMDTE = 0
003900230816     C                   eval      WWRELI = SRRELID
004000060911     C                   eval      LMANC = SRSMAN
004100060911     C     SRASID        Chain     SPRAGXR2
004200230816     C                   If        %found and SXTRMDTE = 0
004300060911     C                   eval      LMANC = SRSMAN
004400060911     C                   eval      LAGCY = SXAGCY
004500060911     C                   eval      LSUPR = SXSUPER
004600060911     C                   Exsr      FAGENCY
004700230814     C                   If        SENDDT = 0
004800060911     C                   Exsr      GETLIC
004900060911     C                   End
005000230816     C                   End
005100060911     C                   End
005200230814
005300230814     C                   read      SMANRLT
005400230814     C                   enddo
005500230811
005600230811     C                   eval      *inLR = *on
005700230811     C                   return
005800060911
005900060911     C     GETLIC        Begsr
006000230814     C     LAGCY         SETLL     BLILAG
006100230814     C     LAGCY         READE     BLILAG
006200230814     C                   Dow       not %eof(BLILAG)
006300230814     C                   if        LGEXPD >= 20220101  and
006400230816     C                             LGEXPD <= w80date
006500230815
006600230815     C                   eval      WWEXPDL = *blanks
006700230815     C                   eval      WWEXPDE = *blanks
006800230815     C                   eval      WWLPOE = *zeros
006900230815     C                   eval      WWAGLE = *zeros
007000230815     C                   eval      WWEXPDC = *blanks
007100230815     C                   eval      WWLPOC = *zeros
007200230815     C                   eval      WWAGLC = *zeros
007300230815
007400230814     C                   eval      LSSTAT = LGSTAT
007500230814     C                   eval      LSLICN = LGLICN
007600230814     C                   eval      LSTYPE = LGTYPE
007700230814     C                   clear                   LMANC
007800230814     C                   clear                   LMANN
007900230814
008000230814            pos = %lookup( LSLICN : License ) ;
008100230814            if pos = 0;
008200230814            poc = poc+1;
008300230814            License(poc) = LSLICN;
008400230815
008500230815      * LAG
008600230815     C                   Movel     LGEXPD        Input_Date
008700230815     C                   Eval      Input_Format  = 'YYYYMMDD'
008800230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
008900230815     C                   Exsr      FormatDateSR
009000230815     C                   Eval      WWEXPDL = %trim(Output_Date)
009100230815
009200230815      * E&O
009300230815     C                   clear                   LELPO
009400230815     C                   clear                   LEAGL
009500230815     C                   clear                   LEEXPD
009600230816     C     WWRELI        Chain     BLIEOC
009700230815     C                   if        %found(BLIEOC)
009800230815     C                   if        LEEXPD >= 20220101  and
009900230816     C                             LEEXPD <= w80date
010000230815
010100230815     C                   eval      WWLPOE = LELPO
010200230815     C                   eval      WWAGLE = LEAGL
010300230815     C                   Movel     LEEXPD        Input_Date
010400230815     C                   Eval      Input_Format  = 'YYYYMMDD'
010500230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
010600230815     C                   Exsr      FormatDateSR
010700230815     C                   Eval      WWEXPDE = %trim(Output_Date)
010800230815
010900230815     C                   else
011000230815     C                   clear                   LELPO
011100230815     C                   clear                   LEAGL
011200230815     C                   clear                   LEEXPD
011300230815     C                   end
011400230815     C                   end
011500230815      * CYBER
011600230815     C                   clear                   LELPO
011700230815     C                   clear                   LEAGL
011800230815     C                   clear                   LEEXPD
011900230816     C     WWRELI        Chain     BLICYB
012000230815     C                   if        %found(BLICYB)
012100230815     C                   if        LEEXPD >= 20220101  and
012200230816     C                             LEEXPD <= w80date
012300230815
012400230815     C                   eval      WWLPOC = LELPO
012500230815     C                   eval      WWAGLC = LEAGL
012600230815     C                   Movel     LEEXPD        Input_Date
012700230815     C                   Eval      Input_Format  = 'YYYYMMDD'
012800230815     C                   Eval      Output_Format = 'MM/DD/YYYY'
012900230815     C                   Exsr      FormatDateSR
013000230815     C                   Eval      WWEXPDC = %trim(Output_Date)
013100230815
013200230815     C                   else
013300230815     C                   clear                   LELPO
013400230815     C                   clear                   LEAGL
013500230815     C                   clear                   LEEXPD
013600230815     C                   end
013700230815     C                   end
013800230816      * GEN
013900230816     C                   clear                   LELPO
014000230816     C                   clear                   LEAGL
014100230816     C                   clear                   LEEXPD
014200230816     C     WWRELI        Chain     BLIGEN
014300230816     C                   if        %found(BLIGEN)
014400230816     C                   if        LEEXPD >= 20220101  and
014500230816     C                             LEEXPD <= w80date
014600230816
014700230816     C                   eval      WWLPOG = LELPO
014800230816     C                   eval      WWAGLG = LEAGL
014900230816     C                   Movel     LEEXPD        Input_Date
015000230816     C                   Eval      Input_Format  = 'YYYYMMDD'
015100230816     C                   Eval      Output_Format = 'MM/DD/YYYY'
015200230816     C                   Exsr      FormatDateSR
015300230816     C                   Eval      WWEXPDG = %trim(Output_Date)
015400230816
015500230816     C                   else
015600230816     C                   clear                   LELPO
015700230816     C                   clear                   LEAGL
015800230816     C                   clear                   LEEXPD
015900230816     C                   end
016000230816     C                   end
016100230816      * CON
016200230816     C                   clear                   LCCARR
016300230816     C                   clear                   LCCNTR
016400230816     C     WWRELI        Chain     BLICON
016500230816     C                   if        %found(BLICON)
016600230816     C                   if        LCEXPD >= 20220101  and
016700230816     C                             LCEXPD <= w80date
016800230816
016900230816     C                   eval      WWCARRN = LCCARR
017000230816     C                   select
017100230816     C                   when      %trim(LCCNTR) = '1'
017200230816     C                   eval      WWCNTRN = 'Salesman'
017300230816     C                   when      %trim(LCCNTR) = '2'
017400230816     C                   eval      WWCNTRN = 'Agency'
017500230816     C                   other
017600230816     C                   eval      WWCNTRN = LCCNTR
017700230816     C                   endsl
017800230816     C                   Movel     LCEXPD        Input_Date
017900230816     C                   Eval      Input_Format  = 'YYYYMMDD'
018000230816     C                   Eval      Output_Format = 'MM/DD/YYYY'
018100230816     C                   Exsr      FormatDateSR
018200230816     C                   Eval      WWEXPDN = %trim(Output_Date)
018300230816
018400230816     C                   else
018500230816     C                   clear                   LCCARR
018600230816     C                   clear                   LCCNTR
018700230816     C                   end
018800230816     C                   end
018900230816
019000230816     C                   if        LCRELI = *blanks
019100230816     C                   eval      LCRELI = WWRELI
019200230816     C                   end
019300230815
019400230814     C                   Write     BLICXLSR
019500230814            endif;
019600230814
019700230814     C                   end
019800230814     C     LAGCY         READE     BLILAG
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
