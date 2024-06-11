000100240109     H DFTACTGRP(*NO) ACTGRP(*CALLER) BNDDIR('GBSBDIR')
000200240109     H option(*nodebugio)
000300000000      *_________________________________________________________________________
000400000000      *
000500000000      *  Description:  Process Declines from FM070
000600000000      *
000700000000      *  (c)Copyright 2024 by Innovative Outsourcing, Inc.
000800000000      *
000900000000      *    Created by:  JALLEN - January 09, 2024
001000000000      *_________________________________________________________________________
001100240109     FDCLCATXRLFIF   E           K DISK
001200240109
001300240109      /copy *libl/qmodsrc,#retdclpr
001400240109      /copy *libl/qmodsrc,#hstdclpr
001500240109      /copy *libl/qmodsrc,#trmdclpr
001600240109
001700240109J002 d dclpdsc         s             30
001800240109J002 d dclpcat         s              3
001900240109J002 d hstflg          s              1
002000240109
002100240109     D webds         e ds                  extname(webdclds)
002200240109     D webtrn        e ds                  extname(webtran)
002300240109
002400000000      * Program status data structure
002500000000     D PGMD          ESDS                  EXTNAME(IOPGMD)
002600240109
002700240109     C     *entry        Plist
002800240109     C                   parm                    webds
002900240109
003000240109J002  * Check for existing decline and auto retire it
003100240109J002 C                   eval      dclpdsc = #retdcl(dstrs:dssub:dsacc:
003200240109J002 C                             dsssn:dscat)
003300240109J002  * Write History Record
003400240109J002 C                   if        %trim(dclpdsc) <> *blanks
003500240109J002 C                   eval      hstflg = #hstdcl(dstrs:dssub:dsacc:
003600240109J002 C                             dsssn:dseff:dscat:dclpdsc)
003700240109J002  * Create TRM_COVG records for declined plan
003800240109J002 C     dscat         chain     dclcatxrlf
003900240109J002 C                   if        %found(dclcatxrlf)
004000240109J002 C                   clear                   webtrn
004100240109J002 C                   Eval      OETRST = dstrs
004200240109J002 C                   Eval      OESUB# = dssub
004300240109J002 C                   Eval      OEACCT = dsacc
004400240109J002 C                   Eval      OESSNO = dsssn
004500240109J002 C                   eval      OEGRPV = DCLPLN
004600240109J002      oeaddd = %dec( %char( %date(DSEFF : *usa) : *iso0) : 8 : 0);
004700240109J002 C                   eval      hstflg = #trmdcl(webtrn)
004800240109J002 C                   end
004900240109J002 C                   end
005000240109
005100240109                         *inLR = *on;
005200240109                         return;
005300000000      *___________________________________________________________________
005400000000      * Key Lists
005500000000      *___________________________________________________________________
005600000000     C     KLIST         BEGSR
005700000000     C                   ENDSR
005800000000      *___________________________________________________________________
005900000000      * Program open
006000000000      *___________________________________________________________________
006100000000     C     *INZSR        BEGSR
006200000000     C                   ENDSR
006300000000      *___________________________________________________________________
006400000000      * Program error handler
006500000000      *___________________________________________________________________
006600000000     C     *PSSR         BEGSR
006700000000     C                   CALL      'SNDRPGM'                            50
006800000000     C                   PARM                    WQPGMN
006900000000     C                   PARM                    WQSTSC
007000000000     C                   PARM                    WQRPGS
007100000000     C                   PARM                    WQMSG
007200000000     C                   ENDSR     '*CANCL'
