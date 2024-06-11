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
001200221123       dcl-f ftsyncp  keyed usage( *Output );
001300221123       dcl-f jmsmstp  keyed usage( *Input ) rename( jmsmstp : rcd1 );
001400221122
001500221207       dcl-s cmpflg Char(1);
001600221123       dcl-s wtrs  Zoned(3);
001700221123       dcl-s wsub  Zoned(3);
001800221206       dcl-s wact  Zoned(4);
001900221206       dcl-s w80date  Zoned(8);
002000221206       dcl-s i80date  Zoned(8);
002100221207
002200221207     d today           s               d   inz
002300221123
002400221122     d in_date         s             32
002500221122     d in_format       s             32
002600221122     d out_format      s             32
002700221122     d out_date        s             32
002800221122     d out_error       s             10
002900220415
003000221122     d fmtDate         pr                  extpgm('FMTDATE')
003100221122     d  in_date                      32    const
003200221122     d  in_format                    32    const
003300221122     d  out_format                   32    const
003400221122     d  out_date                     32    const
003500221122     d  out_error                    10    const
003600221123
003700221123      /Include *LIBL/QMODSRC,#aacolorPr            // Get AA Color
003800221122
003900191115      *-------------------------------------------------------------------------
004000191115      *
004100191115      * *Entry Procedure
004200191115      *
004300191115      *-------------------------------------------------------------------------
004400191115       Dcl-pr Main ExtPgm;
004500221129         *N  char(20);
004600221129         *N  char(12);
004700191115       End-Pr;
004800191115
004900191115       dcl-pi Main;
005000221129         pGroup  char(20);
005100221129         pMatch  char(12);
005200191115       End-Pi;
005300191115
005400191115      *-------------------------------------------------------------------------
005500191115      *
005600191115      * Mainline Program
005700191115      *
005800191115      *-------------------------------------------------------------------------
005900221207
006000221207       Exec Sql
006100221207         Set Option Commit = *None, Naming = *Sys;
006200220412
006300221123        chain ( pGroup ) gbs0030l1;
006400221123        if  %found(gbs0030l1);
006500221123
006600221123        SYJOBNAME  = %trim(JOBSCHNAME);
006700221123        SYGROUP    = %trim(FTGROUP);
006800221129        SYNAME = %scanrpl(',':'':FTNAME);
006900221129        pMatch = %scanrpl('*':'':pMatch);
007000221123
007100221123        GetJob();
007200221123
007300221123        SYPAYVEND  = %trim(FTPAYVEND);
007400221123        SYFILETYP  = %trim(FTFILETYP);
007500221122
007600221123        GetDate();
007700221123
007800221123        if  %trim(FTDEPT) = 'FI';
007900221123        wtrs = %dec(%subst(FTGROUP:1:3):3:0);
008000221123        wsub = %dec(%subst(FTGROUP:4:3):3:0);
008100221123        wact = %dec(%subst(FTGROUP:7:4):4:0);
008200221123        SYAA  = #aacolor(wtrs:wsub:wact);
008300221123        endif;
008400221123
008500221123        Write    R_FTSYNC;
008600221207
008700221123        endif;
008800191203
008900191115       *inlr = *on;
009000221122       // ----------------------------------------------------------------
009100221123       dcl-proc GetDate;
009200221123
009300221123        in_format = 'YYYYMMDD';
009400221123        out_format = 'MM-DD-YYYY';
009500221122        in_date = %Char(%Dec(%Date));
009600221123
009700221122        fmtDate(in_date:in_format:out_format:out_date:out_error)            ;
009800231107        if %trim(out_error) = *blanks;
009900221123        SYRCVDT = %trim(out_date);
010000231107        endif;
010100221129
010200221208
010300221208        if pMatch <> *blanks;
010400221129        in_date = %trim(pMatch);
010500221129        fmtDate(in_date:in_format:out_format:out_date:out_error)            ;
010600231107        if %trim(out_error) = *blanks;
010700221129        SYLSTDT = %trim(out_date);
010800231107        endif;
010900221206
011000231107        monitor;
011100221206        i80date = %dec(pMatch:8:0);
011200231107        on-error;
011300231107        endmon;
011400231107
011500221206        w80date = %dec(%date - %days(30));
011600221206
011700221206        if   i80date < w80date;
011800221206        SYLSTDT = '*** ' + %trim(SYLSTDT) + ' ***';
011900221206        endif;
012000221208        else;
012100221208        SYLSTDT = '*Review';
012200221208        endif;
012300221122
012400221122       End-Proc;
012500221123       // ----------------------------------------------------------------
012600221123       dcl-proc GetJob;
012700221123
012800221123             chain(n) jobSchName JmsMstp;
012900221123             if %Found( JmsMstp ) ;
013000221123
013100221123             JMJOBN = JMJOBN;
013200221123
013300221123               if jmMon = 'Y';
013400221123                 SYFILESCH = %Trim(SYFILESCH) + 'M';
013500221123               else;
013600221123                 SYFILESCH = %Trim(SYFILESCH) + '_';
013700221123               endif;
013800221123
013900221123               if jmTue = 'Y';
014000221123                 SYFILESCH = %Trim(SYFILESCH) + ' T';
014100221123               else;
014200221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
014300221123               endif;
014400221123
014500221123               if jmWed = 'Y';
014600221123                 SYFILESCH = %Trim(SYFILESCH) + ' W';
014700221123               else;
014800221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
014900221123               endif;
015000221123
015100221123               if jmThu = 'Y';
015200221123                 SYFILESCH = %Trim(SYFILESCH) + ' T';
015300221123               else;
015400221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
015500221123               endif;
015600221123
015700221123               if jmFri = 'Y';
015800221123                 SYFILESCH = %Trim(SYFILESCH) + ' F';
015900221123               else;
016000221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
016100221123               endif;
016200221123
016300221123               if jmSat = 'Y';
016400221123                 SYFILESCH = %Trim(SYFILESCH) + ' S';
016500221123               else;
016600221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
016700221123               endif;
016800221123
016900221123               if jmSun = 'Y';
017000221123                 SYFILESCH = %Trim(SYFILESCH) + ' S';
017100221123               else;
017200221123                 SYFILESCH = %Trim(SYFILESCH) + ' _';
017300221123               endif;
017400221123
017500221123               endif;
017600221207
017700221207             Today = %Date();
017800221207             CmpFlg = 'Y';
017900221207
018000221207                 Exec Sql
018100221207                   Update jmshstp
018200221207                     Set jhcomp = :cmpflg, jhrund = Current_Date, jhrunt =
018300221207                           Current_Time
018400221207                     Where jhjobn = :jobSchName And jhdate = :Today;
018500221207
018600221123
018700221123       End-Proc;
