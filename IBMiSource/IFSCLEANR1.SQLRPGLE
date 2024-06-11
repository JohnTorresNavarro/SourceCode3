000100170510     H option(*noDebugIo)  DftActGrp(*No)  BndDir('GBSBIND')
000200151221      *-------------------------------------------------------------------------
000300170511      * Overview:
000400220626      *  Move expired files in input file IFSCLNLST (they come from
000500220626      *  epdf\USERSPDF\*USERNAME*) to epdf\USERSPDF\Archive\*USERNAME*
000600170511      *
000700170728      *  Programmer: B.Rees
000800170831      *  Date:       8/31/2017
000900170511      *
001000220626      * 06/21/22 dlk - change retention time from 30 days to 2 years.
001100220626      *                Only change here is to documentation. Retention time
001200220626      *                changed in CL that calls this and fills IFSCLNLST
001300220626      *
001400151221      *-------------------------------------------------------------------------
001500151221
001600170831      *?For Split Function
001700170831     D x               S             10i 0
001800170831     D y               S             10i 0
001900170831     D tokens          s            100A   varying dim(50)
002000170831     d Sub_Dir         s            100a
002100170831
002200170831     D IFS_Path        s            300A
002300170831     D BlankPos        S             10i 0
002400170831     D FullPath        s            300A
002500170510
002600170831
002700151221      *-------------------------
002800151221      *?Procedure(s)
002900151221      *-------------------------
003000170831     D/include GBSPGM/QMODSRC,IFSAPI_H
003100170831     D/include *LIBL/QMODSRC,#GettokPR         // Get Token (Split)
003200170831     D/include *LIBL/QMODSRC,#COMMANDPR        // Get Token (Split)
003300151221
003400151221
003500170831     D mkdir           PR            10I 0 ExtProc('mkdir')
003600170831     D   path                          *   Value options(*string)
003700170831     D   mode                        10U 0 Value
003800170831
003900170831
004000170508      *-----------------------------------------------------------------
004100170508      *? Main Program
004200170508      *-----------------------------------------------------------------
004300170831
004400170831          Exec Sql
004500170831             Declare C1 Cursor For
004600170831             Select * From IFSCLNLST;
004700170831          Exec Sql    Open C1;
004800170511
004900170831
005000170831         Dou SqlCod <> *Zero;
005100170831            Exec Sql  Fetch Next From C1 Into :IFS_Path;
005200170831
005300170831            if SqlCod <> *Zero;
005400170831               leave;
005500170831            endif;
005600170831
005700170831
005800170831           //?Split out the path name.
005900170831           x = 1;
006000170831           tokens(*) = #Gettok( IFS_Path : '/' : x );
006100170831
006200170831
006300170831
006400170831           //?Get the first array element that has a
006500170831           //?blank value ?Needed for the FOR Loop
006600170831           BlankPos = %lookup( ' ' : Tokens );
006700170906           FullPath = '/epdf/USERSPDF/Archive';
006800170831
006900170831
007000170831           //?Skip the Archive folder
007100170831           if tokens(3) = 'Archive';
007200170831              iter;
007300170831           endif;
007400170831
007500170831
007600170831           //?Loop through the sub-directories
007700170831           //?starting with User Name...
007800170831           //?We are skipping the file name.
007900170831           for y = 3 to (BlankPos - 2);
008000170831              if tokens(y) > *Blanks;
008100170831
008200170831                 Sub_Dir = tokens(y);
008300170831                 FullPath = %Trim(FullPath) + '/' + %Trim(Sub_Dir);
008400170831
008500170831                 //?Create the directory if needed.
008600170831                 mkdir( %Trim(FullPath) :
008700170831                   S_IRUSR + S_IWUSR + S_IXUSR +
008800170831                   S_IRGRP + S_IWGRP + S_IXGRP +
008900170831                   S_IROTH + S_IXGRP)  ;
009000170831
009100170831              endif;
009200170831           endfor;
009300170831
009400170831
009500170831           //?Copy the file to the archive folder.
009600170831           CmdString = 'Cpy Obj(' + q +  %Trim(ifs_Path) + q + ') ' +
009700170831                       'toDir(' + q +  %Trim(FullPath) + q + ') ' +
009800170831                       'Replace(*yes)';
009900170831           #Command(CmdString:%len(%Trim(CmdString)));
010000170831
010100170831
010200170831           //?Delete the file from the main location
010300170831           CmdString = 'Del ObjLnk(' + q +  %Trim(ifs_Path) + q + ') ';
010400170831           #Command(CmdString:%len(%Trim(CmdString)));
010500170831
010600170831
010700170831         enddo;
010800170831
010900170831         Exec Sql  Close C1;
011000170831
011100170728
011200170728       *inlr =*on;
011300170510
011400170728
011500170508      /COPY GBSPGM/QMODSRC,IFSAPI_P
