000100060120     FSMANRLT   IPE  E           K DISK
000200060120     FSPRAGXR2  IF   E           K DISK
000300060120     FSUPRAGCY  IF   E           K DISK
000400110323     FSMANSP    IF   E           K DISK
000500110323     FAGENL4    IF   E           K DISK
000600110323     FKTH012WF  O  A E           K DISK
000700060120   X***X
000800110323     D UP              C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
000900110323     D LO              C                   'abcdefghijklmnopqrstuvwxyz'
001000110323    ***
001100060120     D A1            E DS                  EXTNAME(SPRAGXRF)
001200060120     D A2            E DS                  EXTNAME(SUPRAGCY)
001300060120     D A3            E DS                  EXTNAME(SMAN)
001400060120     D A4            E DS                  EXTNAME(AGENCY)
001500110323     D A5            E DS                  EXTNAME(SMANRLT)
001600060120   X***X
001700110323     C                   CLEAR                   F012
001800060120     C                   CLEAR                   A1
001900060120     C                   CLEAR                   A2
002000060120     C                   CLEAR                   A3
002100060120     C                   CLEAR                   A4
002200060120     C     SRSMAN        CHAIN     SMANR
002300060120     C     SRASID        CHAIN     SXF
002400060120     C     SXSUPER       CHAIN     SAF
002500060120     C     SXAGCY        CHAIN     AGENR
002600060120    ***
002700060120     C                   CLEAR                   A@20             20
002800060120     C                   CLEAR                   A@40             40
002900060120    ***
003000060120     C                   IF        SFNAME <> *BLANKS
003100060120     C                   MOVEL     SFNAME        A@20
003200060120     C                   EXSR      $LDADDR
003300060120     C                   ENDIF
003400060120    ***
003500060120     C                   IF        SMI <> *BLANKS
003600060120     C                   MOVEL     SMI           A@20
003700060120     C                   EXSR      $LDADDR
003800060120     C                   ENDIF
003900060120    ***
004000060120     C                   IF        SLNAME <> *BLANKS
004100060120     C                   MOVEL     SLNAME        A@20
004200060120     C                   EXSR      $LDADDR
004300060120     C                   ENDIF
004400060120    ***
004500110323     C                   EVAL      F2SNAME  = A@40
004600110323     C                   EVAL      F2SMAN   = SRSMAN
004700110323     C                   EVAL      F2GRPR   = SGRP
004800110323     C                   EVAL      F2SMNEFF = SBEGDT
004900110323     C                   EVAL      F2SMNTRM = SENDDT
005000060120    ***
005100110323     C                   EVAL      F2UNAME  = SANAME1
005200110323     C                   EVAL      F2SUPER  = SACODE
005300110323     C                   EVAL      F2SUPEFF = SAEFFDTE
005400110323     C                   EVAL      F2SUPTRM = SATRMDTE
005500060120    ***
005600110323     C                   EVAL      F2RELID  = SRRELID
005700110323     C                   EVAL      F2RELEFF = SREFFDTE
005800110323     C                   EVAL      F2RELTRM = SRTRMDTE
005900060120    ***
006000110323     C                   EVAL      F2LINK   = SXASID
006100110323     C                   EVAL      F2LNKEFF = SXEFFDTE
006200110323     C                   EVAL      F2LNKTRM = SXTRMDTE
006300110323    ***
006400110323     C     LO:UP         XLATE     AGNAM1        AGNAM1
006500110323     C                   EVAL      F2ANAME  = AGNAM1
006600110323     C                   EVAL      F2AGCY   = AGCODE
006700110323     C                   EVAL      F2AGCEFF = AGEFDT
006800110323     C                   EVAL      F2AGCTRM = AGTMDT
006900060120    ***
007000110323     C                   WRITE     F012
007100060120    ***
007200060120   S***S
007300060120     C     $LDADDR       BEGSR
007400060120    ***
007500060120     C                   EVAL      A@20 = %TRIM(A@20)
007600060120     C                   EVAL      A@40 = %TRIM(A@40) + ' ' + A@20
007700060120     C                   CLEAR                   A@20
007800060120    ***
007900060120     C                   ENDSR
008000060120   S***S
