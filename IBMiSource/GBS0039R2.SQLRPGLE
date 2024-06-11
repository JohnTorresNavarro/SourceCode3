000100180724       Ctl-opt option(*noDebugIo)   DftActGrp(*no)
000200180724          bnddir( 'GBSBIND' );
000300180607
000400180607      *-------------------------------------------------------------------------
000500180607      *
000600180824      *  Description: Scan through the ADP file spread sheet. Compare with
000700180824      *   what we have on the iSeries.  We will be alble to
000800180824      *    1. Show the AA's what data needs to be changed.
000900180824      *    2. perhaps use this for the Auto Enrollment Process.
001000180607      *
001100180607      *  Programmer.: Brian Rees
001200180607      *  Date.......: 06/07/2018
001300180607      *
001400180924      *-------------------------------------------------------------------------
001500180924      *  Change Log
001600180924      *
001700180924      *  09/24/2018   B.Rees  Added new field in GBS0030P FTLocTSA
001800180924      *   For ADP Files, if the location field is our TSA, that flag will
001900180924      *   bet set to Y
002000180924      *
002100180924      *
002200180607      *-------------------------------------------------------------------------
002300180607
002400180607      *-------------------------------------------------------------------------
002500180924      *
002600180607      * Declare Files
002700180607      *
002800180607      *-------------------------------------------------------------------------
002900180607
003000180724       dcl-f ADPInputp keyed;
003100180724       dcl-f Gbs0039p keyed usage(*output);
003200180724
003300180724       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
003400190913       Dcl-f DEPENDL4 keyed ExtDesc('F.DEPENDL4') ExtFile(*extdesc);
003500200115       Dcl-f mCovc15  keyed ExtDesc('F.MCOVC15') ExtFile(*extdesc);
003600200115       Dcl-f dCovc    keyed ExtDesc('F.DCOVC') ExtFile(*extdesc);
003700180824
003800180824       dcl-f PlanxRefp keyed;
003900180607
004000180607
004100180607      *-------------------------------------------------------------------------
004200180607      *
004300180607      * Global Variables
004400180607      *
004500180607      *-------------------------------------------------------------------------
004600180724       dcl-s SavSSN Char(11) ;
004700180724
004800180724       dcl-s cssn   Char(9);
004900180724       dcl-s wSSN   Zoned(9);
005000180725       dcl-s wSalary Zoned(8:2);
005100180725       dcl-s wEffDate Zoned(8);
005200180824       dcl-s wTrmDate Zoned(8);
005300180824
005400180824       dcl-s memberFound Char(1);
005500180824       dcl-s PlanCount Zoned(3);
005600180827
005700210624       dcl-s saveFname char(20);
005800180827       dcl-s wd_ssn Zoned(9);
005900180824
006000180827       dcl-s DependFound Char(1);
006100180827       dcl-s wDepno Zoned(2);
006200200114       dcl-s MbrClass like( cpEmpClas );
006300200120       dcl-s wZip5 Char(5);
006400180824
006500180824
006600180824      *-------------------------------------------------------------------------
006700180824      *
006800180824      * *Entry Procedure
006900180824      *
007000180824      *-------------------------------------------------------------------------
007100180920       Dcl-pr Main ExtPgm;
007200200115         *N  Char(10);
007300180920       End-Pr;
007400180920
007500180920       dcl-pi Main;
007600200115         pKey Char(10);
007700180920       End-Pi;
007800180920
007900180920       dcl-s  pTrst Zoned(3);
008000180920       dcl-s  pSub  Zoned(3);
008100180920       dcl-s  pAcct Zoned(4);
008200180724
008300180924       Dcl-s Loc_is_TSA Char(1);
008400180824
008500180824
008600180824
008700180724      *-------------------------------------------------------------------------
008800180724      *
008900180724      * Procedures
009000180724      *
009100180724      *-------------------------------------------------------------------------
009200180724       /include gbspgm/QMODSRC,PR0001RPR            // Case Functions
009300180724
009400180724
009500180724       dcl-pr CheckMatch Char(1);
009600200115         InValue  Char(50) value;
009700200115         SysValue Char(50) value;
009800200115         iFldName Char(20) value;
009900180724       End-Pr;
010000180607
010100180824
010200180824
010300180607
010400180607      *-------------------------------------------------------------------------
010500180607      *
010600180607      * Mainline Program
010700180607      *
010800180607      *-------------------------------------------------------------------------
010900180824
011000180920
011100180920       pTrst = %Dec( %Subst( pKey : 1 : 3 ) : 3 : 0 );
011200180920       pSub  = %Dec( %Subst( pKey : 4 : 3 ) : 3 : 0 );
011300180920       pAcct = %Dec( %Subst( pKey : 7 : 4 ) : 4 : 0 );
011400180920
011500200908       Exec Sql
011600200908         Select Ftloctsa
011700200908           Into :Loc_Is_Tsa
011800200908           From Gbs0030p
011900200908           Where Ftgroup = :Pkey;
012000180924
012100180924
012200180924
012300180924
012400180924       Setll *loval AdpInputp;
012500180724
012600180924       Dou %Eof(AdpInputp);
012700200115         read  AdpInputp;
012800200115         if %eof(AdpInputp);
012900200115           leave;
013000200115         endif;
013100180724
013200200115         inssn = cpssn;
013300200115         Locat = cpLocat;
013400180921
013500200115         if Loc_is_Tsa = 'Y';
013600200115           pTrst = %Dec( %Subst( cpLocat : 1 : 3 ) : 3 : 0 );
013700200115           pSub  = %Dec( %Subst( cpLocat : 4 : 3 ) : 3 : 0 );
013800200115           pAcct = %Dec( %Subst( cpLocat : 7 : 4 ) : 4 : 0 );
013900180924
014000200115         EndIf;
014100180924
014200180924
014300180924
014400200115         if Cpssn <> savssn;
014500200115           inSeq# = 0;
014600200115           savssn = Cpssn;
014700180724
014800200115           cSSN = %Scanrpl( '-' : '' : Cpssn);
014900200115           wSSN = %Dec( cssn : 9 : 0 );
015000180724
015100200115           memberFound = '';
015200200115           DependFound = '';
015300200115           wDepno = 0;
015400200115
015500200908           ineffDt =  '';
015600200908           SyeffDt =  '';
015700180824
015800200115           checkMember();
015900200115           MbrClass = cpEmpClas;
016000180824
016100180724
016200200115         EndIf;   // Saved SSN
016300180824
016400180827
016500180827
016600200115         //----------------------------------------------------
016700200115         //
016800200115         //   Search for the plans: MEMBER
016900200115         //
017000200115         //----------------------------------------------------
017100200115         if memberFound = 'Y' and cpfname > '';
017200200115           MemberPlans();
017300180827
017400200115         EndIf;
017500180824
017600180724
017700180724
017800200115         if cpdfname > ''
017900210624            and cpdfname <> saveFname
018000200115            and inssn = savssn;
018100180827
018200210624           saveFName = cpdfname;
018300180827
018400200115           DependFound = '';
018500200908           ineffDt =  '';
018600200908           SyeffDt =  '';
018700180827
018800200115           checkDepend();
018900180827
019000180827
019100200115         EndIf;
019200180827
019300180724
019400200115         //----------------------------------------------------
019500200115         //
019600200115         //   Search for the plans: MEMBER
019700200115         //
019800200115         //----------------------------------------------------
019900200115         if DependFound = 'Y' and cpdfname > '';
020000200115           DependPlans();
020100200115         EndIf;
020200180827
020300180724
020400180724
020500180827       Enddo;
020600180724
020700180724
020800180607
020900180924       *inlr = *on;
021000180724
021100180824      *----------------------------------------------------------------
021200180824      *
021300180824      * Check Member Record
021400180824      *
021500180824      *----------------------------------------------------------------
021600180824
021700180924       Dcl-Proc CheckMember;
021800180824
021900180824
022000180824
022100200115         // Get Member Information
022200200115         chain wSSN Member;
022300200115         if not %Found( Member );
022400200116           fldName = 'Member SSN';
022500200116           inBound = 'Member not in Genie.';
022600200116           System = '';
022700200116           match = 'N';
022800200116           Write R_GBS0039;
022900200116           return;
023000200115         EndIf;
023100180824
023200200115         if %Found( Member );
023300180824
023400200115           memberFound = 'Y';
023500180824
023600200115           // First Name
023700200115           fldName = 'First Name';
023800200115           inBound = cpfname;
023900200115           System = mfname;
024000200115           match = CheckMatch( inBound : System : fldName );
024100200115           Write R_GBS0039;
024200180824
024300180824
024400200115           // Middle Name
024500200115           fldName = 'Middle Name';
024600200115           inBound = cpmi;
024700200115           System = mmi;
024800200115           match = CheckMatch( inBound : System : fldName );
024900200115           Write R_GBS0039;
025000180824
025100180824
025200200115           // Last Name
025300200115           fldName = 'Last Name';
025400200115           inBound = cplname;
025500200115           System = mlname;
025600200115           match = CheckMatch( inBound : System : fldName );
025700200115           Write R_GBS0039;
025800180824
025900180824
026000200115           // Address 1
026100200115           fldName = 'Addr Line 1';
026200200115           inBound = cpAddr1;
026300200115           System = Addr1;
026400200115           match = CheckMatch( inBound : System : fldName );
026500200115           Write R_GBS0039;
026600180824
026700180824
026800200115           // Address 2
026900200115           fldName = 'Addr Line 2';
027000200115           inBound = cpAddr2;
027100200115           System = Addr2;
027200200115           match = CheckMatch( inBound : System : fldName );
027300200115           Write R_GBS0039;
027400180824
027500200115           // City
027600200115           fldName = 'City';
027700200115           inBound = cpCity;
027800200115           System = City;
027900200115           match = CheckMatch( inBound : System : fldName );
028000200115           Write R_GBS0039;
028100180824
028200200115           // State
028300200115           fldName = 'State';
028400200115           inBound = cpState;
028500200115           System = State;
028600200115           match = CheckMatch( inBound : System : fldName );
028700200115           Write R_GBS0039;
028800180824
028900200115           // Zip
029000200115           fldName = 'ZipCode';
029100200115           inBound = cpZip;
029200200120
029300200120           wZip5 = %Editc(zip:'X');
029400200120           System =wZip5;
029500200120
029600200115           match = CheckMatch( inBound : System : fldName );
029700200115           Write R_GBS0039;
029800180824
029900200115           // Phone
030000200115           fldName = 'Phone';
030100200115           inBound = %Scanrpl( '-' : '' : cpPhone) ;
030200200115           System = %Editc(Area:'X') +  %Editc(PHone:'X');
030300200115           if System = '0000000000';
030400200115             system = '';
030500200115           EndIf;
030600200115           match = CheckMatch( inBound : System : fldName );
030700200115           inBound = cpPhone;
030800200115           Write R_GBS0039;
030900180824
031000200115           // Gender
031100200115           fldName = 'Gender';
031200200115           inBound = cpGender;
031300200115           System = sex;
031400200115           match = CheckMatch( inBound : System : fldName );
031500200115           Write R_GBS0039;
031600180824
031700180824
031800200115           // Birthdate
031900200115           fldName = 'Birth date';
032000200115           inBound = cpbDate;
032100180921
032200180921
032300200115           // Convert to MM/DD/YYYYY  ( From m/d/yyyy )
032400200908           Exec Sql
032500200908             Select To_Char(To_Date(:Inbound, 'mm/dd/yyyy'), 'mm/dd/yyyy')
032600200908               Into :Inbound
032700200908               From Sysibm.Sysdummy1;
032800180921
032900180921
033000180921
033100200115           system = '';
033200200115           if birth > 0;
033300200115             System =  %Char(%Date(birth:*iso):*Usa);
033400200115           endif;
033500200115           match = CheckMatch( inBound : System : fldName );
033600200115           System = %Char(birth);
033700200115           Write R_GBS0039;
033800180824
033900180824
034000200115           // Hire Date
034100200115           fldName = 'Hire Date';
034200200115           inBound = cphDate;
034300180921
034400200115           // Convert to MM/DD/YYYYY  ( From m/d/yyyy )
034500200908           Exec Sql
034600200908             Select To_Char(To_Date(:Inbound, 'mm/dd/yyyy'), 'mm/dd/yyyy')
034700200908               Into :Inbound
034800200908               From Sysibm.Sysdummy1;
034900180921
035000200115           system = '';
035100200115           if empdt > 0;
035200200115             System =  %Char(%Date(empdt:*iso):*Usa);
035300200115           endif;
035400200115           match = CheckMatch( inBound : System : fldName );
035500200115           System = %Char(empdt);
035600200115           Write R_GBS0039;
035700180824
035800180824
035900200115           // Marriage Date
036000200115           fldName = 'Marriage Date';
036100200115           inBound = cpmDate;
036200180921
036300200115           // Convert to MM/DD/YYYYY  ( From m/d/yyyy )
036400200908           Exec Sql
036500200908             Select To_Char(To_Date(:Inbound, 'mm/dd/yyyy'), 'mm/dd/yyyy')
036600200908               Into :Inbound
036700200908               From Sysibm.Sysdummy1;
036800180921
036900200115           system = '';
037000200115           if mardt > 0;
037100200115             System =  %Char(%Date(mardt:*iso):*Usa);
037200200115           endif;
037300200115           match = CheckMatch( inBound : System : fldName );
037400200115           System = %Char(mardt);
037500200115           Write R_GBS0039;
037600180824
037700200115           // Salary
037800200115           fldName = 'Salary';
037900180824
038000200115           wSalary = 0;
038100200115           if cpSalary > '';
038200200115             wSalary = %Dec( %Trim( cpSalary ) : 8 : 2 );
038300200908             Exec Sql
038400200908               Select Round(:Wsalary)
038500200908                 Into :Wsalary
038600200908                 From Sysibm.Sysdummy1;
038700200115           endif;
038800180824
038900200115           inBound = %Char(wSalary);
039000200115           inBound = %Scanrpl('.00' : '' : inBound );
039100180827
039200200115           system = %Char(Salary);
039300200115           match = CheckMatch( inBound : System : fldName );
039400200115           inBound = cpSalary;
039500200115           Write R_GBS0039;
039600180824
039700180824
039800200115           // PCP
039900200115           wEffDate = %Dec(%Date( cpeffdt : *USA ));
040000180824
040100200115           fldName = 'PCP';
040200200115           inBound = cpPCPID;
040300200115           System = '';
040400180824
040500200115           // Get Medical PCP Information
040600200908           Exec Sql
040700200908             Select Pcid#
040800200908               Into :System
040900200908               From "F.PCP"
041000200908               Where Pcssn = :Wssn And
041100200908                     Pcdseq = 0 And
041200200908                     Pceff <= :Weffdate And
041300200908                     (Pccan >= :Weffdate Or
041400200908                       Pccan = 0) And
041500200908                     Pcspcd = 'MED';
041600180824
041700200115           match = CheckMatch( inBound : System : fldName );
041800200115           Write R_GBS0039;
041900180824
042000180824
042100200115         EndIf;    // Member File
042200180824
042300180824
042400180924       end-Proc;
042500180824
042600180724      *----------------------------------------------------------------
042700180724      *
042800180724      * Check Match Function
042900180724      *
043000180724      *----------------------------------------------------------------
043100180724
043200180924       Dcl-Proc CheckMatch export;
043300180724
043400200115         Dcl-pi *n Char(1);
043500200115           inValue  Char(50) value;
043600200115           SysValue Char(50) value;
043700200115           iFldName Char(20) value;
043800200115         End-Pi;
043900180724
044000200115         dcl-s ReturnText Char(1);
044100180724
044200200115         ReturnText = 'Y';
044300180724
044400180920
044500200115         //--------------------------
044600200115         // Remove any periods..
044700200115         //--------------------------
044800200115         inValue = %ScanRpl( '.' : '' : inValue);
044900200115         SysValue = %ScanRpl( '.' : '' : SysValue);
045000180920
045100180724
045200200115         if uCase( inValue ) <> uCase( SysValue );
045300200115           ReturnText = 'N';
045400200115         EndIf;
045500180724
045600200115         // Salary Check.
045700200115         if iFldName = 'Salary';
045800200115           if %Trim( inValue ) = '' and %Trim( SysValue ) = '0';
045900200115             ReturnText = 'Y';
046000200115           endif;
046100200115         endif;
046200190717
046300190717
046400200115         Return ReturnText;
046500180724
046600180924       end-Proc;
046700180724
046800180827      *----------------------------------------------------------------
046900180827      *
047000180827      * Check Member Plans
047100180827      *
047200180827      *----------------------------------------------------------------
047300180827
047400180924       Dcl-Proc MemberPlans;
047500180827
047600180827
047700200115         Setll ( pTrst : pSub : pAcct :
047800200115            ucase( cpEmpClas ) : uCase( cpPlanDsc )) PlanxRefp;
047900180827
048000180827
048100200115
048200200115         Dou %Eof(PlanxRefp);
048300200115           Reade ( pTrst : pSub : pAcct :
048400200115              ucase( cpEmpClas ) : uCase( cpPlanDsc )) PlanxRefp;
048500200115           if %eof(PlanxRefp);
048600200115             leave;
048700200115           endif;
048800200115
048900200115
049000200115
049100200115           //----------------------------------------------------
049200200115           //
049300200115           //  Not Found: Write the missing plan
049400200115           //
049500200115           //----------------------------------------------------
049600200115           if not %Found( PlanxRefp );
049700200115             fldName = 'Plan Error';
049800200115             inBound = cpPlanDsc;
049900200115             System = 'Not found in PlanxRefp';
050000200115             Match = 'N';
050100200115             Write R_GBS0039;
050200200115           EndIf;
050300180827
050400180827
050500200115           //----------------------------------------------------
050600200115           //
050700200115           //  Found: Check to see if the member currently
050800200115           //         has that plan
050900200115           //
051000200115           //----------------------------------------------------
051100200115           if %Found( PlanxRefp );
051200180827
051300200115             wEffDate = 0;
051400200115             if cpEffDt > '';
051500200115               wEffDate = %Dec(%Date( cpeffdt : *USA ));
051600200115             endif;
051700180827
051800200115             wTrmDate = 0;
051900200115             if cpTermDt > '';
052000200115               wTrmDate = %Dec(%Date( cpTermdt : *USA ));
052100200115             endif;
052200180827
052300200114
052400200115             chain ( pTrst : pSub : pAcct : wssn : pxPlanid ) mCovc15;
052500200115             if %Found ( mCovc15 ) ;
052600200115
052700200115               if enrldt = wEffDate;
052800200115                 fldName = 'Plan OK';
052900200115                 inBound = cpPlanDsc;
053000200115                 System = 'Member Enrolled: ' +  pxPlanId ;
053100200115                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
053200200115                 SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
053300200115                 Match = 'Y';
053400200115                 Write R_GBS0039;
053500200115               EndIf;
053600200115
053700200115
053800200115               if enrldt <> wEffDate;
053900200115                 fldName = 'Plan Error';
054000200115                 inBound = cpPlanDsc;
054100200115                 System = 'Member Enrolled: ' +  pxPlanId +
054200200115                  ' Eff Date does not match';
054300200115                 Match = 'N';
054400200115                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
054500200115                 SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
054600200115                 Write R_GBS0039;
054700200115               EndIf;
054800200115
054900200115
055000200115
055100200115             EndIf;
055200180827
055300200115             if not %Found ( mCovc15 ) ;
055400200115               fldName = 'Plan Error';
055500200115               inBound = cpPlanDsc;
055600200115               System = 'Member Not Enrolled: ' + pxPlanId ;
055700200115               Match = 'N';
055800200908               ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
055900200908               SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
056000200115               Write R_GBS0039;
056100200115             EndIf;
056200180827
056300180827
056400200115           EndIf;
056500180827
056600200115         Enddo;
056700180827
056800180924       End-Proc;
056900180827
057000180724
057100180827      *----------------------------------------------------------------
057200180827      *
057300180827      * Check Dependent Record
057400180827      *
057500180827      *----------------------------------------------------------------
057600180827
057700180924       Dcl-Proc CheckDepend;
057800180827
057900180827
058000200115         if cpdepssn = '';
058100200115           fldName = 'Dep SSN';
058200200115           inBound = 'SSN not in File.';
058300200115           System = '';
058400200115           match = 'N';
058500200115           Write R_GBS0039;
058600200115           return;
058700200115         EndIf;
058800180827
058900180827
059000200115         cSSN = %Scanrpl( '-' : '' : CpDepSsn);
059100200115         wd_SSN = %Dec( cssn : 9 : 0 );
059200180827
059300180827
059400180827
059500200115         // Get Dependent Information
059600200115         chain ( wd_SSN : wssn ) Dependl4;
059700200115         if not %Found( Dependl4 );
059800200115           fldName = 'Dep SSN';
059900200115           inBound = 'SSN not found in File.';
060000200115           System = cpdepssn;
060100200115           match = 'N';
060200200115           Write R_GBS0039;
060300200115           return;
060400180827
060500200115         EndIf;
060600180827
060700200115         if %Found( Dependl4 );
060800180827
060900200115           DependFound = 'Y';
061000200115           wDepno = dpSeq#;
061100200115           inSeq# = dpSeq#;
061200180827
061300200115           // First Name
061400200115           fldName = 'Dep First Name';
061500200115           inBound = cpDfname;
061600200115           System = dfname;
061700200115           match = CheckMatch( inBound : System : fldName );
061800200115           Write R_GBS0039;
061900180827
062000180827
062100200115           // Middle Name
062200200115           fldName = 'Dep Middle Name';
062300200115           inBound = cpdmi;
062400200115           System = dmi;
062500200115           match = CheckMatch( inBound : System : fldName );
062600200115           Write R_GBS0039;
062700180827
062800180827
062900200115           // Last Name
063000200115           fldName = 'Dep Last Name';
063100200115           inBound = cpdlname;
063200200115           System = dlname;
063300200115           match = CheckMatch( inBound : System : fldName );
063400200115           Write R_GBS0039;
063500180827
063600180827
063700200115           // Address 1
063800200115           fldName = 'Dep Addr Line 1';
063900200115           inBound = cpdAddr1;
064000200115           System = dAddr1;
064100200115           match = CheckMatch( inBound : System : fldName );
064200200115           Write R_GBS0039;
064300180827
064400180827
064500200115           // Address 2
064600200115           fldName = 'Dep Addr Line 2';
064700200115           inBound = cpdAddr2;
064800200115           System = dAddr2;
064900200115           match = CheckMatch( inBound : System : fldName );
065000200115           Write R_GBS0039;
065100180827
065200200115           // City
065300200115           fldName = 'Dep City';
065400200115           inBound = cpdCity;
065500200115           System = dCity;
065600200115           match = CheckMatch( inBound : System : fldName );
065700200115           Write R_GBS0039;
065800180827
065900200115           // State
066000200115           fldName = 'Dep State';
066100200115           inBound = cpdState;
066200200115           System = dState;
066300200115           match = CheckMatch( inBound : System : fldName );
066400200115           Write R_GBS0039;
066500180827
066600200115           // Zip
066700200115           fldName = 'Dep ZipCode';
066800200115           inBound = cpdZip;
066900200120
067000200120           wZip5 = %Editc(dzip:'X');
067100200120           System =wZip5;
067200200120
067300200115           match = CheckMatch( inBound : System : fldName );
067400200115           Write R_GBS0039;
067500180827
067600200115           // Phone
067700200115           fldName = 'Dep Phone';
067800200115           inBound = %Scanrpl( '-' : '' : cpdPhone) ;
067900200115           System = %Editc(dArea:'X') +  %Editc(dPHone:'X');
068000200115           if System = '0000000000';
068100200115             system = '';
068200200115           EndIf;
068300200115           match = CheckMatch( inBound : System : fldName );
068400200115           inBound = cpdPhone;
068500200115           Write R_GBS0039;
068600180827
068700200115           // Gender
068800200115           fldName = 'Dep Gender';
068900200115           inBound = cpdGender;
069000200115           System = dsex;
069100200115           match = CheckMatch( inBound : System : fldName );
069200200115           Write R_GBS0039;
069300180827
069400180827
069500200115           // Birthdate
069600200115           fldName = 'Dep Birth date';
069700200115           inBound = cpdbDate;
069800180921
069900200115           // Convert to MM/DD/YYYYY  ( From m/d/yyyy )
070000200908           Exec Sql
070100200908             Select To_Char(To_Date(:Inbound, 'mm/dd/yyyy'), 'mm/dd/yyyy')
070200200908               Into :Inbound
070300200908               From Sysibm.Sysdummy1;
070400180921
070500200115           system = '';
070600200115           if dbirth > 0;
070700200115             System =  %Char(%Date(dbirth:*iso):*Usa);
070800200115           endif;
070900200115           match = CheckMatch( inBound : System : fldName );
071000200115           System = %Char(birth);
071100200115           Write R_GBS0039;
071200180827
071300180827
071400200115           // Student
071500200115           fldName = 'Dep Student';
071600200115           inBound = cpdStudnt;
071700200115           system = dstudn;
071800200115           match = CheckMatch( inBound : System : fldName );
071900200115           Write R_GBS0039;
072000180827
072100180827
072200180827
072300200115           // Medicare Number
072400200115           fldName = 'Dep Med Number';
072500200115           inBound = cpMednbr;
072600200115           system = dmed#;
072700200115           match = CheckMatch( inBound : System : fldName );
072800200115           Write R_GBS0039;
072900180827
073000180827
073100200115           // Cob
073200200115           fldName = 'Dep COB';
073300200115           inBound = cpcob;
073400200115           system = dCob;
073500200115           if inBound = '';
073600200115             inBound = 'N';
073700200115           EndIf;
073800200115           match = CheckMatch( inBound : System : fldName );
073900200115           inBound = cpCob;
074000200115           Write R_GBS0039;
074100180827
074200180827
074300200115           // Cob Number
074400200115           fldName = 'Dep COB Number';
074500200115           inBound = cpCobNbr;
074600200115           system = dcobp#;
074700200115           match = CheckMatch( inBound : System : fldName );
074800200115           Write R_GBS0039;
074900180827
075000180827
075100200115         EndIf;    // Dependent File
075200180827
075300180827
075400180924       end-Proc;
075500180827
075600180827
075700180827      *----------------------------------------------------------------
075800180827      *
075900180827      * Check Dependent Plans
076000180827      *
076100180827      *----------------------------------------------------------------
076200180827
076300180924       Dcl-Proc DependPlans;
076400180827
076500180827
076600200115         setll ( pTrst : pSub : pAcct :
076700200115            ucase( MbrClass ) : uCase( cpPlanDsc )) PlanxRefp;
076800180827
076900180827
077000200115         Dou %Eof(PlanxRefp);
077100200115           Reade ( pTrst : pSub : pAcct :
077200200115              ucase( MbrClass ) : uCase( cpPlanDsc )) PlanxRefp;
077300200115           if %eof(PlanxRefp);
077400200115             leave;
077500200115           endif;
077600200115
077700200115
077800200115           //----------------------------------------------------
077900200115           //
078000200115           //  Not Found: Write the missing plan
078100200115           //
078200200115           //----------------------------------------------------
078300200115           if not %Found( PlanxRefp );
078400200115             fldName = 'Dep Plan Error';
078500200115             inBound = cpPlanDsc;
078600200115             System = 'Not found in PlanxRefp';
078700200115             Match = 'N';
078800200115             Write R_GBS0039;
078900200115           EndIf;
079000180827
079100180827
079200200115           //----------------------------------------------------
079300200115           //
079400200115           //  Found: Check to see if the Dependent currently
079500200115           //         has that plan
079600200115           //
079700200115           //----------------------------------------------------
079800200115           if %Found( PlanxRefp );
079900180827
080000200115             wEffDate = 0;
080100200115             if cpEffDt > '';
080200200115               wEffDate = %Dec(%Date( cpeffdt : *USA ));
080300200115             endif;
080400180827
080500200115             wTrmDate = 0;
080600200115             if cpTermDt > '';
080700200115               wTrmDate = %Dec(%Date( cpTermdt : *USA ));
080800200115             endif;
080900180827
081000180827
081100200115             chain ( wssn : wDepNo : pTrst : pSub : pxPlanid ) dCovc;
081200200115             if %Found ( dCovc ) ;
081300200115
081400200115               if denrdt = wEffDate;
081500200115                 fldName = 'Plan OK';
081600200115                 inBound = cpPlanDsc;
081700200115                 System = 'Dependent Enrolled: ' +  pxPlanId ;
081800200115                 Match = 'Y';
081900200115                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
082000200115                 SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
082100200115                 Write R_GBS0039;
082200200115               EndIf;
082300180827
082400200115               if denrdt <> wEffDate;
082500200115                 fldName = 'Plan Error';
082600200115                 inBound = cpPlanDsc;
082700200115                 System = 'Dependent Enrolled: ' +  pxPlanId +
082800200115                  ' Eff Date does not match';
082900200115                 Match = 'N';
083000200115                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
083100200115                 SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
083200200115                 Write R_GBS0039;
083300200115               EndIf;
083400200115
083500200115             else;
083600200115
083700200115               fldName = 'Plan Error';
083800200115               inBound = cpPlanDsc;
083900200115               System = 'Dependent Not Enrolled. Plan id: ' + pxPlanId;
084000200115               Match = 'N';
084100200908               ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
084200200908               SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
084300200115               Write R_GBS0039;
084400180827
084500200115             endif;
084600200115           EndIf;
084700200115         enddo;
084800180827
084900180827       End-Proc;
085000180827
085100180827
