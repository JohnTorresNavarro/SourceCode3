000100000000     FAGENCY    IF   E             DISK
000200000000     FBRKACON   IF   E             DISK
000300000000     FSMAN      IF   E             DISK
000400000000     FSMAN2     IF   E             DISK
000500000000     FSUPRAGCY  IF   E             DISK    PREFIX(K:1)
000600000000     FT200      O  A F  200        DISK
000700000000   X***X
000800000000     d p10             s             10a
000900000000     d @z              s             10a
001000000000     d #z              s             10s 0
001100000000     D @A              S              3A
001200000000     D @N              S              7A
001300000000     D #A              S              3S 0
001400000000     D #N              S              7S 0
001500000000     D @10             s             10a
001600000000     d p               s              5U 0
001700000000     d @o              s            200a
001800000000   X***X
001900000000     C     *ENTRY        PList
002000000000     C                   Parm                    P10
002100000000    ***
002200000000     C                   Eval      @A = %SUBST(P10:1:3)
002300000000     C                   Eval      @N = %SUBST(P10:4:7)
002400000000     C                   Move      p10           @z
002500000000     C                   Move      @z            #z
002600000000     c                   Move      @a            #a
002700000000     c                   Move      @n            #n
002800000000    ***
002900000000     c                   Eval      @o = '"Search For Phone Number: ' + @z + '"'
003000000000     c                   Except    outf
003100000000     c                   Eval      @o = ','
003200000000     c                   Except    outf
003300000000     c                   Eval      @o = '"Results . . . . . .",'
003400000000     c                   Except    outf
003500000000    ***
003600000000     C                   ExSR      $agency
003700000000     C                   ExSR      $brkacon
003800000000     C                   ExSR      $sman
003900000000     C                   ExSR      $sman2
004000000000     C                   ExSR      $supragcy
004100000000    ***
004200000000     C                   Eval      *InLR = *On
004300000000   S***S
004400000000     C     $agency       BegSR
004500000000    ***
004600000000     C                   DoU       %EOF(AGENCY)
004700000000     C                   Read      AGENR
004800000000     C                   If        NOT %EOF(AGENCY)
004900000000    ***
005000000000     C                   If        #A = AGTLX3 AND #N = AGTLX7
005100000000     C                   Eval      @o = '"Match For Agency Phone: ' +
005200000000     C                             %Trim(agcode) + '-' + %Trim(agnam1) +
005300000000     c                             '","Phone: ' + %EditC(agtlx3:'X') +
005400000000     c                             %EditC(agtlx7:'X') + '"'
005500000000     C                   Except    OUTF
005600000000     C                   Else
005700000000     C                   If        #A <> AGTLX3 AND #N = AGTLX7
005800000000     C                   Eval      @o = '"Partial Match For Agency Phone: ' +
005900000000     C                             %Trim(agcode) + '-' + %Trim(agnam1) +
006000000000     c                             '","Phone: ' + %EditC(agtlx3:'X') +
006100000000     c                             %EditC(agtlx7:'X') + '"'
006200000000     C                   Except    OUTF
006300000000     C                   EndIf
006400000000     C                   EndIf
006500000000    * *
006600000000     C                   If        #A = AGFAX3 AND #N = AGFAX7
006700000000     C                   Eval      @o = '"Match For Agency Fax: ' +
006800000000     C                             %Trim(agcode) + '-' + %Trim(agnam1) +
006900000000     c                             '","Fax: ' + %EditC(agfax3:'X') +
007000000000     c                             %EditC(agfax7:'X') + '"'
007100000000     C                   Except    OUTF
007200000000     C                   Else
007300000000     C                   If        #A <> AGFAX3 AND #N = AGFAX7
007400000000     C                   Eval      @o = '"Partial Match For Agency Fax: ' +
007500000000     C                             %Trim(agcode) + '-' + %Trim(agnam1) +
007600000000     c                             '","Fax: ' + %EditC(agfax3:'X') +
007700000000     c                             %EditC(agfax7:'X') + '"'
007800000000     C                   Except    OUTF
007900000000     C                   EndIf
008000000000     C                   EndIf
008100000000    ***
008200000000     C                   EndIf
008300000000     C                   EndDo
008400000000    ***
008500000000     C                   EndSR
008600000000   S***S
008700000000     C     $brkacon      BegSR
008800000000    ***
008900000000     C                   DoU       %EOF(brkacon)
009000000000     C                   Read      braconr
009100000000     C                   If        NOT %EOF(brkacon)
009200000000    * *
009300000000     C                   If        #z = braphn
009400000000     C                   Eval      @o = '"Match For Broker Alt Con Phone: Gro' +
009500000000     C                             'uper: ' + bragrp + '; Alt ID#: ' +
009600000000     c                             %EditC(braid:'X') + '; Name: ' +
009700000000     c                             %Trim(brafnm) + ' ' + %Trim(bralnm) + '","' +
009800000000     c                             'Phone: ' + %EditC(braphn:'X') + '"'
009900000000     C                   Except    OUTF
010000000000     C                   Else
010100000000     c                   Move      braphn        @10
010200000000     c                   Eval      p = %Scan(@n:@10:1)
010300000000     C                   If        p <> 0
010400000000     C                   Eval      @o = '"Partial Match For Broker Alt Con Ph' +
010500000000     C                             'one: Grouper: ' + bragrp + '; Alt ID#: ' +
010600000000     c                             %EditC(braid:'X') + '; Name: ' +
010700000000     c                             %Trim(brafnm) + ' ' + %Trim(bralnm) + '","' +
010800000000     c                             'Phone: ' + %EditC(braphn:'X') + '"'
010900000000     C                   Except    OUTF
011000000000     C                   EndIf
011100000000     C                   EndIf
011200000000    * *
011300000000     C                   If        #z = brafax
011400000000     C                   Eval      @o = '"Match For Broker Alt Con Fax: Gro' +
011500000000     C                             'uper: ' + bragrp + '; Alt ID#: ' +
011600000000     c                             %EditC(braid:'X') + '; Name: ' +
011700000000     c                             %Trim(brafnm) + ' ' + %Trim(bralnm) + '","' +
011800000000     c                             'Fax: ' + %EditC(brafax:'X') + '"'
011900000000     C                   Except    OUTF
012000000000     C                   Else
012100000000     c                   Move      brafax        @10
012200000000     c                   Eval      p = %Scan(@n:@10:1)
012300000000     C                   If        p <> 0
012400000000     C                   Eval      @o = '"Partial Match For Broker Alt Con Fa' +
012500000000     C                             'x: Grouper: ' + bragrp + '; Alt ID#: ' +
012600000000     c                             %EditC(braid:'X') + '; Name: ' +
012700000000     c                             %Trim(brafnm) + ' ' + %Trim(bralnm) + '","' +
012800000000     c                             'Fax: ' + %EditC(brafax:'X') + '"'
012900000000     C                   Except    OUTF
013000000000     C                   EndIf
013100000000     C                   EndIf
013200000000    * *
013300000000     C                   EndIf
013400000000     C                   EndDo
013500000000    ***
013600000000     C                   EndSR
013700000000   S***S
013800000000     C     $sman         BegSR
013900000000    ***
014000000000     C                   DoU       %EOF(sman)
014100000000     C                   Read      smanr
014200000000     C                   If        NOT %EOF(sman)
014300000000    * *
014400000000     C                   If        #A = sarea AND #N = sphone
014500000000     C                   Eval      @o = '"Match For Salesman: ' +
014600000000     C                             smancd + '-' + %Trim(sfname) + ' ' +
014700000000     c                             %Trim(slname) + '","Phone: ' +
014800000000     c                             %EditC(sarea:'X') +
014900000000     c                             %EditC(sphone:'X') + '"'
015000000000     C                   Except    OUTF
015100000000     C                   Else
015200000000     C                   If        #A <> sarea AND #N = sphone
015300000000     C                   Eval      @o = '"Partial Match For Salesman: ' +
015400000000     C                             smancd + '-' + %Trim(sfname) + ' ' +
015500000000     c                             %Trim(slname) + '","Phone: ' +
015600000000     c                             %EditC(sarea:'X') +
015700000000     c                             %EditC(sphone:'X') + '"'
015800000000     C                   Except    OUTF
015900000000     C                   EndIf
016000000000     C                   EndIf
016100000000    * *
016200000000     C                   EndIf
016300000000     C                   EndDo
016400000000    ***
016500000000     C                   EndSR
016600000000   S***S
016700000000     C     $sman2        BegSR
016800000000    ***
016900000000     C                   DoU       %EOF(sman2)
017000000000     C                   Read      sman2r
017100000000     C                   If        NOT %EOF(sman2)
017200000000    * *
017300000000     C                   If        #z = sbradph
017400000000     C                   Eval      @o = '"Match For Sman2 Additional Phone: G' +
017500000000     C                             'rouper: ' + sgrpcd + '","Phone: ' +
017600000000     C                             %EditC(sbradph:'X') + '"'
017700000000     C                   Except    OUTF
017800000000     C                   Else
017900000000     c                   Move      sbradph       @10
018000000000     c                   Eval      p = %Scan(@n:@10:1)
018100000000     C                   If        p <> 0
018200000000     C                   Eval      @o = '"Partial Match For Sman2 Additional ' +
018300000000     C                             'Phone: Grouper: ' + sgrpcd + '","Phone: ' +
018400000000     C                             %EditC(sbradph:'X') + '"'
018500000000     C                   Except    OUTF
018600000000     C                   EndIf
018700000000     C                   EndIf
018800000000    * *
018900000000     C                   If        #z = sbrfax
019000000000     C                   Eval      @o = '"Match For Sman2 Additional Fax: G' +
019100000000     C                             'rouper: ' + sgrpcd + '","Fax: ' +
019200000000     C                             %EditC(sbrfax:'X') + '"'
019300000000     C                   Except    OUTF
019400000000     C                   Else
019500000000     c                   Move      sbrfax        @10
019600000000     c                   Eval      p = %Scan(@n:@10:1)
019700000000     C                   If        p <> 0
019800000000     C                   Eval      @o = '"Partial Match For Sman2 Additional ' +
019900000000     C                             'Fax: Grouper: ' + sgrpcd + '","Fax: ' +
020000000000     C                             %EditC(sbrfax:'X') + '"'
020100000000     C                   Except    OUTF
020200000000     C                   EndIf
020300000000     C                   EndIf
020400000000    * *
020500000000     C                   If        #z = sasphn
020600000000     C                   Eval      @o = '"Match For Sman2 Assistant Phone: G' +
020700000000     C                             'rouper: ' + sgrpcd + '","Phone: ' +
020800000000     C                             %EditC(sasphn:'X') + '"'
020900000000     C                   Except    OUTF
021000000000     C                   Else
021100000000     c                   Move      sasphn        @10
021200000000     c                   Eval      p = %Scan(@n:@10:1)
021300000000     C                   If        p <> 0
021400000000     C                   Eval      @o = '"Partial Match For Sman2 Assistant ' +
021500000000     C                             'Phone: Grouper: ' + sgrpcd + '","Phone: ' +
021600000000     C                             %EditC(sasphn:'X') + '"'
021700000000     C                   Except    OUTF
021800000000     C                   EndIf
021900000000     C                   EndIf
022000000000    * *
022100000000     C                   If        #z = sasfax
022200000000     C                   Eval      @o = '"Match For Sman2 Assistant Fax: G' +
022300000000     C                             'rouper: ' + sgrpcd + '","Fax: ' +
022400000000     C                             %EditC(sasfax:'X') + '"'
022500000000     C                   Except    OUTF
022600000000     C                   Else
022700000000     c                   Move      sasfax        @10
022800000000     c                   Eval      p = %Scan(@n:@10:1)
022900000000     C                   If        p <> 0
023000000000     C                   Eval      @o = '"Partial Match For Sman2 Assistant ' +
023100000000     C                             'Fax: Grouper: ' + sgrpcd + '","Fax: ' +
023200000000     C                             %EditC(sasfax:'X') + '"'
023300000000     C                   Except    OUTF
023400000000     C                   EndIf
023500000000     C                   EndIf
023600000000    * *
023700000000     C                   EndIf
023800000000     C                   EndDo
023900000000    ***
024000000000     C                   EndSR
024100000000   S***S
024200000000     C     $supragcy     BegSR
024300000000    ***
024400000000     C                   DoU       %EOF(supragcy)
024500000000     C                   Read      saf
024600000000     C                   If        NOT %EOF(supragcy)
024700000000    ***
024800000000     C                   If        @z = Kaphone
024900000000     C                   Eval      @o = '"Match For Super Agency Phone: ' +
025000000000     c                             Kacode + '-' + %Trim(Kaname1) + '","Phone:' +
025100000000     C                             ' ' + %Trim(Kaphone) + '"'
025200000000     C                   Except    OUTF
025300000000     C                   Else
025400000000     c                   Eval      p = %Scan(@n:Kaphone:1)
025500000000     C                   If        p <> 0
025600000000     C                   Eval      @o = '"Partial Match For Super Agency Phon' +
025700000000     c                             'e: ' + Kacode + '-' + %Trim(Kaname1) +
025800000000     C                             '","Phone: ' + %Trim(Kaphone) + '"'
025900000000     C                   Except    OUTF
026000000000     C                   EndIf
026100000000     C                   EndIf
026200000000    * *
026300000000     C                   If        @z = Kafax
026400000000     C                   Eval      @o = '"Match For Super Agency Fax: ' +
026500000000     c                             Kacode + '-' + %Trim(Kaname1) + '","Fax:' +
026600000000     C                             ' ' + %Trim(Kafax) + '"'
026700000000     C                   Except    OUTF
026800000000     C                   Else
026900000000     c                   Eval      p = %Scan(@n:Kafax:1)
027000000000     C                   If        p <> 0
027100000000     C                   Eval      @o = '"Partial Match For Super Agency Fax' +
027200000000     c                             ': ' + Kacode + '-' + %Trim(Kaname1) +
027300000000     C                             '","Fax: ' + %Trim(Kafax) + '"'
027400000000     C                   Except    OUTF
027500000000     C                   EndIf
027600000000     C                   EndIf
027700000000    ***
027800000000     C                   EndIf
027900000000     C                   EndDo
028000000000    ***
028100000000     C                   EndSR
028200000000   S***S
028300000000     oT200      EADD         outf
028400000000     o                       @o                 200
