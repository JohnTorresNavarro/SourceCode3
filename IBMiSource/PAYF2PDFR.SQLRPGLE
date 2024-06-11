000100200501       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200200501
000300180607
000400180607      *-------------------------------------------------------------------------
000500180607      *
000600200501      *  Description: Read the Payroll file output and generate PDF's
000700180607      *
000800180607      *  Programmer.: Brian Rees
000900200501      *  Date.......: 05/01/2020
001000181210      *
001100181002      *  Notes:  .15 is a line down
001200181002      *
001300181002      *
001400180607      *-------------------------------------------------------------------------
001500210413      * Modifications
001600210413      *
001700210413      * 04/13/2021   B.Rees   Added Payroll Vendor to the Footer.
001800210511      * 05/11/2021   B.Rees   Added Environment Flag. Only Print the Changes.
001801210728      * 07/28/2021   B.Rees   Added a log to track changes for the AA
001900210728      *   File: PayfSts  PayFile Stats
002000210413      *-------------------------------------------------------------------------
002100180607
002200180607      *-------------------------------------------------------------------------
002300180607      *
002400180607      * Declare Files
002500180607      *
002600180607      *-------------------------------------------------------------------------
002700200501       dcl-f Payf2pdfp usage( *output );
002800200501       dcl-f adpOutputp;
002900210413       dcl-f gbs0028p keyed;
003000210413       dcl-f gbs0030l1 keyed;
003001210728
003002210728       dcl-f PayFSts usage( *update: *output: *input );
003100210728       dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
003101210728
003200180607      *-------------------------------------------------------------------------
003300180607      *
003400180607      * Global Variables
003500180607      *
003600180607      *-------------------------------------------------------------------------
003700200501       dcl-s wPage Zoned(5);
003800210413       dcl-s wKey  Char(20);
003900210413
004000200501
004100181120      *-------------------------------------------------------------------------
004200181120      *
004300181120      * *Entry Procedure
004400181120      *
004500181120      *-------------------------------------------------------------------------
004600200501       Dcl-pr Main ExtPgm;
004700200501         *N  Char(150);
004800200501         *n  char(10);
004900210511         *n  char(1);
005000200501       End-Pr;
005100200501
005200200501       dcl-pi Main;
005300200501         iFileName Char(150);
005400200501         iKey      Char(10);
005500210511         iEnvir    Char(1);
005600200501       End-Pi;
005700200501
005800200501
005900180824
006000180724      *-------------------------------------------------------------------------
006100180724      *
006200180724      * Procedures
006300180724      *
006400180724      *-------------------------------------------------------------------------
006500180824
006600181126
006700180607      *-------------------------------------------------------------------------
006800180607      *
006900180607      * Mainline Program
007000180607      *
007100180607      *-------------------------------------------------------------------------
007200200501       iFileName = %ScanRpl('.csv':'.pdf':iFileName);
007300200501
007400200501       hAcct = 'Account: ' + %Subst(iKey:1:3) + '-'
007500200501         + %Subst(iKey:4:3) + '-'
007600200501         + %Subst(iKey:7:4) ;
007700210413
007800210413       hVend = '';
007900210413       wKey = iKey;
008000210413
008100210413       chain iKey gbs0028p;
008200210413       if apGroupKey > '';
008300210413         wKey = apGroupKey;
008400210413       endif;
008500210413
008600210413       chain wKey gbs0030l1;
008700210413       if %Found( gbs0030l1 );
008800210413         hVend = 'Payroll Vendor: ' + %Trim( ftPayVend );
008900210413       endif;
009000210413
009100210413
009101210728       // Payroll Stats Data...
009103210728       psTrst = %Dec( %Subst( iKey : 1 : 3) : 3 : 0 );
009104210728       psSub# = %Dec( %Subst( iKey : 4 : 3) : 3 : 0 );
009105210728       psAcct= %Dec( %Subst( iKey : 7 : 4) : 4 : 0 );
009106210728
009107210728       chain ( psTrst : psSub# : psAcct ) AccMst;
009108210728       if %Found( AccMst ) ;
009109210728         psActName = acNam1;
009110210728       EndIf;
009111210728
009112210728       psPayVend = ftPayVend;
009113210728       psDate = %Dec(%Date);
009114210728       psTime = %Dec(%Time);
009115210728       psEnVir = iEnvir;
009116210728
009117210728       psMbrCnt = 0;
009118210728       psDtlLine = 0;
009119210728
009120210728       Exec Sql
009121210728       Select Trim(afnam) || ' ' || Trim(alnam)
009122210728       Into :psaaname
009123210728       From aacode
009124210728        Where acode = (Select aacode
009125210728          From "F.ACCMST"
009126210728          Where actrst = :pstrst And
009127210728                acsub# = :pssub# And
009128210728                acacct = :psacct);
009129210728
009130210728
009131210728
009200210728       //----------------------------------------------------
009201210728       //
009202210728       //  Read throuch the Output File.
009203210728       //
009204210728       //----------------------------------------------------
009300200501       Setll *Start ADPOutputp;
009400200501
009500200501       Dou %Eof(ADPOutputp);
009600200501         read ADPOutputp;
009700200501         if %eof(ADPOutputp);
009800200501           leave;
009900200501         endif;
010000200501
010100210511         // For Production files, if the changed
010200210511         // Flag isn't turned on, Skip it.
010300210511         if iEnvir = 'P' and oChgd = '';
010400210728           iter;
010500210511         endif;
010600200501
010700210511
010800200501         if oType = 'Member:';
010900200501           Header_Line();
010901210728           psMbrCnt = psMbrCnt + 1;
011000200501         endif;
011100200501
011200210601         if oType > '' or oInfo > '' or oChgd > '';
011300200501           Detail_Line();
011301210728           psDtlLine = psDtlLine + 1;
011400200501         endif;
011500200501
011600200501       Enddo;
011700200501
011800200501
011801210728       Write r_PayfSts;
011900200501       *inlr = *on;
012000200501
012100200501
012200200501
012300200501       //-----------------------------------------------------------------
012400200501       //
012500200501       // Header..
012600200501       //
012700200501       //-----------------------------------------------------------------
012800200501       dcl-proc Header_Line;
012900200501
013000200501         dcl-s oText Char(100);
013100200501         dcl-s len Zoned(3);
013200200501         dcl-s Start Zoned(3);
013300200501
013400200501         wPage = wPage + 1;
013500200501         hPage = 'Page: ' + %Trim(%editc(wPage :'J'));
013600200501
013700200501         hFileName = %Subst(iFileName:6);
013800200501         hFileName = %ScanRpl( '.pdf' : '' : hFileName );
013900200501
014000200501         // Center the Heading.
014100200501         oText = '';
014200200501         len = %Len(%Trim( hFileName ));
014300200501         Start = ((100 - len )/ 2) + 1;
014400200501         %Subst( oText : Start : len ) =
014500200501          %Subst( %Trim(hFileName) : 1 : len );
014600200501
014700200501         hFileName = otext;
014800200501
014900200501         Write Header1;   // New Page
015000200501         Write Header;
015100200501
015200200501         pos = .90;
015300200501
015400200501       end-proc;
015500200501
015600200501
015700200501       //-----------------------------------------------------------------
015800200501       //
015900200501       // Detail..
016000200501       //
016100200501       //-----------------------------------------------------------------
016200200501       dcl-proc Detail_Line;
016300200501
016400200501         dcl-s savInfo like(oInfo);
016500200501
016600200501         dcl-s wPlan  like(oInfo);
016700200501         dcl-s wEffDt like(oInfo);
016800200501         dcl-s wEnrl  like(oInfo);
016900200501         dcl-s wBene  like(oInfo);
017000201104         dcl-s wEOI   Like(oInfo);
017100201124         dcl-s wTerm  Like(oInfo);
017200201124         dcl-s wQE    Like(oInfo);
017300201104
017400200501         dcl-s location Zoned(5);
017500200514
017600200514
017700200514         if %Subst( oInfo : 1 : 16 ) = 'Election Amount:';
017800200514           oInfo = '    * ' + oInfo;
017900200514         EndIf;
018000200501
018100200501         // Split out the Plan information into multiple lines.
018200200501         if %Subst( oInfo : 1 : 5 ) = 'Plan:';
018300200501           savInfo = oInfo;
018400200501
018500200501           //----------------------
018600200501           // Split Plan Data.
018700200501           //----------------------
018800200501           Select;
018900200501
019000200501           // Searching in order of the text
019100200501           when %scan('Effective Date:': savInfo ) > 0;
019200200501             wPlan = %subst(SavInfo:1:
019300200501                      %scan('Effective Date:': savInfo)-1);
019400200501
019500200514           // Searching in order of the text
019600200514           when %scan('Enrollment Date:': savInfo ) > 0;
019700200514             wPlan = %subst(SavInfo:1:
019800200514                      %scan('Enrollment Date:': savInfo)-1);
019900200514
020000200501           when %scan('Enrollment Lvl:': savInfo ) > 0;
020100200501             wPlan = %subst(SavInfo:1:
020200200501                      %scan('Enrollment Lvl:': savInfo)-1);
020300200501
020400200514           when %scan('Tier Level:': savInfo ) > 0;
020500200514             wPlan = %subst(SavInfo:1:
020600200514                      %scan('Tier Level:': savInfo)-1);
020700200501
020800200501           when %scan('Benefit Amount:': savInfo ) > 0;
020900200501             wPlan = %subst(SavInfo:1:
021000200501                      %scan('Benefit Amount:': savInfo)-1);
021100200501
021200201104           when %scan('Requested Amount:': savInfo ) > 0;
021300201104             wPlan = %subst(SavInfo:1:
021400201104                      %scan('Requested Amount': savInfo)-1);
021500201104
021600201124           when %scan('Term Date:': savInfo ) > 0;
021700201124             wPlan = %subst(SavInfo:1:
021800201124                      %scan('Term Date': savInfo)-1);
021900201124
022000201124           when %scan('Qualified Event:': savInfo ) > 0;
022100201124             wPlan = %subst(SavInfo:1:
022200201124                      %scan('Qualified Event': savInfo)-1);
022300201124
022400201104
022500200501           other ;
022600200501
022700200501             wPlan = %subst(SavInfo:1);
022800200501           EndSl;
022900200501
023000200501
023100200501           //----------------------
023200200514           // Find Enrollment Date.
023300200501           //----------------------
023400200514           Location =  %scan('Enrollment Date:': savInfo);
023500200501
023600200501           if Location > 0;
023700200501
023800200501             Select;
023900200501
024000200501             // Searching in order of the text
024100200514             when %scan('Tier Level:': savInfo ) > 0;
024200200501               wEffDt = %subst(SavInfo:Location:
024300200514                        %scan('Tier Level:': savInfo)-1 - location);
024400200501
024500200501
024600200501             when %scan('Benefit Amount:': savInfo ) > 0;
024700200501               wEffDt = %subst(SavInfo:Location:
024800200501                        %scan('Benefit Amount:': savInfo)-1-location);
024900200501
025000201104
025100201104             when %scan('Requested Amount:': savInfo ) > 0;
025200201104               wEffDt = %subst(SavInfo:Location:
025300201104                        %scan('Requested Amount': savInfo)-1-Location);
025400201104
025500201124             when %scan('Term Date:': savInfo ) > 0;
025600201124               wEffDt = %subst(SavInfo:Location:
025700201124                        %scan('Term Date': savInfo)-1- location);
025800201124
025900201124             when %scan('Qualified Event:': savInfo ) > 0;
026000201124               wEffDt = %subst(SavInfo:Location:
026100201124                        %scan('Qualified Event': savInfo)-1- location);
026200201124
026300200501             other;
026400200501               wEffDt = %subst(SavInfo:Location);
026500200501
026600200501
026700200501             EndSl;
026800200501
026900200501           endif;
027000200501
027100200514
027200200514
027300200514           //----------------------
027400200514           // Find Effective Date.
027500200514           //----------------------
027600200514           Location =  %scan('Effective Date:': savInfo);
027700200514
027800200514           if Location > 0;
027900200514
028000200514             Select;
028100200514
028200200514             // Searching in order of the text
028300200514             when %scan('Enrollment Lvl:': savInfo ) > 0;
028400200514               wEffDt = %subst(SavInfo:Location:
028500200514                        %scan('Enrollment Lvl:': savInfo)-1 - location);
028600200514
028700200514
028800200514             when %scan('Benefit Amount:': savInfo ) > 0;
028900200514               wEffDt = %subst(SavInfo:Location:
029000200514                        %scan('Benefit Amount:': savInfo)-1-location);
029100200514
029200201104             when %scan('Requested Amount:': savInfo ) > 0;
029300201104               wEffDt = %subst(SavInfo:Location:
029400201104                        %scan('Requested Amount': savInfo)-1-Location);
029500201104
029600201124             when %scan('Term Date:': savInfo ) > 0;
029700201124               wEffDt = %subst(SavInfo:Location:
029800201124                        %scan('Term Date': savInfo)-1- location);
029900201124
030000201124             when %scan('Qualified Event:': savInfo ) > 0;
030100201124               wEffDt = %subst(SavInfo:Location:
030200201124                        %scan('Qualified Event': savInfo)-1- location);
030300201124
030400200514             other;
030500200514               wEffDt = %subst(SavInfo:Location);
030600200514
030700200514
030800200514             EndSl;
030900200514
031000200514           endif;
031100200514
031200200514
031300200501           //----------------------
031400200514           // Find Tier Level
031500200501           //----------------------
031600200514           Location =  %scan('Tier Level:': savInfo);
031700200501
031800200501           if Location > 0;
031900200501
032000200501             Select;
032100200501
032200200501             when %scan('Benefit Amount:': savInfo ) > 0;
032300200501               wEnrl = %subst(SavInfo:Location:
032400200501                        %scan('Benefit Amount:': savInfo)-1-location);
032500201104
032600201104             when %scan('Requested Amount:': savInfo ) > 0;
032700201104               wEnrl = %subst(SavInfo:Location:
032800201104                        %scan('Requested Amount': savInfo)-1-Location);
032900201104
033000201124             when %scan('Term Date:': savInfo ) > 0;
033100201124               wEnrl = %subst(SavInfo:Location:
033200201124                        %scan('Term Date': savInfo)-1- location);
033300201124
033400201124             when %scan('Qualified Event:': savInfo ) > 0;
033500201124               wEnrl = %subst(SavInfo:Location:
033600201124                        %scan('Qualified Event': savInfo)-1- location);
033700201124
033800200501             other;
033900200501               wEnrl = %subst(SavInfo:Location);
034000200501             EndSl;
034100200501
034200200501           endif;
034300200501
034400200514
034500200514           //----------------------
034600200514           // Find Enrollment Level.
034700200514           //----------------------
034800200514           Location =  %scan('Enrollment Lvl:': savInfo);
034900200514
035000200514           if Location > 0;
035100200514
035200200514             Select;
035300200514
035400200514             when %scan('Benefit Amount:': savInfo ) > 0;
035500200514               wEnrl = %subst(SavInfo:Location:
035600200514                        %scan('Benefit Amount:': savInfo)-1-location);
035700201104
035800201104             when %scan('Requested Amount:': savInfo ) > 0;
035900201104               wEnrl = %subst(SavInfo:Location:
036000201104                        %scan('Requested Amount': savInfo)-1-Location);
036100201104
036200201124             when %scan('Term Date:': savInfo ) > 0;
036300201124               wEnrl = %subst(SavInfo:Location:
036400201124                        %scan('Term Date': savInfo)-1- location);
036500201124
036600201124             when %scan('Qualified Event:': savInfo ) > 0;
036700201124               wEnrl = %subst(SavInfo:Location:
036800201124                        %scan('Qualified Event': savInfo)-1- location);
036900201124
037000200514             other;
037100200514               wEnrl = %subst(SavInfo:Location);
037200200514             EndSl;
037300200514
037400200514           endif;
037500200514
037600200501
037700200501           //----------------------
037800200501           // Find Benefit Amount .
037900200501           //----------------------
038000200501           Location =  %scan('Benefit Amount:': savInfo);
038100201104
038200201104           if location > 0   ;
038300201104             Select;
038400201104             when %scan('Requested Amount:': savInfo ) > 0;
038500201104               wBene = %subst(SavInfo:Location:
038600201104                        %scan('Requested Amount': savInfo)-1-Location);
038700201104
038800201124             when %scan('Term Date:': savInfo ) > 0;
038900201124               wBene = %subst(SavInfo:Location:
039000201124                        %scan('Term Date': savInfo)-1- location);
039100201124
039200201124             when %scan('Qualified Event:': savInfo ) > 0;
039300201124               wBene = %subst(SavInfo:Location:
039400201124                        %scan('Qualified Event': savInfo)-1- location);
039500201124
039600201104             other;
039700201104               wBene = %subst(SavInfo:Location);
039800201104             endsl;
039900201104           endif;
040000200501
040100200501
040200201104           //----------------------
040300201124           // Find Term Dates
040400201104           //----------------------
040500201124           Location =  %scan('Term Date:' : savInfo);
040600201104
040700201104           if Location > 0;
040800201124             select;
040900201124
041000201124             when %scan('Qualified Event:': savInfo ) > 0;
041100201124               wTerm = %subst(SavInfo:Location:
041200201124                        %scan('Qualified Event': savInfo)-1-Location);
041300201124             other;
041400201124
041500201124               wTerm = %subst(SavInfo:Location);
041600201124             endsl;
041700201104           endif;
041800201104
041900201104
042000201124           //----------------------
042100201124           // Find EOI Amount .
042200201124           //----------------------
042300201124           Location =  %scan('Requested Amount:' : savInfo);
042400201124
042500201124           if Location > 0;
042600201124             select;
042700201124
042800201124             when %scan('Term Date:': savInfo ) > 0;
042900201124               wBene = %subst(SavInfo:Location:
043000201124                        %scan('Term Date': savInfo)-1- location);
043100201124
043200201124             when %scan('Qualified Event:': savInfo ) > 0;
043300201124               wBene = %subst(SavInfo:Location:
043400201124                        %scan('Qualified Event': savInfo)-1- location);
043500201124             other;
043600201124
043700201124               wEOI = %subst(SavInfo:Location);
043800201124             endsl;
043900201124           endif;
044000201124
044100201124
044200201124           //----------------------
044300201124           // Find Qualified Event
044400201124           //----------------------
044500201124           Location =  %scan('Qualified Event:' : savInfo);
044600201124
044700201124           if Location > 0;
044800210728             wQE = %subst(SavInfo:Location);
044900201124           endif;
045000201124
045100201124
045200201104
045300200501           // Print Each Found Element.
045400200501           d_Type = oType;
045500200501
045600201104           if wPlan > '';
045700200501             d_Info = wPlan;
045800200501             pos = pos + .20;
045900201104             if pos >= 9.90;
046000201104               Header_Line();
046100200501             EndIf;
046200201104             Write r_Detail;
046300200501           EndIf;
046400200501
046500201104           if wEffDt > '';
046600200501             d_Info = '     * ' + %trim(wEffDt);
046700200501             pos = pos + .20;
046800201104             Write r_Detail;
046900200501           EndIf;
047000200501
047100201104           if wEnrl > '';
047200200501             d_Info = '     * ' + %trim(wEnrl);
047300200501             pos = pos + .20;
047400201104             Write r_Detail;
047500200501           EndIf;
047600200501
047700201104           if wBene > '';
047800200501             d_Info = '     * ' + %trim(wBene);
047900200501             pos = pos + .20;
048000201104             Write r_Detail;
048100200501           EndIf;
048200201104
048300201104           if wEOI > '';
048400201104             d_Info = '     * ' + %trim(wEOI);
048500201104             pos = pos + .20;
048600201104             Write r_Detailb;
048700201104           EndIf;
048800201104
048900201124           if wTerm > '';
049000201124             d_Info = '     * ' + %trim(wTerm);
049100201124             pos = pos + .20;
049200201124             Write r_Detail;
049300201124           EndIf;
049400201124
049500201124           if wQE > '';
049600201124             d_Info = '     * ' + %trim(wQE);
049700201124             pos = pos + .20;
049800201124             Write r_Detail;
049900201124           EndIf;
050000201124
050100201104
050200201104         else;
050300200501
050400200501           d_Type = oType;
050500200501           d_Info = oInfo;
050600200501
050700201104           if pos >= 9.90;
050800201104             Header_Line();
050900200501           EndIf;
051000200501           pos = pos + .20;
051100201104           Write r_Detail;
051200200501
051300201104         EndIf;
051400200501
051500200501
051600200501
051700200501
051800200501       end-proc;
