000100220707
000200171229       Ctl-Opt option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*No)
000300190502         ActGrp(*New);
000400171229
000500171229      *-------------------------------------------------------------------------
000600171229      *
000700210505      *  Description:  Member Inquiry
000800171229      *  Programmer.:  Brian Rees
000900171229      *  Date.......:  05/25/2017
001000171229      *
001100171229      *-------------------------------------------------------------------------
001200171229
001300181126      *-------------------------------------------------------------------------
001400181126      *
001500181126      *  Change Log:
001600181126      *
001700181126      *-------------------------------------------------------------------------
001800181126      *
001900181126      * 11/26/2018   B.Rees  Added Color and a tool tip to the history date.
002000190514      * 05/14/2019   B.Rees  Added Check by phone
002100190515      * 05/15/2019   B.Rees  Retreive New Hire Emails.
002200190515      *    Mod Id: Br01
002300190520      * 05/20/2019   B.Rees  Added Longer Names.
002400191104      * 11/04/2019   B.Rees  Storing the OE Attachment in a database.
002500191104      *    Mod Id: Br02
002600181126      *
002700191203      * 12/03/2019   B.Rees  Added the Open Enrollment Dates to the Email Header.
002800200520      * 05/20/2020   b.Rees  Added Medicare Window
002900201216      * 12/16/2020   B.Rees  Added Status Description and Enrollment Date.
003000210121      * 01/21/2021   B.Rees  Modified the SFTP to use Arepeggiol
003100210121      *  This changed the invoices programs.
003200210505      * 05/05/2021   b.Rees  Added COBRA Subsidy
003300210614      * 06/14/2021   b.Rees  Added PAyroll Import Vendor
003400210707      * 07/07/2021   b.Rees  Adding Member Extension File.
003500220124      * 1/24/2022    B.Rees  Increase size of email field.
003600220228      * 01/27/2022   j.allen Added check for 0 dates - M001
003700220301      * 02/28/2022   j.allen Added new tab for Temp Id-Info
003800220228      *  Ticket:  CR000426
003900181126      *-------------------------------------------------------------------------
004000220504      *
004100220721      *  5/04/2022   J.Allen Added environment info to screens.
004200220721      *  07/21/2022  jt      Made coverage desc hyperlink when it is UHC plan
004300220721      *  07/27/2022  jt      Added ULP to be able to hyperlink as UHC plan.
004400230313      *  03/13/2023  jt      Added sorting on coverages section. Changed enrolled
004500230313      *                      and canceled dates to be ISO.
004600240312      *  11.13.2023  J.Allen Include Divorced flag elecrt = 'D'
004700240313      *  03.12.2024  J.Allen Include OLE SSID linkable PDF - J001
004800240313      *-------------------------------------------------------------------------
004900240313      *  03.13.2024  J.Allen SETLIBL updated to retrieve the *LIBL 2x
005000240313      *
005100240313      *              1. To set the *LIBL based on AOCODE
005200240313      *              2. To set the System values after the *LIBL is set
005300240313      *
005400240426      *  04/18/2024  jt Added view of Plan Auxiliary at plan subfile
005500240521      *  05.21.2024  J.Allen Add carrier USP for UHC - J002
005600171229      *
005700240426      *-------------------------------------------------------------------------
005800171229      * Declare Files
005900171229      *
006000171229      *-------------------------------------------------------------------------
006100171229       Dcl-f Inq002d WorkStn
006200190502         Handler('PROFOUNDUI(HANDLER)')
006300190502         SFILE(COVSFL:rrn)
006400210505         SFILE(HISTSFL:rrn2)
006500210505         SFILE(SUBSFL:rrn3)  ;
006600171229
006700171229       Dcl-f AccMst keyed
006800190502         ExtDesc('F.ACCMST') ExtFile(*extdesc) ;
006900171229
007000171229       Dcl-f Codesl1 keyed
007100190502         ExtDesc('F.CODESL1') ExtFile(*extdesc);
007200171229
007300171229       Dcl-f Member keyed
007400190502         ExtDesc('F.MEMBER') ExtFile(*extdesc)
007500190502         Rename( Membr : Rcd2 );
007600171229
007700171229       dcl-f mCov40 keyed
007800190502         ExtDesc('F.MCOV40') ExtFile(*extdesc);
007900171229
008000171229       dcl-f mCov41 keyed
008100190502         ExtDesc('F.MCOV41') ExtFile(*extdesc)
008200190502         Rename( mCovr : Rcd1 );
008300171229
008400171229       dcl-f PlnMst keyed
008500190502         ExtDesc('F.PLNMST') ExtFile(*extdesc);
008600171229
008700171229       dcl-f Class keyed
008800190502         ExtDesc('F.CLASS') ExtFile(*extdesc);
008900171229
009000190108       dcl-f Grat26 keyed
009100190502         ExtDesc('F.GRAT26') ExtFile(*extdesc);
009200171229
009300171229       dcl-f MemAlt keyed;
009400180613       dcl-f WebPayrol1 keyed usropn;
009500171229       dcl-f PlnAuxp keyed;
009600180426       dcl-f odcntcp   keyed;
009700180613       dcl-f Accospl3 keyed;
009800180720       dcl-f EmailAddr keyed;
009900190520       dcl-f CFS100P keyed;
010000191104br02   dcl-f InqLtrAtt keyed;
010100210707       dcl-f MemExtp keyed;
010200220901       dcl-f hrafsabap keyed;
010300190515
010400220505       dcl-ds OutEnvr  Qualified  ;
010500220505         e1Envir  Char(15);
010600220505         e1Libl   Char(10);
010700220505         e1Lib2   Char(10);
010800220505         envColor Char(10);
010900220505         e1Acnm   Char(40);
011000220505       End-Ds;
011100171229
011200240312J001   dcl-s pdfLink Char(500);
011300240312 |     dcl-s where Char(1) inz('X');
011400240312 |     dcl-s wwBatch Char(18) inz('FormPrint_Inquiry_');
011500240312 |     dcl-s aacolor  Char(10);
011600240312 |     dcl-s wwssid   Char(16);
011700240312 |     dcl-s wwsys    Char(1);
011800240312 |     dcl-s wwsystem Char(30);
011900240312J001   dcl-s batchLink Char(100);
012000171229
012100171229      *-------------------------------------------------------------------------
012200171229      *
012300171128      /DEFINE CHK_ACA_PLAN_PR
012400171128      /DEFINE CHK_ACA_PLAN_FIELDS
012500171128      /COPY QCPYSRC,ACASRVPGMP
012600171128      /UNDEFINE CHK_ACA_PLAN_PR
012700171128      /UNDEFINE CHK_ACA_PLAN_FIELDS
012800180604
012900180604      /include GBSPGM/QMODSRC,#CommandPr
013000220505      /Include *LIBL/QMODSRC,#GetEnvrPr            // Get Environment
013100240312J001  /copy *libl/qmodsrc,#gbsfrmpr
013200240312J001  /copy *libl/qmodsrc,#aacolorpr
013300171128
013400171229
013500171229      *-------------------------------------------------------------------------
013600171229      *
013700171229      * Global Variables
013800171229      *
013900171229      *-------------------------------------------------------------------------
014000190516
014100190516
014200190516       dcl-ds pgmd
014300210707       ExtName('IOPGMD') PSDS;
014400210707         @pgmq *proc;
014500190516       end-ds;
014600190516
014700190516
014800171229       Dcl-s rrn Zoned(5) inz;
014900171229       Dcl-s rrn2 Zoned(5) inz;
015000210505       Dcl-s rrn3 Zoned(5) inz;
015100171229
015200171229       dcl-s CodeSrch Char(3);
015300171229       dcl-s CharZip  Char(9);
015400171229       dcl-s wSsn Zoned(9);
015500220506       dcl-s Company Char(50) dtaara;
015600220504
015700220504       Dcl-s Library Char(10);
015800220504       dcl-s Library2 Char(10);
015900171229
016000171229       dcl-s SqlStmt Char(1000) inz;
016100210505       dcl-s SqlStmt2 Char(1000) inz;
016200171229       dcl-c q '''';
016300171229       dcl-s Histkey char(10);
016400171229       dcl-s in_Ole char(1);
016500171229       dcl-s wDate Zoned(8);
016600180402       dcl-s phonec Char(7);
016700171229
016800171229
016900180612       dcl-s dash Zoned(2);
017000180612       dcl-s Payr Zoned(2);
017100191104br02   dcl-s Att_Type Char(10);
017200180612
017300210707       dcl-ds @HistData;
017400190502         sqtrDate Zoned(8);
017500190502         sqlDescr Char(30);
017600190502         sqNote1  Char(30);
017700190502         sqNote2  Char(30);
017800190502         sqCovtDt Zoned(8);
017900190502         sqOper   Char(10);
018000190502         sq$Flg   Char(1) ;
018100190502         sqRecDt  Zoned(8);
018200190502         sqTrAmt  Zoned(9:2);
018300210707         sqTrCode Char(3);
018400210707         sqTime   Time;
018500171229       End-Ds;
018600170605
018700210707       dcl-ds Sq_Data ExtName('SUBMEM') End-DS;
018800210505
018900240312J001 D prtfrm        e ds                  extname(genolefrmp) inz
019000210505
019100171229      *-------------------------------------------------------------------------
019200171229      *
019300171229      * Procedures
019400171229      *
019500171229      *-------------------------------------------------------------------------
019600171229
019700210707       dcl-pr zFill Char(100);
019800210707         len Zoned(3) value;
019900210707         text Char(100) value;
020000171229       End-Pr;
020100171229
020200171229
020300240312       dcl-pr BuildForm ExtPgm('PRTOLEFR2C');
020400240312         oSSID char(16);
020500240312         oRtn  char(1);
020600171229       End-Pr;
020700240313
020800240313       dcl-pr BuildFormPay ExtPgm('PRTOLEFR2P');
020900240313         oSSID char(16);
021000240313         oRtn  char(1);
021100240313       End-Pr;
021200240312
021300240312       dcl-pr IssueTracking ExtPgm('INQ003R');
021400240312         oTrst Zoned(3);
021500240312         oSub# Zoned(3);
021600240312         oAcct Zoned(4);
021700240312         oMember Zoned(9);
021800240312       End-Pr;
021900171229
022000171229       dcl-s oTrst Zoned(3);
022100171229       dcl-s oSub# Zoned(3);
022200171229       dcl-s oAcct Zoned(4);
022300171229
022400170605
022500171229       dcl-pr DiaryNotes ExtPgm('TR121CL') ;
022600210707         *n Char(11);
022700171229       End-Pr;
022800171229       dcl-s oDiary Char(11);
022900171027
023000171229
023100171229       dcl-pr PCP_Maint ExtPgm('INQ005R');
023200210707         oMember Zoned(9);
023300171229       End-Pr;
023400171229
023500171229
023600171229       dcl-pr Debit_Maint ExtPgm('FM430CL');
023700210707         oMemberC Char(9);
023800171229       End-Pr;
023900220228       dcl-s CharMember Char(9);
024000220228       dcl-s CharTSA Char(10);
024100171229
024200171229
024300171229       dcl-pr Dep_List ExtPgm('INQ006R') ;
024400210707         oMember Zoned(9);
024500171229       End-Pr;
024600171229
024700171229
024800171229       dcl-pr MoreCovg ExtPgm('INQ012R');
024900210707         oMember Zoned(9);
025000171229       End-Pr;
025100171229
025200220228       dcl-pr Tmp_IDcard ExtPgm('TID001R');
025300220228         oTSA Char(10);
025400220228         oMemberC Char(9);
025500220228         oUSER Char(10);
025600220228       End-Pr;
025700220228       dcl-s oTSA Char(10);
025800220228       dcl-s oUser Char(10);
025900171229
026000171229       dcl-pr OLE_List ExtPgm('INQ007R');
026100210707         oMember Zoned(9);
026200171229       End-Pr;
026300171229
026400171229
026500171229       dcl-pr ACA_Prem ExtPgm('IQ015CL');
026600210707         oMemberC Char(9);
026700171229       End-Pr;
026800171229
026900171229
027000210707       dcl-pr Ben_Summary ExtPgm('INQBSMCL');
027100190502         oTrstc Char(3);
027200190502         oSub#c Char(3);
027300210707         oAcctc Char(4);
027400210707         oMemberC Char(9);
027500171229       End-Pr;
027600171229       dcl-s oTrstc Char(3);
027700171229       dcl-s oSub#c Char(3);
027800171229       dcl-s oAcctc Char(4);
027900171103
028000171128
028100210707       dcl-pr AccountInq ExtPgm('INQ008R');
028200190502         oTrst Zoned(3);
028300210707         oSub# Zoned(3);
028400210707         oAcct Zoned(4);
028500171229       End-Pr;
028600171103
028700180426
028800210707       Dcl-pr onSiteList ExtPgm('INQ018R');
028900190502         oTrst Zoned(3);
029000210707         oSub# Zoned(3);
029100210707         oAcct Zoned(4);
029200180426       End-Pr;
029300180720
029400180720
029500180720       dcl-pr GetINVList ExtPgm('INQ002C1');
029600210707         oPath Char(15);
029700180720       End-Pr;
029800180720       dcl-s oPath Char(15);
029900180720
030000190515br01   dcl-pr ListNH_Email ExtPgm('INQ002C2');
030100210707         oNHPath Char(25);
030200190515       End-Pr;
030300190515       dcl-s oNHPath Char(25);
030400190515
030500180720
030600180720       dcl-pr OpenFolder ExtPgm('INQ008C');
030700210707         oFolder Char(150);
030800180720       End-Pr;
030900180720       dcl-s oFolder Char(150);
031000180720
031100210707       dcl-pr EmailInvoice ExtPgm('INQ008C2');
031200210707         oInvPath Char(150);
031300210707         oInvNbr  Char( 30);
031400180720       End-Pr;
031500180720       dcl-s oInvPath Char(150);
031600180720       dcl-s oInvNbr  Char( 30);
031700180720
031800180720
031900180720
032000180720       dcl-pr EmailUser ExtPgm('INQ008C3');
032100210707         oEmailAddr Char(50);
032200180720       End-Pr;
032300180720       dcl-s oEmailAddr Char(50);
032400180720
032500190514
032600190514       dcl-pr INQ021C ExtPgm('INQ021C');
032700210707         oMember Zoned(9);
032800190514       End-Pr;
032900180720
033000200520
033100200520       dcl-pr INQ025R ExtPgm('INQ025R');
033200210707         oMember Zoned(9);
033300200520       End-Pr;
033400200520
033500220707       //dcl-s type Char(1);
033600220624       dcl-pr uhcDNS ExtPgm('UHCDNSR2');
033700220624         mbTrst   Packed(3:0);
033800220624         mbSub#   Packed(3:0);
033900220624         mbAcct   Packed(4:0);
034000220624         s1ssn    Packed(9:0);
034100220624         s1plan   Char(4);
034200220624         s1Enroll Char(10);
034300220624         s1Cancel Char(10);
034400220624         type     Char(1);
034500220624       End-Pr;
034600220624
034700220624       dcl-pr viewDNS ExtPgm('UHCDNSR');
034800220624         mbTrst   Packed(3:0);
034900220624         mbSub#   Packed(3:0);
035000220624         mbAcct   Packed(4:0);
035100220624       End-Pr;
035200190514
035300220707       dcl-s type Char(1);
035400230313       dcl-s s1Enroll Char(10);
035500230313       dcl-s s1Cancel Char(10);
035600220707       dcl-pr uhcMENU ExtPgm('UHCDNSMNR');
035700220707         mbTrst   Packed(3:0);
035800220707         mbSub#   Packed(3:0);
035900220707         mbAcct   Packed(4:0);
036000220707         s1ssn    Packed(9:0);
036100220707         s1plan   Char(4);
036200220707         s1Enroll Char(10);
036300220707         s1Cancel Char(10);
036400220707         type     Char(1);
036500220707       End-Pr;
036600220707
036700240426       dcl-s xPlan Char(4);
036800240426       dcl-s xTrst Packed(3);
036900240426       dcl-s xSub Packed(3);
037000240426       dcl-s xAcct Packed(4);
037100240426       Dcl-pr getAux ExtPgm('FI035R2');
037200240426         xTrst packed(3);
037300240426         xSub# packed(3);
037400240426         xPlan Char(4);
037500240426         xAcct packed(4);
037600240426       End-Pr;
037700240426
037800180612       //----------------------------------------------------
037900180612       //
038000180612       //   Following is used for the Library List
038100180612       //
038200210707       //----------------------------------------------------
038300210707       dcl-pr RtvJobInf ExtPgm('QUSRJOBI');
038400190502         RcvVar Char(32766) options(*varsize);
038500190502         RcvVarLen int(10) Const;
038600190502         Format Char(8) Const;
038700210707         JobName Char(26) Const;
038800210707         IntJobId Char(16) Const;
038900180612       End-Pr;
039000180612
039100180612       dcl-s IntJobId Char(16) Inz( *Blank );
039200180612       dcl-s Format Char(8) inz( 'JOBI0700' );
039300180612       dcl-s LibsToSkip Int(10);
039400180612       dcl-s pos int(10);
039500180612       dcl-s QualJobName Char(26) inz( '*' );
039600180612       dcl-s RcvVarLen Int(10) inz( %Len( RcvVar ));
039700180612
039800210707       dcl-ds RcvVar len(32767) ;
039900210707         misc Char(64) Inz(*Blank);
040000210707         NbrSysLibs Int(10) Inz(0);
040100210707         NbrPrdLibs Int(10) Inz(0);
040200210707         NbrCurLibs Int(10) Inz(0);
040300210707         NbrUsrLibs Int(10) Inz(0);
040400180612       End-Ds;
040500180612
040600180612       dcl-ds UsrLibs Len(550);
040700210707         TheLibs Char(11) Dim(50);
040800180612       End-Ds;
040900180612
041000190516
041100190516br01   dcl-s Attach1 Char(200) ;
041200190516br01   dcl-s Attach2 Char(200) ;
041300190516br01   Dcl-s Msg Char(2000);
041400190516br01   dcl-s Subject Char(100);
041500190516br01   dcl-s toAddr Char(200);
041600220124br01   dcl-s myEmail Char(60);
041700180612
041800200520       dcl-s Depend_Medi ind;
041900200520       dcl-s count zoned(3);
042000220901     d tdateISO        s               d
042100220901     d fdateISO        s               d
042200180612
042300180404      *-------------------------------------------------------------------------
042400180404      *
042500180404      * *Entry Procedure
042600180404      *
042700180404      *-------------------------------------------------------------------------
042800180404       Dcl-pr Main ExtPgm;
042900210707         *N  Zoned(9);
043000180404       End-Pr;
043100180404
043200180404       dcl-pi Main;
043300210707         pMember Zoned(9);
043400180404       End-Pi;
043500180404
043600180404
043700210707       Exec Sql
043800210707         Set Option Commit = *None, Naming = *Sys;
043900190516
044000190516
044100190516       init();
044200171020
044300161111
044400171229      *-------------------------------------------------------------------------
044500171229      *
044600171229      * Mainline Program
044700171229      *
044800171229      *-------------------------------------------------------------------------
044900171122       s1HistDate = %Date - %Years(2);
045000171122
045100171127       s1ssn = pMember;
045200171127
045300210707       Dou btnExit = *on;
045400190502         wssn = s1ssn;
045500210707         chain s1ssn Member;
045600190502         if not %Found( Member );
045700210707           leave;
045800190502         endif;
045900171127
046000190502         SetLibl();
046100190502         LoadMember();
046200170605
046300190502         Clear_All();
046400190502         LoadActCovgs();
046500190502         LoadTrmCovgs();
046600190502         LoadHistory();
046700210505
046800210707         Load_CBR_Sub();
046900171103
047000190502         //?Build Menu
047100190502         MnuChoice = 'Diary,Issues, COBRA, PCP,  Debit Card,' +
047200220307         'Dependents, Temp ID';
047300171103
047400220228         MnuValue  = 'DIARY,ISSUES,COBRA,PCP,DEBIT,DEPEND,IDCARD';
047500171103
047600180628
047700210707         if in_Ole = 'Y';
047800180628
047900210707           if pySts > '';
048000210707             MnuChoice = %Trim(MnuChoice) + ', Benefit Summary';
048100210707             MnuValue  = %Trim(MnuValue)  + ',BENSUM';
048200190502           endif;
048300180628
048400210707           MnuChoice = %Trim(MnuChoice) + ',OLE Data';
048500210707           MnuValue  = %Trim(MnuValue)  + ',OLE';
048600190502         endif;
048700171103
048800171128
048900210707         if isACA = *on;
049000210707           MnuChoice = %Trim(MnuChoice) + ',ACA Premium';
049100210707           MnuValue  = %Trim(MnuValue)  + ',ACA';
049200190502         endif;
049300190514
049400190514
049500231113         if Elecrt = 'Y' or Elecrt = 'D';
049600210707           MnuChoice = %Trim(MnuChoice) + ',Check by Phone';
049700210707           MnuValue  = %Trim(MnuValue)  + ',ChkPhone';
049800190514         endif;
049900171128
050000210707         if s1medi = 'Y' or depend_Medi;
050100210707           MnuChoice = %Trim(MnuChoice) + ',Medicare Info';
050200210707           MnuValue  = %Trim(MnuValue)  + ',MediInfo';
050300200520         EndIf;
050400171128
050500171103
050600190502         // Display Screen
050700190502         Disp_All();
050800180720
050900180720
051000190502         // Read through the History Subfile.
051100190502         ReadChanged();
051200180720
051300180720
051400220706         // Read through the Coverage Subfile.
051500220707          ReadChanged2();
051600220624
051700170605
051800210707         if btnMoreCvg = *on;
051900210707           MoreCovg( wssn );
052000210707           btnMoreCvg = *off;
052100190502         endif;
052200171127
052300190502         //-----------------------------
052400190502         //
052500190502         // Onsite Link Selected?
052600190502         //
052700210707         //-----------------------------
052800210707         if btnOnSite = *on;
052900190502           oTrst = mbTrst;
053000190502           oSub# = mbSub#;
053100190502           oAcct = mbAcct;
053200180426
053300210707           onSiteList( oTrst : oSub# : oAcct );
053400180426
053500190502         EndIf;
053600180426
053700180426
053800180426
053900210707         if btnGoAcct = *on;
054000190502           oTrst = mbTrst;
054100190502           oSub# = mbSub#;
054200190502           oAcct = mbAcct;
054300171128
054400210707           AccountInq( oTrst : oSub# : oAcct );
054500210707           btnGoAcct = *off;
054600190502         endif;
054700171128
054800171127
054900190502         // Process Menu Options
055000210707         Select;
055100210707         When mnuResp = 'DIARY';
055200190502           oDiary = 'I' + %Editc(s1ssn:'X');
055300171027
055400190502           //    oDiary = 'I' + %Editc(mbTrst:'X') +  %Editc(mbSub#:'X') +
055500190502           //                   %Editc(mbAcct:'X');
055600171027
055700210707           DiaryNotes( oDiary );
055800171027
055900171027
056000171027
056100210707         When mnuResp = 'ISSUES';
056200190502           oTrst = mbTrst;
056300190502           oSub# = mbSub#;
056400190502           oAcct = mbAcct;
056500171020
056600210707           IssueTracking( oTrst : oSub# : oAcct : wssn );
056700171020
056800171020
056900171020
057000210707         When mnuResp = 'COBRA';
057100210505
057200210505           DspSfl3 = *on;
057300190502           exfmt Cobra;
057400210505           DspSfl3 = *off;
057500210505
057600210707           btnClose = *off;
057700171030
057800190502         When mnuResp = 'PCP';
057900210707           Pcp_Maint( wssn );
058000171101
058100190514
058200190514         When mnuResp = 'ChkPhone';
058300210707           INQ021C( wssn );
058400190514
058500171101
058600200520         When mnuResp = 'MediInfo';
058700210707           INQ025R( wssn );
058800171101
058900210707         When mnuResp = 'DEBIT';
059000210707           CharMember = %Editc( s1ssn : 'X' );
059100210707           Debit_Maint( CharMember );
059200220228
059300220228         When mnuResp = 'IDCARD';
059400220228           CharMember = %Editc( s1ssn : 'X' );
059500220228           CharTSA = %Editc( mbtrst: 'X' ) +
059600220228                     %Editc( mbsub#: 'X' ) +
059700220228                     %Editc( mbacct: 'X' ) ;
059800220228           oUSER = %trim(WQUSRN);
059900220228           Tmp_IDcard( CharTSA : CharMember : oUSER);
060000171128
060100210707         When mnuResp = 'ACA';
060200210707           CharMember = %Editc( s1ssn : 'X' );
060300210707           ACA_Prem( CharMember );
060400171128
060500171101
060600190502         When mnuResp = 'DEPEND';
060700210707           Dep_List( wssn );
060800171102
060900171103
061000171103
061100190502         When mnuResp = 'OLE';
061200210707           OLE_List( wssn );
061300171103
061400190514
061500190514
061600171102
061700210707         When mnuResp = 'BENSUM';
061800190502           oTrstC = %Editc( mbTrst : 'X' );
061900190502           oSub#C = %Editc( mbSub# : 'X' );
062000190502           oAcctC = %Editc( mbAcct : 'X' );
062100190502           CharMember = %Editc( s1ssn : 'X' );
062200171103
062300210707           Ben_Summary( oTrstC : oSub#C : oAcctC : CharMember );
062400171103
062500171103
062600190502         Endsl;
062700170606
062800170606
062900210707         // Get the "F" Out
063000210707         if btnGTFO = *on;
063100210707           CmdString = 'ENDRQS';
063200210707           #Command(CmdString:%len(%Trim(CmdString)));
063300210707         EndIf;
063400170606
063500170525       enddo;
063600170529
063700170525       *inlr = *on;
063800170525
063900170525
064000210505      *-------------------------cl------------------------------------------------
064100171229      *
064200171229      * Load the Member Section
064300171229      *
064400171229      *-------------------------------------------------------------------------
064500210707       dcl-proc LoadMember;
064600170531
064700190520         dcl-s @Seq Zoned( 2 );
064800210614         dcl-s fullAcct Char(10);
064900210614
065000210614
065100210614
065200190502         // Check to see if the member is in OLE
065300190502         in_Ole = 'N';
065400210707         chain s1ssn WebPayrol1;
065500190502         if %Found( WebPayrol1 ) ;
065600210707           in_Ole = 'Y';
065700190502         endif;
065800171103
065900190502         s1ssn_nd = %Editc(s1ssn : 'X' );
066000171103
066100190502         // Load Data
066200210707         chain s1ssn Member;
066300210707         if %Found(Member);
066400170531           s1FulName = %trim(mlname) + ', ' + %trim(mfname) + ' ' + %trim(mmi);
066500171127
066600190521           ShowLongNm = *off;
066700210707           chain ( s1ssn : @Seq ) CFS100P ;
066800210707           if %Found( CFS100P ) ;
066900191104             s1FulName = %trim(cfslst) + ', ' + %trim(cfsfst) + ' ' +
067000210707               %trim(cfsmid);
067100210707             ShowLongNm = *on;
067200190520           endif;
067300190520
067400190520
067500190502           s1ActNbr = %Editc(mbTrst:'X') +'-'+  %Editc(mbSub#:'X') +'-'+
067600210707           %Editc(mbAcct:'X');
067700190502           chain ( mbTrst : mbSub# : mbAcct ) AccMst;
067800240312           aacolor = #aacolor(mbTrst:mbSub#:mbAcct);
067900190502           s1ActNam = acnam1;
068000171127
068100190502           s1Addr1 = addr1;
068200190502           s1Addr2 = addr2;
068300170531
068400210707           CharZip = %Editc(Zip : 'X');
068500190502           if %Subst( CharZip : 6 : 4 ) = '0000';
068600210707             %Subst( CharZip : 6 : 4 ) = '    ';
068700190502           endif;
068800190404
068900190404
069000210707           s1CityStZp = %trim(city) + ', ' + %Trim(State);
069100190502           if %len(%Trim(CharZip)) = 9;
069200210707             s1CityStZp = %trim(s1CityStZp) + '  ' + %Subst(CharZip:1:5) +
069300210707               '-' + %Subst(CharZip:6:4);
069400190502           else;
069500210707             s1CityStZp = %trim(s1CityStZp) + '  ' + CharZip;
069600190502           endif;
069700170531
069800190502           s1Sex = sex;
069900190502
070000190502
070100190502
070200210707           test(DE) *iso birth;
070300210707           if not %Error;
070400190502
070500190502             s1Birth = %Char(%Date(birth:*iso):*Usa);
070600190502
070700210707             s1Age = %Diff( %Date(birth:*iso) : %Date : *Years);
070800210707             s1Age = %Abs(s1Age);
070900190502           endif;
071000180226
071100210707           s1Doh = *Blanks;
071200190502           if empdt > 0;
071300210707             s1Doh = %Char(%Date(empdt:*iso):*Usa);
071400190502           endif;
071500180618
071600210707           s1MarDt = '';
071700190502           if Mardt > 0;
071800210707             s1MarDt = %Char(%Date(Mardt:*iso):*Usa);
071900190502           endif;
072000180618
072100180226
072200190502           s1Handi = hndicp;
072300190502           s1Cob = Cob;
072400190502           s1Salary = salary;
072500190502           s1Medi = medicr;
072600200129           s1Email = %Subst(Fill66:1:65);
072700190502           s1mailto = 'mailto:' + %Trim(s1Email);
072800190502           PhoneC = %editc( Phone : 'X' ) ;
072900190502           s1Phone = '(' +  %Editc( area  : 'X' ) + ') ' +
073000210707           %Subst( %Editc(Phone:'X') : 1 : 3 ) + '-' +
073100210707           %Subst( %Editc(Phone:'X') : 4 : 4 );
073200180402
073300180426
073400180426
073500190502           // Check the Onsite Dental Database.
073600190502           ShowDntCnt = *off;
073700210707           chain  ( mbTrst : mbSub# : 0 ) odcntcp;
073800190502           if %Found( odcntcp );
073900210707             ShowDntCnt =  *on;
074000190502           EndIf;
074100180426
074200180426
074300210707           chain  ( mbTrst : mbSub# : mbAcct ) odcntcp;
074400190502           if %Found( odcntcp );
074500210707             ShowDntCnt =  *on;
074600190502           EndIf;
074700180426
074800180426
074900171116
075000190502           //?Load the Cobra Data
075100210707           s1Medadt = *Blanks;
075200190502           if medadt > 0;
075300210707             s1Medadt = %Char(%Date(Medadt:*iso):*Usa);
075400190502           endif;
075500171030
075600210707           s1Medbdt = *Blanks;
075700190502           if medbdt > 0;
075800210707             s1Medbdt = %Char(%Date(Medbdt:*iso):*Usa);
075900190502           endif;
076000171030
076100190502           isCobra = *off;
076200210707           s1cexpdt = *Blanks;
076300210707           if cexpdt > 0;
076400210707             s1cexpdt = %Char(%Date(cexpdt:*iso):*Usa);
076500210707             isCobra = *on;
076600190502           endif;
076700171121
076800190502           s1termdt = *Blanks;
076900210707           isCancld = *off;
077000210707           if EmpSt = 'C' and %Subst( Status : 2 : 1 ) <> 'A';
077100210707             isCancld = *on;
077200190502             if termdt > 0;
077300210707               s1Termdt = %Char(%Date(Termdt:*iso):*Usa);
077400210707             endif;
077500190502           endif;
077600171030
077700210707           if %Subst( Status : 2 : 1 ) = 'C';
077800210707             isCancld = *on;
077900190502             if termdt > 0;
078000210707               s1Termdt = %Char(%Date(Termdt:*iso):*Usa);
078100210707             endif;
078200190502           endif;
078300180409
078400210707           ShowNonSSN = *off;
078500190502           if %Subst( Fill66 : 66 : 1 ) = 'Y';
078600210707             ShowNonSSN = *on;
078700190502           endif;
078800171218
078900210707           s1cvthdt = *Blanks;
079000190502           if cvthdt > 0;
079100210707             s1cvthdt = %Char(%Date(cvthdt:*iso):*Usa);
079200190502           endif;
079300171030
079400210707           s1qedt = *Blanks;
079500190502           if qedt > 0;
079600210707             s1qedt = %Char(%Date(qedt:*iso):*Usa);
079700190502           endif;
079800171030
079900210707           s1ntfydt = *Blanks;
080000190502           if ntfydt > 0;
080100210707             s1ntfydt = %Char(%Date(ntfydt:*iso):*Usa);
080200190502           endif;
080300180725
080400180725
080500190502           s1QeDesc = '';
080600210707           chain qecd Codesl1;
080700190502           if %Found( Codesl1 );
080800210707             s1QeDesc = ldescr;
080900190502           endif;
081000180725
081100180725
081200190502           s1NotDesc = '';
081300210707           chain ntfycd Codesl1;
081400190502           if %Found( Codesl1 );
081500210707             s1NotDesc = ldescr;
081600190502           endif;
081700180725
081800210707           s1gbscdt = *Blanks;
081900190502           if gbscdt > 0;
082000210707             s1gbscdt = %Char(%Date(gbscdt:*iso):*Usa);
082100190502           endif;
082200171030
082300210707           s1eexpdt = *Blanks;
082400190502           if eexpdt > 0;
082500210707             s1eexpdt = %Char(%Date(eexpdt:*iso):*Usa);
082600190502           endif;
082700171030
082800190502           // Cost Center
082900190502           s1ccflg = ccflg;
083000190502           s1ccdesc = '';
083100210707           chain ccflg Codesl1;
083200190502           if %Found( Codesl1 );
083300210707             s1ccdesc = ldescr;
083400190502           endif;
083500180228
083600180228
083700190502           s1elecrt = elecrt;
083800190502           s1NonEmp = NonEmp;
083900171030
084000190502           chain ( 'J ' + EmpSt ) CodesL1;
084100190502           s1EmpStsF = lDescr;
084200201216           s1StsDesc = lDescr;
084300201216
084400210707           // Enrollment Date
084500210707           monitor;
084600210707             s1EnrlDt = *Blanks;
084700201216             if mbenrl > 0;
084800210707               s1EnrlDt = %Char(%Date(mbenrl:*iso):*Usa);
084900201216             endif;
085000201216           on-error;
085100210707             s1EnrlDt = %Char(mbenrl);
085200201216           endmon;
085300201216
085400210707           chain ( s1ssn : 'GBS' ) MemAlt;
085500190502           if %Found( MemAlt );
085600210707             s1AltId = maAltId;
085700190502           endif;
085800171030
085900171030
086000190502           s1PrvBal = PrvBal;
086100190502           s1CurBal = CurBal;
086200190502           s1TotBal = PrvBal + CurBal;
086300171030
086400200520           count = 0;
086500200520           Depend_Medi = *off;
086600200520
086700210707           exec sql
086800210707             Select count(*)
086900210707               into :Count
087000210707               from "F.DEPEND"
087100210707               where dssno = :s1ssn and
087200210707                     dmedcr = 'Y';
087300200520
087400200520           if count > 0;
087500210707             depend_Medi = *on;
087600200520           EndIf;
087700200520
087800210614
087900210614
088000210707           //----------------------------------------------------
088100210707           //
088200210707           // Get the Payroll Import file information
088300210707           //
088400210707           //----------------------------------------------------
088500210707           FullAcct  = %Editc( mbTrst : 'X' ) + %Editc( mbSub# : 'X' ) +
088600210614           %Editc( mbAcct : 'X' );
088700210614
088800210707           s1PayVend = '';
088900210707           Exec Sql
089000210707             Select ftpayvend
089100210707               Into :s1payvend
089200210707               From gbs0030p
089300210707               Where ftgroup = :fullacct;
089400210614
089500210614
089600210707         endif;
089700171030
089800170531
089900210707         //----------------------------------------------------
090000210707         //
090100210707         // Member Extension File
090200210707         //
090300210707         //----------------------------------------------------
090400210707         chain s1ssn MemExtp;
090500210707         if %Found( MemExtp ) ;
090600210707
090700210707           s1EmpNbr = meEmpNbr;
090800210707           s1Loc = meLoc;
090900210707           s1Dept = meDept;
091000210707           s1Hrs = meHrs;
091100210707           s1Div = meDiv;
091200210707           if %len( %Trim( meOcc )) > 30;
091300210707             s1occSm = %subst(meOcc:1:27) + '...';
091400210707             s1Occ = meOcc;
091500210707           else;
091600210707             s1occSm = meOcc;
091700210707             s1Occ = '';
091800210707           endif;
091900210707
092000210707           s1Rule = meRule;
092100210707           s1Mgs = MEMGS;
092200210707
092300210707           s1RuleChg = '';
092400210707           if meRulChgd > 0;
092500210707             test(de) *iso meRulChgd;
092600210707             if %Error;
092700210707               s1RuleChg = %Char(meRulChgd);
092800210707             else;
092900210707               s1RuleChg = %Char(%date(meRulChgd) :*usa)  ;
093000210707             endif;
093100210707           endif;
093200210707
093300210707
093400210707           s1eeo = meEeo;
093500210707
093600210707           if meCommSal = 'Y';
093700210707             s1CommSal = 'Yes';
093800210707           endif;
093900210707
094000210707
094100210707           s1Smoke = meSmoke;
094200210707           s1SmkEffDt = '';
094300210707           if meSmkEffDt > 0;
094400210707             test(de) *iso meSmkEffDt;
094500210707             if %Error;
094600210707               s1SmkEffDt = %Char(meSmkEffDt);
094700210707             else;
094800210707               s1SmkEffDt = %Char(%date(meSmkEffDt) :*usa)  ;
094900210707             endif;
095000210707           endif;
095100210707
095200210707
095300210707
095400210707         EndIf;
095500210707
095600210707
095700210707
095800170531
095900210707       end-proc;
096000170531
096100170531
096200171229      *-------------------------------------------------------------------------
096300171229      *
096400171229      * Clear the Subfiles...
096500171229      *
096600171229      *-------------------------------------------------------------------------
096700210707       dcl-proc Clear_All;
096800170605
096900190502         // Clear the Subfile.
097000190502         ClrSfl = *on;
097100200520         Write Screen1;
097200210707         ClrSfl = *off;
097300210707         rrn = 0;
097400210707         rrn2 = 0;
097500170605
097600210505
097700210707         ClrSfl3 = *on;
097800210707         Write Cobra;
097900210707         ClrSfl3 = *off;
098000210505
098100210707         rrn3 = 0;
098200210505
098300210505
098400170605
098500210707       end-proc;
098600170605
098700171229      *-------------------------------------------------------------------------
098800171229      *
098900171229      * Display The Subfiles...
099000171229      *
099100171229      *-------------------------------------------------------------------------
099200220707       dcl-proc Disp_All;
099300220504
099400220504        Get_Env();
099500170605
099600210707         // Display the Subfile.
099700210707         DspSfl = *on  ;
099800210707         exfmt Screen1;
099900200520         DspSfl = *off;
100000170605
100100210707       end-proc;
100200170607
100300171229      *-------------------------------------------------------------------------
100400171229      *
100500171229      * Load the Active Coverages Section
100600171229      *
100700171229      *-------------------------------------------------------------------------
100800210707       dcl-proc LoadActCovgs;
100900170531
101000210707         s1TotPrem = 0;
101100210707         isACA = *off;
101200171128
101300210707         // Retrive the Active Records..
101400210707         setll s1ssn mCov40;
101500170531
101600210707         dou %Eof(mCov40);
101700190502           reade s1ssn mCov40;
101800170605
101900210707           if %eof( mCov40 );
102000210707             leave;
102100190502           endif;
102200170605
102300190606           clClass = '';
102400190606
102500190502           chain (mcTrst : mcSub# : mcPlan ) PlnMst;
102600190502           chain (mcTrst : mcSub# : mcPlan ) PlnAuxp;
102700200520           chain (mcTrst : mcSub# : mcPlan : mCovtp ) Class;
102800200520           if not %Found(Class);
102900210707             chain (mcTrst : mcSub# : mcPlan : 'TNA' ) Class;
103000200520           endif;
103100170605
103200190502           // Check for ACA Plans
103300200520           if pxacar = 'Y' or pxacar = 'D';
103400210707             isAca = *on;
103500190502           endif;
103600171128
103700171128
103800190502           //chain (mcTrst : mcSub# : mcPlan : mcAgeb : mCovtp ) Grate;
103900190502           chain (mcTrst : mcSub# : mcPlan : mCovtp ) Grat26;
104000170605
104100190502           s1PlanName = mcPlan + ' ' + %Trim( pDescr );
104200210707           s1CovTp = %Subst( mCovtp : 2 : 2);
104300200520           s1Ageb = mcAgeb ;
104400220624           s1Plan = mcPlan;
104500220706
104600220706
104700230313           //s1Enroll = '';
104800230313           s1Enrolld = d'0001-01-01';
104900200520           if enrldt > 0;
105000230313             //s1Enroll = %Char(%Date(enrldt :*iso):*Usa);
105100230313             s1Enrolld = %date(enrldt:*iso);
105200220901             fdateISO =  %date(enrldt:*iso);
105300200520           endif;
105400170605
105500230313           s1Canceld = d'0001-01-01';
105600230313           //s1Cancel = '';
105700200520           if candt > 0;
105800230313             //s1Cancel = %Char(%Date(candt :*iso):*Usa);
105900230313             s1Canceld = %date(candt:*iso);
106000220901             tdateISO =  %date(candt:*iso);
106100200520           endif;
106200170605
106300190502           s1Premium = lPrem;
106400200520           if s1Premium = 0;
106500210707             s1Premium = BilRte;
106600190712           endif;
106700190712
106800200520           s1TotPrem = s1TotPrem + s1Premium;
106900210707           s1clsben = clClass;
107000170605
107100200520           if BenAmt <> 0;
107200210707             s1ClsBen = %editc(benamt:'J')  ;
107300200520           EndIf;
107400180111
107500220901           chain (mcTrst:mcSub#:mbAcct:s1ssn:mcPlan:fdateISO:tdateISO)
107600220901              hrafsabar;
107700220901           if %found;
107800220901            s1ClsBen = %char(hbnamt);
107900220901           endif;
108000220901
108100220901           planCursor = *Blanks;
108200220707           planColor  = '#000000 ';
108300220706
108400220707           runOption5 = ' ';
108500220706           if pcarr = 'AUM' or pcarr = 'UHC' or pcarr = 'UHO'
108600220706            or pcarr = 'UHD' or pcarr = 'UHH' or pcarr = 'UHP'
108700220706             or pcarr = 'UHV' or pcarr = 'ULD' or pcarr = 'ULH'
108800240521              or pcarr = 'ULV' or pcarr = 'ULP'
108900240521               or pcarr = 'USM' or pcarr = 'USD'      // J002
109000240521                or pcarr = 'USV' or pcarr = 'USL';    // J002
109100220707              planCursor = 'text';
109200220706             planColor = '#0000FF';
109300220707             runOption5 = 'UHC';
109400220707            //loadUHC();
109500220706           endIf;
109600220706
109700180111
109800210707           s1rb = *Blanks;
109900210707           if mcorgben > benamt;
110000210707             s1rb = 'Y';
110100210707           endif;
110200170605
110300210707           s1Group# = Group#;
110400170605
110500210707           rrn = rrn + 1;
110600210707           write CovSfl;
110700170605
110800210707         Enddo;
110900170605
111000170605
111100210707       end-proc;
111200170605
111300170605
111400171229      *-------------------------------------------------------------------------
111500171229      *
111600171229      * Load the Termed Coverages Section
111700171229      *
111800171229      *-------------------------------------------------------------------------
111900210707       dcl-proc LoadTrmCovgs;
112000170607
112100170607
112200210707         // Retrive the Termed Records..
112300210707         setll s1ssn mCov41;
112400170607
112500210707         dou %Eof(mCov41);
112600190502           reade s1ssn mCov41;
112700170607
112800200520           if %eof( mCov41 );
112900210707             leave;
113000190502           endif;
113100170607
113200190502           clClass = '';
113300180111
113400190502           chain (mcTrst : mcSub# : mcPlan ) PlnMst;
113500200520           chain (mcTrst : mcSub# : mcPlan : mCovtp ) Class;
113600200520           if not %Found(Class);
113700210707             chain (mcTrst : mcSub# : mcPlan : 'TNA' ) Class;
113800210707           endif;
113900170607
114000190502           //    chain (mcTrst : mcSub# : mcPlan : mcAgeb : mCovtp ) Grate;
114100190502           chain (mcTrst : mcSub# : mcPlan : mCovtp ) Grat26;
114200170607
114300190502           s1PlanName = mcPlan + ' ' + %Trim( pDescr );
114400200520           s1CovTp = %Subst( mCovtp : 2 : 2);
114500200520           s1Ageb = mcAgeb ;
114600220624           s1Plan = mcPlan;
114700220706
114800200520           if enrldt > 0;
114900230313             //s1Enroll = %Char(%Date(enrldt :*iso):*Usa);
115000230313             s1Enrolld = %date(enrldt:*iso);
115100210707           endif;
115200170607
115300200520           if candt > 0;
115400230313             //s1Cancel = %Char(%Date(candt :*iso):*Usa);
115500230313             s1Canceld = %date(candt:*iso);
115600190502           endif;
115700170607
115800210707           s1Premium = lPrem;
115900190502           s1clsben = clClass;
116000170607
116100200520           if BenAmt <> 0;
116200210707             s1ClsBen = %editc(benamt:'J')  ;
116300200520           EndIf;
116400220901
116500220901           chain (mcTrst:mcSub#:mbAcct:s1ssn:mcPlan:fdateISO:tdateISO)
116600220901              hrafsabar;
116700220901           if %found;
116800220901            s1ClsBen = %char(hbnamt);
116900220901           endif;
117000220901
117100220706           planCursor = *Blanks;
117200220707           planColor  = '#000000';
117300220706
117400220707           runOption5 = ' ';
117500220706           if pcarr = 'AUM' or pcarr = 'UHC' or pcarr = 'UHO'
117600220706            or pcarr = 'UHD' or pcarr = 'UHH' or pcarr = 'UHP'
117700220706             or pcarr = 'UHV' or pcarr = 'ULD' or pcarr = 'ULH'
117800240521              or pcarr = 'ULV' or pcarr = 'ULP'
117900240521               or pcarr = 'USM' or pcarr = 'USD'     // J002
118000240521                or pcarr = 'USV' or pcarr = 'USL';   // J002
118100220707              planCursor = 'text';
118200220706             planColor = '#0000FF';
118300220707             runOption5 = 'UHC';
118400220707            //loadUHC();
118500220706           endIf;
118600180111
118700210707           s1rb = *Blanks;
118800210707           if mcorgben > benamt;
118900210707             s1rb = 'Y';
119000210707           endif;
119100170607
119200210707           s1Group# = Group#;
119300170607
119400210707           rrn = rrn + 1;
119500210707           write CovSfl;
119600170607
119700210707         Enddo;
119800170607
119900170607
120000210707       end-proc;
120100170607
120200170607
120300171229      *-------------------------------------------------------------------------
120400171229      *
120500171229      * Load the History Section
120600171229      *
120700171229      *-------------------------------------------------------------------------
120800210707       dcl-proc LoadHistory;
120900180717
121000190502         dcl-s wRecDt Char(10);
121100180720
121200190502         dcl-s wInvoice Char(13);
121300190502         dcl-s wFileName Char(100);
121400190502         dcl-s SavSqlCode like(sqlcod);
121500190502         dcl-s Min_Date Zoned(8);
121600190516         dcl-s HtmlName Char(33);
121700190516         dcl-s Run Char(1) inz('Y');
121800180720
121900180717
122000190502         HistKey = ' ' + zFill(9 : %Char(s1ssn) );
122100190502         wDate = %Dec( s1HistDate );
122200180720
122300210707         HistColor = '';
122400190502         Hist_Tip = '';
122500181126
122600210707         // Get the lowest Transaction Date from the History File.
122700210707         Exec Sql
122800210707           Select Min(trdate)
122900210707             Into :min_date
123000210707             From "F.HIST"
123100210707             Where hkey = :histkey;
123200200520         if sqlCode <> 0;
123300210707           Min_Date = 0;
123400200520         else;
123500210707           if min_Date < wDate and Min_Date > 0;
123600210707             Histcolor = '#0000FF';
123700210707             Hist_Tip = 'Oldest history record in file: '+
123800210707               %Char(%Date(Min_Date :*iso):*Usa);
123900210707           EndIf;
124000181126
124100200520         endif;
124200181126
124300180720
124400200520         // Get Invoice List
124500200520         if s1AltId > '';
124600210707           oPath = s1AltId;
124700210707           GetInvList( oPath ) ;
124800190502         endif;
124900180720
125000180720
125100180720
125200180720
125300190502         // Build SQL Statement
125400190502         SqlStmt =
125500200520         'Select ' +
125600200520         ' trDate, lDescr, ck#Not, Note2, CovtDt, hOper '   +
125700200520         ' ,cm$Flg ,Recvdt, trAmt, trCode, HSTRTIME ' +
125800200520         'From "F.HIST"  '                                  +
125900200520         'Join "F.CODESL1" on trCode = key3      '          +
126000200520         'Where hkey = ' + q + HistKey + q                  +
126100200520         '  and trDate >= ' + %Char( wDate ) +
126200210707           ' Order by hkey, trDate desc, rrn("F.HIST") desc ' ;
126300170605
126400210707         Exec Sql
126500210707           Declare c1 Cursor For sqlstmt;
126600210707         Exec Sql
126700210707           Prepare sqlstmt From :sqlstmt;
126800210707         Exec Sql
126900210707           Open c1;
127000170605
127100210707         Dou SqlCod <> *Zero;
127200210707           Exec Sql
127300210707             Fetch Next From c1
127400210707               Into :@histdata;
127500170605
127600200520           if SqlCod <> *Zero;
127700210707             Leave;
127800200520           endif;
127900170605
128000200520           s1TrDate = *Blanks;
128100210707           if sqtrDate > 0;
128200210707             s1TrDate = %Char(%Date(sqtrDate :*iso):*Usa);
128300190502           endif;
128400170605
128500210707           s1lDescr = sqlDescr;
128600210707           s1ck#not = sqNote1;
128700210707           s1note2 =  sqNote2;
128800210707           s1trAmt =  sqTrAmt;
128900180717
129000210707           if sq$Flg = 'C';
129100200520             s1ck#not = 'C-' + %Trim(sqNote1);
129200210707           endif;
129300180719
129400210707           if sqRecDt > 0;
129500200520             s1note2  = 'RD='+ %Char(%Date(sqRecDt :*iso):*Usa);
129600180717
129700210707             monitor;
129800210707               if sqRecDt > 0;
129900210707                 wRecDt = %Char(%Date(sqRecDt :*iso):*Usa);
130000210707               endif;
130100210707             on-error;
130200210707               wRecDt = %Char( sqRecDt );
130300210707             endmon;
130400180717
130500210707             s1note2  = 'RD='+ %Trim( wRecDt );
130600210707           endif;
130700180717
130800180717
130900200520           s1CovDate = *Blanks;
131000170605
131100200520           monitor;
131200210707             if sqCovtDt > 0;
131300210707               s1CovDate = %Char(%Date(sqCovtDt :*iso):*Usa);
131400210707             endif;
131500200520           on-error;
131600200520             s1CovDate = '';
131700210707           endmon;
131800180529
131900180529
132000190502           s1Oper = sqOper;
132100180720
132200210707           s1OprEml = '';
132300200520           ShowEmail2 = *off;
132400200520           chain s1Oper EmailAddr;
132500200520           if %Found( EmailAddr );
132600210707             s1OprEml = EAEMAIL;
132700210707             ShowEmail2 = *on;
132800200520           endif;
132900180720
133000200520           s1fmtDate = 0;
133100200520           if sqtrDate > 0;
133200210707             s1fmtDate = sqTrDate;
133300210707           endif;
133400180720
133500180720
133600190502           // Setup Diary Display
133700190502           s1trCode = sqTrCode;
133800180720
133900220707           NoteCursor = *Blanks;
134000200520           NoteColor  = '';
134100180720
134200200520           if s1trCode = 'M81';
134300220707             NoteCursor = 'Pointer';
134400210707             NoteColor = '#0000FF';
134500190502           EndIf;
134600240312
134700240312        // J001
134800240312           if s1trCode = 'OLE';
134900240312             NoteCursor = 'Pointer';
135000240312             NoteColor = '#0000FF';
135100240312           EndIf;
135200180720
135300220707           // If this is an invoice -
135400210707           //   check to see if we have that invoice
135500220707           showEmail = *off;
135600210707           showPDF = *off;
135700210707           s1FileName = '';
135800180720
135900210707           if s1trCode = 'BMB';
136000190502             SavSqlCode = sqlcod;
136100180720
136200210707             wInvoice = '%INV#' + %Subst( sqNote1 : 6 : 7 ) + '%';
136300210707             wfileName = '';
136400180720
136500210707             Exec Sql
136600210707               Select Substring(Rcd, 1, 100)
136700210707                 Into :wfilename
136800210707                 From qtemp/Flat500p
136900210707                 Where Rcd Like :winvoice;
137000180720
137100210707             if sqlCod = 0;
137200210707               showEmail = *on;
137300210707               showPDF = *on;
137400210707               s1FileName = wFileName;
137500200520             EndIf;
137600180720
137700200520             // Reset SqlCode
137800200520             sqlcod = SavSqlCode;
137900210707           Endif;
138000180720
138100190515
138200190516
138300200520           // Get New Hire Emails
138400200520           if Run = 'Y';
138500190516
138600210707br01         oNHPath =  %Editc( mbTrst : 'X' ) +
138700210707             %Editc( mbSub# : 'X' ) +
138800210707             %Editc( mbAcct : 'X' ) + '/' +
138900210707             %Editc( s1ssn : 'X' ) + 'Z0*';
139000210707             ListNH_Email( oNHPath );
139100190516
139200210707             run = 'N';
139300210707           endif;
139400190515
139500210707           showEmail3 = *off;
139600210707br01       if s1trCode = 'Z00' or
139700210707           s1trCode = 'Z01' or
139800210707           s1trCode = 'Z02' or
139900210707           s1trCode = 'Z03' or
140000210707           s1trCode = 'Z04' or
140100210707           s1trCode = 'Z05' or
140200210707           s1trCode = 'Z06' ;
140300190522
140400190522
140500190516             SavSqlCode = sqlcod;
140600190516             wfileName = '';
140700190516             HtmlName = %editc( s1ssn : 'X' ) + s1trCode +
140800200520             '_' + %char(sqtrDate) +
140900200520             '_' + %Editc(%Dec(sqTime) : 'X' ) + '.htm';
141000190516
141100190516
141200190516
141300210707             Exec Sql
141400210707               Select Substring(ifsclnlst, 1, 40)
141500210707                 Into :wfilename
141600210707                 From qtemp.ifsclnlst
141700210707                 Where ifsclnlst = :htmlname;
141800190516
141900210707             if sqlCod = 0;
142000210707               showEmail3 = *on;
142100210707               s1FileName = wFileName;
142200210707             EndIf;
142300190516
142400210707             // Reset SqlCode
142500210707             sqlcod = SavSqlCode;
142600190515
142700190515
142800210707           EndIf;
142900190515
143000180720
143100170605
143200210707           rrn2 = rrn2 + 1;
143300210707           Write HistSfl;
143400170605
143500210707           if rrn2 >= 9999;
143600210707             leave;
143700210707           endif;
143800171121
143900170605
144000200520         Enddo;
144100210707         Exec Sql
144200210707           Close c1;
144300210707       end-proc;
144400170605
144500180720
144600180720
144700210707       //-----------------------------------------------------------------
144800210707       dcl-proc ReadChanged;
144900180720
145000180720
145100190502         dcl-f DiaryDt1 keyed
145200200520         ExtDesc('F.DIARYDT1') ExtFile(*extdesc);
145300180720
145400190502         dcl-ds DiaryData LikeRec( RDIARYDT );
145500180720
145600180720
145700190502         dcl-s hKey Char(10);
145800190502         dcl-s @Subj Char(50);
145900190502         dcl-s @Addt Zoned(8);
146000190502         dcl-s @adti Zoned(6);
146100190502         dcl-s @adus Char(10);
146200190502         dcl-s wCount Zoned(5);
146300191203
146400191203         dcl-s wDate Date;
146500191203         dcl-s wDate8 Zoned(8);
146600191203
146700210707         dcl-s wEmlSDt Zoned(8);
146800210707         dcl-s EmailSDt Char(10);
146900210707         dcl-s wEmlEDt Zoned(8);
147000210707         dcl-s EmailEDt Char(10);
147100180720
147200210707         dcl-c  crlf  x'0d25';
147300180720
147400180720
147500210707         Dou *in95 = *ON;
147600210707           READC HistSFL;
147700210707           *in95 = %EOF;
147800180720
147900210707           If *in95 = *OFF;
148000180720
148100210707             // Check Content Menu Options
148200210707             if runOption > *blanks;
148300180720
148400180720
148500200520               if runOption = 'OpenPDF';
148600180720
148700230901                 oFolder = '\\invoicesvcACA.amwins.local\'+
148800210707                 'Compleodata\COBRA_INVOICES\LIVE\' +
148900210707                   %Trim( s1AltId ) + '\' +
149000210707                   %Trim(s1FileName);
149100180720
149200200520                 OpenFolder( oFolder );
149300180720
149400180720
149500210707               EndIf;
149600180720
149700180720
149800200520               if runOption = 'EmailInv';
149900180720
150000230901                 oInvPath = '\\invoicesvcACA.amwins.local\'+
150100210707                 'Compleodata\COBRA_INVOICES\LIVE\' +
150200210707                 %Trim( s1AltId ) + '\' +
150300210707                   %Trim(s1FileName);
150400180720
150500210707                 EmailInvoice( oInvPath : s1ck#not );
150600180720
150700180720
150800210707               EndIf;
150900180720
151000190516
151100190516
151200210707br01           if runOption = 'EmailNH';
151300210707                 if s1trcode = 'Z00' or
151400210707                   s1trcode = 'Z01' or
151500210707                 s1trcode = 'Z02' or
151600210707                   s1trcode = 'Z03';
151700190516
151800191104
151900200520                   Select;
152000200520                   When s1trcode = 'Z00';
152100210707                     Subject = 'New Hire Email';
152200200520                   When s1trcode = 'Z01';
152300210707                     Subject = 'New Hire Begin Email';
152400200520                   When s1trcode = 'Z02';
152500210707                     Subject = 'New Hire Middle Email';
152600200520                   When s1trcode = 'Z03';
152700210707                     Subject = 'New Hire Ending Email';
152800191203                   endsl;
152900191104
153000190516                   toAddr = myEmail;
153100190516                   Msg = '*ATT';
153200190516
153300190516                   Attach1 = '/www/gbsapps/htdocs/gbsapps/OE/OLE_SAVE/' +
153400200520                   %Subst(s1ActNbr : 1 : 3 ) +
153500210707                     %Subst(s1ActNbr : 5 : 3 ) +
153600210707                     %Subst(s1ActNbr : 9 : 4 ) + '/' + s1FileName;
153700190516
153800210707                   // br_todo search / add the account number to the database
153900210707                   // Chesapeake 5900100011 has a custom letter
154000191122
154100191104br02               Att_Type = 'NH_GUIDE';
154200200520                   Attach2 = '';
154300200520                   chain Att_Type InqLtrAtt;
154400200520                   if %Found( InqLtrAtt );
154500191104
154600210707                     //  Attach2 = '/www/gbsapps/htdocs/gbsapps/OE/LETTERS' +
154700191104                 //  '/New Hire Online Benefits Enrollment Guide 10-04-19.pdf' ;
154800191104
154900210707                     Attach2 = ltFileName;
155000191104                   endif;
155100190516
155200210707                   CmdString = 'MailTool toAddr(' + %trim(toAddr) + ') ' +
155300210707                   ' Subject(' + q + %Trim( Subject)  + q + ') ' +
155400210707                   ' Message(' + q + %Trim( Msg ) + q + ')' +
155500210707                   ' Attach( ' + q + %Trim( Attach1 ) + q + ' ' +
155600210707                   q + %Trim( Attach2 ) + q + ') ' +
155700210707                   ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
155800190516
155900190516
156000200520                   #Command(CmdString:%len(%Trim(CmdString)));
156100190516
156200210707                 EndIf;
156300190516
156400190516
156500190516
156600190516
156700210707                 if s1trcode = 'Z04' or
156800210707                   s1trcode = 'Z05' or
156900210707                   s1trcode = 'Z06';
157000190522
157100191203
157200191203                   // If the trcode is Z06, subtract a day from the history
157300191203                   // date for this search to work.
157400200520                   wDate8 = s1FmtDate;
157500200520                   if s1trcode = 'Z06';
157600210707                     wDate = %Date(s1FmtDate:*iso) - %Days(1);
157700210707                     wDate8 = %Dec( wDate ) ;
157800191203                   EndIf;
157900191203
158000191203
158100210707                   exec sql
158200210707                     Select pgmfdt, pgmtdt
158300210707                       into :wEmlSdt, :wEmlEdt
158400210707                       from WebPayDtr
158500210707                       where pgTrst = :mbTrst and
158600210707                             pgSub# = :mbSub# and
158700210707                             pgAcct = :mbAcct and
158800210707                             pgCode = 'OPEN' and
158900210707                             :wDate8 between pgmfdt and pgmtdt;
159000191203
159100220209        // M001
159200220209                   if wemlsdt <> 0;
159300220209                   EmailSDT = %Char(%Date(wEmlSdt:*iso):*Usa);
159400220209                   endif;
159500220209        // M001
159600191203
159700191203
159800200520                   Select;
159900200520                   When s1trcode = 'Z04';
160000210707                     Subject = 'Open Enrollment Begins ' + EmailSDt;
160100200520                   When s1trcode = 'Z05';
160200210707                     Subject = 'Open Enrollment Ends ' + EmailEDt;
160300200520                   When s1trcode = 'Z06';
160400210707                     Subject = 'Open Enrollment has ended';
160500190522                   EndSl;
160600190522
160700190522
160800190516                   toAddr = myEmail;
160900190516                   Msg = '*ATT';
161000190516
161100210707                   Attach1 = '/www/gbsapps/htdocs/gbsapps/OE/OLE_SAVE/' +
161200210707                   %Subst(s1ActNbr : 1 : 3 ) +
161300210707                   %Subst(s1ActNbr : 5 : 3 ) +
161400210707                   %Subst(s1ActNbr : 9 : 4 ) + '/' + s1FileName;
161500190516
161600190516
161700191104br02               Att_Type = 'OE_GUIDE';
161800200520                   Attach2 = '';
161900200520                   chain Att_Type InqLtrAtt;
162000200520                   if %Found( InqLtrAtt );
162100191104
162200210707                     //  Attach2 = '/www/gbsapps/htdocs/gbsapps/OE/LETTERS' +
162300191104                 //  '/New Hire Online Benefits Enrollment Guide 10-04-19.pdf' ;
162400191104
162500210707                     Attach2 = ltFileName;
162600191104                   endif;
162700191104
162800190516
162900210707                   CmdString = 'MailTool toAddr(' + %trim(toAddr) + ') ' +
163000210707                     ' Subject(' + q + %Trim( Subject)  + q + ') ' +
163100210707                     ' Message(' + q + %Trim( Msg ) + q + ')' +
163200210707                     ' Attach( ' + q + %Trim( Attach1 ) + q + ' ' +
163300210707                     q + %Trim( Attach2 ) + q + ') ' +
163400210707                     ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
163500190516
163600190516
163700210707                   #Command(CmdString:%len(%Trim(CmdString)));
163800190516
163900200520                 EndIf;
164000190516
164100190516
164200190516
164300190516
164400200520               EndIf;
164500190516
164600180720
164700200520               if runOption = 'EmailOper';
164800180720
164900200520                 oEmailAddr = s1OprEml;
165000200520                 EmailUser( oEmailAddr );
165100180720
165200210707               EndIf;
165300180720
165400240312         // J001
165500240312               if runOption = 'ViewForm';
165600240312               wwssid = %trim(s1ck#not);
165700240312
165800240312               prtfrm = #gbsfrm(wwssid:'':'');
165900240312               if %trim(FFPDF) = *blanks;
166000240312               Batchlink = %trim(wwbatch) + %trim(wwsystem) + '_' +
166100240312               %trim(aacolor) + '_' + %trim(wwssid) + '.PDF';
166200240312               prtfrm = #gbsfrm(wwssid:wwsys:BatchLink);
166300240313               select;
166400240313               when %trim(wwsys) = '1';
166500240313               BuildForm( wwSSID : Where );
166600240313               when %trim(wwsys) = '2';
166700240313               BuildForm( wwSSID : Where );
166800240313               when %trim(wwsys) = '3';
166900240313               BuildFormPay( wwSSID : Where );
167000240313               endsl;
167100240312               prtfrm = #gbsfrm(wwssid:'':'');
167200240312               endif;
167300240312
167400240312               if  %trim(E1LIBL) = 'QS36F';
167500240312               pdflink = 'https://acaprodweb02/ACAAPI/api/PDF/' +
167600240312               'PDFCreateBatchPrintPDF/' +
167700240312               %trim(FFSSID) + '/ ' +
167800240312               %trim(FFSYS) + '/ ' +
167900240312               %trim(FFPDF);
168000240312               else;
168100240312               pdflink = 'https://p10acadev/ACA_WebAPI/api/PDF/' +
168200240312               'PDFCreateBatchPrintPDF/' +
168300240312               %trim(FFSSID) + '/ ' +
168400240312               %trim(FFSYS) + '/ ' +
168500240312               %trim(FFPDF);
168600240312               endif;
168700240312     C                   call      'SSIDINQC'
168800240312     C                   parm                    pdfLink
168900240312               EndIf;
169000180720
169100210707               if runOption = 'ViewDiary';
169200190516                 s3Head = '';
169300190516                 s3Body = '';
169400190502                 s3Crtby = '';
169500180720
169600180720
169700190502                 hkey = ' ' + zFill(9 : %Char(s1ssn) );
169800180720
169900180720
170000190502                 // Get the Header Info.
170100210707                 Exec Sql
170200210707                   Select nhsubj, nhaddt, nhadti, nhadus
170300210707                     Into :@subj, :@addt, :@adti, :@adus
170400210707                     From "F.DIARYHD0"
170500210707                     Where nhkey = :hkey And
170600210707                           Substring(nhsubj, 1, 30) = :s1ck#not And
170700210707                           nhaddt = :s1fmtdate;
170800180720
170900180720
171000190516                 s3head = @subj;
171100190516                 s3Crtby = 'Record Created by ' + %Trim( @Adus ) +
171200200520                 ' on ' + %Char(%Date(@Addt:*iso ) : *usa) +
171300200520                 ' at ' + %Char(%Time(@adti) : *usa) ;
171400180720
171500180720
171600180720
171700210707                 //-----------------------------------------
171800210707                 //
171900210707                 // Read through the Detail Records.
172000210707                 //
172100210707                 //-----------------------------------------
172200210707                 wCount = 1;
172300181029
172400210707                 setll ( hkey : @Addt : @Adti ) DiaryDt1;
172500210707                 dou %Eof( DiaryDt1 ) ;
172600200520                   reade  ( hkey : @Addt : @Adti ) DiaryDt1 DiaryData;
172700180720
172800210707                   if %eof( DiaryDt1 );
172900210707                     leave;
173000210707                   EndIf;
173100180720
173200210707                   //   s3body = %trim(s3body) + crlf +
173300210707                   //      %Trim( DiaryData.ndText ) ;
173400180720
173500210707                   %Subst( s3Body : wCount : 70 ) =
173600210707                   DiaryData.ndText ;
173700210707                   wCount = wCount + 70;
173800210707                 EndDo;
173900180720
174000210707                 exfmt  DiaryNote;
174100180720
174200180720
174300180720
174400210707               Endif;
174500180720
174600210707             EndIf;
174700180720
174800220706             if runOption5 = s1Plan;
174900220706             endif;
175000220706
175100180720
175200180720
175300180720
175400180720
175500210707             runOption = *Blanks;
175600210707             update HistSFL;
175700180720
175800210707           endif;
175900180720
176000210707         //  Reload = 'Y';
176100180720
176200180720
176300210707         enddo;
176400190516       end-proc;
176500180720
176600180720
176700220624       //-----------------------------------------------------------------
176800220706       dcl-proc ReadChanged2;
176900220707
177000220707          if btnExit = '0' and btnGTFO = '0';
177100220721           readc CovSfl;
177200220721           if s2PlanName = '1';
177300220721            if runOption5 = 'UHC';
177400230313             s1Enroll = %char(s1EnrollD:*usa/);
177500230313              s1Cancel = %char(s1Canceld:*usa/);
177600230313              uhcMENU(mbtrst:mbsub#:mbacct:s1ssn:s1plan:s1enroll:s1cancel:type);
177700220721             s2PlanName = '0';
177800220721            endif;
177900220721           endif;
178000220721          endif;
178100240426
178200240426        if btnInf = '1';
178300240426         xTrst = mbtrst;
178400240426          xSub = mbsub#;
178500240426           xPlan = s1plan;
178600240426           xAcct = mbacct;
178700240426          getAux( xTrst : xSub : xPlan : xAcct  ) ;
178800240426         btnInf = '0';
178900240426        endif;
179000220624
179100220706       end-proc;
179200180720
179300220706       //-----------------------------------------------------------------
179400220706       dcl-proc loadUHC;
179500220706
179600220706           runOption5 = ' ';
179700220706
179800220706           if pcarr = 'AUM' or pcarr = 'UHC' or pcarr = 'UHO'
179900220706            or pcarr = 'UHD' or pcarr = 'UHH' or pcarr = 'UHP'
180000220706             or pcarr = 'UHV' or pcarr = 'ULD' or pcarr = 'ULH'
180100220721              or pcarr = 'ULV' or pcarr = 'ULP';
180200220707             runOption5 = 'UHC';
180300220706           endIf;
180400170605
180500220706       end-proc;
180600180612      *-------------------------------------------------------------------------
180700180612      *
180800180613      * Setup the Library List
180900180612      *
181000180612      *-------------------------------------------------------------------------
181100210707       dcl-proc SetLibl;
181200180612
181300191104         //----------------------------------------------------
181400191104         //
181500191104         //   Close the WebPayroll File if Already Open
181600200520         //
181700200520         //----------------------------------------------------
181800200520         if %Open( WebPayrol1 ) ;
181900210707           close  WebPayrol1;
182000191104         EndIf;
182100180613
182200191104         //----------------------------------------------------
182300191104         //
182400191104         //   Retrieve Current Library List
182500191104         //
182600191104         //----------------------------------------------------
182700180612
182800191104         RtvJobInf( Rcvvar : RcvVarLen : 'JOBI0700' : '*' : '' ) ;
182900191104         libsToSkip = NbrSysLibs +
183000200520         NbrPrdLibs +
183100200520         NbrCurLibs;
183200180612
183300200520         Pos = ( LibsToSkip * 11 ) + 81;
183400180612
183500191104         UsrLibs = %Subst( RcvVar: Pos : NbrUsrLibs * 11 ) ;
183600180612
183700180612
183800180612
183900191104         //----------------------------------------------------
184000191104         //
184100191104         //   Check for RPGSPDASH in the current Library list
184200191104         //
184300191104         //----------------------------------------------------
184400191104         Dash = %Lookup( 'RPGSPDASH' : theLibs ) ;
184500180612
184600191104         //----------------------------------------------------
184700191104         //
184800191104         //   Check for RPGSPPAYR in the current Library list
184900191104         //
185000191104         //----------------------------------------------------
185100210707         Payr = %Lookup( 'RPGSPPAYR' : theLibs ) ;
185200180612
185300210707         //----------------------------------------------------
185400210707         //
185500210707         //   Check the web environment
185600210707         //
185700210707         //----------------------------------------------------
185800210707         chain ( mbTrst : mbSub# : mbAcct ) AccOspl3;
185900210707         if %Found( AccOspL3 );
186000180613
186100200520           // Payroll System
186200200520           //   --  Replace Dashboard with Payroll
186300200520           if (aoCode = 6 or aoCode = 7) and Dash > 0;
186400210707             CmdString = 'RmvLible RPGSPDASH' ;
186500210707             #Command(CmdString : %len(%Trim(CmdString))) ;
186600180613
186700200520             CmdString = 'AddLible RPGSPPAYR' ;
186800200520             #Command(CmdString : %len(%Trim(CmdString))) ;
186900210707           EndIf;
187000180613
187100180613
187200210707           // Dashboard System
187300210707           //   --  Replace Payroll  with Dashboard
187400210707           if (aoCode = 8 or aoCode = 9) and Payr > 0;
187500210707             CmdString = 'RmvLible RPGSPPAYR' ;
187600210707             #Command(CmdString : %len(%Trim(CmdString))) ;
187700180613
187800210707             CmdString = 'AddLible RPGSPDASH' ;
187900210707             #Command(CmdString : %len(%Trim(CmdString))) ;
188000210707           EndIf;
188100240313
188200210707         EndIf;
188300240313
188400240313         //----------------------------------------------------
188500240313         //
188600240313         //   Retrieve New Library List
188700240313         //
188800240313         //----------------------------------------------------
188900240313         RtvJobInf( Rcvvar : RcvVarLen : 'JOBI0700' : '*' : '' ) ;
189000240313         libsToSkip = NbrSysLibs +
189100240313         NbrPrdLibs +
189200240313         NbrCurLibs;
189300240313
189400240313         Pos = ( LibsToSkip * 11 ) + 81;
189500240313
189600240313         UsrLibs = %Subst( RcvVar: Pos : NbrUsrLibs * 11 ) ;
189700240313
189800240313         // Defualt Beta=1, Dash=2,Payr=3
189900240313             wwsys = '1';
190000240313             wwsystem = 'BETA';
190100240313
190200240313         //----------------------------------------------------
190300240313         //
190400240313         //   Check for RPGSPDASH in the current Library list
190500240313         //
190600240313         //----------------------------------------------------
190700240313         Dash = %Lookup( 'RPGSPDASH' : theLibs ) ;
190800240313         if Dash > 0;
190900240313             wwsys = '2';
191000240313             wwsystem = 'DASHBOARD';
191100240313         endif;
191200240313
191300240313         //----------------------------------------------------
191400240313         //
191500240313         //   Check for RPGSPPAYR in the current Library list
191600240313         //
191700240313         //----------------------------------------------------
191800240313         Payr = %Lookup( 'RPGSPPAYR' : theLibs ) ;
191900240313         if Payr > 0;
192000240313             wwsys = '3';
192100240313             wwsystem = 'NON-PAYROLL';
192200240313         endif;
192300240313
192400210707         //----------------------------------------------------
192500210707         //
192600210707         //   Re-open the file.
192700210707         //
192800200520         //----------------------------------------------------
192900200520         open WebPayrol1;
193000180612
193100210707       end-proc;
193200190516
193300190516
193400210707       // ----------------------------------------------------------------
193500210707       dcl-Proc Load_CBR_Sub;
193600210505
193700210505         SqlStmt2 =
193800210707         'Select * from SUBMEM Where smssn = ' +
193900210707           %Char( wssn ) + ' order by smfrdt desc ' ;
194000210505
194100210707         Exec Sql
194200210707           Declare C2 Cursor For Sqlstmt2;
194300210707         Exec Sql
194400210707           Prepare Sqlstmt2 From :Sqlstmt2;
194500210707         Exec Sql
194600210707           Open C2;
194700210505
194800210707         dou SqlCod <> *Zero;
194900210707           Exec Sql
195000210707             Fetch Next From C2
195100210707               Into :Sq_Data;
195200210505
195300210707           if SqlCod <> *zero;
195400210707             leave;
195500210707           endif;
195600210505
195700210707           s1SubdtRg = %Char(%Date(smFrDt : *iso):*Usa) + ' - ' +
195800210707           %Char(%Date(smToDt : *iso):*Usa);
195900210505
196000210707           rrn3 = rrn3 + 1;
196100210707           write SUBSfl;
196200210505
196300210707         enddo;
196400210707         Exec Sql
196500210707           Close C2;
196600210505
196700210505
196800210505
196900210505
197000210707       end-proc;
197100210505
197200190516
197300200520       // ----------------------------------------------------------------
197400200520       dcl-Proc init;
197500190516
197600210707         myEmail = '';
197700190516
197800210707         chain wqusrn EmailAddr;
197900210707         if %Found( EmailAddr ) ;
198000210707           myEmail = eaEmail;
198100210707         EndIf;
198200190516
198300210707       end-proc;
198400190516
198500190516      *----------------------------------------------------------------
198600171229      *
198700170605      * zFill Function
198800171229      *
198900170605      *----------------------------------------------------------------
199000171229
199100210707       Dcl-Proc zFill export;
199200171229
199300200520         Dcl-pi *n Char(100);
199400210707           len Zoned(3) value;
199500200520           Text Char(100) value;
199600191104         End-Pi;
199700171229
199800191104         dcl-s ReturnText Char(100);
199900191104         dcl-s Diff Zoned(3);
200000200520         dcl-s i Zoned(3);
200100171229
200200210707         Diff = len - %Len( %Trim(Text));
200300171229
200400210707         for i = 1 to Diff;
200500210707           ReturnText = %Trim(ReturnText) + '0';
200600210707         EndFor;
200700171229
200800210707         ReturnText = %Trim( ReturnText ) + %Trim( Text );
200900171229
201000210707         Return ReturnText;
201100171229
201200190516       end-Proc;
201300171229
201400220504       // ----------------------------------------------------------------
201500220504       dcl-proc Get_Env;
201600220505
201700220505           OutEnvr = GetEnvironment(' ');
201800220505
201900220505           e1envir = outenvr.e1envir;
202000220505           e1libl  = outenvr.e1libl;
202100220505           Library2 = outenvr.e1lib2;
202200220505           e1acnm  = outenvr.e1acnm;
202300220505           envColor = outenvr.envcolor;
202400220506
202500220506           in company;
202600220506           s1company = company;
202700220505
202800220504       End-Proc;
202900220504
203000220504
