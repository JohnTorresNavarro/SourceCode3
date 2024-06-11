000100000000     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200000000      *-------------------------------------------------------------------------
000300000000      *
000400170526      *  Description: Dashboard Status
000500170526      *  Programmer.: B.Rees
000600170526      *  Date.......: 05/26/2017
000700000000      *
000800000000      *-------------------------------------------------------------------------
000900000000     FGBS0017D  CF   E             WORKSTN
001000000000     F                                     SFILE(LSTSFL:rrn)
001100000000     F                                     INFDS(DSPD)
001200170908     FACCOSPl2  if   e           k Disk
001300170526     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
001400170822     Faoecod    if   e           k disk
001500170822     FWebPayDtr if   e           k disk
001600000000      *-------------------------------------------------------------------------
001700000000
001800000000      * Program status data structure
001900000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002000000000     D  @pgmq            *proc
002100000000
002200000000      * Display file data structure
002300000000     D DSPD            DS
002400000000     D  Key                  369    369
002500000000     D  Currec               378    379b 0
002600000000
002700000000      * Variables
002800000000     D F03             C                   CONST(X'33')
002900000000     D F10             C                   CONST(X'3A')
003000170822     D F11             C                   CONST(X'3B')
003100000000     D F12             C                   CONST(X'3C')
003200000000
003300000000     d Rrn             s              5s 0 inz
003400000000     d SaveCursPos     S              4S 0
003500000000     d ReLoad          s              1
003600000000     d RcdMode         s             10
003700000000     d hasError        s               n
003800170526     d hldSearch       S                   like(mySearch)
003900170526     d oeOnly          s              1
004000170526     d mySQL           s           1000
004100170526     D q               c                   Const('''')
004200000000
004300170908     d savFullAcct     s             10a
004400170908
004500000000      *--------------------------------------------
004600000000      * Procedures
004700000000      *--------------------------------------------
004800000000     D/COPY *LIBL/QMODSRC,PR0001RPR            // Case Functions
004900000000     D/include *LIBL/QMODSRC,#MSGSUBF          // Message Subfile Procedures.
005000170526     D/include *libl/QMODSRC,#COMMANDPR
005100000000
005200000000      *-------------------------------------------------------------------------
005300000000      * Mainline Program
005400000000      *-------------------------------------------------------------------------
005500000000     C*    *entry        plist
005600000000     C*                  parm                    xxxxx
005700000000
005800000000      /Free
005900000000
006000000000       Dow key <> F03;
006100000000
006200170526          If HldSearch <> mySearch or Reload = 'Y';
006300170526             HldSearch= mySearch;
006400000000             exsr CLEAR;
006500000000             exsr LOAD;
006600000000             Reload = 'N';
006700000000          endIf;
006800000000
006900000000          exsr DISPLY;
007000000000
007100000000          // Process Selections
007200000000          Select;
007300000000
007400170526
007500170526          When key = F11;
007600170526            Reload = 'Y';
007700170526            select;
007800170526             when oeOnly = 'N';
007900170526              oeOnly = 'Y';
008000170526             When oeOnly = 'Y';
008100170526              oeOnly = 'N';
008200170526            other ;
008300170526              oeOnly = 'N';
008400170526            endsl;
008500170526
008600170822       // When key = ENTER and Rrn > 0;
008700170822       //    exsr PROCES;
008800000000
008900000000          EndSl;
009000000000       enddo;
009100000000
009200000000       *inlr = *on;
009300000000
009400170526       // ----------------------------------------------------------------
009500000000       Begsr *Inzsr;
009600000000
009700170526          Reload = 'Y';
009800170526          oeOnly = 'N';
009900170526
010000000000       Endsr;
010100000000       // ----------------------------------------------------------------
010200000000       Begsr CLEAR;
010300000000
010400170526          RcdNbr = 1;
010500170526          If SaveCursPos > 0;
010600170526             RcdNbr = SaveCursPos;
010700170526             SaveCursPos = 0;
010800170526          endIf;
010900000000
011000170526          // Clear the Subfile.
011100170526          *in31 = *off;                     // Subfile Display
011200170526          *in32 = *off;                     // Subfile Disp Control
011300170526          *in33 = *on;                      // Subfile Clear
011400000000
011500170526          write LstCtl;
011600000000
011700170526          *in31 = *off;                     // Subfile Display
011800170526          *in32 = *on;                      // Subfile Disp Control
011900170526          *in33 = *off;                     // Subfile Clear
012000170526          rrn = 0;
012100000000
012200000000       Endsr;
012300000000       // ----------------------------------------------------------------
012400000000
012500170526       Begsr Load;
012600000000
012700170526          *in37 = *off;
012800000000
012900000000
013000170908          Setll (*loval) ACCOSPL2;
013100170908          dou %eof(ACCOSPL2);
013200170908             read(n) ACCOSPL2;
013300000000
013400170908             if %eof(ACCOSPL2);
013500170526                *in37 = *on;
013600170526                leave;
013700170526             endif;
013800000000
013900170526
014000170526             s1Acct= %editc(aoTrst : 'X') + '-' +
014100170526                     %editc(aoSub# : 'X') + '-' +
014200170526                     %editc(aoAcct : 'X') ;
014300170526
014400170822             s1FullAcct= %editc(aoTrst : 'X') +
014500170822                         %editc(aoSub# : 'X') +
014600170822                         %editc(aoAcct : 'X') ;
014700170822
014800170908             if s1FullAcct = savFullAcct;
014900170908                iter;
015000170908             endif;
015100170908             SavFullAcct = s1FullAcct;
015200170908
015300170908
015400170526             s1Acct# = aoAcct;
015500170526             s1Sub#  = aoSub#;
015600170526             s1Trst  = aoTrst;
015700170526
015800170526              chain (aoTrst : aoSub# : aoacct) AccMst;
015900170526              if %Found(AccMst);
016000170526                 s1ActNam = AcNam1;
016100170526              endif;
016200170526
016300170822             s1oedesc = *blanks;
016400170822              chain aoCode aoecod;
016500170822              if %Found( aoecod ) ;
016600170822                 s1oedesc = aedesc;
016700170822              endif;
016800170822
016900170526             s1Setup = *Blanks;
017000170526             if AOSetup = 'I';
017100170526                s1Setup = 'InProcess';
017200170526             endif;
017300170526
017400170526             if AOSetup = 'C';
017500170526                s1Setup = 'Completed';
017600170526             endif;
017700170526
017800170822             if oeOnly = 'Y';
017900170822             if s1Setup = *Blanks;
018000170822                iter;
018100170822             EndIf;
018200170822             endif;
018300170822
018400000000
018500170822             //?Get Mail Range
018600171103             s1eRange = *Blanks;
018700171103             S1BEDT = *Blanks;
018800171103             s1Endt = *Blanks;
018900171103             s1Effdt = *Blanks;
019000171103
019100170822             chain ( aoTrst : aoSub# : aoAcct : 'RANGE' : 'OPEN') WebPayDtr;
019200171103
019300171103             if %Found( WebPayDtr );
019400170822             if pgmfdt > *zeros;
019500170822                s1eRange = 'EE OE Date Range: ' +
019600170822                    %Char(%Date(pgmfdt:*iso):*Usa) + ' - ' +
019700170822                    %Char(%Date(pgmtdt:*iso):*Usa) ;
019800170822             endif;
019900170822
020000170822             if pgfrdt > 0;
020100170822              test(de) *iso pgfrdt;
020200170822              if %Error;
020300170822                s1bedt = %Char(pgfrdt);
020400170822              else;
020500170822              S1BEDT =  %Char(%date(pgfrdt) :*usa)  ;
020600170822              endif;
020700170822             endif;
020800170822
020900170822             if pgtodt > 0;
021000170822              test(de) *iso pgtodt;
021100170822              if %error;
021200170822                s1endt = %Char(pgtodt);
021300170822              else;
021400170822             S1ENDT =  %Char(%date(pgtodt) :*usa)  ;
021500170822             endif;
021600170822             endif;
021700170822
021800170823             // Effective Date
021900170823             if pgefdt > 0;
022000170823              test(de) *iso pgefdt;
022100170823              if %error;
022200170823                s1effdt = %Char(pgefdt);
022300170823              else;
022400170823             S1EffDt =  %Char(%date(pgefdt) :*usa)  ;
022500170823             endif;
022600170823             endif;
022700170823
022800171103             endif;
022900170822
023000170526                If mySearch = *Blanks;
023100170526                   rrn = rrn + 1;
023200170526                   write LstSfl;
023300170526                endIf;
023400170526
023500170526
023600170526                If mySearch > *Blanks;
023700170526                   mySearch = ucase(mySearch);
023800170526                   If %Scan( %Trim(mySearch) : s1Acct ) > 0  or
023900170822                      %Scan( %Trim(mySearch) : s1ActNam ) > 0 or
024000170822                      %Scan( %Trim(mySearch) : s1FullAcct ) > 0 ;
024100170526                      rrn = rrn + 1;
024200170526                      write LstSfl;
024300170526                   endIf;
024400170526                endIf;
024500170526
024600000000
024700170526             If rrn >= 9999;
024800170526                leave;
024900170526             endIf;
025000000000
025100000000          enddo;
025200000000
025300170526       Endsr;
025400000000
025500170526       // ----------------------------------------------------------------
025600170526       Begsr DISPLY;
025700000000
025800170526          If rrn = 0;
025900170526             *in31 = *off;
026000170526             write NoRcd;
026100170526             reload = 'Y';
026200170526          endIf;
026300000000
026400170526          If rrn > 0;
026500170526             write Cmd;
026600170526             *in31 = *on;
026700170526          endIf;
026800000000
026900170526          if RcdNbr > rrn;
027000170526             RcdNbr = rrn;
027100170526          EndIf;
027200000000
027300170526          EXFMT LstCtl;
027400000000
027500000000
027600170526       Endsr;
