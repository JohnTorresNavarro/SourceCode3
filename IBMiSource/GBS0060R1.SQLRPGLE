000100210608
000200210510       Ctl-Opt option(*noDebugIo)  DFTACTGRP(*NO)  bnddir('GBSBIND');
000300200121
000400200106      *-------------------------------------------------------------------------
000500200106      *
000600200121      *  Description: Format the GBS 2.0 Data File
000700160708      *
000800200106      *  Programmer.: Brian Rees
000900200121      *  Date.......: 01/21/2020
001000200106      *
001100200121      *  Copied from GBS0029RB
001200200106      *-------------------------------------------------------------------------
001300200106      * Change Log
001400200106      *
001500200903      * 09/03/2020  B.Rees
001600200903      *  Added EASE Cross reference files.
001700201104      * 11/4/2020   B.Rees  Added EASE EOI Text
001800201105      * 11/5/2020   B.Rees  Added Additional Fields for EASE
001900201105      *    Med-A Date, Med-B Date, Med-C Date, Med-D Date, Cost Center.
002000201216      * 12/16/2020   B.Rees  Added Waive Records for EASE
002100210510      *  5/10/2021  Added marking ADPOutput with Changes.
002200210608      *  6/09/2021  New Routines to print out specific information from
002300210608      *  compare to iSeries programming.
002400210614      *  Mod ID:  BR01
002500210614      *
002600211028      * 10/28/2021  B.Rees   Adding Amwins Cost Center Cross Reference.
002700211206      * 12/06/2021  B.Rees   Tweaked issue where printing Cost Center 2x
002800211214      * 12/14/2021  B.Rees   If there is any plan change.. and the member
002900211214      * had selected COBRA - Show the COBRA Flag.
003000220104      * 1/4/2021    B.Rees   Issue where missing plans were not being added
003100220104      *  to the App as "Changes"
003200220214      * 2/14/2022   B.Rees   Check Member file for Wavied Status.
003300210614      *
003400200106      *-------------------------------------------------------------------------
003500170112
003600200121       dcl-f ADPOutputp keyed usage(*output);
003700200121
003800200121       dcl-f GBS20l1 keyed rename( R_GBS20P : Rec1 ) usropn;
003900200121       dcl-f GBS20l2 keyed rename( R_GBS20P : Rec2 ) usropn;
004000200121       dcl-f GBS20l3 keyed rename( R_GBS20P : Rec3 ) usropn;
004100200121       dcl-f GBS20l4 keyed rename( R_GBS20P : Rec4 ) usropn;
004200200121
004300200121       dcl-f PlnMst Keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
004400200121
004500200121       dcl-f Gbs0029P keyed; // Location Cross Reference
004600200121       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
004700200121
004800200903       dcl-f EasePlanl1 keyed;
004900200903       dcl-f EaseQEl1 keyed;
005000200904       dcl-f EaseClasl1 keyed;
005100201104       dcl-f EaseEOI keyed;
005200201105       dcl-f EaseCostl1 keyed;
005300201216       dcl-f EaseWaive keyed;
005400210510
005500210510       dcl-f gbsDiffp keyed;
005600210614br01   dcl-f PlanxRefp keyed;
005700211028       dcl-f CcntrxRefp keyed;
005800200903
005900180516      *-------------------------------------------------------------------------
006000170112
006100181025     d PlanArry        s             20a   dim(26)
006200181025     d EnrlArry        s              3a   dim(26)
006300181025     d EffDtArry       s             10a   dim(26)
006400181025     d TermDtArry      s             10a   dim(26)
006500201124     d TermRsnArry     s             15a   dim(26)
006600181025     d VolAmtArry      s             11a   dim(26)
006700200430     d FSAAnnArry      s             10a   dim(26)
006800181025     d FSAPPArry       s              9a   dim(26)
006900170112     d PlnCnt          s              3s 0
007000170130     d i               s              2s 0 inz
007100170130
007200170201     D Office          s             30    inz
007300170713     d count           s              5s 0
007400200903     d PlanDesc        s             60
007500171214     d VolAmt$         s             11s 0
007600200430     d FSAAmt$         s              7s 2
007700180516
007800180711       dcl-s wSalary Zoned(9:2);
007900180516       dcl-s wSSn Zoned(9);
008000180516       dcl-s wSSnChar Char(11);
008100180516
008200181003       dcl-s wTrst Zoned( 3 );
008300181003       dcl-s wSub  Zoned( 3 );
008400181003       dcl-s wAcct Zoned( 4 );
008500181003
008600201104       dcl-s eoi_ssn Char(15);
008700201104       dcl-s eoi_Plan Char(50);
008800201104
008900210510       dcl-s Check_Field Char(10);
009000210510
009100210510       dcl-s ChgdArry    Char(1)  Dim(26);
009200210510       dcl-s CovgArry    Char(5)  Dim(26);
009300210510       dcl-s PCP#Arry    Char(20) Dim(26);
009400210510       dcl-s PCPNmArry   Char(50) Dim(26);
009500210510       dcl-s PCPEfdtArry Char(8)  Dim(26);
009600210510       dcl-s PCPTMdtArry Char(8)  Dim(26);
009700210510
009800210510       dcl-s Rcd_Level Char(10);
009900210608       dcl-s Skip_Name Char(1) inz('N');
010000210614       dcl-s Get_PlanxRef ind;
010100210510
010200210728       dcl-s @ssn Char(9);
010300211214       dcl-s SearchArray Zoned(2);
010400220214
010500210510
010600210510      *--------------------------------------------
010700210510      *
010800210510      * Procedures
010900210510      *
011000210510      *--------------------------------------------
011100210510      /Include *LIBL/QMODSRC,#EdtStngPr            // Edit String
011200210510      /Include *LIBL/QMODSRC,Pr0001rPr             // Case Functions
011300210510
011400171212
011500200121      *-------------------------------------------------------------------------
011600200121      *
011700200121      * *Entry Procedure
011800200121      *
011900200121      *-------------------------------------------------------------------------
012000200121       Dcl-pr Main ExtPgm;
012100220104         *N  char(1);
012200220104         *N  char(10);
012300220104         *N  char(1);
012400220104         *N  Char(1);
012500220104         *N  Char(10);
012600220104         *N  Char(100) options( *noPass );
012700200121       End-Pr;
012800200121
012900220104       dcl-pi Main;
013000200121         hasOrphan Char(1);
013100200121         pKey      Char(10);
013200200121         phasFSA   Char(1);
013300210518         pEnvir Char(1);
013400220104         eFileType Char(10);
013500220104         pSingleInfo Char(100) options( *noPass );
013600200121       End-Pi;
013700210607
013800210607       dcl-s S_Type Char(1);
013900210608       dcl-s Plan_Type Char(1);
014000210607       dcl-s S_MbrSSN Char(9);
014100210608       dcl-s S_UniqueID Char(32);
014200210608       dcl-s Plan_Name Char(20);
014300210607
014400200121
014500200121      *-------------------------------------------------------------------------
014600200121      *
014700160926      * Mainline Program
014800200121      *
014900160926      *-------------------------------------------------------------------------
015000191205
015100200121       open Gbs20l1;
015200200121       open Gbs20l2;
015300200121       open Gbs20l3;
015400200121       open Gbs20l4;
015500191205
015600200921
015700210614       Get_PlanxRef = *off;
015800180516       pHasFSA   = 'N';
015900180102
016000181003       wTrst = %Dec( %Subst( pKey : 1 : 3 ) : 3 : 0 ) ;
016100181003       wSub  = %Dec( %Subst( pKey : 4 : 3 ) : 3 : 0 ) ;
016200181003       wAcct = %Dec( %Subst( pKey : 7 : 4 ) : 4 : 0 ) ;
016300181003
016400210607
016500220104BR01   // Process a Single Record.
016600220104       if %Parms >= 6;
016700210614
016800210614         S_Type = %SubSt( pSingleInfo : 1 : 1 );
016900210614         s_MbrSSN = %SubSt( pSingleInfo : 2 : 9 );
017000210614         S_UniqueID = %SubSt( pSingleInfo : 11 : 32 );
017100210614         Skip_Name = 'Y';
017200210614         Get_PlanxRef = *on;
017300210607
017400210614         if s_Type = 'M';       // Member Information
017500220104           Single_Member();
017600210614         endif;
017700210607
017800210614         if s_Type = 'D';       // Dependent Information
017900220104           Single_Dependent();
018000210614         endif;
018100210607
018200210608
018300220104         if s_Type = 'P';       // Print
018400210608
018500210625           Get_PlanxRef = *off;
018600210614           Plan_Type = %SubSt( pSingleInfo : 2 : 1 );   // Member or Dependent
018700210623           s_MbrSSN = %SubSt( pSingleInfo : 3 : 9 );
018800210614           Plan_Name = %SubSt( pSingleInfo : 12 : 20 );   // Plan Name
018900210623           S_UniqueID = %SubSt( pSingleInfo : 33 : 32 );   // Unique ID
019000210608
019100210614           if Plan_Type = 'M';
019200220104             PrtMbrPlans();
019300210614           EndIf;
019400210608
019500210614           if Plan_Type = 'D';
019600220104             PrtDepPlans();
019700220104           EndIf;
019800210608
019900210608
020000210608
020100220104         endif;
020200210608
020300210608
020400210608
020500210614br01   EndIf;
020600210607
020700210614
020800210607       //----------------------------------
020900210614       //
021000210607       // Normal Processing.
021100210614       //
021200220104       //----------------------------------
021300220104       if %Parms < 6;
021400200903
021500210607         Omitted_Mbr();
021600181003
021700210607         ProcessData();
021800170713
021900210607         //?Check for Orphan Records.
022000210607         hasOrphan = 'N';
022100170713
022200220104         Exec Sql
022300220104           Select Count(*)
022400220104             Into :Count
022500220104             From Gbs20l3
022600220104             Where L3_Partssn Not In (Select L1_Ssn
022700220104                   From Gbs20l1);
022800170713
022900210607         if Count > 0;
023000220104           hasOrphan = 'Y';
023100220104         endif;
023200170713
023300210607       endif;
023400210607
023500200121       Close Gbs20l1;
023600200121       Close Gbs20l2;
023700200121       Close Gbs20l3;
023800200121       Close Gbs20l4;
023900191205
024000180516       *inlr = *on;
024100170509
024200160708
024300200121      *-------------------------------------------------------------------------
024400220104       dcl-proc ProcessData;
024500170112
024600220104         setll *loval Gbs20l1;
024700220104         dou %Eof(Gbs20L1);
024800210607           read Gbs20L1;
024900170112
025000200121           if %eof(Gbs20L1);
025100220104             leave;
025200200106           endif;
025300170112
025400210510           l1_FName = EdtString(l1_FName:'NAME');
025500210510           l1_LName = EdtString(l1_LName:'NAME');
025600210607           l1_Addr1 = EdtString(l1_Addr1:'ADDR');
025700210607           l1_Addr2 = EdtString(l1_Addr2:'ADDR');
025800210607           l1_City = EdtString(l1_City:'NAME');
025900210607           l1_State = EdtString(l1_State:'NAME');
026000210510
026100200106
026200200106           //?Get the Member Plans then Write Record.
026300200903           GetMbrPlans();
026400210607           WriteMbrRcd();
026500201216           WriteWaive_Mbr();
026600210607
026700210607           MissingPlans();
026800210607
026900170112
027000200106           //?Get the Dependents...
027100220104           setll l1_ssn Gbs20l3;
027200220104           dou %eof(Gbs20l3);
027300210607             reade l1_ssn Gbs20l3;
027400170112
027500210607             if %eof(Gbs20l3);
027600220104               leave;
027700210607             endif;
027800170112
027900210607             l3_FName = EdtString(l3_FName:'NAME');
028000210607             l3_LName = EdtString(l3_LName:'NAME');
028100210607             l3_Addr1 = EdtString(l3_Addr1:'ADDR');
028200210607             l3_Addr2 = EdtString(l3_Addr2:'ADDR');
028300210607             l3_City = EdtString(l3_City:'NAME');
028400210607             l3_State = EdtString(l3_State:'NAME');
028500200106
028600200903             GetDepnPlans();
028700200903             WriteDepnRcd();
028800210607             WriteWaive_Dep();
028900210629
029000220104             Miss_DepPlans();
029100170112
029200210607           enddo;
029300170112
029400210607           // Any Omitted Dependents?
029500210607           Setll (pKey : eFileType : l1_ssn) GbsDiffp;
029600210601
029700220104           Dou %Eof(GbsDiffp);
029800220104             reade (pKey : eFileType : l1_ssn) GbsDiffp;
029900210601             if %eof(GbsDiffp);
030000220104               leave;
030100210601             endif;
030200210601
030300220104             if   gdFile = 'L3' and
030400220104             gdTo = 'Omitted Dependent';
030500210601
030600210607               oChgd = 'Y';
030700210607               oType  = '';
030800210607               oInfo = ' ';
030900210601
031000210607               write r_Output;
031100210601
031200210607               oChgd = 'Y';
031300210607               oType  = 'Dependent:';
031400220104               oInfo = ' ** Dependent Not on File: ' + %Trim( gdFrom );
031500220104               write r_Output;
031600220104             EndIf;
031700210601
031800210601
031900210607           Enddo;
032000210601
032100210601
032200210607           oType  = *Blanks;
032300220104           oInfo  = *Blanks;
032400220104           write r_Output;
032500220104         enddo;
032600170112
032700210607       end-proc;
032800220104       //-----------------------------------------------------------
032900220104       dcl-proc GetMbrPlans;
033000210510
033100210607         Rcd_Level = 'L2';
033200210607         PlnCnt = 0;
033300170112
033400220104         setll l1_ssn Gbs20l2;
033500220104         dou %eof(Gbs20l2);
033600200121           reade l1_ssn Gbs20l2;
033700170112
033800200121           if %eof(Gbs20l2);
033900220104             leave;
034000200106           endif;
034100170112
034200210607           PlnCnt = PlnCnt + 1;
034300210607           PlanArry(PlnCnt) = l2_plan;
034400210607           ChgdArry(plnCnt) = '';
034500210607           oChgd = '';
034600171212
034700220104           Select;
034800210607           When l2_enrl = 'P00';
034900210607             l2_Enrl = 'IN';
035000210607           When l2_enrl = 'F00';
035100210607             l2_Enrl = 'HW';
035200200106           When l2_enrl = 'P99';
035300210607             l2_Enrl = 'P2';
035400210607           When l2_enrl = 'F99';
035500210607             l2_Enrl = 'FA';
035600200106           When l2_enrl = 'P01';
035700220104             l2_Enrl = 'FC';
035800200106           Endsl;
035900200106           EnrlArry(PlnCnt) = l2_enrl;
036000171212
036100171212
036200200106           EffDtArry(PlnCnt) = %Subst(l2_effdt:5:2) +'/'+
036300220104           %Subst(l2_effdt:7:2) +'/'+
036400210607           %Subst(l2_effdt:1:4) ;
036500171212
036600220104           TermDtArry(PlnCnt) = '';
036700210607           if l2_termdt > '';
036800220104             TermDtArry(PlnCnt) = %Subst(l2_termdt:5:2) +'/'+
036900220104             %Subst(l2_termdt:7:2) +'/'+
037000220104             %Subst(l2_termdt:1:4) ;
037100171212
037200200106           endif;
037300170124
037400171214
037500220104           VolAmtArry(PlnCnt) = *Blanks;
037600220104           if l2_VolAmt > '' and l2_VolAmt <> '00000000.00';
037700220104             VolAmt$ = %Dec( l2_VolAmt : 11 : 0 );
037800220104             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
037900200106           endif;
038000171212
038100171214
038200200106           //?FSA Amount
038300200106           FSAAnnArry(PlnCnt) = *Blanks;
038400220104           FSAPPArry(PlnCnt) = *Blanks;
038500220104           if l2_fsa_ann > '' and l2_fsa_ann <> '0.00';
038600210607             FSAAmt$ = %Dec( l2_fsa_Ann : 7 : 2 );
038700210607             FSAAnnArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
038800171214
038900180123
039000220104             if l2_fsa_pp > '';
039100220104               FSAAmt$ = %Dec( l2_fsa_pp : 6 : 2 );
039200220104               FSAPPArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
039300210607             endif;
039400180123
039500220104             pHasFSA = 'Y';
039600200106           endif;
039700171214
039800210510           CovgArry( PlnCnt ) = l2_CovgTp;
039900210607           Pcp#Arry( PlnCnt ) = l2_Pcp#;
040000210607           PcpNmArry( PlnCnt ) = l2_PcpName;
040100210607           PcpEfDtArry( PlnCnt ) = l2_PcpEfDt;
040200210607           PcpTmDtArry( PlnCnt ) = l2_PcptmDt;
040300210510
040400210510
040500210607           //---------------------------------------
040600210607           // Check if Any of the plan information
040700210607           // has been changed.
040800210607           //---------------------------------------
040900210510
041000220104           if pEnvir = 'P';
041100210518
041200210607             Check_Field = 'NEWPLAN';
041300210607             Check_History();
041400210607             ChgdArry(plnCnt) = oChgd;
041500210518
041600210607             Check_Field = 'EFFDT';
041700210607             Check_History();
041800210607             ChgdArry(plnCnt) = oChgd;
041900210510
042000220104             if oChgd = '';
042100210607               Check_Field = 'TERMDT';
042200220104               Check_History();
042300220104               ChgdArry(plnCnt) = oChgd;
042400210607             endif;
042500210510
042600220104             if oChgd = '';
042700210607               Check_Field = 'ENRL';
042800220104               Check_History();
042900220104               ChgdArry(plnCnt) = oChgd;
043000210510             endif;
043100210510
043200220104             if oChgd = '';
043300210607               Check_Field = 'FSAANN';
043400220104               Check_History();
043500220104               ChgdArry(plnCnt) = oChgd;
043600210607             endif;
043700210510
043800220104             if oChgd = '';
043900210607               Check_Field = 'FSAPP';
044000220104               Check_History();
044100220104               ChgdArry(plnCnt) = oChgd;
044200210607             endif;
044300210510
044400220104             if oChgd = '';
044500210607               Check_Field = 'VOLAMT';
044600220104               Check_History();
044700220104               ChgdArry(plnCnt) = oChgd;
044800210607             endif;
044900210510
045000220104             if oChgd = '';
045100210607               Check_Field = 'COVGTP';
045200220104               Check_History();
045300220104               ChgdArry(plnCnt) = oChgd;
045400210607             endif;
045500210510
045600220104             if oChgd = '';
045700210607               Check_Field = 'PCP#';
045800220104               Check_History();
045900220104               ChgdArry(plnCnt) = oChgd;
046000210607             endif;
046100210510
046200220104             if oChgd = '';
046300210607               Check_Field = 'PCPNAME';
046400220104               Check_History();
046500220104               ChgdArry(plnCnt) = oChgd;
046600210607             endif;
046700210510
046800220104             if oChgd = '';
046900210607               Check_Field = 'PCPEFDT';
047000220104               Check_History();
047100220104               ChgdArry(plnCnt) = oChgd;
047200210607             endif;
047300210510
047400220104             if oChgd = '';
047500210607               Check_Field = 'PCPTMDT';
047600220104               Check_History();
047700220104               ChgdArry(plnCnt) = oChgd;
047800220104             endif;
047900210510
048000220104           endif;
048100210510
048200210510
048300210510
048400220104         enddo;
048500170112
048600170112
048700210607       End-proc;
048800220104       //---------------------------------------------------------
048900220104       Dcl-proc WriteMbrRcd;
049000170112
049100220214         dcl-s pos Zoned(5);
049200220214
049300210607         wSSNChar = %Scanrpl('-': '' : l1_ssn );
049400210607         wSSN = %Dec( wSSNChar : 9 : 0 );
049500210607         Rcd_Level = 'L1';
049600180516
049700210510
049800210607         //-----------------------
049900210607         // Member SSN
050000210607         //-----------------------
050100200106         oType  = 'Member:';
050200210607         oInfo  = %Subst(l1_ssn:1:3) + '-'+ %Subst(l1_ssn:4:2) + '-'+
050300210607         %Subst(l1_ssn:6:4);
050400210510
050500220104         if pEnvir = 'P';
050600210607           oChgd = '';
050700220104           Check_Field = '*Any';
050800220104           Check_History();
050900210510         endif;
051000210510
051100210608         if Skip_Name = 'N';
051200220104           write r_Output ;
051300210608         endif;
051400170113
051500210510
051600210510         //-----------------------
051700210510         // Member Name
051800210510         //-----------------------
051900200106         oType  = *Blanks;
052000200106         oInfo  = %trim(l1_lname) + ', ' + %trim(l1_fname) + ' ' + L1_mi;
052100210510
052200220104         if pEnvir = 'P';
052300210510           oChgd = '';
052400220104           Check_Field = '*Any';
052500220104           Check_History();
052600210510         endif;
052700210510
052800210608         if Skip_Name = 'N';
052900220104           write r_Output ;
053000210608         endif;
053100170113
053200210510
053300210510         //-----------------------
053400210510         // Address Line 1
053500210510         //-----------------------
053600200106         oInfo  = %trim(l1_Addr1);
053700210510
053800220104         if pEnvir = 'P';
053900210607           oChgd = '';
054000220104           Check_Field = 'ADDR1';
054100220104           Check_History()  ;
054200210607         endif;
054300210510
054400210607         write r_Output ;
054500170113
054600210510
054700210510         //-----------------------
054800210510         // Address Line 2
054900220104         //-----------------------
055000220104         if l1_addr2 > *Blanks;
055100210607           oInfo  = %trim(l1_Addr2);
055200210510
055300220104           if pEnvir = 'P';
055400210607             oChgd = '';
055500220104             Check_Field = 'ADDR2';
055600220104             Check_History()  ;
055700210510           endif;
055800210510
055900220104           write r_Output ;
056000200106         endif;
056100170113
056200210510         //-----------------------
056300210510         // City, State Zip
056400210510         //-----------------------
056500200106         oInfo  = %trim(l1_City) + ', ' + %trim(l1_State) + '  ' +
056600220104         %trim(l1_Zip);
056700210510
056800220104         if pEnvir = 'P';
056900210607           oChgd = '';
057000210607           Check_Field = 'CITY';
057100210607           Check_History();
057200210510           Check_Field = 'STATE';
057300210510           Check_History();
057400220104           Check_Field = 'ZIP';
057500220104           Check_History();
057600210510         endif;
057700210510
057800200106         write r_Output ;
057900170113
058000190626
058100210510         //-----------------------
058200210510         // Email Address
058300220104         //-----------------------
058400220104         if l1_Email > '';
058500200106           oInfo  = 'Email Addr: ' + %trim(l1_email) ;
058600210510
058700220104           if pEnvir = 'P';
058800210607             oChgd = '';
058900220104             Check_Field = 'EMAIL';
059000220104             Check_History();
059100210510           endif;
059200210510
059300220104           write r_Output ;
059400200106         endif;
059500190626
059600210510
059700210510         //-----------------------
059800210510         // SMoker
059900220104         //-----------------------
060000220104         if l1_Smoker > '';
060100200106           oInfo  = 'Smoker: ' + %trim(l1_Smoker) ;
060200210510
060300210510
060400220104           if pEnvir = 'P';
060500210510             oChgd = '';
060600220104             Check_Field = 'SMOKER';
060700220104             Check_History();
060800210510           endif;
060900210510
061000220104           write r_Output ;
061100200106         endif;
061200190626
061300210510
061400210510         //-----------------------
061500210510         // Office / Location
061600220104         //-----------------------
061700220104         if l1_loc > *Blanks;
061800200106           Office = l1_loc;
061900220104           chain ( pKey : l1_loc ) gbs0029p;
062000210607           if %Found( GBS0029P ) ;
062100220104             office = axName ;
062200210607           endif;
062300171211
062400200106           oInfo  = 'Office: ' + %trim(l1_loc)  + ' - ' +  Office;
062500210510
062600220104           if pEnvir = 'P';
062700210607             oChgd = '';
062800220104             Check_Field = 'LOC';
062900220104             Check_History();
063000210607           endif;
063100210510
063200220104           write r_Output ;
063300171211
063400210607         endif;
063500170201
063600210510
063700210607         //-----------------------
063800210607         // Full Location
063900220104         //-----------------------
064000220104         if L1_fullloc > '';
064100200106           oInfo  = 'Full Location: ' + %Trim( L1_fullloc );
064200210510
064300220104           if pEnvir = 'P';
064400210510             oChgd = '';
064500220104             Check_Field = 'FULLLOC';
064600220104             Check_History();
064700210510           endif;
064800210510
064900220104           write r_Output ;
065000200106         endif;
065100190710
065200210510
065300210510         //-----------------------
065400210510         // Term Date
065500220104         //-----------------------
065600220104         if l1_termdt > *Blanks;
065700200106           oInfo  = 'Member Termed Date: ' + l1_termdt;
065800210510
065900220104           if pEnvir = 'P';
066000210510             oChgd = '';
066100220104             Check_Field = 'TERMDT';
066200220104             Check_History();
066300210510           endif;
066400210510
066500220104           write r_Output ;
066600200106         endif;
066700170501
066800210510
066900210510         //-----------------------
067000210510         // Term Reason
067100220104         //-----------------------
067200220104         if l1_termRsn > *Blanks;
067300200106           oInfo  = 'Termed Reason: ' + l1_termrsn;
067400210510
067500220104           if pEnvir = 'P';
067600210510             oChgd = '';
067700220104             Check_Field = 'TERMRSN';
067800220104             Check_History();
067900210510           endif;
068000210510
068100220104           write r_Output ;
068200200106         endif;
068300190815
068400190815
068500210510         //-----------------------
068600210510         // Qualifed Event
068700220104         //-----------------------
068800220104         if l1_qualevt > *Blanks;
068900200903
069000220104           // EASE Information
069100220104           if %SubSt( l1_Qualevt : 1 : 8) = 'EASE_QE_';
069200200903             chain l1_Qualevt EaseQeL1;
069300200903
069400200903             if %Found( EaseQeL1 );
069500220104               oInfo  = 'Qualifed Event: ' + q_Descr;
069600220104             endif;
069700200903
069800220104           else;
069900200903
070000220104             oInfo  = 'Qualifed Event: ' + l1_Qualevt;
070100210607           EndIf;
070200200903
070300220104           if pEnvir = 'P';
070400210607             oChgd = '';
070500220104             Check_Field = 'QUALEVT';
070600220104             Check_History();
070700210607           endif;
070800210510
070900220104           write r_Output ;
071000210607         endif;
071100190815
071200190815
071300210607         //-----------------------
071400210607         // Gender
071500210607         //-----------------------
071600210607         oInfo  = 'Gender: ' + l1_gender;
071700210510
071800220104         if pEnvir = 'P';
071900210510           oChgd = '';
072000220104           Check_Field = 'GENDER';
072100220104           Check_History();
072200210607         endif;
072300210510
072400210607         write r_Output ;
072500170501
072600170501
072700210607         //-----------------------
072800210510         // Maritial Status
072900220104         //-----------------------
073000220104         if l1_marSts > *Blanks;
073100220104           Select;
073200220302           when l1_Marsts = 'B';
073300220302             oInfo  = 'Marital Status: Domestic Partner';
073400220302           when l1_Marsts = 'D';
073500220302             oInfo  = 'Marital Status: Divorced';
073600200106           when l1_Marsts = 'I';
073700210607             oInfo  = 'Marital Status: Single';
073800200106           when l1_Marsts = 'M';
073900210607             oInfo  = 'Marital Status: Married';
074000210607           when l1_Marsts = 'S';
074100210607             oInfo  = 'Marital Status: Separated';
074200210607           when l1_Marsts = 'W';
074300220104             oInfo  = 'Marital Status: Widowed';
074400200106           endsl;
074500210510
074600220104           if pEnvir = 'P';
074700210607             oChgd = '';
074800220104             Check_Field = 'MARSTS';
074900220104             Check_History();
075000210510           endif;
075100210510
075200220104           write r_Output ;
075300210607         endif;
075400170501
075500170501
075600210607         //-----------------------
075700210607         // Salary
075800220104         //-----------------------
075900220104         if l1_sal > *Blanks;
076000200106           oInfo  = 'Salary: ' + l1_Sal;
076100210510
076200220104           if pEnvir = 'P';
076300210510             oChgd = '';
076400220104             Check_Field = 'SAL';
076500220104             Check_History();
076600210510           endif;
076700210510
076800200106           write r_Output ;
076900180516
077000180516
077100210607           wSalary = %Dec( %Trim( l1_Sal ) : 9 : 2 );
077200220104           Exec Sql
077300220104             Select Round(:Wsalary)
077400220104               Into :Wsalary
077500220104               From Sysibm.Sysdummy1;
077600180516
077700220104           chain wSSN Member;
077800220104           if %Found( Member );
077900220104             if wSalary <> Salary;
078000210607               oInfo = '** Salary does not match our system. ' +
078100220104                 'Current Value: ' +  %editc( Salary: '1') ;
078200220104               write r_output;
078300220104             EndIf;
078400220104           EndIf;
078500180516
078600180516
078700180516
078800210607         endif;
078900170501
079000170829
079100210607         //-----------------------
079200210607         // COBRA
079300220104         //-----------------------
079400220104         if l1_Cobra = 'Y';
079500210607           oInfo  = 'COBRA: Y';
079600210510
079700220104           if pEnvir = 'P';
079800210607             oChgd = '';
079900210607             Check_Field = 'COBRA';
080000210607             Check_History();
080100211214
080200211214             // Show COBRA if any plan has changed.
080300211214             SearchArray = 0;
080400220104             SearchArray = %Lookup( 'Y' : ChgdArry );
080500211214             if SearchArray > 0;
080600220104               oChgd = 'Y';
080700220104             endif;
080800211214
080900210607           endif;
081000210510
081100220104           write r_Output ;
081200200106         endif;
081300170829
081400170501
081500210510
081600210510         //-----------------------
081700210510         // Date of Change
081800220104         //-----------------------
081900220104         if l1_doc > '';
082000200106           oInfo  = 'DOC: ' + %Subst(l1_doc:5:2) +'/'+
082100210607           %Subst(l1_doc:7:2) +'/'+
082200220104           %Subst(l1_doc:1:4) ;
082300190815
082400220104           if pEnvir = 'P';
082500210607             oChgd = '';
082600220104             Check_Field = 'DOC';
082700220104             Check_History();
082800210607           endif;
082900210510
083000220104           write r_Output ;
083100200106         endif;
083200190815
083300170501
083400210510         //-----------------------
083500210607         // Date of Birth
083600220104         //-----------------------
083700220104         if l1_dob > '';
083800200106           oInfo  = 'DOB: ' + %Subst(l1_dob:5:2) +'/'+
083900210607           %Subst(l1_dob:7:2) +'/'+
084000220104           %Subst(l1_dob:1:4) ;
084100210510
084200220104           if pEnvir = 'P';
084300210607             oChgd = '';
084400220104             Check_Field = 'DOB';
084500220104             Check_History();
084600210607           endif;
084700171212
084800220104           write r_Output ;
084900200106         endif;
085000171212
085100210510
085200210510         //-----------------------
085300210607         // Date of Hire
085400220104         //-----------------------
085500220104         if l1_doh > '';
085600200106           oInfo  = 'DOH: ' + %Subst(l1_doh:5:2) +'/'+
085700210607           %Subst(l1_doh:7:2) +'/'+
085800220104           %Subst(l1_doh:1:4) ;
085900210510
086000220104           if pEnvir = 'P';
086100210607             oChgd = '';
086200220104             Check_Field = 'DOH';
086300220104             Check_History();
086400210607           endif;
086500210510
086600220104           write r_Output ;
086700200106         endif;
086800170113
086900210510
087000210510         //-----------------------
087100210607         // Class
087200220104         //-----------------------
087300220104         if l1_Class > '';
087400200908
087500220104           // EASE Information
087600220104           if %SubSt( l1_Class : 1 : 1) = '^';
087700200908             chain (wTrst : wSub : wAcct : l1_Class) EaseClasL1;
087800200908
087900200908             if %Found( EaseClasL1 );
088000220104               oInfo  = 'Class: ' + c_Descr;
088100220104             endif;
088200200908
088300220104           else;
088400200908
088500220104             oInfo  = 'Class: ' + l1_Class;
088600210607           EndIf;
088700200908
088800220104           if pEnvir = 'P';
088900210607             oChgd = '';
089000220104             Check_Field = 'CLASS';
089100220104             Check_History();
089200210607           endif;
089300200908
089400220104           write r_Output ;
089500210607         endif;
089600190815
089700171212
089800210510
089900210607         //-----------------------
090000210607         // Phone
090100220104         //-----------------------
090200220104         if l1_phone > '';
090300200106           oInfo  = 'Phone: ' + l1_Phone;
090400210510
090500220104           if pEnvir = 'P';
090600210510             oChgd = '';
090700220104             Check_Field = 'PHONE';
090800220104             Check_History();
090900210510           endif;
091000210510
091100220104           write r_Output ;
091200200106         endif;
091300170130
091400210510
091500210510         //-----------------------
091600210510         // Med_Adt
091700220104         //-----------------------
091800220104         if l1_Med_adt > '';
091900210510           oInfo  = 'Medicare A Date: ' +
092000210607           %Subst(l1_Med_adt:5:2) +'/'+
092100220104           %Subst(l1_Med_adt:7:2) +'/'+
092200220104           %Subst(l1_Med_adt:1:4) ;
092300210510
092400220104           if pEnvir = 'P';
092500210607             oChgd = '';
092600220104             Check_Field = 'MED_ADT';
092700220104             Check_History();
092800210607           endif;
092900210510
093000220104           write r_Output ;
093100210510         endif;
093200190716
093300210510
093400210607         //-----------------------
093500210607         // Med_Bdt
093600220104         //-----------------------
093700220104         if l1_Med_bdt > '';
093800210510           oInfo  = 'Medicare B Date: ' +
093900210607           %Subst(l1_Med_bdt:5:2) +'/'+
094000220104           %Subst(l1_Med_bdt:7:2) +'/'+
094100220104           %Subst(l1_Med_bdt:1:4) ;
094200210510
094300220104           if pEnvir = 'P';
094400210607             oChgd = '';
094500220104             Check_Field = 'MED_BDT';
094600220104             Check_History();
094700210607           endif;
094800210510
094900220104           write r_Output ;
095000210510         endif;
095100210510
095200210510
095300210607         //-----------------------
095400210607         // Med_Cdt
095500220104         //-----------------------
095600220104         if l1_Med_cdt > '';
095700210510           oInfo  = 'Medicare C Date: ' +
095800210607           %Subst(l1_Med_cdt:5:2) +'/'+
095900220104           %Subst(l1_Med_cdt:7:2) +'/'+
096000220104           %Subst(l1_Med_cdt:1:4) ;
096100210510
096200220104           if pEnvir = 'P';
096300210607             oChgd = '';
096400220104             Check_Field = 'MED_CDT';
096500220104             Check_History();
096600210607           endif;
096700210510
096800220104           write r_Output ;
096900210510         endif;
097000210510
097100210510
097200210607         //-----------------------
097300210607         // Med_Ddt
097400220104         //-----------------------
097500220104         if l1_Med_ddt > '';
097600210510           oInfo  = 'Medicare D Date: ' +
097700210607           %Subst(l1_Med_ddt:5:2) +'/'+
097800220104           %Subst(l1_Med_ddt:7:2) +'/'+
097900220104           %Subst(l1_Med_ddt:1:4) ;
098000210510
098100220104           if pEnvir = 'P';
098200210607             oChgd = '';
098300220104             Check_Field = 'MED_DDT';
098400220104             Check_History();
098500210607           endif;
098600210510
098700220104           write r_Output ;
098800210510         endif;
098900210510
099000210510
099100210510
099200210607         //-----------------------
099300210607         // Cost Center
099400220104         //-----------------------
099500220104         if l1_CostCtr > '' ;
099600201105           oInfo  = 'Cost Center: ' + %Trim( l1_CostCtr) ;
099700201105
099800220104           // EASE Information
099900220104           if %SubSt( l1_CostCtr : 1 : 8) = 'EASE_CC_';
100000201105             chain (wTrst : wSub : wAcct : l1_CostCtr ) EaseCostL1;
100100201105
100200210607             if %Found( EaseCostL1 );
100300220104               oInfo  = 'Cost Center: ' + d_Descr;
100400220104             endif;
100500201105
100600210607           EndIf;
100700210510
100800220104           if pEnvir = 'P';
100900210607             oChgd = '';
101000220104             Check_Field = 'COSTCTR';
101100220104             Check_History();
101200210510           endif;
101300210510
101400210607           write r_Output ;
101500211028
101600211028
101700211028           // Get the Amwins Cost Center
101800211028
101900220104           chain (wTrst : wSub : wAcct : l1_CostCtr ) ccntrxRefp;
102000220104           if %Found( ccntrxRefp );
102100220104             oInfo  = 'Amwins Cost Center: ' + pcAmcntr;
102200220104             write r_Output ;
102300220104           EndIf;
102400211028
102500211028
102600211028
102700210607         endif;
102800201105
102900220214
103000220214
103100220214         // Check for Waived Members.
103200220214         pos = %lookup( 'Y' : ChgdArry );
103300220214         if pos > 0  OR  pEnvir = 'T';
103400220214
103500220214           chain wSSN Member;
103600220214           if %Found( Member );
103700220214             if Empst = 'W';
103800220214               oInfo = '** Member in WAIVED Status in GENIE';
103900220214               oChgd = 'Y';
104000220214               write r_output;
104100220214             EndIf;
104200220214           EndIf;
104300220214
104400220214         EndIf;
104500190716
104600190716
104700220214
104800210607         //-----------------------
104900210607         // Plans
105000220104         //-----------------------
105100220104         for i = 1 to 26;
105200170130
105300200106           if PlanArry(i) = *Blanks;
105400220104             iter;
105500210607           endif;
105600170130
105700210510
105800210607           // Production = If is no changes in a plan, skip.
105900210607           //if pEnvir = 'P';
106000210527           //  if ChgdArry( i ) = '';
106100210527           //    iter;
106200210607           //  EndIf;
106300210607           // EndIf;
106400210510
106500210510
106600210510
106700210607           eoi_plan = planArry(i);
106800210607           PlanDesc = *Blanks;
106900201104
107000220104           if %len(%Trim(PlanArry(i))) = 4;
107100220104             chain (wTrst : wSub : PlanArry(i)) PlnMst;
107200210607             if %Found( PlnMst );
107300220104               PlanDesc = pDescr;
107400220104             endif;
107500200106           endif;
107600170830
107700200903
107800220104           // EASE Information
107900220104           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
108000210607             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
108100200904
108200220104             if %Found( EasePlanL1 );
108300210607               oInfo  = 'Plan: ' + %trim(p_PlanName);
108400201125
108500210607               if TermDtArry(i) = '';
108600220104                 oInfo = %Trim( oInfo ) +
108700220104                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
108800210607               EndIf;
108900201125
109000210607               eoi_Plan = p_PlanName;
109100220104             else;
109200200904
109300210607               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
109400210607               if TermDtArry(i) = '';
109500220104                 oInfo = %Trim( oInfo ) +
109600220104                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
109700220104               EndIf;
109800201125
109900210607             endif;
110000220104           else;
110100200904
110200220104             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
110300210607             if TermDtArry(i) = '';
110400220104               oInfo = %Trim( oInfo ) +
110500220104                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
110600220104             EndIf;
110700210607           EndIf;
110800200904
110900200904
111000220104           if TermDtArry(i) = '';
111100210607             if EnrlArry(i) > '';
111200220104               oInfo = %Trim(oInfo) + '  Enrollment Lvl: ' + EnrlArry(i);
111300201125             endif;
111400171214
111500171214
111600220104             if VolAmtArry(i) > '';
111700210607               oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
111800201104
111900210607               // Check for EASE EOI Amount.
112000210607               eoi_ssn = %Editc( wSSN : 'X' );
112100210607               chain ( wTrst : wSub : wAcct : eoi_ssn :
112200220104                 l1_fname : l1_dob : eoi_Plan ) EaseEOI;
112300210607               if %Found( EaseEoi );
112400220104                 oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
112500220104                 %trim(I_REQAMT) ;
112600201104
112700220104               EndIf;
112800201104
112900210607             endif;
113000171212
113100171214
113200220104             if FSAAnnArry(i) > '';
113300220104               oInfo = %Trim(oInfo) + '  FSA Annual Amt: ' + FSAAnnArry(i);
113400220104               oInfo = %Trim(oInfo) + '  FSA Per Pay: ' + FSAPPArry(i);
113500220104             endif;
113600171214
113700210607           endif;
113800210519
113900210607           oChgd = ChgdArry( i );
114000210607           write r_Output ;
114100170113
114200220104           if TermDtArry(i) > *Blanks;
114300210607             oInfo  = 'Term Date: ' + %trim(TermDtArry(i)) ;
114400210519
114500220104             oChgd = ChgdArry( i );
114600220104             write r_Output ;
114700210607           endif;
114800210510
114900210510
115000220104           if CovgArry(i) > *Blanks;
115100210510             oInfo  = 'Coverage Type: ' + %trim(CovgArry(i)) ;
115200220104             oChgd = ChgdArry( i );
115300220104             write r_Output ;
115400210510           endif;
115500210510
115600210510
115700220104           if PCP#Arry(i) > *Blanks;
115800210510             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
115900220104             oChgd = ChgdArry( i );
116000220104             write r_Output ;
116100210510           endif;
116200210510
116300210510
116400220104           if PCPNmArry(i) > *Blanks;
116500210510             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
116600220104             oChgd = ChgdArry( i );
116700220104             write r_Output ;
116800210510           endif;
116900210510
117000210510
117100220104           if PCPEfDtArry(i) > *Blanks;
117200210510             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
117300220104             oChgd = ChgdArry( i );
117400220104             write r_Output ;
117500210510           endif;
117600210510
117700210510
117800220104           if PCPTMDtArry(i) > *Blanks;
117900210510             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
118000220104             oChgd = ChgdArry( i );
118100220104             write r_Output ;
118200220104           endif;
118300210510
118400210510
118500210510
118600210510
118700210607         endfor;
118800170130
118900170124
119000210607         Clear PlanArry;
119100210607         Clear EnrlArry;
119200210607         Clear EffDtArry;
119300210607         Clear TermDtArry;
119400210510
119500210607         Clear CovgArry;
119600210607         Clear Pcp#Arry;
119700210607         Clear PcpNmArry;
119800220104         Clear pcpEfDtArry;
119900220104         Clear pcpTMdtArry;
120000210510
120100210510
120200210607       End-proc;
120300220104       //-----------------------------------------------------------
120400220104       Dcl-proc GetDepnPlans;
120500170112
120600200106         PlnCnt = 0;
120700210510         Rcd_Level = 'L4';
120800170112
120900220104         setll l3_uniqid Gbs20l4;
121000220104         dou %eof(Gbs20l4);
121100210607           reade l3_uniqid Gbs20l4;
121200170112
121300210607           if %eof(Gbs20l4);
121400220104             leave;
121500210607           endif;
121600170112
121700210607           PlnCnt = PlnCnt + 1;
121800210607           PlanArry(PlnCnt) = l4_plan;
121900210607           ChgdArry(plnCnt) = '';
122000210607           oChgd = '';
122100210510
122200210607           EffDtArry(PlnCnt) = %Subst(l4_effdt:5:2) +'/'+
122300210607           %Subst(l4_effdt:7:2) +'/'+
122400210607           %Subst(l4_effdt:1:4) ;
122500171212
122600220104           TermDtArry(PlnCnt) = '';
122700210607           if l4_termdt > '';
122800220104             TermDtArry(PlnCnt) = %Subst(L4_termdt:5:2) +'/'+
122900220104             %Subst(L4_termdt:7:2) +'/'+
123000220104             %Subst(L4_termdt:1:4) ;
123100200106           endif;
123200201122
123300201122
123400201124           TermRsnArry(PlnCnt) = l4_TermRsn;
123500210518           CovgArry( PlnCnt ) = l4_CovgTyp;
123600210510           Pcp#Arry( PlnCnt ) = l4_Pcp#;
123700210510           PcpNmArry( PlnCnt ) = l4_PcpName;
123800210510           PcpEfDtArry( PlnCnt ) = l4_PcpEfDt;
123900210510           PcpTmDtArry( PlnCnt ) = l4_PcptmDt;
124000201124
124100220104           VolAmtArry(PlnCnt) = *Blanks;
124200220104           if l4_VolAmt > '' and l4_VolAmt <> 'ENROLLED';
124300220104             VolAmt$ = %Dec( l4_VolAmt : 11 : 0 );
124400220104             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
124500201122           endif;
124600201122
124700210510
124800210510           //---------------------------------------
124900210510           // Check if Any of the plan information
125000210510           // has been changed.
125100210510           //---------------------------------------
125200210510
125300220104           if pEnvir = 'P';
125400210607             Check_Field = 'EFFDT';
125500210510             Check_History();
125600210510             ChgdArry(plnCnt) = oChgd;
125700210510
125800220104             if oChgd = '';
125900210607               Check_Field = 'TERMDT';
126000220104               Check_History();
126100220104               ChgdArry(plnCnt) = oChgd;
126200210607             endif;
126300210510
126400210510
126500220104             if oChgd = '';
126600210607               Check_Field = 'COVGTYP';
126700220104               Check_History();
126800220104               ChgdArry(plnCnt) = oChgd;
126900210510             endif;
127000210510
127100220104             if oChgd = '';
127200210607               Check_Field = 'PCP#';
127300220104               Check_History();
127400220104               ChgdArry(plnCnt) = oChgd;
127500210607             endif;
127600210510
127700220104             if oChgd = '';
127800210607               Check_Field = 'PCPNAME';
127900220104               Check_History();
128000220104               ChgdArry(plnCnt) = oChgd;
128100210607             endif;
128200210510
128300220104             if oChgd = '';
128400210607               Check_Field = 'PCPEFDT';
128500220104               Check_History();
128600220104               ChgdArry(plnCnt) = oChgd;
128700210607             endif;
128800210510
128900220104             if oChgd = '';
129000210607               Check_Field = 'PCPTMDT';
129100220104               Check_History();
129200220104               ChgdArry(plnCnt) = oChgd;
129300210607             endif;
129400210510
129500220104             if oChgd = '';
129600210607               Check_Field = 'VOLAMT';
129700220104               Check_History();
129800220104               ChgdArry(plnCnt) = oChgd;
129900210607             endif;
130000210510
130100220104             if oChgd = '';
130200210607               Check_Field = 'TERMRSN';
130300220104               Check_History();
130400220104               ChgdArry(plnCnt) = oChgd;
130500220104             endif;
130600220104           endif;
130700201122
130800220104         enddo;
130900170112
131000170112
131100210607       End-proc;
131200210510
131300220104       //---------------------------------------------------------
131400220104       Dcl-proc WriteDepnRcd;
131500170112
131600210607         dcl-s volPlanName Char(50);
131700210607         Rcd_Level = 'L3';
131800210510
131900201123
132000210607         //--------------------
132100210607         // Dependent SSN
132200210607         //--------------------
132300210607         oType  = 'Dependent:';
132400210607         oInfo  = %Subst(l3_Depssn:1:3) + '-'+
132500220104         %Subst(l3_Depssn:4:2) + '-'+
132600220104         %Subst(l3_Depssn:6:4);
132700210510
132800220104         if pEnvir = 'P';
132900210607           oChgd = '';
133000220104           Check_Field = '*AnyDep';
133100220104           Check_History();
133200210510         endif;
133300210510
133400210608         if Skip_Name = 'N';
133500220104           write r_Output ;
133600210608         endif;
133700210628
133800210628
133900210510
134000210510         //--------------------
134100210510         // Dependent Name
134200210510         //--------------------
134300200106         oType  = *Blanks;
134400200106         oInfo  = %trim(l3_lname) + ', ' + %trim(l3_fname) + ' ' + l3_mi;
134500210510
134600220104         if pEnvir = 'P';
134700210510           oChgd = '';
134800220104           Check_Field = '*AnyDep';
134900220104           Check_History();
135000210510         endif;
135100210510
135200220104         if Skip_Name = 'N';
135300210608           write r_Output ;
135400210628
135500210628
135600220104           if pEnvir = 'P';
135700210629             oChgd = '';
135800210629             Check_Field = 'DEPSSN';
135900210629             Check_History();
136000210629             oType  = '';
136100220104             oInfo  = 'SSN was changed.';
136200210629             if oChgd = 'Y';
136300220104               write r_Output ;
136400220104             endif;
136500220104           endif;
136600210608         endif;
136700170113
136800210510
136900210628
137000210628
137100210510         //--------------------
137200210510         // Dependent Address 1
137300210510         //--------------------
137400200106         oInfo  = %trim(l3_Addr1);
137500210510
137600220104         if pEnvir = 'P';
137700210607           oChgd = '';
137800220104           Check_Field = 'ADDR1';
137900220104           Check_History();
138000210607         endif;
138100210510
138200210607         write r_Output ;
138300170113
138400210510
138500210510         //--------------------
138600210510         // Dependent Address 2
138700220104         //--------------------
138800220104         if l3_addr2 > *Blanks;
138900210607           oInfo  = %trim(l3_Addr2);
139000210510
139100220104           if pEnvir = 'P';
139200210607             oChgd = '';
139300220104             Check_Field = 'ADDR2';
139400220104             Check_History();
139500210510           endif;
139600210510
139700220104           write r_Output ;
139800200106         endif;
139900170113
140000210510
140100210510         //--------------------
140200210510         // City, State Zip
140300210510         //--------------------
140400200106         oInfo  = %trim(l3_City) + ', ' + %trim(l3_State) + '  ' +
140500220104         %trim(l3_Zip);
140600210510
140700220104         if pEnvir = 'P';
140800210607           oChgd = '';
140900210607           Check_Field = 'CITY';
141000210607           Check_History();
141100210510           Check_Field = 'STATE';
141200210510           Check_History();
141300220104           Check_Field = 'ZIP';
141400220104           Check_History();
141500210510         endif;
141600210510
141700200106         write r_Output ;
141800170113
141900210510
142000210510         //--------------------
142100210510         // Dependent Gender
142200210510         //--------------------
142300210607         oInfo  = 'Gender: ' + l3_gender;
142400210510
142500220104         if pEnvir = 'P';
142600210510           oChgd = '';
142700220104           Check_Field = 'GENDER';
142800220104           Check_History();
142900210607         endif;
143000210510
143100210607         write r_Output ;
143200170113
143300210510
143400210510         //--------------------
143500210510         // Relationship
143600210510         //--------------------
143700220104         Select;
143800200106         When L3_relcod = 'S';
143900210607           oInfo  = 'Relationship: Spouse';
144000200106         When L3_relcod = 'C';
144100200106           oInfo  = 'Relationship: Child';
144200210607         When L3_relcod = 'D';
144300200106           oInfo  = 'Relationship: Domestic Partner';
144400200106         Other;
144500220104           oInfo  = 'Relationship: ' + L3_relcod;
144600200106         Endsl;
144700210510
144800220104         if pEnvir = 'P';
144900210607           oChgd = '';
145000220104           Check_Field = 'RELCOD';
145100220104           Check_History();
145200210607         endif;
145300210510
145400200106         write r_Output ;
145500170130
145600170130
145700171212
145800210510         //--------------------
145900210607         // Date of Birth
146000220104         //--------------------
146100220104         if l3_dob > '';
146200200106           oInfo  = 'DOB: ' + %Subst(l3_dob:5:2) +'/'+
146300220104           %Subst(l3_dob:7:2) +'/'+
146400220104           %Subst(l3_dob:1:4) ;
146500210510
146600220104           if pEnvir = 'P';
146700210607             oChgd = '';
146800220104             Check_Field = 'DOB';
146900220104             Check_History();
147000210607           endif;
147100171212
147200220104           write r_Output ;
147300200106         endif;
147400170130
147500171212
147600210510         //-----------------------
147700210607         // COBRA
147800220104         //-----------------------
147900220104         if l3_COBRA > '';
148000210510           oInfo  = 'COBRA: ' + l3_COBRA;
148100210510
148200220104           if pEnvir = 'P';
148300210510             oChgd = '';
148400210510             Check_Field = 'COBRA';
148500210510             Check_History();
148600211214
148700211214             // Show COBRA if any plan has changed.
148800211214             SearchArray = 0;
148900220104             SearchArray = %Lookup( 'Y' : ChgdArry );
149000211214             if SearchArray > 0;
149100220104               oChgd = 'Y';
149200220104             endif;
149300211214
149400210510           endif;
149500210510
149600220104           write r_Output ;
149700210510         endif;
149800210510
149900210510         //-----------------------
150000210510         // Qualifed Event
150100220104         //-----------------------
150200220104         if l3_qualevt > *Blanks;
150300211005
150400220104           // EASE Information
150500220104           if %SubSt( l3_Qualevt : 1 : 8) = 'EASE_QE_';
150600211005             chain l3_Qualevt EaseQeL1;
150700211005
150800211005             if %Found( EaseQeL1 );
150900220104               oInfo  = 'Qualifed Event: ' + q_Descr;
151000220104             endif;
151100211005
151200220104           else;
151300211005
151400220104             oInfo  = 'Qualifed Event: ' + l3_Qualevt;
151500211005           EndIf;
151600211005
151700210510
151800220104           if pEnvir = 'P';
151900210510             oChgd = '';
152000220104             Check_Field = 'QUALEVT';
152100220104             Check_History();
152200210510           endif;
152300210510
152400220104           write r_Output ;
152500210510         endif;
152600210510
152700210510         //--------------------
152800210510         // Qualifed Event Date
152900220104         //--------------------
153000220104         if l3_qeDate > '';
153100210510           oInfo  = 'QE Date: ' + %Subst(l3_qeDate:5:2) +'/'+
153200210607           %Subst(l3_qeDate:7:2) +'/'+
153300220104           %Subst(l3_qeDate:1:4) ;
153400210510
153500220104           if pEnvir = 'P';
153600210607             oChgd = '';
153700220104             Check_Field = 'QEDATE';
153800220104             Check_History();
153900210607           endif;
154000210510
154100220104           write r_Output ;
154200210510         endif;
154300210510
154400210510
154500210510         //-----------------------
154600210607         // Disabld
154700220104         //-----------------------
154800220104         if l3_disabld > *Blanks;
154900210510           oInfo  = 'Disabled: ' + l3_Disabld;
155000210510
155100220104           if pEnvir = 'P';
155200210510             oChgd = '';
155300220104             Check_Field = 'DISABLD';
155400220104             Check_History();
155500210510           endif;
155600210510
155700220104           write r_Output ;
155800210510         endif;
155900210510
156000210510
156100210510
156200210510
156300210510         //--------------------
156400210510         // Plans
156500220104         //--------------------
156600220104         for i = 1 to 26;
156700170130
156800200106           if PlanArry(i) = *Blanks;
156900220104             iter;
157000210607           endif;
157100170130
157200220104           // Production = If is no changes in a plan, skip.
157300220104           if pEnvir = 'P';
157400210607             if ChgdArry( i ) = '';
157500220104               iter;
157600220104             EndIf;
157700210607           EndIf;
157800170830
157900210510
158000210607           //----------------------------------------
158100210607           // PLAN  Description
158200210510           //----------------------------------------
158300220104           PlanDesc = *Blanks;
158400220104           if %len(%Trim(PlanArry(i))) = 4;
158500220104             chain (wTrst : wSub : PlanArry(i)) PlnMst;
158600210607             if %Found( PlnMst );
158700220104               PlanDesc = pDescr;
158800220104             endif;
158900210607           endif;
159000170830
159100201123           volPlanName = PlanArry(i);
159200201123
159300210510
159400210510
159500210510           //----------------------------------------
159600210510           // EASE PLAN Information
159700220104           //----------------------------------------
159800220104           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
159900200903             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
160000200903
160100220104             if %Found( EasePlanL1 );
160200210607               volPlanName = p_PlanName;
160300201123
160400210607               oInfo  = 'Plan: ' + %trim(p_PlanName);
160500201125
160600210607               if TermDtArry(i) = '';
160700220104                 oInfo = %Trim( oInfo ) +
160800220104                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
160900220104               endif;
161000201125
161100220104             else;
161200200903
161300210607               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
161400210607               %Trim(PlanDesc) ;
161500201125
161600201125               if TermDtArry(i) = '';
161700220104                 oInfo = %Trim( oInfo ) +
161800220104                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
161900220104               endif;
162000201125
162100210607             endif;
162200220104           else;
162300170130
162400210607             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
162500220104             %Trim(PlanDesc);
162600201125
162700210607             if TermDtArry(i) = '';
162800220104               oInfo = %Trim( oInfo ) +
162900220104                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
163000220104             endif;
163100210607           EndIf;
163200180516
163300200903
163400210510
163500210607           //--------------------
163600210607           // Term Date
163700220104           //--------------------
163800200903           if TermDtArry(i) > *Blanks;
163900220104             oInfo  = %Trim( oInfo ) +
164000220104             '  Term Date: ' + %trim(TermDtArry(i)) ;
164100210607           endif;
164200200903
164300201124
164400210607           //--------------------
164500210607           // Term Reason ( EASE )
164600220104           //--------------------
164700220104           if TermRsnArry(i)  > '';
164800201124
164900220104             // EASE Information
165000220104             if %SubSt( l4_TermRsn : 1 : 8) = 'EASE_QE_';
165100210607               chain l4_TermRsn EaseQeL1;
165200201124
165300210607               if %Found( EaseQeL1 );
165400220104                 oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + q_Descr;
165500220104               endif;
165600201124
165700220104             else;
165800201124
165900220104               oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + l1_Qualevt;
166000220104             EndIf;
166100201124
166200210607           endif;
166300201124
166400201124
166500201124
166600201122
166700210607           //--------------------
166800210607           // Vol Amount
166900220104           //--------------------
167000220104           if VolAmtArry(i) > '';
167100210607             oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
167200201122
167300201122             // Check for EASE EOI Amount.
167400210607             eoi_ssn = %Editc( wSSN : 'X' );
167500201122             chain ( wTrst : wSub : wAcct : eoi_ssn :
167600210607               l3_Fname : l3_dob : volPlanName ) EaseEOI;
167700210607             if %Found( EaseEoi );
167800220104               oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
167900220104               %trim(I_REQAMT) ;
168000201122
168100220104             EndIf;
168200201122
168300210607           endif;
168400210805
168500210805
168600210805           //  If we are here, oChgd should be 'Y';
168700210805           oChgd = 'Y';
168800210805
168900210607           write r_Output ;
169000210510
169100210510
169200210510
169300210510
169400210607           //--------------------
169500210607           // PCP Information
169600220104           //--------------------
169700220104           if PCP#Arry(i) > *Blanks;
169800220104             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
169900220104             write r_Output ;
170000210607           endif;
170100210510
170200210510
170300220104           if PCPNmArry(i) > *Blanks;
170400220104             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
170500220104             write r_Output ;
170600210510           endif;
170700210510
170800210510
170900220104           if PCPEfDtArry(i) > *Blanks;
171000220104             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
171100220104             write r_Output ;
171200210607           endif;
171300210510
171400210510
171500220104           if PCPTMDtArry(i) > *Blanks;
171600220104             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
171700220104             write r_Output ;
171800210607           endif;
171900210510
172000210615
172100220104           if Get_PlanxRef;
172200210615
172300210615             // Write out AmWins Plan Id's
172400210615             Setll ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
172500210615
172600220104             Dou %Eof(PlanxRefp);
172700220104               reade ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
172800210615               if %eof(PlanxRefp);
172900220104                 leave;
173000210615               endif;
173100210615
173200220104               oInfo = 'Amwins Plan id: ' + pxPlanId;
173300220104               write r_Output;
173400210615
173500220104             Enddo;
173600210615
173700220104           endif;
173800210614
173900210607         endfor;
174000170130
174100170130
174200210607         Clear PlanArry;
174300210607         Clear EnrlArry;
174400210607         Clear EffDtArry;
174500210607         Clear TermDtArry;
174600210510
174700210607         Clear CovgArry;
174800210607         Clear Pcp#Arry;
174900210607         Clear PcpNmArry;
175000220104         Clear pcpEfDtArry;
175100220104         Clear pcpTmDtArry;
175200210510
175300210607       End-proc;
175400200106
175500201216
175600220104       //---------------------------------------------------------
175700220104       Dcl-proc WriteWaive_Mbr;
175800201216
175900210608         setll ( wTrst : wSub : wAcct
176000220104         : l1_ssn: ' ' :  l1_FName ) EaseWaive;
176100201216
176200220104         Dou %Eof(EaseWaive);
176300210608           Reade ( wTrst : wSub : wAcct :
176400220104             l1_ssn: ' ' : l1_FName ) EaseWaive;
176500210607           if %eof(EaseWaive);
176600220104             leave;
176700210607           endif;
176800201216
176900210607           oType  = *Blanks;
177000210607           oInfo  = 'Waived Plan: ' + %Trim( W_PLANTYPE ) + ' - '  +
177100210607           %Trim( W_WAIVERSN );
177200201216
177300220104           write r_Output ;
177400201216
177500220104         Enddo;
177600201216
177700201216
177800210607       End-Proc;
177900201216
178000220104       //---------------------------------------------------------
178100220104       Dcl-proc WriteWaive_Dep;
178200201216
178300210608         setll ( wTrst : wSub : wAcct :
178400220104         l1_ssn:l3_depssn: l3_FName ) EaseWaive;
178500201216
178600220104         Dou %Eof(EaseWaive);
178700210608           reade ( wTrst : wSub : wAcct :
178800220104             l1_ssn:l3_depssn: l3_FName ) EaseWaive;
178900201216           if %eof(EaseWaive);
179000220104             leave;
179100210607           endif;
179200201216
179300210607           oType  = *Blanks;
179400210607           oInfo  = 'Waived Plan: ' + %Trim( W_PLANTYPE ) + ' - '  +
179500210607           %Trim( W_WAIVERSN );
179600201216
179700220104           write r_Output ;
179800201216
179900220104         Enddo;
180000201216
180100201216
180200210607       End-Proc;
180300210510
180400210601      *----------------------------------------------------------------
180500210601      * Omitted Members
180600210601      *----------------------------------------------------------------
180700210601
180800220104       dcl-proc Omitted_Mbr;
180900210601
181000210607         dcl-s PrintHeader Char(1) inz('Y');
181100210601
181200210601
181300210607         // List out the members on the file.
181400210607         Setll (pKey : eFileType) GbsDiffp;
181500210601
181600220104         Dou %Eof(GbsDiffp);
181700220104           reade (pKey : eFileType) GbsDiffp;
181800210607           if %eof(GbsDiffp);
181900220104             leave;
182000210607           endif;
182100210601
182200220104           if   gdFile = 'L1' and
182300220104           gdTo = 'Omitted Member';
182400210601
182500220104             if PrintHeader = 'Y';
182600210607               PrintHEader = 'N';
182700210607               oChgd = 'Y';
182800210607               oType = 'Member:';
182900220104               oInfo = ' * * * Omitted Members * * *';
183000220104               write r_Output;
183100210607             EndIf;
183200210601
183300210607             oChgd = 'Y';
183400210601             oType = '';
183500220104             oInfo = ' ** Member Not on File: ' + %Trim( gdssn );
183600220104             write r_Output;
183700220104           EndIf;
183800210601
183900210601
184000220104         Enddo;
184100210601
184200210601
184300210607       end-proc;
184400210601
184500210601
184600210510
184700210510      *----------------------------------------------------------------
184800210510      * Check History
184900210510      *----------------------------------------------------------------
185000220104       dcl-proc Check_History;
185100210510
185200210510
185300210607         @ssn = l1_ssn;
185400210510
185500210607         if oChgd = 'Y';
185600220104           return;
185700210510         EndIf;
185800210510
185900210510
186000210607         Setll ( pKey : eFileType : @ssn ) GbsDiffp;
186100210510
186200220104         Dou %Eof(GbsDiffp);
186300220104           reade ( pKey : eFileType : @ssn ) GbsDiffp;
186400210607           if %eof(GbsDiffp);
186500220104             leave;
186600210607           endif;
186700210510
186800210510
186900210607           // *Any - If there are any changes; in any field.
187000210607           // mark it as a change..   ( Used for SSN, and Name )
187100210510
187200210510
187300220104           if Check_Field = '*Any';
187400220104             oChgd = 'Y';
187500220104             leave;
187600210607           EndIf;
187700210510
187800220104           if gdFile = 'New-Rcd';
187900220104             oChgd = 'Y';
188000220104             leave;
188100210607           EndIf;
188200210510
188300210527
188400210628
188500220104           if Check_Field = '*AnyDep' ;
188600210527
188700220104             if gdFile = 'L3' and gdUniqId = l3_UniqId;
188800220104               oChgd = 'Y';
188900220104               leave;
189000210607             EndIf;
189100210527
189200220104             if gdFile = 'L4' and gdUniqId  = l4_UniqId;
189300220104               oChgd = 'Y';
189400220104               leave;
189500220104             EndIf;
189600210527
189700220104             if gdFile = 'L4' and gdUniqId = l3_UniqId
189800220104             and gdTo = 'Missing';
189900220104               oChgd = 'Y';
190000220104               leave;
190100220104
190200220104             EndIf;
190300220104
190400220104
190500210607           EndIf;
190600210510
190700210510
190800210628
190900220104           if gdFile <> Rcd_Level;
191000210607             iter;
191100220104           EndIf;
191200210510
191300210628
191400220104           // For a new Dependent, ALL Info should be
191500220104           // listed.
191600210607           if Rcd_Level = 'L3' and
191700220104           gdField = 'New-Dep' and
191800220104           gdTo = L3_UniqId;
191900210728
192000220104             // Dont need the SSN was changed Msg
192100220104             if Check_Field <> 'DEPSSN';
192200220104               oChgd = 'Y';
192300210728             endif;
192400210728
192500220104             iter;
192600210607           endif;
192700210510
192800210628
192900210524           // Record Level 2 should have the plan id
193000220104           // in GBSDIFFP
193100220104           if Rcd_Level = 'L2' and
193200220104           l2_plan <> gdPlanId ;
193300210607             iter;
193400220104           EndIf;
193500210518
193600210518
193700210524           // For a new Dependent, ALL plans should be
193800210607           // listed.
193900210607           if Rcd_Level = 'L4' and
194000210628              gdField = 'New-Dep' and
194100220104             gdFrom = l4_UniqId;
194200210628
194300220104             oChgd = 'Y';
194400220104             iter;
194500210524
194600210524           endif;
194700210524
194800210524
194900220104           if Rcd_Level = 'L4' and
195000220104           l4_plan <> gdPlanId ;
195100220104             iter;
195200210524           EndIf;
195300210524
195400210628
195500220104           // check for new Plans.
195600220104           if gdField = 'NEWPLAN' and
195700220104           gdFrom = l2_Plan;
195800210518
195900210518             oChgd = 'Y';
196000220104             leave;
196100210607           EndIf;
196200210510
196300210628           if gdField = Check_Field and
196400220104           gdUniqId = l3_Uniqid and
196500220104           Rcd_Level = 'L3' and
196600220104           Check_Field = 'DEPSSN';
196700210628
196800210628             oChgd = 'Y';
196900210628             leave;
197000210628
197100210628
197200210628           EndIf;
197300210628
197400210628
197500210628           if gdField = 'VOLAMT'
197600210628              and gdPlanId = l2_Plan
197700210628              and gdFile = 'L2';
197800210628
197900210628             oChgd = 'Y';
198000210628             leave;
198100210628
198200210628           EndIf;
198300210518
198400210628
198500210628           if gdField = 'VOLAMT'
198600220104           and gdPlanId = l4_Plan
198700220104             and gdFile = 'L4';
198800210628
198900220104             oChgd = 'Y';
199000220104             leave;
199100210628
199200220104           EndIf;
199300210628
199400210628
199500210628
199600220104           if Rcd_Level = 'L3';
199700220104             if gdField = Check_Field  and
199800210629               gdUniqId = l3_UniqId;
199900210629
200000210628
200100210629               oChgd = 'Y';
200200210628
200300220104               if gdField = 'NEWPLAN' or
200400220104               gdField = 'DEPSSN'  or
200500220104               gdField = 'VOLAMT';
200600210628
200700220104                 oChgd = '';
200800210628
200900210629               EndIf;
201000210628
201100210629               leave;
201200220104             EndIf;
201300220104           EndIf;
201400210510
201500210629
201600220104           // Level 4
201700220104           if Rcd_Level = 'L4';
201800220104             if gdField = Check_Field  and
201900210629               gdUniqId = l4_UniqId;
202000210629
202100210629
202200210629               oChgd = 'Y';
202300210629
202400220104               if gdField = 'NEWPLAN' or
202500220104               gdField = 'DEPSSN'  or
202600220104               gdField = 'VOLAMT';
202700210629
202800220104                 oChgd = '';
202900210629
203000210629               EndIf;
203100210629
203200210629               leave;
203300210629             EndIf;
203400210629           EndIf;
203500210629
203600210510
203700210629           if Rcd_Level = 'L2';
203800220104             if gdField = Check_Field  and
203900220104               gdPlanId = l2_Plan;
204000210629
204100210629               oChgd = 'Y';
204200210629               leave;
204300210728             endif;
204400210629
204500210629           EndIf;
204600210629
204700210629
204800210629           if Rcd_Level = 'L1';
204900210629             if gdField = Check_Field;
205000210629
205100210629               oChgd = 'Y';
205200210629               leave;
205300220104             endif;
205400210629
205500220104           EndIf;
205600210629
205700210629
205800220104           if Rcd_Level = 'L4';
205900220104             if gdPlanId = l4_plan  and
206000220104             gdUniqId = l4_UniqId and
206100220104             gdTo = 'New Plan';
206200210920
206300220104               oChgd = 'Y';
206400220104               leave;
206500220104             EndIf;
206600220104           EndIf;
206700210629
206800220104         Enddo;
206900210510
207000210510
207100210510
207200220104       End-Proc;
207300210510
207400210607      *----------------------------------------------------------------
207500210607      * Missing Plans
207600210607      *----------------------------------------------------------------
207700210607
207800220104       dcl-proc MissingPlans;
207900210607
208000210607
208100220104         dcl-s PrintHeader Char(1) inz('Y');
208200210607
208300220104         // List out the members on the file.
208400220104         Setll (pKey : eFileType: l1_ssn) GbsDiffp;
208500210607
208600220104         Dou %Eof(GbsDiffp);
208700220104           reade (pKey : eFileType : l1_ssn) GbsDiffp;
208800220104           if %eof(GbsDiffp);
208900220104             leave;
209000220104           endif;
209100210607
209200220104           if   gdFile = 'L2' and
209300220104           gdTo = 'Missing';
209400210607
209500210607             if PrintHeader = 'Y';
209600220104               PrintHEader = 'N';
209700220104               oChgd = 'Y';
209800220104               oType = ' ';
209900210607               oInfo = ' * * * Omitted Plans * * *';
210000210607               write r_Output;
210100220104             EndIf;
210200210607
210300220104             oChgd = 'Y';
210400220104             oType = '';
210500210728
210600210728
210700210728             // Check for EASE Plan
210800210728             if %SubSt( gdPlanId : 1 : 10) = 'EASE_PLAN_';
210900210728               chain (wTrst : wSub : wAcct : gdPlanId) EasePlanL1;
211000210728
211100220104               if %Found( EasePlanL1 );
211200220104                 oInfo = ' ** Plan Not on File: ' + %Trim( p_PlanName );
211300220104               else;
211400220104                 oInfo = ' ** Plan Not on File: ' + %Trim( gdPlanId );
211500210728
211600220104               endif;
211700210728
211800220104             else;
211900210728
212000220104               oInfo = ' ** Plan Not on File: ' + %Trim( gdPlanId );
212100210728
212200220104             endif;
212300220104             write r_Output;
212400210607
212500220104           endif;
212600210728         Enddo;
212700210607
212800210607
212900220104       end-proc;
213000210607
213100210607
213200220104       //-----------------------------------------------------------
213300220104       dcl-proc PrtMbrPlans;
213400210608
213500220214         dcl-s pos Zoned(5);
213600220214
213700220214
213800210608         PlnCnt = 1;
213900210609         l1_ssn = s_MbrSSN;
214000210609
214100210608         Clear PlanArry;
214200210608         Clear EnrlArry;
214300210608         Clear EffDtArry;
214400220104         Clear TermDtArry;
214500210608
214600220104         Clear CovgArry;
214700220104         Clear Pcp#Arry;
214800220104         Clear PcpNmArry;
214900220104         Clear pcpEfDtArry;
215000220104         Clear pcpTMdtArry;
215100210608
215200220104         setll l1_ssn Gbs20l2;
215300220104         dou %eof(Gbs20l2);
215400210608           reade l1_ssn Gbs20l2;
215500210608
215600210728           if %eof(Gbs20l2);
215700220104             leave;
215800220104           endif;
215900210608
216000220104           if l2_plan <> Plan_Name;
216100220104             iter;
216200220104           EndIf;
216300210608
216400220104           PlanArry(PlnCnt) = Plan_Name;
216500210609
216600220104           Select;
216700210728           When l2_enrl = 'P00';
216800220104             l2_Enrl = 'IN';
216900210728           When l2_enrl = 'F00';
217000220104             l2_Enrl = 'HW';
217100210728           When l2_enrl = 'P99';
217200220104             l2_Enrl = 'P2';
217300210728           When l2_enrl = 'F99';
217400220104             l2_Enrl = 'FA';
217500210608           When l2_enrl = 'P01';
217600220104             l2_Enrl = 'FC';
217700220104           Endsl;
217800210608           EnrlArry(PlnCnt) = l2_enrl;
217900210608
218000210608
218100210608           EffDtArry(PlnCnt) = %Subst(l2_effdt:5:2) +'/'+
218200220104           %Subst(l2_effdt:7:2) +'/'+
218300210608           %Subst(l2_effdt:1:4) ;
218400210608
218500210608           TermDtArry(PlnCnt) = '';
218600220104           if l2_termdt > '';
218700210728             TermDtArry(PlnCnt) = %Subst(l2_termdt:5:2) +'/'+
218800220104               %Subst(l2_termdt:7:2) +'/'+
218900220104               %Subst(l2_termdt:1:4) ;
219000210608
219100210608           endif;
219200210608
219300210608
219400210728           VolAmtArry(PlnCnt) = *Blanks;
219500220104           if l2_VolAmt > '' and l2_VolAmt <> '00000000.00';
219600210728             VolAmt$ = %Dec( l2_VolAmt : 11 : 0 );
219700210728             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
219800220104           endif;
219900210608
220000210608
220100220104           //?FSA Amount
220200220104           FSAAnnArry(PlnCnt) = *Blanks;
220300220104           FSAPPArry(PlnCnt) = *Blanks;
220400220104           if l2_fsa_ann > '' and l2_fsa_ann <> '0.00';
220500220104             FSAAmt$ = %Dec( l2_fsa_Ann : 7 : 2 );
220600220104             FSAAnnArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
220700210608
220800210608
220900220104             if l2_fsa_pp > '';
221000220104               FSAAmt$ = %Dec( l2_fsa_pp : 6 : 2 );
221100220104               FSAPPArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
221200220104             endif;
221300210608
221400220104             pHasFSA = 'Y';
221500220104           endif;
221600210608
221700220104           CovgArry( PlnCnt ) = l2_CovgTp;
221800220104           Pcp#Arry( PlnCnt ) = l2_Pcp#;
221900220104           PcpNmArry( PlnCnt ) = l2_PcpName;
222000220104           PcpEfDtArry( PlnCnt ) = l2_PcpEfDt;
222100220104           PcpTmDtArry( PlnCnt ) = l2_PcptmDt;
222200210608
222300210608
222400220104         enddo;
222500210608
222600220214
222700220214         // Check for Waived Members.
222800220214         pos = %lookup( 'Y' : ChgdArry );
222900220214         if pos > 0  OR  pEnvir = 'T';
223000220214
223100220214           chain wSSN Member;
223200220214           if %Found( Member );
223300220214             if Empst = 'W';
223400220214               oInfo = '** Member in WAIVED Status in GENIE';
223500220214               oChgd = 'Y';
223600220214               write r_output;
223700220214             EndIf;
223800220214           EndIf;
223900220214
224000220214         EndIf;
224100210608
224200220214
224300220104         //-----------------------
224400220104         // Plans
224500220104         //-----------------------
224600220104         for i = 1 to 1;
224700210608
224800220104           if PlanArry(i) = *Blanks;
224900220104             iter;
225000220104           endif;
225100210608
225200210608
225300210728           eoi_plan = planArry(i);
225400210728           PlanDesc = *Blanks;
225500210608
225600220104           if %len(%Trim(PlanArry(i))) = 4;
225700210728             chain (wTrst : wSub : PlanArry(i)) PlnMst;
225800210608             if %Found( PlnMst );
225900210728               PlanDesc = pDescr;
226000220104             endif;
226100220104           endif;
226200210608
226300210608
226400220104           // EASE Information
226500220104           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
226600220104             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
226700210608
226800220104             if %Found( EasePlanL1 );
226900210728               oInfo  = 'Plan: ' + %trim(p_PlanName);
227000210608
227100220104               if TermDtArry(i) = '';
227200220104                 oInfo = %Trim( oInfo ) +
227300220104                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
227400220104               EndIf;
227500210608
227600220104               eoi_Plan = p_PlanName;
227700210728             else;
227800210608
227900220104               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
228000210608               if TermDtArry(i) = '';
228100220104                 oInfo = %Trim( oInfo ) +
228200220104                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
228300220104               EndIf;
228400210608
228500220104             endif;
228600210728           else;
228700210608
228800220104             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc);
228900210608             if TermDtArry(i) = '';
229000220104               oInfo = %Trim( oInfo ) +
229100220104               '   Effective Date: ' + %trim(EffDtArry(i)) ;
229200210728             EndIf;
229300220104           EndIf;
229400210608
229500210608
229600220104           if TermDtArry(i) = '';
229700220104             if EnrlArry(i) > '';
229800210728               oInfo = %Trim(oInfo) + '  Enrollment Lvl: ' + EnrlArry(i);
229900220104             endif;
230000210608
230100210608
230200220104             if VolAmtArry(i) > '';
230300210608               oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
230400210608
230500220104               // Check for EASE EOI Amount.
230600220104               eoi_ssn = %Editc( wSSN : 'X' );
230700220104               chain ( wTrst : wSub : wAcct : eoi_ssn :
230800220104               l1_fname : l1_dob : eoi_Plan ) EaseEOI;
230900210608               if %Found( EaseEoi );
231000220104                 oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
231100220104                   %trim(I_REQAMT) ;
231200210608
231300220104               EndIf;
231400210608
231500220104             endif;
231600210608
231700210608
231800220104             if FSAAnnArry(i) > '';
231900220104               oInfo = %Trim(oInfo) + '  FSA Annual Amt: ' + FSAAnnArry(i);
232000220104               oInfo = %Trim(oInfo) + '  FSA Per Pay: ' + FSAPPArry(i);
232100210728             endif;
232200210608
232300210608           endif;
232400210608
232500210728           oChgd = ChgdArry( i );
232600210728           write r_Output ;
232700210608
232800220104           if TermDtArry(i) > *Blanks;
232900210608             oInfo  = 'Term Date: ' + %trim(TermDtArry(i)) ;
233000210608
233100220104             oChgd = ChgdArry( i );
233200220104             write r_Output ;
233300210728           endif;
233400210608
233500210608
233600220104           if CovgArry(i) > *Blanks;
233700220104             oInfo  = 'Coverage Type: ' + %trim(CovgArry(i)) ;
233800220104             oChgd = ChgdArry( i );
233900220104             write r_Output ;
234000210728           endif;
234100210608
234200210608
234300220104           if PCP#Arry(i) > *Blanks;
234400220104             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
234500220104             oChgd = ChgdArry( i );
234600220104             write r_Output ;
234700210728           endif;
234800210608
234900210608
235000220104           if PCPNmArry(i) > *Blanks;
235100220104             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
235200220104             oChgd = ChgdArry( i );
235300220104             write r_Output ;
235400210728           endif;
235500210608
235600210608
235700220104           if PCPEfDtArry(i) > *Blanks;
235800220104             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
235900220104             oChgd = ChgdArry( i );
236000220104             write r_Output ;
236100220104           endif;
236200210608
236300210608
236400220104           if PCPTMDtArry(i) > *Blanks;
236500220104             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
236600220104             oChgd = ChgdArry( i );
236700220104             write r_Output ;
236800220104           endif;
236900210608
237000210614
237100210614
237200210628         // Write out AmWins Plan Id's
237300210628         //    Setll ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
237400210628         //
237500210628         //    Dou %Eof(PlanxRefp);
237600210628         //      reade ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
237700210628         //      if %eof(PlanxRefp);
237800210628         //        leave;
237900210628         //      endif;
238000210628         //
238100210628         //      oInfo = 'Amwins Plan id: ' + pxPlanId;
238200220104         //      write r_Output;
238300220104         //
238400220104         //    Enddo;
238500210614
238600210614
238700210614
238800210614
238900210614
239000210608
239100220104         endfor;
239200210608
239300210608
239400210728       End-proc;
239500210614
239600210728       //-----------------------------------------------------------
239700210728       dcl-proc PrtDepPlans;
239800210623
239900220104         dcl-s volPlanName Char(50);
240000210625
240100210625
240200220104         PlnCnt = 1;
240300220104         l3_UniqId = s_UniqueId;
240400210625
240500220104         Clear PlanArry;
240600220104         Clear EnrlArry;
240700220104         Clear EffDtArry;
240800210623         Clear TermDtArry;
240900210623
241000210623         Clear CovgArry;
241100220104         Clear Pcp#Arry;
241200210623         Clear PcpNmArry;
241300210623         Clear pcpEfDtArry;
241400210728         Clear pcpTMdtArry;
241500210623
241600210728         setll l3_UniqId Gbs20l4;
241700210728         dou %eof(Gbs20l4);
241800220104           reade l3_UniqId Gbs20l4;
241900210623
242000220104           if %eof(Gbs20l4);
242100220104             leave;
242200220104           endif;
242300210623
242400220104           if l4_plan <> Plan_Name;
242500220104             iter;
242600220104           EndIf;
242700210623
242800210623           PlanArry(PlnCnt) = Plan_Name;
242900210623
243000210623
243100210623
243200220104           EffDtArry(PlnCnt) = %Subst(l4_effdt:5:2) +'/'+
243300220104           %Subst(l4_effdt:7:2) +'/'+
243400220104           %Subst(l4_effdt:1:4) ;
243500210623
243600220104           TermDtArry(PlnCnt) = '';
243700210625           if l4_termdt > '';
243800220104             TermDtArry(PlnCnt) = %Subst(l4_termdt:5:2) +'/'+
243900220104               %Subst(l4_termdt:7:2) +'/'+
244000220104               %Subst(l4_termdt:1:4) ;
244100210623
244200220104           endif;
244300210623
244400210623
244500220104           VolAmtArry(PlnCnt) = *Blanks;
244600220104           if l4_VolAmt > '' and l4_VolAmt <> '00000000.00';
244700220104             VolAmt$ = %Dec( l4_VolAmt : 11 : 0 );
244800220104             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
244900220104           endif;
245000210623
245100210623
245200210623
245300220104           CovgArry( PlnCnt ) = l4_CovgTyp;
245400220104           Pcp#Arry( PlnCnt ) = l4_Pcp#;
245500220104           PcpNmArry( PlnCnt ) = l4_PcpName;
245600220104           PcpEfDtArry( PlnCnt ) = l4_PcpEfDt;
245700220104           PcpTmDtArry( PlnCnt ) = l4_PcptmDt;
245800210623
245900210623
246000220104         enddo;
246100210623
246200210623
246300210623
246400220104         //-----------------------
246500220104         // Plans
246600220104         //-----------------------
246700220104         for i = 1 to 1;
246800210623
246900220104           if PlanArry(i) = *Blanks;
247000220104             iter;
247100210623           endif;
247200210623
247300210623
247400220104           if PlanArry(i) = *Blanks;
247500220104             iter;
247600220104           endif;
247700210625
247800220104           // Production = If is no changes in a plan, skip.
247900220104           if pEnvir = 'P';
248000220104             if ChgdArry( i ) = '';
248100220104               iter;
248200220104             EndIf;
248300210625           EndIf;
248400210625
248500210625
248600220104           //----------------------------------------
248700220104           // PLAN  Description
248800220104           //----------------------------------------
248900220104           PlanDesc = *Blanks;
249000220104           if %len(%Trim(PlanArry(i))) = 4;
249100220104             chain (wTrst : wSub : PlanArry(i)) PlnMst;
249200220104             if %Found( PlnMst );
249300220104               PlanDesc = pDescr;
249400220104             endif;
249500220104           endif;
249600210625
249700220104           volPlanName = PlanArry(i);
249800210625
249900210625
250000210625
250100210625           //----------------------------------------
250200210728           // EASE PLAN Information
250300220104           //----------------------------------------
250400210728           if %SubSt( PlanArry(i) : 1 : 10) = 'EASE_PLAN_';
250500220104             chain (wTrst : wSub : wAcct : PlanArry(i)) EasePlanL1;
250600210625
250700220104             if %Found( EasePlanL1 );
250800220104               volPlanName = p_PlanName;
250900210625
251000220104               oInfo  = 'Plan: ' + %trim(p_PlanName);
251100210625
251200220104               if TermDtArry(i) = '';
251300220104                 oInfo = %Trim( oInfo ) +
251400220104                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
251500220104               endif;
251600210625
251700220104             else;
251800210625
251900220104               oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
252000220104               %Trim(PlanDesc) ;
252100210625
252200220104               if TermDtArry(i) = '';
252300220104                 oInfo = %Trim( oInfo ) +
252400220104                   '   Effective Date: ' + %trim(EffDtArry(i)) ;
252500220104               endif;
252600210625
252700220104             endif;
252800220104           else;
252900210625
253000220104             oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' +
253100220104             %Trim(PlanDesc);
253200210625
253300220104             if TermDtArry(i) = '';
253400220104               oInfo = %Trim( oInfo ) +
253500220104                 '   Effective Date: ' + %trim(EffDtArry(i)) ;
253600220104             endif;
253700220104           EndIf;
253800210625
253900210625
254000210625
254100220104           //--------------------
254200220104           // Term Date
254300220104           //--------------------
254400220104           if TermDtArry(i) > *Blanks;
254500220104             oInfo  = %Trim( oInfo ) +
254600220104             '  Term Date: ' + %trim(TermDtArry(i)) ;
254700210625           endif;
254800210625
254900210625
255000220104           //--------------------
255100210728           // Term Reason ( EASE )
255200220104           //--------------------
255300220104           if TermRsnArry(i)  > '';
255400210625
255500220104             // EASE Information
255600220104             if %SubSt( l4_TermRsn : 1 : 8) = 'EASE_QE_';
255700220104               chain l4_TermRsn EaseQeL1;
255800210625
255900220104               if %Found( EaseQeL1 );
256000220104                 oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + q_Descr;
256100220104               endif;
256200210625
256300220104             else;
256400210625
256500220104               oInfo  = %Trim( oInfo ) + '  Qualified Event: ' + l1_Qualevt;
256600220104             EndIf;
256700210625
256800220104           endif;
256900210625
257000210625
257100210625
257200210625
257300220104           //--------------------
257400210728           // Vol Amount
257500220104           //--------------------
257600220104           if VolAmtArry(i) > '';
257700220104             oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
257800210625
257900220104             // Check for EASE EOI Amount.
258000220104             eoi_ssn = %Editc( wSSN : 'X' );
258100220104             chain ( wTrst : wSub : wAcct : eoi_ssn :
258200220104             l3_Fname : l3_dob : volPlanName ) EaseEOI;
258300220104             if %Found( EaseEoi );
258400220104               oInfo = %Trim(oInfo) + '  Requested Amount: EOI Needed: ' +
258500220104               %trim(I_REQAMT) ;
258600210625
258700220104             EndIf;
258800210625
258900220104           endif;
259000220104           write r_Output ;
259100210625
259200210625
259300210625
259400210625
259500220104           //--------------------
259600220104           // PCP Information
259700220104           //--------------------
259800220104           if PCP#Arry(i) > *Blanks;
259900220104             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
260000220104             write r_Output ;
260100220104           endif;
260200210625
260300210625
260400220104           if PCPNmArry(i) > *Blanks;
260500220104             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
260600220104             write r_Output ;
260700220104           endif;
260800210625
260900210625
261000220104           if PCPEfDtArry(i) > *Blanks;
261100220104             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
261200220104             write r_Output ;
261300220104           endif;
261400210625
261500210625
261600220104           if PCPTMDtArry(i) > *Blanks;
261700220104             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
261800220104             write r_Output ;
261900210728           endif;
262000210625
262100210625
262200210728           if Get_PlanxRef;
262300210625
262400220104             // Write out AmWins Plan Id's
262500220104             Setll ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
262600210625
262700220104             Dou %Eof(PlanxRefp);
262800220104               reade ( wTrst : wSub : wAcct : PlanArry(i)) PlanxRefp;
262900220104               if %eof(PlanxRefp);
263000220104                 leave;
263100220104               endif;
263200210625
263300220104               oInfo = 'Amwins Plan id: ' + pxPlanId;
263400220104               write r_Output;
263500210625
263600220104             Enddo;
263700210625
263800220104           endif;
263900210625
264000220104         endfor;
264100210625
264200210625
264300220104         Clear PlanArry;
264400220104         Clear EnrlArry;
264500220104         Clear EffDtArry;
264600220104         Clear TermDtArry;
264700210625
264800220104         Clear CovgArry;
264900220104         Clear Pcp#Arry;
265000220104         Clear PcpNmArry;
265100220104         Clear pcpEfDtArry;
265200220104         Clear pcpTmDtArry;
265300210625
265400210623
265500210623
265600220104       End-proc;
265700210623
265800210614      *-------------------------------------------------------------------------
265900210614      *
266000210614      *
266100210614      *
266200210614      *-------------------------------------------------------------------------
266300220104BR01   dcl-proc Single_Member;
266400210614
266500210614
266600210614
266700220104         setll s_MbrSSN Gbs20l1;
266800220104         dou %Eof(Gbs20L1);
266900210614           reade s_MbrSSN Gbs20L1;
267000210614
267100210614           if %eof(Gbs20L1);
267200220104             leave;
267300210614           endif;
267400210614
267500210614           l1_FName = EdtString(l1_FName:'NAME');
267600210614           l1_LName = EdtString(l1_LName:'NAME');
267700210614           l1_Addr1 = EdtString(l1_Addr1:'ADDR');
267800210614           l1_Addr2 = EdtString(l1_Addr2:'ADDR');
267900210614           l1_City = EdtString(l1_City:'NAME');
268000210614           l1_State = EdtString(l1_State:'NAME');
268100210614
268200210614
268300210614           //?Get the Member Plans then Write Record.
268400220104           GetMbrPlans();
268500220104           WriteMbrRcd();
268600220104           WriteWaive_Mbr();
268700210614
268800220104           MissingPlans();
268900210614
269000210614
269100220104           //?Get the Dependents...
269200220104           setll l1_ssn Gbs20l3;
269300220104           dou %eof(Gbs20l3);
269400210614             reade l1_ssn Gbs20l3;
269500210614
269600210614             if %eof(Gbs20l3);
269700220104               leave;
269800210614             endif;
269900210614
270000220104             l3_FName = EdtString(l3_FName:'NAME');
270100220104             l3_LName = EdtString(l3_LName:'NAME');
270200220104             l3_Addr1 = EdtString(l3_Addr1:'ADDR');
270300220104             l3_Addr2 = EdtString(l3_Addr2:'ADDR');
270400220104             l3_City = EdtString(l3_City:'NAME');
270500220104             l3_State = EdtString(l3_State:'NAME');
270600210614
270700210728             GetDepnPlans();
270800210728             WriteDepnRcd();
270900220104             WriteWaive_Dep();
271000210614
271100220104           enddo;
271200210614
271300220104           // Any Omitted Dependents?
271400220104           Setll (pKey : eFileType : l1_ssn) GbsDiffp;
271500210614
271600220104           Dou %Eof(GbsDiffp);
271700220104             reade (pKey : eFileType : l1_ssn) GbsDiffp;
271800220104             if %eof(GbsDiffp);
271900210614               leave;
272000220104             endif;
272100210614
272200220104             if   gdFile = 'L3' and
272300220104             gdTo = 'Omitted Dependent';
272400210614
272500220104               oChgd = 'Y';
272600220104               oType  = '';
272700220104               oInfo = ' ';
272800210614
272900220104               write r_Output;
273000210614
273100220104               oChgd = 'Y';
273200220104               oType  = 'Dependent:';
273300220104               oInfo = ' ** Dependent Not on File: ' + %Trim( gdFrom );
273400220104               write r_Output;
273500220104             EndIf;
273600210614
273700210614
273800220104           Enddo;
273900210614
274000210614
274100220104           oType  = *Blanks;
274200220104           oInfo  = *Blanks;
274300220104           write r_Output;
274400220104         enddo;
274500210614
274600220104       end-proc;
274700210614
274800210614
274900210614      *-------------------------------------------------------------------------
275000210614      *
275100210614      *
275200210614      *
275300210614      *
275400210614      *-------------------------------------------------------------------------
275500220104BR01   dcl-proc Single_Dependent;
275600210614
275700220104         //?Get the Dependents...
275800220104         setll s_MbrSSN Gbs20l3;
275900220104         dou %eof(Gbs20l3);
276000210614           reade s_MbrSSN Gbs20l3;
276100210614
276200210728           if %eof(Gbs20l3);
276300220104             leave;
276400210614           endif;
276500210614
276600210614           if L3_UNIQID <> s_UniqueId;
276700220104             iter;
276800210614           EndIf;
276900210614
277000220104           l3_FName = EdtString(l3_FName:'NAME');
277100220104           l3_LName = EdtString(l3_LName:'NAME');
277200220104           l3_Addr1 = EdtString(l3_Addr1:'ADDR');
277300220104           l3_Addr2 = EdtString(l3_Addr2:'ADDR');
277400220104           l3_City = EdtString(l3_City:'NAME');
277500220104           l3_State = EdtString(l3_State:'NAME');
277600210614
277700220104           GetDepnPlans();
277800220104           WriteDepnRcd();
277900220104           WriteWaive_Dep();
278000210614
278100220104         enddo;
278200210614
278300210614
278400220104       end-proc;
278500210629
278600210629
278700210629      *-------------------------------------------------------------------------
278800210629      *
278900210629      *
279000210629      *
279100210629      *
279200210629      *-------------------------------------------------------------------------
279300220104       dcl-proc Miss_DepPlans;
279400210629
279500220104         dcl-s FirstTime ind;
279600210629
279700220104         FirstTime = *on;
279800220104         @ssn = l1_ssn;
279900210629
280000210629
280100220104         Setll ( pKey : eFileType : @ssn ) GbsDiffp;
280200210629
280300220104         Dou %Eof(GbsDiffp);
280400220104           reade ( pKey : eFileType : @ssn ) GbsDiffp;
280500220104           if %eof(GbsDiffp);
280600210728             leave;
280700220104           endif;
280800210629
280900210629
281000220104           // Level 4 - Missiing Plans
281100220104           if gdField = 'PLAN'  and
281200220104           gdUniqId = l3_UniqId and
281300220104           gdto = 'Missing';
281400210629
281500220104             oChgd = 'Y';
281600210629
281700210728             if FirstTime;
281800220104               oType = '';
281900220104               oInfo = '';
282000220104               Write r_Output;
282100210629
282200210728               oInfo = '** Missing Plans(s) **';
282300210728               Write r_Output;
282400210629
282500220104               FirstTime = *off;
282600220104             endif;
282700210629
282800210728             oInfo = 'Plan: ' + gdPlanId;
282900210629
283000210728             // Check for Ease Plan
283100220104             if %SubSt( gdPlanId : 1 : 10) = 'EASE_PLAN_';
283200220104               chain (wTrst : wSub : wAcct : gdPlanId)  EasePlanL1;
283300210629
283400220104               if %Found( EasePlanL1 );
283500220104                 oInfo  = 'Plan: ' + %trim(p_PlanName);
283600220104               EndIf;
283700210629
283800220104             EndIf;
283900210629
284000220104             Write r_Output;
284100220104           EndIf;
284200210629
284300210629
284400210629
284500220104         Enddo;
284600210629
284700210629
284800210629
284900210629       end-proc;
