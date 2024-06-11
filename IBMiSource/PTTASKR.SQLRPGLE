000100161109     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200161109    ? *-------------------------------------------------------------------------
000300161109    ? *
000400161111    ? *  Description:
000500161109    ? *  Programmer.:  Brian Rees
000600161109    ? *  Date.......:  08/31/2016
000700161109    ? *
000800161109    ? *-------------------------------------------------------------------------
000900170329    ?FptTaskD   CF   E             WORKSTN
001000161109     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001100161109    ?F                                     SFILE(LSTSFL:rrn)
001200161111    ?F                                     SFILE(NOTESFL:rrn2)
001300161109
001400170329     FptTask    uf a E           k disk
001500170329     FptNotes   uf a E           k disk
001600170413     FptTaskL1  uf   e           k disk    rename(r_ptTask: Rcd2)
001700170413
001800170419     FptEmail   uf a e           k disk
001900170419      *?Email List
002000170419
002100170419     FptTskMst  uf a E           k disk
002200170419      *?Task Master
002300170419
002400170419
002500180417       dcl-f ptbroker keyed;
002600180417       dcl-f ptExtEmll1 keyed;
002700180417
002800161109
002900161109    ? *-------------------------------------------------------------------------
003000161109    ? * Program status data structure
003100161109    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
003200161109     D  @pgmq            *proc
003300161109
003400161109    ? * Display file data structure
003500161109    ?D DSPD            DS
003600161109     D  Key                  369    369
003700161109     D  Currec               378    379b 0
003800161111
003900161109     d Rrn             s              5s 0 inz
004000161111     d Rrn2            s              5s 0 inz
004100161109     d ReLoad          s              1
004200161111     d ReLoadS2        s              1
004300161111     d @Note_Seq       s              9s 0 inz
004400161110
004500170320     d TotalMin        s              7s 0 inz
004600170320     d TotalHr         s              5s 0 inz
004700170320     d TotalMn         s              2s 0 inz
004800170320
004900170412     d** isAdmin         s               n
005000170320      * -- Defined in Screen...
005100170320
005200170329     d pProjKey        s             10
005300170330     d nOpenTsk        s              5s 0 inz
005400170330     d nClosedTsk      s              5s 0 inz
005500170330     d ProjStatus      s              1    inz
005600170329
005700170410     d aNextId         s              5
005800170410     d nNextId         s              5S 0
005900170329
006000171109     d wTrst           s              3s 0
006100171109     d wSub#           s              3s 0
006200171109     d wAcct           s              4s 0
006300171109
006400161111      *--------------------------------------------
006500170320      *?Procedures
006600161111      *--------------------------------------------
006700161117      *?Calling Programs
006800170329     D ptMainC1        pr                  extpgm('PTMAINC1')
006900161111     D   iPgmName                    10
007000161111
007100170320     D/include GBSPGM/QMODSRC,#ChkFncAth        // Check Function Authority
007200180417     D/include *LIBL/QMODSRC,#COMMANDPR         // Command
007300161117
007400161118
007500161109    ? *-------------------------------------------------------------------------
007600161109      *?Mainline Program
007700161109    ? *-------------------------------------------------------------------------
007800161111     C     *entry        plist
007900170329     C                   parm                    pProjKey
008000161111
008100161111
008200161111
008300161109      /Free
008400161109
008500180417       Exec Sql
008600180417          Set Option Commit = *None
008700180417                     ,Naming = *Sys;
008800161109
008900180417       Dou btnExit = *on;
009000180417          If Reload = 'Y';
009100161109             exsr CLEAR;
009200161109             exsr LOAD;
009300180417             Reload = 'N';
009400161109          endIf;
009500161109
009600161109          exsr DISPLY;
009700161109
009800161109
009900161109          //?Process Selections
010000161109          Select;
010100161109
010200180417          //  When btnAddNew = *on;
010300180417          //     Exsr Add_Screen;
010400180417          //     Reload = 'Y';
010500161109
010600161111
010700180417          other;
010800180417             exsr ReadChanged;
010900161109
011000180417          EndSl;
011100161109
011200161109
011300161109       enddo;
011400161109
011500161109       *inlr = *on;
011600161109
011700161110       // ----------------------------------------------------------------
011800180417       Begsr *Inzsr;
011900161109
012000161110          Reload = 'Y';
012100161109
012200170320          //?User Allowed to Delete?
012300170412          isAdmin = *off;
012400170412          AdminMode = *Blanks;
012500170412          oFunction = '*ADMIN';
012600170320          oDspErrMsg = 'N';
012700170320
012800170320          ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
012900180417          if oContinue = 'Y';
013000170412             isAdmin = *on;
013100180417             AdminMode = 'Y';
013200170320          endif;
013300170320
013400170918          //?Setup the Content Menu
013500170918          MenuId = 'Menu1';
013600180417          if isAdmin = *on;
013700180417             MenuId = 'Menu2';
013800180417          endif;
013900170915
014000161109       Endsr;
014100161109       // ----------------------------------------------------------------
014200180417       Begsr CLEAR;
014300161109
014400161110          //?Clear the Subfile
014500161110          ClrSfl = *on;
014600161110          Write Screen1;
014700161110          ClrSfl = *off;
014800180417          rrn = 0;
014900161109
015000161109       Endsr;
015100161109       // ----------------------------------------------------------------
015200180417       Begsr Load;
015300161109
015400170329
015500170329          //?Get Project Information
015600180521          Exec Sql
015700180521             Select Pjdescr,Pjnam1,Pjtrst ,Pjsub# ,Pjacct
015800180521             Into :S1pdescr,:S1actnam,:Wtrst,:Wsub#
015900180521             ,:Wacct
016000180521             From Ptproj
016100180521             Where Pjprojkey = :Pprojkey;
016200170329
016300180417          s1ActNbr = %Editc( wTrst : 'X' ) + '-' +
016400180417             %Editc( wSub# : 'X' ) + '-' +
016500180417             %Editc( wAcct : 'X' );
016600171109
016700180417          Setll pProjKey ptTask;
016800180417          Dou %eof( ptTask );
016900161109
017000180417             reade(n) pProjKey ptTask;
017100170329             if %eof( ptTask );
017200180417                leave;
017300161109             endif;
017400161109
017500180521
017600170321             ShowPgm = *off;
017700170329             if ptProgram > *Blanks;
017800180417                ShowPgm = *on;
017900170321             endif;
018000170321
018100171107             s1LineId = ptLineId;
018200170329             s1Seq = ptSeq;
018300170329             s1Dept = ptDept;
018400170329             s1Category = ptCatg;
018500170329             s1Action = ptAction;
018600170329             s1Contact = ptContact;
018700180417             s1Contact2 = ptContact2;
018800180417             s1Status = ptStatus;
018900170329             s1PgmName = ptProgram;
019000170410             s1NoteKey = ptNoteKey;
019100170919             s1ToolTip = ptToolTip;
019200170919             ShowInfo = *off;
019300170919             if ptToolTip > *blanks;
019400180417                ShowInfo = *on;
019500170919             endif;
019600170919
019700170919
019800170919
019900170320             TotalMin = 0;
020000170320             s1Time   = *Blanks;
020100170320             s1EstTime  = *Blanks;
020200170320
020300170320             //?Get the Total time for each Task
020400170320             Exec Sql
020500180417                Select Sum( onTaskHr * 60 ) + sum( onTaskMn) into :TotalMin
020600180417                From ptNotes
020700180417                Where onProjKey = :pProjKey and onNoteKey = :s1NoteKey;
020800170320
020900170320             TotalHr = %Div(TotalMin : 60);
021000170320             TotalMn = %Rem(TotalMin : 60);
021100170320
021200170320             s1Time  = %Char(TotalHr) + ' Hr ' +
021300180417                %Char(TotalMn) + ' Min';
021400170320
021500180417             s1EstTime = 'Estimated Time: '       +
021600180417                %Char(ptEstHr) + ' Hr ' +
021700180417                %Char(ptEstMn) + ' Min';
021800170320
021900170320
022000180521             //---------------------------------
022100180521             //
022200180521             // Show / Hide View Notes
022300180521             //
022400180521             //---------------------------------
022500180521             shwvNotes = *off;
022600180521             chain ( pProjKey : s1NoteKey) ptNotes;
022700180521             if %Found( ptNotes ) ;
022800180521                shwVNotes = *on;
022900180521             EndIf;
023000180521
023100180521
023200180417             rrn = rrn + 1;
023300180417             write LstSfl;
023400170320
023500180417             If rrn >= 9999;
023600180417                leave;
023700180417             endIf;
023800161109
023900180417          enddo;
024000161109
024100180417       Endsr;
024200161109
024300180417       // ----------------------------------------------------------------
024400180417       Begsr DISPLY;
024500161109
024600180417          DspSfl = *on  ;
024700180417          exfmt Screen1;
024800180417          DspSfl = *off;
024900161109
025000180417       Endsr;
025100180417       // ----------------------------------------------------------------
025200180417       Begsr ReadChanged;
025300161109
025400180417          Dou *in95 = *ON;
025500180417             READC LstSfl;
025600180417             *in95 = %EOF;
025700161109
025800180417             If *in95 = *OFF;
025900161109
026000180417                //?Read the runOptions and set the indicator...
026100180417                if runOption > *Blanks;
026200170918                   if runOption = 'wNotes';
026300180417                      btnEdit = *on;
026400180417                   endif;
026500170918
026600170918                   if runOption = 'vNotes';
026700180417                      btnView = *on;
026800180417                   endif;
026900170918
027000170918                   if runOption = 'RunPgm';
027100180417                      btnRun = *on;
027200180417                   endif;
027300170918
027400180417                   if runOption = 'DelTask';
027500180417                      btnDelete = *on;
027600180417                   endif;
027700170918
027800180417                   if runOption = 'AddPrjTime';
027900180417                      Exsr Add_Time;
028000180417                      ReloadS2 = 'Y';
028100180417                   endif;
028200171107
028300180417                   if runOption = 'EditTask';
028400180417                      btnEditTsk = *on;
028500180417                   endif;
028600170918                endif;
028700161111
028800170918
028900170918
029000180417                //? Edit Note Records
029100180417                If btnEdit = *on;
029200180417                   exsr Screen_2;
029300170918                endIf;
029400170918
029500170918
029600180417                //? View Records
029700180417                If btnView = *on;
029800180417                   exsr ViewNote;
029900161111                endIf;
030000161111
030100161111
030200180417                //?Run Program
030300180417                if btnRun = *on;
030400170329                   ptMainC1( s1PgmName );
030500180417                endif;
030600161109
030700170320
030800180417                //?Delete Task
030900180417                if btnDelete = *on;
031000170320
031100180417                   Exec Sql
031200180417                      Delete from ptTask Where ptProjKey = :pProjKey and
031300180417                      ptSeq = :s1seq;
031400170320
031500180417                   Exec Sql
031600180417                      Delete from ptNotes Where onProjKey = :pProjKey
031700180417                      and onNoteKey = :s1NoteKey;
031800170320
031900180417                   ResequenceTASK();
032000180417                   ReloadS2 = 'Y';
032100180417                endif;
032200161117
032300170413
032400170413
032500180417                //?Edit Task
032600180417                if btnEditTsk = *on;
032700180417                   exsr Load_Task;
032800180417                   exsr ChgTask;
032900180417                   ReloadS2 = 'Y';
033000180417                endif;
033100170419
033200170919
033300180417                //?View Info
033400180417                if btnViewInf = *on;
033500180417                   exsr Load_Task;
033600180417                   exfmt View_Info;
033700180417                   ReloadS2 = 'Y';
033800180417                endif;
033900170919
034000170419
034100170419
034200170419
034300170419
034400180417                //?Status was Changed.
034500180417                if stsChanged = *on;
034600180417                   chain ( pProjKey : s1Seq) ptTask;
034700180417                   ptStatus = s1Status;
034800180417                   ptChgBy = wqusrn;
034900180417                   ptChgDt = %Dec(%Date);
035000180417                   ptChgTm = %Dec(%Time);
035100170329
035200180417                   if ptStatus = 'COMPLETED';
035300180417                      ptCloBy = wqusrn;
035400180417                      ptCloDt = %Dec(%Date);
035500180417                      ptCloTm = %Dec(%Time);
035600180417                   endif;
035700170329
035800170329
035900180417                   update r_ptTask;
036000180417
036100180417                   // Run After the update incase something crashes..
036200180417                   if ptStatus = 'COMPLETED';
036300180522             //       SendEmail();
036400180417                   endif;
036500180417
036600170321
036700180417                   //?Count the open/Closed Tasks to generate
036800180417                   //?the project Status  ( When the Status Changes )
036900180417                   Exec Sql
037000180417                      Select count(*) into :nOpenTsk
037100180417                      From ptTask
037200180417                      Where ptProjKey = :pProjKey
037300180417                      and ptStatus <> 'COMPLETED';
037400170330
037500180417                   Exec Sql
037600180417                      Select count(*) into :nClosedTsk
037700180417                      From ptTask
037800180417                      Where ptProjKey = :pProjKey
037900180417                      and ptStatus = 'COMPLETED';
038000170330
038100180417                   ProjStatus = 'A';
038200180417                   if nOpenTsk = 0 and nClosedTsk > 0;
038300180417                      ProjStatus = 'C';
038400180417                   endif;
038500170330
038600170330
038700180417                   //?Update the ptProject File.
038800180417                   Exec Sql
038900180417                      Update ptProj
039000180417                      Set pjChgBy = :wqUsrn,
039100180417                      pjRcdSts = :ProjStatus,
039200180417                      pjChgDt = int(replace(char(current_date , ISO),'-','')),
039300180417                      pjChgTm = int(replace(char(current_time),':',''))
039400180417                      Where
039500180417                      pjProjKey = :pProjKey;
039600170321
039700180417                endif;
039800161111
039900161111
040000161111
040100161109                btnEdit = *off;
040200161111                btnView = *off;
040300180417                btnRun = *off;
040400180417                btnDelete = *off;
040500180417                btnEditTsk = *off;
040600161118
040700180417                runOption = *Blanks;
040800180417                stsChanged = *off;
040900161111
041000180417                update LstSfl;
041100161109
041200180417                Reload = 'Y';
041300180417             endIf;
041400161109
041500161109
041600180417          enddo;
041700180417       Endsr;
041800161111
041900161111
042000180417       //-----------------------------------------------------------------
042100180417       //?                       ADD Screen
042200180417       //-----------------------------------------------------------------
042300180417       Begsr Add_Screen;
042400161111
042500161111          Clear Add_Note;
042600161111
042700170329          s3pDescr = s1pDescr;
042800180417          s3ActNam = s1ActNam;
042900161111
043000180417          s3Action = s1Action;
043100180417          s3Dept   = s1Dept;
043200180417          s3Category = s1Category;
043300170329
043400180417          s3Seq    = s1Seq;
043500180417          s3NoteKey = s1NoteKey;
043600170410
043700170410
043800180417          Dou btnCancel = *on;
043900161111
044000180417             exfmt Add_Note;
044100161111
044200161111
044300180417             if btnCancel = *on;
044400180417                leave;
044500180417             endif;
044600161111
044700161111
044800180417             if btnAccept = *on;
044900161111
045000161111                //?Validate...
045100161111
045200161111
045300180417                //?No Errors - Update.
045400180417                onProjKey = pProjKey;
045500180417                onNoteKey = s3NoteKey;
045600161111
045700180417                //?If this is the first note for this task, generate
045800180417                //?a unique NoteKey.
045900180417                if s3NoteKey = *Blanks;
046000170412
046100170412                   Exec Sql
046200180417                      Select max( substring( onNoteKey , 3 ))
046300180417                      into :nNextId
046400180417                      From ptNotes where onProjKey = :pProjKey;
046500170410
046600180417                   if SqlCod <> 0;
046700180417                      nNextId = 0;
046800180417                   endif;
046900170410
047000170412                   nNextId = nNextId + 1;
047100170412                   aNextId = %Editc(nNextId : 'X');
047200180417                   onNoteKey = 'NT' + aNextId;
047300180620                endif;
047400170410
047500180417                   Exec Sql
047600180417                      Select Max( onNotSeq ) Into :@note_Seq
047700180417                      From ptNotes
047800180417                      Where onProjKey = :pProjKey and onNoteKey = :onNoteKey;
047900161111
048000180417                   onNotSeq = @Note_Seq + 10;
048100170412
048200170412
048300161111                onSumry = s3Summary;
048400161111                onNote  = s3Note;
048500161111
048600170321                onTaskHr = s3Hour;
048700170321                onTaskMn = s3Min;
048800170321
048900180417                onCrtBy = wqusrn;
049000180417                onCrtDt = %Dec(%Date);
049100180417                onCrtTm = %Dec(%Time);
049200161111
049300180417                Write r_ptNotes;
049400161111
049500180417                //?Update the Task with the Note Key
049600180417                //?New Entry Only..
049700180417                if onNotSeq = 10;
049800170412                   Exec Sql
049900180417                      Update ptTask  Set ptNoteKey = :onNoteKey
050000180417                      Where ptProjKey = :pProjKey and
050100180417                      ptSeq = :s3Seq ;
050200170412
050300180417                   // Set s1NoteKey. (Needed when reloading the
050400180417                   // Subfile)
050500180417                   s1NoteKey = onNoteKey;
050600170412
050700180417                   Exec Sql
050800180417                      Update ptTask  Set ptStatus = 'INPROCESS'
050900180417                      Where ptProjKey = :pProjKey and
051000180417                      ptSeq = :s3Seq  and ptStatus = '';
051100170420
051200180417                endif;
051300170412
051400170412
051500180417                //?Update the ptProject File.
051600180417                Exec Sql
051700180417                   Update ptProj
051800180417                   Set pjChgBy = :wqUsrn,
051900180417                   pjChgDt = int(replace(char(current_date , ISO),'-','')),
052000180417                   pjChgTm = int(replace(char(current_time),':',''))
052100180417                   Where
052200180417                   pjProjKey = :pProjKey;
052300170329
052400180417                leaveSr;
052500180417             endif;
052600161111
052700180417          Enddo;
052800161111
052900180417       Endsr;
053000161111
053100161111       //-----------------------------------------------------------------
053200180417       //?                       Edit Note
053300180417       //-----------------------------------------------------------------
053400180417       Begsr Edit_Note;
053500161111
053600180417          Clear Add_Note;
053700170329
053800180417          s3pDescr = s1pDescr;
053900180417          s3ActNam = s1ActNam;
054000180417          s3Action = s1Action;
054100180417          s3Dept   = s1Dept;
054200180417          s3Category = s1Category;
054300170410          s3NoteKey = s2NoteKey;
054400161111          dtaChanged = *off;
054500161111
054600170425          Chain ( pProjKey : s3NoteKey : s2NotSeq ) ptNotes;
054700161111
054800161111          s3Summary = onSumry;
054900180417          s3Note    =onNote;
055000180417          s3Hour = onTaskHr;
055100180417          s3Min = onTaskMn;
055200170320
055300180417          Dou btnCancel = *on;
055400161111
055500180417             exfmt Add_Note;
055600161111
055700180417             if btnCancel = *on;
055800180417                leave;
055900180417             endif;
056000161111
056100170419
056200180417             if btnAccept = *on ;
056300161111
056400180417                if dtaChanged = *off;
056500180417                   leave;
056600180417                endif;
056700161111
056800161111
056900180417                //?Validate...
057000161111
057100161111
057200180417                //?No Errors - Update.
057300180417                onSumry = s3Summary;
057400180417                onNote  = s3Note;
057500180417                onTaskHr = s3Hour;
057600180417                onTaskMn = s3Min;
057700170320
057800180417                onChgBy = wqusrn;
057900180417                onChgDt = %Dec(%Date);
058000180417                onChgTm = %Dec(%Time);
058100161111
058200180417                update r_ptNotes;
058300170321
058400180417                //?Update the ptProject File.
058500180417                Exec Sql
058600180417                   Update ptProj
058700180417                   Set pjChgBy = :wqUsrn,
058800180417                   pjChgDt = int(replace(char(current_date , ISO),'-','')),
058900180417                   pjChgTm = int(replace(char(current_time),':',''))
059000180417                   Where
059100180417                   pjProjKey = :pProjKey;
059200170329
059300161111
059400180417                leaveSr;
059500180417             endif;
059600161111
059700180417          Enddo;
059800161111
059900180417       Endsr;
060000161111
060100180417       //-----------------------------------------------------------------
060200180417       //?                       View Notes
060300180417       //-----------------------------------------------------------------
060400180417       Begsr ViewNote;
060500161111
060600180417          Clear View_Note;
060700161111
060800170329          s3pDescr = s1pDescr;
060900170329          s3ActNam = s1ActNam;
061000180417          s3Action = s1Action;
061100180417          s3Dept   = s1Dept;
061200180417          s3Category = s1Category;
061300170329
061400180417          s3Seq    = s1Seq;
061500180417          s3NoteKey =  s1NoteKey;
061600170329
061700180417          oHtml    = *blanks;
061800161111
061900180417          Setll ( pProjKey : s3NoteKey ) ptNotes;
062000180417          dou %Eof(ptNotes);
062100180417             reade ( pProjKey : s3NoteKey ) ptNotes;
062200161111
062300180417             if %eof(ptNotes);
062400180417                leave;
062500161111             endif;
062600161111
062700180417             //?Load HTML Container
062800161111
062900180417             oHtml = %Trim(oHtml) + '<p><b>'+ onSumry + '</b><br/>';
063000180417             oHtml = %Trim(oHtml) +
063100180417                'Created by: ' + %Trim(onCrtBy) + ' on ' +
063200180417                %Char(%date(onCrtDt) :*usa) + ' at ' +
063300180417                %Char(%Time(onCrtTm) :*usa);
063400161121
063500180417             oHtml = %Trim(oHtml) + '<p style="margin-left: 40px">' +
063600180417                onNote + '</p><br/>';
063700161111
063800180417          enddo;
063900161111
064000161111
064100161111
064200180417          //?Display Screen
064300180417          Dou btnCancel = *on;
064400161111
064500180417             exfmt View_Note;
064600161111
064700180417             if btnCancel = *on;
064800180417                leave;
064900180417             endif;
065000161111
065100180417          Enddo;
065200161111
065300180417       Endsr;
065400161111
065500180417       //--------------------------------------------------------------------
065600180417       //? Screen 2
065700161111       //--------------------------------------------------------------------
065800180417       begsr Screen_2;
065900161111
066000180417          ReLoadS2 = 'Y';
066100161111
066200180417          Dow btnExit = *off;
066300161111
066400180417             if ReLoadS2 = 'Y';
066500180417                exsr ClearS2;
066600180417                exsr LoadS2;
066700180417                ReloadS2 = 'N';
066800180417             endif;
066900161111
067000180417             Exsr DisplyS2;
067100161111
067200161111
067300180417             //?Process Selections
067400180417             Select;
067500161111
067600180417             When btnAddNew = *on;
067700180417                Exsr Add_Screen;
067800180417                ReloadS2 = 'Y';
067900180417                iter;
068000161111
068100180417             endsl;
068200161111
068300161111
068400180417             //?Read Subfile for Changes.
068500180417             Dou *in95 = *ON;
068600180417                READC NoteSfl;
068700180417                *in95 = %EOF;
068800161111
068900180417                If *in95 = *OFF;
069000161111
069100180417                   //?Edit Note...
069200180417                   if btnEdit = *on;
069300180417                      exsr Edit_Note;
069400180417                      ReloadS2 = 'Y';
069500180417                      iter;
069600161111
069700180417                   endif;
069800161111
069900180417                   btnEdit = *off;
070000180417                   update NoteSfl;
070100180417                endIf;
070200180417             enddo;
070300161111
070400161111
070500161111
070600180417          enddo;
070700180417          btnExit = *off;
070800161111
070900161111
071000180417       Endsr;
071100180417       // ----------------------------------------------------------------
071200180417       Begsr ClearS2;
071300161111
071400161111
071500180417          //?Clear the Subfile
071600180417          ClrSfl2 = *on;
071700180417          Write Screen2;
071800180417          ClrSfl2 = *off;
071900161111
072000180417          RRN2 = 0;
072100180417       Endsr;
072200161111
072300180417       // ----------------------------------------------------------------
072400180417       Begsr DISPLYS2;
072500161111
072600180417          DspSfl2 = *on  ;
072700180417          exfmt Screen2;
072800180417          DspSfl2 = *off;
072900161111
073000180417       Endsr;
073100161111
073200180417       // ----------------------------------------------------------------
073300180417       Begsr LoadS2;
073400161111
073500180417          Clear Screen2;
073600161111
073700180417          s2pDescr = s1pDescr;
073800180417          s2ActNam = s1ActNam;
073900180417          s2Dept   = s1Dept;
074000180417          s2Category = s1Category;
074100180417          s2Action = s1Action;
074200180417          s2NoteKey = s1NoteKey;
074300161111
074400180417          setll ( pProjKey : s2NoteKey ) ptNotes;
074500180417          dou %Eof(ptNotes);
074600161111
074700180417             Reade(n) ( pProjKey : s2NoteKey ) ptNotes;
074800161111
074900180417             if %Eof(ptNotes);
075000180417                leave;
075100180417             endif;
075200161111
075300180417             if onTaskHr = 0;
075400180417                s2Time  = %Char(onTaskMn) + ' Min';
075500180417             else;
075600180417                s2Time  =  %Char(onTaskHr) + ' Hr ' +
075700180417                   %Char(onTaskMn) + ' Min';
075800180417             endif;
075900170320
076000180417             s2Sumry = onSumry;
076100180417             s2Crtby = onCrtby;
076200180417             s2CrtDt = %Date(onCrtDt:*iso);
076300180417             s2CrtTm = %Time(onCrtTm:*iso);
076400180417             s2NotSeq = onNotSeq;
076500161111
076600180417             // Updated by Info...
076700180417             s2ChgBy = onChgBy;
076800180417             s2ChgDt = *Blanks;
076900180417             s2ChgTm = *Blanks;
077000180417             if onChgDt > 0;
077100180417                s2ChgDt = %Char(%Date(onChgDt:*iso));
077200180417                s2ChgTm = %Char(%Time(onChgTm:*iso));
077300180417             endif;
077400170915
077500161111
077600180417             rrn2 = rrn2 + 1;
077700180417             write NoteSfl;
077800180417          enddo;
077900180417       Endsr;
078000161111
078100170413
078200180417       //-----------------------------------------------------------------
078300180417       //?                 Load the Task Screen
078400180417       //-----------------------------------------------------------------
078500180417       Begsr Load_Task;
078600170419
078700180417          Chain(n) (pProjKey: s1Seq) ptTask;
078800180417          s4Seq = s1Seq;
078900171107          s4LineId = s1LineID;
079000170419          s4ProjDsc = s1pDescr;
079100170413
079200170420          s4Action = ptAction;
079300170420          s4Dept =  ptDept;
079400170420          s4Catg = ptCatg;
079500170420          s4Contact = ptContact;
079600170420          s4CntEmail = ptCtEmail;
079700170915
079800170915          s4Contact2 = ptContact2;
079900180417          s4CntEml2  = ptCtEmail2;
080000170915
080100180417          s4Manager = ptManager;
080200180417          s4MgrEmail = ptMgrMail;
080300180417          s4Program = ptProgram;
080400180417          s4Tooltip  = ptToolTip;
080500170918
080600180417          s4EstHr = ptEstHr;
080700180417          s4EstMn = ptEstMn;
080800180417          s4EspDays = ptEspDays;
080900170419
081000170413
081100180417       Endsr;
081200170413
081300170413
081400180417       //-----------------------------------------------------------------
081500180417       //?                     Change Task
081600170413       //-----------------------------------------------------------------
081700180417       Begsr ChgTask;
081800170413
081900180417          Dou btnCancel = *on;
082000170413
082100180417             exfmt Chg_Task;
082200170413
082300180417             if btnCancel = *on;
082400180417                leave;
082500180417             endif;
082600170413
082700170413
082800180417             //----------------------------------------------
082900180417             //?Update.
083000180417             //----------------------------------------------
083100180417             if btnAccept = *on;
083200170413
083300180417                Exec Sql
083400180417                   update ptTask
083500180417                   Set
083600180417                   ptContact = :s4Contact,   ptCtEmail = :s4CntEmail,
083700180417                   ptContact2 = :s4Contact2, ptCtEmail2 = :s4CntEml2,
083800180417                   ptManager = :s4Manager,   ptMgrMail = :s4MgrEmail,
083900180417                   ptEstHr = :s4EstHr, ptEstMn = :s4EstMn,
084000180417                   ptEspDays = :s4EspDays, ptToolTip = :s4ToolTip,
084100180417                   ptChgBy = :WQUSRN,
084200180417                   ptChgDt = int(replace(char(current_date , ISO),'-','')),
084300180417                   ptChgTm = int(replace(char(current_time),':','')),
084400180417                   ptSeq = :s4Seq - 1
084500180417                   Where ptProjKey = :pProjKey and ptLineId = :s4LineId;
084600170413
084700180417                exsr CheckEmail;
084800180417                ResequenceTASK();
084900170413
085000180417                leave;
085100180417             endif;
085200170413
085300180417          Enddo;
085400170413
085500180417       Endsr;
085600170413
085700170419
085800180417       //-----------------------------------------------------------------
085900180417       //?                 Check Email...
086000180417       //-----------------------------------------------------------------
086100180417       Begsr CheckEmail;
086200170419
086300180417          //?Check Contact Info...
086400180417          if s4Contact > *Blanks and s4CntEmail > *Blanks;
086500180417             chain s4Contact ptEmail;
086600180417             if not %Found(ptEmail);
086700180417                puName = s4Contact;
086800180417                puEmail = s4CntEmail;
086900180417                Write r_ptEmail;
087000180417             else;
087100180417                puEmail = s4CntEmail;
087200180417                update r_ptEmail;
087300180417             endif;
087400180417          endif;
087500170419
087600170915
087700180417          //?Check Contact2 Info...
087800180417          if s4Contact2 > *Blanks and s4CntEml2 > *Blanks;
087900180417             chain s4Contact2 ptEmail;
088000180417             if not %Found(ptEmail);
088100180417                puName = s4Contact2;
088200180417                puEmail = s4CntEml2;
088300180417                Write r_ptEmail;
088400180417             else;
088500180417                puEmail = s4CntEml2;
088600180417                update r_ptEmail;
088700180417             endif;
088800180417          endif;
088900170915
089000180417          //?Check Manager Info...
089100180417          if s4Manager > *Blanks and s4MgrEmail > *Blanks;
089200180417             chain s4Manager ptEmail;
089300180417             if not %Found(ptEmail);
089400180417                puName = s4Manager;
089500180417                puEmail = s4MgrEmail;
089600180417                Write r_ptEmail;
089700180417             else;
089800180417                puEmail = s4MgrEmail;
089900180417                update r_ptEmail;
090000180417             endif;
090100180417          endif;
090200170419
090300170419
090400180417       Endsr;
090500170419
090600171107
090700180417       //-----------------------------------------------------------------
090800180417       //?                 Add Time Only
090900180417       //-----------------------------------------------------------------
091000180417       Begsr Add_Time;
091100171107
091200180417          Clear AddTime;
091300180417          s3Action = s1Action;
091400171107
091500180417          Dou btnCancel = *on;
091600171107
091700180417             exfmt AddTime;
091800171107
091900171107
092000180417             if btnBack = *on;
092100180417                leave;
092200180417             endif;
092300171107
092400171107
092500180417             if btnAccept = *on;
092600171107
092700180417                //?Validate...
092800171107
092900171107
093000180417                //?No Errors - Update.
093100180417                onProjKey = pProjKey;
093200180417                onNoteKey = s1NoteKey;
093300171107
093400180417                //?If this is the first note for this task, generate
093500180417                //?a unique NoteKey.
093600180417                if s1NoteKey = *Blanks;
093700171107
093800180417                   Exec Sql
093900180417                      Select max( substring( onNoteKey , 3 ))
094000180417                      into :nNextId
094100180417                      From ptNotes where onProjKey = :pProjKey;
094200171107
094300180417                   if SqlCod <> 0;
094400180417                      nNextId = 0;
094500180417                   endif;
094600171107
094700171107                   nNextId = nNextId + 1;
094800180417                   aNextId = %Editc(nNextId : 'X');
094900180417                   onNoteKey = 'NT' + aNextId;
095000171107
095100180417                   Exec Sql
095200180417                      Select Max( onNotSeq ) Into :@note_Seq
095300180417                      From ptNotes
095400180417                      Where onProjKey = :pProjKey and onNoteKey = :s1NoteKey;
095500171107
095600180417                   onNotSeq = @Note_Seq + 10;
095700180417                endif;
095800171107
095900171107
096000180417                onSumry = 'Time added to project.';
096100171107
096200171107                onTaskHr = s3Hour;
096300171107                onTaskMn = s3Min;
096400171107
096500180417                onCrtBy = wqusrn;
096600180417                onCrtDt = %Dec(%Date);
096700180417                onCrtTm = %Dec(%Time);
096800171107
096900180417                Write r_ptNotes;
097000171107
097100180417                //?Update the Task with the Note Key
097200180417                //?New Entry Only..
097300180417                if onNotSeq = 10;
097400180417                   Exec Sql
097500180417                      Update ptTask  Set ptNoteKey = :onNoteKey
097600180417                      Where ptProjKey = :pProjKey and
097700180417                      ptSeq = :s1Seq ;
097800171107
097900180417                   //?Set s1NoteKey. (Needed when reloading the
098000180417                   //?Subfile)
098100180417                   s1NoteKey = onNoteKey;
098200171107
098300180417                   Exec Sql
098400180417                      Update ptTask  Set ptStatus = 'INPROCESS'
098500180417                      Where ptProjKey = :pProjKey and
098600180417                      ptSeq = :s1Seq  and ptStatus = '';
098700171107
098800180417                endif;
098900171107
099000171107
099100180417                //?Update the ptProject File.
099200180417                Exec Sql
099300180417                   Update ptProj
099400180417                   Set pjChgBy = :wqUsrn,
099500180417                   pjChgDt = int(replace(char(current_date , ISO),'-','')),
099600180417                   pjChgTm = int(replace(char(current_time),':',''))
099700180417                   Where
099800180417                   pjProjKey = :pProjKey;
099900171107
100000180417                leaveSr;
100100180417             endif;
100200171107
100300180417          Enddo;
100400171107
100500170413
100600171107
100700171107
100800180417       Endsr;
100900171107
101000180417
101100180417
101200180417
101300180417
101400180417
101500180417
101600170413      *?==========================================================================================
101700170413      *
101800170413      *  ResequenceTASK subprocedure.  Resequences TASK file
101900170413      *
102000170413      *?==========================================================================================
102100170413     P ResequenceTASK  B
102200170413     D ResequenceTASK  PI
102300170413
102400170413     D newseq          S                   like(ptSeq)
102500170413     D savKey          S                   like(ptProjKey)
102600170413
102700170413      /Free
102800170413
102900180417       //?Read the Main file..
103000180417       SetLL *loval ptTask;
103100180417       Read  ptTask;
103200180417       Dow not %EOF;
103300170413
103400180417          if savKey <> ptProjKey;
103500180417             newSeq = 0;
103600180417             savKey = ptProjKey;
103700180417          endif;
103800170413
103900180417          newseq +=10;
104000180417          ptTmpSeq = newseq;
104100180417          update r_ptTask;
104200170413
104300180417          Read ptTask;
104400180417       EndDo;
104500170413
104600170413
104700180417       //?Read the Logical / Temp File
104800180417       savKey = *Blanks;
104900180417       SetLL *loval ptTaskL1;
105000180417       Read ptTaskL1;
105100180417       Dow not %EOF;
105200170413
105300180417          if savKey <> ptProjKey;
105400180417             newSeq = 0;
105500180417             savKey = ptProjKey;
105600180417          endif;
105700170413
105800180417          newseq +=10;
105900180417          ptSeq = newseq;
106000180417          update Rcd2;
106100170413
106200180417          Read ptTaskL1;
106300180417       EndDo;
106400170413
106500170413
106600180417       Return;
106700170413
106800170413      /End-Free
106900170413     P ResequenceTASK  E
107000170413
107100180417
107200170413
107300180417      *-------------------------------------------------------------------------
107400180417       dcl-Proc  SendEmail;
107500180417
107600180417          Dcl-s Library Char(10);
107700180417          Dcl-s Msg Char(2000);
107800180417          dcl-s Subject Char(100);
107900180417          dcl-s Tasks  Char(2000);
108000180417          dcl-s CloseDate Char(10);
108100180417
108200180417          dcl-c q const ('''');
108300180417
108400180417          dcl-s EmailDesc Char( 40 );
108500180417
108600180417          EmailDesc = 'Broker Task Complete';
108700180417
108800180417
108900180417          //------------------------------
109000180417          //
109100180417          // Get the Environment
109200180417          //
109300180417          //------------------------------
109400180417          Exec Sql
109500180417             Select Objlo00002
109600180417             Into :Library
109700180417             From Table(Qsys2.Object_Statistics('*LIBL', 'FILE',
109800180417             Object_Name => '"F.ACCMST"')) As X ;
109900180417
110000180417
110100180417
110200180417
110300180417          //------------------------------
110400180417          //
110500180417          // Create the Task List
110600180417          //
110700180417          //------------------------------
110800180417          Tasks = '<Table><tr><b>' +
110900180417             '<td>Task</td>'    +
111000180417             '<td>Status</td>'  +
111100180417             '<td>Closed Date</td></b></tr>';
111200180417
111300180417          Setll pProjKey ptTask;
111400180417
111500180417          Dou %Eof(ptTask);
111600180417             reade pProjKey ptTask;
111700180417             if %eof(ptTask);
111800180417                leave;
111900180417             endif;
112000180417
112100180417
112200180417             closeDate = '';
112300180417             if ptCloDt > 0;
112400180417                CloseDate =  %Char(%date(ptCloDt) :*usa);
112500180417             EndIf;
112600180417
112700180417
112800180417             if ptStatus = 'COMPLETED';
112900180417
113000180417                tasks = %Trim(Tasks) +
113100180417                   '<tr><td><i>' + %trim(ptAction) + '</i></td>' +
113200180417                   '<td><b>' + %trim(ptStatus) + '</b></td>' +
113300180417                   '<td>' + %trim(CloseDate) + '</td></tr>';
113400180417
113500180417
113600180417             else;
113700180417
113800180417                tasks = %Trim(Tasks) +
113900180417                   '<tr><td><i>' + %trim(ptAction) + '</i></td>' +
114000180417                   '<td>' + %trim(ptStatus) + '</td>' +
114100180417                   '<td>' + %trim(CloseDate) + '</td></tr>';
114200180417
114300180417             endif;
114400180417
114500180417          Enddo;
114600180417
114700180417          tasks = %Trim(tasks) + '</table>';
114800180417
114900180417
115000180417
115100180417          //------------------------------
115200180417          //
115300180417          // Read through the Broker file
115400180417          //
115500180417          //------------------------------
115600180417
115700180417          setll pProjKey ptBroker;
115800180417
115900180417          Dou %Eof(ptBroker);
116000180417             reade pProjKey ptBroker;
116100180417             if %eof(ptBroker);
116200180417                leave;
116300180417             endif;
116400180417
116500180417
116600180417             // Retrieve the email from the External Email File
116700180417             chain EmailDesc ptExtEmll1;
116800180417             if not %Found( ptExtEmll1 );
116900180417                return;
117000180417             EndIf;
117100180417
117200180417
117300180417             //------------------------------
117400180417             //
117500180417             // Setup the Subject Line
117600180417             //
117700180417             //------------------------------
117800180417             Subject = %ScanRpl('[PROJECT]' :  %Trim( s1pDescr ) :
117900180417                %Trim(pxSubj) );
118000180417             Subject = %ScanRpl(q:'':Subject);
118100180417
118200180417
118300180417
118400180417             //------------------------------
118500180417             //
118600180417             // Setup the Body
118700180417             //
118800180417             //------------------------------
118900180417             Msg = %ScanRpl('[PROJECT]' : %Trim( s1pDescr ) :
119000180417                %Trim(pxEmail) );
119100180417
119200180417             Msg = %ScanRpl('[BROKER]' : %Trim( pbname ) :
119300180417                %Trim(Msg) );
119400180417
119500180417             Msg = %ScanRpl('[TASKS]' : %Trim( Tasks ) :
119600180417                %Trim(Msg) );
119700180417
119800180417             MSg = %ScanRpl(q:'':Msg);
119900180417
120000180417
120100180417             if Library = 'GBSDTAT';
120200180417                Msg = %Trim(Msg) + '<P> NOTE: This is from the TEST ' +
120300180417                   'Environment ** ';
120400180417             EndIf;
120500180417
120600180417
120700180417
120800180417
120900180417
121000180417             CmdString = 'MailTool toAddr(' + %Trim(pbemail) + ') ' +
121100180417                ' Subject(' + q + %Trim(Subject)  + q + ') ' +
121200180417                ' Message(' + q + %Trim( Msg ) + q + ')' +
121300180417                ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
121400180417
121500180417             #Command(CmdString:%len(%Trim(CmdString)));
121600180417          EndDo;
121700180417
121800180417
121900180417
122000180417
122100180417
122200180417
122300180417       End-Proc;
122400180417
