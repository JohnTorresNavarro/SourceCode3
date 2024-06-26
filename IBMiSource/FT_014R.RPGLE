000100190815       Ctl-opt option(*noDebugIo)   DftActGrp(*no) bnddir('GBSBIND');
000200190722
000300190722      *-------------------------------------------------------------------------
000400190722      *
000500190823      *  Description: Scrub the ClaimDoc 834 File.
000600190722      *  Programmer.: Brian Rees
000700190722      *  Date.......: 07/22/2019
000800190722      *
000900190722      *-------------------------------------------------------------------------
001000190821       dcl-f Flat500p usage( *input : *update : *Delete );
001100190815
001200190815
001300190722
001400190722      *-------------------------------------------------------------------------
001500190722      *
001600190722      * Global Variables
001700190722      *
001800190722      *-------------------------------------------------------------------------
001900190815         dcl-s RemoveCount Zoned(5) inz;
002000190722
002100190722      *--------------------------------------------
002200190722      *
002300190722      * Procedures
002400190722      *
002500190722      *--------------------------------------------
002600190722       /include *LIBL/QMODSRC,#COMMANDPR         // Command
002700190815       /include GBSPGM/QMODSRC,#GettokPR
002800190722
002900190722
003000190722
003100190722
003200190722
003300190722      *-------------------------------------------------------------------------
003400190722      *
003500190722      * Mainline Program
003600190722      *
003700190722      *-------------------------------------------------------------------------
003800190722
003900190722
004000190821       Setll *Start Flat500p;
004100190815
004200190815
004300190821       Dou %Eof(Flat500p);
004400190821          read Flat500p;
004500190821          if %eof(Flat500p);
004600190815             leave;
004700190815          endif;
004800190815
004900190815          //  Remove Hire Date  DTP*334*D8
005000190815          if %SubSt( Rcd : 1 : 10 ) = 'DTP*334*D8';
005100190815              RemoveCount = RemoveCount + 1;
005200190821              Delete r_Flat;
005300190815          EndIf;
005400190815
005500190815
005600190815          //  Update Count in SE*
005700190815          if %SubSt( Rcd : 1 : 3 ) = 'SE*';
005800190815            if RemoveCount > 0;
005900190815              Split();
006000190815              update r_Flat;
006100190815              RemoveCount = 0;
006200190815            endif;
006300190815          EndIf;
006400190815
006500190815
006600190815
006700190815
006800190815
006900190815       Enddo;
007000190815
007100190815
007200190815
007300190815
007400190722
007500190722       *inlr = *on;
007600190815
007700190815
007800190815      *-------------------------------------------------------------------------
007900190815      *
008000190815      * Split out the account number
008100190815      *
008200190821      *-------------------------------------------------------------------------
008300190815       Dcl-Proc Split;
008400190815
008500190815         dcl-s x int(10);
008600190815         dcl-s tokens varchar(100) dim(50);
008700190815         dcl-s wCount int(10);
008800190815         dcl-s wLine  Char(10);
008900190815
009000190815         tokens(*) = #Gettok( Rcd : '*' : x );
009100190815
009200190815
009300190815         // we should have 3 array elements filled  in.
009400190815         // the next blank space should be #4.
009500190815         x = %lookup( '' : tokens ) ;
009600190815         if x = 4;
009700190815           wCount = %Dec(Tokens(2):10:0);
009800190815
009900190815
010000190815           wLine = Tokens(3);
010100190815
010200190815           Rcd = %Trim(Tokens(1)) + '*' +
010300190815                 %Char(wCount -  RemoveCount)  + '*' +
010400190815                 wLine;
010500190815
010600190815         EndIf;
010700190815
010800190815
010900190815       End-Proc;
