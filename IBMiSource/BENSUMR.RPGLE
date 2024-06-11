000100111007     H bnddir('*LIBL/GBSBDIR') DFTACTGRP(*NO) ACTGRP(*NEW)
000200111005     H option(*SRCSTMT: *NODEBUGIO)
000300111006
000400111021     FBENSUMF   O  A E           K Disk
000500111021     FBENSUM10F O  A E           K Disk
000600111005
000700111005      * Prototype defintions
000800000000      /COPY *LIBL/QMODSRC,#PROTO
000900111005
001000111005     D  p#             s              2s 0 inz
001100111005     D  p#cnt          s              2s 0 inz
001200111005     D  NewHire        s              1s 0 inz
001300111005     D Ded$Amt         S             10s 2 inz
001400111005     D Credit          S             10s 2 inz
001500111005     D  totpd$amt      s             10s 2 inz
001600111005     D  GrandTotal     s             10s 2 inz
001700111005     D  wiprd          s              1s 0 inz
001800111005     D  desctot        s            100a   inz
001900111005     D  chkcred        s              1a   inz
002000111005     D  TrmEff         s            100a   inz
002100111005     D  paychoice      s              1a   inz
002200111005     D w80date         s              8s 0 inz
002300111005     D coveffd         s              8s 0 inz
002400111005     D winiso          s               d   datfmt(*iso)
002500111006     D  PCPREQ         s              1a   inz
002600111006     D  BENREQ         s              1a   inz
002700111006     D  LIFE           s              1a   inz
002800111005
002900111005     D wusa            s               d   datfmt(*usa)
003000111005     D weff            s               d   datfmt(*iso)
003100111005     D weffn           s               d   datfmt(*usa)
003200111005
003300000000     d  MemCovg      e ds          2000    extname(webmcov)
003400000000     d  plan                   1    100a   dim(25) inz
003500000000     d  pcat                 101    175a   dim(25) inz
003600000000     d  desc                 176   1175a   dim(25) inz
003700000000     d  effd                1176   1425d   dim(25) inz datfmt(*usa)
003800000000     d  ctyp                1426   1500    dim(25) inz
003900000000     d  covt                1501   2000a   dim(25) inz
004000111005
004100111021     d  SUMDS        e ds                  extname(bensumd) inz
004200111021     d  SUMQDS       e ds                  extname(bensum10d) inz
004300111006     d  WEBTRAN      e ds                  extname(webtran)
004400000000     d  WEBPAY       e ds                  extname(webpayroll) inz
004500111005     d  WEBMBR       e ds                  extname(webmember) inz
004600111005     d  WEBGET       e ds                  extname(webtran) prefix(G_) inz
004700000000     d  PAYDEDAMT    e ds                  extname(webpayds) inz
004800111007    ?D PGMD          ESDS                  EXTNAME(IOPGMD)
004900111006
005000111006     C     *Entry        Plist
005100111006     C                   Parm                    WWTRST            3
005200111006     C                   Parm                    WWSUB#            3
005300111006     C                   Parm                    WWACCT            4
005400111007     C                   Parm                    WWSSNO            9
005500111007     C                   Parm                    WHEAD            10
005600111006
005700111006     C                   Move      WWTRST        OETRST
005800111006     C                   Move      WWSUB#        OESUB#
005900111006     C                   Move      WWACCT        OEACCT
006000111006     C                   Move      WWSSNO        OESSNO
006100111006
006200111006     C*                  Eval      OETRST = 590
006300111006     C*                  Eval      OESUB# = 1
006400111006     C*                  Eval      OEACCT = 30
006500111006     C*                  Eval      OESSNO = 454315211
006600111006
006700111006     C*                  Eval      OETRST = 888
006800111006     C*                  Eval      OESUB# = 9
006900111006     C*                  Eval      OEACCT = 1
007000111006     C*                  Eval      OESSNO = 888086789
007100111006
007200111006     C*                  Eval      OETRST = 590
007300111006     C*                  Eval      OESUB# = 1
007400111006     C*                  Eval      OEACCT = 30
007500111006     C*                  Eval      OESSNO = 158362142
007600111005
007700111005      * If PayChoice
007800000000     C                   Eval      PayChoice = #paycho(OETRST:OESUB#:OEACCT)
007900160104     C                   Eval      PayChoice = 'Y'
008000111005     C                   eval      webpay = #pchain(oetrst:oesub#:oeacct:oessno)
008100111005     C                   Exsr      GetMemberInfo
008200111005
008300111005      * If Credit
008400000000     C                   Eval      chkcred = #chkcred(oetrst:oesub#:oeacct:
008500000000     C                                        oessno)
008600111005
008700000000     C                   Exsr      Sflabsm
008800000000     C                   Eval      p# = 1
008900000000     C                   Eval      p#cnt = 0
009000000000     C                   If        plan(p#) <> *blanks
009100000000     C                   Dow       plan(p#) <> *blanks
009200000000     C                   If        plan(p#) <> 'XXXX'
009300000000     C                   Eval      p#cnt = p#cnt + 1
009400000000     C                   If        pysts = 'T' or
009500000000     C                             termdt > 0
009600000000     C                   Select
009700000000     C                   When      %trim(ctyp(p#)) = 'TIN'
009800000000     C                   Eval      covt(p#) = 'INDIVIDUAL'
009900000000     C                   When      %trim(ctyp(p#)) = 'THW'
010000000000     C                   Eval      covt(p#) = 'HUSBAND/WIFE'
010100000000     C                   When      %trim(ctyp(p#)) = 'TFA'
010200000000     C                   Eval      covt(p#) = 'FAMILY'
010300000000     C                   When      %trim(ctyp(p#)) = 'TPC'
010400000000     C                   Eval      covt(p#) = 'PARENT/CHILD'
010500000000     C                   When      %trim(ctyp(p#)) = 'TP2'
010600000000     C                   Eval      covt(p#) = 'PARENT/CHILDREN'
010700000000     C                   When      %trim(ctyp(p#)) = 'TMI'
010800000000     C                   Eval      covt(p#) = 'INDIVIDUAL MEDICARE'
010900000000     C                   Endsl
011000000000     C                   Else
011100000000     C                   Eval      covt(p#) = #getclvl(oetrst:oesub#:oeacct:
011200000000     C                                        oessno:plan(p#):pcat(p#))
011300000000     C                   End
011400111005
011500000000     C                   if        %trim(PayChoice) = 'Y'
011600000000     C                   Eval      coveffd = #get80i(effd(p#))
011700160418     C                   Eval      NewHire= #chknhr(oetrst:oesub#:oeacct:oessno:
011800160418     C                                             ' ')
011900000000     C                   If        NewHire     > 0
012000000000     C                   Eval      wiprd = 1
012100000000     C                   Else
012200000000     C                   Eval      wiprd = 0
012300000000     C                   End
012400000000     C                   eval      paydedamt = #getded(oetrst:oesub#:oeacct:
012500000000     C                                        oessno:0:plan(p#):pcat(p#):
012600160418     C                                        covt(p#):coveffd:wiprd:'')
012700000000     C                   Eval      ded$amt = dsdamt
012800000000     C                   If        pysts = 'T' or
012900000000     C                             termdt > 0
013000000000     C                   Exsr      GetTrm
013100000000     C                   Else
013200000000     C                   move      dseffd        weffn
013300000000     C                   End
013400111005
013500000000     C                   If        plan(p#) = 'CRED'
013600000000     C                   Eval      Credit = ded$amt
013700000000     C                   Else
013800000000     C                   Eval      Totpd$amt = Totpd$amt + ded$amt
013900000000     C                   End
014000111005
014100000000     C                   Else
014200000000     C                   If        pysts = 'T' or
014300000000     C                             termdt > 0
014400000000     C                   Exsr      GetTrm
014500000000     C                   Else
014600000000     C                   move      effd(p#)      weffn
014700000000     C                   End
014800000000     C                   End
014900000000     C                   End
015000111006
015100111021     C                   Eval      bqpl# = %trim(plan(p#))
015200111021     C                   Eval      bspln = %trim(desc(p#))
015300111021     C                   Eval      bqpln = %trim(desc(p#))
015400111021     C                   Evalr     bsamt = %editc(ded$amt:'J')
015500111021     C                   Evalr     bqamt = %editc(ded$amt:'J')
015600111021     C                   Eval      bstyp = %trim(dscovt)
015700111021     C                   Eval      bqtyp = %trim(dscovt)
015800111021     C                   Move      weffn         bsdat
015900111021     C                   Move      weffn         bqdat
016000111021     C                   Movel     SUMDS         BSFLAT
016100111021     C                   Movel     SUMQDS        BQFLAT
016200120402     C                   If        %trim(BQPL#) <> 'XXXX'
016300111021     C                   Write     BSFR
016400111021     C                   Write     BQFR
016500120402     C                   End
016600111006
016700000000     C                   Eval      p# = p# + 1
016800000000     C                   Enddo
016900000000     C                   end
017000000000     C                   if        %trim(PayChoice) = 'Y'
017100000000     C                   If        %abs(Credit) <> 0    and
017200000000     C                             %abs(Credit) > Totpd$amt
017300000000     C                   Eval      Totpd$amt = 0
017400000000     C                   Else
017500000000     C                   Eval      Totpd$amt = Totpd$amt + Credit
017600000000     C                   endif
017700111006
017800111006     C                   if        p#cnt > 0
017900111006     C                   End
018000111006
018100000000     C                   Exsr      Sflxbsm
018200000000     C                   If        plan(1) <> *blanks
018300000000     C                   Eval      desctot = 'Per Pay Deductions:'
018400000000     C                   Else
018500000000     C                   Eval      desctot = 'Per Pay Deductions Total:'
018600000000     C                   End
018700000000     C                   Eval      ChkCred = #chkcred(OETRST:OESUB#:OEACCT:
018800000000     C                                       OESSNO)
018900000000     C                   If        %trim(ChkCred) = 'Y'
019000000000     C                   Eval      desctot = 'Defined Contribution Net ' +
019100000000     C                                       'Deductions:'
019200000000     C                   Else
019300000000     C                   Eval      desctot = 'Per Pay Deductions Total'
019400000000     C                   End
019500111006
019600111021     C                   Clear                   SUMDS
019700111021     C                   Clear                   SUMQDS
019800111021     C                   Eval      bspln = %trim(desctot)
019900111021     C                   Eval      bqpln = %trim(desctot)
020000111021     C                   Evalr     bsamt = %editc(totpd$amt:'J')
020100111021     C                   Evalr     bqamt = %editc(totpd$amt:'J')
020200111021     C                   Movel     SUMDS         BSFLAT
020300111021     C                   Movel     SUMQDS        BQFLAT
020400111021     C                   Write     BSFR
020500111021     C                   Write     BQFR
020600111006
020700000000     C                   Eval      GrandTotal = Totpd$amt
020800000000     C                   Eval      Totpd$amt = *zeros
020900000000     C                   Eval      p# = 1
021000000000     C                   Eval      p#cnt = 0
021100000000     C                   If        plan(p#) <> *blanks
021200000000     C                   Dow       plan(p#) <> *blanks
021300000000     C                   If        plan(p#) <> 'XXXX'
021400000000     C                   Eval      p#cnt = p#cnt + 1
021500000000     C                   If        pysts = 'T' or
021600000000     C                             termdt > 0
021700000000     C                   Select
021800000000     C                   When      %trim(ctyp(p#)) = 'TIN'
021900000000     C                   Eval      covt(p#) = 'INDIVIDUAL'
022000000000     C                   When      %trim(ctyp(p#)) = 'THW'
022100000000     C                   Eval      covt(p#) = 'HUSBAND/WIFE'
022200000000     C                   When      %trim(ctyp(p#)) = 'TFA'
022300000000     C                   Eval      covt(p#) = 'FAMILY'
022400000000     C                   When      %trim(ctyp(p#)) = 'TPC'
022500000000     C                   Eval      covt(p#) = 'PARENT/CHILD'
022600000000     C                   When      %trim(ctyp(p#)) = 'TP2'
022700000000     C                   Eval      covt(p#) = 'PARENT/CHILDREN'
022800000000     C                   When      %trim(ctyp(p#)) = 'TMI'
022900000000     C                   Eval      covt(p#) = 'INDIVIDUAL MEDICARE'
023000000000     C                   Endsl
023100000000     C                   Else
023200000000     C                   Eval      covt(p#) = #getclvl(oetrst:oesub#:oeacct:
023300000000     C                                        oessno:plan(p#):pcat(p#))
023400000000     C                   End
023500000000     C                   Eval      coveffd = #get80i(effd(p#))
023600160418     C                   Eval      NewHire= #chknhr(oetrst:oesub#:oeacct:oessno:
023700160418     C                                             ' ')
023800000000     C                   If        NewHire     > 0
023900000000     C                   Eval      wiprd = 1
024000000000     C                   Else
024100000000     C                   Eval      wiprd = 0
024200000000     C                   End
024300000000     C                   eval      paydedamt = #getded(oetrst:oesub#:oeacct:
024400000000     C                                        oessno:0:plan(p#):pcat(p#):
024500160418     C                                        covt(p#):coveffd:wiprd:'')
024600000000     C                   Eval      ded$amt = dsdamt
024700000000     C                   Eval      Totpd$amt = Totpd$amt + ded$amt
024800000000     C                   If        pysts = 'T' or
024900000000     C                             termdt > 0
025000000000     C                   Exsr      GetTrm
025100000000     C                   Else
025200000000     C                   move      dseffd        weffn
025300000000     C                   End
025400000000     C                   if        p#cnt = 1
025500111006      * ?
025600111006
025700111021     C                   Clear                   SUMDS
025800111021     C                   Clear                   SUMQDS
025900111021     C                   Movel     SUMDS         BSFLAT
026000111021     C                   Movel     SUMQDS        BQFLAT
026100111021     C                   Write     BSFR
026200111021     C                   Write     BQFR
026300111006      * ?
026400000000     C                   End
026500000000     C                   End
026600111006
026700111021     C                   Eval      bqpl# = %trim(plan(p#))
026800111021     C                   Eval      bspln = %trim(desc(p#))
026900111021     C                   Eval      bqpln = %trim(desc(p#))
027000111021     C                   Evalr     bsamt = %editc(ded$amt:'J')
027100111021     C                   Evalr     bqamt = %editc(ded$amt:'J')
027200111021     C                   Eval      bstyp = %trim(dscovt)
027300111021     C                   Eval      bqtyp = %trim(dscovt)
027400111021     C                   Move      weffn         bsdat
027500111021     C                   Move      weffn         bqdat
027600111021     C                   Movel     SUMDS         BSFLAT
027700111021     C                   Movel     SUMQDS        BQFLAT
027800111021     C                   Write     BSFR
027900111021     C                   Write     BQFR
028000111006
028100000000     C                   Eval      p# = p# + 1
028200000000     C                   Enddo
028300000000     C                   End
028400000000     C                   if        p#cnt > 0
028500000000     C                   Eval      GrandTotal = GrandTotal + Totpd$amt
028600000000     C                   Eval      desctot = 'Non-Defined Contribution ' +
028700000000     C                                       'Deductions:'
028800111006
028900111021     C                   Clear                   SUMDS
029000111021     C                   Clear                   SUMQDS
029100111021     C                   Eval      bspln = %trim(desctot)
029200111021     C                   Eval      bqpln = %trim(desctot)
029300111021     C                   Evalr     bsamt = %editc(Totpd$amt:'J')
029400111021     C                   Evalr     bqamt = %editc(Totpd$amt:'J')
029500111021     C                   Movel     SUMDS         BSFLAT
029600111021     C                   Movel     SUMQDS        BQFLAT
029700111021     C                   Write     BSFR
029800111021     C                   Write     BQFR
029900111006
030000000000     C                   If        GrandTotal <> 0
030100000000     C                   Eval      desctot = 'Per Pay Deductions Total:'
030200111006
030300111021     C                   Clear                   SUMDS
030400111021     C                   Clear                   SUMQDS
030500111021     C                   Movel     SUMDS         BSFLAT
030600111021     C                   Movel     SUMQDS        BQFLAT
030700111021     C                   Write     BSFR
030800111021     C                   Write     BQFR
030900111006
031000111021     C                   Clear                   SUMDS
031100111021     C                   Clear                   SUMQDS
031200111021     C                   Eval      bspln = %trim(desctot)
031300111021     C                   Eval      bqpln = %trim(desctot)
031400111021     C                   Evalr     bsamt = %editc(GrandTotal:'J')
031500111021     C                   Evalr     bqamt = %editc(GrandTotal:'J')
031600111021     C                   Movel     SUMDS         BSFLAT
031700111021     C                   Movel     SUMQDS        BQFLAT
031800111021     C                   Write     BSFR
031900111021     C                   Write     BQFR
032000111006     C                   End
032100111006
032200000000     C                   End
032300000000     C                   End
032400111006
032500000000     C                   Eval      *inlr = *On
032600111006     C                   Return
032700000000     C     Sflabsm       Begsr
032800000000     C                   Clear                   MemCovg
032900000000     C                   If        Termdt > 0
033000000000     C                   Eval      MemCovg = #sfltbsm(OETRST:OESUB#:OEACCT:
033100000000     C                                       OESSNO:0:PCPREQ:LIFE:termdt)
033200000000     C                   Else
033300000000     C                   Eval      MemCovg = #sflabsm(OETRST:OESUB#:OEACCT:
033400170817     C                                       OESSNO:0:PCPREQ:LIFE:'')
033500000000     C                   End
033600000000     C                   Endsr
033700000000     C     Sflxbsm       Begsr
033800000000     C                   Clear                   MemCovg
033900000000     C                   Eval      MemCovg = #sflxbsm(OETRST:OESUB#:OEACCT:
034000000000     C                                       OESSNO:0:PCPREQ:LIFE)
034100000000     C                   Endsr
034200000000     C     GetMemberInfo Begsr
034300000000     C                   Eval      WEBMBR = #webdem(pytrs:pysub:pyact:
034400111006     C                                              pyssn:0:'C')
034500000000     C                   If        Termdt = 0  and
034600000000     C                             pysts = 'T'
034700000000     C                   Exsr      GetTrm
034800000000     C                   Eval      Termdt = w80date
034900000000     C                   End
035000000000     C                   If        pysts = 'T' or
035100000000     C                             termdt > 0
035200111007     C                   Eval      WHEAD = 'Term Date'
035300000000     C                   Else
035400111007     C                   Eval      WHEAD = 'Effective'
035500000000     C                   End
035600000000     C                   Endsr
035700000000     C     GetTrm        Begsr
035800000000     C                   Eval      webget = #webbdt(pytrs:pysub:pyact:pyssn)
035900000000     C                   If        %trim(G_OEAFTER) <> *Blanks
036000000000     C                   Movel     G_OEAFTER     w80date
036100000000     C                   eval      weff   = #getiso(w80date)
036200000000     C                   eval      weffn  = weff
036300000000     C                   else
036400000000     C                   eval      weff   = #getiso(termdt)
036500000000     C                   eval      weffn  = weff
036600000000     C                   End
036700000000     C                   Endsr
036800111007    ? *___________________________________________________________________
036900111007    ? * Program error handler
037000111007    ? *___________________________________________________________________
037100111007    ?C     *PSSR         Begsr                                                  PROGRAM ERROR
037200111007    ?C                   Call      'SNDRPGM'                            50      SEND RPG MSG
037300111007    ?C                   Parm                    WQPGMN                         PROGRAM NAME
037400111007    ?C                   Parm                    WQSTSC                         STATUS CODE
037500111007    ?C                   Parm                    WQRPGS                         RPG STATEMENT
037600111007    ?C                   Parm                    WQMSG                          MESSAGE ID
037700111007    ?C                   Endsr     '*CANCL'                                     END PGM ERROR
