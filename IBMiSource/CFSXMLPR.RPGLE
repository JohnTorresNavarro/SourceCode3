000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  CFS XML Letter parser
000400000000      *
000500000000      *  (c)Copyright 2004 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - December 14, 2004
000800000000      *_________________________________________________________________________
000900041214     FCFSXML    IP   E             DISK    Rename(CFSXMLR:XMLR)
001000041214     FCFSXMLP   O  A E           K DISK
001100041214
001200041214     D Pos             s              3S 0 inz
001300041214     D End             s              3S 0 inz
001400041214     D Siz             s              3S 0 inz
001500041214
001600041215     D LOGO            c                   '<logocode>'
001700041214     D GRPID           c                   '<groupid>'
001800041214     D RNLDT           c                   '<renewaldate>'
001900041214     D PRCMT           c                   '<processmonth>'
002000041214     D GPADM           c                   '<groupadmin>'
002100041214     D GPNAM           c                   '<groupname>'
002200041214     D GPAD1           c                   '<groupaddrline1>'
002300041214     D GPAD2           c                   '<groupaddrline2>'
002400041214     D GPAD3           c                   '<groupaddrline3>'
002500041214     D GPAD4           c                   '<groupaddrline4>'
002600041214     D CITY            c                   '<city>'
002700041214     D STATE           c                   '<state>'
002800041214     D ZIPCD           c                   '<zipcode>'
002900041214     D ACMGR           c                   '<acctmgr>'
003000041214     D ACPHN           c                   '<acctmgrphone>'
003100041214     D ACEXT           c                   '<acctmgrphoneext>'
003200041214
003300041214     C                   Eval      XMLDTA = %trim(XMLDTA)
003400041214
003500041214     C                   Select
003600041215     C                   When      %subst(XMLDTA:1:10) = LOGO
003700041215     C                   Eval      pos = %scan('>':XMLDTA:1)
003800041215     C                   Eval      end = %scan('</':XMLDTA:1)
003900041215     C                   Eval      siz = (end - pos) - 1
004000041215     C                   Eval      XMLOGO = %subst(XMLDTA:Pos+1:Siz)
004100041215
004200041214     C                   When      %subst(XMLDTA:1:9) = GRPID
004300041214     C                   Eval      pos = %scan('>':XMLDTA:1)
004400041214     C                   Eval      end = %scan('</':XMLDTA:1)
004500041214     C                   Eval      siz = (end - pos) - 1
004600041214     C                   Eval      XMGRPID = %subst(XMLDTA:Pos+1:Siz)
004700041214
004800041214     C                   When      %subst(XMLDTA:1:13) = RNLDT
004900041214     C                   Eval      pos = %scan('>':XMLDTA:1)
005000041214     C                   Eval      end = %scan('</':XMLDTA:1)
005100041214     C                   Eval      siz = (end - pos) - 1
005200041214     C                   Eval      XMRNLDT = %subst(XMLDTA:Pos+1:Siz)
005300041214
005400041214     C                   When      %subst(XMLDTA:1:14) = PRCMT
005500041214     C                   Eval      pos = %scan('>':XMLDTA:1)
005600041214     C                   Eval      end = %scan('</':XMLDTA:1)
005700041214     C                   Eval      siz = (end - pos) - 1
005800041214     C                   Eval      XMPRCMT = %subst(XMLDTA:Pos+1:Siz)
005900041214
006000041214     C                   When      %subst(XMLDTA:1:12) = GPADM
006100041214     C                   Eval      pos = %scan('>':XMLDTA:1)
006200041214     C                   Eval      end = %scan('</':XMLDTA:1)
006300041214     C                   Eval      siz = (end - pos) - 1
006400041214     C                   Eval      XMGPADM = %subst(XMLDTA:Pos+1:Siz)
006500041214
006600041214     C                   When      %subst(XMLDTA:1:11) = GPNAM
006700041214     C                   Eval      pos = %scan('>':XMLDTA:1)
006800041214     C                   Eval      end = %scan('</':XMLDTA:1)
006900041214     C                   Eval      siz = (end - pos) - 1
007000041214     C                   Eval      XMGPNAM = %subst(XMLDTA:Pos+1:Siz)
007100041214
007200041214     C                   When      %subst(XMLDTA:1:16) = GPAD1
007300041214     C                   Eval      pos = %scan('>':XMLDTA:1)
007400041214     C                   Eval      end = %scan('</':XMLDTA:1)
007500041214     C                   Eval      siz = (end - pos) - 1
007600041214     C                   Eval      XMGPAD1 = %subst(XMLDTA:Pos+1:Siz)
007700041214
007800041214     C                   When      %subst(XMLDTA:1:16) = GPAD2
007900041214     C                   Eval      pos = %scan('>':XMLDTA:1)
008000041214     C                   Eval      end = %scan('</':XMLDTA:1)
008100041214     C                   Eval      siz = (end - pos) - 1
008200041214     C                   Eval      XMGPAD2 = %subst(XMLDTA:Pos+1:Siz)
008300041214
008400041214     C                   When      %subst(XMLDTA:1:16) = GPAD3
008500041214     C                   Eval      pos = %scan('>':XMLDTA:1)
008600041214     C                   Eval      end = %scan('</':XMLDTA:1)
008700041214     C                   Eval      siz = (end - pos) - 1
008800041214     C                   Eval      XMGPAD3 = %subst(XMLDTA:Pos+1:Siz)
008900041214
009000041214     C                   When      %subst(XMLDTA:1:16) = GPAD4
009100041214     C                   Eval      pos = %scan('>':XMLDTA:1)
009200041214     C                   Eval      end = %scan('</':XMLDTA:1)
009300041214     C                   Eval      siz = (end - pos) - 1
009400041214     C                   Eval      XMGPAD4 = %subst(XMLDTA:Pos+1:Siz)
009500041214
009600041214     C                   When      %subst(XMLDTA:1:6) = CITY
009700041214     C                   Eval      pos = %scan('>':XMLDTA:1)
009800041214     C                   Eval      end = %scan('</':XMLDTA:1)
009900041214     C                   Eval      siz = (end - pos) - 1
010000041214     C                   Eval      XMCITY  = %subst(XMLDTA:Pos+1:Siz)
010100041214
010200041214     C                   When      %subst(XMLDTA:1:7) = STATE
010300041214     C                   Eval      pos = %scan('>':XMLDTA:1)
010400041214     C                   Eval      end = %scan('</':XMLDTA:1)
010500041214     C                   Eval      siz = (end - pos) - 1
010600041214     C                   Eval      XMSTATE = %subst(XMLDTA:Pos+1:Siz)
010700041214
010800041214     C                   When      %subst(XMLDTA:1:9) = ZIPCD
010900041214     C                   Eval      pos = %scan('>':XMLDTA:1)
011000041214     C                   Eval      end = %scan('</':XMLDTA:1)
011100041214     C                   Eval      siz = (end - pos) - 1
011200041214     C                   Eval      XMZIPCD = %subst(XMLDTA:Pos+1:Siz)
011300041214
011400041214     C                   When      %subst(XMLDTA:1:9) = ACMGR
011500041214     C                   Eval      pos = %scan('>':XMLDTA:1)
011600041214     C                   Eval      end = %scan('</':XMLDTA:1)
011700041214     C                   Eval      siz = (end - pos) - 1
011800041214     C                   Eval      XMACMGR = %subst(XMLDTA:Pos+1:Siz)
011900041214
012000041214     C                   When      %subst(XMLDTA:1:14) = ACPHN
012100041214     C                   Eval      pos = %scan('>':XMLDTA:1)
012200041214     C                   Eval      end = %scan('</':XMLDTA:1)
012300041214     C                   Eval      siz = (end - pos) - 1
012400041214     C                   Eval      XMACMPH = %subst(XMLDTA:Pos+1:Siz)
012500041214
012600041214     C                   When      %subst(XMLDTA:1:17) = ACEXT
012700041214     C                   Eval      pos = %scan('>':XMLDTA:1)
012800041214     C                   Eval      end = %scan('</':XMLDTA:1)
012900041214     C                   Eval      siz = (end - pos) - 1
013000041214     C                   Eval      XMACEXT = %subst(XMLDTA:Pos+1:Siz)
013100041214     C                   Write     CFSXMLR
013200041214     C                   Clear                   CFSXMLR
013300041214
013400041214     C                   Other
013500041214     C                   Endsl
013600041214
