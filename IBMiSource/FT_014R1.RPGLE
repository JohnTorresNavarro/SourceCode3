000100190815       Ctl-opt option(*noDebugIo)   DftActGrp(*no) bnddir('GBSBIND');
000200190722
000300190722      *-------------------------------------------------------------------------
000400190722      *
000500190823      *  Description: Scrub the ClaimDoc 834 File.
000600190722      *  Programmer.: Brian Rees
000700190722      *  Date.......: 07/22/2019
000800190722      *
000900210116      *  Notes: ClaimDoc requested that we send the department Information
001000210116      *         with the dependent data.
001100210115      *
001200190722      *-------------------------------------------------------------------------
001300190821       dcl-f Flat500p usage( *input : *update : *Delete );
001400210115       dcl-f Temp500p usage( *Output ) rename( r_Flat : x_Flat );
001500210115
001600190815
001700190722
001800190722      *-------------------------------------------------------------------------
001900190722      *
002000190722      * Global Variables
002100190722      *
002200190722      *-------------------------------------------------------------------------
002300210115       dcl-s RemoveCount Zoned(5) inz;
002400210116       dcl-s AddCount    Zoned(5) inz;
002500210115       dcl-s Ref0F_Sav like( Rcd );
002600210115       dcl-s Ref17_Sav like( Rcd );
002700210115       Dcl-s WriteDept Char(1);
002800210115
002900190722      *--------------------------------------------
003000190722      *
003100190722      * Procedures
003200190722      *
003300190722      *--------------------------------------------
003400190722       /include *LIBL/QMODSRC,#COMMANDPR         // Command
003500190815       /include GBSPGM/QMODSRC,#GettokPR
003600190722
003700190722
003800190722
003900190722
004000190722
004100190722      *-------------------------------------------------------------------------
004200190722      *
004300190722      * Mainline Program
004400190722      *
004500190722      *-------------------------------------------------------------------------
004600190722
004700190722
004800190821       Setll *Start Flat500p;
004900190815
005000190815
005100190821       Dou %Eof(Flat500p);
005200210115         read Flat500p;
005300210115         if %eof(Flat500p);
005400210115           leave;
005500210115         endif;
005600190815
005700210116
005800210116         //-------------------------------------------
005900210116         //
006000210115         //  Remove Hire Date  DTP*334*D8
006100210116         //
006200210116         //-------------------------------------------
006300210115         if %SubSt( Rcd : 1 : 10 ) = 'DTP*334*D8';
006400210115           RemoveCount = RemoveCount + 1;
006500210116           iter;
006600210115         EndIf;
006700190815
006800210115
006900210116         //-------------------------------------------
007000210116         //
007100210115         // Member Record
007200210116         //
007300210116         //-------------------------------------------
007400210115         if %SubSt( Rcd : 1 : 7 ) = 'REF*0F*';
007500210115
007600210116           WriteDept = 'N';
007700210115
007800210115           if REF0F_Sav = '';
007900210115             Ref0f_Sav =  Rcd;
008000210115
008100210116           else;
008200210116
008300210116             if Ref0f_Sav = Rcd;
008400210116               WriteDept = 'Y';
008500210116             EndIf;
008600210115
008700210116             Ref0f_sav = Rcd;
008800210116
008900210115           endif;
009000210115
009100210115         endif;
009200210115
009300210115
009400210116         //-------------------------------------------
009500210116         //
009600210116         // Get/Save the Department
009700210116         //
009800210116         //-------------------------------------------
009900210115         if %SubSt( Rcd : 1 : 7 ) = 'REF*17*';
010000210116           Ref17_sav = Rcd;
010100210116         endif;
010200210115
010300210115
010400210115
010500210115
010600210116         //-------------------------------------------
010700210116         //
010800210115         //  Update Count in SE*
010900210116         //
011000210116         //-------------------------------------------
011100210115         if %SubSt( Rcd : 1 : 3 ) = 'SE*';
011200210116           if RemoveCount > 0 or AddCount > 0;
011300210115             Split();
011400210115             update r_Flat;
011500210115             RemoveCount = 0;
011501210116             AddCount = 0;
011600210115           endif;
011700210115         EndIf;
011800190815
011900190815
012000210115
012100210116         write x_Flat;
012200190815
012300210115
012400210116         //-------------------------------------------
012500210116         //
012600210116         // Write Department for Dependent?
012700210116         //
012800210116         //-------------------------------------------
012900210116         if %SubSt( Rcd : 1 : 7 ) = 'REF*1L*' and
013000210116           WriteDept = 'Y';
013100210116
013200210116           Rcd = Ref17_sav;
013300210116           write x_Flat;
013400210116           AddCount = AddCount + 1;
013500210116
013600210116
013700210116           WriteDept = '';
013800210116
013900210116         EndIf;
014000210116
014100210115
014200190815
014300190815       Enddo;
014400190815
014500190815
014600190815
014700190815
014800190722
014900190722       *inlr = *on;
015000190815
015100190815
015200190815      *-------------------------------------------------------------------------
015300190815      *
015400190815      * Split out the account number
015500190815      *
015600190821      *-------------------------------------------------------------------------
015700190815       Dcl-Proc Split;
015800190815
015900190815         dcl-s x int(10);
016000190815         dcl-s tokens varchar(100) dim(50);
016100190815         dcl-s wCount int(10);
016200190815         dcl-s wLine  Char(10);
016300190815
016400190815         tokens(*) = #Gettok( Rcd : '*' : x );
016500190815
016600190815
016700190815         // we should have 3 array elements filled  in.
016800190815         // the next blank space should be #4.
016900190815         x = %lookup( '' : tokens ) ;
017000190815         if x = 4;
017100190815           wCount = %Dec(Tokens(2):10:0);
017200190815
017300190815
017400190815           wLine = Tokens(3);
017500190815
017600190815           Rcd = %Trim(Tokens(1)) + '*' +
017700210116                 %Char(wCount -  RemoveCount + AddCount)  + '*' +
017800190815                 wLine;
017900190815
018000190815         EndIf;
018100190815
018200190815
018300190815       End-Proc;
