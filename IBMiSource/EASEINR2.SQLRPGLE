000100210728       Ctl-opt option(*noDebugIo)   bnddir('GBSBIND') DftActGrp(*no);
000200191104
000300191104      *-------------------------------------------------------------------------
000400191104      *
000500200825      *  Description: EASE Inbound File to GBS File.
000600191104      *  Programmer.: Brian Rees
000700200825      *  Date.......: 08/25/2020
000800191104      *
000900191104      *-------------------------------------------------------------------------
001000210725      * Modifications:
001100210725      *
001200210725      * 07/25/20201  B.Rees   Changed COBRA Logic.
001300210826      * 8/26/2021    b.Rees   Added Omitted Plans Logic
001400210826      *    Maintenance Program:  GBS0076R
001500211207      * 12/07/2021   B.Rees   Writing ALL Classes to the EASE Class Table
001600211207      *   This will be used for the GBS Class xRef.
001700211223      * 12/23/2021   B.Rees   added 'Base + Bonus + Commission'  to EarnBased
001800210725      *
001900220125      * 1/25/2022   B.Rees  Renamed this to EASEINR2 for the 2.0 format.
002000220125      *
002100210725      *-------------------------------------------------------------------------
002200191104
002300191104      *-------------------------------------------------------------------------
002400191104      *
002500210826      * Declare Files
002600191104      *
002700191104      *-------------------------------------------------------------------------
002800200825       dcl-f EaseInp keyed;
002900200826       dcl-f EaseQE  keyed usage(*input:*output);
003000200828       dcl-f EasePlan keyed usage(*input:*output);
003100200908       dcl-f EaseClas keyed usage(*input:*output);
003200201109       dcl-f EaseCost keyed usage(*input:*output);
003300201103       dcl-f AccMst  keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
003400201103
003500200826       dcl-f gbs20p keyed usage( *output );
003600201103       dcl-f EaseEOI Keyed usage(*input:*output:*update:*Delete);
003700201216       dcl-f EaseWaive Keyed usage(*input:*output:*update:*Delete);
003800210826       dcl-f EaseOmit keyed;
003900200825
004000191104      *-------------------------------------------------------------------------
004100191104      *
004200191104      * Global Variables
004300191104      *
004400191104      *-------------------------------------------------------------------------
004500191104       dcl-ds pgmd
004600191104          ExtName('IOPGMD') PSDS;
004700191104         @pgmq *proc;
004800191104       end-ds;
004900191104
005000200825       dcl-s firstTime Char(1) inz('Y');
005100201103       dcl-s wtrst  Zoned(3) inz;
005200201103       dcl-s wSub#  Zoned(3) inz;
005300201103       dcl-s wAcct  Zoned(4) inz;
005400200826       dcl-s sav_Empssn like( e_Empssn ) inz;
005500200901
005600200901       dcl-s sav_fname like( e_Fname);
005700200901       dcl-s sav_Dssn  like( e_ssn );
005800200901       dcl-s sav_Birth like( e_birth );
005900201103       dcl-s EOI_Amount Char(12);
006000201103       dcl-s hasEOI Ind;
006100201103
006200200901       dcl-s wSeq Zoned(5);
006300201122       dcl-s pos zoned(5);
006400210211
006500210211       dcl-s Cont Char(1);
006600210211       dcl-c q '''';
006700200825
006800210826       dcl-s Skip_Plan ind;
006900210826
007000200826       dcl-ds Rcd01 ExtName('GBS20L1') End-DS;
007100200826       dcl-ds Rcd02 ExtName('GBS20L2') End-DS;
007200200826       dcl-ds Rcd03 ExtName('GBS20L3') End-DS;
007300200826       dcl-ds Rcd04 ExtName('GBS20L4') End-DS;
007400191104      *--------------------------------------------
007500191104      *
007600191104      * Procedures
007700191104      *
007800191104      *--------------------------------------------
007900191104       /include *LIBL/QMODSRC,#COMMANDPR         // Command
008000200825       /include GBSPGM/QMODSRC,#GettokPR
008100200902       /include GBSPGM/QMODSRC,PR0001RPR        // Case Functions
008200200825
008300200825       dcl-pr zFill Char(100);
008400200825         len Zoned(3) value;
008500200825         text Char(100) value;
008600200825       End-Pr;
008700200825
008800200825       dcl-pr fmtDate Char(8);
008900200825         iDate Char(10) value;
009000200825       End-Pr;
009100200825
009200200825       dcl-pr StripPhone Char(10);
009300200825         iText Char(20) value;
009400200825       End-Pr;
009500191104
009600191104
009700201103       dcl-pr CleanNumber Char(20);
009800201103         iText Char(20) value;
009900201103       End-Pr;
010000201103
010100200902       dcl-pr get_relat Char(1);
010200200902         iRelcode Char(20) value;
010300200902         iGender  Char(1)  value;
010400200902       End-Pr;
010500200902
010600191104      *-------------------------------------------------------------------------
010700191104      *
010800191104      * *Entry Procedure
010900191104      *
011000191104      *-------------------------------------------------------------------------
011100191104
011200201103       Dcl-pr Main ExtPgm;
011300201103         *N  Char(20);
011400201103       End-Pr;
011500201103
011600201103       dcl-pi Main;
011700201103         pGroup Char(20);
011800201103       End-Pi;
011900200825
012000200825
012100191104      *-------------------------------------------------------------------------
012200191104      *
012300191104      * Mainline Program
012400191104      *
012500200902      *-------------------------------------------------------------------------
012600200902
012700211207       Exec Sql
012800211207         Set Option Commit = *NONE, Naming = *SYS;
012900200902
013000210211
013100210211       // Make sure only one company in the file.
013200210211       Check_Company();
013300210211
013400210211       if Cont = 'Y';
013500210211         ReadFile();
013600210211       EndIf;
013700200825
013800200825
013900191104
014000191104       *inlr = *on;
014100200825
014200210211      *-------------------------------------------------------------------------
014300210211       dcl-proc ReadFile;
014400210211
014500210211
014600210211
014700210211         Setll *start EaseInp;
014800210211
014900210211         Dou %Eof(EaseInp);
015000210211           read EaseInp;
015100210211
015200210211           if %eof(EaseInp);
015300210211             leave;
015400210211           endif;
015500210211
015600210211           if e_Elecstat = 'Waived';
015700210211           //  iter;
015800210211           EndIf;
015900210211
016000210211           if uCase(e_lName) = 'TEST' or
016100210211             uCase(e_lName) = 'GBSCUSTOMERSERVICETEST';
016200210211             iter;
016300210211           EndIf;
016400210211
016500210826
016600210826
016700210211           if firstTime = 'Y';
016800210211             // Get the Account Number.
016900210211             wTrst = %Dec(%Subst(pGroup:1:3):3:0);
017000210211             wSub# = %Dec(%Subst(pGroup:4:3):3:0);
017100210211             wAcct = %Dec(%Subst(pGroup:7:4):4:0);
017200210211
017300210211             firstTime = 'N';
017400210211
017500210211           EndIf;
017600210211
017700210211
017800210826           // Check to see if we need to Omit any plans.
017900211207           skip_Plan = *off;
018000210826
018100211207           Setll ( wTrst : wSub# : wAcct: %upper(e_PlanAdmn) ) EaseOmit;
018200210826
018300211207           Dou %Eof(EaseOmit);
018400211207             reade ( wTrst : wSub# : wAcct: %upper(e_PlanAdmn) ) EaseOmit;
018500211207             if %eof(EaseOmit);
018600211207               leave;
018700211207             endif;
018800210826
018900211207             if (j_StrDate <= %Dec(%Date))  and
019000211207                ( (j_EndDate = 0) or (j_EndDate >= %Dec(%Date)))  ;
019100210826
019200211207               skip_Plan = *on;
019300210826
019400211207             EndIf;
019500210826
019600211207           Enddo;
019700210826
019800211207           if Skip_Plan;
019900211207             iter;
020000211207           EndIf;
020100210826
020200210826
020300210826
020400210826
020500210826
020600210826
020700210211           if e_Empssn <> Sav_EmpSSn;
020800210211             Load_Member();
020900210211             sav_Empssn = e_Empssn;
021000210211
021100210211             sav_fname = '';
021200210211             sav_dssn = '';
021300210211             sav_Birth = '';
021400210211
021500210211             Clear_Waive();
021600210211           endif;
021700210211
021800210211           if e_Relat = 'Employee';
021900210211
022000210211             //-----------------------
022100210211             //
022200210211             // Get Plans
022300210211             //
022400210211             //-----------------------
022500210211             if e_ElecStat <> 'Waived';
022600210211               Get_Mbr_Plans();
022700210211             else;
022800210211               Get_Waive();
022900210702             //Get_Waive_New();
023000210211             endif;
023100210211
023200210211
023300210211
023400210211           EndIf;
023500210211
023600210211
023700210211           // Dependents
023800210211           if e_Relat <> 'Employee';
023900210211
024000210211             if sav_fname <> e_fname or
024100210211                sav_dssn <> e_ssn or
024200210211                sav_Birth <> e_birth;
024300210211
024400210211               Load_Dependent();
024500210211
024600210211               sav_fname = e_Fname;
024700210211               sav_dssn = e_ssn;
024800210211               sav_birth = e_birth;
024900210211
025000210211             EndIf;
025100210211
025200210211             //-----------------------
025300210211             //
025400210211             // Get Plans
025500210211             //
025600210211             //-----------------------
025700210211             if e_ElecStat <> 'Waived';
025800210211               Get_Dep_Plans();
025900210211             else;
026000210211               Get_Waive();
026100210708             // Get_Waive_New();
026200210211             endif;
026300210211
026400210211
026500210211
026600210211           EndIf;
026700210211
026800210211
026900210211
027000210211         Enddo;
027100210211
027200210211       End-Proc;
027300210211
027400200825      *-------------------------------------------------------------------------
027500200901       dcl-proc Load_Member;
027600200826
027700210228         dcl-s wSalary Zoned(11:2);
027800210228         dcl-s wHours Zoned(5);
027900210228         dcl-s Weeks Zoned(2) inz(52);
028000210228
028100210228
028200210228
028300210228
028400200826         Clear Rcd01;
028500200825         Rcd1 = '1';
028600200825
028700200825         l1_ssn = zFill(9: %scanRpl('-':'':e_Empssn));
028800200825         l1_FName = e_FName;
028900200825         l1_mi = e_mi;
029000200825         l1_lname = e_lname;
029100200825         l1_Addr1 = e_Addr1;
029200200825         l1_Addr2 = e_Addr2;
029300200825
029400200825         l1_City = e_City;
029500200825
029600200825
029700211207         exec sql
029800211207           select stcode
029900211207             into :l1_State
030000211207             from statecd
030100211207             where stName = upper(:e_State);
030200200825
030300200825         l1_zip = e_Zip;
030400200826         l1_Phone = StripPhone( e_Phone_p );   // ( e_Phone_M )
030500200825         l1_gender = %SubSt( e_sex :1:1);
030600200825         l1_dob = fmtDate( e_Birth );
030700200826
030800200826
030900200826         // Hire Date..
031000200826         // AllHire is the "ReHire" Date
031100200918         if e_HireDt > '';
031200201103           l1_doh = fmtDate( e_HireDt );
031300200918         endif;
031400200918
031500200918         if e_AllHire > '' and e_HireDt > '';
031600201103           if %Dec(fmtDate(e_AllHire):8:0) >=
031700201103              %Dec(fmtDate(e_HireDt):8:0) ;
031800201103             l1_doh = fmtDate( e_AllHire );
031900201103           EndIf;
032000200918         EndIf;
032100200825
032200200825
032300211207         exec sql
032400211207           select pcCode
032500211207             into :l1_MarSts
032600211207             from webpaychp
032700211207             where pcTrst = 0 and
032800211207                   pcSub# = 0 and
032900211207                   pcAcct = 0 and
033000211207                   pcGrpr = 'MARSTAT' and
033100211207                   upper(pcDesc) = upper(:e_Marsts);
033200200825
033300200825
033400200825         l1_sal = %ScanRpl('$':'':e_Compen);
033500200826         l1_sal = %ScanRpl(',':'':l1_sal);
033600200825
033700210228
033800210228         if e_CompType = 'Hourly' and E_SCHDHRS > '';
033900210708           wSalary = %Dec( l1_Sal : 11 : 2 );
034000210228
034100210228
034200210708           if wSalary <= 500;
034300210708             wHours = %Dec(e_SchdHrs : 5 : 0 );
034400210708             wSalary = wSalary * wHours * Weeks;
034500210708             l1_Sal = %Char( wSalary );
034600210708           endif;
034700210228
034800210228         EndIf;
034900210228
035000210228
035100210228
035200200825         l1_termDt = fmtDate( e_TermDt );
035300200825         l1_doc =  fmtdate( e_CompStrt );
035400200826
035500210725
035600210725         // COBRA Start Date is Turned on..
035700210726         if fmtDate( e_Cobstdt ) <= %Char(%Dec(%Date))
035800210726            and e_Cobstdt > '';
035900210725
036000210725           l1_COBRA = 'Y';
036100210725
036200210725           // COBRA Ended.
036300210725           if fmtDate( e_Cobeddt ) < %Char(%Dec(%Date))  and
036400210725             e_Cobeddt > '';
036500210725             l1_COBRA = '';
036600210725           endif;
036700210725
036800210725         endif;
036900200826
037000200826
037100200903
037200200903         //-----------------------------------------------------
037300200903         // Job Class ( Rule )
037400200903         // If the Job Class is longer than 5 characters,
037500200903         // write to the EASECLAS File.
037600200903         //-----------------------------------------------------
037700200908         if %Len(%Trim(e_JobClas)) <= 5;
037800200908           l1_Class = e_JobClas;
037900211207
038000211207
038100211207           // Still Write to the Ease Class File.
038200211207           if %Len(%Trim(e_JobClas)) > 0;
038300211207
038400211207             chain (wTrst:wSub#:wAcct: e_JobClas) EaseClas;
038500211207             if not %Found( EaseClas );
038600211207               // Add a record to EaseClas
038700211207               wSeq = 0;
038800211207
038900211207               exec sql
039000211207                 select max(c_Seq)
039100211207                   into :wSeq
039200211207                   from EaseClas
039300211207                   where c_Trst = :wTrst and
039400211207                         c_Sub# = :wSub# and
039500211207                         c_Acct = :wAcct;
039600211207
039700211207
039800211207               c_trst = wtrst;
039900211207               c_Sub# = wSub#;
040000211207               c_Acct = wAcct;
040100211207
040200211207               c_Seq = wSeq + 1;
040300211207               c_Code = '';
040400211207               c_Descr = e_JobClas;
040500211207               write r_easeClas;
040600211207             endif;
040700211207           endif;
040800211207
040900211207
041000211207
041100211207
041200211207
041300200903         else;
041400200908           chain (wTrst:wSub#:wAcct: e_JobClas) EaseClas;
041500200908           if %Found( easeClas );
041600200908             l1_Class = c_Code;
041700200903           else;
041800200903
041900200908             // Add a record to EaseClas
042000200903             wSeq = 0;
042100200903
042200211207             exec sql
042300211207               select max(c_Seq)
042400211207                 into :wSeq
042500211207                 from EaseClas
042600211207                 where c_Trst = :wTrst and
042700211207                       c_Sub# = :wSub# and
042800211207                       c_Acct = :wAcct;
042900200903
043000200908
043100200908             c_trst = wtrst;
043200200908             c_Sub# = wSub#;
043300200908             c_Acct = wAcct;
043400200908
043500200908             c_Seq = wSeq + 1;
043600200908             c_Code = '^' + %editc(c_seq:'X');
043700200908             c_Descr = e_JobClas;
043800200908             write r_easeClas;
043900200903
044000200908             l1_Class = c_code;
044100200903
044200200903           EndIf;
044300200903
044400200903
044500200903         EndIf;
044600200903
044700200903
044800201105         //-----------------------------------------------------
044900201105         // Cost Center
045000201105         // If the Cost Center is longer than 20 Characters
045100201105         // write to the EASECOST File.
045200201105         //-----------------------------------------------------
045300201105         if %Len(%Trim(e_Div)) <= 20;
045400201109           l1_CostCtr = e_Div;
045500201105         else;
045600201105           chain (wTrst:wSub#:wAcct: e_Div) EaseCost;
045700201105           if %Found( easeCost );
045800201109             l1_CostCtr = d_Code;
045900201105           else;
046000201105
046100201105             // Add a record to EaseClas
046200201105             wSeq = 0;
046300201105
046400211207             exec sql
046500211207               select max(d_Seq)
046600211207                 into :wSeq
046700211207                 from EaseCost
046800211207                 where d_Trst = :wTrst and
046900211207                       d_Sub# = :wSub# and
047000211207                       d_Acct = :wAcct;
047100201105
047200201105
047300201105             d_trst = wtrst;
047400201105             d_Sub# = wSub#;
047500201105             d_Acct = wAcct;
047600201105
047700201105             d_Seq = wSeq + 1;
047800210317             d_Code = 'EASE_CC_' + %editc(d_seq:'X');
047900201105             d_Descr = e_Div;
048000201105             write r_easeCost;
048100201105
048200201105             l1_CostCtr = d_code;
048300201105
048400201105           EndIf;
048500201105
048600201105
048700201105         EndIf;
048800201105
048900200903
049000200826         // l1_TermRsn =
049100200903         l1_FullLoc = e_location;
049200200826
049300200826
049400200826         //-----------------------------------------------------
049500200826         // Qualifying Event.
049600200826         // If the inbound event is longer than 15 characters,
049700200826         // write to the EASEQE File.
049800200826         //-----------------------------------------------------
049900200826         if %Len(%Trim(e_qeEvent)) <= 15;
050000200826           l1_QualEvt = e_qeEvent;
050100200826         else;
050200200826           chain e_qeEvent easeqe;
050300200826           if %Found( easeQe );
050400200826             l1_QualEvt = q_Code;
050500200826           else;
050600200826
050700200826             // Add a record to EaseQE
050800200826             wSeq = 0;
050900200826
051000211207             exec sql
051100211207               select max(Q_Seq)
051200211207                 into :wSeq
051300211207                 from EaseQe;
051400200826
051500200826             q_Seq = wSeq + 1;
051600200826             q_Code = 'EASE_QE_' + %editc(q_seq:'X');
051700200826             q_Descr = e_qeEvent;
051800200826             write r_easeQe;
051900200826
052000200826             l1_QualEvt = q_code;
052100200826
052200200826           EndIf;
052300200826
052400200826
052500200826         EndIf;
052600200826
052700201123         // Personal or Work    ( e_Email )
052800201123         l1_Email = e_Email_p;
052900201123         if l1_Email = '';
053000201123           l1_Email = e_Email;   // Work Email.
053100201123         EndIf;
053200201123
053300201123
053400200825         l1_Smoker = e_Smoke;
053500200825
053600200825
053700200825         if e_Media_A > '' or
053800200826            e_Media_B > '' or
053900200826            e_Media_C > '' or
054000200826            e_Media_D > '';
054100200825
054200200825           l1_MedEnrl = 'Y';
054300200825         endif;
054400200825
054500200825         l1_MediCar = e_mediaclm;
054600200826         l1_qeDate = fmtDate( e_qeEvtdt );
054700200825
054800200902         Rcd = ucase(Rcd01);
054900200826         write r_gbs20p;
055000200825
055100200825
055200200825
055300200825
055400200825       End-Proc;
055500200825
055600200825
055700200825
055800200901      *-------------------------------------------------------------------------
055900200901       dcl-proc Load_Dependent;
056000200901
056100200901         Clear Rcd03;
056200200902         Rcd3 = '3';
056300200901
056400200902         l3_PartSsn = zFill(9: %scanRpl('-':'':e_Empssn));
056500200901         l3_FName = e_FName;
056600200901         l3_mi = e_mi;
056700200901         l3_lname = e_lname;
056800200901         l3_Addr1 = e_Addr1;
056900200901         l3_Addr2 = e_Addr2;
057000200901
057100200901         l3_City = e_City;
057200200901
057300200901
057400211207         exec sql
057500211207           select stcode
057600211207             into :l3_State
057700211207             from statecd
057800211207             where stName = upper(:e_State);
057900200901
058000200901         l3_zip = e_Zip;
058100200901
058200200902         l3_depssn = zFill(9: %scanRpl('-':'':e_ssn));
058300200901
058400200901         l3_gender = %SubSt( e_sex :1:1);
058500200901         l3_dob = fmtDate( e_Birth );
058600200901
058700200902         l3_relcod = get_relat(E_RELAT : l3_Gender );
058800200901
058900200901
059000200902         l3_UniqId = %Trim(zFill(9: %scanRpl('-':'':e_Empssn))) +
059100200902            fmtDate(e_birth) +
059200200902            %trim( e_Fname);
059300200902
059400200902         // Student?
059500200902         // e_student
059600200902
059700200902         if fmtDate( e_Cobstdt ) <= %Char(%Dec(%Date)) and
059800200902           fmtDate( e_Cobeddt ) >= %Char(%Dec(%Date)) ;
059900200902           l3_COBRA = 'Y';
060000200902         endif;
060100200902
060200200902
060300200902
060400200901         //-----------------------------------------------------
060500200901         // Qualifying Event.
060600200901         // If the inbound event is longer than 15 characters,
060700200901         // write to the EASEQE File.
060800200901         //-----------------------------------------------------
060900200901         if %Len(%Trim(e_qeEvent)) <= 15;
061000200902           l3_QualEvt = e_qeEvent;
061100200901         else;
061200200901           chain e_qeEvent easeqe;
061300200901           if %Found( easeQe );
061400200902             l3_QualEvt = q_Code;
061500200901           else;
061600200901
061700200901             // Add a record to EaseQE
061800200901             wSeq = 0;
061900200901
062000211207             exec sql
062100211207               select max(Q_Seq)
062200211207                 into :wSeq
062300211207                 from EaseQe;
062400200901
062500200901             q_Seq = wSeq + 1;
062600200901             q_Code = 'EASE_QE_' + %editc(q_seq:'X');
062700200901             q_Descr = e_qeEvent;
062800200901             write r_easeQe;
062900200901
063000200902             l3_QualEvt = q_code;
063100200901
063200200901           EndIf;
063300200901
063400200901
063500200901         EndIf;
063600200901
063700200902         if e_Handi > '';
063800200902           l3_Disabld = %Subst(e_handi:1:1);
063900200902         endif;
064000200902
064100200902
064200200901
064300200902         //  if e_Media_A > '' or
064400200902         //     e_Media_B > '' or
064500200902         //     e_Media_C > '' or
064600200902         //     e_Media_D > '';
064700200902         //
064800200902         //    l1_MedEnrl = 'Y';
064900200902         //  endif;
065000200901
065100200902         // l1_MediCar = e_mediaclm;
065200200902         l3_qeDate = fmtDate( e_qeEvtdt );
065300200901
065400200902
065500200902         Rcd = ucase(Rcd03);
065600200901         write r_gbs20p;
065700200901
065800200901
065900200901
066000200901
066100200901       End-Proc;
066200200901
066300200901
066400200826      *-------------------------------------------------------------------------
066500200826       dcl-proc Get_Mbr_Plans;
066600200826
066700200826         Clear Rcd02;
066800200826         Rcd2 = '2';
066900200826
067000201103         hasEOI = *off;
067100200826         l2_ssn = zFill(9: %scanRpl('-':'':e_Empssn));
067200200826
067300201209
067400200828         //-----------------------------------------------------
067500200828         // Plan Names:
067600200828         // If the inbound Name is longer than 20 characters,
067700200828         // write to the EASEPlan File.
067800200828         //-----------------------------------------------------
067900200828         if %Len(%Trim(e_PlanAdmn)) <= 20;
068000200828           l2_Plan = e_PlanAdmn;
068100200828         else;
068200200828           chain (wTrst:wSub#:wAcct: e_PlanAdmn) EasePlan;
068300200828           if %Found( easePlan );
068400200828             l2_Plan = p_Code;
068500200828           else;
068600200828
068700200828             // Add a record to EaseQE
068800200828             wSeq = 0;
068900200828
069000211207             exec sql
069100211207               select max(p_Seq)
069200211207                 into :wSeq
069300211207                 from EasePlan;
069400200828
069500200903             p_Trst = wTrst;
069600200903             p_Sub# = wSub#;
069700200903             p_Acct = wAcct;
069800200918
069900200918             p_Crtby = 'EASEINR';
070000200918             p_CrtDt = %Dec(%Date);
070100200918             p_CrtTm = %Dec(%Time);
070200200918
070300200918
070400200903
070500200828             p_Seq = wSeq + 1;
070600200828             p_Code = 'EASE_PLAN_' + %editc(p_seq:'X');
070700200902             p_PlanName = e_PlanAdmn;
070800200828             write r_easePlan;
070900200828
071000200902             l2_Plan = p_code;
071100200828           endif;
071200200828         endif;
071300200828
071400210421         if l1_termDt = '' or l1_termDt < l1_doh;
071500201125           l2_Effdt = fmtDate( e_CovEffdt );
071600201124         else;
071700201125
071800201125           l2_TermDt = l1_termDt;
071900201125         endif;
072000200828
072100201124
072200201124
072300201029         if %Scan( 'FSA' : e_PlanTyp) > 0  ;
072400201103           if e_ElecStat <> 'Terminated';
072500201103             l2_Fsa_Ann = %ScanRpl('$':'':e_ElecStat);
072600201103             l2_Fsa_Ann = %ScanRpl(',':'':l2_Fsa_Ann);
072700201029           endif;
072800201029         EndIf;
072900200828
073000200828
073100211223         if e_Earnbasd = 'Compensation' or
073200211223           e_Earnbasd = 'Custom' or
073300211223           e_Earnbasd = 'Base + Bonus + Commission' ;
073400211223
073500200903           pos = %Scan( '(' : e_ElecStat ) ;
073600200903           if pos > 0;
073700201103
073800201103             hasEOI = *on;
073900201103
074000201103             // Found a Requested Amount - Need an EOI.
074100201103             EOI_Amount = '';
074200201103             EOI_Amount = CleanNumber( %Subst( e_ElecStat : Pos));
074300201103             e_ElecStat = CleanNumber(%Subst( e_ElecStat : 1 : pos - 1 ));
074400201103
074500201122             chain ( wTrst : wSub# : wAcct : l2_ssn :
074600201122                    uCase(l1_fName) : l1_Dob:    e_PlanAdmn ) EaseEoi;
074700201103             if not %Found( EaseEoi ) ;
074800201103               I_TRST = wTrst;
074900201103               I_SUB# = wSub#;
075000201103               I_ACCT = wAcct;
075100201103
075200201103               chain ( wTrst: wSub#: wAcct ) AccMst;
075300201103               I_ACCNAME = acNam1;
075400201103               I_AACODE = aaCode;
075500201103               I_AANAME = '';
075600201103
075700211207               Exec Sql
075800211207                 Select Substring(afnam, 1, 1) || '. ' || alnam
075900211207                   Into :I_AANAME
076000211207                   From aacode
076100211207                   Where acode = :aaCode;
076200201103
076300201103
076400201103               I_SSN = l2_ssn;
076500201122               I_FNAME = uCase(l1_Fname);
076600201122               I_LNAME = uCase(e_lname);
076700201122               i_DOB = l1_Dob;
076800201122
076900201103               I_PLAN  = e_PlanAdmn;
077000201103               I_CURAMT = e_elecStat;
077100201103               I_REQAMT = EOI_Amount;
077200201103               I_DATE = %Char(%Dec(%Date));
077300210809               I_Relat = e_Relat;
077400201103
077500201103               write r_EaseEOI;
077600201103             else;
077700210712               if i_Curamt <> e_ElecStat or
077800210712               I_REQAMT <>  EOI_Amount;
077900210708                 I_CURAMT = e_elecStat;
078000210708                 I_DATE = %Char(%Dec(%Date));
078100210712                 I_REQAMT = EOI_Amount;
078200210809                 I_Relat = e_Relat;
078300210708                 update r_EaseEOI;
078400210708               endif;
078500210708
078600210708
078700201103               unlock EaseEOI;
078800201103             EndIf;
078900201103
079000201103           EndIf;
079100200903
079200201103           if e_ElecStat <> 'Terminated';
079300201029
079400201103             l2_volAmt = %ScanRpl('$':'':e_ElecStat);
079500201103             l2_volAmt = %ScanRpl(',':'':l2_volAmt);
079600201209
079700201029           endif;
079800201209
079900200828         EndIf;
080000200828
080100201216         if e_ElecStat = 'Terminated';
080200201216           l2_TermDt = fmtDate( e_qeEvtDt );
080300201216         EndIf;
080400200828
080500200828
080600201215         if l1_termDt = '';
080700201125           // Enrollment Level.
080800201125           Select;
080900201125           when e_CovTier = 'Employee Only';
081000201125             l2_Enrl = 'IN';
081100200828
081200201125           when %Subst(e_CovTier:1:19) = 'Employee + Spouse +';
081300201125             l2_Enrl = 'FA';
081400200828
081500201125           when e_CovTier = 'Employee + Spouse';
081600201125             l2_Enrl = 'HW';
081700200828
081800201125           when e_CovTier = 'Employee + 1 Child';
081900201125             l2_Enrl = 'PC';
082000200828
082100201125           when %Subst(e_CovTier:1:10) = 'Employee +';
082200201125             l2_Enrl = 'P2';
082300200828
082400201125           other;
082500201125             l2_Enrl = 'Unknw';
082600200828
082700201125           EndSl;
082800200828
082900201125           // Medical PCP Name/Number
083000201125           if e_MedPcpNm > '';
083100201125             l2_PcpName = e_MedPcpNm;
083200201125           EndIf;
083300200901
083400201125           if e_MedPcpId > '';
083500201125             l2_pcp# = e_MedPcpId;
083600201125           EndIf;
083700200901
083800201125           // Dental PCP Name/Number
083900201125           if e_DenPcpNm > '';
084000201125             l2_PcpName = e_DenPcpNm;
084100201125           EndIf;
084200200901
084300201125           if e_DenPcpId > '';
084400201125             l2_pcp# = e_DenPcpId;
084500201125           EndIf;
084600200901
084700200902         //l2_pcpEffdt =
084800200902         //l2_pcpTmdt =
084900200825
085000201125         endif;
085100201125
085200201125
085300201103         // If No EOI.. Clear Database..
085400201103         if hasEOI = *Off;
085500201122           chain ( wTrst : wSub# : wAcct : l2_ssn :
085600210728             %upper(l1_Fname) : l1_Dob : e_PlanAdmn ) EaseEoi;
085700201103           if %Found(EaseEOI);
085800201103             Delete r_EaseEOI;
085900201103           EndIf;
086000201103         endif;
086100201103
086200200902         Rcd = ucase(Rcd02);
086300200902         write r_gbs20p;
086400200902
086500200826       End-Proc;
086600200825
086700200902      *-------------------------------------------------------------------------
086800200902       dcl-proc Get_Dep_Plans;
086900200902
087000200902
087100200902         Clear Rcd04;
087200200902         Rcd4 = '4';
087300200902
087400200902         l4_UniqId = %Trim(zFill(9: %scanRpl('-':'':e_Empssn))) +
087500200902            fmtDate(e_birth) +
087600200902            %trim( e_Fname);
087700200902
087800200902
087900200902
088000200902         //-----------------------------------------------------
088100200902         // Plan Names:
088200200902         // If the inbound Name is longer than 20 characters,
088300200902         // write to the EASEPlan File.
088400200902         //-----------------------------------------------------
088500200902         if %Len(%Trim(e_PlanAdmn)) <= 20;
088600200902           l4_Plan = e_PlanAdmn;
088700200902         else;
088800200902           chain (wTrst:wSub#:wAcct: e_PlanAdmn) EasePlan;
088900200902           if %Found( easePlan );
089000200902             l4_Plan = p_Code;
089100200902           else;
089200200902
089300200902             // Add a record to EaseQE
089400200902             wSeq = 0;
089500200902
089600211207             exec sql
089700211207               select max(p_Seq)
089800211207                 into :wSeq
089900211207                 from EasePlan;
090000200902
090100200902             p_Seq = wSeq + 1;
090200200902             p_Code = 'EASE_PLAN_' + %editc(p_seq:'X');
090300200902             p_PlanName = e_PlanAdmn;
090400200902             write r_easePlan;
090500200902
090600200902             l4_Plan = q_code;
090700200902           endif;
090800200902         endif;
090900200902
091000200902         l4_Effdt = fmtDate( e_CovEffdt );
091100201124         if e_ElecStat = 'Terminated';
091200201123
091300201124           l4_TermDt = fmtDate( e_qeevtdt );
091400201123
091500201124
091600201124           //-----------------------------------------------------
091700201124           // Qualifying Event.
091800201124           // If the inbound event is longer than 15 characters,
091900201124           // write to the EASEQE File.
092000201124           //-----------------------------------------------------
092100201124           if %Len(%Trim(e_qeEvent)) <= 15;
092200201124             l4_TermRsn = e_qeEvent;
092300201124           else;
092400201124             chain e_qeEvent easeqe;
092500201124             if %Found( easeQe );
092600201124               l4_TermRsn = q_Code;
092700201124             else;
092800201124
092900201124               // Add a record to EaseQE
093000201124               wSeq = 0;
093100201124
093200211207               exec sql
093300211207                 select max(Q_Seq)
093400211207                   into :wSeq
093500211207                   from EaseQe;
093600201124
093700201124               q_Seq = wSeq + 1;
093800201124               q_Code = 'EASE_QE_' + %editc(q_seq:'X');
093900201124               q_Descr = e_qeEvent;
094000201124               write r_easeQe;
094100201124
094200201124               l4_TermRsn = q_code;
094300201124
094400201124             EndIf;
094500201124
094600201124           endif;
094700201124         endif;
094800200902
094900200902         // Coverage Level.   Not Needed for R4 Records
095000200902
095100200902         // Medical PCP Name/Number
095200200902         if e_MedPcpNm > '';
095300200902           l4_PcpName = e_MedPcpNm;
095400200902         EndIf;
095500200902
095600200902         if e_MedPcpId > '';
095700200902           l4_pcp# = e_MedPcpId;
095800200902         EndIf;
095900200902
096000200902         // Dental PCP Name/Number
096100200902         if e_DenPcpNm > '';
096200200902           l4_PcpName = e_DenPcpNm;
096300200902         EndIf;
096400200902
096500200902         if e_DenPcpId > '';
096600200902           l4_pcp# = e_DenPcpId;
096700200902         EndIf;
096800200902
096900200902         //l4_pcpEffdt =
097000200902         //l4_pcpTmdt =
097100200902
097200201122         //l4 Volumn Amount
097300211223         if e_Earnbasd = 'Compensation' or
097400211223           e_Earnbasd = 'Custom' or
097500211223           e_Earnbasd = 'Base + Bonus + Commission' ;
097600211223
097700201122           pos = %Scan( '(' : e_ElecStat ) ;
097800201122           if pos > 0;
097900201122
098000201122             hasEOI = *on;
098100201122
098200201122             // Found a Requested Amount - Need an EOI.
098300201122             EOI_Amount = '';
098400201122             EOI_Amount = CleanNumber( %Subst( e_ElecStat : Pos));
098500201122             e_ElecStat = CleanNumber(%Subst( e_ElecStat : 1 : pos - 1 ));
098600201122
098700201122             chain ( wTrst : wSub# : wAcct : l2_ssn :
098800201122                   ucase(l3_fName) : l3_Dob:    e_PlanAdmn ) EaseEoi;
098900201122             if not %Found( EaseEoi ) ;
099000201122               I_TRST = wTrst;
099100210809               I_SUB# = wSub#;
099200201122               I_ACCT = wAcct;
099300201122
099400201122               chain ( wTrst: wSub#: wAcct ) AccMst;
099500201122               I_ACCNAME = acNam1;
099600201122               I_AACODE = aaCode;
099700201122               I_AANAME = '';
099800201122
099900211207               Exec Sql
100000211207                 Select Substring(afnam, 1, 1) || '. ' || alnam
100100211207                   Into :I_AANAME
100200211207                   From aacode
100300211207                   Where acode = :aaCode;
100400201122
100500201122
100600201122               I_SSN = l2_ssn;
100700201122               I_FNAME = uCase(l3_Fname);
100800201122               I_LNAME = uCase(e_lname);
100900201122               i_DOB = l3_Dob;
101000201122
101100201122               I_PLAN  = e_PlanAdmn;
101200201122               I_CURAMT = e_elecStat;
101300201122               I_REQAMT = EOI_Amount;
101400201122               I_DATE = %Char(%Dec(%Date));
101500210809               I_Relat = e_Relat;
101600201122
101700201122               write r_EaseEOI;
101800201122             else;
101900210729
102000211207               if i_Curamt <> e_ElecStat or
102100211207                I_REQAMT <>  EOI_Amount;
102200210729                 I_CURAMT = e_elecStat;
102300210729                 I_DATE = %Char(%Dec(%Date));
102400210729                 I_REQAMT = EOI_Amount;
102500210809                 I_Relat = e_Relat;
102600210729                 update r_EaseEOI;
102700210729               endif;
102800210729
102900210729
103000210729
103100201122               unlock EaseEOI;
103200201122             EndIf;
103300201122
103400201122           EndIf;
103500201122         endif;
103600201122
103700201122
103800201122         // Volumn Amount
103900201123         if e_ElecStat <> 'Terminated' and
104000201123            e_ElecStat <> 'Enrolled';
104100201122
104200201122           l4_volAmt = %ScanRpl('$':'':e_ElecStat);
104300201122           l4_volAmt = %ScanRpl(',':'':l4_volAmt);
104400201122         endif;
104500201122
104600201122
104700220316         // If No EOI.. Clear Database..
104800220316         if hasEOI = *Off;
104900220316           chain ( wTrst : wSub# : wAcct : l2_ssn :
105000220316             %upper(l3_Fname) : l3_Dob : e_PlanAdmn ) EaseEoi;
105100220316           if %Found(EaseEOI);
105200220316             Delete r_EaseEOI;
105300220316           EndIf;
105400220316         endif;
105500220316
105600201122
105700200902         Rcd = ucase(Rcd04);
105800200902         write r_gbs20p;
105900200902
106000200902       End-Proc;
106100200902
106200200825      *----------------------------------------------------------------
106300200825      *
106400200825      * zFill Function
106500200825      *
106600200825      *----------------------------------------------------------------
106700200825
106800200825       Dcl-Proc zFill export;
106900200825
107000200825         Dcl-pi *n Char(100);
107100200825           len Zoned(3) value;
107200200825           Text Char(100) value;
107300200825         End-Pi;
107400200825
107500200825         dcl-s ReturnText Char(100);
107600200825         dcl-s Diff Zoned(3);
107700200825         dcl-s i Zoned(3);
107800200825
107900200825         Diff = len - %Len( %Trim(Text));
108000200825
108100200825         for i = 1 to Diff;
108200200825           ReturnText = %Trim(ReturnText) + '0';
108300200825         EndFor;
108400200825
108500200825         ReturnText = %Trim( ReturnText ) + %Trim( Text );
108600200825
108700200825         Return ReturnText;
108800200825
108900200825       end-Proc;
109000200825
109100200825
109200200825
109300200825      *-------------------------------------------------------------------------
109400200825      *
109500200825      * Split out the account number
109600200825      *
109700200825      *-------------------------------------------------------------------------
109800200825       Dcl-Proc FmtDate export;
109900200825
110000200825         Dcl-pi *n Char(8);
110100200825           iDate Char(10) value;
110200200825         End-Pi;
110300200825
110400200825
110500200825         dcl-s x int(10);
110600200825         dcl-s tokens varchar(100) dim(50);
110700200825
110800200825         dcl-s wMonth Char(2);
110900200825         dcl-s wDay   Char(2);
111000200825         dcl-s wYear  Char(4);
111100200825         dcl-s oDate  Char(8);
111200200825
111300200825
111400200825         if iDate = '';
111500200825           oDate = '';
111600200825           return oDate;
111700200825         EndIf;
111800200825
111900210228         iDate = %ScanRpl( ',' : '' : iDate ) ;
112000200825         tokens(*) = #Gettok( iDate : '/' : x );
112100200825
112200200825
112300200825         // we should have 3 array elements filled  in.
112400200825         // the next blank space should be #4.
112500200825         x = %lookup( '' : tokens ) ;
112600200825         if x <> 4;
112700200825           oDate = 'Error';
112800200825         else;
112900200825
113000200825
113100200825           wMonth = zFill( 2 : %Trim( Tokens(1) ));
113200200825           wDay   = zFill( 2 : %Trim( Tokens(2) ));
113300200825           wYear  = zFill( 4 : %Trim( Tokens(3) ));
113400200825
113500200825           oDate = wYear + wMonth + wDay;
113600200825
113700200825         EndIf;
113800200825
113900200825         return oDate;
114000200825
114100200825       End-Proc;
114200200825
114300200825
114400200825      *-------------------------------------------------------------------------
114500200825      *
114600200825      * Strip out the phone number
114700200825      *
114800200825      *-------------------------------------------------------------------------
114900200825       Dcl-Proc StripPhone export;
115000200825
115100200825         Dcl-pi *n Char(10);
115200200825           iText Char(20) value;
115300200825         End-Pi;
115400200825
115500200825         dcl-s textOut Char(10);
115600200825         dcl-c digits '0123456789';
115700200825
115800200825         dcl-s pos Zoned(3);
115900200825         dcl-s Len Zoned(3);
116000200825
116100200825
116200200825         Pos = 1;
116300200825         TextOut = '';
116400200825         Len = %Len( %Trim( iText ) ) ;
116500200825
116600200825         dow Pos <= Len;
116700200825           if %Check( Digits : %Subst(iText: Pos : 1)) = 0;
116800200825             TextOut = %Trim(TextOut) + %Subst(iText: Pos : 1);
116900200825           endif;
117000200825           Pos = Pos + 1;
117100200825         enddo;
117200200825
117300200825         return TextOut;
117400200825
117500200825
117600200825       End-Proc;
117700200825
117800200901      *-------------------------------------------------------------------------
117900200901      *
118000200901      * Get the Relationship Code
118100200901      *
118200200901      *-------------------------------------------------------------------------
118300200901       Dcl-Proc get_relat export;
118400200901
118500200902         Dcl-pi *n Char(1);
118600200901           iRelCode Char(20) value;
118700200901           iGender  Char(1) value;
118800200901         End-Pi;
118900200901
119000200902         dcl-s oCode Char(1);
119100200901
119200200902         iRelCode = uCase(iRelCode);
119300200902         iGender  = uCase(iGender);
119400200902
119500200902
119600200902         Select;
119700200902         When %subst(iRelCode:1:5) = 'CHILD';
119800200908           oCode = 'C';
119900200902
120000200902
120100200902         When %subst(iRelCode:1:6) = 'SPOUSE';
120200200908           oCode = 'S';
120300200902
120400200902         When iRelCode = 'DOMESTIC PARTNER';
120500200902           oCode = 'D';
120600200902
120700200902         other;
120800200902           oCode = '?';
120900200902
121000200902         EndSl;
121100200902
121200200902
121300200902         return oCode;
121400200901
121500200901       End-Proc;
121600200901
121700201103      *-------------------------------------------------------------------------
121800201103      *
121900201103      * Clean Number
122000201103      *
122100201103      *-------------------------------------------------------------------------
122200201103       Dcl-Proc CleanNumber export;
122300201103
122400201103         Dcl-pi *n Char(20);
122500201103           iText Char(20) value;
122600201103         End-Pi;
122700201103
122800201103         dcl-s textOut Char(20);
122900201103         dcl-c digits '.0123456789';
123000201103
123100201103         dcl-s pos Zoned(3);
123200201103         dcl-s Len Zoned(3);
123300201103
123400201103
123500201103         Pos = 1;
123600201103         TextOut = '';
123700201103         Len = %Len( %Trim( iText ) ) ;
123800201103
123900201103         dow Pos <= Len;
124000201103           if %Check( Digits : %Subst(iText: Pos : 1)) = 0;
124100201103             TextOut = %Trim(TextOut) + %Subst(iText: Pos : 1);
124200201103           endif;
124300201103           Pos = Pos + 1;
124400201103         enddo;
124500201103
124600201103         return TextOut;
124700201103
124800201103
124900201103       End-Proc;
125000201103
125100201216      *-------------------------------------------------------------------------
125200201216       dcl-proc Get_Waive;
125300201216
125400201216
125500210708         if e_Relat = 'Employee';
125600210708           w_Depssn = '';
125700210708         else;
125800210708           w_Depssn =  zFill(9: %scanRpl('-':'':e_ssn));
125900210708         EndIf;
126000210305
126100210305
126200201216         chain ( wTrst : wSub# : wAcct :
126300210305            zFill(9: %scanRpl('-':'':e_Empssn)) :
126400210305            zFill(9: %scanRpl('-':'':w_Depssn)) :
126500201216            uCase(e_fName) :
126600201216            fmtDate( e_Birth ):
126700201216            uCase(E_PLANTYP) ) EaseWaive;
126800201216
126900201216         if not %Found( EaseWaive ) ;
127000201216           w_TRST = wTrst;
127100201216           w_SUB# = wSub#;
127200201216           w_ACCT = wAcct;
127300201216
127400210305           W_SSN = zFill(9: %scanRpl('-':'':e_Empssn));
127500210708           //  W_DepSSN = zFill(9: %scanRpl('-':'':e_ssn));
127600201216           w_FNAME = uCase(e_fName);
127700201216           w_LNAME = uCase(e_lname);
127800201216           w_DOB = fmtDate( e_Birth );
127900201216
128000201216           w_PLANType  = uCase(e_PlanTyp);
128100201216           W_WAIVERSN = E_WAIVERSN;
128200201216
128300201216           write r_EaseWaiv;
128400201216         else;
128500201216           unlock EaseWaive;
128600201216         EndIf;
128700201216
128800201216
128900201216
129000201216       End-Proc;
129100201216
129200210630
129300210630      *-------------------------------------------------------------------------
129400210630       dcl-proc Get_Waive_NEW;
129500210630
129600210708         if e_Relat = 'Employee';
129700210708           w_Depssn = '';
129800210708         else;
129900210708           w_Depssn =  zFill(9: %scanRpl('-':'':e_ssn));
130000210708         EndIf;
130100210630
130200210630
130300210630
130400210708         // Employee Waived Plan
130500210708         if e_Relat = 'Employee';
130600210630
130700210708           // Write a Waive plan in GBS20
130800210708           Clear Rcd02;
130900210708           Rcd2 = '2';
131000210630
131100210708           l2_ssn = zFill(9: %scanRpl('-':'':e_Empssn));
131200210708           l2_plan =  e_PlanTyp;
131300210708           l2_enrl = 'W';
131400210630
131500210708           Rcd = uCase(rcd02);
131600210708           write r_gbs20p;
131700210630
131800210630
131900210708         else;
132000210630
132100210708           // Dependent Waived Plan
132200210708           clear Rcd04;
132300210708           rcd4 = '4';
132400210630
132500210708           l4_uniqid = l3_UniqId;
132600210708           l4_plan = e_PlanTyp;
132700210708           l4_CovgTyp = 'W';
132800210630
132900210708           Rcd = uCase( rcd04 );
133000210708           write r_gbs20p;
133100210630
133200210630
133300210708         endif;
133400210630
133500210630
133600210630       End-Proc;
133700210630
133800201216      *-------------------------------------------------------------------------
133900201216       dcl-proc Clear_Waive;
134000201216
134100201216
134200201216         Setll ( wTrst : wSub# : wAcct :
134300210305            zFill(9: %scanRpl('-':'':e_Empssn))) EaseWaive;
134400201216
134500201216         Dou %Eof(EaseWaive);
134600201216           Reade ( wTrst : wSub# : wAcct :
134700210305              zFill(9: %scanRpl('-':'':e_Empssn))) EaseWaive;
134800201216
134900201216           if %eof(EaseWaive);
135000201216             leave;
135100201216           endif;
135200201216
135300201216           delete r_EaseWaiv;
135400201216         Enddo;
135500201216
135600201216
135700201216
135800201216       End-Proc;
135900201216
136000210211      *-------------------------------------------------------------------------
136100210211       dcl-proc Check_Company;
136200210211
136300210211         dcl-s CompCount Zoned(5) inz;
136400210211         dcl-s Subj Char(60);
136500210211         dcl-s Msg Char(60);
136600210211
136700210211         Subj = 'Multiple Companies in EASE File';
136800210211
136900210211         cont = 'Y';
137000210211
137100211207         exec sql
137200211207           Select count(Distinct e_Compname)
137300211207             into :CompCount
137400211207             From EaseInp;
137500210211
137600210211         if CompCount > 1;
137700210211           Msg = %Char(CompCount) + ' different companies.  Group:' + pGroup;
137800210211
137900220518           CmdString = 'MailTool toAddr(payrolledi@amwins.com) ' +
138000210211           ' Subject(' + q + %Trim(Subj)  + q + ') ' +
138100210211           ' Message(' + q + %Trim(Msg) + q + ')' +
138200210211           ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
138300210211
138400210211
138500210211           #Command(CmdString:%len(%Trim(CmdString)));
138600210211
138700210211           cont = 'N';
138800210211         EndIf;
138900210211
139000210211
139100210211       End-Proc;
139200210211
139300210211
