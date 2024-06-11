000100180423       Ctl-opt option(*noDebugIo)   DftActGrp(*no)
000200180614          bnddir('GBSBDIR') ;
000300180418
000400180620      *------------------------------------------------------------------
000500180418      *
000600180419      *  Description: MacFadden ( 590 - 1 - 43 ) had requested a Payroll
000700180419      *    Deduction file. They also asked for a summary file. ( Year-End ? )
000800180419      *
000900180420      *  We are reading through the F.MEMBER File
001000180420      *  For Every Member; we check the each plan the member has. ( F.MCOV )
001100180420      *
001200180420      *  We will use the OLE Dashboard utility to retrive the Employee
001300180420      *  Deductions.
001400180420      *
001500180420      *  Since this is using the OLE #GetDed utility, the member must have
001600180420      *  a record in WebPayroll.
001700180420      *
001800180420      *  After retrieving the Employee Deduction and the Employer Deduction,
001900180420      *  We will be writting to the EmpDedP File. ( Accumulative File )
002000180420      *
002100180420      *
002200180420      *  The File Sent to MacFadden will be summerized from EmpDedP
002300180419      *
002400180420      *
002500180420      *  ** Term Records **
002600180420      *  Since we can only accumulate "active" plans, we will check the
002700180420      *  previous weeks file against the current week to find 'Termed' records
002800180420      *
002900180420      *
003000180620      *------------------------------------------------------------------
003100180420      *
003200180420      *  MacFadden Pay Period runs from Monday - Sunday ( Bi-weekly )
003300180420      *  They Requested that the data file is generated on Thursday.
003400180420      *  leaving 4 days within the current pay cycle.
003500180420      *
003600180420      *  So, this program would have to be run on Thursdays ( bi-weekly )
003700180420      *  then again the following Sunday to get any changes on that pay period
003800180420      *
003900180620      *------------------------------------------------------------------
004000180620      *
004100180620      *  Programmer.: Brian Rees
004200180419      *  Date.......: 04/18/2018
004300180418      *
004400180620      *------------------------------------------------------------------
004500180418
004600180430
004700180620      *------------------------------------------------------------------
004800180418      *
004900180418      * Declare Files
005000180418      *
005100180620      *------------------------------------------------------------------
005200220113       Dcl-f MemAc#1 keyed ExtDesc('F.MEMAC#1') ExtFile(*extdesc);
005300220113       Dcl-f MCOV    keyed ExtDesc('F.MCOV') ExtFile(*extdesc);
005400220113       Dcl-f PlnMst  keyed ExtDesc('F.PLNMST') ExtFile(*extdesc);
005500180418       Dcl-f WebPayroll keyed ;
005600180418
005700180418       Dcl-f EmpDedp keyed usage( *output ) ;
005800180418       Dcl-f EmpDedErr keyed usage( *output : *input ) ;
005900180424       dcl-f mcfpaycal keyed;
006000180419
006100180419       dcl-f McfxRef keyed;
006200180419
006300180418
006400180418
006500180418
006600180418
006700180620      *------------------------------------------------------------------
006800180418      *
006900180418      * Global Variables
007000180418      *
007100180620      *------------------------------------------------------------------
007200180418       dcl-s DepSeq Zoned(2);
007300180418       dcl-s PlanCat Char(3);
007400180418       dcl-s myCovgType Char(20);
007500180418       dcl-s ErrorCount Zoned(3) inz;
007600180418       dcl-s Rule char(4);
007700180418       dcl-s hasError char(1);
007800180418
007900180418
008000180418       dcl-ds Payded Extname('WEBPAYDS') End-DS;
008100180418       dcl-ds Webpfq Extname('WEBFACTP') inz end-ds;
008200180418
008300180418       dcl-s pTrst Zoned(3);
008400180418       dcl-s pSub Zoned(3);
008500180418       dcl-s pAcct Zoned(4);
008600180418
008700180423       dcl-s cost_PP  Zoned(5:2);
008800180423       dcl-s Cost_Month Zoned(6:2);
008900180419
009000180423       dcl-s LI_Amount Zoned( 11:2) ;
009100180424
009200180424       dcl-s CurYear Zoned(4);
009300180424       dcl-s CurWeek Zoned(3);
009400180424       dcl-s PrvYear Zoned(4);
009500180424       dcl-s PrvWeek Zoned(3);
009600180424
009700180424
009800180709      *-------------------------------------------------------------------------
009900180709      *
010000180709      * *Entry Procedure
010100180709      *
010200180709      *-------------------------------------------------------------------------
010300180709       Dcl-pr Main ExtPgm;
010400180709          *N  Char(1);
010500180709       End-Pr;
010600180709
010700180709       dcl-pi Main;
010800180709          pGenExport Char(1);
010900180709       End-Pi;
011000180423
011100180418      *------------------------------------------------------------------------
011200180418      *
011300180418      * Procedure
011400180418      *
011500180418      *------------------------------------------------------------------------
011600180709       /include RPGSPDASH/qmodsrc,#proto
011700180418
011800180418
011900180423       dcl-pr ClnNbr Char(100);
012000180620          inString Char(100) value;
012100180620       End-Pr;
012200180423
012300180418
012400180418
012500180620      *------------------------------------------------------------------
012600180418      *
012700180424      * Initialize Variables
012800180418      *
012900180620      *------------------------------------------------------------------
013000180620       pTrst = 590;
013100180418       pSub = 1;
013200180418       pAcct = 43;
013300180418
013400180418
013500180424
013600180424       //---------------------------------------------------
013700180424       //
013800180424       // What week are we in?
013900180424       //
014000180424       //  If we were running on a Thursday, we would use
014100180430       //  the current paycheck Week. ( Run Date )
014200180424       //
014300180424       //  If this is running on a Sunday, we would use
014400180430       //  the FOLLOWING paycheck Week. ( End Date )
014500180424       //---------------------------------------------------
014600180620       Exec Sql
014700180620          Select Mppaychk, Mppayyr
014800180620             Into :Curweek, :Curyear
014900180620             From Mcfpaycal
015000180620             Where Mprundate = Current_Date;
015100180424
015200180709        // Record was found on todays ( Thursday ) Date..
015300180709        // Generate the export file.
015400180709        if sqlCod = 0;
015500180709           pGenExport = 'Y';
015600180709        endif;
015700180709
015800180709
015900180424
016000180620       if sqlCod <> 0;
016100180430
016200180430          // Date not found... Check Sunday's Date ( End Date )
016300180620          // Get the current week - Then get the next week payroll number
016400180620          Exec Sql
016500180620             Select Mppaychk, Mppayyr
016600180620             Into :Curweek, :Curyear
016700180620             From Mcfpaycal
016800180620             Where Mpeddate = Current_Date;
016900180424
017000180424          if sqlCod = 0;
017100180620             setgt ( CurYear : CurWeek ) McfPayCal;
017200180620             read mcfPayCal;
017300180620             if not %Eof( mcfPayCal ) ;
017400180620                CurYear = mpPayYr;
017500180620                CurWeek = mpPayChk;
017600180620             EndIf;
017700180620          EndIf;
017800180424
017900180620       EndIf;
018000180424
018100180424
018200180424
018300180424
018400180430
018500180620       // Get the Previous Week.
018600180424       setll ( CurYear : CurWeek ) McfPayCal;
018700180424       readp mcfPayCal;
018800180424       if not %Eof( mcfPayCal ) ;
018900180620          PrvYear = mpPayYr;
019000180620          PrvWeek = mpPayChk;
019100180620       EndIf;
019200180424
019300180424
019400180620       if CurYear > 0 and CurWeek > 0;
019500180620          ReadFile();
019600180620       EndIf;
019700180620
019800180620
019900180620       *inlr = *on;
020000180424
020100180418
020200180620      *------------------------------------------------------------------
020300180424      *
020400180424      * Mainline Program
020500180424      *
020600180620      *------------------------------------------------------------------
020700180620       dcl-proc ReadFile;
020800180620
020900180620          Setll ( pTrst : pSub : pAcct )  memac#1;
021000180418
021100180620          Dou %Eof(memac#1);
021200180418
021300180620             reade ( pTrst : pSub : pAcct )  memac#1;
021400180620             if %eof(memac#1);
021500180620                leave;
021600180620             endif;
021700180418
021800180418
021900180620             if Termdt < 20180615 and termdt > 0;
022000180620                iter;
022100180620             EndIf;
022200180622
022300180622
022400180418
022500180622             // Dont Send COBRA People
022600180627             if GBSCDT <= %Dec(%Date) and gbscdt > 0;
022700180622                iter;
022800180622             EndIf;
022900180622
023000180424
023100180620             //-----------------------------
023200180620             //
023300180620             // Member Termed...
023400180620             //   We will be focusing on the plans...
023500180620             //   We dont need to worry about termed members.
023600180620             //
023700180620             //-----------------------------
023800180620             // .. Termdt > 0;
023900180418
024000180418
024100180620             DepSeq = 0;
024200180620             Retrieve_Plans();
024300180620             Find_TermPlans();
024400180418
024500180418
024600180620          Enddo;
024700180620       End-Proc;
024800180418
024900180418
025000180418
025100180620       // ----------------------------------------------------------------
025200180418
025300180620       dcl-proc Retrieve_Plans;
025400180418
025500180620          dcl-s NetRate Zoned(11:6);
025600180418          dcl-s YearRate Zoned(15:6);
025700180419          dcl-s PerPay  Zoned(9:2);
025800180418          dcl-s PrevAmt zoned(6:2);
025900180419          dcl-s PrevDed zoned(7:2);
026000180418
026100180418
026200180418
026300180424          //-----------------------------------------------
026400180424          //
026500180620          // Get the Rule & Pay Frequency from WebPayroll
026600180620          //
026700180620          //-----------------------------------------------
026800180620          Setll mbssno mCov;
026900180418
027000180620          Dou %Eof(mCov);
027100180620             reade mbssno mCov;
027200180418
027300180620             if %eof(mCov);
027400180620                leave;
027500180620             endif;
027600180418
027700180620             // Skip if the person is termed before we
027800180620             // started processing...
027900180620             if candt < 20180615 and candt > 0;
028000180620                iter;
028100180424             endIf;
028200180418
028300180418
028400180620             chk_Webpayroll();
028500180418
028600180620             if hasError = 'Y';
028700180620                return;
028800180424             EndIf;
028900180419
029000180419
029100180620             clear PayDed;
029200180418
029300180419
029400180424             // What happens if there is a cancel date   ??
029500180620             if candt > 0 and candt <= %Dec(%Date);
029600180620                Dsdamt = 0;
029700180620                perPay = 0;
029800180620             endif;
029900180419
030000180419
030100180620             if candt = 0;
030200180418
030300180418
030400180620                //-----------------------------------------------
030500180424                //
030600180424                // get the Plan Category
030700180620                //
030800180418                //-----------------------------------------------
030900180418                PlanCat = '';
031000180418                chain ( mcTrst : mcSub# : mcPlan ) PlnMst;
031100180620                if %Found( PlnMst ) ;
031200180620                   PlanCat = plncat;
031300180620                EndIf;
031400180418
031500180620                myCovgType = Get_Covg( mcovtp );
031600180418
031700180418
031800180418
031900180418                //-----------------------------------------------
032000180418                //
032100180418                // Get the Payroll deductions
032200180418                //
032300180418                //-----------------------------------------------
032400180418                payDed = #getDed( mcTrst : mcSub# : Acc# : mcssno :
032500180620                   DepSeq : mcPlan : PlanCat : myCovgType :  Enrldt : 0 : '');
032600180418
032700180418
032800180418
032900180418                //-----------------------------------------------
033000180418                //
033100180418                // Calculate the Employer Cost
033200180418                //
033300180418                //-----------------------------------------------
033400180621                Exec Sql
033500180621                   Select Netrte
033600180621                      Into :Netrate
033700180621                      From "F.GRATE"
033800180621                      Where Grtrst = :Mctrst
033900180621                            And Grsub# = :Mcsub#
034000180621                            And Grplan = :Mcplan
034100180621                            And Typecd = :Mcovtp
034200180621                            And :Enrldt Between Frmdat And Todat;
034300180418
034400180620                /// Calculate Yearly & PerPay Cost
034500180620                Yearrate = Netrate * 12;
034600180620                eval(h) PerPay   = YearRate / wpfrq ;
034700180418
034800180620             endif;
034900180419
035000180419
035100180419
035200180418
035300180418
035400180420             //-----------------------------------------------
035500180420             //
035600180420             // Calculate Deduction Code
035700180420             //
035800180420             //-----------------------------------------------
035900180420             edAction = 'A';               // New Deduction
036000180418
036100180621             Exec Sql
036200180621                Select Edempded, Edemrded
036300180621                   Into :Prevamt, :Prevded
036400180621                   From Empdedp
036500180621                   Where Edtrst = :Mctrst
036600180621                         And Edsub# = :Mcsub#
036700180621                         And Edacct = :Acc#
036800180621                         And Edssn = :Mcssno
036900180621                         And Edplan = :Mcplan
037000180621                         And Edpaychk = :Prvweek
037100180621                         And Edpayyr = :Prvyear
037200180621                   Order By Edrundate Desc
037300180621                   Fetch First Rows Only;
037400180418
037500180418
037600180418
037700180620             If (Prevamt <> Dsdamt or  PrevDed <> perpay)
037800180620                and SqlCod = 0;
037900180620                Edaction = 'U'; // Chnaged from previous Amount
038000180620             Endif;
038100180424
038200180424
038300180620             If Prevamt = Dsdamt
038400180620                And Prevded = Perpay
038500180620                And Sqlcod = 0;
038600180424
038700180620                Edaction = 'N'; // No Change
038800180620             Endif;
038900180424
039000180424
039100180620             //-----------------------------------------------
039200180424             //
039300180424             // Write to the Employee Deduction File
039400180424             //
039500180424             //-----------------------------------------------
039600180424
039700180424             Edrundate = %dec(%date);
039800180424             edPayYr = CurYear;
039900180424             edPayChk = CurWeek;
040000180424             Edtrst = Mctrst;
040100180424             Edsub# = Mcsub#;
040200180424             Edacct = Acc#;
040300180424             Edssn = Mcssno ;
040400180424             Edplan = Mcplan;
040500180424             Edplncat = Plancat;
040600180620             Edpayfrq = Wpfrq;
040700180424             Edempded = Dsdamt;
040800180620             Edemrded = Perpay;
040900180424             Edplncode = '';
041000180424
041100180620             Chain Mcplan Mcfxref;
041200180620             If %found(Mcfxref);
041300180620                Edplncode = Mxded;
041400180620             Endif;
041500180424
041600180620             If Edempded > 0
041700180620                Or Edemrded > 0;
041800180620                Write R_Empdedp;
041900180424
042000180620                // If the Life Amount is > 50,000;
042100180620                // Add a Group Term Life Amount.
042200180424
042300180620                If Mxded = 'BLA02';
042400180620                   Dscovt = Clnnbr(Dscovt);
042500180424
042600180620                   If %trim(Dscovt)  = '';
042700180620                      Dscovt = '0';
042800180620                   Endif;
042900180424
043000180620                   Li_Amount = %dec(Dscovt : 11 : 2);
043100180424
043200180620                   If Li_Amount > 50000;
043300180620                      Edplncode = 'GTL';
043400180620                      Gtl_Calc();
043500180620                      Edempded = Cost_Pp;
043600180620                      Edemrded = 0;
043700180424
043800180620                      Write R_Empdedp;
043900180620                   Endif;
044000180620                Endif;
044100180620             Endif;
044200180620          Enddo;
044300180424
044400180620       End-Proc;
044500180418
044600180418
044700180620      *----------------------------------------------------------------------
044800180420      *
044900180420      * Find the Termed Plans.
045000180420      *   By compairing the previous data with the current data.
045100180420      *   Any plans that are missing; are concidered Termed.
045200180420      *
045300180620      *----------------------------------------------------------------------
045400180620       dcl-proc Find_TermPlans;
045500180420
045600180620          dcl-s SqlStmt char(1000);
045700180620          dcl-s SqlDate  Zoned(8);
045800180620          dcl-s CurrDate Zoned(8) inz;
045900180620          dcl-s PrevDate Zoned(8) inz;
046000180620          dcl-s Count    Zoned(3) inz;
046100180420
046200180620          dcl-ds Sq_Data;
046300180620             sqTrst Zoned(3);
046400180620             sqSub# Zoned(3);
046500180620             sqAcct Zoned(4);
046600180620             sqSSN  Zoned(9);
046700180620             sqPlan   Char(4);
046800180620             sqPlnCat char(3);
046900180620             sqPayFrq  Zoned(3);
047000180620             sqPlnCode Char(20);
047100180620          End-Ds;
047200180420
047300180420
047400180620          //---------------------------
047500180620          //
047600180620          // Get the Dates
047700180620          //
047800180620          //---------------------------
047900180620          SqlStmt =
048000180620             'select Distinct edrundate +
048100180620             From empdedp +
048200180620             order by edrundate desc ' ;
048300180420
048400180620          Exec Sql
048500180620             Declare C1 Cursor For Sqlstmt;
048600180620          Exec Sql
048700180620             Prepare Sqlstmt From :Sqlstmt;
048800180620          Exec Sql
048900180620             Open C1;
049000180420
049100180620          dou SqlCod <> *Zero;
049200180620             Exec Sql
049300180620                Fetch Next From C1 Into :Sqldate;
049400180420
049500180620             if SqlCod <> *zero;
049600180620                Leave;
049700180620             endif;
049800180420
049900180620             count = count + 1;
050000180420
050100180620             if Count = 1;
050200180620                CurrDate = SqlDate;
050300180620             EndIf;
050400180420
050500180620             if count = 2;
050600180620                PrevDate = SqlDate;
050700180620             EndIf;
050800180420
050900180420
051000180620          enddo;
051100180620          Exec Sql Close C1;
051200180420
051300180420
051400180420
051500180420
051600180620          //-----------------------------------
051700180620          //
051800180620          // Get any missing ( Termed ) plans
051900180620          //     using the SQL EXCEPT statement
052000180620          //
052100180620          //-----------------------------------
052200180620          SqlStmt =
052300180620             ' SELECT  EDTRST, EDSUB#, EDACCT, EDSSN, EDPLAN ' +
052400180620             '         EDPLNCAT, EDPAYFRQ, EDPLNCODE ' +
052500180620             ' FROM empdedp WHERE EDRUNDATE = ' + %Char( PrevDate ) +
052600180620             ' EXCEPT ' +
052700180620             ' SELECT EDTRST, EDSUB#, EDACCT, EDSSN, EDPLAN ' +
052800180620             '         EDPLNCAT, EDPAYFRQ, EDPLNCODE ' +
052900180620             ' FROM empdedp WHERE EDRUNDATE = ' + %Char( CurrDate ) ;
053000180420
053100180420
053200180620          Exec Sql
053300180620             Declare C2 Cursor For Sqlstmt2;
053400180620          Exec Sql
053500180620             Prepare Sqlstmt2 From :Sqlstmt;
053600180620          Exec Sql
053700180620             Open C2;
053800180420
053900180620          dou SqlCod <> *Zero;
054000180620             Exec Sql
054100180620                Fetch Next From C2 Into :Sq_Data;
054200180420
054300180620             if SqlCod <> *zero;
054400180620                leave;
054500180620             endif;
054600180420
054700180423
054800180620             Edrundate = %dec(%date);
054900180620             Edtrst = sqtrst;
055000180620             Edsub# = sqsub#;
055100180620             Edacct = sqAcct;
055200180620             Edssn = sqssn ;
055300180620             Edplan = sqPlan;
055400180620             Edplncat = sqPlncat;
055500180620             Edpayfrq = sqPayFrq;
055600180620             Edempded = 0;
055700180620             Edemrded = 0;
055800180423
055900180620             Write R_Empdedp;
056000180423
056100180423
056200180420
056300180620          enddo;
056400180620          Exec Sql
056500180620             Close C2;
056600180420
056700180420
056800180420
056900180420
057000180420
057100180420
057200180620       End-Proc;
057300180420
057400180420
057500180420
057600180420
057700180420
057800180418
057900180620      *----------------------------------------------------------------------
058000180418      *
058100180418      * Check Webpayroll
058200180418      *
058300180620      *----------------------------------------------------------------------
058400180620       dcl-proc Chk_Webpayroll;
058500180418
058600180418
058700180620          //-----------------------------------------------
058800180620          //
058900180620          // Get the Rule & Pay Frequency from WebPayroll
059000180620          //
059100180620          //-----------------------------------------------
059200180620          hasError = 'N';
059300180620          Rule = '';
059400180620          clear webpfq;
059500180418
059600180620          chain ( pTrst : pSub : pAcct : mbssno ) webPayroll;
059700180418
059800180620          if %Found( webPayroll ) ;
059900180620             Rule = pybpc;
060000180620             webpfq = #getfac( pyPfq ) ;
060100180620          endif;
060200180418
060300180418
060400180620          If not %Found( WebPayroll );
060500180620             hasError = 'Y';
060600180418
060700180620             eeRundate = %Dec(%Date);
060800180620             eeTrst = pTrst;
060900180620             eeSub# = pSub ;
061000180620             eeAcct = pAcct;
061100180620             eessn  = mbssno;
061200180418
061300180620             eeError = 'Member not found in WebPayoll.  Unable to +
061400180620                calculate deductions.';
061500180418
061600180418
061700180620             chain ( pTrst : pSub : pAcct :mbssno : eeRunDate ) empDedErr;
061800180418
061900180620             if not %Found( empDedErr ) ;
062000180620                write r_EmpError;
062100180620                errorCount = ErrorCount + 1;
062200180620             endif;
062300180418
062400180620             return;
062500180418
062600180620          EndIf;
062700180418
062800180620       End-Proc;
062900180418
063000180418
063100180418
063200180423
063300180423
063400180620      *----------------------------------------------------------------------
063500180418      *
063600180418      * Get Coverage Code
063700180418      *
063800180620      *----------------------------------------------------------------------
063900180620       dcl-proc get_Covg export;
064000180418
064100180620          dcl-pi *n Char(20);
064200180620             iCode Char(3) value;
064300180620          End-Pi;
064400180418
064500180620          dcl-s ReturnText Char(20);
064600180418
064700180620          ReturnText = '';
064800180418
064900180620          select;
065000180620          when iCode = 'TIN';
065100180620             ReturnText = 'INDIVIDUAL';
065200180620          When iCode = 'THW';
065300180620             ReturnText = 'HUSBAND/WIFE';
065400180620          When iCode = 'TPC';
065500180620             ReturnText = 'PARENT/CHILD';
065600180620          When iCode = 'TP2';
065700180620             ReturnText = 'PARENT/CHILDREN';
065800180620          When iCode = 'TFA';
065900180620             ReturnText = 'FAMILY';
066000180620          When iCode = 'TED';
066100180620             ReturnText = 'EMP + 1 DEPENDENT';
066200180620          When iCode = 'THW';
066300180620             ReturnText = 'DOMESTIC PARTNER';
066400180620          When iCode = 'TED';
066500180620             ReturnText = 'DOMESTIC PARTNER';
066600180620          endsl;
066700180418
066800180620          Return ReturnText;
066900180418
067000180620       end-proc;
067100180423
067200180423
067300180620      *----------------------------------------------------------------------
067400180423      *
067500180423      * Calculate the Imputed Income Calculation
067600180423      *
067700180620      *----------------------------------------------------------------------
067800180620       Dcl-Proc GTL_Calc;
067900180423
068000180620          dcl-s Exclusion zoned( 7 ) inz( 50000 );
068100180620          dcl-s Age Zoned(3);
068200180620          dcl-s empCost Zoned( 5:2);
068300180620          dcl-s Adj_Amount zoned( 11 : 2 );
068400180620          dcl-s Birth date;
068500180423
068600180423
068700180620          Birth = %Date( pybth: *iso);
068800180620          Age = %Diff( %Date : Birth : *Y );
068900180423
069000180620          // Calculate Employee Cost
069100180620          Select;
069200180620          When Age < 25;
069300180620             empCost = .05;
069400180620          When Age < 30;
069500180620             empCost = .06;
069600180620          When Age < 35;
069700180620             empCost = .08;
069800180620          When Age < 40;
069900180620             empCost = .09;
070000180620          When Age < 45;
070100180620             empCost = .10;
070200180620          When Age < 50;
070300180620             empCost = .15;
070400180620          When Age < 55;
070500180620             empCost = .23;
070600180620          When Age < 60;
070700180620             empCost = .43;
070800180620          When Age < 65;
070900180620             empCost = .66;
071000180620          When Age < 70;
071100180620             empCost = 1.27;
071200180620          Other;
071300180620             empCost = 2.06;
071400180620          EndSl;
071500180423
071600180620          // Life Insurance Coverage Subject to imputed income
071700180620          Adj_Amount = LI_Amount - Exclusion;
071800180423
071900180620          // Divide by 1000
072000180620          Adj_Amount = Adj_Amount /  1000;
072100180423
072200180423
072300180620          // Multiple by Emp Cost ( IRS Table Rate )
072400180620          Adj_Amount = Adj_Amount * empCost;
072500180423
072600180423
072700180620          // Multiple by Covered Months ( 12 )
072800180620          Adj_Amount = Adj_Amount * 12;
072900180423
073000180423
073100180620          // Adj_Amount is the Total Cost of Life Insurance.
073200180620          Cost_PP = Adj_Amount / wpfrq;
073300180620          Cost_Month = Adj_Amount / 12 ;
073400180423
073500180423
073600180423
073700180620       End-Proc;
073800180423
073900180423
074000180423      *----------------------------------------------------------------
074100180423      *
074200180423      * Clean Number Function
074300180423      *
074400180423      *----------------------------------------------------------------
074500180423
074600180620       Dcl-Proc ClnNbr export;
074700180423
074800180620          Dcl-pi *n Char(100);
074900180620             inString  Char(100) value;
075000180620          end-pi;
075100180423
075200180620          dcl-s i Zoned(3);
075300180620          dcl-c digits '0123456789';
075400180620          dcl-s TestChar Char(1) ;
075500180620          dcl-s StringOut Char(100);
075600180423
075700180423
075800180620          for i = 1 to %Len(%Trim(inString));
075900180620             testChar = %SubSt(inString : i : 1);
076000180620             if %Check(Digits : testChar) = 0;
076100180620                StringOut = %Trim(StringOut) + testChar;
076200180620             endif;
076300180620          endfor;
076400180423
076500180620          Return StringOut;
076600180423
076700180620       end-Proc;
076800180423
