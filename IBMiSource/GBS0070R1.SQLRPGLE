000100220107
000200210910       ctl-opt option(*noDebugIo) DftActGrp(*no) bnddir('GBSBIND');
000300200121
000400210413      *-----------------------------------------------------------------------
000500200106      *
000600210412      *  Description: Format the GBS 3.0 Data File
000700160708      *
000800200106      *  Programmer.: Brian Rees
000900210412      *  Date.......: 04/12/2021
001000200106      *
001100210910      *  Copied from GBS0060R1
001200210413      *-----------------------------------------------------------------------
001300200106      * Change Log
001400200106      *
001500200903      * 09/03/2020  B.Rees
001600200903      *  Added EASE Cross reference files.
001700201104      * 11/4/2020   B.Rees  Added EASE EOI Text
001800201105      * 11/5/2020   B.Rees  Added Additional Fields for EASE
001900201105      *    Med-A Date, Med-B Date, Med-C Date, Med-D Date, Cost Center.
002000201216      * 12/16/2020   B.Rees  Added Waive Records for EASE
002100220211      * 02/11/2022   B.Rees  Added MEMEXTP Data.
002200220214      * 02/14/2022   B.Rees  Check Member File for Waived Status
002300210413      *-----------------------------------------------------------------------
002400170112
002500200121       dcl-f ADPOutputp keyed usage(*output);
002600200121
002700210412       dcl-f GBS30Mbr  keyed usropn;
002800210412       dcl-f GBS30MCov keyed usropn;
002900210412       dcl-f GBS30Dep  keyed usropn;
003000210412       dcl-f GBS30DCov keyed usropn;
003100200121
003200200121       dcl-f PlnMst Keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
003300200121
003400200121       dcl-f Gbs0029P keyed; // Location Cross Reference
003500200121       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
003600200121
003700200903       dcl-f EasePlanl1 keyed;
003800200903       dcl-f EaseQEl1 keyed;
003900200904       dcl-f EaseClasl1 keyed;
004000201104       dcl-f EaseEOI keyed;
004100201105       dcl-f EaseCostl1 keyed;
004200201216       dcl-f EaseWaive keyed;
004300200903
004400210910       dcl-f gbsDiffp keyed;
004500210910       dcl-f PlanxRefp keyed;
004600220104       dcl-f CcntrxRefp keyed;
004700220307       dcl-f Code20P keyed;
004800210910
004900210413      *-----------------------------------------------------------------------
005000170112
005100210412       dcl-s PlanArry Char(20) dim(26);
005200210412       dcl-s EnrlArry Char(3) dim(26);
005300210412       dcl-s EffDtArry Char(10) dim(26);
005400210413       dcl-s TermDtArry Char(10) dim(26);
005500210412       dcl-s TermRsnArry Char(15) dim(26);
005600210412       dcl-s VolAmtArry Char(11) dim(26);
005700210412       dcl-s FSAAnnArry Char(10) dim(26);
005800210412       dcl-s FSAPPArry Char(9) dim(26);
005900210412
006000210412
006100210412       dcl-s PCP#Arry Char(20) dim(26);
006200210412       dcl-s PCPNameArry Char(50) dim(26);
006300210412       dcl-s PCPEfdtArry Char(8) dim(26);
006400210412       dcl-s PCPTmdtArry Char(8) dim(26);
006500220107
006600210412
006700210910       dcl-s PlnCnt Zoned(3);
006800210910       dcl-s i Zoned(2) inz;
006900210910       dcl-s count Zoned(5);
007000210910       dcl-s VolAmt$ Zoned(11);
007100210910       dcl-s FSAAmt$ Zoned(7:2);
007200210910
007300210910
007400180711       dcl-s wSalary Zoned(9:2);
007500180516       dcl-s wSSn Zoned(9);
007600180516       dcl-s wSSnChar Char(11);
007700180516
007800181003       dcl-s wTrst Zoned( 3 );
007900181003       dcl-s wSub  Zoned( 3 );
008000181003       dcl-s wAcct Zoned( 4 );
008100181003
008200201104       dcl-s eoi_ssn Char(15);
008300201104       dcl-s eoi_Plan Char(50);
008400201104
008500210910       dcl-s Check_Field Char(10);
008600210910
008700210910       dcl-s ChgdArry    Char(1)  Dim(26);
008800210910       dcl-s CovgArry    Char(5)  Dim(26);
008900210910       dcl-s PCPNmArry   Char(50) Dim(26);
009000210910
009100210910       dcl-s Rcd_Level Char(10);
009200210910       dcl-s Skip_Name Char(1) inz('N');
009300210910       dcl-s Get_PlanxRef ind;
009400210910
009500210910       dcl-s @ssn Char(9);
009600210913       dcl-s Office Char(40);
009700210913       dcl-s PlanDesc Char(40);
009800211214
009900211214       dcl-s SearchArray Zoned(2);
010000220104       dcl-s Print_WaiveInfo Char(1);
010100220307       dcl-s CodeType Char(10);
010200210910
010300210910      *--------------------------------------------
010400210910      *
010500210910      * Procedures
010600210910      *
010700210910      *--------------------------------------------
010800210910      /Include *LIBL/QMODSRC,#EdtStngPr            // Edit String
010900210910
011000210910
011100210413      *-----------------------------------------------------------------------
011200200121      *
011300200121      * *Entry Procedure
011400200121      *
011500210413      *-----------------------------------------------------------------------
011600210910       Dcl-pr Main ExtPgm;
011700210910         *N  char(1);
011800210910         *N  char(10);
011900210910         *N  char(1);
012000210910         *N  Char(1);
012100210910         *N  Char(10);
012200210910         *N  Char(100) options( *noPass );
012300210910       End-Pr;
012400210910
012500210910       dcl-pi Main;
012600210910         hasOrphan Char(1);
012700210910         pKey      Char(10);
012800210910         phasFSA   Char(1);
012900210910         pEnvir Char(1);
013000210910         eFileType Char(10);
013100210910         pSingleInfo Char(100) options( *noPass );
013200210910       End-Pi;
013300210910
013400210910       dcl-s S_Type Char(1);
013500210910       dcl-s Plan_Type Char(1);
013600210910       dcl-s S_MbrSSN Char(9);
013700210910       dcl-s S_UniqueID Char(32);
013800210910       dcl-s Plan_Name Char(20);
013900200121
014000210910
014100210413      *-----------------------------------------------------------------------
014200200121      *
014300160926      * Mainline Program
014400200121      *
014500210413      *-----------------------------------------------------------------------
014600191205
014700210412       open GBS30Mbr ;
014800210412       open GBS30MCov;
014900210412       open GBS30Dep;
015000210412       open GBS30DCov;
015100191205
015200200921
015300210910       Get_PlanxRef = *off;
015400210910       pHasFSA   = 'N';
015500210910
015600210910       wTrst = %Dec( %Subst( pKey : 1 : 3 ) : 3 : 0 ) ;
015700210910       wSub  = %Dec( %Subst( pKey : 4 : 3 ) : 3 : 0 ) ;
015800210910       wAcct = %Dec( %Subst( pKey : 7 : 4 ) : 4 : 0 ) ;
015900210910
016000210910
016100210910       // Process a Single Record.
016200210910       if %Parms >= 6;
016300210910
016400210910         S_Type = %SubSt( pSingleInfo : 1 : 1 );
016500210910         s_MbrSSN = %SubSt( pSingleInfo : 2 : 9 );
016600210910         S_UniqueID = %SubSt( pSingleInfo : 11 : 32 );
016700210910         Skip_Name = 'Y';
016800210910         Get_PlanxRef = *on;
016900210910
017000210910         if s_Type = 'M';       // Member Information
017100210910           Single_Member();
017200210910         endif;
017300210910
017400210910         if s_Type = 'D';       // Dependent Information
017500210910           Single_Dependent();
017600210910         endif;
017700210910
017800210910
017900210910         if s_Type = 'P';       // Print
018000210910
018100210910           Get_PlanxRef = *off;
018200210910           Plan_Type = %SubSt( pSingleInfo : 2 : 1 );   // Member or Dependent
018300210910           s_MbrSSN = %SubSt( pSingleInfo : 3 : 9 );
018400210910           Plan_Name = %SubSt( pSingleInfo : 12 : 20 );   // Plan Name
018500210910           S_UniqueID = %SubSt( pSingleInfo : 33 : 32 );   // Unique ID
018600210910
018700210910           if Plan_Type = 'M';
018800210910             PrtMbrPlans();
018900210910           EndIf;
019000210910
019100210910           if Plan_Type = 'D';
019200210910             PrtDepPlans();
019300210910           EndIf;
019400210910
019500210910
019600210910
019700210910         endif;
019800210910
019900210910
020000210910
020100210910       EndIf;
020200210910
020300210910
020400210910       //----------------------------------
020500210910       //
020600210910       // Normal Processing.
020700210910       //
020800210910       //----------------------------------
020900210910       if %Parms < 6;
021000210910
021100210910         Omitted_Mbr();
021200210910
021300210910         ProcessData();
021400210910
021500210910         //?Check for Orphan Records.
021600210910         hasOrphan = 'N';
021700210910
021800220214         Exec Sql
021900220214           Select Count(*)
022000220214             Into :Count
022100220214             From GBS30Dep
022200220214             Where L3_Partssn Not In (Select L1_Ssn
022300220214                   From GBS30Mbr);
022400210910
022500210910         if Count > 0;
022600210910           hasOrphan = 'Y';
022700210910         endif;
022800210910
022900210910       endif;
023000210910
023100170713
023200210412       Close GBS30Mbr ;
023300210412       Close GBS30MCov;
023400210412       Close GBS30Dep;
023500210412       Close GBS30DCov;
023600191205
023700180516       *inlr = *on;
023800170509
023900160708
024000210910
024100210910
024200210910      *-------------------------------------------------------------------------
024300210910       dcl-proc ProcessData;
024400210910
024500210910         setll *loval GBS30Mbr;
024600210910         dou %Eof(GBS30Mbr);
024700210910           read GBS30Mbr;
024800210910
024900210910           if %eof(GBS30Mbr);
025000210910             leave;
025100210910           endif;
025200210910
025300210910           l1_FName = EdtString(l1_FName:'NAME');
025400210910           l1_LName = EdtString(l1_LName:'NAME');
025500210910           l1_Addr1 = EdtString(l1_Addr1:'ADDR');
025600210910           l1_Addr2 = EdtString(l1_Addr2:'ADDR');
025700210910           l1_City = EdtString(l1_City:'NAME');
025800210910           l1_State = EdtString(l1_State:'NAME');
025900210910
026000210910
026100210910           //?Get the Member Plans then Write Record.
026200210910           GetMbrPlans();
026300210910           WriteMbrRcd();
026400210910           MissingPlans();
026500220104
026600220104           WriteWaive_Mbr();
026700210910
026800210910
026900210910           //?Get the Dependents...
027000210910           setll l1_ssn GBS30Dep;
027100210910           dou %eof(GBS30Dep);
027200210910             reade l1_ssn GBS30Dep;
027300210910
027400210910             if %eof(GBS30Dep);
027500210910               leave;
027600210910             endif;
027700210910
027800210910             l3_FName = EdtString(l3_FName:'NAME');
027900210910             l3_LName = EdtString(l3_LName:'NAME');
028000210910             l3_Addr1 = EdtString(l3_Addr1:'ADDR');
028100210910             l3_Addr2 = EdtString(l3_Addr2:'ADDR');
028200210910             l3_City = EdtString(l3_City:'NAME');
028300210910             l3_State = EdtString(l3_State:'NAME');
028400210910
028500210910             GetDepnPlans();
028600210910             WriteDepnRcd();
028700220104             Miss_DepPlans();
028800220104
028900210910             WriteWaive_Dep();
029000210910
029100210910
029200210910           enddo;
029300210910
029400210910           // Any Omitted Dependents?
029500210910           Setll (pKey : eFileType : l1_ssn) GbsDiffp;
029600210910
029700210910           Dou %Eof(GbsDiffp);
029800210910             reade (pKey : eFileType : l1_ssn) GbsDiffp;
029900210910             if %eof(GbsDiffp);
030000210910               leave;
030100210910             endif;
030200210910
030300210910             if   gdFile = 'L3' and
030400210910             gdTo = 'Omitted Dependent';
030500210910
030600210910               oChgd = 'Y';
030700210910               oType  = '';
030800210910               oInfo = ' ';
030900210910
031000210910               write r_Output;
031100210910
031200210910               oChgd = 'Y';
031300210910               oType  = 'Dependent:';
031400210910               oInfo = ' ** Dependent Not on File: ' + %Trim( gdFrom );
031500210910               write r_Output;
031600210910             EndIf;
031700210910
031800210910
031900210910           Enddo;
032000210910
032100210910
032200210910           oType  = *Blanks;
032300210910           oInfo  = *Blanks;
032400210910           write r_Output;
032500210910         enddo;
032600210910
032700210910       end-proc;
032800210910       //-----------------------------------------------------------
032900210910       dcl-proc GetMbrPlans;
033000220104
033100210910         Rcd_Level = 'L2';
033200210910         PlnCnt = 0;
033300220104         Print_WaiveInfo = '';
033400210910
033500210910         setll l1_ssn GBS30MCov;
033600210910         dou %eof(GBS30MCov);
033700210910           reade l1_ssn GBS30MCov;
033800210910
033900210910           if %eof(GBS30MCov);
034000210910             leave;
034100210910           endif;
034200210910
034300210910           PlnCnt = PlnCnt + 1;
034400210910           PlanArry(PlnCnt) = l2_plan;
034500210910           ChgdArry(plnCnt) = '';
034600210910           oChgd = '';
034700210910
034800210910           Select;
034900210910           When l2_enrl = 'P00';
035000210910             l2_Enrl = 'IN';
035100210910           When l2_enrl = 'F00';
035200210910             l2_Enrl = 'HW';
035300210910           When l2_enrl = 'P99';
035400210910             l2_Enrl = 'P2';
035500210910           When l2_enrl = 'F99';
035600210910             l2_Enrl = 'FA';
035700210910           When l2_enrl = 'P01';
035800210910             l2_Enrl = 'FC';
035900210910           Endsl;
036000210910           EnrlArry(PlnCnt) = l2_enrl;
036100210910
036200210910
036300210910           EffDtArry(PlnCnt) = %Subst(l2_effdt:5:2) +'/'+
036400210910             %Subst(l2_effdt:7:2) +'/'+
036500210910           %Subst(l2_effdt:1:4) ;
036600210910
036700210910           TermDtArry(PlnCnt) = '';
036800210910           if l2_termdt > '';
036900210910             TermDtArry(PlnCnt) = %Subst(l2_termdt:5:2) +'/'+
037000210910               %Subst(l2_termdt:7:2) +'/'+
037100210910             %Subst(l2_termdt:1:4) ;
037200210910
037300210910           endif;
037400210910
037500210910
037600210910           VolAmtArry(PlnCnt) = *Blanks;
037700210910           if l2_VolAmt > '' and l2_VolAmt <> '00000000.00';
037800210910             VolAmt$ = %Dec( l2_VolAmt : 11 : 0 );
037900210910             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
038000210910           endif;
038100210910
038200210910
038300210910           //?FSA Amount
038400210910           FSAAnnArry(PlnCnt) = *Blanks;
038500210910           FSAPPArry(PlnCnt) = *Blanks;
038600210910           if l2_fsa_ann > '' and l2_fsa_ann <> '0.00';
038700210910             FSAAmt$ = %Dec( l2_fsa_Ann : 7 : 2 );
038800210910             FSAAnnArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
038900210910
039000210910
039100210910             if l2_fsa_pp > '';
039200210910               FSAAmt$ = %Dec( l2_fsa_pp : 6 : 2 );
039300210910               FSAPPArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
039400210910             endif;
039500210910
039600210910             pHasFSA = 'Y';
039700210910           endif;
039800210910
039900210910           CovgArry( PlnCnt ) = l2_CovgTp;
040000210910           Pcp#Arry( PlnCnt ) = l2_Pcp#;
040100210910           PcpNmArry( PlnCnt ) = l2_PcpName;
040200210910           PcpEfDtArry( PlnCnt ) = l2_PcpEfDt;
040300210910           PcpTmDtArry( PlnCnt ) = l2_PcptmDt;
040400210910
040500210910           //---------------------------------------
040600210910           // Check if Any of the plan information
040700210910           // has been changed.
040800210910           //---------------------------------------
040900210910
041000210910           if pEnvir = 'P';
041100210910
041200210910             Check_Field = 'NEWPLAN';
041300210910             Check_History();
041400210910             ChgdArry(plnCnt) = oChgd;
041500210910
041600210910             Check_Field = 'EFFDT';
041700210910             Check_History();
041800210910             ChgdArry(plnCnt) = oChgd;
041900210910
042000210910             if oChgd = '';
042100210910               Check_Field = 'TERMDT';
042200210910               Check_History();
042300210910               ChgdArry(plnCnt) = oChgd;
042400210910             endif;
042500210910
042600210910             if oChgd = '';
042700210910               Check_Field = 'ENRL';
042800210910               Check_History();
042900210910               ChgdArry(plnCnt) = oChgd;
043000210910             endif;
043100210910
043200210910             if oChgd = '';
043300210910               Check_Field = 'FSAANN';
043400210910               Check_History();
043500210910               ChgdArry(plnCnt) = oChgd;
043600210910             endif;
043700210910
043800210910             if oChgd = '';
043900210910               Check_Field = 'FSAPP';
044000210910               Check_History();
044100210910               ChgdArry(plnCnt) = oChgd;
044200210910             endif;
044300210910
044400210910             if oChgd = '';
044500210910               Check_Field = 'VOLAMT';
044600210910               Check_History();
044700210910               ChgdArry(plnCnt) = oChgd;
044800210910             endif;
044900210910
045000210910             if oChgd = '';
045100210910               Check_Field = 'COVGTP';
045200210910               Check_History();
045300210910               ChgdArry(plnCnt) = oChgd;
045400210910             endif;
045500210910
045600210910             if oChgd = '';
045700210910               Check_Field = 'PCP#';
045800210910               Check_History();
045900210910               ChgdArry(plnCnt) = oChgd;
046000210910             endif;
046100210910
046200210910             if oChgd = '';
046300210910               Check_Field = 'PCPNAME';
046400210910               Check_History();
046500210910               ChgdArry(plnCnt) = oChgd;
046600210910             endif;
046700210910
046800210910             if oChgd = '';
046900210910               Check_Field = 'PCPEFDT';
047000210910               Check_History();
047100210910               ChgdArry(plnCnt) = oChgd;
047200210910             endif;
047300210910
047400210910             if oChgd = '';
047500210910               Check_Field = 'PCPTMDT';
047600210910               Check_History();
047700210910               ChgdArry(plnCnt) = oChgd;
047800210910             endif;
047900210910
048000220107             if oChgd = '';
048100220107               Check_Field = 'QUALEVT';
048200220107               Check_History();
048300220107               ChgdArry(plnCnt) = oChgd;
048400220107             endif;
048500220107
048600220107             if oChgd = '';
048700220107               Check_Field = 'QEDATE';
048800220107               Check_History();
048900220107               ChgdArry(plnCnt) = oChgd;
049000220107             endif;
049100220107
049200220107             if oChgd = '';
049300220107               Check_Field = 'QEDESCR';
049400220107               Check_History();
049500220107               ChgdArry(plnCnt) = oChgd;
049600220107             endif;
049700210910           endif;
049800210910
049900210910
050000210910
050100210910         enddo;
050200210910
050300210910
050400210910       End-proc;
050500210910       //---------------------------------------------------------
050600210910       Dcl-proc WriteMbrRcd;
050700210910
050800210913         dcl-s smLocation Char(4);
050900220214         dcl-s pos zoned(5);
051000210913
051100210910         wSSNChar = %Scanrpl('-': '' : l1_ssn );
051200210910         wSSN = %Dec( wSSNChar : 9 : 0 );
051300210910         Rcd_Level = 'L1';
051400210910
051500210910
051600210910         //-----------------------
051700210910         // Member SSN
051800210910         //-----------------------
051900210910         oType  = 'Member:';
052000210910         oInfo  = %Subst(l1_ssn:1:3) + '-'+ %Subst(l1_ssn:4:2) + '-'+
052100210910         %Subst(l1_ssn:6:4);
052200210910
052300210910         if pEnvir = 'P';
052400210910           oChgd = '';
052500210910           Check_Field = '*Any';
052600210910           Check_History();
052700210910         endif;
052800210910
052900210910         if Skip_Name = 'N';
053000210910           write r_Output ;
053100210910         endif;
053200210910
053300210910
053400210910         //-----------------------
053500210910         // Member Name
053600210910         //-----------------------
053700210910         oType  = *Blanks;
053800210910         oInfo  = %trim(l1_lname) + ', ' + %trim(l1_fname) + ' ' + L1_mi;
053900210910
054000210910         if pEnvir = 'P';
054100210910           oChgd = '';
054200210910           Check_Field = '*Any';
054300210910           Check_History();
054400210910         endif;
054500210910
054600210910         if Skip_Name = 'N';
054700210910           write r_Output ;
054800210910         endif;
054900210910
055000210910
055100220211
055200220211         //-----------------------
055300220211         // Salary
055400220211         //-----------------------
055500220214         //  if l1_sal > *Blanks;
055600220214         //    oInfo  = 'Salary: ' + l1_Sal;
055700220214         //
055800220214         //    if pEnvir = 'P';
055900220214         //      oChgd = '';
056000220214         //      Check_Field = 'SAL';
056100220214         //      Check_History();
056200220214         //    endif;
056300220214         //
056400220214         //    write r_Output ;
056500220214         //
056600220214         //
056700220214         //    wSalary = %Dec( %Trim( l1_Sal ) : 9 : 2 );
056800220214         //    Exec Sql
056900220214         //      Select Round(:Wsalary)
057000220214         //        Into :Wsalary
057100220214         //        From Sysibm.Sysdummy1;
057200220214         //
057300220214         //    chain wSSN Member;
057400220214         //    if %Found( Member );
057500220214         //      if wSalary <> Salary;
057600220214         //        oInfo = '** Salary does not match our system. ' +
057700220214         //          'Current Value: ' +  %editc( Salary: '1') ;
057800220214         //        write r_output;
057900220214         //      EndIf;
058000220214         //    EndIf;
058100220214         //    EndIf;
058200220211
058300220211
058400210910         //-----------------------
058500210910         // Address Line 1
058600210910         //-----------------------
058700210910         oInfo  = %trim(l1_Addr1);
058800210910
058900210910         if pEnvir = 'P';
059000210910           oChgd = '';
059100210910           Check_Field = 'ADDR1';
059200210910           Check_History()  ;
059300210910         endif;
059400210910
059500210910         write r_Output ;
059600210910
059700210910
059800210910         //-----------------------
059900210910         // Address Line 2
060000210910         //-----------------------
060100210910         if l1_addr2 > *Blanks;
060200210910           oInfo  = %trim(l1_Addr2);
060300210910
060400210910           if pEnvir = 'P';
060500210910             oChgd = '';
060600210910             Check_Field = 'ADDR2';
060700210910             Check_History()  ;
060800210910           endif;
060900210910
061000210910           write r_Output ;
061100210910         endif;
061200210910
061300210910         //-----------------------
061400210910         // City, State Zip
061500210910         //-----------------------
061600210910         oInfo  = %trim(l1_City) + ', ' + %trim(l1_State) + '  ' +
061700210910           %trim(l1_Zip);
061800210910
061900210910         if pEnvir = 'P';
062000210910           oChgd = '';
062100210910           Check_Field = 'CITY';
062200210910           Check_History();
062300210910           Check_Field = 'STATE';
062400210910           Check_History();
062500210910           Check_Field = 'ZIP';
062600210910           Check_History();
062700210910         endif;
062800210910
062900210910         write r_Output ;
063000210910
063100210910
063200210910         //-----------------------
063300210910         // Email Address
063400210910         //-----------------------
063500210910         if l1_Email > '';
063600210923           oInfo  = 'Email Addr: ' + %Lower(%trim(l1_email)) ;
063700210910
063800210910           if pEnvir = 'P';
063900210910             oChgd = '';
064000210910             Check_Field = 'EMAIL';
064100210910             Check_History();
064200210910           endif;
064300210910
064400210910           write r_Output ;
064500210910         endif;
064600210910
064700210910
064800210910         //-----------------------
064900210910         // SMoker
065000210910         //-----------------------
065100210910         if l1_Smoker > '';
065200210910           oInfo  = 'Smoker: ' + %trim(l1_Smoker) ;
065300210910
065400210910
065500210910           if pEnvir = 'P';
065600210910             oChgd = '';
065700210910             Check_Field = 'SMOKER';
065800210910             Check_History();
065900210910           endif;
066000210910
066100210910           write r_Output ;
066200210910         endif;
066300210910
066400210910
066500210910         //-----------------------
066600210910         // Office / Location
066700210910         //-----------------------
066800210913         if l1_FullLoc > *Blanks;
066900210913           Office = l1_FullLoc;
067000210913
067100210923           smLocation = '';
067200210913           if %Len( %Trim( l1_FullLoc )) = 4;
067300210913             smLocation = l1_FullLoc;
067400210913           endif;
067500210913
067600210913           chain ( pKey : smLocation ) gbs0029p;
067700210910           if %Found( GBS0029P ) ;
067800210910             office = axName ;
067900210913             oInfo  = 'Office: ' + %trim(l1_FullLoc)  + ' - ' +  Office;
068000210913           else;
068100210923             oInfo  = 'Full Location: ' + %trim(l1_FullLoc) ;
068200210913
068300210910           endif;
068400210910
068500210910
068600210910           if pEnvir = 'P';
068700210910             oChgd = '';
068800210923             Check_Field = 'FULLLOC';
068900210910             Check_History();
069000210910           endif;
069100210910
069200210910           write r_Output ;
069300210910
069400210910         endif;
069500210910
069600210910
069700210910         //-----------------------
069800210910         // Term Date
069900210910         //-----------------------
070000210910         if l1_termdt > *Blanks;
070100210910           oInfo  = 'Member Termed Date: ' + l1_termdt;
070200210910
070300210910           if pEnvir = 'P';
070400210910             oChgd = '';
070500210910             Check_Field = 'TERMDT';
070600210910             Check_History();
070700210910           endif;
070800210910
070900210910           write r_Output ;
071000210910         endif;
071100210910
071200210910
071300210910         //-----------------------
071400210910         // Term Reason
071500210910         //-----------------------
071600210910         if l1_termRsn > *Blanks;
071700210910           oInfo  = 'Termed Reason: ' + l1_termrsn;
071800210910
071900210910           if pEnvir = 'P';
072000210910             oChgd = '';
072100210910             Check_Field = 'TERMRSN';
072200210910             Check_History();
072300210910           endif;
072400210910
072500210910           write r_Output ;
072600210910         endif;
072700210910
072800210910
072900210910         //-----------------------
073000210910         // Qualifed Event
073100210910         //-----------------------
073200210910         if l1_qualevt > *Blanks;
073300210910
073400210910           // EASE Information
073500210910           if %SubSt( l1_Qualevt : 1 : 8) = 'EASE_QE_';
073600210910             chain l1_Qualevt EaseQeL1;
073700210910
073800210910             if %Found( EaseQeL1 );
073900210910               oInfo  = 'Qualifed Event: ' + q_Descr;
074000210910             endif;
074100210910
074200210910           else;
074300210910
074400210910             oInfo  = 'Qualifed Event: ' + l1_Qualevt;
074500210910           EndIf;
074600210910
074700210910           if pEnvir = 'P';
074800210910             oChgd = '';
074900210910             Check_Field = 'QUALEVT';
075000210910             Check_History();
075100210910           endif;
075200210910
075300210910           write r_Output ;
075400210910         endif;
075500210910
075600210910
075700211220         if l1_qeDescr > '';
075800211220
075900220107           oInfo  = 'Qualifed Event Descr:' + l1_qeDescr;
076000211220
076100211220           if pEnvir = 'P';
076200211220             oChgd = '';
076300211220             Check_Field = 'QUALRSN';
076400211220             Check_History();
076500211220           endif;
076600211220
076700211220           write r_Output ;
076800211220         endif;
076900211220
077000211220
077100210910         //-----------------------
077200210910         // Gender
077300210910         //-----------------------
077400210910         oInfo  = 'Gender: ' + l1_gender;
077500210910
077600210910         if pEnvir = 'P';
077700210910           oChgd = '';
077800210910           Check_Field = 'GENDER';
077900210910           Check_History();
078000210910         endif;
078100210910
078200210910         write r_Output ;
078300210910
078400210910
078500210910         //-----------------------
078600210910         // Maritial Status
078700210910         //-----------------------
078800210910         if l1_marSts > *Blanks;
078900210910           Select;
079000220302           when l1_Marsts = 'B';
079100220302             oInfo  = 'Marital Status: Domestic Partner';
079200220302           when l1_Marsts = 'D';
079300220302             oInfo  = 'Marital Status: Divorced';
079400210910           when l1_Marsts = 'I';
079500210910             oInfo  = 'Marital Status: Single';
079600210910           when l1_Marsts = 'M';
079700210910             oInfo  = 'Marital Status: Married';
079800210910           when l1_Marsts = 'S';
079900210910             oInfo  = 'Marital Status: Separated';
080000210910           when l1_Marsts = 'W';
080100210910             oInfo  = 'Marital Status: Widowed';
080200210910           endsl;
080300210910
080400210910           if pEnvir = 'P';
080500210910             oChgd = '';
080600210910             Check_Field = 'MARSTS';
080700210910             Check_History();
080800210910           endif;
080900210910
081000210910           write r_Output ;
081100210910         endif;
081200210910
081300210910
081400210910         //-----------------------
081500210910         // Salary
081600210910         //-----------------------
081700210910         if l1_sal > *Blanks;
081800210910           oInfo  = 'Salary: ' + l1_Sal;
081900210910
082000210910           if pEnvir = 'P';
082100210910             oChgd = '';
082200210910             Check_Field = 'SAL';
082300210910             Check_History();
082400210910           endif;
082500210910
082600210910           write r_Output ;
082700210910
082800210910
082900210910           wSalary = %Dec( %Trim( l1_Sal ) : 9 : 2 );
083000220214           Exec Sql
083100220214             Select Round(:Wsalary)
083200220214               Into :Wsalary
083300220214               From Sysibm.Sysdummy1;
083400210910
083500210910           chain wSSN Member;
083600210910           if %Found( Member );
083700210910             if wSalary <> Salary;
083800210910               oInfo = '** Salary does not match our system. ' +
083900210910                 'Current Value: ' +  %editc( Salary: '1') ;
084000210910               write r_output;
084100210910             EndIf;
084200210910           EndIf;
084300210910
084400210910
084500210910
084600210910         endif;
084700210910
084800210910
084900210910         //-----------------------
085000210910         // COBRA
085100210910         //-----------------------
085200210910         if l1_Cobra = 'Y';
085300210910           oInfo  = 'COBRA: Y';
085400210910
085500211214           if pEnvir = 'P';
085600211214             oChgd = '';
085700211214             Check_Field = 'COBRA';
085800211214             Check_History();
085900211214
086000211214
086100211214             // Show COBRA if any plan has changed.
086200211214             SearchArray = 0;
086300211214             SearchArray = %Lookup( 'Y' : ChgdArry );
086400211214             if SearchArray > 0;
086500211214               oChgd = 'Y';
086600211214             endif;
086700211214
086800211214
086900211214
087000211214           EndIf;
087100211214
087200210910
087300220107           write r_Output ;
087400210910         endif;
087500210910
087600210910
087700210910
087800210910         //-----------------------
087900210910         // Date of Change
088000210910         //-----------------------
088100210910         if l1_doc > '';
088200210910           oInfo  = 'DOC: ' + %Subst(l1_doc:5:2) +'/'+
088300210910           %Subst(l1_doc:7:2) +'/'+
088400210910             %Subst(l1_doc:1:4) ;
088500210910
088600210910           if pEnvir = 'P';
088700210910             oChgd = '';
088800210910             Check_Field = 'DOC';
088900210910             Check_History();
089000210910           endif;
089100210910
089200210910           write r_Output ;
089300210910         endif;
089400210910
089500210910
089600210910         //-----------------------
089700210910         // Date of Birth
089800210910         //-----------------------
089900210910         if l1_dob > '';
090000210910           oInfo  = 'DOB: ' + %Subst(l1_dob:5:2) +'/'+
090100210910           %Subst(l1_dob:7:2) +'/'+
090200210910             %Subst(l1_dob:1:4) ;
090300210910
090400210910           if pEnvir = 'P';
090500210910             oChgd = '';
090600210910             Check_Field = 'DOB';
090700210910             Check_History();
090800210910           endif;
090900210910
091000210910           write r_Output ;
091100210910         endif;
091200210910
091300210910
091400210910         //-----------------------
091500210910         // Date of Hire
091600210910         //-----------------------
091700210910         if l1_doh > '';
091800210910           oInfo  = 'DOH: ' + %Subst(l1_doh:5:2) +'/'+
091900210910           %Subst(l1_doh:7:2) +'/'+
092000210910             %Subst(l1_doh:1:4) ;
092100210910
092200210910           if pEnvir = 'P';
092300210910             oChgd = '';
092400210910             Check_Field = 'DOH';
092500210910             Check_History();
092600210910           endif;
092700210910
092800210910           write r_Output ;
092900210910         endif;
093000210910
093100210910
093200210910         //-----------------------
093300210910         // Class
093400210910         //-----------------------
093500210910         if l1_Class > '';
093600210910
093700210910           // EASE Information
093800210910           if %SubSt( l1_Class : 1 : 1) = '^';
093900210910             chain (wTrst : wSub : wAcct : l1_Class) EaseClasL1;
094000210910
094100210910             if %Found( EaseClasL1 );
094200210910               oInfo  = 'Class: ' + c_Descr;
094300210910             endif;
094400210910
094500210910           else;
094600210910
094700210910             oInfo  = 'Class: ' + l1_Class;
094800210910           EndIf;
094900210910
095000210910           if pEnvir = 'P';
095100210910             oChgd = '';
095200210910             Check_Field = 'CLASS';
095300210910             Check_History();
095400210910           endif;
095500210910
095600210910           write r_Output ;
095700210910         endif;
095800210910
095900210910
096000210910
096100210910         //-----------------------
096200210910         // Phone
096300210910         //-----------------------
096400210910         if l1_phone > '';
096500210910           oInfo  = 'Phone: ' + l1_Phone;
096600210910
096700210910           if pEnvir = 'P';
096800210910             oChgd = '';
096900210910             Check_Field = 'PHONE';
097000210910             Check_History();
097100210910           endif;
097200210910
097300210910           write r_Output ;
097400210910         endif;
097500210910
097600210910
097700210910         //-----------------------
097800210910         // Med_Adt
097900210910         //-----------------------
098000210910         if l1_Med_adt > '';
098100210910           oInfo  = 'Medicare A Date: ' +
098200210910           %Subst(l1_Med_adt:5:2) +'/'+
098300210910             %Subst(l1_Med_adt:7:2) +'/'+
098400210910             %Subst(l1_Med_adt:1:4) ;
098500210910
098600210910           if pEnvir = 'P';
098700210910             oChgd = '';
098800210910             Check_Field = 'MED_ADT';
098900210910             Check_History();
099000210910           endif;
099100210910
099200210910           write r_Output ;
099300210910         endif;
099400210910
099500210910
099600210910         //-----------------------
099700210910         // Med_Bdt
099800210910         //-----------------------
099900210910         if l1_Med_bdt > '';
100000210910           oInfo  = 'Medicare B Date: ' +
100100210910           %Subst(l1_Med_bdt:5:2) +'/'+
100200210910             %Subst(l1_Med_bdt:7:2) +'/'+
100300210910             %Subst(l1_Med_bdt:1:4) ;
100400210910
100500210910           if pEnvir = 'P';
100600210910             oChgd = '';
100700210910             Check_Field = 'MED_BDT';
100800210910             Check_History();
100900210910           endif;
101000210910
101100210910           write r_Output ;
101200210910         endif;
101300210910
101400210910
101500210910         //-----------------------
101600210910         // Med_Cdt
101700210910         //-----------------------
101800210910         if l1_Med_cdt > '';
101900210910           oInfo  = 'Medicare C Date: ' +
102000210910           %Subst(l1_Med_cdt:5:2) +'/'+
102100210910             %Subst(l1_Med_cdt:7:2) +'/'+
102200210910             %Subst(l1_Med_cdt:1:4) ;
102300210910
102400210910           if pEnvir = 'P';
102500210910             oChgd = '';
102600210910             Check_Field = 'MED_CDT';
102700210910             Check_History();
102800210910           endif;
102900210910
103000210910           write r_Output ;
103100210910         endif;
103200210910
103300210910
103400210910         //-----------------------
103500210910         // Med_Ddt
103600210910         //-----------------------
103700210910         if l1_Med_ddt > '';
103800210910           oInfo  = 'Medicare D Date: ' +
103900210910           %Subst(l1_Med_ddt:5:2) +'/'+
104000210910             %Subst(l1_Med_ddt:7:2) +'/'+
104100210910             %Subst(l1_Med_ddt:1:4) ;
104200210910
104300210910           if pEnvir = 'P';
104400210910             oChgd = '';
104500210910             Check_Field = 'MED_DDT';
104600210910             Check_History();
104700210910           endif;
104800210910
104900210910           write r_Output ;
105000210910         endif;
105100210910
105200210910
105300210910
105400210910         //-----------------------
105500210910         // Cost Center
105600210910         //-----------------------
105700210910         if l1_CostCtr > '' ;
105800210910           oInfo  = 'Cost Center: ' + %Trim( l1_CostCtr) ;
105900210910
106000210910           // EASE Information
106100210910           if %SubSt( l1_CostCtr : 1 : 8) = 'EASE_CC_';
106200210910             chain (wTrst : wSub : wAcct : l1_CostCtr ) EaseCostL1;
106300210910
106400210910             if %Found( EaseCostL1 );
106500210910               oInfo  = 'Cost Center: ' + d_Descr;
106600210910             endif;
106700210910
106800210910           EndIf;
106900210910
107000210910           if pEnvir = 'P';
107100210910             oChgd = '';
107200210910             Check_Field = 'COSTCTR';
107300210910             Check_History();
107400210910           endif;
107500210910
107600210910           write r_Output ;
107700211028
107800211028
107900211028
108000211028           // Get the Amwins Cost Center
108100211028           chain (wTrst : wSub : wAcct : l1_CostCtr ) ccntrxRefp;
108200211028           if %Found( ccntrxRefp );
108300211214             oInfo  = 'Amwins Cost Center: ' + pcAmcntr;
108400211214             write r_Output ;
108500211028           EndIf;
108600211028
108700220214         endif;
108800220211
108900220211         //-----------------------
109000220211         // Job Title
109100220211         //-----------------------
109200220211         if l1_JobTitl > '';
109300220211           oInfo  = 'Job Title: ' + %Trim( l1_JobTitl );
109400220211
109500220211           if pEnvir = 'P';
109600220211             oChgd = '';
109700220211             Check_Field = 'JOBTITL';
109800220211             Check_History();
109900220211           endif;
110000220211
110100220211           write r_Output ;
110200220211         endif;
110300220211
110400220211
110500220211
110600220211         //-----------------------
110700220211         // Race
110800220211         //-----------------------
110900220211         if l1_Race > '';
111000220211           oInfo  = 'Race: ' + %Trim( l1_Race );
111100220211
111200220211           if pEnvir = 'P';
111300220211             oChgd = '';
111400220211             Check_Field = 'RACE';
111500220211             Check_History();
111600220211           endif;
111700220211
111800220211           write r_Output ;
111900220211         endif;
112000220211
112100220307         //-----------------------
112200220307         // Pay Frequency
112300220307         //-----------------------
112400220307         if l1_PayFrq > '';
112500220307           oInfo  = 'Pay Frequency: ' + %Trim( l1_PayFrq );
112600220307
112700220307           // Look up the Code.
112800220307           CodeType = 'PAYFREQ';
112900220307           chain ( CodeType : l1_PayFrq ) Code20p;
113000220307           if %Found( Code20p );
113100220307             oInfo  = 'Pay Frequency: ' + %Trim( C20LDESC );
113200220307           endif;
113300220307
113400220307
113500220307           if pEnvir = 'P';
113600220307             oChgd = '';
113700220307             Check_Field = 'PAYFRQ';
113800220307             Check_History();
113900220307           endif;
114000220307
114100220307           write r_Output ;
114200220307         endif;
114300220307
114400220307         //-----------------------
114500220307         // Pay Periods
114600220307         //-----------------------
114700220307         if l1_PayFrq > '';
114800220307           oInfo  = 'Pay Periods: ' + %Trim( l1_PayPer );
114900220307
115000220307           if pEnvir = 'P';
115100220307             oChgd = '';
115200220307             Check_Field = 'PAYPER';
115300220307             Check_History();
115400220307           endif;
115500220307
115600220307           write r_Output ;
115700220307         endif;
115800220307
115900220211
116000220211         //-----------------------
116100220211         // QE Reason
116200220211         //-----------------------
116300220211         if l1_QeDescr > '';
116400220211           oInfo  = 'QE Description: ' + %Trim( l1_qeDescr );
116500220211
116600220211           if pEnvir = 'P';
116700220211             oChgd = '';
116800220211             Check_Field = 'QUALRSN';
116900220211             Check_History();
117000220211           endif;
117100220211
117200220211           write r_Output ;
117300220211         endif;
117400220211
117500220211
117600220214         // Check for Waived Members.
117700220214         pos = %lookup( 'Y' : ChgdArry );
117800220214         if pos > 0  OR  pEnvir = 'T';
117900220214
118000220214           chain wSSN Member;
118100220214           if %Found( Member );
118200220214             if Empst = 'W';
118300220214               oInfo = '** Member in WAIVED Status in GENIE';
118400220214               oChgd = 'Y';
118500220214               write r_output;
118600220214             EndIf;
118700220214           EndIf;
118800220214
118900220214         EndIf;
119000220214
119100220214
119200210910
119300210910         //-----------------------
119400210910         // Plans
119500210910         //-----------------------
119600210910         for i = 1 to 26;
119700210910
119800210910           if PlanArry(i) = *Blanks;
119900210910             iter;
120000210910           endif;
120100210910
120200210910
120300210910           // Production = If is no changes in a plan, skip.
120400210910           //if pEnvir = 'P';
120500210910           //  if ChgdArry( i ) = '';
120600210910           //    iter;
120700210910           //  EndIf;
120800210910           // EndIf;
120900210910
121000210910
121100210910
121200210910           eoi_plan = planArry(i);
121300210910           PlanDesc = *Blanks;
121400210910
121500210910           if %len(%Trim(PlanArry(i))) = 4;
121600210910             chain (wTrst : wSub : PlanArry(i)) PlnMst;
121700210910             if %Found( PlnMst );
121800210910               PlanDesc = pDescr;
121900210910             endif;
122000210910           endif;
122100210910
122200210910
122300210910           // EASE Information
122400210910           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
122500210910             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
122600210910
122700210910             if %Found( EasePlanL1 );
122800210910               oInfo  = 'Plan: ' + %trim(p_PlanName);
122900210910
123000210910               if TermDtArry(i) = '';
123100210910                 oInfo = %Trim( oInfo ) +
123200210910                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
123300210910               EndIf;
123400210910
123500210910               eoi_Plan = p_PlanName;
123600210910             else;
123700210910
123800210910               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
123900210910               if TermDtArry(i) = '';
124000210910                 oInfo = %Trim( oInfo ) +
124100210910                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
124200210910               EndIf;
124300210910
124400210910             endif;
124500210910           else;
124600210910
124700210910             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
124800210910             if TermDtArry(i) = '';
124900210910               oInfo = %Trim( oInfo ) +
125000210910                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
125100210910             EndIf;
125200210910           EndIf;
125300210910
125400210910
125500210910           if TermDtArry(i) = '';
125600210910             if EnrlArry(i) > '';
125700210910               oInfo = %Trim(oInfo) + '  Enrollment Lvl: ' + EnrlArry(i);
125800210910             endif;
125900210910
126000210910
126100210910             if VolAmtArry(i) > '';
126200210910               oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
126300210910
126400210910               // Check for EASE EOI Amount.
126500210910               eoi_ssn = %Editc( wSSN : 'X' );
126600210910               chain ( wTrst : wSub : wAcct : eoi_ssn :
126700210910               l1_fname : l1_dob : eoi_Plan ) EaseEOI;
126800210910               if %Found( EaseEoi );
126900210910                 oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
127000210910                   %trim(I_REQAMT) ;
127100210910
127200210910               EndIf;
127300210910
127400210910             endif;
127500210910
127600210910
127700210910             if FSAAnnArry(i) > '';
127800210910               oInfo = %Trim(oInfo) + '  FSA Annual Amt: ' + FSAAnnArry(i);
127900210910               oInfo = %Trim(oInfo) + '  FSA Per Pay: ' + FSAPPArry(i);
128000210910             endif;
128100210910
128200210910           endif;
128300210910
128400210910           oChgd = ChgdArry( i );
128500210910           write r_Output ;
128600210910
128700210910           if TermDtArry(i) > *Blanks;
128800210910             oInfo  = 'Term Date: ' + %trim(TermDtArry(i)) ;
128900210910
129000210910             oChgd = ChgdArry( i );
129100210910             write r_Output ;
129200210910           endif;
129300210910
129400210910
129500210910           if CovgArry(i) > *Blanks;
129600210910             oInfo  = 'Coverage Type: ' + %trim(CovgArry(i)) ;
129700210910             oChgd = ChgdArry( i );
129800210910             write r_Output ;
129900210910           endif;
130000210910
130100210910
130200210910           if PCP#Arry(i) > *Blanks;
130300210910             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
130400210910             oChgd = ChgdArry( i );
130500210910             write r_Output ;
130600210910           endif;
130700210910
130800210910
130900210910           if PCPNmArry(i) > *Blanks;
131000210910             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
131100210910             oChgd = ChgdArry( i );
131200210910             write r_Output ;
131300210910           endif;
131400210910
131500210910
131600210910           if PCPEfDtArry(i) > *Blanks;
131700210910             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
131800210910             oChgd = ChgdArry( i );
131900210910             write r_Output ;
132000210910           endif;
132100210910
132200210910
132300210910           if PCPTMDtArry(i) > *Blanks;
132400210910             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
132500210910             oChgd = ChgdArry( i );
132600210910             write r_Output ;
132700210910           endif;
132800210910
132900220107
133000210910         endfor;
133100210910
133200210910
133300210910         Clear PlanArry;
133400210910         Clear EnrlArry;
133500210910         Clear EffDtArry;
133600210910         Clear TermDtArry;
133700210910
133800210910         Clear CovgArry;
133900210910         Clear Pcp#Arry;
134000210910         Clear PcpNmArry;
134100210910         Clear pcpEfDtArry;
134200210910         Clear pcpTMdtArry;
134300220107
134400210910
134500210910
134600210910       End-proc;
134700210910       //-----------------------------------------------------------
134800210910       Dcl-proc GetDepnPlans;
134900210910
135000210910         PlnCnt = 0;
135100210910         Rcd_Level = 'L4';
135200220104         Print_WaiveInfo = '';
135300210910
135400210910         setll  (l3_partssn : l3_depseq#) GBS30DCov;
135500210910         dou %eof(GBS30DCov);
135600210910           reade  (l3_partssn : l3_depseq#) GBS30DCov;
135700210910
135800210910           if %eof(GBS30DCov);
135900210910             leave;
136000210910           endif;
136100210910
136200210910           PlnCnt = PlnCnt + 1;
136300210910           PlanArry(PlnCnt) = l4_plan;
136400210910           ChgdArry(plnCnt) = '';
136500210910           oChgd = '';
136600210910
136700210910           EffDtArry(PlnCnt) = %Subst(l4_effdt:5:2) +'/'+
136800210910           %Subst(l4_effdt:7:2) +'/'+
136900210910           %Subst(l4_effdt:1:4) ;
137000210910
137100210910           TermDtArry(PlnCnt) = '';
137200210910           if l4_termdt > '';
137300210910             TermDtArry(PlnCnt) = %Subst(L4_termdt:5:2) +'/'+
137400210910             %Subst(L4_termdt:7:2) +'/'+
137500210910               %Subst(L4_termdt:1:4) ;
137600210910           endif;
137700210910
137800210910
137900210910           TermRsnArry(PlnCnt) = l4_TermRsn;
138000210910           CovgArry( PlnCnt ) = l4_CovgTyp;
138100210910           Pcp#Arry( PlnCnt ) = l4_Pcp#;
138200210910           PcpNmArry( PlnCnt ) = l4_PcpName;
138300210910           PcpEfDtArry( PlnCnt ) = l4_PcpEfDt;
138400210910           PcpTmDtArry( PlnCnt ) = l4_PcptmDt;
138500210910
138600210910           VolAmtArry(PlnCnt) = *Blanks;
138700210910           if l4_VolAmt > '' and l4_VolAmt <> 'ENROLLED';
138800210910             VolAmt$ = %Dec( l4_VolAmt : 11 : 0 );
138900210910             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
139000210910           endif;
139100210910
139200210910
139300210910           //---------------------------------------
139400210910           // Check if Any of the plan information
139500210910           // has been changed.
139600210910           //---------------------------------------
139700210910
139800210910           if pEnvir = 'P';
139900210910             Check_Field = 'EFFDT';
140000210910             Check_History();
140100210910             ChgdArry(plnCnt) = oChgd;
140200210910
140300210910             if oChgd = '';
140400210910               Check_Field = 'TERMDT';
140500210910               Check_History();
140600210910               ChgdArry(plnCnt) = oChgd;
140700210910             endif;
140800210910
140900210910
141000210910             if oChgd = '';
141100210910               Check_Field = 'COVGTYP';
141200210910               Check_History();
141300210910               ChgdArry(plnCnt) = oChgd;
141400210910             endif;
141500210910
141600210910             if oChgd = '';
141700210910               Check_Field = 'PCP#';
141800210910               Check_History();
141900210910               ChgdArry(plnCnt) = oChgd;
142000210910             endif;
142100210910
142200210910             if oChgd = '';
142300210910               Check_Field = 'PCPNAME';
142400210910               Check_History();
142500210910               ChgdArry(plnCnt) = oChgd;
142600210910             endif;
142700210910
142800210910             if oChgd = '';
142900210910               Check_Field = 'PCPEFDT';
143000210910               Check_History();
143100210910               ChgdArry(plnCnt) = oChgd;
143200210910             endif;
143300210910
143400210910             if oChgd = '';
143500210910               Check_Field = 'PCPTMDT';
143600210910               Check_History();
143700210910               ChgdArry(plnCnt) = oChgd;
143800210910             endif;
143900210910
144000210910             if oChgd = '';
144100210910               Check_Field = 'VOLAMT';
144200210910               Check_History();
144300210910               ChgdArry(plnCnt) = oChgd;
144400210910             endif;
144500210910
144600210910             if oChgd = '';
144700210910               Check_Field = 'TERMRSN';
144800210910               Check_History();
144900210910               ChgdArry(plnCnt) = oChgd;
145000210910             endif;
145100220107
145200220107             if oChgd = '';
145300220107               Check_Field = 'QUALEVT';
145400220107               Check_History();
145500220107               ChgdArry(plnCnt) = oChgd;
145600220107             endif;
145700220107
145800220107             if oChgd = '';
145900220107               Check_Field = 'QEDATE';
146000220107               Check_History();
146100220107               ChgdArry(plnCnt) = oChgd;
146200220107             endif;
146300220107
146400220107             if oChgd = '';
146500220107               Check_Field = 'QEDESCR';
146600220107               Check_History();
146700220107               ChgdArry(plnCnt) = oChgd;
146800220107             endif;
146900220107           endif;
147000220107
147100210910
147200210910         enddo;
147300210910
147400210910
147500210910       End-proc;
147600210910
147700210910       //---------------------------------------------------------
147800210910       Dcl-proc WriteDepnRcd;
147900210910
148000210910         dcl-s volPlanName Char(50);
148100210910         Rcd_Level = 'L3';
148200220104
148300210910
148400210910
148500210910         //--------------------
148600210910         // Dependent SSN
148700210910         //--------------------
148800210910         oType  = 'Dependent:';
148900210910         oInfo  = %Subst(l3_Depssn:1:3) + '-'+
149000210910           %Subst(l3_Depssn:4:2) + '-'+
149100210910           %Subst(l3_Depssn:6:4);
149200210910
149300210910         if pEnvir = 'P';
149400210910           oChgd = '';
149500210910           Check_Field = '*AnyDep';
149600210910           Check_History();
149700210910         endif;
149800210910
149900210910         if Skip_Name = 'N';
150000210910           write r_Output ;
150100210910         endif;
150200210910
150300210910
150400210910
150500210910         //--------------------
150600210910         // Dependent Name
150700210910         //--------------------
150800210910         oType  = *Blanks;
150900210910         oInfo  = %trim(l3_lname) + ', ' + %trim(l3_fname) + ' ' + l3_mi;
151000210910
151100210910         if pEnvir = 'P';
151200210910           oChgd = '';
151300210910           Check_Field = '*AnyDep';
151400210910           Check_History();
151500210910         endif;
151600210910
151700210910         if Skip_Name = 'N';
151800210910           write r_Output ;
151900210910
152000210910
152100210910           if pEnvir = 'P';
152200210910             oChgd = '';
152300210910             Check_Field = 'DEPSSN';
152400210910             Check_History();
152500210910             oType  = '';
152600210910             oInfo  = 'SSN was changed.';
152700210910             if oChgd = 'Y';
152800210910               write r_Output ;
152900210910             endif;
153000210910           endif;
153100210910         endif;
153200210910
153300210910
153400210910
153500210910
153600210910         //--------------------
153700210910         // Dependent Address 1
153800210910         //--------------------
153900210910         oInfo  = %trim(l3_Addr1);
154000210910
154100210910         if pEnvir = 'P';
154200210910           oChgd = '';
154300210910           Check_Field = 'ADDR1';
154400210910           Check_History();
154500210910         endif;
154600210910
154700210910         write r_Output ;
154800210910
154900210910
155000210910         //--------------------
155100210910         // Dependent Address 2
155200210910         //--------------------
155300210910         if l3_addr2 > *Blanks;
155400210910           oInfo  = %trim(l3_Addr2);
155500210910
155600210910           if pEnvir = 'P';
155700210910             oChgd = '';
155800210910             Check_Field = 'ADDR2';
155900210910             Check_History();
156000210910           endif;
156100210910
156200210910           write r_Output ;
156300210910         endif;
156400210910
156500210910
156600210910         //--------------------
156700210910         // City, State Zip
156800210910         //--------------------
156900210910         oInfo  = %trim(l3_City) + ', ' + %trim(l3_State) + '  ' +
157000210910           %trim(l3_Zip);
157100210910
157200210910         if pEnvir = 'P';
157300210910           oChgd = '';
157400210910           Check_Field = 'CITY';
157500210910           Check_History();
157600210910           Check_Field = 'STATE';
157700210910           Check_History();
157800210910           Check_Field = 'ZIP';
157900210910           Check_History();
158000210910         endif;
158100210910
158200210910         write r_Output ;
158300210910
158400210910
158500210910         //--------------------
158600210910         // Dependent Gender
158700210910         //--------------------
158800210910         oInfo  = 'Gender: ' + l3_gender;
158900210910
159000210910         if pEnvir = 'P';
159100210910           oChgd = '';
159200210910           Check_Field = 'GENDER';
159300210910           Check_History();
159400210910         endif;
159500210910
159600210910         write r_Output ;
159700210910
159800210910
159900210910         //--------------------
160000210910         // Relationship
160100210910         //--------------------
160200210910         Select;
160300210910         When L3_relcod = 'S';
160400210910           oInfo  = 'Relationship: Spouse';
160500210910         When L3_relcod = 'C';
160600210910           oInfo  = 'Relationship: Child';
160700210910         When L3_relcod = 'D';
160800210910           oInfo  = 'Relationship: Domestic Partner';
160900210910         Other;
161000210910           oInfo  = 'Relationship: ' + L3_relcod;
161100210910         Endsl;
161200210910
161300210910         if pEnvir = 'P';
161400210910           oChgd = '';
161500210910           Check_Field = 'RELCOD';
161600210910           Check_History();
161700210910         endif;
161800210910
161900210910         write r_Output ;
162000210910
162100210910
162200210910
162300210910         //--------------------
162400210910         // Date of Birth
162500210910         //--------------------
162600210910         if l3_dob > '';
162700210910           oInfo  = 'DOB: ' + %Subst(l3_dob:5:2) +'/'+
162800210910             %Subst(l3_dob:7:2) +'/'+
162900210910             %Subst(l3_dob:1:4) ;
163000210910
163100210910           if pEnvir = 'P';
163200210910             oChgd = '';
163300210910             Check_Field = 'DOB';
163400210910             Check_History();
163500210910           endif;
163600210910
163700210910           write r_Output ;
163800210910         endif;
163900210910
164000210910
164100210910         //-----------------------
164200210910         // COBRA
164300210910         //-----------------------
164400210910         if l3_COBRA > '';
164500210910           oInfo  = 'COBRA: ' + l3_COBRA;
164600210910
164700210910           if pEnvir = 'P';
164800210910             oChgd = '';
164900210910             Check_Field = 'COBRA';
165000210910             Check_History();
165100211214
165200211214
165300211214             // Show COBRA if any plan has changed.
165400211214             SearchArray = 0;
165500211214             SearchArray = %Lookup( 'Y' : ChgdArry );
165600211214             if SearchArray > 0;
165700211214               oChgd = 'Y';
165800211214             endif;
165900211214
166000211214
166100210910           endif;
166200210910
166300210910           write r_Output ;
166400210910         endif;
166500210910
166600210910         //-----------------------
166700210910         // Qualifed Event
166800210910         //-----------------------
166900210910         if l3_qualevt > *Blanks;
167000210910
167100211012           // EASE Information
167200211005           if %SubSt( l3_Qualevt : 1 : 8) = 'EASE_QE_';
167300211005             chain l3_Qualevt EaseQeL1;
167400211005
167500211005             if %Found( EaseQeL1 );
167600211005               oInfo  = 'Qualifed Event: ' + q_Descr;
167700211005             endif;
167800211005
167900211005           else;
168000211005
168100211005             oInfo  = 'Qualifed Event: ' + l3_Qualevt;
168200211005           EndIf;
168300211005
168400210910           if pEnvir = 'P';
168500210910             oChgd = '';
168600210910             Check_Field = 'QUALEVT';
168700210910             Check_History();
168800210910           endif;
168900210910
169000210910           write r_Output ;
169100210910         endif;
169200210910
169300210910         //--------------------
169400210910         // Qualifed Event Date
169500210910         //--------------------
169600210910         if l3_qeDate > '';
169700210910           oInfo  = 'QE Date: ' + %Subst(l3_qeDate:5:2) +'/'+
169800210910           %Subst(l3_qeDate:7:2) +'/'+
169900210910             %Subst(l3_qeDate:1:4) ;
170000210910
170100210910           if pEnvir = 'P';
170200210910             oChgd = '';
170300210910             Check_Field = 'QEDATE';
170400210910             Check_History();
170500210910           endif;
170600210910
170700210910           write r_Output ;
170800210910         endif;
170900210910
171000210910
171100210910         //-----------------------
171200210910         // Disabld
171300210910         //-----------------------
171400210910         if l3_disabld > *Blanks;
171500210910           oInfo  = 'Disabled: ' + l3_Disabld;
171600210910
171700210910           if pEnvir = 'P';
171800210910             oChgd = '';
171900210910             Check_Field = 'DISABLD';
172000210910             Check_History();
172100210910           endif;
172200210910
172300210910           write r_Output ;
172400210910         endif;
172500210910
172600210910
172700210910
172800210910
172900210910         //--------------------
173000210910         // Plans
173100210910         //--------------------
173200210910         for i = 1 to 26;
173300210910
173400210910           if PlanArry(i) = *Blanks;
173500210910             iter;
173600210910           endif;
173700210910
173800210910           // Production = If is no changes in a plan, skip.
173900210910           if pEnvir = 'P';
174000210910             if ChgdArry( i ) = '';
174100210910               iter;
174200210910             EndIf;
174300210910           EndIf;
174400210910
174500210910
174600210910           //----------------------------------------
174700210910           // PLAN  Description
174800210910           //----------------------------------------
174900210910           PlanDesc = *Blanks;
175000210910           if %len(%Trim(PlanArry(i))) = 4;
175100210910             chain (wTrst : wSub : PlanArry(i)) PlnMst;
175200210910             if %Found( PlnMst );
175300210910               PlanDesc = pDescr;
175400210910             endif;
175500210910           endif;
175600210910
175700210910           volPlanName = PlanArry(i);
175800210910
175900210910
176000210910
176100210910           //----------------------------------------
176200210910           // EASE PLAN Information
176300210910           //----------------------------------------
176400210910           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
176500210910             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
176600210910
176700210910             if %Found( EasePlanL1 );
176800210910               volPlanName = p_PlanName;
176900210910
177000210910               oInfo  = 'Plan: ' + %trim(p_PlanName);
177100210910
177200210910               if TermDtArry(i) = '';
177300210910                 oInfo = %Trim( oInfo ) +
177400210910                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
177500210910               endif;
177600210910
177700210910             else;
177800210910
177900210910               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
178000210910               %Trim(PlanDesc) ;
178100210910
178200210910               if TermDtArry(i) = '';
178300210910                 oInfo = %Trim( oInfo ) +
178400210910                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
178500210910               endif;
178600210910
178700210910             endif;
178800210910           else;
178900210910
179000210910             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
179100210910               %Trim(PlanDesc);
179200210910
179300210910             if TermDtArry(i) = '';
179400210910               oInfo = %Trim( oInfo ) +
179500210910               '   Effective Date: ' + %trim(EffDtArry(i)) ;
179600210910             endif;
179700210910           EndIf;
179800210910
179900210910
180000210910
180100210910           //--------------------
180200210910           // Term Date
180300210910           //--------------------
180400210910           if TermDtArry(i) > *Blanks;
180500210910             oInfo  = %Trim( oInfo ) +
180600210910                   '  Term Date: ' + %trim(TermDtArry(i)) ;
180700210910           endif;
180800210910
180900210910
181000210910           //--------------------
181100210910           // Term Reason ( EASE )
181200210910           //--------------------
181300210910           if TermRsnArry(i)  > '';
181400210910
181500210910             // EASE Information
181600210910             if %SubSt( l4_TermRsn : 1 : 8) = 'EASE_QE_';
181700210910               chain l4_TermRsn EaseQeL1;
181800210910
181900210910               if %Found( EaseQeL1 );
182000210910                 oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + q_Descr;
182100210910               endif;
182200210910
182300210910             else;
182400210910
182500210910               oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + l1_Qualevt;
182600210910             EndIf;
182700210910
182800210910           endif;
182900210910
183000210910
183100210910
183200210910
183300210910           //--------------------
183400210910           // Vol Amount
183500210910           //--------------------
183600210910           if VolAmtArry(i) > '';
183700210910             oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
183800210910
183900210910             // Check for EASE EOI Amount.
184000210910             eoi_ssn = %Editc( wSSN : 'X' );
184100210910             chain ( wTrst : wSub : wAcct : eoi_ssn :
184200210910               l3_Fname : l3_dob : volPlanName ) EaseEOI;
184300210910             if %Found( EaseEoi );
184400210910               oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
184500210910               %trim(I_REQAMT) ;
184600210910
184700210910             EndIf;
184800210910
184900210910           endif;
185000210910
185100210910
185200210910           //  If we are here, oChgd should be 'Y';
185300210910           oChgd = 'Y';
185400210910
185500210910           write r_Output ;
185600210910
185700220104
185800210910
185900220214           //    if QualEvtArry(i) > '';
186000220214           //      oInfo  = 'Qualified Event: ' + %trim(QualEvtArry(i)) ;
186100220214           //      oChgd = ChgdArry( i );
186200220214           //      write r_Output ;
186300220214           //    endif;
186400220214           //
186500220214           //    if QeDateArry(i) > '';
186600220214           //      oInfo  = 'QE Date: ' + %trim(QeDateArry(i)) ;
186700220214           //      oChgd = ChgdArry( i );
186800220214           //      write r_Output ;
186900220214           //    endif;
187000220214           //
187100220214           //    if QeDescrArry(i) > '';
187200220214           //      oInfo  = 'QE Description: ' + %trim(QeDescrArry(i)) ;
187300220214           //      oChgd = ChgdArry( i );
187400220214           //      write r_Output ;
187500220214           //    endif;
187600220107
187700210910
187800210910           //--------------------
187900210910           // PCP Information
188000210910           //--------------------
188100210910           if PCP#Arry(i) > *Blanks;
188200210910             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
188300210910             write r_Output ;
188400210910           endif;
188500210910
188600210910
188700210910           if PCPNmArry(i) > *Blanks;
188800210910             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
188900210910             write r_Output ;
189000210910           endif;
189100210910
189200210910
189300210910           if PCPEfDtArry(i) > *Blanks;
189400210910             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
189500210910             write r_Output ;
189600210910           endif;
189700210910
189800210910
189900210910           if PCPTMDtArry(i) > *Blanks;
190000210910             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
190100210910             write r_Output ;
190200210910           endif;
190300210910
190400210910
190500210910           if Get_PlanxRef;
190600210910
190700210910             // Write out AmWins Plan Id's
190800210910             Setll ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
190900210910
191000210910             Dou %Eof(PlanxRefp);
191100210910               reade ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
191200210910               if %eof(PlanxRefp);
191300210910                 leave;
191400210910               endif;
191500210910
191600210910               oInfo = 'Amwins Plan id: ' + pxPlanId;
191700210910               write r_Output;
191800210910
191900210910             Enddo;
192000210910
192100210910           endif;
192200210910
192300210910         endfor;
192400210910
192500210910
192600210910         Clear PlanArry;
192700210910         Clear EnrlArry;
192800210910         Clear EffDtArry;
192900210910         Clear TermDtArry;
193000210910
193100210910         Clear CovgArry;
193200210910         Clear Pcp#Arry;
193300210910         Clear PcpNmArry;
193400210910         Clear pcpEfDtArry;
193500210910         Clear pcpTmDtArry;
193600210910
193700220107
193800210910       End-proc;
193900210910
194000210910
194100210910       //---------------------------------------------------------
194200210910       Dcl-proc WriteWaive_Mbr;
194300210910
194400210910         setll ( wTrst : wSub : wAcct
194500210910                    : l1_ssn: ' ' :  l1_FName ) EaseWaive;
194600210910
194700210910         Dou %Eof(EaseWaive);
194800210910           Reade ( wTrst : wSub : wAcct :
194900210910                      l1_ssn: ' ' : l1_FName ) EaseWaive;
195000210910           if %eof(EaseWaive);
195100210910             leave;
195200210910           endif;
195300210910
195400210910           oType  = *Blanks;
195500210910           oInfo  = 'Waived Plan: ' + %Trim( W_PLANTYPE ) + ' - '  +
195600210910           %Trim( W_WAIVERSN );
195700210910
195800220104           oChgd = Print_WaiveInfo;
195900220104
196000210910           write r_Output ;
196100210910
196200210910         Enddo;
196300210910
196400210910
196500210910       End-Proc;
196600210910
196700210910       //---------------------------------------------------------
196800210910       Dcl-proc WriteWaive_Dep;
196900210910
197000210910         setll ( wTrst : wSub : wAcct :
197100210910                      l1_ssn:l3_depssn: l3_FName ) EaseWaive;
197200210910
197300210910         Dou %Eof(EaseWaive);
197400210910           reade ( wTrst : wSub : wAcct :
197500210910                           l1_ssn:l3_depssn: l3_FName ) EaseWaive;
197600210910           if %eof(EaseWaive);
197700210910             leave;
197800210910           endif;
197900210910
198000210910           oType  = *Blanks;
198100210910           oInfo  = 'Waived Plan: ' + %Trim( W_PLANTYPE ) + ' - '  +
198200210910           %Trim( W_WAIVERSN );
198300220104
198400220107           if oChgd = '';
198500220107             oChgd = Print_WaiveInfo;
198600220104           endif;
198700210910
198800210910           write r_Output ;
198900210910
199000210910         Enddo;
199100210910
199200210910
199300210910       End-Proc;
199400210910
199500210910      *----------------------------------------------------------------
199600210910      * Omitted Members
199700210910      *----------------------------------------------------------------
199800210910
199900210910       dcl-proc Omitted_Mbr;
200000210910
200100210910         dcl-s PrintHeader Char(1) inz('Y');
200200210910
200300210910
200400210910         // List out the members on the file.
200500210910         Setll (pKey : eFileType) GbsDiffp;
200600210910
200700210910         Dou %Eof(GbsDiffp);
200800210910           reade (pKey : eFileType) GbsDiffp;
200900210910           if %eof(GbsDiffp);
201000210910             leave;
201100210910           endif;
201200210910
201300210910           if   gdFile = 'L1' and
201400210910           gdTo = 'Omitted Member';
201500210910
201600210910             if PrintHeader = 'Y';
201700210910               PrintHEader = 'N';
201800210910               oChgd = 'Y';
201900210910               oType = 'Member:';
202000210910               oInfo = ' * * * Omitted Members * * *';
202100210910               write r_Output;
202200210910             EndIf;
202300210910
202400210910             oChgd = 'Y';
202500210910             oType = '';
202600210910             oInfo = ' ** Member Not on File: ' + %Trim( gdssn );
202700210910             write r_Output;
202800210910           EndIf;
202900210910
203000210910
203100210910         Enddo;
203200210910
203300210910
203400210910       end-proc;
203500210910
203600210910
203700210910
203800210910      *----------------------------------------------------------------
203900210910      * Check History
204000210910      *----------------------------------------------------------------
204100210910       dcl-proc Check_History;
204200210910
204300210910
204400210910         @ssn = l1_ssn;
204500210910
204600210910         if oChgd = 'Y';
204700210910           return;
204800210910         EndIf;
204900210910
205000210910
205100210910         Setll ( pKey : eFileType : @ssn ) GbsDiffp;
205200210910
205300210910         Dou %Eof(GbsDiffp);
205400210910           reade ( pKey : eFileType : @ssn ) GbsDiffp;
205500210910           if %eof(GbsDiffp);
205600210910             leave;
205700210910           endif;
205800210910
205900210910
206000210910           // *Any - If there are any changes; in any field.
206100210910           // mark it as a change..   ( Used for SSN, and Name )
206200210910
206300210910
206400210910           if Check_Field = '*Any';
206500210910             oChgd = 'Y';
206600210910             leave;
206700210910           EndIf;
206800210910
206900210910           if gdFile = 'New-Rcd';
207000210910             oChgd = 'Y';
207100210910             leave;
207200210910           EndIf;
207300210910
207400210910
207500210910
207600210910           if Check_Field = '*AnyDep' ;
207700210910
207800210913             if gdFile = 'L3' and gdUniqId = l3_depseq#;
207900210910               oChgd = 'Y';
208000210910               leave;
208100210910             EndIf;
208200210910
208300210913             if gdFile = 'L4' and gdUniqId  = l4_depseq#;
208400210910               oChgd = 'Y';
208500210910               leave;
208600210910             EndIf;
208700210910
208800220104             if gdFile = 'L4' and gdUniqId = l3_depseq#
208900220104               and gdTo = 'Missing';
209000220104               oChgd = 'Y';
209100220104               leave;
209200220104
209300220104             EndIf;
209400220104
209500220104
209600220104           EndIf;
209700210910
209800210910
209900210910
210000210910           if gdFile <> Rcd_Level;
210100210910             iter;
210200210910           EndIf;
210300210910
210400210910
210500210910           // For a new Dependent, ALL Info should be
210600210910           // listed.
210700210910           if Rcd_Level = 'L3' and
210800210910             gdField = 'New-Dep' and
210900210913             gdTo = l3_depseq#;
211000210910
211100210910             // Dont need the SSN was changed Msg
211200210910             if Check_Field <> 'DEPSSN';
211300210913               oChgd = 'Y';
211400210910             endif;
211500210910
211600210910             iter;
211700210910           endif;
211800210910
211900210910
212000210910           // Record Level 2 should have the plan id
212100210910           // in GBSDIFFP
212200210910           if Rcd_Level = 'L2' and
212300210910             l2_plan <> gdPlanId ;
212400210910             iter;
212500210910           EndIf;
212600210910
212700210910
212800210910           // For a new Dependent, ALL plans should be
212900210910           // listed.
213000210910           if Rcd_Level = 'L4' and
213100210910              gdField = 'New-Dep' and
213200210913              gdFrom = l4_depseq#;
213300210910
213400210910             oChgd = 'Y';
213500210910             iter;
213600210910
213700210910           endif;
213800210910
213900210910
214000210910           if Rcd_Level = 'L4' and
214100210910              l4_plan <> gdPlanId ;
214200210910             iter;
214300210910           EndIf;
214400210910
214500210910
214600210910           // check for new Plans.
214700210910           if gdField = 'NEWPLAN' and
214800210910              gdFrom = l2_Plan;
214900210910
215000210910             oChgd = 'Y';
215100210910             leave;
215200210910           EndIf;
215300210910
215400210910           if gdField = Check_Field and
215500210913              gdUniqId = l3_depseq# and
215600210910              Rcd_Level = 'L3' and
215700210910              Check_Field = 'DEPSSN';
215800210910
215900210910             oChgd = 'Y';
216000210910             leave;
216100210910
216200210910
216300210910           EndIf;
216400210910
216500210910
216600210910           if gdField = 'VOLAMT'
216700210910              and gdPlanId = l2_Plan
216800210910              and gdFile = 'L2';
216900210910
217000210910             oChgd = 'Y';
217100210910             leave;
217200210910
217300210910           EndIf;
217400210910
217500210910
217600210910           if gdField = 'VOLAMT'
217700210910              and gdPlanId = l4_Plan
217800210910              and gdFile = 'L4';
217900210910
218000210910             oChgd = 'Y';
218100210910             leave;
218200210910
218300210910           EndIf;
218400210910
218500210910
218600210910
218700210910           if Rcd_Level = 'L3';
218800210910             if gdField = Check_Field  and
218900210913               gdUniqId = l3_depseq#;
219000210910
219100210910
219200210910               oChgd = 'Y';
219300210910
219400210910               if gdField = 'NEWPLAN' or
219500210910                  gdField = 'DEPSSN'  or
219600210910                  gdField = 'VOLAMT';
219700210910
219800210910                 oChgd = '';
219900210910
220000210910               EndIf;
220100210910
220200210910               leave;
220300210910             EndIf;
220400210910           EndIf;
220500210910
220600210910
220700210910           // Level 4
220800210910           if Rcd_Level = 'L4';
220900210910             if gdField = Check_Field  and
221000210913               gdUniqId = l4_depseq#;
221100210910
221200210910
221300210910               oChgd = 'Y';
221400210910
221500210910               if gdField = 'NEWPLAN' or
221600210910                  gdField = 'DEPSSN'  or
221700210910                  gdField = 'VOLAMT';
221800210910
221900210910                 oChgd = '';
222000210910
222100210910               EndIf;
222200210910
222300210910               leave;
222400210910             EndIf;
222500210910           EndIf;
222600210910
222700210910
222800210910           if Rcd_Level = 'L2';
222900210910             if gdField = Check_Field  and
223000210910               gdPlanId = l2_Plan;
223100210910
223200210910               oChgd = 'Y';
223300210910               leave;
223400210910             endif;
223500210910
223600210910           EndIf;
223700210910
223800210910
223900210910           if Rcd_Level = 'L1';
224000210910             if gdField = Check_Field;
224100210910
224200210910               oChgd = 'Y';
224300210910               leave;
224400210910             endif;
224500210910
224600210910           EndIf;
224700210910
224800210910
224900211012           if Rcd_Level = 'L4';
225000211012             if gdPlanId = l4_plan  and
225100211012               gdUniqId = l4_depseq# and
225200211012               gdTo = 'New Plan';
225300211012
225400211012               oChgd = 'Y';
225500211012               leave;
225600211012             EndIf;
225700211012           EndIf;
225800210910
225900210910
226000210910         Enddo;
226100210910
226200210910
226300210910
226400210910       End-Proc;
226500210910
226600210910      *----------------------------------------------------------------
226700210910      * Missing Plans
226800210910      *----------------------------------------------------------------
226900210910
227000210910       dcl-proc MissingPlans;
227100210910
227200210910
227300210910         dcl-s PrintHeader Char(1) inz('Y');
227400210910
227500210910         // List out the members on the file.
227600210910         Setll (pKey : eFileType: l1_ssn) GbsDiffp;
227700210910
227800210910         Dou %Eof(GbsDiffp);
227900210910           reade (pKey : eFileType : l1_ssn) GbsDiffp;
228000210910           if %eof(GbsDiffp);
228100210910             leave;
228200210910           endif;
228300210910
228400210910           if   gdFile = 'L2' and
228500210910           gdTo = 'Missing';
228600210910
228700210910             if PrintHeader = 'Y';
228800210910               PrintHEader = 'N';
228900210910               oChgd = 'Y';
229000210910               oType = ' ';
229100210910               oInfo = ' * * * Omitted Plans * * *';
229200210910               write r_Output;
229300210910             EndIf;
229400210910
229500210910             oChgd = 'Y';
229600210910             oType = '';
229700220104             Print_WaiveInfo = 'Y';
229800210910
229900210910             // Check for EASE Plan
230000210910             if %SubSt( gdPlanId : 1 : 10) = 'EASE_PLAN_';
230100210910               chain (wTrst : wSub : wAcct : gdPlanId) EasePlanL1;
230200210910
230300210910               if %Found( EasePlanL1 );
230400210910                 oInfo = ' ** Plan Not on File: ' + %Trim( p_PlanName );
230500210910               else;
230600210910                 oInfo = ' ** Plan Not on File: ' + %Trim( gdPlanId );
230700210910
230800210910               endif;
230900210910
231000210910             else;
231100210910
231200210910               oInfo = ' ** Plan Not on File: ' + %Trim( gdPlanId );
231300210910
231400210910             endif;
231500210910             write r_Output;
231600210910
231700210910           endif;
231800210910         Enddo;
231900210910
232000210910
232100210910       end-proc;
232200210910
232300210910
232400210910       //-----------------------------------------------------------
232500210910       dcl-proc PrtMbrPlans;
232600210910
232700220214         dcl-s pos Zoned(5);
232800220214
232900210910         PlnCnt = 1;
233000210910         l1_ssn = s_MbrSSN;
233100210910
233200210910         Clear PlanArry;
233300210910         Clear EnrlArry;
233400210910         Clear EffDtArry;
233500210910         Clear TermDtArry;
233600210910
233700210910         Clear CovgArry;
233800210910         Clear Pcp#Arry;
233900210910         Clear PcpNmArry;
234000210910         Clear pcpEfDtArry;
234100210910         Clear pcpTMdtArry;
234200210910
234300220214
234400220214         // Check for Waived Members.
234500220214         pos = %lookup( 'Y' : ChgdArry );
234600220214         if pos > 0  OR  pEnvir = 'T';
234700220214
234800220214           chain wSSN Member;
234900220214           if %Found( Member );
235000220214             if Empst = 'W';
235100220214               oInfo = '** Member in WAIVED Status in GENIE';
235200220214               oChgd = 'Y';
235300220214               write r_output;
235400220214             EndIf;
235500220214           EndIf;
235600220214
235700220214         EndIf;
235800220107
235900220214
236000220214
236100220214
236200220214         //Print the Plans
236300210910         setll l1_ssn GBS30MCov;
236400210910         dou %eof(GBS30MCov);
236500210910           reade l1_ssn GBS30MCov;
236600210910
236700210910           if %eof(GBS30MCov);
236800210910             leave;
236900210910           endif;
237000210910
237100210910           if l2_plan <> Plan_Name;
237200210910             iter;
237300210910           EndIf;
237400210910
237500210910           PlanArry(PlnCnt) = Plan_Name;
237600210910
237700210910           Select;
237800210910           When l2_enrl = 'P00';
237900210910             l2_Enrl = 'IN';
238000210910           When l2_enrl = 'F00';
238100210910             l2_Enrl = 'HW';
238200210910           When l2_enrl = 'P99';
238300210910             l2_Enrl = 'P2';
238400210910           When l2_enrl = 'F99';
238500210910             l2_Enrl = 'FA';
238600210910           When l2_enrl = 'P01';
238700210910             l2_Enrl = 'FC';
238800210910           Endsl;
238900210910           EnrlArry(PlnCnt) = l2_enrl;
239000210910
239100210910
239200210910           EffDtArry(PlnCnt) = %Subst(l2_effdt:5:2) +'/'+
239300210910             %Subst(l2_effdt:7:2) +'/'+
239400210910           %Subst(l2_effdt:1:4) ;
239500210910
239600210910           TermDtArry(PlnCnt) = '';
239700210910           if l2_termdt > '';
239800210910             TermDtArry(PlnCnt) = %Subst(l2_termdt:5:2) +'/'+
239900210910             %Subst(l2_termdt:7:2) +'/'+
240000210910               %Subst(l2_termdt:1:4) ;
240100210910
240200210910           endif;
240300210910
240400210910
240500210910           VolAmtArry(PlnCnt) = *Blanks;
240600210910           if l2_VolAmt > '' and l2_VolAmt <> '00000000.00';
240700210910             VolAmt$ = %Dec( l2_VolAmt : 11 : 0 );
240800210910             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
240900210910           endif;
241000210910
241100210910
241200210910           //?FSA Amount
241300210910           FSAAnnArry(PlnCnt) = *Blanks;
241400210910           FSAPPArry(PlnCnt) = *Blanks;
241500210910           if l2_fsa_ann > '' and l2_fsa_ann <> '0.00';
241600210910             FSAAmt$ = %Dec( l2_fsa_Ann : 7 : 2 );
241700210910             FSAAnnArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
241800210910
241900210910
242000210910             if l2_fsa_pp > '';
242100210910               FSAAmt$ = %Dec( l2_fsa_pp : 6 : 2 );
242200210910               FSAPPArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
242300210910             endif;
242400210910
242500210910             pHasFSA = 'Y';
242600210910           endif;
242700210910
242800210910           CovgArry( PlnCnt ) = l2_CovgTp;
242900210910           Pcp#Arry( PlnCnt ) = l2_Pcp#;
243000210910           PcpNmArry( PlnCnt ) = l2_PcpName;
243100210910           PcpEfDtArry( PlnCnt ) = l2_PcpEfDt;
243200210910           PcpTmDtArry( PlnCnt ) = l2_PcptmDt;
243300210910
243400210910
243500210910         enddo;
243600210910
243700210910
243800210910
243900210910         //-----------------------
244000210910         // Plans
244100210910         //-----------------------
244200210910         for i = 1 to 1;
244300210910
244400210910           if PlanArry(i) = *Blanks;
244500210910             iter;
244600210910           endif;
244700210910
244800210910
244900210910           eoi_plan = planArry(i);
245000210910           PlanDesc = *Blanks;
245100210910
245200210910           if %len(%Trim(PlanArry(i))) = 4;
245300210910             chain (wTrst : wSub : PlanArry(i)) PlnMst;
245400210910             if %Found( PlnMst );
245500210910               PlanDesc = pDescr;
245600210910             endif;
245700210910           endif;
245800210910
245900210910
246000210910           // EASE Information
246100210910           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
246200210910             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
246300210910
246400210910             if %Found( EasePlanL1 );
246500210910               oInfo  = 'Plan: ' + %trim(p_PlanName);
246600210910
246700210910               if TermDtArry(i) = '';
246800210910                 oInfo = %Trim( oInfo ) +
246900210910                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
247000210910               EndIf;
247100210910
247200210910               eoi_Plan = p_PlanName;
247300210910             else;
247400210910
247500210910               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
247600210910               if TermDtArry(i) = '';
247700210910                 oInfo = %Trim( oInfo ) +
247800210910                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
247900210910               EndIf;
248000210910
248100210910             endif;
248200210910           else;
248300210910
248400210910             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
248500210910             if TermDtArry(i) = '';
248600210910               oInfo = %Trim( oInfo ) +
248700210910                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
248800210910             EndIf;
248900210910           EndIf;
249000210910
249100210910
249200210910           if TermDtArry(i) = '';
249300210910             if EnrlArry(i) > '';
249400210910               oInfo = %Trim(oInfo) + '  Enrollment Lvl: ' + EnrlArry(i);
249500210910             endif;
249600210910
249700210910
249800210910             if VolAmtArry(i) > '';
249900210910               oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
250000210910
250100210910               // Check for EASE EOI Amount.
250200210910               eoi_ssn = %Editc( wSSN : 'X' );
250300210910               chain ( wTrst : wSub : wAcct : eoi_ssn :
250400210910                 l1_fname : l1_dob : eoi_Plan ) EaseEOI;
250500210910               if %Found( EaseEoi );
250600210910                 oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
250700210910                   %trim(I_REQAMT) ;
250800210910
250900210910               EndIf;
251000210910
251100210910             endif;
251200210910
251300210910
251400210910             if FSAAnnArry(i) > '';
251500210910               oInfo = %Trim(oInfo) + '  FSA Annual Amt: ' + FSAAnnArry(i);
251600210910               oInfo = %Trim(oInfo) + '  FSA Per Pay: ' + FSAPPArry(i);
251700210910             endif;
251800210910
251900210910           endif;
252000210910
252100210910           oChgd = ChgdArry( i );
252200210910           write r_Output ;
252300210910
252400210910           if TermDtArry(i) > *Blanks;
252500210910             oInfo  = 'Term Date: ' + %trim(TermDtArry(i)) ;
252600210910
252700210910             oChgd = ChgdArry( i );
252800210910             write r_Output ;
252900210910           endif;
253000210910
253100210910
253200210910           if CovgArry(i) > *Blanks;
253300210910             oInfo  = 'Coverage Type: ' + %trim(CovgArry(i)) ;
253400210910             oChgd = ChgdArry( i );
253500210910             write r_Output ;
253600210910           endif;
253700210910
253800210910
253900210910           if PCP#Arry(i) > *Blanks;
254000210910             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
254100210910             oChgd = ChgdArry( i );
254200210910             write r_Output ;
254300210910           endif;
254400210910
254500210910
254600210910           if PCPNmArry(i) > *Blanks;
254700210910             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
254800210910             oChgd = ChgdArry( i );
254900210910             write r_Output ;
255000210910           endif;
255100210910
255200210910
255300210910           if PCPEfDtArry(i) > *Blanks;
255400210910             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
255500210910             oChgd = ChgdArry( i );
255600210910             write r_Output ;
255700210910           endif;
255800210910
255900210910
256000210910           if PCPTMDtArry(i) > *Blanks;
256100210910             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
256200210910             oChgd = ChgdArry( i );
256300210910             write r_Output ;
256400210910           endif;
256500210910
256600210910
256700210910
256800210910         // Write out AmWins Plan Id's
256900210910         //    Setll ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
257000210910         //
257100210910         //    Dou %Eof(PlanxRefp);
257200210910         //      reade ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
257300210910         //      if %eof(PlanxRefp);
257400210910         //        leave;
257500210910         //      endif;
257600210910         //
257700210910         //      oInfo = 'Amwins Plan id: ' + pxPlanId;
257800210910         //      write r_Output;
257900210910         //
258000210910         //    Enddo;
258100210910
258200210910
258300210910
258400210910
258500210910
258600210910
258700210910         endfor;
258800210910
258900210910
259000210910       End-proc;
259100210910
259200210910       //-----------------------------------------------------------
259300210910       dcl-proc PrtDepPlans;
259400210910
259500210910         dcl-s volPlanName Char(50);
259600210910
259700210910
259800210910         PlnCnt = 1;
259900210913         l3_depseq# = s_UniqueId;
260000210910
260100210910         Clear PlanArry;
260200210910         Clear EnrlArry;
260300210910         Clear EffDtArry;
260400210910         Clear TermDtArry;
260500210910
260600210910         Clear CovgArry;
260700210910         Clear Pcp#Arry;
260800210910         Clear PcpNmArry;
260900210910         Clear pcpEfDtArry;
261000210910         Clear pcpTMdtArry;
261100210910
261200220107
261300220107
261400210913         setll (l3_partssn : l3_depseq#) GBS30DCov;
261500210910         dou %eof(GBS30DCov);
261600210913           reade (l3_partssn : l3_depseq#) GBS30DCov;
261700210910
261800210910           if %eof(GBS30DCov);
261900210910             leave;
262000210910           endif;
262100210910
262200210910           if l4_plan <> Plan_Name;
262300210910             iter;
262400210910           EndIf;
262500210910
262600210910           PlanArry(PlnCnt) = Plan_Name;
262700210910
262800210910
262900210910
263000210910           EffDtArry(PlnCnt) = %Subst(l4_effdt:5:2) +'/'+
263100210910             %Subst(l4_effdt:7:2) +'/'+
263200210910           %Subst(l4_effdt:1:4) ;
263300210910
263400210910           TermDtArry(PlnCnt) = '';
263500210910           if l4_termdt > '';
263600210910             TermDtArry(PlnCnt) = %Subst(l4_termdt:5:2) +'/'+
263700210910             %Subst(l4_termdt:7:2) +'/'+
263800210910               %Subst(l4_termdt:1:4) ;
263900210910
264000210910           endif;
264100210910
264200210910
264300210910           VolAmtArry(PlnCnt) = *Blanks;
264400210910           if l4_VolAmt > '' and l4_VolAmt <> '00000000.00';
264500210910             VolAmt$ = %Dec( l4_VolAmt : 11 : 0 );
264600210910             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
264700210910           endif;
264800210910
264900210910
265000210910
265100210910           CovgArry( PlnCnt ) = l4_CovgTyp;
265200210910           Pcp#Arry( PlnCnt ) = l4_Pcp#;
265300210910           PcpNmArry( PlnCnt ) = l4_PcpName;
265400210910           PcpEfDtArry( PlnCnt ) = l4_PcpEfDt;
265500210910           PcpTmDtArry( PlnCnt ) = l4_PcptmDt;
265600210910
265700210910
265800210910         enddo;
265900210910
266000210910
266100210910
266200210910         //-----------------------
266300210910         // Plans
266400210910         //-----------------------
266500210910         for i = 1 to 1;
266600210910
266700210910           if PlanArry(i) = *Blanks;
266800210910             iter;
266900210910           endif;
267000210910
267100210910
267200210910           if PlanArry(i) = *Blanks;
267300210910             iter;
267400210910           endif;
267500210910
267600210910           // Production = If is no changes in a plan, skip.
267700210910           if pEnvir = 'P';
267800210910             if ChgdArry( i ) = '';
267900210910               iter;
268000210910             EndIf;
268100210910           EndIf;
268200210910
268300210910
268400210910           //----------------------------------------
268500210910           // PLAN  Description
268600210910           //----------------------------------------
268700210910           PlanDesc = *Blanks;
268800210910           if %len(%Trim(PlanArry(i))) = 4;
268900210910             chain (wTrst : wSub : PlanArry(i)) PlnMst;
269000210910             if %Found( PlnMst );
269100210910               PlanDesc = pDescr;
269200210910             endif;
269300210910           endif;
269400210910
269500210910           volPlanName = PlanArry(i);
269600210910
269700210910
269800210910
269900210910           //----------------------------------------
270000210910           // EASE PLAN Information
270100210910           //----------------------------------------
270200210910           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
270300210910             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
270400210910
270500210910             if %Found( EasePlanL1 );
270600210910               volPlanName = p_PlanName;
270700210910
270800210910               oInfo  = 'Plan: ' + %trim(p_PlanName);
270900210910
271000210910               if TermDtArry(i) = '';
271100210910                 oInfo = %Trim( oInfo ) +
271200210910                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
271300210910               endif;
271400210910
271500210910             else;
271600210910
271700210910               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
271800210910                 %Trim(PlanDesc) ;
271900210910
272000210910               if TermDtArry(i) = '';
272100210910                 oInfo = %Trim( oInfo ) +
272200210910                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
272300210910               endif;
272400210910
272500210910             endif;
272600210910           else;
272700210910
272800210910             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
272900210910               %Trim(PlanDesc);
273000210910
273100210910             if TermDtArry(i) = '';
273200210910               oInfo = %Trim( oInfo ) +
273300210910                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
273400210910             endif;
273500210910           EndIf;
273600210910
273700210910
273800210910
273900210910           //--------------------
274000210910           // Term Date
274100210910           //--------------------
274200210910           if TermDtArry(i) > *Blanks;
274300210910             oInfo  = %Trim( oInfo ) +
274400210910             '  Term Date: ' + %trim(TermDtArry(i)) ;
274500210910           endif;
274600210910
274700210910
274800210910           //--------------------
274900210910           // Term Reason ( EASE )
275000210910           //--------------------
275100210910           if TermRsnArry(i)  > '';
275200210910
275300210910             // EASE Information
275400210910             if %SubSt( l4_TermRsn : 1 : 8) = 'EASE_QE_';
275500210910               chain l4_TermRsn EaseQeL1;
275600210910
275700210910               if %Found( EaseQeL1 );
275800210910                 oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + q_Descr;
275900210910               endif;
276000210910
276100210910             else;
276200210910
276300210910               oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + l1_Qualevt;
276400210910             EndIf;
276500210910
276600210910           endif;
276700210910
276800210910
276900210910
277000210910
277100210910           //--------------------
277200210910           // Vol Amount
277300210910           //--------------------
277400210910           if VolAmtArry(i) > '';
277500210910             oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
277600210910
277700210910             // Check for EASE EOI Amount.
277800210910             eoi_ssn = %Editc( wSSN : 'X' );
277900210910             chain ( wTrst : wSub : wAcct : eoi_ssn :
278000210910               l3_Fname : l3_dob : volPlanName ) EaseEOI;
278100210910             if %Found( EaseEoi );
278200210910               oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
278300210910                 %trim(I_REQAMT) ;
278400210910
278500210910             EndIf;
278600210910
278700210910           endif;
278800210910           write r_Output ;
278900210910
279000210910
279100210910
279200210910
279300210910           //--------------------
279400210910           // PCP Information
279500210910           //--------------------
279600210910           if PCP#Arry(i) > *Blanks;
279700210910             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
279800210910             write r_Output ;
279900210910           endif;
280000210910
280100210910
280200210910           if PCPNmArry(i) > *Blanks;
280300210910             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
280400210910             write r_Output ;
280500210910           endif;
280600210910
280700210910
280800210910           if PCPEfDtArry(i) > *Blanks;
280900210910             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
281000210910             write r_Output ;
281100210910           endif;
281200210910
281300210910
281400210910           if PCPTMDtArry(i) > *Blanks;
281500210910             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
281600210910             write r_Output ;
281700210910           endif;
281800210910
281900210910
282000210910           if Get_PlanxRef;
282100210910
282200210910             // Write out AmWins Plan Id's
282300210910             Setll ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
282400210910
282500210910             Dou %Eof(PlanxRefp);
282600210910               reade ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
282700210910               if %eof(PlanxRefp);
282800210910                 leave;
282900210910               endif;
283000210910
283100210910               oInfo = 'Amwins Plan id: ' + pxPlanId;
283200210910               write r_Output;
283300210910
283400210910             Enddo;
283500210910
283600210910           endif;
283700210910
283800210910         endfor;
283900210910
284000210910
284100210910         Clear PlanArry;
284200210910         Clear EnrlArry;
284300210910         Clear EffDtArry;
284400210910         Clear TermDtArry;
284500210910
284600210910         Clear CovgArry;
284700210910         Clear Pcp#Arry;
284800210910         Clear PcpNmArry;
284900210910         Clear pcpEfDtArry;
285000210910         Clear pcpTmDtArry;
285100210910
285200210910
285300210910       End-proc;
285400210910
285500210910      *-------------------------------------------------------------------------
285600210910      *
285700210910      *
285800210910      *
285900210910      *-------------------------------------------------------------------------
286000210910BR01   dcl-proc Single_Member;
286100210910
286200210910
286300210910
286400210910         setll s_MbrSSN GBS30Mbr;
286500210910         dou %Eof(GBS30Mbr);
286600210910           reade s_MbrSSN GBS30Mbr;
286700210910
286800210910           if %eof(GBS30Mbr);
286900210910             leave;
287000210910           endif;
287100210910
287200210910           l1_FName = EdtString(l1_FName:'NAME');
287300210910           l1_LName = EdtString(l1_LName:'NAME');
287400210910           l1_Addr1 = EdtString(l1_Addr1:'ADDR');
287500210910           l1_Addr2 = EdtString(l1_Addr2:'ADDR');
287600210910           l1_City = EdtString(l1_City:'NAME');
287700210910           l1_State = EdtString(l1_State:'NAME');
287800210910
287900210910
288000210910           //?Get the Member Plans then Write Record.
288100210910           GetMbrPlans();
288200210910           WriteMbrRcd();
288300210910           WriteWaive_Mbr();
288400210910
288500210910           MissingPlans();
288600210910
288700210910
288800210910           //?Get the Dependents...
288900210910           setll l1_ssn GBS30Dep;
289000210910           dou %eof(GBS30Dep);
289100210910             reade l1_ssn GBS30Dep;
289200210910
289300210910             if %eof(GBS30Dep);
289400210910               leave;
289500210910             endif;
289600210910
289700210910             l3_FName = EdtString(l3_FName:'NAME');
289800210910             l3_LName = EdtString(l3_LName:'NAME');
289900210910             l3_Addr1 = EdtString(l3_Addr1:'ADDR');
290000210910             l3_Addr2 = EdtString(l3_Addr2:'ADDR');
290100210910             l3_City = EdtString(l3_City:'NAME');
290200210910             l3_State = EdtString(l3_State:'NAME');
290300210910
290400210910             GetDepnPlans();
290500210910             WriteDepnRcd();
290600210910             WriteWaive_Dep();
290700210910
290800210910           enddo;
290900210910
291000210910           // Any Omitted Dependents?
291100210910           Setll (pKey : eFileType : l1_ssn) GbsDiffp;
291200210910
291300210910           Dou %Eof(GbsDiffp);
291400210910             reade (pKey : eFileType : l1_ssn) GbsDiffp;
291500210910             if %eof(GbsDiffp);
291600210910               leave;
291700210910             endif;
291800210910
291900210910             if   gdFile = 'L3' and
292000210910             gdTo = 'Omitted Dependent';
292100210910
292200210910               oChgd = 'Y';
292300210910               oType  = '';
292400210910               oInfo = ' ';
292500210910
292600210910               write r_Output;
292700210910
292800210910               oChgd = 'Y';
292900210910               oType  = 'Dependent:';
293000210910               oInfo = ' ** Dependent Not on File: ' + %Trim( gdFrom );
293100210910               write r_Output;
293200210910             EndIf;
293300210910
293400210910
293500210910           Enddo;
293600210910
293700210910
293800210910           oType  = *Blanks;
293900210910           oInfo  = *Blanks;
294000210910           write r_Output;
294100210910         enddo;
294200210910
294300210910       end-proc;
294400210910
294500210910
294600210910      *-------------------------------------------------------------------------
294700210910      *
294800210910      *
294900210910      *
295000210910      *
295100210910      *-------------------------------------------------------------------------
295200210910BR01   dcl-proc Single_Dependent;
295300210910
295400210910         //?Get the Dependents...
295500210910         setll s_MbrSSN GBS30Dep;
295600210910         dou %eof(GBS30Dep);
295700210910           reade s_MbrSSN GBS30Dep;
295800210910
295900210910           if %eof(GBS30Dep);
296000210910             leave;
296100210910           endif;
296200210910
296300210913           if l3_depseq# <> s_UniqueId;
296400210910             iter;
296500210910           EndIf;
296600210910
296700210910           l3_FName = EdtString(l3_FName:'NAME');
296800210910           l3_LName = EdtString(l3_LName:'NAME');
296900210910           l3_Addr1 = EdtString(l3_Addr1:'ADDR');
297000210910           l3_Addr2 = EdtString(l3_Addr2:'ADDR');
297100210910           l3_City = EdtString(l3_City:'NAME');
297200210910           l3_State = EdtString(l3_State:'NAME');
297300210910
297400210910           GetDepnPlans();
297500210910           WriteDepnRcd();
297600210910           WriteWaive_Dep();
297700210910
297800210910         enddo;
297900210910
298000210910
298100210910       end-proc;
298200210910
298300210910
298400210910      *-------------------------------------------------------------------------
298500210910      *
298600210910      *
298700210910      *
298800210910      *
298900210910      *-------------------------------------------------------------------------
299000210910       dcl-proc Miss_DepPlans;
299100210910
299200210910         dcl-s FirstTime ind;
299300210910
299400210910         FirstTime = *on;
299500210910         @ssn = l1_ssn;
299600210910
299700210910
299800210910         Setll ( pKey : eFileType : @ssn ) GbsDiffp;
299900210910
300000210910         Dou %Eof(GbsDiffp);
300100210910           reade ( pKey : eFileType : @ssn ) GbsDiffp;
300200210910           if %eof(GbsDiffp);
300300210910             leave;
300400210910           endif;
300500210910
300600210910
300700210910           // Level 4 - Missiing Plans
300800210910           if gdField = 'PLAN'  and
300900210913              gdUniqId = l3_depseq# and
301000210913              gdto = 'Missing';
301100210910
301200210910             oChgd = 'Y';
301300220104             Print_WaiveInfo = 'Y';
301400220104
301500210910             if FirstTime;
301600210910               oType = '';
301700210910               oInfo = '';
301800210910               Write r_Output;
301900210910
302000210910               oInfo = '** Missing Plans(s) **';
302100210910               Write r_Output;
302200210910
302300210910               FirstTime = *off;
302400210910             endif;
302500210910
302600210910             oInfo = 'Plan: ' + gdPlanId;
302700210910
302800210910             // Check for Ease Plan
302900210910             if %SubSt( gdPlanId : 1 : 10) = 'EASE_PLAN_';
303000210910               chain (wTrst : wSub : wAcct : gdPlanId)  EasePlanL1;
303100210910
303200210910               if %Found( EasePlanL1 );
303300210910                 oInfo  = 'Plan: ' + %trim(p_PlanName);
303400210910               EndIf;
303500210910
303600210910             EndIf;
303700210910
303800210910             Write r_Output;
303900210910           EndIf;
304000210910
304100210910
304200210910
304300210910         Enddo;
304400210910
304500210910
304600210910
304700210910       end-proc;
