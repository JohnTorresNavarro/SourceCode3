000100151216     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200141211    ? *-------------------------------------------------------------------------
000300000000    ? *
000400160906    ? *  Description:  VSP File Transfer Maintenance
000500141210    ? *  Programmer.:  Brian Rees
000600151216    ? *  Date.......:  12/16/2015
000700141210    ? *
000800160803    ? *? note:  To Compile, run this program first:
000900160906    ? *?  Call GBS0011C3A
001000160803    ? *
001100141211    ? *-------------------------------------------------------------------------
001200160906    ?FGBS0011D3 CF   E             WORKSTN
001300141211    ?F                                     SFILE(LSTSFL:rrn)
001400000000    ?F                                     INFDS(DSPD)
001500160802     F
001600160802br01 FFTPOUTPUT IF   E           K DISK    ExtDesc('QTEMP/FTPOUTPUT')
001700160802     F                                     ExtFile(*extdesc) UsrOpn
001800141211    ? *-------------------------------------------------------------------------
001900000000    ? * Program status data structure
002000141212    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
002100160729     D  @pgmq            *proc
002200141212
002300000000    ? * Display file data structure
002400141212    ?D DSPD            DS
002500141212     D  Key                  369    369
002600141212     D  Currec               378    379b 0
002700141211
002800141211    ? * Variables
002900141211     D F03             C                   CONST(X'33')
003000141218     D F10             C                   CONST(X'3A')
003100151216     D F12             C                   CONST(X'3C')
003200141212     D Enter           C                   const(X'F1')
003300141211
003400141212
003500151216     d Rrn             s              5s 0 inz
003600151216     d SaveCursPos     S              4S 0
003700151216     d ReLoad          s              1
003800151216     d hldSearch       S                   like(mySearch)
003900151216
004000151216      *--------------------------------------------
004100151216      *?Procedures
004200151216      *--------------------------------------------
004300160802     D/include gbspgm/QMODSRC,PR0001RPR            // Case Functions
004400160802     D/include gbspgm/QMODSRC,ExtFilexPr           // Extract File Extension
004500151217
004600160802
004700160906     d Get_File        pr                  ExtPgm('GBS0011C3B')
004800160803     d  oFileName                   100
004900160803     d oFileName       s            100
005000160802
005100160906     d CreateFTPLst    pr                  ExtPgm('GBS0011C3A')
005200160906     d View_Data       pr                  ExtPgm('GBS0011R4')
005300160802
005400141211    ? *-------------------------------------------------------------------------
005500151216      *?Mainline Program
005600141211    ? *-------------------------------------------------------------------------
005700141211      /Free
005800151216
005900160803       // Create the FTP List.
006000160803       CreateFTPLst();
006100160803
006200151216       Dow key <> F03;
006300151216
006400151216
006500151216          If HldSearch <> mySearch or Reload = 'Y';
006600151216             HldSearch= mySearch;
006700151216             exsr CLEAR;
006800151216             exsr LOAD;
006900151216             Reload = 'N';
007000151216          endIf;
007100151216
007200151216
007300151216          exsr DISPLY;
007400151216
007500151216          //?Process Selections
007600151216          Select;
007700160801
007800151216          When key = ENTER and Rrn > 0;
007900151216             exsr PROCES;
008000151216
008100151216          EndSl;
008200151216       enddo;
008300151216
008400151216       *inlr = *on;
008500151216
008600151216      // ----------------------------------------------------------------
008700151216       Begsr *Inzsr;
008800151216
008900151216         Reload = 'Y';
009000151216
009100160729
009200151216       Endsr;
009300151216       // ----------------------------------------------------------------
009400151216       Begsr CLEAR;
009500151216
009600151216           RcdNbr = 1;
009700151216           If SaveCursPos > 0;
009800151216              RcdNbr = SaveCursPos;
009900151216              SaveCursPos = 0;
010000151216           endIf;
010100151216
010200151216           // Clear the Subfile.
010300151216           *in31 = *off;                     // Subfile Display
010400151216           *in32 = *off;                     // Subfile Disp Control
010500151216           *in33 = *on;                      // Subfile Clear
010600151216
010700151216           write LstCtl;
010800151216
010900151216           *in31 = *off;                     // Subfile Display
011000151216           *in32 = *on;                      // Subfile Disp Control
011100151216           *in33 = *off;                     // Subfile Clear
011200151216           rrn = 0;
011300151216
011400151216       Endsr;
011500151216       // ----------------------------------------------------------------
011600151216
011700151216         Begsr Load;
011800151216
011900160802            open FtpOutput;
012000160802
012100151216            *in37 = *off;
012200160802            dou %eof(FtpOutput);
012300160802               read FtpOutput;
012400151216
012500160802               If %Eof(FtpOutput);
012600151216                  *in37 = *on;
012700151216                  leave;
012800151216               endIf;
012900151216
013000160802               s1Date = %SubSt(ftpout:1:8);
013100160802               s1Time = %SubSt(ftpout:11:7);
013200160802               s1FileName = %SubSt(ftpout:40:52);
013300160802
013400160802                //?Skip Extensions..
013500160802                if uCase(ExtFilExt( s1FileName )) <> '';
013600160802                   iter;
013700160802                endif;
013800160802
013900160802
014000151216                If mySearch = *Blanks;
014100151216                   rrn = rrn + 1;
014200151216                   write LstSfl;
014300151216                endIf;
014400151216
014500151216
014600151216                If mySearch > *Blanks;
014700160802                   If %Scan( %Trim(mySearch) : s1Date ) > 0  or
014800160802                      %Scan( %Trim(mySearch) : s1Time ) > 0  or
014900160802                      %Scan( %Trim(mySearch) : s1FileName ) > 0 ;
015000151216                      rrn = rrn + 1;
015100151216                      write LstSfl;
015200151216                   endIf;
015300151216                endIf;
015400151216
015500151216                If rrn >= 9999;
015600151216                   leave;
015700151216                endIf;
015800151216
015900151216            enddo;
016000160802            close FtpOutput;
016100151216
016200151216         Endsr;
016300151216
016400151216       // ----------------------------------------------------------------
016500151216       Begsr DISPLY;
016600151216
016700151216          If rrn = 0;
016800151216             *in31 = *off;
016900151216             write NoRcd;
017000151216             reload = 'Y';
017100151216          endIf;
017200151216
017300151216          If rrn > 0;
017400151216             write Cmd;
017500151216             *in31 = *on;
017600151216          endIf;
017700151216
017800151216          EXFMT LstCtl;
017900151216
018000151216
018100151216       Endsr;
018200151216       // ----------------------------------------------------------------
018300151216       Begsr PROCES;
018400151216
018500151216          Dou *in95 = *ON;
018600151216             READC LstSfl;
018700151216             *in95 = %EOF;
018800151216
018900151216             If *in95 = *OFF;
019000151216                SaveCursPos = rrn;
019100151216
019200151216
019300160803                If s1Opt  = '5';
019400160803                   oFileName = s1FileName;
019500160803                   get_File(oFileName);
019600160803                   View_Data();
019700160803                endIf;
019800160803
019900151217
020000151216                s1Opt = '';
020100151216                update LstSfl;
020200151216                Reload = 'Y';
020300151216             endIf;
020400151216
020500151216          enddo;
020600151216       Endsr;
020700151216
