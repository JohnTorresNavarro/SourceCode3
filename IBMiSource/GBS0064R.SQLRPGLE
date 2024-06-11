000100210623       Ctl-opt option(*noDebugIo)   DftActGrp(*no)
000200180724          bnddir( 'GBSBIND' );
000300180607
000400180607      *-------------------------------------------------------------------------
000500180607      *
000600201111      *  Description: Scan through the GBS 2.0 file spread sheet. Compare with
000700180824      *   what we have on the iSeries.  We will be alble to
000800180824      *    1. Show the AA's what data needs to be changed.
000900180824      *    2. perhaps use this for the Auto Enrollment Process.
001000180607      *
001100180607      *  Programmer.: Brian Rees
001200201111      *  Date.......: 11/11/2020
001300180607      *
001400180924      *-------------------------------------------------------------------------
001500180924      *  Change Log
001600180924      *
001700180924      *
001800180607      *-------------------------------------------------------------------------
001900180607
002000180607      *-------------------------------------------------------------------------
002100180924      *
002200180607      * Declare Files
002300180607      *
002400180607      *-------------------------------------------------------------------------
002500180607
002501201112       dcl-f GBS20l1 keyed;
002502201112       dcl-f GBS20l2 keyed rename( r_gbs20p : Rcd_2 );
002503201112       dcl-f GBS20l3 keyed rename( r_gbs20p : Rcd_3 );
002504201112       dcl-f GBS20l4 keyed rename( r_gbs20p : Rcd_4 );
002505201112
002506201112
003000180724       dcl-f Gbs0039p keyed usage(*output);
003100180724
003200210224       Dcl-f Member keyed ExtDesc('F.MEMBER') ExtFile(*extdesc);
003300201118       Dcl-f Depndc   keyed ExtDesc('F.DEPNDC') ExtFile(*extdesc);
003400200115       Dcl-f mCovc15  keyed ExtDesc('F.MCOVC15') ExtFile(*extdesc);
003500200115       Dcl-f dCovc    keyed ExtDesc('F.DCOVC') ExtFile(*extdesc);
003600180824
003700180824       dcl-f PlanxRefp keyed;
003701210224       dcl-f CFS100p   keyed;
003800210224       dcl-f MemAc#    keyed ExtDesc('F.MEMAC#') ExtFile(*extdesc)
003801210224            Rename(Membr: Mem1);
003900180607
003901210226       dcl-f Planxrefl1 keyed
003902210226            Rename( r_Planxref : xRef1 );
003903210226
003904210226
003905210315       dcl-f mCov  keyed ExtDesc('F.MCOV') ExtFile(*extdesc)
003906210315          Rename( mCovr : Cov1 );
003907210226
003908210226
003909210520       dcl-f PlnMst  keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
003910210520       dcl-f Codesl1 keyed ExtDesc('F.CODESL1') ExtFile(*extdesc);
003911210520
003912210520
004000180607      *-------------------------------------------------------------------------
004100180607      *
004200180607      * Global Variables
004300180607      *
004400180607      *-------------------------------------------------------------------------
004500201117       dcl-s SavSSN like(l1_ssn);
004600180724
004700180724       dcl-s cssn   Char(9);
004800180724       dcl-s wSSN   Zoned(9);
004900180725       dcl-s wSalary Zoned(8:2);
005000180725       dcl-s wEffDate Zoned(8);
005100180824       dcl-s wTrmDate Zoned(8);
005200180824
005300180824       dcl-s memberFound Char(1);
005900180827       dcl-s DependFound Char(1);
006000180827       dcl-s wDepno Zoned(2);
006200200120       dcl-s wZip5 Char(5);
006300210224       dcl-s hasLongName ind ;
006301210226       dcl-s UniqId like(l3_uniqId);
006302210520
006303210520       dcl-s PCP_Code Char(3);
006400180824
006500180824      *-------------------------------------------------------------------------
006600180824      *
006700180824      * *Entry Procedure
006800180824      *
006900180824      *-------------------------------------------------------------------------
007000180920       Dcl-pr Main ExtPgm;
007100200115         *N  Char(10);
007200180920       End-Pr;
007300180920
007400180920       dcl-pi Main;
007500200115         pKey Char(10);
007600180920       End-Pi;
007700180920
007800180920       dcl-s  pTrst Zoned(3);
007900180920       dcl-s  pSub  Zoned(3);
008000180920       dcl-s  pAcct Zoned(4);
008100180724
008300180824
008400180824
008500180824
008600180724      *-------------------------------------------------------------------------
008700180724      *
008800180724      * Procedures
008900180724      *
009000180724      *-------------------------------------------------------------------------
009200180724
009300180724
009400180724       dcl-pr CheckMatch Char(1);
009500200115         InValue  Char(50) value;
009600200115         SysValue Char(50) value;
009700200115         iFldName Char(20) value;
009800180724       End-Pr;
009900180607
010000180824
010100180824
010200180607
010300180607      *-------------------------------------------------------------------------
010400180607      *
010500180607      * Mainline Program
010600180607      *
010700180607      *-------------------------------------------------------------------------
010800180824
010900180920
011000180920       pTrst = %Dec( %Subst( pKey : 1 : 3 ) : 3 : 0 );
011100180920       pSub  = %Dec( %Subst( pKey : 4 : 3 ) : 3 : 0 );
011200180920       pAcct = %Dec( %Subst( pKey : 7 : 4 ) : 4 : 0 );
011300180920
011301201112
011302210224       Setll *loval GBS20l1;     // Member File
011303201112       Dou %eof(GBS20l1);
011304201112
011305201112         read GBS20l1;
011306201112         if %eof(GBS20l1);
011307201112           leave;
011308201112         endif;
011309201112
011310201112
011311201112         inssn = l1_ssn;
011312201112
014600201117         if l1_ssn <> savssn;
014700201117           cSSN = %Scanrpl( '-' : '' : l1_ssn);
014800201117           wSSN = %Dec( cssn : 9 : 0 );
014900180724
015000201117           memberFound = '';
015200201117           wDepno = 0;
015300200115
015400201117           ineffDt =  '';
015500201117           SyeffDt =  '';
015600180824
015601210604
015602210604           Depssn = '';
015603210604           depFName = '';
015604210604           depMI = '';
015605210604           depLName = '';
015606210624           locat = '';
015608210604
015700201117           checkMember();
015900201117           savssn = l1_ssn;
015901201117         endif;
016000180724
016300180827
016400180827
016500200115         //----------------------------------------------------
016600200115         //
016700200115         //   Search for the plans: MEMBER
016800200115         //
016900200115         //----------------------------------------------------
017000201116         if memberFound = 'Y';
017100200115           MemberPlans();
017101201117
017102210224
017103201117           //----------------------------
017104201117           // Dependent Data
017105210224           //----------------------------
017106201117           Setll l1_ssn GBS20l3;
017107201117
017108201117           Dou %Eof(GBS20l3);
017109201117             reade l1_ssn GBS20l3;
017110201117             if %eof(GBS20l3);
017111201117               leave;
017112201117             endif;
017113201117
017114210604           Depssn = l3_Depssn;
017115210604           depFName = l3_FName;
017116210604           depMI = l3_mi;
017117210604           depLName = l3_lName;
017118210624                    locat = l3_Uniqid;
017119210624
017120201117             checkDepend();
017121201117
017122201119             if DependFound = 'Y';
017123201117
017124210224               //----------------------------
017125210224               // Dependent Coverages
017126210224               //----------------------------
017127210224
017128210224               Setll l3_uniqid gbs20l4;
017129201117
017130210224               Dou %Eof(gbs20l4);
017131210224                 reade l3_uniqid gbs20l4;
017132201119                 if %eof(gbs20l4);
017133210224                   leave;
017134210224                 endif;
017135201117
017136201117
017137201119                 DependPlans();
017138201119               Enddo;
017139201119             endif;
017140201117           Enddo;
018701201117         EndIf;
018800180827
018900180827
020300180724
020400180827       Enddo;
020500180724
020600210813            ScanGenieData();
020700180607
020800180924       *inlr = *on;
020900180724
021000180824      *----------------------------------------------------------------
021100180824      *
021200180824      * Check Member Record
021300180824      *
021400180824      *----------------------------------------------------------------
021500180824
021600201117       Dcl-Proc CheckMember;
021700180824
021800210224         hasLongName = *off;
021900210520         inSeq# = 0;
021901210520
021902210520         SavFName = l1_Fname;
021903210520         SavMi =  l1_mi;
021904210520         savLName = l1_lName;
021906210520
021907210520
022000200115         // Get Member Information
022100201117         chain wSSN Member;
022200201117         if not %Found( Member );
022300200116           fldName = 'Member SSN';
022400200116           inBound = 'Member not in Genie.';
022500200116           System = '';
022600200116           match = 'N';
022700201117           Write R_GBS0039;
022800201117           return;
022900200115         EndIf;
023000180824
023100201117         if %Found( Member );
023200180824
023300200115           memberFound = 'Y';
023400180824
023401210224
023402210224           chain  ( wssn : 0 ) cfs100p;
023403210224           if %Found( cfs100p );
023404210224             hasLongName = *on;
023405210224           EndIf;
023406210224
023407210224
023408210224           if  mbTrst <> pTrst or
023409210224               mbSub# <> pSub or
023410210224               mbAcct <> pAcct;
023411210224
023412210224             fldName = 'Account';
023413210224             inBound = pKey;
023414210224             System = %editc(mbTrst:'X') +
023415210224                      %editc(mbSub#:'X') +
023416210224                      %editc(mbAcct:'X');
023417210224
023418210224             match = 'N';
023419210224             Write R_GBS0039;
023420210224
023421210224           EndIf;
023422210224
023423210224
023424210224
023500200115           // First Name
023600200115           fldName = 'First Name';
023700201112           inBound = L1_fname;
023800200115           System = mfname;
023801210224
023802210224           if hasLongName;
023803210224             System = cfsFst;
023804210224           EndIf;
023806210224
023900200115           match = CheckMatch( inBound : System : fldName );
024000200115           Write R_GBS0039;
024100180824
024200180824
024300200115           // Middle Name
024400200115           fldName = 'Middle Name';
024500201112           inBound = l1_mi;
024600200115           System = mmi;
024605210224
024700200115           match = CheckMatch( inBound : System : fldName );
024800200115           Write R_GBS0039;
024900180824
025000180824
025100200115           // Last Name
025200200115           fldName = 'Last Name';
025300201112           inBound = l1_lname;
025400200115           System = mlname;
025401210224
025402210224           if hasLongName;
025403210224             System = cfsLst;
025404210224           EndIf;
025405210224
025500200115           match = CheckMatch( inBound : System : fldName );
025600200115           Write R_GBS0039;
025700180824
025800180824
025900200115           // Address 1
026000200115           fldName = 'Addr Line 1';
026100201112           inBound = l1_Addr1;
026200200115           System = Addr1;
026300200115           match = CheckMatch( inBound : System : fldName );
026400200115           Write R_GBS0039;
026500180824
026600180824
026700200115           // Address 2
026800200115           fldName = 'Addr Line 2';
026900201112           inBound = l1_Addr2;
027000200115           System = Addr2;
027100200115           match = CheckMatch( inBound : System : fldName );
027200200115           Write R_GBS0039;
027300180824
027400200115           // City
027500200115           fldName = 'City';
027600201112           inBound = l1_City;
027700200115           System = City;
027800200115           match = CheckMatch( inBound : System : fldName );
027900200115           Write R_GBS0039;
028000180824
028100200115           // State
028200200115           fldName = 'State';
028300201112           inBound = l1_State;
028400200115           System = State;
028500200115           match = CheckMatch( inBound : System : fldName );
028600200115           Write R_GBS0039;
028700180824
028800200115           // Zip
028900200115           fldName = 'ZipCode';
029000201112           inBound = l1_Zip;
029100200120
029200200120           wZip5 = %Editc(zip:'X');
029300200120           System =wZip5;
029400200120
029500200115           match = CheckMatch( inBound : System : fldName );
029600200115           Write R_GBS0039;
029700180824
029800200115           // Phone
029900200115           fldName = 'Phone';
030000201112           inBound = %Scanrpl( '-' : '' : l1_Phone) ;
030100201117           System = %Editc(Area:'X') +  %Editc(PHone:'X');
030200200115           if System = '0000000000';
030300201117             system = '';
030400200115           EndIf;
030500200115           match = CheckMatch( inBound : System : fldName );
030600201112           inBound = l1_Phone;
030700200115           Write R_GBS0039;
030800180824
030900200115           // Gender
031000200115           fldName = 'Gender';
031100201112           inBound = l1_Gender;
031200200115           System = sex;
031300200115           match = CheckMatch( inBound : System : fldName );
031400200115           Write R_GBS0039;
031500180824
031600180824
031700200115           // Birthdate
031800200115           fldName = 'Birth date';
031900201112           inBound = l1_dob;
033000201117           system = '';
033100200115           if birth > 0;
033200201117             System =  %Char(birth);
033300200115           endif;
033400200115           match = CheckMatch( inBound : System : fldName );
033500200115           System = %Char(birth);
033600200115           Write R_GBS0039;
033700180824
033800180824
033900200115           // Hire Date
034000200115           fldName = 'Hire Date';
034100201112           inBound = l1_doh;
034900201117           system = '';
035000200115           if empdt > 0;
035100201117             System =  %Char(empdt);
035200200115           endif;
035300200115           match = CheckMatch( inBound : System : fldName );
035400200115           System = %Char(empdt);
035500200115           Write R_GBS0039;
035600180824
035700180824
035800200115           // Marriage Date
035900201116           //    fldName = 'Marriage Date';
036000201116           //    inBound = cpmDate;
036100201116           //
036200201116           //    // Convert to MM/DD/YYYYY  ( From m/d/yyyy )
036300201116           //    Exec Sql
036400201116           //      Select To_Char(To_Date(:Inbound, 'mm/dd/yyyy'), 'mm/dd/yyyy')
036500201116           //        Into :Inbound
036600201116           //        From Sysibm.Sysdummy1;
036700201116           //
036800201116           //    system = '';
036900201116           //    if mardt > 0;
037000201116           //      System =  %Char(%Date(mardt:*iso):*Usa);
037100201116           //    endif;
037200201116           //    match = CheckMatch( inBound : System : fldName );
037300201116           //    System = %Char(mardt);
037400201116           //    Write R_GBS0039;
037500180824
037600200115           // Salary
037700200115           fldName = 'Salary';
037800180824
037900201117           wSalary = 0;
038000201117           if l1_sal > '';
038100201117             wSalary = %Dec( %Trim( l1_Sal ) : 8 : 2 );
038200210520             Exec Sql
038300210520               Select Round(:Wsalary)
038400210520                 Into :Wsalary
038500210520                 From Sysibm.Sysdummy1;
038600200115           endif;
038700180824
038800200115           inBound = %Char(wSalary);
038900200115           inBound = %Scanrpl('.00' : '' : inBound );
039000180827
039100200115           system = %Char(Salary);
039200200115           match = CheckMatch( inBound : System : fldName );
039300201117           inBound = l1_Sal;
039400201117           Write R_GBS0039;
039500180824
039501210520
039502210520           // Email Address
039503210520           fldName = 'Email';
039505210520           inBound = l1_Email;
039506210520           System = %subst(Fill66:1:65);
039507210520           match = CheckMatch( inBound : System : fldName );
039508210520           Write R_GBS0039;
039509210520
039521210520
039529210520           if %Subst(Status:2:1) = 'C';
039530210604           fldName = 'Cancelled';
039531210520             System = 'Member is Cancelled in Genie';
039532210520             inbound = '';
039533210520             match = 'N';
039534210520           Write R_GBS0039;
039535210520           EndIf;
041900180824
042000201117         EndIf;    // Member File
042100180824
042200180824
042300180924       end-Proc;
042400180824
042500180724      *----------------------------------------------------------------
042600180724      *
042700180724      * Check Match Function
042800180724      *
042900180724      *----------------------------------------------------------------
043000180724
043100201117       Dcl-Proc CheckMatch export;
043200180724
043300201117         Dcl-pi *n Char(1);
043400200115           inValue  Char(50) value;
043500201117           SysValue Char(50) value;
043600201117           iFldName Char(20) value;
043700200115         End-Pi;
043800180724
043900200115         dcl-s ReturnText Char(1);
043901210315         dcl-s inSize Zoned(3);
043902210315         dcl-s SysSize Zoned(3);
043903210315         dcl-s Smallest_Size Zoned(3);
043904210315
044000180724
044100200115         ReturnText = 'Y';
044200210603         inValue = %upper(inValue);
044201210603         SysValue = %upper(SysValue);
044202210520
044300180920
044400200115         //--------------------------
044500200115         // Remove any periods..
044600200115         //--------------------------
044700200115         inValue = %ScanRpl( '.' : '' : inValue);
044800200115         SysValue = %ScanRpl( '.' : '' : SysValue);
044900180920
044901210219         inValue = %ScanRpl( ',' : '' : inValue);
044902210219         SysValue = %ScanRpl( ',' : '' : SysValue);
045000180724
045001210219         inValue = %ScanRpl( '&' : '' : inValue);
045002210219         SysValue = %ScanRpl( '&' : '' : SysValue);
045003210219
045004210315
045005210315
045006210315         // Get the length of the values.
045007210315         // we will use this to compare any
045008210315         // truncated values.
045009210315         inSize = %Len( %Trim( inValue ));
045010210315         SysSize = %Len( %Trim( SysValue ));
045012210315
045013210315         Smallest_Size = inSize;
045014210315         if SysSize < inSize;
045015210315           Smallest_Size = SysSize;
045016210315         EndIf;
045017210315
045018210315
045023210315
045024210315         if Smallest_Size = 0;
045100210520           if inValue <>  SysValue;
045200210315             ReturnText = 'N';
045300210315           EndIf;
045301210315
045302210315         else;
045303210315
045304210520           if %Subst(  inValue : 1 : Smallest_Size )  <>
045305210520              %Subst(  SysValue : 1 : Smallest_Size );
045306210315
045308210315             ReturnText = 'N';
045309210315           EndIf;
045310210315
045311210315         endif;
045312210315
045400180724
045500201117         // Salary Check.
045600201117         if iFldName = 'Salary';
045700200115           if %Trim( inValue ) = '' and %Trim( SysValue ) = '0';
045800201117             ReturnText = 'Y';
045900201117           endif;
046000200115         endif;
046100190717
046200190717
046300201117         Return ReturnText;
046400180724
046500180924       end-Proc;
046600180724
046700180827      *----------------------------------------------------------------
046800180827      *
046900180827      * Check Member Plans
047000180827      *
047100180827      *----------------------------------------------------------------
047200180827
047300201117       Dcl-Proc MemberPlans;
047400180827
047401210520         dcl-s Ignore_EffDate Char(1);
047402210315
047403210315         setll l1_ssn gbs20l2;
047404210315         dou %Eof( gbs20l2 );
047500210315           reade l1_ssn gbs20l2;
047501210315
047502210315           if %eof( gbs20l2 );
047503210315             leave;
047504210315           EndIf;
047505210315
047506210315
047600210603           Setll ( pTrst : pSub : pAcct : %upper( l2_plan )) PlanxRefp;
047900180827
048000200115
048100210315           Dou %Eof(PlanxRefp);
048200210603             Reade ( pTrst : pSub : pAcct : %upper( l2_plan )) PlanxRefp;
048400210315             if %eof(PlanxRefp);
048500210315               leave;
048600210315             endif;
048700200115
048800210520             Ignore_EffDate = 'Y';    // Start off ignoring the effective
048801210520             // date unless other information has
048802210520             // changed.
048900200115
049000210315             //----------------------------------------------------
049100210315             //
049200210315             //  Not Found: Write the missing plan
049300210315             //
049400210315             //----------------------------------------------------
049500210315             if not %Found( PlanxRefp );
049600210604               fldName = 'Plan NF';
049700210315               inBound = l2_plan;
049800210315               System = 'Not found in PlanxRefp';
049900210315               Match = 'N';
050000210315               Write R_GBS0039;
050100210315             EndIf;
050200180827
050300180827
050400210315             //----------------------------------------------------
050500210315             //
050600210315             //  Found: Check to see if the member currently
050700210315             //         has that plan
050800210315             //
050900210315             //----------------------------------------------------
051000210315             if %Found( PlanxRefp );
051100180827
051200210315               wEffDate = 0;
051300210315               if l2_Effdt > '';
051400210315                 wEffDate = %Dec(l2_Effdt:8:0);
051500210315               endif;
051600180827
051700210315               wTrmDate = 0;
051800210315               if l2_Termdt > '';
051900210315                 wTrmDate = %Dec(l2_TermDt:8:0);
052000210315               endif;
052100180827
052200200114
052300210315               chain ( pTrst : pSub : pAcct : wssn : pxPlanid ) mCovc15;
052400210315               if %Found ( mCovc15 ) ;
052500200115
052600210315                 if enrldt = wEffDate;
052700210315                   fldName = 'Plan OK';
052800210315                   inBound = l2_Plan;
052900210315                   System = 'Member Enrolled: ' +  pxPlanId ;
053000210315                   ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
053100210315                   SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
053200210315                   Match = 'Y';
053300210315                   Write R_GBS0039;
053400210315                 EndIf;
053500200115
053502210520
053503210520                 if %Subst( mCovTp : 2 : 2 ) <> l2_enrl;
053504210604                   fldName = 'Plan Covg Type';
053505210520                   inBound = l2_Enrl;
053506210520                   System = pxPlanId + ': Coverage Type doesnt match - ' +
053507210520                      %Subst( mCovTp : 2 : 2 );
053508210520                   Match = 'N';
053509210520                   ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
053510210520                   SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
053511210520                   Write R_GBS0039;
053512210520
053514210520                   Ignore_EffDate = 'N';    // Will now need to check the
053515210520                 // Effective Date
053516210520
053517210520                 EndIf;
053518210520
053600200115
053601210520                 if Ignore_EffDate = 'N';
053700210520                   if enrldt < wEffDate;
053800210520                     fldName = 'Plan OK';
053900210520                     inBound = l2_Plan;
054000210520                     System = 'Member Enrolled: ' +  pxPlanId +
054100210520                     ' Eff Date prior to inbound date.' ;
054200210520                     Match = 'Y';
054300210520                     ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
054400210520                     SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
054500210520                     Write R_GBS0039;
054600210520                   EndIf;
054700200115
054701210520                   if enrldt > wEffDate;
054702210604                     fldName = 'Plan Eff Date';
054703210520                     inBound = l2_Plan;
054704210520                     System = 'Member Enrolled: ' +  pxPlanId +
054705210520                     ' Eff Date does not match';
054706210520                     Match = 'N';
054707210520                     ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
054708210520                     SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
054709210520                     Write R_GBS0039;
054710210520                   EndIf;
054711210224
054900210520                 endif;   // Effective Date
054901210520
054902210520
054903210315                 if mcDltd = 'C';
054904210604                   fldName = 'Plan Cancelled';
054905210315                   inBound = l2_Plan;
054906210315                   System = 'Member Enrolled: ' +  pxPlanId +
054907210315                   ' Plan is cancelled in Genie';
054908210315                   Match = 'N';
054909210315                   ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
054910210315                   SyeffDt =  %Char(%Date(enrldt:*iso):*Usa);
054911210315                   Write R_GBS0039;
054912210315
054913210315                 EndIf;
054914210315
055000210520               EndIf;   // Found in mCovc15
055001210520
055002210520
055003210520
055100180827
055200210315               if not %Found ( mCovc15 ) ;
055300210604                 fldName = 'Plan New Plan';
055400210315                 inBound = l2_Plan;
055500210315                 System = 'Member Not Enrolled: ' + pxPlanId ;
055600210315                 Match = 'N';
055700210315                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
055800210315                 SyeffDt =  '';
055900210315                 Write R_GBS0039;
056000210315               EndIf;
056100180827
056200180827
056201210520               // Check PCP Info...
056202210520
056203210520               if l2_pcp# > '';
056204210520                 pcp_Code = 'MED';    // Default to Medical
056205210520
056206210520                 chain ( pTrst : pSub: pxPlanId ) PlnMst;
056207210520                 if %Found( PlnMst ) ;
056208210520                   chain plnCat Codesl1;
056209210520                   if %Found( Codesl1 );
056210210520                     if Action = 'D';
056211210520                       pcp_Code = 'DEN';
056212210520                     EndIf;
056213210520                   EndIf;
056214210520                 EndIf;
056215210520
056216210520
056217210520
056218210520                 fldName = 'PCP';
056219210520                 inBound = l2_pcp#;
056220210520                 System = '';
056221210520
056222210520
056223210520                 // Get Medical PCP Information
056224210520                 Exec Sql
056225210520                   Select Pcid#
056226210520                     Into :System
056227210520                     From "F.PCP"
056228210520                     Where Pcssn = :Wssn And
056229210520                           Pcdseq = 0 And
056230210520                           Pceff <= :l2_pcpefdt And
056231210520                           (Pccan >= :l2_pcpefdt Or
056232210520                             Pccan = 0) And
056233210520                           Pcspcd = :Pcp_Code;
056234210520
056235210520                 match = CheckMatch( inBound : System : fldName );
056236210520                 Write R_GBS0039;
056238210520
056239210520               endif;
056240210520
056241210520
056242210520
056300210520             EndIf;   // In the Plan Cross Reference.
056400180827
056500210315           Enddo;
056600210315         enddo;
056601210315
056700180924       End-Proc;
056800180827
056900180724
057000180827      *----------------------------------------------------------------
057100180827      *
057200180827      * Check Dependent Record
057300180827      *
057400180827      *----------------------------------------------------------------
057500180827
057600201117       Dcl-Proc CheckDepend;
057700180827
057702201118         dcl-s wSeq Zoned(2);
057703210224
057704210224         hasLongName = *off;
057705201119         DependFound = 'Y';
057706201118         wSeq = 0;
057707201118         cSSN = %Scanrpl( '-' : '' : l3_depssn);
057708201118
057709201118
057710201118         if l3_depssn > '';
057711201118
057712210520           exec sql
057713210520             select dpSeq#
057714210520               into :wSeq
057715210520               from "F.DEPEND"
057716210520               where dssno = :wssn and
057717210520                     depss# = :l3_depssn;
057718201118         EndIf;
057719201118
057720201118
057721201118
057722201118         if wSeq = 0;
057723201118           // Use SQL to find the dependent.
057724210520           exec sql
057725210520             select dpSeq#
057726210520               into :wSeq
057727210520               from "F.DEPEND"
057728210520               where dssno = :wssn and
057729210520                     dfname = upper(:l3_fname) and
057730210520                     dbirth = :l3_dob;
057731201118
057732201118         EndIf;
057800180827
057801201118         if wSeq = 0;
057802201118
057803201118           fldName = 'Dep SSN';
057804210608           inBound = 'Dependent Not in Genie';
057805210608           System = l3_uniqid;
057806201118           match = 'N';
057807201119           DependFound = 'N';
057808201118           Write R_GBS0039;
057809201118           return;
057810201118         EndIf;
057811201118
057812201118
059400200115         // Get Dependent Information
059500201118         chain ( wssn : wSeq ) Depndc;
059501201118         if %Found( Depndc ) ;
059502201118
059503201119           wDepno = dpSeq#;
059504201119           inSeq# = dpSeq#;
059505210224
059506210224           chain  ( wssn : wSeq ) cfs100p;
059507210224           if %Found( cfs100p );
059508210224             hasLongName = *on;
059509210224           EndIf;
059510210224
059513201119
059514201119           // SSN
059515201118           if l3_depssn = '';
059600201118             fldName = 'Dep SSN';
059800201118             inBound = 'SSN not found in File.';
059900201118             System = l3_depssn;
060000201118             match = 'N';
060100201118             Write R_GBS0039;
060101201118           endif;
061100180827
061200200115           // First Name
061300200115           fldName = 'Dep First Name';
061400201116           inBound = l3_fname;
061500200115           System = dfname;
061501210224
061502210224           if hasLongName;
061503210224             System = cfsFst;
061504210224           EndIf;
061505210224
061600200115           match = CheckMatch( inBound : System : fldName );
061700210224.          Write R_GBS0039;
061800180827
061900180827
062000200115           // Middle Name
062100200115           fldName = 'Dep Middle Name';
062200201116           inBound = l3_mi;
062300200115           System = dmi;
062400200115           match = CheckMatch( inBound : System : fldName );
062500200115           Write R_GBS0039;
062600180827
062700180827
062800200115           // Last Name
062900200115           fldName = 'Dep Last Name';
063000201116           inBound = l3_lname;
063100200115           System = dlname;
063101210224
063102210224           if hasLongName;
063103210224             System = cfsLst;
063104210224           EndIf;
063105210224
063106210224
063200200115           match = CheckMatch( inBound : System : fldName );
063300200115           Write R_GBS0039;
063400180827
063500180827
063600200115           // Address 1
063700200115           fldName = 'Dep Addr Line 1';
063800201116           inBound = l3_addr1;
063900200115           System = dAddr1;
064000200115           match = CheckMatch( inBound : System : fldName );
064100200115           Write R_GBS0039;
064200180827
064300180827
064400200115           // Address 2
064500200115           fldName = 'Dep Addr Line 2';
064600201116           inBound = l3_addr2;
064700200115           System = dAddr2;
064800200115           match = CheckMatch( inBound : System : fldName );
064900200115           Write R_GBS0039;
065000180827
065100200115           // City
065200200115           fldName = 'Dep City';
065300201116           inBound = l3_city;
065400200115           System = dCity;
065500200115           match = CheckMatch( inBound : System : fldName );
065600200115           Write R_GBS0039;
065700180827
065800200115           // State
065900200115           fldName = 'Dep State';
066000201116           inBound = l3_state;
066100200115           System = dState;
066200200115           match = CheckMatch( inBound : System : fldName );
066300200115           Write R_GBS0039;
066400180827
066500200115           // Zip
066600200115           fldName = 'Dep ZipCode';
066700201116           inBound = l3_zip;
066800200120
066900200120           wZip5 = %Editc(dzip:'X');
067000200120           System =wZip5;
067100200120
067200200115           match = CheckMatch( inBound : System : fldName );
067300200115           Write R_GBS0039;
067400180827
067500200115           // Phone
067600201116           //    fldName = 'Dep Phone';
067700201116           //    inBound = %Scanrpl( '-' : '' : cpdPhone) ;
067800201116           //    System = %Editc(dArea:'X') +  %Editc(dPHone:'X');
067900201116           //    if System = '0000000000';
068000201116           //      system = '';
068100201116           //    EndIf;
068200201116           //    match = CheckMatch( inBound : System : fldName );
068300201116           //    inBound = cpdPhone;
068400201116           //    Write R_GBS0039;
068500180827
068600200115           // Gender
068700200115           fldName = 'Dep Gender';
068800201116           inBound = l3_Gender;
068900200115           System = dsex;
069000200115           match = CheckMatch( inBound : System : fldName );
069100200115           Write R_GBS0039;
069200180827
069300180827
069400200115           // Birthdate
069500200115           fldName = 'Dep Birth date';
069600201116           inBound = l3_dob;
070400201117           system = '';
070500200115           if dbirth > 0;
070600201117             System =  %Char(dBirth);
070700200115           endif;
070800200115           match = CheckMatch( inBound : System : fldName );
070900201117           System = %Char(birth);
071000201117           Write R_GBS0039;
071100180827
071200180827
071300201116         //    // Student
071400201116         //    fldName = 'Dep Student';
071500201116         //    inBound = cpdStudnt;
071600201116         //    system = dstudn;
071700201116         //    match = CheckMatch( inBound : System : fldName );
071800201116         //    Write R_GBS0039;
071900180827
072000180827
072100180827
072200201116         // Medicare Number
072300201116         //    fldName = 'Dep Med Number';
072400201116         //    inBound = cpMednbr;
072500201116         //    system = dmed#;
072600201116         //    match = CheckMatch( inBound : System : fldName );
072700201116         //    Write R_GBS0039;
072800180827
072900180827
073000201116         // Cob
073100201116         //    fldName = 'Dep COB';
073200201116         //    inBound = cpcob;
073300201116         //    system = dCob;
073400201116         //    if inBound = '';
073500201116         //      inBound = 'N';
073600201116         //    EndIf;
073700201116         //    match = CheckMatch( inBound : System : fldName );
073800201116         //    inBound = cpCob;
073900201116         //    Write R_GBS0039;
074000201116         //
074100180827
074200201116         // Cob Number
074300201116         //    fldName = 'Dep COB Number';
074400201116         //    inBound = cpCobNbr;
074500201116         //    system = dcobp#;
074600201116         //    match = CheckMatch( inBound : System : fldName );
074700201116         //    Write R_GBS0039;
074800180827
074900180827
075000201117         EndIf;    // Dependent File
075100180827
075200180827
075300180924       end-Proc;
075400180827
075500180827
075600180827      *----------------------------------------------------------------
075700180827      *
075800180827      * Check Dependent Plans
075900180827      *
076000180827      *----------------------------------------------------------------
076100180827
076200201117       Dcl-Proc DependPlans;
076300180827
076301210614         dcl-s Ignore_EffDate Char(1);
076400180827
076500200115         setll ( pTrst : pSub : pAcct :
076600210603         %upper( l4_Plan ) ) PlanxRefp;
076700180827
076800180827
076900201117         Dou %Eof(PlanxRefp);
077000200115           Reade ( pTrst : pSub : pAcct :
077100210603             %upper( l4_Plan  )) PlanxRefp;
077200200115           if %eof(PlanxRefp);
077300201117             leave;
077400200115           endif;
077500200115
077600210614             Ignore_EffDate = 'Y';    // Start off ignoring the effective
077601210614             // date unless other information has
077602210614             // changed.
077603210614
077604210614
077605210614
077700200115           //----------------------------------------------------
077800200115           //
077900200115           //  Not Found: Write the missing plan
078000200115           //
078100201117           //----------------------------------------------------
078200201117           if not %Found( PlanxRefp );
078300200115             fldName = 'Dep Plan Error';
078400201116             inBound = l4_Plan ;
078500200115             System = 'Not found in PlanxRefp';
078600201117             Match = 'N';
078700201117             Write R_GBS0039;
078800200115           EndIf;
078900180827
079000180827
079100200115           //----------------------------------------------------
079200200115           //
079300200115           //  Found: Check to see if the Dependent currently
079400200115           //         has that plan
079500200115           //
079600201117           //----------------------------------------------------
079700201117           if %Found( PlanxRefp );
079800180827
079900201117             wEffDate = 0;
080000201116             if l4_effdt > '';
080100201117               wEffDate = %Dec(l4_EffDt :8:0);
080200200115             endif;
080300180827
080400201117             wTrmDate = 0;
080500201116             if l4_TermDt > '';
080600201117               wTrmDate = %Dec( l4_TermDt:8:0);
080700200115             endif;
080800180827
080900180827
081000201117             chain ( wssn : wDepNo : pTrst : pSub : pxPlanid ) dCovc;
081100201117             if %Found ( dCovc ) ;
081200200115
081300201117               if denrdt = wEffDate;
081400200115                 fldName = 'Plan OK';
081500201116                 inBound = l4_Plan ;
081600200115                 System = 'Dependent Enrolled: ' +  pxPlanId ;
081700200115                 Match = 'Y';
081800200115                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
081900201117                 SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
082000201117                 Write R_GBS0039;
082100200115               EndIf;
082200180827
082300210224               if denrdt < wEffDate;
082400210224                 fldName = 'Plan OK';
082500201116                 inBound = l4_Plan ;
082600200115                 System = 'Dependent Enrolled: ' +  pxPlanId +
082700210224                 ' Eff Date Prior to inbound date';
082800210224                 Match = 'Y';
082900200115                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
083000201117                 SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
083100201117                 Write R_GBS0039;
083200201117               EndIf;
083300200115
083301210624
083312210624               if dvdltd = 'C' and
083313210624                  (cCandt = 0  or cCandt > %Dec(%Date));
083314210624
083315210624
083316210226                 fldName = 'Plan Error';
083317210226                 inBound = l4_Plan;
083318210226                 System = 'Dependent Enrolled: ' +  pxPlanId +
083319210226                 ' Plan is cancelled in Genie';
083320210226                 Match = 'N';
083321210226                 ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
083322210226                 SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
083323210226                 Write R_GBS0039;
083324210226
083325210226               EndIf;
083326210226
083327210624
083328210624               if dvdltd = 'C' and
083329210624                  (cCandt > 0  and cCandt <= %Dec(%Date));
083330210624
083331210624               fldName = 'Plan New Plan';
083332210624               inBound = l4_Plan ;
083333210624               System = 'Dependent Not Enrolled. Plan id: ' + pxPlanId;
083334210624               Match = 'N';
083335210624               ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
083336210624               SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
083337210624               Write R_GBS0039;
083338210624             endif;
083339210614
083340210614             // Not Needed
083341210614
083342210614       //        if denrdt > wEffDate;
083343210614       //          fldName = 'Plan Error';
083344210614       //          inBound = l4_Plan ;
083345210614       //          System = 'Dependent Enrolled: ' +  pxPlanId +
083346210614       //          ' Eff Date does not match';
083347210614       //          Match = 'N';
083348210614       //          ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
083349210614       //          SyeffDt =  %Char(%Date(denrdt:*iso):*Usa);
083350210614       //          Write R_GBS0039;
083351210614       //        EndIf;
083352210614
083400201117             else;
083500200115
083600200115               fldName = 'Plan Error';
083700201116               inBound = l4_Plan ;
083800200115               System = 'Dependent Not Enrolled. Plan id: ' + pxPlanId;
083900200115               Match = 'N';
084000200908               ineffDt =  %Char(%Date(wEffDate:*iso):*Usa);
084100210804               SyeffDt =  '' ;   // Not going to have an system Date.
084200201117               Write R_GBS0039;
084300180827
084400201117             endif;
084500201117           EndIf;
084600201117         enddo;
084700180827
084800180827       End-Proc;
084900180827
085000180827
085001210224      *----------------------------------------------------------------
085002210224      *
085003210224      * Scan Genie Data
085004210224      *
085005210224      * This will look at all of the active members/dependents and
085006210224      * verify that they are on the inbond file.
085007210224      *
085010210224      *----------------------------------------------------------------
085011210224
085012210224       Dcl-Proc ScanGenieData;
085013210224
085014210226         dcl-s DepFound ind;
085015210224         dcl-s wMbrSSN Char(9);
085016210224         dcl-s wDepSSN Char(9);
085017210224         dcl-s wBirth  Char(9);
085018210224
085019210224         inssn = '';
085020210224         inseq# = 0;
085021210224
085022210224         Setll ( pTrst : pSub : pAcct ) Memac#;
085023210224
085024210224         Dou %Eof(Memac#);
085025210224           reade ( pTrst : pSub : pAcct ) Memac#;
085026210224           if %eof(Memac#);
085027210224             leave;
085028210224           endif;
085029210224
085030210224           wMbrSsn = %Editc(mbssno:'X');
085031210224
085032210224           //----------------------------------
085033210224           //
085034210224           // Member in File?
085035210224           //
085036210224           //----------------------------------
085037210224           if %subst(status:2:1) = 'A';
085038210224             chain wMbrSsn gbs20l1;
085039210224
085040210224             if not %Found( gbs20l1 );
085041210224
085042210226               inssn = %Editc(mbssno:'X') ;
085043210224               fldName = 'Member Error';
085044210224               inBound = '' ;
085045210224               System = %Editc(mbssno:'X') +
085046210224               '   Member in Genie, not in File.';
085047210224               Match = 'N';
085048210224               ineffDt =  '';
085049210224               SyeffDt =  '';
085050210224               Write R_GBS0039;
085051210224
085053210224             EndIf;
085054210224
085055210224
085056210224             // Member is in the inbound file...
085057210224             // Now Check Plans!
085058210224
085059210224             if %Found( gbs20l1 ) ;
085060210224
085061210226               setll mbssno mCov;
085063210225
085064210226               Dou %Eof(mCov);
085065210226                 reade mbssno mCov;
085066210226                 if %eof(mCov);
085067210226                   leave;
085068210226                 endif;
085069210225
085070210226                 if  mcDltd = 'A';
085071210225
085072210226                   chain ( pTrst : pSub : pAcct : mcPlan ) PlanxRefl1;
085073210226                   if not %Found( PlanxRefl1 ) ;
085074210226
085075210226                     inssn = %Editc(mbssno:'X') ;
085076210623                     fldName = 'Enrolled Plan Error';
085077210226                     inBound = '' ;
085078210623                     System = mcPlan +
085079210623                     ' but is not setup in the cross reference file.';
085080210226                     Match = 'N';
085081210226                     ineffDt =  '';
085082210226                     SyeffDt =  '';
085083210813         //          Write R_GBS0039;
085084210226
085085210226                   EndIf;
085086210226
085087210226                   // Found!! Check inbound File.
085088210226                   if %Found( PlanxRefl1 ) ;
085089210226                     chain ( wMbrSsn : pxinPlan ) gbs20l2;
085090210226                     if not %Found( gbs20l2 ) ;
085092210226                       inssn = %Editc(mbssno:'X') ;
085093210226                       fldName = 'Plan Error';
085094210226                       inBound = '' ;
085095210226                       System = 'Plan name: ' + %Trim( pxinplan ) +
085096210226                       '  is not in the inbound file.';
085097210226                       Match = 'N';
085098210226                       ineffDt =  '';
085099210226                       SyeffDt =  '';
085100210813           //          Write R_GBS0039;
085103210226                     EndIf;
085106210226
085107210226                   EndIf;
085110210226
085111210226                 EndIf;
085114210225
085115210225               Enddo;
085119210224
085120210224             EndIf;
085122210224
085123210224           EndIf;
085124210224
085125210226
085126210224           //------------------------------------
085127210224           //
085128210224           // Check Dependent
085129210224           //
085130210224           //------------------------------------
085131210224
085132210224           Setll mbssno Depndc;
085133210224
085134210224           Dou %Eof(Depndc);
085135210224             reade mbssno Depndc;
085136210224             if %eof(Depndc);
085137210224               leave;
085138210224             endif;
085139210224
085141210224
085142210224             if  dpdltd = 'A';
085143210224
085144210226               DepFound = *off;
085145210226               wDepSsn = %Editc(Depss#:'X');
085146210226               wBirth = %Editc(dBirth:'X');
085147210226
085148210226               Setll wMbrSSN gbs20l3;
085149210226
085150210226               Dou %Eof(gbs20l3);
085151210226                 reade wMbrSSN gbs20l3;
085152210226                 if %eof(gbs20l3);
085153210226                   leave;
085154210226                 endif;
085155210226
085156210226                 // Check for SSN
085157210226                 if depss#> 0;
085158210226                   if %editc(Depss#:'X') = l3_Depssn;
085159210226                     UniqId = l3_Uniqid;
085160210226                     DepFound = *on;
085161210226                     leave;
085162210226                   EndIf;
085163210226                 EndIf;
085164210226
085165210226
085166210226                 if depss# = 0;
085167210603                   if %upper(l3_fname)  = dfname and
085168210226                     wBirth = l3_dob;
085169210226                     UniqId = l3_Uniqid;
085170210226                     DepFound = *on;
085171210226                     leave;
085172210226                   EndIf;
085173210226                 EndIf;
085174210226
085175210226
085176210226               Enddo;
085177210226
085178210226
085182210224
085198210224
085199210224
085200210226               if Not DepFound;
085201210224
085202210226                 fldName = 'Dependent Error';
085203210226                 inBound = '' ;
085204210226                 System = %Editc(mbssno:'X') + ' - '  +
085205210226                 %Char( dpSeq# ) + ': ' + dfname +
085206210226                   '   Dependent in Genie, not in File.';
085207210226                 Match = 'N';
085208210226                 ineffDt =  '';
085209210226                 SyeffDt =  '';
085210210226                 Write R_GBS0039;
085211210224
085212210226               EndIf;
085213210224
085214210226
085215210226               // Dependent Found..
085216210226               // Check Plans.
085217210226               if DepFound;
085218210226
085224210226                 setll ( mbssno : dpseq# ) dcovc;
085225210226
085226210226                 Dou %Eof(dcovc);
085227210226                   reade ( mbssno : dpseq# ) dcovc;
085228210226                   if %eof(dcovc);
085229210226                     leave;
085230210226                   endif;
085231210226
085232210226                   if  dvdltd = 'A';
085233210226
085234210226                     chain ( pTrst : pSub : pAcct : dvPlan ) PlanxRefl1;
085235210226                     if not %Found( PlanxRefl1 ) ;
085236210226
085237210226                       inssn = %Editc(mbssno:'X') ;
085238210226                       inSeq# = dpSeq#;
085239210226                       fldName = 'Plan Error';
085240210226                       inBound = '' ;
085241210226                       System = 'Plan ID: ' + dvPlan +
085242210226                       '  is not setup in the cross reference file.';
085243210226                       Match = 'N';
085244210226                       ineffDt =  '';
085245210226                       SyeffDt =  '';
085246210813          //           Write R_GBS0039;
085247210226
085248210226                     EndIf;
085249210226
085250210226                     // Found!! Check inbound File.
085251210226                     if %Found( PlanxRefl1 ) ;
085252210226                       chain ( uniqid : pxinPlan ) gbs20l4;
085253210226                       if not %Found( gbs20l4 ) ;
085254210226                         inssn = %Editc(mbssno:'X') ;
085255210226                         inSeq# = dpSeq#;
085256210226                         fldName = 'Plan Error';
085257210226                         inBound = '' ;
085258210226                         System = 'Plan name: ' + %Trim( pxinplan ) +
085259210226                         '  is not in the inbound file.';
085260210226                         Match = 'N';
085261210226                         ineffDt =  '';
085262210226                         SyeffDt =  '';
085263210813           //            Write R_GBS0039;
085264210226                       EndIf;
085265210226
085266210226                     EndIf;
085267210226
085268210226                   EndIf;
085269210226
085270210226                 Enddo;
085271210226
085272210226               EndIf;
085279210226
085280210226             EndIf;
085281210224
085282210224
085287210224           Enddo;
085288210224
085289210224
085290210224
085291210224         Enddo;
085292210224
085293210224
085294210224
085295210224       End-Proc;
085296210224
