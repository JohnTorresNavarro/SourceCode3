000100220121        Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200220121                         DftActGrp(*no)
000300220616                         bnddir('GBSBIND' )   ;
000400141211    ? *-------------------------------------------------------------------------
000500000000    ? *
000600160201    ? *  Description: Online Enrollment - QE Program List
000700160201    ? *  Programmer.: Brian Rees
000800160201    ? *  Date.......: 02/01/2016
000900141210    ? *
001000141211    ? *-------------------------------------------------------------------------
001100160201    ?FGBS0007D1 CF   E             WORKSTN
001200220121     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001300141211    ?F                                     SFILE(LSTSFL:rrn)
001400000000    ?F                                     INFDS(DSPD)
001500160201    ?FMidLifeP  uf a e           k Disk
001600160201    ?FQePgmLstl1if   e           k Disk
001700141211    ? *-------------------------------------------------------------------------
001800151223
001900151223      * Program status data structure
002000151223     D PGMD          ESDS                  EXTNAME(IOPGMD)
002100151223     D  @pgmq            *proc
002200151223
002300151223
002400151223
002500000000    ? * Display file data structure
002600141212    ?D DSPD            DS
002700141212     D  Key                  369    369
002800141212     D  Currec               378    379b 0
002900141211
003000141211    ? * Variables
003100141211     D F01             C                   CONST(X'31')
003200141211     D F03             C                   CONST(X'33')
003300141211     D F06             C                   CONST(X'36')
003400141216     D F08             C                   CONST(X'38')
003500141218     D F10             C                   CONST(X'3A')
003600151216     D F12             C                   CONST(X'3C')
003700141212     D Enter           C                   const(X'F1')
003800141211
003900141212
004000151216     d Rrn             s              5s 0 inz
004100151216     d SaveCursPos     S              4S 0
004200151216     d ReLoad          s              1
004300151216     d RcdMode         s             10
004400151217     d hasError        s               n
004500151216
004600151218     d CstCntr         s              3    inz
004700160202     d EventCode       s             20    inz
004800160204     d AllPgms         s              1    inz
004900160202
005000160202     d GBS0007R2       pr                  ExtPgm('GBS0007R2')
005100160202     d  oPgmD                        35
005200160202     d  oPgmName                     14
005300160202     d  oCancel                       1
005400160202
005500160202     d  iPgmD          s             35    inz
005600160202     d  iPgmNam        s             14    inz
005700160202     d  iCancel        s              1    inz
005800151218
005900151217      *--------------------------------------------
006000151217      *?Procedures
006100151217      *--------------------------------------------
006200151217     D/COPY *LIBL/QMODSRC,PR0001RPR            // Case Functions
006300160202     D/include *LIBL/QMODSRC,#MSGSUBF             // Message Subfile Procedures.
006400151217
006500141211    ? *-------------------------------------------------------------------------
006600151216      *?Mainline Program
006700141211    ? *-------------------------------------------------------------------------
006800151216     C     *entry        plist
006900160201     C                   parm                    pDescr           50
007000160201     C                   parm                    pMode            10
007100160201     C                   parm                    pEvent           20
007200151216
007300141211      /Free
007400151216
007500160202       EventCode = %Trim(pEvent) + '_' + %Trim(pMode);
007600160204       Dow key <> F12;
007700151216
007800151216
007900151216          If Reload = 'Y';
008000151216             exsr CLEAR;
008100151216             exsr LOAD;
008200151216             Reload = 'N';
008300151216          endIf;
008400151216
008500151216
008600151216          exsr DISPLY;
008700151216
008800151216          //?Process Selections
008900151216          Select;
009000160204          When key = F06 and AllPgms = 'N';
009100151216             Reload = 'Y';
009200151216
009300160202             gbs0007r2( iPgmd : iPgmNam : iCancel ) ;
009400160202
009500160202             if iCancel = *Blanks;
009600160202
009700160202                chain(n) ( EventCode : iPgmNam ) MidLifep;
009800160202                if %Found( MidLifep );
009900160202                   msgData = 'The program is already set for this Event.' +
010000160202                             ' The Record was NOT added.';
010100160202                   exsr SendMsg;
010200160202                else;
010300160202
010400160209                   mlAction = EventCode;
010500160202                   mlProgram = iPgmNam;
010600160202                   mlCrtBy = WQUSRN;
010700160202                   mlCrtDt = %Dec( %Date() ) ;
010800160202                   mlCrtTm = %Dec( %Time() ) ;
010900160202                   write MidLifepR;
011000160202                endif;
011100160202             endif;
011200160202
011300160202
011400160202          When key = Enter;
011500160202             exsr PROCES;
011600160202
011700151216
011800151216          EndSl;
011900151216       enddo;
012000151216
012100151216       *inlr = *on;
012200151216
012300151216      // ----------------------------------------------------------------
012400151216       Begsr *Inzsr;
012500151216
012600151216         Reload = 'Y';
012700151216
012800151217
012900151216       Endsr;
013000151216       // ----------------------------------------------------------------
013100151216       Begsr CLEAR;
013200151216
013300151216           RcdNbr = 1;
013400151216           If SaveCursPos > 0;
013500151216              RcdNbr = SaveCursPos;
013600151216              SaveCursPos = 0;
013700151216           endIf;
013800151216
013900151216           // Clear the Subfile.
014000151216           *in31 = *off;                     // Subfile Display
014100151216           *in32 = *off;                     // Subfile Disp Control
014200151216           *in33 = *on;                      // Subfile Clear
014300151216
014400151216           write LstCtl;
014500151216
014600151216           *in31 = *off;                     // Subfile Display
014700151216           *in32 = *on;                      // Subfile Disp Control
014800151216           *in33 = *off;                     // Subfile Clear
014900151216           rrn = 0;
015000151216
015100151216       Endsr;
015200151216       // ----------------------------------------------------------------
015300151216
015400151216         Begsr Load;
015500151216
015600160204            AllPgms = 'N';
015700151216            *in37 = *off;
015800160204            *in80 = *off;
015900160202            setll EventCode MidLifeP;
016000160201            dou %eof(MidLifeP);
016100160202               reade EventCode MidLifeP;
016200151216
016300160201               If %Eof(MidLifeP);
016400151216                  *in37 = *on;
016500151216                  leave;
016600151216               endIf;
016700151216
016800160201                s1PgmNam = mlProgram;
016900160201                s1PgmD = *Blanks;
017000151216
017100160201                chain mlProgram QePgmLstL1;
017200160201                if %Found( QePgmLstL1 ) ;
017300160201                   s1PgmD = qlPgmd;
017400160201                endif;
017500160201
017600160204                if mlProgram = '*ALL';
017700160204                   AllPgms = 'Y';
017800160204                   *in80 = *on;
017900160204                endif;
018000160204
018100151216                rrn = rrn + 1;
018200151216                write LstSfl;
018300151216
018400151216                If rrn >= 9999;
018500151216                   leave;
018600151216                endIf;
018700151216
018800151216            enddo;
018900151216
019000151216         Endsr;
019100151216
019200151216       // ----------------------------------------------------------------
019300151216       Begsr DISPLY;
019400151216
019500151216          If rrn = 0;
019600151216             *in31 = *off;
019700151216             write NoRcd;
019800151216             reload = 'Y';
019900151216          endIf;
020000151216
020100151216          If rrn > 0;
020200151216             write Cmd;
020300151216             *in31 = *on;
020400151216          endIf;
020500151223
020600151223          if RcdNbr > rrn;
020700151223             RcdNbr = rrn;
020800151223          EndIf;
020900160202          write MSGCTL;
021000151216          EXFMT LstCtl;
021100160202          exsr RemoveMsg;
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
022400151223
022500160201                If s1Opt  = '4';
022600160202                  chain (EventCode : s1PgmNam) MidLifep;
022700151223
022800160201                  if %Found(MidLifep);
022900160201                     delete MidLifep;
023000151223
023100151223                     if SaveCursPos > 1;
023200151223                        SaveCursPos = SaveCursPos -1;
023300151223                     endif;
023400151223                  EndIf;
023500151223
023600151223
023700151223                endIf;
023800151223
023900151216
024000151216                s1Opt = '';
024100151216                update LstSfl;
024200151216                Reload = 'Y';
024300151216             endIf;
024400151216
024500151216          enddo;
024600151216       Endsr;
024700151216
024800151216       // ----------------------------------------------------------------
024900160202         Begsr SendMsg;
025000160202
025100160202            messageid = '';
025200160202            qualmsgf   = '';
025300160202
025400160202       //      msgdata     = 'This is an error message';
025500160202
025600160202            msgdtalen  = %len(%trim(msgdata));
025700160202            msgtype    = '*DIAG';
025800160202            callstkent = '*';
025900160202            callstkcnt = 0;
026000160202            messagekey = ' ';
026100160202
026200160202            sndpgmmsg( messageid: qualmsgf:
026300160202                msgdata : msgdtalen: msgtype:
026400160202                callstkent: callstkcnt: messagekey:
026500160202                *null );
026600160202         Endsr;
026700160202
026800160202       //------------------------------------------------------
026900160202         Begsr RemoveMsg;
027000160202
027100160202            messageRmv = '*ALL';
027200160202            callstkent = '*';
027300160202            callstkcnt = 0;
027400160202            messagekey = ' ';
027500160202            clrpgmmsg(
027600160202                callstkent: callstkcnt: messagekey:
027700160202                messageRmv : *null );
027800160202
027900160202         Endsr;
