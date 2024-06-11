000100230206          Ctl-opt option(*nodebugio:*srcstmt:*nounref)
000200230206                           DftActGrp(*no)
000300230206                           bnddir('GBSBDIR' )   ;
000400230206
000500000000      *_________________________________________________________________________
000600000000      *
000700231208      *  (c)Copyright 2023 by Amwins.
000800000000      *
000900231208      *    Created by:  JALLEN - December 08, 2023
001000230914      *
001100000000      *_________________________________________________________________________
001200231208       Dcl-f ddlistp keyed usage( *input );
001300231208       Dcl-f AccMst keyed ExtDesc('F.ACCMST') ExtFile(*extdesc);
001400231208       Dcl-f Ac2MstL2 keyed ExtDesc('AC2MSTL2') ExtFile(*extdesc);
001500231208       Dcl-f ddaccadrp Keyed usage( *input : *output );
001600230206
001700231016     D In_OETRST       S              3S 0 inz
001800231016     D In_OESUB#       S              3S 0 inz
001900231016     D In_OEACCT       S              4S 0 inz
002000230206
002100000000      * Program status data structure
002200000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002300231016
002400231208                read   ddlistp;
002500231208                dow not %eof(ddlistp);
002600231208
002700231208           in_oetrst = %dec(%subst(XTSA:1:3):3:0);
002800231208           in_oesub# = %dec(%subst(XTSA:5:3):3:0);
002900231208           in_oeacct = %dec(%subst(XTSA:9:4):4:0);
003000231208
003100231208           chain ( in_oetrst : in_oeSub# : in_oeAcct ) AccMst;
003200231208           if %found(ACCMST);
003300231208
003400231208           DDGRP = XGRP;
003500231208           DDTRST = %editc(in_oetrst:'X');
003600231208           DDSUB# = %editc(in_oesub#:'X');
003700231208           DDACCT = %editc(in_oeacct:'X');
003800231208
003900231208           chain ( in_oetrst : in_oeSub# : in_oeAcct ) Ac2MstL2;
004000231208           if %found(AC2MSTl2) and %trim(A2ADDRESS1) <> *blanks and
004100231208           %trim(A2CITY) <> *blanks and %trim(A2STATE) <> *blanks;
004200231208           DDACNAM1 = %trim(ACNAM1);
004300231208           DDACNAM2 = %trim(ACNAM2);
004400231208           DDADDR1 = %trim(A2ADDRESS1);
004500231208           DDADDR2 = %trim(A2ADDRess2);
004600231208           DDCITY = %trim(A2CITY);
004700231208           DDSTATE = %trim(A2STATE);
004800231208           DDZIP5 = %char(A2ZIP5);
004900231208           DDZIP4 = %char(A2ZIP4);
005000231208           else;
005100231208           DDACNAM1 = %trim(ACNAM1);
005200231208           DDACNAM2 = %trim(ACNAM2);
005300231208           DDADDR1 = %trim(AADDR1);
005400231208           DDADDR2 = %trim(AADDR2);
005500231208           DDCITY = %trim(ACITY);
005600231208           DDSTATE = %trim(ASTATE);
005700231208           DDZIP5 = %subst(%char(AZIP):1:5);
005800231208           DDZIP4 = %subst(%char(AZIP):6:4);
005900231208           endif;
006000231208
006100231208           write    ddadrr;
006200231208
006300231208           endif;
006400231016
006500231208                read   ddlistp;
006600230206     C                   enddo
006700231016
006800230206     C                   eval      *inlr = *on
006900230206     C                   return
007000000000      *___________________________________________________________________
007100000000      * Program open
007200000000      *___________________________________________________________________
007300000000     C     *INZSR        BEGSR
007400000000     C                   ENDSR
007500000000      *___________________________________________________________________
007600000000      * Program error handler
007700000000      *___________________________________________________________________
007800000000     C     *PSSR         BEGSR
007900000000     C                   CALL      'SNDRPGM'                            50
008000000000     C                   PARM                    WQPGMN
008100000000     C                   PARM                    WQSTSC
008200000000     C                   PARM                    WQRPGS
008300000000     C                   PARM                    WQMSG
008400000000     C                   ENDSR     '*CANCL'
