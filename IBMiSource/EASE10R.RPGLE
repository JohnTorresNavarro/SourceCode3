000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Load ACCOSP with EASE 10 links - One Time load
000400000000      *
000500000000      *  (c)Copyright 2023 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - May 02, 2023
000800000000      *_________________________________________________________________________
000900230503       dcl-f Ease10p usage(*input :*update :*delete);
001000230502       dcl-f ACCOSPL3 keyed usage(*input :*update: *output);
001100230502
001200230502       dcl-s wtrst  Zoned(3) inz;
001300230502       dcl-s wSub#  Zoned(3) inz;
001400230502       dcl-s wAcct  Zoned(4) inz;
001500230502
001600230502       dcl-s w80dateB Zoned(8) inz;
001700230502       dcl-s w80dateE Zoned(8) inz;
001800230502
001900230502     D Tomorrow        S               D   datfmt(*ISO)
002000230502    ?D ISOToday        S               D   datfmt(*ISO)
002100230502
002200000000      * Program status data structure
002300000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002400230502
002500230502             w80dateE = %int(%char(%date : *iso0));
002600230502             isoToday = %Date(w80dateE:*iso);
002700230502
002800230502     C     ISOToday      Adddur    1:*d          Tomorrow
002900230502                w80dateB = %dec(Tomorrow);
003000230502
003100230502       // We want to start on the 1st so nothing transmits tonight
003200230502         w80dateB = 20230501;
003300230502         w80dateE = 20230430;
003400230502
003500230502         Setll *start Ease10p;
003600230502
003700230502         Dou %Eof(Ease10p);
003800230502           read Ease10p;
003900230502
004000230502           if %eof(Ease10p);
004100230502             leave;
004200230502           endif;
004300230502
004400230502             wTrst = %Dec(%Subst(TSA:1:3):3:0);
004500230502             wSub# = %Dec(%Subst(TSA:4:3):3:0);
004600230502             wAcct = %Dec(%Subst(TSA:7:4):4:0);
004700230502
004800230502           Setll ( wTrst : wSub# : wAcct ) ACCOSPL3;
004900230502           Dou %Eof(ACCOSPL3);
005000230502             reade ( wTrst : wSub# : wAcct ) ACCOSPL3;
005100230502             if %eof(ACCOSPL3);
005200230502               leave;
005300230502             endif;
005400230502
005500230502             if   aocode = 01;
005600230503             AOENDT = W80dateE;
005700230502             update  ACCOSPR;
005800230502
005900230502             Clear ACCOSPR;
006000230502             AOTRST = wTrst;
006100230502             AOSUB# = wSub#;
006200230502             AOACCT = wAcct;
006300230502             AOBEDT = w80dateB;
006400230502             AOENDT = 0;
006500230502             AOCODE = 10;
006600230502             AOCHDT = w80dateE;
006700230502             AOCHGU = 'EASE10R';
006800230503             AODTDT = W80dateE;
006900230502             write   ACCOSPR;
007000230502             delete  EASER;
007100230503             leave;
007200230502
007300230503             else;
007400230503             TRS  =  wTrst;
007500230503             SUB  =  wSub#;
007600230503             ACC  =  wAcct;
007700230503             TCODE =  AOCODE;
007800230503             update   EASER;
007900230502             endif;
008000230502
008100230502             Enddo;
008200230502
008300230502             Enddo;
008400230502
008500230502             *inLR = *on;
008600230502             return;
008700230502
008800000000      *___________________________________________________________________
008900000000      * Key Lists
009000000000      *___________________________________________________________________
009100000000     C     KLIST         BEGSR
009200000000     C                   ENDSR
009300000000      *___________________________________________________________________
009400000000      * Program open
009500000000      *___________________________________________________________________
009600000000     C     *INZSR        BEGSR
009700000000     C                   ENDSR
009800000000      *___________________________________________________________________
009900000000      * Program error handler
010000000000      *___________________________________________________________________
010100000000     C     *PSSR         BEGSR
010200000000     C                   CALL      'SNDRPGM'                            50
010300000000     C                   PARM                    WQPGMN
010400000000     C                   PARM                    WQSTSC
010500000000     C                   PARM                    WQRPGS
010600000000     C                   PARM                    WQMSG
010700000000     C                   ENDSR     '*CANCL'
