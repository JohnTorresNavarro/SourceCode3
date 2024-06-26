000100181017
000200181017       Ctl-opt option(*noDebugIo)   DftActGrp(*no);
000300181017
000400181017      *-------------------------------------------------------------------------
000500181017      *
000600191125      *  Description: Manual Test Inbound File
000700181017      *  Programmer.: Brian Rees
000800191125      *  Date.......: 11/25/2019
000900181017      *
001000181017      *-------------------------------------------------------------------------
001100181017
001200181017      *-------------------------------------------------------------------------
001300181017      *
001400181017      * Declare Files
001500181017      *
001600181017      *-------------------------------------------------------------------------
001700191125       Dcl-f FT_I005D WorkStn
001800181017          Handler('PROFOUNDUI(HANDLER)');
001900181017
002000191125       dcl-f EmailAddr keyed;
002100181017
002200181017      *-------------------------------------------------------------------------
002300181017      *
002400181017      * Global Variables
002500181017      *
002600181017      *-------------------------------------------------------------------------
002700191125       dcl-ds pgmd
002701191125         ExtName('IOPGMD') PSDS;
002702191125         @pgmq *proc;
002703191125       end-ds;
002704191125
002705191125
002800181017       dcl-ds UploadFile Qualified  ;
002900191125         NumFiles Zoned(3);
003000191125         Directory Char(256);
003100191125         Files Char(256);
003200181017       End-Ds;
003300181017
003400181017       dcl-s myFileName Char(256) ;
003401191125
003402191125
003403191125       dcl-pr ft_i005c ExtPgm('FT_I005C');
003404191125         oemail Char(30);
003407191125       End-Pr;
003500181017
003600181017      *-------------------------------------------------------------------------
003700181017      *
003800181017      * Mainline Program
003900181017      *
004000181017      *-------------------------------------------------------------------------
004100181017
004101191202       Exec Sql
004102191202         Set Option Commit = *NONE, Naming = *SYS;
004103191202
004104191202       init();
004105191125
004200181017       Dou btnExit = *on;
004300191125         Exfmt Screen1;
004400160922
004500191125         if btnExit = *on;
004600191125           leave;
004700191125         endif;
004800160926
004900161103
005000191125         myFileName = UploadFile.Files;
005100181017
005200181017
005201191125         // Set Generic File Settings.
005203191202         exec sql
005204191202           update gbs0028p
005205191202             set apFileType = :s1FileType
005206191202             where apkey = '0000000000' ;
005207191125
005208191125
005209191202         exec sql
005210191202           update gbs0028e set aeEmail = :s1Email where aekey = '0000000000' ;
005213191125
005214191125
005215191125         ft_i005c( s1Email );
005216191125
005217191125
005300191125         leave;
005400181017       enddo;
005500160922
005600160926
005700160922       *inlr = *on;
005701191125
005702191125
005703191125
005704191125       //-----------------------------------------------------------------
005705191125       //
005706191125       //                     Initialize Routine
005707191125       //
005708191125       //-----------------------------------------------------------------
005709191125br02   Dcl-Proc Init;
005710191125
005713191125
005754191125         // Get Email Addrees
005755191125         chain wqusrn EmailAddr;
005756191125         if %Found( EmailAddr );
005757191202           exec sql
005758191202             set :s1email = lower(:eaEmail);
005760191125         endif;
005761191125
005762191125
005763191125       End-Proc;
