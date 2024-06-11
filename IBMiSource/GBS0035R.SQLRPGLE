000100180507
000200210511       Ctl-opt option(*noDebugIo)  DftActGrp(*no)  bnddir('GBSBIND') ;
000300180507
000400180507
000500160928      *-------------------------------------------------------------------------
000600160928      *
000700171211      *  Description: File Import Settings
000800161007      *  Programmer.: Brian Rees
000900171211      *  Date.......: 12/11/2017
001000160928      *
001100170322      *
001200160928      *-------------------------------------------------------------------------
001300160928      * Modifications
001400160928      *
001500160928      * Date         Programmer    Mod      Description
001600160928      *-------------------------------------------------------------------------
001700210511      * 05/11/2021   B.Rees                 Added Search Box.
001800160928      *
001900160928      *-------------------------------------------------------------------------
002000180507
002100180507
002200180507       dcl-f gbs0035d workstn
002300180507          HANDLER('PROFOUNDUI(HANDLER)')
002400180507          SFILE(LSTSFL:rrn);
002500180507
002600180507       dcl-f gbs0035P keyed
002700180507          usage( *output : *update : *Delete );
002800180508
002900180508       dcl-f LumQuestp keyed
003000180508          usage( *output : *update : *Delete );
003100180508
003200180508
003300180508
003400180507
003500180507      *-------------------------------------------------------------------------
003600180507      *
003700180507      * Global Variables
003800180507      *
003900180507      *-------------------------------------------------------------------------
004000161005
004100180507       dcl-ds pgmd
004200180507          ExtName('IOPGMD') PSDS;
004300200116         @pgmq *proc;
004400180507       end-ds;
004500180507
004600180507
004700180507       dcl-s hasError ind;
004800180507       dcl-s reLoad char(1);
004900180507       dcl-s rrn Zoned(5);
005000180507
005100180507       dcl-s wGroup Char(20);
005200180507
005300171211
005400161227      *--------------------------------------------
005500180507      *
005600161227      * Procedures
005700180507      *
005800161227      *--------------------------------------------
005900210511      /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
006000210511
006100180507       dcl-pr GBS0035R1 ExtPgm('GBS0035R1');
006200200116         iGroup Char(20);
006300200116         iGrpName Char(40);
006400180507       End-Pr;
006500180507
006600180508
006700180510       dcl-pr GBS0035R2 ExtPgm('GBS0035R2');
006800200116         iGroup Char(20);
006900180510       End-Pr;
007000180510
007100180806       dcl-pr GBS0035R3 ExtPgm('GBS0035R3');
007200200116         iGroup Char(20);
007300180806       End-Pr;
007400180508
007500180807       dcl-pr GBS0035R4 ExtPgm('GBS0035R4');
007600200116         iGroup Char(20);
007700180807       End-Pr;
007800180807
007900161005      *-------------------------------------------------------------------------
008000180507      *
008100180507      * Mainline Program
008200180507      *
008300161005      *-------------------------------------------------------------------------
008400210511       Exec Sql
008500210511         Set Option Commit = *None, Naming = *Sys;
008600161222       Reload = 'Y';
008700161222
008800150902
008900161223       dou btnExit = *on;
009000160928
009100210511         //if Reload = 'Y';
009200200116           ClearS1();
009300200116           LoadS1();
009400210511         //  Reload = 'N';
009500210511        // endif;
009600160928
009700200116         DisplyS1();
009800160928
009900200116         if btnExit = *on;
010000200116           leave;
010100200116         endif;
010200161223
010300161223
010400200116         Select;
010500210511
010600210511         when btnRefresh = *on;
010700210511           s1Search = '';
010800210511           iter;
010900210511
011000210511
011100200116         when  btnAddNew = *on;
011200200116           Clear AddScreen;
011300200116           ReLoad = 'Y';
011400200116           $AddRecord();
011500161223
011600200116         other;
011700200116           ReadChanged();
011800161223
011900200116         endsl;
012000161223
012100180507       enddo;
012200160928
012300180507       *inlr = *on;
012400160928
012500160928      *-------------------------------------------------------------------------
012600180508       dcl-proc ClearS1;
012700160928
012800200116         //?Clear the Subfile
012900200116         ClrSfl = *on;
013000200116         Write LstCtl;
013100200116         ClrSfl = *off;
013200160928
013300200116         rrn = 0;
013400160928
013500180508       end-proc;
013600160928      *-------------------------------------------------------------------------
013700180508       dcl-proc DisplyS1;
013800160928
013900200116         DspSfl = *on  ;
014000200116         exfmt  LstCtl ;
014100200116         DspSfl = *off;
014200160928
014300180508       end-proc;
014400160928      *-------------------------------------------------------------------------
014500180508       dcl-proc LoadS1;
014600161005
014700200116         //----------------------------------------------------
014800200116         //?Load the Subfile.
014900200116         //----------------------------------------------------
015000200116         Setll *loval GBS0035P;
015100200116         dou %Eof(GBS0035P);
015200200116           read(n) GBS0035P;
015300161005
015400200116           if %Eof(GBS0035P);
015500200116             leave;
015600200116           endif;
015700161222
015800200116           s1Group = apGroup;
015900200116           s1GrpName  = apGrpName;
016000200116           s1FileType = '';
016100200116           chain(n) s1Group LumQuestp;
016200200116           if %Found( LumQuestp );
016300200116             if Mode =  'T';
016400200116               s1FileType = 'Testing';
016500200116             EndIf;
016600180508
016700200116             if Mode = 'F';
016800200116               s1FileType = 'Production';
016900200116             EndIf;
017000180508
017100200116           EndIf;
017200171211
017300200116           s1RunDate = *Blanks;
017400200116           if apLastDate > 0;
017500200116             s1RunDate = %Char(%Date(apLastDate:*iso):*Usa);
017600200116           endif;
017700171211
017800200116           s1CalcTerm = apCalcTerm;
017900200116           s1AddCBR   = apAddCbr;
018000200116           s1Use_Pid  = apUse_Pid;
018100190222
018200200116           s1OvrEffDt = '';
018300200116           if apOvrEffDt > 0;
018400200116             s1OvrEffDt = %Char(%Date(apOvrEffDt : *iso):*Usa);
018500200116           endif;
018600190222
018700210511           if s1Search = '';
018800210511             rrn = rrn + 1;
018900210511             write LstSfl;
019000161223
019100210511           else;
019200210511             if %scan( %Trim(s1Search) : ucase(s1Group)) >  0 or
019300210511             %scan( %Trim(s1Search) : ucase(s1GrpName)) >  0 or
019400210511             %scan( %Trim(s1Search) : ucase(s1FileType)) >  0 ;
019500210511
019600210511               rrn = rrn + 1;
019700210511               write LstSfl;
019800210511
019900210511
020000210511             EndIf;
020100210511           EndIf;
020200210511
020300210511
020400210511
020500210511         enddo;
020600161005
020700161005
020800161005
020900161005
021000210511       end-proc;
021100161223
021200161223      *-------------------------------------------------------------------------
021300210511       dcl-proc $AddRecord;
021400161223
021500161223
021600210511         dou btnCancel = *on;
021700161223
021800210511           exfmt AddScreen;
021900210511           Validate();
022000210511           if hasError = *on;
022100200116             iter;
022200210511           EndIf;
022300161223
022400210511           if btnAccept = *on;
022500161223
022600200116             apGroup = s2Group;
022700180426
022800210511             Exec Sql
022900210511               Select Grname
023000210511                 Into :Apgrpname
023100210511                 From Luminxlive.Groupmstl1
023200210511                 Where Grgroup = :S2group
023300210511                 Fetch First 1 Rows Only;
023400180426
023500200116             if sqlcod <> 0;
023600210511               apGrpName = s2Group;
023700200116             EndIf;
023800180427
023900180427
024000210511             Exec Sql
024100210511               Insert Into Gbs0035e
024200220518                 Values (:S2group, 'T', 'payrolledi@amwins.com', :wqusrn, int(
024300210511                       replace(char(current_date, ISO), '-', '')), int(
024400210511                       replace(char(current_time), ':', '')), '', 0, 0);
024500190221
024600210511             Exec Sql
024700210511               Insert Into Gbs0035e
024800220518                 Values (:S2group, 'P', 'payrolledi@amwins.com', :wqusrn, int(
024900210511                       replace(char(current_date, ISO), '-', '')), int(
025000210511                       replace(char(current_time), ':', '')), '', 0, 0);
025100180426
025200180426
025300200116             Aplastdate = 0;
025400210511             apCalcTerm = s2CalcTerm;
025500210511             apAddCBR   = s2AddCbr;
025600210511             apUse_Pid  = s2Use_Pid;
025700210511             apOvrEffDt = 0;
025800190222
025900210511             if s2OvrEffDt > '';
026000210511               apOvrEffDt =
026100210511               %dec(%char(%date(s2OvrEffDt : *usa/) :*iso0):8:0);
026200210511             endif;
026300180426
026400210511             write r_gbs0035;
026500210511             leave;
026600161223
026700210511           EndIf;
026800161223
026900161223
027000200116         EndDo;
027100161223
027200161223
027300210511       end-proc;
027400161223
027500161223      *-------------------------------------------------------------------------
027600210511       dcl-proc LoadData;
027700161223
027800210511         Clear EditScreen;
027900161223
028000210511         chain s1Group gbs0035P;
028100171211
028200210511         s2Group = apGroup;
028300210511         s2GrpName= apGrpName;
028400210511         s2CalcTerm  = apCalcTerm;
028500210511         s2AddCbr    = apAddCbr;
028600200116         s2Use_Pid   = apUse_Pid;
028700190222
028800210511         s2OvrEffDt = '';
028900210511         if apOvrEffDt > 0;
029000210511           s2OvrEffDt  = %Char(%Date(apOvrEffDt:*iso):*Usa);
029100210511         endif;
029200171211
029300161223
029400210511       end-proc;
029500161223      *-------------------------------------------------------------------------
029600210511       dcl-proc $EditRecord;
029700161223
029800161223
029900210511         LoadData();
030000161223
030100210511         dou btnCancel = *on;
030200161223
030300210511           exfmt EditScreen;
030400161223
030500210511           if btnAccept = *on;
030600210511             chain s2Group gbs0035P;
030700210511             if %Found( gbs0035p ) ;
030800171211
030900210511               apGroup = s2Group;
031000210511               apLastDate = 0;
031100210511               apCalcTerm = s2CalcTerm;
031200210511               apAddCbr   = s2AddCbr;
031300200116               apUse_Pid  = s2Use_Pid;
031400200116
031500200116
031600210511               apOvrEffDt = 0;
031700171211
031800200116
031900210511               if s2OvrEffDt >'';
032000210511                 test(de) *iso s2OvrEffDt;
032100210511                 if not %Error;
032200210511                   apOvrEffDt =
032300210511                   %dec(%char(%date(s2OvrEffDt : *usa/) :*iso0):8:0);
032400210511                 endif;
032500210511               EndIf;
032600200116
032700200116
032800200116
032900210511               update r_gbs0035;
033000210511             endif;
033100210511             leave;
033200161223
033300210511           EndIf;
033400161223
033500161223
033600210511         EndDo;
033700161223
033800161223
033900210511       end-proc;
034000161007      *-------------------------------------------------------------------------
034100210511       dcl-proc Validate;
034200161007
034300210511         hasError = *off;
034400161223
034500210511       end-proc;
034600161223
034700161223      *-------------------------------------------------------------------------
034800210511       dcl-proc ReadChanged;
034900161223
035000210511         Dou *in95 = *ON;
035100210511           READC LstSfl;
035200210511           *in95 = %EOF;
035300161223
035400210511           If *in95 = *OFF;
035500161223
035600180807
035700210511             If btnEdit = *on;
035800210511               $EditRecord();
035900210511             endIf;
036000161223
036100161223
036200210511             If btnDelete= *on;
036300200116               $DelRecord();
036400210511             endIf;
036500161223
036600171212
036700210511             If btnEmail = *on;
036800210511               GBS0035R1( s1Group : s1GrpName );
036900210511             endIf;
037000171212
037100161223
037200210511             if runOption > '';
037300200116               if runOption = 'ViewQuest';
037400210511                 LoadQuest();
037500210511                 exfmt ViewQuest;
037600210511               EndIf;
037700180508
037800200116               if runOption = 'EditQuest';
037900210511                 LoadQuest();
038000200116                 $Edit_Quest();
038100200116               EndIf;
038200180508
038300180510
038400210511               if runOption = 'LmxPlan';
038500210511                 GBS0035R2( s1Group );
038600210511               EndIf;
038700180510
038800180806
038900210511               if runOption = 'LmxDiv';
039000210511                 GBS0035R3( s1Group );
039100210511               EndIf;
039200180807
039300180807
039400210511               if runOption = 'RmvLoadMsg';
039500210511                 GBS0035R4( s1Group );
039600210511               EndIf;
039700180807
039800180807
039900180807
040000180807
040100180806
040200210511             EndIf;
040300180508
040400180508
040500210511             runOption = '';
040600180508
040700210511             btnEmail  = *off;
040800210511             btnDelete = *off;
040900210511             btnEdit = *off;
041000210511             update LstSfl;
041100161223
041200210511             Reload = 'Y';
041300210511           endIf;
041400161223
041500161223
041600210511         enddo;
041700210511       end-proc;
041800161223
041900161223
042000161223      *-------------------------------------------------------------------------
042100210511       dcl-proc $DelRecord;
042200161223
042300161223
042400210511         LoadData();
042500161223
042600210511         dou btnCancel = *on;
042700210511           exfmt Confirm;
042800161223
042900161223
043000210511           if btnAccept = *on;
043100210511             Exec Sql
043200210511               Delete From Gbs0035e Where Aegroup = :S1group;
043300210511             Exec Sql
043400210511               Delete From Gbs0035p Where Apgroup = :S1group;
043500171213
043600210511             leave;
043700210511           EndIf;
043800161223
043900210511         enddo;
044000161223
044100161223
044200210511       end-proc;
044300161223
044400180508
044500180508      *-------------------------------------------------------------------------
044600210511       dcl-proc LoadQuest;
044700180508
044800180508
044900210511         Clear ViewQuest;
045000210511         Clear EditQuest;
045100180508
045200210511         chain(n)  s1Group LumQuestp;
045300180508
045400180508
045500210511         if not %Found( LumQuestp );
045600210511           // Copy "DEFAULT"
045700210511           wGroup = 'DEFAULT';
045800210511           chain(n) wGroup LumQuestp;
045900210511           if %Found( LumQuestp );
046000210511             Group = s1Group;
046100190221
046200220323             input =  %ScanRpl('load1': 'ld' + %Trim( %lower(s1Group)): input);
046300220323
046400210511             LQCRTBY = wqusrn;
046500210511             LQCRTDT = %Dec(%Date);
046600210511             LQCRTTM = %Dec(%Time);
046700190221
046800210511             LQCHGBY = '';
046900210511             LQCHGDT = 0;
047000210511             LQCHGTM = 0;
047100190221
047200210511             write r_LumQuest;
047300180508
047400210511             chain(n) s1Group LumQuestp;
047500200116           EndIf;
047600180508
047700210511         EndIf;
047800180508
047900180508
048000180508
048100210511         if %Found( LumQuestp );
048200180508
048300200116           s3FulName = %Trim( group ) + ' - ' + %Trim( S1GrpName );
048400200116           s3Group = group;
048500180612
048600200116           s3Mode = Mode;
048700200116           s3Format = Format;
048800200116           s3Input = Input;
048900200116           s3BillAdj = BillAdj;
049000180508
049100200116           s3TermDt = TermDt;
049200200116           s3TermFSA = TermFSA;
049300200116           s3KeepFSA = KeepFSA;
049400200116           s3PartCbr = PartCbr;
049500200116           s3Partncbr = Partncbr;
049600200116           s3Clrcrd_1 = %Subst( ClearCard : 1 : 1 );
049700200116           s3Clrcrd_2 = %Subst( ClearCard : 3 : 1 );
049800200116           s3Clrcrd_3 = %Subst( ClearCard : 5 : 1 );
049900200116           s3Clrcrd_4 = %Subst( ClearCard : 7 : 1 );
050000180508
050100200116           s3addrerr = addrerr;
050200210511           s3cbractnm = cbracctnm;
050300210511           s3lastper = lastper;
050400210511           s3othCovg = othercovg;
050500210511           s3incsrch = incsrch;
050600210511           s3rtnfile = rtnfile;
050700210511           s3fsaload = fsaload;
050800210511           s3fsaytd = fsaytd;
050900210511           s3fsacard = fsacard;
051000210511           s3listatv = listatv;
051100210511           s3Canccare = canccare;
051200180508
051300210511         EndIf;
051400180508
051500180508
051600180508
051700210511       End-Proc;
051800180508
051900180508
052000180508
052100180508      *-------------------------------------------------------------------------
052200210511       dcl-proc $Edit_Quest;
052300180508
052400180508
052500210511         dou btnBack = *on;
052600180508
052700210511           exfmt EditQuest;
052800180508
052900180508
053000210511           if btnBack = *on;
053100200116             leave;
053200210511           endif;
053300180508
053400210511           // Verify???
053500180508
053600210511           if btnInfo = *on;
053700200116             exfmt Info;
053800200116             btnInfo = *off;
053900200116             btnBack = *off;
054000200116             iter;
054100210511           endif;
054200180511
054300180511
054400210511           if btnAccept = *on;
054500180508
054600200116             chain s3Group LumQuestp;
054700180508
054800200116             Group = s3Group;
054900200116             Mode = s3Mode;
055000200116             Format = s3Format;
055100200116             Input = s3Input;
055200200116             BillAdj = s3BillAdj;
055300180508
055400200116             TermDt = s3TermDt;
055500200116             TermFSA = s3TermFSA;
055600200116             KeepFSA = s3KeepFSA;
055700200116             PartCbr = s3PartCbr;
055800200116             Partncbr = s3Partncbr;
055900180508
056000200116             s3Clrcrd_1 = %Subst( ClearCard : 1 : 1 );
056100200116             s3Clrcrd_2 = %Subst( ClearCard : 3 : 1 );
056200200116             s3Clrcrd_3 = %Subst( ClearCard : 5 : 1 );
056300200116             s3Clrcrd_4 = %Subst( ClearCard : 7 : 1 );
056400180508
056500200116             ClearCard = s3ClrCrd_1 + ' ' +
056600210511             s3ClrCrd_2 + ' ' +
056700210511               s3ClrCrd_3 + ' ' +
056800210511             s3ClrCrd_4;
056900180508
057000180508
057100200116             addrerr = s3addrerr;
057200200116             cbracctnm = s3cbractnm;
057300200116             lastper = s3lastper;
057400200116             othercovg = s3othCovg;
057500200116             incsrch = s3incsrch;
057600200116             rtnfile = s3rtnfile;
057700210511             fsaload = s3fsaload;
057800210511             fsaytd = s3fsaytd;
057900210511             fsacard = s3fsacard;
058000210511             listatv = s3listatv;
058100210511             Canccare = s3canccare;
058200180508
058300210511             lqChgBy = wqusrn;
058400210511             lqChgDt = %Dec(%Date);
058500210511             lqChgTm = %Dec(%Time);
058600190221
058700210511             update r_LumQuest;
058800210511             return;
058900180508
059000180508
059100210511           EndIf;
059200180508
059300180508
059400210511         enddo;
059500180508
059600180508
059700180508
059800180508       End-Proc;
059900180508
