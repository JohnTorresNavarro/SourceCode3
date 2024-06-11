000100220121        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220121                         DftActGrp(*no)
000300220121                         bnddir('GBSBIND' )   ;
000400141211    ? *-------------------------------------------------------------------------
000500000000    ? *
000600160201    ? *  Description:  Online Enrollment - QE Program List
000700141210    ? *  Programmer.:  Brian Rees
000800160201    ? *  Date.......:  02/01/2016
000900141210    ? *
001000141211    ? *-------------------------------------------------------------------------
001100160201    ?FGBS0007D  CF   E             WORKSTN
001200220121     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300141211    ?F                                     SFILE(LSTSFL:rrn)
001400000000    ?F                                     INFDS(DSPD)
001500160201    ?FMidLifLst if   e           k Disk
001600160209    ?FMidLifAct if   e           k Disk
001700141211    ? *-------------------------------------------------------------------------
001800000000    ? * Program status data structure
001900141212    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002000160324     D  @pgmq            *proc
002100160324
002200000000    ? * Display file data structure
002300141212    ?D DSPD            DS
002400141212     D  Key                  369    369
002500141212     D  Currec               378    379b 0
002600141211
002700141211    ? * Variables
002800141211     D F01             C                   CONST(X'31')
002900141211     D F03             C                   CONST(X'33')
003000141211     D F06             C                   CONST(X'36')
003100141216     D F08             C                   CONST(X'38')
003200141218     D F10             C                   CONST(X'3A')
003300151216     D F12             C                   CONST(X'3C')
003400141212     D Enter           C                   const(X'F1')
003500141211
003600141212
003700151216     d Rrn             s              5s 0 inz
003800151216     d SaveCursPos     S              4S 0
003900151216     d ReLoad          s              1
004000151216     d hldSearch       S                   like(mySearch)
004100160209
004200160209     d Action_Add      s              1
004300160209     d Action_Term     s              1
004400160209     d Action_RmvDep   s              1
004500151216
004600151216      *--------------------------------------------
004700151216      *?Procedures
004800151216      *--------------------------------------------
004900151216     D/COPY *LIBL/QMODSRC,PR0001RPR            // Case Functions
005000160324     D/COPY *LIBL/QMODSRC,PR0003RPR            // Check Program Authority
005100151217
005200160201     d QEList          pr                  ExtPgm('GBS0007R1')
005300160202     d  oDescr                       50
005400160202     d  oMode                        10
005500160202     d  oEvent                       20
005600160202
005700141211    ? *-------------------------------------------------------------------------
005800151216      *?Mainline Program
005900141211    ? *-------------------------------------------------------------------------
006000141211      /Free
006100151216
006200151216       Dow key <> F03;
006300151216
006400151216
006500151216          If HldSearch <> mySearch or Reload = 'Y';
006600151216             HldSearch= mySearch;
006700151216             exsr CLEAR;
006800151216             exsr LOAD;
006900151216             Reload = 'N';
007000151216          endIf;
007100151216
007200151216
007300151216          exsr DISPLY;
007400151216
007500151216          //?Process Selections
007600151216          Select;
007700151216
007800151216          When key = ENTER and Rrn > 0;
007900151216             exsr PROCES;
008000151216
008100151216          EndSl;
008200151216       enddo;
008300151216
008400151216       *inlr = *on;
008500151216
008600151216      // ----------------------------------------------------------------
008700151216       Begsr *Inzsr;
008800151216
008900151216         Reload = 'Y';
009000151216
009100160324         //?Check Program Authority
009200160324         ChkPgmAuth(@pgmq : oContinue);
009300160324         if oContinue = 'N';
009400160324            *inlr = *on;
009500160324            Return;
009600160324         endif;
009700160324
009800151216       Endsr;
009900151216       // ----------------------------------------------------------------
010000151216       Begsr CLEAR;
010100151216
010200151216           RcdNbr = 1;
010300151216           If SaveCursPos > 0;
010400151216              RcdNbr = SaveCursPos;
010500151216              SaveCursPos = 0;
010600151216           endIf;
010700151216
010800151216           // Clear the Subfile.
010900151216           *in31 = *off;                     // Subfile Display
011000151216           *in32 = *off;                     // Subfile Disp Control
011100151216           *in33 = *on;                      // Subfile Clear
011200151216
011300151216           write LstCtl;
011400151216
011500151216           *in31 = *off;                     // Subfile Display
011600151216           *in32 = *on;                      // Subfile Disp Control
011700151216           *in33 = *off;                     // Subfile Clear
011800151216           rrn = 0;
011900151216
012000151216       Endsr;
012100151216       // ----------------------------------------------------------------
012200151216
012300151216         Begsr Load;
012400151216
012500151216            *in37 = *off;
012600160201            setll *loval MidLifLst;
012700160201            dou %eof(MidLifLst);
012800160201               read MidLifLst;
012900151216
013000151223
013100160201               If %Eof(MidLifLst);
013200151216                  *in37 = *on;
013300151216                  leave;
013400151216               endIf;
013500151216
013600160201                s1Desc = mdDesc;
013700160201                s1Event = mdEvent;
013800160201
013900160201
014000160209                exsr CheckAction;
014100160201
014200151216                If mySearch = *Blanks;
014300160209                   if Action_Add = 'Y';
014400160201                      s1Mode = 'ADD';
014500160201                      rrn = rrn + 1;
014600160201                      write LstSfl;
014700160201                   endIf;
014800160201
014900160209                   if Action_Term = 'Y';
015000160201                      s1Mode = 'TERM';
015100160201                      rrn = rrn + 1;
015200160201                      write LstSfl;
015300160201                   endIf;
015400160209
015500160209                   if Action_RmvDep = 'Y';
015600160209                      s1Mode = 'RMVDEP';
015700160209                      rrn = rrn + 1;
015800160209                      write LstSfl;
015900160209                   endIf;
016000160201                endIf;
016100151216
016200151216
016300151216                If mySearch > *Blanks;
016400151216                   mySearch = ucase(mySearch);
016500160201                   If %Scan( %Trim(mySearch) : uCase(s1Desc) ) > 0  ;
016600160201
016700160209                      if Action_Add = 'Y';
016800160201                         s1Mode = 'ADD';
016900160201                         rrn = rrn + 1;
017000160201                         write LstSfl;
017100160201                      endIf;
017200160201
017300160209                      if Action_Term = 'Y';
017400160201                         s1Mode = 'TERM';
017500160201                         rrn = rrn + 1;
017600160201                         write LstSfl;
017700160201                      endIf;
017800160209
017900160209                      if Action_RmvDep = 'Y';
018000160209                         s1Mode = 'RMVDEP';
018100160209                         rrn = rrn + 1;
018200160209                         write LstSfl;
018300160209                      endIf;
018400160201
018500151216                   endIf;
018600151216                endIf;
018700151216
018800151216                If rrn >= 9999;
018900151216                   leave;
019000151216                endIf;
019100151216
019200151216            enddo;
019300151216
019400151216         Endsr;
019500151216
019600151216       // ----------------------------------------------------------------
019700151216       Begsr DISPLY;
019800151216
019900151216          If rrn = 0;
020000151216             *in31 = *off;
020100151216             write NoRcd;
020200151216             reload = 'Y';
020300151216          endIf;
020400151216
020500151216          If rrn > 0;
020600151216             write Cmd;
020700151216             *in31 = *on;
020800151216          endIf;
020900151216
021000151216          EXFMT LstCtl;
021100151216
021200151216
021300151216       Endsr;
021400151216       // ----------------------------------------------------------------
021500151216       Begsr PROCES;
021600151216
021700151216          Dou *in95 = *ON;
021800151216             READC LstSfl;
021900151216             *in95 = %EOF;
022000151216
022100151216             If *in95 = *OFF;
022200151216                SaveCursPos = rrn;
022300151216
022400151216                If s1Opt  = '2';
022500160202                   QEList( s1Desc : s1Mode : s1Event ) ;
022600151216                endIf;
022700160202
022800151216
022900151216                s1Opt = '';
023000151216                update LstSfl;
023100151216                Reload = 'Y';
023200151216             endIf;
023300151216
023400151216          enddo;
023500151216       Endsr;
023600160209       // ----------------------------------------------------------------
023700160209       Begsr CheckAction;
023800151216
023900160209          Action_Add    = *Blanks;
024000160209          Action_Term   = *Blanks;
024100160209          Action_RmvDep = *Blanks;
024200160209
024300160209          Setll mdEvent MidLifAct;
024400160209          dou %Eof(MidLifAct);
024500160209             reade mdEvent MidLifAct;
024600160209
024700160209                if %Eof(MidLifAct);
024800160209                   leave;
024900160209                endif;
025000160209
025100160209               //?Search for "ADD" Mode
025200160209               if %Scan( '_ADD' : maAction ) > 0;
025300160209                  Action_Add = 'Y';
025400160209               endif;
025500160209
025600160209               //?Search for "TERM" Mode
025700160209               if %Scan( '_TERM' : maAction ) > 0;
025800160209                  Action_TERM = 'Y';
025900160209               endif;
026000160209
026100160209               //?Search for "RMVDEP" Mode
026200160209               if %Scan( '_RMVDEP' : maAction ) > 0;
026300160209                  Action_RMVDEP = 'Y';
026400160209               endif;
026500160209            enddo;
026600160209
026700160209       Endsr;
