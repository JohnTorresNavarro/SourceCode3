000100200501       Ctl-opt option(*noDebugIo)   DftActGrp(*no)  ;
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
001900210413      *
002000210413      *-------------------------------------------------------------------------
002100180607
002200180607      *-------------------------------------------------------------------------
002300180607      *
002400180607      * Declare Files
002500180607      *
002600180607      *-------------------------------------------------------------------------
002700200501       dcl-f Payf2pdfp usage( *output ) usropn;
002800200501       dcl-f adpOutputp;
002900210413       dcl-f gbs0028p keyed;
003000210413       dcl-f gbs0030l1 keyed;
003100180607
003200180607      *-------------------------------------------------------------------------
003300180607      *
003400180607      * Global Variables
003500180607      *
003600180607      *-------------------------------------------------------------------------
003700200501       dcl-s wPage Zoned(5);
003800200501       dcl-s FileName Char(50);
003900210413       dcl-s wKey  Char(20);
004000200501
004100200501      *-------------------------------------------------------------------------
004200200501      *
004300200501      * Procedures
004400200501      *
004500200501      *-------------------------------------------------------------------------
004600200501      /include *LIBL/QMODSRC,#COMMANDPR
004700200501
004800181120      *-------------------------------------------------------------------------
004900181120      *
005000181120      * *Entry Procedure
005100181120      *
005200181120      *-------------------------------------------------------------------------
005300200501       Dcl-pr Main ExtPgm;
005400200501         *N  Char(18);
005500200501         *n  char(10);
005600210511         *n  char(1);
005700200501       End-Pr;
005800200501
005900200501       dcl-pi Main;
006000200501         iFolder  Char(18);
006100200501         iKey     Char(10);
006200210511         iEnvir    Char(1);
006300200501       End-Pi;
006400200501
006500200501
006600180824
006700180724      *-------------------------------------------------------------------------
006800180724      *
006900180724      * Procedures
007000180724      *
007100180724      *-------------------------------------------------------------------------
007200180824
007300181126
007400180607      *-------------------------------------------------------------------------
007500180607      *
007600180607      * Mainline Program
007700180607      *
007800180607      *-------------------------------------------------------------------------
007900200501       hAcct = 'Account: ' + %Subst(iKey:1:3) + '-'
008000200501         + %Subst(iKey:4:3) + '-'
008100200501         + %Subst(iKey:7:4) ;
008200200501
008300210413
008400210413       hVend = '';
008500210413       wKey = iKey;
008600210413
008700210413       chain iKey gbs0028p;
008800210413       if apGroupKey > '';
008900210413         wKey = apGroupKey;
009000210413       endif;
009100210413
009200210413       chain wKey gbs0030l1;
009300210413       if %Found( gbs0030l1 );
009400210413         hVend = 'Payroll Vendor: ' + %Trim( ftPayVend );
009500210413       endif;
009600210413
009700210413
009800200501
009900200501       Setll *Start ADPOutputp;
010000200501
010100200501       Dou %Eof(ADPOutputp);
010200200501         read ADPOutputp;
010300200501         if %eof(ADPOutputp);
010400200501           leave;
010500200501         endif;
010600200501
010700210511
010800210511         // For Production files, if the changed
010900210511         // Flag isn't turned on, Skip it.
011000210511         if iEnvir = 'P' and oChgd = '';
011100210511            iter;
011200210511         endif;
011300200501
011400200501         if oType = 'Member:';
011500200501           open Payf2pdfp;
011600200501           wPage = 0;
011700200501
011800200501           FileName = 'PAYF_' + iKey + '_' + %Subst(oInfo:1:3) +
011900200501             %Subst(oInfo:5:2) +
012000200501             %Subst(oInfo:8:4) +  '_' + %Char(%Dec(%Date)) + '.pdf';
012100200501
012200200501           Header_Line();
012300200501         endif;
012400200501
012500200501         if oType > '' or oInfo > '';
012600200501           Detail_Line();
012700200501         endif;
012800200501
012900200501
013000200501         if oType = '' and oInfo = '';
013100200501           close Payf2pdfp;
013200200501           CreatePDF();
013300200501         endif;
013400200501
013500200501
013600200501
013700200501       Enddo;
013800200501
013900200501
014000200501       *inlr = *on;
014100200501
014200200501
014300200501
014400200501       //-----------------------------------------------------------------
014500200501       //
014600200501       // Header..
014700200501       //
014800200501       //-----------------------------------------------------------------
014900200501       dcl-proc Header_Line;
015000200501
015100200501         dcl-s oText Char(100);
015200200501         dcl-s len Zoned(3);
015300200501         dcl-s Start Zoned(3);
015400200501
015500200501         wPage = wPage + 1;
015600200501         hPage = 'Page: ' + %Trim(%editc(wPage :'J'));
015700200501
015800200501         hFileName = FileName;
015900200501
016000200501         // Center the Heading.
016100200501         oText = '';
016200200501         len = %Len(%Trim( hFileName ));
016300200501         Start = ((100 - len )/ 2) + 1;
016400200501         %Subst( oText : Start : len ) =
016500200501          %Subst( %Trim(hFileName) : 1 : len );
016600200501
016700200501         hFileName = otext;
016800200501
016900200501         Write Header1;   // New Page
017000200501         Write Header;
017100200501
017200200501         pos = .90;
017300200501
017400200501       end-proc;
017500200501
017600200501
017700200501       //-----------------------------------------------------------------
017800200501       //
017900200501       // Detail..
018000200501       //
018100200501       //-----------------------------------------------------------------
018200200501       dcl-proc Detail_Line;
018300200501
018400200501         dcl-s savInfo like(oInfo);
018500200501
018600200501         dcl-s wPlan  like(oInfo);
018700200501         dcl-s wEffDt like(oInfo);
018800200501         dcl-s wEnrl  like(oInfo);
018900200501         dcl-s wBene  like(oInfo);
019000200501
019100200501         dcl-s location Zoned(5);
019200200501
019300200501
019400200501         // Split out the Plan information into multiple lines.
019500200501         if %Subst( oInfo : 1 : 5 ) = 'Plan:';
019600200501           savInfo = oInfo;
019700200501
019800200501           //----------------------
019900200501           // Split Plan Data.
020000200501           //----------------------
020100200501           Select;
020200200501
020300200501           // Searching in order of the text
020400200501           when %scan('Effective Date:': savInfo ) > 0;
020500200501             wPlan = %subst(SavInfo:1:
020600200501                      %scan('Effective Date:': savInfo)-1);
020700200501
020800200501           when %scan('Enrollment Lvl:': savInfo ) > 0;
020900200501             wPlan = %subst(SavInfo:1:
021000200501                      %scan('Enrollment Lvl:': savInfo)-1);
021100200501
021200200501
021300200501           when %scan('Benefit Amount:': savInfo ) > 0;
021400200501             wPlan = %subst(SavInfo:1:
021500200501                      %scan('Benefit Amount:': savInfo)-1);
021600200501
021700200501           other ;
021800200501
021900200501             wPlan = %subst(SavInfo:1);
022000200501           EndSl;
022100200501
022200200501
022300200501           //----------------------
022400200501           // Find Effective Date.
022500200501           //----------------------
022600200501           Location =  %scan('Effective Date:': savInfo);
022700200501
022800200501           if Location > 0;
022900200501
023000200501             Select;
023100200501
023200200501             // Searching in order of the text
023300200501             when %scan('Enrollment Lvl:': savInfo ) > 0;
023400200501               wEffDt = %subst(SavInfo:Location:
023500200501                        %scan('Enrollment Lvl:': savInfo)-1 - location);
023600200501
023700200501
023800200501             when %scan('Benefit Amount:': savInfo ) > 0;
023900200501               wEffDt = %subst(SavInfo:Location:
024000200501                        %scan('Benefit Amount:': savInfo)-1-location);
024100200501
024200200501             other;
024300200501               wEffDt = %subst(SavInfo:Location);
024400200501
024500200501
024600200501             EndSl;
024700200501
024800200501           endif;
024900200501
025000200501           //----------------------
025100200501           // Find Enrollment Level.
025200200501           //----------------------
025300200501           Location =  %scan('Enrollment Lvl:': savInfo);
025400200501
025500200501           if Location > 0;
025600200501
025700200501             Select;
025800200501
025900200501             when %scan('Benefit Amount:': savInfo ) > 0;
026000200501               wEnrl = %subst(SavInfo:Location:
026100200501                        %scan('Benefit Amount:': savInfo)-1-location);
026200200501             other;
026300200501               wEnrl = %subst(SavInfo:Location);
026400200501             EndSl;
026500200501
026600200501           endif;
026700200501
026800200501
026900200501           //----------------------
027000200501           // Find Benefit Amount .
027100200501           //----------------------
027200200501           Location =  %scan('Benefit Amount:': savInfo);
027300200501
027400200501           if Location > 0;
027500200501             wBene = %subst(SavInfo:Location);
027600200501           endif;
027700200501
027800200501
027900200501
028000200501           // Print Each Found Element.
028100200501           d_Type = oType;
028200200501
028300200501           if wPlan > '';
028400200501             d_Info = wPlan;
028500200501             pos = pos + .20;
028600200501             if pos >= 9.90;
028700200501               Header_Line();
028800200501             EndIf;
028900200501             Write r_Detail;
029000200501           EndIf;
029100200501
029200200501           if wEffDt > '';
029300200501             d_Info = '     * ' + %trim(wEffDt);
029400200501             pos = pos + .20;
029500200501             Write r_Detail;
029600200501           EndIf;
029700200501
029800200501           if wEnrl > '';
029900200501             d_Info = '     * ' + %trim(wEnrl);
030000200501             pos = pos + .20;
030100200501             Write r_Detail;
030200200501           EndIf;
030300200501
030400200501           if wBene > '';
030500200501             d_Info = '     * ' + %trim(wBene);
030600200501             pos = pos + .20;
030700200501             Write r_Detail;
030800200501           EndIf;
030900200501
031000200501         else;
031100200501
031200200501           d_Type = oType;
031300200501           d_Info = oInfo;
031400200501
031500200501           if pos >= 9.90;
031600200501             Header_Line();
031700200501           EndIf;
031800200501           pos = pos + .20;
031900200501           Write r_Detail;
032000200501
032100200501         EndIf;
032200200501
032300200501
032400200501       end-proc;
032500200501
032600200501
032700200501
032800200501
032900200501       // ----------------------------------------------------------------
033000200501       dcl-proc CreatePDF;
033100200501
033200200501         dcl-c q '''';
033300200501         dcl-c ValidChars 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-
033400200501                            abcdefghijklmnopqrstuvwxyz-
033500200501                            0123456789_.';
033600200501         dcl-s tempString Char(50);
033700200501         dcl-s i int(10);
033800200501
033900200501
034000200501         //--------------------------
034100200501         // Clean up the String
034200200501         //--------------------------
034300200501         tempString = FileName;
034400200501         i = %check( validChars : tempString);
034500200501
034600200501         dow i > 0;
034700200501           tempString = %subst(tempString:1:i-1) + %subst(tempString:i+1);
034800200501           i = %check(validChars:tempString);
034900200501         EndDo;
035000200501
035100200501         FileName = tempString;
035200200501
035300200501
035400200501
035500200501         cmdstring = 'CpySplf File(Payf2pdfp) toFile(*TOSTMF) ' +
035600200501           ' SPLNBR(*LAST) WSCST(*PDF) ' + ' Tostmf(' + q + ifolder +
035700200501           '/' + %trim(filename)
035800200501           + q + ')';
035900200501
036000200501
036100200501         #Command(CmdString:%len(%Trim(CmdString)));
036200200501
036300200501
036400200501         CmdString = 'DLTSPLF File(Payf2pdfp) SPLNBR(*LAST)';
036500200501         #Command(CmdString:%len(%Trim(CmdString)));
036600200501
036700200501
036800200501       end-proc;
