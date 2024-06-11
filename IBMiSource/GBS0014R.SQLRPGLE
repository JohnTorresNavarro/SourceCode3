000100210126     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200161109    ? *-------------------------------------------------------------------------
000300161109    ? *
000400170322    ? *  Description:  Daily Job Schedule.
000500161109    ? *  Programmer.:  Brian Rees
000600161109    ? *  Date.......:  08/31/2016
000700161109    ? *
000800170322    ? *  This replaces the VARPG Program that Anthony (Operations) uses.
000900170511    ? *
001000170511    ? *  To Compile: Add JMS400L to your library list
001100170322    ? *
001200161109    ? *-------------------------------------------------------------------------
001300170110    ?FGBS0014D  CF   E             WORKSTN
001400161109     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001500161109    ?F                                     SFILE(LSTSFL:rrn)
001501210127     F                                     SFile( ArchSfl : rrn3 )
001600161109
001700170110     FJmsHstLf  if   E           k disk
001800170327     FJmsMste   if   E           k disk
001900170124     FJmsDocp   if   E           k disk    rename(JmsDocp : Doc)
002000170728     FJmsStsp   if   E           k disk
002100161109    ? *-------------------------------------------------------------------------
002200161109    ? * Program status data structure
002300161109    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002400161109     D  @pgmq            *proc
002500161109
002600161109    ? * Display file data structure
002700161109    ?D DSPD            DS
002800161109     D  Key                  369    369
002900161109     D  Currec               378    379b 0
003000161111
003100161109     d Rrn             s              5s 0 inz
003101210127     d Rrn3            s              5s 0 inz
003200161109     d ReLoad          s              1
003300170110     d today           s               d   inz
003400170110     d HldHour         s              4    inz
003500170125     d wDay            s              2s 0 inz
003600170628
003700170628     D Q               C                   CONST('''')
003800170628     D Dq              C                   CONST('"')
003900170628
004000170804      * ToolTip Counts
004100170804     d nDoneA          s              4s 0 inz
004200170804     d nDoneM          s              4s 0 inz
004300170804     d DoneA           s              4s 0 inz
004400170804     d DoneM           s              4s 0 inz
004401210127       dcl-s oScript Char(250);
004500161111      *--------------------------------------------
004600161111      *?Procedures
004700161111      *--------------------------------------------
004800170602     d GBS0014R2       pr                  ExtPgm('GBS0014R2')
004900170809     d LetterCount     pr                  ExtPgm('GBS0014R3')
005000170809     d  iCount                       10
005100170809     D iCount          s             10
005200170915     d GBS0014C5       pr                  ExtPgm('GBS0014C5')
005300170915     d  iMonth                        2
005400170915     d  iYear                         4
005500170915     d iMonth          s              2
005600170915     d iYear           s              4
005700170915
005800170915
005801201117     d GBS0030C        pr                  ExtPgm('GBS0030C')
005802201117
005900170814     d AutoRunJob      pr                  ExtPgm('GBS0014C4')
006000210127     d  iScript                     250
006100170814
006200170628     D/include *LIBL/QMODSRC,#CommandPr
006300190429     D/include *LIBL/QMODSRC,PR0001RPR
006400170811     d cTime           s               t
006500170628
006600190429
006700190429       dcl-s wGroup Char(20);
006800190429       dcl-s wDept Char(5);
006900190429       dcl-s wScript Char(200);
007000190429       dcl-s wTrst Char(3);
007100190429       dcl-s wSub# Char(3);
007200190429       dcl-s wAcct Char(4);
007300190429       dcl-s wAAName Char(40);
007400190429       dcl-s pos Zoned(4);
007500190429       dcl-c  crlf  x'0d25';
007501210127       dcl-s wFolder Char(40);
007600190429
007700210127
008000210127       dcl-pr vwcarftpc1 ExtPgm('VWCARFTPC1') ;
008001210127         FolderName Char(150);
008002210127       end-pr;
008003210127       dcl-s FolderName Char(150);
008004210127
008005210127       dcl-pr vwcarftpc2 ExtPgm('VWCARFTPC2') ;
008006210127         FolderName Char(150);
008007210127         FileDate   Char(26);
008008210127         FileSize   Char(10);
008009210127       end-pr;
008010210127       dcl-s FileDate   Char(26);
008011210127       dcl-s kb_Text Char(10);
008012210127
008100190716
008200190429
008300161109    ? *-------------------------------------------------------------------------
008400161109      *?Mainline Program
008500161109    ? *-------------------------------------------------------------------------
008600170110     C*    *entry        plist
008700170110     C*                  parm                    s1Trst
008800161111
008900161111
009000170811
009100170811
009200210127       Exec Sql
009300210127         Set Option Commit = *None, Naming = *Sys;
009400190710
009500161109       Dou btnExit = *on;
009600161109
009700190429         If Reload = 'Y';
009800190429           exsr CLEAR;
009900190429           exsr LOAD;
010000190429           Reload = 'N';
010100190429         endIf;
010200161109
010300190429         exsr DISPLY;
010400161109
010500161109
010600190429         //?Process Selections
010700190429         Select;
010800161111
010900190429         When ChgShowMan = *on;
011000190429           Reload = 'Y';
011100170807
011200190429         when btnRefresh = *on;
011300190429           Reload = 'Y';
011400171201
011500190429           cTime = %Time();
011600190429           if cTime > %Time('08.45.00') and cTime < %Time('15.30.00');
011700171130
011800190429             LetterCount( iCount );
011900190429             if iCount > *Blanks;
012000190429               ltrMessage = 'There are ' + %Trim(iCount) +
012100190429                 ' SD Letters to be printed. ';
012200190429               exfmt PrintLtr;
012300190429             endif;
012400190429           endif;
012500170809
012600170809
012700190429         When mnuResp = 'GBS0014R2';
012800190429           // Call the Master File Maintenace Program
012900190429           GBS0014R2();
013000170602
013001201117         When mnuResp = 'GBS0030C';
013002201117           // Call the File Transfer Menu
013003201117           GBS0030C();
013004201117
013100190429         When mnuResp = 'cMonth';
013200190429           //?Generate the Operations Report - Current Month
013300190429           iMonth = %Char( %Subdt(%Date:*M)) ;
013400190429           iYear  = %Char( %Subdt(%Date:*Y)) ;
013500170915
013600190429           GBS0014C5(iMonth : iYear);
013700170915
013800190429         When mnuResp = 'nMonth';
013900190429           //?Generate the Operations Report - Next Month
014000190429           iMonth = %Char( %Subdt(%Date + %Months(1): *M)) ;
014100190429           iYear  = %Char( %Subdt(%Date + %Months(1): *Y)) ;
014200170915
014300190429           GBS0014C5(iMonth : iYear);
014400170602
014500190429         other;
014600190429           exsr ReadChanged;
014700161109
014800190429         EndSl;
014900161109
015000161109
015100161109       enddo;
015200161109
015300161109       *inlr = *on;
015400161109
015500161110       // ----------------------------------------------------------------
015600161109       Begsr *Inzsr;
015700161109
015800190429         Reload = 'Y';
015900190429         hDate = %Date();
016000190429         Today = %Date();
016100190429         wDay  = %Subdt( %Date() : *Days);
016200161109
016300161109       Endsr;
016400161109       // ----------------------------------------------------------------
016500161109       Begsr CLEAR;
016600161109
016700190429         //?Clear the Subfile
016800190429         ClrSfl = *on;
016900190429         Write CtlSfl;
017000190429         ClrSfl = *off;
017100190429         rrn = 0;
017200161109
017300161109       Endsr;
017400161109       // ----------------------------------------------------------------
017500170511       Begsr Load;
017600170110
017700170728
017800190429         // Get Status Message...
017900190429         s1StsMsg = *blanks;
018000210127         Exec Sql
018100210127           Select *
018200210127             Into :s1stsmsg
018300210127             From jmsstsp;
018400170728
018500170728
018600190429         nDoneA = 0;
018700190429         nDoneM = 0;
018800190429         DoneA = 0;
018900190429         DoneM = 0;
019000170804
019100190429         s1Done = 0;
019200190429         s1nDone = 0;
019300190429         s1AutoCnt = 0;
019400190429         s1Time = %Time;
019500170511
019600190429         Setll Today JmsHstLf;
019700190429         Dou %eof(JmsHstLf);
019800161109
019900190429           reade Today JmsHstLf;
020000190429           if %eof(JmsHstLf);
020100190429             leave;
020200190429           endif;
020300161109
020400190429           s1Jobn = jhJobn;
020500190429           s1Jobd = jhDate;
020600190429           s1Comp = jhComp;
020700190429           s1RunD = jhRunD;
020800190429           s1RunT = jhRunT;
020900190429           s1AmPm = jhAmPm;
020901210127           s1Script = '';
021000170110
021100170511
021200190429           hasJob   = 'N';
021300190429           ShowPct = *off;
021400190429           s1Auto = *blanks;
021500190429           chain jhJobn jmsmste;
021600190429           if %Found(jmsMste);
021700190429             if jeAuto = 'Y';
021800190429               s1Auto = 'Yes';
021900190429               s1AutoCnt = s1AutoCnt + 1;
022000190429             endif;
022100170628
022101210127             ShowRun = *off;
022102210127             s1Script = jeScript;
022200210127             if %trim(jeScript) > '';
022300190429               hasJob   = 'Y';
022301210127               ShowRun = *on;
022400190429             endif;
022500170511
022600190429             if jePct > 0;
022700190429               ShowPct = *on;
022800190429               s1Width = %Char(jePct) + 'px';
022900190429               s1Status = jeStatus;
023000190429               s1Percent = jePct;
023100170511
023200190429               //?Set Text Color
023300190429               pctColor='black';
023400190429               if jePct  >= 54;
023500190429                 pctColor='white';
023600190429               endif;
023700190429             endif;
023800190429           endif;
023900170327
024000170327
024100190429           if s1Comp = '' or s1Comp = 'N';
024200190429             s1nDone = s1nDone + 1;
024300190429             // Get Counts for the tool tip
024400190429             if jeAuto = 'Y';
024500190429               nDoneA = nDoneA + 1;
024600190429             else;
024700190429               nDoneM = nDoneM + 1;
024800190429             endif;
024900170804
025000170804
025100190429           else;
025200190429             s1Done = s1Done + 1;
025300190429             if jeAuto = 'Y';
025400190429               DoneA = DoneA + 1;
025500190429             else;
025600190429               DoneM = DoneM + 1;
025700190429             endif;
025800190429           endif;
025900170206
026000190429           hasNotes = 'N';
026100190429           ShowView = *off;
026200190429           chain s1Jobn jmsdocp;
026300190429           if %Found(JmsDocp);
026400190429             ShowView = *on;
026500190429             hasNotes = 'Y';
026600190429           endif;
026700170124
026800170628
026900170124
027000190429           //?Set Color of Row...
027100190429           s1Mth = '';
027200190429           s1Late = *zero;
027300190429           s1RowColor = '';
027400190429           s1FontClr  = '';
027500171218
027600190429           if jhMth > '';
027700190429             s1Mth = 'Yes';
027800190429             if s1Comp = '';
027900170907             //    s1RowColor = '#d3d3d3';     // Grey
028000190429             endif;
028100170125
028200190429             //?Get the Number of days that this didn't run.
028300190429             if jhDom1 > 0 and jhDom1 <= wDay;
028400190429               s1Late = wDay - jhDom1;
028500190429             endif;
028600170125
028700190429             if jhDom2 > 0 and jhDom2 <= wDay;
028800190429               s1Late = wDay - jhDom2;
028900190429             endif;
029000170125
029100190429             if jhDom3 > 0 and jhDom3 <= wDay;
029200190429               s1Late = wDay - jhDom3;
029300190429             endif;
029400170125
029500190429             if jhDom4 > 0 and jhDom4 <= wDay;
029600190429               s1Late = wDay - jhDom4;
029700190429             endif;
029800170125
029900190429             if jhDom5 > 0 and jhDom5 <= wDay;
030000190429               s1Late = wDay - jhDom5;
030100190429             endif;
030200170125
030300190429             //?Row Color ..
030400190429             Select;
030500190429             When s1Late = 1;
030600190429               s1RowColor = '#ffff00';     // Yellow
030700190429             When s1Late = 2;
030800190429               s1RowColor = '#ff4d4d';     // Red
030900190429             When s1Late = 3;
031000190429               s1RowColor = '#3333ff';     // Blue
031100190429               s1FontClr  = '#ffffff';     // White
031200190429             Endsl;
031300170125
031600190429           endif;
031700170120
031800201113           // Another Late Job.
031801201113           if jhRunc = 1;
031802210127             s1RowColor = '#ffff00';     // Yellow
031803201113           EndIf;
031804201113
031805201113
031900190429           hldHour = %Editc(jhHour:'X');
032000190429           s1Hour = %Subst(HldHour:1:2) + ':' + %Subst(HldHour:3:2);
032100190429           nDoneTip = %Char( nDoneA ) + ' Automatic jobs remaining and '+
032200190429             %Char( nDoneM ) + ' Manual jobs remaining.' ;
032300190429           DoneTip = %Char( DoneA ) + ' Automatic jobs completed and '+
032400190429             %Char( DoneM ) + ' Manual jobs completed.' ;
032500170804
032600190429
032700190429
032800190429           // Get the File Transfer Information
032900190429           s1JobTip = '';
033000190716           ShowFolder = *Off;
033100190429           if %Subst(s1Jobn : 1 : 3 ) = 'FT_';
033200190429
033300210127             Exec Sql
033400210127               Select ftgroup, ftdept, FTINFLDR, ftFolder
033500210127                 Into :wgroup, :wdept, :wscript, :wFolder
033600210127                 From gbs0030p
033700210127                 Where jobschname = :s1jobn
033800210127                 With NC;
033900190710
034000190429
034100190429             wTrst = %Subst( wGroup : 1 : 3 );
034200190429             wSub# = %Subst( wGroup : 4 : 3 );
034300190429             wAcct = %Subst( wGroup : 7 : 4 );
034400190429
034500190429             waaName = '';
034600190716             s1Location = '';
034700190429             if wDept = 'FI';
034800190716
034900210127               if wqusrn <> 'QTMHHTTP';
035000210127                 ShowFolder = *On;
035100210127               endif;
035200190717
035300210127               Exec Sql
035400210127                 Select Substring(afnam, 1, 1) || '. ' || alnam
035500210127                   Into :waaname
035600210127                   From aacode
035700210127                   Where acode = (Select aacode
035800210127                         From "F.ACCMST"
035900210127                         Where actrst = :wtrst And
036000210127                               acsub# = :wsub# And
036100210127                               acacct = :wacct);
036200210127             else;
036300210127               waaname = 'Wendy Abeshouse';
036400210127             EndIf;
036500190429
036600210127             wScript = ucase(wScript );
036700210127             s1Location = %Trim(wFolder) + '\Archive';
036800190429
036900190429
037000210127             s1JobTip = 'Dept: ' + %Trim( wDept ) + crlf +
037100210127             'AA: ' + %Trim( waaname ) + crlf +
037200210127             'Location: ' + %Trim( lcase(wScript)  ) ;
037300190429
037400190429
037500190429
037600190429           EndIf;
037700190429
037800190429
037900190429
038000190429           //?Check the Show Manual Checkbox.
038100190429           if ChkShowMan = *Blanks;
038200190429             rrn = rrn + 1;
038300190429             write LstSfl;
038400190429           else;
038500190429             if s1Auto = *blanks;
038600190429               rrn = rrn + 1;
038700190429               write LstSfl;
038800190429             endif;
038900190429           endif;
039000170807
039100190429           If rrn >= 9999;
039200190429             leave;
039300190429           endIf;
039400161109
039500190429         enddo;
039600161109
039700201107         if s1AutoCnt > 0;
039800210127           s1Pct = (s1AutoCnt / (s1Done + s1nDone ) ) * 100;
039801201107         endif;
039900170728
040000161110       Endsr;
040100161109
040200161109       // ----------------------------------------------------------------
040300161109       Begsr DISPLY;
040400161109
040500190429         DspSfl = *on  ;
040600190429         exfmt CtlSfl;
040700190429         DspSfl = *off;
040800161109
040900161109       Endsr;
041000161109       // ----------------------------------------------------------------
041100161109       Begsr ReadChanged;
041200161109
041300190429         Dou *in95 = *ON;
041400190429           READC LstSfl;
041500190429           *in95 = %EOF;
041600161109
041700190429           If *in95 = *OFF;
041800161109
041900170124
042000190429             //?View Instructions
042100190429             if btnView = *on;
042200190429               exsr ViewNotes;
042300190429             endif;
042400170124
042500210127             if btnRunPgm = *on;
042501210127               AutoRunJob( s1Script );
042502210127             endif;
042503210127
042600190716             //?Open Archive Folder
042700190716             if btnOpenFlr = *on;
042800210127               Screen3();
042900190716             endif;
043000190716
043100170124
043200190429             //?Status was Changed.
043300190429             if stsChanged = *on;
043400170623
043500190429               if s1Comp > *Blanks;
043600210127                 Exec Sql
043700210127                   Update jmshstp
043800210127                     Set jhcomp = :s1comp, jhrund = Current_Date, jhrunt =
043900210127                           Current_Time
044000210127                     Where jhjobn = :s1jobn And
044100210127                     jhdate = :s1jobd;
044200170623
044300190429               else;
044400210127                 Exec Sql
044500210127                   Update jmshstp
044600210127                     Set jhcomp = :s1comp, jhrund = '0001-01-01', jhrunt =
044700210127                           '00.00.00'
044800210127                     Where jhjobn = :s1jobn And
044900210127                     jhdate = :s1jobd;
045000190429               Endif;
045100170623
045200190429             endif;
045300161111
045400170623
045500190429             //?Check Content Menu Options
045600190429             if runOption > *blanks;
045700170623
045800190429               if runOption = 'CompTask';
045900210127                 Exec Sql
046000210127                   Update jmshstp
046100210127                     Set jhcomp = 'Y', jhrund = Current_Date, jhrunt =
046200210127                           Current_Time
046300210127                     Where jhjobn = :s1jobn And
046400210127                     jhdate = :s1jobd;
046500190429               endif;
046600170623
046700190429               if runOption = 'ViewIns';
046800190429                 exsr ViewNotes;
046900190429               endif;
047000170623
047100170628
047200190429               //?Run Job - Build the Windows Command
047300190429               //?and run the task.
047400190429               if runOption = 'RunJob';
047500210127                 AutoRunJob( s1Script );
047600190429               endif;
047700170623
047701210127
047702210127               if runOption = 'Opnfldr';
047704210127                 pos = %scanr('\':s1Script);
047705210127                 oScript ='Start "" ' + '"' +
047706210127                     %Subst( s1Script:1: Pos -1) + '"';
047707210127                 AutoRunJob( oScript )   ;
047708210127               endif;
047709210127
047710210127
047800170623
047900190429             endif;
048000170623
048100170623
048200190429             stsChanged = *off;
048300190429             btnView = *off;
048400190429             runOption = *Blanks;
048500210127             btnOpenFlr = *off;
048600210127             btnRunPgm = *off;
048601210127
048700190429             update LstSfl;
048800161109
048900190429             Reload = 'Y';
049000190429           endIf;
049100161109
049200161109
049300190429         enddo;
049400161109       Endsr;
049500161111
049600170623       // ----------------------------------------------------------------
049700170623       Begsr ViewNotes;
049800170623
049900190429         s2JobName = s1JobN;
050000190429         s2Note = *Blanks;
050100170623
050200190429         chain s2JobName JmsDocp;
050300190429         if not %Found(JmsDocp);
050400190429           Exfmt NoNotes;
050500190429           btnExit = *off;
050600190429           leaveSr;
050700190429         endif;
050800170623
050900170623
051000190429         setll s2JobName JmsDocp;
051100190429         dou %Eof(JmsDocp);
051200190429           reade s2JobName jmsDocp;
051300190429           if %eof(JmsDocp);
051400190429             leave;
051500190429           endif;
051600190429           s2Note = %trim(s2Note) +  %Trim(jdNote) + '<br/>';
051700190429         enddo;
051800170623
051900170623
052000170623
052100190429         exfmt View_Note;
052200170623
052300170623       Endsr;
052301210127
052302210127
052303210127
052304210127       // ----------------------------------------------------------------
052305210127       Dcl-Proc Screen3;
052306210127
052307210127         Dou btnClose = *on;
052308210127
052309210127           ClearS3();
052310210127           LoadS3();
052311210127
052312210127           DisplyS3();
052313210127
052314210127         enddo;
052315210127
052316210127       end-Proc;
052317210127
052318210127
052319210127       // ----------------------------------------------------------------
052320210127       dcl-proc CLEARS3;
052321210127
052322210127         //-------------------------
052323210127         //
052324210127         // Clear the Subfile
052325210127         //
052326210127         //-------------------------
052327210127
052328210127         Clrsfl3 = *on;
052329210127         Write ArchList;
052330210127         Clrsfl3= *off;
052331210127         rrn3 = 0;
052332210127
052333210127
052334210127         FolderName = '/Carrier_Inbound/' + %trim( s1Location );
052335210127         FolderName = %ScanRpl('\':'/':FolderName);
052336210127
052337210127         CmdString = 'AFNDINIFS  ' +
052338210127         'STARTDIR(' + q + %Trim(FolderName) + q + ') MATCH(*) ' +
052339210127           'OUTPUT(*RTVCMD) INCSUB(*NO) FILEORDIR(*FILE)';
052340210127
052341210127         #Command(CmdString:%len(%Trim(CmdString)));
052342210127
052343210127
052344210127       End-Proc;
052345210127       // ----------------------------------------------------------------
052346210127       Dcl-Proc LoadS3;
052347210127         dcl-s pos Zoned(5);
052348210127
052349210127         s3Heading = s1Jobn;
052350210127         FolderName = '/Carrier_Inbound/' + %trim( s1Location );
052351210127
052352210127         Dou FolderName = '*END';
052353210127
052354210127           vwcarftpc1(FolderName);
052355210127
052356210127           if FolderName = '*END';
052357210127             leave;
052358210127           endif;
052359210127
052360210127           pos = %Scanr('/':FolderName);
052361210127
052362210127           s3FileName = %Subst(FolderName:Pos+1);
052363210127
052364210127
052365210127           vwcarftpc2(FolderName:FileDate:kb_text);
052366210127           s3Size = %trim( kb_Text ) + ' KB';
052367210127           s3Date = %Subst( FileDate : 1 : 10 );
052368210127
052369210127           rrn3 = rrn3 + 1;
052370210127           write ArchSfl;
052371210127           If rrn3 >= 9999;
052372210127             leave;
052373210127           endIf;
052374210127
052375210127         enddo;
052376210127
052377210127
052378210127       End-Proc;
052379210127
052380210127       // ----------------------------------------------------------------
052381210127       Dcl-Proc DisplyS3;
052382210127
052383210127         DspSfl3 = *on  ;
052384210127         exfmt ArchList;
052385210127         DspSfl3 = *off;
052386210127
052387210127       End-Proc;
