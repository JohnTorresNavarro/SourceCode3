000100221116       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no)
000200210310        bnddir('GBSBIND');
000300210310
000400210310      *-------------------------------------------------------------------------
000500210310      *
000600210310      *  Description: FM485R - Rewriting the Program Authority Maintenance
000700210310      *                        in Profound Logic
000800210310      *
000900210310      *  Programmer.: Brian Rees
001000210310      *  Date.......: 3/10/2021
001100210310      *
001200220331      *  04/07/2022  JT  Fixed various issues.
001300220906      *  09/06/2022  JT  Changed PL to use *iso 8 date. Was using 6 char.
001400221003      *  10/03/2022  JT  Added feature to copy user to user
001500221116      *  11/16/2022  JT  Allowed the use *ALL as a valid program name.
001600230726      *  07/26/2023 DLK  change obj check from *LIBL to *ALLUSR to support
001700230726      *                  GA programs and any other future use.
001800210310      *-------------------------------------------------------------------------
001900210310
002000220906      *-------------------------------------------------------------------------
002100210310      *
002200210310      * Declare Files
002300210310      *
002400210310      *-------------------------------------------------------------------------
002500210310       Dcl-f FM485D WorkStn
002600210310          Handler('PROFOUNDUI(HANDLER)')
002700210310          SFILE(LstSfl:rrn);
002800210310
002900210310       dcl-f PgmAuthl1 keyed usage(*Input:*output:*Delete:*update);
003000210310
003100221006       dcl-f PgmAuthl2 keyed usage(*Input:*update) rename(R_PGMAUTH:R_PGMAUTHX);
003200221003
003300221003       dcl-f PgmAuth2 keyed usage(*Input:*output:*Delete:*update);
003400221003
003500220727      *-------------------------------------------------------------------------
003600220727      *
003700220727      /Include *LIBL/QMODSRC,#GetEnvrPr            // Get Environment
003800221003      /include gbspgm/QMODSRC,#COMMANDPR           // Command String
003900220727      *
004000210310      *-------------------------------------------------------------------------
004100210310      *
004200210310      * Global Variables
004300210310      *
004400210310      *-------------------------------------------------------------------------
004500210310       dcl-ds pgmd
004600210310          ExtName('IOPGMD') PSDS;
004700210310         @pgmq *proc;
004800210310       end-ds;
004900210310
005000210310
005100210310       dcl-s rrn Zoned(5);
005200210310       dcl-s reload char(1) inz('Y');
005300210310       dcl-s hasError ind;
005400210311       dcl-s Mode Char(10);
005500220727
005600220727       dcl-s Library Char(10);
005700220727       dcl-s Library2 Char(10);
005800220727
005900220727       dcl-ds OutEnvr  Qualified  ;
006000220727         e1Envir  Char(15);
006100220727         e1Libl   Char(10);
006200220727         e1Lib2   Char(10);
006300220727         envColor Char(10);
006400220727         e1Acnm   Char(40);
006500220727       End-Ds;
006600210310
006700210310
006800210310      *-------------------------------------------------------------------------
006900210310      *
007000210310      * Procedures
007100210310      *
007200210310      *-------------------------------------------------------------------------
007300210310
007400210310       /include *LIBL/QMODSRC,PR0001RPR            // Case Functions
007500210310       /include *LIBL/QMODSRC,PR0002RPR            // Get User Info API
007600210310       /include *LIBL/QMODSRC,PR0003RPR            // Check Program Authority
007700210310
007800210310
007900210310       dcl-pr UserLookup ExtPgm('WN0009R');
008000210310         iName Char(10);
008100210310         iCancel Char(1);
008200210310       End-Pr;
008300210310       dcl-s iCancel Char(1);
008400210310
008500210310      *-------------------------------------------------------------------------
008600210310      *
008700210310      * Mainline Program
008800210310      *
008900210310      *-------------------------------------------------------------------------
009000210310       Init();
009100210310
009200210310       Dou btnExit = *on;
009300210310
009400210310         If Reload = 'Y';
009500210310           ClearS1();
009600210310           LoadS1();
009700210310           Reload = 'N';
009800210310         endIf;
009900210310
010000210310         DisplyS1();
010100210311         Mode = '';
010200210310
010300210310         //?Process Selections
010400210310         Select;
010500210310
010600210310         when btnAddNew = *on;
010700210310           reload = 'Y';
010800210310           Clear AddScreen;
010900210311           Mode = 'Add';
011000221006           s2Auth = 'N';
011100210310           AddRecord();
011200210310
011300221003         when btnUser = *on;
011400221003           reload = 'Y';
011500221003           Clear U2UScreen;
011600221003           Mode = 'Add';
011700221006           s2Auth = 'N';
011800221003           CopyRecord();
011900221003
012000221006         when btnDeact = *on;
012100221006           reload = 'Y';
012200221006           Clear DeactScrn;
012300221006           Mode = 'Add';
012400221006           s2Auth = 'N';
012500221006           Deactivate();
012600221006
012700221006         when btnReact = *on;
012800221006           reload = 'Y';
012900221006           Clear ReactScrn;
013000221006           Mode = 'Add';
013100221006           s2Auth = 'N';
013200221006           Reactivate();
013300221006
013400210310
013500210310         When srchChgd = *on;
013600210310           reload = 'Y';
013700210310
013800210310
013900210310         When btnReset = *on;
014000210310           Reload = 'Y';
014100210310           s1Search = *blanks;
014200210310
014300210310         other;
014400210310           ReadChangedS1();
014500210310
014600210310         EndSl;
014700210310
014800210310
014900210310       enddo;
015000210310
015100210310       *inlr = *on;
015200210310
015300210310
015400210310       // ----------------------------------------------------------------
015500210310       dcl-proc CLEARS1;
015600210310
015700210310         //-------------------------
015800210310         //
015900210310         // Clear the Subfile
016000210310         //
016100210310         //-------------------------
016200210310
016300210310         SflClr = *on;
016400210310         Write LstCtl;
016500210310         SflClr= *off;
016600210310         rrn = 0;
016700210310
016800210310       End-Proc;
016900210310       // ----------------------------------------------------------------
017000210310       Dcl-Proc LoadS1;
017100210310
017200210310         Setll *loval PgmAuthl1;
017300210310         Dou %eof(PgmAuthl1);
017400210310
017500210310           read(n) PgmAuthl1;
017600210310           if %eof(PgmAuthl1);
017700210310             leave;
017800210310           endif;
017900210310
018000210310           s1Program = Program;
018100210310           s1UserId = UserName;
018200210310           s1Func = Function;
018300210310           s1Auth_Txt = 'Yes';
018400210310           if Authorized = 'N';
018500210310             s1Auth_txt = 'No';
018600210310           EndIf;
018700220906
018800210310
018900210310
019000220906           //s1StrDate = '';
019100220906           s1StrDate = d'0001-01-01';
019200210310           if StartDate > 0;
019300220906            // s1StrDate = %char(%date(StartDate:*iso):*usa/);
019400220906            s1StrDate = %date(StartDate:*iso);
019500210310           endif;
019600210310
019700220906           //s1EndDate = '';
019800220906           s1EndDate = d'0001-01-01';
019900210310           if EndDate > 0;
020000220906             //s1EndDate = %char(%date(EndDate:*iso):*usa/);
020100220906             s1EndDate = %date(EndDate:*iso);
020200210310           endif;
020300210310
020400210310
020500210310
020600210310           if s1Search = '';
020700210310             rrn = rrn + 1;
020800210310             write LstSfl;
020900210310
021000210310           else;   //?Search Field
021100210310             if %scan( %Trim(s1Search) : s1Program ) > 0 or
021200210310              %scan( %Trim(s1Search) : uCase(s1Func) ) > 0 or
021300210310              %scan( %Trim(s1Search) : uCase(s1UserId) ) > 0;
021400210310               rrn = rrn + 1;
021500210310               write LstSfl;
021600210310             endif;
021700210310           endif;
021800210310
021900210310           If rrn >= 9999;
022000210310             leave;
022100210310           endIf;
022200210310
022300210310         enddo;
022400210310
022500210310       End-Proc;
022600210310
022700210310       // ----------------------------------------------------------------
022800210310       Dcl-Proc DisplyS1;
022900210310
023000220727         Get_Env();
023100220727
023200210310         SflDsp = *on  ;
023300210310         exfmt LstCtl;
023400210310         SflDsp = *off;
023500210310
023600210310       End-Proc;
023700210310
023800210310       // ----------------------------------------------------------------
023900210310       Dcl-Proc ReadChangedS1;
024000210310
024100210310         Dou *in95 = *ON;
024200210310           READC LstSfl;
024300210310           *in95 = %EOF;
024400210310
024500210310           If *in95 = *OFF;
024600210310
024700210310
024800210310             if btnEdit = *on;
024900210311               Load_Data();
025000210311               Edit_Data();
025100210310             endIf;
025200210310
025300210323             if btnCopy = *on;
025400210323               Clear AddScreen;
025500210323               Load_Data();
025600210323               Mode = 'Add';
025700210323               s2UserId = '';
025800210323               AddRecord();
025900210323             endIf;
026000210323
026100210310
026200210310             if btnDelete = *on;
026300210310               chain ( s1Program : s1Func : s1UserId ) PgmAuthl1;
026400210310               if %Found( PgmAuthl1 );
026500210310                 delete r_PgmAuth;
026600210310               EndIf;
026700210310             EndIf;
026800210310
026900210311             if btnView = *on;
027000210311               load_Data();
027100210311               exfmt ViewScreen;
027200210311             EndIf;
027300210311
027400210311
027500210311             btnView = *off;
027600210310             btnDelete = *off;
027700210310             btnEdit = *off;
027800210310             update LstSfl;
027900210310             Reload = 'Y';
028000210310
028100210310           endIf;
028200210310
028300210310         enddo;
028400210310
028500210310       End-Proc;
028600210310
028700210310
028800210310
028900210310       // ----------------------------------------------------------------
029000210310       Dcl-Proc AddRecord;
029100210310
029200220324         clear AddScreen;
029300210312
029400220324         if btnCopy = *on;
029500220324          s2Program = s1Program;
029600220324          s2Func = s1Func;
029700220324          s2UserId = s1UserId;
029800220324          s2Auth = Authorized;
029900220324
030000220906             //if s1StrDate > *blanks;
030100220906             if s1StrDate > d'0001-01-01';
030200220906              s2StrDate = s1StrDate;
030300220324             endif;
030400220324
030500220906             //if s1EndDate > *blanks;
030600220906             if s1EndDate > d'0001-01-01';
030700220906              s2EndDate = s1EndDate;
030800220324             endif;
030900220324          btnCopy = *off;
031000220324         endif;
031100220324
031200210310         Dou btnCancel = *on;
031300210310           exfmt AddScreen;
031400210310           hasError = *off;
031500210310           errObject = *off;
031600210310           errUser1 = *off;
031700210311           errDate1 = *off;
031800210310           s2Msg = '';
031900210310
032000210310
032100210310
032200210310           if btnSrchUsr = *on;
032300210310             UserLookup( s2UserId : iCancel ) ;
032400210310           EndIf;
032500210310
032600210310
032700210310           if btnAccept = *on;
032800210310             validate();
032900210310
033000210310             if hasError = *on;
033100210310               iter;
033200210310             EndIf;
033300210310
033400210310             //------------------------
033500210310             //
033600210310             // Update Files.
033700210310             //
033800210310             //------------------------
033900210310             Program = s2Program;
034000210310             UserName = s2UserId;
034100210310             Function = s2Func;
034200210310             Authorized = s2Auth;
034300210310
034400210310             StartDate = 0;
034500220906             //if s2StrDate > *blanks;
034600220906             if s2StrDate > d'0001-01-01';
034700220906               //StartDate = %dec(%char(%date(s2StrDate:*usa/):*iso0):8:0);
034800220906               StartDate = %dec(s2StrDate);
034900210310             endif;
035000210310
035100210310             EndDate = 0;
035200220906             //if s2EndDate > *blanks;
035300220906             if s2EndDate > d'0001-01-01';
035400220906              // EndDate = %dec(%char(%date(s2EndDate:*usa/):*iso0):8:0);
035500220906               EndDate = %dec(s2EndDate);
035600210310             endif;
035700210310
035800210310
035900210310             paCrtBy = WQUSRN;
036000210310             paCrtDt = %Dec(%Date);
036100210310             paCrtTm = %Dec(%Time);
036200210310
036300210310             paChgBy = *Blanks;
036400210310             paChgDt = 0;
036500210310             paChgTm = 0;
036600210310
036700210310             Write r_PgmAuth;
036800210310
036900210310             //?Reset and Loop.
037000210310             s2msg = 'User: ' + %Trim(s2UserId) +
037100210310                      ' added to program: ' + %Trim(s2Program);
037200210310             s2UserId = '';
037300210310
037400210310           EndIf;
037500210310
037600210310
037700210310         EndDo;
037800210310
037900210310         btnCancel = *off;
038000210310
038100210310
038200210310       End-Proc;
038300210310
038400210310
038500221003       // ----------------------------------------------------------------
038600221003       Dcl-Proc CopyRecord;
038700221003
038800221003         clear U2UScreen;
038900221003
039000221003         if btnUser = *on;
039100221003         // s2Program = s1Program;
039200221003         // s2Func = s1Func;
039300221003         // s2UserId = s1UserId;
039400221003         // s2Auth = Authorized;
039500221003         endif;
039600221003
039700221003         Dou btnCancel = *on;
039800221003           exfmt U2UScreen;
039900221003           hasError = *off;
040000221003           errObject = *off;
040100221003           errUser1 = *off;
040200221003           errDate1 = *off;
040300221003           s2Msg = '';
040400221003
040500221003
040600221003
040700221003           if btnSrchUsr = *on;
040800221003             UserLookup( s2UserId : iCancel ) ;
040900221003           EndIf;
041000221003
041100221003           if btnSrchUs2 = *on;
041200221003             UserLookup( s2UserId2 : iCancel ) ;
041300221003           EndIf;
041400221003
041500221003
041600221003           if btnAccept = *on;
041700221003             validate2();
041800221003
041900221003             if hasError = *on;
042000221003               iter;
042100221003             EndIf;
042200221003
042300221003             dupRecords();
042400221003
042500221003             s2msg = 'User: ' + %Trim(s2UserId) +
042600221003                      ' copied to User: ' + %Trim(s2UserId2);
042700221003             //s2UserId = '';
042800221003
042900221003           EndIf;
043000221003
043100221003
043200221003         EndDo;
043300221003
043400221003         btnCancel = *off;
043500221003
043600221003
043700221003       End-Proc;
043800221003
043900221003
044000221006       // ----------------------------------------------------------------
044100221006       Dcl-Proc Deactivate;
044200221006
044300221006         clear DeactScrn;
044400221006
044500221006         if btnDeact = *on;
044600221006         // s2Program = s1Program;
044700221006         // s2Func = s1Func;
044800221006         // s2UserId = s1UserId;
044900221006         // s2Auth = Authorized;
045000221006         endif;
045100221006
045200221006         Dou btnCancel = *on;
045300221006           exfmt DeactScrn;
045400221006           hasError = *off;
045500221006           errObject = *off;
045600221006           errUser1 = *off;
045700221006           errDate = *off;
045800221006           s2Msg = '';
045900221006
046000221006
046100221006           if btnSrchUsr = *on;
046200221006             UserLookup( s2UserId : iCancel ) ;
046300221006           EndIf;
046400221006
046500221006
046600221006           if btnAccept = *on;
046700221006             validate3();
046800221006
046900221006             if hasError = *on;
047000221006               iter;
047100221006             EndIf;
047200221006
047300221006             deactivateUser();
047400221006
047500221006             s2msg = 'User: ' + %Trim(s2UserId) +
047600221006                      ' has been deactivated';
047700221006
047800221006           EndIf;
047900221006
048000221006
048100221006         EndDo;
048200221006
048300221006         btnCancel = *off;
048400221006
048500221006
048600221006       End-Proc;
048700221006
048800221006
048900221006       // ----------------------------------------------------------------
049000221006       Dcl-Proc Reactivate;
049100221006
049200221006         clear ReactScrn;
049300221006
049400221006         if btnReact = *on;
049500221006         // s2Program = s1Program;
049600221006         // s2Func = s1Func;
049700221006         // s2UserId = s1UserId;
049800221006         // s2Auth = Authorized;
049900221006         endif;
050000221006
050100221006         Dou btnCancel = *on;
050200221006           exfmt ReactScrn;
050300221006           hasError = *off;
050400221006           errObject = *off;
050500221006           errUser1 = *off;
050600221006           errDate = *off;
050700221006           s2Msg = '';
050800221006
050900221006
051000221006           if btnSrchUsr = *on;
051100221006             UserLookup( s2UserId : iCancel ) ;
051200221006           EndIf;
051300221006
051400221006
051500221006           if btnAccept = *on;
051600221006             validate4();
051700221006
051800221006             if hasError = *on;
051900221006               iter;
052000221006             EndIf;
052100221006
052200221006             reactivateUser();
052300221006
052400221006             s2msg = 'User: ' + %Trim(s2UserId) +
052500221006                      ' has been reactivated';
052600221006
052700221006           EndIf;
052800221006
052900221006
053000221006         EndDo;
053100221006
053200221006         btnCancel = *off;
053300221006
053400221006
053500221006       End-Proc;
053600221006
053700221006
053800210310       // ----------------------------------------------------------------
053900210310       Dcl-Proc Validate;
054000210310
054100210310         dcl-s ObjCount Zoned(3) inz;
054200210311         dcl-s SDate Zoned(8) inz;
054300210311         dcl-s EDate Zoned(8) inz;
054400210310
054500210310         hasError = *off;
054600210310
054700210310
054800210311         if Mode = 'Add';
054900221122          if s2program <> '*ALL';
055000210310
055100210311           //-----------------------------------
055200210311           //
055300210311           // Check for the objects Existence
055400210311           //
055500210311           //-----------------------------------
055600210311           Exec Sql
055700210311             Select Count(*)
055800210311               Into :ObjCount
055900210311               From
056000210311                 Table (
056100210311                   Qsys2.Object_Statistics(
056200230726                     '*ALLUSR', 'ALL', Object_Name => :s2Program)
056300210311                 );
056400210310
056500210310
056600210311           if objCount = 0;
056700210311             hasError = *on;
056800210311             ErrObject = *on;
056900210311           EndIf;
057000210310
057100221116          endif;
057200210310
057300210310
057400210310
057500210311           //-----------------------------------
057600210311           //
057700210311           // Allready setup?
057800210311           //
057900210311           //-----------------------------------
058000210310
058100210311           chain(n) (s2Program: s2Func : S2UserId) PgmAuthl1;
058200210311           if %Found(PgmAuthl1);
058300210311             hasError = *on;
058400210311             ErrUser1 = *on;
058500210311           EndIf;
058600210310
058700210311         endif;
058800210311
058900210311
059000210311
059100210311         // Verify Date Range.
059200220906         //if s2StrDate > *blanks;
059300220906         if s2StrDate > d'0001-01-01';
059400220906          // SDate = %dec(%char(%date(s2StrDate:*usa/):*iso0):8:0);
059500220906          SDate = %dec(s2StrDate);
059600210311         endif;
059700210310
059800220906         //if s2EndDate > *blanks;
059900220906         if s2EndDate > d'0001-01-01';
060000220906           //EDate = %dec(%char(%date(s2EndDate:*usa/):*iso0):8:0);
060100220906           EDate = %dec(s2EndDate);
060200210311         endif;
060300210310
060400210311         if eDate > 0 and eDate <= sDate;
060500210311           errDate1 = *on;
060600210311           hasError = *on;
060700210311         EndIf;
060800210310
060900210310       End-Proc;
061000210310
061100221003       // ----------------------------------------------------------------
061200221003       Dcl-Proc Validate2;
061300221003
061400221003         dcl-s ObjCount Zoned(3) inz;
061500221003         dcl-s SDate Zoned(8) inz;
061600221003         dcl-s EDate Zoned(8) inz;
061700221003
061800221003         hasError = *off;
061900221003         ErrFUser = *off;
062000221003         ErrTUser = *off;
062100221003         ErrTUser2 = *off;
062200221003
062300221003         if s2userid = s2userid2;
062400221003          ErrTUser2 = *on;
062500221003          hasError = *on;
062600221003         endif;
062700221003
062800221003         if s2userid = ' ';
062900221003          ErrFUser = *on;
063000221003          hasError = *on;
063100221003         endif;
063200221003
063300221003         if s2userid2 = ' ';
063400221003          ErrTUser = *on;
063500221003          hasError = *on;
063600221003         endif;
063700221003
063800221003         // Verify Date Range.
063900221003         if s2StrDate > d'0001-01-01';
064000221003          SDate = %dec(s2StrDate);
064100221003         endif;
064200221003
064300221003         if s2EndDate > d'0001-01-01';
064400221003           EDate = %dec(s2EndDate);
064500221003         endif;
064600221003
064700221003         if eDate > 0 and eDate <= sDate;
064800221003           errDate1 = *on;
064900221003           hasError = *on;
065000221003         EndIf;
065100221003
065200221003       End-Proc;
065300221003
065400221006       // ----------------------------------------------------------------
065500221006       Dcl-Proc Validate3;
065600221006
065700221006         dcl-s ObjCount Zoned(3) inz;
065800221006         dcl-s SDate Zoned(8) inz;
065900221006         dcl-s EDate Zoned(8) inz;
066000221006
066100221006         hasError = *off;
066200221006         ErrDUser = *off;
066300221006         ErrTUser = *off;
066400221006         ErrDate = *off;
066500221006
066600221006         if s2userid = ' ';
066700221006          ErrDUser = *on;
066800221006          hasError = *on;
066900221006         endif;
067000221006
067100221006         // Verify Date.
067200221006         if s2StrDate > d'0001-01-01';
067300221006          if s2StrDate < %date();
067400221006           ErrDate = *on;
067500221006           hasError = *on;
067600221006          endif;
067700221006         endif;
067800221006
067900221006
068000221006       End-Proc;
068100221006
068200221006       // ----------------------------------------------------------------
068300221006       Dcl-Proc Validate4;
068400221006
068500221006         dcl-s ObjCount Zoned(3) inz;
068600221006         dcl-s SDate Zoned(8) inz;
068700221006         dcl-s EDate Zoned(8) inz;
068800221006
068900221006         hasError = *off;
069000221006         ErrDUser = *off;
069100221006         ErrTUser = *off;
069200221006         ErrTUser2 = *off;
069300221006
069400221006         if s2StrDate > d'0001-01-01';
069500221006          if s2StrDate < %date();
069600221006           ErrDate = *on;
069700221006           hasError = *on;
069800221006          endif;
069900221006         endif;
070000221006
070100221006         if s2userid = ' ';
070200221006          ErrDUser = *on;
070300221006          hasError = *on;
070400221006         endif;
070500221006
070600221006
070700221006       End-Proc;
070800221006
070900221006       // ----------------------------------------------------------------
071000221003       Dcl-Proc dupRecords;
071100221003
071200221003        setll *loval r_PgmAuth2;
071300221003        read r_PgmAuth2;
071400221003        dow not %eof;
071500221003
071600221003         delete r_PgmAuth2;
071700221003
071800221003         read r_PgmAuth2;
071900221003        enddo;
072000221003
072100221003        setll s2userid r_PgmAuthx;
072200221003        reade s2userid r_PgmAuthx;
072300221003        dow not %eof;
072400221003
072500221003         write r_PgmAuth2;
072600221003
072700221003         reade s2userid r_PgmAuthx;
072800221003        enddo;
072900221003
073000221003        setll *loval r_PgmAuth2;
073100221003        read r_PgmAuth2;
073200221003        dow not %eof;
073300221003
073400221003         chain (program : function : s2userid2) r_PgmAuth;
073500221003         if not %found;
073600221003
073700221003          if s2StrDate > d'0001-01-01';
073800221003           startdate = %dec(s2StrDate);
073900221003          endif;
074000221003
074100221003          if s2EndDate > d'0001-01-01';
074200221003           enddate = %dec(s2EndDate);
074300221003          endif;
074400221003
074500221003          username = s2userid2;
074600221003           paCrtBy = WQUSRN;
074700221003            paCrtDt = %Dec(%Date);
074800221003             paCrtTm = %Dec(%Time);
074900221003             paChgBy = *Blanks;
075000221003            paChgDt = 0;
075100221003           paChgTm = 0;
075200221003          write r_PgmAuth;
075300221003         endif;
075400221003
075500221003         read r_PgmAuth2;
075600221003        enddo;
075700221003
075800221003        setll *loval r_PgmAuth2;
075900221003        read r_PgmAuth2;
076000221003        dow not %eof;
076100221003
076200221003         delete r_PgmAuth2;
076300221003
076400221003         read r_PgmAuth2;
076500221003        enddo;
076600221003
076700221003
076800221003       End-Proc;
076900221003
077000221003
077100221006       // ----------------------------------------------------------------
077200221006       Dcl-Proc deactivateUser;
077300221006
077400221006        setll s2userid r_PgmAuthx;
077500221006        reade s2userid r_PgmAuthx;
077600221006        dow not %eof;
077700221006
077800221006         if s2StrDate = d'0001-01-01';
077900221006          enddate = %dec(%date);
078000221006         else;
078100221006          enddate = %dec(s2StrDate);
078200221006         endif;
078300221006
078400221006         authorized = 'N';
078500221006         paChgBy = WQUSRN;
078600221006         paChgDt = %dec(%date);
078700221006         paChgTm = %dec(%time);
078800221006
078900221006         update r_PgmAuthx;
079000221006
079100221006         reade s2userid r_PgmAuthx;
079200221006        enddo;
079300221006
079400221006
079500221006       End-Proc;
079600221006
079700221006
079800221006       // ----------------------------------------------------------------
079900221006       Dcl-Proc reactivateUser;
080000221006
080100221006        setll s2userid r_PgmAuthx;
080200221006        reade s2userid r_PgmAuthx;
080300221006        dow not %eof;
080400221006
080500221006         authorized = 'Y';
080600221006
080700221006         if s2StrDate > d'0001-01-01';
080800221006          startdate = %dec(s2StrDate);
080900221006         else;
081000221006          startdate = 0;
081100221006         endif;
081200221006
081300221006         enddate = 0;
081400221006
081500221006         paChgBy = WQUSRN;
081600221006         paChgDt = %dec(%date);
081700221006         paChgTm = %dec(%time);
081800221006
081900221006         update r_PgmAuthx;
082000221006
082100221006         reade s2userid r_PgmAuthx;
082200221006        enddo;
082300221006
082400221006
082500221006       End-Proc;
082600221006
082700221006
082800221003       // ----------------------------------------------------------------
082900210310       Dcl-Proc Init;
083000210310
083100210310         // Check Program Authority
083200210310         ChkPgmAuth(@pgmq : oContinue);
083300210310         if oContinue = 'N';
083400210310           *inlr = *on;
083500210310           Return;
083600210310         endif;
083700210310
083800221003
083900210310       End-Proc;
084000210310
084100210310
084200210311       // ----------------------------------------------------------------
084300210311       Dcl-Proc Load_Data;
084400210311
084500210311
084600210311         chain (s1Program: s1Func : S1UserId) PgmAuthl1;
084700210311         if %Found(PgmAuthl1);
084800210311
084900210311           s2Program = Program;
085000210311           s2Func = Function;
085100210311           s2UserID = UserNAme;
085200210311           s2Auth = Authorized;
085300210311
085400220906           //s2StrDate = '';
085500220906           s2StrDate = d'0001-01-01';
085600210311           if StartDate > 0;
085700220906            // s2StrDate = %char(%date(StartDate:*iso):*usa/);
085800220906             s2StrDate = %date(StartDate:*iso);
085900210311           endif;
086000210311
086100220906           //s2EndDate = '';
086200220906           s2EndDate = d'0001-01-01';
086300210311           if EndDate > 0;
086400220906            // s2EndDate = %char(%date(EndDate:*iso):*usa/);
086500220906             s2EndDate = %date(EndDate:*iso);
086600210311           endif;
086700210311
086800210311           if paCrtby > '';
086900210311             s2Crtby = 'Created by ' + %Trim( paCrtby ) +
087000210311             ' on ' +  %Char(%date(paCrtDt) :*usa) +
087100210311             ' at ' + %Char(%Time(paCrtTm) :*usa);
087200210311           endif;
087300210311
087400210311
087500210311           if paChgBy > '';
087600210311             s2Chgby = 'Changed by ' + %Trim( paChgby ) +
087700210311             ' on ' +  %Char(%date(paChgDt) :*usa) +
087800210311             ' at ' + %Char(%Time(paChgTm) :*usa);
087900210311           endif;
088000210311
088100210311
088200210311         EndIf;
088300210311
088400210311       End-Proc;
088500210311
088600210310
088700210310
088800210311
088900210311       // ----------------------------------------------------------------
089000210311       Dcl-Proc Edit_Data;
089100210311
089200210311         Mode = '';
089300210311
089400210311         Dou btnCancel = *on;
089500210311
089600210311           Exfmt EditScreen;
089700210311           hasError = *off;
089800210311           errDate1 = *off;
089900210311
090000210311           if btnCancel = *on;
090100210311             leave;
090200210311           EndIf;
090300220331
090400220331           if btnSrchUsr = *on;
090500220331             UserLookup( s2UserId : iCancel ) ;
090600220331           EndIf;
090700210311
090800210311           if btnAccept = *on;
090900210311
091000210311             validate();
091100210311
091200210311             if hasError = *on;
091300210311               iter;
091400210311             EndIf;
091500210311
091600210311             //------------------------
091700210311             //
091800210311             // Update Files.
091900210311             //
092000210311             //------------------------
092100210311             Authorized = s2Auth;
092200210311
092300210311             StartDate = 0;
092400220906             //if s2StrDate > *blanks;
092500220906             if s2StrDate > d'0001-01-01';
092600220906              // StartDate = %dec(%char(%date(s2StrDate:*usa/):*iso0):8:0);
092700220906               StartDate = %dec(s2StrDate);
092800210311             endif;
092900210311
093000210311             EndDate = 0;
093100220906             //if s2EndDate > *blanks;
093200220906             if s2EndDate > d'0001-01-01';
093300220906              // EndDate = %dec(%char(%date(s2EndDate:*usa/):*iso0):8:0);
093400220906               EndDate = %dec(s2EndDate);
093500210311             endif;
093600210311
093700220331             program = s2program;
093800220331             username = s2UserId;
093900220331             function = s2func;
094000220324             paChgBy = WQUSRN;
094100210311             paChgDt = %Dec(%Date);
094200210311             paChgTm = %Dec(%Time);
094300210311
094400210311             Update r_PgmAuth;
094500220324             btnCancel = *on;
094600210311
094700210311           EndIf;
094800210311
094900210311
095000210311         enddo;
095100210311
095200210311         btnCancel = *off;
095300210311         unlock PgmAuthl1;
095400210311
095500210311
095600210311       End-Proc;
095700220727
095800220727       // ----------------------------------------------------------------
095900220727
096000220727       dcl-proc Get_Env;
096100220727
096200220727           OutEnvr = GetEnvironment(' ');
096300220727
096400220727           e1envir = outenvr.e1envir;
096500220727           e1libl  = outenvr.e1libl;
096600220727           Library2 = outenvr.e1lib2;
096700220727           envColor = outenvr.envcolor;
096800220727
096900220727
097000220727       End-Proc;
097100210311
097200210310
