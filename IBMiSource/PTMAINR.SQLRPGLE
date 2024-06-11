000100161109     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200161109    ? *-------------------------------------------------------------------------
000300161109    ? *
000400161109    ? *  Description:  View Payroll Calendar
000500161109    ? *  Programmer.:  Brian Rees
000600161109    ? *  Date.......:  08/31/2016
000700161109    ? *
000800161109    ? *-------------------------------------------------------------------------
000900170327    ?FptMainD   CF   E             WORKSTN
001000161109     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001100161109    ?F                                     SFILE(LSTSFL:rrn)
001200161109
001300170327     FptProj    uf a E           k disk
001400161109     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
001500161109
001600180501
001700180501       dcl-f ptEmail keyed usage( *output : *update );
001800180501
001900180501       Dcl-f ptbroker keyed
002000180501          usage( *input : *output : *update  ) ;
002100180501
002200180525       dcl-f cmct14  keyed ExtDesc('F.CMCT14') ExtFile(*ExtDesc);
002300180525       dcl-f sman2l1 keyed ExtDesc('F.SMAN2L1') ExtFile(*ExtDesc);
002400180525       dcl-f sman    keyed ExtDesc('F.SMAN') ExtFile(*ExtDesc);
002500180501
002600170420
002700161109    ? *-------------------------------------------------------------------------
002800161109    ? * Program status data structure
002900161109    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003000161109     D  @pgmq            *proc
003100161109
003200161109    ? * Display file data structure
003300161109    ?D DSPD            DS
003400161109     D  Key                  369    369
003500161109     D  Currec               378    379b 0
003600161109
003700161109     d Rrn             s              5s 0 inz
003800161109     d ReLoad          s              1
003900161111
004000170327     d aNextId         s              5
004100170327     d nNextId         s              5S 0
004200170329     d
004300170329     d nOpenTsk        s              5S 0
004400170329     d nClosedTsk      s              5S 0
004500170329     d CRLF            C                   x'0d25'
004600170412     d
004700170412     d isAdmin         s               n
004800171107     D wLineID         S              7S 0
004900171107     d
005000161111      *--------------------------------------------
005100161111      *?Procedures
005200161111      *--------------------------------------------
005300170412     D/include GBSPGM/QMODSRC,#ChkFncAth        // Check Function Authority
005400180216     D/include *LIBL/QMODSRC,#COMMANDPR         // Command
005500161111
005600170329      *?Task Maintenance
005700170329     D ptTaskR         pr                  extpgm('PTTASKR')
005800170327     D   iProjKey                    10
005900170327     d iMainKey        s             10
006000170327     D iProjKey        s             10
006100161111
006200161118
006300170329     d ptDocsR         pr                  extpgm('PTDOCSR')
006400170327     D   iProjKey                    10
006500161118
006600161118
006700170330     d ptChartr        pr                  extpgm('PTCHARTR')
006800170327     D   iProjKey                    10
006900170320
007000170605     d ptSetupC        pr                  extpgm('PTSETUPC')
007100170605
007200180417       dcl-pr ptbrokerr ExtPgm('PTBROKERR');
007300180417          iMainKey Char(10);
007400180417          iProjKey char(10);
007500180417       End-Pr;
007600170320
007700161111
007800161109    ? *-------------------------------------------------------------------------
007900161109      *?Mainline Program
008000161109    ? *-------------------------------------------------------------------------
008100161109      /Free
008200161109
008300180501       Exec Sql
008400180501          Set Option Commit = *None
008500180501          ,Naming = *Sys;
008600161109
008700161109       Dou btnExit = *on;
008800161109          If Reload = 'Y';
008900161109             exsr CLEAR;
009000161109             exsr LOAD;
009100161109             Reload = 'N';
009200161109          endIf;
009300161109
009400161109          exsr DISPLY;
009500161109
009600161109
009700161109          //?Process Selections
009800161109          Select;
009900161109
010000161109          When btnAddNew = *on;
010100161109             Exsr Add_Screen;
010200161109             Reload = 'Y';
010300161109
010400170605
010500170605          When btnSetup = *on;
010600170605             ptSetupc();
010700170605             Reload = 'Y';
010800170605
010900161109          other;
011000161109             exsr ReadChanged;
011100161109
011200161109          EndSl;
011300161109
011400161109
011500161109       enddo;
011600161109
011700161109       *inlr = *on;
011800161109
011900161110       // ----------------------------------------------------------------
012000161109       Begsr *Inzsr;
012100161109
012200161110          Reload = 'Y';
012300170915
012400170915
012500170412          //?User Allowed an Admin?
012600170412          isAdmin = *off;
012700170412          oFunction = '*ADMIN';
012800170412          oDspErrMsg = 'N';
012900170412
013000170412          ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
013100170412          if oContinue = 'Y';
013200170412             isAdmin = *on;
013300170412          endif;
013400170412
013500170915          MenuID = *Blanks;
013600170915          if isAdmin = *on;
013700170915             MenuID = 'Menu2';
013800170915          endif;
013900170915
014000170412
014100161109
014200161109       Endsr;
014300161109       // ----------------------------------------------------------------
014400161109       Begsr CLEAR;
014500161109
014600161110          //?Clear the Subfile
014700161110          ClrSfl = *on;
014800161110          Write Screen1;
014900161110          ClrSfl = *off;
015000161110          rrn = 0;
015100161109
015200161109       Endsr;
015300161109       // ----------------------------------------------------------------
015400161110       Begsr Load;
015500161109
015600170327          Setll *loval ptProj;
015700170327          Dou %eof(ptProj);
015800161109
015900170327             read ptProj;
016000170327             if %eof(ptProj);
016100161109                leave;
016200161109             endif;
016300161109
016400170327             s1MainKey = pjMainKey;
016500170327             s1ProjKey = pjProjKey;
016600170327             s1ProjDesc = pjDescr;
016700170327
016800170327             s1ActNam = pjNam1;
016900170330             s1Status = *blanks;
017000170327             Select;
017100180216             when pjRcdSts = 'C';
017200180216                s1Status = 'Closed';
017300180216             when pjRcdSts = 'I';
017400180216                s1Status = 'InProcess';
017500180216             when pjRcdSts = 'A';
017600180216                s1Status = 'Active';
017700170327             Endsl;
017800170327
017900170329             //?Generate the Tooltip Message
018000180417             Exec Sql
018100180417                Select Count(*)
018200180417                Into :Nopentsk
018300180417                From Pttask
018400180417                Where Ptprojkey = :S1projkey
018500180417                And Ptstatus <> 'COMPLETED';
018600170329
018700180417             Exec Sql
018800180417                Select Count(*)
018900180417                Into :Nclosedtsk
019000180417                From Pttask
019100180417                Where Ptprojkey = :S1projkey
019200180417                And Ptstatus = 'COMPLETED';
019300170329
019400180216             s1StsCnt = %Char( nOpenTsk ) + ' Open Tasks.' + crlf +
019500180216                %Char( nClosedTsk ) + ' Closed Tasks.';
019600170329
019700170327             s1TSA = *Blanks;
019800170327             if pjTrst > 0;
019900180216                s1TSA = %Editc(pjTrst:'X') + '-' +
020000180216                   %Editc(pjSub#:'X') + '-' +
020100180216                   %Editc(pjAcct:'X') ;
020200170327             endif;
020300161109
020400170915             s1Update = *blanks;
020500170915             s1UpdMsg = *blanks;
020600170327             if pjChgDt > 0;
020700170915                s1Update = %Char( %Date(pjChgDt:*iso));
020800170327                s1UpdMsg = 'Record last updated by ' +
020900180216                   %Trim(pjChgBy) + ' on ' +
021000180216                   %Char(%date(pjChgDt) :*usa) + ' at ' +
021100180216                   %Char(%Time(pjChgTm) :*usa);
021200180216             endif;
021300170327
021400170915
021500170915             //?Created Date
021600170915             s1Created = %Char(%Date(pjCrtDt:*iso));
021700170915             s1CrtMsg  = 'Record created by ' +
021800180216                %Trim(pjCrtBy) + ' on ' +
021900180216                %Char(%date(pjCrtDt) :*usa) + ' at ' +
022000180216                %Char(%Time(pjCrtTm) :*usa);
022100170327
022200170327
022300180216             rrn = rrn + 1;
022400161109             write LstSfl;
022500161109
022600161109             If rrn >= 9999;
022700161109                leave;
022800161109             endIf;
022900161109
023000161110          enddo;
023100161109
023200161110       Endsr;
023300161109
023400161109       // ----------------------------------------------------------------
023500161109       Begsr DISPLY;
023600161109
023700161110          DspSfl = *on  ;
023800161110          exfmt Screen1;
023900161110          DspSfl = *off;
024000161109
024100161109       Endsr;
024200161109       // ----------------------------------------------------------------
024300161109       Begsr ReadChanged;
024400161109
024500161109          Dou *in95 = *ON;
024600161109             READC LstSfl;
024700161109             *in95 = %EOF;
024800161109
024900161109             If *in95 = *OFF;
025000161109
025100161109                If btnEdit = *on;
025200170329                   ptTaskR( s1ProjKey );
025300161109                endIf;
025400161118
025500161118                If btnDocs = *on;
025600170329                   ptDocsR( s1ProjKey );
025700161118                endIf;
025800161118
025900170320
026000170320                If btnChart = *on;
026100170330                   ptChartR( s1ProjKey );
026200170320                endIf;
026300170320
026400170915                //?Check Content Menu Options
026500170915                if runOption > *blanks;
026600170915
026700170918                   s2ProjDesc = s1ProjDesc;
026800170918
026900170918
027000170915                   if runOption = 'DelProj';
027100180216                      exfmt Screen2;
027200180216                      if btnCont = *on;
027300170918
027400180501                         Exec Sql
027500180501                            Delete From Ptdocs Where Odprojkey = :S1projkey;
027600180501                         Exec Sql
027700180501                            Delete From Ptproj Where Pjprojkey = :S1projkey;
027800180501                         Exec Sql
027900180501                            Delete From Pttask Where Ptprojkey = :S1projkey;
028000180501                         Exec Sql
028100180501                            Delete From Ptbroker Where Pbproject = :S1projkey;
028200180501
028300180501                      Endif;
028400170918
028500180501                      btnCont = *off;
028600180501                      btnExit = *off;
028700180501                   endif;
028800171110
028900180501                   if runOption = 'ReName';
029000180501                      Exec Sql  Select PjDescr into :s2Descr From PtProj
029100180501                         where pjProjKey = :s1ProjKey;
029200171110
029300180501                      dou btnExit = *on;
029400180216                         exfmt ChangeName;
029500180501                         if btnCont = *on;
029600180216                            Exec Sql  update ptProj Set PjDescr = :s2Descr
029700180216                               where pjProjKey = :s1ProjKey;
029800180501                            leave;
029900180501                         endif;
030000180501                      enddo;
030100171110
030200180501                      btnCont = *off;
030300180501                      btnExit = *off;
030400180501                   endif;
030500171110
030600180417
030700180417
030800180501                   if runOption = 'BrkEmail';
030900180417                      ptBrokerr( s1MainKey : s1ProjKey );
031000180501                   EndIf;
031100171110
031200180501                endif;
031300170915
031400170320
031500180501                btnEdit = *off;
031600180501                btnDocs = *off;
031700180501                btnChart = *off;
031800180501                runOption = *Blanks;
031900180501                update LstSfl;
032000161109
032100180501                Reload = 'Y';
032200180501             endIf;
032300161118
032400161109
032500180501          enddo;
032600180501       Endsr;
032700161109
032800161109
032900161109       //-----------------------------------------------------------------
033000161109       //?                       ADD Screen
033100161109       //-----------------------------------------------------------------
033200180417       Begsr Add_Screen;
033300161109
033400180501          Clear AddScreen;
033500161109
033600180417          Dou btnCancel = *on;
033700161109
033800180501             exfmt AddScreen;
033900161110             errAcct = *off;
034000161110
034100161109
034200180417             if btnCancel = *on;
034300180501                leave;
034400180501             endif;
034500161109
034600161109
034700180417             if btnAccept = *on;
034800161109
034900161110                //?Validate...
035000170327                if s1HasAcct = 'Y';
035100180216                //    chain (s2Trst : s2Sub : s2Acct) oeSetup;
035200180216                //    if %Found(oeSetup);
035300180216                //       ErrAcct = *on;
035400180216                //       iter;
035500180216                //    endif;
035600170327                endif;
035700161109
035800170327
035900170327                //----------------------------------------------
036000161110                //?No Errors - Update.
036100170327                //----------------------------------------------
036200170327
036300170327                //?Get Next Unique ID Number..
036400170327                Exec Sql
036500180501                   Select max( substring( pjProjKey , 3 ))
036600180417                   into :nNextId
036700180417                   From ptProj
036800180417                   Where substring( pjProjKey , 1, 2 ) = 'PJ' ;
036900170327
037000180501                if SqlCod <> 0;
037100180417                   nNextId = 0;
037200180216                endif;
037300170327
037400170327                nNextId = nNextId + 1;
037500170327                aNextId = %Editc(nNextId : 'X');
037600170327
037700170327
037800170328                pjMainKey = s2MainKey;
037900170327                pjProjKey = 'PJ' + aNextId;
038000170327                pjDescr = s2Descr;
038100170327                pjOwner = s2Owner;
038200170327                pjEmail = s2Email;
038300170327
038400170327                pjTrst = s2trst;
038500170327                pjSub# = s2Sub;
038600170327                pjAcct = s2Acct;
038700161109
038800170327
038900180417                if s1HasAcct = 'Y';
039000180501                   chain (s2Trst : s2Sub : s2acct) AccMst;
039100180417                   if %Found(AccMst);
039200180501                      pjNam1 = AcNam1;
039300180501                   endif;
039400180501                else;
039500180501                   pjNam1 = s2ProjName;
039600180501                endif;
039700170327
039800170329                pjRcdSts = 'A';
039900170329
040000170327                pjCrtBy = wqusrn;
040100170327                pjCrtDt = %Dec(%Date);
040200170327                pjCrtTm = %Dec(%Time);
040300161109
040400170915                pjCloBy = *Blanks;
040500170915                pjCloDt = 0;
040600170915                pjCloTm = 0;
040700170915                pjChgBy = *Blanks;
040800170915                pjChgDt = 0;
040900170915                pjChgTm = 0;
041000170915
041100170915
041200170327                Write r_ptProj;
041300161109
041400170420                exsr CheckEmail;
041500180216
041600180216                // Send an email to let people know about the task
041700180216                NewTaskEmail();
041800180216
041900170321
042000170420
042100170321                //?Load the Action Items...
042200170328                Exec Sql
042300180501                   Insert into ptTask
042400180417                   ( ptProjKey, ptSeq, ptTrst, ptSub#, ptAcct,
042500180417                   ptDept, ptCatg, ptAction, ptContact, ptctEmail,
042600180417                   ptContact2, ptctEmail2,
042700180417                   ptManager, ptMgrMail, ptProgram, ptDepSeq,
042800180417                   ptToolTip,
042900180417                   ptEstHr, ptEstMn, ptEspDays, ptCrtby, ptCrtDt,
043000180417                   ptCrtTm, ptCloDt, ptCloTm, ptChgDt, ptChgTm, ptLineId)
043100170328
043200180417                   (Select :pjProjKey, tmSeq, :s2Trst, :s2Sub, :s2Acct,
043300180417                   tmDept, tmCatg, tmAction, tmContact, tmctEmail,
043400180417                   tmContact2, tmctEmail2,
043500180417                   tmManager, tmMgrMail, tmProgram, tmDepSeq,
043600180417                   tmToolTip,
043700180417                   tmEstHr, tmEstMn, tmEspDays, :wqusrn,
043800180417                   int(replace(char(current_date , ISO),'-','')),
043900180417                   int(replace(char(current_time),':','')), 0,0,0,0,
044000180417                   tmLineId
044100180417                   From ptTskMst Where tmMainKey = :s2MainKey ) ;
044200170321
044300180501
044400180501
044500180501                   LoadBroker();
044600180501
044700180501                leaveSr;
044800180501                endif;
044900161109
045000180501          Enddo;
045100161109
045200180501       Endsr;
045300170420
045400170420
045500170420       //-----------------------------------------------------------------
045600170420       //?                 Check Email...
045700170420       //-----------------------------------------------------------------
045800180417       Begsr CheckEmail;
045900170420
046000180501          //?Check Project Info...
046100180417          if s2Owner > *Blanks and s2Email > *Blanks;
046200170420             chain s2Owner ptEmail;
046300180417             if not %Found(ptEmail);
046400180501                puName = s2Owner;
046500180216                puEmail = s2Email;
046600180417                Write r_ptEmail;
046700180501             else;
046800180501                puEmail = s2Email;
046900180417                update r_ptEmail;
047000180501             endif;
047100180501          endif;
047200170420
047300170420
047400170420
047500180501       Endsr;
047600170420
047700180216
047800180216
047900180216      *-------------------------------------------------------------------------
048000180216       dcl-Proc  NewTaskEmail;
048100180216
048200180501          Dcl-s wEmail Char(60);
048300180417          Dcl-s Library Char(10);
048400180417          Dcl-s Msg Char(250);
048500180417          dcl-c q const ('''');
048600180216
048700180216
048800180417          //------------------------------
048900180417          // Get the Environment
049000180417          //------------------------------
049100180417          Exec Sql
049200180501             Select Objlo00002 Into :Library
049300180417             From Table(Qsys2.Object_Statistics('*LIBL', 'FILE',
049400180417             Object_Name => '"F.ACCMST"' )) As X ;
049500180216
049600180216
049700180216
049800180501          //------------------------------
049900180501          // Set the Email Message
050000180417          //------------------------------
050100180417          s2Descr = %ScanRpl(q:'':s2Descr);
050200180221
050300180417          Msg = 'A new task has been setup in the project ' +
050400180417             'tracking system.<p>Task: ' + s2Descr + '<p>' +
050500180417             'Project Owner: ' + s2Owner ;
050600180216
050700180501          if Library = 'GBSDTAT';
050800180417             Msg = %Trim(Msg) + '<P> NOTE: This is from the TEST ' +
050900180501                'Environment ** ';
051000180501          EndIf;
051100180216
051200180216
051300180417          Exec Sql  Declare C1 Cursor For
051400180501             Select Distinct Tmctemail
051500180417             From Pttskmst Where Tmmainkey = :S2mainkey
051600180417             Union
051700180417             Select Tmctemail2
051800180417             From Pttskmst Where Tmmainkey = :S2mainkey;
051900180216
052000180501          Exec Sql Open C1;
052100180216
052200180501          dou SqlCod <> *Zero;
052300180417             Exec Sql Fetch Next From C1 Into :Wemail;
052400180216
052500180501             if SqlCod <> *Zero;
052600180501                leave;
052700180417             EndIf;
052800180216
052900180501             if wemail = '';
053000180501                iter;
053100180417             EndIf;
053200180216
053300180216
053400180417             //  if Library = 'GBSDTAT';
053500180417             //     wEmail = 'brees@gbsio.net';
053600180417             //  EndIf;
053700180216
053800180417             CmdString = 'MailTool toAddr(' + %Trim(wEmail) + ') ' +
053900180417                ' Subject(' + q + 'New Task Created' + q + ') ' +
054000180417                ' Message(' + q + %Trim( Msg ) + q + ')' +
054100180417                ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
054200180216
054300180501             #Command(CmdString:%len(%Trim(CmdString)));
054400180501          EndDo;
054500180216
054600180216
054700180216
054800180216
054900180216
055000180216
055100180501       End-Proc;
055200180501
055300180501       //-----------------------------------------------------------------
055400180501       dcl-proc LoadBroker;
055500180501
055600180501
055700180501
055800180501          Setll (s2Trst : s2Sub : s2Acct ) cmct14;
055900180501
056000180501          Dou %Eof(cmct14);
056100180501             reade ( s2Trst : s2Sub : s2Acct ) cmct14;
056200180501             if %eof(cmct14);
056300180501                leave;
056400180501             endif;
056500180501
056600180501             if cmCan >0 and cmCan <= %dec(%Date);
056700180501                iter;
056800180501             EndIf;
056900180501
057000180501             pbProject = pjProjKey;
057100180501
057200180501             chain slsman sman2l1;
057300180501             if %found( sman2l1 ) ;
057400180501                pbEmail = sbreml;
057500180501             EndIf;
057600180501
057700180501             chain slsman sman;
057800180501             if %found( sman ) ;
057900180501                pbName = %trim( sfname) + ' ' + %Trim( slname );
058000180501             EndIf;
058100180501
058200180501             chain ( pjProjKey : pbName : pbEmail) ptBroker;
058300180501             if not %Found( ptBroker );
058400180501
058500180501                pbCrtBy = wqUsrn;
058600180501                pbCrtDt = %Dec(%Date);
058700180501                pbCrtTm = %Dec(%Time);
058800180501
058900180501                pbChgBy = '';
059000180501                pbChgDt = 0;
059100180501                pbChgTm = 0;
059200180501
059300180501
059400180501                write r_ptbroker;
059500180501             else;
059600180501                unlock ptBroker;
059700180501             endif;
059800180501
059900180501          Enddo;
060000180501
060100180501
060200180501       End-Proc;
060300180501
