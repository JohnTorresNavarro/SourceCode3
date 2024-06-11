000100170504     H DftActGrp(*NO)    bnddir('GBSBDIR')
000200160428     H Option(*SRCSTMT: *NODEBUGIO: *NOSHOWCPY)
000300160428      *-------------------------------------------------------------------------
000400160428      *
000500170322      *  Description: Employee Update / Audit
000600160428      *  Programmer.: Brian Rees
000700170313      *  Date.......: 3/13/2017
000800170313      *
000900160428      *-------------------------------------------------------------------------
001000160428      * Modifications
001100160428      *
001200170427      * Date         Programmer    Mod      Description
001300160428      *-------------------------------------------------------------------------
001400160428      *
001500160428      *
001600160428      *-------------------------------------------------------------------------
001700170313    ?FGbs0016D2 CF   E             WORKSTN
001800170313     F                                     HANDLER('PROFOUNDUI(HANDLER)')
001900170313     F                                     SFILE(LSTSFL:rrn)
002000170313     fCensusp   if   e           k Disk
002100170810     fCensusap  uf a e           k Disk
002200170313     fMember    if   E           K Disk    ExtDesc('F.MEMBER') ExtFile(*extdesc)
002300170315     fWebPayrollif   E           K Disk
002400170427     fHist      if a E           K Disk    ExtDesc('F.HIST') ExtFile(*extdesc)
002500170430     fWebTran   if a E           K Disk
002600170430     faccmst    if   E           K Disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
002700160428      *-------------------------------------------------------------------------
002800160428
002900161010      * Program status data structure
003000161010     D pgmsts         sDS
003100161010     D  Jobname              244    253
003200161010     D  @User                254    263
003300161010     D  Jobnum               264    269s 0
003400161010     D  @date                276    281s 0
003500161010     D  CurrentUser          358    367A
003600161010
003700170315     D @pgmq             *proc
003800170313
003900170315     d rrn             s              5s 0
004000170315     d LineCount       s              3s 0
004100170315     d wLine           s              3s 0
004200170315     d Reload          s              1
004300170315
004400170315
004500170315     d pCatg           ds
004600170315     d chkName                        1
004700170315     d chkAddr                        1
004800170315     d chkEmail                       1
004900170315     d chkSalary                      1
005000170315     d chkJobt                        1
005100170505     d
005200170505     d @ssn            s              9s 0
005300170505     d NeedHeader      s              1
005400170505
005500170426      *?Update List
005600170426     d AryUpdList      s              5s 0 dim( 2000 )
005700170426     d AryCnt          s              5s 0
005800170426     d i               s              5s 0
005900170505     d x               s              5s 0
006000170505     d rrnCount        s              5s 0
006100170426     d Count           s              5s 0
006200170427     d RunUpdate       s              1a
006300170426     d q               c                   Const('''')
006400170427     d SqlStmt         s           2000a   inz
006500170426
006600170430     d oessid          s             16a   inz
006700170430     d webdtaara       s              9s 0 dtaara
006800170430      *?WebTran TRN# Dataarea
006900170430
007000170807
007100170807     d savSSN          s              9s 0
007200170807
007300160126      *-------------------------------------------------------------------------
007400170504      /copy *libl/qmodsrc,#genssidPR
007500160428
007600170505     d WEBTSUMR1       pr                  ExtPgm('WEBTSUMR1')
007700170505     d   ossid                       16
007800170430
007900170430
008000160127      *------------------------------------------------------------------
008100160127      *?Main Program
008200160127      *------------------------------------------------------------------
008300170315     C     *entry        plist
008400170315     C                   parm                    pTrust            3 0
008500170315     C                   parm                    pSub              3 0
008600170315     C                   parm                    pAcct             4 0
008700170315     C                   parm                    pCatg            20
008800160126
008900160126      /free
009000170427
009100170505       Exec Sql  Set Option Commit=*None, Naming=*Sys;
009200170313
009300170427       Reload = 'Y';
009400170427       dou btnExit = *on;
009500170313
009600170427          if Reload = 'Y' or btnChkAll = *on;
009700170427             exsr ClearS1;
009800170427             exsr LoadS1;
009900170427             Reload = 'N';
010000170427          endif;
010100170313
010200170427          exsr DisplyS1;
010300170313
010400170427          if btnExit = *on;
010500170427             leave;
010600170427          endif;
010700170313
010800170810          if btnAudit = *on;
010900170810             exfmt LstCtl3;
011000170810          endif;
011100170810
011200170427
011300170427          //?Only Update the checkboxes.
011400170427          if btnUpdate = *on;
011500170427             exsr ReadChanged;
011600170815
011700170815             if RunUpdate = 'Y';
011800170815                leave;
011900170815             endif;
012000170815
012100170427          endif;
012200170313
012300170427       enddo;
012400170313
012500170427       *inlr = *on;
012600170313
012700170313      *-------------------------------------------------------------------------
012800170427       Begsr ClearS1;
012900170313
013000170427          //?Clear the Subfile
013100170427          SflClr = *on;
013200170427          Write LstCtl;
013300170427          SflClr = *off;
013400170313
013500170427          rrn = 0;
013600170313
013700170427       Endsr;
013800170313      *-------------------------------------------------------------------------
013900170427       Begsr DisplyS1;
014000170313
014100170427          SflDsp = *on  ;
014200170427          exfmt  LstCtl ;
014300170427          SflDsp = *off;
014400170313
014500170427       Endsr;
014600170313      *-------------------------------------------------------------------------
014700170427       Begsr LoadS1;
014800170313
014900170313
015000170427          //----------------------------------------------------
015100170427          //?Line Count..
015200170430          //?  This section will calculate the number of
015300170430          //?  columns the grid/Subfile will contain.
015400170427          //----------------------------------------------------
015500170427          LineCount = 0;
015600170427          wLine     = 0;
015700170427          s1Heading = 'Update, SS# / Name, Location';
015800170315
015900170427          //?Check Name
016000170427          if chkName = 'Y';
016100170427             s1Heading = %Trim(s1Heading) + ',Name';
016200170427             LineCount = LineCount + 1;
016300170427          endif;
016400170315
016500170315
016600170427          //?Check Address
016700170427          if chkAddr = 'Y';
016800170427             s1Heading = %Trim(s1Heading) +
016900170315                         ',Address,Address 2,City State Zip';
017000170427             LineCount = LineCount + 3;
017100170427          endif;
017200170315
017300170315
017400170427          //?Check Email
017500170427          if chkEmail = 'Y';
017600170427             s1Heading = %Trim(s1Heading) + ',Email';
017700170427             LineCount = LineCount + 1;
017800170427          endif;
017900170315
018000170315
018100170315
018200170427          //?Check Salary
018300170427          if chkSalary = 'Y';
018400170427             s1Heading = %Trim(s1Heading) + ',Salary';
018500170427             LineCount = LineCount + 1;
018600170427          endif;
018700170315
018800170315
018900170315
019000170427          //?Check Job Title
019100170427          if chkJobt = 'Y';
019200170427             s1Heading = %Trim(s1Heading) + ',Job Title';
019300170427             LineCount = LineCount + 1;
019400170427          endif;
019500170315
019600170427          s1ColCnt = LineCount;
019700170315
019800170430          //?Set the placement for the Update Button
019900170430          //?and the Exit button dynamically.
020000170427          Upd_Left = 510;
020100170427          Exit_Left = 390;
020200170316
020300170427          if LineCount = 2;
020400170427             Upd_Left = 720;
020500170427             Exit_Left = 600;
020600170427          endif;
020700170315
020800170427          if LineCount = 3;
020900170427             Upd_Left = 935;
021000170427             Exit_Left = 815;
021100170427          endif;
021200170315
021300170427          if LineCount = 4;
021400170427             Upd_Left = 1145;
021500170427             Exit_Left = 1025;
021600170427          endif;
021700170315
021800170315
021900170427          if LineCount = 5;
022000170427             Upd_Left = 1355;
022100170427             Exit_Left = 1235;
022200170427          endif;
022300170315
022400170427          if LineCount = 6;
022500170427             Upd_Left = 1565;
022600170427             Exit_Left = 1445;
022700170427          endif;
022800170315
022900170427          if LineCount = 7;
023000170427             Upd_Left = 1805;
023100170427             Exit_Left = 1685;
023200170427          endif;
023300170315
023400170427          //----------------------------------------------------
023500170430          //?Load the Grid
023600170427          //----------------------------------------------------
023700170427          Setll *loval Censusp;
023800170427          dou %Eof( Censusp );
023900170427             read Censusp;
024000170313
024100170427             if %Eof( Censusp );
024200170427                leave;
024300170427             endif;
024400170313
024500170427             if btnChkAll = *on;
024600170427                s1Update = s1ChkAll;
024700170427             endif;
024800170316
024900170427             s1Trst = cuTrst;
025000170427             s1Sub# = cuSub#;
025100170427             s1Acct = cuAcct;
025200170316
025300170427             s1ssn  = %Subst(cSocSec:1:3) + '-' + %Subst(cSocSec:4:2) + '-' +
025400170315                      %Subst(cSocSec:6:4);
025500170504             s1FulNam = %Trim(clName) + ', ' + %Trim(cfName);
025600170427             s1Seq = cuSeq;
025700170426
025800170426
025900170427             @ssn = %dec(cSocSec:9:0);
026000170430             chain @Ssn Member;
026100170427             chain ( pTrust : pSub : pAcct : @Ssn ) WebPayroll;
026200170315
026300170427             wLine = 0;
026400170427
026500170427             //--------------------------------------
026600170427             //?Check Name
026700170427             //--------------------------------------
026800170427             if chkName = 'Y';
026900170427                wLine = 1;
027000170504                nLine1 = %Trim(clName) + ', ' + %Trim(cfName) + '  ' +
027100170504                        %Trim(cmiddlei);
027200170427                oLine1 = 'Not Found**';
027300170427                if %Found( Member );
027400170504                   oLine1 = %Trim(mlName) + ', ' + %Trim(mfName) + '  ' +
027500170504                        %Trim(mmi);
027600170427                endif;
027700170427             endif;
027800170315
027900170315
028000170427             //--------------------------------------
028100170427             //?Address
028200170427             //--------------------------------------
028300170427             if chkAddr = 'Y';
028400170427                Exsr LstAddress;
028500170427             endif;
028600170315
028700170315
028800170427             //--------------------------------------
028900170427             //?Email
029000170427             //--------------------------------------
029100170427             if chkEmail = 'Y';
029200170427                Exsr LstEmail;
029300170427             endif;
029400170315
029500170505
029600170427             //--------------------------------------
029700170427             //?Salary
029800170427             //--------------------------------------
029900170427             if chkSalary = 'Y';
030000170427                Exsr LstSalary;
030100170427             endif;
030200170315
030300170427
030400170427             //--------------------------------------
030500170427             //?Job Title
030600170427             //--------------------------------------
030700170427             if chkJobt = 'Y';
030800170427                Exsr LstJobT;
030900170427             endif;
031000170427
031100170315
031200170427             rrn = rrn + 1;
031300170427             write LstSfl;
031400170313
031500170313
031600170427          enddo;
031700170313
031800170313
031900170313
032000170313
032100170427       Endsr;
032200170313
032300170315      *-------------------------------------------------------------------------
032400170427       Begsr LstAddress;
032500170315
032600170427          //------------------------------------------------------
032700170427          // This process runs after the chkName routine.
032800170427          // If the user didn't select chkName, then we will
032900170427          // be using the first 3 lines.
033000170427          //------------------------------------------------------
033100170427          if wLine = 0;
033200170427             wLine = 3;
033300170315
033400170427             nLine1 = *blanks;
033500170427             nLine2 = *blanks;
033600170427             nLine3 = *blanks;
033700170315
033800170427             oLine1 = 'Not Found**';
033900170427             oLine2 = 'Not Found**';
034000170427             oLine3 = *Blanks;
034100170315
034200170427             //?Has F.Member Record.
034300170427             if %Found( Member );
034400170427                oLine1 = %Trim(Addr1);
034500170427                oLine2 = %Trim(Addr2);
034600170427                oLine3 = %Trim( City ) + ' ' +  %Trim( State ) + ', ' +
034700170315                         %char( Zip );
034800170427             endif;
034900170315
035000170315
035100170427             //?New Information
035200170427             nLine1 = %Trim(cAddr1);
035300170427             nLine2 = %Trim(cAddr2);
035400170427             nLine3 = %Trim( csCity ) + ' ' + %Trim( csState ) + ', ' +
035500170315                      %Trim( csZip );
035600170315
035700170427          Endif;   //?wLine = 0;
035800170315
035900170315
036000170427          if wLine = 1;
036100170427             wLine = 4;
036200170315
036300170427             nLine2 = *blanks;
036400170427             nLine3 = *blanks;
036500170427             nLine4 = *blanks;
036600170315
036700170427             oLine2 = 'Not Found**';
036800170427             oLine3 = 'Not Found**';
036900170427             oLine4 = *Blanks;
037000170315
037100170427             //?Has F.Member Record.
037200170427             if %Found( Member );
037300170427                oLine2 = %Trim(Addr1);
037400170427                oLine3 = %Trim(Addr2);
037500170427                oLine4 = %Trim( City ) + ' ' + %Trim( State ) + ', ' +
037600170315                         %Char( Zip );
037700170427             endif;
037800170315
037900170315
038000170427             //?New Information
038100170427             nLine2 = %Trim(cAddr1);
038200170427             nLine3 = %Trim(cAddr2);
038300170427             nLine4 = %Trim( csCity ) + ' ' +%Trim( csState ) + ', ' +
038400170315                      %Trim( csZip );
038500170315
038600170427          Endif;   //?wLine = 1;
038700170315
038800170427       Endsr;
038900170315      *-------------------------------------------------------------------------
039000170427       Begsr LstEmail;
039100170315
039200170427          //?Line 4( Name & Address)
039300170427          if wLine = 4;
039400170427             wLine = 5;
039500170427             oLine5 = 'Not Found**';
039600170427             nLine5 = cemail;
039700170315
039800170427             if %Found( Member );
039900170427                oLine5 = Fill66;
040000170427             endif;
040100170427          endif;
040200170315
040300170427          //?Line 3( Address )
040400170427          if wLine = 3;
040500170427             wLine = 4;
040600170427             oLine4 = 'Not Found**';
040700170427             nLine4 = cemail;
040800170315
040900170427             if %Found( Member );
041000170427                oLine4 = Fill66;
041100170427             endif;
041200170427          endif;
041300170315
041400170315
041500170427          //?Line 1( Name )
041600170427          if wLine = 1;
041700170427             wLine = 2;
041800170427             oLine2 = 'Not Found**';
041900170427             nLine2 = cemail;
042000170315
042100170427             if %Found( Member );
042200170427                oLine2 = Fill66;
042300170427             endif;
042400170427          endif;
042500170315
042600170315
042700170427          //?Line 0
042800170427          if wLine = 0;
042900170427             wLine = 1;
043000170427             oLine1 = 'Not Found**';
043100170427             nLine1 = cemail;
043200170315
043300170427             if %Found( Member );
043400170427                oLine1 = Fill66;
043500170427             endif;
043600170427          endif;
043700170315
043800170427       Endsr;
043900170315      *-------------------------------------------------------------------------
044000170427       Begsr LstSalary;
044100170315
044200170427          //?Line 5( Name, Address & Email )
044300170427          if wLine = 5;
044400170427             wLine = 6;
044500170427             oLine6 = 'Not Found**';
044600170427             nLine6 = cAnnSalary;
044700170315
044800170427             if %Found( Member );
044900170427                oLine6 = %Char(Salary) +'.00';
045000170427             endif;
045100170427          endif;
045200170315
045300170315
045400170427          //?Line 4( Name & Address)
045500170427          if wLine = 4;
045600170427             wLine = 5;
045700170427             oLine5 = 'Not Found**';
045800170427             nLine5 = cAnnSalary;
045900170315
046000170427             if %Found( Member );
046100170427                oLine5 = %Char(Salary) +'.00';
046200170427             endif;
046300170427          endif;
046400170315
046500170505          //?Line 2( Name + Email)
046600170505          if wLine = 2;
046700170505             wLine = 3;
046800170505             oLine3 = 'Not Found**';
046900170505             nLine3 = cAnnSalary;
047000170315
047100170427             if %Found( Member );
047200170505                oLine3 = %Char(Salary) +'.00';
047300170427             endif;
047400170427          endif;
047500170315
047600170315
047700170505          //?Line 1( Name )
047800170505          if wLine = 1;
047900170505             wLine = 2;
048000170505             oLine2 = 'Not Found**';
048100170505             nLine2 = cAnnSalary;
048200170505
048300170505             if %Found( Member );
048400170505                oLine2 = %Char(Salary) +'.00';
048500170505             endif;
048600170505          endif;
048700170427          //?Line 1( Name )
048800170427          if wLine = 1;
048900170427             wLine = 2;
049000170427             oLine2 = 'Not Found**';
049100170427             nLine2 = cAnnSalary;
049200170315
049300170427             if %Found( Member );
049400170427                oLine2 = %Char(Salary) +'.00';
049500170427             endif;
049600170427          endif;
049700170315
049800170315
049900170427          //?Line 0
050000170427          if wLine = 0;
050100170427             wLine = 1;
050200170427             oLine1 = 'Not Found**';
050300170427             nLine1 = cAnnSalary;
050400170315
050500170427             if %Found( Member );
050600170427                oLine1 = %Char(Salary) +'.00';
050700170427             endif;
050800170427          endif;
050900170315
051000170427       Endsr;
051100170315      *-------------------------------------------------------------------------
051200170427       Begsr LstJobt;
051300170315
051400170427          //?Line 6( Name, Address, Email, Salary)
051500170427          if wLine = 6;
051600170427             wLine = 7;
051700170427             oLine7 = 'Not Found**';
051800170427             nLine7 = cJobTitle;
051900170315
052000170427             if %Found( WebPayroll );
052100170427                oLine7 = pyOcc;
052200170427             endif;
052300170427          endif;
052400170315
052500170315
052600170427          //?Line 5( Name, Address, Email)
052700170427          if wLine = 5;
052800170427             wLine = 6;
052900170427             oLine6 = 'Not Found**';
053000170427             nLine6 = cJobTitle;
053100170315
053200170427             if %Found( WebPayroll );
053300170427                oLine6 = pyOcc;
053400170427             endif;
053500170427          endif;
053600170315
053700170427          //?Line 4( Name & Address)
053800170427          if wLine = 4;
053900170427             wLine = 5;
054000170427             oLine5 = 'Not Found**';
054100170427             nLine5 = cJobTitle;
054200170315
054300170427             if %Found( WebPayroll );
054400170427                oLine5 = pyOcc;
054500170427             endif;
054600170427          endif;
054700170315
054800170427          //?Line 3( Address )
054900170427          if wLine = 3;
055000170427             wLine = 4;
055100170427             oLine4 = 'Not Found**';
055200170427             nLine4 = cJobTitle;
055300170315
055400170427             if %Found( WebPayroll );
055500170427                oLine4 = pyOcc;
055600170427             endif;
055700170427          endif;
055800170315
055900170315
056000170427          //?Line 1( Name )
056100170427          if wLine = 1;
056200170427             wLine = 2;
056300170427             oLine2 = 'Not Found**';
056400170427             nLine2 = cJobTitle;
056500170315
056600170427             if %Found( WebPayroll );
056700170427                oLine2 = pyOcc;
056800170427             endif;
056900170427          endif;
057000170315
057100170315
057200170427          //?Line 0
057300170427          if wLine = 0;
057400170427             wLine = 1;
057500170427             oLine1 = 'Not Found**';
057600170427             nLine1 = cJobTitle;
057700170315
057800170427             if %Found( WebPayroll );
057900170427                oLine1 = pyOcc;
058000170427             endif;
058100170427          endif;
058200170315
058300170427       Endsr;
058400170425
058500170425
058600170427       // ----------------------------------------------------------------
058700170427       Begsr ReadChanged;
058800170425
058900170427          RunUpdate = 'N';
059000170427          AryCnt = 0;
059100170505          rrnCount = rrn;
059200170505
059300170505          for x = 1 to rrnCount;
059400170505             chain x LstSfl;
059500170425
059600170505             //?Write to Update Array...
059700170505             If s1Update = 'Y';
059800170505                AryCnt = AryCnt + 1;
059900170505                AryUpdList(AryCnt) = s1Seq;
060000170505                RunUpdate = 'Y';
060100170505             endif;
060200170426
060300170505          endfor;
060400170426
060500170427          //?If RunUpdate is 'Y', process the changes..
060600170427          if RunUpdate = 'Y';
060700170427             exsr ProcessChgs;
060800170815          else;
060900170815             //?No updates selected??? Send Message.
061000170815             Exfmt Screen4;
061100170815
061200170427          endif;
061300170426
061400170427       Endsr;
061500170425
061600170427       // ----------------------------------------------------------------
061700170427       Begsr ProcessChgs;
061800170426
061900170430          //?Chain to the Account Master to get the AA Code.
062000170430          chain (s1Trst : s1Sub# : s1Acct) AccMst;
062100170430
062200170430
062300170427          // Read through the Array
062400170427          for i = 1 to AryCnt;
062500170427             chain ( s1Trst : s1Sub# : s1Acct : AryUpdList(i)) Censusp;
062600170426
062700170430             //?iSeries Data
062800170430             @ssn = %dec(cSocSec:9:0);
062900170430             chain  @ssn Member;     // Get Current Values.
063000170430
063100170427             exsr iSeries_Data;
063200170427             if sqlCod = 0;
063300170427                exsr WriteHist;
063400170427             EndIf;
063500170501
063600170501             //?Web Payroll Data
063700170501             @ssn = %dec(cSocSec:9:0);
063800170501             chain ( pTrust : pSub : pAcct : @Ssn ) WebPayroll;
063900170501
064000170427             exsr OLE_Data;
064100170501             if sqlCod = 0;
064200170501                exsr WriteTrans;
064300170501             EndIf;
064400170427
064500170427          endfor;
064600170427
064700170427          if AryCnt = 1;
064800170427             UpdMsg = '1 record updated.';
064900170427          else;
065000170427             UpdMsg = %Editc(AryCnt: '1') + ' records updated.';
065100170427          endif;
065200170427
065300170427          exfmt Screen3;
065400170427
065500170427       Endsr;
065600170426
065700170427
065800170427
065900170427
066000170427       //----------------------------------------------------------------
066100170427       // Build the SQL Dynamically to update F.Member
066200170427       //----------------------------------------------------------------
066300170427       Begsr iseries_Data;
066400170427
066500170427          //?Build SQL..
066600170427          Count = 0;
066700170427          SqlStmt = 'Update "F.MEMBER" set';
066800170427
066900170427
067000170427          //?-------------------------
067100170427          //?Check Email Flag...
067200170427          //?-------------------------
067300170816          if chkEmail = 'Y' and cEmail > *Blanks;
067400170427             if Count = 0;
067500170427                sqlStmt = %Trim(sqlStmt) +
067600170427                  ' Fill66 = ' + q + %TRIM(cEmail) + q;
067700170427             else;
067800170427                sqlStmt = %Trim(sqlStmt) +
067900170427                  ', Fill66 = ' + q + %trim(cEmail) + q;
068000170427             endif;
068100170427
068200170427             count = count + 1;
068300170427          endif;
068400170427
068500170427
068600170427
068700170427          //?-------------------------
068800170427          //?Check Salary Flag...
068900170427          //?-------------------------
069000170816          if chkSalary = 'Y' and  %Trim(cAnnSalary) > *Blanks;
069100170427             if Count = 0;
069200170427                sqlStmt =
069300170427                   %Trim(sqlStmt) + ' Salary = '  + %Trim(cAnnSalary);
069400170427             else;
069500170427                sqlStmt =
069600170427                   %Trim(sqlStmt) + ', Salary = '  + %Trim(cAnnSalary);
069700170427             endif;
069800170427
069900170427             count = count + 1;
070000170427          endif;
070100170427
070200170427
070300170427
070400170427          //?-------------------------
070500170427          //?Check Name Flag...
070600170427          //?-------------------------
070700170818          if chkName = 'Y' and clName > *Blanks;
070800170427             if Count = 0;
070900170427                sqlStmt =  %Trim(sqlStmt) +
071000170427                    ' MLName = '  + q + %Trim(clName) + q +
071100170427                    ', MFName = ' + q + %Trim(cfName) + q +
071200170427                    ', MMI = '    + q + %Trim(cmiddlei) + q ;
071300170427
071400170427             else;
071500170427                sqlStmt =  %Trim(sqlStmt) +
071600170427                    ', MLName = '  + q + %Trim(clName) + q +
071700170427                    ', MFName = '  + q + %Trim(cfName) + q +
071800170427                    ', MMI = '     + q + %Trim(cmiddlei) + q;
071900170427
072000170427             endif;
072100170427
072200170427             count = count + 1;
072300170427          endif;
072400170427
072500170427
072600170427
072700170427          //?-------------------------
072800170427          //?Check Address Flag...
072900170427          //?-------------------------
073000170427          if chkAddr = 'Y';
073100170818
073200170818             if cAddr1 > *Blanks;
073300170818             if Count = 0;
073400170427                sqlStmt =  %Trim(sqlStmt) +
073500170427                    ' Addr1 = '  + q + %Trim(cAddr1) +  q +
073600170818                    ', Addr2 = ' + q + %Trim(cAddr2) +  q ;
073700170427             else;
073800170427                sqlStmt =  %Trim(sqlStmt) +
073900170427                    ', Addr1 = '  + q + %Trim(cAddr1) +  q +
074000170818                    ', Addr2 = ' + q + %Trim(cAddr2) +  q ;
074100170427             endif;
074200170818             count = count + 1;
074300170818             endif;
074400170427
074500170818
074600170818
074700170818             if csCity > *Blanks;
074800170818             if Count = 0;
074900170818                sqlStmt =  %Trim(sqlStmt) +
075000170818                    '  City = '  + q + %Trim(csCity) +  q ;
075100170818             else;
075200170818                sqlStmt =  %Trim(sqlStmt) +
075300170818                    ', City = '  + q + %Trim(csCity) +  q ;
075400170818             endif;
075500170818             count = count + 1;
075600170818             endif;
075700170818
075800170818
075900170818
076000170818             if csState > *Blanks;
076100170818             if Count = 0;
076200170818                sqlStmt =  %Trim(sqlStmt) +
076300170818                    ', State = ' + q + %Trim(csState) + q ;
076400170818             else;
076500170818                sqlStmt =  %Trim(sqlStmt) +
076600170818                    ', State = ' + q + %Trim(csState) + q ;
076700170818             endif;
076800170818             count = count + 1;
076900170818             endif;
077000170818
077100170818
077200170818
077300170818             if csZip > *Blanks;
077400170818             if Count = 0;
077500170818                sqlStmt =  %Trim(sqlStmt) +
077600170818                    '  Zip = '   +  %Subst(csZip:1:5) + '0000' ;
077700170818             else;
077800170818                sqlStmt =  %Trim(sqlStmt) +
077900170818                    ', Zip = '   +  %Subst(csZip:1:5) + '0000';
078000170818             endif;
078100170427             count = count + 1;
078200170818             endif;
078300170818
078400170427          endif;
078500170427
078600170427
078700170427          //-------------------------
078800170427          //?Finish up SQL Command.
078900170427          //-------------------------
079000170427          sqlStmt = %Trim(sqlStmt) +
079100170427            ' Where mbTrst = ' + %char(s1Trst) +
079200170427            '   and mbSub# = ' + %char(s1Sub#) +
079300170427            '   and mbAcct = ' + %char(s1Acct) +
079400170427            '   and mbssno = ' + %char(cSocSec) ;
079500170427
079600170427
079700170427          //-------------------------
079800170427          //?Run the SQL Statement.
079900170427          //-------------------------
080000170427          Exec Sql Prepare D1 From :Sqlstmt ;
080100170427          exec sql execute d1 ;
080200170427
080300170427
080400170427
080500170427       EndSr;
080600170427
080700170427       //----------------------------------------------------------------
080800170427       // Build the SQL to update webPayroll (OLE) Dynamically
080900170427       //----------------------------------------------------------------
081000170427       Begsr OLE_Data;
081100170427
081200170427          //?Build SQL..
081300170427          Count = 0;
081400170427          SqlStmt = 'Update WebPayroll set';
081500170427
081600170427
081700170427          //?-------------------------
081800170427          //?Check Email Flag...
081900170427          //?-------------------------
082000170823          if chkEmail = 'Y' and cEmail > *Blanks;
082100170427             if Count = 0;
082200170427                sqlStmt = %Trim(sqlStmt) +
082300170427                  ' pyEml = ' + q + %TRIM(cEmail) + q;
082400170427             else;
082500170427                sqlStmt = %Trim(sqlStmt) +
082600170427                  ', pyEml = ' + q + %trim(cEmail) + q;
082700170427             endif;
082800170427
082900170427             count = count + 1;
083000170427          endif;
083100170427
083200170427
083300170427
083400170427          //?-------------------------
083500170427          //?Check Salary Flag...
083600170427          //?-------------------------
083700170823          if chkSalary = 'Y' and cAnnSalary > *Blanks;
083800170427             if Count = 0;
083900170427                sqlStmt =
084000170427                   %Trim(sqlStmt) + ' pyans = '  + %Trim(cAnnSalary);
084100170427             else;
084200170505
084300170427                sqlStmt =
084400170427                   %Trim(sqlStmt) + ', pyAns = '  + %Trim(cAnnSalary);
084500170427             endif;
084600170427
084700170505             sqlStmt =
084800170505                %Trim(sqlStmt) + ', PYSALDT = '  + %Trim(cSalChgDt);
084900170505
085000170427             count = count + 1;
085100170427          endif;
085200170427
085300170427
085400170505          //?-------------------------
085500170505          //?Check Job Title...
085600170505          //?-------------------------
085700170823          if chkJobt = 'Y' and cJobTitle > *Blanks;
085800170505             if Count = 0;
085900170505                sqlStmt =
086000170505                   %Trim(sqlStmt) + ' pyocc = '  + q + %Trim(cJobTitle) + q;
086100170505             else;
086200170505                sqlStmt =
086300170505                   %Trim(sqlStmt) + ', pyocc = ' + q + %Trim(cJobTitle) + q;
086400170505             endif;
086500170505
086600170505             count = count + 1;
086700170505          endif;
086800170505
086900170427
087000170427          //?-------------------------
087100170427          //?Check Name Flag...
087200170427          //?-------------------------
087300170823          if chkName = 'Y' and clName < *Blanks;
087400170427             if Count = 0;
087500170427                sqlStmt =  %Trim(sqlStmt) +
087600170427                    '  pylst = '  + q + %Trim(clName) + q +
087700170427                    ', pyfst = '  + q + %Trim(cfName) + q +
087800170427                    ', pymid = '  + q + %Trim(cmiddlei) + q ;
087900170427
088000170427             else;
088100170427                sqlStmt =  %Trim(sqlStmt) +
088200170427                    ', pylst = '  + q + %Trim(clName) + q +
088300170427                    ', pyfst = '  + q + %Trim(cfName) + q +
088400170427                    ', pymid = '  + q + %Trim(cmiddlei) + q;
088500170427
088600170427             endif;
088700170427
088800170427             count = count + 1;
088900170427          endif;
089000170427
089100170427
089200170427
089300170427          //?-------------------------
089400170427          //?Check Address Flag...
089500170427          //?-------------------------
089600170427          if chkAddr = 'Y';
089700170823             if cAddr1 > *Blanks;
089800170427             if Count = 0;
089900170427                sqlStmt =  %Trim(sqlStmt) +
090000170427                    '  PyAd1 = '  + q + %Trim(cAddr1)  + q +
090100170823                    ', PyAd2 = ' + q + %Trim(cAddr2)  + q ;
090200170427
090300170427             else;
090400170427                sqlStmt =  %Trim(sqlStmt) +
090500170427                    ', PyAd1 = '  + q + %Trim(cAddr1)  + q +
090600170823                    ', PyAd2 = ' + q + %Trim(cAddr2)  + q ;
090700170823             endif;
090800170823             endif;
090900170427
091000170823
091100170823
091200170823             if csCity > *Blanks;
091300170823             if Count = 0;
091400170823                sqlStmt =  %Trim(sqlStmt) +
091500170823                    '  pyCty = '  + q + %Trim(csCity)  + q ;
091600170823
091700170823             else;
091800170823                sqlStmt =  %Trim(sqlStmt) +
091900170823                    ', pyCty = '  + q + %Trim(csCity)  + q ;
092000170427             endif;
092100170823             endif;
092200170823
092300170823
092400170823             if csState > *Blanks;
092500170823             if Count = 0;
092600170823                sqlStmt =  %Trim(sqlStmt) +
092700170823                    '  pyStt = '  + q + %Trim(csState) + q  ;
092800170823             else;
092900170823                sqlStmt =  %Trim(sqlStmt) +
093000170823                    ', pyStt = '  + q + %Trim(csState) + q ;
093100170823             endif;
093200170823             endif;
093300170427
093400170823
093500170823
093600170823             if csState > *Blanks;
093700170823             if Count = 0;
093800170823                sqlStmt =  %Trim(sqlStmt) +
093900170823                    '  pyZp5 = '  + q + %Subst(csZip:1:5)   + q ;
094000170823             else;
094100170823                sqlStmt =  %Trim(sqlStmt) +
094200170823                    ', pyZp5 = '  + q + %Subst(csZip:1:5)   + q ;
094300170823             endif;
094400170823             endif;
094500170823
094600170823
094700170427             count = count + 1;
094800170427          endif;
094900170427
095000170427
095100170427          //-------------------------
095200170427          //?Finish up SQL Command.
095300170427          //-------------------------
095400170427          sqlStmt = %Trim(sqlStmt) +
095500170427            ' Where pyTrs = ' + %char(s1Trst) +
095600170427            '   and pySub = ' + %char(s1Sub#) +
095700170427            '   and pyAct = ' + %char(s1Acct) +
095800170427            '   and pyssn = ' + %char(cSocSec) ;
095900170427
096000170427
096100170427          //-------------------------
096200170427          //?Run the SQL Statement.
096300170427          //-------------------------
096400170427          Exec Sql Prepare D1 From :Sqlstmt ;
096500170427          exec sql execute d1 ;
096600170427
096700170427
096800170427
096900170427       EndSr;
097000170427
097100170427
097200170427       //----------------------------------------------------------------
097300170427       //  Write to the History File.
097400170427       //----------------------------------------------------------------
097500170427       Begsr WriteHist;
097600170427
097700170427          // Setup Defaults
097800170427          hkey = ' ' + %Subst(cSocSec : 1 : 9) ;
097900170427          hPrgnm = 'GBS0016R';
098000170427          trDate = %Dec(%Date);
098100170427          hsTrst = s1Trst;
098200170427          hsSub# = s1Sub#;
098300170427          hsAcct = s1Acct;
098400170427          hsDltd = 'A';
098500170427          hstrTime = %Time;
098600170427          hOper =  @User;
098700170427          covtdt = %Dec(%Date);
098800170427
098900170427
099000170427
099100170427
099200170427          //?-------------------------
099300170427          //? Email Change?
099400170427          //?-------------------------
099500170428          if chkEmail = 'Y'
099600170428             and %trim(fill66) <> %Trim(cEmail);
099700170427             trCode = 'M75';
099800170427             ck#Not =  Fill66;
099900170427             note2 = %trim(cEmail);
100000170427             write histr;
100100170427          endif;
100200170427
100300170427
100400170505
100500170505          //?-------------------------
100600170505          //? Salary Change?
100700170505          //?-------------------------
100800170505          if chkSalary = 'Y';
100900170505             trCode = 'M17';
101000170505             ck#Not =  %Char(Salary);
101100170505             note2 = %Trim(cAnnSalary);
101200170505             write histr;
101300170505          EndIf;
101400170505
101500170427
101600170427          //?-------------------------
101700170427          //?Check Name Flag...
101800170427          //?-------------------------
101900170427          if chkName = 'Y';
102000170427
102100170427             // Last Name
102200170427             if mlName <> clName;
102300170427                trCode = 'M01';
102400170427                ck#Not =  mlName;
102500170427                note2 = %Trim(clName);
102600170427                write histr;
102700170427             EndIf;
102800170427
102900170427
103000170427             // First Name
103100170427             if mfName <> cfName;
103200170427                trCode = 'M02';
103300170427                ck#Not =  mfName;
103400170427                note2 = %Trim(cfName);
103500170427                write histr;
103600170427             EndIf;
103700170427
103800170427
103900170427             // Middle Init
104000170427             if mmi <> cmiddlei;
104100170427                trCode = 'M03';
104200170427                ck#Not =  mmi;
104300170427                note2 = %Trim(cmiddlei);
104400170427                write histr;
104500170427             EndIf;
104600170427
104700170427
104800170427          endif;
104900170427
105000170427
105100170427
105200170427          //?-------------------------
105300170427          //?Check Address Flag...
105400170427          //?-------------------------
105500170427          if chkAddr = 'Y';
105600170427
105700170427             // Addr1
105800170427             if addr1 <> caddr1;
105900170427                trCode = 'M04';
106000170427                ck#Not =  addr1;
106100170427                note2 = %Trim(caddr1);
106200170427                write histr;
106300170427             EndIf;
106400170427
106500170427
106600170427             // Addr2
106700170427             if addr2 <> caddr2;
106800170427                trCode = 'M05';
106900170427                ck#Not =  addr2;
107000170427                note2 = %Trim(caddr2);
107100170427                write histr;
107200170427             EndIf;
107300170427
107400170427
107500170427             // City
107600170427             if city <> csCity;
107700170427                trCode = 'M06';
107800170427                ck#Not =  city;
107900170427                note2 = %Trim(cscity);
108000170427                write histr;
108100170427             EndIf;
108200170427
108300170427             // State
108400170427             if state <> csState;
108500170427                trCode = 'M07';
108600170427                ck#Not =  State;
108700170427                note2 = %Trim(csState);
108800170427                write histr;
108900170427             EndIf;
109000170427
109100170505             // Zip
109200170505             if zip <> %dec ( %Subst(csZip:1:5) + '0000' : 9 : 0 );
109300170505                trCode = 'M08';
109400170505                ck#Not =  %char(Zip);
109500170505                note2 =  %Subst(csZip:1:5) + '0000';
109600170505                write histr;
109700170505             EndIf;
109800170505
109900170427
110000170427          endif;
110100170427
110200170427
110300170427
110400170427       endsr;
110500170427
110600170430
110700170430       //----------------------------------------------------------------
110800170430       //  Write to the OE Transaction File (WebTran)
110900170430       //----------------------------------------------------------------
111000170430       Begsr WriteTrans;
111100170430
111200170505          //----------------------------
111300170505          //?Add Personel Info first..
111400170505          //----------------------------
111500170430
111600170505          NeedHeader = 'Y';
111700170505
111800170505          //?Generate a Session ID; using the #Molule from RPGsp.
111900170808          oessid = #genssid(s1Trst : s1Sub# : s1Acct : 'E');
112000170430
112100170505          oeTrst = s1Trst;
112200170505          oeSub# = s1Sub#;
112300170505          oeAcct = s1Acct;
112400170505          oessno = %dec( cSocSec : 9 : 0 );
112500170430
112600170505          oeaddf = 'Y';
112700170505          oeaddu = @User;
112800170505          oeaddd = %Dec(%Date);
112900170505          oeaddt = %Dec(%Time);
113000170430
113100170505          oecnff = 'Y';
113200170505          oecnfu = @User;
113300170505          oecnfd = %Dec(%Date);
113400170505          oecnft = %Dec(%Time);
113500170430
113600170505          oesigf = 'Y';
113700170505          oesigu = @User;
113800170505          oesigd = %Dec(%Date);
113900170505          oesigt = %Dec(%Time);
114000170430
114100170505          oeretf = 'W';
114200170505          oeretu = 'GBS0016R2';
114300170505          oeretd = %Dec(%Date);
114400170505          oerett = %Dec(%Time);
114500170430
114600170505          oeprtf = 'N';
114700170505          oeSuper = '*NO';
114800170505          oeaacod = aacode;
114900170430
115000170505          //?Per_Info Changes..
115100170505          oeGrpv = 'PER_INFO';
115200170505
115300170505
115400170505          if chkEmail = 'Y'  or  chkName = 'Y' or ChkAddr = 'Y';
115500170505             //?Get Next Available transaction number.
115600170505             in *lock webdtaara;
115700170505             webdtaara = webdtaara + 1;
115800170505             out webdtaara;
115900170505
116000170505             oeTrn# = webdtaara;
116100170505
116200170505             // Write Header..
116300170505             oeFldv = 'HEADER';
116400170505             write webtranr;
116500170505             NeedHeader = 'N';
116600170505
116700170505             oeFldv = 'CENSUS_UPLD';
116800170505             write webtranr;
116900170505
117000170505
117100170505          endif;
117200170505
117300170505
117400170430
117500170505          //?-------------------------
117600170505          //? Email Change?
117700170505          //?-------------------------
117800170505          if chkEmail = 'Y'
117900170505             and %trim(pyEml) <> %Trim(cEmail);
118000170505             oeFldv = 'PYEML';
118100170505             oeBefore =  pyEml;
118200170505             oeAfter = %trim(cEmail);
118300170505             write WebTranr;
118400170505          endif;
118500170430
118600170430
118700170501
118800170501          //?-------------------------
118900170501          //?Check Name Flag...
119000170501          //?-------------------------
119100170501          if chkName = 'Y';
119200170501
119300170501             // Last Name
119400170501             if pylst <> clName;
119500170505                oeFldv = 'MLNAME';
119600170505                oeBefore =  pyLst;
119700170505                oeAfter = %trim(clName);
119800170505                write WebTranr;
119900170501             EndIf;
120000170501
120100170501
120200170501             // First Name
120300170501             if pyfst <> cfName;
120400170505                oeFldv = 'MFNAME';
120500170505                oeBefore =  pyFst;
120600170505                oeAfter = %trim(cfName);
120700170505                write WebTranr;
120800170501             EndIf;
120900170501
121000170501
121100170501             // Middle Init
121200170501             if pymid <> cmiddlei;
121300170505                oeFldv = 'MMI';
121400170505                oeBefore =  pymid;
121500170505                oeAfter = %trim(cmiddlei);
121600170505                write WebTranr;
121700170501             EndIf;
121800170501
121900170501
122000170501          endif;
122100170501
122200170501
122300170501
122400170501          //?-------------------------
122500170501          //?Check Address Flag...
122600170501          //?-------------------------
122700170501          if chkAddr = 'Y';
122800170501
122900170501             // Addr1
123000170505             if pyad1 <> caddr1;
123100170505                oeFldv = 'ADDR1';
123200170505                oeBefore =  pyad1;
123300170505                oeAfter = %trim(caddr1);
123400170505                write WebTranr;
123500170501             EndIf;
123600170501
123700170501
123800170501             // Addr2
123900170505             if pyad2 <> caddr2;
124000170505                oeFldv = 'ADDR2';
124100170505                oeBefore =  pyad2;
124200170505                oeAfter = %trim(caddr2);
124300170505                write WebTranr;
124400170501             EndIf;
124500170501
124600170501
124700170501             // City
124800170505             if pycty <> csCity;
124900170505                oeFldv = 'CITY';
125000170505                oeBefore =  pycty;
125100170505                oeAfter = %trim(cscity);
125200170505                write WebTranr;
125300170501             EndIf;
125400170501
125500170501             // State
125600170505             if pystt <> csState;
125700170505                oeFldv = 'STATE';
125800170505                oeBefore =  pystt;
125900170505                oeAfter = %trim(csState);
126000170505                write WebTranr;
126100170501             EndIf;
126200170505
126300170505             // Zip
126400170505             if pyzp5 <> %Subst(csZip:1:5) ;
126500170505                oeFldv = 'ZIP';
126600170505                oeBefore =  pyzp5;
126700170505                oeAfter = %Subst(csZip:1:5) ;
126800170505                write WebTranr;
126900170505             endif;
127000170501
127100170501          endif;
127200170501
127300170505
127400170505          //?Emp_Info Changes..
127500170505          oeGrpv = 'EMP_INFO';
127600170505
127700170505          if chkSalary = 'Y'  or chkJobt = 'Y';
127800170505
127900170505             //?Get Next Available transaction number.
128000170505             in *lock webdtaara;
128100170505             webdtaara = webdtaara + 1;
128200170505             out webdtaara;
128300170505
128400170505             oeTrn# = webdtaara;
128500170505
128600170505             // Write Header..
128700170505             if NeedHeader = 'Y';
128800170505                oeFldv = 'HEADER';
128900170505                write webtranr;
129000170505                NeedHeader = 'N';
129100170505
129200170505                oeFldv = 'CENSUS_UPLD';
129300170505                write webtranr;
129400170505             EndIf;
129500170505          endif;
129600170505
129700170505
129800170505          //?-------------------------
129900170505          //? Salary Change?
130000170505          //?-------------------------
130100170505          if chkSalary = 'Y';
130200170505             oeFldv = 'ANNUAL_SALARY';
130300170505             oeBefore =  %char(pyans);
130400170505
130500170505             // If there is a decimal point, remove it;
130600170505             // otherwise, add 2 zeros.
130700170505             if %Scan('.' : oeBefore) > 0;
130800170505                oeBefore = %scanrpl('.' : '' : oeBefore);
130900170505             else;
131000170505                oeBefore = %Trim(oeBefore) + '00';
131100170505             EndIf;
131200170505
131300170505
131400170505             oeAfter = %trim(cAnnSalary) ;
131500170505
131600170505
131700170505             // If there is a decimal point, remove it;
131800170505             // otherwise, add 2 zeros.
131900170505             if %Scan('.' : oeAfter) > 0;
132000170505                oeAfter = %scanrpl('.' : '' : oeAfter);
132100170505             else;
132200170505                oeAfter = %Trim(oeAfter) + '00';
132300170505             EndIf;
132400170505
132500170505             write WebTranr;
132600170505
132700170505
132800170505             oeFldv = 'PYSALDT';
132900170505             oeBefore =  %Char(pySalDt);
133000170505             oeAfter = %trim(cSalChgDt) ;
133100170505             write WebTranr;
133200170505
133300170505          EndIf;
133400170430
133500170430
133600170505          //?-------------------------
133700170505          //? Job Type Change?
133800170505          //?-------------------------
133900170505          if chkJobt = 'Y';
134000170505             oeFldv = 'PYOCC';
134100170505             oeBefore =  pyocc;
134200170505             oeAfter = %trim(cJobTitle) ;
134300170505             write WebTranr;
134400170505          EndIf;
134500170505
134600170505
134700170505         // Write History Transaction Record
134800170505         WEBTSUMR1(oessid);
134900170505
135000170430       endsr;
135100170807
135200170807      *-------------------------------------------------------------------------
135300170807       Begsr Build_Audit;
135400170807
135500170807          setll *loval Censusap;
135600170807          dou %eof( Censusap );
135700170807             read Censusap;
135800170807
135900170807             if %eof( Censusap );
136000170807                leave;
136100170807             endif;
136200170807
136300170807             if cHiredate = '18991231';
136400170807                cHireDate = *Blanks;
136500170807             endif;
136600170807
136700170807             if cbDate = '18991231';
136800170807                cbDate = *Blanks;
136900170807             endif;
137000170807
137100170807             if cSalChgDt = '18991231';
137200170807                cSalChgDt = *Blanks;
137300170807             endif;
137400170807             update Audit_r;
137500170807
137600170807             //?Get New Data
137700170807             savSSN = %Dec( cSocSec  : 9 : 0 );
137800170807
137900170807
138000170807
138100170807          enddo;
138200170807
138300170807
138400170807
138500170807
138600170807
138700170807       Endsr;
