000100220107       Ctl-opt option(*noDebugIo)   bnddir('GBSBIND') DftActGrp(*no);
000200191104
000300191104      *-------------------------------------------------------------------------
000400191104      *
000500200825      *  Description: EASE Inbound File to GBS File.
000600191104      *  Programmer.: Brian Rees
000700200825      *  Date.......: 08/25/2020
000800191104      *
000900191104      *-------------------------------------------------------------------------
001000210708      * Modifications:
001100210708      *
001200210725      * 07/25/20201  B.Rees   Changed COBRA Logic.
001300210725      *
001400210708      * 07/09/20201  B.Rees   Changed output to GBS30 File Specs.
001500210829      *
001600210829      * 8/26/2021    b.Rees   Added Omitted Plans Logic
001700210829      *    Maintenance Program:  GBS0076R
001800211207      *
001900211207      * 12/07/2021   B.Rees   Writing ALL Classes to the EASE Class Table
002000211207      *   This will be used for the GBS Class xRef.
002100210829      *
002200220107      *  1/7/2022   B.Rees   Added QE to plan level
002300230308      *  3/7/2022   B.Rees   Added PayFrq and PayPer
002400230308      *  3/8/2023   J.Allen  updated hours to 5.2 to allow for 32.5
002500210708      *-------------------------------------------------------------------------
002600210713
002700210713      *-------------------------------------------------------------------------
002800210713      *
002900210713      * Notes
003000210713      *
003100210713      *-------------------------------------------------------------------------
003200210713      * Please note. We could write directly to the GBS30MBR, GBS30MCOV, ect
003300210713      * files, but I wanted to test the New import process so I am sending the
003400210713      * the files to GBS30P.
003500210713      *-------------------------------------------------------------------------
003600191104
003700191104      *-------------------------------------------------------------------------
003800191104      *
003900191104      * Declare Files
004000191104      *
004100191104      *-------------------------------------------------------------------------
004200200825       dcl-f EaseInp keyed;
004300200826       dcl-f EaseQE  keyed usage(*input:*output);
004400200828       dcl-f EasePlan keyed usage(*input:*output);
004500200908       dcl-f EaseClas keyed usage(*input:*output);
004600201109       dcl-f EaseCost keyed usage(*input:*output);
004700201103       dcl-f AccMst  keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
004800201103
004900210708       dcl-f gbs30p keyed usage( *output );
005000201103       dcl-f EaseEOI Keyed usage(*input:*output:*update:*Delete);
005100201216       dcl-f EaseWaive Keyed usage(*input:*output:*update:*Delete);
005200210829       dcl-f EaseOmit keyed;
005300210829
005400200825
005500191104      *-------------------------------------------------------------------------
005600191104      *
005700191104      * Global Variables
005800191104      *
005900191104      *-------------------------------------------------------------------------
006000191104       dcl-ds pgmd
006100191104          ExtName('IOPGMD') PSDS;
006200191104         @pgmq *proc;
006300191104       end-ds;
006400191104
006500200825       dcl-s firstTime Char(1) inz('Y');
006600201103       dcl-s wtrst  Zoned(3) inz;
006700201103       dcl-s wSub#  Zoned(3) inz;
006800201103       dcl-s wAcct  Zoned(4) inz;
006900200826       dcl-s sav_Empssn like( e_Empssn ) inz;
007000200901
007100200901       dcl-s sav_fname like( e_Fname);
007200200901       dcl-s sav_Dssn  like( e_ssn );
007300200901       dcl-s sav_Birth like( e_birth );
007400201103       dcl-s EOI_Amount Char(12);
007500201103       dcl-s hasEOI Ind;
007600201103
007700200901       dcl-s wSeq Zoned(5);
007800201122       dcl-s pos zoned(5);
007900210211
008000210211       dcl-s Cont Char(1);
008100210211       dcl-c q '''';
008200210712       dcl-s DepCount Zoned(2);
008300210829       dcl-s Skip_Plan ind;
008400210829
008500211018       dcl-s wPartSsn Zoned(9);
008600211018       dcl-s HoldSeq Zoned(2);
008700230418       dcl-s SAL_Amount Char(20);
008800200825
008900210708       dcl-ds Rcd01 ExtName('GBS30MBR')  End-DS;
009000210708       dcl-ds Rcd02 ExtName('GBS30MCOV') End-DS;
009100210708       dcl-ds Rcd03 ExtName('GBS30DEP')  End-DS;
009200210708       dcl-ds Rcd04 ExtName('GBS30DCOV') End-DS;
009300210712       dcl-ds GBS30_Fmt ExtName('GBS30P') End-DS;
009400191104      *--------------------------------------------
009500191104      *
009600191104      * Procedures
009700191104      *
009800191104      *--------------------------------------------
009900191104       /include *LIBL/QMODSRC,#COMMANDPR         // Command
010000200825       /include GBSPGM/QMODSRC,#GettokPR
010100200825
010200200825       dcl-pr zFill Char(100);
010300200825         len Zoned(3) value;
010400200825         text Char(100) value;
010500200825       End-Pr;
010600200825
010700200825       dcl-pr fmtDate Char(8);
010800200825         iDate Char(10) value;
010900200825       End-Pr;
011000200825
011100200825       dcl-pr StripPhone Char(10);
011200200825         iText Char(20) value;
011300200825       End-Pr;
011400191104
011500191104
011600201103       dcl-pr CleanNumber Char(20);
011700201103         iText Char(20) value;
011800201103       End-Pr;
011900201103
012000200902       dcl-pr get_relat Char(1);
012100200902         iRelcode Char(20) value;
012200200902         iGender  Char(1)  value;
012300200902       End-Pr;
012400200902
012500191104      *-------------------------------------------------------------------------
012600191104      *
012700191104      * *Entry Procedure
012800191104      *
012900191104      *-------------------------------------------------------------------------
013000191104
013100201103       Dcl-pr Main ExtPgm;
013200201103         *N  Char(20);
013300201103       End-Pr;
013400201103
013500201103       dcl-pi Main;
013600201103         pGroup Char(20);
013700201103       End-Pi;
013800200825
013900200825
014000191104      *-------------------------------------------------------------------------
014100191104      *
014200191104      * Mainline Program
014300191104      *
014400200902      *-------------------------------------------------------------------------
014500200902
014600220107       Exec Sql
014700220107         Set Option Commit = *NONE, Naming = *SYS;
014800200902
014900210211
015000210211       // Make sure only one company in the file.
015100210211       Check_Company();
015200210211
015300210211       if Cont = 'Y';
015400210211         ReadFile();
015500210211       EndIf;
015600200825
015700200825
015800191104
015900191104       *inlr = *on;
016000200825
016100210211      *-------------------------------------------------------------------------
016200210211       dcl-proc ReadFile;
016300210211
016400210211
016500210211         Setll *start EaseInp;
016600210211
016700210211         Dou %Eof(EaseInp);
016800210211           read EaseInp;
016900210211
017000210211           if %eof(EaseInp);
017100210211             leave;
017200210211           endif;
017300210211
017400210211           if e_Elecstat = 'Waived';
017500210211           //  iter;
017600210211           EndIf;
017700210211
017800210712           if %upper(e_lName) = 'TEST' or
017900210712             %upper(e_lName) = 'GBSCUSTOMERSERVICETEST';
018000210211             iter;
018100210211           EndIf;
018200210211
018300210211
018400210211           if firstTime = 'Y';
018500210211             // Get the Account Number.
018600210211             wTrst = %Dec(%Subst(pGroup:1:3):3:0);
018700210211             wSub# = %Dec(%Subst(pGroup:4:3):3:0);
018800210211             wAcct = %Dec(%Subst(pGroup:7:4):4:0);
018900210211
019000210211             firstTime = 'N';
019100210211
019200210211           EndIf;
019300210211
019400210829           // Check to see if we need to Omit any plans.
019500211018           skip_Plan = *off;
019600210829
019700210829           Setll ( wTrst : wSub# : wAcct: %upper(e_PlanAdmn) ) EaseOmit;
019800210829
019900210829           Dou %Eof(EaseOmit);
020000210829             reade ( wTrst : wSub# : wAcct: %upper(e_PlanAdmn) ) EaseOmit;
020100210829             if %eof(EaseOmit);
020200210829               leave;
020300210829             endif;
020400210829
020500211018             if (j_StrDate <= %Dec(%Date))  and
020600211018                ( (j_EndDate = 0) or (j_EndDate >= %Dec(%Date)))  ;
020700210829
020800211018               skip_Plan = *on;
020900210829
021000211018             EndIf;
021100210829
021200211018           Enddo;
021300210829
021400211018           if Skip_Plan;
021500211018             iter;
021600211018           EndIf;
021700210829
021800210829
021900210829
022000210829
022100210211           if e_Empssn <> Sav_EmpSSn;
022200210211             Load_Member();
022300210211             sav_Empssn = e_Empssn;
022400210211
022500210211             sav_fname = '';
022600210211             sav_dssn = '';
022700210211             sav_Birth = '';
022800210712             depCount = 0;
022900210211
023000210211             Clear_Waive();
023100210211           endif;
023200210211
023300210712
023400210712
023500210211           if e_Relat = 'Employee';
023600210211
023700210211             //-----------------------
023800210211             //
023900210211             // Get Plans
024000210211             //
024100210211             //-----------------------
024200210211             if e_ElecStat <> 'Waived';
024300210211               Get_Mbr_Plans();
024400210211             else;
024500210211               Get_Waive();
024600210211             endif;
024700210211
024800210211
024900210211
025000210211           EndIf;
025100210211
025200210211
025300210211           // Dependents
025400210211           if e_Relat <> 'Employee';
025500210211
025600210211             if sav_fname <> e_fname or
025700210211                sav_dssn <> e_ssn or
025800210211                sav_Birth <> e_birth;
025900210211
026000211018               Get_DepSeq();
026100211018
026200211018
026300210211               Load_Dependent();
026400210211
026500210211               sav_fname = e_Fname;
026600210211               sav_dssn = e_ssn;
026700210211               sav_birth = e_birth;
026800210211
026900210211             EndIf;
027000210211
027100210211             //-----------------------
027200210211             //
027300210211             // Get Plans
027400210211             //
027500210211             //-----------------------
027600210211             if e_ElecStat <> 'Waived';
027700210211               Get_Dep_Plans();
027800210211             else;
027900210211               Get_Waive();
028000210211             endif;
028100210211
028200210211
028300210211
028400210211           EndIf;
028500210211
028600210211
028700210211
028800210211         Enddo;
028900210211
029000210211       End-Proc;
029100210211
029200200825      *-------------------------------------------------------------------------
029300200901       dcl-proc Load_Member;
029400200826
029500210228         dcl-s wSalary Zoned(11:2);
029600230308         dcl-s wHours Zoned(5:2);
029700210228         dcl-s Weeks Zoned(2) inz(52);
029800210228
029900210228
030000210228
030100210228
030200200826         Clear Rcd01;
030300210708         l1RcdTyp = '1';
030400200825         l1_ssn = zFill(9: %scanRpl('-':'':e_Empssn));
030500200825         l1_FName = e_FName;
030600200825         l1_mi = e_mi;
030700211005         if e_MiddleNm > '';
030800211005           l1_mi = %Subst(e_MiddleNm:1:1);
030900211005         EndIf;
031000200825         l1_lname = e_lname;
031100200825         l1_Addr1 = e_Addr1;
031200200825         l1_Addr2 = e_Addr2;
031300200825
031400200825         l1_City = e_City;
031500200825
031600200825
031700220107         exec sql
031800220107           select stcode
031900220107             into :l1_State
032000220107             from statecd
032100220107             where stName = upper(:e_State);
032200200825
032300200825         l1_zip = e_Zip;
032400210712         l1_Country =  e_Country;
032500210712
032600210712
032700210712         l1_Phone = StripPhone( e_Phone_p );   // ( e_Phone_M )
032800200825         l1_gender = %SubSt( e_sex :1:1);
032900200825         l1_dob = fmtDate( e_Birth );
033000200826
033100200826
033200200826         // Hire Date..
033300200826         // AllHire is the "ReHire" Date
033400200918         if e_HireDt > '';
033500201103           l1_doh = fmtDate( e_HireDt );
033600200918         endif;
033700200918
033800200918         if e_AllHire > '' and e_HireDt > '';
033900201103           if %Dec(fmtDate(e_AllHire):8:0) >=
034000201103              %Dec(fmtDate(e_HireDt):8:0) ;
034100201103             l1_doh = fmtDate( e_AllHire );
034200201103           EndIf;
034300200918         EndIf;
034400200825
034500211018         l1_Marsts = '';
034600200825
034700211018         if e_Marsts > '';
034800220107           exec sql
034900220107             select pcCode
035000220107               into :l1_MarSts
035100220107               from webpaychp
035200220107               where pcTrst = 0 and
035300220107                     pcSub# = 0 and
035400220107                     pcAcct = 0 and
035500220107                     pcGrpr = 'MARSTAT' and
035600220107                     upper(pcDesc) = upper(:e_Marsts);
035700210715
035800210715
035900211018         endif;
036000200825
036100230418         // Sal_Amount = %ScanRpl('$':'':e_Compen);
036200230418         // Sal_Amount = %ScanRpl(',':'':Sal_Amount);
036300230418         // l1_sal = %trim(Sal_Amount);
036400230418
036500230418         l1_sal = %ScanRpl('$':'':e_Compen);
036600230418         l1_sal = %ScanRpl(',':'':l1_sal);
036700210228
036800210228         if e_CompType = 'Hourly' and E_SCHDHRS > '';
036900210708           wSalary = %Dec( l1_Sal : 11 : 2 );
037000210228
037100210228
037200210708           if wSalary <= 500;
037300230308             wHours = %Dec(e_SchdHrs : 5 : 2 );
037400210708             wSalary = wSalary * wHours * Weeks;
037500210708             l1_Sal = %Char( wSalary );
037600210708           endif;
037700210228
037800210228         EndIf;
037900210228
038000210228
038100210228
038200200825         l1_termDt = fmtDate( e_TermDt );
038300200825         l1_doc =  fmtdate( e_CompStrt );
038400200826
038500200826
038600211018         // COBRA Start Date is Turned on..
038700210726         if fmtDate( e_Cobstdt ) <= %Char(%Dec(%Date))
038800210726            and e_Cobstdt > '';
038900210725
039000210725           l1_COBRA = 'Y';
039100210725
039200210725           // COBRA Ended.
039300210725           if fmtDate( e_Cobeddt ) < %Char(%Dec(%Date))  and
039400210725             e_Cobeddt > '';
039500210725             l1_COBRA = '';
039600210725           endif;
039700210725
039800210725         endif;
039900200826
040000210712
040100210712         //-----------------------------------------------------
040200210712         // Job Class ( Rule )
040300210712         // If the Job Class is longer than 5 characters,
040400210712         // write to the EASECLAS File.
040500210712         //-----------------------------------------------------
040600210712         if %Len(%Trim(e_JobClas)) <= 5;
040700210712           l1_Class = e_JobClas;
040800211207
040900211207           // Still Write to the Ease Class File.
041000211207           if %Len(%Trim(e_JobClas)) > 0;
041100211207
041200211207             chain (wTrst:wSub#:wAcct: e_JobClas) EaseClas;
041300211207             if not %Found( EaseClas );
041400211207
041500211207               // Add a record to EaseClas
041600211207               wSeq = 0;
041700211207
041800220107               exec sql
041900220107                 select max(c_Seq)
042000220107                   into :wSeq
042100220107                   from EaseClas
042200220107                   where c_Trst = :wTrst and
042300220107                         c_Sub# = :wSub# and
042400220107                         c_Acct = :wAcct;
042500211207
042600211207
042700211207               c_trst = wtrst;
042800211207               c_Sub# = wSub#;
042900211207               c_Acct = wAcct;
043000211207
043100211207               c_Seq = wSeq + 1;
043200211207               c_Code = '';
043300211207               c_Descr = e_JobClas;
043400211207               write r_easeClas;
043500211207
043600211207             EndIf;
043700211207           EndIf;
043800211207
043900211207
044000210712         else;
044100210712           chain (wTrst:wSub#:wAcct: e_JobClas) EaseClas;
044200210712           if %Found( easeClas );
044300210712             l1_Class = c_Code;
044400210712           else;
044500210712
044600210712             // Add a record to EaseClas
044700210712             wSeq = 0;
044800210712
044900220107             exec sql
045000220107               select max(c_Seq)
045100220107                 into :wSeq
045200220107                 from EaseClas
045300220107                 where c_Trst = :wTrst and
045400220107                       c_Sub# = :wSub# and
045500220107                       c_Acct = :wAcct;
045600210712
045700210712
045800210712             c_trst = wtrst;
045900210712             c_Sub# = wSub#;
046000210712             c_Acct = wAcct;
046100210712
046200210712             c_Seq = wSeq + 1;
046300210712             c_Code = '^' + %editc(c_seq:'X');
046400210712             c_Descr = e_JobClas;
046500210712             write r_easeClas;
046600210712
046700210712             l1_Class = c_code;
046800210712
046900210712           EndIf;
047000210712
047100210712
047200210712         EndIf;
047300210712
047400210712
047500210712         // l1_TermRsn =
047600210712
047700210712
047800210712         //-----------------------------------------------------
047900210712         // Qualifying Event.
048000210712         // If the inbound event is longer than 15 characters,
048100210712         // write to the EASEQE File.
048200210712         //-----------------------------------------------------
048300210712         if %Len(%Trim(e_qeEvent)) <= 15;
048400210712           l1_QualEvt = e_qeEvent;
048500210712         else;
048600210712           chain e_qeEvent easeqe;
048700210712           if %Found( easeQe );
048800210712             l1_QualEvt = q_Code;
048900210712           else;
049000210712
049100210712             // Add a record to EaseQE
049200210712             wSeq = 0;
049300210712
049400220107             exec sql
049500220107               select max(Q_Seq)
049600220107                 into :wSeq
049700220107                 from EaseQe;
049800210712
049900210712             q_Seq = wSeq + 1;
050000210712             q_Code = 'EASE_QE_' + %editc(q_seq:'X');
050100210712             q_Descr = e_qeEvent;
050200210712             write r_easeQe;
050300210712
050400210712             l1_QualEvt = q_code;
050500210712
050600210712           EndIf;
050700210712
050800210712
050900210712         EndIf;
051000200903
051100200826
051200200826
051300201123         // Personal or Work    ( e_Email )
051400201123         l1_Email = e_Email_p;
051500201123         if l1_Email = '';
051600201123           l1_Email = e_Email;   // Work Email.
051700201123         EndIf;
051800201123
051900201123
052000200825         l1_Smoker = e_Smoke;
052100210712
052200210712         l1_FullLoc = e_location;
052300210712
052400200825         if e_Media_A > '' or
052500200826            e_Media_B > '' or
052600200826            e_Media_C > '' or
052700200826            e_Media_D > '';
052800200825
052900200825           l1_MedEnrl = 'Y';
053000200825         endif;
053100200825
053200200825         l1_MediCar = e_mediaclm;
053300200826         l1_qeDate = fmtDate( e_qeEvtdt );
053400200825
053500210712
053600220211         l1_Jobtitl = e_jobTitle;
053700210712         l1_med_adt = fmtDate( e_Media_A );
053800210712         l1_med_bdt = fmtDate( e_Media_B );
053900210712         l1_med_cdt = fmtDate( e_Media_C );
054000210712         l1_med_ddt = fmtDate( e_Media_D );
054100211220         l1_qedescr = e_qeDetal;
054200220307
054300220307         l1_race = e_Race;
054400220307         select;
054500220307           When %upper(e_paycycle) = 'BI-WEEKLY';
054600220307             l1_PayFrq = 'BW1';
054700220307
054800220307           When %upper(e_paycycle) = 'MONTHLY';
054900220307             l1_PayFrq = 'MTH';
055000220307           When %upper(e_paycycle) = 'WEEKLY';
055100220307             l1_PayFrq = 'WKY';
055200220307           When %upper(e_paycycle) = 'SEMI-MONTHLY';
055300220307             l1_PayFrq = 'SEM';
055400220307           When %upper(e_paycycle) = 'YEARLY';
055500220307             l1_PayFrq = 'YER';
055600220307
055700220307
055800220307             other;
055900220307               l1_PayFrq = e_PayCycle;
056000220307
056100220307         EndSl;
056200220307
056300220307
056400220307       l1_payper = e_PayPer;
056500220307
056600220307
056700210712         //-----------------------------------------------------
056800210712         // Cost Center
056900210712         // If the Cost Center is longer than 20 Characters
057000210712         // write to the EASECOST File.
057100210712         //-----------------------------------------------------
057200210712         if %Len(%Trim(e_Div)) <= 20;
057300210712           l1_CostCtr = e_Div;
057400210712         else;
057500210712           chain (wTrst:wSub#:wAcct: e_Div) EaseCost;
057600210712           if %Found( easeCost );
057700210712             l1_CostCtr = d_Code;
057800210712           else;
057900210712
058000210712             // Add a record to EaseClas
058100210712             wSeq = 0;
058200210712
058300220107             exec sql
058400220107               select max(d_Seq)
058500220107                 into :wSeq
058600220107                 from EaseCost
058700220107                 where d_Trst = :wTrst and
058800220107                       d_Sub# = :wSub# and
058900220107                       d_Acct = :wAcct;
059000210712
059100210712
059200210712             d_trst = wtrst;
059300210712             d_Sub# = wSub#;
059400210712             d_Acct = wAcct;
059500210712
059600210712             d_Seq = wSeq + 1;
059700210712             d_Code = 'EASE_CC_' + %editc(d_seq:'X');
059800210712             d_Descr = e_Div;
059900210712             write r_easeCost;
060000210712
060100210712             l1_CostCtr = d_code;
060200210712
060300210712           EndIf;
060400210712
060500210712
060600210712         EndIf;
060700210712
060800210829         Rcd01 = %Upper(Rcd01);
060900210713         Write_Rcd1();
061000200825
061100200825
061200200825
061300200825       End-Proc;
061400200825
061500200825
061600200825
061700200901      *-------------------------------------------------------------------------
061800200901       dcl-proc Load_Dependent;
061900200901
062000200901         Clear Rcd03;
062100210712         l3RcdTyp = '3';
062200200901
062300200902         l3_PartSsn = zFill(9: %scanRpl('-':'':e_Empssn));
062400211018         l3_depSeq# = %Char(HoldSeq);
062500210712
062600200901         l3_FName = e_FName;
062700200901         l3_mi = e_mi;
062800211005         if e_MiddleNm > '';
062900211005           l3_mi = %Subst(e_MiddleNm:1:1);
063000211005         EndIf;
063100211005
063200200901         l3_lname = e_lname;
063300200901         l3_Addr1 = e_Addr1;
063400200901         l3_Addr2 = e_Addr2;
063500200901
063600200901         l3_City = e_City;
063700200901
063800200901
063900220107         exec sql
064000220107           select stcode
064100220107             into :l3_State
064200220107             from statecd
064300220107             where stName = upper(:e_State);
064400200901
064500200901         l3_zip = e_Zip;
064600210712         l3_Country = e_Country;
064700210712
064800210712
064900200902         l3_depssn = zFill(9: %scanRpl('-':'':e_ssn));
065000200901
065100200901         l3_gender = %SubSt( e_sex :1:1);
065200200901         l3_dob = fmtDate( e_Birth );
065300200901
065400200902         l3_relcod = get_relat(E_RELAT : l3_Gender );
065500200901
065600200902
065700200902
065800200902         if fmtDate( e_Cobstdt ) <= %Char(%Dec(%Date)) and
065900200902           fmtDate( e_Cobeddt ) >= %Char(%Dec(%Date)) ;
066000200902           l3_COBRA = 'Y';
066100200902         endif;
066200200902
066300200902
066400200902
066500200901         //-----------------------------------------------------
066600200901         // Qualifying Event.
066700200901         // If the inbound event is longer than 15 characters,
066800200901         // write to the EASEQE File.
066900200901         //-----------------------------------------------------
067000200901         if %Len(%Trim(e_qeEvent)) <= 15;
067100200902           l3_QualEvt = e_qeEvent;
067200200901         else;
067300200901           chain e_qeEvent easeqe;
067400200901           if %Found( easeQe );
067500200902             l3_QualEvt = q_Code;
067600200901           else;
067700200901
067800200901             // Add a record to EaseQE
067900200901             wSeq = 0;
068000200901
068100220107             exec sql
068200220107               select max(Q_Seq)
068300220107                 into :wSeq
068400220107                 from EaseQe;
068500200901
068600200901             q_Seq = wSeq + 1;
068700200901             q_Code = 'EASE_QE_' + %editc(q_seq:'X');
068800200901             q_Descr = e_qeEvent;
068900200901             write r_easeQe;
069000200901
069100200902             l3_QualEvt = q_code;
069200200901
069300200901           EndIf;
069400200901
069500200901
069600200901         EndIf;
069700200901
069800200902         if e_Handi > '';
069900200902           l3_Disabld = %Subst(e_handi:1:1);
070000200902         endif;
070100200902
070200200902
070300200901
070400211018         if e_Media_A > '' or
070500211018            e_Media_B > '' or
070600211018            e_Media_C > '' or
070700211018            e_Media_D > '';
070800210712
070900211018           l3_MedEnrl = 'Y';
071000211018         endif;
071100200901
071200210712         l3_MediCar = e_mediaclm;
071300200902         l3_qeDate = fmtDate( e_qeEvtdt );
071400220107         l3_qedescr = e_qeDetal;
071500200901
071600210712
071700210712         l3_med_adt = fmtDate( e_Media_A );
071800210712         l3_med_bdt = fmtDate( e_Media_B );
071900210712         l3_med_cdt = fmtDate( e_Media_C );
072000210712         l3_med_ddt = fmtDate( e_Media_D );
072100210712
072200210712
072300210712         l3_Studnt = e_student;
072400200902
072500210712
072600210713         Rcd03 = %Upper(Rcd03);
072700210713         Write_Rcd3();
072800200901
072900200901       End-Proc;
073000200901
073100200901
073200200826      *-------------------------------------------------------------------------
073300200826       dcl-proc Get_Mbr_Plans;
073400200826
073500200826         Clear Rcd02;
073600210712         l2RcdTyp = '2';
073700200826
073800201103         hasEOI = *off;
073900200826         l2_ssn = zFill(9: %scanRpl('-':'':e_Empssn));
074000200826
074100201209
074200200828         //-----------------------------------------------------
074300200828         // Plan Names:
074400200828         // If the inbound Name is longer than 20 characters,
074500200828         // write to the EASEPlan File.
074600200828         //-----------------------------------------------------
074700200828         if %Len(%Trim(e_PlanAdmn)) <= 20;
074800200828           l2_Plan = e_PlanAdmn;
074900200828         else;
075000200828           chain (wTrst:wSub#:wAcct: e_PlanAdmn) EasePlan;
075100200828           if %Found( easePlan );
075200200828             l2_Plan = p_Code;
075300200828           else;
075400200828
075500200828             // Add a record to EaseQE
075600200828             wSeq = 0;
075700200828
075800220107             exec sql
075900220107               select max(p_Seq)
076000220107                 into :wSeq
076100220107                 from EasePlan;
076200200828
076300200903             p_Trst = wTrst;
076400200903             p_Sub# = wSub#;
076500200903             p_Acct = wAcct;
076600200918
076700200918             p_Crtby = 'EASEINR';
076800200918             p_CrtDt = %Dec(%Date);
076900200918             p_CrtTm = %Dec(%Time);
077000200918
077100200918
077200200903
077300200828             p_Seq = wSeq + 1;
077400200828             p_Code = 'EASE_PLAN_' + %editc(p_seq:'X');
077500200902             p_PlanName = e_PlanAdmn;
077600200828             write r_easePlan;
077700200828
077800200902             l2_Plan = p_code;
077900200828           endif;
078000200828         endif;
078100200828
078200210421         if l1_termDt = '' or l1_termDt < l1_doh;
078300201125           l2_Effdt = fmtDate( e_CovEffdt );
078400201124         else;
078500201125
078600201125           l2_TermDt = l1_termDt;
078700201125         endif;
078800200828
078900201124
079000201124
079100201029         if %Scan( 'FSA' : e_PlanTyp) > 0  ;
079200201103           if e_ElecStat <> 'Terminated';
079300201103             l2_Fsa_Ann = %ScanRpl('$':'':e_ElecStat);
079400201103             l2_Fsa_Ann = %ScanRpl(',':'':l2_Fsa_Ann);
079500201029           endif;
079600201029         EndIf;
079700200828
079800200828
079900211223         if e_Earnbasd = 'Compensation' or
080000211223            e_Earnbasd = 'Custom' or
080100211223            e_Earnbasd = 'Base + Bonus + Commission' ;
080200200903           pos = %Scan( '(' : e_ElecStat ) ;
080300200903           if pos > 0;
080400201103
080500201103             hasEOI = *on;
080600201103
080700201103             // Found a Requested Amount - Need an EOI.
080800201103             EOI_Amount = '';
080900201103             EOI_Amount = CleanNumber( %Subst( e_ElecStat : Pos));
081000201103             e_ElecStat = CleanNumber(%Subst( e_ElecStat : 1 : pos - 1 ));
081100201103
081200201122             chain ( wTrst : wSub# : wAcct : l2_ssn :
081300210712                    %Upper(l1_fName) : l1_Dob:    e_PlanAdmn ) EaseEoi;
081400201103             if not %Found( EaseEoi ) ;
081500201103               I_TRST = wTrst;
081600201103               I_SUB# = wSub#;
081700201103               I_ACCT = wAcct;
081800201103
081900201103               chain ( wTrst: wSub#: wAcct ) AccMst;
082000201103               I_ACCNAME = acNam1;
082100201103               I_AACODE = aaCode;
082200201103               I_AANAME = '';
082300201103
082400220107               Exec Sql
082500220107                 Select Substring(afnam, 1, 1) || '. ' || alnam
082600220107                   Into :I_AANAME
082700220107                   From aacode
082800220107                   Where acode = :aaCode;
082900201103
083000201103
083100201103               I_SSN = l2_ssn;
083200210712               I_FNAME = %Upper(l1_Fname);
083300210712               I_LNAME = %Upper(e_lname);
083400201122               i_DOB = l1_Dob;
083500210804               I_Relat = e_Relat;
083600201122
083700201103               I_PLAN  = e_PlanAdmn;
083800201103               I_CURAMT = e_elecStat;
083900201103               I_REQAMT = EOI_Amount;
084000201103               I_DATE = %Char(%Dec(%Date));
084100201103
084200201103               write r_EaseEOI;
084300201103             else;
084400210712               if i_Curamt <> e_ElecStat or
084500210712                  I_REQAMT <>  EOI_Amount;
084600210712
084700210708                 I_CURAMT = e_elecStat;
084800210712                 I_REQAMT = EOI_Amount;
084900210708                 I_DATE = %Char(%Dec(%Date));
085000210708                 update r_EaseEOI;
085100210708               endif;
085200210708
085300201103               unlock EaseEOI;
085400201103             EndIf;
085500201103
085600201103           EndIf;
085700200903
085800201103           if e_ElecStat <> 'Terminated';
085900201029
086000201103             l2_volAmt = %ScanRpl('$':'':e_ElecStat);
086100201103             l2_volAmt = %ScanRpl(',':'':l2_volAmt);
086200201209
086300201029           endif;
086400201209
086500200828         EndIf;
086600200828
086700201216         if e_ElecStat = 'Terminated';
086800201216           l2_TermDt = fmtDate( e_qeEvtDt );
086900201216         EndIf;
087000200828
087100200828
087200201215         if l1_termDt = '';
087300201125           // Enrollment Level.
087400201125           Select;
087500201125           when e_CovTier = 'Employee Only';
087600201125             l2_Enrl = 'IN';
087700200828
087800201125           when %Subst(e_CovTier:1:19) = 'Employee + Spouse +';
087900201125             l2_Enrl = 'FA';
088000200828
088100201125           when e_CovTier = 'Employee + Spouse';
088200201125             l2_Enrl = 'HW';
088300200828
088400201125           when e_CovTier = 'Employee + 1 Child';
088500201125             l2_Enrl = 'PC';
088600200828
088700201125           when %Subst(e_CovTier:1:10) = 'Employee +';
088800201125             l2_Enrl = 'P2';
088900200828
089000201125           other;
089100201125             l2_Enrl = 'Unknw';
089200200828
089300201125           EndSl;
089400200828
089500201125           // Medical PCP Name/Number
089600201125           if e_MedPcpNm > '';
089700201125             l2_PcpName = e_MedPcpNm;
089800201125           EndIf;
089900200901
090000201125           if e_MedPcpId > '';
090100201125             l2_pcp# = e_MedPcpId;
090200201125           EndIf;
090300200901
090400201125           // Dental PCP Name/Number
090500201125           if e_DenPcpNm > '';
090600201125             l2_PcpName = e_DenPcpNm;
090700201125           EndIf;
090800200901
090900201125           if e_DenPcpId > '';
091000201125             l2_pcp# = e_DenPcpId;
091100201125           EndIf;
091200200901
091300220107           //l2_pcpEffdt =
091400220107           //l2_pcpTmdt =
091500220107
091600220107
091700201125         endif;
091800201125
091900201125
092000201103         // If No EOI.. Clear Database..
092100201103         if hasEOI = *Off;
092200201122           chain ( wTrst : wSub# : wAcct : l2_ssn :
092300210728             %Upper(l1_Fname) : l1_Dob : e_PlanAdmn ) EaseEoi;
092400201103           if %Found(EaseEOI);
092500201103             Delete r_EaseEOI;
092600201103           EndIf;
092700201103         endif;
092800201103
092900210712
093000210713         //GBS30_Fmt  = %Upper(Rcd02);
093100210713         //write r_gbs30p;
093200200902
093300210713         Rcd02 = %Upper(Rcd02);
093400210713         Write_Rcd2();
093500210713
093600200826       End-Proc;
093700200825
093800200902      *-------------------------------------------------------------------------
093900200902       dcl-proc Get_Dep_Plans;
094000200902
094100200902
094200200902         Clear Rcd04;
094300210712         l4RcdTyp = '4';
094400210712
094500210712         l4_PartSsn = l1_ssn;
094600211018         l4_depSeq# = %Char(HoldSeq);
094700200902
094800200902
094900200902
095000200902         //-----------------------------------------------------
095100200902         // Plan Names:
095200200902         // If the inbound Name is longer than 20 characters,
095300200902         // write to the EASEPlan File.
095400200902         //-----------------------------------------------------
095500200902         if %Len(%Trim(e_PlanAdmn)) <= 20;
095600200902           l4_Plan = e_PlanAdmn;
095700200902         else;
095800200902           chain (wTrst:wSub#:wAcct: e_PlanAdmn) EasePlan;
095900200902           if %Found( easePlan );
096000200902             l4_Plan = p_Code;
096100200902           else;
096200200902
096300200902             // Add a record to EaseQE
096400200902             wSeq = 0;
096500200902
096600220107             exec sql
096700220107               select max(p_Seq)
096800220107                 into :wSeq
096900220107                 from EasePlan;
097000200902
097100200902             p_Seq = wSeq + 1;
097200200902             p_Code = 'EASE_PLAN_' + %editc(p_seq:'X');
097300200902             p_PlanName = e_PlanAdmn;
097400200902             write r_easePlan;
097500200902
097600200902             l4_Plan = q_code;
097700200902           endif;
097800200902         endif;
097900200902
098000200902         l4_Effdt = fmtDate( e_CovEffdt );
098100201124         if e_ElecStat = 'Terminated';
098200201123
098300201124           l4_TermDt = fmtDate( e_qeevtdt );
098400201123
098500201124
098600201124           //-----------------------------------------------------
098700201124           // Qualifying Event.
098800201124           // If the inbound event is longer than 15 characters,
098900201124           // write to the EASEQE File.
099000201124           //-----------------------------------------------------
099100201124           if %Len(%Trim(e_qeEvent)) <= 15;
099200201124             l4_TermRsn = e_qeEvent;
099300201124           else;
099400201124             chain e_qeEvent easeqe;
099500201124             if %Found( easeQe );
099600201124               l4_TermRsn = q_Code;
099700201124             else;
099800201124
099900201124               // Add a record to EaseQE
100000201124               wSeq = 0;
100100201124
100200220107               exec sql
100300220107                 select max(Q_Seq)
100400220107                   into :wSeq
100500220107                   from EaseQe;
100600201124
100700201124               q_Seq = wSeq + 1;
100800201124               q_Code = 'EASE_QE_' + %editc(q_seq:'X');
100900201124               q_Descr = e_qeEvent;
101000201124               write r_easeQe;
101100201124
101200201124               l4_TermRsn = q_code;
101300201124
101400201124             EndIf;
101500201124
101600201124           endif;
101700201124         endif;
101800200902
101900200902         // Coverage Level.   Not Needed for R4 Records
102000200902
102100200902         // Medical PCP Name/Number
102200200902         if e_MedPcpNm > '';
102300200902           l4_PcpName = e_MedPcpNm;
102400200902         EndIf;
102500200902
102600200902         if e_MedPcpId > '';
102700200902           l4_pcp# = e_MedPcpId;
102800200902         EndIf;
102900200902
103000200902         // Dental PCP Name/Number
103100200902         if e_DenPcpNm > '';
103200200902           l4_PcpName = e_DenPcpNm;
103300200902         EndIf;
103400200902
103500200902         if e_DenPcpId > '';
103600200902           l4_pcp# = e_DenPcpId;
103700200902         EndIf;
103800200902
103900200902         //l4_pcpEffdt =
104000200902         //l4_pcpTmdt =
104100200902
104200201122         //l4 Volumn Amount
104300211223         if e_Earnbasd = 'Compensation' or
104400211223            e_Earnbasd = 'Custom' or
104500211223            e_Earnbasd = 'Base + Bonus + Commission' ;
104600201122           pos = %Scan( '(' : e_ElecStat ) ;
104700201122           if pos > 0;
104800201122
104900201122             hasEOI = *on;
105000201122
105100201122             // Found a Requested Amount - Need an EOI.
105200201122             EOI_Amount = '';
105300201122             EOI_Amount = CleanNumber( %Subst( e_ElecStat : Pos));
105400201122             e_ElecStat = CleanNumber(%Subst( e_ElecStat : 1 : pos - 1 ));
105500201122
105600201122             chain ( wTrst : wSub# : wAcct : l2_ssn :
105700210712                   %upper(l3_fName) : l3_Dob:    e_PlanAdmn ) EaseEoi;
105800201122             if not %Found( EaseEoi ) ;
105900201122               I_TRST = wTrst;
106000201122               I_SUB# = wSub#;
106100201122               I_ACCT = wAcct;
106200201122
106300201122               chain ( wTrst: wSub#: wAcct ) AccMst;
106400201122               I_ACCNAME = acNam1;
106500201122               I_AACODE = aaCode;
106600201122               I_AANAME = '';
106700201122
106800220107               Exec Sql
106900220107                 Select Substring(afnam, 1, 1) || '. ' || alnam
107000220107                   Into :I_AANAME
107100220107                   From aacode
107200220107                   Where acode = :aaCode;
107300201122
107400201122
107500201122               I_SSN = l2_ssn;
107600210712               I_FNAME = %upper(l3_Fname);
107700210712               I_LNAME = %upper(e_lname);
107800201122               i_DOB = l3_Dob;
107900201122
108000201122               I_PLAN  = e_PlanAdmn;
108100201122               I_CURAMT = e_elecStat;
108200201122               I_REQAMT = EOI_Amount;
108300201122               I_DATE = %Char(%Dec(%Date));
108400210804               I_Relat = e_Relat;
108500201122
108600201122               write r_EaseEOI;
108700201122             else;
108800210729
108900211018               if i_Curamt <> e_ElecStat or
109000211018                 I_REQAMT <>  EOI_Amount;
109100210729                 I_CURAMT = e_elecStat;
109200210729                 I_DATE = %Char(%Dec(%Date));
109300210729                 I_REQAMT = EOI_Amount;
109400210729                 update r_EaseEOI;
109500210729               endif;
109600210729
109700210729
109800201122               unlock EaseEOI;
109900201122             EndIf;
110000201122
110100201122           EndIf;
110200201122         endif;
110300201122
110400201122
110500201122         // Volumn Amount
110600201123         if e_ElecStat <> 'Terminated' and
110700201123            e_ElecStat <> 'Enrolled';
110800201122
110900201122           l4_volAmt = %ScanRpl('$':'':e_ElecStat);
111000201122           l4_volAmt = %ScanRpl(',':'':l4_volAmt);
111100201122         endif;
111200201122
111300210712
111400220316
111500220316         // If No EOI.. Clear Database..
111600220316         if hasEOI = *Off;
111700220316           chain ( wTrst : wSub# : wAcct : l2_ssn :
111800220316             %Upper(l3_Fname) : l3_Dob : e_PlanAdmn ) EaseEoi;
111900220316           if %Found(EaseEOI);
112000220316             Delete r_EaseEOI;
112100220316           EndIf;
112200220316         endif;
112300220316
112400210713
112500210713         Rcd04 = %Upper(Rcd04);
112600210713         Write_Rcd4();
112700200902
112800200902       End-Proc;
112900200902
113000200825      *----------------------------------------------------------------
113100200825      *
113200200825      * zFill Function
113300200825      *
113400200825      *----------------------------------------------------------------
113500200825
113600200825       Dcl-Proc zFill export;
113700200825
113800200825         Dcl-pi *n Char(100);
113900200825           len Zoned(3) value;
114000200825           Text Char(100) value;
114100200825         End-Pi;
114200200825
114300200825         dcl-s ReturnText Char(100);
114400200825         dcl-s Diff Zoned(3);
114500200825         dcl-s i Zoned(3);
114600200825
114700200825         Diff = len - %Len( %Trim(Text));
114800200825
114900200825         for i = 1 to Diff;
115000200825           ReturnText = %Trim(ReturnText) + '0';
115100200825         EndFor;
115200200825
115300200825         ReturnText = %Trim( ReturnText ) + %Trim( Text );
115400200825
115500200825         Return ReturnText;
115600200825
115700200825       end-Proc;
115800200825
115900200825
116000200825
116100200825      *-------------------------------------------------------------------------
116200200825      *
116300200825      * Split out the account number
116400200825      *
116500200825      *-------------------------------------------------------------------------
116600200825       Dcl-Proc FmtDate export;
116700200825
116800200825         Dcl-pi *n Char(8);
116900200825           iDate Char(10) value;
117000200825         End-Pi;
117100200825
117200200825
117300200825         dcl-s x int(10);
117400200825         dcl-s tokens varchar(100) dim(50);
117500200825
117600200825         dcl-s wMonth Char(2);
117700200825         dcl-s wDay   Char(2);
117800200825         dcl-s wYear  Char(4);
117900200825         dcl-s oDate  Char(8);
118000200825
118100200825
118200200825         if iDate = '';
118300200825           oDate = '';
118400200825           return oDate;
118500200825         EndIf;
118600200825
118700210228         iDate = %ScanRpl( ',' : '' : iDate ) ;
118800200825         tokens(*) = #Gettok( iDate : '/' : x );
118900200825
119000200825
119100200825         // we should have 3 array elements filled  in.
119200200825         // the next blank space should be #4.
119300200825         x = %lookup( '' : tokens ) ;
119400200825         if x <> 4;
119500200825           oDate = 'Error';
119600200825         else;
119700200825
119800200825
119900200825           wMonth = zFill( 2 : %Trim( Tokens(1) ));
120000200825           wDay   = zFill( 2 : %Trim( Tokens(2) ));
120100200825           wYear  = zFill( 4 : %Trim( Tokens(3) ));
120200200825
120300200825           oDate = wYear + wMonth + wDay;
120400200825
120500200825         EndIf;
120600200825
120700200825         return oDate;
120800200825
120900200825       End-Proc;
121000200825
121100200825
121200200825      *-------------------------------------------------------------------------
121300200825      *
121400200825      * Strip out the phone number
121500200825      *
121600200825      *-------------------------------------------------------------------------
121700200825       Dcl-Proc StripPhone export;
121800200825
121900200825         Dcl-pi *n Char(10);
122000200825           iText Char(20) value;
122100200825         End-Pi;
122200200825
122300200825         dcl-s textOut Char(10);
122400200825         dcl-c digits '0123456789';
122500200825
122600200825         dcl-s pos Zoned(3);
122700200825         dcl-s Len Zoned(3);
122800200825
122900200825
123000200825         Pos = 1;
123100200825         TextOut = '';
123200200825         Len = %Len( %Trim( iText ) ) ;
123300200825
123400200825         dow Pos <= Len;
123500200825           if %Check( Digits : %Subst(iText: Pos : 1)) = 0;
123600200825             TextOut = %Trim(TextOut) + %Subst(iText: Pos : 1);
123700200825           endif;
123800200825           Pos = Pos + 1;
123900200825         enddo;
124000200825
124100200825         return TextOut;
124200200825
124300200825
124400200825       End-Proc;
124500200825
124600200901      *-------------------------------------------------------------------------
124700200901      *
124800200901      * Get the Relationship Code
124900200901      *
125000200901      *-------------------------------------------------------------------------
125100200901       Dcl-Proc get_relat export;
125200200901
125300200902         Dcl-pi *n Char(1);
125400200901           iRelCode Char(20) value;
125500200901           iGender  Char(1) value;
125600200901         End-Pi;
125700200901
125800200902         dcl-s oCode Char(1);
125900200901
126000210712         iRelCode = %Upper(iRelCode);
126100210712         iGender  = %Upper(iGender);
126200200902
126300200902
126400200902         Select;
126500200902         When %subst(iRelCode:1:5) = 'CHILD';
126600200908           oCode = 'C';
126700200902
126800200902
126900200902         When %subst(iRelCode:1:6) = 'SPOUSE';
127000200908           oCode = 'S';
127100200902
127200200902         When iRelCode = 'DOMESTIC PARTNER';
127300200902           oCode = 'D';
127400200902
127500200902         other;
127600200902           oCode = '?';
127700200902
127800200902         EndSl;
127900200902
128000200902
128100200902         return oCode;
128200200901
128300200901       End-Proc;
128400200901
128500201103      *-------------------------------------------------------------------------
128600201103      *
128700201103      * Clean Number
128800201103      *
128900201103      *-------------------------------------------------------------------------
129000201103       Dcl-Proc CleanNumber export;
129100201103
129200201103         Dcl-pi *n Char(20);
129300201103           iText Char(20) value;
129400201103         End-Pi;
129500201103
129600201103         dcl-s textOut Char(20);
129700201103         dcl-c digits '.0123456789';
129800201103
129900201103         dcl-s pos Zoned(3);
130000201103         dcl-s Len Zoned(3);
130100201103
130200201103
130300201103         Pos = 1;
130400201103         TextOut = '';
130500201103         Len = %Len( %Trim( iText ) ) ;
130600201103
130700201103         dow Pos <= Len;
130800201103           if %Check( Digits : %Subst(iText: Pos : 1)) = 0;
130900201103             TextOut = %Trim(TextOut) + %Subst(iText: Pos : 1);
131000201103           endif;
131100201103           Pos = Pos + 1;
131200201103         enddo;
131300201103
131400201103         return TextOut;
131500201103
131600201103
131700201103       End-Proc;
131800201103
131900201216      *-------------------------------------------------------------------------
132000201216       dcl-proc Get_Waive;
132100201216
132200201216
132300210708         if e_Relat = 'Employee';
132400210708           w_Depssn = '';
132500210708         else;
132600210708           w_Depssn =  zFill(9: %scanRpl('-':'':e_ssn));
132700210708         EndIf;
132800210305
132900210305
133000201216         chain ( wTrst : wSub# : wAcct :
133100210305            zFill(9: %scanRpl('-':'':e_Empssn)) :
133200210305            zFill(9: %scanRpl('-':'':w_Depssn)) :
133300210712            %upper(e_fName) :
133400201216            fmtDate( e_Birth ):
133500210712            %upper(E_PLANTYP) ) EaseWaive;
133600201216
133700201216         if not %Found( EaseWaive ) ;
133800201216           w_TRST = wTrst;
133900201216           w_SUB# = wSub#;
134000201216           w_ACCT = wAcct;
134100201216
134200210305           W_SSN = zFill(9: %scanRpl('-':'':e_Empssn));
134300210708           //  W_DepSSN = zFill(9: %scanRpl('-':'':e_ssn));
134400210712           w_FNAME = %upper(e_fName);
134500210712           w_LNAME = %upper(e_lname);
134600201216           w_DOB = fmtDate( e_Birth );
134700201216
134800210712           w_PLANType  = %upper(e_PlanTyp);
134900201216           W_WAIVERSN = E_WAIVERSN;
135000201216
135100201216           write r_EaseWaiv;
135200201216         else;
135300201216           unlock EaseWaive;
135400201216         EndIf;
135500201216
135600201216
135700201216
135800201216       End-Proc;
135900201216
136000210630
136100201216      *-------------------------------------------------------------------------
136200201216       dcl-proc Clear_Waive;
136300201216
136400201216
136500201216         Setll ( wTrst : wSub# : wAcct :
136600210305            zFill(9: %scanRpl('-':'':e_Empssn))) EaseWaive;
136700201216
136800201216         Dou %Eof(EaseWaive);
136900201216           Reade ( wTrst : wSub# : wAcct :
137000210305              zFill(9: %scanRpl('-':'':e_Empssn))) EaseWaive;
137100201216
137200201216           if %eof(EaseWaive);
137300201216             leave;
137400201216           endif;
137500201216
137600201216           delete r_EaseWaiv;
137700201216         Enddo;
137800201216
137900201216
138000201216
138100201216       End-Proc;
138200201216
138300210211      *-------------------------------------------------------------------------
138400210211       dcl-proc Check_Company;
138500210211
138600210211         dcl-s CompCount Zoned(5) inz;
138700210211         dcl-s Subj Char(60);
138800210211         dcl-s Msg Char(60);
138900210211
139000210211         Subj = 'Multiple Companies in EASE File';
139100210211
139200210211         cont = 'Y';
139300210211
139400220107         exec sql
139500220107           Select count(Distinct e_Compname)
139600220107             into :CompCount
139700220107             From EaseInp;
139800210211
139900210211         if CompCount > 1;
140000210211           Msg = %Char(CompCount) + ' different companies.  Group:' + pGroup;
140100210211
140200220518           CmdString = 'MailTool toAddr(payrolledi@amwins.com) ' +
140300210211           ' Subject(' + q + %Trim(Subj)  + q + ') ' +
140400210211           ' Message(' + q + %Trim(Msg) + q + ')' +
140500210211           ' BdyCt(' + q + 'text/html; charset=utf-8' + q + ')';
140600210211
140700210211
140800210211           #Command(CmdString:%len(%Trim(CmdString)));
140900210211
141000210211           cont = 'N';
141100210211         EndIf;
141200210211
141300210211
141400210211       End-Proc;
141500210211
141600210211
141700210713      *-------------------------------------------------------------------------
141800210713       dcl-proc Write_Rcd1;
141900210713
142000210713
142100211018         g3rcdtyp = l1RcdTyp;
142200211018         g3ssn =   l1_ssn;
142300211018         g3field1 = l1_Fname;
142400211018         g3field2 = l1_mi;
142500211018         g3field3 = l1_lname;
142600211018         g3field4 = l1_addr1;
142700211018         g3field5 = l1_addr2;
142800211018         g3field6 = l1_city;
142900211018         g3field7 = l1_State;
143000211018         g3field8 = l1_zip;
143100211018         g3field9 = l1_Country;
143200211018         g3field10 = l1_Phone;
143300211018         g3field11 = l1_Gender;
143400211018         g3field12 = l1_dob;
143500211018         g3field13 = l1_doh;
143600211018         g3field14 = l1_marsts;
143700211018         g3field15 = l1_sal;
143800211018         g3field16 = l1_TermDt;
143900211018         g3field17 = l1_Doc;
144000211018         g3field18 = l1_Cobra;
144100211018         g3field19 = l1_Class;
144200211018         g3field20 = l1_TermRsn;
144300211018         g3field21 = l1_QualEvt;
144400211018         g3field22 = l1_Email;
144500211018         g3field23 = l1_Smoker;
144600211018         g3field24 = l1_FullLoc;
144700211018         g3field25 = l1_MedEnrl;
144800211018         g3field26 = l1_Medicar;
144900211018         g3field27 = l1_QeDate;
145000211018         g3field28 = l1_Med_Adt;
145100211018         g3field29 = l1_Med_Bdt;
145200211018         g3field30 = l1_Med_Cdt;
145300211018         g3field31 = l1_Med_Ddt;
145400211018         g3field32 = l1_CostCtr;
145500220107         g3field33 = l1_jobtitl;
145600220107         g3field34 = l1_race;
145700220107         g3field35 = l1_qedescr;
145800220307         g3field36 = l1_PayFrq;
145900220307         g3field37 = l1_PayPer;
146000210713
146100211018         Write r_gbs30p;
146200210713
146300210713
146400210713       End-Proc;
146500210713
146600210713
146700210713      *-------------------------------------------------------------------------
146800210713       dcl-proc Write_Rcd2;
146900210713
147000211018         Clear r_Gbs30p;
147100210713
147200211018         g3rcdtyp = l2RcdTyp;
147300211018         g3ssn =  l2_ssn;
147400211018         g3field1 = l2_Plan;
147500211018         g3field2 = l2_Effdt;
147600211018         g3field3 = l2_TermDt;
147700211018         g3field4 = l2_Enrl;
147800211018         g3field5 = l2_Fsa_Ann;
147900211018         g3field6 = l2_Fsa_Pp;
148000211018         g3field7 = l2_VolAmt;
148100211018         g3field8 = l2_CovgTp;
148200211018         g3field9 = l2_Pcp#;
148300211018         g3field10 = l2_PcpName;
148400211018         g3field11 = l2_PcpEfDt;
148500211018         g3field12 = l2_PcpTmdt;
148600210713
148700211018         Write r_gbs30p;
148800210713
148900210713
149000210713       End-Proc;
149100210713      *-------------------------------------------------------------------------
149200210713       dcl-proc Write_Rcd3;
149300210713
149400211018         Clear r_Gbs30p;
149500210713
149600211018         g3rcdtyp = l3RcdTyp;
149700211018         g3ssn =    l3_Partssn;
149800211018         g3field1 = l3_DepSeq#;
149900211018         g3field2 = l3_fName;
150000211018         g3field3 = l3_mi;
150100211018         g3field4 = l3_lName;
150200211018         g3field5 = l3_Addr1;
150300211018         g3field6 = l3_Addr2;
150400211018         g3field7 = l3_City;
150500211018         g3field8 = l3_State;
150600211018         g3field9 = l3_Zip;
150700211018         g3field10 = l3_Country;
150800211018         g3field11 = l3_DepSSn;
150900211018         g3field12 = l3_Gender;
151000211018         g3field13 = l3_DOB;
151100211018         g3field14 = l3_RelCod;
151200211018         g3field15 = l3_EffDt;
151300211018         g3field16 = l3_Cobra;
151400211018         g3field17 = l3_QualEvt;
151500211018         g3field18 = l3_Disabld;
151600211018         g3field19 = l3_QeDate;
151700211018         g3field20 = l3_Studnt;
151800211018         g3field21 = l3_MedEnrl;
151900220107         g3field22 = l3_Medicar;
152000220107         g3field23 = l3_Med_Adt;
152100220107         g3field24 = l3_Med_Bdt;
152200220107         g3field25 = l3_Med_Cdt;
152300220107         g3field26 = l3_Med_Ddt;
152400220107         g3field27 = l3_qeDescr;
152500210713
152600211018         Write r_gbs30p;
152700210713
152800210713
152900210713       End-Proc;
153000210713
153100210713      *-------------------------------------------------------------------------
153200210713       dcl-proc Write_Rcd4;
153300210713
153400211018         Clear r_Gbs30p;
153500210713
153600211018         g3rcdtyp = l4RcdTyp;
153700211018         g3ssn = l4_PartSsn;
153800211018         g3field1 = l4_DepSeq#;
153900211018         g3field2 = l4_Plan;
154000211018         g3field3 = l4_EffDt;
154100211018         g3field4 = l4_TermDt;
154200211018         g3field5 = l4_CovgTyp;
154300211018         g3field6 = l4_Pcp#;
154400211018         g3field7 = l4_PcpName;
154500211018         g3field8 = l4_pcpEfdt;
154600211018         g3field9 = l4_PcpTmdt;
154700211018         g3field10 = l4_VolAmt;
154800211018         g3field11 = l4_TermRsn;
154900211018         Write r_gbs30p;
155000210713
155100210713
155200210713       End-Proc;
155300210713
155400211018      *-------------------------------------------------------------------------
155500211018       dcl-proc Get_DepSeq;
155600211018
155700211019         dcl-s wBirth Char(8);
155800211019
155900211019         wBirth = fmtDate( e_Birth );
156000211019
156100211018         // Do we already have this dependent in the system?
156200211018         HoldSeq = 0;
156300211018
156400211018         wPartssn = 0;
156500211018         if e_ssn > '';
156600211018           wPartSsn = %Dec( %scanRpl('-':'':e_ssn):9:0);
156700211018         endif;
156800211018
156900211018         // Search for the Dependent Sequence #
157000211018         if l1_ssn > '' and wPartssn > 0;
157100220107           Exec Sql
157200220107             Select dpSeq#
157300220107               into :HoldSeq
157400220107               FROM "F.DEPEND"
157500220107               Where dssno = :l1_ssn and
157600220107                     Depss# = :wPartSsn;
157700211018         endif;
157800211018
157900211018
158000211018
158100211018         // Check by First Name...
158200211018         if HoldSeq = 0;
158300220107           Exec Sql
158400220107             Select dpSeq#
158500220107               into :HoldSeq
158600220107               FROM "F.DEPEND"
158700220107               Where dssno = :l1_ssn and
158800220107                     upper(Dfname) = upper(:e_FName) and
158900220107                     dBirth = :wBirth;
159000211018         endif;
159100211018
159200211018
159300211018         if HoldSeq = 0;
159400220107           Exec Sql
159500220107             Select Max(dpSeq#)
159600220107               into :HoldSeq
159700220107               FROM "F.DEPEND"
159800220107               Where dssno = :l1_ssn;
159900211018
160000211018           DepCount = DepCount + 1;
160100211018           HoldSeq = HoldSeq + DepCount;
160200211018         endif;
160300211018
160400211018
160500211018
160600211018       End-Proc;
160700211018
