000100171229
000200171229       Ctl-Opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*No)
000300190410         ActGrp(*New);
000400171229
000500171229
000600171229      *-------------------------------------------------------------------------
000700171229      *
000800171229      *  Description:  Member Inquiry - Issue Tracking
000900171229      *  Programmer.:  Brian Rees
001000171229      *  Date.......:  06/06/2017
001100171229      *
001200171229      *-------------------------------------------------------------------------
001300171229
001400171229
001500171229      *-------------------------------------------------------------------------
001600171229      *
001700171229      * Declare Files
001800171229      *
001900171229      *-------------------------------------------------------------------------
002000171229       Dcl-f Inq003d WorkStn
002100190410         Handler('PROFOUNDUI(HANDLER)')
002200190410         SFILE(LSTSFL:rrn)
002300190410         SFILE(HISTSFL:rrn2)  ;
002400171229
002500171229
002600171229       dcl-f itissp keyed
002700190410         usage(*Output : *update ) ;
002800171229
002900171229       dcl-f ithisp keyed
003000190410         usage(*Output : *update ) ;
003100171229
003200171229       dcl-f itcodp keyed;
003300171229
003400171229       Dcl-f AccMst keyed
003500190410         ExtDesc('F.ACCMST') ExtFile(*extdesc) ;
003600171229
003700171229       Dcl-f Member keyed
003800190410         ExtDesc('F.MEMBER') ExtFile(*extdesc) ;
003900171229
004000171229       Dcl-f hypercarr keyed;
004100171229
004200171229
004300171229       dcl-f Hist keyed
004400190410         ExtDesc('F.HIST') ExtFile(*extdesc)
004500190410         usage(*Output : *update ) ;
004600161109
004700171229
004800171229
004900171229      *-------------------------------------------------------------------------
005000171229      *
005100171229      * Global Variables
005200171229      *
005300171229      *-------------------------------------------------------------------------
005400171229       dcl-ds pgmd
005500190410         ExtName('IOPGMD') PSDS;
005600171229       end-ds;
005700171229
005800171229
005900171229       Dcl-s rrn Zoned(5) inz;
006000171229       Dcl-s rrn2 Zoned(5) inz;
006100171229
006200171229       dcl-s Reload Char(1);
006300171229       dcl-s Reloads2 Char(1);
006400171229       dcl-s CharSSN Char(9);
006500171229
006600171229       dcl-s HldDate Date(*Iso);
006700171229       dcl-s SqlDow Zoned(1);
006800171229       dcl-s hasError Ind;
006900171229       dcl-s IssueClosed Char(1);
007000171229
007100171229
007200171229       Dcl-ds oCarGrp_DS len(40);
007300190410         oCarGrp1  Char(2);
007400190410         oCarGrp2  Char(2);
007500190410         oCarGrp3  Char(2);
007600190410         oCarGrp4  Char(2);
007700190410         oCarGrp5  Char(2);
007800190410         oCarGrp6  Char(2);
007900190410         oCarGrp7  Char(2);
008000190410         oCarGrp8  Char(2);
008100190410         oCarGrp9  Char(2);
008200190410         oCarGrp10 Char(2);
008300190410         oCarGrp11 Char(2);
008400190410         oCarGrp12 Char(2);
008500190410         oCarGrp13 Char(2);
008600190410         oCarGrp14 Char(2);
008700190410         oCarGrp15 Char(2);
008800190410         oCarGrp16 Char(2);
008900190410         oCarGrp17 Char(2);
009000190410         oCarGrp18 Char(2);
009100190410         oCarGrp19 Char(2);
009200190410         oCarGrp20 Char(2);
009300171229       End-Ds;
009400171229
009500171229
009600171229       Dcl-ds itGroupCd Len(40);
009700190410         itCgr1  Char(2);
009800190410         itCgr2  Char(2);
009900190410         itCgr3  Char(2);
010000190410         itCgr4  Char(2);
010100190410         itCgr5  Char(2);
010200190410         itCgr6  Char(2);
010300190410         itCgr7  Char(2);
010400190410         itCgr8  Char(2);
010500190410         itCgr9  Char(2);
010600190410         itCgr10 Char(2);
010700190410         itCgr11 Char(2);
010800190410         itCgr12 Char(2);
010900190410         itCgr13 Char(2);
011000190410         itCgr14 Char(2);
011100190410         itCgr15 Char(2);
011200190410         itCgr16 Char(2);
011300190410         itCgr17 Char(2);
011400190410         itCgr18 Char(2);
011500190410         itCgr19 Char(2);
011600190410         itCgr20 Char(2);
011700171229       End-Ds;
011800171229
011900171229
012000171229       Dcl-ds s2GroupCd Len(40);
012100190410         s2CarCd1  Char(2);
012200190410         s2CarCd2  Char(2);
012300190410         s2CarCd3  Char(2);
012400190410         s2CarCd4  Char(2);
012500190410         s2CarCd5  Char(2);
012600190410         s2CarCd6  Char(2);
012700190410         s2CarCd7  Char(2);
012800190410         s2CarCd8  Char(2);
012900190410         s2CarCd9  Char(2);
013000190410         s2CarCd10 Char(2);
013100190410         s2CarCd11 Char(2);
013200190410         s2CarCd12 Char(2);
013300190410         s2CarCd13 Char(2);
013400190410         s2CarCd14 Char(2);
013500190410         s2CarCd15 Char(2);
013600190410         s2CarCd16 Char(2);
013700190410         s2CarCd17 Char(2);
013800190410         s2CarCd18 Char(2);
013900190410         s2CarCd19 Char(2);
014000190410         s2CarCd20 Char(2);
014100171229       End-Ds;
014200171229
014300171229
014400171020
014500161111      *--------------------------------------------
014600171229      *
014700171229      * Procedures
014800171229      *
014900161111      *--------------------------------------------
015000171229
015100171229       Dcl-pr CarrSelect ExtPgm('INQ004R');
015200190410         oTrst Zoned(3);
015300190410         oSub# Zoned(3);
015400190410         oMember Zoned(9);
015500190410         oAcct  Zoned(4);
015600190410         oCarGrp Char(40);
015700190410         oCancel Char(1);
015800171229       End-Pr;
015900190410
016000190410       dcl-s oAcct Zoned(4);
016100171229       dcl-s oCarGrp Char(40);
016200171229       dcl-s oCancel Char(1);
016300171229
016400171229
016500170919
016600171229       dcl-pr SendEmail ExtPgm('ITEMAILC');
016700190410         oTo Char(20);
016800190410         oSubject Char(60);
016900190410         oText Char(755);
017000171229       End-Pr;
017100171229
017200171229       dcl-s rfeTo Char(20);
017300171229       dcl-s rfeSubj Char(60);
017400171229       dcl-s rfeText Char(755);
017500171019
017600180404
017700180404      *-------------------------------------------------------------------------
017800180404      *
017900180404      * *Entry Procedure
018000180404      *
018100180404      *-------------------------------------------------------------------------
018200180404       Dcl-pr Main ExtPgm;
018300190410         *N  Zoned(3);
018400190410         *N  Zoned(3);
018500190410         *N  Zoned(4);
018600190410         *N  Zoned(9);
018700180404       End-Pr;
018800180404
018900180404       dcl-pi Main;
019000190410         pTrst  Zoned(3);
019100190410         pSub#  Zoned(3);
019200190410         pAcct  Zoned(4);
019300190410         pMember  Zoned(9);
019400180404       End-Pi;
019500180404
019600180404
019700161111
019800171229      *-------------------------------------------------------------------------
019900171229      *
020000171229      * Mainline Program
020100171229      *
020200171229      *-------------------------------------------------------------------------
020300170606
020400190410       Exec Sql
020500190410          Set Option Commit = *None, Naming = *Sys;
020600171229       Reload = 'Y';
020700170606
020800171229       // Set Visibility Properites if this is a Member;
020900171128       isMember = *off;
021000171128       if pMember > 0;
021100190410         isMember = *on;
021200171128       endif;
021300170607
021400171128
021500171128
021600170901       CharSSN = %Editc(pMember : 'X');
021700170901       s1ssn = %Subst(CharSSN:1:3) + '-' +
021800190410         %Subst(CharSSN:4:2) + '-' +
021900190410         %Subst(CharSSN:6:4) ;
022000170606
022100170901       chain pMember Member;
022200170901       chain (ptrst :  pSub# : pAcct ) AccMst;
022300170607
022400170901       s1FulName = %Trim(mlname) + ', ' + %Trim(mfname);
022500170901       s1ActNbr = %Editc(pTrst:'X') + '-' + %Editc(pSub#:'X') + '-' +
022600190410         %Editc(pAcct:'X');
022700170901       s1ActName = acNam1;
022800170606
022900170905
023000170905
023100170905       //----------------------------------------------------------
023200171229       // Load Subfile
023300170905       //----------------------------------------------------------
023400170901       Dou btnExit = *on;
023500161109
023600190410         If Reload = 'Y';
023700190410           ClearS1();
023800171128
023900190410           if pMember > 0;
024000190410             Load_Mbr();
024100190410           else;
024200190410             Load_Acct();
024300190410           endif;
024400171128
024500171128
024600190410           Reload = 'N';
024700190410         endIf;
024800161109
024900190410         DISPLY();
025000161109
025100161109
025200190410         // Process Selections
025300190410         Select;
025400161109
025500190410         When btnAddNew = *on;
025600190410           Add_Screen();
025700190410           Reload = 'Y';
025800170922
025900161109
026000190410         When ChgOpnOnly = *on;
026100190410           Reload = 'Y';
026200170817
026300170922
026400190410         other;
026500190410           ReadChanged();
026600161109
026700190410         EndSl;
026800161109
026900161109
027000170901       enddo;
027100161109
027200170901       *inlr = *on;
027300161109
027400170905       //-----------------------------------------------------------------
027500171229       dcl-proc ClearS1;
027600161109
027700190410         // Clear the Subfile
027800190410         ClrSfl = *on;
027900190410         Write Screen1;
028000190410         ClrSfl = *off;
028100190410         rrn = 0;
028200161109
028300171229       end-proc;
028400170905
028500170905       //-----------------------------------------------------------------
028600170920       //
028700171229       // Load the Subfile Data..   MEMBER
028800170920       //
028900170905       //-----------------------------------------------------------------
029000171229       dcl-proc Load_Mbr;
029100170606
029200190410         Setll ( pTrst: pSub# : pAcct : pMember ) itissp;
029300190410         Dou %eof(itissp);
029400161109
029500190410           reade(n) ( pTrst: pSub# : pAcct : pMember ) itissp;
029600190410           if %eof(itissp);
029700190410             leave;
029800190410           endif;
029900161109
030000171128
030100190410           s1GridSsn = *Blanks;
030200190410           s1GridFN = *Blanks;
030300190410           s1w_ssn = 0;
030400180606
030500190410           if itmssn > 0;
030600190410             CharSSN = %Editc(itmssn : 'X');
030700190410             s1GridSsn = %Subst(CharSSN:1:3) + '-' +
030800190410               %Subst(CharSSN:4:2) + '-' +
030900190410               %Subst(CharSSN:6:4) ;
031000171130
031100190410             s1w_ssn = itmssn;
031200190410             chain itmssn Member;
031300190410             s1GridFN = %Trim(mlname) + ', ' + %Trim(mfname);
031400171130
031500190410           endif;
031600171128
031700171128
031800190410           s1iss# = itiss#;
031900190410           s1init = itinit;
032000190410           s1Typc = ittypc;
032100170817
032200190410           s1Sbjt = itSbjt;
032300170606
032400190410           s1dato = *Blanks;
032500190410           if itdato > 0;
032600190410             s1dato = %Char(%Date(itdato:*iso):*Usa);
032700190410           endif;
032800170606
032900190410           s1fudt = *Blanks;
033000190410           if itfudt > 0;
033100190410             s1fudt = %Char( %Date(itfudt:*iso):*usa);
033200190410           endif;
033300170606
033400190410           s1datc = *Blanks;
033500190410           if itdatc > 0;
033600190410             s1datc = %Char(%Date(itdatc:*iso):*Usa);
033700190410           endif;
033800170606
033900170817
034000190410           // Check the open issues only checkbox.
034100190410           if chkOpnOnly = '';
034200190410             rrn = rrn + 1;
034300190410             write LstSfl;
034400190410           else;
034500190410             if itSts = 'O';
034600190410               rrn = rrn + 1;
034700190410               write LstSfl;
034800190410             endif;
034900190410           endif;
035000170817
035100170817
035200190410           If rrn >= 9999;
035300190410             leave;
035400190410           endIf;
035500161109
035600190410         enddo;
035700161109
035800171229       end-proc;
035900161109
036000171128
036100171128       //-----------------------------------------------------------------
036200171128       //
036300171229       // Load the Subfile Data..   ACCOUNT
036400171128       //
036500171128       //-----------------------------------------------------------------
036600171229       dcl-proc Load_Acct;
036700171128
036800190410         Setll ( pTrst: pSub# : pAcct ) itissp ;
036900190410         Dou %eof(itissp );
037000171128
037100190410           reade(n) ( pTrst: pSub# : pAcct ) itissp ;
037200190410           if %eof(itissp );
037300190410             leave;
037400190410           endif;
037500171128
037600190410           s1GridSsn = *Blanks;
037700190410           s1GridFN = *Blanks;
037800190410           s1w_ssn = 0;
037900180606
038000190410           if itmssn > 0;
038100190410             CharSSN = %Editc(itmssn : 'X');
038200190410             s1GridSsn = %Subst(CharSSN:1:3) + '-' +
038300190410               %Subst(CharSSN:4:2) + '-' +
038400190410               %Subst(CharSSN:6:4) ;
038500171130
038600190410             s1w_ssn = itmssn;
038700190410             chain itmssn Member;
038800190410             s1GridFN = %Trim(mlname) + ', ' + %Trim(mfname);
038900190410           endif;
039000171128
039100171128
039200190410           s1iss# = itiss#;
039300190410           s1init = itinit;
039400190410           s1Typc = ittypc;
039500171128
039600190410           s1Sbjt = itSbjt;
039700171128
039800190410           s1dato = *Blanks;
039900190410           if itdato > 0;
040000190410             s1dato = %Char(%Date(itdato:*iso):*Usa);
040100190410           endif;
040200171128
040300190410           s1fudt = *Blanks;
040400190410           if itfudt > 0;
040500190410             s1fudt = %Char( %Date(itfudt:*iso):*usa);
040600190410           endif;
040700171128
040800190410           s1datc = *Blanks;
040900190410           if itdatc > 0;
041000190410             s1datc = %Char(%Date(itdatc:*iso):*Usa);
041100190410           endif;
041200171128
041300171128
041400190410           // Check the open issues only checkbox.
041500190410           if chkOpnOnly = '';
041600190410             rrn = rrn + 1;
041700190410             write LstSfl;
041800190410           else;
041900190410             if itSts = 'O';
042000190410               rrn = rrn + 1;
042100190410               write LstSfl;
042200190410             endif;
042300190410           endif;
042400171128
042500171128
042600190410           If rrn >= 9999;
042700190410             leave;
042800190410           endIf;
042900171128
043000190410         enddo;
043100171128
043200171229       end-proc;
043300171128
043400170905       //-----------------------------------------------------------------
043500171229       dcl-proc DISPLY;
043600161109
043700190410         DspSfl = *on  ;
043800190410         exfmt Screen1;
043900190410         DspSfl = *off;
044000161109
044100171229       end-proc;
044200170905       //-----------------------------------------------------------------
044300171229       dcl-proc ReadChanged;
044400161109
044500190410         Dou *in95 = *ON;
044600190410           READC LstSfl;
044700190410           *in95 = %EOF;
044800161109
044900190410           If *in95 = *OFF;
045000161109
045100190410             If btnEdit = *on;
045200190410               LoadIssueDta();
045300190410               EditIssue();
045400190410             endIf;
045500161118
045600170320
045700190410             If btnView = *on;
045800190410               LoadIssueDta();
045900190410               ViewIssue();
046000190410             endIf;
046100170607
046200190410             If btnHist = *on;
046300190410               ReloadS2 = 'Y';
046400190410               LoadHistory();
046500190410             endIf;
046600170726
046700170607
046800170320
046900190410             btnEdit = *off;
047000190410             btnView = *off;
047100190410             btnHist = *off;
047200190410             update LstSfl;
047300161109
047400190410             Reload = 'Y';
047500190410           endIf;
047600161118
047700161109
047800190410         enddo;
047900171229       end-proc;
048000161109
048100161109
048200170901       //-----------------------------------------------------------------
048300170920       //
048400171229       //                        ADD Screen
048500170920       //
048600170901       //-----------------------------------------------------------------
048700171229       dcl-proc Add_Screen;
048800161109
048900190410         Clear AddScreen;
049000170921
049100190410         s2ActNbr  = s1ActNbr;
049200190410         s2ActName = s1ActName;
049300170920
049400190410         s2init = wqusrn;
049500190410         s2dato = %Date;
049600190410         s2timo = %Time;
049700170920
049800190410         // Default the Follow up Date to be 2 days..
049900190410         HldDate = %Date + %Days(2);
050000170920
050100190410         Exec Sql
050200190410            Select Dayofweek(:hlddate)
050300190410               Into :sqldow
050400190410               From sysibm.sysdummy1 ;
050500170920
050600190410         // If the 2nd day is the weekend, grab Mondays Date
050700190410         if SqlDow = 1 or SqlDow = 7;
050800190410           Exec Sql
050900190410              Select Next_Day(Current_Date, 'MON')
051000190410                 Into :hlddate
051100190410                 From sysibm.sysdummy1;
051200190410         endif;
051300170920
051400170920
051500190410         s2fudt = HldDate;
051600170920
051700170920
051800170920
051900190410         // Get the Next ISS Tracking Number.
052000190410         Exec Sql
052100190410            Select Max(itiss#)
052200190410               Into :s2iss#
052300190410               From itissp;
052400190410         s2iss# = s2iss# + 1;
052500170920
052600170920
052700170920
052800190410         //------------------------------------------------------
052900190410         //
053000190410         // Display ADD Scren Page...
053100190410         //
053200190410         //------------------------------------------------------
053300190410         Dou btnCancel = *on;
053400170920
053500190410           exfmt AddScreen;
053600161110
053700161109
053800190410           if btnCancel = *on;
053900190410             leave;
054000190410           endif;
054100161109
054200170920
054300190410           // Add / Modify Carriers
054400190410           if btnAddCar = *on;
054500190410             CarrSelect( pTrst : pSub# : pMember : pAcct :
054600190410               oCarGrp : oCancel );
054700190410             if oCancel = *Blanks;
054800190410               oCarGrp_DS = oCarGrp;
054900190410               s2GroupCd  = oCarGrp_ds;
055000190410               LoadS2_Carr();
055100190410             endif;
055200190410             btnAddCar = *off;
055300190410           Endif;
055400170920
055500161109
055600190410           if btnAccept = *on;
055700161109
055800170921
055900190410             // Validate...
056000190410             Validate_Add();
056100190410             if hasError = *on;
056200190410               iter;
056300190410             endif;
056400170922
056500170922
056600190410             //----------------------------------------------
056700190410             // No Errors - Add.
056800190410             //----------------------------------------------
056900171010
057000171010
057100190410             ihText = 'ISSUE ' + %CHAR( s2Iss# ) + ' OPENED';
057200190410             ihtypc = 'H';
057300190410             Write_Hist();
057400171010
057500171010
057600190410             // Write Records to Database
057700190410             itTrst = pTrst;
057800190410             itSub# = pSub#;
057900190410             itAcct = pAcct;
058000190410             itmssn = pMember;
058100170922
058200190410             itiss# = s2iss#;
058300190410             itInit = s2init;
058400190410             itfudt = %Dec( s2fudt );
058500190410             itvewc = s5vewc;
058600190410             ittypc = s5typc;
058700190410             itdato = %Dec( s2dato );
058800190410             ittimo = %Dec( s2timo );
058900190410             itdatc = 0;
059000190410             ittimc = 0;
059100190410             itsbjt = s5Sbjt;
059200190410             itrefr = s5refr;
059300190410             itrefd = 0;
059400190410             if s2refd_d > *Blanks;
059500190410               itrefd = %Dec( s2refd );
059600190410             EndIf;
059700170922
059800190410             itresp = s5Resp;
059900170922
060000190410             itGroupCd = s2GroupCd;
060100190410             itDesc = s5Desc;
060200190410             itSts = 'O';
060300170922
060400170922
060500190410             write itissr;
060600170921
060700171010
060800190410             // Write F.Hist Record
060900190410             trCode = 'UIO';
061000190410             ck#Not = 'ISSUE TRACKING #' + %editc(s2iss#:'X') + ' OPENED';
061100190410             note2  = s5sbjt ;
061200190410             WriteHist();
061300171010
061400171019
061500190410             // Send Referral Email
061600190410             if s5refr > *Blanks;
061700190410               Ref_Email();
061800190410             endif;
061900171019
062000171019
062100170321
062200190410             return;
062300190410           endif;
062400161109
062500190410         Enddo;
062600161109
062700171229       end-proc;
062800170607
062900170607
063000170901       //-----------------------------------------------------------------
063100170920       //
063200171229       //                        Load Issue Data
063300170920       //
063400170901       //-----------------------------------------------------------------
063500171229       dcl-proc LoadIssueDta;
063600170607
063700190410         // chain(n) ( pTrst : pSub# : pAcct : pMember : s1iss# ) itissp;
063800190410         chain(n) ( pTrst : pSub# : pAcct : s1w_Ssn : s1iss# ) itissp;
063900170607
064000190410         s2iss# = itiss#;
064100190410         s1ssn = S1Gridssn;
064200170608
064300190410         Clear s2dato;
064400190410         if itdato > 0;
064500190410           s2dato = %Date(itdato:*iso);
064600190410         endif;
064700170608
064800190410         clear s2fudt;
064900190410         s2fudt_D = *Blanks;
065000190410         if itfudt > 0;
065100190410           s2fudt = %Date(itfudt:*iso);
065200190410           s2fudt_D = %Char(%Date(itfudt:*iso):*usa);
065300190410         endif;
065400170608
065500190410         s2datc = 'OPEN';
065600190410         if itdatc > 0;
065700190410           s2datc = %Char(%Date(itdatc:*iso):*Usa);
065800190410         endif;
065900170608
066000170607
066100190410         s2init = itInit;
066200170608
066300190410         s2timo = %Time(ittimo);
066400170608
066500190410         s2Timc = *Blanks;
066600190410         if ittimc > 0;
066700190410           s2timc = %Char(%Time(ittimc) :*usa);
066800190410         endif;
066900170608
067000190410         s2resp = itResp;
067100190410         chain ('Q' : itResp ) itCodp;
067200190410         if %Found( itCodp );
067300190410           s2Resp = icText;
067400190410         endif;
067500170725
067600170725
067700190410         s2typc = ittypc;
067800190410         s2Vewc = itVewc;
067900170608
068000190410         Clear s2Refd;
068100190410         s2Refd_d = *Blanks;
068200190410         if itRefd > 0;
068300190410           s2Refd_d = %Char(%Date(itrefd:*iso):*usa);
068400190410           s2Refd =  %Date(itrefd:*iso);
068500190410         endif;
068600170607
068700190410         s2Sbjt = itSbjt;
068800170817
068900190410         s2refr = itrefr;
069000190410         s2reft = itreft;
069100170607
069200190410         s2GroupCd = itGroupCd;
069300190410         LoadCarrier();
069400170607
069500190410         s2Desc = itDesc;
069600170607
069700170607
069800170607
069900171229       end-proc;
070000170920
070100170901       //-----------------------------------------------------------------
070200170920       //
070300171229       //                        Load Carriers
070400170920       //
070500170901       //-----------------------------------------------------------------
070600171229       dcl-proc LoadCarrier;
070700170608
070800190410         s2Car1 = #GetCarrier(itcgr1);
070900190410         s2Car2 = #GetCarrier(itcgr2);
071000190410         s2Car3 = #GetCarrier(itcgr3);
071100190410         s2Car4 = #GetCarrier(itcgr4);
071200190410         s2Car5 = #GetCarrier(itcgr5);
071300190410         s2Car6 = #GetCarrier(itcgr6);
071400190410         s2Car7 = #GetCarrier(itcgr7);
071500190410         s2Car8 = #GetCarrier(itcgr8);
071600190410         s2Car9 = #GetCarrier(itcgr9);
071700190410         s2Car10 = #GetCarrier(itcgr10);
071800190410         s2Car11 = #GetCarrier(itcgr11);
071900190410         s2Car12 = #GetCarrier(itcgr12);
072000190410         s2Car13 = #GetCarrier(itcgr13);
072100190410         s2Car14 = #GetCarrier(itcgr14);
072200190410         s2Car15 = #GetCarrier(itcgr15);
072300190410         s2Car16 = #GetCarrier(itcgr16);
072400190410         s2Car17 = #GetCarrier(itcgr17);
072500190410         s2Car18 = #GetCarrier(itcgr18);
072600190410         s2Car19 = #GetCarrier(itcgr19);
072700190410         s2Car20 = #GetCarrier(itcgr20);
072800170608
072900171229       end-proc;
073000170920
073100170920       //-----------------------------------------------------------------
073200170920       //
073300171229       //                        Load Carriers
073400170920       //
073500170920       //-----------------------------------------------------------------
073600171229       dcl-proc Loads2_Carr;
073700170920
073800190410         s2Car1 = #GetCarrier(oCarGrp1);
073900190410         s2Car2 = #GetCarrier(oCarGrp2);
074000190410         s2Car3 = #GetCarrier(oCarGrp3);
074100190410         s2Car4 = #GetCarrier(oCarGrp4);
074200190410         s2Car5 = #GetCarrier(oCarGrp5);
074300190410         s2Car6 = #GetCarrier(oCarGrp6);
074400190410         s2Car7 = #GetCarrier(oCarGrp7);
074500190410         s2Car8 = #GetCarrier(oCarGrp8);
074600190410         s2Car9 = #GetCarrier(oCarGrp9);
074700190410         s2Car10 = #GetCarrier(oCarGrp10);
074800190410         s2Car11 = #GetCarrier(oCarGrp11);
074900190410         s2Car12 = #GetCarrier(oCarGrp12);
075000190410         s2Car13 = #GetCarrier(oCarGrp13);
075100190410         s2Car14 = #GetCarrier(oCarGrp14);
075200190410         s2Car15 = #GetCarrier(oCarGrp15);
075300190410         s2Car16 = #GetCarrier(oCarGrp16);
075400190410         s2Car17 = #GetCarrier(oCarGrp17);
075500190410         s2Car18 = #GetCarrier(oCarGrp18);
075600190410         s2Car19 = #GetCarrier(oCarGrp19);
075700190410         s2Car20 = #GetCarrier(oCarGrp20);
075800170920
075900171229       end-proc;
076000170901       //-----------------------------------------------------------------
076100171229       //                        View Issue
076200170901       //-----------------------------------------------------------------
076300171229       dcl-proc ViewIssue;
076400170607
076500170607
076600190410         Dou btnCancel = *on;
076700170607
076800190410           exfmt ViewScreen;
076900170607
077000190410           if btnCancel = *on;
077100190410             leave;
077200190410           endif;
077300170607
077400190410         Enddo;
077500170607
077600171229       end-proc;
077700170726
077800170901       //-----------------------------------------------------------------
077900170920       //
078000171229       //                        Edit Issue
078100170920       //
078200170901       //-----------------------------------------------------------------
078300171229       dcl-proc EditIssue;
078400170817
078500170817
078600190410         Dou btnCancel = *on;
078700170817
078800190410           exfmt EditScreen;
078900170817
079000190410           if btnCancel = *on;
079100190410             leave;
079200190410           endif;
079300170817
079400170919
079500190410           if btnAddCar = *on;
079600190410             CarrSelect( pTrst : pSub# : pMember : pAcct :
079700190410                           oCarGrp : oCancel );
079800190410             if oCancel = *Blanks;
079900190410               oCarGrp_DS = oCarGrp;
080000190410               s2GroupCd  = oCarGrp_ds;
080100190410               LoadS2_Carr();
080200190410             endif;
080300190410             btnAddCar = *off;
080400190410           Endif;
080500170919
080600171010
080700190410           // Close the Issue
080800190410           if btnClose = *on;
080900171019
081000190410             issueClosed = 'N';
081100190410             s4Desc = '';
081200190410             Close_Issue();
081300171019
081400190410             if issueClosed = 'Y';
081500190410               leave;
081600190410             endif;
081700171019
081800190410           endif;
081900171010
082000171010
082100171019
082200171019
082300190410           if btnUpdate = *on;
082400170817
082500190410             // Validate...
082600190410             Validate_Edit();
082700190410             if hasError = *on;
082800190410               iter;
082900190410             endif;
083000170921
083100170817
083200190410             // Chain and Update..
083300190410             chain ( pTrst : pSub# : pAcct : pMember : s2iss# ) itissp;
083400170921
083500190410             // Write History Records...
083600190410             if itfudt <> %dec( s2fudt ) ;
083700190410               ihText = 'Follow up Date was changed.';
083800190410               ihtypc = 'C';
083900190410               Write_Hist();
084000190410             endif;
084100170921
084200190410             if itrefd <> %dec( s2refd ) ;
084300190410               ihText = 'Referral Date was changed.';
084400190410               ihtypc = 'C';
084500190410               Write_Hist();
084600190410             endif;
084700170921
084800190410             if itSbjt <> s2sbjt;
084900190410               ihText = 'Subject Text was changed.';
085000190410               ihtypc = 'C';
085100190410               Write_Hist();
085200190410             endif;
085300170921
085400190410             if itreft <> s2reft;
085500190410               ihText = 'Referral Text was changed.';
085600190410               ihtypc = 'C';
085700190410               Write_Hist();
085800190410             endif;
085900170921
086000190410             if itdesc <> s2Desc ;
086100190410               ihText = 'Issue Description was changed.';
086200190410               ihtypc = 'C';
086300190410               Write_Hist();
086400190410             endif;
086500170921
086600190410             if itGroupCd <> s2GroupCd ;
086700190410               ihText = 'Associated Carriers were changed.';
086800190410               ihtypc = 'C';
086900190410               Write_Hist();
087000190410             endif;
087100170921
087200190410             if itVewc <> s2vewc;
087300190410               ihText = 'Viewable by was changed.';
087400190410               ihtypc = 'C';
087500190410               Write_Hist();
087600190410             endif;
087700170921
087800190410             if itTypc <> s2typc;
087900190410               ihText = 'Issue Type was changed.';
088000190410               ihtypc = 'C';
088100190410               Write_Hist();
088200190410             endif;
088300170921
088400190410             if itRefr <> s2Refr;
088500190410               ihText = 'Referred to was changed.';
088600190410               ihtypc = 'C';
088700190410               Write_Hist();
088800171020
088900190410               // Send Referred Changed Email.
089000190410               Ref_ChgEmail();
089100171020
089200190410             endif;
089300170921
089400170921
089500190410             // Update Database...
089600190410             itfudt = %dec( s2fudt );
089700190410             itrefd = %dec( s2refd );
089800190410             itSbjt = s2sbjt;
089900190410             itreft = s2reft;
090000190410             itdesc = s2desc;
090100190410             itGroupCd = s2GroupCd;
090200190410             itTypc = s2Typc;
090300190410             itVewc = s2vewc;
090400190410             itrefr = s2refr;
090500170921
090600170921
090700190410             update itissr;
090800190410             leave;
090900190410           endif;
091000171010
091100190410         Enddo;
091200170817
091300190410         btnUpdate = *Off;
091400190410         btnClose  = *Off;
091500171010
091600171229       end-proc;
091700170817
091800170921
091900170921       //-----------------------------------------------------------------
092000170921       //
092100171229       //                      Write History Records
092200170921       //
092300170921       //-----------------------------------------------------------------
092400171229       dcl-proc Write_Hist;
092500170921
092600190410         // Get the Next History Number.
092700190410         Exec Sql
092800190410            Select Max(ihhis#)
092900190410               Into :ihhis#
093000190410               From ithisp
093100190410               Where ihiss# = :s2iss#;
093200190410         ihhis# = ihhis# + 1;
093300170921
093400170921
093500190410         ihiss# = s2iss#;
093600190410         ihDate = %Dec( %Date );
093700190410         ihTime = %Dec( %Time );
093800190410         ihUser = wqUsrn;
093900170921
094000190410         Write ithisr;
094100170921
094200171229       end-proc;
094300170921
094400170921       //-----------------------------------------------------------------
094500170921       //
094600171229       //                      Validate Edit Screen
094700170921       //
094800170921       //-----------------------------------------------------------------
094900171229       dcl-proc Validate_Edit;
095000170921
095100190410         hasError = *off;
095200190410         errFudt = *off;
095300170921
095400190410         if s2fudt < %Date() and s2fudt > d'0001-01-01';
095500190410           errFudt = *on;
095600190410           hasError = *on;
095700190410         endif;
095800170922
095900170922
096000190410         if s2refd < %Date() and s2refd > d'0001-01-01';
096100190410           errRefd = *on;
096200190410           hasError = *on;
096300190410         endif;
096400170921
096500171229       end-proc;
096600170921
096700170922
096800170922       //-----------------------------------------------------------------
096900170922       //
097000171229       //                      Validate Add Screen
097100170922       //
097200170922       //-----------------------------------------------------------------
097300171229       dcl-proc Validate_Add;
097400170922
097500190410         hasError = *off;
097600190410         errCarrier = *off;
097700190410         errFudt = *off;
097800190410         errRefd = *off;
097900170922
098000170922
098100190410         if s2GroupCd = *blanks;
098200190410           errCarrier = *on;
098300190410           hasError = *on;
098400190410         endif;
098500170922
098600170922
098700190410         if s2fudt < %Date() and s2fudt > d'0001-01-01';
098800190410           errFudt = *on;
098900190410           hasError = *on;
099000190410         endif;
099100170922
099200170922
099300190410         if s2refd < %Date() and s2refd > d'0001-01-01';
099400190410           errRefd = *on;
099500190410           hasError = *on;
099600190410         endif;
099700170922
099800171229       end-proc;
099900170922
100000170901       //-----------------------------------------------------------------
100100170901       //
100200171229       //                      Load History Subfile
100300170901       //
100400170901       //-----------------------------------------------------------------
100500171229       dcl-proc LoadHistory;
100600170608
100700170726
100800190410         Dou btnExit = *on;
100900170726
101000190410           If ReloadS2 = 'Y';
101100190410             ClearS2();
101200190410             LoadS2();
101300190410             Reloads2 = 'N';
101400190410           endIf;
101500170726
101600190410           DisplyS2();
101700170726
101800170726
101900190410           // Process Selections
102000190410           Select;
102100170726
102200190410           When btnAddHst = *on;
102300190410             AddHistRcd_It();       // Issue Tracking
102400190410             Reload = 'Y';
102500170726
102600190410           other;
102700190410             ReadChangedS2();
102800170726
102900190410           EndSl;
103000170726
103100170726
103200190410         enddo;
103300170726
103400170726
103500190410         btnExit = *off;
103600170726
103700170726
103800171229       end-proc;
103900170726
104000170901       // ----------------------------------------------------------------
104100171229       dcl-proc ClearS2;
104200170726
104300190410         // Clear the Subfile
104400190410         ClrSfl = *on;
104500190410         Write Screen2;
104600190410         ClrSfl = *off;
104700190410         rrn2 = 0;
104800170726
104900171229       end-proc;
105000170726
105100170901       // ----------------------------------------------------------------
105200171229       dcl-proc DisplyS2;
105300170726
105400190410         DspSfl = *on  ;
105500190410         exfmt Screen2;
105600190410         DspSfl = *off;
105700170726
105800171229       end-proc;
105900170726
106000170901       // ----------------------------------------------------------------
106100171229       dcl-proc Loads2;
106200170726
106300190410         s3iss# = s1iss#;
106400190410         s3Sbjt = s1Sbjt;
106500190410         s1ssn = S1Gridssn;
106600171130
106700171130
106800190410         Setll s3iss# ithisp;
106900190410         Dou %eof(ithisp);
107000170726
107100190410           reade s3iss# ithisp;
107200190410           if %eof(ithisp);
107300190410             leave;
107400190410           endif;
107500170726
107600190410           s3hDate = %Char(%Date(ihDate:*iso):*Usa);
107700190410           s3hUser = ihUser;
107800190410           s3hText = ihText;
107900190410           s3his#  = ihhis#;
108000170726
108100190410           rrn2 = rrn2 + 1;
108200190410           Write HistSfl;
108300170726
108400190410         Enddo;
108500170726
108600171229       end-proc;
108700170726
108800170726
108900170901       // ----------------------------------------------------------------
109000171229       dcl-proc ReadChangedS2;
109100170817
109200190410         Dou *in95 = *ON;
109300190410           READC HistSfl;
109400190410           *in95 = %EOF;
109500170817
109600190410           If *in95 = *OFF;
109700170817
109800190410             If btnView = *on;
109900190410               LoadHistRcd();
110000190410               ViewHistRcd();
110100190410             endIf;
110200170817
110300190410             btnView = *off;
110400190410             update HistSfl;
110500170817
110600190410             Reload = 'Y';
110700190410           endIf;
110800170817
110900170817
111000190410         enddo;
111100171229       end-proc;
111200170817
111300170901       // ----------------------------------------------------------------
111400171229       dcl-proc LoadHistRcd;
111500170817
111600190410         chain  ( s3iss# : s3his# ) ithisp;
111700190410         chain(n) ( pTrst : pSub# : pAcct : pMember : s3iss# ) itissp;
111800190410         s1ssn = s1GridSsn;
111900170901
112000190410         s4iss# = ihiss#;
112100190410         Clear s4dato;
112200190410         if itdato > 0;
112300190410           s4dato = %Date(itdato:*iso);
112400190410         endif;
112500170817
112600190410         s4datc = 'OPEN';
112700190410         if itdatc > 0;
112800190410           s4datc = %Char(%Date(itdatc:*iso):*Usa);
112900190410         endif;
113000170817
113100190410         s4fudt = *Blanks;
113200190410         if itfudt > 0;
113300190410           s4fudt = %char(%Date(itfudt:*iso): *usa);
113400190410         endif;
113500170817
113600190410         s4Type = ittypc;
113700190410         chain ( 'T' : ittypc ) itCodp;
113800190410         if %found( itCodp ) ;
113900190410           s4Type = icText;
114000190410         endif;
114100170817
114200190410         s4init = itInit;
114300170817
114400190410         s4Timo = *Blanks;
114500190410         if ittimo > 0;
114600190410           s4timo = %Char(%Time(ittimo) :*usa);
114700190410         endif;
114800170817
114900190410         s4Timc = *Blanks;
115000190410         if ittimc > 0;
115100190410           s4timc = %Char(%Time(ittimc) :*usa);
115200190410         endif;
115300170817
115400190410         s4resp = itResp;
115500190410         chain ('Q' : itResp ) itCodp;
115600190410         if %Found( itCodp );
115700190410           s4Resp = icText;
115800190410         endif;
115900170817
116000190410         s4sbjt = itSbjt;
116100170817
116200190410         HstRcdTxt = 'History record created by ' + %Trim(ihuser) + ' on ' +
116300190410           %Char(%date(ihDate) :*usa) + ' at ' +
116400190410           %Char(%Time(ihTime) :*usa);
116500170817
116600190410         s4Desc = ihText;
116700170817
116800171229       end-proc;
116900170817
117000170726
117100170817
117200170901       // ----------------------------------------------------------------
117300171229       dcl-proc ViewHistRcd;
117400170817
117500190410         exfmt HistDtl;
117600170817
117700170817
117800171229       end-proc;
117900170817
118000170905
118100170905       //----------------------------------------------------------------
118200171229       //                    Add History Record - Issue Tracking History
118300170905       //----------------------------------------------------------------
118400171229       dcl-proc AddHistRcd_It;
118500170905
118600170905
118700190410         LoadHistRcd();
118800170905
118900190410         // Initialize
119000190410         HstRcdTxt = 'History Detail';
119100190410         s4Desc = *Blanks;
119200170905
119300190410         Dou btnExit = *on;
119400190410           exfmt AddHist;
119500170905
119600190410           if btnExit = *on;
119700190410             leave;
119800190410           endif;
119900170905
120000190410           // Validation is done on the Screen
120100170905
120200190410           if btnAccept = *on;
120300190410             Exec Sql
120400190410                Insert Into ithisp
120500190410                   Values (:s4iss#,
120600190410                         (Select Max(ihhis#) + 1
120700190410                             From ithisp
120800190410                             Where ihiss# = :s4iss#),
120900190410                             Int(Replace(Char(Current_Date, Iso), '-', '')),
121000190410                             Int(Replace(Char(Current_Time), ':', '')),
121100190410                             :wqusrn, 'C', Upper(:s4desc));
121200170905
121300190410             leave;
121400190410           endif;
121500190410         enddo;
121600170905
121700190410         btnExit = *off;
121800190410         btnAccept = *off;
121900190410         ReloadS2 = 'Y';
122000170905
122100170905
122200171229       end-proc;
122300170905
122400170919
122500171229       //---------------------------------------------------------
122600171229       dcl-proc WriteHist;
122700171010
122800190410         hkey = ' ' + %editc(pMember : 'X');
122900180402
123000190410         if pMember = 0;
123100190410           hkey = %Editc( pTrst : 'X' ) + %Editc( pSub# : 'X' ) +
123200190410             %Editc( pAcct : 'X' );
123300190410         EndIf;
123400171010
123500190410         // trCode = 'MMA';
123600190410         // ck#Not = *Blanks;
123700190410         // note2  = *Blanks;
123800171010
123900190410         hPrgnm = 'INQ003R';
124000190410         trDate = %Dec(%Date);
124100190410         hsTrst = pTrst;
124200190410         hsSub# = pSub#;
124300190410         hsAcct = pAcct;
124400190410         hsDltD = 'A';
124500190410         hsTrTime = %Time;
124600190410         covtDt = %Dec(%Date);
124700190410         hOper = wqusrn;
124800171010
124900190410         Write histr;
125000171010
125100171010
125200171229       end-proc;
125300171010
125400171019
125500171229       //---------------------------------------------------------
125600171229       dcl-proc Close_Issue;
125700171019
125800190410         Dou btnClose = *on;
125900171019
126000190410           exfmt CloseIssue;
126100171019
126200190410           if btnClose = *on;
126300190410             btnClose = *off;
126400190410             leave;
126500190410           endif;
126600171019
126700190410           // Write F.Hist Record
126800190410           trCode = 'UIC';
126900190410           ck#Not = 'ISSUE TRACKING #' + %editc(s2iss#:'X') + ' CLOSED';
127000190410           note2  = s2sbjt ;
127100190410           WriteHist();
127200171019
127300190410           // Write Issue History Record.
127400190410           ihText = s4Desc;
127500190410           ihtypc = 'C';
127600190410           Write_Hist();
127700171019
127800171019
127900190410           // Close Issue History Record.
128000190410           ihText = 'ISSUE ' + %CHAR( s2Iss# ) + ' CLOSED';
128100190410           ihtypc = 'H';
128200190410           Write_Hist();
128300171019
128400171019
128500190410           Exec Sql
128600190410              Update itissp
128700190410                 Set itsts = 'C', itdatc = Int(Replace(Char(Current_Date,
128800190410                     Iso), '-', '')),
128900190410                     ittimc = Int(Replace(Char(Current_Time), ':', ''))
129000190410                 Where ittrst = :ptrst
129100190410                       And itsub# = :psub#
129200190410                       And itacct = :pacct
129300190410                       And itmssn = :s1w_ssn
129400190410                       And itiss# = :s2iss#;
129500171019
129600171019
129700190410           issueClosed = 'Y';
129800190410           leave;
129900171019
130000190410         enddo;
130100171019
130200171229       end-proc;
130300171019
130400171019
130500171229       //---------------------------------------------------------
130600171229       dcl-proc Ref_Email;
130700171019
130800171019
130900190410         rfeTo = #GetEmailAdr( s5refr );
131000171019
131100190410         // Member Issue
131200190410         if s1GridSsn > *Blanks;
131300190410           rfeSubj = 'Issue Tracking - ' + %char(s1GridSsn) +
131400190410             %Trim(s1GridFn) ;
131500190410         endif;
131600171019
131700171019
131800190410         // Email Body
131900190410         rfeText = 'Issue Tracking Issue#: ' + %Char( s1iss# ) +
132000190410           ' opened by ' + %Trim( wqusrn ) + ' has been referred' +
132100190410           ' to you. :/NFollow up date is ' + %Char( s2fudt : *Usa ) + '.' +
132200190410           ' The Type is ' +  %trim(#RtvIssueType( s5typc )) + '.' + ':/N'+
132300190410           'Referral Text: "' + %trim( s5Reft ) + '"' + ':/N:/N' +
132400190410           'Issue Details: "' + %trim( s5Desc ) + '".';
132500171019
132600171020
132700190410         SendEmail( rfeTo : rfeSubj : rfeText );
132800171019
132900171019
133000190410         // Write Hist Record
133100190410         ihText = 'Referral Email Sent to ' + s5Refr;
133200171020
133300171020
133400190410         ihtypc = 'C';
133500190410         Write_Hist();
133600171019
133700171019
133800171229       end-proc;
133900171020
134000171020
134100171229       //---------------------------------------------------------
134200171229       dcl-proc Ref_ChgEmail;
134300171020
134400171020
134500190410         rfeTo = #GetEmailAdr( s2refr );
134600171020
134700190410         // Member Issue
134800190410         if s1ssn > *Blanks;
134900190410           rfeSubj = 'Issue Tracking - ' + %char(s1ssn) +
135000190410             %Trim(s1FulName) ;
135100171020
135200190410         endif;
135300171020
135400171020
135500190410         // Email Body
135600190410         rfeText = 'Issue Tracking Issue#: ' + %Char( s2iss# ) +
135700190410           ' has been changed and is now referred' +
135800190410           ' to you. :/NFollow up date is ' + %Char( s2fudt : *Usa ) + '.' +
135900190410           ' The Type is ' +  %trim(#RtvIssueType( s2typc )) + '.' + ':/N'+
136000190410           'Referral Text: "' + %trim( s2Reft ) + '"' + ':/N:/N' +
136100190410           'Issue Details: "' + %trim( s2Desc ) + '".';
136200171020
136300171020
136400190410         SendEmail( rfeTo : rfeSubj : rfeText );
136500171020
136600171020
136700190410         // Write Hist Record
136800190410         ihText = 'Referral Change Email Sent to ' + s2Refr;
136900171020
137000190410         ihtypc = 'C';
137100190410         Write_Hist();
137200171020
137300171020
137400171229       end-proc;
137500171020
137600171020      *-----------------------------------------------------------
137700171229
137800171229       Dcl-Proc #RtvIssueType export;
137900171229
138000190410         dcl-pi *n Char(30);
138100190410           inType Char(3);
138200190410         End-Pi;
138300171229
138400190410         dcl-s ReturnVal Char(30);
138500171229
138600190410         ReturnVal = '';
138700171229
138800171020
138900190410         // Chain to the Codes file t get the Description
139000190410         chain ('T' : inType ) itCodp;
139100190410         if %Found( itCodp );
139200190410           ReturnVal = icText;
139300190410         endif;
139400171020
139500190410         Return ReturnVal;
139600171020
139700171229
139800171229       End-Proc;
139900171020
140000171019
140100170608      *-----------------------------------------------------------
140200171229
140300171229       Dcl-Proc #GetCarrier Export;
140400171229
140500190410         dcl-pi *n Char(30);
140600190410           inCar Char(2) value;
140700190410         End-Pi;
140800171229
140900190410         Dcl-s ReturnVal Char(30);
141000171229
141100190410         ReturnVal = '';
141200171229
141300190410         Select;
141400190410         When inCar = 'NC';
141500190410           ReturnVal = 'NOT CARRIER SPECIFIC';
141600190410         When inCar > *Blanks;
141700190410           chain inCar HyperCarr;
141800190410           if %Found(HyperCarr);
141900190410             ReturnVal = hcName;
142000190410           endif;
142100190410         Endsl;
142200170608
142300190410         Return ReturnVal;
142400170608
142500171229       end-Proc;
142600170608
142700171019      *-----------------------------------------------------------
142800171229
142900171229       Dcl-Proc #GetEmailAdr export;
143000171229
143100190410         dcl-pi *n Char(20);
143200190410           inRefr Char(3) value;
143300190410         End-Pi;
143400171229
143500190410         dcl-s ReturnVal Char(20);
143600171229
143700171019
143800190410         ReturnVal = '';
143900171019
144000190410         Select;
144100190410         When inRefr = 'BSC';
144200190410           ReturnVal = 'bscarfield@gbsio.net';
144300190410         When inRefr = 'CBL';
144400190410           ReturnVal = 'cblizzard@gbsio.net';
144500190410         When inRefr = 'CFA';
144600190410           ReturnVal = 'cfallin@gbsio.net';
144700190410         When inRefr = 'CFB';
144800190410           ReturnVal = 'cfabiszak@gbsio.net';
144900190410         When inRefr = 'CWH';
145000190410           ReturnVal = 'cwhitehead@gbsio.net';
145100190410         When inRefr = 'DCL';
145200190410           ReturnVal = 'dclark@gbsio.net';
145300190410         When inRefr = 'LKE';
145400190410           ReturnVal = 'lketterman@gbsio.net';
145500190410         When inRefr = 'SRA';
145600190410           ReturnVal = 'srapski@gbsio.net';
145700190410         When inRefr = 'BPR';
145800220518           ReturnVal = 'payrolledi@amwins.com';
145900190410         Endsl;
146000171019
146100190410         Return ReturnVal;
146200171019
146300171229       end-Proc;
146400171019
