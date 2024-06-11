000100190523
000200211201       Ctl-opt option(*noDebugIo)   DftActGrp(*no) bnddir('GBSBIND') ;
000300190523
000400190523      *-------------------------------------------------------------------------
000500190523      *
000600190523      *  Description:  Guardian File Transfer Maintenance
000700190523      *  Programmer.:  Brian Rees
000800190523      *  Date.......:  12/16/2015
000900190523      *
001000190523      *-------------------------------------------------------------------------
001100190523
001200190523
001300190523      *-------------------------------------------------------------------------
001400190523      * Change Log
001500190523      *
001600180914      *  09/14/2018  J. Torres  Added call to new send/not send program that maintains new file
001700190523      *
001800181101      *  11/01/2018  J. Torres  Added programming to write to history and diary notes files
001900200610      *  06/10/2020  B.Rees     Added New Field: cost Center to Department CST2DEPT
002000210109      *  01/09/2021  B.Rees     New File: Transfer Log
002100211115      *  11/15/2021  B.Rees     Added Total Records and Active Records
002200211115      *                         to the screen.
002300230309      *  12/01/2021  b.Rees     Modified the Screen.
002301230309      *  03/09/2023  J.Torres   Added ability to write to History and Diary
002302230309      *                         files when file is actually transmitted
002400190523      *-------------------------------------------------------------------------
002500190523
002600190523       Dcl-f GBS0006D WorkStn
002700190523         Handler('PROFOUNDUI(HANDLER)')
002800210109         SFILE(LstSfl:rrn)
002900210109         SFILE(NotesSfl:rrn2);
003000190523
003100190524       dcl-f Guartranp keyed usage( *input : *output : *update );
003200190523       Dcl-f CarAccp   keyed usage( *input : *output : *update );
003300190524       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
003301230306       Dcl-f GuardTestQ keyed usage( *input : *output : *update );
003400190524
003500190523       dcl-f Hist Keyed usage( *output )
003600190523         ExtDesc('F.HIST') ExtFile(*extdesc)
003700190523         rename(histr:histFile);
003800190523
003900190523
004000190523       dcl-f diaryhd0 Keyed usage( *output )
004100190523         ExtDesc('F.DIARYHD0') ExtFile(*extdesc)
004200190523         rename(rdiaryhd:diaryFile);
004300190523
004400210109       dcl-f GuartLogp keyed usage(*Input:*output);
004500210109
004600210109
004700190523      *-------------------------------------------------------------------------
004800190523      *
004900190523      * Global Variables
005000190523      *
005100190523      *-------------------------------------------------------------------------
005200181101
005300190523       dcl-ds pgmd
005400190523         ExtName('IOPGMD') PSDS;
005500190523         @pgmq *proc;
005600190523       end-ds;
005700141212
005800190523       dcl-s rrn Zoned(5);
005900210109       dcl-s rrn2 Zoned(5);
006000190523       dcl-s reload Char(1);
006100190524       dcl-s wActNbr like( s2Account );
006200190523
006300190523       dcl-s UniqueID  Char(10);
006400190523       dcl-s UniqueId# Zoned(10);
006500190523       dcl-s hasError  ind;
006600190523       dcl-s RcdMode   Char(10);
006700190523       dcl-s NextId    Char(10);
006800190523       dcl-s wCount    Int(5);
006900190523
007000190523       dcl-s canEdit ind;
007100190523       dcl-s canTest ind;
007200190524
007300190524       dcl-c digits  '0123456789';
007400190524
007500160729
007600190523      *-------------------------------------------------------------------------
007700190523      *
007800190523      * Procedures
007900190523      *
008000190523      *-------------------------------------------------------------------------
008100190524       /include *LIBL/QMODSRC,#ChkFncAth           // Check Function Authority
008200190524       /include GBSPGM/QMODSRC,#GettokPR
008300190524       /include GBSPGM/QMODSRC,#zFillpr
008400151217
008500190523       dcl-pr PlanMaint ExtPgm('GBS0006R1');
008600190523         oUniq Char(10);
008700190523         oTrst Zoned(3);
008800190523         oSub# Zoned(3);
008900190523         oAcct Zoned(4);
009000190523       End-Pr;
009100190523
009200190523       dcl-pr GuarOverride ExtPgm('GBS0006R2');
009300190523         oUniq Char(10);
009400190523         oTrst Zoned(3);
009500190523         oSub# Zoned(3);
009600190523         oAcct Zoned(4);
009700190523       End-Pr;
009800190523
009900190523       dcl-pr Guardian_S ExtPgm('GUARDIAN_S');
010000190523         oUniq Char(10);
010100190523       End-Pr;
010200190523
010300200617       dcl-pr Guardian_O ExtPgm('GUARDIAN_O');
010400200617         oUniq Char(10);
010500200617       End-Pr;
010600200617
010700190529       dcl-pr ViewArchive  ExtPgm('GBS0006R3');
010800190529         pCaCid3 Char(30);
010900190529       End-Pr;
011000190523
011100160621
011200190523       // Account Selection Window
011300190524       dcl-pr Acct_Window ExtPgm('WNACCMSTR');
011400190524         oFullAcct Char(10);
011500190523         oDesc Char(40);
011600190523         oCancel Char(1);
011700190523       End-Pr;
011800190524       dcl-s oFullAcct Char(10);
011900190523
012000190523
012100190523       dcl-pr dltadd ExtPgm('TROFF3');
012200190524         p#Trst Packed(3);
012300190524         p#Sub# Packed(3);
012400190524         p#Acct Packed(4);
012500190524         inCarrier Packed(2);
012600190523         option Char(1);
012700190523       End-Pr;
012800190524       dcl-s inCarrier Packed(2);
012900190524       dcl-s p#Trst Packed(3);
013000190524       dcl-s p#Sub# Packed(3);
013100190524       dcl-s p#Acct Packed(4);
013200190524
013300190523
013400190523       dcl-s iDescr40 Char(40);
013500190523       dcl-s Cancel Char(1);
013600190523       dcl-s option Char(1);
013700190523       dcl-s Subject Char(26);
013800190523       dcl-s on_off Char(3);
013900190523
014000190528       dcl-pr AccountInq ExtPgm('INQ008R');
014100190528         oTrst Zoned(3);
014200190528         oSub# Zoned(3);
014300190528         oAcct Zoned(4);
014400190528       End-Pr;
014500190528       dcl-s oTrst Zoned(3);
014600190528       dcl-s  oSub# Zoned(3);
014700190528       dcl-s  oAcct Zoned(4);
014800190919
014900190919       dcl-pr SendTestFile ExtPgm('FT_001CT') End-Pr;
014901230307
014902230307       dcl-pr SendTestFile2 ExtPgm('FT_001CTT') End-Pr;
014903230307
015000200610       dcl-pr GBS0061R ExtPgm('GBS0061R') End-Pr;
015001230307
015002230307     d e1envir         s             15
015003230307     d e1libl          s             10
015004230307     d e1Lib2          s             10
015005230307     d envColor        s             10
015006230307     d e1Acnm          s             40
015007230307
015008230307     d getEnv          pr                  ExtPgm('GETENVR')
015009230307     d  e1envir                      15
015010230307     d  e1libl                       10
015011230307     d  e1Lib2                       10
015012230307     d  envColor                     10
015013230307     d  e1Acnm                       40
015100190524
015200190523      *-------------------------------------------------------------------------
015300190523      *
015400190523      * Mainline Program
015500190523      *
015600190523      *-------------------------------------------------------------------------
015700170118
015800151216
015900211201       Exec Sql
016000211201         Set Option Commit = *None, Naming = *Sys;
016100160804
016200160804
016300190524       init();
016400190524
016500190524
016600190524
016700190524       Dou btnExit = *on;
016800190524
016900190524         ClearS1();
017000190524         LoadS1();
017100200610         mnuChoice = '';
017200200610         mnuValues = '';
017300190524
017400190524         //-----------------------------------
017500190524         //
017600190524         //  Build Popup Menu
017700190524         //
017800190524         //-----------------------------------
017900190524         if canEdit = *on;
018000190524           mnuChoice = ',Edit,Copy Group';
018100190524           mnuValues = ',mnuEdit,mnuCopy';
018200190524         EndIf;
018300190524
018400190524         mnuChoice = %trim( mnuChoice ) + ',Plans';
018500190524         mnuValues = %trim( mnuValues ) + ',mnuPlans';
018600190524
018700190524         if canTest = *on;
018800220314           mnuChoice = %trim( mnuChoice ) + ',Generate Test File';
018900190524           mnuValues = %trim( mnuValues ) + ',mnuTest';
019000190524         EndIf;
019100190524
019200190524
019300190524         mnuChoice = %trim( mnuChoice ) + ',Work with Overrides';
019400190524         mnuValues = %trim( mnuValues ) + ',Overrde';
019500190524
019600190524         if canEdit = *on;
019700190524           mnuChoice = %trim( mnuChoice ) + ',Copy Same Uniq Id';
019800190524           mnuValues = %trim( mnuValues ) + ',CpyUniqId';
019900190524         EndIf;
020000190524
020100190524
020200190524         mnuChoice = %trim( mnuChoice ) + ',Run Export';
020300190524         mnuValues = %trim( mnuValues ) + ',mnuExport';
020400190524
020500190529         mnuChoice = %trim( mnuChoice ) + ',View Archive Files';
020600190529         mnuValues = %trim( mnuValues ) + ',mnuArchive';
020700200610
020800200610         // New Menu Option - Cost Center/ Department Cross Reference.
020900200610         mnuChoice = %trim( mnuChoice ) + ',Cost Center/Dept xRef';
021000200610         mnuValues = %trim( mnuValues ) + ',mnuDptxRef';
021100200610
021200190529
021300190524         mnuChoice = %Subst( mnuChoice : 2 );
021400190524         mnuValues = %Subst( mnuValues : 2 );
021500190524
021600190524
021700190524
021800190524         DisplyS1();
021900190524
022000190524
022100190524         //?Process Selections
022200190524         Select;
022300190524
022400190524         when btnAddNew = *on;
022500190524           RcdMode = 'Add';
022600190528           Reset_Screen();
022700190528
022800190528           //?Get Next Unique ID Number..
022900211201           Exec Sql
023000211201             Select Max(cauniq)
023100211201               Into :nextid
023200211201               From caraccp
023300211201               Where Substring(cauniq, 1, 1) = '0';
023400190528
023500190528           s2UniqId = %Dec(NextId:5:0) + 1;
023600190528
023700190524           Add_Record();
023800190528
023900200610         when btnDrop = *on;
024000190529           sflScroll = rrn - 10;
024100190524
024200190524         When btnReset = *on;
024300190524           Reload = 'Y';
024400190524           s1Search = *blanks;
024500190524
024600190524
024700190524
024800200610         When btnTstFile = *on;
024801230307           if e1envir = 'Production';
024802230307            SendTestFile();
024804230307           else;
024805230307            SendTestFile2();
024806230307           endif;
024901230306           updateGuardQ();
025000190524
025100190524         other;
025200190528           ReadChangedS1();
025300190524
025400190524         EndSl;
025500190524
025600190524
025700190528       enddo;
025800190524
025900190524       *inlr = *on;
026000190524
026100190524
026200190524
026300190524       // ----------------------------------------------------------------
026400190524       dcl-proc CLEARS1;
026500190524
026600190524         //-------------------------
026700190524         //
026800190524         // Clear the Subfile
026900190524         //
027000190524         //-------------------------
027100190524
027200190524         SflClr = *on;
027300190524         Write CtlSfl;
027400190524         sflClr = *off;
027500190524         rrn = 0;
027600190524
027700190524       End-Proc;
027800190524       // ----------------------------------------------------------------
027900190524       Dcl-Proc LoadS1;
028000190524
028100211115         s1TotRecs = 0;
028200211115         s1TotAct  = 0;
028300211115
028400190524         Setll *loval Guartranp;
028500190524         Dou %eof(Guartranp);
028600190524
028700190524           read Guartranp;
028800190524           if %eof(Guartranp);
028900190528             leave;
029000190528           endif;
029100190524
029200190524
029300190524           s1GrpNbr = *blanks;
029400190524           chain(n) (gtUniq : gtTrst : gtSub# : gtAcct) carAccp;
029500190524           if %Found(CarAccp);
029600190524             s1GrpNbr = cacid2;
029700190524           endif;
029800190524
029900190524           If %Eof(GuarTranp);
030000190528             leave;
030100190528           endIf;
030200190524
030300190524
030400190524           // Show All Active
030500190524           if chkShowAct = 'Y' and  caStatus <> 'Y';
030600190524             iter;
030700190528           EndIf;
030800190524
030900190524
031000190524           s1UniqId = %Dec(gtUniq:5:0);
031100190524
031200190524           s1Trst = gtTrst;
031300190524           s1Sub# = gtSub#;
031400190524           s1Acct = gtAcct;
031500190524
031600190524           s1Tsa = %editc(gtTrst : 'X') + '-' +
031700190524             %editc(gtSub# : 'X') + '-' +
031800190524             %editc(gtAcct : 'X') ;
031900190528           s1Tsa_nd = %ScanRpl('-' : '' : s1Tsa);
032000190524           s1GrpName = grpName;
032100190524           s1Status = caStatus;
032200190524           s1Uniq = caUniq;
032300190529           s1Cid3 = cacid3;
032400190524
032500190528           s1aaName = '';
032600211201           Exec Sql
032700211201             Select Substring(afnam, 1, 1) || '. ' || alnam
032800211201               Into :s1aaname
032900211201               From aacode
033000211201               Where acode = (Select aacode
033100211201                     From "F.ACCMST"
033200211201                     Where actrst = :s1trst And
033300211201                           acsub# = :s1sub# And
033400211201                           acacct = :s1acct);
033500190528
033600211115
033700211115           s1TotRecs = s1TotRecs + 1;
033800211115           if s1Status = 'Y';
033900211115             s1TotAct = s1TotAct + 1;
034000211115           EndIf;
034100211115
034200190528
034300190528           if s1Search = *blanks;
034400190524             rrn = rrn + 1;
034500190528             write LstSfl;
034600190524
034700190528           else;   //?Search Field
034800220104             if %scan( %Trim(s1Search) : %upper(s1GrpName) ) > 0 or
034900190528               %Scan( %Trim(s1Search) : s1Uniq ) > 0  or
035000190524               %Scan( %Trim(s1Search) : s1GrpNbr ) > 0  or
035100190524               %Scan( %Trim(s1Search) : s1tsa_Nd) > 0  ;
035200190524
035300190524
035400190524               rrn = rrn + 1;
035500190524               write LstSfl;
035600190528             endif;
035700190528           endif;
035800190524
035900190528           If rrn >= 9999;
036000190528             leave;
036100190524           endIf;
036200190524
036300190528         enddo;
036400190524
036500190524       End-Proc;
036600190524
036700190524       // ----------------------------------------------------------------
036800190524       Dcl-Proc DisplyS1;
036900190524
037000190524         exfmt CtlSfl;
037100190524
037200190524       End-Proc;
037300190524
037400190524       // ----------------------------------------------------------------
037500190528
037600190528       Dcl-Proc ReadChangedS1;
037700190524
037800190524         Dou *in95 = *ON;
037900190524           READC LstSfl;
038000190524           *in95 = %EOF;
038100190524
038200190524           If *in95 = *OFF;
038300190528             ShowAccept = *on;
038400190528             Lockdown = *off;
038500190524
038600190524
038700190528             //------------------------------
038800190528             //
038900190528             // Go to Account Inquiry
039000190528             //
039100190528             //------------------------------
039200190524             if SelInv = *on;
039300190524               oAcct = s1Acct;
039400190524               oTrst = s1Trst;
039500190524               oSub# = s1Sub# ;
039600190524
039700190524               AccountInq( oTrst : oSub# : oAcct );
039800190524
039900190524             endif;
040000190524
040100190528
040200190528
040300190528
040400190528             //------------------------------
040500190528             //
040600190528             // Copy Group Number to New ID
040700190528             //
040800190528             //------------------------------
040900190528             if runOption = 'mnuCopy';
041000190528               RcdMode = 'Add';
041100190528               Reset_Screen();
041200190528               Load_Data();
041300190528
041400190528               //?Get Next Unique ID Number..
041500211201               Exec Sql
041600211201                 Select Max(cauniq)
041700211201                   Into :nextid
041800211201                   From caraccp
041900211201                   Where Substring(cauniq, 1, 1) = '0';
042000190528
042100190528               s2UniqId = %Dec(NextId:5:0) + 1;
042200190528
042300190528               Add_Record();
042400190528             endIf;
042500190528
042600190524
042700190528
042800190528             //------------------------------
042900190528             //
043000190528             // Edit Record
043100190528             //
043200190528             //------------------------------
043300190528             if btnEdit = *on    or  runOption = 'mnuEdit';
043400190524               RcdMode = 'Change';
043500190528               header = 'Edit Account';
043600190524               Load_Data();
043700190524               Chg_Data();
043800190528             endIf;
043900190524
044000190529
044100190528
044200190529             //------------------------------
044300190529             //
044400190529             // View Archive Records
044500190529             //
044600190529             //------------------------------
044700190529             if  runOption = 'mnuArchive';
044800190529               ViewArchive( s1Cid3 );
044900190529             endIf;
045000190529
045100200610
045200200610             //------------------------------
045300200610             //
045400200610             // Cross Reference / Department xrefence.
045500200610             //
045600200610             //------------------------------
045700200610             if  runOption = 'mnuDptxRef';
045800200610               GBS0061R();
045900200610             endIf;
046000200610
046100190528
046200190528
046300190528             //------------------------------
046400190528             //
046500190528             // View Record
046600190528             //
046700190528             //------------------------------
046800190528             if btnView = *on;
046900210110
047000210110               dou btnExit = *on;
047100210110
047200210110                 if btnExit = *on;
047300210110                   leave;
047400210110                 endif;
047500210110
047600210110                 RcdMode = 'View';
047700210110                 header = 'View Account';
047800210110                 Load_Data();
047900210110                 Lockdown = *on;
048000210110                 ShowAccept = *off;
048100210110                 Exfmt EditScreen;
048200210110
048300210110
048400210110                 if  btnNote = *on;
048500210110                   ClearS2();
048600210110                   LoadS2();
048700210110                   DisplyS2();
048800210110
048900210110                   btnExit = *off;
049000210110                   iter;
049100210110                 EndIf;
049200210110
049300210110               enddo;
049400210112
049500211115               btnExit = *off;
049600210110
049700190528             endIf;
049800190528
049900190528
050000190528
050100190528             //------------------------------
050200190528             //
050300190528             // Edit Plans
050400190528             //
050500190528             //------------------------------
050600190528             if runOption = 'mnuPlans';
050700190528
050800190528               oTrst = s1Trst;
050900190528               oSub# = s1Sub# ;
051000190528               oAcct = s1Acct;
051100190528
051200190528               PlanMaint( s1Uniq : oTrst : oSub# : oAcct ) ;
051300190528             EndIf;
051400190528
051500190528
051600190528
051700190528             //------------------------------
051800190528             //
051900190528             // Send Test File
052000190528             //
052100190528             //------------------------------
052200190528             if runOption = 'mnuTest';
052300190528
052400190528               UniqueId# = %Dec(s1UniqId:3:0);
052500190528               UniqueId = %editc( UniqueId# : 'X');
052600190528               Guardian_S( UniqueId );
052700190528
052800190528               chain (UniqueId : s1Trst : s1Sub# : s1Acct) GuarTranp;
052900190528               Tst_FileDt = %Dec(%Date);
053000190528               Tst_FileTm = %Dec(%Time);
053100190528               Update Guartranr;
053101230306
053102230306               chain (s1Trst : s1Sub# : s1Acct) GuardQr;
053103230306               if not %found;
053104230306                gttrstq = s1Trst;
053105230306                 gtsub#q = s1Sub#;
053106230306                  gtacctq = s1Acct;
053107230306                  gatransq = 'N';
053108230306                 dateQ = 0;
053109230306                write GuardQr;
053110230306               else;
053112230306                gatransq = 'N';
053113230306                dateQ = 0;
053114230306                update GuardQr;
053115230306               endif;
053200190528
053300190528               // Remove Termed Records.. (Because we are only testing
053400190528               // this account)
053500211201               Exec Sql
053600211201                 Delete From guar014wf Where nttrst = :s1trst And
053700211201                 ntsub# = :s1sub# And
053800211201                 ntacct = :s1acct And
053900211201                 nttransdt = :tst_filedt;
054000190528
054100190528             EndIf;
054200190528
054300190528
054400190528             //------------------------------
054500190528             //
054600190528             // Send Test File
054700190528             //
054800190528             //------------------------------
054900190528             if runOption = 'Overrde';
055000190528
055100190528               UniqueId# = %Dec(s1UniqId:3:0);
055200190528               UniqueId = %editc( UniqueId# : 'X');
055300190528
055400190528               oTrst = s1Trst;
055500190528               oSub# = s1Sub# ;
055600190528               oAcct = s1Acct;
055700190528
055800190528               GuarOverride( s1Uniq : oTrst : oSub# : oAcct ) ;
055900190528
056000190528             EndIf;
056100190528
056200190528
056300190528
056400190528             //------------------------------
056500190528             //
056600190528             // Copy Same Uniq ID
056700190528             //
056800190528             //------------------------------
056900190528             if runOption = 'CpyUniqId';
057000190528
057100190528               RcdMode = 'Add';
057200190528               Reset_Screen();
057300190528               Load_Data();
057400190528               Add_Record();
057500190528             EndIf;
057600190528
057700190528
057800190528
057900190528             //------------------------------
058000190528             //
058100190528             // Run Export
058200190528             //
058300190528             //------------------------------
058400190528             if runOption = 'mnuExport';
058500190528
058600190528               UniqueId# = %Dec(s1UniqId:3:0);
058700190528               UniqueId = %editc( UniqueId# : 'X');
058800200617               Guardian_O( UniqueId );
058900190528
059000190528             EndIf;
059100190528
059200190528
059300190524
059400190528
059500190528
059600190524             SelInv= *off;
059700190524             btnEdit = *off;
059800190528             btnView = *off;
059900190528             RunOption = '';
060000190524             update LstSfl;
060100190524             Reload = 'Y';
060200190524
060300190528           endIf;
060400190524
060500190528         enddo;
060600190524
060700190528       End-Proc;
060800190524
060900190524
060901230306       // ----------------------------------------------------------------
060902230306       Dcl-Proc updateGuardQ;
060903230306
060904230306         setll *loval GuardQr;
060906230306         read GuardQr;
060907230306         dow not %eof;
060908230306
060909230306          if gatransq = 'N';
060910230306           gatransq = 'Y';
060911230306            dateq = %dec(%date());
060912230306            update GuardQr;
060913230306           history2();
060914230306          endif;
060915230306
060916230306         read GuardQr;
060917230306         enddo;
060918230306
060919230306       End-Proc;
060920230306
061000190524       // ----------------------------------------------------------------
061100190524       Dcl-Proc Init;
061200190524
061300190528         Reload = 'Y';
061400190524
061500190524         //?User Allowed to Edit?
061600190524         canEdit = *off;
061700190524         oFunction = 'EDIT';
061800190524         oDspErrMsg = 'N';
061900190524
062000190524         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
062100190524         if oContinue = 'Y';
062200190528           canEdit = *on;
062300190528         endif;
062400190524
062500190524
062600190524         //?User Allowed to Test?
062700190524         canTest = *off;
062800190524         oFunction = 'TEST';
062900190524         oDspErrMsg = 'N';
063000190530         ShowAdd = *off;
063100190524
063200190524         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
063300190524         if oContinue = 'Y';
063400190528           canTest = *on;
063500190530           ShowAdd = *on;
063600190528         endif;
063700190524
063701230307         getenv(e1envir : e1libl : e1Lib2 : envColor : e1Acnm);
063800190524
063900190528       End-Proc;
064000190523
064100190524
064200190528
064300190528       // ----------------------------------------------------------------
064400190528       Dcl-Proc Reset_Screen;
064500190528
064600190528
064700190528         Clear AddScreen;
064800190528
064900190528         s2Status = 'N';
065000190528         s2Salary = 'N';
065100190528         s2StdCvg = 'N';
065200190528         s2StdVol = 'N';
065300190528         s2LtdVol = 'N';
065400190528         s2LifeVol = 'N';
065500190528         s2ADNDVOL = 'N';
065600190528
065700190528         s2CostCde = 'N';
065800190528         s2BlankVis = 'N';
065900190528         s2DeptCls = 'N';
066000190528         s2VlcVgd = 'N';
066100200610         s2Cst2Dept = 'N';
066200190528
066300190528
066400190528       End-Proc;
066500190528
066600190524
066700190524       // ----------------------------------------------------------------
066800190524       Dcl-Proc Add_Record;
066900190524
067000190524
067100190524         dou btnExit = *on;
067200190524
067300190528           exfmt AddScreen;
067400190524
067500190524
067600190524           if btnExit = *on;
067700190528             leave;
067800190528           EndIf;
067900190524
068000190524
068100190524           If btnSrchAct = *on;
068200190524
068300190524             // Account Window
068400190524             Acct_Window(oFullAcct :  iDescr40 : Cancel);
068500190524             if Cancel = '';
068600190524
068700190528               s2Trst = %dec(%Subst(oFullAcct : 1 : 3 ) : 3 : 0 );
068800190524               s2Sub# = %dec(%Subst(oFullAcct : 4 : 3 ) : 3 : 0 );
068900190524               s2Acct = %dec(%Subst(oFullAcct : 7 : 4 ) : 4 : 0 );
069000190524               s2Account = %Subst(oFullAcct : 1 : 3 ) + '-' +
069100190524                 %Subst(oFullAcct : 4 : 3 ) + '-' +
069200190528                 %Subst(oFullAcct : 7 : 4 );
069300190524
069400190528             endif;
069500190524
069600190528           endif;
069700190524
069800190524
069900190524           //-----------------------------------------------------------
070000190524           //
070100190524           // Split out the Account number ( If the user keyed the
070200190524           // account number manually
070300190524           //
070400190524           //-----------------------------------------------------------
070500190524           split();
070600190524           wActNbr = s2Account;
070700190524
070800190524           s2Account = %ScanRpl( '-' : '' : s2Account );
070900190524           s2Account = %ScanRpl( ' ' : '' : s2Account );
071000190524
071100190524           if %check( digits : %Trim( s2Account )) = 0  and
071200190524             %Len(%Trim( s2Account )) = 10;
071300190524             s2Trst = %Dec( %Subst( s2Account : 1 : 3) : 3 : 0 );
071400190524             s2Sub# = %Dec( %Subst( s2Account : 4 : 3) : 3 : 0 );
071500190524             s2Acct = %Dec( %Subst( s2Account : 7 : 4) : 4 : 0 );
071600190524
071700190524             chain ( s2Trst : s2Sub# : s2Acct ) AccMst;
071800190524             if not %Found( AccMst );
071900190528               ErrAccount = *on;
072000190524               s2Account = wActNbr;
072100190528             else;
072200190528               s2GrpNam = acNam1;
072300190524               s2FileName = %ScanRpl(' ' : '_' : %Trim(acNam1) ) ;
072400190524
072500190524             endif;
072600190524
072700190528           else;
072800190524
072900190528             errAccount = *on;
073000190528           endif;
073100190524
073200190524
073300190524
073400190524
073500190524           if btnAccept = *on;
073600190528             Validate();
073700190524             if hasError = *on;
073800190528               iter;
073900190528             EndIf;
074000190524
074100190524
074200190524
074300190524             //-----------------------------------
074400190524             //
074500190524             // Add Mode
074600190524             //
074700190524             //-----------------------------------
074800190524
074900190524             UniqueID# = s2UniqId;
075000190524             caUniq = %editc( UniqueId# : 'X');
075100190524
075200190524             caTrst = s2Trst;
075300190524             caSub# = s2Sub#;
075400190524             caAcct = s2Acct;
075500190524
075600190524             CaTxt1 = 'Group Name';
075700190524             CaTxt2 = 'Group Number';
075800190524             CaTxt3 = 'Individual File Name';
075900190524             CaTxt4 = 'Class';
076000190524             CaTxt5 = 'Division';
076100190524
076200190524             caCid1 = %SubSt(s2GrpNam:1:30);
076300190524             caCid2 = s2GrpNbr;
076400190524             caCid3 = s2FileName;
076500190524             caCid4 = s2Clas;
076600190524             caCid5 = s2Div;
076700190524             caCid6 = s2Dept;
076800190524             caStatus = s2Status;
076900190524
077000190524             add_toTransfile();
077100210109             glNotes = 'Added During New Account Setup in GBS0006R';
077200210109             add_toTLog();
077300210109
077400210109
077500190524             Write CarAccr;
077600190524
077700190524
077800190524             //-----------------------------------
077900190524             //
078000190524             // Guardian Transmission File..
078100190524             //
078200190524             //-----------------------------------
078300190524
078400190524             gtUniq = caUniq;
078500190524
078600190524             gtTrst = caTrst;
078700190524             gtSub# = caSub#;
078800190524             gtAcct = caAcct;
078900190524
079000190524             GrpName  = s2GrpNam;
079100190524             AcctStrDt = %dec(%char(%date(s2StDate:*usa/):*iso0):8:0);
079200190524             ShowSalary = s2Salary;
079300190524             StdCovDesC = s2StdCvg;
079400190524             VlCovDesc = s2VlCvgd;
079500190524             StdVolElec = s2StdVol;
079600190524             LtdVolElec = s2LtdVol;
079700190524             LifVolElec = s2LifeVol;
079800190524             addVolElec = s2AdndVol;
079900190524             UseCstCntr = s2CostCde;
080000190524             BlankViCd  = s2BlankVis;
080100190524             Dept_Class = s2DeptCls;
080200200610             Cst2Dept = s2Cst2Dept;
080300190524
080400190524
080500190524             gtCrtBy = WQUSRN;
080600190524             gtCrtDt = %Dec(%Date);
080700190524             gtCrtTm = %Dec(%Time);
080800190524
080900190524             Tst_FileDt = 0;
081000190524             Tst_FileTm = 0;
081100190524
081200190524             gtChgBy = *Blanks;
081300190524             gtChgDt = 0;
081400190524             gtChgTm = 0;
081500190524             write GuarTranr;
081600190524
081610230306
081700190524             leave;
081800190524
081900190528           endif;
082000190524
082100190524
082200190524
082300190528         EndDo;
082400190524
082500190524         btnExit = *off;
082600190524
082700190528       End-Proc;
082800190524
082900190524
083000190524       // ----------------------------------------------------------------
083100190524       Dcl-Proc Chg_Data;
083200190524
083300190528         dcl-s SaveStatus Char(1);
083400190528
083500190528         SaveStatus = s2Status;
083600190528
083700190528         dou btnExit = *on;
083800190524
083900190524
084000190528           exfmt EditScreen;
084100190524
084200190524
084300190524           if btnExit = *on;
084400190528             leave;
084500190528           EndIf;
084600190524
084700190524
084800210109           if  btnNote = *on;
084900210109             ClearS2();
085000210109             LoadS2();
085100210109             DisplyS2();
085200210109
085300210109             btnExit = *off;
085400210109             iter;
085500210109           EndIf;
085600210109
085700190524
085800210109
085900190524           if btnAccept = *on;
086000190528             Validate();
086100190524             if hasError = *on;
086200190528               iter;
086300190528             EndIf;
086400190524
086500210109             s3Notes = '';
086600210109             if chgStatus = *on;
086700211201
086800211201               dou btnAccept = *on;
086900211201
087000211201                 exfmt Screen3;
087100211201                 glNotes = s3Notes;
087200211201
087300211201               enddo;
087400211201               btnAccept = *off;
087500211201
087600211201
087700210109             EndIf;
087800190524             //?No Error... Update Files
087900190524             if RcdMode = 'Change';
088000190524
088100190528               caCid1 = %SubSt(s2GrpNam:1:30);
088200190524               caCid2 = s2GrpNbr;
088300190524               caCid3 = s2FileName;
088400190524               caCid4 = s2Clas;
088500190524               caCid5 = s2Div;
088600190524               caCid6 = s2Dept;
088700190524               caStatus = s2Status;
088800190524
088900190528
089000190528               // Only write a history record if the status is changed.
089100190528               if SaveStatus <> s2Status;
089200200610                 add_toTransfile();
089300210109                 add_toTLog();
089400190528               endif;
089500190524
089600190524               Update CarAccr;
089700190524
089800190524
089900190524               //?Guardian Transmission File..
090000190524               GrpName  = s2GrpNam;
090100190524               acctStrDt = 0;
090200190524               if s2stDate > '';
090300190528                 AcctStrDt = %dec(%char(%date(s2StDate:*usa/):*iso0):8:0);
090400190528               endif;
090500190524               ShowSalary = s2Salary;
090600190524               StdCovDesC = s2StdCvg;
090700190524               vlCovDesc = s2VlCvgd;
090800190524               StdVolElec = s2StdVol;
090900190524               LtdVolElec = s2LtdVol;
091000190524               LifVolElec = s2LifeVol;
091100190524               addVolElec = s2AdndVol;
091200190524               UseCstCntr = s2CostCde;
091300190524               BlankViCd  = s2BlankVis;
091400190524               Dept_Class = s2DeptCls;
091500200610               Cst2Dept = s2Cst2Dept;
091600190524
091700190524
091800190524               gtChgBy = WQUSRN;
091900190524               gtChgDt = %Dec(%Date);
092000190524               gtChgTm = %Dec(%Time);
092100190524
092200190524               update GuarTranr;
092300190524
092400190528             endif;
092500190524
092600190524
092700190524             leave;
092800190524
092900190528           endif;
093000190528         EndDo;
093100190524
093200190524         btnExit = *off;
093300190528       End-Proc;
093400190524
093500190524       // ----------------------------------------------------------------
093600190524       Dcl-Proc Validate;
093700190524
093800190528         hasError = *off;
093900190524         err_01 = *off;
094000190524
094100190524         if RcdMode = 'Add';
094200190524
094300211201           Exec Sql
094400211201             Select Count(*)
094500211201               Into :wcount
094600211201               From caraccp
094700211201               Where cacid2 = :s2grpnbr;
094800190524
094900190528           if wCount > 0;
095000190528             hasError = *on;
095100190528             err_01 = *on;
095200190528           endif;
095300190524
095400190528         endif;
095500190524
095600190528       End-Proc;
095700190524
095800190524
095900190524
096000190524       // ----------------------------------------------------------------
096100190524       Dcl-Proc add_toTransfile;
096200190524
096300190528         if castatus = 'Y';
096400190528           option = 'D';
096500190524           incarrier = 13;
096600190524           dltadd(catrst : casub# : caacct : incarrier : option);
096700190528         endif;
096800190528
096900190528         If castatus = 'N';
097000190528           Option = 'A';
097100190528           incarrier = 13;
097200190528           dltadd(catrst : casub# : caacct : incarrier : Option);
097300190528         endif;
097400190528
097500190528         history();
097600190528
097700190528       End-proc;
097800190528
097900190528       // ----------------------------------------------------------------
098000190528       dcl-proc history;
098100190528
098200190528         If castatus = 'Y';
098300190528           on_off = 'ON';
098400190528         Else;
098500190528           on_off = 'OFF';
098600190528         endif;
098700190528
098800190528         subject = 'GUARDN-TRANSMISSION TURNED';
098900190528         clear diaryfile;
099000190528
099100190528         nhkey = %editc(catrst:'X')
099200190528           + %editc(casub#:'X')
099300190528           + %editc(caacct:'X');
099400190528         nhcode = 'WFT';
099500190528         nhaddt = %dec(%date);
099600190528         nhadti = %dec(%time);
099700190528         nhadus = wqusrn;
099800190528         nhsubj = subject + ' ' + on_off;
099900190528         Write diaryfile;
100000190528
100100190528
100200190528         clear histfile;
100300190528         hkey = %editc(catrst:'X')
100400190528           + %editc(casub#:'X')
100500190528           + %editc(caacct:'X');
100600190528         trcode = 'UHM';
100700190528         hprgnm = @pgmq;
100800190528         hstrst = catrst;
100900190528         hssub# = casub#;
101000190528         hsacct = caacct;
101100190528         hsdltd = 'A';
101200190528         trdate = %dec(%date);
101300190528         hstrtime = %time;
101400190528         hoper = wqusrn;
101500190528         ck#not = subject + ' ' + on_off;
101600190528         Write histfile;
101700190528
101800190528       End-proc;
101900190524
102000190524
102001230306       // ----------------------------------------------------------------
102002230306       dcl-proc history2;
102003230306
102009230306
102011230306         subject = 'GUARDIAN TEST FILE SENT';
102014230306
102015230306         clear diaryfile;
102016230306         nhkey = %editc(gttrstq:'X')
102017230306           + %editc(gtsub#q:'X')
102018230306           + %editc(gtacctq:'X');
102019230306         nhcode = 'WFT';
102020230306         nhaddt = %dec(%date);
102021230306         nhadti = %dec(%time);
102022230306         nhadus = wqusrn;
102023230306         nhsubj = subject;
102024230306         Write diaryfile;
102025230306
102026230306
102027230306         clear histfile;
102028230306         hkey = %editc(gttrstq:'X')
102029230306           + %editc(gtsub#q:'X')
102030230306           + %editc(gtacctq:'X');
102031230306         trcode = 'UHM';
102032230306         hprgnm = @pgmq;
102033230306         hstrst = catrst;
102034230306         hssub# = casub#;
102035230306         hsacct = caacct;
102036230306         hsdltd = 'A';
102037230306         trdate = %dec(%date);
102038230306         hstrtime = %time;
102039230306         hoper = wqusrn;
102040230306         ck#not = subject;
102041230307         note2 = %trim('Date:') + %char(%date) + ' ' + %trim('Time:') +
102042230307         %char(%time);
102043230306         Write histfile;
102044230306
102045230306       End-proc;
102046230306
102047230306
102100190524      *-------------------------------------------------------------------------
102200190524      *
102300190524      * Split out the account number
102400190524      *
102500190524      *-------------------------------------------------------------------------
102600190524       Dcl-Proc Split;
102700190524
102800190528         dcl-s x int(10);
102900190524         dcl-s tokens varchar(100) dim(50);
103000190524         dcl-s Trst Char(3);
103100190524         dcl-s Sub  Char(3);
103200190524         dcl-s Acct Char(4);
103300190524
103400190524         tokens(*) = #Gettok( s2Account : '-' : x );
103500190524
103600190524
103700190524         // we should have 3 array elements filled  in.
103800190524         // the next blank space should be #4.
103900190524         x = %lookup( '' : tokens ) ;
104000190524         if x = 4;
104100190528           Trst = #zFill( 3 : %Trim( Tokens(1) ));
104200190524           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
104300190524           Acct = #zFill( 4 : %Trim( Tokens(3) ));
104400190524
104500190524           s2Account = trst + '-' + Sub + '-' + Acct;
104600190524
104700190524         EndIf;
104800190524
104900190524
105000190528       End-Proc;
105100190524
105200190524
105300190524      *-------------------------------------------------------------------------
105400190524      *
105500190524      * Load the Edit / View Screen
105600190524      *
105700190524      *-------------------------------------------------------------------------
105800190524       Dcl-Proc Load_Data;
105900190524
106000190528         UniqueId# = %Dec(s1UniqId:3:0);
106100190524         UniqueId = %editc( UniqueId# : 'X');
106200190524         chain (UniqueId : s1Trst : s1Sub# : s1Acct) CarAccp;
106300190524         chain (UniqueId : s1Trst : s1Sub# : s1Acct) GuarTranp;
106400190524
106500210109         // Get Transmit Log Data.
106600210109         s2LogMsg = '';
106700210109         s2TranDate = '';
106800210109         ShowNote = *off;
106900210109
107000210109         Setll (UniqueId : s1Trst : s1Sub# : s1Acct) GuarTLogp;
107100210109         Dou %Eof(GuarTLogp);
107200210110           reade (UniqueId : s1Trst : s1Sub# : s1Acct) GuarTLogp;
107300210110           if %eof(GuarTLogp);
107400210109             leave;
107500210110           endif;
107600210109
107700210109           if glStatus = 'N';
107800210110             s2LogMsg = 'Date transmission turned OFF:' ;
107900210110           else;
108000210110             s2LogMsg = 'Date transmission turned ON:' ;
108100210110           endif;
108200210109
108300210110           s2TranDate = %Char(%Date(glDate:*iso):*Usa);
108400210110           ShowNote = *on;
108500210109
108600210110         Enddo;
108700210109
108800210109
108900190524         if %Found(GuarTranp);
109000190528           s2UniqId = %Dec(gtUniq:5:0);
109100190524           s2Account = %editc(gtTrst : 'X') + '-' +
109200190528             %editc(gtSub# : 'X') + '-' +
109300190524             %editc(gtAcct : 'X') ;
109400190524
109500190528           if %Found(carAccp);
109600190528             s2GrpNbr = %Trim(caCid2);
109700190524             s2FileName = caCid3;
109800190528             s2Clas = %trim(caCid4);
109900190524             s2Div = %trim(caCid5);
110000190524             s2Dept = %trim(caCid6);
110100190528           endif;
110200190524
110300190528           s2GrpNam = GrpName;
110400190524           if AcctStrDt > 0;
110500190528             s2StDate = %Char(%Date(AcctStrDt:*iso):*Usa);
110600190524           endif;
110700190524
110800190524           s2Salary = ShowSalary;
110900190524           if ShowSalary = '';
111000190528             s2Salary = 'N';
111100190528           EndIf;
111200190524
111300190524
111400190524           s2StdCvg = StdCovDesc;
111500190524           if stdCovDesc = '';
111600190528             s2StdCvg = 'N';
111700190528           EndIf;
111800190524
111900190524           s2VlCvgd = vlCovDesc;
112000190524           if vlCovDesc = '';
112100190528             s2VlCvgd = 'N';
112200190528           EndIf;
112300190524
112400190524           s2StdVol = StdVolElec;
112500190524           if StdVolElec = '';
112600190528             s2StdVol = 'N';
112700190528           EndIf;
112800190524
112900190524           s2LtdVol = LtdVolElec;
113000190524           if LtdVolElec = '';
113100190528             s2LtdVol = 'N';
113200190528           EndIf;
113300190524
113400190524           s2LifeVol = LifVolElec;
113500190524           if LifVolElec = '';
113600190528             s2LifeVol = 'N';
113700190528           EndIf;
113800190524
113900190524           s2AdndVol = addVolElec;
114000190524           if addVolElec = '';
114100190528             s2AdndVol = 'N';
114200190528           EndIf;
114300190524
114400190524           s2CostCde = UseCstCntr;
114500190524           if UseCstCntr = '';
114600190528             s2CostCde = 'N';
114700190528           EndIf;
114800190524
114900190524           s2BlankVis = BlankVicd;
115000190524           if BlankVicd = '';
115100190528             s2BlankVis = 'N';
115200190528           EndIf;
115300190524
115400190524           s2DeptCls = Dept_Class;
115500190524           if Dept_Class = '';
115600190528             s2DeptCls = 'N';
115700190528           EndIf;
115800190524
115900190524           s2Status  = caStatus;
116000190524           if caStatus = '';
116100190528             s2Status = 'N';
116200190528           EndIf;
116300190524
116400190524
116500200610           s2Cst2Dept = Cst2Dept;
116600200610           if Cst2Dept = '';
116700200610             s2Cst2Dept = 'N';
116800200610           EndIf;
116900190524
117000200610
117100190524           s2Trst = s1Trst;
117200190524           s2Sub# = s1Sub#;
117300190524           s2Acct = s1Acct;
117400190524
117500190524
117600190524           s2aaName = '';
117700211201           Exec Sql
117800211201             Select Substring(afnam, 1, 1) || '. ' || alnam
117900211201               Into :s2aaname
118000211201               From aacode
118100211201               Where acode = (Select aacode
118200211201                     From "F.ACCMST"
118300211201                     Where actrst = :s2trst And
118400211201                           acsub# = :s2sub# And
118500211201                           acacct = :s2acct);
118600190524
118700190528           s2CrtDate = *Blanks;
118800190528           s2ChgDate = *Blanks;
118900190524
119000190524           if gtCrtDt > 0 ;
119100190528             s2CrtDate = %Char(%Date(gtCrtDt:*iso):*Usa);
119200190524           endif;
119300190524
119400190524           if gtChgDt > 0 ;
119500190528             s2ChgDate = %Char(%Date(gtChgDt:*iso):*Usa);
119600190528           endif;
119700190524
119800190524           s2TstMsg = *Blanks;
119900190524           if tst_FileDt > 0 ;
120000190528             s2TstMsg = 'Last test file was created on ' +
120100190528               %Char(%date(tst_FileDt) :*usa) + ' at ' +
120200190524               %Char(%Time(tst_FileTm) :*usa);
120300190528           endif;
120400190524
120500190528         endif;
120600190524
120700190524
120800190528       End-Proc;
120900190524
121000210109       // ----------------------------------------------------------------
121100210109       Dcl-Proc add_toTLog;
121200210109
121300210109         gluniq = caUniq;
121400210109         gltrst = s2Trst;
121500210109         glsub# = s2Sub#;
121600210109         glacct = s2Acct;
121700210109         glstatus = caStatus;
121800210109         gluser = wqusrn;
121900210109         gldate = %Dec(%Date);
122000210109         gltime = %Dec(%Time);
122100210109         glPgm  = 'GBS0006R'  ;
122200210109
122300210109         write GUARTLOGR ;
122400210109
122500210109
122600210109       End-proc;
122700210109
122800210109
122900210109
123000210109       // ----------------------------------------------------------------
123100210109       dcl-proc CLEARS2;
123200210109
123300210110         //-------------------------
123400210110         //
123500210110         // Clear the Subfile
123600210110         //
123700210110         //-------------------------
123800210109
123900210110         Clrsfl2 = *on;
124000210110         Write Screen4;
124100210110         Clrsfl2= *off;
124200210110         rrn2 = 0;
124300210109
124400210109       End-Proc;
124500210109       // ----------------------------------------------------------------
124600210109       Dcl-Proc LoadS2;
124700210109
124800211115         UniqueId# = %Dec(s1UniqId:3:0);
124900211115         UniqueId = %editc( UniqueId# : 'X');
125000210126
125100210126         Setll UniqueId GuartLogp;
125200210110         Dou %eof(GuartLogp);
125300210109
125400210126           reade UniqueId GuartLogp;
125500210110           if %eof(GuartLogp);
125600210110             leave;
125700210110           endif;
125800210109
125900210110           glDateTm = %Char(%Date(glDate:*iso):*Usa) + ' ' +
126000210110                      %Char(%Time(glTime:*iso):*Usa) ;
126100210109
126200210110           rrn2 = rrn2 + 1;
126300210110           write NotesSfl;
126400210109
126500210110           If rrn2 >= 9999;
126600210110             leave;
126700210110           endIf;
126800210109
126900210110         enddo;
127000210109
127100210109       End-Proc;
127200210109
127300210109       // ----------------------------------------------------------------
127400210109       Dcl-Proc DisplyS2;
127500210109
127600210110         exfmt Screen4;
127700210109
127800210109       End-Proc;
127900210109
