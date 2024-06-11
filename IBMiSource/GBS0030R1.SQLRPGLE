000100171211     H option(*noDebugIo)  DftActGrp(*no)
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400180725      *  Description: File Transfer Groups   VIEW ONLY
000500161007      *  Programmer.: Brian Rees
000600171215      *  Date.......: 12/15/2017
000700160928      *
000800170322      *
000900160928      *-------------------------------------------------------------------------
001000180919      * Change Log
001100160928      *
001200160928      * Date         Programmer    Mod      Description
001300160928      *-------------------------------------------------------------------------
001400180919      * 09/19/2018   B.Rees
001500180919      *  Added Option to view Blank Plan Cross Reference data.
001600160928      *
001700190322      * 03/22/2019   B.Rees        br01     Added Job Schedule Name
001800190508      * 05/08/2019   B.Rees        br02     Added Department / Function Check
001900190509      * 05/09/2019   B.Rees        br03     Added Contact List
002000190509      *
002100160928      *-------------------------------------------------------------------------
002200180322
002300180725       dcl-f Gbs0030d1 Workstn
002400190509         HANDLER('PROFOUNDUI(HANDLER)')
002500190509         SFILE(LSTSFL:rrn);
002600180323
002700180322       dcl-f gbs0030p keyed
002800190509         usage( *input : *output : *update ) ;
002900180322
003000180322       dcl-f gbs0030n keyed
003100190509         usage( *input : *output : *update ) ;
003200180919
003400190326       dcl-f gbs0028p keyed;
003500200507       dcl-f gbs0035p keyed;
003600190326
003700180322
003800161005
003900160218      *--------------------------------------------------------------------
004000190509
004100190509       dcl-ds pgmd
004200190509         ExtName('IOPGMD') PSDS;
004300190509         @pgmq *proc;
004400200914       end-ds;
004500190509
004600190509       dcl-s reLoad Char(1);
004700190509       dcl-s rrn Zoned(5);
004800190509
004900180919       dcl-s wTrst Zoned(3);
005000180919       dcl-s wSub Zoned(3);
005100180919       dcl-s wAcct Zoned(4);
005200180919
005300180920       dcl-s PlanCnt Zoned(4);
005400180920       dcl-s BlankCnt Zoned(4);
005500180924
005600180924       dcl-s Aauserid Char(25);
005700180924       dcl-s AA_Account Char(1);
005800180924       dcl-s Cont Char(1);
005900180924
006000190508br02   dcl-s Auth_Dept Char(5);
006100161222
006200161227      *--------------------------------------------
006300161227      * Procedures
006400161227      *--------------------------------------------
006500190508br02  /include *LIBL/QMODSRC,#ChkFncAth         // Check Function Authority
006600190508
006601200914       // Removed 9/14/2020
006700200914       //dcl-pr gbs0038C ExtPgm('GBS0038C');
006800200914       //  oType Char(10);
006900200914       //  oName Char(40);
007000200914       //end-Pr;
007100180426
007200180820
007300180820       dcl-pr gbs0030R2 ExtPgm('GBS0030R2');
007400200914         oKey Char(10);
007500190509         oFileType Char(3);
007600200914       end-Pr;
007700180820       dcl-s oKey Char(10);
007800180820
007900180919
008000180919       dcl-pr gbs0044R  ExtPgm('GBS0044R');
008100190509         oKey Char(10);
008200180919       end-Pr;
008300180920
008400180920
008500180920       // iSeries Compare
008600180920       dcl-pr gbs0039C ExtPgm('GBS0039C');
008700190509         oType Char(10);
008800190509         oName Char(40);
008900190509         oKey  Char(10);
009000180920       end-Pr;
009100190509
009200190509
009300190509br03   // Show Contact List
009400190509       dcl-pr ShowCntList ExtPgm('GBS0030R3');
009500190509         oVend Char(10);
009600190509       end-Pr;
009700190509
009800190509
009801200914
009802200914       // View Archive Files.
009803200914       dcl-pr VWINBNDC ExtPgm('VWINBNDC');
009804200914         oSearch Char(20);
009805200914       end-Pr;
009806200914       dcl-s oSearch Char(20);
009807200914
009808200914
009809200914       // Scan Text Files.
009810200914       dcl-pr SCANFILEC ExtPgm('SCANFILEC');
009811200914         oCompName Char(40);
009812200914         oStaging Char(40);
009813200914       end-Pr;
009814200914
009900161005      *-------------------------------------------------------------------------
010000160928      *?Mainline Program
010100161005      *-------------------------------------------------------------------------
010200200914       Exec Sql
010300200914         Set Option Commit = *None, Naming = *Sys;
010400190508
010500190508       init();
010600150902
010700161223       dou btnExit = *on;
010800160928
010900190509         if Reload = 'Y';
011000190509           exsr ClearS1;
011100190509           Exsr $Check_AA;
011200180924
011300190509           exsr LoadS1;
011400190509           Reload = 'N';
011500200914         endif;
011600160928
011700190509         exsr DisplyS1;
011800160928
011900190509         if btnExit = *on;
012000190509           leave;
012100200914         endif;
012200161223
012300161223
012400190509         Select;
012500161223
012600190509         When ChgShowAll = *on;
012700200914           Reload = 'Y';
012800180725
012900190509         other;
013000200914           exsr ReadChanged;
013100161223
013200190509         endsl;
013300161223
013400200914       enddo;
013500160928
013600161223       *inlr = *on;
013700160928
013800160928      *-------------------------------------------------------------------------
013900161222       Begsr ClearS1;
014000160928
014100190509         //?Clear the Subfile
014200190509         ClrSfl = *on;
014300190509         Write LstCtl;
014400190509         ClrSfl = *off;
014500160928
014600190509         rrn = 0;
014700160928
014800200914       Endsr;
014900160928      *-------------------------------------------------------------------------
015000161222       Begsr DisplyS1;
015100160928
015200190509         DspSfl = *on  ;
015300190509         exfmt  LstCtl ;
015400190509         DspSfl = *off;
015500160928
015600160928       Endsr;
015700160928      *-------------------------------------------------------------------------
015800161222       Begsr LoadS1;
015900161005
016000200914         //----------------------------------------------------
016100200914         //?Load the Subfile.
016200200914         //----------------------------------------------------
016300200914         Setll *loval GBS0030P;
016400200914         dou %Eof(GBS0030P);
016500200914           read(n) GBS0030P;
016600161005
016700200914           if %Eof(GBS0030P);
016800200914             leave;
016900190509           endif;
017000161222
017100171215
017200200914           s1Seq = ftSeq#;
017300200916           s1Folder = ftFolder;
017301200916
017400200914           Exec Sql
017500200914             Select Count(*)
017600200914               Into :s1notes
017700200914               From gbs0030n
017800200914               Where onftseq = :s1seq;
017900180326
018000190509           LineColor = '';
018100200914           if ftRcdSts = 'D';
018200200914             LineColor = 'RED';
018300190509           EndIf;
018400180612
018500180612
018600200914           Select;
018700200914           When Ftdept = 'FI';
018800200914             s1Dept = 'Fully Insured';
018900190509           When ftDept = 'SF';
019000200914             s1Dept = 'Self Funded';
019100190509           When ftDept = 'OTH';
019200200914             s1Dept = 'Other';
019300190509           endsl;
019400190508
019500190508
019600190508
019700200914br02       // Check the Authorized Department
019800200914 |         Select;
019900200914 |         when Auth_Dept = 'FI' and ftDept <> 'FI';
020000200914 |           iter;
020100190508 |
020200200914 |         When Auth_Dept = '';
020300200914 |           iter;
020400190508 |
020500190508 |         when Auth_Dept = 'SF' and ftDept <> 'SF';
020600200914 |           iter;
020700190508 |
020800200914 |         EndSl;
020900190508br02
021000190508
021100190508
021200171215
021300200914           s1FileTyp = ftFileTyp;
021400200914           s1PayVend = ftPayVend;
021500180924
021600200914           s1UserId = '';
021700200914           s1ActGrp = ftGroup;
021800200914           if ftDept = 'FI';
021900200914             s1ActGrp = %Subst(ftGroup : 1 : 3) + '-' +
022000200914               %Subst(ftGroup : 4 : 3) + '-' +
022100200914               %Subst(ftGroup : 7 : 4);
022200180919
022300180919
022400190509             if ftGroup > '' ;
022500200914               wTrst = %Dec( %Subst(ftGroup : 1 : 3) : 3: 0 );
022600200914               wSub  = %Dec( %Subst(ftGroup : 4 : 3) : 3: 0 );
022700200914               wAcct = %Dec( %Subst(ftGroup : 7 : 4) : 4: 0 );
022800190509             else;
022900200914               wTrst = 0;
023000200914               Wsub = 0;
023100200914               wAcct = 0;
023200190509             endif;
023300180921
023400180921
023500200914             aaUserId = '';
023600200914             Exec Sql
023700200914               Select eausrprf
023800200914                 Into :aauserid
023900200914                 From aacode
024000200914                      Join emailaddr
024100200914                        On Lower(aemla) = Lower(eaemail)
024200200914                 Where acode = (Select aacode
024300200914                       From "F.ACCMST"
024400200914                       Where actrst = :wtrst And
024500200914                             acsub# = :wsub And
024501200914                             acacct = :wacct);
024600180921
024700190509             s1UserId = aaUserId;
024800180921
024900190509           endif;
025000171215
025100200914           s1Name = ftName;
025200171211
025300190326
025400200914           // Set the Tool Tip ( Last Run Date )
025500200914           s1ToolTip = '';
025600200914           oKey = %subst(ftGroup:1:10);
025700200914           chain oKey gbs0028p;
025800200914           if %Found( gbs0028p ) and apLastDate > 0;
025900200914             s1ToolTip = 'Last run date: ' +
026000200914               %Char(%date( APLASTDATE : *iso) :*usa);
026100200914           EndIf;
026200190326
026300190326
026400200914           chain ftGroup gbs0035p;
026500200914           if %Found( gbs0035p ) and apLastDate > 0;
026600200914             s1ToolTip = 'Last run date: ' +
026700200914               %Char(%date( APLASTDATE : *iso) :*usa);
026800190509           EndIf;
026900190326
027000190326
027100190326
027200200914           s1Active = '-';
027300200914           if ftActive = 'Y';
027400200914             s1Active = 'Yes';
027500200914           endif;
027600171215
027700171215
027800200914
028300200914           s1FileType = '';
028400200914           if ftFileTyp = 'GBS' and ftDept = 'SF';
028500200914             s1FileType = 'GBS-SF';
028600200914           EndIf;
028700180719
028800200914           if ftFileTyp = 'GBS' and ftDept = 'FI';
028900200914             s1FileType = 'GBS-FI';
029000190509           EndIf;
029100180719
029200200914           if ftFileTyp = 'ADP';
029300200914             s1FileType = 'ADP';
029400200914           EndIf;
029500180719
029600180719
029700180921
029800200914           s1Proc = ftProc;
029900200914           s1FileSch = ftFileSch;
030000200914br01       s1JobName = JobSchName;
030100180612
033400180920
033500200914           Exsr CheckLine;
033600200914           if Cont = 'Y';
033700200914             rrn = rrn + 1;
033800200914             write LstSfl;
033900190509           EndIf;
034000180924
034100161223
034200161223
034300200914         enddo;
034400161005
034500161005
034600161005
034700161005
034800161222       Endsr;
034900161223
035000161223      *-------------------------------------------------------------------------
035100161223       Begsr LoadData;
035200161223
035300161223
035400190509         chain(n) s1Seq gbs0030P;
035500171211
035600190509         s2Seq = s1Seq;
035700171215
035800190509         s2Group = ftGroup;
035900190509         s2Name = ftName;
036000190509         s2Folder = ftFolder;
036100190509         s2Script = ftScript;
036200190509         s2Notes = ftNotes;
036300190509         s2Contact = ftContact;
036400190509         s2PayVend = ftPayVend;
036500180612
036600190509         s2RcdStat = '';
036700190509         if ftRcdSts = 'A';
036800190509           s2RcdStat = 'Active';
036900190509         EndIf;
037000190509         if ftRcdSts = 'D';
037100200914           s2RcdStat = 'Deleted';
037200200914         EndIf;
037300171215
037400171215
037500171215
037600190509         s2Activef = '-';
037700190509         if ftActive = 'Y';
037800190509           s2Activef = 'Yes';
037900190509         endif;
038000171215
038100190509         s2CreateLg = '';
038200190509         if ftCrtDt > 0;
038300200914           s2CreateLg = 'Record Created by ' + %Trim( ftCrtby ) + ' on ' +
038400200914             %Char(%date(ftCrtDt:*iso) :*usa) + ' at ' +
038500200914             %Char(%Time(ftCrtTm:*iso) :*usa);
038600190509         endif;
038700171215
038800171215
038900171215
039000190509         s2ChngLg = '';
039100190509         if ftChgDt > 0;
039200200914           s2ChngLg = 'Record Changed by ' + %Trim( ftChgby ) + ' on ' +
039300200914             %Char(%date(ftChgDt:*iso) :*usa) + ' at ' +
039400200914             %Char(%Time(ftChgTm:*iso) :*usa);
039500190509         endif;
039600171215
039700171215
039800190509         s2Procf = *Blanks;
039900190509         if ftProc = 'Testing';
040000200914           s2Procf = 'Yes';
040100200914         endif;
040200171215
040300190509         s2FileSch = ftFileSch;
040400190509         s2FileTyp = ftFileTyp;
040500190509br01     s2JobName = JobSchName;
040600180924
040700190509         s1UserId = '';
040800180924
040900200914         Exec Sql
041000200914           Select eausrprf
041100200914             Into :aauserid
041200200914             From aacode
041300200914                  Join emailaddr
041400200914                    On Lower(aemla) = Lower(eaemail)
041500200914             Where acode = (Select aacode
041600200914                   From "F.ACCMST"
041700200914                   Where actrst = :wtrst And
041800200914                         acsub# = :wsub And
041801200914                         acacct = :wacct);
041900180924
042000200914         s1UserId = aaUserId;
042100180924
042200180924
042300171215
042400161223
042500200914       Endsr;
042600180725
042700171215      *-------------------------------------------------------------------------
042800171215       Begsr $ViewRecord;
042900171215
043000171215
043100190509         exsr LoadData;
043200171215
043300190509         dou btnCancel = *on;
043400171215
043500190509           exfmt ViewScreen;
043600171215
043700190509         EndDo;
043800171215
043900171215
044000200914       EndSr;
044100161223
044200161223      *-------------------------------------------------------------------------
044300161223       Begsr ReadChanged;
044400161223
044500190509         Dou *in95 = *ON;
044600190509           READC LstSfl;
044700190509           *in95 = %EOF;
044800161223
044900190509           If *in95 = *OFF;
045000161223
045100190509             if runOption = 'viewGroup' or btnView = *on;
045200190509               exsr $ViewRecord;
045300190509             EndIf;
045400180322
045500180322
045600190509             if runOption = 'vNotes';
045700200914               exsr ViewNote;
045800200914             EndIf;
045900180322
046000200914             //      Removed 9/14/2020
046100200914             //      if runOption = 'ViewDtaFil' or btnRawData = *on;
046200200914             //        gbs0038c( s1FileType : s1Name );
046300200914             //
046400200914             //      EndIf;
046500200914             //
046600180820
046700190509             if runOption = 'FileDiff';
046800200914               oKey = %scanrpl('-':'':s1ActGrp);
046900190509               gbs0030R2(  oKey : s1FileType );
047000200914             EndIf;
047100180820
047200180820
047300190509             if runOption = 'PlnxRef';
047400190509               oKey = %scanrpl('-':'':s1ActGrp);
047500190509               gbs0044R(  oKey );
047600190509             EndIf;
047700180820
047701200914             if runOption = 'mnScanText';
047702200914               ScanFileC( s1Name: s1Folder );
047703200914             EndIf;
047704200914
047705200914
047706200914               if runOption = 'vwArchFile';
047707200914               oSearch = %Trimr( s1Folder );
047708200914               oSearch = %scanrpl('\':'/':oSearch);
047709200914               vwinbndc( oSearch );
047710200914             EndIf;
047711200914
047800180920
047900190509             if runOption = 'iSeriesCmp';
048000180920
048100190509               oKey = %scanrpl('-':'':s1ActGrp);
048200190509               gbs0039C( s1FileType : s1Name: oKey );
048300180920
048400190509             EndIf;
048500180920
048600180920
048700190509br03         if runOption = 'CntList';
048800190509               ShowCntList(s1PayVend );
048900190509             EndIf;
049000190509
049100190509
049200190509
049300190509
049400190509             btnRawData = *Off;
049500190509             btnView = *off;
049600190509             runOption = '';
049700190509             update LstSfl;
049800161223
049900190509             Reload = 'Y';
050000200914           endIf;
050100161223
050200161223
050300190509         enddo;
050400200914       Endsr;
050500171215
050600180322
050700180322       //-----------------------------------------------------------------
050800180322       //?                       View Notes
050900180322       //-----------------------------------------------------------------
051000180322       Begsr ViewNote;
051100180322
051200190509         Clear View_Note;
051300180322
051400190509         s3Seq  = s1Seq;
051500190509         s3Name = s1Name;
051600190509         oHtml  = *blanks;
051700180322
051800190509         Setll s3Seq gbs0030n;
051900190509         dou %Eof(gbs0030n);
052000190509           reade s3Seq gbs0030n;
052100180322
052200190509           if %eof(gbs0030n);
052300190509             leave;
052400200914           endif;
052500180322
052600190509           //?Load HTML Container
052700180322
052800190509           oHtml = %Trim(oHtml) + '<p><b>'+ onSumry + '</b><br/>';
052900190509           oHtml = %Trim(oHtml) +
053000190509             'Created by: ' + %Trim(onCrtBy) + ' on ' +
053100190509             %Char(%date(onCrtDt) :*usa) + ' at ' +
053200190509             %Char(%Time(onCrtTm) :*usa);
053300180322
053400200914           oHtml = %Trim(oHtml) + '<p style="margin-left: 40px">' +
053500200914             onNote + '</p><br/>';
053600180322
053700190509         enddo;
053800180322
053900180322
054000180322
054100190509         //?Display Screen
054200190509         Dou btnCancel = *on;
054300180322
054400190509           exfmt View_Note;
054500180322
054600190509           if btnCancel = *on;
054700190509             leave;
054800200914           endif;
054900180322
055000190509         Enddo;
055100180322
055200200914       Endsr;
055300180921
055400180921      *-------------------------------------------------------------------------
055500180921
055600180921       Begsr $Check_AA;
055700180921
055800190509         AA_Account = '';
055900180921
056000190509         //----------------------------------------------------
056100190509         //?Load the Subfile.
056200190509         //----------------------------------------------------
056300190509         Setll *loval GBS0030P;
056400190509         dou %Eof(GBS0030P);
056500190509           read(n) GBS0030P;
056600180921
056700190509           if %Eof(GBS0030P);
056800190509             leave;
056900200914           endif;
057000180921
057100180921
057200180924
057300190509           if ftDept = 'FI';
057400180921
057500190509             if ftGroup > '' ;
057600190509               wTrst = %Dec( %Subst(ftGroup : 1 : 3) : 3: 0 );
057700190509               wSub  = %Dec( %Subst(ftGroup : 4 : 3) : 3: 0 );
057800190509               wAcct = %Dec( %Subst(ftGroup : 7 : 4) : 4: 0 );
057900190509             else;
058000200914               wTrst = 0;
058100190509               Wsub = 0;
058200190509               wAcct = 0;
058300200914             endif;
058400180921
058500180921
058600200914             Exec Sql
058700200914               Select eausrprf
058800200914                 Into :aauserid
058900200914                 From aacode
059000200914                      Join emailaddr
059100200914                        On Lower(aemla) = Lower(eaemail)
059200200914                 Where acode = (Select aacode
059300200914                       From "F.ACCMST"
059400200914                       Where actrst = :wtrst And
059500200914                             acsub# = :wsub And
059501200914                             acacct = :wacct);
059600180924
059700200914             if aaUserId = wqUsrn;
059800200914               AA_Account = 'Y';
059900190509               leave;
060000200914             EndIf;
060100180924
060200190509           endif;
060300180921
060400180921
060500200914         enddo;
060600180921
060700180921
060800180921       EndSr;
060900180921
061000180924
061100180924       // ----------------------------------------------------------------
061200180924       Begsr CheckLine;
061300180924
061400190509         // Checking:
061500190509         //   If this is an AA User - see if they have the
061600190509         //   checkbox for all users.
061700180924
061800190509         Cont = 'N';
061900180924
062000180924
062100190509         // Normal Users - Not an Account Admin
062200190509         if AA_Account = '';
062300180924
062400190509           if chkShowAll = 'Y';
062500190509             Cont = 'Y';
062600200914           endif;
062700180924
062800190509           if chkShowAll = '' and ftRcdSts = 'A';
062900190509             Cont = 'Y';
063000200914           EndIf;
063100180924
063200190509         endif;
063300180924
063400180924
063500190509         // Account Admin User
063600190509         if AA_Account > '';
063700180924
063800190509           if ChkUsers = 'Y';
063900180924
064000190509             if chkShowAll = 'Y';
064100190509               Cont = 'Y';
064200200914             endif;
064300180924
064400190509             if chkShowAll = '' and ftRcdSts = 'A';
064500190509               Cont = 'Y';
064600200914             EndIf;
064700180924
064800190509           else;
064900180924
065000200914             if s1UserId  = wqUsrn;
065100180924
065200190509               if chkShowAll = 'Y';
065300190509                 Cont = 'Y';
065400200914               endif;
065500180924
065600190509               if chkShowAll = '' and ftRcdSts = 'A';
065700190509                 Cont = 'Y';
065800200914               EndIf;
065900180924
066000180924
066100190509             EndIf;
066200180924
066300180924
066400200914           endif;
066500200914         Endif;
066600180924
066700180924
066800180924       endSR;
066900190508
067000190508
067100190508       //-----------------------------------------------------------------
067200190508       //
067300190508       //                     Initialize Routine
067400190508       //
067500190508       //-----------------------------------------------------------------
067600190508br02   Dcl-Proc Init;
067700190508
067800190508
067900190508         Reload = 'Y';
068000190508
068100190508         Auth_Dept = '';
068200190508
068300190508
068400190508         // User have all Access?
068500190508         oFunction = 'DEPT-ALL';
068600190508         oDspErrMsg = 'N';
068700190508
068800190508         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
068900190508         if oContinue = 'Y';
069000190508           Auth_Dept = 'ALL';
069100190508         endif;
069200190508
069300190508
069400190508         // User have Fully Insurred?
069500190508         oFunction = 'DEPT-FI';
069600190508         oDspErrMsg = 'N';
069700190508
069800190508         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
069900190508         if oContinue = 'Y';
070000190508           Auth_Dept = 'FI';
070100190508         endif;
070200190508
070300190508
070400190508         // User have Self Funded?
070500190508         oFunction = 'DEPT-SF';
070600190508         oDspErrMsg = 'N';
070700190508
070800190508         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
070900190508         if oContinue = 'Y';
071000190508           Auth_Dept = 'SF';
071100190508         endif;
071200190508
071300190508
071400200914       End-Proc;
071500190508
071600190508
