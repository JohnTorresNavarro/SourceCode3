000100000000      *_________________________________________________________________________
000200000000      *
000300000000      *  Description:  Build Internal Sales Commission Work file
000400000000      *
000500000000      *  (c)Copyright 2001 by Innovative Outsourcing, Inc.
000600000000      *
000700000000      *    Created by:  JALLEN - February 20, 2001
000800030401      *_________________________________________________________________________
000900030401      *
001000030401      * 04/01/2003 SSK changed agency chain from SCOCD to CAGCOD, since
001100030401      *                  SCOCD is going away.
0011010708280015  * 08/28/07 dlk - change to find market size by transaction
0011020708280015  *                effdt instead of run effdt.
001200000000      *_________________________________________________________________________
001300010220     FCR130HST  IP   E           K DISK
001400010220     FSMAN      IF   E           K DISK
001500010220     FAGENCY    IF   E           K DISK
001600010327     FACCMST    IF   E           K DISK
001700010220     FISCOVR    IF   E           K DISK
001800010220     FISCAGY    IF   E           K DISK
001900040730     FISCSMN    IF   E           K DISK
002000040730     FISCSM2    IF   E           K DISK
002100050208     FCMCT15    IF   E           K DISK
002200050208     FCODESL1   IF   E           K DISK
002300030224     FPLNMST    IF   E           K DISK
002400030224     FMKTCARA1  IF   E           K DISK
002500010220     FISCWRK    O  A E           K DISK
002600030604
002700080314     D MedCat          s              2    dim(10) ctdata perrcd(1)
002800050208     D mcv             s              2s 0 inz
002900050208     D Grpcd           s              1    inz
003000030224
003100010327     D wdate           s               d   datfmt(*iso) inz
003101070618     D wstart          s              8  0 inz
003102070618     D wcomcd          s              8  0 inz
003200020220     D wsales          s              8  0 inz
003300020220     D wgbsdt          s              8  0 inz
003400010327     D weffdt          s              8  0 inz
003500030604     D ValidDates      S              1N   inz(*OFF)
003600010221
003700010327     D                 ds                  inz
003800010327     D winvdt                  1      8  0
003900010327     D cefiyy                  1      4  0
004000010327     D cefimm                  5      6  0
004100010327     D cefidd                  7      8  0
004200010327
004300010316     D                 ds
004400010316     D debugfld                1     14
004500010316     D ctrust                  1      3  0
004600010316     D csub                    4      6  0
004700010316     D cacct                   7     10  0
004800010316     D cplan                  11     14
004900010522
005000010522     D WdOvr         e ds                  extname(iscovr)
005100010316
005200010220     ICRHSTR        01
005300010220
005400010223     C   01              Do
005500010320
005600010222      * Get Plan Cat - SAVE IT.
005700050208     C                   Eval      Grpcd = *blanks
005800010221     C     KPLN          CHAIN     PLNMST
005900010223     C                   If        %Found
006000010223     C                   Eval      PLANCAT   =   PLNCAT
006100010223     C     *LIKE         Define    PLNCAT        PLANCAT
006200050208     C     PLANCAT       Chain     CODESL1
006300050208     C                   If        %found
006400050208     C                   Eval      Grpcd = ACTION
006500050208     C                   End
006600020222
006700020222      * Get Salesman
006800020222     C     CBCODE        Chain     SMAN
006900020222     C                   If        %Found
007000020220
007100010221      * Get Agency
007200030401     C     CAGCOD        Chain     AGENCY
007300010223     C                   If        %Found
007400010223     C                   Eval      IAAGNY  =   AGCODE
007500010221
007600010223      * Check for Int Sales Comm Overrides
007700020507     C                   Move      *on           *In99
007800020507     C                   Eval      SOVFLG  =   'X'
007900020507     C     KOVR          Setll     ISCOVR
008000020507     C     KOVR          Reade     ISCOVR                                 55
008100020507     C     *IN55         Doweq     *Off
008200010226     C                   If        IOPAYC  =   'N'
008300010226     C                   Move      *off          *In99
008400060509     C                   Else
008500060509     C                   Move      *on           *In99
008600060509     C                   End
008700010223     C                   Select
008800010518     C                   When      CEFFDT  >=  IOEFDT and
008900010518     C                             IOTRDT  =   *ZEROS
009000010223     C                   Eval      SOVFLG  =   'Y'
009100010518     C                   When      CEFFDT  >=  IOEFDT and
009200010518     C                             CEFFDT  <=  IOTRDT
009300010223     C                   Eval      SOVFLG  =   'Y'
009400010223     C                   Other
009500010223     C                   Eval      SOVFLG  =   'N'
009600010223     C                   Endsl
009700020507     C                   Exsr      CheckDuration
009800020521     C     KOVR          Reade     ISCOVR                                 55
009900020507     C                   Enddo
010000020507
010100020507     C                   If        SOVFLG  =   'X'
010200020507     C                   Eval      SOVFLG  =   'N'
010300020507     C                   Clear                   WDOVR
010400020507     C                   Exsr      CheckDuration
010500020507     C                   End
010600010227
010700010223     C                   End
010800010223     C                   End
010900020222     C                   End
011000020507     C                   Clear                   ISCWRKR
011100010223     C                   Enddo
011200010221      *___________________________________________________________________
011300010221      * Check Duration
011400010221      *___________________________________________________________________
011500010223     C     CheckDuration Begsr
011600010221
011700030401      * Get GBS Admin Date + 12 months or
011800030401      *     GBS GA Date + 12 months.
011900010327     C     KCOM          Chain     ACCMST
012000010327     C                   If        %Found
012100020222     C                   z-add     ceffdt        wsales
012200040806     C                   If        gbsgad  <>    0
012300040806     C                   If        gbsbdt   <    gbsgad
012400010327     C     *YMD          Move      gbsbdt        wdate
012401070618     C                   eval      wstart   =    gbsbdt
012500030401     C                   Else
012600030401     C     *YMD          Move      gbsgad        wdate
012601070618     C                   eval      wstart   =    gbsgad
012700040806     C                   End
012800040806     C                   Else
012900040806     C     *YMD          Move      gbsbdt        wdate
013000030401     C                   End
013100010327     C     wdate         adddur    12:*m         wdate
013200010327     C                   move      wdate         wgbsdt
013300010327     C                   Else
013400010327     C                   z-add     0             wgbsdt
013500020220     C                   z-add     0             wsales
013600010327     C                   End
013700010327
013800010302     C                   Move      *off          *In50
013900010221      * Get Oldest Commission Control Record for this TSA.
014000010222     C     KCOM          Setll     CMCT15
014100010222     C     KCOM          Reade     CMCT15                                 50
014200010223     C     *IN50         Doweq     *Off
014300010222     C     KPLNC         Chain     PLNMST
014400050208     C                   If        %found
014500050210      *
014600050210      * Rx exception: Treat Rx like Medical
014700050210     C                   Select
014800050210     C                   When      grpcd = 'R'
014900050210     C     PLNCAT        Chain     CODESL1
015000050210     C                   If        %Found and
015100050210     C                             (action = grpcd and
015200050210     C                             effdat <> cmcan) or
015300050210     C                             (action = 'M'   and
015400050210     C                             effdat <> cmcan)
015401070618     C                   Eval      Weffdt = EffDat
015500070618     C                   Eval      Wcomcd = EffDat
015600050210     C                   Leave
015700050210     C                   End
015800050210     C                   Other
015900050208     C     PLNCAT        Chain     CODESL1
016000050208     C                   If        %Found and action = grpcd and
016100010504     C                             effdat <> cmcan
016200010227     C                   Eval      Weffdt = EffDat
016201070618     C                   Eval      Wcomcd = EffDat
016300010222     C                   Leave
016400050208     C                   End
016500050210     C                   Endsl
016600050210      *
016700010222     C                   End
016800010222     C     KCOM          Reade     CMCT15                                 50
016900010222     C                   Enddo
017000010227     C                   Eval      PLNCAT   =    PLANCAT
017100010227
017200010323      * Find the agency/saleman to pay commissions to.
017300010302     C                   Move      *off          *In50
017400010227     C     IAAGNY        Setll     ISCAGY
017500010227     C     IAAGNY        Reade     ISCAGY                                 50
017600010227     C     *IN50         Doweq     *Off
017700010227     C                   Exsr      CheckDates
017800010227     C                   If        ValidDates
017900010522     C                   If        weffdt < wgbsdt or
018000030220     C                             isbyfl = 'Y'
018100030604     C                   Select
018200030604     C                   When      ISCATG = 'ALL'
018300030604     C                   Exsr      CreateRecord
018400030612     C* If salesman override move on to next agency
018500030612     C                   If        SOVFLG = 'Y'
018600030612     C                   Leave
018700030612     C                   End
018800030604     C                   When      ISCATG = 'MED'
018900030604     C                   Eval      mcv = %lookup(%subst(plncat:2:2):MedCat)
019000030604     C                   If        mcv > 0
019100030604     C                   Exsr      CreateRecord
019200030612     C* If salesman override move on to next agency
019300030612     C                   If        SOVFLG = 'Y'
019400030612     C                   Leave
019500030612     C                   End
019600030604     C                   End
019700030604     C                   When      ISCATG = 'ANC'
019800030604     C                   Eval      mcv = %lookup(%subst(plncat:2:2):MedCat)
019900030604     C                   If        mcv = 0
020000030604     C                   Exsr      CreateRecord
020100030612     C* If salesman override move on to next agency
020200030612     C                   If        SOVFLG = 'Y'
020300030612     C                   Leave
020400030612     C                   End
020500030604     C                   End
020600030604     C                   Endsl
020700030612     C                   End
020800010327     C                   End
020900010227     C     IAAGNY        Reade     ISCAGY                                 50
021000010227     C                   Enddo
021100010223     C                   Endsr
021200010522      *___________________________________________________________________
021300010522      * Create Record
021400010522      *___________________________________________________________________
021500010522     C     CreateRecord  Begsr
021501070618
021502070618      *
021503070618      * If product date is after GBS Admin/GBS GA Dates, then use it.
021504070618     C                   If        Wcomcd > Wstart
021505070618     C                   Eval      STARTD = Wcomcd
021506070618     C                   Else
021507070618     C                   Eval      STARTD = Wstart
021508070618     C                   End
021509070618
021600060504     C                   IF        ISSKIP = 'Y'
021700060504     C   99              Write     ISCWRKR
021800060504     C                   ELSE
021900051110     C     *YMD          Move      EFFDAT        wdate
022000010522     C     wdate         adddur    isderm:*m     wdate
022100010522     C                   move      wdate         weffdt
022200010522     C                   If        weffdt > winvdt
022300010522     C   99              Write     ISCWRKR
022400060504     C                   End
022500060504     C                   End
022600010522     C                   Endsr
022700010227      *___________________________________________________________________
022800010227      * Check Date Between
022900010227      *___________________________________________________________________
023000010227     C     CheckDates    Begsr
023100010516
023200010516      * If Salesman was overriden, then override the saleman.
023300010517     C                   If        SOVFLG =  'Y' and
023400010517     C                             IOSMAN <> *Blanks
023500010516     C                   Eval      IASMAN =  IOSMAN
023600010516     C                   End
023700010516
023800010227     C                   Eval      ValidDates = *Off
023900010227     C                   Select
024000010227     C                   When      IAEFDT <> *Zeros and
024100010227     C                             IATRDT <> *Zeros
024200010312     C                   If        Weffdt >= IAEFDT and
024300010312     C                             Weffdt <= IATRDT
024400020220     C                   Exsr      GetSalesman
024500010227     C                   End
024600010227     C                   When      IAEFDT <> *Zeros and
024700010227     C                             IATRDT =  *Zeros
024800010312     C                   If        Weffdt >= IAEFDT
024900020220     C                   Exsr      GetSalesman
025000010227     C                   End
025100010227     C                   Endsl
025200010227     C                   Endsr
025300020220      *___________________________________________________________________
025400020220      * Salesman
025500020220      *___________________________________________________________________
025600020220     C     GetSalesman   Begsr
025700040730     C     KSMN          Chain     ISCSMN
025800040730     C     KSMN          Setll     ISCSM2
025900040730     C     KSMN          Reade     ISCSM2                                 77
026000020220     C                   Dow       *in77 = *off
026100020220     C                   Select
026200020220     C                   When      ISEFDT <> *Zeros and
026300020220     C                             ISTRDT <> *Zeros
026400040730     C                   If        (Weffdt >= ISEFDT and
026500040730     C                             Weffdt <= ISTRDT) or
026600040730     C                             (Weffdt >= ISEFDT and
026700040805     C                             ISTRDT >= Weffdt  and
026800040805     C                             ISRUNO = 'Y')
026900030220     C                   Exsr      MarketSize
027000030710     C                   Evalr     WWSZCD = %trim(WWSZCD)
027100030710     C                   Evalr     ISSZCD = %trim(ISSZCD)
027200030710     C     ' ':'0'       xlate     WWSZCD        WWSZCD
027300030710     C     ' ':'0'       xlate     ISSZCD        ISSZCD
027400030710     C                   Select
027500030220     C                   When      ISLHFL = 'L' and
027600030710     C                             WWSZCD <= ISSZCD
027700030220     C                   Eval      ValidDates = *On
027800030220     C                   Leavesr
027900030221     C                   When      ISLHFL = 'H' and
028000030604     C                             WWSZCD >  ISSZCD
028100030221     C                   Eval      ValidDates = *On
028200030221     C                   Leavesr
028300030220     C                   Endsl
028400030609     C                   End
028500020220     C                   When      ISEFDT <> *Zeros and
028600020220     C                             ISTRDT =  *Zeros
028700030609     C                   If        Weffdt >= ISEFDT
028800030220     C                   Exsr      MarketSize
028900030710     C                   Evalr     WWSZCD = %trim(WWSZCD)
029000030710     C                   Evalr     ISSZCD = %trim(ISSZCD)
029100030710     C     ' ':'0'       xlate     WWSZCD        WWSZCD
029200030710     C     ' ':'0'       xlate     ISSZCD        ISSZCD
029300030221     C                   Select
029400030221     C                   When      ISLHFL = 'L' and
029500030604     C                             WWSZCD <= ISSZCD
029600030221     C                   Eval      ValidDates = *On
029700030221     C                   Leavesr
029800030221     C                   When      ISLHFL = 'H' and
029900030604     C                             WWSZCD >  ISSZCD
030000030221     C                   Eval      ValidDates = *On
030100030221     C                   Leavesr
030200030221     C                   Endsl
030300030609     C                   End
030400020220     C                   Other
030500020220     C                   Eval      ValidDates = *Off
030600020220     C                   Endsl
030700040730     C     KSMN          Reade     ISCSM2                                 77
030800020220     C                   Enddo
030900020220     C                   Endsr
031000030220      *___________________________________________________________________
031100030220      * Market Size
031200030220      *___________________________________________________________________
031300030220     C     MarketSize    Begsr
031400030220      *
031500030224     C     *Like         Define    MASZCD        WWSZCD
031600030224     C                   Eval      WWSZCD    =   *BLANKS
031700030220      *
031800030220      * Get Market Size
031900030220     C     KMKT          Setll     MKTCARA1
032000030221     C     KMKT          Reade     MKTCARA1                               51
032100030221     C     *IN51         Doweq     *OFF
032200030220     C                   Select
032300030220     C                   When      mafrdt  = matodt
032400030220      * Skip if deleted. *SKIP*
032500070828     C                   When      winvdt >= mafrdt  and
032600030220     C                             matodt  = *zeros
032700030224     C                   Eval      WWSZCD = MASZCD
032800070828     C                   When      winvdt >= mafrdt  and
032900070828     C                             winvdt <= matodt
033000030224     C                   Eval      WWSZCD = MASZCD
033100030220     C                   Other
033200030220     C                   Endsl
033300030221     C     KMKT          Reade     MKTCARA1                               51
033400030220     C                   Enddo
033500030220      *
033600030220      *******************************************************************
033700030220      * NOTE - If not found, use default of 50.
033800030220      *******************************************************************
033900030224     C                   If        WWSZCD = *BLANKS
034000030224     C                   Eval      WWSZCD = '50   '
034100030220     C                   End
034200030220      *
034300030220     C                   Endsr
034400000000      *___________________________________________________________________
034500000000      * Key Lists
034600000000      *___________________________________________________________________
034700010223     C     KLIST         Begsr
034800030220     C     KMKT          KLIST
034900030220     C                   KFLD                    CTRUST
035000030220     C                   KFLD                    CSUB
035100030220     C                   KFLD                    CACCT
035200030220     C                   KFLD                    CCARCD
035300010220     C     KOVR          KLIST
035400010220     C                   KFLD                    CTRUST
035500010220     C                   KFLD                    CSUB
035600010220     C                   KFLD                    CACCT
035700010220     C                   KFLD                    CPLAN
035800010220     C     KPLN          KLIST
035900010220     C                   KFLD                    CTRUST
036000010220     C                   KFLD                    CSUB
036100010220     C                   KFLD                    CPLAN
036200010222     C     KPLNC         KLIST
036300010222     C                   KFLD                    CTRUST
036400010222     C                   KFLD                    CSUB
036500010222     C                   KFLD                    CMPLAN
036600010221     C     KCOM          KLIST
036700010221     C                   KFLD                    CTRUST
036800010221     C                   KFLD                    CSUB
036900010221     C                   KFLD                    CACCT
037000030225     C     KSMN          KLIST
037100030225     C                   KFLD                    IASMAN
037200010223     C                   Endsr
037300000000      *___________________________________________________________________
037400000000      * Program open
037500000000      *___________________________________________________________________
037600010223     C     *INZSR        Begsr
037700010223     C                   Endsr
037800030604** MedCat
037900030609CM
038000030609CS
038100030609MC
038200030609ME
038300030609MM
038400030609MS
038500030609OO
038600030609PP
038601080314RX
038700080314BG
