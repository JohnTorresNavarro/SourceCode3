000100171229
000200180604       Ctl-opt option(*noDebugIo)  bnddir('GBSBIND' )
000300190410         DftActGrp(*no)
000400190410         ActGrp(*New);
000500171229
000600171229      *-------------------------------------------------------------------------
000700171229      *
000800171229      *  Description:
000900171229      *  Programmer.:  Brian Rees
001000171229      *  Date.......:  05/25/2017
001100171229      *
001200171229      *-------------------------------------------------------------------------
001300180227
001400180227      *-------------------------------------------------------------------------
001500180227      *
001600181126      *  Change Log:
001700180227      *
001800181126      *-------------------------------------------------------------------------
001900180227      *
002000181126      *  2/27/2018   B.Rees  Added Senior Dental Write Off
002100181126      *
002200181126      *  7/06/2018   B.Rees  Added Paid Through Date
002300181126      *
002400181126      * 11/26/2018   B.Rees  Added Color and a tool tip to the history date.
002500181126      *
002600190207      * 02/07/2019   B.Rees  Added menu option for the Account Master
002700190207      *                      Report Generator
002800181126      *
002900190404      * 04/04/2019   B.Rees  Removed Account Master Report Generator
003000190404      *  Ticket #:  CR000113
003100190404      *
003200190410      * 04/10/2019   B.Rees  Added Auto Debit Flag
003300190502      *
003400190502      * 05/02/2019   B.Rees  Payroll Import Vendor
003500190507      * 05/07/2019   B.Rees  Added Invoice Admin Fee
003600190510      * 05/09/2019   B.Rees  Added Phyiscal Address
003700190515      * 05/14/2019   B.Rees  Added Check by phone
003800190517      * 05/17/2019   B.Rees  Added No Not Publish Invoice Note to the
003900190517      *                      History
004000190920      * 09/20/2019   b.Rees  Added Broker Access
004100191028      * 10/28/2019   B.Rees  Changed AA Name to Full Name
004200191119      * 11/19/2019   B.Rees  Added Agency Access
004300191121      * 11/21/2019   B.Rees  Added OLE Payroll Deductions Flag.
004400191206      * 12/06/2019   b.Rees  Added option to generate folders for the
004500191206      *                      scanning tech. New Function Authority:
004600191206      *                      *ScanTech
004700191219      * 12/19/2019   jt      Added option to go to the "Do Not Send" screen
004800191219      *                      by adding hyperlink on notes.
004900200206      * 02/07/2020   B.Rees  Added Link to view related Accounts.
005000200219      * 02/19/2020   B.Rees  Check for Broker Select Accounts
005100200416      * 04/16/2020   B.Rees  Changed oeRepos to be user open
005200200527      * 05/27/2020   B.Rees  Added Trust 80 to Check by Phone.
005300201008      * 10/08/2020   jt      Added Principal and Hartford to the "Do Not Send"
005400201008      *                      hyperlink on notes.
005500210218      * 02/18/2021   jt      Corrected Principal and Hartford links to the
005600210218      *                      "Do not Send" screen.
005700210420      * 04/20/2021   jt      Added monotor when adding RPGSPDASH library
005800210827      * 8/27/2021    B.Rees  Added Broker Rep.
005900210922      * 9/22/2021    B.Rees  Modified Check by phone. Included Range 80 - 99
006000220117      * 1/17/2022    B.Rees  Addded Notes Tab under Account Data.
006100220124      * 1/20/2022    B.Rees  Monitored a Date error in AccOsp
006200220124      * 1/24/2022    B.Rees  Increased Email Size
006300220217      * 2/17/2022    B.Rees  Added Account Search Window
006400220217      *  Ticket:  CR000509
006500220301      * 02/28/2022   j.allen Added new tab for Temp Id-Info
006600220228      *  Ticket:  CR000426
006700181126      *-------------------------------------------------------------------------
006800220504      *
006900240426      * 05/04/2022 J.Allen Added environment info to screens.
007000240426      * 05/13/2022 J.Allen Addded Group Elig Tab under Account Data.
007001240429      * 04/26/2024 jt      Changed history records load from 2 years to 6 months
007100171229
007200171229      *-------------------------------------------------------------------------
007300171229      *
007400171229      * Declare Files
007500171229      *
007600171229      *-------------------------------------------------------------------------
007700171229       Dcl-f Inq008d WorkStn
007800190410         Handler('PROFOUNDUI(HANDLER)')
007900190410         SFILE(HISTSFL:rrn2)   ;
008000171229
008100171229
008200210121       Dcl-f CodesL1 keyed ExtDesc('F.CODESL1') ExtFile(*extdesc);
008300210121       Dcl-f AccMst  keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
008400210121       Dcl-f Member  keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
008500210121       Dcl-f SMan    keyed ExtDesc('F.SMAN') ExtFile(*extdesc);
008600210121       dcl-f sMan2l1 keyed ExtDesc('F.SMAN2L1') ExtFile(*extdesc);
008700210121       dcl-f TrsMst  keyed ExtDesc('F.TRSMST') ExtFile(*extdesc);
008800180227
008900180227
009000171229       Dcl-f AccOspl2 keyed;
009100171229       dcl-f AoeCod   keyed;
009200180404       dcl-f aaCode   keyed;
009300171229       dcl-f Ac2Mstl2 keyed;
009400180227       dcl-f AccSwb   keyed;
009500180309       dcl-f EmailAddr keyed;
009600180426       dcl-f odcntcp   keyed;
009700180613       dcl-f AccOspl3  keyed Rename(Accospr : Rcd1 );
009800180309
009900180524       Dcl-f MCOVC15 keyed ExtDesc('F.MCOVC15') ExtFile(*extdesc);
010000180524       Dcl-f PLNMST  keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
010100190410       dcl-f AccMsp  keyed;
010200190410       dcl-f Secach  keyed;
010300190507       dcl-f code20p keyed;
010400190517       dcl-f AccAchl1 keyed;
010500190517       dcl-f InvDnp keyed;
010600190517
010700200416       dcl-f oeReposl2 keyed usropn;
010800191121       dcl-f WebPayChp keyed;
010900200206       Dcl-f Acrelatp keyed ExtDesc('F.ACRELATP') ExtFile(*extdesc);
011000200219       Dcl-f sManRlt  keyed ExtDesc('F.SMANRLT')  ExtFile(*extdesc);
011100200219       Dcl-f Spragxr2 keyed ExtDesc('F.SPRAGXR2') ExtFile(*extdesc);
011200200219
011300210827       dcl-f smanrmgp keyed;
011400210827       dcl-f rmgrmst3 keyed;
011500220117
011600220117       dcl-f amNotep keyed;
011700220513       dcl-f AccAdp  keyed;
011800200219
011900190920
012000171229      *-------------------------------------------------------------------------
012100171229      *
012200171229      * Global Variables
012300171229      *
012400171229      *-------------------------------------------------------------------------
012500171229
012600180511       dcl-ds pgmd
012700190410         ExtName('IOPGMD') PSDS;
012800190410         @pgmq *proc;
012900180511       end-ds;
013000180511
013100200415
013200171229       dcl-s rrn2 Zoned(5);
013300171229
013400171229       dcl-s CharZip  Char(9);
013500171229       dcl-s PhoneC   Char(7);
013600171229       dcl-s CompDate Zoned(8);
013700220506       dcl-s Company Char(50) dtaara;
013800171130
013900171229       dcl-s SqlStmt Char(1000) inz;
014000171229       dcl-s HistKey Char(10);
014100171229       dcl-s wActNbr like( s1ActNbr );
014200220504
014300220504       Dcl-s Library Char(10);
014400220504       dcl-s Library2 Char(10);
014500170605
014600171229       dcl-s wTrst    Zoned(3);
014700171229       dcl-s wSub#    Zoned(3);
014800171229       dcl-s wAcct    Zoned(4);
014900171229       dcl-s AcaCount Zoned(5);
015000171108
015100171229       dcl-s Bal       Zoned(9:2) dim(12);
015200171229       dcl-s CurrMonth Zoned(2);
015300171229       dcl-s PrevMonth Zoned(2);
015400171229       dcl-s wDate     Zoned(8);
015500171229       dcl-s wSSN      Zoned(9);
015600171229       dcl-s CharSSN   Char(9);
015700190920       dcl-s wIdent    Char(40);
015800191219       dcl-s carrier   Packed(2);
015900171106
016000180227       dcl-s SenDental Char(1);
016100180227
016200171229       dcl-c q  '''';
016300171229       dcl-c digits  '0123456789';
016400180613
016500180613       dcl-s dash Zoned(2);
016600180613       dcl-s Payr Zoned(2);
016700190507       dcl-s wType Char(10);
016800171229
016900171229
017000171229       dcl-ds @HistData;
017100190410         sqtrDate Zoned(8);
017200190410         sqlDescr Char(30);
017300190410         sqNote1  Char(30);
017400190410         sqNote2  Char(30);
017500190410         sqCovtDt Zoned(8);
017600190410         sqOper   Char(10);
017700190410         sqTrAmt  Zoned(9:2);
017800190410         sqTrCode Char(3);
017900190410         sqcm$Flg Char(1);
018000190410         sqRecvDt Zoned(8);
018100190410         sqt_Time Time;
018200171229       End-Ds;
018300190507
018400180227       dcl-ds waDta ExtName('ACCSWB') End-ds;
018500191121
018600191121       dcl-s wGrouper Char(10);
018700191121       dcl-s wCode    Char(20);
018800191121       dcl-s sv_AoCode Like( aoCode );
018900191206
019000191206       dcl-s isScanTech ind;
019100220121       dcl-s hasNotes ind;
019200220505
019300220505       dcl-ds OutEnvr  Qualified  ;
019400220505         e1Envir  Char(15);
019500220505         e1Libl   Char(10);
019600220505         e1Lib2   Char(10);
019700220505         envColor Char(10);
019800220505         e1Acnm   Char(40);
019900220505       End-Ds;
020000170605
020100161111      *--------------------------------------------
020200171229      *
020300171229      * Procedures
020400171229      *
020500161111      *--------------------------------------------
020600180222
020700180222       /include GBSPGM/QMODSRC,#GettokPR
020800180222       /include GBSPGM/QMODSRC,#zFillpr
020900180604       /include GBSPGM/QMODSRC,#CommandPr
021000191206       /include GBSPGM/QMODSRC,#ChkFncAth        // Check Function Authority
021100220505       /Include *LIBL/QMODSRC,#GetEnvrPr         // Get Environment
021200191206
021300220217       dcl-pr wn0011r ExtPgm('WN0011R');
021400220217         pAcct# Char(12);
021500220217         pAcctName Char(40);
021600220217       end-Pr;
021700220217       dcl-s pAcct# Char(12);  // Character Acct Nbr
021800220217       dcl-s pAcctName Char(40);
021900220217
022000180222
022100180604
022200180604
022300171229       Dcl-pr IssueTracking ExtPgm('INQ003R');
022400190410         oTrst Zoned(3);
022500190410         oSub# Zoned(3);
022600190410         oAcct Zoned(4);
022700190410         oMember Zoned(9);
022800171229       End-Pr;
022900171229
023000171229       dcl-s oTrst Zoned(3);
023100171229       dcl-s oSub# Zoned(3);
023200171229       dcl-s oAcct Zoned(4);
023300171229       dcl-s oMember Zoned(9);
023400171229
023500171027
023600171229       Dcl-pr CommCtrl ExtPgm('INQ009C');
023700190410         oTrst Zoned(3);
023800190410         oSub# Zoned(3);
023900190410         oAcct Zoned(4);
024000171229       End-Pr;
024100171110
024200171106
024300171229       Dcl-pr DiaryNotes ExtPgm('TR121CL');
024400190410         *N Char(11);
024500171229       End-Pr;
024600171229       dcl-s oDiary Char(11);
024700171229
024800171229
024900171229       dcl-pr MemberList ExtPgm('INQ011R');
025000190410         oTrst Zoned(3);
025100190410         oSub# Zoned(3);
025200190410         oAcct Zoned(4);
025300190410         oCobra Char(1);
025400171229       End-Pr;
025500171229       dcl-s oCobra Char(1);
025600171121
025700220228
025800220228       dcl-pr Tmp_IDcard ExtPgm('TID001R');
025900220228         oTSA Char(10);
026000220228         oMemberC Char(9);
026100220228         oUSER Char(10);
026200220228       End-Pr;
026300220228       dcl-s oTSA Char(10);
026400220228       dcl-s oUser Char(10);
026500220228       dcl-s CharMember Char(9);
026600220228       dcl-s CharTSA Char(10);
026700190515
026800190515
026900190515       dcl-pr INQ021C1 ExtPgm('INQ021C1');
027000190515         oTrst Zoned(3);
027100190515         oSub# Zoned(3);
027200190515         oAcct Zoned(4);
027300190515       End-Pr;
027400180122
027500190515
027600180122       dcl-pr OpenFolder ExtPgm('INQ008C');
027700191030         oFolder Char(500);
027800180122       End-Pr;
027900191030       dcl-s oFolder Char(500);
028000180124
028100180124
028200180124       dcl-pr GetINVList ExtPgm('INQ008C1');
028300190410         oPath Char(11);
028400180124       End-Pr;
028500180124       dcl-s oPath Char(11);
028600180118
028700180125
028800180125       dcl-pr EmailInvoice ExtPgm('INQ008C2');
028900190410         oInvPath Char(150);
029000190410         oInvNbr  Char( 30);
029100180125       End-Pr;
029200180125       dcl-s oInvPath Char(150);
029300180125       dcl-s oInvNbr  Char( 30);
029400180125
029500180227       dcl-pr SD_WriteOff ExtPgm('WRKSWBCL');
029600190410         *n Char(56);
029700180227       End-Pr;
029800180309
029900180309
030000180309       dcl-pr EmailUser ExtPgm('INQ008C3');
030100211209         oEmailAddr Char(60);
030200180309       End-Pr;
030300211209       dcl-s oEmailAddr Char(60);
030400180309
030500180327       Dcl-pr CostCntr ExtPgm('INQ017R');
030600190410         oTrst Zoned(3);
030700190410         oSub# Zoned(3);
030800190410         oAcct Zoned(4);
030900180327       End-Pr;
031000180327
031100180426       Dcl-pr onSiteList ExtPgm('INQ018R');
031200190410         oTrst Zoned(3);
031300190410         oSub# Zoned(3);
031400190410         oAcct Zoned(4);
031500180426       End-Pr;
031600180426
031700180706       dcl-pr GetPaidThru ExtPgm('GETPTHRUCL');
031800190410         oKey Char(10);
031900190410         oDate Char(8);
032000180706       End-Pr;
032100180706
032200180706       dcl-s oKey Char(10);
032300180706       dcl-s oDate Char(8);
032400180613
032500190207
032600190207       dcl-pr GBS0052C ExtPgm('GBS0052C') end-pr;
032700190207
032800191206       dcl-pr INQ024C ExtPgm('INQ024C');
032900191206         oKey Char(10);
033000191206       End-Pr;
033100191206
033200191219       Dcl-pr troff ExtPgm('TROFF');
033300191219         carrier Packed(2);
033400191219         dspMode char(1) const;
033500191219       End-Pr;
033600191219       dcl-s dspMode   char(1);
033700190207
033800200207
033900200207       Dcl-pr RelatedAct ExtPgm('INQ024R');
034000200207         oTrst Zoned(3);
034100200207         oSub# Zoned(3);
034200200207         oAcct Zoned(4);
034300200207         oCancel Char(1);
034400200207       End-Pr;
034500200207       dcl-s oCancel Char(1);
034600200207
034700180613       //----------------------------------------------------
034800180613       //
034900180613       //   Following is used for the Library List
035000180613       //
035100180613       //----------------------------------------------------
035200180613       dcl-pr RtvJobInf ExtPgm('QUSRJOBI');
035300190410         RcvVar Char(32766) options(*varsize);
035400190410         RcvVarLen int(10) Const;
035500190410         Format Char(8) Const;
035600190410         JobName Char(26) Const;
035700190410         IntJobId Char(16) Const;
035800180613       End-Pr;
035900180613
036000180613       dcl-s IntJobId Char(16) Inz( *Blank );
036100180613       dcl-s Format Char(8) inz( 'JOBI0700' );
036200180613       dcl-s LibsToSkip Int(10);
036300180613       dcl-s pos int(10);
036400180613       dcl-s QualJobName Char(26) inz( '*' );
036500180613       dcl-s RcvVarLen Int(10) inz( %Len( RcvVar ));
036600180613
036700180613       dcl-ds RcvVar len(32767) ;
036800190410         misc Char(64) Inz(*Blank);
036900190410         NbrSysLibs Int(10) Inz(0);
037000190410         NbrPrdLibs Int(10) Inz(0);
037100190410         NbrCurLibs Int(10) Inz(0);
037200190410         NbrUsrLibs Int(10) Inz(0);
037300180613       End-Ds;
037400180613
037500180613       dcl-ds UsrLibs Len(550);
037600190410         TheLibs Char(11) Dim(50);
037700180613       End-Ds;
037800180613
037900180613
038000180613
038100171229      *-------------------------------------------------------------------------
038200171229      *
038300180404      * *Entry Procedure
038400171229      *
038500171229      *-------------------------------------------------------------------------
038600180404       Dcl-pr Main ExtPgm;
038700190410         *N  Zoned(3);
038800190410         *N  Zoned(3);
038900190410         *N  Zoned(4);
039000180404       End-Pr;
039100180404
039200180404       dcl-pi Main;
039300190410         pTrst  Zoned(3);
039400190410         pSub#  Zoned(3);
039500190410         pAcct  Zoned(4);
039600180404       End-Pi;
039700180404
039800180404
039900180404
040000180404     Iaccmsr
040100180404     I              aacode                      aa_code
040200180404
040300180404
040400180404      *-------------------------------------------------------------------------
040500180404      *
040600180404      * Mainline Program
040700180404      *
040800180404      *-------------------------------------------------------------------------
040900171106
041000220505        init();
041100220505        Get_Env();
041200191206
041300171128       wTrst = pTrst;
041400171128       wSub# = pSub#;
041500171128       wAcct = pAcct;
041600171128
041700170531
041800220217       Exec Sql
041900220217         Set Option Commit = *Chg, Naming = *Sys;
042000240426       //s1HistDate = %Date - %Years(2);
042001240426       s1HistDate = %Date - %months(6);
042100171106
042200171106
042300170525       Dou btnExit = *on;
042400190410         errAccount = *off;
042500170605
042600220217         // Adding in a Search for Account Name.
042700220217         if  btnSearch = *on;
042800220217           wn0011r( pAcct# : pAcctName );
042900220217           if pAcct# > '';
043000220217             s1ActNbr = pAcct#;
043100220217             actChgd = *on;
043200220217           EndIf;
043300220217
043400220217         EndIf;
043500220217
043600220217
043700190410         // Check to see if the Account Number has changed.
043800190410         if ActChgd = *on;
043900190410           tabPanel = 0;
044000180222
044100190410           // For the people who press "Field+"
044200190410           s1ActNbr = %ScanRpl( '+' : '-' : s1ActNbr );
044300240426           //s1HistDate = %Date - %Years(2);
044301240426           s1HistDate = %Date - %months(6);
044400180502
044500180502
044600190410           split();
044700190410           wActNbr = s1ActNbr;
044800171130
044900190410           s1ActNbr = %ScanRpl( '-' : '' : s1ActNbr );
045000190410           s1ActNbr = %ScanRpl( ' ' : '' : s1ActNbr );
045100171130
045200180426
045300180426
045400190410           if %check( digits : %Trim( s1ActNbr )) = 0  and
045500190410             %Len(%Trim( s1ActNbr )) = 10;
045600190410             wTrst = %Dec( %Subst( s1ActNbr : 1 : 3) : 3 : 0 );
045700190410             wSub# = %Dec( %Subst( s1ActNbr : 4 : 3) : 3 : 0 );
045800190410             wAcct = %Dec( %Subst( s1ActNbr : 7 : 4) : 4 : 0 );
045900171130
046000190410             chain ( wTrst : wSub# : wAcct ) AccMst;
046100190410             if not %Found( AccMst );
046200190410               Clear Screen1;
046300190410               ErrAccount = *on;
046400190410               s1ActNBr = wActNbr;
046500190410             endif;
046600171130
046700190410           else;
046800171130
046900171130
047000171130
047100190410             errAccount = *on;
047200190410           endif;
047300171130
047400190410         endif;
047500171128
047600190410         if errAccount = *on;
047700190410           Clear_All();
047800190410           visMenu = *off;
047900171130
048000190410         Else;
048100180816
048200190410           SetLIBL();
048300190410           Load_AcctInfo();
048400190410           Clear_All();
048500190410           LoadHistory();
048600190410           visMenu = *on;
048700170605
048800171103
048900190410           // Build Menu
049000190410           MnuChoice = 'Diary,Issues,Commission Control';
049100190410           MnuChoice = %Trim(MnuChoice) + ', Member List' ;
049200190410           MnuChoice = %Trim(MnuChoice) + ', COBRA List' ;
049300190410           MnuChoice = %Trim(MnuChoice) + ', Invoices' ;
049400220228           MnuChoice = %Trim(MnuChoice) + ', Cost Centers' ;
049500220307           MnuChoice = %Trim(MnuChoice) + ', Temp ID' ;
049600171130
049700190410           MnuValue  = 'DIARY,ISSUES,COMM,MBRLIST,COBRALST,INVFOLDER';
049800220228           MnuValue  = %Trim(MnuValue) + ',CCNTR';
049900220228           MnuValue  = %Trim(MnuValue) + ',IDCARD';
050000180227
050100180227
050200190410           // Senior Dental Account?
050300190410           SenDental = 'N';
050400190410           chain wTrst TrsMst;
050500190410           if %Found( TrsMst );
050600190410             if TsCode = 'O N' or tsCode = 'O M';
050700190410               SenDental = 'Y';
050800180227
050900190410               // If Termed, display the Write off Menu Option
051000190410               if ATRMDT > 0 and atrmdt < %Dec(%Date);
051100190410                 chain ( wTrst : wSub# : wAcct ) AccSwb;
051200190410                 if %Found( AccSwb );
051300190410                   MnuChoice = %Trim(MnuChoice) + ',<b> Senior Dental</b>';
051400190410                 else;
051500190410                   MnuChoice = %Trim(MnuChoice) + ',Senior Dental' ;
051600190410                 EndIf;
051700190410                 MnuValue = %Trim(MnuValue) + ',SenDen';
051800180227
051900190410               EndIf;
052000180227
052100190410             EndIf;
052200190410           endif;
052300180227
052400180227
052500190517           // Pay by Check..
052600190517           //  Senior Dental:  Trust 25 - 75
052700190517           // Mobile Dental Care:  Trust 76
052800200531           if (wTrst >= 25 and wTrst <= 76) or
052900210922               wTrst in %Range( 80 : 99 );
053000190515
053100190517             MnuChoice = %Trim(MnuChoice) + ',Check by Phone' ;
053200190517             MnuValue  = %Trim(MnuValue) + ',ChkPhone';
053300190515
053400190517           EndIf;
053500190515
053600191206           // Build Scan Folders
053700191206           if isScanTech;
053800191206             MnuChoice = %Trim(MnuChoice) + ',Build Scan Folders' ;
053900191206             MnuValue  = %Trim(MnuValue) + ',ScanFldr';
054000191206           EndIf;
054100191206
054200190515
054300190404         //  Removed Ticket: CR000113
054400190404         //  MnuChoice = %Trim(MnuChoice) + ', Acct Report' ;
054500190404         //  MnuValue  = %Trim(MnuValue) + ',ACTRPT';
054600180227
054700180227
054800190410         endif;
054900171130
055000171103
055100190410         // Display Screen
055200190410         Disp_All();
055300170605
055400190410         // Read through the History Subfile.
055500190410         ReadChanged();
055600180111
055700180426
055800190410         //-----------------------------
055900190410         //
056000190410         // Sending Account Email?
056100190410         //
056200190410         //-----------------------------
056300190410         if s1SndEmail = 'Contact';
056400190410           oEmailAddr = s1conemail;
056500190410           EmailUser( oEmailAddr );
056600190410         EndIf;
056700180426
056800190410         if s1SndEmail = 'EContact';
056900190410           oEmailAddr = s1excEml;
057000190410           EmailUser( oEmailAddr );
057100190410         EndIf;
057200180426
057300180816
057400190410         if s1SndEmail = 'BORNAM';
057500190410           oEmailAddr = s1BorEml;
057600190410           EmailUser( oEmailAddr );
057700190410         EndIf;
057800180426
057900180816
058000200221         if s1SndEmail = 'BRKSEL';
058100210121           oEmailAddr = 'Gbs.brokerselectsupport@amwins.com';
058200190410           EmailUser( oEmailAddr );
058300190410         EndIf;
058400180604
058500180816
058600200221
058700200221         if s1SndEmail = 'BKRNAM';
058800200221           oEmailAddr = s1BkrEml;
058900200221           EmailUser( oEmailAddr );
059000200221         EndIf;
059100200221
059200200221
059300200221
059400190410         // Get the "F" Out
059500190410         if btnGTFO = *on;
059600190410           CmdString = 'ENDRQS';
059700190410           #Command(CmdString:%len(%Trim(CmdString)));
059800190410         EndIf;
059900180604
060000200206
060100200206         //-----------------------------
060200200206         //
060300200206         // View Related Accounts
060400200206         //
060500200206         //-----------------------------
060600200206         if btnRelat = *on;
060700200206           oTrst = wTrst;
060800200206           oSub# = wSub#;
060900200206           oAcct = wAcct;
061000200206
061100200207           RelatedAct( oTrst : oSub# : oAcct : oCancel);
061200200207
061300200207           if oCancel = 'N' ;
061400200207             s1ActNbr = %Editc(oTrst:'X') +
061500200207             %Editc(oSub#:'X') +
061600200207             %Editc(oAcct:'X') ;
061700200207
061800200207             ActChgd = *on;
061900200207             iter;
062000200207
062100200207           EndIf;
062200200207
062300200206
062400200206         EndIf;
062500200206
062600200206
062700180604
062800180604
062900190410         //-----------------------------
063000190410         //
063100190410         // Onsite Link Selected?
063200190410         //
063300190410         //-----------------------------
063400190410         if btnOnSite = *on;
063500190410           oTrst = wTrst;
063600190410           oSub# = wSub#;
063700190410           oAcct = wAcct;
063800180426
063900190410           onSiteList( oTrst : oSub# : oAcct );
064000180426
064100190410         EndIf;
064200180426
064300180426
064400171103
064500190410         // Process Menu Options
064600190410         Select;
064700190410         When mnuResp = 'DIARY';
064800171027
064900190410           oDiary = 'I' + %Editc(wTrst:'X') +  %Editc(wSub#:'X') +
065000190410             %Editc(wAcct:'X');
065100171027
065200190410           DiaryNotes( oDiary );
065300171027
065400171027
065500190410         When mnuResp = 'ISSUES';
065600190410           oTrst = wTrst;
065700190410           oSub# = wSub#;
065800190410           oAcct = wAcct;
065900190410           oMember = 0;
066000171108
066100190410           IssueTracking( oTrst : oSub# : oAcct : oMember );
066200171108
066300171108
066400190410         When mnuResp = 'COMM';
066500190410           oTrst = wTrst;
066600190410           oSub# = wSub#;
066700190410           oAcct = wAcct;
066800171110
066900190410           CommCtrl( oTrst : oSub# : oAcct );
067000171110
067100171121
067200190410         When mnuResp = 'MBRLIST';
067300190410           oTrst = wTrst;
067400190410           oSub# = wSub#;
067500190410           oAcct = wAcct;
067600190410           oCobra = '';
067700171121
067800190410           MemberList( oTrst : oSub# : oAcct : oCobra );
067900171121
068000190515
068100190517         When mnuResp = 'ChkPhone';
068200190515           oTrst = wTrst;
068300190515           oSub# = wSub#;
068400190515           oAcct = wAcct;
068500190515           INQ021C1( oTrst : oSub# : oAcct );
068600190515
068700190515
068800191206         When mnuResp = 'ScanFldr';
068900191206
069000191206           oKey = %Editc( wTrst : 'X' ) +
069100191206              %Editc( wSub# : 'X' ) +
069200191206              %Editc( wAcct : 'X' );
069300191206
069400191206           INQ024C( oKey );
069500191206
069600191206
069700190515
069800190515
069900190410         When mnuResp = 'COBRALST';
070000190410           oTrst = wTrst;
070100190410           oSub# = wSub#;
070200190410           oAcct = wAcct;
070300190410           oCobra = 'Y';
070400171121
070500190410           MemberList( oTrst : oSub# : oAcct : oCobra );
070600171121
070700180227
070800190410         When mnuResp = 'INVFOLDER';
070900230807           oFolder = '\\invoicesvcACA.amwins.local\' +
071000190621             'Compleodata\INVOICES\FULLYINSRD\' +
071100190410             %Editc( wTrst : 'X' ) + '\' +
071200190410             %Editc( wSub# : 'X' ) + %Editc( wAcct : 'X' ) ;
071300180122
071400190410           OpenFolder( oFolder );
071500171108
071600180227
071700190410         When mnuResp = 'SenDen';
071800190410           swTrst = wTrst;
071900190410           swSub# = wSub#;
072000190410           swAcct = wAcct;
072100180227
072200190410           SD_WriteOff( wadta );
072300180227
072400171027
072500190410         When mnuResp = 'CCNTR';
072600190410           oTrst = wTrst;
072700190410           oSub# = wSub#;
072800190410           oAcct = wAcct;
072900180327
073000190410           CostCntr( oTrst : oSub# : oAcct );
073100180327
073200220228         When mnuResp = 'IDCARD';
073300220228           CharMember = '000000000';
073400220228           CharTSA = %Editc( wTrst: 'X' ) +
073500220228                     %Editc( wSub#: 'X' ) +
073600220228                     %Editc( wAcct: 'X' ) ;
073700220228           oUSER = %trim(WQUSRN);
073800220228           Tmp_IDcard( CharTSA : CharMember : oUSER);
073900190207
074000190410         When mnuResp = 'ACTRPT';
074100190207
074200190410           GBS0052C();
074300190207
074400190410         Endsl;
074500170606
074600170606
074700170525       enddo;
074800170529
074900170525       *inlr = *on;
075000170525
075100171106
075200171229      *-------------------------------------------------------------------------
075300171229      * Load the Account Info...
075400171229      *-------------------------------------------------------------------------
075500171229       Dcl-Proc Load_AcctInfo;
075600171106
075700190410         dcl-s wTaxId Char(10);
075800190410         dcl-s SavSSN Zoned(9);
075900190502         dcl-s fullAcct Char(10);
076000191119         dcl-s AgcAccCnt Zoned(9);
076100191119
076200190410         chain ( wTrst : wSub# : wAcct ) AccMst;
076300190410         chain ( wTrst : wSub# : wAcct ) Ac2Mstl2;
076400190410         chain ( wTrst : wSub# : wAcct ) AccMsp;
076500171106
076600171205
076700190410         // Use SQL to get the Total Counts.
076800220217         Exec Sql
076900220217           Select Count(Distinct mcssno)
077000220217             Into :s1actemp
077100220217             From "F.MCOV"
077200220217             Where mctrst = :wtrst And
077300220217                   mcsub# = :wsub# And
077400220217                   acc# = :wacct And
077500220217                   mcdltd = 'A';
077600171205
077700171205
077800190507
077900190507         // Invoice Print Fee
078000190507         s1admdesc = '';
078100190507         if oldt06 > '';
078200190507
078300190507           wType = 'ADMINFEE';
078400190507           chain ( wType : oldt06 ) Code20p;
078500190507           if %Found( Code20p ) ;
078600190507             s1AdmDesc = c20lDesc;
078700190507           EndIf;
078800190507
078900190507         EndIf;
079000190507
079100180524
079200190410         // Count the number of active members with Medial
079300190410         s1ActMed = 0;
079400190410         Setll ( wTrst : wSub# : wAcct ) mCovc15;
079500180524
079600190410         Dou %Eof(mCovc15);
079700190410           reade ( wTrst : wSub# : wAcct ) mCovc15;
079800190410           if %eof(mCovc15);
079900190410             leave;
080000190410           endif;
080100180524
080200190410           if mcdltd <> 'A';
080300190410             iter;
080400190410           EndIf;
080500180524
080600190410           if savSsn = mcssno;
080700190410             iter;
080800190410           EndIf;
080900180524
081000180524
081100190410           chain ( wTrst : wSub# : mcPlan ) PlnMst;
081200190410           if not %Found( PlnMst ) ;
081300190410             iter;
081400190410           EndIf;
081500180524
081600190410           chain plncat Codesl1;
081700190410           if not %Found( Codesl1 );
081800190410             iter;
081900190410           EndIf;
082000180524
082100190410           if Action = 'M';
082200190410             s1ActMed  = s1ActMed  + 1;
082300190410             SAvSsn = mcssno;
082400190410           EndIf;
082500180524
082600180524
082700190410         Enddo;
082800180524
082900171205
083000220217         Exec Sql
083100220217           Select Count(Distinct mcssno)
083200220217             Into :s1totemp
083300220217             From "F.MCOV"
083400220217             Where mctrst = :wtrst And
083500220217                   mcsub# = :wsub# And
083600220217                   acc# = :wacct;
083700171205
083800171205
083900190410         // Setup the email address
084000190410         s1ConEmail =  %Trim( a2Email1 );
084100190410         s1ExcEml   =  %Trim( a2Email2 );
084200190410         s1Payr     = amPayr;
084300180917
084400190410         // Contact
084500190410         CntColor = '';
084600190410         CntCurs = '';
084700190410         hasCntEml = '';
084800190410         showCntEml = *off;
084900180426
085000190410         if a2Email1 > '';
085100190410           hasCntEml = 'Y';
085200190410           showCntEml = *on;
085300190410           CntColor = '#187CCE';
085400190410           CntCurs = 'pointer';
085500190410         EndIf;
085600171205
085700180426
085800190410         // EX Contact
085900190410         shwECntEml = *off;
086000190410         eCntColor = '';
086100190410         eCntCurs = '';
086200190410         hasECntEml = '';
086300180426
086400190410         if a2Email2 > '';
086500190410           hasECntEml = 'Y';
086600190410           shwECntEml = *on;
086700190410           eCntColor = '#187CCE';
086800190410           ecntCurs = 'pointer';
086900190410         EndIf;
087000180426
087100180426
087200180426
087300180426
087400180426
087500190410         // Check to see if the account has been cancelled.
087600190410         isCanCld = *off;
087700190410         if acdltd = 'C';
087800190410           isCanCld = *on;
087900190410         endif;
088000171129
088100180111
088200190410         // Always show reinstated. ( Per Shelly )
088300190410         // we will only reinstate an account once
088400190410         ViewReinst = *off;
088500190410         if RNSTCD = 'R';
088600190410           ViewReinst = *on;
088700190410         endif;
088800171108
088900190410         wTaxId = %Editc( a2Tax_id# : 'X' );
089000190410         s1taxid = %Subst(wTaxId : 2 : 2 ) + '-' + %Subst(wTaxId : 4 : 7 );
089100171108
089200190410         s1ActNbr = %editc( wTrst : 'X' ) + '-' +
089300190410           %editc( wSub# : 'X' ) + '-' +
089400190410           %editc( wAcct : 'X' );
089500171108
089600190502
089700190502         s1acct_nd =  %editc( wTrst : 'X' ) +
089800190502           %editc( wSub# : 'X' ) +
089900190502           %editc( wAcct : 'X' );
090000171108
090100190410         CharZip = %Editc( aZip : 'X' ) ;
090200180719
090300190410         // If the user didn't add the Zip + 4..
090400190410         if %Subst(CharZip:1:4) = '0000';
090500190410           CharZip = %Subst(CharZip:5:5) + %Subst(CharZip:1:4);
090600190410         endif;
090700180719
090800190410         s1CityStZp = %Trim( aCity ) + ', ' + aState + '  ' +
090900190410           %Subst(CharZip:1:5) + '-' + %Subst(CharZip:6:4);
091000170531
091100171106
091200190510
091300190510         // Physical Address
091400190510         CharZip = %Editc( a2Zip5 : 'X' ) + %Editc( a2Zip4 : 'X' ) ;
091500190510
091600190510         // If the user didn't add the Zip + 4..
091700190510         if %Subst(CharZip:1:4) = '0000';
091800190510           CharZip = %Subst(CharZip:5:5) + %Subst(CharZip:1:4);
091900190510         endif;
092000190510
092100190510         a2CityStZp = %Trim( a2City ) + ', ' + a2State + '  ' +
092200190510           %Subst(CharZip:1:5) + '-' + %Subst(CharZip:6:4);
092300190510
092400190510
092500190510
092600190510
092700190510
092800190410         PhoneC = %Editc( aPhone : 'X' ) ;
092900190410         s1Phone = '(' +  %Char( Aarea ) + ') ' +
093000190410           %Subst( PhoneC : 1 : 3 ) + '-' + %Subst( PhoneC : 4 : 4 );
093100171106
093200171106
093300190410         PhoneC = %Editc( Fax# : 'X' ) ;
093400190410         s1fax   = '(' +  %Char( faxare ) + ') ' +
093500190410           %Subst( PhoneC : 1 : 3 ) + '-' + %Subst( PhoneC : 4 : 4 );
093600171106
093700171108
093800190410         s1cfsedt = *Blanks;
093900190410         if cfsedt > 0;
094000190410           s1cfsedt =  %Char(%Date(cfsedt:*iso):*Usa);
094100190410         endif;
094200171107
094300171108
094400190410         // OLE Data
094500190410         s1OleBeg = *Blanks;
094600190410         s1OleEnd = *Blanks;
094700190410         s1OleMsg = 'No Current OLE Range.';
094800171107
094900190410         CompDate = %Dec( %Date + %Days(1)  ) ;
095000191013
095100191121         Setll ( wTrst : wSub# : wAcct ) AccOspL2;
095200191013
095300191121         Dou %Eof(AccOspL2);
095400191121           reade ( wTrst : wSub# : wAcct ) AccOspL2;
095500191121           if %eof(AccOspL2);
095600191013             leave;
095700191121           endif;
095800191013
095900191013
096000190410           if aobedt <= CompDate and
096100190410             (aoendt >= CompDate   or aoendt = 0 ) ;
096200171107
096300220124
096400220217             monitor;
096500220217               s1OleBeg =  %Char(%Date(aobedt:*iso):*Usa);
096600220124
096700220217             on-error;
096800220217               s1OleBeg = 'Date Error';
096900220124
097000220217             EndMon;
097100220124
097200220124
097300220124
097400190410             if aoendt > 0 ;
097500190410               s1OleEnd =  %Char(%Date(aoendt:*iso):*Usa);
097600190410             endif;
097700171107
097800171227
097900190410             s1xmit = '';
098000190410             if AODTDT > 0;
098100190503               test(de) *iso aodtdt;
098200190503               if not %Error;
098300190507                 s1xmit =  %Char(%Date(aodtdt:*iso):*Usa);
098400190503               endif;
098500190410             EndIf;
098600190503
098700171227
098800191121             sv_AoCode = aoCode;
098900190410             chain aocode aoecod;
099000190410             if not %Found( aoecod ) ;
099100190410               s1OleMsg = 'OLE ' + %Char( aocode ) + ' Not on file.';
099200190410             else;
099300190410               s1OleMsg = aeDesc;
099400190410             endif;
099500190410           endif;
099600191013         enddo;
099700171107
099800190410         // Dates
099900190410         s1acvtdt = *Blanks;
100000190410         if acvtdt > 0;
100100190410           s1acvtdt =  %Char(%Date(acvtdt:*iso):*Usa);
100200190410         endif;
100300171107
100400190410         s1Enroll = *Blanks;
100500190410         if Enroll > 0;
100600190410           s1Enroll =  %Char(%Date(Enroll:*iso):*Usa);
100700190410         endif;
100800171107
100900190410         s1GbsBdt = *Blanks;
101000190410         if GbsBdt > 0;
101100190410           s1GbsBdt =  %Char(%Date(GbsBdt:*iso):*Usa);
101200190410         endif;
101300171108
101400190410         s1aTrmDt = *Blanks;
101500190410         if aTrmDt > 0;
101600190410           s1aTrmDt =  %Char(%Date(aTrmDt:*iso):*Usa);
101700190410         endif;
101800180706
101900180706
102000190410         // Get the Paid Through Date
102100190410         oKey = %Editc( wTrst : 'X' ) + %Editc( wSub# : 'X' ) +
102200190410           %Editc( wAcct : 'X' );
102300180706
102400190410         GetPaidThru( oKey : oDate ) ;
102500190410         s1PaidThr = '';
102600190410         if oDate <> '00000000' ;
102700190410           wDate = %Dec( oDate : 8 : 0 ) ;
102800190410           s1PaidThr = %Char(%Date( wDate : *iso):*Usa);
102900190410         EndIf;
103000180706
103100191121         wGrouper = 'HIDE COLMN';
103200191121         wCode = 'PER_PAY_DEDUCT';
103300191121         s1PayDed = 'NA';
103400191121         if sv_AoCode = 8 or sv_AoCode = 9;
103500191121           s1PayDed = 'Yes';
103600191121           chain ( wTrst : wSub# : wAcct: wGrouper : wCode ) WebPayChp;
103700191121           if %Found( WebPayChp );
103800191121             s1PayDed = 'No';
103900191121           EndIf;
104000191121         endif;
104100191121
104200191121
104300180706
104400190410         // AA Code
104500190410         aaName = *Blanks;
104600190410         chain aa_Code aaCode;
104700190410         if %found( aaCode );
104800191028           aaName = %Trim( afnam ) + ' ' + %Trim( alnam );
104900190410         endif;
105000180404
105100190410         //  BOR Info
105200190410         s1bor = smancd;
105300190410         chain s1bor  SMAN ;
105400190410         s1BorNam = %Trim( sfname) + ' ' + %Trim( slname ) ;
105500180301
105600190920
105700190920         // Check for Broker Access
105800190920         s1brkacc = '';
105900190920         wIdent = sGrp;
106000200416         open oeReposl2;
106100190920         chain wIdent oeReposl2;
106200190920         if %Found( oeReposl2 );
106300200107           if rGrid = 100119;   // OE Access
106400200207             s1BrkAcc = 'Yes';
106500200207           EndIf;
106600200207         endif;
106700200416         close oeReposl2;
106800190920
106900190920
107000191119         // Agency Access
107100191119         s1AgcAcc = '';
107200191119         AgcAccCnt = 0;
107300191119
107400220217         exec sql
107500220217           Select count(*)
107600220217             into :agcAccCnt
107700220217             from oeReposp
107800220217             where RIDEN = trim(:Free15) and
107900220217                   rgrid = '100118';
108000191119
108100200415
108200191121         if AgcAccCnt > 0;
108300191121           s1AgcAcc = 'Yes';
108400191121         EndIf;
108500191119
108600191119
108700191119
108800190410         if sArea  > 0;
108900190410           PhoneC = %Editc( sPhone : 'X' ) ;
109000190410           s1borPh#  = '(' +  %Char( sArea ) + ') ' +
109100190410             %Subst( PhoneC : 1 : 3 ) + '-' + %Subst( PhoneC : 4 : 4 );
109200190410         endif;
109300171218
109400190410         chain s1bor  SMAN2L1;
109500190410         if %Found( sman2l1 );
109600190410           // s1BorEml = 'mailto:' + %Trim( SBREML ) ;
109700190410           s1BorEml =  %Trim( SBREML ) ;
109800190410         endif;
109900180816
110000180816
110100190410         //?Broker
110200190410         BorColor = '';
110300190410         BorCurs = '';
110400190410         hasBorEml = '';
110500180816
110600190410         if s1BorEml > '';
110700190410           hasBorEml = 'Y';
110800190410           BorColor = '#187CCE';
110900190410           BorCurs = 'pointer';
111000190410         EndIf;
111100180816
111200171218
111300190410         //  Broker Info
111400190410         chain a2Code1 SMAN ;
111500190410         s1BkrNam = %Trim( sfname) + ' ' + %Trim( slname ) ;
111600190410         if sArea  > 0;
111700190410           PhoneC = %Editc( sPhone : 'X' ) ;
111800190410           s1bkrPh#  = '(' +  %Char( sArea ) + ') ' +
111900190410             %Subst( PhoneC : 1 : 3 ) + '-' + %Subst( PhoneC : 4 : 4 );
112000190410         endif;
112100171218
112200190410         chain a2Code1 SMAN2L1;
112300190410         if %Found( sman2l1 );
112400190410           //s1BkrEml = 'mailto:' + %trim( SBREML );
112500190410           s1BkrEml =  %trim( SBREML );
112600190410         endif;
112700171218
112800190410         //?Servicing Broker
112900190410         BkrColor = '';
113000190410         BkrCurs = '';
113100190410         hasBkrEml = '';
113200180816
113300190410         if s1BkrEml > '';
113400190410           hasBkrEml = 'Y';
113500190410           BkrColor = '#187CCE';
113600190410           BkrCurs = 'pointer';
113700190410         EndIf;
113800171218
113900171218
114000210827
114100190410         // Billing Info
114200190410         CurrMonth = %Subdt( %Date(ACVTDT:*iso) : *Months );
114300190410         PrevMonth =  %Subdt( %Date(ACVTDT:*iso) - %Days( 1 ) : *Months );
114400171108
114500190410         Bal( 1 ) = Bal1;
114600190410         Bal( 2 ) = Bal2;
114700190410         Bal( 3 ) = Bal3;
114800190410         Bal( 4 ) = Bal4;
114900190410         Bal( 5 ) = Bal5;
115000190410         Bal( 6 ) = Bal6;
115100190410         Bal( 7 ) = Bal7;
115200190410         Bal( 8 ) = Bal8;
115300190410         Bal( 9 ) = Bal9;
115400190410         Bal( 10 ) = Bal10;
115500190410         Bal( 11 ) = Bal11;
115600190410         Bal( 12 ) = Bal12;
115700171108
115800190410         PriorBal = Bal( PrevMonth );
115900190410         CurrBal = Bal( CurrMonth );
116000171108
116100190410         PrevBal =  %xfoot( Bal ) - PriorBal - CurrBal;
116200190410         CurrDue =  %xfoot( Bal );
116300171108
116400190410         // Check for an MLR (ACA) Account
116500220217         Exec Sql
116600220217           Select Count(*)
116700220217             Into :acacount
116800220217             From cmctl2
116900220217                  Join plnauxp
117000220217                    On pxtrst = cmtrst And
117100220217                      pxsub# = csubdv And
117200220217                      pxplan = cmplan
117300220217             Where cmtrst = :wtrst And
117400220217                   csubdv = :wsub# And
117500220217                   cmacct = :wacct And
117600220217                   (cmcan = 0 Or
117700220217                     cmcan > Int(Replace(Char(Current_Date, Iso), '-', ''))) And
117800220217                   pxacar In ('Y', 'D');
117900171130
118000171130
118100190410         isACA = *off;
118200190410         if AcaCount > 0;
118300190410           isAca = *on;
118400190410         endif;
118500171130
118600180426
118700190410         // Check the Onsite Dental Database.
118800190410         ShowDntCnt = *off;
118900190410         chain  (wTrst : wSub# : wAcct ) odcntcp;
119000190410         if %Found( odcntcp );
119100190410           ShowDntCnt =  *on;
119200190410         EndIf;
119300180426
119400180426
119500190410         chain  (wTrst : wSub# : 0) odcntcp;
119600190410         if %Found( odcntcp );
119700190410           ShowDntCnt =  *on;
119800190410         EndIf;
119900180426
120000180426
120100190410         // ACH ( Auto Debit Setup )
120200190410         s1AutoDbt = '';
120300190517         s1DbtText = 'Auto Debit:';
120400190410         Setll ( wTrst : wSub# : wAcct ) Secach;
120500190410
120600190410         Dou %Eof(Secach);
120700190410           reade ( wTrst : wSub# : wAcct ) Secach;
120800190410           if %eof(Secach);
120900190410             leave;
121000190410           endif;
121100190410
121200210831           if ahbedt <= %Dec( %Date ) and
121300210831             ( ahendt = 0  or ahendt >= %Dec( %Date )) ;
121400190410
121500190410
121600210831             // Group: 3-1-911.
121700210831             // The system should not store an ACH begin date when it is a
121800210831             // single payment. Since this group is not signed up for Auto
121900210831             // Debit, the flag should be a No.
122000210831             // So.. We are now using the Auto Debit Flag instead of the date.
122100200723
122200210831             if AHDEBIT = 'E';
122300210831               s1AutoDbt = 'Yes';
122400210831             EndIf;
122500210831           EndIf;
122600190718
122700190718
122800190410         Enddo;
122900190410
123000190517
123100190517         // Not an AutoDebit.. Check the for an ACH Account.
123200190517         if s1AutoDbt = '';
123300190517
123400190517           Setll ( wTrst : wSub# : wAcct ) AccAchl1;
123500190517
123600190517           Dou %Eof(AccAchl1);
123700190517             reade ( wTrst : wSub# : wAcct ) AccAchl1;
123800190517             if %eof(AccAchl1);
123900190517               leave;
124000190517             endif;
124100190517
124200190517             if ahbedt <= %Dec( %Date ) and
124300190517               ( ahendt = 0  or ahendt >= %Dec( %Date )) ;
124400190517               s1DbtText = 'ACH Account:';
124500190517               s1AutoDbt = 'Yes';
124600190517             EndIf;
124700190517
124800190517
124900190517           Enddo;
125000190517
125100190517
125200190517         endif;
125300190517
125400180426
125500190507         //----------------------------------------------------
125600190507         //
125700190507         // Get the Payroll Import file information
125800190507         //
125900190507         //----------------------------------------------------
126000190502         FullAcct  = %Editc( wTrst : 'X' ) + %Editc( wSub# : 'X' ) +
126100190502           %Editc( wAcct : 'X' );
126200190502
126300190502         s1PayVend = '';
126400220217         Exec Sql
126500220217           Select ftpayvend
126600220217             Into :s1payvend
126700220217             From gbs0030p
126800220217             Where ftgroup = :fullacct and
126900220217                   ftRcdSts = 'A';
127000190502
127100200206
127200200206
127300200206         //----------------------------------------------------
127400200206         //
127500200206         // Related Accounts
127600200206         //
127700200206         //----------------------------------------------------
127800200206         VisRelAct = *off;
127900200206
128000200206         Chain ( 'F' : wTrst : wSub# : wAcct ) acRelatp;
128100200206         if %Found( acRelatp );
128200200207           VisRelAct = *on;
128300200206         EndIf;
128400200206
128500200206
128600200219
128700200219         //----------------------------------------------------
128800200219         //
128900200219         // Broker Select Accounts
129000200219         //
129100200219         //----------------------------------------------------
129200200415         visBrkSel = isBrokerSel();
129300200219
129400220117         s1smrmgr = '';
129500220117         s1rmname = '';
129600210831
129700210831         if visBrkSel = *off;
129800210831
129900210831           if (wTrst <> 5) ;
130000210831             if ( wTrst < 25 ) or (wTrst > 99);
130100220117               // Broker Rep
130200210831
130300220117               chain smancd smanRmGp;
130400220117               if %Found( smanRmGp );
130500220117                 s1smrmgr = smrmgr;
130600210831
130700220117                 chain smrmgr rMgrMst3;
130800220117                 s1rmname = rmName;
130900210831
131000220117               EndIf;
131100220117             EndIf;
131200210831           EndIf;
131300210831         EndIf;
131400210831
131500171107
131600220117         //----------------------------------------------------
131700220117         //
131800220117         // Load Notes
131900220117         //
132000220117         //----------------------------------------------------
132100220117         oHtml = '';
132200220121         hasNotes = *Off;
132300220117         Setll ( wTrst : wSub# : wAcct ) amNotep;
132400220117
132500220117         Dou %Eof(amNotep);
132600220117           reade ( wTrst : wSub# : wAcct ) amNotep;
132700220117           if %eof(amNotep);
132800220117             leave;
132900220117           endif;
133000220117
133100220117           oHtml = %Trim(oHtml) + '<p><b>'+ onSumry + '</b><br/>';
133200220117           oHtml = %Trim(oHtml) + '<p style="margin-left: 40px">' +
133300220117           onNote + '</p><br/>';
133400220121           hasNotes = *on;
133500220117
133600220117         enddo;
133700220117
133800220513          // ACCADP
133900220513             chain ( wTrst : wSub# : wAcct ) AccAdp;
134000220513             if %Found( AccAdp );
134100220513             g1dp   = ADADFL;
134200220513             g1ssex = ADSEXS;
134300220513             g1dsex = ADSEXD;
134400220513             g1PTE = A2PARTTIME;
134500220513             g1RET = A2RETIREES;
134600220513             g1EEO = A2OTHERINS;
134700220513             endif;
134800220117
134900220121
135000220121         // Build Tab Headers
135100220121
135200220513         TabNames = 'Account Info,OLE Info,' +
135300220513                    'Other Info,COBRA,Notes,Group Eligibility';
135400220121
135500220121         if hasNotes = *on;
135600220513           TabNames = 'Account Info,OLE Info,' +
135700220513                      'Other Info,COBRA,' +
135800220513         //  '<img src="/profoundui/userdata/Images2/paperclip.png">' +
135900220513                      '+ Notes,Group Eligibility';
136000220121
136100220121         EndIf;
136200220117
136300220117       End-proc;
136400180102      *-------------------------------------------------------------------------
136500180102      * Clear the Subfiles...
136600180102      *-------------------------------------------------------------------------
136700220117       Dcl-Proc Clear_All;
136800170605
136900220117         s1SndEmail =  '';
137000220121
137100180426
137200220121         // Clear the Subfile.
137300220117         ClrSfl = *on;
137400220117         Write Screen1;
137500220117         ClrSfl = *off;
137600220117         rrn2 = 0;
137700220117         SFLScroll = 0;
137800170605
137900220117       End-Proc;
138000170605
138100180102      *-------------------------------------------------------------------------
138200180102      * Display The Subfiles...
138300180102      *-------------------------------------------------------------------------
138400220117       Dcl-Proc Disp_All;
138500220504
138600220504        Get_Env();
138700170605
138800220117         // Display the Subfile.
138900220117         DspSfl = *on  ;
139000220117         exfmt Screen1;
139100220117         DspSfl = *off;
139200170605
139300220117       End-Proc;
139400170607
139500180102      *-------------------------------------------------------------------------
139600180102      * Load the History Section
139700180102      *-------------------------------------------------------------------------
139800220117       Dcl-Proc LoadHistory;
139900180124
140000180124
140100190410         dcl-s wInvoice Char(13);
140200190410         dcl-s wFileName Char(100);
140300190410         dcl-s SavSqlCode like(sqlcod);
140400190410         dcl-s Min_Date Zoned(8);
140500190517         dcl-s DNP_Inv Zoned(7);
140600190621         dcl-s Order Char(4);
140700180124
140800180124
140900190410         HistKey = %Editc( wTrst : 'X' ) + %Editc( wSub# : 'X' ) +
141000220117         %Editc( wAcct : 'X' );
141100181126
141200220117         HistColor = '';
141300220117         Hist_Tip = '';
141400220117         wDate = %Dec( s1HistDate );
141500181126
141600181126
141700220117         // Get the lowest Transaction Date from the History File.
141800220217         Exec Sql
141900220217           Select Min(trdate)
142000220217             Into :min_date
142100220217             From "F.HIST"
142200220217             Where hkey = :histkey;
142300220117         if sqlCode <> 0;
142400220117           Min_Date = 0;
142500220117         else;
142600220117           if min_Date < wDate and Min_Date > 0;
142700220117             Histcolor = '#0000FF';
142800220117             Hist_Tip = 'Oldest history record in file: '+
142900220117             %Char(%Date(Min_Date :*iso):*Usa);
143000220117           EndIf;
143100181126
143200190410         endif;
143300181126
143400180124
143500190410         // Get the Invoice List from the CompLeo Directory
143600190410         oPath = %Editc( wTrst : 'X' ) + '\' + %Editc( wSub# : 'X' ) +
143700220117         %Editc( wAcct : 'X' );
143800180124
143900190410         GetInvList( oPath ) ;
144000180124
144100190621         order = 'desc';
144200190621         if ChgHist = *on;
144300220117           order = 'ASC';
144400190621         EndIf;
144500190621
144600190621
144700190410         // Build SQL Statement
144800190410         SqlStmt =
144900220117         'Select ' +
145000220117         ' trDate, lDescr, ck#Not, Note2, CovtDt, '         +
145100220117         '  hOper, trAmt, trCode, cm$flg, Recvdt, hsTrTime ' +
145200220117         'From "F.HIST"  '                                  +
145300220117         'Join "F.CODESL1" on trCode = key3      '          +
145400220117         'Where hkey = ' + q + HistKey + q                  +
145500220117         '  and trDate >= ' + %Char( wDate ) +
145600220117         ' Order by hkey, trDate ' + %Trim( order ) +
145700220117         ', rrn("F.HIST") desc ' ;
145800170605
145900220217         Exec Sql
146000220217           Declare c1 Cursor For sqlstmt;
146100220217         Exec Sql
146200220217           Prepare sqlstmt From :sqlstmt;
146300220217         Exec Sql
146400220217           Open c1;
146500170605
146600220117         Dou SqlCod <> *Zero;
146700220217           Exec Sql
146800220217             Fetch Next From c1
146900220217               Into :@histdata;
147000170605
147100220117           if SqlCod <> *Zero;
147200220117             Leave;
147300220117           endif;
147400170605
147500220117           // If this has an SSN, display the Members Name
147600220117           s1MemName = *blanks;
147700220117           if  %Subst( sqNote1 : 5 : 1 ) = '-' and
147800220117           %Subst( sqNote1 : 8 : 1 ) = '-' ;
147900220117             CharSSN = %Subst( sqNote1 : 2 : 3 ) +
148000220117             %Subst( sqNote1 : 6 : 2 ) +
148100220117             %Subst( sqNote1 : 9 : 4 );
148200180104
148300220117             if %check( digits : %Trim( CharSSN )) = 0;
148400180104
148500220117               wSSN = %Dec( CharSSN : 9 : 0 ) ;
148600220117               chain wSSN Member;
148700220117               if %Found(Member);
148800220117                 s1MemName = %trim( mfname ) + ' ' + %Trim( mlname );
148900220117               EndIf;
149000220117             endif;
149100220117           endif;
149200191219
149300180111
149400220117           // Setup Diary Display
149500220117           s1trCode = sqTrCode;
149600180111
149700220117           NoteCursor = *Blanks;
149800190410           NoteColor  = '';
149900180111
150000220117           if s1trCode = 'L81';
150100220117             NoteCursor = 'Pointer';
150200220117             NoteColor = '#0000FF';
150300190410           EndIf;
150400180111
150500180111
150600220117           if s1trCode = 'UHM';
150700220117             NoteCursor = 'Pointer';
150800220117             NoteColor = '#0000FF';
150900220117           EndIf;
151000191219
151100191219
151200220117           // If this is an invoice -
151300220117           //   check to see if we have that invoice
151400220117           showEmail = *off;
151500220117           showPDF = *off;
151600220117           s1FileName = '';
151700220117           //s1invhtml = '';
151800180124
151900220117           if s1trCode = 'BMB';
152000220117             SavSqlCode = sqlcod;
152100180124
152200220117             wInvoice = '%INV#' + %Subst( sqNote1 : 6 : 7 ) + '%';
152300220117             wfileName = '';
152400180124
152500220217             Exec Sql
152600220217               Select Substring(Rcd, 1, 100)
152700220217                 Into :wfilename
152800220217                 From qtemp/flat500p
152900220217                 Where rcd Like :winvoice;
153000180124
153100220117             if sqlCod = 0;
153200220117               showEmail = *on;
153300220117               showPDF = *on;
153400220117               s1FileName = wFileName;
153500220117             //s1invhtml =  'mailto:' + %Trim( '' );
153600220117             EndIf;
153700180124
153800220117             // Reset SqlCode
153900220117             sqlcod = SavSqlCode;
154000220117           Endif;
154100180124
154200180111
154300220117           s1cm$flg = sqcm$flg;
154400180111
154500220117           s1fmtDate = 0;
154600220117           s1TrDate = *Blanks;
154700220117           if sqtrDate > 0;
154800220117             s1fmtDate = sqTrDate;
154900220117             s1TrDate = %Char(%Date(sqtrDate :*iso):*Usa);
155000190410           endif;
155100170605
155200220117           s1t_Time = sqt_Time;
155300180803
155400220117           s1lDescr = sqlDescr;
155500190410           s1ck#not = sqNote1;
155600190410           s1note2 =  sqNote2;
155700170605
155800180313
155900190410           if sqRecvDt > 0;
156000220117             %Subst( s1Note2 : 18 : 13 ) = 'RD=' +
156100220117               %Char(%Date(sqRecvDt :*iso):*Usa);
156200220117           EndIf;
156300180313
156400180313
156500220117           s1CovDate = *Blanks;
156600190410           if sqCovtDt > 0;
156700220117             s1CovDate = %Char(%Date(sqCovtDt :*iso):*Usa);
156800190410           endif;
156900170605
157000220117           s1Oper = sqOper;
157100170605
157200220117           s1OprEml = '';
157300220117           ShowEmail2 = *off;
157400220117           chain s1Oper EmailAddr;
157500220117           if %Found( EmailAddr );
157600220117             s1OprEml = EAEMAIL;
157700220117             ShowEmail2 = *on;
157800220117           endif;
157900180309
158000170605
158100220117           // Do Not Publish Invoice
158200220117           Note1Tip = '';
158300220117           if s1trCode = 'U79';
158400220117             DNP_Inv = %Dec( %Subst(s1Note2 : 6 : 7 ) : 7: 0);
158500190517
158600220117             chain ( wTrst : wSub# : wAcct : Dnp_INv ) invDnp;
158700220117             if %Found( invDnp ) ;
158800220117               s1ck#not = IndReas;
158900220117               if %Len(%Trim(IndReas)) > 30;
159000220117                 s1ck#not = %Subst( IndReas : 1 :27 ) + '...';
159100220117               EndIf;
159200190517
159300220117               Note1Tip = IndReas;
159400220117             endif;
159500190517
159600220117           endif;
159700190517
159800220117           if s1trCode = 'UHM';
159900220117             Note1Tip = 'Go to the Do not Display Screen';
160000220117           endif;
160100191219
160200190517
160300190517
160400190517
160500190517
160600190517
160700220117           rrn2 = rrn2 + 1;
160800220117           Write HistSfl;
160900170605
161000220117           if rrn2 >= 9999;
161100220117             leave;
161200220117           endif;
161300171121
161400170605
161500220117         Enddo;
161600220217         Exec Sql
161700220217           Close c1;
161800220117       End-Proc;
161900170605
162000180111
162100220117       //-----------------------------------------------------------------
162200220117       dcl-proc ReadChanged;
162300180111
162400180111
162500190410         dcl-f DiaryDt1 keyed
162600220117         ExtDesc('F.DIARYDT1') ExtFile(*extdesc);
162700180111
162800190410         dcl-ds DiaryData LikeRec( RDIARYDT );
162900180111
163000180111
163100220117         dcl-s hKey Char(10);
163200220117         dcl-s @Subj Char(50);
163300220117         dcl-s @Addt Zoned(8);
163400220117         dcl-s @adti Zoned(6);
163500220117         dcl-s @adus Char(10);
163600220117         dcl-s wCount Zoned(5);
163700180803
163800220117         dcl-s @StartTime Char(10);
163900220117         dcl-s @Endtime  Char(10);
164000180803
164100180111
164200220117         dcl-c  crlf  x'0d25';
164300180111
164400180111
164500220117         Dou *in95 = *ON;
164600220117           READC HistSFL;
164700220117           *in95 = %EOF;
164800180111
164900220117           If *in95 = *OFF;
165000180111
165100220117             // Check Content Menu Options
165200220117             if runOption > *blanks;
165300180111
165400180111
165500220117               if runOption = 'OpenPDF';
165600180124
165700230807                 oFolder = '\\invoicesvcACA.amwins.local\' +
165800220117                 'Compleodata\INVOICES\FULLYINSRD\' +
165900220117                 %Editc( wTrst : 'X' ) + '\' +
166000220117                   %Editc( wSub# : 'X' ) + %Editc( wAcct : 'X' ) + '\' +
166100220117                   %Trim(s1FileName);
166200180124
166300220117                 OpenFolder( oFolder );
166400180124
166500180124
166600220117               EndIf;
166700180124
166800180125
166900220117               if runOption = 'EmailInv';
167000180125
167100230901                 oInvPath = '\\invoicesvACA.amwins.local\' +
167200220117                 'Compleodata\INVOICES\FULLYINSRD\' +
167300220117                 %Editc( wTrst : 'X' ) + '\' +
167400220117                   %Editc( wSub# : 'X' ) + %Editc( wAcct : 'X' ) + '\' +
167500220117                   %Trim(s1FileName);
167600180125
167700190410                 EmailInvoice( oInvPath : s1ck#not );
167800180125
167900180125
168000220117               EndIf;
168100180125
168200180124
168300220117               if runOption = 'EmailOper';
168400180309
168500190410                 oEmailAddr = s1OprEml;
168600220117                 EmailUser( oEmailAddr );
168700180309
168800220117               EndIf;
168900180309
169000180309
169100220117               if runOption = 'ViewDNS';
169200200207                 getCarrier();
169300200207                 troff(carrier: 'N');
169400220117               endif;
169500180124
169600180124
169700220117               if runOption = 'ViewDiary';
169800190410                 s3Head = '';
169900190410                 s3Body = '';
170000190410                 s3Crtby = '';
170100180111
170200180111
170300190410                 hkey = %ScanRpl( '-' : '' : s1ActNbr );
170400180111
170500180111
170600190410                 @StartTime = %Char(s1t_Time - %Minutes(10));
170700190410                 @EndTime = %Char(s1t_Time + %Minutes(2));
170800180803
170900190410                 @StartTime = %scanrpl('.' : '' : @StartTime );
171000190410                 @EndTime   = %scanrpl('.' : '' : @EndTime );
171100180803
171200180111
171300190410                 // Get the Header Info.
171400220217                 Exec Sql
171500220217                   Select nhsubj, nhaddt, nhadti, nhadus
171600220217                     Into :@subj, :@addt, :@adti, :@adus
171700220217                     From "F.DIARYHD0"
171800220217                     Where nhkey = :hkey And
171900220217                           Substring(nhsubj, 1, 30) = :s1ck#not And
172000220217                           nhaddt = :s1fmtdate And
172100220217                           nhadti Between :@starttime And :@endtime;
172200180111
172300220117                 s3Head = @Subj;
172400220117                 s3Crtby = 'Record Created by ' + %Trim( @Adus ) +
172500220117                 ' on ' + %Char(%Date(@Addt:*iso ) : *usa) +
172600220117                   ' at ' + %Char(%Time(@adti) : *usa) ;
172700180111
172800180111
172900180111
173000220117                 //-----------------------------------------
173100220117                 //
173200220117                 // Read through the Detail Records.
173300220117                 //
173400220117                 //-----------------------------------------
173500220117                 wCount = 1;
173600181029
173700220117                 setll ( hkey : @Addt : @Adti ) DiaryDt1;
173800220117                 dou %Eof( DiaryDt1 ) ;
173900190410                   reade  ( hkey : @Addt : @Adti ) DiaryDt1 DiaryData;
174000180111
174100220117                   if %eof( DiaryDt1 );
174200220117                     leave;
174300220117                   EndIf;
174400181029
174500220117                   //      s3body = %trim(s3body) + crlf +
174600220117                   //         %Trim( DiaryData.ndText ) ;
174700181029
174800220117                   %Subst( s3Body : wCount : 70 ) =
174900220117                   DiaryData.ndText ;
175000220117                   wCount = wCount + 70;
175100181029
175200220117                 EndDo;
175300180111
175400220117                 exfmt  DiaryNote;
175500180111
175600180111
175700180111
175800220117               Endif;
175900180111
176000220117             EndIf;
176100180111
176200180111
176300180111
176400180111
176500180111
176600220117             runOption = *Blanks;
176700220117             update HistSFL;
176800180111
176900220117           endif;
177000180111
177100220117         //  Reload = 'Y';
177200180111
177300180111
177400220117         enddo;
177500220117       end-proc;
177600180222
177700180222
177800180222      *-------------------------------------------------------------------------
177900180222      * Split out the account number
178000180222      *-------------------------------------------------------------------------
178100220117       Dcl-Proc Split;
178200180222
178300220117         dcl-s x int(10);
178400220117         dcl-s tokens varchar(100) dim(50);
178500220117         dcl-s Trst Char(3);
178600220117         dcl-s Sub  Char(3);
178700220117         dcl-s Acct Char(4);
178800180222
178900220117         tokens(*) = #Gettok( s1ActNbr : '-' : x );
179000180222
179100180222
179200220117         // we should have 3 array elements filled  in.
179300220117         // the next blank space should be #4.
179400220117         x = %lookup( '' : tokens ) ;
179500220117         if x = 4;
179600220117           Trst = #zFill( 3 : %Trim( Tokens(1) ));
179700220117           Sub  = #zFill( 3 : %Trim( Tokens(2) ));
179800220117           Acct = #zFill( 4 : %Trim( Tokens(3) ));
179900180222
180000220117           s1ActNbr = trst + '-' + Sub + '-' + Acct;
180100180222
180200220117         EndIf;
180300180222
180400180222
180500220117       End-Proc;
180600180613      *-------------------------------------------------------------------------
180700180613      *
180800180613      * Setup the Library List
180900180613      *
181000180613      *-------------------------------------------------------------------------
181100220117       dcl-proc SetLibl;
181200180613
181300180613
181400190410         //----------------------------------------------------
181500190410         //
181600190410         //   Retrieve Current Library List
181700190410         //
181800190410         //----------------------------------------------------
181900180613
182000190410         RtvJobInf( Rcvvar : RcvVarLen : 'JOBI0700' : '*' : '' ) ;
182100190410         libsToSkip = NbrSysLibs +
182200220117         NbrPrdLibs +
182300220117         NbrCurLibs;
182400180613
182500220117         Pos = ( LibsToSkip * 11 ) + 81;
182600180613
182700190410         UsrLibs = %Subst( RcvVar: Pos : NbrUsrLibs * 11 ) ;
182800180613
182900180613
183000180613
183100190410         //----------------------------------------------------
183200190410         //
183300190410         //   Check for RPGSPDASH in the current Library list
183400190410         //
183500190410         //----------------------------------------------------
183600190410         Dash = %Lookup( 'RPGSPDASH' : theLibs ) ;
183700180613
183800180613
183900180613
184000190410         //----------------------------------------------------
184100190410         //
184200190410         //   Check for RPGSPPAYR in the current Library list
184300190410         //
184400220117         //----------------------------------------------------
184500220117         Payr = %Lookup( 'RPGSPPAYR' : theLibs ) ;
184600180613
184700180613
184800220117         //----------------------------------------------------
184900220117         //
185000220117         //   Check the web environment
185100220117         //
185200220117         //----------------------------------------------------
185300220117         chain ( wTrst : wSub# : wAcct ) AccOspl3;
185400220117         if %Found( AccOspL3 );
185500180613
185600220117           // Payroll System
185700220117           //   --  Replace Dashboard with Payroll
185800220117           if (aoCode = 6 or aoCode = 7) and Dash > 0;
185900220117             CmdString = 'RmvLible RPGSPDASH' ;
186000220117             #Command(CmdString : %len(%Trim(CmdString))) ;
186100180613
186200220117             CmdString = 'AddLible RPGSPPAYR' ;
186300220117             #Command(CmdString : %len(%Trim(CmdString))) ;
186400180613
186500220117           EndIf;
186600180613
186700180613
186800220117           // Dashboard System
186900220117           //   --  Replace Payroll  with Dashboard
187000220117           if (aoCode = 8 or aoCode = 9) and Payr > 0;
187100220117             CmdString = 'RmvLible RPGSPPAYR' ;
187200220117             #Command(CmdString : %len(%Trim(CmdString))) ;
187300180613
187400220117             CmdString = 'AddLible RPGSPDASH' ;
187500220117             monitor;
187600220117               #Command(CmdString : %len(%Trim(CmdString))) ;
187700220117             on-error;
187800220117             endmon;
187900220117           EndIf;
188000220117         EndIf;
188100180613
188200180613
188300180613
188400220117       end-proc;
188500180613
188600220117       // ----------------------------------------------------------------
188700220117       dcl-Proc getCarrier;
188800191219
188900220117         dcl-f caraccp keyed;
189000191219
189100220117         dcl-ds caraccpdata LikeRec(CARACCR);
189200191219
189300220117         select;
189400210219         when %subst(s1ck#not:1:9) = 'METLIFE-T' or %subst(s1ck#not:1:5)='MET-T'
189500220117         or %subst(s1ck#not:1:5) = 'MET-I';
189600220117           carrier = 1;
189700191219
189800210219         when %subst(s1ck#not:1:8) = 'EYEMED-T' or %subst(s1ck#not:1:5)='EMD-T'
189900220117         or %subst(s1ck#not:1:5) = 'EMD-I';
190000220117           carrier = 2;
190100191219
190200210219         when %subst(s1ck#not:1:5) = 'HUM-T' or %subst(s1ck#not:1:5) = 'HUM-I';
190300220117           carrier = 3;
190400191219
190500220117         when %subst(s1ck#not:1:8) = 'ADVNTI-T' ;
190600220117           carrier = 4;
190700191219
190800220117         when %subst(s1ck#not:1:6) = 'UCCI-T';
190900220117           carrier = 5;
191000191219
191100220117         when %subst(s1ck#not:1:7) = 'AETNA-T';
191200220117           chain ('0000000011': wtrst : wsub# : wacct) caraccr caraccpData;
191300220117           if %found;
191400220117             carrier = 6;
191500220117           endif;
191600191219
191700220117           chain ('0000000127': wtrst : wsub# : wacct) caraccr caraccpData;
191800220117           if %found;
191900220117             carrier = 7;
192000191219           endif;
192100191219
192200210219         when %subst(s1ck#not:1:5) = 'CIGNA-T' or %subst(s1ck#not:1:7) = 'CIG-T'
192300220117         or %subst(s1ck#not:1:5) = 'CIG-I';
192400220117           carrier = 8;
192500191219
192600220117         when %subst(s1ck#not:1:5) = 'VSP-T';
192700220117           carrier = 9;
192800191219
192900220117         when %subst(s1ck#not:1:8) = 'AVESIS-T';
193000220117           carrier = 10;
193100191219
193200220117         when %subst(s1ck#not:1:5) = 'NVA-T';
193300220117           carrier = 11;
193400191219
193500220117         when %subst(s1ck#not:1:8) = 'HGHMRK-T';
193600220117           carrier = 12;
193700191219
193800220117         when %subst(s1ck#not:1:8) = 'GUARDN-T';
193900220117           carrier = 13;
194000191219
194100220117         when %subst(s1ck#not:1:5) = 'DOM-T';
194200220117           carrier = 14;
194300191219
194400220117         when %subst(s1ck#not:1:8) = 'KAISER-T';
194500220117           carrier = 15;
194600191219
194700220117         when %subst(s1ck#not:1:5) = 'CFI-T';
194800220117           carrier = 16;
194900191219
195000220117         when %subst(s1ck#not:1:5)= 'UHC-T' or %subst(s1ck#not:1:5) = 'UHC-I';
195100220117           carrier = 17;
195200191219
195300220117         when %subst(s1ck#not:1:7) = 'DELTA-T';
195400220117           carrier = 18;
195500191219
195600220117         when %subst(s1ck#not:1:5) = 'PRI-T' or %subst(s1ck#not:1:5) = 'PRI-I';
195700220117           carrier = 19;
195800201008
195900220117         when %subst(s1ck#not:1:5) = 'HAR-T' or %subst(s1ck#not:1:5) = 'HAR-I';
196000220117           carrier = 20;
196100201008
196200220117         endsl;
196300191219
196400220117       end-proc;
196500191219
196600220117       // ----------------------------------------------------------------
196700220117       dcl-Proc isBrokerSel Export;
196800200219
196900200219         dcl-pi *N ind End-Pi;
197000200219
197100200219         dcl-s wRelid Char(8);
197200200219         dcl-s rtnValue ind;
197300200219
197400200219         rtnValue = *off;
197500200219
197600200219
197700200219         SqlStmt =
197800220117         'Select distinct cmRelid ' +
197900220117         ' from "F.CMCT14" ' +
198000220117         ' Where cmTrst = ' + %Char(wTrst) +
198100220117         '   and cSubdv = ' + %Char(wSub#) +
198200220117         '   and cmacct = ' + %Char(wacct) +
198300220117         '   and ( cmcan = 0 or cmcan >= ' + %Char(%Dec(%Date)) + ')';
198400200219
198500220217         Exec Sql
198600220217           Declare C2 Cursor For BrokerStmt;
198700220217         Exec Sql
198800220217           Prepare BrokerStmt From :Sqlstmt;
198900220217         Exec Sql
199000220217           Open C2;
199100200219
199200220117         dou SqlCod <> *Zero;
199300220217           Exec Sql
199400220217             Fetch Next From C2
199500220217               Into :wRelid;
199600200219
199700220117           if SqlCod <> *zero;
199800220117             leave;
199900220117           endif;
200000200219
200100220117           if wRelid = '00002243';
200200220117             rtnValue = *on;
200300220117             leave;
200400220117           EndIf;
200500200221
200600200415         //    chain wRelid SmanRlt;
200700200415         //    if %Found( SmanRlt );
200800200415         //
200900200415         //      chain srasid Spragxr2;
201000220117         //      if %Found( Spragxr2 );
201100220117         //        if  sxSuper = '959';
201200220117         //          rtnValue = *on;
201300220117         //          leave;
201400220117         //        EndIf;
201500220117         //      EndIf;
201600220117         //
201700200415         //    EndIf;
201800200221
201900220117         enddo;
202000200219
202100220217         Exec Sql
202200220217           Close C2;
202300200219
202400220117         return rtnValue;
202500200219
202600200219
202700220117       end-proc;
202800200219
202900220117       // ----------------------------------------------------------------
203000220117       dcl-Proc Init;
203100191206
203200191206
203300191206
203400220117         //?User Allowed an Admin?
203500220117         isScanTech = *off;
203600220117         oFunction = '*SCANTECH';
203700220117         oDspErrMsg = 'N';
203800191206
203900220117         ChkFncAuth(@pgmq : oFunction : oDspErrMsg : oContinue);
204000220117         if oContinue = 'Y';
204100220117           isScanTech = *on;
204200220117         endif;
204300191206
204400191206       end-proc;
204500220504
204600220504       // ----------------------------------------------------------------
204700220504       dcl-proc Get_Env;
204800220505
204900220505           OutEnvr = GetEnvironment(' ');
205000220505
205100220505           e1envir = outenvr.e1envir;
205200220505           e1libl  = outenvr.e1libl;
205300220505           Library2 = outenvr.e1lib2;
205400220505           e1acnm  = outenvr.e1acnm;
205500220505           envColor = outenvr.envcolor;
205600220506
205700220506           in company;
205800220506           s1company = company;
205900220505
206000220504       End-Proc;
206100220504
206200220504
