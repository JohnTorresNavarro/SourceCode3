000100131004   X***X
000200131004   X***X11/26/08 dlk - add new commission history file
000300131004   X***XFIXED SRLHIST DATA
000400131004   X***X
000500131004   X***X07/15/2011 SSK ADD HISTORIC BEFORE AND AFTER IMAGES
000600131004   X***X
000700131004   X**** 08/28/2013 SSK ADD AC2MST BROKER LOGIC
000800131004   X****   FIELD IS A2CODE1 AND IS THE RENEWAL BROKER
000900131004   X***X
001000131004   X***X 10/04/2013 SSK HIST EXPANSION PROJECT
001100131004   X***X
001200131004   X***X
001300131004   X***X
001400131004   X***X
001500131004   X***X
001600060918     FFM500D    CF   E             WORKSTN INFDS(WSDS)
001700061005     fsmanrlt   Uf   e           k disk
001800070416     faccmst5   if   e           k disk    RENAME(accmsr:lf5) prefix(q)
001900070312     faccmst    uf   e           k disk
002000130828     FAC2MSTL2  UF   E           K DISK
002100060915     faccmstp   if   e           k disk
002200070416     fcmct14    if   e           k disk    rename(comcxr:cm14) prefix(c)
002300060915     fcmctlf    uf a e           k disk
002400060915     fbrkprdl   uf a e           k disk
002500061024     FSRLHIST0  O  A E           K DISK
002600060915     FHIST      O  A E             DISK
002700070413     FSYSMODLOG O  A E             DISK
002800070416     FCMIABLKTR O  A E             DISK
002900070416     FINTGBSLOG O  A E             DISK
003000081126     Fcomhst    O  A E             DISK
003100060915     ft2000     o  a f 2000        disk
003200070223     ft2000A    o  a f 2000        disk
003300060915   X***X
003400081126     D comhiscode      S              1A
003500060918     D WSDS            DS
003600060918     D  FKEY                 369    369A
003700060918    ***       FUNCTION KEYS
003800060918     D  F1             C                   CONST(X'31')
003900060918     D  F2             C                   CONST(X'32')
004000060918     D  F3             C                   CONST(X'33')
004100060918     D  F4             C                   CONST(X'34')
004200060918     D  F5             C                   CONST(X'35')
004300060918     D  F6             C                   CONST(X'36')
004400060918     D  F7             C                   CONST(X'37')
004500060918     D  F8             C                   CONST(X'38')
004600060918     D  F9             C                   CONST(X'39')
004700060918     D  F10            C                   CONST(X'3A')
004800060918     D  F11            C                   CONST(X'3B')
004900060918     D  F12            C                   CONST(X'3C')
005000060918     D  F13            C                   CONST(X'B1')
005100060918     D  F14            C                   CONST(X'B2')
005200060918     D  F15            C                   CONST(X'B3')
005300060918     D  F16            C                   CONST(X'B4')
005400060918     D  F17            C                   CONST(X'B5')
005500060918     D  F18            C                   CONST(X'B6')
005600060918     D  F19            C                   CONST(X'B7')
005700060918     D  F20            C                   CONST(X'B8')
005800060918     D  F21            C                   CONST(X'B9')
005900060918     D  F22            C                   CONST(X'BA')
006000060918     D  F23            C                   CONST(X'BB')
006100060918     D  F24            C                   CONST(X'BC')
006200060918    ***
006300060915     d                 ds
006400060918     d prm@in                  1     24a
006500060915     d pi@frel                 1      8a
006600060915     d pi@trel                 9     16a
006700060918     d pi#dte                 17     24s 0
006800060915    ***
006900060915     d @range          s             30a
007000070416     d log@          e ds                  extname(sysmodlog) prefix(vv:2)
007100070416     d sys@          e ds                  extname(sysmodlog)
007200070416     d cmia@         e ds                  extname(cmiablktR)
007300070416     d igbs@         e ds                  extname(intgbslog)
007400060915     d brp@          e ds                  extname(brkprdp)
007500060915     d hld@brp       e ds                  extname(brkprdp) prefix(z:1)
007600060915     d pi#iso          s               d   datfmt(*ISO)
007700080813     d #H              s               d   datfmt(*ISO)
007800080813     d #L              s               d   datfmt(*ISO)
007900130828     D SVB@CHG         S              1A
008000060915     d trm8s0          s              8s 0
008100060918     d #today          s              8s 0
008200060919     d #usa            s               d   datfmt(*USA)
008300060918     d #iso            s               d   datfmt(*ISO)
008400060915     d pi#trm          s               d   datfmt(*ISO)
0085001310040037 D sysdateymd      S               d   datfmt(*iso)
008600131004     D thispgmname     S             10a   inz('FM500     ')
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
012800061024     D @TS40           S             40A
012900061024     D @TIMESTAMP      DS
013000061024     D  #TSCYMD                1      8S 0
013100061024     D  #TSTIME                9     14S 0
013200061024     D  @TSJOB                15     24
013300061024     D  @TSUSER               25     34
013400061024     D  #TSNBR                35     40S 0
013500131007     D P@40                    1     40A
013600110805     ***
013700110805     D DS@B4         E DS                  EXTNAME(BRKPRDP) PREFIX(B4:2)
013800110805     D  B4@IMG                 1    125A
013900110805      *
014000110805     D DS@AF         E DS                  EXTNAME(BRKPRDP) PREFIX(AF:2)
014100110805     D  AF@IMG                 1    125A
014200110805      *
014300110805     D @291            S            291A
014400110805     ***
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
031500060919    ***
031600130828     C                   IF        FRAGCY <> TRAGCY
031700130828     C                   EVAL      SVB@CHG = 'Y'
031800130828     C                   ELSE
031900130828     C                   EVAL      SVB@CHG = 'N'
032000130828     C                   ENDIF
032100130828    ***
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
046400070404     c                   LeaveSR
046500070404     c                   EndIf
046600070312    ***
046700070312     c     bpacct        Chain     accmstr
046800060915    ***
046900060915     c                   If        bptrdt <> D'9999-12-31'
047000070312    * *
047100070312     c                   If        bptrdt > pi#iso and bpefdt < pi#iso
047200070312     c                   If        adimd = 'Y'
047300070802     c                   Eval      @o = '"Have Pam manually fix this record f'
047400070312     c                             + 'or account:' + %Trim(adname) + '",'
047500070312     c                   Else
047600070312     c                   Eval      @o = '"Have Ev manually fix this record f'
047700070312     c                             + 'or account:' + %Trim(adname) + '",'
047800070312     c                   EndIf
047900070312     c                   Except    outf
048000070312     c                   EndIf
048100070312    * *
048200061005     c                   LeaveSR
048300060915     c                   EndIf
048400061208    ***
048500080521    *c*                  If        bpsplit <> 0.0000
048600080521    ***
048700080521    *c*                  If        adimd = 'Y'
048800080521    *c*                  Eval      @oA = '"Split Broker Product, skipped, '
048900080521    *c*                            + 'tell Pam.' + %Trim(adname) + '",'
049000080521    *c*                  Else
049100080521    *c*                  Eval      @oA = '"Split Broker Product, skipped, '
049200080521    *c*                            + 'tell Ev.' + %Trim(adname) + '",'
049300080521    *c*                  EndIf
049400080521    ***
049500080521    *c*                  Except    outfa
049600080521    *c*                  LeaveSR
049700080521    ***
049800080521    *c*                  EndIf
049900070223    ***
050000060915     c                   Add       1             #cnt
050100060915     c                   Eval      hld@brp = brp@
050200110805     C                   EVAL      DS@B4 = BRP@
050300110805     C                   CALL      'TIMESTMP'
050400110805     C                   PARM                    @TS40
050500110805     C                   EVAL      P@40 = @TS40
050600060915    ***
050700060920     c                   If        bpefdt >= pi#iso or bpefdt = D'0001-01-01'
050800060915    * *
050900060915     c                   Eval      bptrdt = bpefdt
051000110805     C                   EVAL      DS@AF = BRP@
051100060915     c                   Update    brkprdr
051200110805     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
051300110805     C                   CALL      'GAC592'
051400110805     C                   PARM                    @291
051500060915     c                   Eval      brp@ = hld@brp
051600060915     c                   Eval      bprelid = pi@trel
051700060915     c                   Eval      bpsman = t@sman
051800060915     c                   Eval      bpagcy = t@agcy
051900060915     c                   Eval      bpsuper = t@super
052000060915     c                   Write     brkprdr
052100110805     C                   CLEAR                   DS@B4
052200110805     C                   EVAL      DS@AF = BRP@
052300110805     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
052400110805     C                   CALL      'GAC592'
052500110805     C                   PARM                    @291
052600060915    * *
052700060915     c                   Else
052800060915    * *
052900060915     c                   Eval      bptrdt = pi#trm
053000110805     C                   EVAL      DS@AF = BRP@
053100060915     c                   Update    brkprdr
053200110805     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
053300110805     C                   CALL      'GAC592'
053400110805     C                   PARM                    @291
053500060915     c                   Eval      brp@ = hld@brp
053600060915     c                   Eval      bprelid = pi@trel
053700060915     c                   Eval      bpsman = t@sman
053800060915     c                   Eval      bpagcy = t@agcy
053900060915     c                   Eval      bpsuper = t@super
054000060915     c                   Eval      bpefdt = pi#iso
054100060915     c                   Write     brkprdr
054200110805     C                   CLEAR                   DS@B4
054300110805     C                   EVAL      DS@AF = BRP@
054400110805     C                   EVAL      @291 = B4@IMG + AF@IMG + P@40 + '*'
054500110805     C                   CALL      'GAC592'
054600110805     C                   PARM                    @291
054700060915    * *
054800060915     c                   EndIf
054900060915    ***
055000060915     c     *USA          Move      zpefdt        #f                8 0
055100060915     c     *USA          Move      zptrdt        #t                8 0
055200060915     c                   Eval      @range = %EditC(#f:'Y') + '-' +
055300060915     c                                      %EditC(#t:'Y')
055400060915    * *
055500060915     c                   Eval      @o = '"' + bpacct + '","' + %Trim(adname)   +
055600060915     c                             '","' + %Trim(@range) + '"'
055700060915     c                   Except    outf
055800070430    ***
055900070430     c                   EndSR
056000070430   S***S
056100070430     c     $prep4        BegSR
056200070430    ***
056300070430     c                   If        #cnt = 0
056400070430     c                   Eval      @o = '"No Active Non-administered Business",'
056500070430     c                   Except    outf
056600070430     c                   EndIf
056700070430    ***
056800070430     c                   Eval      @step = 'STEP4'
056900060915    ***
057000060915     c                   EndSR
057100060915   S***S
057200060915     c     $step4        BegSR
057300060915    ***
057400060915     c     pi@frel       Chain(n)  comcxr
057500060915     c                   If        Not %Found(cmctlf)
057600060915     c                   Eval      @o = '"No Administered Business",'
057700060915     c                   Except    outf
057800070430     c                   Eval      @step = 'STEP6'
057900070312     c                   ExSR      $smrchg
058000060915     c                   LeaveSR
058100060915     c                   EndIf
058200060915    ***
058300060915     c     pi@frel       SetLL     comcxr
058400060915    ***
058500061005     c                   Move      *Zeros        #cnt              9 0
058600070430     c                   Eval      @step = 'STEP5'
058700061005    ***
058800061005     c                   EndSR
058900061005   S***S
059000061005     c     $smrchg       BegSR
059100061024    ***
059200061024     C                   CLEAR                   RSRLHIST
059300100318     C                   EVAL      HRELID = SRRELID
059400061005    ***
059500061005     c     FRMREL        Chain     srf
059600100318     C                   EVAL      HBEFORE = REC@DS
059700061005     c                   Eval      srtrmdte = trm8s0
059800100318     C                   EVAL      HAFTER = REC@DS
059900061005     c                   Update    srf
060000061024    ***
060100061024    *C                   MOVE      *BLANKS       @TS40
060200060915    ***
060300061024    *C                   CALL      'TIMESTMP'
060400061024    *C                   PARM                    @TS40
060500061024    *C                   MOVEL     @TS40         @TIMESTAMP
060600061024    *C                   EVAL      HJOB = @TSJOB
060700061024    *C                   EVAL      HUSERID = @TSUSER
060800061024    *C                   MOVE      #TSNBR        HNUMBER
060900061024    *C                   MOVE      #TSCYMD       HDATE
061000061024    *C                   MOVE      #TSTIME       HTIME
061100061024    ***
061200061024     C                   WRITE     RSRLHIST
061300061024    ***
061400060915     c                   EndSR
061500060915   S***S
061600060915     c     $step5        BegSR
061700060915    ***
061800060915     c     pi@frel       ReadE     comcxr
061900060915    ***
062000060915     c                   If        %EOF(cmctlf)
062100070430     c                   Eval      @step = 'STEP6'
062200060915     c                   If        #cnt = 0
062300060915     c                   Eval      @o = '"No Active Administered Business",'
062400060915     c                   Except    outf
062500060915     c                   EndIf
062600061005     c                   ExSR      $smrchg
062700060915     c                   LeaveSR
062800060915     c                   EndIf
062900070404    ***
063000070404     c                   If        cmcan =  effdat
063100070404     c                   LeaveSR
063200070404     c                   EndIf
063300070312    ***
063400070312     c     kl#           KList
063500070312     c                   KFld                    cmtrst
063600070312     c                   KFld                    csubdv
063700070312     c                   KFld                    cmacct
063800070312     c     kl#           Chain     accmsr
063900070312    ***
064000070419     c                   If        atrmdt <> 0
064100070419     c                   LeaveSR
064200070419     c                   EndIf
064300070419    ***
064400130828     C     KL#           CHAIN     ACCMSR2
064500130828     C                   IF        %FOUND(AC2MSTL2)
064600130828     C                             AND SVB@CHG = 'Y'
064700130828     C                   EVAL      A2CODE1 = TRSMAN
064800130828     C                   UPDATE    ACCMSR2
064900130828     C                   ENDIF
065000130828    ***
065100070312     c                   Move      *Blanks       @50              50
065200070312     c                   Eval      @50 = %EditC(cmtrst:'X') + '-' +
065300070312     c                             %EditC(csubdv:'X') + '-' +
065400070417     c                             %EditC(cmacct:'X') + '-' + cmplan
065500060915    ***
065600060915     c                   If        cmcan <> 0
065700070312    * *
065800070312     c                   If        cmcan > pi#dte and effdat < pi#dte
065900070802     c                   Eval      @oA =
066000070802     c                                  '"This Commission Control must be ma' +
066100070312     c                             'nually changed: ' + %Trim(acnam1) +
066200070312     c                             ' ' + %Trim(@50) + '; Acc Bkr:' + smancd +'"'
066300070802     c                   Except    outfA
066400070312     c                   EndIf
066500070312    * *
066600060915     c                   LeaveSR
066700060915     c                   EndIf
066800061208    ***
066900080521    *c*                  If        cccmsp <> 0.0000
067000080521    *c*                  Eval      @oA =
067100080521    *c*                                 '"Split Commission Control record, sk' +
067200080521    *c*                            'ipping this one for : ' + %Trim(acnam1) +
067300080521    *c*                            ' ' + %Trim(@50) + '"'
067400080521    *c*                  Except    outfa
067500080521    *c*                  LeaveSR
067600080521    *c*                  EndIf
067700080521    ***
067800060915     c                   Add       1             #cnt
067900060915     c                   Eval      hld@cmx = cmx@
068000060915    ***
068100060915     c                   If        effdat >= pi#dte
068200060915    * *
068300081126     c                   move      cmcan         cmcanhold         8 0
068400060915     c                   Eval      cmcan = effdat
068500060915     c                   Eval      cmdltd = 'C'
068600060918     c                   ExSR      $histcnl
068700060915     c                   Update    comcxr
068800081126      * write new com hist
068900081126     c                   move      'D'           comhiscode
069000081126     C                   EXSR      #comhst
069100081126     c                   clear                   comhiscode
069200081126
069300060915     c                   Eval      cmx@ = hld@cmx
069400060915     c                   Eval      cmrelid = pi@trel
069500060919     c                   Eval      slsman = TRsman
069600060915     c                   Eval      cmdltd = 'A'
069700060918     c                   ExSR      $histadd
069800060915     c                   Write     comcxr
069900081126      * write new com hist
070000081126     c                   move      'A'           comhiscode
070100081126     c                   exsr      #comhst
070200081126     c                   clear                   comhiscode
070300081126
070400060915    * *
070500060915     c                   Else
070600060915    * *
070700081126     c                   move      cmcan         cmcanhold         8 0
070800060915     c                   Eval      cmcan = trm8s0
070900060915     c                   Eval      cmdltd = 'C'
071000060918     c                   ExSR      $histcnl
071100060915     c                   Update    comcxr
071200081126      * write new com hist
071300081126     c                   move      'D'           comhiscode
071400081126     c                   exsr      #comhst
071500081126     c                   clear                   comhiscode
071600081126
071700060915     c                   Eval      cmx@ = hld@cmx
071800060915     c                   Eval      cmrelid = pi@trel
071900060919     c                   Eval      slsman = TRsman
072000060915     c                   Eval      effdat = pi#dte
072100060915     c                   Eval      cmdltd = 'A'
072200060918     c                   ExSR      $histadd
072300060915     c                   Write     comcxr
072400081126      * write new com hist
072500081126     c                   move      'A'           comhiscode
072600081126     c                   exsr      #comhst
072700081126     c                   clear                   comhiscode
072800060915    * *
072900060915     c                   EndIf
073000060918    ***
073100070802     c                   If        smancd <> frsman And smancd <> trsman
073200070802     c                   Eval      @oA = '"Different BOR for plans of this ac' +
073300070802     c                             'count: ' + %Trim(acnam1) +
073400070802     c                             ' ' + %Trim(@50) + '; Acc Bkr:' + smancd +'"'
073500070802     c                   If        @oA <> pmsg
073600070802     c                   Eval      pmsg = %Trim(@oA)
073700070802     c                   Except    outfa
073800070802     c                   EndIf
073900070802     c*******************LeaveSR
074000070802     c                   EndIf
074100070802    ***
074200070802     c                   If        smancd = frsman AND smancd <> trsman
074300070802     c                   Eval      smancd = TRsman
074400070802     c                   ExSR      $hist_acc
074500070802     c                   Update    accmsr
074600070802     c                   EndIf
074700070802    ***
074800060920     c                   Move      yffdat        #iso
074900060920     c     *USA          Move      #iso          #f                8 0
075000060920    * *
075100060920     c                   If        ymcan = 0
075200060920     c                   Eval      #t = 0
075300060920     c                   Else
075400060920     c                   Move      ymcan         #iso
075500060920     c     *USA          Move      #iso          #t                8 0
075600060920     c                   EndIf
075700060920    ***
075800060915     c                   Eval      @range = %EditC(#f:'Y') + '-' +
075900060915     c                                      %EditC(#t:'Y')
076000060920    ***
076100060915     c                   Eval      @o = '"' + %Trim(@50) + '","' + %Trim(acnam1)
076200060915     c                             + '","' + %Trim(@range) + '"'
076300060915     c                   Except    outf
076400060918    ***
076500060918     c                   EndSR
076600070312   S***S
076700070312     c     $hist_acc     BegSR
076800070312    ***
076900070312     C                   CLEAR                   HISTR
077000070312     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
077100070312     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
077200070312     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
077300070312     C                   MOVE      *Blanks       TRMFLG
077400070312     C                   MOVE      *Blanks       TRLFLG
077500070312     C                   MOVE      'N'           DTRFLG
077600070312     C                   MOVE      *ZEROS        HDSEQ#
077700131004     c*******************Eval      hprgnm = 'F500'
077800131004     c                   eval      hprgnm = thispgmname
077900131004     c                   MoveL(p)  @TSUSER       hoper
078000070312     c                   Move      cmtrst        hstrst
078100070312     c                   Move      csubdv        hssub#
078200070312     c                   Move      cmacct        hsacct
078300070312     C                   MOVE      'A'           HSDLTD
078400070312     c                   Eval      trdate = #today
078500131004     c                   eval      hstrtime = %time
078600070312     C                   MOVE      'L25'         TRCODE
078700070312     C                   MOVEL     frsman        CK#NOT
078800070312     C                   MOVEL     trsman        NOTE2
078900070312     c                   Eval      covtdt = pi#dte
079000070312     c                   Write     histr
079100070312    ***
079200070312     c                   EndSR
079300060918   S***S
079400060918     c     $histadd      BegSR
079500060918    ***
079600060918     c                   Clear                   histr
079700060918     c                   Move      cmtrst        hstrst
079800060918     c                   Move      csubdv        hssub#
079900060918     c                   Move      cmacct        hsacct
080000060918     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
080100060918     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
080200060918     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
080300070312     C                   MOVE      *Blanks       TRMFLG
080400070312     C                   MOVE      *Blanks       TRLFLG
080500060918     c                   Eval      dtrflg = 'N'
080600060918     c                   Eval      trcode = 'LAC'
080700060918     c                   Eval      ck#not = 'PLAN# - ' + cmplan +
080800060919     c                             '  SALESMAN - ' + TRSMAN
080900060918     c                   Eval      note2 = 'EFF DATE - ' +
081000060918     c                             %EditC(effdat:'X')
081100131004     c*******************Eval      hprgnm = 'F500'
081200131004     c                   eval      hprgnm = thispgmname
081300131004     c                   MoveL(p)  @TSUSER       hoper
081400060918     c                   Eval      hsdltd = 'A'
081500060918     c                   Eval      trdate = #today
081600131004     c                   eval      hstrtime = %time
081700060920     c                   Eval      covtdt = pi#dte
081800060918     c                   Write     histr
081900060915    ***
082000060915     c                   EndSR
082100060915   S***S
082200060918     c     $histcnl      BegSR
082300060918    ***
082400060918     c                   Clear                   histr
082500060918     c                   Move      cmtrst        hstrst
082600060918     c                   Move      csubdv        hssub#
082700060918     c                   Move      cmacct        hsacct
082800060918     c                   Eval      %SubSt(hkey:1:3) = %EditC(cmtrst:'X')
082900060918     c                   Eval      %SubSt(hkey:4:3) = %EditC(csubdv:'X')
083000060918     c                   Eval      %SubSt(hkey:7:4) = %EditC(cmacct:'X')
083100060918     c                   Eval      trmflg = 'X'
083200060918     c                   Eval      trlflg = 'X'
083300060918     c                   Eval      dtrflg = 'N'
083400060918     c                   Eval      trcode = 'LDC'
083500060918     c                   Eval      ck#not = 'PLAN# - ' + cmplan +
083600060919     c                             '  SALESMAN - ' + FRSMAN
083700060918     c                   Eval      note2 = 'EFF DATE - ' +
083800060918     c                             %EditC(effdat:'X')
083900131004     c*******************Eval      hprgnm = 'F500'
084000131004     c                   eval      hprgnm = thispgmname
084100131004     c                   MoveL(p)  @TSUSER       hoper
084200060918     c                   Eval      hsdltd = 'A'
084300060918     c                   Eval      trdate = #today
084400131004     c                   eval      hstrtime = %time
084500060920     C                   Move      pi#trm        #8                8 0
084600060920     c                   Eval      covtdt = #8
084700060918     c                   Write     histr
084800070416    ***
084900070416     c                   EndSR
085000081126
085100081126      ******************************************************
085200081126      * write new commission history rec
085300081126      ******************************************************
085400081126     C     #comhst       BEGSR
085500081126
085600081126      * common fields in commission history file
085700081126     c                   clear                   comhstr
085800081126     C                   move      cmtrst        chtrust
085900081126     C                   move      csubdv        chsub
086000081126     C                   move      cmacct        chacc
086100081126     C                   MOVEL     cmplan        chplan
086200081126     c                   move      #today        chtrdat
086300081126     c                   time                    chtrtim
086400131004     C                   MOVEL     @TSUSER       chuser
086500081126     C                   MOVEL     'FM500R    '  chpgm
086600081126
086700081126      * after fields
086800081126     c                   move      effdat        chaeff
086900081126     c                   move      cmcan         chacan
087000081126     c                   move      cmrelid       charel
087100081126     c                   move      ccovpp        chapop
087200081126     c                   move      ccovra        chaff
087300081126     c                   move      ccovpc        chapoc
087400081126     c                   move      ccpnc         chapnc
087500081126     c                   move      cccmsp        chacmsp
087600090416     c                   movel     free5         chapri
087700081126
087800081126      * add new rec with after fields only
087900081126     c                   if        comhiscode = 'A'
088000081126     C                   eval      chtrcod = 'LAC'
088100081126     c                   write     comhstr
088200081126     c                   leavesr
088300081126     c                   end
088400081126      * before fields
088500081126     c                   move      effdat        chbeff
088600081126     c                   move      cmcanhold     chbcan
088700081126     c                   move      cmrelid       chbrel
088800081126     c                   move      ccovpp        chbpop
088900081126     c                   move      ccovra        chbff
089000081126     c                   move      ccovpc        chbpoc
089100081126     c                   move      ccpnc         chbpnc
089200081126     c                   move      cccmsp        chbcmsp
089300090416     c                   movel     free5         chbpri
089400081126
089500081126      * set transaction code for delete
089600081126     C                   eval      chtrcod = 'LDC'
089700081126
089800081126      * add rec with before and after fields
089900081126     c                   write     comhstr
090000081126
090100081126     C                   ENDSR
090200081126     C*
090300070416   S***S
090400070416     c     $step6        BegSR
090500070416    ***
090600070802    *c*    frsman        Chain     lf5
090700070802    *c*                  If        Not %Found(accmst5)
090800070802    *c*                  Eval      @step = 'LEAVE'
090900070802    *c*                  LeaveSR
091000070802    *c*                  EndIf
091100070802    ***
091200070802    *c*    frsman        SetLL     lf5
091300070802    *c*                  DoU       %EOF(accmst5)
091400070802    *c*    frsman        ReadE     lf5
091500070802    *c*                  If        Not %EOF(accmst5)
091600070802    ***
091700070802    *c*    kl#cm         KList
091800070802    *c*                  KFld                    Qactrst
091900070802    *c*                  KFld                    Qacsub#
092000070802    *c*                  KFld                    Qacacct
092100070802    ***
092200070802    *c*                  ExSR      $loopctx
092300070802    ***
092400070802    *c*                  EndIf
092500070802    *c*                  EndDo
092600070802    ***
092700070430     c                   Eval      @step = 'LEAVE'
092800070416    ***
092900070416     c                   EndSR
093000070416   S***S
093100070802    *c*    $loopctx      BegSR
093200070802    ***
093300070802    *c*    kl#cm         SetLL     cm14
093400070802    *c*                  DoU       %EOF(cmct14)
093500070802    *c*    kl#cm         ReadE     cm14
093600070802    *c*                  If        Not %EOF(cmct14)
093700070802    *****
093800070802    *c*                  Move      *Blanks       @50              50
093900070802    *c*                  Eval      @50 = %EditC(Ccmtrst:'X') + '-' +
094000070802    *c*                            %EditC(Ccsubdv:'X') + '-' +
094100070802    *c*                            %EditC(Ccmacct:'X')
094200070802    *c*                  Eval      @oA = '"**This accounts servicing broker m' +
094300070802    *c*                            'atches, but is not eligible: ' +
094400070802    *c*                            %Trim(Qacnam1) + ' ' + %Trim(@50) +
094500070802    *c*                            '; Acc Bkr:' + Qsmancd +'"'
094600070802    *c*                  If        @oA <> pmsg
094700070802    *c*                  Eval      pmsg = %Trim(@oA)
094800070802    *c*                  Except    outfa
094900070802    *c*                  EndIf
095000070802    *c*                  LeaveSR
095100070802    *****
095200070802    *c*                  EndIf
095300070802    *c*                  EndDo
095400070802    ***
095500070802    *c*                  EndSR
095600060918   S***S
095700060915     c     *Inzsr        BegSR
095800060915    ***
095900060920    *c     *Entry        PList
096000060920    *c                   Parm                    @10              10
096100131004    *********************Eval      prm@in = @24
096200131004     C                   CALL      'TIMESTMP'
096300131004     C                   PARM                    @TS40
096400131004     C                   EVAL      P@40 = @TS40
096500131004     C                   MOVE      #TSCYMD       #TODAY
096600060915    ***
096700060915     c                   EndSR
096800060915   S***S
096900060918     oT2000     EADD         OUTF
097000060918     o                       @o             B  2000
097100070223     oT2000A    EADD         OUTFA
097200070223     o                       @oA            B  2000
