000100210503
000200210503       Ctl-Opt option(*noDebugIo)  DFTACTGRP(*NO)  bnddir('GBSBIND');
000300210503
000400210503      *-------------------------------------------------------------------------
000500210503      *
000600210503      *  Description: Format the Cava Data File.
000700160708      *
000800210503      *  Programmer.: Brian Rees
000900210503
001000210503      *
001100210503      *
001200210503      *-------------------------------------------------------------------------
001300210503      * Mod
001400210503      *
001500210503      * B.Rees    7/31/2017       Added Benefit Change Field
001600210503      *  Mod: Br01
001700210503      * B.Rees    2/21/2018       Added Location Cross Reference File
001800210503      *  Mod: Br02
001900200106      * B.Rees    1/06/2020       Removal of commas in Name and address
002000200106      *  Mod: Br03
002100210503      * B.Rees    5/03/2021       Marking ADPOutput with Changes.
002200210503      *  Mod: Br04
002300210827      * B.Rees    8/27/2021       Skipping Blank Plans.
002400210503      *-------------------------------------------------------------------------
002500210503       dcl-f AdpOutputP keyed usage(*output:*update:*input);
002600180516
002700180516br02   Dcl-f ADPLocxRef keyed;
002800220113       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*ExtDesc);
002900210503br04   dcl-f adpDiffp keyed;
003000180516
003100180516
003200180516
003300180516      *-------------------------------------------------------------------------
003400170731     d Sq_Input      e ds                  extname('ADPINPUTP')
003500170503
003600170504     d q               c                   Const('''')
003700170504     d SavSSN          s             11    inz
003800170504     d SavDSSN         s             11    inz
003900170504     d savName         s             20    inz
004000190716     d SavRelat        s             20    inz
004100170504     d sqlCount        s              9s 0 inz
004200170504     d savAddr         s             40    inz
004300180516
004400180516       dcl-s wSalary Zoned(8:2);
004500180516       dcl-s wSSn Zoned(9);
004600180516       dcl-s wSSnChar Char(11);
004700210503       dcl-s Check_Field Char(10);
004800180516
004900210503      *-------------------------------------------------------------------------
005000210503      *
005100210503      * *Entry Procedure
005200210503      *
005300210503      *-------------------------------------------------------------------------
005400210503       Dcl-pr Main ExtPgm;
005500210503         *N  Char(1);
005600210503         *N  Char(10);
005700210503br04     *N  Char(1);
005800210503       End-Pr;
005900210503
006000210503       dcl-pi Main;
006100210503         pContinue Char(1);
006200210503br02     Key Char(10);
006300210503br04     pEnvir Char(1);
006400210503       End-Pi;
006500210503
006600210503
006700210503      *--------------------------------------------
006800210503      *
006900210503      * Procedures
007000210503      *
007100210503      *--------------------------------------------
007200210503      /Include *LIBL/QMODSRC,#EdtStngPr            // Edit String
007300210503      /Include *LIBL/QMODSRC,Pr0001rPr             // Case Functions
007400210503
007500210503
007600210503
007700210503      *-------------------------------------------------------------------------
007800160926      * Mainline Program
007900160926      *-------------------------------------------------------------------------
008000170504
008100180312       SavSSN =  '^';
008200180312
008300210503       // Set Continue Flag.
008400170504       pContinue = 'N';
008500210503       Exec Sql
008600210503         Select Count(*)
008700210503           Into :Sqlcount
008800210503           From Adpinputp;
008900170504
009000170504       if SqlCount > 0;
009100210503         pContinue = 'Y';
009200170504       endif;
009300170504
009400170713
009500170504
009600210503       // Use SQL to read/Sort the database.
009700210503       Exec Sql
009800210503         Declare C1 Cursor For
009900210503           Select *
010000210503             From ADPInputp
010100210503             Order By Cpssn,
010200210503                      Case
010300210503                        When Ucase(Cprelat) = 'EMPLOYEE' Then '1'
010400210503                        When Ucase(Cprelat) = 'SPOUSE' Then '2'
010500210503                        When Ucase(Cprelat) = 'DOMESTIC PARTNER' Then '3'
010600210503                        When Ucase(Cprelat) = 'CHILD' Then '4'
010700210503                      End, CPDFNAME;
010800170503
010900210503       Exec Sql
011000210503         Open C1;
011100170503
011200210503       // Loop through the SQL Results
011300210503       dou SqlCod <> *Zero;
011400170503
011500210503         Exec Sql
011600210503           Fetch Next From C1
011700210503             Into :Sq_Input;
011800170503
011900210503         if SqlCod <> *Zero;
012000210503           leave;
012100200106         endif;
012200170503
012300210503         // Skip the plans that we dont administer.
012400210503         if ucase(%Trim(cpPlanDsc)) = 'COLONIAL ACCIDENT-STANDARD'  or
012500210503         ucase(%Trim(cpPlanDsc)) = 'COLONIAL MEDICAL BRIDGE-STANDARD'  or
012600210503         ucase(%Trim(cpPlanDsc)) = 'COLONIAL VOLUNTARY LIFE-STANDARD'  or
012700210503         ucase(%Trim(cpPlanDsc)) = 'HEALTHIESTYOU-STANDARD'  or
012800210503         ucase(%Trim(cpPlanDsc)) = '2016 HSA-EMPLOYEE ONLY'  or
012900210827         ucase(%Trim(cpPlanDsc)) = '2016 HSA-FAMILY' or
013000210827         ucase(%Trim(cpPlanDsc)) = '';
013100170516
013200210503           iter;
013300200106         endif;
013400170516
013500170516
013600210503br03     cpfname = EdtString(cpfname:'NAME');
013700210503br03     cplname = EdtString(cplname:'NAME');
013800210503br03     cpaddr1 = EdtString(cpAddr1:'ADDR');
013900210503br03     cpaddr2 = EdtString(cpAddr2:'ADDR');
014000210503
014100210503br03     cpCity  = EdtString(cpCity:'NAME');
014200210503br03     cpState = EdtString(cpState:'NAME');
014300210503br03     cpZip   = EdtString(cpZip:'NAME');
014400200106
014500200106
014600210503         // Member Record
014700210503         if ucase(cpRelat) = 'EMPLOYEE';
014800210503           if savSSN <> cpssn;
014900210503             BlankLine();
015000210503             GetMbrRcd();
015100200106             SavSSN = cpssn;
015200180516
015300200106             savdssn = *Blanks;
015400210503             savName = *Blanks;
015500200106           endif;
015600170504
015700210503           GetPlanInfo();
015800170504
015900210503         else;
016000170504
016100210503           // Dependent Record
016200210503           if savdSSN <> cpdepssn or
016300210503           savName <> cpdfname or
016400210503           savRelat <> ucase(cpRelat);
016500210503             GetDepRcd();
016600170504
016700200106             SavdSSN = cpdepssn;
016800200106             savName = cpdfname;
016900210503             savRelat = uCase(cpRelat);
017000200106           EndIf;
017100170504
017200210503           GetPlanInfo();
017300210503         endif;
017400170112
017500170504       enddo;
017600170504
017700170504
017800210503       Exec Sql
017900210503         Close C1;
018000170504
018100170504       *inlr = *on;
018200170504
018300170504
018400170504       //---------------------------------------------------------
018500210503       dcl-proc GetPlanInfo;
018600170504
018700200106         oType = *Blanks;
018800200106         oInfo = 'Plan: ' + %trim(cpPlanDsc) ;
018900210503         oChgd = '';
019000170504
019100210503         // If Tier / Coverage Level = Blank; Subsitute with
019200210503         // Employee Only
019300210503         if cpTier = *Blanks;
019400210503           if pEnvir = 'P';
019500210503             Check_Field = 'TIER';
019600210503             Check_History();
019700210503           endif;
019800210503           cpTier = 'EE';
019900200106         endif;
020000170516
020100170516
020200210503         if cpeffdt > *Blanks;
020300210503           if pEnvir = 'P';
020400210503             Check_Field = 'EFFDT';
020500210503             Check_History();
020600210503           endif;
020700210503           oInfo = %Trim(oInfo) + '  Enrollment Date: ' + cpEffDt;
020800200106         EndIf;
020900170504
021000210503         if cpTermDt > *Blanks;
021100210503           if pEnvir = 'P';
021200210503             Check_Field = 'TERMDT';
021300210503             Check_History();
021400210503           endif;
021500210503           oInfo = %Trim(oInfo) + '  Termination Date: ' + cpTermDt;
021600200106         EndIf;
021700170504
021800210503         // Only for Member Records
021900210503         if cpTier > *Blanks and ucase(cpRelat) = 'EMPLOYEE';
022000210503           oInfo = %Trim(oInfo) + '  Tier Level: ' + %Trim(cpTier);
022100200106         EndIf;
022200170504
022300210503         if cpEmpClas > *Blanks;
022400210503           if pEnvir = 'P';
022500210503             Check_Field = 'EMPCLAS';
022600210503             Check_History();
022700210503           endif;
022800210503           oInfo  = %Trim(oInfo) +
022900210503           ' Employee Class: ' + cpEmpClas;
023000200106         endif;
023100181003
023200170504
023300200106         write r_Output;
023400170504
023500170907
023600210503         // Election Amount
023700210503         if cpElAmt > *Blanks;
023800200106           oInfo = 'Election Amount: ' + %Trim(cpElAmt);
023900210503           if pEnvir = 'P';
024000210503             oChgd = '';
024100210503             Check_Field = 'ELAMT';
024200210503             Check_History();
024300210503           endif;
024400210503           write r_Output;
024500210503         endif;
024600170907
024700210503       end-proc;
024800170112
024900170504       //---------------------------------------------------------
025000210503       dcl-proc BlankLine;
025100170504
025200200106         oType = *Blanks;
025300200106         oInfo = *Blanks;
025400210503         write r_Output;
025500170504
025600210503       end-proc;
025700170504       //---------------------------------------------------------
025800210503       dcl-proc GetMbrRcd;
025900170112
026000210503         if cpssn > '';
026100200106           wSSNChar = %Scanrpl('-': '' : cpssn );
026200210503           wSSN = %Dec( wSSNChar : 9 : 0 );
026300200106         endif;
026400180516
026500200106         oType  = 'Member:';
026600200106         oInfo  = cpssn;
026700210503         if pEnvir = 'P';
026800210503           oChgd = '';
026900210503
027000210503           Check_Field = '*Any';
027100210503           Check_History();
027200210503         endif;
027300210503
027400200106         write r_Output;
027500170113
027600200106         oType  = *Blanks;
027700200106         oInfo  = %trim(cplname) + ', ' + %trim(cpfname) + ' ' +
027800210503         %trim(cpmi) ;
027900210503
028000210503br04     //---------------------------------------------------------
028100210503 |       // Check the ADPDiffP file for any changes.
028200210503 |       // Check_Field are the field names stored in ADPDIFFP.
028300210503 |       // they are entered in there program ChkHistADP
028400210503 |       //---------------------------------------------------------
028500210503 |       if pEnvir = 'P';
028600210503 |         oChgd = '';
028700210503 |
028800210503 |         Check_Field = '*Any';
028900210503 |         Check_History();
029000210503 |
029100210503br04     EndIf;
029200210503
029300210503         write r_Output;
029400170113
029500210503         SavAddr = cpAddr1;
029600210503         oInfo  = %trim(cpAddr1);
029700210503         if pEnvir = 'P';
029800210503           oChgd = '';
029900210503           Check_Field = 'ADDR1';
030000210503           Check_History();
030100210503         endif;
030200200106         write r_Output;
030300170113
030400210503         if cpaddr2 > *Blanks;
030500200106           oInfo  = %trim(cpAddr2);
030600210503           if pEnvir = 'P';
030700210503             oChgd = '';
030800210503             Check_Field = 'ADDR2';
030900210503             Check_History();
031000210503           endif;
031100210503           write r_Output;
031200210503         endif;
031300170113
031400210503         oInfo  = %trim(cpCity) + ', ' + %trim(cpState) + '  ' +
031500210503           %trim(cpZip);
031600210503         if pEnvir = 'P';
031700210503           oChgd = '';
031800210503           Check_Field = 'CITY';
031900210503           Check_History();
032000210503
032100210503           Check_Field = 'STATE';
032200210503           Check_History();
032300210503
032400210503           Check_Field = 'ZIP';
032500210503           Check_History();
032600210503         endif;
032700210503         write r_Output;
032800170503
032900200106         if cpGender > *Blanks;
033000210503           oInfo  = 'Gender: ' + cpGender;
033100210503           if pEnvir = 'P';
033200210503             oChgd = '';
033300210503             Check_Field = 'GENDER';
033400210503             Check_History();
033500210503           endif;
033600210503           write r_Output;
033700200106         endif;
033800170503
033900170504
034000200106         if cpPhone > *Blanks;
034100210503           oInfo  = 'Phone: ' + cpPhone;
034200210503           if pEnvir = 'P';
034300210503             oChgd = '';
034400210503             Check_Field = 'PHONE';
034500210503             Check_History();
034600210503           endif;
034700200106           write r_Output;
034800210503         endif;
034900210503
035000210503
035100210503
035200210503         if cppcpid > *Blanks;
035300210503           oInfo  = 'PCP Id: ' + cpPcpId;
035400210503           if pEnvir = 'P';
035500210503             oChgd = '';
035600210503             Check_Field = 'PCPID';
035700210503             Check_History();
035800210503           endif;
035900210503           write r_Output;
036000210503         endif;
036100170503
036200170113
036300210503         if cplocat > *Blanks;
036400210503br02       chain ( key : cplocat ) ADPLocxRef;
036500210503 |         if %Found(ADPLocxRef);
036600210503 |           cpLocat = lxDesc;
036700210503br02       endif;
036800180221
036900210503           oInfo  = 'Location: ' + cpLocat;
037000210503           if pEnvir = 'P';
037100210503             oChgd = '';
037200210503             Check_Field = 'LOCAT';
037300210503             Check_History();
037400210503           endif;
037500200106           write r_Output;
037600210503         endif;
037700170201
037800210503         //if cptermdt > *Blanks;
037900210503         //   oInfo  = 'Member Termed Date: ' + cptermdt;
038000210503         //   write r_Output;
038100210503         //endif;
038200170501
038300170501
038400210503         if cpmdate > *Blanks;
038500210503           oInfo  = 'Marital Date: ' + cpmDate;
038600210503           if pEnvir = 'P';
038700210503             oChgd = '';
038800210503             Check_Field = 'MDATE';
038900210503             Check_History();
039000210503           endif;
039100210503           write r_Output;
039200210503         endif;
039300170501
039400170501
039500210503         if cpSalary > *Blanks;
039600210503           oInfo  = 'Salary: ' + cpSalary;
039700210503           if pEnvir = 'P';
039800210503             oChgd = '';
039900210503             Check_Field = 'SALARY';
040000210503             Check_History();
040100210503           endif;
040200210503           write r_Output;
040300180516
040400210119
040500210503           monitor;
040600210503             wSalary = %Dec( %Trim( cpSalary ) : 8 : 2 );
040700210119
040800210119           on-error;
040900210503             wSalary = 0;
041000210503           EndMon;
041100210119
041200210119
041300210503           Exec Sql
041400210503             Select Round(:Wsalary)
041500210503               Into :Wsalary
041600210503               From Sysibm.Sysdummy1;
041700180516
041800210503           if cpssn > '';
041900210503             chain wSSN Member;
042000210503             if %Found( Member );
042100210503               if wSalary <> Salary;
042200210503                 oInfo = '** Salary does not match our system. ' +
042300210503                 'Current Value: ' +  %editc( Salary: '1') ;
042400210503                 write r_output;
042500210503               EndIf;
042600210503             EndIf;
042700210503           EndIf;
042800180516
042900210503         Endif;
043000170501
043100170501
043200210503         if cpMedicare > *Blanks;
043300210503           oInfo  = 'Medicare: ' + cpMedicare;
043400210503           if pEnvir = 'P';
043500210503             oChgd = '';
043600210503             Check_Field = 'MEDICARE';
043700210503             Check_History();
043800210503           endif;
043900210503           write r_Output;
044000210503         endif;
044100170503
044200170503
044300170501
044400210503         oInfo  = 'DOB: ' + cpbDate;
044500210503         if pEnvir = 'P';
044600210503           oChgd = '';
044700210503           Check_Field = 'BDATE';
044800210503           Check_History();
044900210503         endif;
045000210503         write r_Output;
045100170113
045200200106         oInfo  = 'DOH: ' + cphDate;
045300210503         if pEnvir = 'P';
045400210503           oChgd = '';
045500210503           Check_Field = 'HDATE';
045600210503           Check_History();
045700210503         endif;
045800200106         write r_Output;
045900170113
046000170504
046100200106         if cpCob > *Blanks;
046200210503           oInfo  = 'COB: ' + cpCob;
046300210503           if pEnvir = 'P';
046400210503             oChgd = '';
046500210503             Check_Field = 'COB';
046600210503             Check_History();
046700210503             Check_Field = 'COBNBR';
046800210503             Check_History();
046900210503           endif;
047000210503           write r_Output;
047100200106         EndIf;
047200170504
047300170504
047400200106         if cpCobNbr > *Blanks;
047500210503           oInfo  = 'COB Number: ' + cpCobNbr;
047600200106           write r_Output;
047700210503         EndIf;
047800170504
047900170504
048000210503br01     if cpMedNbr > *Blanks;
048100210503 |         oInfo  = 'Benefit Change Reason: ' + cpMedNbr;
048200210503           if pEnvir = 'P';
048300210503             oChgd = '';
048400210503             Check_Field = 'MEDNBR';
048500210503             Check_History();
048600210503           endif;
048700210503 |         write r_Output;
048800210503br01     EndIf;
048900170731
049000170112
049100210503       end-proc;
049200170503
049300210503       //---------------------------------------------------------
049400210503       dcl-proc GetDepRcd;
049500170504
049600170504
049700210503         oType  = 'Dependent:';
049800210503         oInfo  = cpDepssn;
049900210503         write r_Output;
050000170504
050100200106         oType  = *Blanks;
050200210503         oInfo  = %trim(cpdlname) + ', ' + %trim(cpdfname) + ' ' +
050300210503           %trim(cpdmi) ;
050400210503         if pEnvir = 'P';
050500210503           oChgd = '';
050600210503
050700210503           Check_Field = 'DFNAME';
050800210503           Check_History();
050900210503
051000210503           Check_Field = 'DMI';
051100210503           Check_History();
051200210503
051300210503           Check_Field = 'DLNAME';
051400210503           Check_History();
051500210503
051600210503         EndIf;
051700210503         write r_Output;
051800170504
051900200106         if cpdaddr1 > *Blanks
052000210503         and SavAddr <> cpdaddr1;
052100200106           oInfo  = %trim(cpdAddr1);
052200210503           if pEnvir = 'P';
052300210503             oChgd = '';
052400210503             Check_Field = 'DADDR1';
052500210503             Check_History();
052600210503           endif;
052700210503           write r_Output;
052800210503         endif;
052900170504
053000210503         if cpdaddr2 > *Blanks
053100210503         and SavAddr <> cpdaddr1;
053200200106           oInfo  = %trim(cpdAddr2);
053300210503           if pEnvir = 'P';
053400210503             oChgd = '';
053500210503             Check_Field = 'DADDR2';
053600210503             Check_History();
053700210503           endif;
053800210503           write r_Output;
053900200106         endif;
054000170504
054100210503         if cpdcity > *Blanks
054200210503         and SavAddr <> cpdaddr1;
054300210503           oInfo  = %trim(cpdCity) + ', ' + %trim(cpdState) + '  ' +
054400210503           %trim(cpdZip);
054500210503           if pEnvir = 'P';
054600210503             oChgd = '';
054700210503             Check_Field = 'DCITY';
054800210503             Check_History();
054900210503
055000210503             Check_Field = 'DSTATE';
055100210503             Check_History();
055200210503
055300210503             Check_Field = 'DZIP';
055400210503             Check_History();
055500210503           endif;
055600200106           write r_Output;
055700210503         endif;
055800170504
055900170504
056000210503         if cpdGender > *Blanks;
056100210503           oInfo  = 'Gender: ' + cpdGender;
056200210503           if pEnvir = 'P';
056300210503             oChgd = '';
056400210503             Check_Field = 'DGENDER';
056500210503             Check_History();
056600210503           endif;
056700210503           write r_Output;
056800210503         endif;
056900171023
057000171023
057100210503         if cpRelat > *Blanks;
057200210503           oInfo  = 'Relationship: ' + cpRelat;
057300210503           if pEnvir = 'P';
057400210503             oChgd = '';
057500210503             Check_Field = 'RELAT';
057600210503             Check_History();
057700210503           endif;
057800210503           write r_Output;
057900210503         endif;
058000170504
058100170504
058200210503         if cpdPhone > *Blanks;
058300210503           oInfo  = 'Phone: ' + cpdPhone;
058400210503           if pEnvir = 'P';
058500210503             oChgd = '';
058600210503             Check_Field = 'DPHONE';
058700210503             Check_History();
058800210503           endif;
058900210503           write r_Output;
059000210503         endif;
059100170504
059200170504
059300210503         if cpdbdate > *Blanks;
059400210503           oInfo  = 'DOB: ' + cpdbDate;
059500210503           if pEnvir = 'P';
059600210503             oChgd = '';
059700210503             Check_Field = 'DBDATE';
059800210503             Check_History();
059900210503           endif;
060000210503           write r_Output;
060100210503         endif;
060200170504
060300170504
060400200106         if cpdstudnt > *Blanks;
060500210503           oInfo  = 'Student: ' + cpdStudnt;
060600210503           if pEnvir = 'P';
060700210503             oChgd = '';
060800210503             Check_Field = 'DSTUDNT';
060900210503             Check_History();
061000210503           endif;
061100210503           write r_Output;
061200200106         EndIf;
061300170504
061400200106         if cpStudDt > *blanks;
061500210503           oInfo  = 'Student Date: ' + cpStudDt;
061600210503           if pEnvir = 'P';
061700210503             oChgd = '';
061800210503             Check_Field = 'STUDDT';
061900210503             Check_History();
062000210503           endif;
062100210503           write r_Output;
062200210503         EndIf;
062300170504
062400210503         if cpSchool > *blanks;
062500210503           oInfo  = 'School: ' + cpSchool;
062600210503           if pEnvir = 'P';
062700210503             oChgd = '';
062800210503             Check_Field = 'SCHOOL';
062900210503             Check_History();
063000210503           endif;
063100210503           write r_Output;
063200210503         EndIf;
063300170504
063400170504
063500170504
063600210503       end-proc;
063700170504
063800210503      *----------------------------------------------------------------
063900210503      * Check History
064000210503      *----------------------------------------------------------------
064100210503       dcl-proc Check_History;
064200210503
064300210503         dcl-s @ssn Char(9);
064400210503
064500210503         @ssn = %Editc( wssn : 'X' ) ;
064600210503
064700210503         if oChgd = 'Y';
064800210503           return;
064900210503         EndIf;
065000210503
065100210503
065200210503         Setll ( Key : @ssn ) AdpDiffp;
065300210503
065400210503         Dou %Eof(AdpDiffp);
065500210503           reade ( Key : @ssn ) AdpDiffp;
065600210503           if %eof(AdpDiffp);
065700210503             leave;
065800210503           endif;
065900210503
066000210503           if Check_Field = '*Any';
066100210503             oChgd = 'Y';
066200210503             leave;
066300210503           EndIf;
066400210503
066500210503
066600210503           if adField = Check_Field;
066700210503             oChgd = 'Y';
066800210503             leave;
066900210503           EndIf;
067000210503
067100210503           if adField = 'New Rcd';
067200210503             oChgd = 'Y';
067300210503             leave;
067400210503           EndIf;
067500210503
067600210503
067700210503         Enddo;
067800210503
067900210503
068000210503
068100210503       End-Proc;
068200210503
