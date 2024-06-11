000100191203       Ctl-opt option(*noDebugIo)   DftActGrp(*no) ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400220411      *
000500221122      *  Description: File Transfer: Sync Report for files not received
000600211216      *  Programmer.: Jon Allen
000700221122      *  Born on ...: 11/22/2022
000800191115      *
000900191203      *
001000191115      *-------------------------------------------------------------------------
001100221122       dcl-f jmsmstp keyed usage( *Input ) rename( jmsmstp : rcd1 );
001200221122
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
003200221122         *N  Char(20);
003300221122         *N  Char(30);
003400221122         *N  Char(12);
003500221122         *N  Char(4);
003600191115       End-Pr;
003700191115
003800191115       dcl-pi Main;
003900221122         pJobSchName Char(20);
004000221122         pPayVend Char(30);
004100221122         pMatch Char(12);
004200221122         pDOW Char(4);
004300191115       End-Pi;
004400191115
004500191115      *-------------------------------------------------------------------------
004600191115      *
004700191115      * Mainline Program
004800191115      *
004900191115      *-------------------------------------------------------------------------
005000221122        pMatch = ' ';
005100221122        in_format = 'YYYYMMDD';
005200221122        out_format = 'YYYYMMDD';
005300221122        if %trim(pPayVend) = 'EASE';
005400221122        out_format = 'YYYY-MM-DD';
005500221122        endif;
005600221206        if %trim(pPayVend) = 'Employee Navigator';
005700221206        out_format = 'MMDDYYYY';
005800221206        endif;
005900221219        if %trim(pJobSchName) = 'FT_AGISOL';
006000221219        out_format = 'MMDDYYYY';
006100221219        endif;
006200230103        if %trim(pJobSchName) = 'FT_CRISWELL';
006300230103        out_format = 'MMDDYYYY';
006400230103        endif;
006500220412
006600221122        chain ( pJOBSCHNAME ) jmsmstp;
006700221122        if     %found(jmsmstp);
006800221122
006900221122        select;
007000221122        when JMMON = 'Y' and pDOW = '*MON';
007100221122         Match();
007200221122        when JMTUE = 'Y' and pDOW = '*TUE';
007300221122         Match();
007400221122        when JMWED = 'Y' and pDOW = '*WED';
007500221122         Match();
007600221122        when JMTHU = 'Y' and pDOW = '*THU';
007700221122         Match();
007800221122        when JMFRI = 'Y' and pDOW = '*FRI';
007900221122         Match();
008000221122        when JMSAT = 'Y' and pDOW = '*SAT';
008100221122         Match();
008200221122        when JMSUN = 'Y' and pDOW = '*SUN';
008300221122         Match();
008400221122        endsl;
008500221122
008600221122
008700221122        endif;
008800191203
008900191115       *inlr = *on;
009000221122       // ----------------------------------------------------------------
009100221122       dcl-proc Match;
009200221122
009300221122        in_date = %Char(%Dec(%Date));
009400221208        // // in_date = '20221207';
009500221122        fmtDate(in_date:in_format:out_format:out_date:out_error)            ;
009600221208        if out_error = *blanks;
009700221122        pMatch = '*' + %trim(out_date) + '*';
009800221208        endif;
009900221122
010000221122       End-Proc;
