000100161109     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200161109    ? *-------------------------------------------------------------------------
000300161109    ? *
000400161111    ? *  Description:
000500161109    ? *  Programmer.:  Brian Rees
000600161109    ? *  Date.......:  08/31/2016
000700161109    ? *
000800161109    ? *-------------------------------------------------------------------------
000900170323    ?FptSetupd  CF   E             WORKSTN
001000161109     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001100171106    ?F                                     SFILE(LSTSFL  : rrn)
001200170323    ?F                                     SFILE(TaskSfl : rrn2)
001300171106    ?F                                     SFILE(SeqSfl  : rrn3)
001400161109
001500170323     FptPrjMst  uf a E           k disk
001600170323      *?Project Master
001700170323
001800170323     FptTskMst  uf a E           k disk
001900170323      *?Task Master
002000170323
002100170324     FptTskMstL1uf   e           k disk    rename(r_ptTskMst: Rcd1)
002200170324      *?Task Master
002300170331
002400170331     FptTask    uf a E           k disk
002500170331      *?Task
002600170331
002700170331     FptTaskL1  uf   e           k disk    rename(r_ptTask: Rcd2)
002800170331      *?Task Master
002900170324
003000170401     FptEmail   uf a e           k disk
003100170401      *?Email List
003200170401
003300170421     FptCatgp   uf a e           k disk
003400170421      *?Category List
003500170421
003600170421     FptDeptp   uf a e           k disk
003700170421      *?Department List
003800170421
003900171106     FptProj    if   e           k disk
004000171106      *?Project List
004100171106
004200161109    ? *-------------------------------------------------------------------------
004300161109    ? * Program status data structure
004400161109    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004500161109     D  @pgmq            *proc
004600161109
004700161109    ? * Display file data structure
004800161109    ?D DSPD            DS
004900161109     D  Key                  369    369
005000161109     D  Currec               378    379b 0
005100161111
005200161109     d Rrn             s              5s 0 inz
005300170323     d Rrn2            s              5s 0 inz
005400171106     d Rrn3            s              5s 0 inz
005500171106     d @rrn            s              5s 0 inz
005600171106
005700161109     d ReLoad          s              1
005800170323     d ReLoadS2        s              1
005900161128
006000170323     d aNextId         s              5
006100170323     d nNextId         s              5S 0
006200161128
006300170324     D RRNp            S              5  0
006400170324     D sourceSEQ       S                   like(tmSeq)
006500170324     D targetSEQ       S                   like(tmSeq)
006600170324
006700170324     d TotalMin        s              7s 0 inz
006800170324     d TotalHr         s              5s 0 inz
006900170324     d TotalMn         s              2s 0 inz
007000170324
007100170331     D sqProjKey       S             10
007200171106     D wLineID         S              7S 0
007300161111      *--------------------------------------------
007400161111      *?Procedures
007500161111      *--------------------------------------------
007600180417       dcl-pr ptExtEmlr ExtPgm('PTEXTEMLR') end-pr;
007700161128
007800161117
007900161118
008000161109    ? *-------------------------------------------------------------------------
008100161109      *?Mainline Program
008200161109    ? *-------------------------------------------------------------------------
008300161111
008400180417       Exec Sql
008500180417          Set Option Commit = *None
008600180417                     ,Naming = *Sys;
008700161109
008800161109       Dou btnExit = *on;
008900161109          If Reload = 'Y';
009000161109             exsr CLEAR;
009100161109             exsr LOAD;
009200161109             Reload = 'N';
009300161109          endIf;
009400161109
009500161109          exsr DISPLY;
009600161109
009700161109
009800161109          //?Process Selections
009900161109          Select;
010000180417
010100180417          when mnuOption = 'wEmail';
010200180417             ptExtEmlr();
010300180417             reload = 'Y';
010400180417
010500161109
010600170324          When ChgChkDel = *on;
010700170324             Reload = 'Y';
010800170324
010900170324
011000170321          When btnAddNew = *on;
011100170323             Clear Add_Proj;
011200170323             Exsr Add_Project;
011300170321             Reload = 'Y';
011400161109
011500161109          other;
011600161109             exsr ReadChanged;
011700161109
011800161109          EndSl;
011900161128
012000161109       enddo;
012100161109
012200161109       *inlr = *on;
012300161109
012400170323       //-----------------------------------------------------------------
012500161109       Begsr *Inzsr;
012600161109
012700161110          Reload = 'Y';
012800170323          ReloadS2 = 'Y';
012900161109
013000161109       Endsr;
013100170323       //-----------------------------------------------------------------
013200161109       Begsr CLEAR;
013300161109
013400161110          //?Clear the Subfile
013500161110          ClrSfl = *on;
013600161110          Write Screen1;
013700161110          ClrSfl = *off;
013800161110          rrn = 0;
013900161109
014000161109       Endsr;
014100161109       // ----------------------------------------------------------------
014200161110       Begsr Load;
014300161109
014400170323          Setll *loval ptPrjMst;
014500170323          Dou %eof(ptPrjMst);
014600161109
014700170419             read(n) ptPrjMst;
014800170323             if %eof(ptPrjMst);
014900161109                leave;
015000161109             endif;
015100161109
015200161111
015300170324
015400170324             //?Get the Total time for each Task
015500180417             Exec Sql
015600180417                Select Sum(Tmesthr * 60) + Sum(Tmestmn)
015700180417                   Into :Totalmin
015800180417                   From Pttskmst
015900180417                   Where Tmmainkey = :Pmmainkey;
016000170324
016100170324             if SqlCod <> 0;
016200170324                TotalMin = 0;
016300170324                s1TotTime = *Blanks;
016400170324             endif;
016500170324
016600170324             TotalHr = %Div(TotalMin : 60);
016700170324             TotalMn = %Rem(TotalMin : 60);
016800170324
016900170324             s1TotTime = %Char(TotalHr) + ' Hr ' +
017000180417                %Char(TotalMn) + ' Min';
017100170324
017200170324
017300170323             s1Action = pmDescr;
017400170323             s1MainKey = pmMainKey;
017500170323             s1Status = 'Active';
017600170323             RowColor = *Blanks;
017700170323             if pmRcdSts = 'D';
017800170323                s1Status = 'Deleted';
017900170323                RowColor = '#ff0000';
018000170323             endif;
018100170323
018200170324             //?Check the Deleted Checkbox
018300170324             if ChkShowDel = 'Y';
018400170324                rrn = rrn + 1;
018500170324                write LstSfl;
018600170324             else;
018700170324                if pmRcdSts = 'A';
018800170324                   rrn = rrn + 1;
018900170324                   write LstSfl;
019000170324                endif;
019100170324             endif;
019200170324
019300170324
019400170324
019500170324
019600161109             If rrn >= 9999;
019700161109                leave;
019800161109             endIf;
019900161109
020000161110          enddo;
020100161109
020200161110       Endsr;
020300161109
020400161109       // ----------------------------------------------------------------
020500161109       Begsr DISPLY;
020600161109
020700161110          DspSfl = *on  ;
020800161110          exfmt Screen1;
020900161110          DspSfl = *off;
021000161109
021100161109       Endsr;
021200161109       // ----------------------------------------------------------------
021300161109       Begsr ReadChanged;
021400161109
021500161109          Dou *in95 = *ON;
021600161109             READC LstSfl;
021700161109             *in95 = %EOF;
021800161109
021900161109             If *in95 = *OFF;
022000161109
022100180417                //? Edit Note Records
022200180417                If btnEdit = *on;
022300180417                   exsr Load_Proj;
022400180417                   exsr Chg_Project;
022500180417                endIf;
022600161111
022700180417                If btnTask = *on;
022800180417                   exsr MainTask;
022900180417                   ReloadS2 = 'Y';
023000180417                endIf;
023100170323
023200170918
023300170918                //?Check Content Menu Options
023400170918                if runOption > *blanks;
023500170918
023600170918                   s2Action = s1Action;
023700170918                   s2MainKey = s1MainKey;
023800170918
023900170918                   if runOption = 'CpyProj';
024000180417                      exfmt CopyScreen;
024100170918
024200180417                      if btnCont = *on;
024300180417                         exsr Copy_Project;
024400180417                      endif;
024500170918
024600180417                      btnCont = *off;
024700180417                      btnExit = *off;
024800170918                   endif;
024900170918
025000170918
025100170918
025200170918                   if runOption = 'DelProj';
025300180417                      exfmt DelScreen;
025400170918
025500180417                      if btnCont = *on;
025600180417                         Exec Sql  Delete from ptPrjMst
025700180417                            Where pmMainKey = :s2MainKey;
025800180417                         Exec Sql  Delete from ptTskMst
025900180417                            Where tmMainKey = :s2MainKey;
026000180417                      endif;
026100170918
026200180417                      btnCont = *off;
026300180417                      btnExit = *off;
026400170918                   endif;
026500170918
026600170321
026700171106
026800171106                   //?ReSequence Project
026900171106                   if runOption = 'ReSeqProj';
027000180417                      exsr ReSeq_Project;
027100171106
027200171106                   endif;
027300171106                endif;
027400171106
027500171106
027600170918
027700170918                runOption = *blanks;
027800170321                btnEdit = *off;
027900170324                btnTask = *off;
028000161109                update LstSfl;
028100161109
028200161109                Reload = 'Y';
028300161109             endIf;
028400161109
028500161109
028600161109          enddo;
028700161109       Endsr;
028800161111
028900161128
029000170321       //-----------------------------------------------------------------
029100170323       //?                 Load the EDIT Project Screen
029200170321       //-----------------------------------------------------------------
029300170323       Begsr Load_Proj;
029400170321
029500170323          Chain(n) s1MainKey ptPrjMst;
029600170323          s2MainKey = s1MainKey;
029700170323          s2Descr = pmDescr;
029800170323          s2RcdSts = pmRcdSts;
029900170323
030000170324          s2CrtMsg = *Blanks;
030100170324          s2ChgMsg = *Blanks;
030200170324
030300170323          if pmCrtBy > *Blanks;
030400170323             s2CrtMsg = 'Project created by ' + %Trim( pmCrtBy ) + ' on ' +
030500180417                %Char(%date(pmCrtDt) :*usa) + ' at ' +
030600180417                %Char(%Time(pmCrtTm) :*usa);
030700170323          endif;
030800170323
030900170323          if pmChgBy > *Blanks;
031000170323             s2ChgMsg = 'Project changed by ' + %Trim( pmChgBy ) + ' on ' +
031100180417                %Char(%date(pmChgDt) :*usa) + ' at ' +
031200180417                %Char(%Time(pmChgTm) :*usa);
031300170323          endif;
031400170323
031500170321       Endsr;
031600170323
031700170323       //-----------------------------------------------------------------
031800170323       //?                     Change Project
031900170323       //-----------------------------------------------------------------
032000170323       Begsr Chg_Project;
032100170323
032200170323          Dou btnCancel = *on;
032300170323
032400170323             exfmt Chg_Proj;
032500170323
032600170323             if btnCancel = *on;
032700170323                leave;
032800170323             endif;
032900170323
033000170323
033100170323             //----------------------------------------------
033200170323             //?Update.
033300170323             //----------------------------------------------
033400170323             if btnAccept = *on;
033500170323
033600170323                Exec Sql
033700180417                   update ptPrjMst
033800180417                   Set pmDescr = :s2Descr, pmRcdSts = :s2RcdSts,
033900180417                   pmChgBy = :WQUSRN,
034000180417                   pmChgDt = int(replace(char(current_date , ISO),'-','')),
034100180417                   pmChgTm = int(replace(char(current_time),':',''))
034200170323
034300180417                   Where pmMainKey = :s2MainKey;
034400170323
034500180417                   leave;
034600180417                endif;
034700170323
034800170323          Enddo;
034900170323
035000170323       Endsr;
035100170323
035200170323
035300170323       //-----------------------------------------------------------------
035400170323       //?                       Add Project
035500170323       //-----------------------------------------------------------------
035600170323       Begsr Add_Project;
035700170323
035800170324
035900170323          Dou btnCancel = *on;
036000170323
036100170323             exfmt Add_Proj;
036200170323
036300170323             if btnCancel = *on;
036400170323                leave;
036500170323             endif;
036600170323
036700170323
036800170323             //----------------------------------------------
036900170323             //?Add Update.
037000170323             //----------------------------------------------
037100170323             if btnAccept = *on;
037200170323
037300170323                //?Get Next Unique ID Number..
037400170323                Exec Sql
037500180417                   Select max( substring( pmMainKey , 3 ))
037600180417                   into :nNextId
037700180417                   From ptPrjMst
037800180417                   Where substring( pmMainKey , 1, 2 ) = 'PM' ;
037900170323
038000170323                if SqlCod <> 0;
038100170323                   nNextId = 0;
038200170323                endif;
038300170323
038400170331                nNextId = nNextId + 1;
038500170323                aNextId = %Editc(nNextId : 'X');
038600170323
038700170323                Exec Sql
038800180417                   Insert into ptPrjMst
038900170323                   ( pmMainKey, pmDescr, pmRcdSts, pmCrtby, pmCrtDt,
039000180417                   pmCrtTm, pmChgBy, pmChgDt, pmChgTm )
039100180417                   Values ( 'PM' || :aNextId, :s2Descr, 'A', :wqUsrn,
039200180417                   int(replace(char(current_date , ISO),'-','')),
039300180417                   int(replace(char(current_time),':','')),'', 0,0 ) ;
039400170323
039500180417                leaveSr;
039600180417             endif;
039700170323
039800170323          Enddo;
039900170323
040000170323       Endsr;
040100170323
040200170323       //?----------------------------------------------------------------
040300170323       //?                      Task Maintenance
040400170323       //?----------------------------------------------------------------
040500170323       Begsr MainTask;
040600170323
040700170323          Dou btnExit = *on;
040800170323
040900170323             If ReloadS2 = 'Y';
041000170323                exsr CLEARS2;
041100170323                exsr LOADS2;
041200170323                ReloadS2 = 'N';
041300170323             endif;
041400170323
041500170323             exsr DISPLYS2;
041600170323
041700170323
041800170323             //?Process Selections
041900170323             Select;
042000170323
042100170323             When btnAddNew = *on;
042200170323                Clear Add_Task;
042300170324                Exsr AddTask;
042400170323                ReloadS2 = 'Y';
042500170323
042600170324             other;
042700170324                exsr ReadChangedS2;
042800170420                ResequenceFile();
042900170420
043000170323             EndSl;
043100170323
043200180417             Exsr HandleDragDropAction;
043300180417             targetElem = '';
043400170324
043500170323          enddo;
043600170323
043700170323          btnExit = *off;
043800170323
043900170323       Endsr;
044000170323       //-----------------------------------------------------------------
044100170323       Begsr ClearS2;
044200170323
044300170323          //?Clear the Subfile
044400170323          ClrSfl2 = *on;
044500170323          Write Screen2;
044600170323          ClrSfl2 = *off;
044700170323          rrn2 = 0;
044800170323
044900170323       Endsr;
045000170323       // ----------------------------------------------------------------
045100170323       Begsr LoadS2;
045200170323
045300170324          s3Project = s1Action;
045400170324          s3MainKey = s1MainKey;
045500170324
045600170324          //?Check to see if this project is deleted.
045700170425          chain(n) s1MainKey ptPrjMst;
045800170324          ProjColor = *Blanks;
045900170324          if pmRcdSts = 'D';
046000170324             ProjColor = '#ff0000';
046100170324          endif;
046200170324
046300170324
046400170324
046500170324          Setll s1MainKey ptTskMst;
046600170323          Dou %eof(ptTskMst);
046700170323
046800170419             reade(n) s1MainKey ptTskMst;
046900170323             if %eof(ptTskMst);
047000170323                leave;
047100170323             endif;
047200170323
047300170323             s3Seq = tmSeq;
047400170323             s3Dept = tmDept;
047500170323             s3Category = tmCatg;
047600170323             s3Action = tmAction;
047700170323             s3Contact = tmContact;
047800170920             s3Contact2 = tmContact2;
047900170323             s3EstTime = %Char(tmEstHr) + 'Hr ' +
048000180417                %Char(tmEstMn) + 'Min';
048100170323
048200170919             s3ToolTip = tmToolTip;
048300170919             showInfo = *off;
048400170919             if tmToolTip > *Blanks;
048500170919                showInfo = *on;
048600170919             endif;
048700170919
048800170323             RowColor = *Blanks;
048900170323             if tmRcdSts = 'D';
049000170323                RowColor = '#ff0000';
049100170323             endif;
049200170323
049300170323
049400170323             rrn2 = rrn2 + 1;
049500170323             write TaskSfl;
049600170323
049700170323             If rrn2 >= 9999;
049800170323                leave;
049900170323             endIf;
050000170323
050100170323          enddo;
050200170323
050300170323       Endsr;
050400170323
050500170323       // ----------------------------------------------------------------
050600170323       Begsr DisplyS2;
050700170323
050800170323          DspSfl2 = *on  ;
050900170323          exfmt Screen2;
051000170323          DspSfl2 = *off;
051100170323
051200170323       Endsr;
051300170324
051400170324       //-----------------------------------------------------------------
051500170324       //?                       Add Task
051600170324       //-----------------------------------------------------------------
051700170324       Begsr AddTask;
051800170324
051900170324          s4MainKey = s1MainKey;
052000170324          s4ProjDsc = s3Project;
052100170324
052200170324          Dou btnCancel = *on;
052300170324
052400170324             exfmt Add_Task;
052500170324
052600170324             if btnCancel = *on;
052700170324                leave;
052800170324             endif;
052900170324
053000170324
053100170324             //----------------------------------------------
053200170324             //?Add Update.
053300170324             //----------------------------------------------
053400170324             if btnAccept = *on;
053500170324
053600170420                if s4Seq = 0;
053700180417                   Exec Sql
053800180417                      Select max( tmSeq )  into :nNextId
053900180417                      From ptTskMst
054000180417                      Where tmMainKey = :s4MainKey;
054100170324
054200180417                   if SqlCod <> 0;
054300180417                      nNextId = 0;
054400180417                   endif;
054500170324
054600180417                   nNextId = nNextId + 10;
054700170420                endif;
054800170420
054900170330                //?Sequence number will be 1 less than
055000170330                //?the entered value
055100170330                if s4Seq > 1;
055200170331                   nNextId = s4Seq - 1;
055300170330                endif;
055400170330
055500171106
055600171106                //?Get the Next Line ID
055700171106                wLineId = NextLine#( s4MainKey );
055800171106
055900171106
056000170324                Exec Sql
056100180417                   Insert into ptTskMst
056200170324                   ( tmMainKey, tmSeq, tmDept, tmCatg, tmAction, tmContact,
056300180417                   tmCtEmail, tmContact2, tmCtEmail2,
056400180525                   tmManager, tmMgrMail, tmProgram, tmToolTip, tmEmlSts,
056500180417                   tmEstHr, tmEstMn, tmEspDays, tmRcdSts, tmCrtby,
056600180417                   tmCrtDt, tmCrtTm, tmChgDt, tmChgTm, tmLineId )
056700170324
056800180417                   Values ( :S4MainKey, :nNextId, :s4Dept, :s4Catg, :s4Action,
056900180417                   :s4Contact, :s4CntEmail, :s4Contact2, :s4CntEml2,
057000180417                   :s4Manager, :s4MgrEmail,
057100180525                   :s4Program, :s4ToolTip, '',  :s4EstHr, :s4EstMn,
057200180417                   :s4EspDays, 'A', :WQUSRN,
057300180417                   int(replace(char(current_date , ISO),'-','')),
057400180417                   int(replace(char(current_time),':','')), 0,0 , :wLineId) ;
057500170324
057600180417                   ResequenceFile();
057700170330
057800170421                exsr CheckEmail;
057900170421                exsr CheckCodes;
058000170401
058100170401
058200170331                //?Update All Open Tasks with the current task.
058300170331                Exec Sql
058400180417                   Declare C1 Cursor For
058500180417                   Select pjProjKey from ptProj
058600180417                   Where pjMainKey = :s4MainKey and
058700180417                   pjRcdSts = 'A';
058800170331
058900170331                Exec Sql    Open C1;
059000170331
059100170331                Dou SqlCod <> *Zero;
059200170331                   Exec Sql  Fetch Next From C1 Into :sqProjKey;
059300170331
059400170331                   if SqlCod <> *Zero;
059500170331                      leave;
059600170331                   endif;
059700170331
059800170331
059900180417                   Exec Sql
060000180417                      Insert into ptTask
060100180417                      ( ptProjKey, ptSeq, ptDept, ptCatg, ptAction, ptContact,
060200180417                      ptCtEmail, ptContact2, ptCtEmail2,
060300180525                      ptManager, ptMgrMail, ptProgram, ptToolTip, ptEmlSts,
060400180417                      ptEstHr, ptEstMn, ptEspDays, ptCrtby,
060500180417                      ptCrtDt, ptCrtTm, ptCloDt, ptCloTm, ptChgDt, ptChgTm,
060600180417                      ptLineId )
060700171106
060800170331                  Values ( :sqProjKey, :nNextId, :s4Dept, :s4Catg, :s4Action,
060900180417                      :s4Contact, :s4CntEmail, :s4Contact2, :s4CntEml2,
061000180417                      :s4Manager, :s4MgrEmail,
061100180525                      :s4Program, :s4ToolTip, ''  ,
061200180525                      :s4EstHr, :s4EstMn, :s4EspDays,
061300180417                      :WQUSRN,
061400180417                      int(replace(char(current_date , ISO),'-','')),
061500180417                      int(replace(char(current_time),':','')), 0,0,0,0,
061600180417                      :wLineId ) ;
061700170331
061800170331
061900180417                      enddo;
062000170331
062100170331                Exec Sql    Close C1;
062200170331                ResequenceTASK();
062300170331
062400170331
062500170331                leaveSr;
062600180417             endif;
062700170324
062800170324          Enddo;
062900170324
063000170324       Endsr;
063100170324
063200170324       // ----------------------------------------------------------------
063300170324       Begsr ReadChangedS2;
063400170324
063500170324          Dou *in95 = *ON;
063600170324             READC TaskSfl;
063700170324             *in95 = %EOF;
063800170324
063900170324             If *in95 = *OFF;
064000170324
064100180417                //? Edit Note Records
064200180417                If btnEdit = *on;
064300180417                   exsr Load_Task;
064400180417                   exsr ChgTask;
064500180417                endIf;
064600170324
064700180417                //? Delete Task...
064800180417                If btnDelete = *on;
064900180417                   Exec Sql
065000180417                      Delete from ptTskMst
065100180417                      where tmMainKey = :s3MainKey and
065200180417                      tmSeq = :s3Seq;
065300180417                endIf;
065400170324
065500170324
065600180103                btnDelete = *off;
065700180103                btnEdit = *off;
065800170324                update TaskSfl;
065900170324
066000170324                ReloadS2 = 'Y';
066100170324             endIf;
066200170324
066300170324
066400170324          enddo;
066500170324       Endsr;
066600170324
066700170324
066800170324       //-----------------------------------------------------------------
066900170324       //?                 Load the Task Screen
067000170324       //-----------------------------------------------------------------
067100170324       Begsr Load_Task;
067200170324
067300170324          Chain(n) (s3MainKey: s3Seq) ptTskMst;
067400170324          s4MainKey = s3MainKey;
067500170324
067600170324          s4MainKey = s1MainKey;
067700170324          s4Seq = s3Seq;
067800170324          s4ProjDsc = s3Project;
067900170324
068000170324          s4Action = tmAction;
068100170324          s4Dept =  tmDept;
068200170324          s4Catg = tmCatg;
068300170324          s4Contact = tmContact;
068400170324          s4CntEmail = tmCtEmail;
068500170918          s4Contact2 = tmContact2;
068600170918          s4CntEml2 = tmCtEmail2;
068700170324          s4Manager = tmManager;
068800170324          s4MgrEmail = tmMgrMail;
068900170324          s4Program = tmProgram;
069000170918          s4ToolTip = tmToolTip;
069100170324          s4EstHr = tmEstHr;
069200170324          s4EstMn = tmEstMn;
069300170324          s4EspDays = tmEspDays;
069400170324          s4RcdSts = tmRcdSts;
069500170324
069600170324          s4CrtMsg = *blanks;
069700170324          s4ChgMsg = *blanks;
069800170324
069900170324          if tmCrtBy > *Blanks;
070000170324             s4CrtMsg = 'Task created by ' + %Trim( tmCrtBy ) + ' on ' +
070100180417                %Char(%date(tmCrtDt) :*usa) + ' at ' +
070200180417                %Char(%Time(tmCrtTm) :*usa);
070300170324          endif;
070400170324
070500170324          if tmChgBy > *Blanks;
070600170324             s4ChgMsg = 'Task changed by ' + %Trim( tmChgBy ) + ' on ' +
070700180417                %Char(%date(tmChgDt) :*usa) + ' at ' +
070800180417                %Char(%Time(tmChgTm) :*usa);
070900170324          endif;
071000170324
071100170324       Endsr;
071200170324
071300170324
071400170324       //-----------------------------------------------------------------
071500170324       //?                     Change Task
071600170324       //-----------------------------------------------------------------
071700170324       Begsr ChgTask;
071800170324
071900170324          Dou btnCancel = *on;
072000170324
072100170324             exfmt Chg_Task;
072200170324
072300170324             if btnCancel = *on;
072400170324                leave;
072500170324             endif;
072600170324
072700170324
072800170324             //----------------------------------------------
072900170324             //?Update.
073000170324             //----------------------------------------------
073100170324             if btnAccept = *on;
073200170324
073300170324                Exec Sql
073400180417                   update ptTskMst
073500180417                   Set tmDept = :s4Dept, tmCatg = :s4Catg,
073600180417                   tmAction = :s4Action , tmContact = :s4Contact,
073700180417                   tmCtEmail = :s4CntEmail,
073800180417                   tmContact2 = :s4Contact2,  tmCtEmail2 = :s4CntEml2,
073900180417                   tmManager = :s4Manager,
074000180417                   tmMgrMail = :s4MgrEmail, tmProgram = :s4Program,
074100180417                   tmEstHr = :s4EstHr, tmEstMn = :s4EstMn,
074200180417                   tmEspDays = :s4EspDays, tmRcdSts = :s4RcdSts,
074300180417                   tmToolTip = :s4ToolTip,
074400180417                   tmChgBy = :WQUSRN,
074500180417                   tmChgDt = int(replace(char(current_date , ISO),'-','')),
074600180417                   tmChgTm = int(replace(char(current_time),':',''))
074700170324
074800180417                   Where tmMainKey = :s4MainKey and tmSeq = :s4Seq;
074900170324
075000180417                   exsr CheckEmail;
075100180417                exsr CheckCodes;
075200170401
075300171106
075400180417                //?Update All Tasks with the changes.
075500180417                Exec Sql
075600180417                   update ptTask
075700180417                   Set ptDept = :s4Dept, ptCatg = :s4Catg,
075800180417                   ptAction = :s4Action , ptContact = :s4Contact,
075900180417                   ptProgram = :s4Program,
076000180417                   ptToolTip = :s4ToolTip,
076100180525                   ptEmlSts = '',
076200180417                   ptChgBy = :WQUSRN,
076300180417                   ptChgDt = int(replace(char(current_date , ISO),'-','')),
076400180417                   ptChgTm = int(replace(char(current_time),':',''))
076500180525
076600180525
076700180417                   Where
076800171106                   ptProjKey in ( Select pjProjKey from ptProj where
076900180417                   pjMainKey = :s4MainKey) and ptLineId = :tmLineId;
077000171106
077100171106
077200171106
077300180417                   leave;
077400180417                endif;
077500170324
077600170324          Enddo;
077700170324
077800170324       Endsr;
077900170421
078000170421
078100170421       //-----------------------------------------------------------------
078200170421       //?                 Check Email...
078300170421       //-----------------------------------------------------------------
078400170421       Begsr CheckEmail;
078500170421
078600170421          // Check Contact Info...
078700170421          if s4Contact > *Blanks and s4CntEmail > *Blanks;
078800170421             chain s4Contact ptEmail;
078900170421             if not %Found(ptEmail);
079000180417                puName = s4Contact;
079100180417                puEmail = s4CntEmail;
079200180417                Write r_ptEmail;
079300170421             else;
079400180417                puEmail = s4CntEmail;
079500180417                update r_ptEmail;
079600170421             endif;
079700170421          endif;
079800170421
079900170918          // Check Contact2 Info...
080000170918          if s4Contact2 > *Blanks and s4CntEml2 > *Blanks;
080100170918             chain s4Contact2 ptEmail;
080200170918             if not %Found(ptEmail);
080300180417                puName = s4Contact2;
080400180417                puEmail = s4CntEml2;
080500180417                Write r_ptEmail;
080600170918             else;
080700180417                puEmail = s4CntEml2;
080800180417                update r_ptEmail;
080900170918             endif;
081000170918          endif;
081100170918
081200170421          // Check Manager Info...
081300170421          if s4Manager > *Blanks and s4MgrEmail > *Blanks;
081400170421             chain s4Manager ptEmail;
081500170421             if not %Found(ptEmail);
081600180417                puName = s4Manager;
081700180417                puEmail = s4MgrEmail;
081800180417                Write r_ptEmail;
081900170421             else;
082000180417                puEmail = s4MgrEmail;
082100180417                update r_ptEmail;
082200170421             endif;
082300170421          endif;
082400170421
082500170421
082600170421       Endsr;
082700170421
082800170421
082900170421       //-----------------------------------------------------------------
083000170421       //?                 Check Codes...
083100170421       //-----------------------------------------------------------------
083200170421       Begsr CheckCodes;
083300170421
083400170421          //?Check Category Info...
083500170425
083600170425          if s4Catg > *Blanks and %Len(%Trim(s4Catg)) > 3;
083700170421             chain s4Catg ptCatgp;
083800170421             if not %Found(ptCatgp);
083900180417                pcCatg = s4Catg;
084000180417                Write r_ptCatg;
084100170421             endif;
084200170421          endif;
084300170421
084400170421          //?Check Department Info...
084500170421          if s4Dept > *Blanks;
084600170602             chain s4Dept ptDeptp;
084700170421             if not %Found(ptDeptp);
084800180417                pdDept = s4Dept;
084900180417                Write r_ptDept;
085000170421             endif;
085100170421          endif;
085200170421
085300170421
085400170421
085500170421       Endsr;
085600170918
085700170918       //-----------------------------------------------------------------
085800170918       //?                 Copy Project..
085900170918       //-----------------------------------------------------------------
086000170918       Begsr Copy_Project;
086100170918
086200170918
086300170918          // Get  ?Next Unique ID Number..
086400170918          Exec Sql
086500180417             Select max( substring( pmMainKey , 3 ))
086600180417             into :nNextId
086700180417             From ptPrjMst
086800180417             Where substring( pmMainKey , 1, 2 ) = 'PM' ;
086900170918
087000170918          if SqlCod <> 0;
087100170918             nNextId = 0;
087200170918          endif;
087300170918
087400170918          nNextId = nNextId + 1;
087500170918          aNextId = %Editc(nNextId : 'X');
087600170918
087700170918          Exec Sql
087800180417             Insert into ptPrjMst
087900180417             ( pmMainKey, pmDescr, pmRcdSts, pmCrtby, pmCrtDt,
088000180417             pmCrtTm, pmChgBy, pmChgDt, pmChgTm )
088100180417             Values ( 'PM' || :aNextId, :s2NewActn, 'A', :wqUsrn,
088200180417             int(replace(char(current_date , ISO),'-','')),
088300180417             int(replace(char(current_time),':','')),'', 0,0 ) ;
088400170421
088500170918
088600170918          Exec Sql
088700180516             Insert into pttskmst (
088800180417             select 'PM' || :aNextId, tmSeq, 0, tmDept, tmCatg, tmAction,
088900180417             tmContact, tmctemail, tmContact2, tmctemail2,
089000180516             tmmanager, tmmgrmail, '',
089100180525             tmProgram, tmDepSeq, tmToolTip, '',
089200180417             tmesthr, tmestmn, tmespDays, 'A',
089300180417             :wqUsrn,
089400180417             int(replace(char(current_date , ISO),'-','')),
089500180417             int(replace(char(current_time),':','')),'', 0,0, tmLineId
089600170918
089700170918
089800180417             From ptTskMst
089900180516             Where tmMainKey = :s2MainKey) ;
090000170918
090100170918
090200170918
090300180417             Endsr;
090400170324
090500171106
090600180417             //?----------------------------------------------------------------
090700171106       //?                      ReSequence Project
090800171106       //?----------------------------------------------------------------
090900171106       Begsr ReSeq_Project;
091000171106
091100171106          Dou btnClose = *on;
091200171106
091300180417             exsr CLEARS3;
091400180417             exsr LOADS3;
091500171106
091600180417             exsr DISPLYS3;
091700171106
091800171106
091900171106             //?Process Selections
092000171106             if chkChanged = *off;
092100171106                exsr ReadChangedS3;
092200171106                leave;
092300171106             endif;
092400171106
092500171106
092600171106          enddo;
092700171106
092800171106          btnClose = *off;
092900171106
093000171106       Endsr;
093100171106       //-----------------------------------------------------------------
093200171106       Begsr ClearS3;
093300171106
093400171106          //?Clear the Subfile
093500171106          ClrSfl3 = *on;
093600171106          Write ReSeq;
093700171106          ClrSfl3 = *off;
093800171106          rrn3 = 0;
093900171106
094000171106       Endsr;
094100171106       // ----------------------------------------------------------------
094200171106       Begsr LoadS3;
094300171106
094400171106
094500171106          Setll s1MainKey ptProj;
094600171106          Dou %eof(ptTskMst);
094700171106
094800171106             reade s1MainKey ptProj;
094900171106             if %eof(ptProj);
095000171106                leave;
095100171106             endif;
095200171106
095300171106             s4Descr = pjDescr;
095400171106             s4ProjKey = pjProjKey;
095500171106
095600171106             //?Check All Button
095700171106             s4Check = s4ChkAll;
095800171106
095900171106
096000171106             rrn3 = rrn3 + 1;
096100171106             write SeqSfl;
096200171106
096300171106             If rrn3 >= 9999;
096400171106                leave;
096500171106             endIf;
096600171106
096700171106          enddo;
096800171106
096900171106       Endsr;
097000171106
097100171106       // ----------------------------------------------------------------
097200171106       Begsr DisplyS3;
097300171106
097400171106          DspSfl3 = *on  ;
097500171106          exfmt ReSeq;
097600171106          DspSfl3 = *off;
097700171106
097800171106       Endsr;
097900171106
098000171106       // ----------------------------------------------------------------
098100171106       Begsr ReadChangedS3;
098200171106
098300171106          //?Process Subfile.
098400171106          @rrn = 1;
098500171106          for @rrn = 1 to rrn3;
098600171106
098700171106             chain @rrn SeqSfl;
098800171106             if %Error() ;
098900171106                leave;
099000171106             endif;
099100171106
099200171107
099300171106             if s4Check = 'Y';
099400171107
099500171107                //?Update the Sequence numbers in PTTASK
099600171107                exec Sql
099700171107                   Update ptTask set ptSeq =
099800180417                   ( Select tmSeq from ptTskMst
099900180417                   Where ptProjKey = :s4ProjKey and tmLineId = ptLineId
100000180417                   )  Where ptProjKey = :s4ProjKey ;
100100171107
100200171106             endif;
100300171106
100400171106
100500171106          endfor;
100600171106
100700171106
100800171106       Endsr;
100900171106
101000170324       //?==========================================================================================
101100170324       //? The HandleDragDropAction Subroutine
101200170324       //?==========================================================================================
101300170324       BegSr HandleDragDropAction;
101400170324
101500180417          Select;
101600170324
101700180417          // If something is dragged onto an invalid element
101800180417          When targetElem = 'undefined' or targetElem = '';
101900180417             LeaveSr;
102000170324
102100170324
102200180417          //A Pending Task Record was Dragged somewhere
102300180417          When sourceElem = 'Grid1';
102400180417             ExSr GetSourceRow;
102500170324
102600170324
102700180417             //--------------------------------------
102800180417             // Pending Record Dragged to Recycle Bin
102900180417             //--------------------------------------
103000180417             If targetElem = 'Bin';
103100170324
103200180417                Chain ( s3MainKey : s3Seq ) ptTskMst;
103300180417                If %Found;
103400180417                   Delete r_ptTskMst;
103500180417                   ResequenceFile();
103600180417                   Reload = 'Y';
103700180417                EndIf;
103800180417             EndIf;
103900170324
104000170324
104100170324
104200170324
104300180417             //------------------------------------------
104400180417             // Pending Record Dragged to Pending Subfile
104500180417             //------------------------------------------
104600180417             If targetElem = 'Grid1';
104700180417                ExSr GetTargetRow;
104800170324
104900180417                Chain (s3MainKey : sourceSEQ) ptTskMst;
105000180417                If %Found;
105100170324
105200180417                   tmSeq = targetSEQ;
105300180417                   Update r_ptTskMst;
105400180417                   ResequenceFile();
105500180417                   ReloadS2 = 'Y';
105600180417                EndIf;
105700180417             EndIf;
105800170324
105900170324
106000180417          EndSL;
106100170324
106200170324       EndSr;
106300170324
106400170324
106500170324
106600170324       //?==========================================================================================
106700170324       //? The GetSourceRow Subroutine  - determines the sequence number (sourceSEQ) of
106800170324       //?                                the subfile record that was dragged somewhere
106900170324       //?==========================================================================================
107000170324       BegSr GetSourceRow;
107100180417          If sourceRec = 0;
107200180417             LeaveSr;
107300180417          EndIf;
107400170324
107500180417          Select;
107600180417          When sourceElem = 'Grid1';
107700180417             RRNp = sourceRec;
107800180417             Chain RRNp TaskSfl;
107900180417             If %Found;
108000180417                sourceSEQ = s3SEQ;
108100180417             EndIf;
108200170324
108300170324
108400180417          Other;
108500180417             LeaveSr;
108600180417          EndSL;
108700170324
108800170324
108900170324       EndSr;
109000170324
109100170324
109200170324
109300170324
109400170324       //?==========================================================================================
109500170324       //? The GetTargetRow Subroutine   - determines the sequence number (targetSEQ) of
109600170324       //?                                 the subfile record where something was dragged to
109700170324       //?==========================================================================================
109800170324       BegSr GetTargetRow;
109900180417          Select;
110000180417          When targetElem = 'Grid1';
110100170324
110200170324
110300180417             If targetRec = 0;
110400180417                targetSEQ = 5;
110500180417             Else;
110600180417                RRNp = targetRec;
110700180417                Chain RRNp TaskSfl;
110800180417                If %Found;
110900180417                   targetSEQ = s3Seq + 5;
111000180417                EndIf;
111100180417             EndIf;
111200170324
111300170324
111400170324
111500170324
111600180417          EndSL;
111700170324
111800170324       EndSr;
111900170324
112000170324
112100170324
112200170324
112300170324
112400170324      *?==========================================================================================
112500170331      *  ResequenceFile subprocedure.  Resequences TASK Master file
112600170324      *
112700170324      *     Status: P = Resequence Pending Records
112800170324      *             C = Resequence Completed Records
112900170324      *             B = Resequence Both Pending and Completed Records
113000170324      *
113100170324      *?==========================================================================================
113200170324     P ResequenceFile  B
113300170324     D ResequenceFile  PI
113400170324
113500170324     D newseq          S                   like(tmSeq)
113600170324     D Trst            s              3s 0
113700170324     D Sub#            s              3s 0
113800170324     D Acct            s              4s 0
113900170324
114000170324      /Free
114100170324
114200180417       newseq = 0;
114300180417       SetLL s3MainKey ptTskMst;
114400180417       ReadE s3MainKey ptTskMst;
114500180417       Dow not %EOF;
114600180417          newseq +=10;
114700180417          tmTmpSeq = newseq;
114800180417          update r_ptTskMst;
114900170324
115000180417          ReadE s3MainKey ptTskMst;
115100180417       EndDo;
115200170324
115300170324
115400180417       newseq = 0;
115500180417       SetLL s3MainKey ptTskMstL1;
115600180417       ReadE s3MainKey ptTskMstL1;
115700180417       Dow not %EOF;
115800180417          newseq +=10;
115900180417          tmSeq = newseq;
116000180417          update Rcd1;
116100170324
116200180417          ReadE s3MainKey ptTskMstL1;
116300180417       EndDo;
116400170324
116500170324
116600170324       Return;
116700170324
116800170324      /End-Free
116900170324     P ResequenceFile  E
117000170324
117100170324
117200170324
117300170331
117400170331
117500170331      *?==========================================================================================
117600170331      *
117700170331      *  ResequenceTASK subprocedure.  Resequences TASK file
117800170331      *
117900170331      *?==========================================================================================
118000171106     P ResequenceTASK  B
118100170331     D ResequenceTASK  PI
118200170331
118300170331     D newseq          S                   like(ptSeq)
118400170331     D savKey          S                   like(ptProjKey)
118500170331
118600170331      /Free
118700170331
118800180417       //?Read the Main file..
118900180417       SetLL *loval ptTask;
119000180417       Read  ptTask;
119100180417       Dow not %EOF;
119200170331
119300180417          if savKey <> ptProjKey;
119400170331             newSeq = 0;
119500170331             savKey = ptProjKey;
119600180417          endif;
119700170331
119800180417          newseq +=10;
119900180417          ptTmpSeq = newseq;
120000180417          update r_ptTask;
120100170331
120200180417          Read ptTask;
120300180417       EndDo;
120400170331
120500170331
120600180417       //?Read the Logical / Temp File
120700180417       savKey = *Blanks;
120800180417       SetLL *loval ptTaskL1;
120900180417       Read ptTaskL1;
121000180417       Dow not %EOF;
121100170331
121200180417          if savKey <> ptProjKey;
121300170331             newSeq = 0;
121400170331             savKey = ptProjKey;
121500180417          endif;
121600170331
121700180417          newseq +=10;
121800180417          ptSeq = newseq;
121900180417          update Rcd2;
122000170331
122100180417          Read ptTaskL1;
122200180417       EndDo;
122300170331
122400170331
122500170331       Return;
122600170331
122700170331      /End-Free
122800170331     P ResequenceTASK  E
122900170331
123000170331
123100171106
123200171106
123300171106
123400171106      *?---------------------------------------------------------------
123500171106      *?Get the Next Line Number
123600171106      *?---------------------------------------------------------------
123700171106     P NextLine#       B                   export
123800171106     D NextLine#       PI             7s 0
123900171106     d  inKey                        10    value
124000171106
124100171106     D NewLineId       s              7s 0
124200171106     D ReturnText      s              7s 0
124300171106
124400180417       Exec Sql
124500171106          Select max( tmLineId )  into :NewLineId
124600171106          From ptTskMst
124700171106          Where tmMainKey = :inKey;
124800171106
124900180417       if SqlCod <> 0;
125000180417          NewLineId = 0;
125100180417       endif;
125200171106
125300180417       NewLineId = NewLineId + 5;
125400171106
125500180417       Return NewLineId;
125600171106
125700171106
125800171106     P NextLine#       E
125900171106
126000170331
