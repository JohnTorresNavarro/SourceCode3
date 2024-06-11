000100240403       Ctl-opt option(*noDebugIo)   DftActGrp(*no) ;
000200211020
000300211020      *-------------------------------------------------------------------------
000400211020      *
000500220502      * Declare Files
000600211020      *
000700211020      *-------------------------------------------------------------------------
000800240405       Dcl-f oeforml1 usage(*input : *update) keyed
000900240405             extfile('OEFORM/OEFORML1');
001000220502
001100240405       dcl-f accmst keyed usage(*input) extfile('F.ACCMST');
001200240405       dcl-f member keyed usage(*input) extfile('F.MEMBER');
001300240405       dcl-f dclcatxrfp keyed usage(*input);
001400240403       dcl-f webtranl6 keyed usage(*input);
001500240405       dcl-f oeformnotp keyed usage(*input : *output);
001600211020
001700211020      *-------------------------------------------------------------------------
001800211020      *
001900211020      * Global Variables
002000211020      *
002100211020      *-------------------------------------------------------------------------
002200240226
002300240226       dcl-c q const ('''');
002400240226
002500240405       dcl-s wcat Char(3);
002600240405       dcl-s in_date       char(32);
002700240405       dcl-s in_format     char(32);
002800240405       dcl-s out_format    char(32);
002900240405       dcl-s out_date      char(32);
003000240405       dcl-s out_error     char(10);
003100220328
003200211026       dcl-ds pgmd
003300211026         ExtName('IOPGMD') PSDS;
003400220408         @pgmq *proc;
003500211026       end-ds;
003600211026
003700240405
003800240405     d fmtDate         pr                  extpgm('FMTDATE')
003900240405     d  in_date                      32    const
004000240405     d  in_format                    32    const
004100240405     d  out_format                   32    const
004200240405     d  out_date                     32    const
004300240405     d  out_error                    10    const
004400240405
004500220616      *-----------------------------------------------------------------------
004600220616      *
004700220616      * *Entry Procedure
004800220616      *
004900220616      *-----------------------------------------------------------------------
005000220616       Dcl-pr Main ExtPgm;
005100240226         *N  Char(1);
005200220616       End-Pr;
005300220616
005400220616       dcl-pi Main;
005500240226         pOut  Char(1);
005600220616       End-Pi;
005700220616
005800220502
005900211020      *-------------------------------------------------------------------------
006000211020      *
006100211020      * Mainline Program
006200211020      *
006300211020      *-------------------------------------------------------------------------
006400240405         setll *loval OEFORML1;
006500240405         read OEFORML1;
006600240405         Dou %eof(OEFORML1);
006700240403
006800240405           read OEFORML1;
006900240405           if %eof(OEFORML1);
007000240403             leave;
007100240403           endif;
007200240403
007300240405         exsr  myDecline;
007400240403
007500240403         Enddo;
007600240403
007700240403         *inlr = *on;
007800240403         return;
007900240403
008000240405          begsr myDecline;
008100240405
008200240405           chain FOSSID oeformnotp;
008300240405           if  not %found(oeformnotp);
008400240405
008500240405           setll FOSSID webtranl6;
008600240405           read webtranl6;
008700240405           Dou %eof(webtranl6);
008800240405
008900240405           read webtranl6;
009000240405           if %eof(webtranl6);
009100240405             leave;
009200240405           endif;
009300240405
009400240405           if    %trim(OEFLDV) = 'PCAT1';
009500240405           wcat = %trim(oeafter);
009600240405           chain wcat dclcatxrfp;
009700240405           if  %found(dclcatxrfp);
009800240405           clear    OE_NOTER;
009900240405           NOSSID        = FOSSID;
010000240405           // NODATE        =  %Char(%Date(OEADDD:*iso):*Usa);
010100240405
010200240405        in_date = %editc(OEADDD: 'X');
010300240405        fmtDate(in_date:'YYYYMMDD':'Mmmmmmmmmz DD, YYYY':out_date:out_error);
010400240405        NODATE = %trim(out_date);
010500240405
010600240405           chain oessno member;
010700240405           if  %found(member);
010800240405           NONAME        = %trim(mfname) + ' ' + %trim(mlname);
010900240405           endif;
011000240405           NOSSN          = %editc(OESSNO:'X');
011100240405           NOSSN = %subst(NOSSN:1:3) + '-' + %subst(NOSSN:4:2) + '-' +
011200240405                   %subst(NOSSN:6:4);
011300240405           NOTSA          = %subst(OESSID:1:10);
011400240405           NOTSA = %subst(NOTSA:1:3) + '-' + %subst(NOTSA:4:3) + '-' +
011500240405                   %subst(NOTSA:7:4);
011600240405           chain (oetrst:oesub#:oeacct) accmst;
011700240405           if  %found(accmst);
011800240405           NOTSANAM       = %trim(acnam1);
011900240405           endif;
012000240405           note001 = 'Term Benefit: ' + %trim(dcldsc);
012100240405           write    OE_NOTER;
012200240405           leave;
012300240405           endif;
012400240405           endif;
012500240405
012600240405           enddo;
012700240403
012800240403           endif;
012900240403
013000240403           endsr;
