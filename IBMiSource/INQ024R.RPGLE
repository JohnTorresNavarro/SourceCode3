000100200207       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200171229
000300171229      *-------------------------------------------------------------------------
000400171229      *
000500200207      *  Description: Related Accounts
000600200207      *  Date.......: 02/07/2020
000601200207      *  Programmer.: Brian Rees
000700171229      *
000800171229      *-------------------------------------------------------------------------
000900171229
001000180115
001100171229      *-------------------------------------------------------------------------
001200171229      *
001300171229      * Declare Files
001400171229      *
001500171229      *-------------------------------------------------------------------------
001600200207       Dcl-f INQ024D WorkStn
001700190102         Handler('PROFOUNDUI(HANDLER)')
001800200207         SFILE(LstSfl:rrn);
001900200207
002000200207       Dcl-f ACRELATP keyed ExtDesc('F.ACRELATP') ExtFile(*extdesc);
002001200207       Dcl-f AccMst   keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
002100190423
002200170525
002300171229      *-------------------------------------------------------------------------
002400171229      *
002500171229      * Global Variables
002600171229      *
002700171229      *-------------------------------------------------------------------------
002800171229       Dcl-s rrn Zoned(5) inz;
003200180315       dcl-s refresh ind;
004500180306
004600190731
004700190731
004800190731      *-------------------------------------------------------------------------
004900190731      *
005000190731      * *Entry Procedure
005100190731      *
005200190731      *-------------------------------------------------------------------------
005300200207       Dcl-pr Main ExtPgm;
005400200207        *N  Zoned(3);
005401200207        *N  Zoned(3);
005402200207        *N  Zoned(4);
005500200207        *N  Char(1);
005600200207       End-Pr;
005700200207
005800200207       dcl-pi Main;
005900200207         pTrst Zoned(3);
005901200207         pSub# Zoned(3);
005902200207         pAcct Zoned(4);
006000200207         pCancel Char(1);
006100200207       End-Pi;
006200190517
006300180316
006400171229      *-------------------------------------------------------------------------
006500171229      *
006600171229      * Mainline Program
006700171229      *
006800171229      *-------------------------------------------------------------------------
006801200207
006802200207       pCancel = 'Y';
006803200207       Dou btnExit = *on;
006804200207
006805200207         ClearS1();
006806200207         LoadS1();
006810200207         DisplyS1();
006811200207
006812200207         if btnExit = *on;
006813200207           pCancel = 'Y';
006814200207           leave;
006815200207         EndIf;
006816200207
006822200207         ReadChangedS1();
006823200207
006824200207         if pCancel = 'N';
006825200207           leave;
006826200207         EndIf;
006827200207
006828200207
006829200207       enddo;
006830200207
006831200207       *inlr = *on;
006832200207
006833200207
006834200207
006835200207       // ----------------------------------------------------------------
006836200207       dcl-proc CLEARS1;
006837200207
006838200207         //-------------------------
006839200207         //
006840200207         // Clear the Subfile
006841200207         //
006842200207         //-------------------------
006843200207
006844200207         ClrSfl = *on;
006845200207         Write Screen1;
006846200207         ClrSfl = *off;
006847200207         rrn = 0;
006848200207
006849200207       End-Proc;
006850200207       // ----------------------------------------------------------------
006851200207       Dcl-Proc LoadS1;
006852200207
006853200207         Setll ('F' : pTrst : pSub# : pAcct ) ACRELATP;
006854200207         Dou %eof(ACRELATP);
006855200207
006856200207           reade ('F' : pTrst : pSub# : pAcct ) ACRELATP;
006857200207           if %eof(ACRELATP);
006858200207             leave;
006859200207           endif;
006860200207
006861200207           s1Trst = arTrstx;
006862200207           s1Sub# = arSub#x;
006863200207           s1Acct = arAcctx;
006864200207
006865200207           s1AcctName = '';
006866200207           chain ( s1Trst : s1Sub# : s1Acct ) AccMst;
006867200207           if %Found( AccMst ) ;
006868200207             s1AcctName = acNam1;
006869200207           EndIf;
006870200207
006871200207           s1FulAct = %Editc(s1Trst:'X') + '-' +
006872200207                      %Editc(s1Sub#:'X') + '-' +
006873200207                      %Editc(s1Acct:'X') ;
006874200207
006875200608           RowColor = '#000000';
006877200608              if acdltd = 'C';
006878200608           RowColor = '#FF0000';
006879200608         endif;
006880200608
006881200207           rrn = rrn + 1;
006882200207           write LstSfl;
006883200207
006884200207
006885200207           If rrn >= 9999;
006886200207             leave;
006887200207           endIf;
006888200207
006889200207         enddo;
006890200207
006891200207       End-Proc;
006892200207
006893200207       // ----------------------------------------------------------------
006894200207       Dcl-Proc DisplyS1;
006895200207
006896200207         DspSfl = *on  ;
006897200207         exfmt Screen1;
006898200207         DspSfl = *off;
006899200207
006900200207       End-Proc;
006901200207
006902200207       // ----------------------------------------------------------------
006903200207       Dcl-Proc ReadChangedS1;
006904200207
006905200207         Dou *in95 = *ON;
006906200207           READC LstSfl;
006907200207           *in95 = %EOF;
006908200207
006909200207           If *in95 = *OFF;
006910200207
006911200207              pTrst = s1Trst;
006912200207              pSub# = s1Sub#;
006913200207              pAcct = s1Acct;
006914200207              pCancel = 'N';
006915200207
006916200207           endIf;
006917200207
006918200207         enddo;
006919200207
006920200207       End-Proc;
