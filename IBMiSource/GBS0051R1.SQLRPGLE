000100180724       Ctl-opt option(*noDebugIo)   DftActGrp(*no)
000200190122         bnddir( 'GBSBIND' );
000300180607
000400180607      *-------------------------------------------------------------------------
000500180607      *
000600181211      *  Description: This will look through the intercept file that we
000700190610      *  are storing in PAYFILESH. This will allow us to run them manually
000800181211      *  if needed.
000900181211      *
001000180607      *  Programmer.: Brian Rees
001100190610      *  Date.......: 06/10/2019
001200180607      *
001300181211      *  To Compile:
001400190610      *   DspObjd Obj(PayFilesH/*all) ObjType(*File)
001500181105      *     Output(*Outfile) Outfile(Qtemp/Pay_Objd)
001600181105      *
001700181105      *
001800181105      *
001900180607      *-------------------------------------------------------------------------
002000180607
002100180607      *-------------------------------------------------------------------------
002200180607      *
002300180607      * Declare Files
002400180607      *
002500180607      *-------------------------------------------------------------------------
002600190610       Dcl-f GBS0051D1 WorkStn
002700190122         Handler('PROFOUNDUI(HANDLER)')
002800190122         SFILE(LstSFL:rrn);
002900181105
003000181105       dcl-f pay_objd UsrOpn;
003100181105
003200181105
003300180607      *-------------------------------------------------------------------------
003400180607      *
003500180607      * Global Variables
003600180607      *
003700180607      *-------------------------------------------------------------------------
003800180725
003900181105       dcl-s SqlStmt Char( 500 );
004000181105       dcl-s SqlStmt2 Char( 500 );
004100181105       dcl-s rrn Zoned(5);
004200181105       dcl-s reload Char(1);
004300190612       dcl-c q '''';
004400180824
004500180824
004600180724      *-------------------------------------------------------------------------
004700180724      *
004800180724      * Procedures
004900180724      *
005000180724      *-------------------------------------------------------------------------
005100181105      /include *LIBL/QMODSRC,#COMMANDPR        // Command
005200181105
005300181204
005400181204
005500181105
005600180607      *-------------------------------------------------------------------------
005700180607      *
005800180607      * Mainline Program
005900180607      *
006000180607      *-------------------------------------------------------------------------
006100180824
006200190612        Exec Sql
006300190612           Set Option Commit = *None, Naming = *Sys;
006400190612
006500181105       Reload = 'Y';
006600181105
006700181105       Dou btnExit = *on;
006800181105
006900190122         If Reload = 'Y';
007000190122           ClearS1();
007100190122           LoadS1();
007200190122           Reload = 'N';
007300190122         endIf;
007400181105
007500190122         DisplyS1();
007600181105
007700181105
007800190122         //?Process Selections
007900190122         Select;
008000190122         When btnRefresh = *on;
008100190122           reload = 'Y';
008200181211
008300190122         other;
008400190122           ReadChangedS1();
008500181105
008600190122         EndSl;
008700181105
008800181105
008900181105       enddo;
009000181105
009100181105       *inlr = *on;
009200181105
009300181105
009400181105
009500181105       // ----------------------------------------------------------------
009600181105       dcl-proc CLEARS1;
009700181105
009800190122         //-------------------------
009900190122         //
010000190122         // Clear the Subfile
010100190122         //
010200190122         //-------------------------
010300181105
010400190122         ClrSfl = *on;
010500190122         Write Screen1;
010600190122         ClrSfl = *off;
010700190122         rrn = 0;
010800181105
010900181105       End-Proc;
011000181105
011100181105       // ----------------------------------------------------------------
011200181105       Dcl-Proc LoadS1;
011300181105
011400181105
011500190122         CmdString = 'DspObjd ' +
011600190610           'Obj(PayFilesh/*all) ObjType(*File) ' +
011700190122           'Output(*Outfile) Outfile(Qtemp/Pay_Objd)';
011800181105
011900190122         monitor;
012000190122
012100190122           #Command(CmdString:%len(%Trim(CmdString)));
012200190122         on-error;
012300190122
012400190612           return;
012500190122
012600190122         EndMon;
012700181105
012800181105
012900190122         open Pay_Objd;
013000181105
013100190122         Setll 1 Pay_Objd;
013200190122         Dou %eof(Pay_Objd);
013300181105
013400190122           read Pay_Objd;
013500190122           if %eof(Pay_Objd);
013600190122             leave;
013700190122           endif;
013800181105
013900190122           s1obow = odobow;
014000181105
014100190122           s1FileName = odobnm;
014200190610           s1FileDate = '20' +  %Subst( odCDat : 5 : 2 ) +
014300190612             %Subst( odCDat : 1 : 4 ) ;
014400190610
014500190610
014600190122           //------------------------------
014700190122           //
014800190122           // Get File Amount
014900190122           //
015000190122           //------------------------------
015100190611           s1Amount = 0;
015200190611
015300190612
015400190612           if %subst( s1FileName : 1 : 2 ) = 'RD' or
015500190612             %subst( s1FileName : 1 : 2 ) = 'AW';
015600190612
015700190612             SqlStmt =
015800190612               'Select sum( bkamt ) From Payfilesh.' + odobnm;
015900181105
016000190612
016100190612           else;
016200190612             SqlStmt =
016300190612               'Select  sum( substring(' + %trim(odobnm) + ',28,8)) / 100' +
016400190612               ' from payfilesh.' + odobnm +
016500190612               ' Where Substring(' + %trim(odobnm)+ ',1,1)' +
016600190612               ' not in (' + q + 'H' + q + ',' + q + 'T' + q + ')';
016700190612
016800190612
016900190612           endif;
017000190612
017100190612
017200190612
017300190612           Exec Sql
017400190612              Declare c1 Cursor For sqlstmt;
017500190612           Exec Sql
017600190612              Prepare sqlstmt From :sqlstmt;
017700190612
017800190612
017900190612
018000190612           Exec Sql
018100190612              Open c1;
018200190612
018300190612           dou SqlCod <> *Zero;
018400190612             Exec Sql
018500190612                Fetch Next From c1 Into :s1amount;
018600190612
018700190612             If Sqlcod <> *Zero;
018800190612               Leave;
018900190612             endif;
019000190612
019100190612             leave;
019200190612
019300190612           enddo;
019400190612           Exec Sql
019500190612              Close c1;
019600181105
019700181105
019800181105
019900190122           rrn = rrn + 1;
020000190122           write LstSfl;
020100181105
020200181105
020300190122           If rrn >= 9999;
020400190122             leave;
020500190122           endIf;
020600181105
020700190122         enddo;
020800190122         close Pay_Objd;
020900181105
021000181105
021100181105       End-Proc;
021200181105
021300181105       // ----------------------------------------------------------------
021400181105       Dcl-Proc DisplyS1;
021500181105
021600190122         DspSfl = *on  ;
021700190122         exfmt Screen1;
021800190122         DspSfl = *off;
021900181105
022000181105       End-Proc;
022100181105
022200181105       // ----------------------------------------------------------------
022300181105       Dcl-Proc ReadChangedS1;
022400181105
022500190612         dcl-s sqlCommand Char(500);
022600181105
022700190122         Dou *in95 = *ON;
022800190122           READC LstSfl;
022900190122           *in95 = %EOF;
023000181105
023100190122           If *in95 = *OFF;
023200181105
023300181105
023400190122             if btnView = *on;
023500181105
023600190612               if %subst( s1FileName : 1 : 2 ) = 'RD' or
023700190612                 %subst( s1FileName : 1 : 2 ) = 'AW';
023800190612
023900190612                 s2FileName = 'PAYFILESH/' + s1FileName;
024000190612                 exfmt Screen2;
024100190612
024200190612               else;
024300190612
024400190612                 s4sql = 'Select substring(' + %trim(s1FileName)+ ',1,10),' +
024500190612                   ' substring(' + %trim(s1FileName)+ ',11,10),' +
024600190612                   ' substring(' + %trim(s1FileName)+ ',21,3),' +
024700190612                   ' substring(' + %trim(s1FileName)+ ',24,4),' +
024800190612                   ' substring(' + %trim(s1FileName)+ ',28,6) ||' +
024900190612                   q + '.' + q + '||' +
025000190612                   ' substring(' + %trim(s1FileName)+ ',34,2),'  +
025100190612                   ' substring(' + %trim(s1FileName)+ ',36,10),' +
025200190612                   ' substring(' + %trim(s1FileName)+ ',46,8),' +
025300190612                   ' substring(' + %trim(s1FileName)+ ',54,10)' +
025400190612                   ' From payfilesh.'+ %trim( s1FileName) +
025500190612                   ' Where Substring( ' + %trim( s1FileName) + ',1,1)' +
025600190612                   ' not in (' + q + 'H' + q + ',' + q + 'T' + q + ')';
025700190612
025800190612                 Exfmt Screen4;
025900190612
026000190612
026100190612               endif;
026200181105
026300190122             endIf;
026400181105
026500181105
026600190611             if btnDelete = *on;
026700190611
026800190612               CmdString = 'Dltf payfilesh/' + %Trim( s1FileName );
026900190612               #Command(CmdString:%len(%Trim(CmdString)));
027000190611
027100190611             EndIf;
027200181105
027300190611
027400190611
027500190122             if runOption = 'DelFile';
027600190122               exfmt Screen3;
027700190122               if btnCont = *on;
027800181105
027900190611                 CmdString = 'Dltf payfilesh/' + %Trim( s1FileName );
028000190122                 #Command(CmdString:%len(%Trim(CmdString)));
028100190612                 Reload = 'Y';
028200181105
028300190122               EndIf;
028400190122             EndIf;
028500181105
028600190612
028700190612             if runOption = 'PrepFile';
028800190612               CmdString = 'cpyf payfilesh/' + %Trim( s1FileName ) +
028900190612                 ' payfiles/' + %Trim( s1FileName ) + 'R CrtFile(*Yes)';
029000190612               #Command(CmdString:%len(%Trim(CmdString)));
029100190612
029200190612
029300190612
029400190612               sqlCommand = 'update payfiles/' +  %Trim( s1FileName ) + 'R' +
029500190612               ' set bkamt = bkamt * -1 ';
029600190612             Exec Sql
029700190612                Prepare sqlcommand From :sqlcommand;
029800190612
029900190612             Exec Sql
030000190612                Execute sqlcommand;
030100190612
030200190612
030201220316              // For file that are NOT intercept, prefix the check number
030202220316              // with '99'   -- Intercept Files start with AW
030203220316              if %Subst( s1FileName : 1 : 2 ) <> 'AW';
030204220316
030206220316
030207220316               sqlCommand = 'update payfiles/' +  %Trim( s1FileName ) + 'R' +
030208220316               ' set bkChk# = ' +
030209220316               ' case ' +
030210220316               '  When bkChk# < 99       then 9900       + bkChk# '+
030211220316               '  When bkChk# < 999      then 99000      + bkChk# '+
030212220316               '  When bkChk# < 9999     then 990000     + bkChk# '+
030213220316               '  When bkChk# < 99999    then 9900000    + bkChk# '+
030214220316               '  When bkChk# < 999999   then 99000000   + bkChk# '+
030215220316               '  When bkChk# < 9999999  then 990000000  + bkChk# '+
030216220316               '  When bkChk# < 99999999 then 9900000000 + bkChk# '+
030217220316               ' else bkChk#  end ';
030218220316
030219220316
030220220316             Exec Sql
030221220316                Prepare sqlcommand From :sqlcommand;
030222220316
030223220316             Exec Sql
030224220316                Execute sqlcommand;
030225220316
030226220316
030227220316              EndIf;
030228220316
030229220316
030300190612
030400190612             endif;
030500190612
030600190612
030700181105
030800190612             selrow = '';
030900190612           runOption = '';
031000190612           btnExit = *off;
031100190612         btnView = *off;
031200190612         update LstSfl;
031300181105
031400190612       endIf;
031500181105
031600190612       enddo;
031700181105
031800181105       End-Proc;
031900181105
032000180917
