000100111007     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*NEW)
000200111005     H option(*SRCSTMT: *NODEBUGIO)
000300191113
000400191113      */  bs01 jallen  11.13.2019    use coveffd not dsdeff          */
000500191113      */                                                             */
000600191113      */                                                             */
000700191113      */                                                             */
000800191113
000900111006
001000111207     FBENSUMFV2 O  A E           K Disk
001100111207     FBENSUM20F O  A E           K Disk
001200111005
001300111005      * Prototype defintions
001400000000      /COPY *LIBL/QMODSRC,#PROTO
001500111005
001600111005     D  p#             s              2s 0 inz
001700111005     D  p#cnt          s              2s 0 inz
001800111005     D  NewHire        s              1s 0 inz
001900111005     D Ded$Amt         S             10s 2 inz
002000111005     D Credit          S             10s 2 inz
002100111005     D  totpd$amt      s             10s 2 inz
002200111005     D  GrandTotal     s             10s 2 inz
002300111005     D  wiprd          s              1s 0 inz
002400111005     D  desctot        s            100a   inz
002500111005     D  chkcred        s              1a   inz
002600111005     D  TrmEff         s            100a   inz
002700111005     D  paychoice      s              1a   inz
002800111005     D w80date         s              8s 0 inz
002900111005     D coveffd         s              8s 0 inz
003000111005     D winiso          s               d   datfmt(*iso)
003100111006     D  PCPREQ         s              1a   inz
003200111006     D  BENREQ         s              1a   inz
003300111006     D  LIFE           s              1a   inz
003400111005
003500111005     D wusa            s               d   datfmt(*usa)
003600111005     D weff            s               d   datfmt(*iso)
003700111005     D weffn           s               d   datfmt(*usa)
003800111005
003900000000     d  MemCovg      e ds          2000    extname(webmcov)
004000000000     d  plan                   1    100a   dim(25) inz
004100000000     d  pcat                 101    175a   dim(25) inz
004200000000     d  desc                 176   1175a   dim(25) inz
004300000000     d  effd                1176   1425d   dim(25) inz datfmt(*usa)
004400000000     d  ctyp                1426   1500    dim(25) inz
004500000000     d  covt                1501   2000a   dim(25) inz
004600111005
004700111021     d  SUMDS        e ds                  extname(bensumd) inz
004800111207     d  SUMQDS       e ds                  extname(bensum20d) inz
004900111006     d  WEBTRAN      e ds                  extname(webtran)
005000000000     d  WEBPAY       e ds                  extname(webpayroll) inz
005100111207     d  WEBMBR       e ds                  extname(webmember) inz
005200111207     d  WEBPLN       e ds                  extname(webplan) inz
005300111005     d  WEBGET       e ds                  extname(webtran) prefix(G_) inz
005400000000     d  PAYDEDAMT    e ds                  extname(webpayds) inz
005500111007    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
005600111006
005700111006     C     *Entry        Plist
005800111006     C                   Parm                    WWTRST            3
005900111006     C                   Parm                    WWSUB#            3
006000111006     C                   Parm                    WWACCT            4
006100111007     C                   Parm                    WWSSNO            9
006200111007     C                   Parm                    WHEAD            10
006300111006
006400111006     C                   Move      WWTRST        OETRST
006500111006     C                   Move      WWSUB#        OESUB#
006600111006     C                   Move      WWACCT        OEACCT
006700111006     C                   Move      WWSSNO        OESSNO
006800111006
006900111006     C*                  Eval      OETRST = 590
007000111006     C*                  Eval      OESUB# = 1
007100111006     C*                  Eval      OEACCT = 30
007200111006     C*                  Eval      OESSNO = 454315211
007300111006
007400111006     C*                  Eval      OETRST = 888
007500111006     C*                  Eval      OESUB# = 9
007600111006     C*                  Eval      OEACCT = 1
007700111006     C*                  Eval      OESSNO = 888086789
007800111006
007900111006     C*                  Eval      OETRST = 590
008000111006     C*                  Eval      OESUB# = 1
008100111006     C*                  Eval      OEACCT = 30
008200111006     C*                  Eval      OESSNO = 158362142
008300111005
008400160104      * If PayChoice - Dashboard alwasy Y
008500000000     C                   Eval      PayChoice = #paycho(OETRST:OESUB#:OEACCT)
008600160104     C                   eval      PayChoice = 'Y'
008700111005     C                   eval      webpay = #pchain(oetrst:oesub#:oeacct:oessno)
008800111005     C                   Exsr      GetMemberInfo
008900111005
009000111005      * If Credit
009100000000     C                   Eval      chkcred = #chkcred(oetrst:oesub#:oeacct:
009200000000     C                                        oessno)
009300111005
009400000000     C                   Exsr      Sflabsm
009500000000     C                   Eval      p# = 1
009600000000     C                   Eval      p#cnt = 0
009700000000     C                   If        plan(p#) <> *blanks
009800000000     C                   Dow       plan(p#) <> *blanks
009900000000     C                   If        plan(p#) <> 'XXXX'
010000000000     C                   Eval      p#cnt = p#cnt + 1
010100000000     C                   If        pysts = 'T' or
010200000000     C                             termdt > 0
010300000000     C                   Select
010400000000     C                   When      %trim(ctyp(p#)) = 'TIN'
010500000000     C                   Eval      covt(p#) = 'INDIVIDUAL'
010600000000     C                   When      %trim(ctyp(p#)) = 'THW'
010700000000     C                   Eval      covt(p#) = 'HUSBAND/WIFE'
010800000000     C                   When      %trim(ctyp(p#)) = 'TFA'
010900000000     C                   Eval      covt(p#) = 'FAMILY'
011000000000     C                   When      %trim(ctyp(p#)) = 'TPC'
011100000000     C                   Eval      covt(p#) = 'PARENT/CHILD'
011200000000     C                   When      %trim(ctyp(p#)) = 'TP2'
011300000000     C                   Eval      covt(p#) = 'PARENT/CHILDREN'
011400000000     C                   When      %trim(ctyp(p#)) = 'TMI'
011500000000     C                   Eval      covt(p#) = 'INDIVIDUAL MEDICARE'
011600000000     C                   Endsl
011700000000     C                   Else
011800000000     C                   Eval      covt(p#) = #getclvl(oetrst:oesub#:oeacct:
011900000000     C                                        oessno:plan(p#):pcat(p#))
012000000000     C                   End
012100111005
012200000000     C                   if        %trim(PayChoice) = 'Y'
012300000000     C                   Eval      coveffd = #get80i(effd(p#))
012400160418     C                   Eval      NewHire= #chknhr(oetrst:oesub#:oeacct:oessno:
012500160418     C                                              '')
012600000000     C                   If        NewHire     > 0
012700000000     C                   Eval      wiprd = 1
012800000000     C                   Else
012900000000     C                   Eval      wiprd = 0
013000000000     C                   End
013100000000     C                   eval      paydedamt = #getded(oetrst:oesub#:oeacct:
013200000000     C                                        oessno:0:plan(p#):pcat(p#):
013300160418     C                                        covt(p#):coveffd:wiprd:'')
013400000000     C                   Eval      ded$amt = dsdamt
013500000000     C                   If        pysts = 'T' or
013600000000     C                             termdt > 0
013700000000     C                   Exsr      GetTrm
013800000000     C                   Else
013900191113bs01 C**                 move      dseffd        weffn
014000191113bs01 C                   move      coveffd       weff
014100191113bs01 C                   move      weff          weffn
014200000000     C                   End
014300111005
014400000000     C                   If        plan(p#) = 'CRED'
014500000000     C                   Eval      Credit = ded$amt
014600000000     C                   Else
014700000000     C                   Eval      Totpd$amt = Totpd$amt + ded$amt
014800000000     C                   End
014900111005
015000000000     C                   Else
015100000000     C                   If        pysts = 'T' or
015200000000     C                             termdt > 0
015300000000     C                   Exsr      GetTrm
015400000000     C                   Else
015500000000     C                   move      effd(p#)      weffn
015600000000     C                   End
015700000000     C                   End
015800000000     C                   End
015900111207
016000111207      * Get Group#
016100111207     C                   Eval      w80date = #get80i(effd(p#))
016200111207     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
016300111207     C                                        plan(p#):w80date)
016400111207     C                   Eval      bqgrp = %trim(plngrp)
016500111006
016600111021     C                   Eval      bqpl# = %trim(plan(p#))
016700111021     C                   Eval      bspln = %trim(desc(p#))
016800111021     C                   Eval      bqpln = %trim(desc(p#))
016900111021     C                   Evalr     bsamt = %editc(ded$amt:'J')
017000111021     C                   Evalr     bqamt = %editc(ded$amt:'J')
017100111021     C                   Eval      bstyp = %trim(dscovt)
017200111021     C                   Eval      bqtyp = %trim(dscovt)
017300111021     C                   Move      weffn         bsdat
017400111021     C                   Move      weffn         bqdat
017500111021     C                   Movel     SUMDS         BSFLAT
017600111021     C                   Movel     SUMQDS        BQFLAT
017700120402     C                   If        %trim(bqpl#) <> 'XXXX'
017800111021     C                   Write     BSFR
017900111021     C                   Write     BQFR
018000120402     C                   End
018100111006
018200000000     C                   Eval      p# = p# + 1
018300000000     C                   Enddo
018400000000     C                   end
018500000000     C                   if        %trim(PayChoice) = 'Y'
018600000000     C                   If        %abs(Credit) <> 0    and
018700000000     C                             %abs(Credit) > Totpd$amt
018800000000     C                   Eval      Totpd$amt = 0
018900000000     C                   Else
019000000000     C                   Eval      Totpd$amt = Totpd$amt + Credit
019100000000     C                   endif
019200111006
019300111006     C                   if        p#cnt > 0
019400111006     C                   End
019500111006
019600000000     C                   Exsr      Sflxbsm
019700000000     C                   If        plan(1) <> *blanks
019800000000     C                   Eval      desctot = 'Per Pay Deductions:'
019900000000     C                   Else
020000000000     C                   Eval      desctot = 'Per Pay Deductions Total:'
020100000000     C                   End
020200000000     C                   Eval      ChkCred = #chkcred(OETRST:OESUB#:OEACCT:
020300000000     C                                       OESSNO)
020400000000     C                   If        %trim(ChkCred) = 'Y'
020500000000     C                   Eval      desctot = 'Defined Contribution Net ' +
020600000000     C                                       'Deductions:'
020700000000     C                   Else
020800000000     C                   Eval      desctot = 'Per Pay Deductions Total'
020900000000     C                   End
021000111006
021100111021     C                   Clear                   SUMDS
021200111021     C                   Clear                   SUMQDS
021300111021     C                   Eval      bspln = %trim(desctot)
021400111021     C                   Eval      bqpln = %trim(desctot)
021500111021     C                   Evalr     bsamt = %editc(totpd$amt:'J')
021600111021     C                   Evalr     bqamt = %editc(totpd$amt:'J')
021700111021     C                   Movel     SUMDS         BSFLAT
021800111021     C                   Movel     SUMQDS        BQFLAT
021900111021     C                   Write     BSFR
022000111021     C                   Write     BQFR
022100111006
022200000000     C                   Eval      GrandTotal = Totpd$amt
022300000000     C                   Eval      Totpd$amt = *zeros
022400000000     C                   Eval      p# = 1
022500000000     C                   Eval      p#cnt = 0
022600000000     C                   If        plan(p#) <> *blanks
022700000000     C                   Dow       plan(p#) <> *blanks
022800000000     C                   If        plan(p#) <> 'XXXX'
022900000000     C                   Eval      p#cnt = p#cnt + 1
023000000000     C                   If        pysts = 'T' or
023100000000     C                             termdt > 0
023200000000     C                   Select
023300000000     C                   When      %trim(ctyp(p#)) = 'TIN'
023400000000     C                   Eval      covt(p#) = 'INDIVIDUAL'
023500000000     C                   When      %trim(ctyp(p#)) = 'THW'
023600000000     C                   Eval      covt(p#) = 'HUSBAND/WIFE'
023700000000     C                   When      %trim(ctyp(p#)) = 'TFA'
023800000000     C                   Eval      covt(p#) = 'FAMILY'
023900000000     C                   When      %trim(ctyp(p#)) = 'TPC'
024000000000     C                   Eval      covt(p#) = 'PARENT/CHILD'
024100000000     C                   When      %trim(ctyp(p#)) = 'TP2'
024200000000     C                   Eval      covt(p#) = 'PARENT/CHILDREN'
024300000000     C                   When      %trim(ctyp(p#)) = 'TMI'
024400000000     C                   Eval      covt(p#) = 'INDIVIDUAL MEDICARE'
024500000000     C                   Endsl
024600000000     C                   Else
024700000000     C                   Eval      covt(p#) = #getclvl(oetrst:oesub#:oeacct:
024800000000     C                                        oessno:plan(p#):pcat(p#))
024900000000     C                   End
025000000000     C                   Eval      coveffd = #get80i(effd(p#))
025100160418     C                   Eval      NewHire= #chknhr(oetrst:oesub#:oeacct:oessno:
025200160418     C                                              '')
025300000000     C                   If        NewHire     > 0
025400000000     C                   Eval      wiprd = 1
025500000000     C                   Else
025600000000     C                   Eval      wiprd = 0
025700000000     C                   End
025800000000     C                   eval      paydedamt = #getded(oetrst:oesub#:oeacct:
025900000000     C                                        oessno:0:plan(p#):pcat(p#):
026000160418     C                                        covt(p#):coveffd:wiprd:'')
026100000000     C                   Eval      ded$amt = dsdamt
026200000000     C                   Eval      Totpd$amt = Totpd$amt + ded$amt
026300000000     C                   If        pysts = 'T' or
026400000000     C                             termdt > 0
026500000000     C                   Exsr      GetTrm
026600000000     C                   Else
026700000000     C                   move      dseffd        weffn
026800000000     C                   End
026900000000     C                   if        p#cnt = 1
027000111006      * ?
027100111006
027200111021     C                   Clear                   SUMDS
027300111021     C                   Clear                   SUMQDS
027400111021     C                   Movel     SUMDS         BSFLAT
027500111021     C                   Movel     SUMQDS        BQFLAT
027600111021     C                   Write     BSFR
027700111021     C                   Write     BQFR
027800111006      * ?
027900000000     C                   End
028000000000     C                   End
028100111209
028200111209      * Get Group#
028300111209     C                   Eval      w80date = #get80i(effd(p#))
028400111209     C                   Eval      webpln = #getplan(oetrst:oesub#:oeacct:
028500111209     C                                        plan(p#):w80date)
028600111209     C                   Eval      bqgrp = %trim(plngrp)
028700111006
028800111021     C                   Eval      bqpl# = %trim(plan(p#))
028900111021     C                   Eval      bspln = %trim(desc(p#))
029000111021     C                   Eval      bqpln = %trim(desc(p#))
029100111021     C                   Evalr     bsamt = %editc(ded$amt:'J')
029200111021     C                   Evalr     bqamt = %editc(ded$amt:'J')
029300111021     C                   Eval      bstyp = %trim(dscovt)
029400111021     C                   Eval      bqtyp = %trim(dscovt)
029500111021     C                   Move      weffn         bsdat
029600111021     C                   Move      weffn         bqdat
029700111021     C                   Movel     SUMDS         BSFLAT
029800111021     C                   Movel     SUMQDS        BQFLAT
029900111021     C                   Write     BSFR
030000111021     C                   Write     BQFR
030100111006
030200000000     C                   Eval      p# = p# + 1
030300000000     C                   Enddo
030400000000     C                   End
030500000000     C                   if        p#cnt > 0
030600000000     C                   Eval      GrandTotal = GrandTotal + Totpd$amt
030700000000     C                   Eval      desctot = 'Non-Defined Contribution ' +
030800000000     C                                       'Deductions:'
030900111006
031000111021     C                   Clear                   SUMDS
031100111021     C                   Clear                   SUMQDS
031200111021     C                   Eval      bspln = %trim(desctot)
031300111021     C                   Eval      bqpln = %trim(desctot)
031400111021     C                   Evalr     bsamt = %editc(Totpd$amt:'J')
031500111021     C                   Evalr     bqamt = %editc(Totpd$amt:'J')
031600111021     C                   Movel     SUMDS         BSFLAT
031700111021     C                   Movel     SUMQDS        BQFLAT
031800111021     C                   Write     BSFR
031900111021     C                   Write     BQFR
032000111006
032100000000     C                   If        GrandTotal <> 0
032200000000     C                   Eval      desctot = 'Per Pay Deductions Total:'
032300111006
032400111021     C                   Clear                   SUMDS
032500111021     C                   Clear                   SUMQDS
032600111021     C                   Movel     SUMDS         BSFLAT
032700111021     C                   Movel     SUMQDS        BQFLAT
032800111021     C                   Write     BSFR
032900111021     C                   Write     BQFR
033000111006
033100111021     C                   Clear                   SUMDS
033200111021     C                   Clear                   SUMQDS
033300111021     C                   Eval      bspln = %trim(desctot)
033400111021     C                   Eval      bqpln = %trim(desctot)
033500111021     C                   Evalr     bsamt = %editc(GrandTotal:'J')
033600111021     C                   Evalr     bqamt = %editc(GrandTotal:'J')
033700111021     C                   Movel     SUMDS         BSFLAT
033800111021     C                   Movel     SUMQDS        BQFLAT
033900111021     C                   Write     BSFR
034000111021     C                   Write     BQFR
034100111006     C                   End
034200111006
034300000000     C                   End
034400000000     C                   End
034500111006
034600000000     C                   Eval      *inlr = *On
034700111006     C                   Return
034800000000     C     Sflabsm       Begsr
034900000000     C                   Clear                   MemCovg
035000000000     C                   If        Termdt > 0
035100000000     C                   Eval      MemCovg = #sfltbsm(OETRST:OESUB#:OEACCT:
035200000000     C                                       OESSNO:0:PCPREQ:LIFE:termdt)
035300000000     C                   Else
035400000000     C                   Eval      MemCovg = #sflabsm(OETRST:OESUB#:OEACCT:
035500180620     C                                       OESSNO:0:PCPREQ:LIFE:'')
035600000000     C                   End
035700000000     C                   Endsr
035800000000     C     Sflxbsm       Begsr
035900000000     C                   Clear                   MemCovg
036000000000     C                   Eval      MemCovg = #sflxbsm(OETRST:OESUB#:OEACCT:
036100000000     C                                       OESSNO:0:PCPREQ:LIFE)
036200000000     C                   Endsr
036300000000     C     GetMemberInfo Begsr
036400000000     C                   Eval      WEBMBR = #webdem(pytrs:pysub:pyact:
036500111006     C                                              pyssn:0:'C')
036600000000     C                   If        Termdt = 0  and
036700000000     C                             pysts = 'T'
036800000000     C                   Exsr      GetTrm
036900000000     C                   Eval      Termdt = w80date
037000000000     C                   End
037100000000     C                   If        pysts = 'T' or
037200000000     C                             termdt > 0
037300111007     C                   Eval      WHEAD = 'Term Date'
037400000000     C                   Else
037500111007     C                   Eval      WHEAD = 'Effective'
037600000000     C                   End
037700000000     C                   Endsr
037800000000     C     GetTrm        Begsr
037900000000     C                   Eval      webget = #webbdt(pytrs:pysub:pyact:pyssn)
038000000000     C                   If        %trim(G_OEAFTER) <> *Blanks
038100000000     C                   Movel     G_OEAFTER     w80date
038200000000     C                   eval      weff   = #getiso(w80date)
038300000000     C                   eval      weffn  = weff
038400000000     C                   else
038500000000     C                   eval      weff   = #getiso(termdt)
038600000000     C                   eval      weffn  = weff
038700000000     C                   End
038800000000     C                   Endsr
038900111007    ? *___________________________________________________________________
039000111007    ? * Program error handler
039100111007    ? *___________________________________________________________________
039200111007    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
039300111007    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
039400111007    ?C                   Parm                    WQPGMN                         PROGRAM NAME
039500111007    ?C                   Parm                    WQSTSC                         STATUS CODE
039600111007    ?C                   Parm                    WQRPGS                         RPG STATEMENT
039700111007    ?C                   Parm                    WQMSG                          MESSAGE ID
039800111007    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
