000100221123       Ctl-opt option(*noDebugIo) DftActGrp(*no) bnddir('GBSBIND') ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400220411      *
000500221123      *  Description: File Transfer: Sync Report
000600211216      *  Programmer.: Jon Allen
000700221122      *  Born on ...: 11/22/2022
000800191115      *
000900191203      *
001000191115      *-------------------------------------------------------------------------
001100221123       dcl-f gbs0030l1 keyed usage( *Input );
001200221128       dcl-f ftsyncpsf  keyed usage( *Output );
001300221123       dcl-f jmsmstp  keyed usage( *Input ) rename( jmsmstp : rcd1 );
001400221123
001500221206       dcl-s w80date  Zoned(8);
001600221206       dcl-s i80date  Zoned(8);
001700221207       dcl-s cmpflg Char(1);
001800221206
001900221207     d today           s               d   inz
002000221207
002100221122     d in_date         s             32
002200221122     d in_format       s             32
002300221122     d out_format      s             32
002400221122     d out_date        s             32
002500221122     d out_error       s             10
002600220415
002700221122     d fmtDate         pr                  extpgm('FMTDATE')
002800221122     d  in_date                      32    const
002900221122     d  in_format                    32    const
003000221122     d  out_format                   32    const
003100221122     d  out_date                     32    const
003200221122     d  out_error                    10    const
003300221122
003400191115      *-------------------------------------------------------------------------
003500191115      *
003600191115      * *Entry Procedure
003700191115      *
003800191115      *-------------------------------------------------------------------------
003900191115       Dcl-pr Main ExtPgm;
004000221129         *N  char(20);
004100221129         *N  char(12);
004200191115       End-Pr;
004300191115
004400191115       dcl-pi Main;
004500221129         pGroup  char(20);
004600221129         pMatch  char(12);
004700191115       End-Pi;
004800191115
004900191115      *-------------------------------------------------------------------------
005000191115      *
005100191115      * Mainline Program
005200191115      *
005300191115      *-------------------------------------------------------------------------
005400221207       Exec Sql
005500221207         Set Option Commit = *None, Naming = *Sys;
005600220412
005700221123        chain ( pGroup ) gbs0030l1;
005800221123        if  %found(gbs0030l1);
005900221123
006000221123        SYJOBNAME  = %trim(JOBSCHNAME);
006100221123        SYGROUP    = %trim(FTGROUP);
006200221123        SYNAME     = %scanrpl(',':'':FTNAME);
006300221129        pMatch = %scanrpl('*':'':pMatch);
006400221123
006500221123        GetJob();
006600221123
006700221123        SYPAYVEND  = %trim(FTPAYVEND);
006800221123        SYFILETYP  = %trim(FTFILETYP);
006900221122
007000221123        GetDate();
007100221123
007200221123        Write    R_FTSYNC;
007300221122
007400221123        endif;
007500191203
007600191115       *inlr = *on;
007700221122       // ----------------------------------------------------------------
007800221123       dcl-proc GetDate;
007900221123
008000221123        in_format = 'YYYYMMDD';
008100221123        out_format = 'MM-DD-YYYY';
008200221122        in_date = %Char(%Dec(%Date));
008300221123
008400221122        fmtDate(in_date:in_format:out_format:out_date:out_error)            ;
008500231107        if %trim(out_error) = *blanks;
008600221123        SYRCVDT = %trim(out_date);
008700231107        endif;
008800221129
008900221212        if pMatch <> *blanks;
009000221129        in_date = %trim(pMatch);
009100221129        fmtDate(in_date:in_format:out_format:out_date:out_error)            ;
009200231107        if %trim(out_error) = *blanks;
009300221129        SYLSTDT = %trim(out_date);
009400231107        endif;
009500221206
009600231107        monitor;
009700221206        i80date = %dec(pMatch:8:0);
009800231107        on-error;
009900231107        endmon;
010000221206        w80date = %dec(%date - %days(30));
010100221206
010200221206        if   i80date < w80date;
010300221206        SYLSTDT = '*** ' + %trim(SYLSTDT) + ' ***';
010400221206        endif;
010500221212        else;
010600221212        SYLSTDT = '*Review';
010700221212        endif;
010800221122
010900221122       End-Proc;
011000221123       // ----------------------------------------------------------------
011100221123       dcl-proc GetJob;
011200221123
011300221123             chain(n) jobSchName JmsMstp;
011400221123             if %Found( JmsMstp ) ;
011500221123
011600221123             JMJOBN = JMJOBN;
011700221123
011800221123               if jmMon = 'Y';
011900221123                 SYFILESCH = %Trim(SYFILESCH) + 'M';
012000221123               else;
012100221123                 SYFILESCH = %Trim(SYFILESCH) + '_';
012200221123               endif;
012300221123
012400221123               if jmTue = 'Y';
012500221123                 SYFILESCH = %Trim(SYFILESCH) + ' T';
012600221123               else;
012700221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
012800221123               endif;
012900221123
013000221123               if jmWed = 'Y';
013100221123                 SYFILESCH = %Trim(SYFILESCH) + ' W';
013200221123               else;
013300221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
013400221123               endif;
013500221123
013600221123               if jmThu = 'Y';
013700221123                 SYFILESCH = %Trim(SYFILESCH) + ' T';
013800221123               else;
013900221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
014000221123               endif;
014100221123
014200221123               if jmFri = 'Y';
014300221123                 SYFILESCH = %Trim(SYFILESCH) + ' F';
014400221123               else;
014500221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
014600221123               endif;
014700221123
014800221123               if jmSat = 'Y';
014900221123                 SYFILESCH = %Trim(SYFILESCH) + ' S';
015000221123               else;
015100221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
015200221123               endif;
015300221123
015400221123               if jmSun = 'Y';
015500221123                 SYFILESCH = %Trim(SYFILESCH) + ' S';
015600221123               else;
015700221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
015800221123               endif;
015900221123
016000221123               endif;
016100221207
016200221207             Today = %Date();
016300221207             CmpFlg = 'Y';
016400221207
016500221207                 Exec Sql
016600221207                   Update jmshstp
016700221207                     Set jhcomp = :cmpflg, jhrund = Current_Date, jhrunt =
016800221207                           Current_Time
016900221207                     Where jhjobn = :jobSchName And jhdate = :Today;
017000221207
017100221123
017200221123       End-Proc;
