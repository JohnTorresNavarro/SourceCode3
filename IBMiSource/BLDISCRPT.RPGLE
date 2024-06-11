000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Build Internal Sales Commission Report file
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 21, 2001
000701070828      *
0007020708280015  * 08/28/07 dlk - change to find market size by transaction
0007030708280015  *                effdt instead of run effdt.
000800000000      *_________________________________________________________________________
000900010221     FISCWRK    ip   e           k Disk
001000010221     FMKTCARA1  if   e           k Disk
001100010221     FAGCAROV1  if   e           k Disk
001200010222     FCARMST    if   e           k Disk    prefix(Z)
001300010222     FAGENCY    if   e           k Disk
001400010222     FACCMST    if   e           k Disk
001500010222     FPLNMST    if   e           k Disk
001600040730     FISCSMN    if   e           k Disk
001700040730     FISCSM2    if   e           k Disk
001800010222     FISCOVR    if   e           k Disk
001900020227     FISCPZC    if   e           k Disk
002000010221     FISCRPT    o  a e           k Disk
002100010221
002200020225     D wgbsdt          s              8  0 inz
002300020225     D wrundt          s              8  0 inz
002400020220     D ValidDates      S              1N   inz(*OFF)
002401070828
002402070828     D                 ds                  inz
002403070828     D winvdt                  1      8  0
002404070828     D cefiyy                  1      4  0
002405070828     D cefimm                  5      6  0
002406070828     D cefidd                  7      8  0
002500020222
002600040730    ?D WIDATA        E DS                  EXTNAME(ISCSM2)
002700020220
002800010221     IISCWRKR       01
002900010222
003000010222      * Load Misc fields values from work file.
003100010222     C                   Exsr      LOADMISC
003200010222
003300010222      * Get Market Size
003400020222     C     KMKT          Setll     MKTCARA1
003500020222     C     KMKT          Reade     MKTCARA1                               50
003600020222     C     *IN50         Doweq     *OFF
003700020222     C                   Select
003800020222     C                   When      mafrdt  = matodt
003900020222      * Skip if deleted. *SKIP*
004000070828     C                   When      winvdt >= mafrdt  and
004100020222     C                             matodt  = *zeros
004200020222     C                   Eval      IRMKSZ = MASZCD
004300070828     C                   When      winvdt >= mafrdt  and
004400070828     C                             winvdt <= matodt
004500020222     C                   Eval      IRMKSZ = MASZCD
004600020222     C                   Other
004700020222     C                   Endsl
004800020222     C     KMKT          Reade     MKTCARA1                               50
004900020222     C                   Enddo
005000020222      *******************************************************************
005100020222      * NOTE - If not found, use default of 50.
005200020222      *******************************************************************
005300020222     C                   If        IRMKSZ = *BLANKS
005400020222     C                   Eval      IRMKSZ = '50   '
005500020222     C                   End
005600010222
005700020226      * Set amt fields....
005800020222     C                   Eval      IRAGOR = *ZEROS
005900020226     C                   Eval      IRPAID = CPAMT
006000020226     C                   Eval      IRCOME = CCOME
006100020226
006200020226      * Get Agency Override
006300020222     C     KAGC          Setll     AGCAROV1
006400020222     C     KAGC          Reade     AGCAROV1                               51
006500020222     C     *IN51         Doweq     *OFF
006600020222     C                   Select
006700020222     C                   When      acefdt  = actrdt
006800020222      * Skip if deleted. *SKIP*
006900020222     C                   When      ceffdt >= acefdt  and
007000020222     C                             actrdt  = *zeros
007100020222     C                   Exsr      CALCAGOR
007200020222     C                   When      ceffdt >= acefdt  and
007300020222     C                             ceffdt <= actrdt
007400020222     C                   Exsr      CALCAGOR
007500020222     C                   Other
007600020222     C                   Endsl
007700020222     C     KAGC          Reade     AGCAROV1                               51
007800020222     C                   Enddo
007900010222
008000010222      * Calculate Income and Payables
008100010221     C                   Exsr      CALCINCOME
008200020220     C                   Exsr      CALCPAYSMAN
008201070618
008202070618      * Set Start Date
008203070618     C                   Eval      IRSTARTD = STARTD
008300010222
008400030708      * Create Report Record (TESTING)
008500030708     C                   If        IRLNAM <> *BLANKS
008600010222     C                   Write     ISCRPTR
008700030708     C                   End
008800010222     C                   Clear                   ISCRPTR
008900010221
009000010221      *--------------------------------------------------------------*
009100010221      * Calculate Agency Override Result                             *
009200010221      *--------------------------------------------------------------*
009300010221     C     CALCAGOR      BEGSR
009400010221     C                   Select
009500010221      * % Premium
009600010221     C                   When      ACOVPP <> *zeros
009700010222     C     ACOVPP        Div       100           IRPERP
009800010223     C     IRPERP        Mult      IRPAID        IRAGOR
009900010221      * Flat Fee
010000010221     C                   When      ACOVRA <> *zeros
010100040917     C                   Eval      IRFLAT = ACOVRA
010200040917     C                   Eval      IRAGOR = ACOVRA
010300010221      * % Commission
010400010221     C                   When      ACOVPC <> *zeros
010500010222     C     ACOVPC        Div       100           IRPERC
010600010222     C     IRPERC        Mult      IRCOME        IRAGOR
010700010221      * Other
010800010221     C                   Other
010900010221     C                   EVAL      IRAGOR = *ZEROS
011000010221     C                   Endsl
011100010221     C                   ENDSR
011200010221      *--------------------------------------------------------------*
011300010221      * Calculate Income                                             *
011400010221      *--------------------------------------------------------------*
011500010222     C     CALCINCOME    BEGSR
011600010222     C                   Eval      IRADME = CADME
011700010222     C                   Eval      IRBOND = CBOND
011800010221     C     KCAR          Chain     CARMST
011900010221     C                   If        %Found
012000010226     C                   Eval      IRCARD = zCNAME
012100010221     C                   Select
012200010222     C                   When      ZCOMSCH = '1'
012300010221     C                   Exsr      SCHEDULE1
012400010222     C                   When      ZCOMSCH = '2'
012500010221     C                   Exsr      SCHEDULE2
012600010221     C                   Other
012700010221     C                   Endsl
012800020227     C                   If        IRINCR = *Zeros
012900020227     C     KCAR          Chain     ISCPZC
013000020227     C                   If        %Found
013100020227     C                   Select
013200020227     C                   When      IZPPRM <> 0
013300020227     C                   Eval      IRINCR = IZPPRM * CPAMT
013400020228     C     IRINCR        Div       100           IRINCR
013500020227     C                   Z-add     IZPPRM        IRPERP
013600020227     C                   When      IZPCPM <> 0
013700020227     C                   Eval      IRINCR = IZPCPM * CLIVES
013800020228     C     IRINCR        Div       100           IRINCR
013900040917     C                   Eval      IRFLAT = IZPCPM
014000020227     C                   Endsl
014100020227     C                   End
014200020227     C                   End
014300020227     C                   End
014400010221     C                   ENDSR
014500010221      *--------------------------------------------------------------*
014600010221      * Calculate Income for Schedule 1.                             *
014700010221      *--------------------------------------------------------------*
014800010221     C     SCHEDULE1     BEGSR
014900020220      *
015000020226     C                   Eval      IRINCR = (IRADME + IRBOND) - IRAGOR
015100020226      *
015200010221     C                   ENDSR
015300010221      *--------------------------------------------------------------*
015400010221      * Calculate Income for Schedule 2.                             *
015500010221      *--------------------------------------------------------------*
015600010221     C     SCHEDULE2     BEGSR
015700020220      *
015800020226     C                   Eval      IRINCR = IRADME - IRAGOR
015900020220      *
016000020220     C*******************Eval      IRM91P = 0.91
016100020220     C*******************Eval      IRM89P = 0.89
016200020220     C*******************Select
016300020220     C*******************When      IRMKSZ = '50   '
016400020220     C*******************Eval      IRINCR = IRADME + (IRBOND * IRM91P) - IRAGOR
016500020220     C*******************Other
016600020220     C*******************Eval      IRINCR = IRADME + (IRBOND * IRM89P) - IRAGOR
016700020220     C*******************Endsl
016800010221     C                   ENDSR
016900010222      *--------------------------------------------------------------*
017000020220      * Calculate Payables - Salesman                              *
017100010222      *--------------------------------------------------------------*
017200020220     C     CALCPAYSMAN   BEGSR
017300020220     C                   Eval      ValidDates = *Off
017400040730     C     IASMAN        Chain     ISCSMN
017500010222     C                   Eval      IRSMAN = IASMAN
017600040730     C     KSMN          Setll     ISCSM2
017700040730     C     KSMN          Reade     ISCSM2                                 77
017800020220     C                   Dow       *in77 = *off
017900020220     C                   Select
018000020220     C                   When      ISEFDT <> *Zeros and
018100020220     C                             ISTRDT <> *Zeros
018200040730     C                   If        (Wgbsdt >= ISEFDT and
018300040805     C                              Wgbsdt <= ISTRDT and
018400040730     C                             ISRUNO = 'Y')
018500020220     C                   Exsr      CHKSMANOVR
018600020220     C                   Exsr      CALCPAYMGR
018700020220     C                   Leavesr
018800020220     C                   End
018900020220     C                   When      ISEFDT <> *Zeros and
019000020220     C                             ISTRDT =  *Zeros
019100030708     C                   If        Wgbsdt >= ISEFDT
019200020220     C                   Exsr      CHKSMANOVR
019300020220     C                   Exsr      CALCPAYMGR
019400020220     C                   Leavesr
019500020220     C                   End
019600020220     C                   Other
019700020220     C                   Eval      IRLNAM = *Blanks
019800020220     C                   Eval      IRPISA = *Zeros
019900020220     C                   Eval      IRINSP = *Zeros
020000020220     C                   Eval      IRLMGR = *Blanks
020100020220     C                   Eval      IRPIMG = *Zeros
020200020220     C                   Eval      IRINMP = *Zeros
020300020220     C                   Endsl
020400040730     C     KSMN          Reade     ISCSM2                                 77
020500020220     C                   Enddo
020600010222     C                   ENDSR
020700020220      *--------------------------------------------------------------*
020800020220      * Calculate Payables - Manager                                 *
020900020220      *--------------------------------------------------------------*
021000020220     C     CALCPAYMGR    BEGSR
021100020220     C                   Eval      ValidDates = *Off
021200020222      *
021300020222      * Check Invoice Date against Salesman file.
021400020222     C                   Call      'CHKISCMGR'
021500090122     C                   Parm      IRSMGR        WISMAN           10
021600020225     C                   Parm      WGBSDT        WIDATE            8 0
021700020222     C                   Parm                    WIDATA
021800020222     C                   Parm      *BLANKS       WIRTN             1
021900020222      *
022000020225      * Check Run Date against Salesman file.
022100020222     C                   If        WIRTN    =   'Y'
022200020222     C                   Call      'CHKISCMGR'
022300020222     C                   Parm      IRSMGR        WISMAN
022400020225     C                   Parm      WRUNDT        WIDATE
022500020222     C                   Parm                    WIDATA
022600020222     C                   Parm      *BLANKS       WIRTN
022700020222     C                   End
022800020222      *
022900020222      * If Inv. Date and GBS Date are both found in range.
023000020222     C                   If        WIRTN    =   'Y'
023100020220     C                   Exsr      CHKSMGROVR
023200020225     C     IRSMGR        Chain     ISCSMN
023300020225     C                   If        %Found
023400020225     C                   Eval      IRLMGR = ISLNAM
023500020225     C                   Else
023600020225     C                   Eval      IRLMGR = *Blanks
023700020225     C                   End
023800020225     C                   End
023900020222      *
024000020220     C                   ENDSR
024100010223      *--------------------------------------------------------------*
024200010223      * Check Salesman Override                                      *
024300010223      *--------------------------------------------------------------*
024400010223     C     CHKSMANOVR    BEGSR
024500020220     C                   Eval      IRLNAM = %trim(ISLNAM) + ', ' +
024600020220     C                             %trim(ISFNAM)
024700020220     C                   Eval      IRSMGR = ISSMGR
024800010223     C     KOVR          Chain     ISCOVR
024900010223     C                   If        %Found      and
025000010518     C                             IOTRDT  =   *Zeros and
025100010518     C                             IREFDT  >=  IOEFDT or
025200010223     C                             %Found      and
025300010518     C                             IREFDT  >=  IOEFDT and
025400010518     C                             IREFDT  <=  IOTRDT
025500010223     C                   Select
025600010223     C                   When      IOPREP <> 0
025700010223     C     IOPREP        Div       100           IRPISA
025800010223     C                   Eval      IRINSP = IRINCR * IRPISA
025900010223     C                   When      IOFLAT <> 0
026000010223     C                   Eval      IRPISA = *Zeros
026100040917     C                   Eval      IRINSP = IOFLAT
026200010223     C                   When      IOCOMP <> 0
026300010223     C     IOCOMP        Div       100           IRPISA
026400010223     C                   Eval      IRINSP = IRINCR * IRPISA
026500010223     C                   When      IOPOIN <> 0
026600010223     C     IOPOIN        Div       100           IRPISA
026700010223     C                   Eval      IRINSP = IRINCR * IRPISA
026800010223     C                   Endsl
026900010223     C                   Else
027000030224     C                   Eval      ValidDates = *On
027100020220     C                   If        ValidDates = *On
027200030224     C     ISRATE        Div       100           IRPISA
027300010223     C                   Eval      IRINSP = IRINCR * IRPISA
027400010223     C                   Else
027500010223     C                   Eval      IRLNAM = *Blanks
027600010223     C                   Eval      IRPISA = *Zeros
027700010223     C                   Eval      IRINSP = *Zeros
027800010223     C                   End
027900010223     C                   End
028000010223     C                   ENDSR
028100010223      *--------------------------------------------------------------*
028200010223      * Check Manager Override                                       *
028300010223      *--------------------------------------------------------------*
028400031110      * Only check for manager override if salesman was overridden
028500031110      * otherwise just pay the manager.
028600031110      *
028700010223     C     CHKSMGROVR    BEGSR
028800031110     C                   If        IRSOVF = 'Y'
028900031110     C     KOVRM         Chain     ISCOVR
029000010518     C                   If        %Found      and
029100010518     C                             IOTRDT  =   *Zeros and
029200010518     C                             IREFDT  >=  IOEFDT or
029300010518     C                             %Found      and
029400010518     C                             IREFDT  >=  IOEFDT and
029500010518     C                             IREFDT  <=  IOTRDT
029600010223     C                   Select
029700010223     C                   When      IOPREP <> 0
029800010223     C     IOPREP        Div       100           IRPIMG
029900010223     C                   Eval      IRINMP = IRINCR * IRPIMG
030000010223     C                   When      IOFLAT <> 0
030100010223     C                   Eval      IRPIMG = *Zeros
030200040917     C                   Eval      IRINMP = IOFLAT
030300010223     C                   When      IOCOMP <> 0
030400010223     C     IOCOMP        Div       100           IRPIMG
030500010223     C                   Eval      IRINMP = IRINCR * IRPIMG
030600010223     C                   When      IOPOIN <> 0
030700010223     C     IOPOIN        Div       100           IRPIMG
030800010223     C                   Eval      IRINMP = IRINCR * IRPIMG
030900010223     C                   Endsl
031000031110     C                   End
031100010223     C                   Else
031200031110      * otherwise just pay the manager.
031300030224     C                   Eval      ValidDates = *On
031400020220     C                   If        ValidDates = *On
031500030224     C     ISRATE        Div       100           IRPIMG
031600010223     C                   Eval      IRINMP = IRINCR * IRPIMG
031700010223     C                   Else
031800010223     C                   Eval      IRLMGR = *Blanks
031900010223     C                   Eval      IRPIMG = *Zeros
032000010223     C                   Eval      IRINMP = *Zeros
032100010223     C                   End
032200010223     C                   End
032300010223     C                   ENDSR
032400010222      *--------------------------------------------------------------*
032500010222      * Load Misc field values from work file                        *
032600010222      *--------------------------------------------------------------*
032700010222     C     LOADMISC      BEGSR
032800010222     C                   Eval      IREFDT = CEFFDT
032900010222     C                   Eval      IREIYY = CEFIYY
033000010222     C                   Eval      IREIMM = CEFIMM
033100010222     C                   Eval      IREIDD = CEFIDD
033200010222     C                   Eval      IRAGNY = IAAGNY
033300010222     C                   Eval      IRCARR = CCARCD
033400010222     C                   Eval      IRTRST = CTRUST
033500010222     C                   Eval      IRSUB# = CSUB
033600010222     C                   Eval      IRACCT = CACCT
033700010222     C                   Eval      IRPLAN = CPLAN
033800010222     C                   Eval      IRGRP# = CGROUP
033900010222     C                   Eval      IRSOVF = SOVFLG
034000010222     C                   Eval      IRPCAT = PLNCAT
034100010226     C                   Eval      IR#CNT = CLIVES
034200010222     C     KACC          Chain     ACCMST
034300010222     C                   If        %Found
034400010222     C                   Eval      IRTSAD = ACNAM1
034500020225     C                   z-add     ceffdt        wrundt
034600040806     C                   If        gbsgad  <>    *Zeros
034700040806     C                   If        gbsbdt <      gbsgad
034800020225     C                   z-add     gbsbdt        wgbsdt
034900030401     C                   Else
035000030401     C                   z-add     gbsgad        wgbsdt
035100030401     C                   End
035200040806     C                   Else
035300040806     C                   z-add     gbsbdt        wgbsdt
035400040806     C                   End
035500020220     C                   Else
035600020220     C                   Eval      IRTSAD = *Blanks
035700020225     C                   z-add     0             wrundt
035800020225     C                   z-add     0             wgbsdt
035900010222     C                   End
036000010222     C     IRAGNY        Chain     AGENCY
036100010222     C                   If        %Found
036200010222     C                   Eval      IRAGYD = AGNAM1
036300010222     C                   End
036400010222     C     KPLN          Chain     PLNMST
036500010222     C                   If        %Found
036600010222     C                   Eval      IRPLND = PDESCR
036700010222     C                   End
036800010222     C                   ENDSR
036900010221      *--------------------------------------------------------------*
037000010221      * Key List Definitions                                         *
037100010221      *--------------------------------------------------------------*
037200010221     C     KLIST         BEGSR
037300010221     C     KMKT          KLIST
037400010222     C                   KFLD                    IRTRST
037500010222     C                   KFLD                    IRSUB#
037600010222     C                   KFLD                    IRACCT
037700010222     C                   KFLD                    IRCARR
037800010221     C     KAGC          KLIST
037900010222     C                   KFLD                    IRAGNY
038000010222     C                   KFLD                    IRCARR
038100010222     C                   KFLD                    IRMKSZ
038200010221     C     KCAR          KLIST
038300010222     C                   KFLD                    IRCARR
038400010222     C     KACC          KLIST
038500010222     C                   KFLD                    IRTRST
038600010222     C                   KFLD                    IRSUB#
038700010222     C                   KFLD                    IRACCT
038800010222     C     KPLN          KLIST
038900010222     C                   KFLD                    IRTRST
039000010222     C                   KFLD                    IRSUB#
039100010222     C                   KFLD                    IRPLAN
039200010222     C     KOVR          KLIST
039300010222     C                   KFLD                    IRTRST
039400010222     C                   KFLD                    IRSUB#
039500010222     C                   KFLD                    IRACCT
039600010222     C                   KFLD                    IRPLAN
039700030603     C                   KFLD                    IRSMAN
039800031110     C     KOVRM         KLIST
039900031110     C                   KFLD                    IRTRST
040000031110     C                   KFLD                    IRSUB#
040100031110     C                   KFLD                    IRACCT
040200031110     C                   KFLD                    IRPLAN
040300031110     C                   KFLD                    IRSMGR
040400030225     C     KSMN          KLIST
040500030225     C                   KFLD                    IRSMAN
040600040730     C****************** KFLD                    ISLHFL
040700010221     C                   ENDSR
