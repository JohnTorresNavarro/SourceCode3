000100970917     F******************************************************************
000200000414     F* RPA060     GROUP BENEFIT SERVICES SOFTWARE           1988      *
000300970917     F*                                                                *
000400970917     F*            WRITTEN BY - MICHAEL C. DUNPHY                      *
000500970917     F*            DATE - 08/16/89                                     *
000600970917     F*                                                                *
000700970917     F*  DESCRIPTION - THIS PROGRAM WILL PRODUCE SALESMAN COMMISSION   *
000800970917     F*            STATEMENTS.                                         *
000900971007      *       09/17/97 GSP  Added processing to capture report data &
001000971007      *                     save in a disk resident file - QS36F/RPA060WK
001100000622     F* 06/22/00 DLK - CHANGE NUMERIC FIELDS TO SIGNED OUTPUT SO CREDIT
001200000622     F*                AMOUNTS WILL SHOW.
001300000628     F*              - ADD LEVEL BREAK BY EFFDT and convert to rpgle   *
001400000629     F*                and convert to 8x11 on laser printer and add    *
001500000629     F*                summary of carriers paid by salesman            *
001600001012     F* DLK 10/12/00 - change group # to 15                            *
001700010131     F* RLJ 01/31/01 - suppress printing of report                     *
001800010201     F* RLJ 02/01/01 - change RPA060WK output format                   *
001900030325     F* SSK 03/25/03 - ADD SLM RELATION ID                             *
002000050519     F* szz  5/19/05 - Change Commission Project (Commission Paid Date *
002100071207     F* dlk 12/07/07 - change runtyp to use lda position 22 for run seq*
002200071207     F*                to store in rpa060wk in the field rplflg.       *
002300071207     F*                RPA060WK records are only written at full run   *
002400071207     F*                time anyway (seq 01) so this should not be a    *
002500071207     F*                problem.                                        *
002600080206      * 02/06/2008 DLK - change seq to 2.0 in rpa060wk. Now commissions
002700080206      *                  are written at every run for new transactions.
002800080206      *                  Only records that should be paid are fed to this
002900080206      *                  RPG from rpa068. also change to external def
003000080206      *                  for rpa060wk
003100080911      * 09/11/2008 DLK - update new field in F.INVDET, "IDCOMDT" =
003200080911      *                  commission paid date and increase rpa068 file
003300080911      *                  length to include date/seq field
003400081007      * 10/07/2008 DLK - use new field rppdfl to know when a record
003500081007      *                  should be paid comm
003600081015      * 10/15/2008 DLK - change rpa068 file length
003700100817      * 08/17/2010 DLK - change rpa068 file length
003800110601      * 06/01/2011 DLK - add market size and calc agency override for
003900110607      *                  rpa060wk by calling GETAO pgm. Remember the
004000110616      *                  files in GETAO need to be overridden in the CL
004100110607      *                  for this program (AGCAROV1, SPRAGXR2, SMANRLT).
004200110615      *                  Also change rpa068 input file to rpa068wk
004201140910      * 09/10/14 dlk - change to use IDTRMD (record type effective date)
0042021409100035  *                instead of IDCVDT (invoice effective date)
0042031409100035  *                for all compensation calculations.
004300071207     F*                                                                *
004400970917     F******************************************************************
004500110615     FRPA068WK  IP   F  193        DISK
004600080206     FPLNMST    IF   e           k DISK
004700080206     FACCMST    IF   e           k DISK
004800080206     FSMAN      IF   e           k DISK
0049001106010014 Fmktcara1  IF   e           k DISK
005000080911     Finvdetl2  uf   e           k DISK
005100080206     FRPA060WK  O  A e             DISK
0052000809110050 Fqsysprt   O    F  132        PRINTER OFLIND(*INOF)
005300080206     d slnameout       s                   like(slname)
005400080206     d sfnameout       s                   like(sfname)
005500080206     d smiout          s                   like(smi)
005600080206     d acnam1out       s                   like(acnam1)
005700080206     d pdescrout       s                   like(pdescr)
005800110603     d mksz            s                   like(rpmaszcd)
005900110607     D parmrel         s                   like(rprelid)
006000110607     D parmcar         s                   like(rppcar)
006100110607     D parmmksz        s                   like(rpmaszcd)
006200110607     D parmeffymd      s                   like(rpefdt)
006300110607     D parmcomamt      s                   like(rppcom)
006400110607     D parmprem        s                   like(rppprm)
006500110607     D parmmcnt        s                   like(rpmcnt)
006600110607     D parmmethod      s                   like(rpaomthd)
006700110607     D parmrate        s                   like(rpaorate)
006800110607     D parmovramt      s                   like(rpaoamt)
006900110607     D parmfound       s              1
007000970918     D                UDS
007100980929     D  RUNDAT                 1      8  0
007200980929     D  RUNMM                  1      2  0
007300980929     D  RUNDD                  3      4  0
007400980929     D  RUNYY                  5      8  0
007500080206     D  lrunseq               21     22  0
007600970917     D  CONAME               201    240
0077000809110056 D  lrunymd              400    407  0
007800110615     IRPA068WK  NS  01
007900000628     I                                  1    3 0TRST#         L6
008000970917     I                                  1    6 0TRSUB
008100080206     I                                  4    6 0SUB
008200080206     I                                  7   10 0acc
008300000628     I                                  1   10 0ACC#          L5
008400000628     I                                 11   14  PLAN#         L3
008500970917     I                                 15   23 0SSN           L1
008600140103     I                                 24   25 0depseq
008700081007     I                                 28   28  rppdfl
008800081007     I                                 29   31  SMANCD        L7
008900970917     I                                 32   36 2COMRTE
009000970917     I                                 37   39  COMTYP
009100970917     I                                 38   39  COMTY2
009200970917     I                             P   40   43 2LPREM
009300970917     I                                 44   46  PCARR
009400000628     I                                 47   61  GROUP#        L4
009500970917     I                                 62  101  CNAME
009600970917     I                                102  106 2CRPRTE
009700970917     I                                107  109  CRPTYP
009800140910     I                                110  117  idtrmd        L2
009900000706     I                                118  118 0memcnt
010000970917     I                             P  122  126 2SLSCOM
010100970917     I                             P  127  131 2CRPCOM
010200030401     I                                132  134  agcy          L8
010300030603     I                                151  158  @RELID        L7
010400090617     I                                159  177  dateseq
010500000629     C*
010600970917     C* CHAIN TO SMAN FOR SALESMAN NAME
010700970917     C*
010800000629     c                   if        *inl7
010900080206     c                   clear                   slnameout
011000080206     c                   clear                   sfnameout
011100080206     c                   clear                   smiout
011200000629     C     SMANCD        CHAIN     SMAN
011300080206     c                   if        %found(sman)
011400080206     c                   movel     slname        slnameout
011500080206     c                   movel     sfname        sfnameout
011600080206     c                   move      smi           smiout
011700080206     c                   end
011800080206
011900000629     c                   end
012000970917     C*
012100970917     C* CHAIN TO ACCMST FOR ACC NAME
012200970917     C*
012300000629     c                   if        *inl5
012400080206     c                   clear                   acnam1out
012500080206     C     ACCkey        CHAIN     ACCMST
012600080206     c                   if        %found(accmst)
012700080206     c                   movel     acnam1        acnam1out
012800080206     c                   end
012900000629     c                   end
013000970917     C*
013100970917     C* CHAIN TO PLNMST FOR PLAN DESCRIPTION
013200970917     C*
013300000629     c                   if        *inl3
013400080206     c                   clear                   pdescrout
013500080206     C     plnkey        CHAIN     PLNMST
013600080206     c                   if        %found(plnmst)
013700080206     c                   movel     pdescr        pdescrout
013800080206     c                   end
013900000629     c                   end
014000081007
014100100817      *  If this record should be paid sman commission (rppdfl = Y)
014200081007      *  accumulate member count, premium and commission then update the
014300081007      *  comm paid date.
014400081007     c                   if        rppdfl = 'Y'
014500081007
014600970917     C                   ADD       LPREM         PLNPRM            9 2
014700970917     C                   ADD       SLSCOM        PLNCOM            9 2
014800010201     C                   ADD       memcnt        MCOUNT            7 2
014900080911      *
015000081007      * update commission paid date in F.INVDET if the commission is paid
015100080911      *
015200080911     c     dateseq       chain     invdetl2
015300080911     c                   if        %found(invdetl2)
015400080911
015500080911     c                   if        idcomdt <> 0 or idpaid <> lrunymd
015600080911     c                   if        firste = ' '
015700080911     c                   except    head
015800080911     c                   move      'N'           firste            1
015900080911     c                   end
016000080911     c   of              except    head
016100080911     c                   except    error
016200080911     c                   else
016300080911     c                   eval      idcomdt = lrunymd
016400080911     c                   update    invdr
016500080911     c                   end
016600080911
016700080911      * date/seq not found - error
016800080911     c                   else
016900080911     c                   if        firste = ' '
017000080911     c                   except    head
017100080911     c                   move      'N'           firste
017200080911     c                   end
017300080911     c   of              except    head
017400080911     c                   except    error2
017500080911
017600080911     c                   end
017700080911
017800081007     c                   end
017900000629     c*
018000140910     c* idtrmd (effective date)
018100000629     c*
018200080206     Cl2NU4              exsr      #writerpa060
018300080206     Cl2                 z-add     0             mcount
018400080206     Cl2                 z-add     0             plnprm
018500080206     Cl2                 z-add     0             plncom
0186000006280107 C*
0187000802060103 C***************************************************
0188000802060104 C* write rpa060wk record                           *
0189000802060105 C***************************************************
0190000802060107 C*
0191000802060106 C     #writerpa060  BEGSR
019200080206
019300080206     c                   clear                   rpa60r
019400080206
019500080206     c                   move      COMDAT        RPCDAT
019600080206     c                   movel     SMANCD        RPSMCD
019700080206     c                   movel     SLNAMEout     RPSLNM
019800080206     c                   movel     SFNAMEout     RPSFNM
019900080206     c                   movel     SMIout        RPSMI
020000080206     c                   movel     agcy          RPCCDE
020100080206     c                   movel     trst#         RPTRST
020200080206     c                   movel     sub           RPSUB
020300080206     c                   movel     ACC           RPACC
020400080206     c                   movel     ACNAM1out     RPANM
020500080206     c                   movel     GROUP#        RPGRP
020600080206     c                   movel     PCARR         RPPCAR
020700080206     c                   movel     CNAME         RPCNAM
020800080206     c                   movel     PLAN#         RPPLAN
020900080206     c                   movel     PDESCRout     RPPDSC
021000080206     c                   move      COMRTE        RPCMRT
021100080206     c                   move      MCOUNT        RPMCNT
021200080206     c                   move      PLNPRM        rppprm
021300080206     c                   move      plncom        RPPCOM
021400080206     c                   clear                   RPNOTE
021500080206     C                   clear                   RPCHG
021600080206     C                   clear                   RPDUM
021700080206     C                   clear                   RPEDAT
021800140910     C                   move      idtrmd        RPEFDT
021900080206     C                   clear                   RPMTHD
022000080206     C                   clear                   RPPSPL
022100080206     C                   move      lrunseq       RPSEQ#
022200080206     C                   move      @RELID        RPRELID
022300080206     C                   clear                   RPCPDDT
022400110616
022500110616      * get acct / carrier market size
022600110616     c                   exsr      #getmktsz
022700110616
022800110616      * paid flag
022900081007     c                   if        rppdfl = 'Y'
023000081007     c                   move      'Y'           rppaid
023100110616      * agency override
023200110616     c                   exsr      #getao
023300081007     c                   else
023400081007     c                   move      'N'           rppaid
023500081007     c                   end
023600110607
023700080206      * write commission history rec
023800080206     c                   write     rpa60r
023900080206
0240000802060120 C                   ENDSR
024100110603
024200110603      *************************************************
024300110603      * get acct / carrier market size
024400110603      *************************************************
0245001106030120 C     #getmktsz     begsr
0246001106030456  * Get Acct Mkt size - default to 50 if not found
024700110603     c                   clear                   mksz
024800110603     c     mkcaky        setll     mktcara1
024900110603     C                   dou       %eof(mktcara1)
025000110603     c     mkcaky        reade     mktcara1
025100110603     c                   if        (not %eof(mktcara1)) and (mafrdt <> matodt)
025200140910     c                             and (mafrdt <= idtrmd) and
025300140910     c                             ((matodt >= idtrmd) or (matodt = 0))
025400110603     c                   movel     maszcd        mksz
025500110603     c                   leave
025600110603     c                   endif
025700110603     c                   enddo
0258001106030456  *
025900110603     c                   if        mksz = *blanks
026000110603     c                   movel     '50'          mksz
026100110603     c                   endif
026200110603
026300110607     C                   move      mksz          RPMASZCD
026400110607
0265001106030120 C                   ENDSR
026600110607      *************************************************
026700110607      * get agency override
026800110607      *************************************************
0269001106070120 C     #getao        begsr
0270001106070456
027100110607     c     grplist       plist
027200110607     c                   parm                    parmrel
027300110607     c                   parm                    parmcar
027400110607     c                   parm                    parmmksz
027500110607     c                   parm                    parmeffymd
027600110607     c                   parm                    parmcomamt
027700110607     c                   parm                    parmprem
027800110607     c                   parm                    parmmcnt
027900110607     c                   parm                    parmmethod
028000110607     c                   parm                    parmrate
028100110607     c                   parm                    parmovramt
028200110607     c                   parm                    parmfound
028300110607
028400110607      * set parameter values using RPA060WK fields. This is what the
028500110607      * agency override is calculated from
028600110607     c                   move      rprelid       parmrel
028700110607     c                   move      rppcar        parmcar
028800110607     c                   move      rpmaszcd      parmmksz
028900110607     c                   move      rpefdt        parmeffymd
029000110607     c                   move      rppcom        parmcomamt
029100110607     c                   move      rppprm        parmprem
029200110607     c                   move      rpmcnt        parmmcnt
029300110607     c                   clear                   parmmethod
029400110607     c                   clear                   parmrate
029500110607     c                   clear                   parmovramt
029600110607     c                   clear                   parmfound
029700110607
029800110607     c                   call      'GETAO'       grplist
029900110607
030000110607      * if a valid agency override was found then move the calculated
030100110607      * retun values to the rpa060wk fields
030200110607     c                   if        parmfound = 'Y'
030300110607     c                   move      parmmethod    RPAOMTHD
030400110607     c                   move      parmrate      RPAORATE
030500110607     c                   move      parmovramt    RPAOAMT
030600110607     c                   end
030700110607
0308001106070120 C                   ENDSR
030900080206
031000110607      *************************************************
031100110607      * first cycle
031200110607      *************************************************
0313000006290106 C     *inzsr        BEGSR
031400000629     C                   MOVEL     RUNYY         COMDAT            8 0
031500000629     C                   MOVEL     RUNMM         COMMD             4 0
031600000629     C                   MOVE      RUNDD         COMMD
031700000629     C                   MOVE      COMMD         COMDAT
031800000706     C                   TIME                    HTIME             6 0
031900080206
032000080206     c     acckey        klist
032100080206     c                   kfld                    TRST#
032200080206     c                   kfld                    SUB
032300080206     c                   kfld                    acc
032400080206     c     plnkey        klist
032500080206     c                   kfld                    TRST#
032600080206     c                   kfld                    SUB
032700080206     c                   kfld                    plan#
032800110607
032900110607     c     mkcaky        klist
033000110607     c                   kfld                    RPTRST
033100110607     c                   kfld                    RPSUB
033200110607     c                   kfld                    RPACC
033300110607     c                   kfld                    RPPCAR
033400110607
0335000802060120 C                   ENDSR
0336000809110477 Oqsysprt   e            head           2  3
0337000809110478 O                                           45 '*****'
0338000809110479 O                       CONAME              85
0339000809110480 O                                           91 '*****'
0340000809110477 O          e            head           1
0341000809110482 O                                           66 'INVOICE DETAIL UPDATE ER'
0342000809110483 O                                           90 'RORS                    '
0343000809110477 O          e            head           1
0344000809110485 O                                           25 'PROGRAM NAME: RPA060 '
0345000809110486 O                                          125 'PAGE:'
0346000809110487 O                       PAGE          Z    131
0347000809110477 O          e            head           1
0348000809110489 O                                           13 'RUN DATE:'
0349000809110490 O                       UDATE         Y     24
0350000809110491 O                                           67 'FOR PERIOD:'
035100080911     O                       rundat              78 '  /  /    '
0352000809110477 O          e            head        1  1
0353000809110494 O                                           24 '""""""""""""""""""""""""'
0354000809110495 O                                           48 '""""""""""""""""""""""""'
0355000809110496 O                                           72 '""""""""""""""""""""""""'
0356000809110497 O                                           96 '""""""""""""""""""""""""'
0357000809110498 O                                          120 '""""""""""""""""""""""""'
0358000809110499 O                                          132 '""""""""""""'
0359000809110477 O          e            head           1
0360000809110502 O                                           10 'DATE/SEQ  '
0361000809110502 O                                           45 'IDCOMDT ALREADY IN FILE '
0362000809110502 O                                           82 'IDPAID ALREADY IN FILE  '
0363000809110477 O          e            head           2
0364000809110509 O                                           24 '""""""""""""""""""""""""'
0365000809110510 O                                           48 '""""""""""""""""""""""""'
0366000809110511 O                                           72 '""""""""""""""""""""""""'
0367000809110512 O                                           96 '""""""""""""""""""""""""'
0368000809110513 O                                          120 '""""""""""""""""""""""""'
0369000809110514 O                                          132 '""""""""""""'
0370000809110515 O*
0371000809110516 O          E            error          1
0372000906170518 O                       dateseq             19
0373000809110518 O                       idcomdt             44 '    /  /  '
0374000809110518 O                       idpaid              80 '    /  /  '
0375000809110516 O          E            error2         1
0376000906170518 O                       dateseq             19
0377000809110518 O                                           44 '* DATE/SEQ NOT FOUND *'
