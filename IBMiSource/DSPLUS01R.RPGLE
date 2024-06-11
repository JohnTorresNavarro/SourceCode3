000100171229
000200180131       Ctl-Opt option(*noDebugIo) DftActGrp(*no) ActGrp(*New);
000300171227
000400171229      *-------------------------------------------------------------------------
000500171229      *
000600180305      *  Description: Direct Sales Inquiry Plus
000700180131      *  Programmer.: Jon Allen
000800180312      *  Date.......: 03/12/2018
000900171229      *
001000180201      *
001100180201      *
001200171229      *-------------------------------------------------------------------------
001300180131      *
001400180131      * File specifications
001500180131      *
001600180131      *-------------------------------------------------------------------------
001700180220
001800180305       Dcl-f dsplus01d  WorkStn
001900180314          Handler('PROFOUNDUI(HANDLER)')
002000180314          SFILE(SFL1:rrn)
002100180314          SFILE(SFL2:rrn2);
002200180227
002300180227        dcl-f sman keyed usage(*Input)
002400180227              extdesc('F.SMAN') extfile(*extdesc);
002500180227
002600180305        dcl-f aacode keyed usage(*Input)
002700180305              extdesc('AACODE') extfile(*extdesc);
002800180227
002900180305        dcl-f accmst keyed usage(*Input)
003000180305              extdesc('F.ACCMST') prefix(A_) extfile(*extdesc);
003100180314
003200180314        dcl-f cmct15 keyed usage(*Input)
003300180314              extdesc('F.CMCT15') extfile(*extdesc);
003400180314
003500180314        dcl-f plnmst keyed usage(*Input)
003600180314              extdesc('F.PLNMST') extfile(*extdesc);
003700180314
003800180314        dcl-f grate  keyed usage(*Input)
003900180314              extdesc('F.GRATE') extfile(*extdesc);
004000180314
004100180314        dcl-f trkrnwlp keyed usage(*Input)
004200180314              extdesc('TRKRNWLP') extfile(*extdesc);
004300180227
004400180131
004500170420
004600171229      *-------------------------------------------------------------------------
004700171229      *
004800171229      * Global Variables
004900171229      *
005000171229      *-------------------------------------------------------------------------
005100171227
005200180227       dcl-s wmancd char(3);
005300180314       dcl-s rrn Zoned(5) inz;
005400180314       dcl-s rrn2 Zoned(5) inz;
005500180228       dcl-s x Zoned(5) inz;
005600180228       dcl-s y Zoned(5) inz;
005700180305       dcl-s gac char(10) dim(100) inz;
005800180305       dcl-s wtrs char(3) ;
005900180305       dcl-s wsub char(3) ;
006000180305       dcl-s wact char(4) ;
006100180227
006200180131       dcl-s @today zoned(8) inz ;
006300180216       dcl-s @zeros zoned(8) inz(*all'0');
006400180228       dcl-s @isotoday date(*iso);
006500180302
006600180305       dcl-ds wwtsa;
006700180302          oTrst  Zoned(3);
006800180302          oSub#  Zoned(3);
006900180302          oAcct  Zoned(4);
007000180302       End-Ds;
007100180302
007200180227      *-------------------------------------------------------------------------
007300180227      *
007400180227      * Procedures
007500180227      *
007600180227      *-------------------------------------------------------------------------
007700180315       dcl-pr DSPLUS02R ExtPgm('DSPLUS02R');
007800180315          oTrst   Zoned(3);
007900180315          oSub#   Zoned(3);
008000180315          oAcct   Zoned(4);
008100180315          oPln    Char(4);
008200180315       End-Pr;
008300180315
008400180302
008500180102      *-------------------------------------------------------------------------
008600171229      *
008700180102      * Mainline Program
008800171229      *
008900180102      *-------------------------------------------------------------------------
009000180227     C     *entry        plist
009100180305     C                   parm                    WTRS
009200180305     C                   parm                    WSUB
009300180305     C                   parm                    WACT
009400180220
009500180305        oTrst = %dec(WTRS:3:0);
009600180305        oSub# = %dec(WSUB:3:0);
009700180305        oAcct = %dec(WACT:4:0);
009800180305
009900180131          @today = %DEC(%CHAR(%DATE:*ISO0):8:0);
010000180228          @isotoday = %date(@today : *iso);
010100180131
010200180305       Dou ExitBtn = *on;
010300180227
010400180227          Clear_All();
010500180227
010600180314          exsr load_tab01;
010700180314          exsr load_tab02;
010800180314          exsr load_tab03;
010900180227
011000180227          // Display Screen
011100180227          Disp_All();
011200180328
011300180328          exsr ReadChangedTab2;
011400180328
011500180315
011600180227       enddo;
011700180220
011800180131         *inlr = *on;
011900180131         return ;
012000180131
012100180328       // ----------------------------------------------------------------
012200180328       Begsr ReadChangedTab2;
012300180328
012400180328
012500180328          Dou *in96 = *ON;
012600180328             READC SFL1;
012700180328             *in96 = %EOF;
012800180328
012900180328             If *in96 = *OFF;
013000180328
013100180328            if runOption = 'A';
013200180328            wwtsa = %char(WSACCT);
013300180328            DSPLUS02R( oTRST:oSUB#:oACCT:wsplan);
013400180328            endif;
013500180328
013600180328                runOption = '';
013700180328                update SFL1;
013800180328             endIf;
013900180328
014000180328          enddo;
014100180328
014200180328       EndSr;
014300180131      *-------------------------------------------------------------------------
014400180131      *
014500180314      * Load Tab01
014600180131      *
014700180131      *-------------------------------------------------------------------------
014800180314       Begsr load_Tab01;
014900180131
015000180305        chain (otrst:osub#:oacct) accmst;
015100180305        if %found(accmst);
015200180305
015300180305        wsacct = %dec(wwtsa:10:0);
015400180305
015500180305        if A_atrmdt = 0 or A_atrmdt >= @today;
015600180305        wsstatus = '*ACTIVE';
015700180305        else;
015800180305        wsstatus = '*TERMED';
015900180305        endif;
016000180305
016100180305        wsname = %trim(A_ACNAM1);
016200180305        wsadr1 = %trim(A_AADDR1);
016300180305        if A_AADDR2 <> *blanks;
016400180305        wsadr2 = %trim(A_AADDR2);
016500180305        wsadr3 = %trim(A_ACITY) + ', ' + %trim(A_ASTATE) +
016600180305                 %editw(A_AZIP:'0     .    ') ;
016700180305        else;
016800180305        wsadr2 = %trim(A_ACITY) + ', ' + %trim(A_ASTATE) +
016900180305                 %editw(A_AZIP:'0     .    ') ;
017000180305        wsadr3 = *blanks;
017100180305        endif;
017200180305
017300180305        wsphone = %char(A_AAREA) + '.' + %editw(A_APHONE:'0   .    ');
017400180305        wsfax   = %char(A_FAXARE) + '.' + %editw(A_FAX#:'0   .    ');
017500180305        wscont = %trim(A_CONTAC);
017600180305        wsexec = %trim(A_ECNTAC);
017700180305
017800180305        chain (A_SMANCD) sman;
017900180227        if %found(sman);
018000180227
018100180305        wssman = %trim(SLNAME) + ', ' + %trim(SFNAME) + ' ' +
018200180305                %trim(SMI) + ' - ' + %trim(SMANCD);
018300180227
018400180305        chain (A_aacode) aacode;
018500180305        if %found(aacode);
018600180227
018700180305        wsaa   = %trim(ALNAM) + ', ' + %trim(AFNAM) + ' ' +
018800180305                 ' - ' + %trim(ACODE);
018900180227
019000180305        endif;
019100180227        endif;
019200180227        endif;
019300180216
019400180131       Endsr;
019500180314
019600180314      *-------------------------------------------------------------------------
019700180314      *
019800180314      * Load Tab02
019900180314      *
020000180314      *-------------------------------------------------------------------------
020100180314       Begsr load_Tab02;
020200180314
020300180314        setll (otrst:osub#:oacct) cmct15;
020400180314        reade (otrst:osub#:oacct) cmct15;
020500180314        dow not %eof(cmct15);
020600180314
020700180314        chain (A_SMANCD) sman;
020800180314        if %found(sman);
020900180314
021000180314        wssman = %trim(SLNAME) + ', ' + %trim(SFNAME) + ' ' +
021100180314                %trim(SMI) + ' - ' + %trim(SMANCD);
021200180314
021300180314        chain (cmtrst:csubdv:cmplan) plnmst;
021400180314        if %found(plnmst);
021500180314
021600180314        wsplan = %trim(cmplan);
021700180314        wspdsc = %trim(pdescr);
021800180314        exsr get_group#;
021900180314
022000180314           clear wsdat1;
022100180314           if effdat > 0;
022200180314           wsdat1 = %Char(%Date(effdat:*iso):*Usa);
022300180314           endif;
022400180314
022500180314           clear wsdat2;
022600180314           if cmcan > 0;
022700180314           wsdat2 = %Char(%Date(cmcan:*iso):*Usa);
022800180314           endif;
022900180314
023000180314            RRN += 1;
023100180314            Write SFL1;
023200180314
023300180314        endif;
023400180314        endif;
023500180314
023600180314        reade (otrst:osub#:oacct) cmct15;
023700180314        enddo;
023800180314
023900180314       Endsr;
024000180314      *-------------------------------------------------------------------------
024100180314      *
024200180314      * Load Tab03
024300180314      *
024400180314      *-------------------------------------------------------------------------
024500180314       Begsr load_Tab03;
024600180314
024700180314        setll (otrst:osub#:oacct) trkrnwlp;
024800180314        reade (otrst:osub#:oacct) trkrnwlp;
024900180314        dow not %eof(trkrnwlp);
025000180314
025100180314        chain (trtrst:trsub#:trplan) plnmst;
025200180314        if %found(plnmst);
025300180314
025400180314        wsplan3 = %trim(trplan);
025500180314        wspdsc3 = %trim(pdescr);
025600180314        wsgroup3 = trgroup#;
025700180314        wscat3 = trplncat;
025800180314        wsmon3 = trrenmm;
025900180314        wsnrc3 = TRNONRN;
026000180314        wsmkts3 = TRMKTSIZE;
026100180314        wscar3 = TRPCARR;
026200180314
026300180314           clear wsdat3;
026400180314           if trbegdat > 0;
026500180314           wsdat3 = %Char(%Date(trbegdat:*iso):*Usa);
026600180314           endif;
026700180314
026800180314           clear wsdat4;
026900180314           if TRNRNDT > 0;
027000180314           wsdat4 = %Char(%Date(TRNRNDT:*iso):*Usa);
027100180314           endif;
027200180314
027300180314            RRN2 += 1;
027400180314            Write SFL2;
027500180314
027600180314        endif;
027700180314
027800180314        reade (otrst:osub#:oacct) trkrnwlp;
027900180314        enddo;
028000180314
028100180314
028200180314       Endsr;
028300180314      *-------------------------------------------------------------------------
028400180314      *
028500180314      * Get Group#
028600180314      *
028700180314      *-------------------------------------------------------------------------
028800180314       Begsr get_group#;
028900180314
029000180314        wsgroup = *blanks;
029100180314
029200180314        setll (otrst:osub#:cmplan) grate;
029300180314        reade (otrst:osub#:cmplan) grate;
029400180314        dow not %eof(grate);
029500180314
029600180314        if @today >= frmdat and @today <=todat;
029700180314        wsgroup = %trim(group#);
029800180314        leavesr;
029900180314        endif;
030000180314
030100180314        reade (otrst:osub#:cmplan) grate;
030200180314        enddo;
030300180314
030400180314       Endsr;
030500180227      *-------------------------------------------------------------------------
030600180227      *
030700180227      * Clear the Subfiles...
030800180227      *
030900180227      *-------------------------------------------------------------------------
031000180227       dcl-proc Clear_All;
031100180227
031200180227          // Clear the Subfile.
031300180314          SFLCLR1 = *on;
031400180314          SFLCLR2 = *on;
031500180314          Write SFLCTL;
031600180314          SFLCLR1 = *off;
031700180314          SFLCLR2 = *off;
031800180314          rrn = 0;
031900180314          rrn2 = 0;
032000180227
032100180227
032200180227       end-proc;
032300180227
032400180227      *-------------------------------------------------------------------------
032500180227      *
032600180227      * Display The Subfiles...
032700180227      *
032800180227      *-------------------------------------------------------------------------
032900180227       dcl-proc Disp_All;
033000180227
033100180227          // Display the Subfile.
033200180314          SFLDSP1 = *on  ;
033300180314          SFLDSP2 = *on  ;
033400180227          exfmt SFLCTL;
033500180314          rrn = 0;
033600180314          rrn2 = 0;
033700180314          SFLDSP1 = *off;
033800180314          SFLDSP2 = *off;
033900180227
034000180227       end-proc;
034100180227
