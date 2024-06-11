000100101222     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*CALLER)
000200101222     H option(*SRCSTMT: *NODEBUGIO)
000300000000      *_________________________________________________________________________
000400000000      *
000500170505      *  Description:  Set OLE LIBL
000600000000      *
000700170505      *  (c)Copyright 2017 by GBS, Inc.
000800000000      *
000900170505      *    Created by:  JALLEN - May 05, 2017
001000000000      *_________________________________________________________________________
001100170419     faccosp    if   e           K disk    usropn
001200170419
001300170419     d  Today          s              8s 0 inz
001400170419     d  RPGSPLib       s             10a
001500170419
001600170419     d  WEBDED       e ds                  extname(webpayded)
001700170419
001800170419     C                   Exsr      OpenFiles
001900170419      * Default
002000170419     C                   Clear                   aocode
002100170419
002200170419     C     ospKey        Klist
002300170419     C                   Kfld                    pqTRS
002400170419     C                   Kfld                    pqSUB
002500170419     C                   Kfld                    pqact
002600170419
002700170419     C     ospKey        Setgt     ACCOSP
002800170419     C     ospKey        Readpe    ACCOSP
002900170419     C                   Dow       not %eof
003000170419      *
003100170419     C                   Select
003200170419     C                   When      Today >= AOBEDT  and
003300170419     C                             AOENDT = 0
003400170419
003500170419     C                   Exsr      SetRPGSP
003600170419
003700170419     C                   Leave
003800170419     C                   When      Today >= AOBEDT  and
003900170419     C                             Today <= AOENDT
004000170419
004100170419     C                   Exsr      SetRPGSP
004200170419
004300170419     C                   Leave
004400170419     C                   Endsl
004500170419      *
004600170419     C     ospKey        Readpe    ACCOSP
004700170419     C                   Enddo
004800170419
004900170419     C                   Close     accosp
005000170419     C                   return
005100170419
005200170419     C     SetRPGSP      Begsr
005300170419
005400170419     C                   Select
005500170419     C                   When      %trim(RPGSPLIB) = 'QS36F' and
005600170419     C                             aocode = 8
005700170419     C                   Eval      RPGSPLIB = 'RPGSPDASH'
005800170419     C                   When      %trim(RPGSPLIB) = 'QS36F' and
005900170419     C                             aocode = 9
006000170419     C                   Eval      RPGSPLIB = 'RPGSPDASH'
006100170419     C                   When      %trim(RPGSPLIB) = 'GBSDTAT' and
006200170419     C                             aocode = 8
006300170419     C                   Eval      RPGSPLIB = 'RPGSPBETA'
006400170419     C                   When      %trim(RPGSPLIB) = 'GBSDTAT' and
006500170419     C                             aocode = 9
006600170419     C                   Eval      RPGSPLIB = 'RPGSPBETA'
006700170419     C                   Other
006800170419     C                   Eval      RPGSPLIB = 'RPGSPPAYR'
006900170419     C                   Endsl
007000170419
007100170419     C                   Endsr
007200170419
007300170419     C     OpenFiles     Begsr
007400170419
007500170419     C     *Entry        Plist
007600170419     C                   Parm                    WEBDED
007700170419     C                   Parm                    RPGSPLIB
007800170419
007900170419     C                   Open      accosp
008000170419
008100170419     C                   eval      Today  = %int(%char(%date : *iso0))
008200170419
008300170419     C                   Endsr
