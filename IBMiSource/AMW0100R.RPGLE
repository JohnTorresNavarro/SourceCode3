000100191203       Ctl-opt option(*noDebugIo)   DftActGrp(*no) ;
000200191115
000300191115      *-------------------------------------------------------------------------
000400191115      *
000500191203      *
000600191115      *-------------------------------------------------------------------------
000700230216       dcl-f amw0006p usage( *Input: *Delete: *Output :*Update ) keyed;
000800230217       dcl-f amw0006l1 usage( *Input: *Update ) keyed rename(R_AMW0006R:R6);
000900191115
001000191115      *-------------------------------------------------------------------------
001100230214
001200230214     d in_date         s             32
001300230214     d in_format       s             32
001400230214     d out_format      s             32
001500230214     d out_date        s             32
001600230214     d out_error       s             10
001700230214
001800230214     d fmtDate         pr                  extpgm('FMTDATE')
001900230214     d  in_date                      32    const
002000230214     d  in_format                    32    const
002100230214     d  out_format                   32    const
002200230214     d  out_date                     32    const
002300230214     d  out_error                    10    const
002400230217
002500230217     d PGMD          ESDS                  EXTNAME(IOPGMD)
002600230217     D  @pgmq            *proc
002700230217
002800230217      *-------------------------------------------------------------------------
002900230217      * *Entry Procedure
003000191115      *-------------------------------------------------------------------------
003100191115       Dcl-pr Main ExtPgm;
003200230216         *N  Char(10);
003300230216         *N  Char(150);
003400230216         *N  Char(150);
003500191115       End-Pr;
003600191115
003700191115       dcl-pi Main;
003800230216         pTSA      Char(10);
003900230216         pEmpty    Char(150);
004000230216         pFileName Char(150);
004100191115       End-Pi;
004200191115
004300230216     d wDateIso        s               d   datfmt(*iso)
004400230216
004500230214       dcl-s cdate char(10);
004600230216       dcl-s wdate Zoned(8);
004700230216       dcl-s wclose Zoned(8);
004800230214       dcl-s pos   Zoned(3);
004900191115
005000191115      *-------------------------------------------------------------------------
005100191115      *
005200191115      * Mainline Program
005300191115      *
005400191115      *-------------------------------------------------------------------------
005500230214        in_format = 'YYYY-MM-DD';
005600230214        out_format = 'YYYYMMDD';
005700230217
005800230217          A6TRUST = %dec(%subst(pTSA:1:3):3:0);
005900230217          A6SUBNO = %dec(%subst(pTSA:4:3):3:0);
006000230217          A6ACCTN = %dec(%subst(pTSA:7:4):4:0);
006100230214
006200230217        if pEmpty <> *blanks;
006300230217           pos = %scan('-2':pEMPTY);
006400230217           cDate = %subst(pEMPTY:pos+1:10);
006500230217           in_date = Cdate;
006600230217           fmtDate(in_date:in_format:out_format:out_date:out_error)         ;
006700230217        if out_error = *blanks;
006800230217           cdate = %trim(out_date);
006900230217           wclose = %dec(cDate:8:0);
007000230217           wDateIso = %Date(wclose:*iso);
007100230217           wDateIso = wDateIso - %Days(1);
007200230217           wClose = %Dec(wDateIso);
007300230217        endif;
007400230217
007500230217          chain (A6TRUST:A6SUBNO:A6ACCTN) AMW0006L1;
007600230217        if  %found(AMW0006L1);
007700230217           If A6CLOSED = 0;
007800230217           A6CLOSED = 99999999;
007900230217           endif;
008000230217        if wClose >= A6OPENED and wClose <= A6CLOSED;
008100230217           A6CLOSED = wClose;
008200230217           A6STATUS = 'N';
008300230217           A6CHGUSR = WQUSRN;
008400230217           A6CHGDAT = %Dec(%Date);
008500230217           A6CHGTIM = %Dec(%Time);
008600230217           update  R6;
008700230217        endif;
008800230217        endif;
008900230217
009000230217        else;
009100230216
009200230217           pos = %scan('-2':pFILENAME);
009300230217           cDate = %subst(pFILENAME:pos+1:10);
009400230217           in_date = Cdate;
009500230217           fmtDate(in_date:in_format:out_format:out_date:out_error)         ;
009600230217         if out_error = *blanks;
009700230217           cdate = %trim(out_date);
009800230217           wdate = %dec(cDate:8:0);
009900230217         endif;
010000230217
010100230217          chain (A6TRUST:A6SUBNO:A6ACCTN) AMW0006L1;
010200230217          if  %found(AMW0006L1);
010300230217           If A6CLOSED = 0;
010400230217           A6CLOSED = 99999999;
010500230217           endif;
010600230217           if wDate >= A6OPENED and wDate <= A6CLOSED;
010700230217           // Do nothing since OE continues
010800230217           endif;
010900230217
011000230217          else;
011100230217
011200230217          chain (A6TRUST:A6SUBNO:A6ACCTN:wdate) AMW0006P;
011300230217        if  not %found(AMW0006P);
011400230217          A6TRUST = %dec(%subst(pTSA:1:3):3:0);
011500230217          A6SUBNO = %dec(%subst(pTSA:4:3):3:0);
011600230217          A6ACCTN = %dec(%subst(pTSA:7:4):4:0);
011700230217          A6OPENED = wdate;
011800230217          A6CLOSED = *zeros;
011900230217          A6STATUS = 'Y';
012000230217          A6ADDUSR = WQUSRN;
012100230217          A6ADDDAT = %Dec(%Date);
012200230217          A6ADDTIM = %Dec(%Time);
012300230217          write R_AMW0006R;
012400230217        endif;
012500230217
012600230217          endif;
012700230217          endif;
012800230216
012900230216
013000220412
013100191115       *inlr = *on;
