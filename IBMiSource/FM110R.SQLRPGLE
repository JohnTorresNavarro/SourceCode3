000100050705    ?Ffm110rd   CF   E             WORKSTN INFDS(WSDS) SFILE(LSTSFL:RRT)
000200040827   X***X
000300050705     D/COPY GALIB/QRPGLESRC,FKEYSTD
000400040827   X***X
000500050623     d ap              s              1a   INZ('''')
000600040827    ***
000700040827     D @STEP           S              5A
000800050705     D P@sgrp          S              5A
000900040827     D RRT             S              4S 0
001000040827     D #CNT            S              4S 0
001100040827   X***X
001200040827     C                   DOU       @STEP = 'LEAVE'
001300040827     C     @STEP         CASEQ     'PREP1'       $PREP1
001400040827     C     @STEP         CASEQ     'STEP1'       $STEP1
001500040827     C                   ENDCS
001600040827     C                   ENDDO
001700040827     C                   EVAL      *INLR = *ON
001800040827   S***S
001900040827     C     *INZSR        BEGSR
002000040827    ***
002100040827     C     *ENTRY        PLIST
002200050705     C                   PARM                    P@sgrp
002300040827    ***
002400040827     C                   EVAL      @STEP = 'PREP1'
002500050705     c                   evalr     wspsn1 = '00000'
002600050705     c                   z-add     41            #c                3 0
002700050705     c                   movea     '100'         *in(41)
002800050705     C                   move      '00000'       P@sgrp
002900040827    ***
003000040827     C                   ENDSR
003100040827   S***S
003200040827     C     $PREP1        BEGSR
003300040827    ***
003400040827     C                   EXSR      $BUILDSFL
003500050623     c                   eval      wspsn1 = *blanks
003600050623     c                   eval      wspsn2 = *blanks
003700050623     c                   eval      wspsn3 = *blanks
003800040827     C                   EVAL      @STEP = 'STEP1'
003900040827    ***
004000040827     C                   ENDSR
004100040827   S***S
004200040827     C     $BUILDSFL     BEGSR
004300040827    ***
004400040827     C                   MOVE      *ZEROS        RRT
004500040827     C                   MOVE      *ZEROS        #CNT
004600040827    ***
004700040827     C                   MOVEA     '011'         *IN(25)
004800040827     C                   WRITE     lstCTL
004900040827     C                   MOVEA     '010'         *IN(25)
005000050623    ***
005100050623     c                   exsr      $bldsql
005200040827    ***
005300040827     C/EXEC SQL
005400040830     c+ Set Option Datfmt = *Iso
005500040830     C/END-EXEC
005600050623    ***
005700050623     C/EXEC SQL
005800050623     c+ prepare sel from :@500
005900050623     C/END-EXEC
006000050623    ***
006100040830     C/EXEC SQL
006200050623     C+ DECLARE GRPCSR SCROLL CURSOR FOR sel
006300040827     C/END-EXEC
006400040827    ***
006500040827     C/EXEC SQL
006600040827     C+ OPEN GRPCSR
006700040827     C/END-EXEC
006800040827    ***
006900040827     c                   exsr      $loadsfl
007000040827    ***
007100040827     C                   IF        RRT > 6
007200040827     C                   EVAL      *IN91 = *ON
007300040827     C                   ENDIF
007400040827    ***
007500040827     c/exec sql
007600040827     c+ close grpcsr
007700040827     c/end-exec
007800040827    ***
007900040827     C                   ENDSR
008000040827   S***S
008100040827     C     $loadsfl      BEGSR
008200040827    ***
008300040827     C                   DOU       sqlcod <> 0 or #cnt >= 5000
008400040827    ***
008500040827     c/EXEC SQL
008600040827     c+ FETCH NEXT FROM GRPCSR
008700050705     c+   INTO :SFSGRP, :SFLNAM, :SFFNAM, :SFSMI
008800040827     C/END-EXEC
008900040827    ***
009000040827     C                   if        sqlcod = 0 and #cnt <= 5000
009100040827    ***
009200040827     C                   MOVE      *ON           *IN25
009300040827     C                   ADD       1             RRT
009400040827     C                   IF        RRT = 1
009500040827     C                   Z-ADD     RRT           SFLPOS
009600040827     C                   ENDIF
009700040827     C                   MOVE      *BLANKS       wsopc
009800040827     C                   WRITE     lstsfl
009900040827     C                   ADD       1             #CNT
010000040827    ***
010100040827     C                   ENDIF
010200040827     C                   ENDDO
010300050623    ***
010400050623     C                   ENDSR
010500050623   S***S
010600050623     C     $bldsql       BEGSR
010700050623    ***
010800050623     c                   move      *blanks       @500            500
010900050623    ***
011000050705     c                   eval      @500 = 'select t2.sgrpcd, t1.slname, t1.sf' +
011100050705     c                             'name, t1.smi from "F.SMANL3" T1, "F.SMAN2' +
011200050705     c                             'L" T2 where T2.sgrpcd = T1.sgrp and T2.gr' +
011300050705     c                             'dmgdft = T1.smancd and'
011400050623    ***
011500050623     c                   select
011600050623     c                   when      *in41 = *on
011700050705     c                   eval      @500 = %trim(@500) + ' t2.sgrpcd >= ' + ap +
011800050705     c                             wspsn1 + ap + ' order by 1, 2, 3'
011900050623     c                   when      *in42 = *on
012000050705     c                   eval      @500 = %trim(@500) + ' t1.slname >= ' + ap +
012100050705     c                             %trim(wspsn2) + ap + ' order by 2, 3, 1'
012200050623     c                   when      *in43 = *on
012300050705     c                   eval      @500 = %trim(@500) + ' t1.sfname >= ' + ap +
012400050705     c                             %trim(wspsn3) + ap + ' order by 3, 2, 1'
012500050623     c                   endsl
012600040827    ***
012700040827     C                   ENDSR
012800040827   S***S
012900040827     C     $STEP1        BEGSR
013000040827    ***
013100040827     C                   WRITE     JUNK
013200040827     C                   EXFMT     lstCTL
013300040827    ***
013400040827     C                   IF        FKEY = F3
013500040827     C                   EVAL      @STEP = 'LEAVE'
013600040827     C                   LEAVESR
013700040827     C                   ENDIF
013800040827    ***
013900050623     C                   IF        FKEY = F10
014000050623     C                   exsr      $inc
014100050623     C                   LEAVESR
014200050623     C                   ENDIF
014300050623    ***
014400050623     c                   if        wspsn1 <> *blanks or wspsn2 <> *blanks or
014500050623     c                             wspsn3 <> *blanks
014600050502     C                   EVAL      @STEP = 'PREP1'
014700050502     C                   LEAVESR
014800050502     C                   ENDIF
014900050502    ***
015000040827     C                   EXSR      $CHKSEL
015100040827    ***
015200040827     C                   ENDSR
015300040827   S***S
015400040827     C     $CHKSEL       BEGSR
015500040827    ***
015600040827     C                   MOVE      *OFF          *IN99
015700040827    ***
015800040827     C                   DOU       *IN99 = *ON
015900040827     C                   READC     lstsfl                                 99
016000040827     C                   IF        *IN99 = *OFF AND wsopc <> *BLANKS
016100040827    ***
016200040827     C                   MOVE      *ON           *IN99
016300050705     C                   MOVEL(P)  SFsgrp        P@sgrp
016400040827     C                   EVAL      @STEP = 'LEAVE'
016500040827    ***
016600040827     C                   ENDIF
016700040827     C                   ENDDO
016800050623    ***
016900050623     C                   ENDSR
017000050623   S***S
017100050623     C     $inc          BEGSR
017200050623    ***
017300050705     c                   add       1             #c
017400050623     c                   if        #c > 43
017500050623     c                   z-add     41            #c
017600050623     c                   endif
017700050623     c                   movea     '000'         *in(41)
017800050623     c                   move      '1'           *IN(#c)
017900050623    ***
018000040827     C                   ENDSR
018100040827   S***S
