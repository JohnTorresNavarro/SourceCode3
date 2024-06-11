000100210504
000200210504       Ctl-Opt option(*noDebugIo)  DFTACTGRP(*NO)  bnddir('GBSBIND');
000300210504
000400200106      *-------------------------------------------------------------------------
000500200106      *
000600200106      *  Description: Format the Edifice Solutions Data File
000700160708      *
000800200106      *  Programmer.: Brian Rees
000900200106      *  Date.......: 08/07/2017
001000200106      *
001100200106      *-------------------------------------------------------------------------
001200200106      * Change Log
001300200106      *
001400200106      * 01/06/2020  Added the Removal of commas in the fields.
001500200106      *  Mod Id: Br01
001600210504      *
001700210504      *  5/04/2021  Added marking ADPOutput with Changes.
001800210504      *
001900210504      *
002000200106      *-------------------------------------------------------------------------
002100170807     FADPOutputpif a e           k disk
002200170112
002300191205     FUltiSoftL1if   e           k disk    rename(ultisoftr:Rec1) usropn
002400191205     FUltiSoftL2if   e           k disk    rename(ultisoftr:Rec2) usropn
002500191205     FUltiSoftL3if   e           k disk    rename(ultisoftr:Rec3) usropn
002600191205     FUltiSoftL4if   e           k disk    rename(ultisoftr:Rec4) usropn
002700170112     F*?Ultimate Software Import File.
002800170509
002900170830
003000170830     FPlnMst    if   e           k disk    ExtDesc('F.PLNMST') ExtFile(*extdesc)
003100171211     FGBS0029P  if   e           k disk
003200171211     F*?Location Cross Reference
003300180516
003400210106       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
003500210504       dcl-f gbsDiffp keyed;
003600180516
003700210504
003800210504
003900180516      *-------------------------------------------------------------------------
004000160708
004100170112
004200181025     d PlanArry        s             20a   dim(26)
004300181025     d EnrlArry        s              3a   dim(26)
004400181025     d EffDtArry       s             10a   dim(26)
004500181025     d TermDtArry      s             10a   dim(26)
004600181025     d VolAmtArry      s             11a   dim(26)
004700181025     d FSAAnnArry      s              9a   dim(26)
004800181025     d FSAPPArry       s              9a   dim(26)
004900170112     d PlnCnt          s              3s 0
005000170130     d i               s              2s 0 inz
005100170130
005200170201     D Office          s             30    inz
005300170713     d count           s              5s 0
005400170830     d PlanDesc        s             40
005500171214     d VolAmt$         s             11s 0
005600171214     d FSAAmt$         s              6s 2
005700180516
005800210506       dcl-s Check_Field Char(10);
005900210506
006000210506       dcl-s ChgdArry    Char(1)  Dim(26);
006100210506       dcl-s CovgArry    Char(5)  Dim(26);
006200210506       dcl-s PCP#Arry    Char(20) Dim(26);
006300210506       dcl-s PCPNmArry   Char(50) Dim(26);
006400210506       dcl-s PCPEfdtArry Char(8)  Dim(26);
006500210517       dcl-s PCPTMdtArry Char(8)  Dim(26);
006600210506
006700210506
006800180711       dcl-s wSalary Zoned(9:2);
006900180516       dcl-s wSSn Zoned(9);
007000180516       dcl-s wSSnChar Char(11);
007100180516
007200181003       dcl-s wTrst Zoned( 3 );
007300181003       dcl-s wSub  Zoned( 3 );
007400181003       dcl-s wAcct Zoned( 4 );
007500181003
007600210506       dcl-s Rcd_Level Char(10);
007700210504
007800210504
007900210504      *--------------------------------------------
008000210504      *
008100210504      * Procedures
008200210504      *
008300210504      *--------------------------------------------
008400210504      /Include *LIBL/QMODSRC,#EdtStngPr            // Edit String
008500210504      /Include *LIBL/QMODSRC,Pr0001rPr             // Case Functions
008600210504
008700210504
008800171212
008900210504      *-------------------------------------------------------------------------
009000210504      *
009100210504      * *Entry Procedure
009200210504      *
009300210504      *-------------------------------------------------------------------------
009400210504       Dcl-pr Main ExtPgm;
009500210504         *N  Char(1);
009600210504         *N  Char(10);
009700210504         *N  Char(1);
009800210504         *N  Char(1);
009900210517         *N  Char(10);
010000210504       End-Pr;
010100210504
010200210504       dcl-pi Main;
010300210504         hasOrphan Char(1);
010400210504         pKey Char(10);
010500210504         phasFSA Char(1);
010600210504         pEnvir Char(1);
010700210504         eFileType Char(10);
010800210504       End-Pi;
010900170112
011000210504      *-------------------------------------------------------------------------
011100160926      * Mainline Program
011200160926      *-------------------------------------------------------------------------
011300191205       open UltiSoftl1;
011400191205       open UltiSoftl2;
011500191205       open UltiSoftl3;
011600191205       open UltiSoftl4;
011700191205
011800191205
011900180516       pHasFSA   = 'N';
012000180102
012100181003       wTrst = %Dec( %Subst( pKey : 1 : 3 ) : 3 : 0 ) ;
012200181003       wSub  = %Dec( %Subst( pKey : 4 : 3 ) : 3 : 0 ) ;
012300181003       wAcct = %Dec( %Subst( pKey : 7 : 4 ) : 4 : 0 ) ;
012400181003
012500210531       Omitted_Mbr();
012501210531
012600180516       exsr ProcessData;
012700170713
012800210504       // Check for Orphan Records.
012900180516       hasOrphan = 'N';
013000170713
013100220314       Exec Sql
013200220314         Select Count(*)
013300220314           Into :Count
013400220314           From Ultisoftl3
013500220314           Where L3_Partssn Not In (Select L1_Ssn
013600220314                 From Ultisoftl1);
013700170713
013800210106       if Count > 0;
013900210106         hasOrphan = 'Y';
014000180516       endif;
014100170713
014200191205       Close UltiSoftl1;
014300191205       Close UltiSoftl2;
014400191205       Close UltiSoftl3;
014500191205       Close UltiSoftl4;
014600191205
014700180516       *inlr = *on;
014800170509
014900160708
015000210504      *-------------------------------------------------------------------------
015100170112       Begsr ProcessData;
015200170112
015300200106         setll *loval UltiSoftl1;
015400200106         dou %Eof(UltiSoftL1);
015500200106           read UltiSoftL1;
015600170112
015700200106           if %eof(UltiSoftL1);
015800200106             leave;
015900200106           endif;
016000170112
016100210504br01       l1_FName = EdtString(l1_FName:'NAME');
016200210504br01       l1_LName = EdtString(l1_LName:'NAME');
016300210504br01       l1_Addr1 = EdtString(l1_Addr1:'ADDR');
016400210504br01       l1_Addr2 = EdtString(l1_Addr2:'ADDR');
016500210504br01       l1_City = EdtString(l1_City:'NAME');
016600210504br01       l1_State = EdtString(l1_State:'NAME');
016700210504
016800210504
016900200106
017000210504           // Get the Member Plans then Write Record.
017100200106           Exsr GetMbrPlans;
017200200106           Exsr WriteMbrRcd;
017300170112
017400210504           // Get the Dependents...
017500200106           setll l1_ssn ultisoftl3;
017600200106           dou %eof(ultisoftl3);
017700200106             reade l1_ssn ultisoftl3;
017800170112
017900200106             if %eof(ultisoftl3);
018000200106               leave;
018100200106             endif;
018200170112
018300210504br01         l3_FName = EdtString(l3_FName:'NAME');
018400210504br01         l3_LName = EdtString(l3_LName:'NAME');
018500210504br01         l3_Addr1 = EdtString(l3_Addr1:'ADDR');
018600210504br01         l3_Addr2 = EdtString(l3_Addr2:'ADDR');
018700210504br01         l3_City = EdtString(l3_City:'NAME');
018800210504br01         l3_State = EdtString(l3_State:'NAME');
018900200106
019000200106             Exsr GetDepnPlans;
019100200106             Exsr WriteDepnRcd;
019200170112
019300200106           enddo;
019301210531
019302210531
019303210531           // Any Omitted Dependents?
019305210531           Setll (pKey : eFileType : l1_ssn) GbsDiffp;
019306210531
019307210531           Dou %Eof(GbsDiffp);
019308210531             reade (pKey : eFileType : l1_ssn) GbsDiffp;
019309210531             if %eof(GbsDiffp);
019310210531               leave;
019311210531             endif;
019312210531
019313210531             if   gdFile = 'L3' and
019314210531               gdTo = 'Omitted Dependent';
019315210531
019316210531               oChgd = 'Y';
019317210531               oType = ' ';
019318210531               oInfo = ' ';
019319210531
019320210531               write r_Output;
019321210531
019322210531               oChgd = 'Y';
019323210601               oType  = 'Dependent:';
019326210531               oInfo = ' ** Dependent Not on File: ' + %Trim( gdFrom );
019327210531               write r_Output;
019328210531             EndIf;
019329210531
019330210531
019331210531           Enddo;
019332210531
019333210531
019400170112
019500200106           oType  = *Blanks;
019600200106           oInfo  = *Blanks;
019700200106           write r_Output;
019800200106         enddo;
019900170112
020000180516       endsr;
020100170112       //-----------------------------------------------------------
020200180516       begsr GetMbrPlans;
020300170112
020400210506         Rcd_Level = 'L2';
020500200106         PlnCnt = 0;
020600170112
020700200106         setll l1_ssn ultisoftl2;
020800200106         dou %eof(ultisoftl2);
020900200106           reade l1_ssn ultisoftl2;
021000170112
021100200106           if %eof(ultisoftl2);
021200200106             leave;
021300200106           endif;
021400170112
021500200106           PlnCnt = PlnCnt + 1;
021600200106           PlanArry(PlnCnt) = l2_plan;
021700210506           ChgdArry(plnCnt) = '';
021800210506           oChgd = '';
021900210504
022000210504
022100200106           Select;
022200200106           When l2_enrl = 'P00';
022300200106             l2_Enrl = 'IN';
022400200106           When l2_enrl = 'F00';
022500200106             l2_Enrl = 'HW';
022600200106           When l2_enrl = 'P99';
022700200106             l2_Enrl = 'P2';
022800200106           When l2_enrl = 'F99';
022900200106             l2_Enrl = 'FA';
023000200106           When l2_enrl = 'P01';
023100200106             l2_Enrl = 'FC';
023200200106           Endsl;
023300200106           EnrlArry(PlnCnt) = l2_enrl;
023400171212
023500171212
023600200106           EffDtArry(PlnCnt) = %Subst(l2_effdt:5:2) +'/'+
023700200106              %Subst(l2_effdt:7:2) +'/'+
023800200106              %Subst(l2_effdt:1:4) ;
023900171212
024000200106           TermDtArry(PlnCnt) = '';
024100200106           if l2_termdt > '';
024200200106             TermDtArry(PlnCnt) = %Subst(l2_termdt:5:2) +'/'+
024300200106                %Subst(l2_termdt:7:2) +'/'+
024400200106                %Subst(l2_termdt:1:4) ;
024500171212
024600200106           endif;
024700200106           //TermDtArry(PlnCnt) = %Char(L2_termdt);
024800170124
024900171214
025000200106           VolAmtArry(PlnCnt) = *Blanks;
025100200106           if l2_VolAmt > '' and l2_VolAmt <> '00000000.00';
025200200106             VolAmt$ = %Dec( l2_VolAmt : 11 : 0 );
025300200106             VolAmtArry(PlnCnt) = %Trim( %Editc( VolAmt$ : 'J' ));
025400200106           endif;
025500171212
025600171214
025700210504           // FSA Amount
025800200106           FSAAnnArry(PlnCnt) = *Blanks;
025900200106           FSAPPArry(PlnCnt) = *Blanks;
026000200106           if l2_fsa_ann > '' and l2_fsa_ann <> '0.00';
026100200106             FSAAmt$ = %Dec( l2_fsa_Ann : 6 : 2 );
026200200106             FSAAnnArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
026300171214
026400180123
026500200106             if l2_fsa_pp > '';
026600200106               FSAAmt$ = %Dec( l2_fsa_pp : 6 : 2 );
026700200106               FSAPPArry(PlnCnt) = %Trim( %Editc( FSAAmt$ : 'J' ));
026800200106             endif;
026900180123
027000200106             pHasFSA = 'Y';
027100200106           endif;
027200171214
027300210506           CovgArry( PlnCnt ) = l2_CovgTp;
027400210506           Pcp#Arry( PlnCnt ) = l2_Pcp#;
027500210506           PcpNmArry( PlnCnt ) = l2_PcpName;
027600210506           PcpEfDtArry( PlnCnt ) = l2_PcpEfDt;
027700210506           PcpTmDtArry( PlnCnt ) = l2_PcptmDt;
027800210506
027900210506
028000210506           //---------------------------------------
028100210506           // Check if Any of the plan information
028200210506           // has been changed.
028300210506           //---------------------------------------
028400210506
028500210506           if pEnvir = 'P';
028600210517
028700210517
028800210517             Check_Field = 'NEWPLAN';
028900210517             Check_History();
029000210517             ChgdArry(plnCnt) = oChgd;
029100210517
029200210517
029300210506             Check_Field = 'EFFDT';
029400210506             Check_History();
029500210506             ChgdArry(plnCnt) = oChgd;
029600210506
029700210506             if oChgd = '';
029800210506               Check_Field = 'TERMDT';
029900210506               Check_History();
030000210506               ChgdArry(plnCnt) = oChgd;
030100210506             endif;
030200210506
030300210506             if oChgd = '';
030400210506               Check_Field = 'ENRL';
030500210506               Check_History();
030600210506               ChgdArry(plnCnt) = oChgd;
030700210506             endif;
030800210506
030900210506             if oChgd = '';
031000210506               Check_Field = 'FSAANN';
031100210506               Check_History();
031200210506               ChgdArry(plnCnt) = oChgd;
031300210506             endif;
031400210506
031500210506             if oChgd = '';
031600210506               Check_Field = 'FSAPP';
031700210506               Check_History();
031800210506               ChgdArry(plnCnt) = oChgd;
031900210506             endif;
032000210506
032100210506             if oChgd = '';
032200210506               Check_Field = 'VOLAMT';
032300210506               Check_History();
032400210506               ChgdArry(plnCnt) = oChgd;
032500210506             endif;
032600210506
032700210506             if oChgd = '';
032800210506               Check_Field = 'COVGTP';
032900210506               Check_History();
033000210506               ChgdArry(plnCnt) = oChgd;
033100210506             endif;
033200210506
033300210506             if oChgd = '';
033400210506               Check_Field = 'PCP#';
033500210506               Check_History();
033600210506               ChgdArry(plnCnt) = oChgd;
033700210506             endif;
033800210506
033900210506             if oChgd = '';
034000210506               Check_Field = 'PCPNAME';
034100210506               Check_History();
034200210506               ChgdArry(plnCnt) = oChgd;
034300210506             endif;
034400210506
034500210506             if oChgd = '';
034600210506               Check_Field = 'PCPEFDT';
034700210506               Check_History();
034800210506               ChgdArry(plnCnt) = oChgd;
034900210506             endif;
035000210506
035100210506             if oChgd = '';
035200210506               Check_Field = 'PCPTMDT';
035300210506               Check_History();
035400210506               ChgdArry(plnCnt) = oChgd;
035500210506             endif;
035600210506
035700210506           endif;
035800210506
035900210506
036000200106         enddo;
036100170112
036200170112
036300180516       endsr;
036400180516       //---------------------------------------------------------
036500180516       Begsr WriteMbrRcd;
036600170112
036700200106         wSSNChar = %Scanrpl('-': '' : l1_ssn );
036800200106         wSSN = %Dec( wSSNChar : 9 : 0 );
036900210506         Rcd_Level = 'L1';
037000180516
037100210506         //-----------------------
037200210506         // Member SSN
037300210506         //-----------------------
037400200106         oType  = 'Member:';
037500200106         oInfo  = %Subst(l1_ssn:1:3) + '-'+ %Subst(l1_ssn:4:2) + '-'+
037600200106            %Subst(l1_ssn:6:4);
037700210506
037800210506         if pEnvir = 'P';
037900210506           oChgd = '';
038000210506           Check_Field = '*Any';
038100210506           Check_History();
038200210506         endif;
038300210506
038400200106         write r_Output ;
038500170113
038600210506
038700210506         //-----------------------
038800210506         // Member Name
038900210506         //-----------------------
039000200106         oType  = *Blanks;
039100200106         oInfo  = %trim(l1_lname) + ', ' + %trim(l1_fname) + ' ' + L1_mi;
039200210506
039300210506         if pEnvir = 'P';
039400210506           oChgd = '';
039500210506           Check_Field = '*Any';
039600210506           Check_History();
039700210506         endif;
039800210506
039900200106         write r_Output ;
040000170113
040100210506
040200210506         //-----------------------
040300210506         // Address Line 1
040400210506         //-----------------------
040500200106         oInfo  = %trim(l1_Addr1);
040600210506
040700210506         if pEnvir = 'P';
040800210506           oChgd = '';
040900210506           Check_Field = 'ADDR1';
041000210506           Check_History()  ;
041100210506         endif;
041200210506
041300200106         write r_Output ;
041400170113
041500210506
041600210506         //-----------------------
041700210506         // Address Line 2
041800210506         //-----------------------
041900200106         if l1_addr2 > *Blanks;
042000200106           oInfo  = %trim(l1_Addr2);
042100210506
042200210506           if pEnvir = 'P';
042300210506             oChgd = '';
042400210506             Check_Field = 'ADDR2';
042500210506             Check_History();
042600210506           endif;
042700210506
042800200106           write r_Output ;
042900200106         endif;
043000170113
043100210506
043200210506         //-----------------------
043300210506         // City, State Zip
043400210506         //-----------------------
043500200106         oInfo  = %trim(l1_City) + ', ' + %trim(l1_State) + '  ' +
043600200106            %trim(l1_Zip);
043700210506
043800210506         if pEnvir = 'P';
043900210506           oChgd = '';
044000210506           Check_Field = 'CITY';
044100210506           Check_History();
044200210506           Check_Field = 'STATE';
044300210506           Check_History();
044400210506           Check_Field = 'ZIP';
044500210506           Check_History();
044600210506         endif;
044700210506
044800200106         write r_Output ;
044900170113
045000190626
045100210506         //-----------------------
045200210506         // Email Address
045300210506         //-----------------------
045400200106         if l1_Email > '';
045500200106           oInfo  = 'Email Addr: ' + %trim(l1_email) ;
045600210506
045700210506           if pEnvir = 'P';
045800210506             oChgd = '';
045900210506             Check_Field = 'EMAIL';
046000210506             Check_History();
046100210506           endif;
046200210506
046300200106           write r_Output ;
046400200106         endif;
046500190626
046600210506
046700210506         //-----------------------
046800210506         // SMoker
046900210506         //-----------------------
047000200106         if l1_Smoker > '';
047100200106           oInfo  = 'Smoker: ' + %trim(l1_Smoker) ;
047200210506
047300210506           if pEnvir = 'P';
047400210506             oChgd = '';
047500210506             Check_Field = 'SMOKER';
047600210506             Check_History();
047700210506           endif;
047800210506
047900200106           write r_Output ;
048000200106         endif;
048100190626
048200190626
048300210506         //-----------------------
048400210506         // Office / Location
048500210506         //-----------------------
048600200106         if l1_loc > *Blanks;
048700200106           Office = l1_loc;
048800200106           chain ( pKey : l1_loc ) gbs0029p;
048900200106           if %Found( GBS0029P ) ;
049000200106             office = axName ;
049100200106           endif;
049200171211
049300200106           oInfo  = 'Office: ' + %trim(l1_loc)  + ' - ' +  Office;
049400210506
049500210506           if pEnvir = 'P';
049600210506             oChgd = '';
049700210506             Check_Field = 'LOC';
049800210506             Check_History();
049900210506           endif;
050000210506
050100200106           write r_Output ;
050200171211
050300200106         endif;
050400170201
050500210506
050600210506
050700210506         //-----------------------
050800210506         // Full Location
050900210506         //-----------------------
051000200106         if L1_fullloc > '';
051100200106           oInfo  = 'Full Location: ' + %Trim( L1_fullloc );
051200210506
051300210506           if pEnvir = 'P';
051400210506             oChgd = '';
051500210506             Check_Field = 'FULLLOC';
051600210506             Check_History();
051700210506           endif;
051800210506
051900200106           write r_Output ;
052000200106         endif;
052100190710
052200210506
052300210506         //-----------------------
052400210506         // Term Date
052500210506         //-----------------------
052600200106         if l1_termdt > *Blanks;
052700200106           oInfo  = 'Member Termed Date: ' + l1_termdt;
052800210506
052900210506           if pEnvir = 'P';
053000210506             oChgd = '';
053100210506             Check_Field = 'TERMDT';
053200210506             Check_History();
053300210506           endif;
053400210506
053500200106           write r_Output ;
053600200106         endif;
053700170501
053800210506
053900210506         //-----------------------
054000210506         // Term Reason
054100210506         //-----------------------
054200200106         if l1_termRsn > *Blanks;
054300200106           oInfo  = 'Termed Reason: ' + l1_termrsn;
054400210506
054500210506           if pEnvir = 'P';
054600210506             oChgd = '';
054700210506             Check_Field = 'TERMRSN';
054800210506             Check_History();
054900210506           endif;
055000210506
055100200106           write r_Output ;
055200200106         endif;
055300190815
055400190815
055500210506         //-----------------------
055600210506         // Qualifed Event
055700210506         //-----------------------
055800200106         if l1_qualevt > *Blanks;
055900200106           oInfo  = 'Qualifed Event: ' + l1_Qualevt;
056000210506
056100210506           if pEnvir = 'P';
056200210506             oChgd = '';
056300210506             Check_Field = 'QUALEVT';
056400210506             Check_History();
056500210506           endif;
056600210506
056700200106           write r_Output ;
056800200106         endif;
056900190815
057000190815
057100190815
057200210506         //-----------------------
057300210506         // Gender
057400210506         //-----------------------
057500200106         oInfo  = 'Gender: ' + l1_gender;
057600210506
057700210506         if pEnvir = 'P';
057800210506           oChgd = '';
057900210506           Check_Field = 'GENDER';
058000210506           Check_History();
058100210506         endif;
058200210506
058300200106         write r_Output ;
058400170501
058500170501
058600210506         //-----------------------
058700210506         // Maritial Status
058800210506         //-----------------------
058900200106         if l1_marSts > *Blanks;
059000200106           Select;
059100200106           when l1_Marsts = 'D';
059200200106             oInfo  = 'Marital Status: Divorced';
059300200106           when l1_Marsts = 'I';
059400200106             oInfo  = 'Marital Status: Single';
059500200106           when l1_Marsts = 'M';
059600200106             oInfo  = 'Marital Status: Married';
059700200106           when l1_Marsts = 'S';
059800200106             oInfo  = 'Marital Status: Separated';
059900200106           when l1_Marsts = 'W';
060000200106             oInfo  = 'Marital Status: Widowed';
060100200106           endsl;
060200210506
060300210506           if pEnvir = 'P';
060400210506             oChgd = '';
060500210506             Check_Field = 'MARSTS';
060600210506             Check_History();
060700210506           endif;
060800210506
060900200106           write r_Output ;
061000200106         endif;
061100170501
061200170501
061300210506         //-----------------------
061400210506         // Salary
061500210506         //-----------------------
061600200106         if l1_sal > *Blanks;
061700200106           oInfo  = 'Salary: ' + l1_Sal;
061800210506
061900210506           if pEnvir = 'P';
062000210506             oChgd = '';
062100210506             Check_Field = 'SAL';
062200210506             Check_History();
062300210506           endif;
062400210506
062500200106           write r_Output ;
062600210106
062700210106           monitor;
062800210106             wSalary = %Dec( %Trim( l1_Sal ) : 9 : 2 );
062900210106
063000210106           on-error;
063100210106             wSalary = 0;
063200210106           EndMon;
063300210106
063400220314           Exec Sql
063500220314             Select Round(:Wsalary)
063600220314               Into :Wsalary
063700220314               From Sysibm.Sysdummy1;
063800180516
063900200106           chain wSSN Member;
064000200106           if %Found( Member );
064100200106             if wSalary <> Salary;
064200200106               oInfo = '** Salary does not match our system. ' +
064300200106                  'Current Value: ' +  %editc( Salary: '1') ;
064400200106               write r_output;
064500200106             EndIf;
064600200106           EndIf;
064700180516
064800210506
064900200106         endif;
065000170501
065100170829
065200170829
065300210506         //-----------------------
065400210506         // COBRA
065500210506         //-----------------------
065600200106         if l1_Cobra = 'Y';
065700210506           oInfo  = 'COBRA: Y';
065800210506
065900210506           if pEnvir = 'P';
066000210506             oChgd = '';
066100210506             Check_Field = 'COBRA';
066200210506             Check_History();
066300210506           endif;
066400210506
066500200106           write r_Output ;
066600200106         endif;
066700170829
066800170501
066900210506         //-----------------------
067000210506         // Date of Change
067100210506         //-----------------------
067200200106         if l1_doc > '';
067300200106           oInfo  = 'DOC: ' + %Subst(l1_doc:5:2) +'/'+
067400200106              %Subst(l1_doc:7:2) +'/'+
067500200106              %Subst(l1_doc:1:4) ;
067600210506
067700210506           if pEnvir = 'P';
067800210506             oChgd = '';
067900210506             Check_Field = 'DOC';
068000210506             Check_History();
068100210506           endif;
068200210506
068300200106           write r_Output ;
068400200106         endif;
068500190815
068600170501
068700210506         //-----------------------
068800210506         // Date of Birth
068900210506         //-----------------------
069000200106         if l1_dob > '';
069100200106           oInfo  = 'DOB: ' + %Subst(l1_dob:5:2) +'/'+
069200200106              %Subst(l1_dob:7:2) +'/'+
069300200106              %Subst(l1_dob:1:4) ;
069400171212
069500210506           if pEnvir = 'P';
069600210506             oChgd = '';
069700210506             Check_Field = 'DOB';
069800210506             Check_History();
069900210506           endif;
070000210506
070100200106           write r_Output ;
070200200106         endif;
070300171212
070400210506
070500210506
070600210506         //-----------------------
070700210506         // Date of Hire
070800210506         //-----------------------
070900200106         if l1_doh > '';
071000200106           oInfo  = 'DOH: ' + %Subst(l1_doh:5:2) +'/'+
071100200106              %Subst(l1_doh:7:2) +'/'+
071200200106              %Subst(l1_doh:1:4) ;
071300210506
071400210506           if pEnvir = 'P';
071500210506             oChgd = '';
071600210506             Check_Field = 'DOH';
071700210506             Check_History();
071800210506           endif;
071900210506
072000200106           write r_Output ;
072100200106         endif;
072200210506
072300170113
072400210506         //-----------------------
072500210506         // Class
072600210506         //-----------------------
072700200106         if l1_Class > '';
072800200106           oInfo  = 'Class: ' + l1_Class;
072900210506
073000210506           if pEnvir = 'P';
073100210506             oChgd = '';
073200210506             Check_Field = 'CLASS';
073300210506             Check_History();
073400210506           endif;
073500210506
073600200106           write r_Output ;
073700200106         endif;
073800190815
073900171212
074000210506         //-----------------------
074100210506         // Phone
074200210506         //-----------------------
074300200106         if l1_phone > '';
074400200106           oInfo  = 'Phone: ' + l1_Phone;
074500210506
074600210506           if pEnvir = 'P';
074700210506             oChgd = '';
074800210506             Check_Field = 'PHONE';
074900210506             Check_History();
075000210506           endif;
075100210506
075200200106           write r_Output ;
075300200106         endif;
075400170130
075500210506
075600210506         //-----------------------
075700210506         // Medicare Enrollment
075800210506         //-----------------------
075900200106         if l1_Medenrl > '';
076000200106           oInfo  = 'Enrolled in Medicare: ' + l1_Medenrl;
076100210506
076200210506           if pEnvir = 'P';
076300210506             oChgd = '';
076400210506             Check_Field = 'MEDENRL';
076500210506             Check_History();
076600210506           endif;
076700210506
076800200106           write r_Output ;
076900210506
077000190716
077100210506           //-----------------------
077200210506           // Medicare
077300210506           //-----------------------
077400200106           if l1_Medicar > '';
077500200106             oInfo  = 'Medicare Number: ' + l1_Medicar;
077600210506
077700210506             if pEnvir = 'P';
077800210506               oChgd = '';
077900210506               Check_Field = 'MEDICAR';
078000210506               Check_History();
078100210506             endif;
078200210506
078300200106             write r_Output ;
078400200106           endif;
078500200106         endif;
078600190716
078700210506
078800210506         //-----------------------
078900210506         // QE Date
079000210506         //-----------------------
079100210506         if l1_qeDate > '';
079200210506           oInfo  = 'Qualifying Event Date: ' +
079300210506              %Subst(l1_qeDate:5:2) +'/'+
079400210506              %Subst(l1_qeDate:7:2) +'/'+
079500210506              %Subst(l1_qeDate:1:4) ;
079600210506
079700210506
079800210506           if pEnvir = 'P';
079900210506             oChgd = '';
080000210506             Check_Field = 'QEDATE';
080100210506             Check_History();
080200210506           endif;
080300210506
080400210506           write r_Output ;
080500210506         endif;
080600210506
080700190716
080800210506         //-----------------------
080900210506         // Plans
081000210506         //-----------------------
081100200106         for i = 1 to 26;
081200170130
081300200106           if PlanArry(i) = *Blanks;
081400200713             iter;
081500200106           endif;
081600170130
081700210506
081800210506           // Production = If is no changes in a plan, skip.
081900210531           //    if pEnvir = 'P';
082000210531           //      if ChgdArry( i ) = '';
082100210531           //        iter;
082200210531           //      EndIf;
082300210531           //    EndIf;
082400170130
082500210506
082600200106           PlanDesc = *Blanks;
082700200106           if %len(%Trim(PlanArry(i))) = 4;
082800181003             chain (wTrst : wSub : PlanArry(i)) PlnMst;
082900170830             if %Found( PlnMst );
083000200106               PlanDesc = pDescr;
083100170830             endif;
083200200106           endif;
083300170830
083400200106           oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc) +
083500200106              '   Effective Date: ' + %trim(EffDtArry(i));
083600171212
083700171214
083800200106           if EnrlArry(i) > '';
083900200106             oInfo = %Trim(oInfo) + '  Enrollment Lvl: ' + EnrlArry(i);
084000200106           endif;
084100171214
084200171214
084300200106           if VolAmtArry(i) > '';
084400200106             oInfo = %Trim(oInfo) + '  Benefit Amount: ' + VolAmtArry(i);
084500200106           endif;
084600171212
084700171214
084800200106           if FSAAnnArry(i) > '';
084900200106             oInfo = %Trim(oInfo) + '  FSA Annual Amt: ' + FSAAnnArry(i);
085000200106             oInfo = %Trim(oInfo) + '  FSA Per Pay: ' + FSAPPArry(i);
085100200106           endif;
085200171214
085300210517           oChgd = ChgdArry( i );
085400200106           write r_Output ;
085500170124
085600170113
085700200106           if TermDtArry(i) > *Blanks;
085800200106             oInfo  = 'Term Date: ' + %trim(TermDtArry(i)) ;
085900210531             oChgd = ChgdArry( i );
086000200106             write r_Output ;
086100200106           endif;
086200210506
086300210506
086400210506           if CovgArry(i) > *Blanks;
086500210506             oInfo  = 'Coverage Type: ' + %trim(CovgArry(i)) ;
086600210531             oChgd = ChgdArry( i );
086700210506             write r_Output ;
086800210506           endif;
086900210506
087000210506
087100210506           if PCP#Arry(i) > *Blanks;
087200210506             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
087300210531             oChgd = ChgdArry( i );
087400210506             write r_Output ;
087500210506           endif;
087600210506
087700210506
087800210506           if PCPNmArry(i) > *Blanks;
087900210506             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
088000210531             oChgd = ChgdArry( i );
088100210506             write r_Output ;
088200210506           endif;
088300210506
088400210506
088500210506           if PCPEfDtArry(i) > *Blanks;
088600210506             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
088700210531             oChgd = ChgdArry( i );
088800210506             write r_Output ;
088900210506           endif;
089000210506
089100210506
089200210506           if PCPTMDtArry(i) > *Blanks;
089300210506             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
089400210531             oChgd = ChgdArry( i );
089500210506             write r_Output ;
089600210506           endif;
089700210506
089800210517
089900210517
090000200106         endfor;
090100170130
090200170124
090300200106         Clear PlanArry;
090400200106         Clear EnrlArry;
090500200106         Clear EffDtArry;
090600200106         Clear TermDtArry;
090700210506
090800210506         Clear CovgArry;
090900210506         Clear Pcp#Arry;
091000210506         Clear PcpNmArry;
091100210506         Clear pcpEfDtArry;
091200210517         Clear pcpTmDtArry;
091300210506
091400170112
091500180516       Endsr;
091600170112       //-----------------------------------------------------------
091700180516       begsr GetDepnPlans;
091800170112
091900200106         PlnCnt = 0;
092000210506         Rcd_Level = 'L4';
092100170112
092200200106         setll l3_uniqid ultisoftl4;
092300200106         dou %eof(ultisoftl4);
092400200106           reade l3_uniqid ultisoftl4;
092500170112
092600200106           if %eof(ultisoftl4);
092700200106             leave;
092800200106           endif;
092900170112
093000200106           PlnCnt = PlnCnt + 1;
093100200106           PlanArry(PlnCnt) = l4_plan;
093200210506           ChgdArry(plnCnt) = '';
093300210506           oChgd = '';
093400210506
093500171212
093600200106           EffDtArry(PlnCnt) = %Subst(l4_effdt:5:2) +'/'+
093700200106              %Subst(l4_effdt:7:2) +'/'+
093800200106              %Subst(l4_effdt:1:4) ;
093900171212
094000200106           TermDtArry(PlnCnt) = '';
094100200106           if l4_termdt > '';
094200200106             TermDtArry(PlnCnt) = %Subst(L4_termdt:5:2) +'/'+
094300200106                %Subst(L4_termdt:7:2) +'/'+
094400200106                %Subst(L4_termdt:1:4) ;
094500200106           endif;
094600210506
094700210517           CovgArry( PlnCnt ) = l4_CovgTyp;
094800210506           Pcp#Arry( PlnCnt ) = l4_Pcp#;
094900210506           PcpNmArry( PlnCnt ) = l4_PcpName;
095000210506           PcpEfDtArry( PlnCnt ) = l4_PcpEfDt;
095100210506           PcpTmDtArry( PlnCnt ) = l4_PcptmDt;
095200210506
095300210506           //---------------------------------------
095400210506           // Check if Any of the plan information
095500210506           // has been changed.
095600210506           //---------------------------------------
095700210506
095800210506           if pEnvir = 'P';
095900210517
096000210517             Check_Field = 'NEWPLAN';
096100210517             Check_History();
096200210517             ChgdArry(plnCnt) = oChgd;
096300210517
096400210517
096500210506             Check_Field = 'EFFDT';
096600210506             Check_History();
096700210506             ChgdArry(plnCnt) = oChgd;
096800210506
096900210506             if oChgd = '';
097000210506               Check_Field = 'TERMDT';
097100210506               Check_History();
097200210506               ChgdArry(plnCnt) = oChgd;
097300210506             endif;
097400210506
097500210506
097600210506             if oChgd = '';
097700210518               Check_Field = 'COVGTYP';
097800210506               Check_History();
097900210506               ChgdArry(plnCnt) = oChgd;
098000210506             endif;
098100210506
098200210506             if oChgd = '';
098300210506               Check_Field = 'PCP#';
098400210506               Check_History();
098500210506               ChgdArry(plnCnt) = oChgd;
098600210506             endif;
098700210506
098800210506             if oChgd = '';
098900210506               Check_Field = 'PCPNAME';
099000210506               Check_History();
099100210506               ChgdArry(plnCnt) = oChgd;
099200210506             endif;
099300210506
099400210506             if oChgd = '';
099500210506               Check_Field = 'PCPEFDT';
099600210506               Check_History();
099700210506               ChgdArry(plnCnt) = oChgd;
099800210506             endif;
099900210506
100000210506             if oChgd = '';
100100210506               Check_Field = 'PCPTMDT';
100200210506               Check_History();
100300210506               ChgdArry(plnCnt) = oChgd;
100400210506             endif;
100500210506
100600210506           endif;
100700210506
100800210506
100900210506
101000200106         enddo;
101100170112
101200170112
101300180516       endsr;
101400180516       //---------------------------------------------------------
101500180516       Begsr WriteDepnRcd;
101600170112
101700210506         Rcd_Level = 'L3';
101800210506
101900210506
102000210506         //--------------------
102100210506         // Dependent SSN
102200210506         //--------------------
102300200106         oType  = 'Dependent:';
102400200106         oInfo  = %Subst(l3_Depssn:1:3) + '-'+
102500200106            %Subst(l3_Depssn:4:2) + '-'+
102600200106            %Subst(l3_Depssn:6:4);
102700210506
102800210506         if pEnvir = 'P';
102900210506           oChgd = '';
103000210506           Check_Field = '*AnyDep';
103100210506           Check_History();
103200210506         endif;
103300210506
103400200106         write r_Output ;
103500170113
103600210506
103700210506         //--------------------
103800210506         // Dependent Name
103900210506         //--------------------
104000200106         oType  = *Blanks;
104100200106         oInfo  = %trim(l3_lname) + ', ' + %trim(l3_fname) + ' ' + l3_mi;
104200210506
104300210506         if pEnvir = 'P';
104400210506           oChgd = '';
104500210506           Check_Field = '*AnyDep';
104600210506           Check_History();
104700210506         endif;
104800210506
104900200106         write r_Output ;
105000170113
105100210506
105200210506         //--------------------
105300210506         // Dependent Address 1
105400210506         //--------------------
105500200106         oInfo  = %trim(l3_Addr1);
105600210506
105700210506         if pEnvir = 'P';
105800210506           oChgd = '';
105900210506           Check_Field = 'ADDR1';
106000210506           Check_History()  ;
106100210506         endif;
106200210506
106300200106         write r_Output ;
106400170113
106500210506
106600210506         //--------------------
106700210506         // Dependent Address 2
106800210506         //--------------------
106900200106         if l3_addr2 > *Blanks;
107000200106           oInfo  = %trim(l3_Addr2);
107100210506
107200210506           if pEnvir = 'P';
107300210506             oChgd = '';
107400210510             Check_Field = 'ADDR2';
107500210506             Check_History()  ;
107600210506           endif;
107700210506
107800200106           write r_Output ;
107900200106         endif;
108000170113
108100210506
108200210506         //--------------------
108300210506         // City, State, Zip
108400210506         //--------------------
108500200106         oInfo  = %trim(l3_City) + ', ' + %trim(l3_State) + '  ' +
108600200106            %trim(l3_Zip);
108700210506
108800210506         if pEnvir = 'P';
108900210506           oChgd = '';
109000210506           Check_Field = 'CITY';
109100210506           Check_History();
109200210506           Check_Field = 'STATE';
109300210506           Check_History();
109400210506           Check_Field = 'ZIP';
109500210506           Check_History();
109600210506         endif;
109700210506
109800200106         write r_Output ;
109900170113
110000210506
110100210506         //--------------------
110200210506         // Gender
110300210506         //--------------------
110400200106         oInfo  = 'Gender: ' + l3_gender;
110500210506
110600210506         if pEnvir = 'P';
110700210506           oChgd = '';
110800210506           Check_Field = 'GENDER';
110900210506           Check_History();
111000210506         endif;
111100210506
111200200106         write r_Output ;
111300170113
111400210510
111500210510         //--------------------
111600210510         // Relationship
111700210510         //--------------------
111800200106         Select;
111900200106         When L3_relcod = 'S';
112000200106           oInfo  = 'Relationship: Spouse';
112100200106         When L3_relcod = 'C';
112200200106           oInfo  = 'Relationship: Child';
112300200106         When L3_relcod = 'D';
112400200106           oInfo  = 'Relationship: Domestic Partner';
112500200106         Other;
112600200106           oInfo  = 'Relationship: ' + L3_relcod;
112700200106         Endsl;
112800210506
112900210506         if pEnvir = 'P';
113000210506           oChgd = '';
113100210506           Check_Field = 'RELCOD';
113200210506           Check_History();
113300210506         endif;
113400210506
113500200106         write r_Output ;
113600170130
113700170130
113800171212
113900210506         //--------------------
114000210506         // Date of Birth
114100210506         //--------------------
114200200106         if l3_dob > '';
114300200106           oInfo  = 'DOB: ' + %Subst(l3_dob:5:2) +'/'+
114400200106              %Subst(l3_dob:7:2) +'/'+
114500200106              %Subst(l3_dob:1:4) ;
114600210506
114700210506           if pEnvir = 'P';
114800210506             oChgd = '';
114900210506             Check_Field = 'DOB';
115000210506             Check_History();
115100210506           endif;
115200171212
115300200106           write r_Output ;
115400200106         endif;
115500170130
115600171212
115700210506         //-----------------------
115800210506         // COBRA
115900210506         //-----------------------
116000210506         if l3_COBRA > '';
116100210506           oInfo  = 'COBRA: ' + l3_COBRA;
116200210506
116300210506           if pEnvir = 'P';
116400210506             oChgd = '';
116500210506             Check_Field = 'COBRA';
116600210506             Check_History();
116700210506           endif;
116800210506
116900210506           write r_Output ;
117000210506         endif;
117100210506
117200210506         //-----------------------
117300210506         // Qualifed Event
117400210506         //-----------------------
117500210506         if l3_qualevt > *Blanks;
117600210506           oInfo  = 'Qualifed Event: ' + l3_Qualevt;
117700210506
117800210506           if pEnvir = 'P';
117900210506             oChgd = '';
118000210506             Check_Field = 'QUALEVT';
118100210506             Check_History();
118200210506           endif;
118300210506
118400210506           write r_Output ;
118500210506         endif;
118600210506
118700210506         //--------------------
118800210506         // Qualifed Event Date
118900210506         //--------------------
119000210506         if l3_qeDate > '';
119100210506           oInfo  = 'QE Date: ' + %Subst(l3_qeDate:5:2) +'/'+
119200210506              %Subst(l3_qeDate:7:2) +'/'+
119300210506              %Subst(l3_qeDate:1:4) ;
119400210506
119500210506           if pEnvir = 'P';
119600210506             oChgd = '';
119700210506             Check_Field = 'QEDATE';
119800210506             Check_History();
119900210506           endif;
120000210506
120100210506           write r_Output ;
120200210506         endif;
120300210506
120400210506
120500210506         //-----------------------
120600210506         // Disabld
120700210506         //-----------------------
120800210506         if l3_disabld > *Blanks;
120900210506           oInfo  = 'Disabled: ' + l3_Disabld;
121000210506
121100210506           if pEnvir = 'P';
121200210506             oChgd = '';
121300210506             Check_Field = 'DISABLD';
121400210506             Check_History();
121500210506           endif;
121600210506
121700210506           write r_Output ;
121800210506         endif;
121900171212
122000210506
122100210506
122200210506         //-----------------------
122300210506         // Plans
122400210506         //-----------------------
122500210506
122600200106         for i = 1 to 26;
122700170130
122800200106           if PlanArry(i) = *Blanks;
122900200713             iter;
123000200106           endif;
123100170130
123200210506           // Production = If is no changes in a plan, skip.
123300210506           if pEnvir = 'P';
123400210506             if ChgdArry( i ) = '';
123500210506               iter;
123600210506             EndIf;
123700210506           EndIf;
123800210506
123900210506
124000200106           PlanDesc = *Blanks;
124100200106           if %len(%Trim(PlanArry(i))) = 4;
124200181003             chain (wTrst : wSub : PlanArry(i)) PlnMst;
124300170830             if %Found( PlnMst );
124400200106               PlanDesc = pDescr;
124500170830             endif;
124600200106           endif;
124700170830
124800170130
124900200106           oInfo  = 'Plan: ' + %trim(PlanArry(i)) + ' - ' + %Trim(PlanDesc) +
125000200106              '   Effective Date: ' + %trim(EffDtArry(i)) ;
125100210517           oChgd = ChgdArry( i );
125200200106           write r_Output ;
125300180516
125400200106           if TermDtArry(i) > *Blanks;
125500200106             oInfo  = 'Term Date: ' + %trim(TermDtArry(i)) ;
125600210531             oChgd = ChgdArry( i );
125700200106             write r_Output ;
125800200106           endif;
125900180516
126000210506
126100210506           if PCP#Arry(i) > *Blanks;
126200210506             oInfo  = 'PCP #: ' + %trim(Pcp#Arry(i)) ;
126300210531             oChgd = ChgdArry( i );
126400210506             write r_Output ;
126500210506           endif;
126600210506
126700210506
126800210506           if PCPNmArry(i) > *Blanks;
126900210506             oInfo  = 'PCP Name: ' + %trim(PcpNmArry(i)) ;
127000210531             oChgd = ChgdArry( i );
127100210506             write r_Output ;
127200210506           endif;
127300210506
127400210506
127500210506           if PCPEfDtArry(i) > *Blanks;
127600210506             oInfo  = 'PCP Effective Date: ' + %trim(PcpEfDtArry(i)) ;
127700210531             oChgd = ChgdArry( i );
127800210506             write r_Output ;
127900210506           endif;
128000210506
128100210506
128200210506           if PCPTMDtArry(i) > *Blanks;
128300210506             oInfo  = 'PCP Termination Date: ' + %trim(PcpTmDtArry(i)) ;
128400210531             oChgd = ChgdArry( i );
128500210506             write r_Output ;
128600210506           endif;
128700210506
128800210517
128900210517
129000210506
129100200106         endfor;
129200170130
129300170130
129400200106         Clear PlanArry;
129500200106         Clear EnrlArry;
129600210506         Clear EffDtArry;
129700210506         Clear TermDtArry;
129800210506
129900210506         Clear CovgArry;
130000210506         Clear Pcp#Arry;
130100210506         Clear PcpNmArry;
130200210506         Clear pcpEfDtArry;
130300210517         Clear pcpTmDtArry;
130400170112
130500180516       Endsr;
130600200106
130700210504
130701210531      *----------------------------------------------------------------
130702210531      * Omitted Members
130703210531      *----------------------------------------------------------------
130800210504
130801210531       dcl-proc Omitted_Mbr;
130802210531
130803210531         dcl-s PrintHeader Char(1) inz('Y');
130804210531
130805210531
130806210531         // List out the members on the file.
130811210531         Setll (pKey : eFileType) GbsDiffp;
130812210531
130813210531         Dou %Eof(GbsDiffp);
130814210531           reade (pKey : eFileType) GbsDiffp;
130815210531           if %eof(GbsDiffp);
130816210531             leave;
130817210531           endif;
130818210531
130819210531           if   gdFile = 'L1' and
130820210813            ( gdTo = 'Omitted Member' or
130821210813              %Subst( gdTo : 1 : 15 ) = 'Member in Genie');
130822210531
130823210531             if PrintHeader = 'Y';
130824210531               PrintHEader = 'N';
130825210531               oChgd = 'Y';
130826210531               oType = 'Member:';
130827210531               oInfo = ' * * * Omitted Members * * *';
130828210531               write r_Output;
130829210531             EndIf;
130830210531
130831210813             oChgd = 'Y';
130832210531             oType = '';
130833210813
130834210813             if gdTo = 'Omitted Member';
130835220314               oInfo = ' ** Member Not on File: ' + %Trim( gdssn );
130836210813             else;
130837210814               oInfo = %Trim( gdTo ) + '  ' + %Trim( gdssn );
130838210813             endif;
130839210813
130840210813
130841210531             write r_Output;
130842210531           EndIf;
130843210531
130844210531
130845210531         Enddo;
130846210531
130847210531
130848210531       end-proc;
130849210531
130850210531
130851210531
130900210504      *----------------------------------------------------------------
131000210504      * Check History
131100210504      *----------------------------------------------------------------
131200210504       dcl-proc Check_History;
131300210504
131400210504         dcl-s @ssn Char(9);
131500210504
131600210517         @ssn = l1_ssn;
131700210504
131800210504         if oChgd = 'Y';
131900210504           return;
132000210504         EndIf;
132100210504
132200210504
132300210517         Setll ( pKey : eFileType : @ssn ) GbsDiffp;
132400210504
132500210504         Dou %Eof(GbsDiffp);
132600210517           reade ( pKey : eFileType : @ssn ) GbsDiffp;
132700210504           if %eof(GbsDiffp);
132800210504             leave;
132900210504           endif;
133000210504
133100210504
133200210504           // *Any - If there are any changes; in any field.
133300210504           // mark it as a change..   ( Used for SSN, and Name )
133400210504
133500210506
133600210531           if Check_Field = '*Any'  ;
133601210531             // and %Subst(gdTo:1:7) <> 'Omitted';
133602210531
133700210504             oChgd = 'Y';
133800210504             leave;
133900210504           EndIf;
134000210504
134100210506           if gdFile = 'New-Rcd';
134200210506             oChgd = 'Y';
134300210506             leave;
134400210506           EndIf;
134500210506
135101210531
135102210531           if Check_Field = '*AnyDep';
135103210531
135104210531
135114220314             if gdFile = 'L3' and gdUniqId = l3_UniqId;
135115220314               oChgd = 'Y';
135116220314               leave;
135117220314             EndIf;
135118220314
135119220314             if gdFile = 'L4' and gdUniqId  = l4_UniqId;
135120220314               oChgd = 'Y';
135121220314               leave;
135122220314             EndIf;
135123220314
135124220314             if gdFile = 'L4' and gdUniqId = l3_UniqId
135125220314             and gdTo = 'Missing';
135126220314               oChgd = 'Y';
135127220314               leave;
135128220314
135129220314             EndIf;
135130220314
135131210531           EndIf;
135132210531
135133210531
135134210531
135200210506
135300210506           if gdFile <> Rcd_Level;
135400210506             iter;
135500210506           EndIf;
135600210504
135601210531           // For a new Dependent, ALL Info should be
135602210531           // listed.
135603210531           if Rcd_Level = 'L3' and
135604210531              gdField = 'New-Dep' and
135605210531              gdTo = L3_UniqId;
135606210531             oChgd = 'Y';
135607210531             iter;
135608210531
135609210531           endif;
135610210531
135700210531           // Record Level 2 should have the plan id
135800210531           // in GBSDIFFP
135900210531           if Rcd_Level = 'L2' and
136000210531             l2_plan <> gdPlanId ;
136100210531             iter;
136200210531           EndIf;
136300210518
136301210531
136302210531
136303210531           // For a new Dependent, ALL Info should be
136304210531           // listed.
136305210531           if Rcd_Level = 'L4' and
136306210531              gdField = 'New-Dep' and
136307210531              gdTo = L4_UniqId;
136308210531             oChgd = 'Y';
136309210531             iter;
136310210531
136311210531           endif;
136312210531
136313210531
136314210531
136400210531           if Rcd_Level = 'L4' and
136500210531             l4_plan <> gdPlanId ;
136600210531             iter;
136700210531           EndIf;
136800210518
136900210518
137000210518
137100210531           // check for new Plans.
137200210517           if gdField = 'NEWPLAN' and
137300210517              gdFrom = l2_Plan;
137400210517
137500210517             oChgd = 'Y';
137600210517             leave;
137700210517           EndIf;
137800210517
137900210517
138000210517
138100210517           if gdField = Check_Field and
138200210517             (gdField <> 'NEWPLAN')     ;
138300210504             oChgd = 'Y';
138400210504             leave;
138500210504           EndIf;
138600210504
138700210504
138800210504         Enddo;
138900210504
139000210504
139100210504
139200210504       End-Proc;
139300210504
