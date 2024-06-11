000100160928     H option(*noDebugIo)  DftActGrp(*no) BndDir('GBSBDIR')
000200160928      *-------------------------------------------------------------------------
000300160928      *
000400220907      *  Description: Create FTP Security Settings list
000500220907      *  Programmer.: Jon Allen
000600220907      *  Date.......: 09/07/2022
000700161007      *
000800161222      *  Description:
000900161222      *
001000161007      *
001100160928      *-------------------------------------------------------------------------
001200160928      * Modifications
001300160928      *
001400160928      * Date         Programmer    Mod      Description
001500160928      *-------------------------------------------------------------------------
001600160928      *
001700160928      *
001800160928      *-------------------------------------------------------------------------
001900220907     fFtpSec    if   e           k disk
002000220907     fFtpSecLst o  a e           k disk
002100161005
002200160218      *--------------------------------------------------------------------
002300161227     d oUser           s             40a
002400161227     d oPass           s             40a
002500170106     d oFolder         s            100a
002600220907     d myPassword      s             14a   inz
002700161223
002800161005      *-------------------------------------------------------------------------
002900160928      *?Mainline Program
003000161005      *-------------------------------------------------------------------------
003100220907       myPassWord = 'PineAppleAriel';
003200220907
003300220907         Setll *loval FtpSec;
003400220907         dou %Eof(FtpSec);
003500220907           read(n) FtpSec;
003600220907
003700220907           if %Eof(FtpSec);
003800220907             leave;
003900220907           endif;
004000220907
004100220907           FLName = ftName;
004200220907           FLUrl  = ftUrl;
004300220907           FLFolder = ftFolder;
004400220907           FLPORT = ftport;
004500220907           FLNOTES = ftnotes;
004600220907           FLCRTBY = ftcrtby;
004700220907           FLCRTDT = ftcrtdt;
004800220907           FLCRTTM = ftcrttm;
004900220907           FLCHGBY = ftchgby;
005000220907           FLCHGDT = ftchgdt;
005100220907           FLCHGTM = ftchgtm;
005200220907
005300220907           //?User ID
005400220907           Exec Sql
005500220907             Select Decrypt_Char(:Ftuser, :Mypassword)
005600220907               Into :FLuser
005700220907               From Sysibm/Sysdummy1;
005800220907
005900220907           //?Password
006000220907           Exec Sql
006100220907             Select Decrypt_Char(:Ftpass, :Mypassword)
006200220907               Into :FLpass
006300220907               From Sysibm/Sysdummy1;
006400220907
006500220907         write FTPSEC_R2;
006600220907
006700220907         enddo;
006800220907
006900220907       *inlr = *on;
007000220907
