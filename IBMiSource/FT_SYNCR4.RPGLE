000100191203       Ctl-opt option(*noDebugIo)   DftActGrp(*no) ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400220411      *
000500221129      *  Description: File Transfer: Match current date - 1
000600211216      *  Programmer.: Jon Allen
000700221122      *  Born on ...: 11/22/2022
000800191115      *
000900191203      *
001000191115      *-------------------------------------------------------------------------
001100221122
001200221129     d in_days         s              3  0
001300221122     d in_date         s             32
001400221122     d in_format       s             32
001500221122     d out_format      s             32
001600221122     d out_date        s             32
001700221122     d out_error       s             10
001800220415
001900221122     d fmtDate         pr                  extpgm('FMTDATE')
002000221122     d  in_date                      32    const
002100221122     d  in_format                    32    const
002200221122     d  out_format                   32    const
002300221122     d  out_date                     32    const
002400221122     d  out_error                    10    const
002500221122
002600191115      *-------------------------------------------------------------------------
002700191115      *
002800191115      * *Entry Procedure
002900191115      *
003000191115      *-------------------------------------------------------------------------
003100191115       Dcl-pr Main ExtPgm;
003200221129         *N  Char(30);
003300221129         *N  Char(3);
003400230103         *N  Char(12);
003500230103         *N  Char(20);
003600191115       End-Pr;
003700191115
003800191115       dcl-pi Main;
003900221129         pPayVend Char(30);
004000221129         pDays Char(3);
004100230103         pMatch Char(12);
004200230103         pJobSchName Char(20);
004300191115       End-Pi;
004400191115
004500191115      *-------------------------------------------------------------------------
004600191115      *
004700191115      * Mainline Program
004800191115      *
004900191115      *-------------------------------------------------------------------------
005000221122        pMatch = ' ';
005100221129        in_days = %dec(pDays:3:0);
005200221205
005300221205             if in_days < 366;
005400221205
005500221122        in_format = 'YYYYMMDD';
005600221122        out_format = 'YYYYMMDD';
005700221122        if %trim(pPayVend) = 'EASE';
005800221122        out_format = 'YYYY-MM-DD';
005900221122        endif;
006000221206        if %trim(pPayVend) = 'Employee Navigator';
006100221206        out_format = 'MMDDYYYY';
006200221206        endif;
006300230103        if %trim(pJobSchName) = 'FT_AGISOL';
006400230103        out_format = 'MMDDYYYY';
006500230103        endif;
006600230103        if %trim(pJobSchName) = 'FT_CRISWELL';
006700230103        out_format = 'MMDDYYYY';
006800230103        endif;
006900220412
007000221122         Match();
007100191203
007200221205             endif;
007300221205
007400191115       *inlr = *on;
007500221122       // ----------------------------------------------------------------
007600221122       dcl-proc Match;
007700221129        in_Days = in_Days + 1;
007800221129        in_date = %char(%dec(%date - %days(in_Days)));
007900221122        fmtDate(in_date:in_format:out_format:out_date:out_error)            ;
008000221122        pMatch = '*' + %trim(out_date) + '*';
008100221129        pdays = %char(%dec(in_Days:3:0));
008200221122
008300221122       End-Proc;
