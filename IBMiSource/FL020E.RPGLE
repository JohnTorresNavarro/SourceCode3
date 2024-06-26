000100190425       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000200180607
000300180607      *-------------------------------------------------------------------------
000400180607      *
000500201211      *  Description: Subdivision List - Excel Format
000600190401      *
000700180607      *
000800201211      *  Programmer.: John Torres
000900201211      *  Date.......: 12/22/2020
001000180607      *
001100201211      *  This will read the data from the work file and write/Create the XLS File.
001200190429      *
001300201211      *-------------------------------------------------------------------- -----
001600180607      *
001700180607      * Declare Files
001800180607      *
001900201211      *----------------------------------------------------- -------------------
002000200820
002100201211       Dcl-f fl020l WorkStn
002200190429         Handler('UNIVERSAL(HANDLER)') ;
002300190402
002400201211       dcl-f fl021;       // Criteria
002500201211       dcl-f fl020 keyed;
002600180607
002601201211      *-------------------------------------------------------- -----------------
002602200826
002603201211       //Dcl-pr Main ExtPgm;
002604201211       //  *N  Char(7) options(*Nopass);
002605201211       //End-Pr;
002606200826
002607201211       //dcl-pi rp135e;
002608201211       //  orderby Char(7) options(*Nopass);
002609201211       //End-Pi;
002610200826
003800190402      *-------------------------------------------------------------------------
003900190402      *
004000190402      * Mainline Program
004100180607      *
004200180607      *-------------------------------------------------------------------------
004300190429
004301200826       //type = 'T';
004302200826
004400190429       Write Header;
004500200819       Write Criteria_H;
004600200819
004700200819
004800200819       // Criteria Page...
004900200819
005000201211       Setll *Start fl021;
005300201211       read  fl021;
005301200826       Dow not %Eof;
005400190429
005900200819         write Criteria_d;
006000190429
006001201211         read  fl021;
006200190429       Enddo;
006300190429
006400200819       write Criteria_F;
006500190429
006600200819
006700200819       //-----------------------------------------------
006800200819       //
006900200819       // Detail Sheet....
007000200819       //
007100200819       //-----------------------------------------------
007200200819
007300201211         Setll *loval fl020;
007301201211         read  fl020;
007400201211
007500201211         Dow not %Eof;
007700200819
008200201211          write Detail;
008300201211
008403201211         read  fl020;
008406200826
008500201211         Enddo;
008600200819
008700201211         write Footer;
008800200819
008900190429       *inlr = *on;
009000190429
