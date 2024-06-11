000100190412
000200190412       Ctl-opt option(*noDebugIo)   DftActGrp(*no) bnddir('GBSBIND') ;
000300190412
000400210109      *-----------------------------------------------------------------------
000500190412      *
000600201209      *  Description: Listing of the payroll files
000700190412      *  Programmer.: Brian Rees
000800190412      *  Date.......: 04/12/2019
000900190412      *
001000210109      *-----------------------------------------------------------------------
001100201209      *  Modifications
001200201209      *
001300201209      * 12/9/2020 B.Rees  Rewrote using Page at a time SQL to speed
001400201209      *                   up the process.
001500201209      *
001600201215      *  We are using the manual sorting in this program.
001700201215      *
001800201215      *  Fields:
001900201215      *
002000201215      *   RtnSortFld = List of Field names that the user selected to
002100201215      *       sort by. ( Field1, Field2 )
002200201215      *   rtnSortOrd = The Direction of the sort ( Ascending / Descending )
002300201215      *
002400201215      *   ArrowColmn = Arrow Cells     ( '1,3,4' )
002500201215      *   ArrowDir   = Arrow Direction ( 'A,D,A' )
002600201209      *
002700220107      *
002800220107      *
002900220107      *  1/8/2022 B.Rees  To retrieve values from "deleted" account, we
003000220107      *    needed to change the SQL to replace NULL values with spaces.
003100220107      *    Ticket:  CR000476
003200220518      *
003300220518      *  05.18.2022 J.Allen - Removed BREES, updated with auth function
003400220629      *  06/29/2022 J.Allen  Added Environment Logic
003500220518      *
003600210109      *-----------------------------------------------------------------------
003700190412
003800210109      *-----------------------------------------------------------------------
003900190412      *
004000190412      * Declare Files
004100190412      *
004200210109      *-----------------------------------------------------------------------
004300190412       Dcl-f GBS0054D WorkStn
004400190412         Handler('PROFOUNDUI(HANDLER)')
004500190415         SFILE(LSTSFL:rrn)
004600190415         sFile( HistSFL : rrn2 );
004700190412
004800190412       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
004900190412       dcl-f ftFmtFil keyed;
005000190412       dcl-f ftRtvDta Keyed usage(*input: *output);
005100190412       dcl-f emailAddr keyed;
005200190412
005300201215Sort   dcl-s SaveSortFld Char(50) ;
005400201215Sort   dcl-s SaveSortOrd Char(20) ;
005500201215
005600201215Sort   dcl-s arySortFld Char(10) Dim(15);
005700201215Sort   dcl-s arySortOrd Char(5)  Dim(15);
005800201215Sort   dcl-s i int(5);
005900201215
006000190412
006100190412
006200190412      *-------------------------------------------------------------------------
006300190412      *
006400190412      * Global Variables
006500190412      *
006600190412      *-------------------------------------------------------------------------
006700190412
006800190412       dcl-ds pgmd
006900190412         ExtName('IOPGMD') PSDS;
007000190412         @pgmq *proc;
007100190412       end-ds;
007200190412
007300201209
007400210109       Dcl-s Library Char(10);
007500220629       dcl-s Library2 Char(10);
007600201209
007700190412       dcl-s rrn Zoned(5);
007800190415       dcl-s rrn2 Zoned(5);
007900190415
008000201209
008100190415       dcl-s isAA Char(1);
008200200610       dcl-c q '''';
008300190412
008400201209       dcl-s PageSize Zoned(2) inz(14);
008500201215       dcl-s SqlStmt Char(2000);
008600201209       dcl-s Cursor_Open Char(1) inz('N');
008700190412
008800201209       dcl-s refresh ind;
008900220629
009000220629       dcl-ds OutEnvr  Qualified  ;
009100220629         e1Envir  Char(15);
009200220629         e1Libl   Char(10);
009300220629         e1Lib2   Char(10);
009400220629         envColor Char(10);
009500220629         e1Acnm   Char(40);
009600220629       End-Ds;
009700201209
009800201211       dcl-ds Sq_Data;
009900201215         ffSeq# Zoned(5);
010000201215         ffTrst Zoned(3);
010100201215         ffSub# Zoned(3);
010200201215         ffAcct Zoned(4);
010300201215         ffDept   Char(5);
010400201215         ffEncrypt  Char(64);
010500201215         fffName    Char(60);
010600201215         ffDesc   Char(120);
010700201215         ffExt    Char(5);
010800201215         ffIfsLoc  Char(512);
010900201215         ffCrtDt   Zoned(8);
011000201218         ffCrtTm  Zoned(6);
011100201215         ffDemoAuto  Char(1);
011200201215         ffAsgn_aa  Char(10);
011300201218         ftname   Char(40);
011400210726         ftPayVend   Char(30);
011500201211       End-Ds;
011600201211
011700201211
011800190412      *--------------------------------------------
011900190412      *
012000190412      * Procedures
012100190412      *
012200190412      *--------------------------------------------
012300190412      /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
012400200102      /include GBSPGM/QMODSRC,#CommandPr
012500201218      /include GBSPGM/QMODSRC,#GettokPR           // Split Function
012600220629      /include *LIBL/QMODSRC,#ChkFncAth           // Check Function Authori ty
012700220629      /Include *LIBL/QMODSRC,#GetEnvrPr         // Get Environment
012800201218
012900190412
013000190510       dcl-pr gbs0030C  ExtPgm('GBS0030C') end-pr;
013001221014
013002221014
013200210109      *----------------------------------------------------------------------
013300190412      *
013400190412      * Mainline Program
013500190412      *
013600210109      *----------------------------------------------------------------------
013700200102
013800210507       Exec Sql
013900210507         Set Option Commit = *None, Naming = *Sys;
014000200102
014100190415       init();
014200220629       Get_Env();
014300190412
014400201209
014500201209
014600201209
014700201209       // Set Defaults
014800201209       btnSearch = *on;
014900201209
015000201209       Dou btnExit = *on;
015100201209
015200201209
015300220107         if btnExit = *on;
015400220107           leave;
015500220107         EndIf;
015600220107
015700201209
015800201209         // When the user presses the search button
015900201209         // set the lower limit of the selected file.
016000201209
016100201218         if btnSearch = *on or
016200201218         RtnSortFld > '';
016300201209
016400201209           build_Sql();
016500201209
016600201209           if Cursor_Open = 'Y';
016700201209
016800210507             Exec Sql
016900210507               Close c1;
017000201209
017100201209             Cursor_Open = 'N';
017200201209           endif;
017300201209
017400201209
017500201209
017600210507           Exec Sql
017700210507             Declare c1 Scroll Cursor For sqlstmt;
017800210507           Exec Sql
017900210507             Prepare sqlstmt From :sqlstmt;
018000210507           Exec Sql
018100210507             Open c1;
018200201209
018300201209           cursor_open = 'Y';
018400201209
018500201209           load_Grid();
018600201209           btnSearch = *off;
018700201209         EndIf;
018800201209
018900201209
019000201209
019100201209         //-----------------------------
019200201209         // Page Down was pressed
019300201209         //-----------------------------
019400201209         if PageDown = *on ;
019500201209           load_Grid();
019600201209           PageDown = *off;
019700201209         endif;
019800201209
019900201209
020000201209
020100201209         //-----------------------------
020200201209         // Page Up was pressed
020300201209         //-----------------------------
020400201209         if PageUp = *on ;
020500201209           Prev();
020600201209           load_Grid();
020700201209           PageUp = *off;
020800201209         endif;
020900201209
021000201209
021100201209         //-----------------------------
021200201209         // Refresh Page
021300201209         //-----------------------------
021400201209         if btnReset = *on or btnReset = *on;
021500201209           Refresh = *off ;
021600201209           btnReset = *off;
021700201221           btnSearch = *on;
021800201221           s1Search = '';
021900201221           iter;
022000210109         // RefreshS1();
022100210109         // load_Grid();
022200201209         endif;
022300201209
022400201209
022500210507         //-------------------------------
022600210507         // Filter Button
022700210507         //-------------------------------
022800210507         if btnFilters = *on;
022900210507           exfmt Filter;
023000210507           btnFilters = *off;
023100210507           btnAccept = *off;
023200210507           btnSearch = *on;
023300210507           iter;
023400210507         EndIf;
023500210507
023600201209         DisplyS1();
023700201209
023800201209
023900201209         //?Process Selections
024000201209         Select;
024100201209
024200201209         when btnGrpPgm = *on;
024300201209           Gbs0030C();
024400201209
024500201209         When btnReset = *on;
024600201209           s1Search = *blanks;
024700201209
024800201209         other;
024900201209           ReadChangedS1();
025000210109
025100210109           if Refresh = *on;
025200210109             Refresh = *off;
025300210109             RefreshS1();
025400210109             load_Grid();
025500210109           EndIf;
025600210109
025700201209         EndSl;
025800201209
025900201209       enddo;
026000201209
026100201209
026200210507       Exec Sql
026300210507         Close c1;
026400201209
026500201209       *inlr = *On;
026600201209
026700190412
026800201209       //----------------------------------------------------------------
026900201209       //
027000201209       // Previous:  Set the cursor back 34 spaces ( 17 * 2 )
027100201209       //   if at the BOF ( SetLL to *Loval )
027200201209       //
027300201209       //----------------------------------------------------------------
027400201209
027500201209       dcl-proc Prev;
027600201209
027700201209         dcl-s x Zoned(5);
027800201209
027900201209
028000201209         x = 1;
028100201209
028200201209         dou x = PageSize * 2;
028300201209
028400201209
028500210507           Exec Sql
028600210507             Fetch Prior From c1
028700210507               Into :sq_data;
028800201209
028900201209           If sqlcod <> 0;
029000201209             Leave;
029100201209           endif;
029200201209           x = x + 1;
029300201209         enddo;
029400201209
029500201209
029600201209       End-proc;
029700190412
029800201209       //----------------------------------------------------------------
029900201209       //
030000201209       // Refresh:  Set the cursor back 17 spaces
030100201209       //   if at the BOF ( SetLL to *Loval )
030200201209       //
030300201209       //----------------------------------------------------------------
030400201209       dcl-proc refreshs1;
030500201209         dcl-s x Zoned(5);
030600201209
030700201209         x = 1;
030800201209         dou x = Pagesize;
030900210507           Exec Sql
031000210507             Fetch Prior From c1
031100210507               Into :sq_data;
031200201209
031300201209           if sqlcod <> 0;
031400201209             leave;
031500201209           EndIf;
031600201209
031700201209           x = x + 1;
031800201209
031900201209         EndDo;
032000201209
032100201209       End-Proc;
032200201209
032300201209
032400201209       // ----------------------------------------------------------------
032500201209       dcl-proc CLEARS1;
032600190412
032700201209         //-------------------------
032800201209         //
032900201209         // Clear the Subfile
033000201209         //
033100201209         //-------------------------
033200190412
033300190412         ClrSfl = *on;
033400190412         Write LstCtl;
033500190412         ClrSfl = *off;
033600190412         rrn = 0;
033700190412
033800201209       End-Proc;
033900190412
034000201209       //----------------------------------------------------------------
034100201209       //
034200201209       //  Load the grid using the Account name.
034300201209       //
034400201209       //----------------------------------------------------------------
034500201209
034600201209       dcl-proc Load_Grid;
034700201209
034800201209
034900201209         dcl-s First Char(1) inz('Y');
035000201209         EnableUp = *On;
035100201209
035200201209         ClearS1();
035300201209
035400201209         dou SqlCod <> *Zero;
035500201209
035600201209
035700201209           //-------------------
035800201209           //
035900201209           // Setup Page UP
036000201209           //
036100201209           //-------------------
036200201209           if First = 'Y';
036300201209             First = 'N';
036400201209
036500201209
036600210507             Exec Sql
036700210507               Fetch Prior From c1
036800210507                 Into :sq_data;
036900201209
037000201209             If sqlcod = 0;
037100201209               enableup = *On;
037200201209             Else;
037300201209               enableup = *off;
037400201209             endif;
037500201209           endif;
037600210507           Exec Sql
037700210507             Fetch Next From c1
037800210507               Into :sq_data;
037900220107
038000201209
038100201209           If sqlcod <> *zero;
038200201209             Leave;
038300201209           endif;
038400201209
038500201209           load_Subfile();
038600201209
038700201209           if rrn = PageSize;
038800201209             leave;
038900201209           endif;
039000201209
039100201209         enddo;
039200201209
039300201209
039400201209         //---------------------------
039500201209         // Setup Directional Links.
039600201209         //---------------------------
039700210507         Exec Sql
039800210507           Fetch Next From c1
039900210507             Into :sq_data;
040000201209
040100201209         If sqlcod = 0;
040200201209           enabledown = *On;
040300210507           Exec Sql
040400210507             Fetch Prior From c1
040500210507               Into :sq_data;
040600201209         else;
040700201209           EnableDown = *off;
040800201209         EndIf;
040900201209
041000201209
041100201209
041200201209
041300201209
041400201209       end-proc;
041500201209
041600201209       // ----------------------------------------------------------------
041700201209
041800201209       dcl-proc Load_Subfile;
041900201209
042000201209         dcl-s HistCount Zoned(5);
042100201209
042200201209         MenuId = '';
042300220518         if oContinue = 'Y';
042400201209           MenuId = 'Menu1';
042500201209         EndIf;
042600201209
042700210109         s1Trst = ffTrst;
042800210109         s1Sub# = ffSub#;
042900210109         s1Acct = ffAcct;
043000210109         s1CrtDt = ffCrtdt;
043100210109         s1CrtTm = ffCrttm;
043200201209
043300201209         s1ActNbr = %Editc( ffTrst : 'X' ) + '-' +
043400201209           %Editc( ffSub# : 'X' ) + '-' +
043500201209           %Editc( ffAcct : 'X' );
043600190412
043700210109         s1ActName  = ftname;
043800190424
043900201209         s1FileName = fffname;
044000201209         s1Encrypt  = ffEncrypt;
044100201209         s1Created  = %Subst( %Char(ffcrtdt):1:4)
044200201209         + '/' + %Subst( %Char(ffcrtdt):5:2)
044300201209         + '/' + %Subst( %Char(ffcrtdt):7:2)
044400200102
044500201209         + '  ' +
044600201209         %Char(%Time(ffCrtTm) :*hms);
044700201209         s1AutoLoad = ffDemoAuto;
044800201209         s1AaUser = ffAsgn_aa;
044900201209         s1Dept   = ffdept;
045000210726         s1PayVend = ftPayVend;
045100190412
045200201209         s1Worked = '';
045300201209         s1WorkDt = '';
045400190412
045500190412
045600201209         // See if the file was worked.
045700201209         Setll s1Encrypt ftRtvDta;
045800201209         Dou %Eof(ftRtvDta);
045900201209           reade s1Encrypt ftRtvDta;
046000201209           if %eof(ftRtvDta);
046100201209             leave;
046200201209           endif;
046300190412
046400201209           if  frisaa = 'Y';
046500201209             s1Worked = 'Y';
046600201209             s1WorkDt = %Char(%Date(frOpnDt:*iso):*Usa) + '  ' +
046700201209             %Char(%Time(frOpntm) :*hms);
046800201209             leave;
046900201209           EndIf;
047000190412
047100201209         Enddo;
047200190412
047300201209         s1ToolTip = 'View History';
047400210507         Exec Sql
047500210507           Select Count(*)
047600210507             Into :histcount
047700210507             From ftrtvdta
047800210507             Where frencrypt = :s1encrypt;
047900190415
048000201209         if HistCount > 0;
048100201209           s1ToolTip = 'View History (' + %Char( HistCount ) + ')';
048200201209           ShowHist = *on;
048300201209         else;
048400201209           ShowHist = *off;
048500201209         endif;
048600190415
048700201209         ShowView = *on;
048800210109         if s1Encrypt = '';
048900210109           showView = *off;
049000210109           ShowHist = *off;
049100210109         EndIf;
049200190412
049300201211         rrn = rrn + 1;
049400201211         write LstSfl;
049600190412
049700201209       End-Proc;
049800190412
049900190424
050000190412       // ----------------------------------------------------------------
050100201209       Dcl-Proc DisplyS1;
050200190412
050300210507         dcl-s FltrCnt Zoned(3);
050400210507
050500210507         fltrCnt = 0;
050600210507         FltrName = 'Filters';
050700210507         If ChkShowAll = 'Y';
050800210507           FltrCnt = fltrCnt + 1;
050900210507         EndIf;
051000210507
051100210507         If ChkHideRcs = 'Y';
051200210507           FltrCnt = fltrCnt + 1;
051300210507         EndIf;
051400210507
051500210507         if FltrCnt > 0;
051600210507           fltrName = %Trim( FltrName ) + ' ( ' +  %Char(FltrCnt) + ' )';
051700210507         EndIf;
051800210507
051900201209         DspSfl = *on  ;
052000201209         exfmt LstCtl;
052100210507         DspSfl = *off;
052200190412
052300201209       End-Proc;
052400190412
052500201209       // ----------------------------------------------------------------
052600210507       Dcl-Proc ReadChangedS1;
052700190412
052800201209         dcl-s aa_Count Zoned(3);
052900190412
053000210507         Dou *in95 = *ON;
053100201209           READC LstSfl;
053200201209           *in95 = %EOF;
053300190412
053400210507           If *in95 = *OFF;
053500190412
053600210507             if rtnValue = 'btnView';
053700190412
053800201209               // Is current User an AA?
053900201209               frisaa = '';
054000201209               chain wqusrn emailaddr;
054100210507               if %Found( emailAddr );
054200190412
054300201209                 eaemail = lCase( eaemail );
054400190412
054500201209                 aa_count = 0;
054600210507                 Exec Sql
054700210507                   Select Count(*)
054800210507                     Into :aa_count
054900221014                     From aacode
055000210507                     Where Lower(aemla) = :eaemail;
055100190412
055200190412
055300190412
055400210507                 if aa_Count > 0;
055500210507                   frisaa = 'Y';
055600201209                 EndIf;
055700190412
055800190412
055900201209                 // Write to Retrieved Database.
056000201209                 frEncrypt = s1Encrypt;
056100201209                 fropnby = wqusrn;
056200201209                 fropnDt = %Dec( %Date );
056300201209                 fropnTm = %Dec( %Time );
056400190412
056500201209                 write r_Ftrtvdta;
056600210109
056700210507                 Refresh = *on;
056800190412
056900210507               EndIf;
057000190412
057100190412
057200201209             EndIf;
057300190415
057400190415
057500201209             // Delete File.
057600210507             if runOption = 'delFile';
057700200102
057800210507               exec sql
057900210507                 Delete from FTFMTFIL where FFENCRYPT = :s1Encrypt and
058000210507                 ffTrst = :s1Trst and
058100210507                 ffSub# = :s1Sub# and
058200210507                 ffAcct = :s1Acct and
058300210507                 ffcrtdt = :s1CrtDt and
058400210507                 ffcrttm = :s1Crttm;
058500210109
058600200102
058700210507               if s1Encrypt > '';
058800210109
058900210507                 if Library = 'QS36F';
059000210507                   exec sql
059100210507                     Delete from FTRTVDTA where FRENCRYPT = :s1Encrypt;
059200200102
059300200102
059400210109                   CmdString = 'Del ObjLnk(' + q + '/ft_Files/' +
059500210109                   %Trim( s1Encrypt ) + q + ')' ;
059600210507                   #Command(CmdString : %len(%Trim(CmdString))) ;
059700200102
059800210507                 endif;
059900210109               endif;
060000210507               Refresh = *on;
060100201209             EndIf;
060200200102
060300200102
060400190415
060500210109             // View History
060600210507             if btnhistory = *on;
060700210507               ViewHistory();
060800201209             EndIf;
060900190415
061000190415
061100201209             btnHistory = *off;
061200210109             rtnValue = '';
061300210109             runOption = '';
061400210507             update LstSfl;
061500210507           endif;
061600210507         enddo;
061700190412
061800201209       End-proc;
061900201209
062000190415
062100201209       //----------------------------------------------------------------
062200201209       //
062300201209       // View the File Opened History.
062400201209       //
062500201209       //----------------------------------------------------------------
062600190415
062700210507       dcl-proc ViewHistory;
062800190415
062900210507         Dou btnExit = *on;
063000190415
063100201209           ClearS2();
063200210109           LoadS2();
063300190415
063400210507           DisplyS2();
063500190415
063600190415
063700210109         enddo;
063800190415
063900210507         btnExit = *off;
064000190415
064100201209       end-proc;
064200190415
064300190415
064400190415
064500201209       // ----------------------------------------------------------------
064600210507       dcl-proc CLEARS2;
064700190415
064800201209         //-------------------------
064900201209         //
065000201209         // Clear the Subfile
065100201209         //
065200201209         //-------------------------
065300190415
065400201209         ClrSfl2 = *on;
065500210109         Write HistCtl;
065600210109         ClrSfl2 = *off;
065700210507         rrn2 = 0;
065800190415
065900201209       End-Proc;
066000201209       // ----------------------------------------------------------------
066100210507       Dcl-Proc LoadS2;
066200190415
066300201209         s2FileName = s1FileName;
066400190415
066500210109         Setll s1Encrypt ftRtvDta;
066600210507         Dou %eof(ftRtvDta);
066700190415
066800210109           reade s1Encrypt ftRtvDta;
066900210507           if %eof(ftRtvDta);
067000210507             leave;
067100201209           endif;
067200190415
067300190415           s2User = FROPNBY;
067400190415           s2DatTim  = %Char(%Date(frOpnDt:*iso):*Usa) + '  ' +
067500201209           %Char(%Time(frOpnTm) :*usa);
067600190415
067700201209           rrn2 = rrn2 + 1;
067800210109           write HistSfl;
067900190415
068000210507           If rrn2 >= 9999;
068100210507             leave;
068200210507           endIf;
068300190415
068400210507         enddo;
068500190415
068600201209       End-Proc;
068700190415
068800201209       // ----------------------------------------------------------------
068900210507       Dcl-Proc DisplyS2;
069000190415
069100201209         DspSfl2 = *on  ;
069200210109         exfmt HistCtl;
069300210507         DspSfl2 = *off;
069400190415
069500201209       End-Proc;
069600190415
069700201209
069800201209
069900201209       // ----------------------------------------------------------------
070000201209
070100210507       dcl-proc Build_Sql;
070200201209
070300201209
070400201218         Dcl-s Where Char(1000);
070500201218         Dcl-s WhereAA Char(500);
070600210507         Dcl-s WhereNR Char(500);
070700201209
070800201215         dcl-s hasWhere Char(1);
070900201211
071000201209         //----------------------------------------------------
071100201209         //
071200201209         //  Select Statements
071300201209         //
071400201209         //----------------------------------------------------
071500201209
071600201218         SqlStmt =
071700220107         'Select a.*, ' +
071800220107          ' COALESCE(ftname, ' + q + q +') ftname, ' +
071900220107          ' COALESCE(ftPayVend, ' + q + q +') ftPayVend ' +
072000220107          ' from ftFmtFil a ' +
072100220107          ' left Join gbs0030p on ffseq# = ftseq# ' ;
072200201209
072300201209
072400201209         //----------------------------------------------------
072500201209         //
072600201211         //  Build Search Where Clauses
072700201209         //
072800201209         //----------------------------------------------------
072900201209
073000210109         where = '';
073100201211
073200210507         if s1Search > '';
073300201209
073400210507           Where = 'And ' +
073500210507           '( Char(digits(ffTrst)) || +
073600210507           Char(digits(ffSub#)) || +
073700210507           Char(digits(ffAcct)) ' +
073800210507           '  like ' + q + '%' + %Trim( s1Search ) + '%' + q +
073900210507           ' or  Char(digits(ffTrst)) || ' + q + '-' + q + '|| +
074000210507           Char(digits(ffSub#)) || ' + q + '-' + q + ' ||+
074100210507           Char(digits(ffAcct)) ' +
074200210507           '  like ' + q + '%' + %Trim( s1Search ) + '%' + q +
074300201211
074400210507           ' or Upper(ffDept) like ' + q + '%' + %Trim( s1Search ) + '%' + q +
074500210507           ' or Upper(ftname) like ' + q + '%' + %Trim( s1Search ) + '%' + q +
074600210507           ' or Upper(fffname) like ' + q + '%' + %Trim( s1Search ) + '%' + q +
074700210507           ' or Upper(ffDesc) like ' + q + '%' + %Trim( s1Search ) + '%' + q +
074800210726        ' or Upper(ftPayVend) like ' + q + '%' + %Trim( s1Search ) + '%' + q +
074900210507           ' or ffcrtdt like ' + q + '%' + %Trim( s1Search ) + '%' + q +
075000201218         ' or Upper(ffasgn_aa) like ' + q + '%' + %Trim( s1Search ) + '%' + q +
075100210507           ')' ;
075200201211
075300210507           endif;
075400201209
075500201209
075600201211
075700201211
075800210507         //----------------------------------------------------
075900210507         //
076000201215         //  Build AA Where Clauses
076100201211         //
076200201211         //----------------------------------------------------
076300201211
076400210507         if isAA = 'Y';
076500210507           WhereAA = 'and ffasgn_aa = ' + q + %Trim( wqusrn ) + q  ;
076600210507         EndIf;
076700201211
076800210507         if chkShowAll = 'Y';
076900210507           WhereAA = '';
077000210507         EndIf;
077100201211
077200210507         if isAA = '';
077300210507           WhereAA = '';
077400210507         EndIf;
077500201211
077600201211
077700210507
077800210507         //----------------------------------------------------
077900210507         //
078000210507         //  Build "No Records" Where Clause
078100210507         //
078200210507         //----------------------------------------------------
078300210507         WhereNr = '';
078400210507
078500210507         if chkHideRcs = 'Y';
078600210507           WhereNR = 'and ffEncrypt <> ' + q + q ;
078700210507         EndIf;
078800210507
078900210507
079000201211
079100201211         //----------------------------------------------------
079200201211         //
079300201211         //  Put it together.
079400201211         //
079500201211         //----------------------------------------------------
079600210109         hasWhere = '';
079700201215
079800210507         if Where > '';
079900210507           hasWhere = 'Y';
080000201215
080100210507           sqlStmt = %Trim( SqlStmt ) + ' Where ' +
080200210507           %Subst( %Trim(Where): 4 );
080300201215
080400210507         EndIf;
080500201211
080600210507         if WhereAA > '';
080700210507           if hasWhere = 'Y';
080800201215
080900210507             sqlStmt = %Trim( SqlStmt ) + ' ' +
081000210507             %Trim( WhereAA);
081100201215
081200210507           else;
081300201215
081400210507             sqlStmt = %Trim( SqlStmt ) + ' Where ' +
081500210507             %Subst( %Trim(WhereAA): 4 );
081600201215
081700210507           endif;
081800201215
081900210507         EndIf;
082000210507
082100210507
082200210507         if WhereNR > '';
082300210507           if hasWhere = 'Y';
082400210507
082500210507             sqlStmt = %Trim( SqlStmt ) + ' ' +
082600210507             %Trim( WhereNR );
082700210507
082800210507           else;
082900210507
083000210507             sqlStmt = %Trim( SqlStmt ) + ' Where ' +
083100210507             %Subst( %Trim(WhereNR): 4 );
083200210507
083300210507           endif;
083400210507
083500210507         EndIf;
083600201211
083700210507         setOrder();
083800210507       End-Proc;
083900201209
084000201215
084100201215
084200201215
084300201215       // ----------------------------------------------------------------
084400210507       dcl-proc Split;
084500201215
084600201215
084700201215         // To Split the Field Names
084800201215         dcl-s x int(10);
084900201215         dcl-s tokens  varchar(100) dim(50);
085000201215
085100201215         // To Split the Directions
085200201215         dcl-s y int(10);
085300201215         dcl-s tokens2 varchar(100) dim(50);
085400201215
085500201215         dcl-s i int(10);
085600201215
085700201215
085800201215         clear ArySortFld;
085900201215         clear ArySortOrd;
086000201215         clear ArrowColmn;
086100210109         clear ArrowDir;
086200201215
086300201215
086400210507         if rtnSortFld = '';
086500210507           rtnSortFld = 'S1CREATED';
086600210507           rtnSortOrd = 'D';
086700210507         EndIf;
086800201215
086900201215         tokens(*) = #Gettok( rtnSortFld : ',' : x );
087000201215         tokens2(*) = #Gettok( rtnSortORd : ',' : y );
087100201215
087200201215
087300201215         // Find the first blank space
087400210109         x = %lookup( '' : tokens ) ;
087500201215
087600210507         for i = 1 to x - 1;
087700201215
087800210507           ArySortFld(i) = tokens(i);
087900201215
088000201215
088100201215           // Check the sort order.. if blank, reverse from the
088200210109           // last time.
088300210507           if tokens2(i) = '';
088400201215
088500210507             if SaveSortFld <> rtnSortFld;
088600210507               SaveSortOrd = '';
088700210507             EndIf;
088800201215
088900201215
089000210507             if SaveSortOrd = 'A';
089100210507               arySortOrd(i) = 'Desc';
089200210507             else;
089300210507               arySortOrd(i) = 'Asc';
089400210507             EndIf;
089500201215
089600210507             SaveSortOrd = %Subst( arySortOrd(i) : 1 : 1 );
089700201215
089800210507           else;
089900201215
090000201218
090100201218
090200201218
090300210507             if tokens2(i) = 'A';
090400210507               arySortOrd(i) = 'Asc';
090500210507             else;
090600210507               arySortOrd(i) = 'Desc';
090700210507             endif;
090800201215
090900201218
091000201218
091100201218
091200210507             SaveSortOrd = %Subst( arySortOrd(i) : 1 : 1 );
091300201218
091400201218
091500201215
091600210507           EndIf;
091700201215
091800210507         EndFor;
091900210507         rtnSortOrd = '';
092000201215
092100210507       End-Proc;
092200201215
092300201215
092400201215       // ----------------------------------------------------------------
092500201215
092600210507       dcl-proc SetOrder;
092700201215
092800210507         dcl-s OrderBy Char(1000);
092900201215
093000201218         //----------------------------------------------------
093100201218         //
093200201218         //   Set the order
093300201218         //
093400201218         //----------------------------------------------------
093500201215
093600210109         split();
093700201215
093800210507         for i = 1 to 12;
093900210507           if %Trim(ArySortFld(i)) > '';
094000201215
094100210507             if i = 1;
094200210507               SqlStmt = %Trim( SqlStmt ) + ' Order by ' ;
094300210507             EndIf;
094400201215
094500201215
094600210507             if ArySortFld(i) = 'S1ACTNBR';
094700210507               OrderBy = %Trim( OrderBy ) + ', fftrst||ffsub#||ffacct ' +
094800210507                 ArySortOrd(i);
094900201218               ArrowColmn = %Trim( ArrowColmn ) + ',1';
095000210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
095100210507               %Subst(ArySortOrd(i):1:1);
095200210507             endif;
095300201215
095400201215
095500210507             if ArySortFld(i) = 'S1DEPT';
095600210507               OrderBy = %Trim( OrderBy ) + ', ffDept ' + ArySortOrd(i);
095700210507               ArrowColmn = %Trim( ArrowColmn ) + ',2';
095800210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
095900210507               %Subst(ArySortOrd(i):1:1);
096000210507             endif;
096100201215
096200201218
096300210507             if ArySortFld(i) = 'S1ACTNAME';
096400210507               OrderBy = %Trim( OrderBy ) + ', ftname ' + ArySortOrd(i);
096500201218               ArrowColmn = %Trim( ArrowColmn ) + ',3';
096600210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
096700210507               %Subst(ArySortOrd(i):1:1);
096800210507             endif;
096900201215
097000210726
097100210726
097200210507             if ArySortFld(i) = 'S1FILENAME';
097300210507               OrderBy = %Trim( OrderBy ) + ', fffname ' + ArySortOrd(i);
097400201218               ArrowColmn = %Trim( ArrowColmn ) + ',4';
097500210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
097600210507               %Subst(ArySortOrd(i):1:1);
097700210507             endif;
097800201218
097900201218
098000210507             if ArySortFld(i) = 'S1CREATED';
098100210507               OrderBy = %Trim( OrderBy ) + ', FFCRTDT ' + ArySortOrd(i);
098200201218               OrderBy = %Trim( OrderBy ) + ', FFCRTTM ' + ArySortOrd(i);
098300201218               ArrowColmn = %Trim( ArrowColmn ) + ',5';
098400210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
098500210507               %Subst(ArySortOrd(i):1:1);
098600201218             endif;
098700201218
098800201215
098900201218
099000210507             if ArySortFld(i) = 'S1AUTOLOAD';
099100210507               OrderBy = %Trim( OrderBy ) + ', ffdemoauto ' + ArySortOrd(i);
099200201218               ArrowColmn = %Trim( ArrowColmn ) + ',8';
099300210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
099400210507               %Subst(ArySortOrd(i):1:1);
099500210109             endif;
099600201218
099700201218
099800210507             if ArySortFld(i) = 'S1AAUSER';
099900210507               OrderBy = %Trim( OrderBy ) + ', ffasgn_aa ' + ArySortOrd(i);
100000201218               ArrowColmn = %Trim( ArrowColmn ) + ',9';
100100210507               ArrowDir = %Trim( ArrowDir ) + ', ' +
100200210507               %Subst(ArySortOrd(i):1:1);
100300210507             endif;
100400201218
100500210726
100600210726             if ArySortFld(i) = 'S1PAYVEND';
100700210726               OrderBy = %Trim( OrderBy ) + ', ftpayVend ' + ArySortOrd(i);
100800210726               ArrowColmn = %Trim( ArrowColmn ) + ',10';
100900210726               ArrowDir = %Trim( ArrowDir ) + ', ' +
101000210726               %Subst(ArySortOrd(i):1:1);
101100210726             endif;
101200201215
101300210507           endif;
101400201215
101500210507         endfor;
101600201215
101700201218         OrderBy = %Subst(OrderBy:3);
101800201218         ArrowDir = %Subst(ArrowDir:3);
101900201218         //  ArrowColmn = %Subst(ArrowColmn:2);
102000201218         SqlStmt = %Trim( SqlStmt ) + ' ' + %Trim( OrderBy );
102100201215
102200210109         SaveSortFld = rtnSortFld;
102300210507         RtnSortFld = '';
102400201215
102500201215
102600210507       End-Proc;
102700201215
102800201215
102900210109       // ----------------------------------------------------------------
103000210109
103100210507       Dcl-Proc Init;
103200210109
103300210507         dcl-s SqlCount Zoned(3);
103400220518
103500220518         oFunction = 'DELETE';
103600220518         oDspErrMsg = 'N';
103700220518         oContinue = ' ';
103800220518
103900220518         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
104000220518         if oContinue = 'Y';
104100220518         //canEdit = *on;
104200220518         endif;
104300220518
104400210109
104500210109         isAA = '';
104600210109
104700210109         // Check to see if the user is an AA.
104800210109         chain wqusrn emailaddr;
104900210507         if %Found( emailAddr );
105000210109
105100210507           eaEmail = lcase( eaEmail ) ;
105200210109
105300210507           Exec Sql
105400210507             Select Count(*)
105500210507               Into :sqlcount
105600221014               From aacode
105700210507               Where Lower(aemla) = :eaemail;
105800210109
105900210507           if sqlCount > 0;
106000210507             isAA = 'Y';
106100210507           EndIf;
106200210109
106300210507         EndIf;
106400210109
106500210109
106600210109         //------------------------------
106700210109         // Get the Environment
106800210109         //------------------------------
106900210507         Exec Sql
107000210507           Select Objlo00002
107100210507             Into :Library
107200210507             From
107300210507               Table (
107400210507                 Qsys2.Object_Statistics(
107500210507                   '*LIBL', 'FILE', Object_Name => '"F.ACCMST"')
107600210507               ) As X;
107700210109
107800210109
107900210109
108000210507       End-Proc;
108100220629       // ----------------------------------------------------------------
108200220629       dcl-proc Get_Env;
108300220629
108400220629           OutEnvr = GetEnvironment(' ');
108500220629
108600220629           e1envir = outenvr.e1envir;
108700220629           e1libl  = outenvr.e1libl;
108800220629           Library2 = outenvr.e1lib2;
108900220629           e1acnm  = outenvr.e1acnm;
109000220629           envColor = outenvr.envcolor;
109100220629
109200220629       End-Proc;
109300201215
109400201215
109500201215
