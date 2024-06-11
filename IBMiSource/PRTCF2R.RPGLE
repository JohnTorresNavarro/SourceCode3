000100000000      *_________________________________________________________________________
000200000000      *
000300081203      *  Description:  Print Fixed By Report
000400000000      *
000500081203      *  (c)Copyright 2008 by GBS, Inc.
000600000000      *
000700081203      *    Created by:  JALLEN - Dec 03, 2008
000800000000      *_________________________________________________________________________
000900130807     FTRNSUMPL3 IP   E           K DISK
001000131023     FPRTCF21P  IF   E           k DISK
001100131023     FPRTCF23P  IF   E           k DISK
001200131018     FPRTCF2PP  O  a E             DISK
001300131018     FPRTCF22P  O  a E             DISK
001400081203     FPRTCF2P   O    E             PRINTER oflind(*in91)
001500031107      *
001600031107     D Count           S              5S 0
001700131015     D Tount           S              5S 0
001800131023     D wbig            S             10S 2
001900131023     D pos             S              3S 0
002000131023     D Dept            S             40a
002100081203      *
002200081203     ITRNSUMR       01
002300081203     I                                          SMUSER        L2
002400030829      *
002500081203    ?C   L2              Move      *on           *in91
002600081203      *
002700081203      *
002800081203     C   01              CALL      'RTVAALCL'
002900081203     C                   PARM                    SMUSER
003000081203     C                   PARM                    SMTEXT           50
003100140110      *
003200140110     C                   Clear                   DEPT
003300131023      *
003400131023     C                   Eval      pos = %scan('-':SMTEXT)
003500131023     C                   If        pos > 0
003600131023     C                   Eval      DEPT   = %subst(SMTEXT:pos+1)
003700131023     C                   Eval      SMTEXT = %subst(SMTEXT:1:pos-1)
003800131023     C                   End
003900131023     C                   If        %trim(SMTEXT) = 'Jenny Snowden'
004000131023     C                   Eval      SMTEXT = 'Jenny Bartholme'
004100131023     C                   End
004200140110     C                   If        DEPT = *blanks
004300131023     C                   eval      C3NAME = %trim(SMTEXT)
004400131023     C     C3NAME        Chain     PRTCF23P
004500131023     C                   If        %found(PRTCF23P)
004600131023     C                   Eval      DEPT = %trim(C3DEPT)
004700140110     C                   Else
004800140110     C                   Eval      DEPT = *blanks
004900140110     C                   End
005000131023     C                   End
005100081203      *
005200090716    ?C** 01              Exsr      ChkOvf
005300081203     C   01SMDATE        Mult      10000.0001    WPDATE
005400090716     C   01              Eval      WWUSER = SMTEXT
005500090716     C   01              Eval      WWNAME = SMNAME
005600090716     C   01              Eval      FCREAS = SMFIXR
005700081203      *
005800131018     C                   If        SMFIXR <> *blanks
005900081203     C   01              Eval      Count += 1
006000131018    ?C   01              Write     PRTDTL
006100131018    ?C   01              Write     CF2PPR
006200131018     C                   End
006300081203      *
006400081203     CL2                 Exsr      COTALS
006500081203     CLR                 Exsr      TOTALS
006600081203    ? *___________________________________________________________________
006700081203      * Cotals
006800081203    ? *___________________________________________________________________
006900081203     C     COTALS        Begsr
007000131010      *
007100131010     C                   Eval      PCount = *zeros
007200131010     C                   Eval      WPERC = *zeros
007300131010      *
007400131010     C     SMUSER        Chain     PRTCF21P
007500131010     C                   If        %found(PRTCF21P)
007600131010     C                   Select
007700131010     C                   When      PCount > 0  and
007800131010     C                             Count > 0
007900131010     C                   Eval      WPERC = (Count / PCount) * 100
008000131010     C                   When      PCount > 0  and
008100131010     C                             Count = 0
008200131018     C                   Eval      WPERC = 000.00
008300131010     C                   Endsl
008400131015     C                   Eval      wgcount = wgcount + PCount
008500131010     C                   End
008600081203      *
008700131018     C                   If        Count > 0
008800081203     C                   Eval      WCCOUNT = Count
008900081203     C                   Eval      WTCOUNT = WTCOUNT + Count
009000081203     C                   Write     PRTCOT
009100131018     C                   Else
009200131018    ?C                   Write     PRTDTL0
009300131018     C                   Eval      WCCOUNT = Count
009400131018     C                   Eval      WTCOUNT = WTCOUNT + Count
009500131018     C                   Write     PRTCOT
009600131018     C                   End
009700131018      *
009800131022     C                   Eval      C2XLS = '"' +
009900131022     C                                     %trim(SMTEXT) + '","' +
010000131023     C                                     %trim(DEPT) + '","' +
010100131022     C                                     %char(WCCOUNT) + '","' +
010200131022     C                                     %char(PCOUNT) + '","' +
010300131022     C                                     %char(WPERC) + '"'
010400131018    ?C                   Write     CF22PR
010500081203      *
010600081203     C                   Eval      Count   = 0
010700081203     C                   Eval      WCCOUNT = 0
010800081203      *
010900081203     C                   Endsr
011000081203    ? *___________________________________________________________________
011100081203      * Totals
011200081203    ? *___________________________________________________________________
011300081203     C     TOTALS        Begsr
011400131015      *
011500131015     C                   Eval      Wbig = (WTCount / WGCount) * 100
011600131015     C                   z-add     wbig          wpcount
011700081203      *
011800081203     C                   Write     PRTTOT
011900131022      *
012000131023     C                   clear                   DEPT
012100131022     C                   Eval      C2XLS = '"REPORT TOTALS","' +
012200131023     C                                     %trim(DEPT) + '","' +
012300131022     C                                     %char(WTCOUNT) + '","' +
012400131022     C                                     %char(WGCOUNT) + '","' +
012500131022     C                                     %char(WPCOUNT) + '"'
012600131022    ?C                   Write     CF22PR
012700081203      *
012800081203     C                   Endsr
012900030422    ? *___________________________________________________________________
013000030422    ? * Check Overflow
013100030422    ? *___________________________________________________________________
013200030422    ?C     ChkOvf        Begsr
013300081203B001?C     *in91         Ifeq      *On
013400030422 001?C                   Time                    WPTIM
013500030422 001?C                   Write     PRTHDR
013600030422 001?C                   Move      *Off          *In91
013700030422E001?C                   Endif
013800030422    ?C                   Endsr
013900030422      *___________________________________________________________________
014000030422      * Program initialization
014100030422      *___________________________________________________________________
014200030422     C     *INZSR        BEGSR
014300131010      *
014400131010     C     *Entry        Plist
014500131010     C                   Parm                    wiFrom            8
014600131010     C                   Parm                    wiTo              8
014700131015      *
014800131015     C                   move      wiFrom        wfrom
014900131015     C                   move      wito          wto
015000131015      *
015100131015     C     wfrom         Mult      10000.0001    wfrom
015200131015     C     wto           Mult      10000.0001    wto
015300030422      *
015400081204     C                   Eval      WQPGMN =      'PRTCF2R'
015500090716 001?C                   Time                    WPTIM
015600090716 001?C                   Write     PRTHDR
015700090716 001?C                   Move      *Off          *In91
015800131022
015900131022     C                   eval      C2XLS  = '"' +
016000131023     C                                     'User Name' + '","' +
016100131023     C                                     'Department' + '","' +
016200131023     C                                     'Error Total' + '","' +
016300131023     C                                     'Total Transactions' + '","' +
016400131022     C                                     'Percentage' + '"'
016500131022     C                   WRITE     CF22PR
016600030422      *
016700030422    ?C                   Endsr
