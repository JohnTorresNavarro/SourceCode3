000100170510     H option(*noDebugIo)  DftActGrp(*No)  BndDir('GBSBIND')
000200151221      *-------------------------------------------------------------------------
000300170511      * Overview:
000400220626      *  Delete expired files in input file IFSCLNLST (they come from
000500220626      *  epdf\USERSPDF\Archive)
000600170511      *
000700170511      *
000800170728      *  Programmer: B.Rees
000900170831      *  Date:       8/31/2017
001000170511      *
001100220626      * 06/21/22 dlk - change archive folder time from 60 days to 2 years
001200220626      *                30 days.
001300220626      *                Only change here is to documentation. Retention time
001400220626      *                changed in CL that calls this and fills IFSCLNLST
001500220626      *
001600151221      *-------------------------------------------------------------------------
001700151221
001800170831      *?For Split Function
001900170831     D x               S             10i 0
002000170831     D y               S             10i 0
002100170831     D tokens          s            100A   varying dim(50)
002200170831     d Sub_Dir         s            100a
002300170831
002400170831     D IFS_Path        s            300A
002500170831     D BlankPos        S             10i 0
002600170831     D FullPath        s            300A
002700170510
002800170831
002900151221      *-------------------------
003000151221      *?Procedure(s)
003100151221      *-------------------------
003200170831     D/include GBSPGM/QMODSRC,IFSAPI_H
003300170831     D/include *LIBL/QMODSRC,#COMMANDPR        // Get Token (Split)
003400151221
003500151221
003600170831
003700170508      *-----------------------------------------------------------------
003800170508      *? Main Program
003900170508      *-----------------------------------------------------------------
004000170831
004100170831          Exec Sql
004200170831             Declare C1 Cursor For
004300170831             Select * From IFSCLNLST;
004400170831          Exec Sql    Open C1;
004500170511
004600170831
004700170831         Dou SqlCod <> *Zero;
004800170831            Exec Sql  Fetch Next From C1 Into :IFS_Path;
004900170831
005000170831            if SqlCod <> *Zero;
005100170831               leave;
005200170831            endif;
005300170831
005400170831
005500170831           //?Delete the file from the main location
005600170831           CmdString = 'Del ObjLnk(' + q +  %Trim(ifs_Path) + q + ') ';
005700170831           #Command(CmdString:%len(%Trim(CmdString)));
005800170831
005900170831
006000170831         enddo;
006100170831
006200170831         Exec Sql  Close C1;
006300170831
006400170728
006500170728       *inlr =*on;
006600170510
006700170728
006800170508      /COPY GBSPGM/QMODSRC,IFSAPI_P
