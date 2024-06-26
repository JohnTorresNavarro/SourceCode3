000100221108       Ctl-opt option(*noDebugIo)   DftActGrp(*no) bnddir('GBSBIND') ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400220411      *
000500220415      *  Description: Populate Has Data
000600211216      *  Programmer.: Jon Allen
000700220415      *  Date.......: 04/15/2022
000800191115      *
000900191203      *
001000191115      *-------------------------------------------------------------------------
001100220415       dcl-f amw0001p usage( *Input : *Update ) Keyed;
001200220415       dcl-f amw0002p usage( *Input: *Update ) keyed;
001300191115
001400221108      /Include *LIBL/QMODSRC,#aacolorPr            // Get AA Color
001500220415
001600191115      *-------------------------------------------------------------------------
001700191115      *
001800191115      * *Entry Procedure
001900191115      *
002000191115      *-------------------------------------------------------------------------
002100191115       Dcl-pr Main ExtPgm;
002200220414         *N  Char(1);
002300191115       End-Pr;
002400191115
002500191115       dcl-pi Main;
002600220415         pRtn Char(1);
002700191115       End-Pi;
002800191115
002900191115      *-------------------------------------------------------------------------
003000191115      *
003100191115      * Mainline Program
003200191115      *
003300191115      *-------------------------------------------------------------------------
003400220412
003500220415        setll ( *loval ) amw0001p;
003600220415        read amw0001p;
003700220415        dow   not %eof(amw0001p);
003800221108         A1ASSIGN = #aacolor(a1trust:a1subno:a1acctn);
003900220415         update R_AMW0001R;
004000220415        read amw0001p;
004100220415        enddo;
004200220415
004300220415        setll ( *loval ) amw0002p;
004400220415        read amw0002p;
004500220415        dow   not %eof(amw0002p);
004600221108         A1ASSIGN = #aacolor(a1trust:a1subno:a1acctn);
004700220415         update R_AMW0002R;
004800220415        read amw0002p;
004900220415        enddo;
005000191203
005100191115       *inlr = *on;
