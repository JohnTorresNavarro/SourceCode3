000100131008   X***X
000200131008   X***X 11/26/08 dlk - add new commission history file
000300131008   X***X FIXED SRLHIST DATA
000400131008   X***X
000500131008   X***X SSK 05/11/2010 NO IMD CLONED VERSION OF FM500R
000600131008   X***X
000700131008   X***X 07/15/2011 SSK ADD HISTORIC BEFORE AND AFTER IMAGES
000800131008   X***X
000900131008   X***X 08/28/2013 SSK ADD AC2MST BROKER LOGIC
001000131008   X***X   FIELD IS A2CODE1 AND IS THE RENEWAL BROKER
001100131008   X***X
001200131008   X***X 10/04/2013 SSK HIST EXPANSION PROJECT
001300131008   X***X
001400131008   X***X
001500131008   X***X
001600131008   X***X
001700110511     FFM501D    CF   E             WORKSTN INFDS(WSDS)
001800061005     fsmanrlt   Uf   e           k disk
001900070416     faccmst5   if   e           k disk    RENAME(accmsr:lf5) prefix(q)
002000070312     faccmst    uf   e           k disk
002100130828     FAC2MSTL2  UF   E           K DISK
002200060915     faccmstp   if   e           k disk
002300070416     fcmct14    if   e           k disk    rename(comcxr:cm14) prefix(c)
002400060915     fcmctlf    uf a e           k disk
002500060915     fbrkprdl   uf a e           k disk
002600061024     FSRLHIST0  O  A E           K DISK
002700060915     FHIST      O  A E             DISK
002800070413     FSYSMODLOG O  A E             DISK
002900070416     FCMIABLKTR O  A E             DISK
003000070416     FINTGBSLOG O  A E             DISK
003100081126     Fcomhst    O  A E             DISK
003200060915     ft2000     o  a f 2000        disk
003300070223     ft2000A    o  a f 2000        disk
003400060915   X***X
003500081126     D comhiscode      S              1A
003600060918     D WSDS            DS
003700060918     D  FKEY                 369    369A
003800060918    ***       FUNCTION KEYS
003900060918     D  F1             C                   CONST(X'31')
004000060918     D  F2             C                   CONST(X'32')
004100060918     D  F3             C                   CONST(X'33')
004200060918     D  F4             C                   CONST(X'34')
004300060918     D  F5             C                   CONST(X'35')
004400060918     D  F6             C                   CONST(X'36')
004500060918     D  F7             C                   CONST(X'37')
004600060918     D  F8             C                   CONST(X'38')
004700060918     D  F9             C                   CONST(X'39')
004800060918     D  F10            C                   CONST(X'3A')
004900060918     D  F11            C                   CONST(X'3B')
005000060918     D  F12            C                   CONST(X'3C')
005100060918     D  F13            C                   CONST(X'B1')
005200060918     D  F14            C                   CONST(X'B2')
005300060918     D  F15            C                   CONST(X'B3')
005400060918     D  F16            C                   CONST(X'B4')
005500060918     D  F17            C                   CONST(X'B5')
005600060918     D  F18            C                   CONST(X'B6')
005700060918     D  F19            C                   CONST(X'B7')
005800060918     D  F20            C                   CONST(X'B8')
005900060918     D  F21            C                   CONST(X'B9')
006000060918     D  F22            C                   CONST(X'BA')
006100060918     D  F23            C                   CONST(X'BB')
006200060918     D  F24            C                   CONST(X'BC')
006300060918    ***
006400060915     d                 ds
006500060918     d prm@in                  1     24a
006600060915     d pi@frel                 1      8a
006700060915     d pi@trel                 9     16a
006800060918     d pi#dte                 17     24s 0
006900060915    ***
007000060915     d @range          s             30a
007100070416     d log@          e ds                  extname(sysmodlog) prefix(vv:2)
007200070416     d sys@          e ds                  extname(sysmodlog)
007300070416     d cmia@         e ds                  extname(cmiablktR)
007400070416     d igbs@         e ds                  extname(intgbslog)
007500060915     d brp@          e ds                  extname(brkprdp)
007600060915     d hld@brp       e ds                  extname(brkprdp) prefix(z:1)
007700060915     d pi#iso          s               d   datfmt(*ISO)
007800080813     d #H              s               d   datfmt(*ISO)
007900080813     d #L              s               d   datfmt(*ISO)
008000130828     D SVB@CHG         S              1A
008100060915     d trm8s0          s              8s 0
008200060918     d #today          s              8s 0
008300060919     d #usa            s               d   datfmt(*USA)
008400060918     d #iso            s               d   datfmt(*ISO)
008500060915     d pi#trm          s               d   datfmt(*ISO)
008600060919     d @v              s              1a
008700070430     d @step           s              5a
008800060919     d hfrm            s              8a
008900060919     d hto             s              8a
009000060919     d hpdate          s              8s 0
0091001310080037 D sysdateymd      S               d   datfmt(*iso)
009200131008     D thispgmname     S             10a   inz('FM500     ')
009300130828     D DS@B4         E DS                  EXTNAME(BRKPRDP) PREFIX(B4:2)
009400130828     D  B4@IMG                 1    125A
009500130828      *
009600130828     D DS@AF         E DS                  EXTNAME(BRKPRDP) PREFIX(AF:2)
009700130828     D  AF@IMG                 1    125A
009800130828      *
009900130828     D @291            S            291A
010000080813     d warn#dte        s              8s 0
010100060915     d @o              s           2000a
010200070223     d @oA             s           2000a
010300070417     d pmsg            s           2000a
010400060915     d cmx@          e ds                  extname(comctx)
010500060915     d hld@cmx       e ds                  extname(comctx) prefix(y:1)
010600061024     D REC@DS        E DS                  EXTNAME(SMANRLT)
010700060915    ***
010800130828     ***
010900130828     D f@SMAN          S              3a
011000130828     D f@SNAME         S             50a
011100130828     D f@AGCY          S              3a
011200130828     D f@ANAME         S             50a
011300130828     D f@SUPER         S              3A
011400130828     D f@UNAME         S             50A
011500060915    ***
011600130828     D t@SMAN          S              3a
011700130828     D t@SNAME         S             50a
011800130828     D t@AGCY          S              3a
011900130828     D t@ANAME         S             50a
012000130828     D t@SUPER         S              3A
012100130828     D t@UNAME         S             50A
012200060915    ***
012300060915     D                 DS
012400060915     D PRMS                    1    142A
012500060915     D P@SMAN                  1      3A
012600060915     D P@SNAME                 4     36A
012700060915     D P@AGCY                 37     39A
012800060915     D P@ANAME                40     79A
012900060915     D P@SUPER                80     82A
013000060915     D P@UNAME                83    132A
013100060915     D P@RELID               133    140A
013200060915     D P@RESULT              141    141A
013300060915     D P@REQUEST             142    142A
013400060915    ***     call gar900
013500060915     D @@@PARMS        S            142A
013600061024    ***
013700061024     D @TS40           S             40A
013800061024     D @TIMESTAMP      DS
013900131008     D  P@40                   1     40A
014000061024     D  #TSCYMD                1      8S 0
014100061024     D  #TSTIME                9     14S 0
014200061024     D  @TSJOB                15     24
014300061024     D  @TSUSER               25     34
014400061024     D  #TSNBR                35     40S 0
014500060915   X***X
014600060919     c                   Eval      @v = 'A'
014700070430     c                   Eval      @step = 'BEGIN'
014800060918     C                   EXSR      $SCREEN
014900060918    ***
015000070430     c                   DoW       @step <> 'LEAVE'
015100070430     c     @step         CasEq     'STEP1'       $step1
015200070430     c     @step         CasEq     'STEP2'       $step2
015300070430     c     @step         CasEq     'STEP3'       $step3
015400070430     c     @step         CasEq     'PREP4'       $prep4
015500070430     c     @step         CasEq     'STEP4'       $step4
015600070430     c     @step         CasEq     'STEP5'       $step5
015700070430     c     @step         CasEq     'STEP6'       $step6
015800060918     c                   EndCs
015900060915     c                   EndDo
016000060915     c                   Eval      *InLR = *On
016100060918   S***S
016200060918     C     $screen       BegSR
016300070416    ***
016400070416     c                   Eval      al1 = 'ALL'
016500060918    ***
016600070430     c                   DoU       fkey = F3 or @step <> 'BEGIN'
016700060918    * *
016800060918     c                   ExFmt     io01
016900060918    * *
017000060920     c                   If        fkey = F3
017100070430     c                   Eval      @step = 'LEAVE'
017200060920     c                   LEAVESR
017300060918     c                   EndIf
017400060919    * *
017500060919     c                   If        hfrm <> frmrel or hto <> torel or
017600060919     c                             procdate <> hpdate
017700060919     c                   Eval      @v = 'A'
017800060919     c                   EndIf
017900060918    * *
018000060919     c                   If        @v = 'G'
018100070430     c                   Eval      @step = 'STEP1'
018200060919     c                   LeaveSR
018300060919     c                   EndIf
018400060919    * *
018500060919     c                   ExSR      $procscr
018600060918    * *
018700060918     c                   EndDo
018800060919    ***
018900060919     C                   EndSR
019000060919   S***S
019100060919     c     $procscr      BegSR
019200060919    ***
019300060919     c                   Eval      hfrm = frmrel
019400060919     c                   Eval      hto = torel
019500060919     c                   Eval      hpdate = procdate
019600070416    ***
019700070802     C                   EVAL      SCLOG = 'S'
019800070416     c                   If        sclog = *blanks Or (sclog <> 'S' And
019900070416     c                             sclog <> 'C' And sclog <> 'I')
020000070416     c                   Eval      emsg = 'Invalid log value.'
020100070416     c                   LeaveSR
020200070416     c                   EndIf
020300060919    ***
020400060919     c                   If        frmrel = *blanks
020500060919     c                   Eval      emsg = 'From Relationship is invalid.'
020600060919     c                   LeaveSR
020700060919     c                   EndIf
020800060919    ***
020900061005     c     frmrel        Chain(n)  srf
021000060919     c                   If        Not %Found(smanrlt)
021100060919     c                   Eval      emsg = 'From Relationship is invalid.'
021200060919     c                   LeaveSR
021300060919     c                   EndIf
021400060919    ***
021500060919     c                   Eval      pi@frel = frmrel
021600060919    ***
021700060919     C                   Move      *BLANKS       PRMS
021800060919     C                   Eval      P@RELID = frmrel
021900060919     C                   Eval      P@REQUEST = 'R'
022000060919     C                   Eval      @@@PARMS = PRMS
022100060919     C                   Call      'GAC900'
022200060919     C                   Parm                    @@@PARMS
022300060919    * *
022400060919     C                   MoveL     @@@PARMS      PRMS
022500060919    * *
022600060919     C                   If        P@RESULT = 'P'
022700060919     C                   Eval      frSMAN  = P@SMAN
022800060919     C                   MoveL(p)  P@SNAME       frSMANd
022900060919     C                   Eval      frAGCY  = P@AGCY
023000060919     C                   MoveL(p)  P@ANAME       frAGCYd
023100060919     C                   Eval      frSUPER = P@SUPER
023200060919     C                   MoveL(p)  P@UNAME       frSUPERd
023300060919     C                   Else
023400060919     C                   MoveL(p)  '*ERROR*'     frSMAN
023500060919     C                   MoveL(p)  '*ERROR*'     frAGCY
023600060919     C                   MoveL(p)  '*ERROR*'     frSUPER
023700060919     C                   MoveL(p)  '*ERROR*'     frSMANd
023800060919     C                   MoveL(p)  '*ERROR*'     frAGCYd
023900060919     C                   MoveL(p)  '*ERROR*'     frSUPERd
024000080813     c                   Eval      emsg = 'Error in retrieval, call 3305'
024100080813     c                   LeaveSR
024200060919     c                   EndIf
024300060919    ***
024400060919     c                   If        torel = *blanks
024500060919     c                   Eval      emsg = 'To Relationship is invalid.'
024600060919     c                   LeaveSR
024700060919     c                   EndIf
024800060919    ***
024900061005     c     torel         Chain(n)  srf
025000060919     c                   If        Not %Found(smanrlt)
025100060919     c                   Eval      emsg = 'To Relationship is invalid.'
025200060919     c                   LeaveSR
025300060919     c                   EndIf
025400060919    ***
025500060919     c                   Eval      pi@trel = torel
025600060919    ***
025700060919     C                   Move      *BLANKS       PRMS
025800060919     C                   Eval      P@RELID = torel
025900060919     C                   Eval      P@REQUEST = 'R'
026000060919     C                   Eval      @@@PARMS = PRMS
026100060919     C                   Call      'GAC900'
026200060919     C                   Parm                    @@@PARMS
026300060919    * *
026400060919     C                   MoveL     @@@PARMS      PRMS
026500060919    * *
026600060919     C                   If        P@RESULT = 'P'
026700060919     C                   Eval      trSMAN  = P@SMAN
026800060919     C                   MoveL(p)  P@SNAME       trSMANd
026900060919     C                   Eval      trAGCY  = P@AGCY
027000060919     C                   MoveL(p)  P@ANAME       trAGCYd
027100060919     C                   Eval      trSUPER = P@SUPER
027200060919     C                   MoveL(p)  P@UNAME       trSUPERd
027300060919     C                   Else
027400060919     C                   MoveL(p)  '*ERROR*'     trSMAN
027500060919     C                   MoveL(p)  '*ERROR*'     trAGCY
027600060919     C                   MoveL(p)  '*ERROR*'     trSUPER
027700060919     C                   MoveL(p)  '*ERROR*'     trSMANd
027800060919     C                   MoveL(p)  '*ERROR*'     trAGCYd
027900060919     C                   MoveL(p)  '*ERROR*'     trSUPERd
028000080813     c                   Eval      emsg = 'Error in retrieval, call 3305'
028100080813     c                   LeaveSR
028200060919     c                   EndIf
028300060919    ***
028400060919     c                   If        procdate = 0
028500060919     c                   Eval      emsg = 'Process Date is invalid.'
028600060919     c                   LeaveSR
028700060919     c                   EndIf
028800060919    ***
028900060919     c     *USA          test(de)                procdate
029000060919     c                   If        %Error
029100060919     c                   Eval      emsg = 'Process Date is invalid.'
029200060919     c                   LeaveSR
029300060919     c                   EndIf
029400060919    ***
029500060919     c                   Move      procdate      #usa
029600060919     c                   Move      #usa          #iso
029700060919     c                   Move      #iso          pi#dte
029800060919     c                   Move      pi#dte        pi#iso
029900060919     c                   Move      pi#dte        pi#trm
030000060919     c                   SubDur    1:*D          pi#trm
030100060919     c                   Move      pi#trm        trm8s0
030200080813    ***
030300080813     C                   EVAL      #H = %DATE
030400080813     C                   EVAL      #L = %DATE
030500080813     C                   ADDDUR    90:*D         #H
030600080813     C                   SUBDUR    90:*D         #L
030700080813     C                   If        PI#ISO < #L Or PI#ISO > #H
030800080813     c                   If        pi#dte <> warn#dte
030900080813     c                   Eval      warn#dte = pi#dte
031000080813     c                   Eval      emsg = 'Date outside of 90 days, press ' +
031100080813     c                             ' enter to accept'
031200080813     c                   LeaveSR
031300080813     c                   EndIf
031400080813     c                   EndIf
031500130828    ***
031600130828     C                   IF        FRAGCY <> TRAGCY
031700130828     C                   EVAL      SVB@CHG = 'Y'
031800130828     C                   ELSE
031900130828     C                   EVAL      SVB@CHG = 'N'
032000130828     C                   ENDIF
032100060919    ***
032200060919     c                   Eval      emsg = 'Press Enter to Run'
032300060919     c                   Eval      @v = 'G'
032400060918    ***
032500060918     C                   EndSR
032600060915   S***S
032700060915     c     $step1        BegSR
032800070416    ***
032900070416     c                   Clear                   log@
033000070802     c                   Eval      sclog = 'S'
033100070802     c                   Eval      al1 = *blanks
033200070802     c                   Eval      al2 = *blanks
033300070416     c                   Move      #today        vvmodte
033400070416     c                   Move      pi#dte        vveffdte
033500070416     c                   Eval      vvpvrelid = frmrel
033600070417     c                   Eval      vvpvsname = %Trim(frsmand)
033700070416     c                   Eval      vvpvsman = frsman
033800070416     c                   Eval      vvpvagcy = fragcy
033900070416     c                   Eval      vvpvsuper = frsuper
034000070416     c                   Eval      vvnwrelid = torel
034100070416     c                   Eval      vvnwsman = trsman
034200070417     c                   Eval      vvnwsname = %Trim(trsmand)
034300070416     c                   Eval      vvnwagcy = tragcy
034400070416     c                   Eval      vvnwsuper = trsuper
034500070416     c                   Eval      vvaal = %Trim(al1) + %Trim(al2)
034600070416    ***
034700070416     c                   Select
034800070416     c                   When      sclog = 'S'
034900070416     c                   Eval      sys@ = log@
035000070416     c                   Write     smlf
035100070416     c                   When      sclog = 'C'
035200070416     c                   Eval      cmia@ = log@
035300070416     c                   Write     cmiaf
035400070416     c                   When      sclog = 'I'
035500070416     c                   Eval      igbs@ = log@
035600070416     c                   Write     igbsf
035700070416     c                   Endsl
035800060915    ***
035900060919     c                   Eval      f@SMAN  = frSMAN
036000060919     c                   Eval      f@SNAME = frsmand
036100060919     c                   Eval      f@AGCY  = fragcy
036200060919     c                   Eval      f@ANAME = fragcyd
036300060919     c                   Eval      f@SUPER = frSUPER
036400060919     c                   Eval      f@UNAME = frsuperd
036500060915    ***
036600060919     c                   Eval      t@SMAN  = trSMAN
036700060919     c                   Eval      t@SNAME = trsmand
036800060919     c                   Eval      t@AGCY  = tragcy
036900060919     c                   Eval      t@ANAME = tragcyd
037000060919     c                   Eval      t@SUPER = trSUPER
037100060919     c                   Eval      t@UNAME = trsuperd
037200060915    ***
037300060915     c                   Eval      @o = '"Relationship ID Move With Cancel"'
037400060915     c                   Except    outf
037500060915    ***
037600060915     c                   Eval      @o = ','
037700060915     c                   Except    outf
037800060915    ***
037900060919     c                   Eval      @o = '"From Relationship ID: ' + frmrel     +
038000060919     c                             '; Sman: ' + %Trim(frsman) + '-'            +
038100060919     c                             %Trim(frsmand) + '; Agency: ' + fragcy      +
038200060919     c                             '-' + %Trim(fragcyd) + '; Super Agency: '   +
038300060919     c                             frsuper + '-' + %Trim(frsuperd) + '",'
038400060915     c                   Except    outf
038500060915    ***
038600060915     c                   Eval      @o = ','
038700060915     c                   Except    outf
038800060915    ***
038900060919     c                   Eval      @o = '"To Relationship ID: ' + torel        +
039000060919     c                             '; Sman: ' + %Trim(trsman) + '-'            +
039100060919     c                             %Trim(trsmand) + '; Agency: ' + tragcy      +
039200060919     c                             '-' + %Trim(tragcyd) + '; Super Agency: '   +
039300060920     c                             trsuper + '-' + %Trim(trsuperd) + '",'
039400060915     c                   Except    outf
039500060915    ***
039600060915     c                   Eval      @o = ','
039700060915     c                   Except    outf
039800060915    ***
039900070419     c                   Eval      @o = '"Account Number[W/Plan]","Account Na' +
040000070419     c                             'me","Previous Date Range"'
040100060915     c                   Except    outf
040200060915    ***
040300070223     c                   Eval      @oA = '"Relationship ID Move Exceptions"'
040400070223     c                   Except    outfa
040500070223    ***
040600070223     c                   Eval      @oA = ','
040700070223     c                   Except    outfa
040800070223    ***
040900070223     c                   Eval      @oA = '"From Relationship ID: ' + frmrel    +
041000070223     c                             '; Sman: ' + %Trim(frsman) + '-'            +
041100070223     c                             %Trim(frsmand) + '; Agency: ' + fragcy      +
041200070223     c                             '-' + %Trim(fragcyd) + '; Super Agency: '   +
041300070223     c                             frsuper + '-' + %Trim(frsuperd) + '",'
041400070223     c                   Except    outfa
041500070223    ***
041600070223     c                   Eval      @oA = ','
041700070223     c                   Except    outfa
041800070223    ***
041900070223     c                   Eval      @oA = '"To Relationship ID: ' + torel       +
042000070223     c                             '; Sman: ' + %Trim(trsman) + '-'            +
042100070223     c                             %Trim(trsmand) + '; Agency: ' + tragcy      +
042200070223     c                             '-' + %Trim(tragcyd) + '; Super Agency: '   +
042300070223     c                             trsuper + '-' + %Trim(trsuperd) + '",'
042400070223     c                   Except    outfa
042500070223    ***
042600070223     c                   Eval      @oA = ','
042700070223     c                   Except    outfa
042800070223    ***
042900070223     c                   Eval      @oA = '"Account Number","Account Name","Pr' +
043000070223     c                             'evious Date Range"'
043100070223     c                   Except    outfa
043200070223    ***
043300070430     c                   Eval      @step = 'STEP2'
043400060915    ***
043500060915     c                   EndSR
043600060915   S***S
043700060915     c     $step2        BegSR
043800060915    ***
043900060915     c     pi@frel       Chain(n)  brkprdr
044000060915     c                   If        Not %Found(brkprdl)
044100060915     c                   Eval      @o = '"No Non-administered Business",'
044200060915     c                   Except    outf
044300070430     c                   Eval      @step = 'STEP4'
044400060915     c                   LeaveSR
044500060915     c                   EndIf
044600060915    ***
044700060915     c     pi@frel       SetLL     brkprdr
044800060915    ***
044900060915     c                   Move      *Zeros        #cnt              9 0
045000070430     c                   Eval      @step = 'STEP3'
045100060915    ***
045200060915     c                   EndSR
045300060915   S***S
045400060915     c     $step3        BegSR
045500060915    ***
045600060915     c     pi@frel       ReadE     brkprdr
045700060915    ***
045800060915     c                   If        %EOF(brkprdl)
045900070430     c                   Eval      @step = 'PREP4'
046000060915     c                   LeaveSR
046100060915     c                   EndIf
046200070404    ***
046300070404     c                   If        bpefdt = bptrdt
046400110511     C                             OR %SUBST(BPACCT:1:1) = 'I'
046500070404     c                   LeaveSR
046600070404     c                   EndIf
046700070312    ***
046800070312     c     bpacct        Chain     accmstr
046900060915    ***
047000060915     c                   If        bptrdt <> D'9999-12-31'
047100070312    * *
047200070312     c                   If        bptrdt > pi#iso and bpefdt < pi#iso
047300070312     c                   If        adimd = 'Y'
047400110511     c                   Eval      @o = '"Have KELLY manually fix this record f'
047500070312     c                             + 'or account:' + %Trim(adname) + '",'
047600070312     c                   Else
047700070312     c                   Eval      @o = '"Have Ev manually fix this record f'
047800070312     c                             + 'or account:' + %Trim(adname) + '",'
047900070312     c                   EndIf
048000070312     c                   Except    outf
048100070312     c                   EndIf
048200070312    * *
048300061005     c                   LeaveSR
048400060915     c                   EndIf
048500061208    ***
048600060915     c                   Add       1             #cnt
048700060915     c                   Eval      hld@brp = brp@
048800130828     C                   EVAL      DS@B4 = BRP@
048900130828     C                   CALL      'TIMESTMP'
049000130828     C                   PARM                    @TS40
049100130828     C                   EVAL      P@40 = @TS40
049200060915    ***
049300060920     c                   If        bpefdt >= pi#iso or bpefdt = D'0001-01-01'
049400060915    * *
049500060915     c                   Eval      bptrdt = bpefdt
049600130828     C                   EVAL      DS@AF = BRP@
049700060915     c                   Update    brkprdr
049800130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
049900130828     C                   CALL      'GAC592'
050000130828     C                   PARM                    @291
050100060915     c                   Eval      brp@ = hld@brp
050200060915     c                   Eval      bprelid = pi@trel
050300060915     c                   Eval      bpsman = t@sman
050400060915     c                   Eval      bpagcy = t@agcy
050500060915     c                   Eval      bpsuper = t@super
050600060915     c                   Write     brkprdr
050700130828     C                   CLEAR                   DS@B4
050800130828     C                   EVAL      DS@AF = BRP@
050900130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
051000130828     C                   CALL      'GAC592'
051100130828     C                   PARM                    @291
051200060915    * *
051300060915     c                   Else
051400060915    * *
051500060915     c                   Eval      bptrdt = pi#trm
051600130828     C                   EVAL      DS@AF = BRP@
051700060915     c                   Update    brkprdr
051800130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
051900130828     C                   CALL      'GAC592'
052000130828     C                   PARM                    @291
052100060915     c                   Eval      brp@ = hld@brp
052200060915     c                   Eval      bprelid = pi@trel
052300060915     c                   Eval      bpsman = t@sman
052400060915     c                   Eval      bpagcy = t@agcy
052500060915     c                   Eval      bpsuper = t@super
052600060915     c                   Eval      bpefdt = pi#iso
052700060915     c                   Write     brkprdr
052800130828     C                   CLEAR                   DS@B4
052900130828     C                   EVAL      DS@AF = BRP@
053000130828     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
053100130828     C                   CALL      'GAC592'
053200130828     C                   PARM                    @291
053300060915    * *
053400060915     c                   EndIf
053500060915    ***
053600060915     c     *USA          Move      zpefdt        #f                8 0
053700060915     c     *USA          Move      zptrdt        #t                8 0
053800060915     c                   Eval      @range = %EditC(#f:'Y') + '-' +
053900060915     c                                      %EditC(#t:'Y')
054000060915    * *
054100060915     c                   Eval      @o = '"' + bpacct + '","' + %Trim(adname)   +
054200060915     c                             '","' + %Trim(@range) + '"'
054300060915     c                   Except    outf
054400070430    ***
054500070430     c                   EndSR
054600070430   S***S
054700070430     c     $prep4        BegSR
054800070430    ***
054900070430     c                   If        #cnt = 0
055000070430     c                   Eval      @o = '"No Active Non-administered Business",'
055100070430     c                   Except    outf
055200070430     c                   EndIf
055300070430    ***
055400070430     c                   Eval      @step = 'STEP4'
055500060915    ***
055600060915     c                   EndSR
055700060915   S***S
055800060915     c     $step4        BegSR
055900060915    ***
056000060915     c     pi@frel       Chain(n)  comcxr
056100060915     c                   If        Not %Found(cmctlf)
056200060915     c                   Eval      @o = '"No Administered Business",'
056300060915     c                   Except    outf
056400070430     c                   Eval      @step = 'STEP6'
056500070312     c                   ExSR      $smrchg
056600060915     c                   LeaveSR
056700060915     c                   EndIf
056800060915    ***
056900060915     c     pi@frel       SetLL     comcxr
057000060915    ***
057100061005     c                   Move      *Zeros        #cnt              9 0
057200070430     c                   Eval      @step = 'STEP5'
057300061005    ***
057400061005     c                   EndSR
057500061005   S***S
057600061005     c     $smrchg       BegSR
057700061024    ***
057800061024     C                   CLEAR                   RSRLHIST
057900100318     C                   EVAL      HRELID = SRRELID
058000061005    ***
058100061005     c     FRMREL        Chain     srf
058200100318     C                   EVAL      HBEFORE = REC@DS
058300061005     c                   Eval      srtrmdte = trm8s0
058400100318     C                   EVAL      HAFTER = REC@DS
058500061005     c                   Update    srf
058600061024    ***
058700061024    *C                   MOVE      *BLANKS       @TS40
058800060915    ***
058900061024    *C                   CALL      'TIMESTMP'
059000061024    *C                   PARM                    @TS40
059100131008     C                   EVAL      P@40 = @TS40
059200061024    *C                   EVAL      HJOB = @TSJOB
059300061024    *C                   EVAL      HUSERID = @TSUSER
059400061024    *C                   MOVE      #TSNBR        HNUMBER
059500061024    *C                   MOVE      #TSCYMD       HDATE
059600061024    *C                   MOVE      #TSTIME       HTIME
059700061024    ***
059800061024     C                   WRITE     RSRLHIST
059900061024    ***
060000060915     c                   EndSR
060100060915   S***S
060200060915     c     $step5        BegSR
060300060915    ***
060400060915     c     pi@frel       ReadE     comcxr
060500060915    ***
060600060915     c                   If        %EOF(cmctlf)
060700070430     c                   Eval      @step = 'STEP6'
060800060915     c                   If        #cnt = 0
060900060915     c                   Eval      @o = '"No Active Administered Business",'
061000060915     c                   Except    outf
061100060915     c                   EndIf
061200061005     c                   ExSR      $smrchg
061300060915     c                   LeaveSR
061400060915     c                   EndIf
061500070404    ***
061600070404     c                   If        cmcan =  effdat
061700070404     c                   LeaveSR
061800070404     c                   EndIf
061900070312    ***
062000070312     c     kl#           KList
062100070312     c                   KFld                    cmtrst
062200070312     c                   KFld                    csubdv
062300070312     c                   KFld                    cmacct
062400070312     c     kl#           Chain     accmsr
062500070312    ***
062600070419     c                   If        atrmdt <> 0
062700070419     c                   LeaveSR
062800070419     c                   EndIf
062900070419    ***
063000130828     C     KL#           CHAIN     ACCMSR2
063100130828     C                   IF        %FOUND(AC2MSTL2)
063200130828     C                             AND SVB@CHG = 'Y'
063300130828     C                   EVAL      A2CODE1 = TRSMAN
063400130828     C                   UPDATE    ACCMSR2
063500130828     C                   ENDIF
063600130828    ***
063700070312     c                   Move      *Blanks       @50              50
063800070312     c                   Eval      @50 = %EditC(cmtrst:'X') + '-' +
063900070312     c                             %EditC(csubdv:'X') + '-' +
064000070417     c                             %EditC(cmacct:'X') + '-' + cmplan
064100060915    ***
064200060915     c                   If        cmcan <> 0
064300070312    * *
064400070312     c                   If        cmcan > pi#dte and effdat < pi#dte
064500070802     c                   Eval      @oA =
064600070802     c                                  '"This Commission Control must be ma' +
064700070312     c                             'nually changed: ' + %Trim(acnam1) +
064800070312     c                             ' ' + %Trim(@50) + '; Acc Bkr:' + smancd +'"'
064900070802     c                   Except    outfA
065000070312     c                   EndIf
065100070312    * *
065200060915     c                   LeaveSR
065300060915     c                   EndIf
065400061208    ***
065500060915     c                   Add       1             #cnt
065600060915     c                   Eval      hld@cmx = cmx@
065700060915    ***
065800060915     c                   If        effdat >= pi#dte
065900060915    * *
066000081126     c                   move      cmcan         cmcanhold         8 0
066100060915     c                   Eval      cmcan = effdat
066200060915     c                   Eval      cmdltd = 'C'
066300060918     c                   ExSR      $histcnl
066400060915     c                   Update    comcxr
066500081126      * write new com hist
066600081126     c                   move      'D'           comhiscode
066700081126     C                   EXSR      #comhst
066800081126     c                   clear                   comhiscode
066900081126
067000060915     c                   Eval      cmx@ = hld@cmx
067100060915     c                   Eval      cmrelid = pi@trel
067200060919     c                   Eval      slsman = TRsman
067300060915     c                   Eval      cmdltd = 'A'
067400060918     c                   ExSR      $histadd
067500060915     c                   Write     comcxr
067600081126      * write new com hist
067700081126     c                   move      'A'           comhiscode
067800081126     c                   exsr      #comhst
067900081126     c                   clear                   comhiscode
068000081126
068100060915    * *
068200060915     c                   Else
068300060915    * *
068400081126     c                   move      cmcan         cmcanhold         8 0
068500060915     c                   Eval      cmcan = trm8s0
068600060915     c                   Eval      cmdltd = 'C'
068700060918     c                   ExSR      $histcnl
068800060915     c                   Update    comcxr
068900081126      * write new com hist
069000081126     c                   move      'D'           comhiscode
069100081126     c                   exsr      #comhst
069200081126     c                   clear                   comhiscode
069300081126
069400060915     c                   Eval      cmx@ = hld@cmx
069500060915     c                   Eval      cmrelid = pi@trel
069600060919     c                   Eval      slsman = TRsman
069700060915     c                   Eval      effdat = pi#dte
069800060915     c                   Eval      cmdltd = 'A'
069900060918     c                   ExSR      $histadd
070000060915     c                   Write     comcxr
070100081126      * write new com hist
070200081126     c                   move      'A'           comhiscode
070300081126     c                   exsr      #comhst
070400081126     c                   clear                   comhiscode
070500060915    * *
070600060915     c                   EndIf
070700060918    ***
070800070802     c                   If        smancd <> frsman And smancd <> trsman
070900070802     c                   Eval      @oA = '"Different BOR for plans of this ac' +
071000070802     c                             'count: ' + %Trim(acnam1) +
071100070802     c                             ' ' + %Trim(@50) + '; Acc Bkr:' + smancd +'"'
071200070802     c                   If        @oA <> pmsg
071300070802     c                   Eval      pmsg = %Trim(@oA)
071400070802     c                   Except    outfa
071500070802     c                   EndIf
071600070802     c                   EndIf
071700070802    ***
071800070802     c                   If        smancd = frsman AND smancd <> trsman
071900070802     c                   Eval      smancd = TRsman
072000070802     c                   ExSR      $hist_acc
072100070802     c                   Update    accmsr
072200070802     c                   EndIf
072300070802    ***
072400060920     c                   Move      yffdat        #iso
072500060920     c     *USA          Move      #iso          #f                8 0
072600060920    * *
072700060920     c                   If        ymcan = 0
072800060920     c                   Eval      #t = 0
072900060920     c                   Else
073000060920     c                   Move      ymcan         #iso
073100060920     c     *USA          Move      #iso          #t                8 0
073200060920     c                   EndIf
073300060920    ***
073400060915     c                   Eval      @range = %EditC(#f:'Y') + '-' +
073500060915     c                                      %EditC(#t:'Y')
073600060920    ***
073700060915     c                   Eval      @o = '"' + %Trim(@50) + '","' + %Trim(acnam1)
073800060915     c                             + '","' + %Trim(@range) + '"'
073900060915     c                   Except    outf
074000060918    ***
074100060918     c                   EndSR
074200070312   S***S
074300070312     c     $hist_acc     BegSR
074400070312    ***
074500070312     C                   CLEAR                   HISTR
074600070312     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
074700070312     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
074800070312     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
074900070312     C                   MOVE      *Blanks       TRMFLG
075000070312     C                   MOVE      *Blanks       TRLFLG
075100070312     C                   MOVE      'N'           DTRFLG
075200070312     C                   MOVE      *ZEROS        HDSEQ#
075300131008     c*******************Eval      hprgnm = 'F500'
075400131008     c                   eval      hprgnm = thispgmname
075500131008     c                   MoveL(p)  @TSUSER       hoper
075600070312     c                   Move      cmtrst        hstrst
075700070312     c                   Move      csubdv        hssub#
075800070312     c                   Move      cmacct        hsacct
075900070312     C                   MOVE      'A'           HSDLTD
076000070312     c                   Eval      trdate = #today
076100131008     c                   eval      hstrtime = %time
076200070312     C                   MOVE      'L25'         TRCODE
076300070312     C                   MOVEL     frsman        CK#NOT
076400070312     C                   MOVEL     trsman        NOTE2
076500070312     c                   Eval      covtdt = pi#dte
076600070312     c                   Write     histr
076700070312    ***
076800070312     c                   EndSR
076900060918   S***S
077000060918     c     $histadd      BegSR
077100060918    ***
077200060918     c                   Clear                   histr
077300060918     c                   Move      cmtrst        hstrst
077400060918     c                   Move      csubdv        hssub#
077500060918     c                   Move      cmacct        hsacct
077600060918     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
077700060918     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
077800060918     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
077900070312     C                   MOVE      *Blanks       TRMFLG
078000070312     C                   MOVE      *Blanks       TRLFLG
078100060918     c                   Eval      dtrflg = 'N'
078200060918     c                   Eval      trcode = 'LAC'
078300060918     c                   Eval      ck#not = 'PLAN# - ' + cmplan +
078400060919     c                             '  SALESMAN - ' + TRSMAN
078500060918     c                   Eval      note2 = 'EFF DATE - ' +
078600060918     c                             %EditC(effdat:'X')
078700131008     c*******************Eval      hprgnm = 'F500'
078800131008     c                   eval      hprgnm = thispgmname
078900131008     c                   MoveL(p)  @TSUSER       hoper
079000060918     c                   Eval      hsdltd = 'A'
079100060918     c                   Eval      trdate = #today
079200131008     c                   eval      hstrtime = %time
079300060920     c                   Eval      covtdt = pi#dte
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
081500131008     c*******************Eval      hprgnm = 'F500'
081600131008     c                   eval      hprgnm = thispgmname
081700131008     c                   MoveL(p)  @TSUSER       hoper
081800060918     c                   Eval      hsdltd = 'A'
081900060918     c                   Eval      trdate = #today
082000131008     c                   eval      hstrtime = %time
082100060920     C                   Move      pi#trm        #8                8 0
082200060920     c                   Eval      covtdt = #8
082300060918     c                   Write     histr
082400070416    ***
082500070416     c                   EndSR
082600081126
082700081126      ******************************************************
082800081126      * write new commission history rec
082900081126      ******************************************************
083000081126     C     #comhst       BEGSR
083100081126
083200081126      * common fields in commission history file
083300081126     c                   clear                   comhstr
083400081126     C                   move      cmtrst        chtrust
083500081126     C                   move      csubdv        chsub
083600081126     C                   move      cmacct        chacc
083700081126     C                   MOVEL     cmplan        chplan
083800081126     c                   move      #today        chtrdat
083900081126     c                   time                    chtrtim
084000081126     C                   MOVEL     @10           chuser
084100110511     C                   MOVEL     'FM501R    '  chpgm
084200081126
084300081126      * after fields
084400081126     c                   move      effdat        chaeff
084500081126     c                   move      cmcan         chacan
084600081126     c                   move      cmrelid       charel
084700081126     c                   move      ccovpp        chapop
084800081126     c                   move      ccovra        chaff
084900081126     c                   move      ccovpc        chapoc
085000081126     c                   move      ccpnc         chapnc
085100081126     c                   move      cccmsp        chacmsp
085200090416     c                   movel     free5         chapri
085300081126
085400081126      * add new rec with after fields only
085500081126     c                   if        comhiscode = 'A'
085600081126     C                   eval      chtrcod = 'LAC'
085700081126     c                   write     comhstr
085800081126     c                   leavesr
085900081126     c                   end
086000081126      * before fields
086100081126     c                   move      effdat        chbeff
086200081126     c                   move      cmcanhold     chbcan
086300081126     c                   move      cmrelid       chbrel
086400081126     c                   move      ccovpp        chbpop
086500081126     c                   move      ccovra        chbff
086600081126     c                   move      ccovpc        chbpoc
086700081126     c                   move      ccpnc         chbpnc
086800081126     c                   move      cccmsp        chbcmsp
086900090416     c                   movel     free5         chbpri
087000081126
087100081126      * set transaction code for delete
087200081126     C                   eval      chtrcod = 'LDC'
087300081126
087400081126      * add rec with before and after fields
087500081126     c                   write     comhstr
087600081126
087700081126     C                   ENDSR
087800070416   S***S
087900070416     c     $step6        BegSR
088000070416    ***
088100070430     c                   Eval      @step = 'LEAVE'
088200070416    ***
088300070416     c                   EndSR
088400060918   S***S
088500060915     c     *Inzsr        BegSR
088600060915    ***
088700060920    *c     *Entry        PList
088800060920    *c                   Parm                    @10              10
088900060919    *c*                  Eval      prm@in = @24
089000131008     C                   CALL      'TIMESTMP'
089100131008     C                   PARM                    @TS40
089200131008     C                   EVAL      P@40 = @TS40
089300131008     C                   MOVE      #TSCYMD       #TODAY
089400060915    ***
089500060915     c                   EndSR
089600060915   S***S
089700060918     oT2000     EADD         OUTF
089800060918     o                       @o             B  2000
089900070223     oT2000A    EADD         OUTFA
090000070223     o                       @oA            B  2000
