000100190509     H option(*noDebugIo)  DftActGrp(*no)  bnddir('GBSBIND')
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400171215      *  Description: File Transfer Groups
000500161007      *  Programmer.: Brian Rees
000600171215      *  Date.......: 12/15/2017
000700160928      *
000800170322      *
000900160928      *-------------------------------------------------------------------------
001000160928      * Modifications
001100160928      *
001200190509      * Date         Programmer    Mod      Description
001300160928      *-------------------------------------------------------------------------
001400190322      * 03/22/2019   B.Rees        br01     Added Job Schedule Name
001500190508      * 05/08/2019   B.Rees        br02     Added Department / Function Check
001600190509      * 05/09/2019   B.Rees        br03     Added Contact List
001700190710      * 07/10/2019   b.Rees        br04
001800190710      *   New Fields: Inbound Folder and Append Date to File.
001900190710      *   Writing to the Job History Record.
002000190710      *   Create Folder on PC during ADD
002100190710      *   Right click on Menu option to Test/Proccess/ReRun File
002200190710      *
002300191113      * 11/13/2019   b.Rees        br05
002400191113      *   Added Account Window Prompt.
002500191122      * 11/22/2019   b.Rees
002600191122      *   Added Global Scape.
002700191125      * 11/25/2019   b.Rees        br06
002800191125      *   For Global Scape: Process/Test files on the i.
002900191202      * 12/02/2019   b.Rees        br07
003000191202      *   Added a hyperlink to the account inquiry
003100191203      * 12/03/2019   b.Rees        br07
003200191203      *   Added a Test Option
003300200121      * 01/21/2020   b.Rees        br08
003400200121      *   Added View Archive Files
003500200908      * 09/08/2020   B.Rees
003600200908      *   Set Autoload Demographics to "Y" when creating a new record.
003700200914      * 09/14/2020   B.Rees
003800200914      *   New Program Call: Scan text files.
003900200916      *
004000200916      * 09/17/2020 B.Rees   Added EASE Account Flag
004100201117      * 11/17/2020 B.Rees   Added Archive List
004200210111      * 01/11/2021 B.Rees   Hid GlobalScape from the Grid and
004300210111      *   added the Pending Count.
004400210322      * 03/22/2021 B.Rees   Added Method to upload a file.
004500210511      * 05/11/2021 B.Rees   Added the ability to clear the Data Area.
004600210512      * 05/12/2021 B.Rees   Added Stats
004700210822      * 08/22/2021 B.Rees   Added Hard Delete of Lines.
004800210826      * 08/26/2021 B.Rees   Added Omitted EASE Plans
004900210923      * 09/23/2021 B.Rees   Added the Enviroment. ( needed for Dev )
005000211020      * 10/20/2021 B.Rees   Including TIME on the Grid.
005100211021      * 10/21/2021 B.Rees   Added AutoLoad Options for the menu.
005200220413      * 12/09/2021 B.Rees   Changed the size of the email field.
005300220510      * 04/13/2022 J.Allen  Replaced brians email with guardianedi@amwins.com
005400220510      * 05/10/2022 J.Allen  Added if %found when removing added email  ns.com
005500220527      * 04/13/2022 J.Allen  Replaced guardianedi@amwins.com with payrolledi@amwins.com
005600220608      * 05/27/2022 J.Allen  Allow view of dataara only to all users
005700220629      * 06/08/2022 J.Allen  Added search on File Type to search list
005800221122      * 06/29/2022 J.Allen  Added Environment Logic
005900221122      * 11/22/2022 J.Allen  If record flagged as Deleted, turn off - D001
006000230323      * 11/22/2022 J.Allen  monitor for folder not found - D002
006100230323      * 03/23/2023 J.Allen  Add edi group to new account email
006200230421      * 03/23/2023 J.Allen  J001 - remove the 28p record on delete
006300230713      * 04/21/2023 J.Allen  J002 - increase oFolder from 30 - 40
006301230810      * 08/10/2023 RLJ      Chk for ACDLTD = 'C' instead of checking
006302230810      *                     for Term Date (ATRMDT) to set Deleted flag
006400220413      *------------------------------------------------m------------------------
006500180322
006600180323       dcl-f Gbs0030d Workstn
006700190508         HANDLER('PROFOUNDUI(HANDLER)')
006800210512         SFILE( LSTSFL   : rrn  )
006900210512         SFile( NoteSfl  : rrn2 )
007000210512         SFile( ArchSfl  : rrn3 )
007100210512         SFile( StatsSfl : rrn4 );
007200201117
007300180323
007400180322       dcl-f gbs0030p keyed
007500210822         usage( *input : *output : *update : *delete) ;
007600180322
007700180322       dcl-f gbs0030n keyed
007800190508         usage( *input : *output : *update ) ;
007900190326
008000190326
008100200113       dcl-f gbs0028p keyed
008200230323         usage( *input : *output : *update : *delete ) ;
008300200113
008400200113
008500190326       dcl-f gbs0035p keyed;
008600190710
008700190710       dcl-f jmsmstp  keyed usage( *output : *update )
008800190710         ExtDesc('JMS400L/JMSMSTP') ExtFile(*extdesc)
008900190710         rename( jmsmstp : rcd1 );
009000190710
009100190710       dcl-f jmsmste  keyed usage( *output : *update )
009200190710         ExtDesc('JMS400L/JMSMSTE') ExtFile(*extdesc);
009300190710
009400190711       dcl-f EmailAddr Keyed;
009500190711       dcl-f gbs0028e  keyed
009600190711         usage( *input : *output : *delete );
009700180322
009800200909       dcl-f AccMst keyed
009900200909          ExtDesc('F.ACCMST') ExtFile(*extdesc)  ;
010000210902
010100210902       dcl-f EaseEoi keyed usage(*Delete);
010200161005
010300160218      *--------------------------------------------------------------------
010400190509       dcl-ds pgmd
010500190509         ExtName('IOPGMD') PSDS;
010600190509         @pgmq *proc;
010700190509       end-ds;
010800190509
010900190509       dcl-s hasError ind;
011000190509       dcl-s reLoad Char(1);
011100190509       dcl-s rrn Zoned(5);
011200201117       dcl-s rrn3 Zoned(5);
011300210512       dcl-s rrn4 Zoned(5);
011400190509
011500190509       dcl-s nNextId Zoned(5);
011600180323
011700180323       dcl-s rrn2 Zoned(5);
011800180323       dcl-s @note_Seq Zoned( 9 ) ;
011900180326       dcl-s reloads2 char(1);
012000180920
012100180920       dcl-s wTrst Zoned(3);
012200180920       dcl-s wSub Zoned(3);
012300180920       dcl-s wAcct Zoned(4);
012400180920
012500180920       dcl-s PlanCnt Zoned(4);
012600180920       dcl-s BlankCnt Zoned(4);
012700190508br02   dcl-s Auth_Dept Char(5);
012800190710br04   dcl-s WriteJobRcd Char(1);
012900190710       dcl-s SavJobName Char(20);
013000190710       dcl-s AddedEmail Char(1);
013100190711       dcl-s myEmail Char(75);
013200180920
013300191113br05   dcl-s pAcct Char(12);
013400191113br05   dcl-s pAcctName Char(40);
013500200821
013600200821       dcl-s ok_Cont Char(1);
013700201117       dcl-c q '''';
013800210111       dcl-s Pending_Found Char(1);
013900210219       dcl-s TotalPend  Zoned(5);
014000210219
014100210219
014200210322       dcl-ds UploadFile Qualified  ;
014300210322         NumFiles Zoned(3);
014400210322         Directory Char(256);
014500210322         Files Char(256);
014600210322       End-Ds;
014700210322
014800210322       dcl-s myFileName Char(256) ;
014900210511       dcl-s FtProcess Char(40) dtaara;
015000210511
015100210512
015200210512       // Stats Calculations
015300210512       dcl-s Sts_TotalGrps Zoned(5);
015400210512       dcl-s Sts_TotalFi Zoned(5);
015500210512       dcl-s Sts_TotalSF Zoned(5);
015600210512       dcl-s Sts_TotalOth Zoned(5);
015700210512       dcl-s Sts_TotalEase Zoned(5);
015800210512
015900210512       dcl-s Sts_FType_ADPSF Zoned(5);
016000210512       dcl-s Sts_FType_GBSSF Zoned(5);
016100210512       dcl-s Sts_FType_Lum30 Zoned(5);
016200210512
016300210512       dcl-s Sts_FType_ADPFI Zoned(5);
016400210512       dcl-s Sts_FType_GBSFI Zoned(5);
016500210512       dcl-s Sts_FType_GBS20 Zoned(5);
016600210512       dcl-s Sts_FType_GBS30 Zoned(5);
016700210512
016800210923       Dcl-s Library Char(10);
016900220629       dcl-s Library2 Char(10);
017000220629
017100220629       dcl-ds OutEnvr  Qualified  ;
017200220629         e1Envir  Char(15);
017300220629         e1Libl   Char(10);
017400220629         e1Lib2   Char(10);
017500220629         envColor Char(10);
017600220629         e1Acnm   Char(40);
017700220629       End-Ds;
017800210512
017900161227      *--------------------------------------------
018000180917      *
018100161227      * Procedures
018200180917      *
018300161227      *--------------------------------------------
018400180917      /include *LIBL/QMODSRC,#COMMANDPR         // Command
018500190508br02  /include *LIBL/QMODSRC,#ChkFncAth         // Check Function Authority
018600190711br04  /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
018700220629      /Include *LIBL/QMODSRC,#GetEnvrPr         // Get Environment
018800190509
018900180612       dcl-pr gbs0028c ExtPgm('GBS0028C')  end-Pr;
019000180612       dcl-pr gbs0035r ExtPgm('GBS0035R')  end-Pr;
019100180426
019200201117       // Removed 9/14/2020
019300200914       //dcl-pr gbs0038C ExtPgm('GBS0038C');
019400200914       //  oType Char(10);
019500200914       //  oName Char(40);
019600200914       //end-Pr;
019700180823
019800180823
019900180823       dcl-pr gbs0030R2 ExtPgm('GBS0030R2');
020000190508         oKey Char(10);
020100190508         oFileType Char(3);
020200201201         oEaseType Char(10);
020300180920       end-Pr;
020400180823       dcl-s oKey Char(10);
020500201201       dcl-s oEaseType Char(10);
020600180426
020700180917
020800180920       dcl-pr gbs0044R  ExtPgm('GBS0044R');
020900190508         oKey Char(10);
021000180920       end-Pr;
021100180920
021200211021
021300220218       dcl-pr alMenu  ExtPgm('ALMENUR');
021400211021         oKey Char(10);
021500211021       end-Pr;
021600180920
021700180920       // iSeries Compare
021800180920       dcl-pr gbs0039C ExtPgm('GBS0039C');
021900190508         oType Char(10);
022000190508         oName Char(40);
022100190508         oKey  Char(10);
022200180920       end-Pr;
022300180920
022400190509br03   // Show Contact List
022500190509       dcl-pr ShowCntList ExtPgm('GBS0030R3');
022600190509         oVend Char(10);
022700190509       end-Pr;
022800190509
022900190710
023000190710br04   // Create PC Folder
023100190710       dcl-pr GBS0030C1 ExtPgm('GBS0030C1');
023200190710         oC_Seq Char(5);
023300190710       end-Pr;
023400190710       dcl-s oC_Seq Char(5);
023500180917
023600190710
023700190710br04   // Test FI File
023800190710       dcl-pr GBS0030C2 ExtPgm('GBS0030C2');
023900190710         oC_Seq Char(5);
024000190710       end-Pr;
024100190710
024200191125
024300191125br06   // GlobalScape: Test FI File
024400191125       dcl-pr FT_I003C ExtPgm('FT_I003C');
024500230713         oFolder Char(40);
024600191125       end-Pr;
024700230713       dcl-s oFolder Char(40);
024800191125
024900191125br06   // GlobalScape: Process FI File
025000191125       dcl-pr FT_I004C ExtPgm('FT_I004C');
025100191127         oSeq Packed(5);
025200220124         oEmail Char(60);
025300191125       end-Pr;
025400191127       dcl-s oSeq Packed(5);
025500191125
025600191125
025700190710br04   // Process FI File
025800190710       dcl-pr GBS0030C3 ExtPgm('GBS0030C3');
025900190710         oC_Seq Char(5);
026000190710       end-Pr;
026100190710
026200191113
026300191113       dcl-pr wn0011r ExtPgm('WN0011R');
026400191113         oAcct Char(12);
026500191113         oAcctName Char(40);
026600191113       end-Pr;
026700191202
026800191202br07   dcl-pr AccountInq ExtPgm('INQ008R');
026900191202         oTrst Zoned(3);
027000191202         oSub# Zoned(3);
027100191202         oAcct Zoned(4);
027200191202       End-Pr;
027300191202
027400191203br07   dcl-pr TestFile ExtPgm('FT_I005R') End-Pr;
027500191203
027600200121
027700200121br08   // View Archive Files.
027800200121       dcl-pr VWINBNDC ExtPgm('VWINBNDC');
027900200121         oSearch Char(20);
028000200121       end-Pr;
028100200121       dcl-s oSearch Char(20);
028200200121
028300200914
028400200914       // Scan Text Files.
028500200914       dcl-pr SCANFILEC ExtPgm('SCANFILEC');
028600200914         oCompName Char(40);
028700200914         oStaging Char(40);
028800200914       end-Pr;
028900200121
029000201117       dcl-pr vwcarftpc1 ExtPgm('VWCARFTPC1') ;
029100201117         FolderName Char(150);
029200201117       end-pr;
029300201117       dcl-s FolderName Char(150);
029400201117
029500201117       dcl-pr vwcarftpc2 ExtPgm('VWCARFTPC2') ;
029600201117         FolderName Char(150);
029700201117         FileDate   Char(26);
029800201117         FileSize   Char(10);
029900201117       end-pr;
030000201117       dcl-s FileDate   Char(26);
030100201117       dcl-s kb_Text Char(10);
030200201117
030300210219       dcl-pr GBS0028R1 extPgm('GBS0028R1');
030400210219         iKey Char(10);
030500210219         iCompName Char(40);
030600210219       End-Pr;
030700210219       dcl-s iKey Char(10);
030800210219
030900210219
031000210219       dcl-pr GBS0035R1 extPgm('GBS0035R1');
031100210219         iGroup Char(20);
031200210219         iCompName Char(40);
031300210219       End-Pr;
031400210219
031500210826       dcl-pr GBS0076R  extPgm('GBS0076R') End-Pr ;
031600210512
031700201117
031800180920      *-----------------------------------------------------------------------
031900180917      *
032000160928      *?Mainline Program
032100180917      *
032200180920      *-----------------------------------------------------------------------
032300220320       Exec Sql
032400220320         Set Option Commit = *None, Naming = *Sys;
032500190508
032600190508       init();
032700220629       Get_Env();
032800190508
032900161223       dou btnExit = *on;
033000160928
033100201117         exsr ClearS1;
033200201117         exsr LoadS1;
033300160928
033400180817
033500190508         // mnChoice =
033600190508         //  '<img src="/profoundui/userdata/Images2/notebook_edit.png">' +
033700190508         //  ' Work with Notes' +
033800190508         //  ',<img src="/profoundui/userdata/Images2/preview.png">' +
033900190508         //  ' View Notes' +
034000190508         //  ',View Raw Data File';
034100180817
034200190508         // mnValues = 'wNotes,vNotes,ViewDtaFil';
034300180817
034400190508         // if ftDept = 'FI';
034500190508         //   mnChoice = %Trim(mnChoice) + ',List Input File Diff';
034600190508         //   mnValues = %Trim(mnValues) + ',FileDiff';
034700190508         // endif;
034800180817
034900180817
035000210511         in ftProcess;
035100210511         s1DtaAra = ftProcess;
035200210511
035300210511
035400190508         exsr DisplyS1;
035500160928
035600190711         // Remove Test Email ( If added during the last READC ).
035700190711         if AddedEmail = 'Y';
035800190711           chain ( oKey : 'T'  : myEmail) gbs0028e;
035900220510           if %Found( gbs0028e );
036000190711           Delete gbs0028e;
036100190711           AddedEmail = '';
036200220510         EndIf;
036300190711         EndIf;
036400190711
036500190711
036600190711         if btnExit = *on;
036700190711           leave;
036800190711         endif;
036900190711
037000161223
037100190508         Select;
037200161223
037300210111         when btnRefresh = *on;
037400210322           iter;
037500210111
037600210512         when ViewStats = *on;
037700210512           Screen4();
037800210512           iter;
037900210512
038000210512
038100210511         when ClrDtaAra = *on;
038200210511           in *lock ftProcess;
038300210511           ftProcess = '';
038400210511           out ftProcess;
038500210511           clrDtaAra = *off;
038600210511
038700210511           iter;
038800210511
038900190711         When ChgShowAll = *on;
039000180612
039100191203         When btnTstFile = *on;
039200191203           TestFile();
039300191203
039400190711         when btn_FIList = *on;
039500190711           gbs0028c();
039600180426
039700190711         when btn_SFList = *on;
039800190711           gbs0035r();
039900180426
040000190711         when  btnAddNew = *on;
040100190508           Clear AddScreen;
040200190508           ReLoad = 'Y';
040300190711           exsr $AddRecord;
040400161223
040500190711         other;
040600190711           exsr ReadChanged;
040700161223
040800190711         endsl;
040900161223
041000180920       enddo;
041100160928
041200161223       *inlr = *on;
041300160928
041400180920      *-----------------------------------------------------------------------
041500161222       Begsr ClearS1;
041600160928
041700190711         //?Clear the Subfile
041800190711         ClrSfl = *on;
041900190711         Write LstCtl;
042000190711         ClrSfl = *off;
042100160928
042200190711         rrn = 0;
042300160928
042400180920       Endsr;
042500180920      **-----------------------------------------------------------------------
042600161222       Begsr DisplyS1;
042700160928
042800190711         DspSfl = *on  ;
042900190711         exfmt  LstCtl ;
043000190711         DspSfl = *off;
043100160928
043200160928       Endsr;
043300180920      *-----------------------------------------------------------------------
043400161222       Begsr LoadS1;
043500161005
043600210322         TotalPend = 0;
043700210512         ClearStats();
043800210512
043900190711         //----------------------------------------------------
044000190711         //?Load the Subfile.
044100190711         //----------------------------------------------------
044200190711         Setll *loval GBS0030P;
044300190711         dou %Eof(GBS0030P);
044400190711           read(n) GBS0030P;
044500161005
044600190508           if %Eof(GBS0030P);
044700190711             leave;
044800190711           endif;
044900161222
045000171215
045100220621           s1Seq = ftSeq#;
045200220621           s1Folder = ftfolder;
045300171215
045400220320           Exec Sql
045500220320             Select Count(*)
045600220320               Into :s1notes
045700220320               From gbs0030n
045800220320               Where onftseq = :s1seq;
045900180326
046000190711           LineColor = '';
046100190508           if ftRcdSts = 'D';
046200190711             LineColor = 'RED';
046300190711           EndIf;
046400180612
046500210111           s1GblScape = ftGblScape;
046600210111br08       s1Folder = ftFolder;
046700210111
046800210111           if ftRcdSts <> 'D' and FTGBLSCAPE = 'Y';
046900210111             Pending_Count();
047000210219             TotalPend = s1Pending + TotalPend;
047100210111           EndIf;
047200210111
047300210111
047400210111
047500210111
047600190711           Select;
047700190508           When Ftdept = 'FI';
047800190711             s1Dept = 'Fully Insured';
047900190508           When ftDept = 'SF';
048000190711             s1Dept = 'Self Funded';
048100190508           When ftDept = 'OTH';
048200190711             s1Dept = 'Other';
048300190711           endsl;
048400171215
048500190508
048600190711br02       // Check the Authorized Department
048700190711 |         Select;
048800190508 |         when Auth_Dept = 'FI' and ftDept <> 'FI';
048900190711 |           iter;
049000190508 |
049100190508 |         When Auth_Dept = '';
049200190711 |           iter;
049300190508 |
049400190508 |         when Auth_Dept = 'SF' and ftDept <> 'SF';
049500190711 |           iter;
049600190508 |
049700190711 |         EndSl;
049800190508br02
049900190508
050000190711           s1FileTyp = ftFileTyp;
050100190711           s1PayVend = ftPayVend;
050200180315
050300190711           s1ActGrp = ftGroup;
050400190711           s1aaName = '';
050500200121
050600200916           s1Ease = ftEase;
050700201021           s1EnrlType = ftEnrlTyp;
050800200916
050900200916
051000190711           // Set the Tool Tip ( Last Run Date )
051100190711           s1ToolTip = '';
051200190711           oKey = %subst(ftGroup:1:10);
051300200130           chain(n) oKey gbs0028p;
051400190508           if %Found( gbs0028p ) and apLastDate > 0;
051500190711             s1ToolTip = 'Last run date: ' +
051600190711               %Char(%date( APLASTDATE : *iso) :*usa);
051700190711           EndIf;
051800190326
051900190326
052000200330           chain ftGroup gbs0035p;
052100190508           if %Found( gbs0035p ) and apLastDate > 0;
052200190711             s1ToolTip = 'Last run date: ' +
052300190711               %Char(%date( APLASTDATE : *iso) :*usa);
052400190711           EndIf;
052500190326
052600190326
052700190326
052800190326
052900201117           s1Termed = '';
053000180920
053100190508           if ftDept = 'FI';
053200190711             s1ActGrp = %Subst(ftGroup : 1 : 3) + '-' +
053300190711               %Subst(ftGroup : 4 : 3) + '-' +
053400190711               %Subst(ftGroup : 7 : 4);
053500180920
053600190508             if ftGroup > '' ;
053700190711               wTrst = %Dec( %Subst(ftGroup : 1 : 3) : 3: 0 );
053800190711               wSub  = %Dec( %Subst(ftGroup : 4 : 3) : 3: 0 );
053900190711               wAcct = %Dec( %Subst(ftGroup : 7 : 4) : 4: 0 );
054000180920
054100180920
054200220320               Exec Sql
054300220320                 Select Trim(afnam) || ' ' || Trim(alnam)
054400220320                   Into :s1aaname
054500220320                   From aacode
054600220320                   Where acode = (Select aacode
054700220320                         From "F.ACCMST"
054800220320                         Where actrst = :wtrst And
054900220320                               acsub# = :wsub And
055000220320                               acacct = :wacct);
055100180920
055200201117               chain (wtrst : wsub : wAcct ) AccMst;
055300201117               if %Found( AccMSt ) ;
055400230810                 //  if ATRMDT > 0 and ATRMDT  < %Dec(%Date);
055401230810                 if ACDLTD = 'C';
055500200909                   s1Termed = 'Y';
055600200909                 EndIf;
055700201117               EndIf;
055800200909
055900190508             else;
056000190711               wTrst = 0;
056100190711               Wsub = 0;
056200190711               wAcct = 0;
056300190711             endif;
056400190711           endif;
056500171215
056600190711           s1Name = ftName;
056700171211
056800190711           s1Active = '-';
056900190508           if ftActive = 'Y';
057000190711             s1Active = 'Yes';
057100190711           endif;
057200171215
057300171215
057400171215
057500190711           s1FileType = '';
057600190508           if ftFileTyp = 'GBS' and ftDept = 'SF';
057700190711             s1FileType = 'GBS-SF';
057800190711           EndIf;
057900180719
058000190508           if ftFileTyp = 'GBS' and ftDept = 'FI';
058100190711             s1FileType = 'GBS-FI';
058200190711           EndIf;
058300180719
058400201110           if ftFileTyp = 'GBS20' and ftDept = 'FI';
058500201110             s1FileType = 'GBS20-FI';
058600201110           EndIf;
058700201110
058800190508           if ftFileTyp = 'ADP';
058900190711             s1FileType = 'ADP';
059000190711           EndIf;
059100180719
059200180719
059300190711           s1Proc = ftProc;
059400190711br01       s1JobName = JobSchName;
059500180920
059600200811           s1FileSch = '';
059700200811           if JobSchName > '';
059800200811             chain(n) jobSchName JmsMstp;
059900200811             if %Found( JmsMstp ) ;
060000200811
060100200811               if jmMon = 'Y';
060200201117                 s1FileSch = %Trim(s1FileSch) + 'M';
060300200811               else;
060400201117                 s1FileSch = %Trim(s1FileSch) + '_';
060500200811               endif;
060600200811
060700200811               if jmTue = 'Y';
060800201117                 s1FileSch = %Trim(s1FileSch) + ' T';
060900200811               else;
061000201117                 s1FileSch = %Trim(s1FileSch) + ' _';
061100200811               endif;
061200200811
061300200811               if jmWed = 'Y';
061400201117                 s1FileSch = %Trim(s1FileSch) + ' W';
061500200811               else;
061600201117                 s1FileSch = %Trim(s1FileSch) + ' _';
061700200811               endif;
061800200811
061900200811               if jmThu = 'Y';
062000201117                 s1FileSch = %Trim(s1FileSch) + ' T';
062100200811               else;
062200201117                 s1FileSch = %Trim(s1FileSch) + ' _';
062300200811               endif;
062400200811
062500200811               if jmFri = 'Y';
062600201117                 s1FileSch = %Trim(s1FileSch) + ' F';
062700200811               else;
062800201117                 s1FileSch = %Trim(s1FileSch) + ' _';
062900200811               endif;
063000200811
063100200811               if jmSat = 'Y';
063200201117                 s1FileSch = %Trim(s1FileSch) + ' S';
063300200811               else;
063400201117                 s1FileSch = %Trim(s1FileSch) + ' _';
063500200811               endif;
063600200811
063700200811               if jmSun = 'Y';
063800201117                 s1FileSch = %Trim(s1FileSch) + ' S';
063900200811               else;
064000201117                 s1FileSch = %Trim(s1FileSch) + ' _';
064100200811               endif;
064200200811
064300200811
064400200811             EndIf;
064500200811           EndIf;
064600200811
064700210512           Calc_Stats();
064800210512
064900210512
065000200821           exsr $CheckCont;
065100200821           if ok_Cont = 'N';
065200200821             iter;
065300200821           EndIf;
065400200821
065500180612
065600190508           if chkShowAll = 'Y';
065700221123           checks3();
065800190711             rrn = rrn + 1;
065900190711             write LstSfl;
066000190711           endif;
066100180612
066200190508           if chkShowAll = '' and ftRcdSts = 'A';
066300221123           checks3();
066400190711             rrn = rrn + 1;
066500190711             write LstSfl;
066600190711           EndIf;
066700161223
066800161223
066900190711         enddo;
067000161005
067100210219         s1PendMsg = '';
067200210219         if TotalPend > 0;
067300210322           s1PendMsg = 'Pending: ' + %char(TotalPend);
067400210219         endif;
067500161005
067600180920       Endsr;
067700161223
067800200821
067900200821      *-------------------------------------------------------------------------
068000200821       Begsr $CheckCont;
068100200821
068200201117         ok_Cont = 'N';
068300200821
068400200821         if s1Search = '';
068500201117           ok_Cont = 'Y';
068600201117           leaveSr;
068700200821         EndIf;
068800200821
068900200821
069000201117         if %scan( %Trim(s1Search) : ucase(s1ActGrp)) >  0 or
069100201117            %scan( %Trim(s1Search) : ucase(s1Dept)) >  0 or
069200201117            %scan( %Trim(s1Search) : ucase(s1Name)) >  0 or
069300220608            %scan( %Trim(s1Search) : ucase(s1PayVend)) >  0 or
069400220608            %scan( %Trim(s1Search) : ucase(s1FileTyp)) >  0 or
069500201117            %scan( %Trim(s1Search) : ucase(s1Active)) >  0  or
069600201117            %scan( %Trim(s1Search) : ucase(s1JobName)) >  0   ;
069700200821
069800201117           ok_Cont = 'Y';
069900200821
070000201117         EndIf;
070100200821
070200200821       EndSr;
070300200821
070400161223      *-------------------------------------------------------------------------
070500190711       Begsr $AddRecord;
070600161223
070700201218         s2RcdSts = 'A';
070800201218
070900190711         dou btnCancel = *on;
071000161223
071100190508           exfmt AddScreen;
071200191113
071300191113           // Search for an account by Name.
071400191113br05       if btnSearch = *on;
071500191113             pAcct = '';
071600191113             pAcctName = '';
071700191113             wn0011r( pAcct : pAcctName ) ;
071800191113             if pAcct > '';
071900191113               s2Group = %ScanRpl('-' : '' : pAcct ) ;
072000191113               s2Name = pAcctName;
072100191113             EndIf;
072200191113             iter;
072300191113           EndIf;
072400191113
072500191113
072600191113
072700190508           exsr Validate;
072800190711           if hasError = *on;
072900190711             iter;
073000190508           EndIf;
073100161223
073200190711           if btnAccept = *on;
073300161223
073400220320             Exec Sql
073500220320               Select Max(ftseq#)
073600220320                 Into :nnextid
073700220320                 From gbs0030p;
073800171215
073900190508             ftSeq# = ftSeq# + 5;
074000200330             ftGroup = %ScanRpl('-':'':s2Group);
074100190508             ftDept = s2Dept;
074200190508             ftName = s2Name;
074300190508             ftActive = s2Active;
074400190508             ftFolder = s2Folder;
074500190508             ftNotes = s2Notes;
074600190508             ftContact = s2Contact;
074700190508             ftProc    = s2Proc;
074800190508             ftFileTyp = s2FileTyp;
074900190508             ftPayVend = s2PayVend;
075000190508             ftLocTsa  = s2LocTsa;
075100190710br01         JobSchName = s2JobName;
075200190710br04         ftInFldr = s2infldr;
075300191125br04         ftApndDate = s2ApndDate;
075400200916             ftGblScape = s2GblScape;
075500201021             ftEnrlTyp  = s2EnrlType;
075600200916             ftEase = s2Ease;
075700200916
075800190508             ftRcdSts = 'A';
075900190508             ftCrtBy = wqUsrn;
076000190508             ftCrtDt = %Dec(%Date);
076100190508             ftCrtTm = %Dec(%Time);
076200171215
076300190508             ftChgBy = '';
076400190508             ftChgDt = 0;
076500190508             ftChgTm = 0;
076600171215
076700171215
076800190508             write r_gbs0030;
076900180914
077000180914
077100200113             // Write to the Processing File.
077200200113             if s2Dept = 'FI';
077300200113               apKey = ftGroup;
077400200113               apFileType = ftFileTyp;
077500200113               apCompName = ftName;
077600200908               APRUNAUTO = 'Y';
077700200113               write r_Gbs0028;
077800200113             endif;
077900200113
078000200113
078100190711             if s2Dept = 'FI' and ftGroup <> '8880010005';
078200190711               SendEmail();
078300190508             EndIf;
078400190710
078500190710
078600190710
078700190710             // Write to the Job Schedule
078800190711             if s2JobName > '';
078900190710               jeJobN = s2JobName;
079000191125               jeAuto = 'Y';
079100190710               write jmsmste_r;
079200190710
079300201117               // Load Job Master Fields
079400201117               jmJobN = s2JobName;
079500201117               jmMon = s2Mon;
079600201117               jmTue = s2Tue;
079700201117               jmWed = s2Wed;
079800201117               jmThu = s2Thu;
079900201117               jmFri = s2Fri;
080000201117               jmSat = s2Sat;
080100201117               jmSun = s2Sun;
080200200811
080300201117               jmHour = s2Hour;
080400201117               jmampm = 'AM';
080500201117               if s2Hour >= 1200;
080600201117                 jmampm = 'PM';
080700201117               EndIf;
080800200811
080900200811
081000201117               jmonof = s2Active;
081100190710
081200190711               write rcd1;
081300190710
081400190710             EndIf;
081500190710
081600190710
081700190710             // Create PC Folders.
081800200113             //      oC_Seq = %Char(ftSeq#);
081900200113             //      GBS0030C1( oC_Seq );
082000200113             //
082100180914
082200190711             leave;
082300161223
082400190711           EndIf;
082500161223
082600161223
082700190711         EndDo;
082800161223
082900161223
083000180920       EndSr;
083100161223
083200161223      *-------------------------------------------------------------------------
083300180920       Begsr LoadData;
083400161223
083500190711         Clear EditScreen;
083600161223
083700190711         chain(n) s1Seq gbs0030P;
083800171211
083900190711         s2Seq = s1Seq;
084000171215
084100190711         s2Group = ftGroup;
084200190711         s2Dept = ftDept;
084300190711         s2Name = ftName;
084400190711         s2Active = ftActive;
084500190711         s2Folder = ftFolder;
084600190711         s2Notes = ftNotes;
084700190711         s2Contact = ftContact;
084800190711         s2PayVend = ftPayVend;
084900190711         s2RcdSts = ftRcdSts;
085000190711br04     s2InFldr = ftinfldr;
085100190711br04     s2ApndDate = ftApndDate;
085200201021         s2GblScape = ftGblScape;
085300201021         s2EnrlType = ftEnrlTyp;
085400200916         s2Ease = ftEase;
085500180612
085600210902
085700210902
085800201117         //  s2RcdStat = '';
085900201117         //  if ftRcdSts = 'A';
086000201117         //    s2RcdStat = 'Active';
086100201117         //  EndIf;
086200201117         //  if ftRcdSts = 'D';
086300201117         //    s2RcdStat = 'Deleted';
086400201117         //  EndIf;
086500201117         //
086600201117         //
086700201117         //  Select;
086800201117         //  When s2Dept = 'FI';
086900201117         //    s2DeptName = 'Fully Insured';
087000201117         //  When s2Dept = 'SF';
087100201117         //    s2DeptName = 'Self Funded';
087200201117         //  When s2Dept = 'OTH';
087300201117         //    s2DeptName = 'Other';
087400201117         //  endsl;
087500171215
087600171215
087700190711         s2CreateLg = '';
087800190711         if ftCrtDt > 0;
087900190711           s2CreateLg = 'Record Created by ' + %Trim( ftCrtby ) + ' on ' +
088000190711             %Char(%date(ftCrtDt:*iso) :*usa) + ' at ' +
088100190711             %Char(%Time(ftCrtTm:*iso) :*usa);
088200190711         endif;
088300171215
088400171215
088500171215
088600190711         s2ChngLg = '';
088700190711         if ftChgDt > 0;
088800190711           s2ChngLg = 'Record Changed by ' + %Trim( ftChgby ) + ' on ' +
088900190711             %Char(%date(ftChgDt:*iso) :*usa) + ' at ' +
089000190711             %Char(%Time(ftChgTm:*iso) :*usa);
089100190711         endif;
089200171215
089300171215
089400201117         //  s2Procf = ftProc;
089500190711         s2Proc  = ftProc;
089600171215
089700190711         s2FileTyp = ftFileTyp;
089800190711         s2LocTsa  = ftLocTsa;
089900190711br01     s2JobName = JobSchName;
090000190322
090100161223
090200200811         // Get Job Schedule
090300200811         if JobSchName > '';
090400200811
090500201117           chain JobSchName JmsMstp;
090600201117           if %Found( JmsMstp ) ;
090700201117             s2Mon = jmMon;
090800201117             s2Tue = jmTue;
090900201117             s2Wed = jmWed;
091000201117             s2Thu = jmThu;
091100201117             s2Fri = jmFri;
091200201117             s2Sat = jmSat;
091300201117             s2Sun = jmSun;
091400200811
091500201117             s2Dom1 = jmDom1;
091600201117             s2Hour = jmhour;
091700200811
091800201117           EndIf;
091900200811
092000200811
092100200811         EndIf;
092200200811
092300200811
092400200811
092500180920       Endsr;
092600161223      *-------------------------------------------------------------------------
092700190711       Begsr $EditRecord;
092800161223
092900161223
093000190508         exsr LoadData;
093100161223
093200190711         dou btnCancel = *on;
093300161223
093400190508           exfmt EditScreen;
093500161223
093600190711           if btnAccept = *on;
093700190508             chain s2Seq gbs0030P;
093800171215
093900190711             if %Found( gbs0030p ) ;
094000190710
094100190710               WriteJobRcd = '';
094200190711               if chgJobName = *on and JobSchName = '';
094300190711                 WriteJobRcd = 'Y';
094400190711               else;
094500190710                 savJobName = JobSchName;
094600190711                 WriteJobRcd = 'C';
094700190710               EndIf;
094800171215
094900190508               ftGroup = s2Group;
095000190508               ftDept = s2Dept;
095100190508               ftName = s2Name;
095200190508               ftActive = s2Active;
095300190508               ftFolder = s2Folder;
095400190508               ftNotes = s2Notes;
095500190508               ftContact = s2Contact;
095600190508               ftProc    = s2Proc;
095700190508br01           JobSchName = s2JobName;
095800190710br04           ftInFldr = s2infldr;
095900190710br04           ftApndDate = s2ApndDate;
096000201021               ftGblScape = s2GblScape;
096100200916               ftEase = s2Ease;
096200201021               ftEnrlTyp = s2EnrlType;
096300200916
096400190508               ftFileTyp = s2FileTyp;
096500190508               ftPayVend = s2PayVend;
096600190508               ftLocTsa  = s2LocTsa;
096700171215
096800221122             // D001 - if deleted, turn off all.
096900190508               ftRcdSts = s2RcdSts;
097000221122               if ftRcdSts = 'D';
097100221122               ftActive = 'N';
097200221122               ftProc   = ' ';
097300221122               endif;
097400180612
097500190508               ftChgBy = wqUsrn;
097600190508               ftChgDt = %Dec(%Date);
097700190508               ftChgTm = %Dec(%Time);
097800171215
097900190508               update r_gbs0030;
098000190710
098100190710
098200190710
098300200113               // Update the Processing File.
098400200113               if s2Dept = 'FI';
098500200113                 okey = %Trim( ftGroup ) ;
098600200113                 chain oKey GBS0028P;
098700200113                 if %Found( GBS0028P ) ;
098800200113                   apFileType = ftFileTyp;
098900200113                   update r_Gbs0028;
099000200113                 endif;
099100200113               endif;
099200200113
099300200113
099400200811
099500200811
099600190711               if writeJobRcd = 'Y';
099700190710
099800190710                 // Write to the Job Schedule
099900190710                 jeJobN = s2JobName;
100000190710                 jeAuto = 'Y';
100100190710                 write jmsmste_r;
100200190710
100300200811                 // Write to the Job Master.
100400201117                 // Load Job Master Fields
100500200811                 jmJobN = s2JobName;
100600200811                 jmMon = s2Mon;
100700200811                 jmTue = s2Tue;
100800200811                 jmWed = s2Wed;
100900200811                 jmThu = s2Thu;
101000200811                 jmFri = s2Fri;
101100200811                 jmSat = s2Sat;
101200200811                 jmSun = s2Sun;
101300200811
101400200811                 jmHour = s2Hour;
101500200811                 jmampm = 'AM';
101600200811                 if s2Hour >= 1200;
101700200811                   jmampm = 'PM';
101800200811                 EndIf;
101900200811
102000200811
102100200811                 jmonof = s2Active;
102200190711                 write rcd1;
102300190710
102400190710               endif;
102500190710
102600190710
102700190710
102800190711               if writeJobRcd = 'C';
102900190710
103000190710                 // Update the Job Schedule
103100190710
103200190710                 chain savJobName jmsmste;
103300190711                 if %found( JmsMste );
103400190710                   jeJobn = s2JobName;
103500190711                   update jmsmste_r;
103600190710                 EndIf;
103700190710
103800190710                 chain savJobName jmsmstp;
103900190711                 if %found( jmsmstp );
104000190710                   jmJobn = s2JobName;
104100201117                   jmJobN = s2JobName;
104200201117                   jmMon = s2Mon;
104300201117                   jmTue = s2Tue;
104400201117                   jmWed = s2Wed;
104500201117                   jmThu = s2Thu;
104600201117                   jmFri = s2Fri;
104700201117                   jmSat = s2Sat;
104800201117                   jmSun = s2Sun;
104900200811
105000201117                   jmHour = s2Hour;
105100201117                   jmampm = 'AM';
105200201117                   if s2Hour >= 1200;
105300201117                     jmampm = 'PM';
105400201117                   EndIf;
105500200811
105600200811
105700201117                   jmonof = s2Active;
105800190711                   update Rcd1;
105900190711                 EndIf;
106000190710
106100190711               endif;
106200190710
106300190710
106400190710
106500190710
106600190710             endif;
106700190711             leave;
106800161223
106900190711           EndIf;
107000161223
107100161223
107200190711         EndDo;
107300161223
107400161223
107500190710       EndSr;
107600171215      *-------------------------------------------------------------------------
107700190711       Begsr $ViewRecord;
107800171215
107900171215
108000190710         exsr LoadData;
108100171215
108200190711         dou btnCancel = *on;
108300171215
108400190711           exfmt ViewScreen;
108500171215
108600190711         EndDo;
108700171215
108800171215
108900190710       EndSr;
109000161007      *-------------------------------------------------------------------------
109100161007       Begsr Validate;
109200161007
109300190711         hasError = *off;
109400161223
109500161007       endsr;
109600161223
109700161223      *-------------------------------------------------------------------------
109800190711       Begsr ReadChanged;
109900161223
110000190711         Dou *in95 = *ON;
110100190710           READC LstSfl;
110200190710           *in95 = %EOF;
110300161223
110400190711           If *in95 = *OFF;
110500161223
110600190711             if runOption = 'viewGroup' or btnView = *on;
110700190711               exsr $ViewRecord;
110800190710             EndIf;
110900180322
111000190711             if runOption = 'editGroup' or btnEdit = *on;
111100190711               exsr $EditRecord;
111200190710             endIf;
111300161223
111400190711             if runOption = 'delGroup' or btnDelete = *on;
111500190711               exsr $DelRecord;
111600190710             endIf;
111700171215
111800190711             if runOption = 'wNotes';
111900190711               exsr Screen_2;
112000190710             EndIf;
112100210322
112200210826             if runOption = 'mnOmitEase';
112300210902               Gbs0076R();
112400210826             EndIf;
112500210826
112600210826
112700210322             if runOption = 'mnFileUpl';
112800210322               chain(n) s1Seq gbs0030p;
112900210322
113000210322               TargetDir = '/Carrier_Inbound/' + ftFolder;
113100210322               TargetDir = %ScanRpl('\':'/':TargetDir);
113200210322
113300210322               dou btnCancel = *on;
113400210322                 exfmt UploadScr;
113500210322
113600210322                 if btnCancel = *on;
113700210322                   btnCancel = *off;
113800210322                   leave;
113900210322                 EndIf;
114000210322
114100210322                 if btnAccept = *on;
114200210322                   myFileName = UploadFile.Files;
114300210322                   leave;
114400210322                 endif;
114500210322
114600210322               EndDo;
114700210322
114800210322             EndIf;
114900161223
115000210512
115100200121br08         if runOption = 'vwArchFile';
115200200121               oSearch = %Trimr( s1Folder );
115300200121               oSearch = %scanrpl('\':'/':oSearch);
115400200121               vwinbndc( oSearch );
115500200121             EndIf;
115600200121
115700180322
115800210219
115900210219             if runOption = 'mnEmailLst';
116000210219               if s1Dept = 'Fully Insured';
116100210322                 iKey = %SubSt( s1ActGrp : 1 : 3 ) +
116200210322                        %SubSt( s1ActGrp : 5 : 3 ) +
116300210322                        %SubSt( s1ActGrp : 9 : 4 );
116400210322                 GBS0028R1( iKey : s1Name ) ;
116500210322               EndIf;
116600210219
116700210219
116800210219               if s1Dept = 'Self Funded';
116900210322                 GBS0035R1( s1ActGrp : s1Name ) ;
117000210322               EndIf;
117100210219
117200210219
117300210219             EndIf;
117400210219
117500190711             if runOption = 'vNotes';
117600190711               exsr ViewNote;
117700190710             EndIf;
117800180322
117900211021
118000211021             if runOption = 'mnAutoLoad';
118100220320               iKey = %SubSt( s1ActGrp : 1 : 3 ) +
118200220320                      %SubSt( s1ActGrp : 5 : 3 ) +
118300220320                      %SubSt( s1ActGrp : 9 : 4 );
118400220320               alMenu( iKey ) ;
118500211021             EndIf;
118600211021
118700211021
118800211021
118900180719
119000190710             // Test File.
119100190711             if runOption = 'mnTestFile';
119200190711
119300190711
119400190711               // Check to see if the user is setup to
119500190711               // Receive Test Emails.
119600190711               AddedEmail = '';
119700190711               oKey = %scanrpl('-':'':s1ActGrp);
119800190711               chain(n) ( oKey : 'T'  : myEmail) gbs0028e;
119900190711               if not %Found( gbs0028e );
120000190711                 AddedEmail = 'Y';
120100190711
120200190711                 aeKey = oKey;
120300190711                 aeFileType = 'T';
120400190711                 aeEmail = myEmail;
120500190711
120600190711                 write r_gbs0028e;
120700190711
120800190711               EndIf;
120900190711
121000191125br06           if s1GblScape = 'Y';
121100191125                 oSeq = s1Seq;
121200220621                 oFolder = %trim(s1Folder);
121300230427                 FT_I003C( oFolder );
121400191125               else;
121500191125                 oC_Seq = %Char(s1Seq);
121600191125                 GBS0030C2( oC_Seq );
121700191125               endif;
121800190711
121900190711
122000190710             endif;
122100190710
122200210406
122300190710
122400201117             // Removed 9/14/2020
122500201117             //      if runOption = 'ViewDtaFil';
122600201117             //        gbs0038c( s1FileType : s1Name );
122700201117             //
122800201117             //      EndIf;
122900180719
123000180823
123100190711             if runOption = 'FileDiff';
123200201201
123300201201               if s1Ease = 'Y';
123400201201
123500201201                 FileList = 'Daily';
123600201201                 dou BtnCancel = *on;
123700201201                   Exfmt EaseSel;
123800201201
123900201201                   if btnAccept = *on;
124000201201                     if FileList <> 'Daily';
124100201201                       oEaseType = FileList;
124200201201                     endif;
124300201201                     leave;
124400201201                   endif;
124500201201                 enddo;
124600201201               endif;
124700201201
124800201201
124900201201
125000201201               oKey = %scanrpl('-':'':s1ActGrp);
125100201201               gbs0030R2(  oKey : s1FileType :oEaseType);
125200201201             EndIf;
125300180823
125400201201             if runOption = 'PlnxRef';
125500201201               oKey = %scanrpl('-':'':s1ActGrp);
125600201201               gbs0044R(  oKey );
125700201201             EndIf;
125800180823
125900180920
126000201201br03         if runOption = 'CntList';
126100201201               ShowCntList(s1PayVend );
126200201201             EndIf;
126300190509
126400190509
126500201201             if runOption = 'iSeriesCmp';
126600201201               oKey = %scanrpl('-':'':s1ActGrp);
126700201201               gbs0039C( s1FileType : s1Name: oKey );
126800201201             EndIf;
126900180920
127000200914
127100201201             if runOption = 'mnScanText';
127200201201               ScanFileC( s1Name: s1Folder );
127300201201             EndIf;
127400200914
127500200914
127600201201             if btnArchLst = *on;
127700201201               Screen3();
127800201201             endif;
127900201117
128000191202
128100201201br07         If SelAcct = *on;
128200201201               // Go Directly to application;
128300201201               if s1Dept = 'Fully Insured';
128400191202
128500201201                 wTrst = %Dec( %Subst(s1ActGrp : 1 : 3) : 3: 0 );
128600201201                 wSub  = %Dec( %Subst(s1ActGrp : 5 : 3) : 3: 0 );
128700201201                 wAcct = %Dec( %Subst(s1ActGrp : 9 : 4) : 4: 0 );
128800191202
128900201201                 AccountInq( wTrst : wSub : wAcct );
129000201201               endIf;
129100201201             endif;
129200191202
129300191202
129400201201             btnArchLst = *off;
129500201201             SelAcct = *off;
129600201201             btnDelete = *off;
129700201201             btnEdit = *off;
129800201201             btnView = *off;
129900201201             runOption = '';
130000201201             update LstSfl;
130100161223
130200201201             Reload = 'Y';
130300201201           endIf;
130400161223
130500161223
130600201201         enddo;
130700190710       Endsr;
130800171215
130900171215      *-------------------------------------------------------------------------
131000190711       Begsr $DelRecord;
131100171215
131200171215
131300190710         exsr LoadData;
131400171215
131500190711         dou btnCancel = *on;
131600190710           exfmt Confirm;
131700171215
131800171215
131900190711           if btnAccept = *on;
132000180612
132100190509             chain s1Seq gbs0030P;
132200210902             //ftRcdSts = 'D';
132300180612
132400210902             //ftChgBy = wqUsrn;
132500210902             // ftChgDt = %Dec(%Date);
132600210902             // ftChgTm = %Dec(%Time);
132700180612
132800210822             delete r_gbs0030;
132900230323
133000230323             //---------------------------
133100230323             // Remove the 28P record - J001
133200230323             //---------------------------
133300230323           oKey = %subst(s2Group:1:10);
133400230324         Setll okey GBS0028P;
133500230324         dou %Eof(GBS0028P);
133600230324           reade okey GBS0028P;
133700230324
133800230324           if %Eof(GBS0028P);
133900230324             leave;
134000230324           endif;
134100230324
134200230324           if  %trim(apfiletype) = %trim(s2FILETYP);
134300230323           delete r_Gbs0028;
134400230323           endif;
134500230324
134600230324           enddo;
134700210902
134800210902             //---------------------------
134900210902             // Remove the EOI requests
135000210902             //---------------------------
135100210902             if ftEase = 'Y';
135200210902               wTrst = %Dec( %Subst(ftGroup : 1 : 3) : 3: 0 );
135300210902               wSub  = %Dec( %Subst(ftGroup : 4 : 3) : 3: 0 );
135400210902               wAcct = %Dec( %Subst(ftGroup : 7 : 4) : 4: 0 );
135500210902
135600210902               Setll ( wTrst : wSub : wAcct ) EaseEoi;
135700210902
135800210902               Dou %Eof(EaseEoi);
135900210902                 reade ( wTrst : wSub : wAcct ) EaseEoi;
136000210902                 if %eof(EaseEoi);
136100210902                   leave;
136200210902                 endif;
136300210902
136400210902                 delete r_EaseEoi;
136500210902
136600210902               Enddo;
136700210902
136800210902
136900210902
137000210902             EndIf;
137100210902
137200210902
137300210902
137400190711             leave;
137500190711           EndIf;
137600210902
137700190710         enddo;
137800171215
137900190711         btnCancel = *off;
138000190710       Endsr;
138100171215
138200180322
138300180322
138400180322
138500180322
138600180322
138700180322
138800190710       //-----------------------------------------------------------------
138900190710       //?                       Edit Note
139000190710       //-----------------------------------------------------------------
139100190711       Begsr Edit_Note;
139200180322
139300190710         Clear Add_Note;
139400180322
139500190509         dtaChanged = *off;
139600180322
139700190710         Chain ( s2Seq : s2NotSeq ) gbs0030n;
139800180322
139900190710         s3Summary = onSumry;
140000190710         s3Note    =onNote;
140100180322
140200190711         Dou btnCancel = *on;
140300180322
140400190710           exfmt Add_Note;
140500180322
140600190711           if btnCancel = *on;
140700190711             leave;
140800190710           endif;
140900180322
141000180322
141100190711           if btnAccept = *on ;
141200180322
141300190711             if dtaChanged = *off;
141400190711               leave;
141500190710             endif;
141600180322
141700180322
141800190710             //?Validate...
141900180322
142000180322
142100190710             //?No Errors - Update.
142200190710             onSumry = s3Summary;
142300190710             onNote  = s3Note;
142400180322
142500190710             onChgBy = wqusrn;
142600190710             onChgDt = %Dec(%Date);
142700190710             onChgTm = %Dec(%Time);
142800180322
142900190710             update r_Gbs0030n;
143000180322
143100190711             leaveSr;
143200190711           endif;
143300180322
143400190711         Enddo;
143500180322
143600190710       Endsr;
143700180322
143800190710       //-----------------------------------------------------------------
143900190710       //?                       View Notes
144000190710       //-----------------------------------------------------------------
144100190711       Begsr ViewNote;
144200180322
144300190710         Clear View_Note;
144400180322
144500190710         s3Seq  = s1Seq;
144600190710         s3Name = s1Name;
144700190710         oHtml  = *blanks;
144800180322
144900190710         Setll s3Seq gbs0030n;
145000190711         dou %Eof(gbs0030n);
145100190710           reade s3Seq gbs0030n;
145200180322
145300190711           if %eof(gbs0030n);
145400190711             leave;
145500190710           endif;
145600180322
145700190710           //?Load HTML Container
145800180322
145900190710           oHtml = %Trim(oHtml) + '<p><b>'+ onSumry + '</b><br/>';
146000190710           oHtml = %Trim(oHtml) +
146100190711             'Created by: ' + %Trim(onCrtBy) + ' on ' +
146200190711             %Char(%date(onCrtDt) :*usa) + ' at ' +
146300190711             %Char(%Time(onCrtTm) :*usa);
146400180322
146500190711           oHtml = %Trim(oHtml) + '<p style="margin-left: 40px">' +
146600190711             onNote + '</p><br/>';
146700180322
146800190710         enddo;
146900180322
147000180322
147100180322
147200190710         //?Display Screen
147300190711         Dou btnCancel = *on;
147400180322
147500190509           exfmt View_Note;
147600180322
147700190711           if btnCancel = *on;
147800190711             leave;
147900190711           endif;
148000180322
148100190711         Enddo;
148200180322
148300190710       Endsr;
148400180322
148500190710       //--------------------------------------------------------------------
148600190710       //
148700190710       //  Screen 2
148800190710       //
148900190710       //--------------------------------------------------------------------
149000190711       begsr Screen_2;
149100180322
149200190710         ReLoadS2 = 'Y';
149300180322
149400190711         Dow btnExit = *off;
149500180322
149600190711           if ReLoadS2 = 'Y';
149700190710             exsr ClearS2;
149800190710             exsr LoadS2;
149900190711             ReloadS2 = 'N';
150000190710           endif;
150100180322
150200190710           Exsr DisplyS2;
150300180322
150400180322
150500190710           //?Process Selections
150600190710           Select;
150700180322
150800190711           When btnAddNew = *on;
150900190710             Exsr Add_Screen;
151000190710             ReloadS2 = 'Y';
151100190711             iter;
151200180322
151300190710           endsl;
151400180322
151500180322
151600190710           //?Read Subfile for Changes.
151700190711           Dou *in95 = *ON;
151800190710             READC NoteSfl;
151900190710             *in95 = %EOF;
152000180322
152100190711             If *in95 = *OFF;
152200180322
152300190710               //?Edit Note...
152400190711               if btnEdit = *on;
152500190710                 exsr Edit_Note;
152600190710                 ReloadS2 = 'Y';
152700190711                 iter;
152800180322
152900190710               endif;
153000180322
153100190710               btnEdit = *off;
153200190711               update NoteSfl;
153300190711             endIf;
153400190711           enddo;
153500180322
153600180322
153700180322
153800190710         enddo;
153900190711         btnExit = *off;
154000180322
154100180322
154200190710       Endsr;
154300190509       // ----------------------------------------------------------------
154400190711       Begsr ClearS2;
154500180322
154600180322
154700190710         //?Clear the Subfile
154800190710         ClrSfl2 = *on;
154900190710         Write Screen2;
155000190710         ClrSfl2 = *off;
155100180322
155200190711         RRN2 = 0;
155300190710       Endsr;
155400180322
155500190710       // ----------------------------------------------------------------
155600190711       Begsr DISPLYS2;
155700180322
155800190710         DspSfl2 = *on  ;
155900190710         exfmt Screen2;
156000190711         DspSfl2 = *off;
156100180322
156200190710       Endsr;
156300180322
156400190710       // ----------------------------------------------------------------
156500190711       Begsr LoadS2;
156600180924
156700190509         Clear Screen2;
156800190710         s2Name = s1Name;
156900190710         s2Seq = s1Seq;
157000180322
157100190710         setll s2Seq  gbs0030n;
157200190711         dou %Eof(gbs0030n);
157300180322
157400190710           Reade(n) s2Seq gbs0030n;
157500180322
157600190711           if %Eof(gbs0030n);
157700190711             leave;
157800190710           endif;
157900180322
158000190710           s2Sumry = onSumry;
158100190710           s2Crtby = onCrtby;
158200190710           s2CrtDt = %Date(onCrtDt:*iso);
158300190710           s2CrtTm = %Time(onCrtTm:*iso);
158400190710           s2NotSeq = onNotSeq;
158500180322
158600190710           // Updated by Info...
158700190710           s2ChgBy = onChgBy;
158800190710           s2ChgDt = *Blanks;
158900190710           s2ChgTm = *Blanks;
159000190711           if onChgDt > 0;
159100190710             s2ChgDt = %Char(%Date(onChgDt:*iso));
159200190711             s2ChgTm = %Char(%Time(onChgTm:*iso));
159300190509           endif;
159400180322
159500180322
159600190509           rrn2 = rrn2 + 1;
159700190711           write NoteSfl;
159800190711         enddo;
159900190710       Endsr;
160000180322
160100180322
160200190710       //-----------------------------------------------------------------
160300190710       //?                       ADD Screen
160400190710       //-----------------------------------------------------------------
160500190711       Begsr Add_Screen;
160600180322
160700190710         Clear Add_Note;
160800190710         s3Name = s2name;
160900190710         s2Seq = s1Seq;
161000180322
161100180322
161200190711         Dou btnCancel = *on;
161300180322
161400190710           exfmt Add_Note;
161500180322
161600180322
161700190711           if btnCancel = *on;
161800190711             leave;
161900190710           endif;
162000180322
162100180322
162200190711           if btnAccept = *on;
162300180322
162400190710             //?Validate...
162500180322
162600180322
162700190710             //?No Errors - Update.
162800180322
162900190710             // If this is the first note for this task, generate
163000190710             // a unique NoteKey.
163100180322
163200220320             Exec Sql
163300220320               Select Max(onnotseq)
163400220320                 Into :@note_seq
163500220320                 From gbs0030n
163600220320                 Where onftseq = :s2seq;
163700180322
163800190710             onNotSeq = @Note_Seq + 10;
163900190711             if sqlcod <> 0;
164000190711               onNotSeq = 10;
164100190509             EndIf;
164200180326
164300190509             onftseq = s2seq;
164400180326
164500190509             onSumry = s3Summary;
164600190509             onNote  = s3Note;
164700180322
164800190509             onCrtBy = wqusrn;
164900190509             onCrtDt = %Dec(%Date);
165000190509             onCrtTm = %Dec(%Time);
165100180326
165200190509             onChgby = '';
165300190509             onChgdt = 0;
165400190509             onChgtm = 0;
165500180322
165600190710             Write r_gbs0030n;
165700180322
165800190711             leaveSr;
165900190711           endif;
166000180322
166100190711         Enddo;
166200180322
166300190710       Endsr;
166400180322
166500180914
166600180914
166700190710       //-----------------------------------------------------------------
166800190710       //
166900190710       //                     Send Email to AA's
167000190710       //
167100190710       //-----------------------------------------------------------------
167200190711       Dcl-Proc SendEmail;
167300180914
167400190710         Dcl-s Library Char(10);
167500190710         Dcl-s Msg Char(2000);
167600190710         dcl-s Subject Char(100);
167700190710         dcl-s toAddr Char(200);
167800190710         dcl-s ccAddr Char(200);
167900180914
168000190710         dcl-c q const ('''');
168100180914
168200180914
168300190710         dcl-s wTrst Char(3);
168400190710         dcl-s wSub  Char(3);
168500190710         dcl-s wAcct Char(4);
168600211209         dcl-s aaEmail Char(60) ;
168700180914
168800180914
168900180914
169000190710         //------------------------------
169100190508         //
169200190508         // Get the Environment
169300190508         //
169400190508         //------------------------------
169500220320         Exec Sql
169600220320           Select objlo00002
169700220320             Into :library
169800220320             From
169900220320               Table (
170000220320                 qsys2.object_statistics(
170100220320                   '*LIBL', 'FILE', object_name => '"F.ACCMST"')
170200220320               ) As x;
170300180914
170400180914
170500180914
170600201117         wtrst = %subst(ftgroup : 1 : 3);
170700190509         wSub  =  %Subst( ftGroup : 4 : 3 );
170800190509         wAcct =  %Subst( ftGroup : 7 : 4 );
170900180914
171000180914
171100190509         //------------------------------
171200190509         //
171300190509         // Get the AA's Email
171400190509         //
171500190509         //------------------------------
171600220320         Exec Sql
171700220320           Select aemla
171800220320             Into :aaemail
171900220320             From aacode
172000220320             Where acode = (Select aacode
172100220320                   From "F.ACCMST"
172200220320                   Where actrst = :wtrst And
172300220320                         acsub# = :wsub And
172400220320                         acacct = :wacct);
172500180914
172600180914
172700191125         toAddr = %Trim(aaEmail)
172800240108           + ' candace.fallin@amwins.com'                             ;
172900180914
173000220520         ccAddr = 'Stacey.Helbig@amwins.com' +
173200230323                  ' payrolledi@amwins.com'                         ;
173300180914
173400180917
173500190711         if library = 'GBSDTAT';
173600220520           toAddr = 'payrolledi@amwins.com';
173700220520           ccAddr = 'payrolledi@amwins.com';
173800190710         EndIf;
173900180917
174000190710         Subject = 'New Payroll Account Group';
174100211008         Msg = 'A new payroll account group has begun the setup process.' +
174200190711           '<p>Account: ' + wTrst + '-' + wSub + '-' + wAcct + '  ' +
174300190711           %Trim( ftName ) ;
174400180917
174500200917         if s2Ease = 'Y';
174600200917           Subject = %ScanRpl('Payroll' : 'EASE' : Subject );
174700201022           Msg     = %ScanRpl('payroll' : 'EASE' : Msg );
174800200917         EndIf;
174900200917
175000200917
175100190710         CmdString = 'MailTool toAddr(' + toAddr + ') ' +
175200190711           ' ccAddr(' + ccAddr + ') ' +
175300190711           ' Subject(' + q + %Trim( Subject)  + q + ') ' +
175400190711           ' Message(' + q + %Trim( Msg ) + q + ')' +
175500190711           ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
175600180917
175700190711         #Command(CmdString:%len(%Trim(CmdString)));
175800180917
175900180917
176000190712
176100190712         // Add the Email address to the Email List.
176200190712         aekey = s2Group;
176300190712         aeFileType = 'T';
176400220520         aeEmail = 'payrolledi@amwins.com';
176500190712         Write r_Gbs0028e;
176600190712
176700240108         // aeFileType = 'P';
176800240108         // aeEmail = 'eric.develbiss@amwins.com';
176900240108         // Write r_Gbs0028e;
177000190712
177100190712         aeFileType = 'P';
177200190712         aeEmail = aaEmail;
177300190712         Write r_Gbs0028e;
177400180917
177500180914
177600190710       end-proc;
177700180914
177800180914
177900180914
178000210923       //-----------------------------------------------------------------
178100190710       //
178200190710       //                     Initialize Routine
178300190710       //
178400190710       //-----------------------------------------------------------------
178500190711br02   Dcl-Proc Init;
178600190508
178700190508
178800190509         Reload = 'Y';
178900190710         ShowSFBtn = *off;
179000190710         ShowFIBtn = *off;
179100190508
179200190710         Auth_Dept = '';
179300190508
179400190508
179500190710         // User have all Access?
179600190710         oFunction = 'DEPT-ALL';
179700190710         oDspErrMsg = 'N';
179800190508
179900190710         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
180000190711         if oContinue = 'Y';
180100190710           Auth_Dept = 'ALL';
180200190710           ShowSFBtn = *on;
180300190711           ShowFIBtn = *on;
180400190508         endif;
180500190508
180600190508
180700190508         // User have Fully Insurred?
180800190508         oFunction = 'DEPT-FI';
180900190509         oDspErrMsg = 'N';
181000190508
181100190509         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
181200190711         if oContinue = 'Y';
181300190710           Auth_Dept = 'FI';
181400190711           ShowFIBtn = *on;
181500190508
181600190710         endif;
181700190508
181800190508
181900190710         // User have Self Funded?
182000190710         oFunction = 'DEPT-SF';
182100190710         oDspErrMsg = 'N';
182200190508
182300190509         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
182400190711         if oContinue = 'Y';
182500190710           Auth_Dept = 'SF';
182600190711           ShowSFBtn = *on;
182700190509         endif;
182800190508
182900190711
183000190711         // Get Email Addrees
183100190711         chain wqusrn EmailAddr;
183200190711         if %Found( EmailAddr );
183300190711           myEmail = lcase(eaEmail);
183400190711         endif;
183500190711
183600210511
183700210511         // Show / Hide Data Area Line
183800190508
183900210512         oFunction = 'SHOW_DTARA';
184000210512         oDspErrMsg = 'N';
184100210512         HideDtaara = *off;
184200210512
184300210512         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
184400210512         if oContinue = 'Y';
184500210512           HideDtaara = *on;
184600210512         endif;
184700210512
184800210512
184900210923
185000220320         // Set the Environment
185100210923
185200210923
185300210923
185400220320         //------------------------------
185500220320         // Get the Environment
185600220320         //------------------------------
185700220320         Exec Sql
185800220320           Select Objlo00002
185900220320             Into :Library
186000220320             From
186100220320               Table (
186200220320                 Qsys2.Object_Statistics(
186300220320                   '*LIBL', 'FILE', Object_Name => '"F.ACCMST"')
186400220320               ) As X;
186500210923
186600210923
186700220320         S1Envir = '';
186800220320         if Library = 'GBSDTAT';
186900220320           S1Envir = 'Development';
187000220320         EndIf;
187100210923
187200210923
187300210923
187400190710       End-Proc;
187500201117
187600201117
187700201117       // ----------------------------------------------------------------
187800201117       Dcl-Proc Screen3;
187900201117
188000201117         Dou btnClose = *on;
188100201117
188200201117           ClearS3();
188300201117
188400201117
188500201117         enddo;
188600201117
188700201117       end-Proc;
188800201117
188900201117
189000201117       // ----------------------------------------------------------------
189100201117       dcl-proc CLEARS3;
189200201117
189300201117         //-------------------------
189400201117         //
189500201117         // Clear the Subfile
189600221122         //
189700221122         // D002 - Monitor folder not found
189800201117         //
189900201117         //-------------------------
190000201117
190100201117         Clrsfl3 = *on;
190200201117         Write ArchList;
190300201117         Clrsfl3= *off;
190400201117         rrn3 = 0;
190500201117
190600201117
190700201117         FolderName = '/Carrier_Inbound/' + %trim( s1Folder ) + '/Archive';
190800201117         FolderName = %ScanRpl('\':'/':FolderName);
190900201117
191000201117         CmdString = 'AFNDINIFS  ' +
191100201117         'STARTDIR(' + q + %Trim(FolderName) + q + ') MATCH(*) ' +
191200201117           'OUTPUT(*RTVCMD) INCSUB(*NO) FILEORDIR(*FILE)';
191300201117
191400221122         monitor;
191500201117         #Command(CmdString:%len(%Trim(CmdString)));
191600201117
191700221122         on-error;
191800221122         btnClose = *on;
191900221122           return;
192000221122         EndMon;
192100221122
192200221122           LoadS3();
192300221122           DisplyS3();
192400201117
192500201117       End-Proc;
192600221122       // ----------------------------------------------------------------
192700221122       dcl-proc CHECKS3;
192800221122
192900221122         //-------------------------
193000221122         //
193100221122         // Check the folder
193200221122         //
193300221122         // D002 - Monitor folder not found
193400221122         //
193500221122         //-------------------------
193600221123
193700221123         HideFLDR = *on;
193800221123         if   ftrcdsts = 'D';
193900221122
194000221122         FolderName = '/Carrier_Inbound/' + %trim( s1Folder ) + '/Archive';
194100221122         FolderName = %ScanRpl('\':'/':FolderName);
194200221122
194300221122         CmdString = 'AFNDINIFS  ' +
194400221122         'STARTDIR(' + q + %Trim(FolderName) + q + ') MATCH(*) ' +
194500221122           'OUTPUT(*RTVCMD) INCSUB(*NO) FILEORDIR(*FILE)';
194600221122
194700221122         monitor;
194800221122         #Command(CmdString:%len(%Trim(CmdString)));
194900221122
195000221122         on-error;
195100221122         HideFLDR = *off;
195200221122           return;
195300221122         EndMon;
195400221123
195500221123           Endif;
195600221122
195700221122       End-Proc;
195800201117       // ----------------------------------------------------------------
195900201117       Dcl-Proc LoadS3;
196000201117         dcl-s pos Zoned(5);
196100201117
196200201201         s3Heading = s1Name;
196300201117         FolderName = '/Carrier_Inbound/' + %trim( s1Folder ) + '/Archive';
196400201117
196500201117         Dou FolderName = '*END';
196600201117
196700201117           vwcarftpc1(FolderName);
196800201117
196900201117           if FolderName = '*END';
197000201117             leave;
197100201117           endif;
197200201117
197300201117           pos = %Scanr('/':FolderName);
197400201117
197500201117           s3FileName = %Subst(FolderName:Pos+1);
197600201117
197700201117
197800201117           vwcarftpc2(FolderName:FileDate:kb_text);
197900201117           s3Size = %trim( kb_Text ) + ' KB';
198000201117           s3Date = %Subst( FileDate : 1 : 10 );
198100211020           s3Time = %Subst( FileDate : 12:  5 );
198200211020           s3Time = %scanrpl('.' : ':' : s3Time);
198300211020
198400201117
198500201117           rrn3 = rrn3 + 1;
198600201117           write ArchSfl;
198700201117           If rrn3 >= 9999;
198800201117             leave;
198900201117           endIf;
199000201117
199100201117         enddo;
199200201117
199300201117
199400201117       End-Proc;
199500201117
199600201117       // ----------------------------------------------------------------
199700201117       Dcl-Proc DisplyS3;
199800201117
199900201117         DspSfl3 = *on  ;
200000201117         exfmt ArchList;
200100201117         DspSfl3 = *off;
200200201117
200300201117       End-Proc;
200400201117
200500210111       // ----------------------------------------------------------------
200600210511       Dcl-Proc Pending_Count;
200700210111
200800210111         s1Pending = 0;
200900210111
201000210322
201100210322         // Count inbound from Amwins.
201200210111         FolderName = '/FTP_Inbound/S_GBALSCPE/' + %trim( s1Folder ) ;
201300210111         FolderName = %ScanRpl('\':'/':FolderName);
201400210111
201500210111         CmdString = 'AFNDINIFS  ' +
201600210111         'STARTDIR(' + q + %Trim(FolderName) + q + ') MATCH(*) ' +
201700210111           'OUTPUT(*RTVCMD) INCSUB(*NO) FILEORDIR(*FILE)';
201800210111
201900210111
202000210111         monitor;
202100210111           #Command(CmdString:%len(%Trim(CmdString)));
202200210111
202300210111         on-error;
202400210111           return;
202500210111         EndMon;
202600210111
202700210111         Dou FolderName = '*END';
202800210111
202900210111           vwcarftpc1(FolderName);
203000210111
203100210111           if FolderName = '*END';
203200210111             leave;
203300210111           endif;
203400210111
203500210111           s1Pending = s1Pending + 1;
203600210111         enddo;
203700210111
203800210322
203900210322
204000210322         // Count Staging from Amwins.
204100210322         FolderName = '/Carrier_Inbound/' + %trim( s1Folder ) ;
204200210322         FolderName = %ScanRpl('\':'/':FolderName);
204300210322
204400210322         CmdString = 'AFNDINIFS  ' +
204500210322         'STARTDIR(' + q + %Trim(FolderName) + q + ') MATCH(*) ' +
204600210322           'OUTPUT(*RTVCMD) INCSUB(*NO) FILEORDIR(*FILE)';
204700210322
204800210322
204900210322         monitor;
205000210322           #Command(CmdString:%len(%Trim(CmdString)));
205100210322
205200210322         on-error;
205300210322           return;
205400210322         EndMon;
205500210322
205600210322         Dou FolderName = '*END';
205700210322
205800210322           vwcarftpc1(FolderName);
205900210322
206000210322           if FolderName = '*END';
206100210322             leave;
206200210322           endif;
206300210322
206400210322           s1Pending = s1Pending + 1;
206500210322         enddo;
206600210322
206700210111       End-Proc;
206800210111
206900210512
207000210512       // ----------------------------------------------------------------
207100210512       Dcl-Proc Screen4;
207200210512
207300210512         Dou btnClose = *on;
207400210512
207500210512           if btnClose = *on;
207600210512             leave;
207700210512           EndIf;
207800210512
207900210512           // Clear the Subfile
208000210512           Clrsfl4 = *on;
208100210512           Write StatsList;
208200210512           Clrsfl4= *off;
208300210512           rrn4 = 0;
208400210512
208500210512
208600210512
208700210512           LoadS4();
208800210512
208900210512
209000210512           DspSfl4 = *on  ;
209100210512           exfmt StatsList;
209200210512           DspSfl4 = *off;
209300210512
209400210512         enddo;
209500210512
209600220320         btnClose = *off;
209700220320
209800210512       end-Proc;
209900210512
210000210512       // ----------------------------------------------------------------
210100210512       Dcl-Proc LoadS4;
210200210512
210300210512         s4Stat = 'Total Groups:';
210400210512         s4Result = %Char(sts_TotalGrps);
210500210512         rrn4 = rrn4 + 1;
210600210512         write StatsSfl;
210700210512
210800210512         s4Stat = '  Total Fully Insured:';
210900210512         s4Result = %Char(sts_TotalFI);
211000210512         rrn4 = rrn4 + 1;
211100210512         write StatsSfl;
211200210512
211300210512         s4Stat = '  Total Self Funded:';
211400210512         s4Result = %Char(sts_TotalSF);
211500210512         rrn4 = rrn4 + 1;
211600210512         write StatsSfl;
211700210512
211800210512         s4Stat = '  Total Other:';
211900210512         s4Result = %Char(sts_TotalOth);
212000210512         rrn4 = rrn4 + 1;
212100210512         write StatsSfl;
212200210512
212300210512         s4Stat = '  Total EASE:';
212400210512         s4Result = %Char(sts_TotalEase);
212500210512         rrn4 = rrn4 + 1;
212600210512         write StatsSfl;
212700210512
212800210512         // Blank Line
212900210512         s4Stat = '';
213000210512         s4Result = '';
213100210512         rrn4 = rrn4 + 1;
213200210512         write StatsSfl;
213300210512
213400210512         s4Stat = 'File Types:';
213500210512         s4Result = '';
213600210512         rrn4 = rrn4 + 1;
213700210512         write StatsSfl;
213800210512
213900210512         s4Stat = '  ADP - Self Funded:';
214000210512         s4Result = %Char(sts_FType_ADPSF);
214100210512         rrn4 = rrn4 + 1;
214200210512         write StatsSfl;
214300210512
214400210512         s4Stat = '  GBS - Self Funded:';
214500210512         s4Result = %Char(sts_FType_GBSSF);
214600210512         rrn4 = rrn4 + 1;
214700210512         write StatsSfl;
214800210512
214900210512         s4Stat = '  LUM30 - Self Funded:';
215000210512         s4Result = %Char(sts_FType_Lum30);
215100210512         rrn4 = rrn4 + 1;
215200210512         write StatsSfl;
215300210512
215400210512         //--------------------------------
215500210512
215600210512         s4Stat = '  ADP - Fully Insured:';
215700210512         s4Result = %Char(sts_FType_ADPFI);
215800210512         rrn4 = rrn4 + 1;
215900210512         write StatsSfl;
216000210512
216100210512         s4Stat = '  GBS - Fully Insured:';
216200210512         s4Result = %Char(sts_FType_GBSFI);
216300210512         rrn4 = rrn4 + 1;
216400210512         write StatsSfl;
216500210512
216600210512         s4Stat = '  GBS20 - Fully Insured:';
216700210512         s4Result = %Char(sts_FType_GBS20);
216800210512         rrn4 = rrn4 + 1;
216900210512         write StatsSfl;
217000210512
217100210512         s4Stat = '  GBS30 - Fully Insured:';
217200210512         s4Result = %Char(sts_FType_GBS30);
217300210512         rrn4 = rrn4 + 1;
217400210512         write StatsSfl;
217500210512
217600210512
217700210512       End-Proc;
217800210512
217900210512       // ----------------------------------------------------------------
218000210512       Dcl-Proc Calc_Stats;
218100210512
218200210512         if ftRcdSts <> 'A';
218300210512           return;
218400210512         EndIf;
218500210512
218600210512         sts_TotalGrps = Sts_TotalGrps + 1;
218700210512
218800210512
218900210512         if ftEase = 'Y';
219000210512           sts_TotalEase = Sts_TotalEase + 1;
219100210512         EndIf;
219200210512
219300210512         //------------------------------------
219400210512         //
219500210512         // Fully Insurred Files.
219600210512         //
219700210512         //------------------------------------
219800210512         if ftDept = 'FI';
219900210512           Sts_TotalFI =  Sts_TotalFI + 1;
220000210512
220100210512           if ftFileTyp = 'ADP';
220200210512             Sts_FType_ADPFI = Sts_FType_ADPfi + 1;
220300210512           EndIf;
220400210512
220500210512           if ftFileTyp = 'GBS';
220600210512             Sts_FType_GBSfi = Sts_FType_GBSfi + 1;
220700210512           EndIf;
220800210512
220900210512           if ftFileTyp = 'GBS20';
221000210512             Sts_FType_gbs20 = Sts_FType_gbs20 + 1;
221100210512           EndIf;
221200210512
221300210512           if ftFileTyp = 'GBS30';
221400210512             Sts_FType_gbs30 = Sts_FType_gbs30 + 1;
221500210512           EndIf;
221600210512
221700210512         EndIf;
221800210512
221900210512
222000210512
222100210512         //------------------------------------
222200210512         //
222300210512         // Other
222400210512         //
222500210512         //------------------------------------
222600210512         if ftDept = 'OTH';
222700210512           Sts_TotalOth =  Sts_TotalOth + 1;
222800210512         EndIf;
222900210512
223000210512
223100210512         //------------------------------------
223200210512         //
223300210512         // Self Funded Files
223400210512         //
223500210512         //------------------------------------
223600210512         if ftDept = 'SF';
223700210512           Sts_TotalSF =  Sts_TotalSF + 1;
223800210512
223900210512           if ftFileTyp = 'ADP';
224000210512             Sts_FType_ADPSF = Sts_FType_ADPSF + 1;
224100210512           EndIf;
224200210512
224300210512           if ftFileTyp = 'GBS';
224400210512             Sts_FType_GBSSF = Sts_FType_GBSSF + 1;
224500210512           EndIf;
224600210512
224700210512           if ftFileTyp = 'LUM30';
224800210512             Sts_FType_Lum30 = Sts_FType_Lum30 + 1;
224900210512           EndIf;
225000210512
225100210512         EndIf;
225200210512
225300210512
225400210512       End-Proc;
225500210512
225600210512       // ----------------------------------------------------------------
225700210512       Dcl-Proc ClearStats;
225800210512
225900210512         Clear Sts_TotalGrps;
226000210512         Clear  Sts_TotalFi ;
226100210512         Clear  Sts_TotalSF ;
226200210512         Clear  Sts_TotalOth ;
226300210512         Clear  Sts_TotalEase ;
226400210512
226500210512         Clear  Sts_FType_ADPSF ;
226600210512         Clear  Sts_FType_ADPFI ;
226700210512         Clear  Sts_FType_GBSFI ;
226800210512         Clear  Sts_FType_GBSSF ;
226900210512         Clear  Sts_FType_GBS20 ;
227000210512         Clear  Sts_FType_Lum30 ;
227100210512         Clear  Sts_FType_GBS30 ;
227200210512
227300210512       End-Proc;
227400220629       // ----------------------------------------------------------------
227500220629       dcl-proc Get_Env;
227600220629
227700220629           OutEnvr = GetEnvironment(' ');
227800220629
227900220629           e1envir = outenvr.e1envir;
228000220629           e1libl  = outenvr.e1libl;
228100220629           Library2 = outenvr.e1lib2;
228200220629           e1acnm  = outenvr.e1acnm;
228300220629           envColor = outenvr.envcolor;
228400220629
228500220629       End-Proc;
