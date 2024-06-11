000100101222     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200101222     H option(*SRCSTMT: *NODEBUGIO)
000300000000      *_________________________________________________________________________
000400000000      *
000500170419      *  Description:  Reinstate Version
000600000000      *
000700110506      *  (c)Copyright 2011 by GBS, Inc.
000800000000      *
000900110506      *    Created by:  JALLEN - May 06, 2011
001000000000      *_________________________________________________________________________
001100170419     faccosp    if   e           K disk    usropn
001200170419
001300170419     d  Today          s              8s 0 inz
001400180116     d  RPGSPLib       s             10a
001500180116     d  RPGSPflg       s              1a
001600170419
001700170419     d  WEBDED       e ds                  extname(webpayded)
001800170419
001900170419     C                   Exsr      OpenFiles
002000170419      * Default
002100170419     C                   Clear                   aocode
002200170419
002300170419     C     ospKey        Klist
002400170419     C                   Kfld                    pqTRS
002500170419     C                   Kfld                    pqSUB
002600170419     C                   Kfld                    pqact
002700180115
002800180116     C                   clear                   RPGSPflg
002900170419
003000170419     C     ospKey        Setgt     ACCOSP
003100170419     C     ospKey        Readpe    ACCOSP
003200170419     C                   Dow       not %eof
003300170419      *
003400170419     C                   Select
003500170419     C                   When      Today >= AOBEDT  and
003600170419     C                             AOENDT = 0
003700170419
003800170419     C                   Exsr      SetRPGSP
003900170419
004000180116     C                   eval      RPGSPflg = 'Y'
004100170419     C                   Leave
004200170419     C                   When      Today >= AOBEDT  and
004300170419     C                             Today <= AOENDT
004400170419
004500170419     C                   Exsr      SetRPGSP
004600170419
004700180116     C                   eval      RPGSPflg = 'Y'
004800170419     C                   Leave
004900170419     C                   Endsl
005000170419      *
005100170419     C     ospKey        Readpe    ACCOSP
005200170419     C                   Enddo
005300180115
005400180116     C                   if        RPGSPflg = *blanks
005500180116     C                   Exsr      GuessRPGSP
005600180115     C                   end
005700170419
005800170419     C                   Close     accosp
005900170419     C                   return
006000170419
006100170419     C     SetRPGSP      Begsr
006200170419
006300170419     C                   Select
006400170419     C                   When      %trim(RPGSPLIB) = 'QS36F' and
006500170419     C                             aocode = 8
006600170419     C                   Eval      RPGSPLIB = 'RPGSPDASH'
006700170419     C                   When      %trim(RPGSPLIB) = 'QS36F' and
006800170419     C                             aocode = 9
006900170419     C                   Eval      RPGSPLIB = 'RPGSPDASH'
007000170419     C                   When      %trim(RPGSPLIB) = 'GBSDTAT' and
007100170419     C                             aocode = 8
007200170419     C                   Eval      RPGSPLIB = 'RPGSPBETA'
007300170419     C                   When      %trim(RPGSPLIB) = 'GBSDTAT' and
007400170419     C                             aocode = 9
007500170419     C                   Eval      RPGSPLIB = 'RPGSPBETA'
007600170419     C                   Other
007700170419     C                   Eval      RPGSPLIB = 'RPGSPPAYR'
007800170419     C                   Endsl
007900170419
008000170419     C                   Endsr
008100180116     C     GuessRPGSP    Begsr
008200180116
008300180116     C                   Select
008400180116     C                   When      %trim(RPGSPLIB) = 'QS36F'
008500180116     C                   Eval      RPGSPLIB = 'RPGSPDASH'
008600180116     C                   When      %trim(RPGSPLIB) = 'GBSDTAT'
008700180116     C                   Eval      RPGSPLIB = 'RPGSPBETA'
008800180116     C                   Other
008900180116     C                   Eval      RPGSPLIB = 'RPGSPPAYR'
009000180116     C                   Endsl
009100180116
009200180116     C                   Endsr
009300170419
009400170419     C     OpenFiles     Begsr
009500170419
009600170419     C     *Entry        Plist
009700170419     C                   Parm                    WEBDED
009800170419     C                   Parm                    RPGSPLIB
009900170419
010000170419     C                   Open      accosp
010100170419
010200170419     C                   eval      Today  = %int(%char(%date : *iso0))
010300170419
010400170419     C                   Endsr
