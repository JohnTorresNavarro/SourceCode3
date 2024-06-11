000100210707
000200210607       Ctl-opt option(*nodebugio:*srcstmt:*nounref)   DftActGrp(*no);
000300210607
000400210607      *-------------------------------------------------------------------------
000500210607      *
000600210607      *  Description: Maintain Member Extension File
000700210607      *  Programmer.: Brian Rees
000800210607      *  Date.......: 06/07/2021
000900210607      *
001000210607      *-------------------------------------------------------------------------
001100210607
001200210607      *-------------------------------------------------------------------------
001300210607      *
001400210607      * Declare Files
001500210607      *
001600210607      *-------------------------------------------------------------------------
001700210707       Dcl-f GBS0073d WorkStn
001800210607          Handler('PROFOUNDUI(HANDLER)');
001900210607
002000210607       Dcl-f MemExtp keyed usage( *Input: *output: *Update );
002100210706       Dcl-f Cfs100P keyed usage( *Input: *output: *Update );
002200210607
002300210707       Dcl-f Hist   keyed ExtDesc('F.HIST') ExtFile(*extdesc)
002400210707       usage(*output);
002500210707
002600210607
002700210607
002800210607      *-------------------------------------------------------------------------
002900210607      *
003000210607      * Global Variables
003100210607      *
003200210607      *-------------------------------------------------------------------------
003300210607
003400210607       dcl-ds pgmd
003500210607          ExtName('IOPGMD') PSDS;
003700210607       end-ds;
003800210607
003900210607
004000210706       Dcl-s DepSeq Zoned(2) inz(0);
004100210706       dcl-c  crlf  x'0d25';
004200210706       dcl-s hasError Ind;
004300210706       dcl-s hasWarning Ind;
004400210706
004500210707       dcl-s wTrst Zoned(3);
004600210707       dcl-s wSub# Zoned(3);
004700210707       dcl-s wAcct Zoned(4);
004800210707
004804220211
004805220211       // Origional Values.. Used for Updating History
004900210707       dcl-s s_lname like( s1LName ) ;
005000210707       dcl-s s_fname like( s1fName ) ;
005100210707       dcl-s s_mi  like( s1mi ) ;
005200210707
005300210707       dcl-s s_marsts  like( s1Marsts ) ;
005400210707       dcl-s s_EmpNbr  like( s1EmpNbr ) ;
005500210707       dcl-s s_Loc  like( s1loc ) ;
005600210707       dcl-s s_Dept  like( s1dept ) ;
005700210707       dcl-s s_Rule  like( s1Rule ) ;
005800210707       dcl-s s_RulEff  like( s1RulEff ) ;
005900210707       dcl-s s_occ  like( s1occ ) ;
006000210707       dcl-s s_ljc  like( s1ljc ) ;
006100210707
006200210707       dcl-s s_hours  like( s1hours ) ;
006300210707       dcl-s s_smoke  like( s1smoke ) ;
006400210707       dcl-s s_smkeffdt  like( s1smkeffdt ) ;
006500210707       dcl-s s_eeo  like( s1eeo ) ;
006600210707       dcl-s s_div  like( s1div ) ;
006700210707       dcl-s s_CommSal  like( s1CommSal ) ;
006701220211
006702220211       dcl-s s_Qualevdt  like( s1Qualevdt ) ;
006703220211       dcl-s s_EmpTrdt   like( s1EmpTrdt ) ;
006704220303       dcl-s s_pfq       like( s1pfq ) ;
006800210707
006900210607
006901220211
006902220211
007000210706      *-------------------------------------------------------------------------
007100210706      *
007200210706      * *Entry Procedure
007300210706      *
007400210706      *-------------------------------------------------------------------------
007500210706       Dcl-pr Main ExtPgm;
007600210706         *N  Zoned(9);
007700210706         *N  Char(18);
007800210706         *N  Char(12);
007900210706         *N  Char(1);
008000210707         *N  Char(10);
008100210706       End-Pr;
008200210706
008300210706       dcl-pi Main;
008400210706         pMember Zoned(9);
008500210706         pLast   Char(18);
008600210706         pFirst  Char(12);
008700210706         pMi     Char(1);
008800210707         pTSA    Char(10);
008900210706       End-Pi;
009000210607
009100210607
009200210607      *-------------------------------------------------------------------------
009300210607      *
009400210607      * Mainline Program
009500210607      *
009600210607      *-------------------------------------------------------------------------
009700210607
009800210706
009801220211       wTrst = %Dec( %Subst( pTSA : 1 : 3) : 3 : 0 );
009802220211       wSub# = %Dec( %Subst( pTSA : 4 : 3) : 3 : 0 );
009803220211       wAcct = %Dec( %Subst( pTSA : 7 : 4) : 4 : 0 );
009804220211
009901220211
010000210706       Load_Screen();
010100210706
010200210706
010300210706       dou btnExit = *on;
010400210706
010500210707         exfmt Screen1;
010600210707
010700210707
010800210706         if btnExit = *on;
010900210706           leave;
011000210706         EndIf;
011100210706
011200210707         // Reset
011300210706         hasError = *off;
011400210706         hasWarning = *off;
011500210707         errSmokeDt = *off;
011600210707         errRuleDt = *off;
011700210706
011800210706
011900210707
012000210707         //----------------------------------------------
012100210707         //
012200210707         // Accept Button - Process Data.
012300210707         //
012400210707         //----------------------------------------------
012500210706         if btnAccept = *on;
012600210706
012700210707
012800210707           //------------------------
012900210707           // Valadition...
013000210707           //------------------------
013100210707           Validation();
013200210707
013300210707           if hasError;
013400210707             iter;
013500210707           EndIf;
013600210707
013700210707
013800210707
013900210706           //------------------------
014000210707           // Soft Valadition...
014100210706           //------------------------
014200210706           Soft_Validation();
014300210706
014400210707           if hasWarning;
014500210707
014600210707
014700210707             Exfmt Screen2;
014800210707
014900210707             if btnOk = *on;
015000210707             // Continue...
015100210707             EndIf;
015200210707
015300210707
015400210707             if BtnCancel = *on;
015500210707               btnCancel = *off;
015600210707               iter;
015700210707             EndIf;
015800210707
015900210706           EndIf;
016000210706
016100210706
016200210706
016300210707           //------------------------
016400210707           // Continue Updating...
016500210707           //------------------------
016600210707           chain pMember MemExtp;
016700210706
016800210706           meMgs = s1Marsts ;
016900210706           meEmpNbr = s1EmpNbr;
017000210706           meLoc = s1Loc;
017100210706           meDept = s1Dept;
017200210706           merule = s1Rule;
017300220303           mepfq = s1pfq;
017301220303
017400210707           if s1Rule <> s_Rule;
017500210707             meRulChgd = %Dec(%Date);
017600210707             meRulChgu = wqUsrn;
017700210707           EndIf;
017800210707
017900210707
018000210706           meHrs = s1Hours;
018100210706           meDiv = s1Div;
018200210707           meocc = s1occ;
018300210706           meljc =  s1ljc;
018400210706
018500210707           if s1RulEff > '';
018600210707             meRulEff = %dec(%char(%date(s1RulEff:*usa/):*iso0):8:0);
018700210706           EndIf;
018800210706
018900210706           meSmoke = s1Smoke;
019000210706
019100210706           if s1SmkEffDt > '';
019200210706             meSmkEffDt = %dec(%char(%date(s1SmkEffDt:*usa/):*iso0):8:0);
019300210706           EndIf;
019400210706
019500210706           meCommSal = s1CommSal;
019600210706           meEeo = s1Eeo;
019700210706
019701220211
019702220211           if s1QualEvdt > '';
019703220211             meQualEvdt = %dec(%char(%date(s1QualEvdt:*usa/):*iso0):8:0);
019704220211           EndIf;
019705220211
019706220211
019707220211           if s1EmpTrDt > '';
019708220211             meEmpTrDt = %dec(%char(%date(s1EmpTrDt:*usa/):*iso0):8:0);
019709220211           EndIf;
019710220211
019800210706
019900210706           if %Found( MemExtp ) ;
020000210706
020100210706             update r_MemExtp;
020200210706           else;
020300210706
020400210706             messno = pMember;
020500210706             write r_MemExtp;
020600210706           EndIf;
020700210706
020800210706           unlock MemExtp;
020900210706         endif;
021000210706
021100210707
021200210707         WriteHist();
021300210707
021400210707         leave;
021500210707
021600210706       EndDo;
021700210706
021800210706
021900210706
022000210607
022100210607
022200210706       *inlr = *on;
022300210706
022400210706
024200210706
024300210706      *-------------------------------------------------------------------------
024400210706      *
024500210706      * Load Screen
024600210706      *
024700210706      *-------------------------------------------------------------------------
024800210706
024900210706       dcl-Proc Load_Screen;
025000210706
025100210706         Clear Screen1;
025200210706
025300210706         s1ssno = pMember;
025400210706         s1lName = pLast;
025500210706         s1fName = pFirst;
025600210706         s1mi = pmi;
025700210706
025800210706
025900210706         chain(N) pMember MemExtp;
026000210706         if %Found( MemExtp ) ;
026100210706
026200210706           s1Marsts = meMgs;
026300210706           s1EmpNbr = meEmpNbr;
026400210706           s1Loc = meLoc;
026500210706           s1Dept = meDept;
026600210706           s1rule = meRule;
026700210706
026800210706           s1Hours = meHrs;
026900210706           s1Div = meDiv;
027000210707           s1occ = meocc;
027100210706           s1ljc =  meljc;
027200220303             s1pfq = mepfq;
027300210706
027400210707           s1RulEff = '';
027500210707           if meRulEff > 0;
027600210707             test(de) *iso meRulEff;
027700210706             if %Error;
027800210707               s1RulEff = %Char(meRulEff);
027900210706             else;
028000210707               s1RulEff = %Char(%date(meRulEff) :*usa);
028100210706             endif;
028200210706           endif;
028300210706
028400210706
028500210706
028600210706           s1Smoke = meSmoke;
028700210706
028800210706           s1SmkEffDt = '';
028900210706           if meSmkEffDt > 0;
029000210706             test(de) *iso meSmkEffDt;
029100210706             if %Error;
029200210706               s1SmkEffDt = %Char(meSmkEffDt);
029300210706             else;
029400210707               s1SmkEffDt = %Char(%date(meSmkEffDt) :*usa);
029500210706             endif;
029600210706           endif;
029700210706
029800210706
029900210706           s1CommSal = meCommSal;
030000210706           s1Eeo = meEeo;
030100210706
030200210707           s1SalChDt = '';
030300210707           if meSalDt > 0;
030400210707             test(de) *iso meSalDt;
030500210707             if %Error;
030600210707               s1SalChDt = %Char(meSalDt);
030700210707             else;
030800210707               s1SalChDt = %Char(%date(meSalDt) :*usa);
030900210707             endif;
031000210707           endif;
031101220211
031102220211
031103220211           s1QualEvdt = '';
031104220211           if meQualEvdt > 0;
031105220211             test(de) *iso meQualEvdt;
031106220211             if %Error;
031107220211               s1QualEvdt = %Char(meQualEvdt);
031108220211             else;
031109220211               s1QualEvdt = %Char(%date(meQualEvdt) :*usa);
031110220211             endif;
031111220211           endif;
031112220211
031113220211
031114220211           s1EmpTrdt = '';
031115220211           if meEmpTrdt > 0;
031116220211             test(de) *iso meEmpTrdt;
031117220211             if %Error;
031118220211               s1EmpTrdt = %Char(meEmpTrdt);
031119220211             else;
031120220211               s1EmpTrdt = %Char(%date(meEmpTrdt) :*usa);
031121220211             endif;
031122220211           endif;
031200210707
031300210706         EndIf;
031400210706
031500210706
031600210706
031700210706         //----------------------------------------------------
031800210706         //
031900210706         //  Check for Long Name
032000210706         //
032100210706         //----------------------------------------------------
032200210706
032300210706         chain(n) ( pMember : DepSeq ) Cfs100p;
032400210706         if %Found( Cfs100p ) ;
032500210706
032600210706           s1lName = cfslst;
032700210706           s1fName = cfsfst;
032800210706           s1mi = cfsmid;
032900210706
033000210706         EndIf;
033100210706
033200210706
033300210707
033400210707         //----------------------------------------------------
033500210707         //
033600210707         //  Load Saved Values
033700210707         //
033800210707         //----------------------------------------------------
033900210707
034000210707         s_lname =  s1LName;
034100210707         s_fname =  s1fName;
034200210707         s_mi =  s1mi;
034300210707
034400210707         s_marsts = s1Marsts;
034500210707         s_EmpNbr = s1EmpNbr;
034600210707         s_Loc   = s1loc;
034700210707         s_Dept  = s1dept;
034800210707         s_Rule  = s1Rule;
034900210707         s_RulEff = s1RulEff;
035000210707         s_occ = s1occ;
035100210707         s_ljc = s1ljc;
035200210707
035300210707         s_hours = s1hours;
035400210707         s_smoke = s1smoke;
035500210707         s_smkeffdt = s1smkeffdt;
035600210707         s_eeo =  s1eeo;
035700210707         s_div =  s1div;
035800210707         s_CommSal = s1CommSal;
035900210707
036000220211         s_EmpTrdt = s1EmpTrdt;
036001220211         s_QualEvdt = s1QualEvdt;
036002220303         s_pfq = s1pfq;
036003220211
036100210706       End-Proc;
036200210706
036300210706
036400210706
036500210706
036600210706
036700210706      *-------------------------------------------------------------------------
036800210706      *
036900210706      * Soft Validation
037000210706      *
037100210706      *-------------------------------------------------------------------------
037200210706
037300210706       dcl-Proc Soft_Validation;
037400210706
037500210706
037600210706         dcl-s First Char(1) inz('Y');
037700210706
037800210706         wMessage = '';
037900210706
038000210706
038100210706         //----------------------------------------------------
038200210706         //
038300210706         //   Check Hours Worked. Soft Edit.
038400210706         //
038500210706         //----------------------------------------------------
038600210706         if s1Hours = 0;
038700210706
038800210706           hasWarning = *on;
038900210706           if First = 'Y';
039000210706             First = 'N';
039100210706             wMessage = 'Hours Worked should have a value.';
039200210706           else;
039300210706             wMessage = %Trim(wMessage ) + crlf +
039400210706             'Hours Worked should have a value.' ;
039500210706
039600210706           endif;
039700210706
039800210706         EndIf;
039900210706
040000210706
040100210706
040200210706         //----------------------------------------------------
040300210706         //
040400210706         //   Check Job Title. Soft Edit.
040500210706         //
040600210706         //----------------------------------------------------
040700210706         if s1Occ = '';
040800210706
040900210706           hasWarning = *on;
041000210706           if First = 'Y';
041100210706             First = 'N';
041200210706             wMessage = 'Job title is blank.';
041300210706           else;
041400210706             wMessage = %Trim(wMessage ) + crlf +
041500210706             'Job title is blank.' ;
041600210706
041700210706           endif;
041800210706
041900210706         EndIf;
042000210706
042100210706
042200210706       End-Proc;
042300210706
042400210706
042500210706      *-------------------------------------------------------------------------
042600210706      *
042700210706      *  Validation
042800210706      *
042900210706      *-------------------------------------------------------------------------
043000210706
043100210706       dcl-Proc Validation;
043200210706
043300210706
043400210707         // Rule Date must be filled in when a Rule is selected.
043500210707         if s1RulEff = '' and s1Rule > '';
043600210707           hasError = *on;
043700210707           errRuleDt = *on;
043800210707         endif;
043900210706
044000210706
044100210707         // Smoker Effective Date must be filled in when Smoker is selected.
044200210707         if s1SmkEffDt = '' and s1Smoke = 'Y';
044300210707           hasError = *on;
044400210707           errSmokeDt = *on;
044500210707         endif;
044600210706
044700210706
044800210706
044900210706       End-Proc;
045000210707
045100210707
045200210707       // ----------------------------------------------------------------
045300210707       dcl-proc WriteHist;
045400210707
045500210707
045600210707         //?Setup Defaults
045700210707         hkey = ' ' + %editc(pMember : 'X') ;
045800210707         hPrgnm = 'GBS0073R';
045900210707         trDate = %Dec(%Date);
046000210707         hsTrst = wtrst;
046100210707         hsSub# = wSub#;
046200210707         hsAcct = wAcct;
046300210707         hsDltd = 'A';
046400210707         hstrTime = %Time;
046500210707         hOper =  WQUSRN;
046600210707         covtdt = %Dec(%Date);
046700210707
046800210707
046900210707         // Last Name
047000210707         if s_lname <> s1lname;
047100210707           trCode = 'M01';
047200210707           ck#Not = s_lname;
047300210707           note2 = s1lname;
047400210707           write histr;
047500210707         EndIf;
047600210707
047700210707
047800210707         // First Name
047900210707         if s_fname <> s1fname;
048000210707           trCode = 'M02';
048100210707           ck#Not = s_fname;
048200210707           note2 = s1fname;
048300210707           write histr;
048400210707         EndIf;
048500210707
048600210707
048700210707         // Middle Init
048800210707         if s_mi <> s1mi;
048900210707           trCode = 'M03';
049000210707           ck#Not = s_mi;
049100210707           note2 = s1mi;
049200210707           write histr;
049300210707         EndIf;
049400210707
049500210707
049600210707         // Marital Status
049700210707         if s_marsts <> s1marsts;
049800210707           trCode = 'M86';
049900210707           ck#Not = s_marsts;
050000210707           note2 = s1marsts;
050100210707           write histr;
050200210707         EndIf;
050300210707
050400210707
050500210707         // Employee Number
050600210707         if s_EmpNbr <> s1EmpNbr;
050700210707           trCode = 'MAP';
050800210707           ck#Not = s_EmpNbr;
050900210707           note2 = s1EmpNbr;
051000210707           write histr;
051100210707         EndIf;
051200210707
051300210707
051400210707         // Location
051500210707         if s_Loc <> s1Loc;
051600210707           trCode = 'MAQ';
051700210707           ck#Not = s_Loc;
051800210707           note2 = s1Loc;
051900210707           write histr;
052000210707         EndIf;
052100210707
052200210707
052300210707         // Department
052400210707         if s_Dept <> s1Dept;
052500210707           trCode = 'M89';
052600210707           ck#Not = s_Dept;
052700210707           note2 = s1Dept;
052800210707           write histr;
052900210707         EndIf;
053000210707
053100210707
053200210707         // Rule
053300210707         if s_Rule <> s1Rule;
053400210707           trCode = 'M88';
053500210707           ck#Not = s_Rule;
053600210707           note2 = s1Rule;
053700210707           write histr;
053800210707         EndIf;
053900210707
054000210707
054100210707         // Rule Change Date
054200210707         if s_RulEff <> s1RulEff;
054300210707           trCode = 'MAR';
054400210707           ck#Not = s_RulEff;
054500210707           note2 = s1RulEff;
054600210707           write histr;
054700210707         EndIf;
054800210707
054900210707
055000210707         // Job Title
055100210707         if s_occ <> s1occ;
055200210707           trCode = 'MAS';
055300210707           ck#Not = s_occ;
055400210707           note2 = s1occ;
055500210707           write histr;
055600210707         EndIf;
055700210707
055800210707
055900210707         // Labor/ Job Code
056000210707         if s_ljc <> s1ljc;
056100210707           trCode = 'M87';
056200210707           ck#Not = s_ljc;
056300210707           note2 = s1ljc;
056400210707           write histr;
056500210707         EndIf;
056600210707
056700210707
056800210707         // Hours
056900210707         if s_hours <> s1hours;
057000210707           trCode = 'MAL';
057100210707           ck#Not = %char(s_hours);
057200210707           note2 = %Char(s1hours);
057300210707           write histr;
057400210707         EndIf;
057500210707
057600210707
057700210707         // Smoker
057800210707         if s_smoke <> s1smoke;
057900210707           trCode = 'MSF';
058000210707           ck#Not = s_smoke;
058100210707           note2 = s1smoke;
058200210707           write histr;
058300210707         EndIf;
058400210707
058500210707
058600210707         // Smoker Effective Date
058700210707         if s_smkeffdt <> s1smkeffdt;
058800210707           trCode = 'MSD';
058900210707           ck#Not = s_smkeffdt;
059000210707           note2 = s1smkeffdt;
059100210707           write histr;
059200210707         EndIf;
059300210707
059400210707
059500210707         // EEO Code
059600210707         if s_eeo <> s1eeo;
059700210707           trCode = 'MAJ';
059800210707           ck#Not = s_eeo;
059900210707           note2 = s1eeo;
060000210707           write histr;
060100210707         EndIf;
060200210707
060300210707
060400210707         // Division
060500210707         if s_div <> s1div;
060600210707           trCode = 'MAT';
060700210707           ck#Not = s_div;
060800210707           note2 = s1div;
060900210707           write histr;
061000210707         EndIf;
061100210707
061200210707
061300210707         // Commission / Salary
061400210707         if s_commSal <> s1commSal;
061500210707           trCode = 'MAU';
061600210707           ck#Not = s_commSal;
061700210707           note2 = s1commSal;
061800210707           write histr;
061900210707         EndIf;
062000210707
062001220211
062002220211         // Qualified Event Date
062003220211         if s_QualEvdt <> s1QualEvdt;
062004220211           trCode = 'M79';
062005220211           ck#Not = s_QualEvdt;
062006220211           note2 = s1QualEvdt;
062007220211           write histr;
062008220211         EndIf;
062009220211
062010220211
062011220211         // Employment Term Date
062012220211         if s_EmpTrDt <> s1EmpTrDt;
062013220211           trCode = 'M78';
062014220211           ck#Not = s_EmpTrDt;
062015220211           note2 = s1EmpTrDt;
062016220211           write histr;
062017220211         EndIf;
062100210707
062101220303
062102220303         // Pay Frequency
062103220303         if s_pfq <> s1pfq;
062104220303           trCode = 'MAK';
062105220303           ck#Not = s_pfq;
062106220303           note2 = s1pfq;
062107220303           write histr;
062108220303         EndIf;
062109220303
062200210707       end-proc;
062300210707
