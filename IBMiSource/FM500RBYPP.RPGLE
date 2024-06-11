000100131007   X***X
000200131007   X***X 11/26/08 dlk - add new commission history file
000300131007   X***X FIXED SRLHIST DATA
000400131007   X***X
000500131007   X***X 07/15/2011 SSK ADD HISTORIC BEFORE AND AFTER IMAGES
000600131007   X***X
000700131007   X**** 08/28/2013 SSK ADD AC2MST BROKER LOGIC
000800131007   X****   FIELD IS A2CODE1 AND IS THE RENEWAL BROKER
000900131007   X***X
001000131007   X***X 10/04/2013 SSK HIST EXPANSION PROJECT
001100131007   X***X
001200131007   X***X
001300131007   X***X
001400131007   X***X
001500060918     FFM500D    CF   E             WORKSTN INFDS(WSDS)
001600061005     fsmanrlt   Uf   e           k disk
001700070416     faccmst5   if   e           k disk    RENAME(accmsr:lf5) prefix(q)
001800070312     faccmst    uf   e           k disk
001900130828     FAC2MSTL2  UF   E           K DISK
002000060915     faccmstp   if   e           k disk
002100070416     fcmct14    if   e           k disk    rename(comcxr:cm14) prefix(c)
002200060915     fcmctlf    uf a e           k disk
002300060915     fbrkprdl   uf a e           k disk
002400061024     FSRLHIST0  O  A E           K DISK
002500060915     FHIST      O  A E             DISK
002600070413     FSYSMODLOG O  A E             DISK
002700070416     FCMIABLKTR O  A E             DISK
002800070416     FINTGBSLOG O  A E             DISK
002900081126     Fcomhst    O  A E             DISK
003000060915     ft2000     o  a f 2000        disk
003100070223     ft2000A    o  a f 2000        disk
003200060915   X***X
003300081126     D comhiscode      S              1A
003400060918     D WSDS            DS
003500060918     D  FKEY                 369    369A
003600060918    ***       FUNCTION KEYS
003700060918     D  F1             C                   CONST(X'31')
003800060918     D  F2             C                   CONST(X'32')
003900060918     D  F3             C                   CONST(X'33')
004000060918     D  F4             C                   CONST(X'34')
004100060918     D  F5             C                   CONST(X'35')
004200060918     D  F6             C                   CONST(X'36')
004300060918     D  F7             C                   CONST(X'37')
004400060918     D  F8             C                   CONST(X'38')
004500060918     D  F9             C                   CONST(X'39')
004600060918     D  F10            C                   CONST(X'3A')
004700060918     D  F11            C                   CONST(X'3B')
004800060918     D  F12            C                   CONST(X'3C')
004900060918     D  F13            C                   CONST(X'B1')
005000060918     D  F14            C                   CONST(X'B2')
005100060918     D  F15            C                   CONST(X'B3')
005200060918     D  F16            C                   CONST(X'B4')
005300060918     D  F17            C                   CONST(X'B5')
005400060918     D  F18            C                   CONST(X'B6')
005500060918     D  F19            C                   CONST(X'B7')
005600060918     D  F20            C                   CONST(X'B8')
005700060918     D  F21            C                   CONST(X'B9')
005800060918     D  F22            C                   CONST(X'BA')
005900060918     D  F23            C                   CONST(X'BB')
006000060918     D  F24            C                   CONST(X'BC')
006100060918    ***
006200060915     d                 ds
006300060918     d prm@in                  1     24a
006400060915     d pi@frel                 1      8a
006500060915     d pi@trel                 9     16a
006600060918     d pi#dte                 17     24s 0
006700131007    ***
0068001310070037 D sysdateymd      S               d   datfmt(*iso)
006900131007     D thispgmname     S             10a   inz('FM500     ')
007000060915    ***
007100060915     d @range          s             30a
007200070416     d log@          e ds                  extname(sysmodlog) prefix(vv:2)
007300070416     d sys@          e ds                  extname(sysmodlog)
007400070416     d cmia@         e ds                  extname(cmiablktR)
007500070416     d igbs@         e ds                  extname(intgbslog)
007600060915     d brp@          e ds                  extname(brkprdp)
007700060915     d hld@brp       e ds                  extname(brkprdp) prefix(z:1)
007800060915     d pi#iso          s               d   datfmt(*ISO)
007900080813     d #H              s               d   datfmt(*ISO)
008000080813     d #L              s               d   datfmt(*ISO)
008100130828     D SVB@CHG         S              1A
008200060915     d trm8s0          s              8s 0
008300060918     d #today          s              8s 0
008400060919     d #usa            s               d   datfmt(*USA)
008500060918     d #iso            s               d   datfmt(*ISO)
008600060915     d pi#trm          s               d   datfmt(*ISO)
008700060919     d @v              s              1a
008800070430     d @step           s              5a
008900060919     d hfrm            s              8a
009000060919     d hto             s              8a
009100060919     d hpdate          s              8s 0
009200080813     d warn#dte        s              8s 0
009300060915     d @o              s           2000a
009400070223     d @oA             s           2000a
009500070417     d pmsg            s           2000a
009600060915     d cmx@          e ds                  extname(comctx)
009700060915     d hld@cmx       e ds                  extname(comctx) prefix(y:1)
009800061024     D REC@DS        E DS                  EXTNAME(SMANRLT)
009900060915    ***
010000130828     D f@SMAN          S              3a
010100130828     D f@SNAME         S             50a
010200130828     D f@AGCY          S              3a
010300130828     D f@ANAME         S             50a
010400130828     D f@SUPER         S              3A
010500130828     D f@UNAME         S             50A
010600060915    ***
010700130828     D t@SMAN          S              3a
010800130828     D t@SNAME         S             50a
010900130828     D t@AGCY          S              3a
011000130828     D t@ANAME         S             50a
011100130828     D t@SUPER         S              3A
011200130828     D t@UNAME         S             50A
011300060915    ***
011400060915     D                 DS
011500060915     D PRMS                    1    142A
011600060915     D P@SMAN                  1      3A
011700060915     D P@SNAME                 4     36A
011800060915     D P@AGCY                 37     39A
011900060915     D P@ANAME                40     79A
012000060915     D P@SUPER                80     82A
012100060915     D P@UNAME                83    132A
012200060915     D P@RELID               133    140A
012300060915     D P@RESULT              141    141A
012400060915     D P@REQUEST             142    142A
012500060915    ***     call gar900
012600060915     D @@@PARMS        S            142A
012700061024    ***
012800130828     D DS@B4         E DS                  EXTNAME(BRKPRDP) PREFIX(B4:2)
012900130828     D  B4@IMG                 1    125A
013000130828      *
013100130828     D DS@AF         E DS                  EXTNAME(BRKPRDP) PREFIX(AF:2)
013200130828     D  AF@IMG                 1    125A
013300130828      *
013400130828     D @291            S            291A
013500130828     ***
013600061024     D @TS40           S             40A
013700061024     D @TIMESTAMP      DS
013800131007     D  P@40                   1     40A
013900061024     D  #TSCYMD                1      8S 0
014000061024     D  #TSTIME                9     14S 0
014100061024     D  @TSJOB                15     24
014200061024     D  @TSUSER               25     34
014300061024     D  #TSNBR                35     40S 0
014400060915   X***X
014500060919     c                   Eval      @v = 'A'
014600070430     c                   Eval      @step = 'BEGIN'
014700060918     C                   EXSR      $SCREEN
014800060918    ***
014900070430     c                   DoW       @step <> 'LEAVE'
015000070430     c     @step         CasEq     'STEP1'       $step1
015100070430     c     @step         CasEq     'STEP2'       $step2
015200070430     c     @step         CasEq     'STEP3'       $step3
015300070430     c     @step         CasEq     'PREP4'       $prep4
015400070430     c     @step         CasEq     'STEP4'       $step4
015500070430     c     @step         CasEq     'STEP5'       $step5
015600070430     c     @step         CasEq     'STEP6'       $step6
015700060918     c                   EndCs
015800060915     c                   EndDo
015900060915     c                   Eval      *InLR = *On
016000060918   S***S
016100060918     C     $screen       BegSR
016200070416    ***
016300070416     c                   Eval      al1 = 'ALL'
016400060918    ***
016500070430     c                   DoU       fkey = F3 or @step <> 'BEGIN'
016600060918    * *
016700060918     c                   ExFmt     io01
016800060918    * *
016900060920     c                   If        fkey = F3
017000070430     c                   Eval      @step = 'LEAVE'
017100060920     c                   LEAVESR
017200060918     c                   EndIf
017300060919    * *
017400060919     c                   If        hfrm <> frmrel or hto <> torel or
017500060919     c                             procdate <> hpdate
017600060919     c                   Eval      @v = 'A'
017700060919     c                   EndIf
017800060918    * *
017900060919     c                   If        @v = 'G'
018000070430     c                   Eval      @step = 'STEP1'
018100060919     c                   LeaveSR
018200060919     c                   EndIf
018300060919    * *
018400060919     c                   ExSR      $procscr
018500060918    * *
018600060918     c                   EndDo
018700060919    ***
018800060919     C                   EndSR
018900060919   S***S
019000060919     c     $procscr      BegSR
019100060919    ***
019200060919     c                   Eval      hfrm = frmrel
019300060919     c                   Eval      hto = torel
019400060919     c                   Eval      hpdate = procdate
019500070416    ***
019600070802     C                   EVAL      SCLOG = 'S'
019700070416     c                   If        sclog = *blanks Or (sclog <> 'S' And
019800070416     c                             sclog <> 'C' And sclog <> 'I')
019900070416     c                   Eval      emsg = 'Invalid log value.'
020000070416     c                   LeaveSR
020100070416     c                   EndIf
020200060919    ***
020300060919     c                   If        frmrel = *blanks
020400060919     c                   Eval      emsg = 'From Relationship is invalid.'
020500060919     c                   LeaveSR
020600060919     c                   EndIf
020700060919    ***
020800061005     c     frmrel        Chain(n)  srf
020900060919     c                   If        Not %Found(smanrlt)
021000060919     c                   Eval      emsg = 'From Relationship is invalid.'
021100060919     c                   LeaveSR
021200060919     c                   EndIf
021300060919    ***
021400060919     c                   Eval      pi@frel = frmrel
021500060919    ***
021600060919     C                   Move      *BLANKS       PRMS
021700060919     C                   Eval      P@RELID = frmrel
021800060919     C                   Eval      P@REQUEST = 'R'
021900060919     C                   Eval      @@@PARMS = PRMS
022000060919     C                   Call      'GAC900'
022100060919     C                   Parm                    @@@PARMS
022200060919    * *
022300060919     C                   MoveL     @@@PARMS      PRMS
022400060919    * *
022500060919     C                   If        P@RESULT = 'P'
022600060919     C                   Eval      frSMAN  = P@SMAN
022700060919     C                   MoveL(p)  P@SNAME       frSMANd
022800060919     C                   Eval      frAGCY  = P@AGCY
022900060919     C                   MoveL(p)  P@ANAME       frAGCYd
023000060919     C                   Eval      frSUPER = P@SUPER
023100060919     C                   MoveL(p)  P@UNAME       frSUPERd
023200060919     C                   Else
023300060919     C                   MoveL(p)  '*ERROR*'     frSMAN
023400060919     C                   MoveL(p)  '*ERROR*'     frAGCY
023500060919     C                   MoveL(p)  '*ERROR*'     frSUPER
023600060919     C                   MoveL(p)  '*ERROR*'     frSMANd
023700060919     C                   MoveL(p)  '*ERROR*'     frAGCYd
023800060919     C                   MoveL(p)  '*ERROR*'     frSUPERd
023900080813     c                   Eval      emsg = 'Error in retrieval, call 3305'
024000080813     c                   LeaveSR
024100060919     c                   EndIf
024200060919    ***
024300060919     c                   If        torel = *blanks
024400060919     c                   Eval      emsg = 'To Relationship is invalid.'
024500060919     c                   LeaveSR
024600060919     c                   EndIf
024700060919    ***
024800061005     c     torel         Chain(n)  srf
024900060919     c                   If        Not %Found(smanrlt)
025000060919     c                   Eval      emsg = 'To Relationship is invalid.'
025100060919     c                   LeaveSR
025200060919     c                   EndIf
025300060919    ***
025400060919     c                   Eval      pi@trel = torel
025500060919    ***
025600060919     C                   Move      *BLANKS       PRMS
025700060919     C                   Eval      P@RELID = torel
025800060919     C                   Eval      P@REQUEST = 'R'
025900060919     C                   Eval      @@@PARMS = PRMS
026000060919     C                   Call      'GAC900'
026100060919     C                   Parm                    @@@PARMS
026200060919    * *
026300060919     C                   MoveL     @@@PARMS      PRMS
026400060919    * *
026500060919     C                   If        P@RESULT = 'P'
026600060919     C                   Eval      trSMAN  = P@SMAN
026700060919     C                   MoveL(p)  P@SNAME       trSMANd
026800060919     C                   Eval      trAGCY  = P@AGCY
026900060919     C                   MoveL(p)  P@ANAME       trAGCYd
027000060919     C                   Eval      trSUPER = P@SUPER
027100060919     C                   MoveL(p)  P@UNAME       trSUPERd
027200060919     C                   Else
027300060919     C                   MoveL(p)  '*ERROR*'     trSMAN
027400060919     C                   MoveL(p)  '*ERROR*'     trAGCY
027500060919     C                   MoveL(p)  '*ERROR*'     trSUPER
027600060919     C                   MoveL(p)  '*ERROR*'     trSMANd
027700060919     C                   MoveL(p)  '*ERROR*'     trAGCYd
027800060919     C                   MoveL(p)  '*ERROR*'     trSUPERd
027900080813     c                   Eval      emsg = 'Error in retrieval, call 3305'
028000080813     c                   LeaveSR
028100060919     c                   EndIf
028200060919    ***
028300060919     c                   If        procdate = 0
028400060919     c                   Eval      emsg = 'Process Date is invalid.'
028500060919     c                   LeaveSR
028600060919     c                   EndIf
028700060919    ***
028800060919     c     *USA          test(de)                procdate
028900060919     c                   If        %Error
029000060919     c                   Eval      emsg = 'Process Date is invalid.'
029100060919     c                   LeaveSR
029200060919     c                   EndIf
029300060919    ***
029400060919     c                   Move      procdate      #usa
029500060919     c                   Move      #usa          #iso
029600060919     c                   Move      #iso          pi#dte
029700060919     c                   Move      pi#dte        pi#iso
029800060919     c                   Move      pi#dte        pi#trm
029900060919     c                   SubDur    1:*D          pi#trm
030000060919     c                   Move      pi#trm        trm8s0
030100080813    ***
030200080813     C                   EVAL      #H = %DATE
030300080813     C                   EVAL      #L = %DATE
030400080813     C                   ADDDUR    90:*D         #H
030500080813     C                   SUBDUR    90:*D         #L
030600080813     C                   If        PI#ISO < #L Or PI#ISO > #H
030700080813     c                   If        pi#dte <> warn#dte
030800080813     c                   Eval      warn#dte = pi#dte
030900080813     c                   Eval      emsg = 'Date outside of 90 days, press ' +
031000080813     c                             ' enter to accept'
031100080813     c                   LeaveSR
031200080813     c                   EndIf
031300080813     c                   EndIf
031400060919    ***
031500130828     C                   IF        FRAGCY <> TRAGCY
031600130828     C                   EVAL      SVB@CHG = 'Y'
031700130828     C                   ELSE
031800130828     C                   EVAL      SVB@CHG = 'N'
031900130828     C                   ENDIF
032000130828    ***
032100060919     c                   Eval      emsg = 'Press Enter to Run'
032200060919     c                   Eval      @v = 'G'
032300060918    ***
032400060918     C                   EndSR
032500060915   S***S
032600060915     c     $step1        BegSR
032700070416    ***
032800070416     c                   Clear                   log@
032900070802     c                   Eval      sclog = 'S'
033000070802     c                   Eval      al1 = *blanks
033100070802     c                   Eval      al2 = *blanks
033200070416     c                   Move      #today        vvmodte
033300070416     c                   Move      pi#dte        vveffdte
033400070416     c                   Eval      vvpvrelid = frmrel
033500070417     c                   Eval      vvpvsname = %Trim(frsmand)
033600070416     c                   Eval      vvpvsman = frsman
033700070416     c                   Eval      vvpvagcy = fragcy
033800070416     c                   Eval      vvpvsuper = frsuper
033900070416     c                   Eval      vvnwrelid = torel
034000070416     c                   Eval      vvnwsman = trsman
034100070417     c                   Eval      vvnwsname = %Trim(trsmand)
034200070416     c                   Eval      vvnwagcy = tragcy
034300070416     c                   Eval      vvnwsuper = trsuper
034400070416     c                   Eval      vvaal = %Trim(al1) + %Trim(al2)
034500070416    ***
034600070416     c                   Select
034700070416     c                   When      sclog = 'S'
034800070416     c                   Eval      sys@ = log@
034900070416     c                   Write     smlf
035000070416     c                   When      sclog = 'C'
035100070416     c                   Eval      cmia@ = log@
035200070416     c                   Write     cmiaf
035300070416     c                   When      sclog = 'I'
035400070416     c                   Eval      igbs@ = log@
035500070416     c                   Write     igbsf
035600070416     c                   Endsl
035700060915    ***
035800060919     c                   Eval      f@SMAN  = frSMAN
035900060919     c                   Eval      f@SNAME = frsmand
036000060919     c                   Eval      f@AGCY  = fragcy
036100060919     c                   Eval      f@ANAME = fragcyd
036200060919     c                   Eval      f@SUPER = frSUPER
036300060919     c                   Eval      f@UNAME = frsuperd
036400060915    ***
036500060919     c                   Eval      t@SMAN  = trSMAN
036600060919     c                   Eval      t@SNAME = trsmand
036700060919     c                   Eval      t@AGCY  = tragcy
036800060919     c                   Eval      t@ANAME = tragcyd
036900060919     c                   Eval      t@SUPER = trSUPER
037000060919     c                   Eval      t@UNAME = trsuperd
037100060915    ***
037200060915     c                   Eval      @o = '"Relationship ID Move With Cancel"'
037300060915     c                   Except    outf
037400060915    ***
037500060915     c                   Eval      @o = ','
037600060915     c                   Except    outf
037700060915    ***
037800060919     c                   Eval      @o = '"From Relationship ID: ' + frmrel     +
037900060919     c                             '; Sman: ' + %Trim(frsman) + '-'            +
038000060919     c                             %Trim(frsmand) + '; Agency: ' + fragcy      +
038100060919     c                             '-' + %Trim(fragcyd) + '; Super Agency: '   +
038200060919     c                             frsuper + '-' + %Trim(frsuperd) + '",'
038300060915     c                   Except    outf
038400060915    ***
038500060915     c                   Eval      @o = ','
038600060915     c                   Except    outf
038700060915    ***
038800060919     c                   Eval      @o = '"To Relationship ID: ' + torel        +
038900060919     c                             '; Sman: ' + %Trim(trsman) + '-'            +
039000060919     c                             %Trim(trsmand) + '; Agency: ' + tragcy      +
039100060919     c                             '-' + %Trim(tragcyd) + '; Super Agency: '   +
039200060920     c                             trsuper + '-' + %Trim(trsuperd) + '",'
039300060915     c                   Except    outf
039400060915    ***
039500060915     c                   Eval      @o = ','
039600060915     c                   Except    outf
039700060915    ***
039800070419     c                   Eval      @o = '"Account Number[W/Plan]","Account Na' +
039900070419     c                             'me","Previous Date Range"'
040000060915     c                   Except    outf
040100060915    ***
040200070223     c                   Eval      @oA = '"Relationship ID Move Exceptions"'
040300070223     c                   Except    outfa
040400070223    ***
040500070223     c                   Eval      @oA = ','
040600070223     c                   Except    outfa
040700070223    ***
040800070223     c                   Eval      @oA = '"From Relationship ID: ' + frmrel    +
040900070223     c                             '; Sman: ' + %Trim(frsman) + '-'            +
041000070223     c                             %Trim(frsmand) + '; Agency: ' + fragcy      +
041100070223     c                             '-' + %Trim(fragcyd) + '; Super Agency: '   +
041200070223     c                             frsuper + '-' + %Trim(frsuperd) + '",'
041300070223     c                   Except    outfa
041400070223    ***
041500070223     c                   Eval      @oA = ','
041600070223     c                   Except    outfa
041700070223    ***
041800070223     c                   Eval      @oA = '"To Relationship ID: ' + torel       +
041900070223     c                             '; Sman: ' + %Trim(trsman) + '-'            +
042000070223     c                             %Trim(trsmand) + '; Agency: ' + tragcy      +
042100070223     c                             '-' + %Trim(tragcyd) + '; Super Agency: '   +
042200070223     c                             trsuper + '-' + %Trim(trsuperd) + '",'
042300070223     c                   Except    outfa
042400070223    ***
042500070223     c                   Eval      @oA = ','
042600070223     c                   Except    outfa
042700070223    ***
042800070223     c                   Eval      @oA = '"Account Number","Account Name","Pr' +
042900070223     c                             'evious Date Range"'
043000070223     c                   Except    outfa
043100070223    ***
043200070430     c                   Eval      @step = 'STEP2'
043300060915    ***
043400060915     c                   EndSR
043500060915   S***S
043600060915     c     $step2        BegSR
043700060915    ***
043800060915     c     pi@frel       Chain(n)  brkprdr
043900060915     c                   If        Not %Found(brkprdl)
044000060915     c                   Eval      @o = '"No Non-administered Business",'
044100060915     c                   Except    outf
044200070430     c                   Eval      @step = 'STEP4'
044300060915     c                   LeaveSR
044400060915     c                   EndIf
044500060915    ***
044600060915     c     pi@frel       SetLL     brkprdr
044700060915    ***
044800060915     c                   Move      *Zeros        #cnt              9 0
044900100917     c                   Eval      @step = 'PREP4'
045000060915    ***
045100060915     c                   EndSR
045200060915   S***S
045300060915     c     $step3        BegSR
045400060915    ***
045500100916    *c     pi@frel       ReadE     brkprdr
045600100916    ***
045700100916    *c                   If        %EOF(brkprdl)
045800100916    *c                   Eval      @step = 'PREP4'
045900100916    *c                   LeaveSR
046000100916    *c                   EndIf
046100100916    ***
046200100916    *c                   If        bpefdt = bptrdt
046300100916    *c                   LeaveSR
046400100916    *c                   EndIf
046500100916    ***
046600100916    *c     bpacct        Chain     accmstr
046700100916    ***
046800100916    *c                   If        bptrdt <> D'9999-12-31'
046900100916    ***
047000100916    *c                   If        bptrdt > pi#iso and bpefdt < pi#iso
047100100916    *c                   If        adimd = 'Y'
047200100916    *c                   Eval      @o = '"Have Pam manually fix this record f'
047300100916    *c                             + 'or account:' + %Trim(adname) + '",'
047400100916    *c                   Else
047500100916    *c                   Eval      @o = '"Have Ev manually fix this record f'
047600100916    *c                             + 'or account:' + %Trim(adname) + '",'
047700100916    *c                   EndIf
047800100916    *c                   Except    outf
047900100916    *c                   EndIf
048000100916    ***
048100100916    *c                   LeaveSR
048200100916    *c                   EndIf
048300100916    ***
048400100916    *c                   Add       1             #cnt
048500100916    *c                   Eval      hld@brp = brp@
048600130828     C                   EVAL      DS@B4 = BRP@
048700130828     C                   CALL      'TIMESTMP'
048800130828     C                   PARM                    @TS40
048900130828     C                   EVAL      P@40 = @TS40
049000100916    ***
049100100916    *c                   If        bpefdt >= pi#iso or bpefdt = D'0001-01-01'
049200100916    ***
049300100916    *c                   Eval      bptrdt = bpefdt
049400130828     C                   EVAL      DS@AF = BRP@
049500100916    *c                   Update    brkprdr
049600130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
049700130828     C                   CALL      'GAC592'
049800130828     C                   PARM                    @291
049900100916    *c                   Eval      brp@ = hld@brp
050000100916    *c                   Eval      bprelid = pi@trel
050100100916    *c                   Eval      bpsman = t@sman
050200100916    *c                   Eval      bpagcy = t@agcy
050300100916    *c                   Eval      bpsuper = t@super
050400100916    *c                   Write     brkprdr
050500130828     C                   CLEAR                   DS@B4
050600130828     C                   EVAL      DS@AF = BRP@
050700130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
050800130828     C                   CALL      'GAC592'
050900130828     C                   PARM                    @291
051000100916    ***
051100100916    *c                   Else
051200100916    ***
051300100916    *c                   Eval      bptrdt = pi#trm
051400130828     C                   EVAL      DS@AF = BRP@
051500100916    *c                   Update    brkprdr
051600130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
051700130828     C                   CALL      'GAC592'
051800130828     C                   PARM                    @291
051900100916    *c                   Eval      brp@ = hld@brp
052000100916    *c                   Eval      bprelid = pi@trel
052100100916    *c                   Eval      bpsman = t@sman
052200100916    *c                   Eval      bpagcy = t@agcy
052300100916    *c                   Eval      bpsuper = t@super
052400100916    *c                   Eval      bpefdt = pi#iso
052500100916    *c                   Write     brkprdr
052600130828     C                   CLEAR                   DS@B4
052700130828     C                   EVAL      DS@AF = BRP@
052800130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
052900130828     C                   CALL      'GAC592'
053000130828     C                   PARM                    @291
053100100916    ***
053200100916    *c                   EndIf
053300100916    ***
053400100916    *c     *USA          Move      zpefdt        #f                8 0
053500100916    *c     *USA          Move      zptrdt        #t                8 0
053600100916    *c                   Eval      @range = %EditC(#f:'Y') + '-' +
053700100916    *c                                      %EditC(#t:'Y')
053800100916    ***
053900100916    *c                   Eval      @o = '"' + bpacct + '","' + %Trim(adname)   +
054000100916    *c                             '","' + %Trim(@range) + '"'
054100100916    *c                   Except    outf
054200100916    ***
054300070430     c                   EndSR
054400070430   S***S
054500070430     c     $prep4        BegSR
054600070430    ***
054700070430     c                   If        #cnt = 0
054800070430     c                   Eval      @o = '"No Active Non-administered Business",'
054900070430     c                   Except    outf
055000070430     c                   EndIf
055100070430    ***
055200070430     c                   Eval      @step = 'STEP4'
055300060915    ***
055400060915     c                   EndSR
055500060915   S***S
055600060915     c     $step4        BegSR
055700060915    ***
055800060915     c     pi@frel       Chain(n)  comcxr
055900060915     c                   If        Not %Found(cmctlf)
056000060915     c                   Eval      @o = '"No Administered Business",'
056100060915     c                   Except    outf
056200070430     c                   Eval      @step = 'STEP6'
056300070312     c                   ExSR      $smrchg
056400060915     c                   LeaveSR
056500060915     c                   EndIf
056600060915    ***
056700060915     c     pi@frel       SetLL     comcxr
056800060915    ***
056900061005     c                   Move      *Zeros        #cnt              9 0
057000070430     c                   Eval      @step = 'STEP5'
057100061005    ***
057200061005     c                   EndSR
057300061005   S***S
057400061005     c     $smrchg       BegSR
057500061024    ***
057600061024     C                   CLEAR                   RSRLHIST
057700100318     C                   EVAL      HRELID = SRRELID
057800061005    ***
057900061005     c     FRMREL        Chain     srf
058000100318     C                   EVAL      HBEFORE = REC@DS
058100061005     c                   Eval      srtrmdte = trm8s0
058200100318     C                   EVAL      HAFTER = REC@DS
058300061005     c                   Update    srf
058400061024    ***
058500061024    *C                   MOVE      *BLANKS       @TS40
058600060915    ***
058700061024    *C                   CALL      'TIMESTMP'
058800061024    *C                   PARM                    @TS40
058900061024    *C                   MOVEL     @TS40         @TIMESTAMP
059000061024    *C                   EVAL      HJOB = @TSJOB
059100061024    *C                   EVAL      HUSERID = @TSUSER
059200061024    *C                   MOVE      #TSNBR        HNUMBER
059300061024    *C                   MOVE      #TSCYMD       HDATE
059400061024    *C                   MOVE      #TSTIME       HTIME
059500061024    ***
059600061024     C                   WRITE     RSRLHIST
059700061024    ***
059800060915     c                   EndSR
059900060915   S***S
060000060915     c     $step5        BegSR
060100060915    ***
060200060915     c     pi@frel       ReadE     comcxr
060300060915    ***
060400060915     c                   If        %EOF(cmctlf)
060500070430     c                   Eval      @step = 'STEP6'
060600060915     c                   If        #cnt = 0
060700060915     c                   Eval      @o = '"No Active Administered Business",'
060800060915     c                   Except    outf
060900060915     c                   EndIf
061000061005     c                   ExSR      $smrchg
061100060915     c                   LeaveSR
061200060915     c                   EndIf
061300070404    ***
061400070404     c                   If        cmcan =  effdat
061500070404     c                   LeaveSR
061600070404     c                   EndIf
061700070312    ***
061800070312     c     kl#           KList
061900070312     c                   KFld                    cmtrst
062000070312     c                   KFld                    csubdv
062100070312     c                   KFld                    cmacct
062200070312     c     kl#           Chain     accmsr
062300070312    ***
062400070419     c                   If        atrmdt <> 0
062500070419     c                   LeaveSR
062600070419     c                   EndIf
062700070419    ***
062800130828     C     KL#           CHAIN     ACCMSR2
062900130828     C                   IF        %FOUND(AC2MSTL2)
063000130828     C                             AND SVB@CHG = 'Y'
063100130828     C                   EVAL      A2CODE1 = TRSMAN
063200130828     C                   UPDATE    ACCMSR2
063300130828     C                   ENDIF
063400130828    ***
063500070312     c                   Move      *Blanks       @50              50
063600070312     c                   Eval      @50 = %EditC(cmtrst:'X') + '-' +
063700070312     c                             %EditC(csubdv:'X') + '-' +
063800070417     c                             %EditC(cmacct:'X') + '-' + cmplan
063900060915    ***
064000060915     c                   If        cmcan <> 0
064100070312    * *
064200070312     c                   If        cmcan > pi#dte and effdat < pi#dte
064300070802     c                   Eval      @oA =
064400070802     c                                  '"This Commission Control must be ma' +
064500070312     c                             'nually changed: ' + %Trim(acnam1) +
064600070312     c                             ' ' + %Trim(@50) + '; Acc Bkr:' + smancd +'"'
064700070802     c                   Except    outfA
064800070312     c                   EndIf
064900070312    * *
065000060915     c                   LeaveSR
065100060915     c                   EndIf
065200061208    ***
065300060915     c                   Add       1             #cnt
065400060915     c                   Eval      hld@cmx = cmx@
065500060915    ***
065600060915     c                   If        effdat >= pi#dte
065700060915    * *
065800081126     c                   move      cmcan         cmcanhold         8 0
065900060915     c                   Eval      cmcan = effdat
066000060915     c                   Eval      cmdltd = 'C'
066100060918     c                   ExSR      $histcnl
066200060915     c                   Update    comcxr
066300081126      * write new com hist
066400081126     c                   move      'D'           comhiscode
066500081126     C                   EXSR      #comhst
066600081126     c                   clear                   comhiscode
066700081126
066800060915     c                   Eval      cmx@ = hld@cmx
066900060915     c                   Eval      cmrelid = pi@trel
067000060919     c                   Eval      slsman = TRsman
067100060915     c                   Eval      cmdltd = 'A'
067200060918     c                   ExSR      $histadd
067300060915     c                   Write     comcxr
067400081126      * write new com hist
067500081126     c                   move      'A'           comhiscode
067600081126     c                   exsr      #comhst
067700081126     c                   clear                   comhiscode
067800081126
067900060915    * *
068000060915     c                   Else
068100060915    * *
068200081126     c                   move      cmcan         cmcanhold         8 0
068300060915     c                   Eval      cmcan = trm8s0
068400060915     c                   Eval      cmdltd = 'C'
068500060918     c                   ExSR      $histcnl
068600060915     c                   Update    comcxr
068700081126      * write new com hist
068800081126     c                   move      'D'           comhiscode
068900081126     c                   exsr      #comhst
069000081126     c                   clear                   comhiscode
069100081126
069200060915     c                   Eval      cmx@ = hld@cmx
069300060915     c                   Eval      cmrelid = pi@trel
069400060919     c                   Eval      slsman = TRsman
069500060915     c                   Eval      effdat = pi#dte
069600060915     c                   Eval      cmdltd = 'A'
069700060918     c                   ExSR      $histadd
069800060915     c                   Write     comcxr
069900081126      * write new com hist
070000081126     c                   move      'A'           comhiscode
070100081126     c                   exsr      #comhst
070200081126     c                   clear                   comhiscode
070300060915    * *
070400060915     c                   EndIf
070500060918    ***
070600070802     c                   If        smancd <> frsman And smancd <> trsman
070700070802     c                   Eval      @oA = '"Different BOR for plans of this ac' +
070800070802     c                             'count: ' + %Trim(acnam1) +
070900070802     c                             ' ' + %Trim(@50) + '; Acc Bkr:' + smancd +'"'
071000070802     c                   If        @oA <> pmsg
071100070802     c                   Eval      pmsg = %Trim(@oA)
071200070802     c                   Except    outfa
071300070802     c                   EndIf
071400070802     c                   EndIf
071500070802    ***
071600070802     c                   If        smancd = frsman AND smancd <> trsman
071700070802     c                   Eval      smancd = TRsman
071800070802     c                   ExSR      $hist_acc
071900070802     c                   Update    accmsr
072000070802     c                   EndIf
072100070802    ***
072200060920     c                   Move      yffdat        #iso
072300060920     c     *USA          Move      #iso          #f                8 0
072400060920    * *
072500060920     c                   If        ymcan = 0
072600060920     c                   Eval      #t = 0
072700060920     c                   Else
072800060920     c                   Move      ymcan         #iso
072900060920     c     *USA          Move      #iso          #t                8 0
073000060920     c                   EndIf
073100060920    ***
073200060915     c                   Eval      @range = %EditC(#f:'Y') + '-' +
073300060915     c                                      %EditC(#t:'Y')
073400060920    ***
073500060915     c                   Eval      @o = '"' + %Trim(@50) + '","' + %Trim(acnam1)
073600060915     c                             + '","' + %Trim(@range) + '"'
073700060915     c                   Except    outf
073800060918    ***
073900060918     c                   EndSR
074000070312   S***S
074100070312     c     $hist_acc     BegSR
074200070312    ***
074300070312     C                   CLEAR                   HISTR
074400070312     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
074500070312     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
074600070312     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
074700070312     C                   MOVE      *Blanks       TRMFLG
074800070312     C                   MOVE      *Blanks       TRLFLG
074900070312     C                   MOVE      'N'           DTRFLG
075000070312     C                   MOVE      *ZEROS        HDSEQ#
075100131007     c*******************Eval      hprgnm = 'F500'
075200131007     c                   eval      hprgnm = thispgmname
075300131007     c                   MoveL(p)  @TSUSER       hoper
075400131007     ********************MoveL(p)  @10           hoper
075500070312     c                   Move      cmtrst        hstrst
075600070312     c                   Move      csubdv        hssub#
075700070312     c                   Move      cmacct        hsacct
075800070312     C                   MOVE      'A'           HSDLTD
075900070312     c                   Eval      trdate = #today
076000131007     c                   eval      hstrtime = %time
076100070312     C                   MOVE      'L25'         TRCODE
076200070312     C                   MOVEL     frsman        CK#NOT
076300070312     C                   MOVEL     trsman        NOTE2
076400070312     c                   Eval      covtdt = pi#dte
076500070312     c                   Write     histr
076600070312    ***
076700070312     c                   EndSR
076800060918   S***S
076900060918     c     $histadd      BegSR
077000060918    ***
077100060918     c                   Clear                   histr
077200060918     c                   Move      cmtrst        hstrst
077300060918     c                   Move      csubdv        hssub#
077400060918     c                   Move      cmacct        hsacct
077500060918     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
077600060918     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
077700060918     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
077800070312     C                   MOVE      *Blanks       TRMFLG
077900070312     C                   MOVE      *Blanks       TRLFLG
078000060918     c                   Eval      dtrflg = 'N'
078100060918     c                   Eval      trcode = 'LAC'
078200060918     c                   Eval      ck#not = 'PLAN# - ' + cmplan +
078300060919     c                             '  SALESMAN - ' + TRSMAN
078400060918     c                   Eval      note2 = 'EFF DATE - ' +
078500060918     c                             %EditC(effdat:'X')
078600131007     c*******************Eval      hprgnm = 'F500'
078700131007     c                   eval      hprgnm = thispgmname
078800131007     c                   MoveL(p)  @TSUSER       hoper
078900131007     c*******************MoveL(p)  @10           hoper
079000060918     c                   Eval      hsdltd = 'A'
079100060918     c                   Eval      trdate = #today
079200060920     c                   Eval      covtdt = pi#dte
079300131007     c                   eval      hstrtime = %time
079400060918     c                   Write     histr
079500060915    ***
079600060915     c                   EndSR
079700060915   S***S
079800060918     c     $histcnl      BegSR
079900060918    ***
080000060918     c                   Clear                   histr
080100060918     c                   Move      cmtrst        hstrst
080200060918     c                   Move      csubdv        hssub#
080300060918     c                   Move      cmacct        hsacct
080400060918     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
080500060918     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
080600060918     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
080700060918     c                   Eval      trmflg = 'X'
080800060918     c                   Eval      trlflg = 'X'
080900060918     c                   Eval      dtrflg = 'N'
081000060918     c                   Eval      trcode = 'LDC'
081100060918     c                   Eval      ck#not = 'PLAN# - ' + cmplan +
081200060919     c                             '  SALESMAN - ' + FRSMAN
081300060918     c                   Eval      note2 = 'EFF DATE - ' +
081400060918     c                             %EditC(effdat:'X')
081500131007     c*******************Eval      hprgnm = 'F500'
081600131007     c*******************MoveL(p)  @10           hoper
081700131007     c                   eval      hprgnm = thispgmname
081800131007     c                   MoveL(p)  @TSUSER       hoper
081900060918     c                   Eval      hsdltd = 'A'
082000060918     c                   Eval      trdate = #today
082100131007     c                   eval      hstrtime = %time
082200060920     C                   Move      pi#trm        #8                8 0
082300060920     c                   Eval      covtdt = #8
082400060918     c                   Write     histr
082500070416    ***
082600070416     c                   EndSR
082700081126
082800081126      ******************************************************
082900081126      * write new commission history rec
083000081126      ******************************************************
083100081126     C     #comhst       BEGSR
083200081126
083300081126      * common fields in commission history file
083400081126     c                   clear                   comhstr
083500081126     C                   move      cmtrst        chtrust
083600081126     C                   move      csubdv        chsub
083700081126     C                   move      cmacct        chacc
083800081126     C                   MOVEL     cmplan        chplan
083900081126     c                   move      #today        chtrdat
084000081126     c                   time                    chtrtim
084100131007     C                   MOVEL     @TSUSER       chuser
084200131007     C********************OVEL     @10           chuser
084300081126     C                   MOVEL     'FM500R    '  chpgm
084400081126
084500081126      * after fields
084600081126     c                   move      effdat        chaeff
084700081126     c                   move      cmcan         chacan
084800081126     c                   move      cmrelid       charel
084900081126     c                   move      ccovpp        chapop
085000081126     c                   move      ccovra        chaff
085100081126     c                   move      ccovpc        chapoc
085200081126     c                   move      ccpnc         chapnc
085300081126     c                   move      cccmsp        chacmsp
085400090416     c                   movel     free5         chapri
085500081126
085600081126      * add new rec with after fields only
085700081126     c                   if        comhiscode = 'A'
085800081126     C                   eval      chtrcod = 'LAC'
085900081126     c                   write     comhstr
086000081126     c                   leavesr
086100081126     c                   end
086200081126      * before fields
086300081126     c                   move      effdat        chbeff
086400081126     c                   move      cmcanhold     chbcan
086500081126     c                   move      cmrelid       chbrel
086600081126     c                   move      ccovpp        chbpop
086700081126     c                   move      ccovra        chbff
086800081126     c                   move      ccovpc        chbpoc
086900081126     c                   move      ccpnc         chbpnc
087000081126     c                   move      cccmsp        chbcmsp
087100090416     c                   movel     free5         chbpri
087200081126
087300081126      * set transaction code for delete
087400081126     C                   eval      chtrcod = 'LDC'
087500081126
087600081126      * add rec with before and after fields
087700081126     c                   write     comhstr
087800081126
087900081126     C                   ENDSR
088000070416   S***S
088100070416     c     $step6        BegSR
088200070416    ***
088300070430     c                   Eval      @step = 'LEAVE'
088400070416    ***
088500070416     c                   EndSR
088600060918   S***S
088700060915     c     *Inzsr        BegSR
088800060915    ***
088900060920    *c     *Entry        PList
089000060920    *c                   Parm                    @10              10
089100060919    *c*                  Eval      prm@in = @24
089200131007     C                   CALL      'TIMESTMP'
089300131007     C                   PARM                    @TS40
089400131007     C                   EVAL      P@40 = @TS40
089500131007     C                   MOVE      #TSCYMD       #TODAY
089600131007     c*******************Eval      #iso = %Date
089700131007     c*******************Move      #iso          #today
089800060915    ***
089900060915     c                   EndSR
090000060915   S***S
090100060918     oT2000     EADD         OUTF
090200060918     o                       @o             B  2000
090300070223     oT2000A    EADD         OUTFA
090400070223     o                       @oA            B  2000
