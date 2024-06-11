000100000000     H option(*noDebugIo)  bnddir('GBSBIND')  DftActGrp(*no)
000200000000      *-------------------------------------------------------------------------
000300000000      *
000400000000      *  Description:
000500000000      *  Programmer.:
000600000000      *  Date.......:  10/03/2017
000700000000      *
000800000000      *-------------------------------------------------------------------------
000900171003     FGBS0027D  CF   E             WORKSTN
001000000000     F                                     SFILE(LSTSFL:rrn)
001100000000     F                                     INFDS(DSPD)
001200000000     FACARGRP   uf a e           k Disk
001300171009     FAccMst    if   e           k disk    ExtDesc('F.ACCMST') ExtFile(*extdesc)
001400000000     F
001500000000      *-------------------------------------------------------------------------
001600000000
001700000000      * Program status data structure
001800000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
001900000000     D  @pgmq            *proc
002000000000
002100000000      * Display file data structure
002200000000     D DSPD            DS
002300000000     D  Key                  369    369
002400000000     D  Currec               378    379b 0
002500000000
002600000000      * Variables
002700000000     D F03             C                   CONST(X'33')
002800171003     D Enter           C                   const(X'F1')
002900000000
003000000000     d Rrn             s              5s 0 inz
003100000000     d SaveCursPos     S              4S 0
003200000000     d ReLoad          s              1
003300000000
003400171003     d @t              s              3s 0
003500171003     d @s              s              3s 0
003600171003     d @a              s              4s 0
003700171003     d svSearch        s             10
003800171003
003900000000
004000000000      *-------------------------------------------------------------------------
004100000000      * Mainline Program
004200000000      *-------------------------------------------------------------------------
004300000000
004400000000       Dow key <> F03;
004500000000
004600000000          If Reload = 'Y';
004700000000             exsr CLEAR;
004800000000             exsr LOAD;
004900000000             Reload = 'N';
005000171003             svSearch = s1Search;
005100000000          endIf;
005200000000
005300000000          exsr DISPLY;
005400000000
005500171003
005600171003          if s1Search <> svSearch;
005700171003             reload = 'Y';
005800171003          EndIf;
005900171003
006000000000          // Process Selections
006100171003          Select;
006200171003
006300000000          When key = ENTER and Rrn > 0;
006400000000             exsr PROCES;
006500000000
006600000000          EndSl;
006700000000       enddo;
006800000000
006900000000       *inlr = *on;
007000000000
007100171003       // ----------------------------------------------------------------
007200000000       Begsr *Inzsr;
007300000000
007400171003          Reload = 'Y';
007500000000
007600000000       Endsr;
007700000000       // ----------------------------------------------------------------
007800000000       Begsr CLEAR;
007900000000
008000171003          RcdNbr = 1;
008100171003          If SaveCursPos > 0;
008200171003             RcdNbr = SaveCursPos;
008300171003             SaveCursPos = 0;
008400171003          endIf;
008500000000
008600171003          // Clear the Subfile.
008700171003          *in31 = *off;                     // Subfile Display
008800171003          *in32 = *off;                     // Subfile Disp Control
008900171003          *in33 = *on;                      // Subfile Clear
009000000000
009100171003          write LstCtl;
009200000000
009300171003          *in31 = *off;                     // Subfile Display
009400171003          *in32 = *on;                      // Subfile Disp Control
009500171003          *in33 = *off;                     // Subfile Clear
009600171003          rrn = 0;
009700000000
009800000000       Endsr;
009900000000       // ----------------------------------------------------------------
010000000000
010100171003       Begsr Load;
010200000000
010300171003          *in37 = *off;
010400000000
010500000000
010600171009          s1AcName = *Blanks;
010700171009          if s1Search > *Blanks;
010800171009             @t = %Dec( %Subst(s1search: 1 : 3) : 3 : 0 );
010900171009             @s = %Dec( %Subst(s1search: 4 : 3) : 3 : 0 );
011000171009             @a = %Dec( %Subst(s1search: 7 : 4) : 4 : 0 );
011100171009
011200171009             chain (@t:@s:@a) AccMst;
011300171009             if %Found(AccMst);
011400171009                s1AcName = acNam1;
011500171009             endif;
011600171009          endif;
011700171009
011800171009
011900171003          Setll (*loval) ACARGRP;
012000171003          dou %eof(ACARGRP);
012100171003             read(n) ACARGRP;
012200000000
012300171003             if %eof(ACARGRP);
012400171003                *in37 = *on;
012500171003                leave;
012600171003             endif;
012700000000
012800171003             S1PDT = AGPDT     ;
012900171003             S1CARGRP = AGCARGRP  ;
013000171004             S1RNWLFR = %Char(%Date(AGRNWLFR:*iso) :*usa) ;
013100171004             S1RNWLTO = %Char(%Date(AGRNWLTO:*iso) :*usa) ;
013200171003             S1RATRGN = AGRATRGN  ;
013300171003             s1Tsa = %editc(agTrst:'X') + '-' + %editc(agSub#:'X') + '-' +
013400171003                     %editc(agAcct:'X');
013500171003
013600171003             svTrst = agTrst;
013700171003             svSub# = agSub#;
013800171003             svAcct = agAcct;
013900171003             svPDT = AGPDT     ;
014000171003             svCARGRP = AGCARGRP  ;
014100171003             svRNWLFR = AGRNWLFR  ;
014200171003             svRNWLTO = AGRNWLTO  ;
014300171003
014400171003
014500171003             if s1Search = *blanks;
014600171003                rrn = rrn + 1;
014700171003                write LstSfl;
014800171003             endif;
014900171003
015000171003
015100171003             if s1Search > *blanks;
015200171003                @t = %Dec( %Subst(s1search: 1 : 3) : 3 : 0 );
015300171003                @s = %Dec( %Subst(s1search: 4 : 3) : 3 : 0 );
015400171003                @a = %Dec( %Subst(s1search: 7 : 4) : 4 : 0 );
015500171003
015600171003                if @t = svTrst  and
015700171003                   @s = svSub#  and
015800171003                   @a = svAcct;
015900171003
016000171003                   rrn = rrn + 1;
016100171003                   write LstSfl;
016200171003
016300171003                EndIf;
016400171003             EndIf;
016500000000
016600171003             If rrn >= 9999;
016700171003                leave;
016800171003             endIf;
016900000000
017000000000          enddo;
017100000000
017200171003       Endsr;
017300000000
017400171003       // ----------------------------------------------------------------
017500171003       Begsr DISPLY;
017600000000
017700171003          If rrn = 0;
017800171003             *in31 = *off;
017900171003             write NoRcd;
018000171003             reload = 'Y';
018100171003          endIf;
018200000000
018300171003          If rrn > 0;
018400171003             write Cmd;
018500171003             *in31 = *on;
018600171003          endIf;
018700000000
018800171003          if RcdNbr > rrn;
018900171003             RcdNbr = rrn;
019000171003          EndIf;
019100000000
019200171003          EXFMT LstCtl;
019300000000
019400000000
019500171003       Endsr;
019600171003       // ----------------------------------------------------------------
019700171003       Begsr PROCES;
019800000000
019900171003          Dou *in95 = *on;
020000171003             Readc LstSfl;
020100171003             *in95 = %eof;
020200000000
020300171003             if *in95 = *Off;
020400171003                SaveCursPos = rrn;
020500000000
020600000000
020700171003                If s1Opt = '4';
020800171003                   chain (svTRST:svSUB#:svACCT:svPDT:svCARGRP:svRNWLFR:svRNWLTO)
020900171003                       ACARGRP;
021000000000
021100171003                   if %Found(ACARGRP);
021200171003                      delete ACARGRP;
021300000000
021400171003                      If SaveCursPos > 1;
021500171003                         SaveCursPos = SaveCursPos -1;
021600171003                      Endif;
021700171003                   Endif;
021800171003                Endif;
021900000000
022000171003
022100171003
022200171003                chain (svTRST:svSUB#:svACCT:svPDT:svCARGRP:svRNWLFR:svRNWLTO)
022300171003                    ACARGRP;
022400171003
022500171003                if %Found(ACARGRP);
022600171003
022700171004                   agrnwlfr = %dec(%char(%date(s1rnwlfr:*usa/):*iso0):8:0);
022800171004                   agrnwlto = %dec(%char(%date(s1rnwlto:*usa/):*iso0):8:0);
022900171003                   update ACARGRF ;
023000171003                Endif;
023100171003
023200171003
023300000000
023400171003                s1Opt = '';
023500171003                update LstSfl;
023600171003                Reload = 'Y';
023700171003             endIf;
023800000000
023900171003          enddo;
024000171003       Endsr;
024100000000
