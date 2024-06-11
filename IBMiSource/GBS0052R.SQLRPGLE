000100181219       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200181217
000300181217      *-------------------------------------------------------------------------
000400181217      *
000500181219      *  Description: Account Master Report Generator
000600181217      *  Programmer.: Brian Rees
000700181217      *  Date.......: 12/17/2018
000800181217      *
000900181219      *  This will build a grid dynamically. This was requested for the EDT
001000181219      *  Block of business.
001100181219      *
001200181217      *-------------------------------------------------------------------------
001300181217
001400190312
001500190312      *-------------------------------------------------------------------------
001600190312      *
001700190312      * Change Log
001800190312      *
001900190312      * 03/12/2019  B.Rees   Added F.AC2MST to Selections
002000190312      *   Change Id: Br01
002100190312      *
002200190312      *
002300190312      *
002400190312      *-------------------------------------------------------------------------
002500190312
002600190312
002700190312
002800190312
002900181217      *-------------------------------------------------------------------------
003000181217      *
003100181217      * Declare Files
003200181217      *
003300181217      *-------------------------------------------------------------------------
003400181217       Dcl-f gbs0052d WorkStn
003500181217         Handler('PROFOUNDUI(HANDLER)');
003600181217
003700181219       dcl-f gbs0052p keyed usage( *input : *update : *output );
003800181217
003900181217
004000181217
004100181217      *-------------------------------------------------------------------------
004200181217      *
004300181217      * Global Variables
004400181217      *
004500181217      *-------------------------------------------------------------------------
004600181217
004700181217       dcl-ds pgmd
004800181217         ExtName('IOPGMD') PSDS;
004900190125         @pgmq *proc;
005000181217       end-ds;
005100181217
005200181217
005300181217
005400190312       dcl-s mySelection Char(1000);
005500190312       dcl-s myCriteria Char(1000);
005600181218       dcl-s mySort Char(500);
005700181218
005800181218       dcl-c q '''';
005900181218       dcl-s hasError ind;
006000190125       dcl-s DataChanged Char(1);
006100181218
006200181218
006300181217
006400181217
006500181219      *-------------------------------------------------------------------------
006600181219      *
006700181219      * *Entry Procedure
006800181219      *
006900181219      *-------------------------------------------------------------------------
007000181219       Dcl-pr Main ExtPgm;
007100181220         *N  Char(10);
007200181220         *N  zoned(5);
007300181219       End-Pr;
007400181219
007500181219       dcl-pi Main;
007600181220         pUserName Char(10);
007700181220         pSeq Zoned(5);
007800181219       End-Pi;
007900181217
008000181219
008100181219
008200181217      *-------------------------------------------------------------------------
008300181217      *
008400181217      * Mainline Program
008500181217      *
008600181217      *-------------------------------------------------------------------------
008700181217
008800181220       if pSeq > 0;
008900181220         Load_Data();
009000181220       EndIf;
009100181219
009200181217
009300181217       dou btnExit = *on;
009400181217
009500181217
009600181217         Exfmt Screen1;
009700181218
009800190125
009900190125         //----------------------------------------------------
010000190125         //
010100190125         //   If the user presses the Exit button. Check to
010200190125         //   See if they have saved the query.
010300190125         //
010400190125         //----------------------------------------------------
010500190125
010600190125         if btnExit = *on;
010700190125
010800190125
010900190125           if DataChanged = 'Y' or dta_Chgd = *on;
011000190125             exfmt Warning;
011100190125
011200190125             if btnNo = *on;
011300190125               leave;
011400190125             EndIf;
011500190125
011600190125             if btnYes = *on;
011700190125               if S1QryName = '';
011800190125                 exfmt NewName;
011900190125                 if btnSave = *on;
012000190125                   Add_Record();
012100190125                   leave;
012200190125                 EndIf;
012300190125
012400190125                 if btnBack = *on;
012500190125                   btnExit = *off;
012600190125                   iter;
012700190125                 EndIf;
012800190125
012900190125                else;
013000190125                   Add_Record();
013100190125                   leave;
013200190125
013300190125               EndIf;
013400190125
013500190125             EndIf;
013600190125
013700190125           else;
013800190125             leave;
013900190125
014000190125           EndIf;
014100190125
014200190125
014300190125
014400190125         EndIf;
014500190125
014600190125
014700181219
014800181219         if btnSave = *on;
014900181220           Add_Record();
015000190125           DataChanged = 'N';
015100181219         EndIf;
015200181219
015300181218
015400181218         Verify();
015500181218         if hasError = *on;
015600181218           ActiveTab = 0;
015700181218           iter;
015800181218         EndIf;
015900181217
016000181218
016100181218
016200181217         if btnAccept = *on;
016300190125
016400190125           if chg_834 = *on or dta_Chgd = *on;
016500190125             DataChanged = 'Y';
016600190125           EndIf;
016700190125
016800181217           Process_Sql();
016900181219           Exfmt Screen2;
017000181220
017100181220           if pSeq > 0;
017200181220
017300181220             // Update Record
017400181220             amRunBy = wqusrn;
017500181220             amRunDt = %Dec(%Date);
017600181220             amRunTm = %Dec(%Time);
017700181220
017800181220             Update r_gbs0052;
017900181220
018000181220
018100181220             // Now Save the data incase the user presses SAVE again.
018200181220             chain ( pUserName : pSeq ) GBS0052P;
018300181220           endif;
018400181220
018500181220
018600190125           btnExit = *off;
018700181219
018800181217         EndIf;
018900181218
019000181218
019100181218         if btnSQL = *on;
019200190125
019300190125           if chg_834 = *on or dta_Chgd = *on;
019400190125             DataChanged = 'Y';
019500190125           EndIf;
019600190125
019700181218           Process_Sql();
019800181218         EndIf;
019900181217
020000181218
020100181218
020200181217       EndDo;
020300181217
020400181217
020500181219       unlock gbs0052p;
020600181219
020700181217       *inlr = *on;
020800181217
020900181217
021000181217
021100181217       // ----------------------------------------------------------------
021200181217       dcl-proc Process_Sql;
021300181217
021400181218         mySelection = '';
021500181218         myCriteria= '';
021600181221         Sql_header = '';
021700181221
021800181218         mySort = '';
021900181219         sql_Col# = 0;
022000181219
022100181217
022200181218         Check_Selection();
022300181219
022400181218         SqlStmt = 'Select ' + %Trim( mySelection );
022500181218         SqlStmt =  %Trim( SqlStmt ) + ' From "F.ACCMST" ';
022600190312         SqlStmt =  %Trim( SqlStmt ) + ' Join "F.AC2MST" on a2Trst = acTrst ';
022700190312         SqlStmt =  %Trim( SqlStmt ) + ' and  a2Sub#  = acSub# ';
022800190312         SqlStmt =  %Trim( SqlStmt ) + ' and a2Acct = acAcct ';
022900181218
023000181218
023100181218         Build_Crit();
023200181218         SqlStmt =  %Trim( SqlStmt ) +  ' ' + %Trim( myCriteria );
023300181218
023400181218         Build_Sort();
023500181218         SqlStmt =  %Trim( SqlStmt ) +  ' ' + %Trim( mySort );
023600181218
023700181217
023800181217       end-proc;
023900180917
024000181217
024100181217
024200181217       // ----------------------------------------------------------------
024300181217       dcl-proc Check_Selection;
024400181217
024500181219         dcl-s i Zoned(2);
024600181217
024700181217         if FAACODE = '' and
024800181217           FACCT     = '' and
024900181217           FACDLTD   = '' and
025000181217           FACOBSRV  = '' and
025100181217           FACTNAM1  = '' and
025200181217           FACTNAM2  = '' and
025300181217           FACVTDT   = '' and
025400181217           FADDR1    = '' and
025500181217           FADDR2    = '' and
025600181217           FAPREMI   = '' and
025700181217           FASPHFL   = '' and
025800181217           FATRMDT   = '' and
025900181217           FCAFIC    = '' and
026000181217           FCFS834   = '' and
026100181217           FCFSEDT   = '' and
026200181217           FCITY     = '' and
026300181217           FCOBADM   = '' and
026400181217           FCONTAC   = '' and
026500181217           FECNTAC     = '' and
026600181217           FENROLL     = '' and
026700181217           FFAX#       = '' and
026800181217           FFCSTFL     = '' and
026900181217           FGBSBDT     = '' and
027000181217           FLIFPCT     = '' and
027100181217           FLINV#      = '' and
027200181217           FLINVDT     = '' and
027300181217           FLTDPCT     = '' and
027400181217           FLUPDDT     = '' and
027500181217           FMEDEMP     = '' and
027600181217           FNOEMPL     = '' and
027700181217           FOLDT06     = '' and
027800181217           FPHONE      = '' and
027900181217           FRNEWPD     = '' and
028000181217           FRNSTCD     = '' and
028100181217           FSICCOD     = '' and
028200181217           FSMANCD       = '' and
028300181217           FSTATE        = '' and
028400181217           FSTDPCT       = '' and
028500181217           FSUB          = '' and
028600181217           FSVOWFL       = '' and
028700181217           FTOTEMP       = '' and
028800181217           FTRUST        = '' and
028900190312           FZIP       = ''   and
029000190312br01       FA2TAX    = '' and
029100190312 |         FA2ADDR1  = '' and
029200190312 |         FA2ADDR2  = '' and
029300190312 |         FA2CITY   = '' and
029400190312 |         FA2STATE  = '' and
029500190312 |         FA2ZIP5   = '' and
029600190312 |         FA2CONTRY  = '' and
029700190312 |         FA2EML1   = '' and
029800190312 |         FA2EML2   = '' and
029900190312br01       FAUSECC  = '';
030000190312
030100190312
030200190312
030300190312
030400181219           mySelection = ',acTrst,acSub#,acAcct,acNam1,acNam2,aaddr1' +
030500181217             ',aaddr2,acity,astate,azip' +
030600181217             ',Cast(aarea as char(3)) || cast(aphone as char(7)) as Phone' +
030700190312             ',contac,fcstfl,noempl,gbsbdt,ltdpct,svowfl,cfsedt' +
030800190312             ',asphfl,acobsrv,apremi,linv#,totemp' +
030900181219             ',Cast(faxare as char(3)) || cast(fax# as char(7)) as Fax' +
031000190312             ',cobadm,cafic,ecntac,rnstcd,lifpct,siccod,medemp'+
031100190312             ',stdpct,aacode,smancd,rnewpd,cfs834,oldt06,acdltd' +
031200190312             ',acvtdt,linvdt,atrmdt,enroll,lupddt' ;
031300181219
031400190312
031500190312br01       mySelection = %Trim( mySelection ) +
031600190312             ',a2tax_id#,a2address1,a2address2,a2city,a2state' +
031700190312             ', Case When a2zip4 > 0 then ' +
031800190312             '  Cast(a2Zip5 as char(5)) ||'  + q + '-' + q + ' || ' +
031900190312             ' Cast(a2Zip4 as char(4))  else  Cast(a2Zip5 as char(5)) end ' +
032000190312             ',a2countycd,a2email1,a2email2,a2usecc';
032100190312
032200181219
032300190312           sql_Col# = 53;
032400181217
032500181219
032600181219           Sql_header =
032700181219             ',Trust' +
032800181219             ',Subdivision' +
032900181219             ',Account' +
033000181219             ',Account Name 1' +
033100181219             ',Account Name 2' +
033200181219             ',Address 1' +
033300181219             ',Address 2' +
033400181219             ',City' +
033500181219             ',State' +
033600181219             ',Zip Code' +
033700181219             ',Phone Number' +
033800181219             ',Contact Person' +
033900181219             ',Cobra Federal State Flag' +
034000181219             ',Number Of Employees' +
034100181219             ',Gbs Begin Admin Date' +
034200181219             ',Ltd Contribution %' +
034300181219             ',See Volume On Web Flag' +
034400181219             ',Cfs  Entity Date' +
034500181219             ',Special Handling Flag' +
034600181219             ',Cobra Service' +
034700181219             ',Premium As Of Inv' +
034800181219             ',Last Invoice#' +
034900181219             ',Total Employees' +
035000181219             ',Fax #' +
035100181219             ',Cobra Admin Fee' +
035200181219             ',Invoice Print' +
035300181219             ',Executive Contact' +
035400181219             ',Reinstatement Occurred' +
035500181219             ',Life Contribution Percent' +
035600181219             ',S.i.c. Code' +
035700181219             ',# Employees With Medical' +
035800181219             ',Std Contribution %' +
035900181219             ',Account Administrator Code' +
036000181219             ',Salesman Code' +
036100181219             ',Renewal Period In Months' +
036200181219             ',Cfs 834' +
036300181219             ',Admin Fee Code' +
036400181219             ',Delete Code' +
036500181219             ',Invoiced Through Date' +
036600181219             ',Last Invoice Date' +
036700181219             ',Termination Date' +
036800181219             ',Original Enrollment Date' +
036900190312             ',Last Update Date'  +
037000190312br01         ',Tax ID #'  +
037100190312             ',Physical Address Line 1'  +
037200190312             ',Physical Address Line 2'  +
037300190312             ',Physical City'  +
037400190312             ',Physical State'  +
037500190312             ',Physical Zip'  +
037600190312             ',County'  +
037700190312             ',Contact Person Email Address'  +
037800190312             ',Executive Contact Email Address'  +
037900190312             ',Cost Centers'  ;
038000190312
038100181217         EndIf;
038200181217
038300181217
038400181217         // Build Selection
038500181217         if FTRUST        = 'Y';
038600181218           mySelection = %Trim( mySelection ) + ',acTrst';
038700181219           sql_Col# = Sql_Col# + 1;
038800181219           Sql_header = %Trim( Sql_Header ) +  ',Trust';
038900181217         EndIf;
039000181217
039100181217
039200181217         if FSUB          = 'Y';
039300181218           mySelection = %Trim( mySelection ) + ',acSub#';
039400181219           sql_Col# = Sql_Col# + 1;
039500181219           Sql_header = %Trim( Sql_Header ) +  ',Subdivision';
039600181217         EndIf;
039700181217
039800181217
039900181217         if FACCT = 'Y';
040000181217           mySelection = %Trim( mySelection ) + ',acAcCT';
040100181219           sql_Col# = Sql_Col# + 1;
040200181219           Sql_header = %Trim( Sql_Header ) +  ',Account';
040300181217         EndIf;
040400181217
040500181217
040600181217         if FACTNAM1 = 'Y';
040700181217           mySelection = %Trim( mySelection ) + ',acnam1';
040800181219           sql_Col# = Sql_Col# + 1;
040900181219           Sql_header = %Trim( Sql_Header ) +  ',Account Name 1';
041000181217         EndIf;
041100181217
041200181217         if FACTNAM2 = 'Y';
041300181217           mySelection = %Trim( mySelection ) + ',acnam2';
041400181219           sql_Col# = Sql_Col# + 1;
041500181219           Sql_header = %Trim( Sql_Header ) +  ',Account Name 2';
041600181217         EndIf;
041700181217
041800181217
041900181217         if FADDR1    = 'Y';
042000181219           mySelection = %Trim( mySelection ) + ',aaddr1';
042100181219           sql_Col# = Sql_Col# + 1;
042200181219           Sql_header = %Trim( Sql_Header ) +  ',Address 1';
042300181217         EndIf;
042400181217
042500181217         if FADDR2    = 'Y';
042600181219           mySelection = %Trim( mySelection ) + ',aaddr2';
042700181219           sql_Col# = Sql_Col# + 1;
042800181219           Sql_header = %Trim( Sql_Header ) +  ',Address 2';
042900181217         EndIf;
043000181217
043100181217
043200181217         if FCITY     = 'Y';
043300181217           mySelection = %Trim( mySelection ) + ',acity';
043400181219           sql_Col# = Sql_Col# + 1;
043500181219           Sql_header = %Trim( Sql_Header ) +  ',City';
043600181217         EndIf;
043700181217
043800181217         if FSTATE        = 'Y';
043900181217           mySelection = %Trim( mySelection ) + ',astate';
044000181219           sql_Col# = Sql_Col# + 1;
044100181219           Sql_header = %Trim( Sql_Header ) +  ',State';
044200181217         EndIf;
044300181217
044400181217
044500181217         if FZIP     =   'Y';
044600181217           mySelection = %Trim( mySelection ) + ',azip';
044700181219           sql_Col# = Sql_Col# + 1;
044800181219           Sql_header = %Trim( Sql_Header ) +  ',Zip Code';
044900181217         EndIf;
045000181217
045100181217
045200181217         if FPHONE      = 'Y';
045300181221           mySelection = %Trim( mySelection ) +
045400181221             ',Cast(aarea as char(3)) || cast(aphone as char(7)) as Phone';
045500181219           sql_Col# = Sql_Col# + 1;
045600181219           Sql_header = %Trim( Sql_Header ) +  ',Phone Number';
045700181217         EndIf;
045800181217
045900181217         if FCONTAC   = 'Y';
046000181217           mySelection = %Trim( mySelection ) + ',contac';
046100181219           sql_Col# = Sql_Col# + 1;
046200181219           Sql_header = %Trim( Sql_Header ) +  ',Contact Person';
046300181217         EndIf;
046400181217
046500181217
046600181217         if FFCSTFL     = 'Y';
046700181217           mySelection = %Trim( mySelection ) + ',fcstfl';
046800181219           sql_Col# = Sql_Col# + 1;
046900181219           Sql_header = %Trim( Sql_Header ) +  ',Cobra Federal State Flag';
047000181217         EndIf;
047100181217
047200181217
047300181217         if FNOEMPL     = 'Y';
047400181217           mySelection = %Trim( mySelection ) + ',noempl';
047500181219           sql_Col# = Sql_Col# + 1;
047600181219           Sql_header = %Trim( Sql_Header ) +  ',Number Of Employees';
047700181217         EndIf;
047800181217
047900181217
048000181217         if FGBSBDT     = 'Y';
048100181217           mySelection = %Trim( mySelection ) + ',gbsbdt';
048200181219           sql_Col# = Sql_Col# + 1;
048300181219           Sql_header = %Trim( Sql_Header ) +  ',Gbs Begin Admin Date';
048400181217         EndIf;
048500181217
048600181217
048700181217         if FLTDPCT     = 'Y';
048800181217           mySelection = %Trim( mySelection ) + ',ltdpct';
048900181219           sql_Col# = Sql_Col# + 1;
049000181219           Sql_header = %Trim( Sql_Header ) +  ',Ltd Contribution %';
049100181217         EndIf;
049200181217
049300181217         if FSVOWFL       = 'Y';
049400181217           mySelection = %Trim( mySelection ) + ',svowfl';
049500181219           sql_Col# = Sql_Col# + 1;
049600181219           Sql_header = %Trim( Sql_Header ) +  ',See Volume On Web Flag';
049700181217         EndIf;
049800181217
049900181217
050000181217         if FCFSEDT   = 'Y';
050100181217           mySelection = %Trim( mySelection ) + ',cfsedt';
050200181219           sql_Col# = Sql_Col# + 1;
050300181219           Sql_header = %Trim( Sql_Header ) +  ',Cfs  Entity Date';
050400181217         EndIf;
050500181217
050600181217         if FASPHFL   = 'Y';
050700181217           mySelection = %Trim( mySelection ) + ',asphfl';
050800181219           sql_Col# = Sql_Col# + 1;
050900181219           Sql_header = %Trim( Sql_Header ) +  ',Special Handling Flag';
051000181217         EndIf;
051100181217
051200181217         if FACOBSRV = 'Y';
051300181217           mySelection = %Trim( mySelection ) + ',acobsrv';
051400181219           sql_Col# = Sql_Col# + 1;
051500181219           Sql_header = %Trim( Sql_Header ) +  ',Cobra Service';
051600181217         EndIf;
051700181217
051800181217         if FAPREMI   = 'Y';
051900181217           mySelection = %Trim( mySelection ) + ',apremi';
052000181219           sql_Col# = Sql_Col# + 1;
052100181219           Sql_header = %Trim( Sql_Header ) +  ',Premium As Of Inv';
052200181217         EndIf;
052300181217
052400181217
052500181217
052600181217         if FLINV#      = 'Y';
052700181217           mySelection = %Trim( mySelection ) + ',linv#';
052800181219           sql_Col# = Sql_Col# + 1;
052900181219           Sql_header = %Trim( Sql_Header ) +  ',Last Invoice #';
053000181217         EndIf;
053100181217
053200181217
053300181217         if FTOTEMP       = 'Y';
053400181217           mySelection = %Trim( mySelection ) + ',Totemp';
053500181219           sql_Col# = Sql_Col# + 1;
053600181219           Sql_header = %Trim( Sql_Header ) +  ',Total Employees';
053700181217         EndIf;
053800181217
053900181217         if FFAX#       = 'Y';
054000181217           mySelection = %Trim( mySelection ) +
054100181219             ',Cast(faxare as char(3)) || cast(fax# as char(7)) as Fax' ;
054200181219           sql_Col# = Sql_Col# + 1;
054300181219           Sql_header = %Trim( Sql_Header ) +  ',Fax #';
054400181217         EndIf;
054500181217
054600181217         if FCOBADM   = 'Y';
054700181217           mySelection = %Trim( mySelection ) + ',cobadm';
054800181219           sql_Col# = Sql_Col# + 1;
054900181219           Sql_header = %Trim( Sql_Header ) +  ',Cobra Admin Fee';
055000181217         EndIf;
055100181217
055200181217         if FCAFIC    = 'Y';
055300181217           mySelection = %Trim( mySelection ) + ',cafic';
055400181219           sql_Col# = Sql_Col# + 1;
055500181219           Sql_header = %Trim( Sql_Header ) +  ',Invoice Print';
055600181217         EndIf;
055700181217
055800181217
055900181217         if FECNTAC     = 'Y';
056000181217           mySelection = %Trim( mySelection ) + ',ecntac';
056100181219           sql_Col# = Sql_Col# + 1;
056200181219           Sql_header = %Trim( Sql_Header ) +  ',Executive Contact';
056300181217         EndIf;
056400181217
056500181217
056600181217         if FRNSTCD     = 'Y';
056700181217           mySelection = %Trim( mySelection ) + ',rnstcd';
056800181219           sql_Col# = Sql_Col# + 1;
056900181219           Sql_header = %Trim( Sql_Header ) +  ',Reinstatement Occurred';
057000181217         EndIf;
057100181217
057200181217
057300181217         if FLIFPCT     = 'Y';
057400181217           mySelection = %Trim( mySelection ) + ',lifpct';
057500181219           sql_Col# = Sql_Col# + 1;
057600181219           Sql_header = %Trim( Sql_Header ) +  ',Life Contribution Percent';
057700181217         EndIf;
057800181217
057900181217
058000181217         if FSICCOD     = 'Y';
058100181217           mySelection = %Trim( mySelection ) + ',siccod';
058200181219           sql_Col# = Sql_Col# + 1;
058300181219           Sql_header = %Trim( Sql_Header ) +  ',S.i.c. Code';
058400181217         EndIf;
058500181217
058600181217         if FMEDEMP     = 'Y';
058700181217           mySelection = %Trim( mySelection ) + ',MedEmp';
058800181219           sql_Col# = Sql_Col# + 1;
058900181219           Sql_header = %Trim( Sql_Header ) +  ',# Employees With Medical';
059000181217         EndIf;
059100181217
059200181217
059300181217
059400181217         if FSTDPCT       = 'Y';
059500181217           mySelection = %Trim( mySelection ) + ',stdpct';
059600181219           sql_Col# = Sql_Col# + 1;
059700181219           Sql_header = %Trim( Sql_Header ) +  ',Std Contribution %';
059800181217         EndIf;
059900181217
060000181217         if FAACODE = 'Y';
060100181217           mySelection = %Trim( mySelection ) + ',aaCode';
060200181219           sql_Col# = Sql_Col# + 1;
060300181219           Sql_header = %Trim( Sql_Header ) +  ',Account Administrator Code';
060400181217         EndIf;
060500181217
060600181217         if FSMANCD       = 'Y';
060700181217           mySelection = %Trim( mySelection ) + ',smancd';
060800181219           sql_Col# = Sql_Col# + 1;
060900181219           Sql_header = %Trim( Sql_Header ) +  ',Salesman Code';
061000181217         EndIf;
061100181217
061200181217
061300181217         if FRNEWPD     = 'Y';
061400181217           mySelection = %Trim( mySelection ) + ',rnewpd';
061500181219           sql_Col# = Sql_Col# + 1;
061600181219           Sql_header = %Trim( Sql_Header ) +  ',Renewal Period In Months';
061700181217         EndIf;
061800181217
061900181217         if FCFS834   = 'Y';
062000181217           mySelection = %Trim( mySelection ) + ',cfs834';
062100181219           sql_Col# = Sql_Col# + 1;
062200181219           Sql_header = %Trim( Sql_Header ) +  ',Cfs 834';
062300181217         EndIf;
062400181217
062500181217         if FOLDT06     = 'Y';
062600181217           mySelection = %Trim( mySelection ) + ',oldt06';
062700181219           sql_Col# = Sql_Col# + 1;
062800181219           Sql_header = %Trim( Sql_Header ) +  ',Admin Fee Code';
062900181217         EndIf;
063000181217
063100181217
063200181217         if FACDLTD = 'Y';
063300181217           mySelection = %Trim( mySelection ) + ',acdltd';
063400181219           sql_Col# = Sql_Col# + 1;
063500181219           Sql_header = %Trim( Sql_Header ) +  ',Delete Code';
063600181217         EndIf;
063700181217
063800181217
063900181217         if FACVTDT = 'Y';
064000181217           mySelection = %Trim( mySelection ) + ',acvtdt';
064100181219           sql_Col# = Sql_Col# + 1;
064200181219           Sql_header = %Trim( Sql_Header ) +  ',Invoiced Through Date';
064300181217         EndIf;
064400181217
064500181217
064600181217         if FLINVDT     = 'Y';
064700181217           mySelection = %Trim( mySelection ) + ',Linvdt';
064800181219           sql_Col# = Sql_Col# + 1;
064900181219           Sql_header = %Trim( Sql_Header ) +  ',Last Invoice Date';
065000181217         EndIf;
065100181217
065200181217
065300181217         if FATRMDT   = 'Y';
065400181217           mySelection = %Trim( mySelection ) + ',atrmdt';
065500181219           sql_Col# = Sql_Col# + 1;
065600181219           Sql_header = %Trim( Sql_Header ) +  ',Termination Date';
065700181217         EndIf;
065800181217
065900181217
066000181217         if FENROLL     = 'Y';
066100181217           mySelection = %Trim( mySelection ) + ',enroll';
066200181219           sql_Col# = Sql_Col# + 1;
066300181219           Sql_header = %Trim( Sql_Header ) +  ',Original Enrollment Date';
066400181217         EndIf;
066500181217
066600181217
066700181217
066800181217         if FLUPDDT     = 'Y';
066900181217           mySelection = %Trim( mySelection ) + ',lupddt';
067000181219           sql_Col# = Sql_Col# + 1;
067100181219           Sql_header = %Trim( Sql_Header ) +  ',Last Update Date';
067200181217         EndIf;
067300181217
067400181217
067500190312br01     if fa2tax     = 'Y';
067600190312           mySelection = %Trim( mySelection ) + ',a2tax_id#';
067700190312           sql_Col# = Sql_Col# + 1;
067800190312           Sql_header = %Trim( Sql_Header ) +  ',Tax ID #';
067900190312         EndIf;
068000190312
068100190312
068200190312br01     if fa2addr1     = 'Y';
068300190312           mySelection = %Trim( mySelection ) + ',a2Address1';
068400190312           sql_Col# = Sql_Col# + 1;
068500190312           Sql_header = %Trim( Sql_Header ) +  ',Physical Address Line 1';
068600190312         EndIf;
068700190312
068800190312br01     if fa2addr2     = 'Y';
068900190312           mySelection = %Trim( mySelection ) + ',a2Address2';
069000190312           sql_Col# = Sql_Col# + 1;
069100190312           Sql_header = %Trim( Sql_Header ) +  ',Physical Address Line 2';
069200190312         EndIf;
069300190312
069400190312br01     if fa2City     = 'Y';
069500190312           mySelection = %Trim( mySelection ) + ',a2City';
069600190312           sql_Col# = Sql_Col# + 1;
069700190312           Sql_header = %Trim( Sql_Header ) +  ',Physical City';
069800190312         EndIf;
069900190312
070000190312br01     if fa2State     = 'Y';
070100190312           mySelection = %Trim( mySelection ) + ',a2State';
070200190312           sql_Col# = Sql_Col# + 1;
070300190312           Sql_header = %Trim( Sql_Header ) +  ',Physical State';
070400190312         EndIf;
070500190312
070600190312br01     if fa2Zip5   = 'Y';
070700190312           mySelection = %Trim( mySelection ) +
070800190312             ', Case When a2zip4 > 0 then ' +
070900190312             '  Cast(a2Zip5 as char(5)) ||'  + q + '-' + q + ' || ' +
071000190312             '  Cast(a2Zip4 as char(4))  else  Cast(a2Zip5 as char(5)) end ';
071100190312           sql_Col# = Sql_Col# + 1;
071200190312           Sql_header = %Trim( Sql_Header ) +  ',Physical Zip';
071300190312         EndIf;
071400190312
071500190312
071600190312br01     if fa2Contry    = 'Y';
071700190312           mySelection = %Trim( mySelection ) + ',a2countycd';
071800190312           sql_Col# = Sql_Col# + 1;
071900190312           Sql_header = %Trim( Sql_Header ) +  ',County';
072000190312         EndIf;
072100190312
072200190312br01     if fa2eml1  = 'Y';
072300190312           mySelection = %Trim( mySelection ) + ',a2email1';
072400190312           sql_Col# = Sql_Col# + 1;
072500190312           Sql_header = %Trim( Sql_Header ) +  ',Contact Person Email Address';
072600190312         EndIf;
072700190312
072800190312br01     if fa2eml2     = 'Y';
072900190312           mySelection = %Trim( mySelection ) + ',a2email2';
073000190312           sql_Col# = Sql_Col# + 1;
073100190312         Sql_header = %Trim( Sql_Header ) +  ',Executive Contact Email Address';
073200190312         EndIf;
073300190312
073400190312br01     if faUSECC    = 'Y';
073500190312           mySelection = %Trim( mySelection ) + ',a2usecc';
073600190312           sql_Col# = Sql_Col# + 1;
073700190312           Sql_header = %Trim( Sql_Header ) +  ',Cost Centers';
073800190312         EndIf;
073900190312
074000190312
074100190312
074200181217         //------------------------------
074300181217         //
074400181217         // Remove first comma
074500181217         //
074600181217         //------------------------------
074700181217         mySelection = %Subst( mySelection : 2 );
074800181219         sql_header = %Subst( sql_header : 2 );
074900181217
075000181219
075100181217       end-proc;
075200181217
075300181217
075400181218
075500181218       // ----------------------------------------------------------------
075600181218       dcl-proc Build_Crit;
075700181218
075800181218
075900181218
076000181218         dcl-s w_Zip Char(9);
076100181218         dcl-s wDate Char(8);
076200181218
076300181218
076400181218         // If All Blank - No Critia.
076500181218
076600181218         if cTrst = ''  and
076700181218           cSub = ''    and
076800181218           cAcct = ''   and
076900181218           cActNam = '' and
077000181218           cAddr = ''   and
077100181218           cCity = ''   and
077200181218           cZip = ''    and
077300181218           cPhone = ''  and
077400181218           cContac = '' and
077500181218           cGBSBDT = '' and
077600181218           ccfsedt = '' and
077700181218           casphfl = '' and
077800181218           cacobsrv = '' and
077900181218           cfax# = ''    and
078000181218           cEcntac = ''  and
078100181218           csmancd = ''  and
078200181218           cacdltd = ''  and
078300181218           cState = ''   and
078400181218           cfcstfl = ''  and
078500181218           ccafic = ''   and
078600181218           ccfs834 = '';
078700181218
078800181218
078900181218           Return;
079000181218
079100181218         else;
079200181218
079300181218
079400181218           if cTrst > '';
079500181218             myCriteria = %Trim( myCriteria ) + ' and acTrst = ' + cTrst;
079600181218           EndIf;
079700181218
079800181218
079900181218           if cSub > '';
080000181218             myCriteria = %Trim( myCriteria ) + ' and acSub# = ' + %Char(cSub);
080100181218           EndIf;
080200181218
080300181218           if cAcct > '';
080400181218             myCriteria = %Trim( myCriteria ) + ' and acAcct = ' + %Char(cAcct);
080500181218           EndIf;
080600181218
080700181218
080800181218           if cActNam > '';
080900181218             myCriteria = %Trim( myCriteria ) +
081000181218               ' and upper(acNam1) like ' + q + '%' + %trim(cActNam) + '%' + q ;
081100181218           EndIf;
081200181218
081300181218
081400181218           if cAddr > '';
081500181218             myCriteria = %Trim( myCriteria ) +
081600181218               ' and upper(aAddr1) like ' + q + '%' + %trim(cAddr) + '%' + q ;
081700181218           EndIf;
081800181218
081900181218
082000181218           if cCity  > '';
082100181218             myCriteria = %Trim( myCriteria ) +
082200181218               ' and upper(acity) = ' + q + %trim(cCity) + q ;
082300181218           EndIf;
082400181218
082500181218           if cState  > '';
082600181218             myCriteria = %Trim( myCriteria ) +
082700190125               ' and upper(astate) like ' + q + '%' + %trim(cState) + '%' + q;
082800181218           EndIf;
082900181218
083000181218
083100181218           if cZip  > '';
083200181218
083300181218             w_Zip = %Trim(cZip) + '0000';
083400181218
083500181218             myCriteria = %Trim( myCriteria ) +
083600181218               ' and aZip = '  + w_Zip ;
083700181218           EndIf;
083800181218
083900181218
084000181218           if cPhone  > '';
084100181218
084200181218             myCriteria = %Trim( myCriteria ) +
084300181218               ' and aArea = '  + %Subst( cPhone : 1 : 3 ) ;
084400181218
084500181218             myCriteria = %Trim( myCriteria ) +
084600181218               ' and aPhone = '  + %Subst( cPhone : 4 ) ;
084700181218           EndIf;
084800181218
084900181218
085000181218           if cContac  > '';
085100181218             myCriteria = %Trim( myCriteria ) +
085200190125               ' and upper(Contac) like ' + q + '%' + %trim(cContac) + '%' + q;
085300181218           EndIf;
085400181218
085500181218
085600181218           if cfcstfl  > '';
085700181218
085800181218             myCriteria = %Trim( myCriteria ) +
085900181218               ' and fcstfl = ' + q  + cfcstfl + q ;
086000181218           EndIf;
086100181218
086200181218
086300181218           if casphfl  > '';
086400181218
086500181218             myCriteria = %Trim( myCriteria ) +
086600181218               ' and asphfl = ' + q  + casphfl + q ;
086700181218           EndIf;
086800181218
086900181218
087000181218           if cacobsrv  > '';
087100181218
087200181218             myCriteria = %Trim( myCriteria ) +
087300181218               ' and aacobsrv = ' + q  + cacobsrv + q ;
087400181218           EndIf;
087500181218
087600181218
087700181218
087800181218           if cFax#  > '';
087900181218
088000181218             myCriteria = %Trim( myCriteria ) +
088100181218               ' and Faxare = '  + %Subst( cFax# : 1 : 3 ) ;
088200181218
088300181218             myCriteria = %Trim( myCriteria ) +
088400181218               ' and fax# = '  + %Subst( cFax# : 4 ) ;
088500181218           EndIf;
088600181218
088700181218
088800181218           if cCaFic  > '';
088900181218
089000181218             myCriteria = %Trim( myCriteria ) +
089100181218               ' and CaFic = ' + q  + cCaFic + q ;
089200181218           EndIf;
089300181218
089400181218
089500181218           if cecntac  > '';
089600181218             myCriteria = %Trim( myCriteria ) +
089700190125               ' and upper(ecntac) like ' + q + '%' + %trim(cecntac) + '%' + q;
089800181218           EndIf;
089900181218
090000181218
090100181218           if csmancd  > '';
090200181218             myCriteria = %Trim( myCriteria ) +
090300181218               ' and sMancd = ' + q  + csmancd + q ;
090400181218           EndIf;
090500181218
090600181218
090700181218           if cCFS834  > '';
090800181218             myCriteria = %Trim( myCriteria ) +
090900181218               ' and CFS834 = ' + q  + cCFS834 + q ;
091000181218           EndIf;
091100181218
091200181218           if cacdltd  > '';
091300181218             myCriteria = %Trim( myCriteria ) +
091400181218               ' and acdltd = ' + q  + cacdltd + q ;
091500181218           EndIf;
091600181218
091700181218
091800181218           // GBS Admin Date
091900181218           if cgbsbdt > '';
092000181218             wDate = %char(%date(cgbsbdt:*usa/):*iso0);
092100181218
092200181218             myCriteria = %Trim( myCriteria ) +
092300181218               ' and gbsbdt ' + %Trim( Oper1 ) + ' ' + wDate ;
092400181218
092500181218           EndIf;
092600181218
092700181218
092800181218
092900181218           // CFG Entity Date
093000181218           if ccfsedt > '';
093100181218             wDate = %char(%date(ccfsedt:*usa/):*iso0);
093200181218
093300181218             myCriteria = %Trim( myCriteria ) +
093400181218               ' and cfsedt ' + %Trim( Oper2 ) + ' ' + wDate ;
093500181218
093600181218           EndIf;
093700181218
093800181218
093900181218
094000181218           // Add "Where" Statement!
094100181218
094200181218           if myCriteria > '';
094300181218             myCriteria = ' Where ' + %Subst( myCriteria : 5) ;
094400181218           EndIf;
094500181218
094600181218
094700181218         EndIf;   // Criteria not Blank
094800181218
094900181218
095000181218
095100181218       End-Proc;
095200181218
095300181218
095400181218       // ----------------------------------------------------------------
095500181218
095600181218       dcl-proc Verify;
095700181218
095800181218
095900181218         hasError = *off;
096000181218         ErrOper1 = *off;
096100181218         ErrOper2 = *off;
096200181218         errDate1 = *off;
096300181218
096400181218
096500181218         if cGBSBDT > '' and Oper1 = '';
096600181218           hasError = *on;
096700181218           errOper1 = *on;
096800181218         EndIf;
096900181218
097000181218         if cCFSEDT > '' and Oper2 = '';
097100181218           hasError = *on;
097200181218           errOper2 = *on;
097300181218         EndIf;
097400181218
097500181218
097600181218         if cGBSBDT > '';
097700181218           Test(DE) *USA cGBSBDT;
097800181218           if %Error();
097900181218             hasError = *on;
098000181218             errDate1 = *on;
098100181218           EndIf;
098200181218         EndIf;
098300181218
098400181218         if cCFSEDT > '';
098500181218           Test(DE) *USA cCFSEDT;
098600181218           if %Error();
098700181218             hasError = *on;
098800181218             errDate2 = *on;
098900181218           EndIf;
099000181218         EndIf;
099100181218
099200181218
099300181218
099400181218
099500181218
099600181218
099700181218
099800181218       End-Proc;
099900181218
100000181217
100100181218       // ----------------------------------------------------------------
100200181218
100300181218       dcl-proc Build_Sort;
100400181218
100500181218         dcl-s i zoned(1);
100600181218
100700181218
100800181218         for i = 1 to 5;
100900181218
101000181218
101100181218           if sTrst = i;
101200181218             mySort = %Trim( mySort ) + ',acTrst';
101300181218           EndIf;
101400181218
101500181218
101600181218           if sSub = i;
101700181218             mySort = %Trim( mySort ) + ',acSub#';
101800181218           EndIf;
101900181218
102000181218           if sAcct = i;
102100181218             mySort = %Trim( mySort ) + ',acAcct';
102200181218           EndIf;
102300181218
102400181218
102500181218           if sActNam = i;
102600181218             mySort = %Trim( mySort ) + ',acNam1';
102700181218           EndIf;
102800181218
102900181218           if sCity = i;
103000181218             mySort = %Trim( mySort ) + ',aCity';
103100181218           EndIf;
103200181218
103300181218           if sState = i;
103400181218             mySort = %Trim( mySort ) + ',aState';
103500181218           EndIf;
103600181218
103700181218           if sZip = i;
103800181218             mySort = %Trim( mySort ) + ',aZip';
103900181218           EndIf;
104000181218
104100181219           if sContact = i;
104200181218             mySort = %Trim( mySort ) + ',Concac';
104300181218           EndIf;
104400181218
104500181218           if sCfs = i;
104600181218             mySort = %Trim( mySort ) + ',cfsedt';
104700181218           EndIf;
104800181218
104900181218           if sSalesmen = i;
105000181218             mySort = %Trim( mySort ) + ',smancd';
105100181218           EndIf;
105200181218
105300181218           if sRenew = i;
105400181218             mySort = %Trim( mySort ) + ',rnewpd';
105500181218           EndIf;
105600181218
105700181218           if sAACode = i;
105800181218             mySort = %Trim( mySort ) + ',aaCode';
105900181218           EndIf;
106000181218
106100181218           if sAcvtdt = i;
106200181218             mySort = %Trim( mySort ) + ',Acvtdt';
106300181218           EndIf;
106400181218
106500181218           if sLinvdt = i;
106600181218             mySort = %Trim( mySort ) + ',linvdt';
106700181218           EndIf;
106800181218
106900181218
107000181218         EndFor;
107100181218
107200181218
107300181218         if mySort > '';
107400181218           mySort = 'Order by ' + %Subst( mySort : 2 );
107500181218         EndIf;
107600181218
107700181218
107800181218       End-Proc;
107900181219
108000181219
108100181219       // ----------------------------------------------------------------
108200181219
108300181219       dcl-proc Load_Data;
108400181219
108500181220         chain ( pUserName : pSeq ) GBS0052P;
108600181219
108700181220         s1QryName = amQryName;
108800181219
108900181219
109000181219       End-Proc;
109100181219
109200181219       // ----------------------------------------------------------------
109300181219
109400181219       dcl-proc Add_Record;
109500181219
109600181220         dcl-s wSeq Zoned(5);
109700181219
109800181219
109900181220         if pSeq = 0;
110000181219
110100181220           wSeq = 0;
110200181219
110300181220           // Retrieve next Seq#
110400190125           Exec Sql
110500190125              Select Max(amseq)
110600190125                 Into :wseq
110700190125                 From gbs0052p
110800190125                 Where amcrtby = :wqusrn;
110900181219
111000181220           amSeq = wseq + 1;
111100181219
111200181219
111300181220           amQryName = s1QryName;
111400181220           amCrtBy = wqusrn;
111500181220           amCrtDt = %Dec(%Date);
111600181220           amCrtTm = %Dec(%Time);
111700181219
111800181220           amRcdSts = 'A';
111900181219
112000181220           amChgBy = '';
112100181220           amChgDt = 0;
112200181220           amChgTm = 0;
112300181219
112400181220           write r_gbs0052;
112500181220
112600181220           // Now Save the data incase the user presses SAVE again.
112700181220           pSeq = amSeq;
112800181220           chain ( pUserName : pSeq ) GBS0052P;
112900181219
113000181219
113100181220         else;
113200181219
113300181220           // Update Record
113400181220           amQryName = s1QryName;
113500181220           amChgBy = wqusrn;
113600181220           amChgDt = %Dec(%Date);
113700181220           amChgTm = %Dec(%Time);
113800181219
113900181220           Update r_gbs0052;
114000181219
114100181220
114200181220           // Now Save the data incase the user presses SAVE again.
114300181220           chain ( pUserName : pSeq ) GBS0052P;
114400181220
114500181220
114600181220         EndIf;
114700181219
114800181219
114900181219
115000181219       End-Proc;
115100181219
115200181219
